Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0565BF348
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 04:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIUCFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 22:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiIUCFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 22:05:09 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98760681
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 19:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663725903; x=1695261903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=niNE7USxHEgctKqu9Af7e4066Df+kVr9Z0eABgej3/Q=;
  b=T7bvlD1qbtgUXZWWbzAog1V/09AbegYPr1Ob6ShjHL2QezJ2PH9MaJ15
   4s9KhmmL0M4DRvn7FlAEBb8pOuW/h79ioFZWTLi0C94MsEr6QigBmUHFt
   9xPppf5p+xuq5iBvPPGwDWtMPLtWwSfE+/ncJkGyXNQ5INQecDYxqzJqx
   U=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="318191346"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="318191346"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 04:05:00 +0200
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 04:05:00 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 04:05:00 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Wed, 21 Sep 2022 04:04:59 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="258960040"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="258960040"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 21 Sep 2022 04:04:59 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Sep 2022
 21:04:57 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 75F28100556;
        Tue, 20 Sep 2022 21:02:14 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 72B0E9806AB; Tue, 20 Sep 2022 21:02:14 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 2/4] brcmfmac: fix firmware trap while dumping obss stats
Date:   Tue, 20 Sep 2022 21:00:58 -0500
Message-ID: <20220921020100.16752-3-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220921020100.16752-1-ian.lin@infineon.com>
References: <20220921020100.16752-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 49 ++++++++-----------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 415b3300af48..cfe2f0e778f7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7655,16 +7655,15 @@ brcmf_dump_obss(struct brcmf_if *ifp, struct cca_msrmnt_query req,
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
@@ -7672,11 +7671,9 @@ brcmf_dump_obss(struct brcmf_if *ifp, struct cca_msrmnt_query req,
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
@@ -7713,7 +7710,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	struct ieee80211_supported_band *band;
 	struct ieee80211_channel *chan;
 	struct cca_msrmnt_query req;
-	u32 val, noise;
+	u32 noise;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
@@ -7739,31 +7736,27 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
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
+	survey = kzalloc(sizeof(*survey), GFP_KERNEL);
+	if (!survey)
+		return -ENOMEM;
+
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
 
-	survey = kzalloc(sizeof(*survey), GFP_KERNEL);
-	if (unlikely(!survey)) {
-		brcmf_err("%s: alloc failed\n", __func__);
-		return -ENOMEM;
-	}
 
 	/* Start Measurement for obss stats on current channel */
 	req.msrmnt_query = 0;
@@ -7778,7 +7771,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	/* Issue IOVAR to collect measurement results */
 	req.msrmnt_query = 1;
 	err = brcmf_dump_obss(ifp, req, survey);
-	if (err < 0)
+	if (err)
 		goto exit;
 
 	info->channel = chan;
@@ -7798,9 +7791,9 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	brcmf_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
 		  info->noise, info->time_busy, info->time_rx, info->time_tx);
 
-	kfree(survey);
-	return 0;
 exit:
+	if (!brcmf_is_apmode(ifp->vif))
+		brcmf_set_mpc(ifp, 1);
 	kfree(survey);
 	return err;
 }
-- 
2.25.0

