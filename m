Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD64B8037
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Feb 2022 06:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344596AbiBPFcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 00:32:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBPFcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 00:32:12 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89FE7B54B
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 21:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644989520; x=1676525520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwmYX1eeWslYyE2ZWz0TtBsoBANU3fW2bwAIzs4igpA=;
  b=nDN0YvuS4bb01PPP2x2Brh2kcKtviUC2ISR7agP7fVhW+1VXj2/A7q8n
   3yctSpMV44209nIISRFwPWCHkcYVstmE+UqSb3Is2bXQI0GygxqcvaQtO
   BCDy73sNgh7CKAybRpJ5pH/Wftc2OE4vGPUnRTPl9OnlZP/0/r0CFHGdx
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Feb 2022 21:31:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 21:31:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 21:31:57 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 21:31:56 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 3/3] mac80211: EHT operation element support in AP mode
Date:   Tue, 15 Feb 2022 21:31:45 -0800
Message-ID: <20220216053145.20898-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220216053145.20898-1-quic_alokad@quicinc.com>
References: <20220216053145.20898-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
 include/net/mac80211.h     |  7 +++++++
 net/mac80211/cfg.c         |  8 ++++++++
 net/mac80211/eht.c         | 11 +++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e584a3998d2c..e7e3b31a4c75 100644
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
index aa45627a4208..4227236dd5ba 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1137,6 +1137,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
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
index 00d5bd6013c2..2f1261ebe94d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2532,4 +2532,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const u8 *he_cap_ie, u8 he_cap_len,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len, struct sta_info *sta);
+void ieee80211_eht_op_ie_to_bss_conf(struct ieee80211_vif *vif,
+				     const struct ieee80211_eht_operation *eht_op);
 #endif /* IEEE80211_I_H */
-- 
2.31.1

