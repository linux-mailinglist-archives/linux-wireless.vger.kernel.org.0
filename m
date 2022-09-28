Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15CF5ED8C6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiI1JWi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiI1JWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 05:22:36 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB7A74EA
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664356956; x=1695892956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=veTjMlhdWz5IYDgzEoYIBh4WwCoTIdfo792k2aA8IXw=;
  b=iwH8eD8DP9lsfieQhPkCt6wJB1sN8+SX6SBUF3pStu97qdZdXapXc8a/
   nSMlFvxA2j5HEOjmGghWkfR8BLjcFBtB86wtsV2BH1z6Y0UuGLm63IKa9
   xh4dIbclu4TeqhyVHMyd0oRHo0WzpH1yzDb+1kwcedTYOSlF0JYzIXQqG
   Q=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="319323011"
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="319323011"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 11:22:35 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 11:22:35 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 11:22:34 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Wed, 28 Sep 2022 11:22:33 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="261078442"
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="261078442"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 28 Sep 2022 11:22:33 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 04:22:32 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 006471004E0;
        Wed, 28 Sep 2022 04:22:32 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 E4DFB9807EB; Wed, 28 Sep 2022 04:22:31 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 2/4] brcmfmac: fix firmware trap while dumping obss stats
Date:   Wed, 28 Sep 2022 04:22:21 -0500
Message-ID: <20220928092223.22673-3-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220928092223.22673-1-ian.lin@infineon.com>
References: <20220928092223.22673-1-ian.lin@infineon.com>
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
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 38 +++++++++----------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index f16dad462eb2..9f2f2a990f20 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7659,16 +7659,15 @@ brcmf_dump_obss(struct brcmf_if *ifp, struct cca_msrmnt_query req,
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
@@ -7676,11 +7675,9 @@ brcmf_dump_obss(struct brcmf_if *ifp, struct cca_msrmnt_query req,
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
@@ -7719,7 +7716,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	struct ieee80211_supported_band *band;
 	struct ieee80211_channel *chan;
 	struct cca_msrmnt_query req;
-	u32 val, noise;
+	u32 noise;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
@@ -7745,23 +7742,20 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
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
 
@@ -7778,7 +7772,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	/* Issue IOVAR to collect measurement results */
 	req.msrmnt_query = 1;
 	err = brcmf_dump_obss(ifp, req, &survey);
-	if (err < 0)
+	if (err)
 		goto exit;
 
 	info->channel = chan;
@@ -7799,6 +7793,8 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 		  info->noise, info->time_busy, info->time_rx, info->time_tx);
 
 exit:
+	if (!brcmf_is_apmode(ifp->vif))
+		brcmf_set_mpc(ifp, 1);
 	return err;
 }
 
-- 
2.25.0

