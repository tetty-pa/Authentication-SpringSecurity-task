package com.epam.esm.service.impl;

import com.epam.esm.dao.TagDao;
import com.epam.esm.dao.UserDao;
import com.epam.esm.entity.Tag;
import com.epam.esm.exception.DuplicateEntityException;
import com.epam.esm.exception.EntityNotFoundException;
import com.epam.esm.exception.InvalidDataException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static com.epam.esm.service.impl.util.Constants.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;


@ExtendWith(MockitoExtension.class)
class TagServiceImplTest {


    @Mock
    TagDao tagDao;

    @Mock
    UserDao userDao;

    @InjectMocks
    TagServiceImpl tagService;

    @Test
    void getAll() {
        List<Tag> tags = Arrays.asList(FIRST_TEST_TAG, SECOND_TEST_TAG, THIRD_TEST_TAG);
        when(tagDao.getAll(PAGE)).thenReturn(tags);
        List<Tag> actual = tagService.getAll(PAGE_NUM, PAGE_SIZE);

        assertEquals(tags, actual);
    }

    @Test
    void create() {
        when(tagDao.create(TAG_TO_CREATE)).thenReturn(TAG_TO_CREATE);
        Tag actual = tagService.create(TAG_TO_CREATE);
        assertEquals(TAG_TO_CREATE, actual);
    }

    @Test
    void createShouldThrowInvalidDataException() {
        when(tagDao.create(INVALID_TAG)).thenThrow(new InvalidDataException());
        assertThrows(InvalidDataException.class, () -> tagService.create(INVALID_TAG));
    }

    @Test
    void createShouldThrowDuplicateEntityException() {
        when(tagDao.getByColumn("name", FIRST_TEST_TAG.getName())).thenReturn(Optional.of(FIRST_TEST_TAG));
        assertThrows(DuplicateEntityException.class, () -> tagService.create(FIRST_TEST_TAG));
    }

    @Test
    void getById() {
        when(tagDao.getById(TEST_ID)).thenReturn(Optional.of(FIRST_TEST_TAG));
        Tag actual = tagService.getById(TEST_ID);
        assertEquals(FIRST_TEST_TAG, actual);
    }

    @Test
    void getByIdShouldThrowEntityNotFoundException() {
        when(tagDao.getById(NOT_EXIST_ID)).thenThrow(new EntityNotFoundException());
        assertThrows(EntityNotFoundException.class, () -> tagService.getById(NOT_EXIST_ID));
    }



    @Test
    void deleteByIdShouldThrowEntityNotFoundException() {
        assertThrows(EntityNotFoundException.class, () -> tagService.deleteById(NOT_EXIST_ID));
    }

    @Test
    void getMostWidelyUsedTagOfUserWithHighestCostOfAllOrders() {
        when(userDao.getById(TEST_ID)).thenReturn(Optional.of(FIRST_TEST_USER));
        when(tagDao.getMostWidelyUsedTagOfUserWithHighestCostOfAllOrders(TEST_ID)).thenReturn(Optional.of(FIRST_TEST_TAG));
        Tag actual = tagService.getMostWidelyUsedTagOfUserWithHighestCostOfAllOrders(TEST_ID);
        assertEquals(FIRST_TEST_TAG, actual);
    }
}