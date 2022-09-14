Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199E95B7F6D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Sep 2022 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiINDc6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 23:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiINDcz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 23:32:55 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526AA5B7B8
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 20:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663126374; x=1694662374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WvjKQCmQJP/0I227rOxHflcLvHigaPbFLkRL102mFGk=;
  b=U6qaMQoW5nQGGTC1Vj27Vhm7Hj6DCX+MbD7OaCJxobZ1uFKvHtZGK1to
   xQSstWjq8KBmeREGo5s5FZCYdXxN0bp0PsyQgFAp+FzJfc9H5PYCrHEI5
   wSuoduKCo5qepTjenMJ8AzQegmXKPtjw2XU5ddF8fWNCQ4HEMRsN5pkBu
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="317079798"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="317079798"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 05:31:51 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 05:31:50 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 05:31:49 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Wed, 14 Sep 2022 05:31:49 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="258419704"
X-IronPort-AV: E=Sophos;i="5.93,313,1654552800"; 
   d="scan'208";a="258419704"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 14 Sep 2022 05:31:49 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Sep 2022
 22:31:47 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id A13EB100243;
        Tue, 13 Sep 2022 22:31:47 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 9EA42980794; Tue, 13 Sep 2022 22:31:47 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 5/5] brcmfmac: Remove the call to "dtim_assoc" IOVAR
Date:   Tue, 13 Sep 2022 22:31:02 -0500
Message-ID: <20220914033102.27893-6-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220914033102.27893-1-ian.lin@infineon.com>
References: <20220914033102.27893-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 7c72ea26a7d7..a653ba1515c6 100644
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

