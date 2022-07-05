Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905355679DE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jul 2022 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiGEWDR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jul 2022 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiGEWDQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jul 2022 18:03:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06A19286
        for <linux-wireless@vger.kernel.org>; Tue,  5 Jul 2022 15:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657058595; x=1688594595;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+IhKpC2aYM8AXeVzSJaIMiJe17jT6ZmldsrR1GUt2Oc=;
  b=f8T9WDxPNZdOIFxE/tuxVlrc2Pe/FCK7eQbAoqPJzqp69my+M5a7B8ek
   T/AXhfcA9/V0doGc8fbSNneEDXvDpyZ2AojCHVbPVEKLS95tVC95PDl/b
   v9dt6P2E7mvDtmEsou3TCM1Eeml2s+luAnPUSg1yLek8F2m1bMbke9G0H
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 15:03:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:03:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 15:03:14 -0700
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 15:03:13 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v2 1/2] mac80211: Add VHT MU-MIMO related flags in ieee80211_bss_conf
Date:   Tue, 5 Jul 2022 15:03:05 -0700
Message-ID: <1657058586-4621-1-git-send-email-quic_msinada@quicinc.com>
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

Adding flags for SU Beamformer, SU Beamformee, MU Beamformer and
MU Beamformee for VHT. This is utilized to pass MU-MIMO
configurations from user space to driver.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/mac80211.h |  8 ++++++++
 net/mac80211/cfg.c     | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ebadb2103968..ef4133091d41 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -636,6 +636,10 @@ struct ieee80211_fils_discovery {
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
+ * @vht_su_beamformer: does this BSS support operation as an VHT SU beamformer
+ * @vht_su_beamformee: does this BSS support operation as an VHT SU beamformee
+ * @vht_mu_beamformer: does this BSS support operation as an VHT MU beamformer
+ * @vht_mu_beamformee: does this BSS support operation as an VHT MU beamformee
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -711,6 +715,10 @@ struct ieee80211_bss_conf {
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
 	bool eht_support;
+	bool vht_su_beamformer;
+	bool vht_su_beamformee;
+	bool vht_mu_beamformer;
+	bool vht_mu_beamformee;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7896f257e1b..76418bb360fa 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1164,6 +1164,21 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	prev_beacon_int = sdata->vif.bss_conf.beacon_int;
 	sdata->vif.bss_conf.beacon_int = params->beacon_interval;
 
+	if (params->vht_cap) {
+		sdata->vif.bss_conf.vht_su_beamformer =
+		       !!(ap_vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
+		sdata->vif.bss_conf.vht_su_beamformee =
+		       !!(ap_vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
+		sdata->vif.bss_conf.vht_mu_beamformer =
+		       !!(ap_vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE));
+		sdata->vif.bss_conf.vht_mu_beamformee =
+		       !!(ap_vht_cap->vht_cap_info &
+			  cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE));
+	}
+
 	if (params->he_cap && params->he_oper) {
 		sdata->vif.bss_conf.he_support = true;
 		sdata->vif.bss_conf.htc_trig_based_pkt_ext =
-- 
2.7.4

