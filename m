Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF344E6DFA
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358376AbiCYGBt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiCYGBs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:01:48 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02295C681C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648188015; x=1679724015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=beTOa7QdjKZ5Ywt9VErYX4lAZHPF7tifsDmxNSyC5OA=;
  b=LMrnY4OIs3SGt3lQAMGzULp+YJrEjuBr2uohEVKzGrbNdc9lZ9MdccZN
   ZjFSJKgNx/e05uTDEkaOMhgOLgtWJedW3B1JQ0UJx3cCPbAeps0d/YUyX
   /JZG3UpAH9ey9Xut3/Vwep6cDq+t/O5jI8gka89yc/+v3j8cSawiGQjy0
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Mar 2022 23:00:14 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 23:00:14 -0700
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 23:00:13 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
CC:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH v6 2/3] mac80211: Add support for beacon tx mode
Date:   Fri, 25 Mar 2022 11:29:48 +0530
Message-ID: <20220325055949.3035053-3-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325055949.3035053-1-quic_mkenna@quicinc.com>
References: <20220325055949.3035053-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pass the beacon tx mode value from the nl80211/cfg80211
layer to the driver via ieee80211_ops and driver ops.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00480-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/cfg.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 382ebb862ea8..de6bce88f4fb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -637,6 +637,7 @@ struct ieee80211_fils_discovery {
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
+ * @beacon_tx_mode: Beacon Tx Mode setting.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -712,6 +713,7 @@ struct ieee80211_bss_conf {
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
 	bool eht_support;
+	enum nl80211_beacon_tx_mode beacon_tx_mode;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ba752539d1d9..522bf71db850 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1162,6 +1162,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	prev_beacon_int = sdata->vif.bss_conf.beacon_int;
 	sdata->vif.bss_conf.beacon_int = params->beacon_interval;
+	sdata->vif.bss_conf.beacon_tx_mode = params->beacon_tx_mode;
 
 	if (params->he_cap && params->he_oper) {
 		sdata->vif.bss_conf.he_support = true;
@@ -2237,6 +2238,7 @@ static int copy_mesh_setup(struct ieee80211_if_mesh *ifmsh,
 
 	sdata->vif.bss_conf.beacon_int = setup->beacon_interval;
 	sdata->vif.bss_conf.dtim_period = setup->dtim_period;
+	sdata->vif.bss_conf.beacon_tx_mode = setup->beacon_tx_mode;
 
 	sdata->beacon_rate_set = false;
 	if (wiphy_ext_feature_isset(sdata->local->hw.wiphy,
-- 
2.25.1

