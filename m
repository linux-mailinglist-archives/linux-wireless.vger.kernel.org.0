Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D3B5EED07
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 07:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiI2FGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 01:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiI2FG3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 01:06:29 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09354CA3D
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 22:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664427988; x=1695963988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JHhvTPbiGl5OGSrQmdXAztP71EWXy/q3AlYCfYGWAAI=;
  b=CxLm84mw8GGg6mFMUUyawPohZiri4oxcmvtHizUQddUx9eUjfurVMniv
   gtQRxOluePX3McLwWgxkscA+ouYlxZyEjgYInjfURawkHTGm16qp4Pe8q
   3/5AmxPhrhyoIYDDfC8Ob4yiNktEHVAL6/7jPnUetdn2TI8V4ccPkHQ4k
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="319475413"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="319475413"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 07:06:25 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 07:06:25 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 07:06:24 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 07:06:24 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264162895"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="264162895"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 07:06:24 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Sep 2022
 00:06:22 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id A7E621004E2;
        Thu, 29 Sep 2022 00:06:22 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 A47F89807D1; Thu, 29 Sep 2022 00:06:22 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 4/4] brcmfmac: revise SoftAP channel setting
Date:   Thu, 29 Sep 2022 00:06:14 -0500
Message-ID: <20220929050614.31518-5-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929050614.31518-1-ian.lin@infineon.com>
References: <20220929050614.31518-1-ian.lin@infineon.com>
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

From: Ting-Ying Li <tingying.li@cypress.com>

We need to update "chanspec" iovar for each SoftAP creation
because firmware will update the chanspec to current bsscfg
for each bss. If we do not update it then the wrong chanspec
will be shown on the result of 'wl -i [interface] status'
command. No need to handle channel resource reusing for mbss
mode by the host driver, it should be covered by firmware.

Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index d0aee6c1aa0d..67cb1f568e7e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5061,17 +5061,17 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 				 err);
 			goto exit;
 		}
-		if (!mbss) {
-			/* Firmware 10.x requires setting channel after enabling
-			 * AP and before bringing interface up.
-			 */
-			err = brcmf_fil_iovar_int_set(ifp, "chanspec", chanspec);
-			if (err < 0) {
-				bphy_err(drvr, "Set Channel failed: chspec=%d, %d\n",
-					 chanspec, err);
-				goto exit;
-			}
+
+		/* Firmware 10.x requires setting channel after enabling
+		 * AP and before bringing interface up.
+		 */
+		err = brcmf_fil_iovar_int_set(ifp, "chanspec", chanspec);
+		if (err < 0) {
+			bphy_err(drvr, "Set Channel failed: chspec=%d, %d\n",
+				 chanspec, err);
+			goto exit;
 		}
+
 		err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_UP, 1);
 		if (err < 0) {
 			bphy_err(drvr, "BRCMF_C_UP error (%d)\n", err);
-- 
2.25.0

