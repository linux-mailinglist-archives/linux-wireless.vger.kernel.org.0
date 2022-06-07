Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B29540B04
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 20:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349973AbiFGSYt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 14:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351127AbiFGSXm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 14:23:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67176CFE0D
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654624465; x=1686160465;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=UxrsoFy28TLLP+uzfCgZqXwjVtC04/DrwHCBvJprHJQ=;
  b=xYlv59tKJIe5pOSGXyH02OSSDsigzBFoNjNxnFP1b5B6kQLlTK4wZn4O
   2E1zkJiEefe6m+hU3zo1QhH68izELDrDOjxIZzqenKOTnfZzrRG4a2sus
   ZkvxGi8rMZ8xss73MvZ18nr1A8ZWD5Hv9WF/xHRFay/4TuEd29kkuDroV
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jun 2022 10:54:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 10:54:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 10:54:06 -0700
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 10:54:06 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH] mac80211: Add HE MU-MIMO related flags in ieee80211_bss_conf
Date:   Tue, 7 Jun 2022 10:54:00 -0700
Message-ID: <1654624440-30386-1-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
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

Adding flags for SU Beamformer, SU Beamformee, MU Beamformer and Full
Bandwidth UL MU-MIMO for HE. This is utilized to pass MU-MIMO
configurations from user space to driver.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/mac80211.h | 10 ++++++++++
 net/mac80211/cfg.c     | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ebadb2103968..5c8d99e6bb1e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -636,6 +636,12 @@ struct ieee80211_fils_discovery {
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
+ * @he_su_beamformer: does this BSS support operation as an HE SU beamformer
+ * @he_su_beamformee: does this BSS support operation as an HE SU beamformee
+ * @he_mu_beamformer: does this BSS support operation as an HE MU beamformer
+ * @he_full_ul_mumimo: does this BSS support the reception (AP) or transmission
+ *	(non-AP STA) of an HE TB PPDU on an RU that spans the entire PPDU
+ *	bandwidth
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -711,6 +717,10 @@ struct ieee80211_bss_conf {
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
 	bool eht_support;
+	bool he_su_beamformer;
+	bool he_su_beamformee;
+	bool he_mu_beamformer;
+	bool he_full_ul_mumimo;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7896f257e1b..900046825981 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1178,6 +1178,21 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (params->he_cap) {
+		sdata->vif.bss_conf.he_su_beamformer =
+					!!(params->he_cap->phy_cap_info[3] &
+					   IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER);
+		sdata->vif.bss_conf.he_su_beamformee =
+					!!(params->he_cap->phy_cap_info[4] &
+					   IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE);
+		sdata->vif.bss_conf.he_mu_beamformer =
+					!!(params->he_cap->phy_cap_info[4] &
+					   IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER);
+		sdata->vif.bss_conf.he_full_ul_mumimo =
+				   !!(params->he_cap->phy_cap_info[2] &
+				      IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO);
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
-- 
2.7.4

