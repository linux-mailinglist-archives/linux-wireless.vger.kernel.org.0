Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD474E7174
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 11:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiCYKot (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 06:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiCYKoq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 06:44:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E9F32
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 03:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F8BBB827F9
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 10:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF43C340E9;
        Fri, 25 Mar 2022 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648204986;
        bh=vcdEzAqlYBWnO+/Hu2D410+GeEqk3kVc05tMIgLuYFU=;
        h=From:To:Cc:Subject:Date:From;
        b=X5kiz2x+x4sGLZ6henAV2cxmIx2jri/Qv99xM8d3obKVpuXymWj8Bmtln4Rlcg3zs
         PAGX/h2SoA7rFjEoQXHlF/5eyM5wgYreXTb5r0t7F32PGUnFpYrE9A4rrQTQiE8kHz
         sAdE3GLQUFCd6H9IUomjyYnXW0uRJpBON/V7+5XlSUUj0GZAxoe7tnQK54tReoxOSz
         t4tj8XnyHxyW9DGY2SrOT3koPdRSQ+dydNwN714DVCaEv0IihxhF9z3m01jUmewmU7
         6dNmPjTKzNCJzsCam/YOESMcdAQUG9vWrjA4TmeByDCyz3blyJZw0xXhBqpHCr+5Vv
         fSxIHcbt225VQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, chui-hao.chiu@mediatek.com, j@w1.fi
Subject: [PATCH v2 wireless-next] mac80211: introduce BSS color collision detection
Date:   Fri, 25 Mar 2022 11:42:41 +0100
Message-Id: <a05eeeb1841a84560dc5aaec77894fcb69a54f27.1648204871.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add ieee80211_rx_check_bss_color_collision routine in order to introduce
BSS color collision detection in mac80211 if it is not supported in HW/FW
(e.g. for mt7915 chipset).
Add NL80211_EXT_FEATURE_HW_COLOR_COLLISION flag to let the driver notify
BSS color collision detection is supported in HW/FW.

Tested-by: Peter Chiu <Chui-Hao.Chiu@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- use BIT_ULL instead of BIT for color bitmap
---
 drivers/net/wireless/ath/ath11k/mac.c |  6 +++-
 include/uapi/linux/nl80211.h          |  4 +++
 net/mac80211/rx.c                     | 47 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d5b83f90d27a..12af2b073574 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8483,9 +8483,13 @@ static int __ath11k_mac_register(struct ath11k *ar)
 
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
-	if (test_bit(WMI_TLV_SERVICE_BSS_COLOR_OFFLOAD, ar->ab->wmi_ab.svc_map))
+	if (test_bit(WMI_TLV_SERVICE_BSS_COLOR_OFFLOAD,
+		     ar->ab->wmi_ab.svc_map)) {
 		wiphy_ext_feature_set(ar->hw->wiphy,
 				      NL80211_EXT_FEATURE_BSS_COLOR);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_HW_COLOR_COLLISION);
+	}
 
 	ar->hw->wiphy->cipher_suites = cipher_suites;
 	ar->hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0568a79097b8..c54dca41ff89 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6172,6 +6172,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_RADAR_BACKGROUND: Device supports background radar/CAC
  *	detection.
  *
+ * @NL80211_EXT_FEATURE_HW_COLOR_COLLISION: The driver supports BSS color
+ *	collision detection in hw/fw.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6239,6 +6242,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
+	NL80211_EXT_FEATURE_HW_COLOR_COLLISION,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index beb6b92eb780..07c76f7271c2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3178,6 +3178,50 @@ static void ieee80211_process_sa_query_req(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tx_skb(sdata, skb);
 }
 
+static void
+ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
+{
+	struct ieee80211_mgmt *mgmt = (void *)rx->skb->data;
+	const struct element *ie;
+	size_t baselen;
+
+	if (!wiphy_ext_feature_isset(rx->local->hw.wiphy,
+				     NL80211_EXT_FEATURE_BSS_COLOR))
+		return;
+
+	if (wiphy_ext_feature_isset(rx->local->hw.wiphy,
+				    NL80211_EXT_FEATURE_HW_COLOR_COLLISION))
+		return;
+
+	if (rx->sdata->vif.csa_active)
+		return;
+
+	baselen = mgmt->u.beacon.variable - rx->skb->data;
+	if (baselen > rx->skb->len)
+		return;
+
+	ie = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION,
+				    mgmt->u.beacon.variable,
+				    rx->skb->len - baselen);
+	if (ie && ie->datalen >= sizeof(struct ieee80211_he_operation) &&
+	    ie->datalen >= ieee80211_he_oper_size(ie->data + 1)) {
+		struct ieee80211_bss_conf *bss_conf = &rx->sdata->vif.bss_conf;
+		const struct ieee80211_he_operation *he_oper;
+		u8 color;
+
+		he_oper = (void *)(ie->data + 1);
+		if (le32_get_bits(he_oper->he_oper_params,
+				  IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED))
+			return;
+
+		color = le32_get_bits(he_oper->he_oper_params,
+				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
+		if (color == bss_conf->he_bss_color.color)
+			ieeee80211_obss_color_collision_notify(&rx->sdata->vif,
+							       BIT_ULL(color));
+	}
+}
+
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 {
@@ -3203,6 +3247,9 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	    !(rx->flags & IEEE80211_RX_BEACON_REPORTED)) {
 		int sig = 0;
 
+		/* sw bss color collision detection */
+		ieee80211_rx_check_bss_color_collision(rx);
+
 		if (ieee80211_hw_check(&rx->local->hw, SIGNAL_DBM) &&
 		    !(status->flag & RX_FLAG_NO_SIGNAL_VAL))
 			sig = status->signal;
-- 
2.35.1

