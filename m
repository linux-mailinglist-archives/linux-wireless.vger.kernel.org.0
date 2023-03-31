Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A746D2355
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjCaO7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjCaO7W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 10:59:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC0D502
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IFrv5C0qFn2Z0SMMAODEMyAJWUwsb9nJLoPW6DUyBAE=;
        t=1680274755; x=1681484355; b=a8ojdFImUi3HumVZ/ZA2U/I/jX7Km5AN26m6GMLc9u+9qcR
        MvlpcIqHOdDFjGvWCqTiXC5dAjReekxCuFmGGW88SxubDJHOb8Xxv7Eb7GVKSLot1T4JK63w/OrvU
        DK6A4PzcQ22K1rc/lNBDeHjjU/6VG4uZ5we2hR4wEcEIy7B/ztO8CGE4WT0eG0hUdYdUUu3wb8kO2
        VDQuAnjxOxwLpqauEWCCxcHxwOyag+RUe7iSCWsy2KWLUHVfYISGPUTx2wbtASaEJlg16LnB8FlYz
        3jKLJ+AoYwNMMqq2jaeeRgxTmYR2A72PtL3AV3ZkgnSHWaw7lTTPCEbwJvMXa5vQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1piGDf-002ICn-2h;
        Fri, 31 Mar 2023 16:59:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 2/2] wifi: ieee80211: correctly mark FTM frames non-bufferable
Date:   Fri, 31 Mar 2023 16:59:08 +0200
Message-Id: <20230331160543.0baaf350311f.I905770131aed93344f425d80eb7d9d80fde486c9@changeid>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331160543.a831d2a29cbb.I75620751b3752528d0e06526b2e2a5fe2d731070@changeid>
References: <20230331160543.a831d2a29cbb.I75620751b3752528d0e06526b2e2a5fe2d731070@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The checks of whether or not a frame is bufferable were not
taking into account that some action frames aren't, such as
FTM. Check this, which requires some changes to the function
ieee80211_is_bufferable_mmpdu() since we need the whole skb
for the checks now.

Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c |  7 +--
 drivers/net/wireless/mediatek/mt76/tx.c     |  2 +-
 include/linux/ieee80211.h                   | 52 +++++++++++++++------
 net/mac80211/tx.c                           |  4 +-
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 2c842938656d..ae767c3227dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -606,8 +606,9 @@ static void iwl_mvm_skb_prepare_status(struct sk_buff *skb,
 static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
 				      struct iwl_mvm_vif_link_info *link,
 				      struct ieee80211_tx_info *info,
-				      struct ieee80211_hdr *hdr)
+				      struct sk_buff *skb)
 {
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 fc = hdr->frame_control;
 
 	switch (info->control.vif->type) {
@@ -624,7 +625,7 @@ static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
 		 * reason 7 ("Class 3 frame received from nonassociated STA").
 		 */
 		if (ieee80211_is_mgmt(fc) &&
-		    (!ieee80211_is_bufferable_mmpdu(fc) ||
+		    (!ieee80211_is_bufferable_mmpdu(skb) ||
 		     ieee80211_is_deauth(fc) || ieee80211_is_disassoc(fc)))
 			return link->mgmt_queue;
 
@@ -757,7 +758,7 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 				sta_id = link->mcast_sta.sta_id;
 
 			queue = iwl_mvm_get_ctrl_vif_queue(mvm, link, &info,
-							   hdr);
+							   skb);
 		} else if (info.control.vif->type == NL80211_IFTYPE_MONITOR) {
 			queue = mvm->snif_queue;
 			sta_id = mvm->snif_sta.sta_id;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1f309d05380a..3ad9742364ba 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -330,7 +330,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	if ((dev->drv->drv_flags & MT_DRV_HW_MGMT_TXQ) &&
 	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 	    !ieee80211_is_data(hdr->frame_control) &&
-	    !ieee80211_is_bufferable_mmpdu(hdr->frame_control)) {
+	    !ieee80211_is_bufferable_mmpdu(skb)) {
 		qid = MT_TXQ_PSD;
 	}
 
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 0583b2b0ce1f..c4cf296e7eaf 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -782,20 +782,6 @@ static inline bool ieee80211_is_any_nullfunc(__le16 fc)
 	return (ieee80211_is_nullfunc(fc) || ieee80211_is_qos_nullfunc(fc));
 }
 
-/**
- * ieee80211_is_bufferable_mmpdu - check if frame is bufferable MMPDU
- * @fc: frame control field in little-endian byteorder
- */
-static inline bool ieee80211_is_bufferable_mmpdu(__le16 fc)
-{
-	/* IEEE 802.11-2012, definition of "bufferable management frame";
-	 * note that this ignores the IBSS special case. */
-	return ieee80211_is_mgmt(fc) &&
-	       (ieee80211_is_action(fc) ||
-		ieee80211_is_disassoc(fc) ||
-		ieee80211_is_deauth(fc));
-}
-
 /**
  * ieee80211_is_first_frag - check if IEEE80211_SCTL_FRAG is not set
  * @seq_ctrl: frame sequence control bytes in little-endian byteorder
@@ -4132,6 +4118,44 @@ static inline u8 *ieee80211_get_DA(struct ieee80211_hdr *hdr)
 		return hdr->addr1;
 }
 
+/**
+ * ieee80211_is_bufferable_mmpdu - check if frame is bufferable MMPDU
+ * @skb: the skb to check, starting with the 802.11 header
+ */
+static inline bool ieee80211_is_bufferable_mmpdu(struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	__le16 fc = mgmt->frame_control;
+
+	/*
+	 * IEEE 802.11 REVme D2.0 definition of bufferable MMPDU;
+	 * note that this ignores the IBSS special case.
+	 */
+	if (!ieee80211_is_mgmt(fc))
+		return false;
+
+	if (ieee80211_is_disassoc(fc) || ieee80211_is_deauth(fc))
+		return true;
+
+	if (!ieee80211_is_action(fc))
+		return false;
+
+	if (skb->len < offsetofend(typeof(*mgmt), u.action.u.ftm.action_code))
+		return true;
+
+	/* action frame - additionally check for non-bufferable FTM */
+
+	if (mgmt->u.action.category != WLAN_CATEGORY_PUBLIC &&
+	    mgmt->u.action.category != WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
+		return true;
+
+	if (mgmt->u.action.u.ftm.action_code == WLAN_PUB_ACTION_FTM_REQUEST ||
+	    mgmt->u.action.u.ftm.action_code == WLAN_PUB_ACTION_FTM_RESPONSE)
+		return false;
+
+	return true;
+}
+
 /**
  * _ieee80211_is_robust_mgmt_frame - check if frame is a robust management frame
  * @hdr: the frame (buffer must include at least the first octet of payload)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index dfe6b9c9b29e..1a3327407552 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -488,7 +488,7 @@ ieee80211_tx_h_unicast_ps_buf(struct ieee80211_tx_data *tx)
 		int ac = skb_get_queue_mapping(tx->skb);
 
 		if (ieee80211_is_mgmt(hdr->frame_control) &&
-		    !ieee80211_is_bufferable_mmpdu(hdr->frame_control)) {
+		    !ieee80211_is_bufferable_mmpdu(tx->skb)) {
 			info->flags |= IEEE80211_TX_CTL_NO_PS_BUFFER;
 			return TX_CONTINUE;
 		}
@@ -1323,7 +1323,7 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
 	    unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
 		if ((!ieee80211_is_mgmt(hdr->frame_control) ||
-		     ieee80211_is_bufferable_mmpdu(hdr->frame_control) ||
+		     ieee80211_is_bufferable_mmpdu(skb) ||
 		     vif->type == NL80211_IFTYPE_STATION) &&
 		    sta && sta->uploaded) {
 			/*
-- 
2.39.2

