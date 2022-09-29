Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D375EEADF
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 03:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiI2BZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 21:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI2BZj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 21:25:39 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C477026102
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 18:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664414738; x=1695950738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1AoarjU6KoBxYR2ZolxNpEemZ2yH8Oa3nmqFwsJxT4M=;
  b=koVy6PqzZLrYGTYsBeCTl+GLk4oLti2kpFUShVl36xItBqQTNbNNta77
   3KH8p4sMkfblznyYlvJLTqESL8eH98Ib3KBc4NOMWcJ7h+pG8mMZnAvhY
   NxQgb3aMSRFfZPkPpc9mSq4QzF6Rr4anxH8DwJyhfBqA3HRSK4Km8ZDDC
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="2355170"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="2355170"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 03:25:36 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 03:25:35 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 03:25:35 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 03:25:35 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264114141"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="264114141"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 03:25:35 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 20:25:33 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 452291004E0;
        Wed, 28 Sep 2022 20:25:33 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 42B93980853; Wed, 28 Sep 2022 20:25:33 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v3 2/4] brcmfmac: fix firmware trap while dumping obss stats
Date:   Wed, 28 Sep 2022 20:25:25 -0500
Message-ID: <20220929012527.4152-3-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929012527.4152-1-ian.lin@infineon.com>
References: <20220929012527.4152-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

When doing dump_survey, host will call "dump_obss" iovar to firmware
side. Host need to make sure the HW clock in dongle is on, or there is
high probability that firmware gets trap because register or shared
memory access failed. To fix this, we disable mpc when doing dump obss
and set it back after that.

[28350.512799] brcmfmac: brcmf_dump_obss: dump_obss error (-52)
[28743.402314] ieee80211 phy0: brcmf_fw_crashed: Firmware has halted or
crashed
[28745.869430] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
[28745.877546] brcmfmac: brcmf_sdio_checkdied: firmware trap in dongle

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 38 +++++++++----------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index bb3380c057d8..db39e730096a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7635,16 +7635,15 @@ brcmf_dump_obss(struct brcmf_if *ifp, struct cca_msrmnt_query req,
 	int err;
 
 	buf = kzalloc(sizeof(char) * BRCMF_DCMD_MEDLEN, GFP_KERNEL);
-	if (unlikely(!buf)) {
-		brcmf_err("%s: buf alloc failed\n", __func__);
+	if (!buf)
 		return -ENOMEM;
-	}
 
 	memcpy(buf, &req, sizeof(struct cca_msrmnt_query));
 	err = brcmf_fil_iovar_data_get(ifp, "dump_obss",
 				       buf, BRCMF_DCMD_MEDLEN);
-	if (err < 0) {
+	if (err) {
 		brcmf_err("dump_obss error (%d)\n", err);
+		err = -EINVAL;
 		goto exit;
 	}
 	results = (struct cca_stats_n_flags *)(buf);
@@ -7652,11 +7651,9 @@ brcmf_dump_obss(struct brcmf_if *ifp, struct cca_msrmnt_query req,
 	if (req.msrmnt_query)
 		brcmf_parse_dump_obss(results->buf, survey);
 
-	kfree(buf);
-	return 0;
 exit:
 	kfree(buf);
-	return -EINVAL;
+	return err;
 }
 
 static s32
@@ -7695,7 +7692,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	struct ieee80211_supported_band *band;
 	struct ieee80211_channel *chan;
 	struct cca_msrmnt_query req;
-	u32 val, noise;
+	u32 noise;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
@@ -7721,23 +7718,20 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 		return 0;
 	}
 
-	if (!idx) {
-		/* Disable mpc */
-		val = 0;
-		brcmf_set_mpc(ifp, val);
-		/* Set interface up, explicitly. */
-		val = 1;
-		err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_UP, val);
-		if (err) {
-			brcmf_err("BRCMF_C_UP error (%d)\n", err);
-			return -EIO;
-		}
+	/* Disable mpc */
+	brcmf_set_mpc(ifp, 0);
+
+	/* Set interface up, explicitly. */
+	err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_UP, 1);
+	if (err) {
+		brcmf_err("set interface up failed, err = %d\n", err);
+		goto exit;
 	}
 
 	/* Get noise value */
 	err = brcmf_fil_cmd_int_get(ifp, BRCMF_C_GET_PHY_NOISE, &noise);
 	if (err) {
-		brcmf_err("Get Phy Noise failed, error = %d\n", err);
+		brcmf_err("Get Phy Noise failed, use dummy value\n");
 		noise = CHAN_NOISE_DUMMY;
 	}
 
@@ -7754,7 +7748,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	/* Issue IOVAR to collect measurement results */
 	req.msrmnt_query = 1;
 	err = brcmf_dump_obss(ifp, req, &survey);
-	if (err < 0)
+	if (err)
 		goto exit;
 
 	info->channel = chan;
@@ -7775,6 +7769,8 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 		  info->noise, info->time_busy, info->time_rx, info->time_tx);
 
 exit:
+	if (!brcmf_is_apmode(ifp->vif))
+		brcmf_set_mpc(ifp, 1);
 	return err;
 }
 
-- 
2.25.0

