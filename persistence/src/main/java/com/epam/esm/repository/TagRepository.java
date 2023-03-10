package com.epam.esm.repository;

import com.epam.esm.model.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;


public interface TagRepository extends JpaRepository<Tag, Long> {
    String MOST_WIDELY_USED_WITH_HIGHEST_ORDER_COST_TAG_QUERY = " SELECT * FROM tags" +
            "JOIN gift_certificate_has_tag gcht on tags.id = gcht.tag_id " +
            "JOIN orders o on gcht.gift_certificate_id = o.gift_certificate_id " +
            "WHERE o.user_id = ? " +
            "GROUP BY  tag_id " +
            "ORDER BY COUNT(gcht.tag_id) DESC , SUM(o.cost) DESC LIMIT 1";

    /**
     * Gets Tag by column name.
     *
     * @param name Tag column name to get
     * @return Optional<Tag> tag if founded or Empty if not
     */
    Optional<Tag> findByName(String name);

    /**
     * Gets Most Widely Used Tag Of User With Highest Cost Of All Orders Tag .
     *
     * @param userId User id to get
     * @return Optional<Tag>
     */
   @Query(value = MOST_WIDELY_USED_WITH_HIGHEST_ORDER_COST_TAG_QUERY, nativeQuery = true)
    Optional<Tag> getMostWidelyUsedTagOfUserWithHighestCostOfAllOrders(long userId);

}
