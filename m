Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D134DE82A
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Mar 2022 14:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiCSN3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Mar 2022 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiCSN3g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Mar 2022 09:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BBE89098
        for <linux-wireless@vger.kernel.org>; Sat, 19 Mar 2022 06:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F3360DBA
        for <linux-wireless@vger.kernel.org>; Sat, 19 Mar 2022 13:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DFBC340EC;
        Sat, 19 Mar 2022 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647696494;
        bh=ud9GOAdlSs+htcqHe4z2OVXxgJ2BvkEh9kSf1b+GEdI=;
        h=From:To:Cc:Subject:Date:From;
        b=k0Y6E9cVRk6yIJ1z4kaGi8pEEtdWRQAHYG0JeKDYjw2tvPI2MZb85UnRNabrrdEk0
         ICH/7A4PaV383iOXbNiQ643c16DcFMJtYgHmyKG91uFYiFdqdrl+UwUAIuOmIYc1Pd
         ebCi7GEYa6mWlIdpmCEzkFUGmPeI3g2MsvfwiFlHFNSG0kdVWIgk9nOONrNWtgcxr0
         0SlstiVH5pXu/UtnxhPCxET8dv6APmrnKjRGFo9tt7gt0CjTP+yFuAudy7xP8ZquOT
         le/eQlyar3n3Rzw93ffwkapbYeA/+7oaSgemVLnEARm6hypskIaG4SnQJOZB3wGuw/
         lv9qQfWMSp4Mg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        dan.carpenter@oracle.com
Subject: [PATCH] mt76: mt7915: fix unbounded shift in mt7915_mcu_beacon_mbss
Date:   Sat, 19 Mar 2022 14:28:01 +0100
Message-Id: <b48f89bf73860cc9149f99986ea528db9ab35b7f.1647696425.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following smatch static checker warning:
	drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1872 mt7915_mcu_beacon_mbss()
	error: undefined (user controlled) shift '(((1))) << (data[2])'

Rely on mac80211 definitions for ieee80211_bssid_index subelement.

Fixes: 6b7f9aff7c67 ("mt76: mt7915: introduce 802.11ax multi-bss support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e7a6f80e7755..736c9c342baa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1854,7 +1854,8 @@ mt7915_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
 			continue;
 
 		for_each_element(sub_elem, elem->data + 1, elem->datalen - 1) {
-			const u8 *data;
+			const struct ieee80211_bssid_index *idx;
+			const u8 *idx_ie;
 
 			if (sub_elem->id || sub_elem->datalen < 4)
 				continue; /* not a valid BSS profile */
@@ -1862,14 +1863,19 @@ mt7915_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
 			/* Find WLAN_EID_MULTI_BSSID_IDX
 			 * in the merged nontransmitted profile
 			 */
-			data = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX,
-						sub_elem->data,
-						sub_elem->datalen);
-			if (!data || data[1] < 1 || !data[2])
+			idx_ie = cfg80211_find_ie(WLAN_EID_MULTI_BSSID_IDX,
+						  sub_elem->data,
+						  sub_elem->datalen);
+			if (!idx_ie || idx_ie[1] < sizeof(*idx))
 				continue;
 
-			mbss->offset[data[2]] = cpu_to_le16(data - skb->data);
-			mbss->bitmap |= cpu_to_le32(BIT(data[2]));
+			idx = (void *)(idx_ie + 2);
+			if (!idx->bssid_index || idx->bssid_index > 31)
+				continue;
+
+			mbss->offset[idx->bssid_index] =
+				cpu_to_le16(idx_ie - skb->data);
+			mbss->bitmap |= cpu_to_le32(BIT(idx->bssid_index));
 		}
 	}
 }
-- 
2.35.1

