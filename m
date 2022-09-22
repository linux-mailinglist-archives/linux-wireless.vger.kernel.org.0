Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C975E6011
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 12:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiIVKmX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 06:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiIVKmV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 06:42:21 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6414A6ADD
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663843341; x=1695379341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYywTs4efIJDaEim9wX1oHlqssoGLwjBbYILoJAuKpM=;
  b=MF/hTDhHMwSGSdvLHKvOf8v4CwySyYyhhE7KybByTc7zePc8EUzRgiEh
   uOPDTkV01PBOFeOh/i3v3j8eGfn/vkGvG3j4WUd7BrrX3fM50tps5Swtq
   CNgV1DCJL1J5sL/tKRex0lB3pxsnfyrot8FI9HP5kGCTu7IxhOdnHuN5s
   I=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="1444106"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="1444106"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:42:19 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 12:42:18 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:42:18 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 22 Sep 2022 12:42:18 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="259403212"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="259403212"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 22 Sep 2022 12:42:18 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Sep 2022
 05:42:17 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 778951004E6;
        Thu, 22 Sep 2022 05:42:14 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 7545D9807D1; Thu, 22 Sep 2022 05:42:14 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 4/4] brcmfmac: Remove the call to "dtim_assoc" IOVAR
Date:   Thu, 22 Sep 2022 05:41:40 -0500
Message-ID: <20220922104140.11889-5-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220922104140.11889-1-ian.lin@infineon.com>
References: <20220922104140.11889-1-ian.lin@infineon.com>
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

From: Ramesh Rangavittal <ramesh.rangavittal@infineon.com>

When STA roams from one AP to another, after roam is complete, host
driver tries to get TIM information from firmware. This is no longer
supported in the firmware & hence, this call will always fail.
This failure results in the below message being displayed on the
console all the time when roam is done.

ieee80211 phy0: brcmf_update_bss_info: wl dtim_assoc failed (-52)

Changes ensure that the host driver will no longer try to get TIM
information from firmware.

Signed-off-by: Ramesh Rangavittal <ramesh.rangavittal@infineon.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 42068145a447..dfcfb3333369 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3164,10 +3164,7 @@ static s32 brcmf_update_bss_info(struct brcmf_cfg80211_info *cfg,
 				 struct brcmf_if *ifp)
 {
 	struct brcmf_pub *drvr = cfg->pub;
-	struct brcmf_bss_info_le *bi;
-	const struct brcmf_tlv *tim;
-	size_t ie_len;
-	u8 *ie;
+	struct brcmf_bss_info_le *bi = NULL;
 	s32 err = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -3181,29 +3178,8 @@ static s32 brcmf_update_bss_info(struct brcmf_cfg80211_info *cfg,
 		bphy_err(drvr, "Could not get bss info %d\n", err);
 		goto update_bss_info_out;
 	}
-
 	bi = (struct brcmf_bss_info_le *)(cfg->extra_buf + 4);
 	err = brcmf_inform_single_bss(cfg, bi);
-	if (err)
-		goto update_bss_info_out;
-
-	ie = ((u8 *)bi) + le16_to_cpu(bi->ie_offset);
-	ie_len = le32_to_cpu(bi->ie_length);
-
-	tim = brcmf_parse_tlvs(ie, ie_len, WLAN_EID_TIM);
-	if (!tim) {
-		/*
-		* active scan was done so we could not get dtim
-		* information out of probe response.
-		* so we speficially query dtim information to dongle.
-		*/
-		u32 var;
-		err = brcmf_fil_iovar_int_get(ifp, "dtim_assoc", &var);
-		if (err) {
-			bphy_err(drvr, "wl dtim_assoc failed (%d)\n", err);
-			goto update_bss_info_out;
-		}
-	}
 
 update_bss_info_out:
 	brcmf_dbg(TRACE, "Exit");
-- 
2.25.0

