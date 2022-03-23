Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3D4E5B94
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbiCWW4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 18:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbiCWW4b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 18:56:31 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E509025B
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 15:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648076096; x=1679612096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MMRubxy4Ea09HKOuAvEbRBAJSSN5c8nMaNgnkBvqWNc=;
  b=hR9C9RvtA0e4NJU8d8kJ4+MRSU9PsI7WXoMFklo9FWr++4puesqRJTAa
   CsB8/PwTU3UC+PPP5du6VNghECSbJ/Isr9S4X1Iy/UNG+FzK9RQZNJOlj
   OKnTpErTN8u0ZuxnAdknQ5szV30S3JWyyGWVzBBL735j6/dXFgllleco/
   0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Mar 2022 15:54:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 15:54:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 15:54:55 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 15:54:55 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 3/3] mac80211: EHT operation element support in AP mode
Date:   Wed, 23 Mar 2022 15:54:43 -0700
Message-ID: <20220323225443.13947-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220323225443.13947-1-quic_alokad@quicinc.com>
References: <20220323225443.13947-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new parameters to struct ieee80211_bss_conf for EHT operation
element data in AP mode.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v2: Rebased on top of wireless-next git repository

 include/net/mac80211.h     |  7 +++++++
 net/mac80211/cfg.c         |  8 ++++++++
 net/mac80211/eht.c         | 11 +++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 382ebb862ea8..b3ab1f7cc2fb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -637,6 +637,8 @@ struct ieee80211_fils_discovery {
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
+ * @eht_oper: EHT operation information of the BSS (AP/Mesh) or of the AP we
+ *	are connected to (STA).
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -712,6 +714,11 @@ struct ieee80211_bss_conf {
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
 	bool eht_support;
+	struct {
+		u8 chan_width;
+		u8 ccfs;
+		u8 present_bm;
+	} eht_oper;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ba752539d1d9..01f3db0f20c6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1177,6 +1177,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (params->eht_cap && params->eht_oper) {
+		if (!sdata->vif.bss_conf.he_support)
+			return -EOPNOTSUPP;
+
+		sdata->vif.bss_conf.eht_support = true;
+		ieee80211_eht_op_ie_to_bss_conf(&sdata->vif, params->eht_oper);
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 364ad0ef7692..243dfcfaf7b2 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -74,3 +74,14 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
 	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
 }
+
+void ieee80211_eht_op_ie_to_bss_conf(struct ieee80211_vif *vif,
+				     const struct ieee80211_eht_operation *op_ie)
+{
+	if (!op_ie)
+		return;
+
+	vif->bss_conf.eht_oper.chan_width = op_ie->chan_width;
+	vif->bss_conf.eht_oper.ccfs = op_ie->ccfs;
+	vif->bss_conf.eht_oper.present_bm = op_ie->present_bm;
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d4a7ba4a8202..f6f5efa7d987 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2550,4 +2550,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const u8 *he_cap_ie, u8 he_cap_len,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len, struct sta_info *sta);
+void ieee80211_eht_op_ie_to_bss_conf(struct ieee80211_vif *vif,
+				     const struct ieee80211_eht_operation *eht_op);
 #endif /* IEEE80211_I_H */
-- 
2.31.1

