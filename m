Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50574693640
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Feb 2023 07:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBLGi5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Feb 2023 01:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBLGiy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Feb 2023 01:38:54 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8A14213;
        Sat, 11 Feb 2023 22:38:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 832DB42601;
        Sun, 12 Feb 2023 06:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1676183932; bh=adcFx8+Ki3/6rJCB6FOrhipz/dSoNnMHTrkx6UZeD+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KqyAfJKgrpo2tBCZGW+ASCTPNue9ydet1gMXQsOc8g7/PirKZrMOKE9fAXe4ySHar
         ddrcRjY/A0ToYbSNlc/DT69Mk57Tt/97PkEWIDAHsKyV2/S6G7oiVWWVnyfv+HahBT
         P5eDrvI+JAEAXd5+snfmjeRT1CwEHhbAnVQ7eHajQ0dJZAvv8OM3iBEtIaqRMdaRDa
         1SFy/JSzBfBABmpJuJu2xpIIHwAehEYr4qOYUmSIZrkBcNJqag9h37um8RE87w8CHz
         Kep90VVhRKhKGmBzCwYlmSJiliSaNVRlFAScVJuUG/UC9rzjF0GySZfGJaIiBh+Slh
         5vd23bjE+tl/g==
From:   Hector Martin <marcan@marcan.st>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Prutskov <alep@cypress.com>,
        Ian Lin <ian.lin@infineon.com>,
        Joseph chuang <jiac@cypress.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Aditya Garg <gargaditya08@live.com>,
        Jonas Gorski <jonas.gorski@gmail.com>, asahi@lists.linux.dev,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v4 2/4] brcmfmac: pcie: Add IDs/properties for BCM4355
Date:   Sun, 12 Feb 2023 15:38:11 +0900
Message-Id: <20230212063813.27622-3-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230212063813.27622-1-marcan@marcan.st>
References: <20230212063813.27622-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This chip is present on at least these Apple T2 Macs:

* hawaii: MacBook Air 13" (Late 2018)
* hawaii: MacBook Air 13" (True Tone, 2019)

Users report seeing PCI revision ID 12 for this chip, which Arend
reports should be revision C2, but Apple has the firmware tagged as
revision C1. Assume the right cutoff point for firmware versions is
revision ID 11 then, and leave older revisions using the non-versioned
firmware filename (Apple only uses C1 firmware builds).

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 +++++++++-
 .../wireless/broadcom/brcm80211/include/brcm_hw_ids.h  |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 96608174a123..7135f889907a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -52,6 +52,7 @@ BRCMF_FW_DEF(43602, "brcmfmac43602-pcie");
 BRCMF_FW_DEF(4350, "brcmfmac4350-pcie");
 BRCMF_FW_DEF(4350C, "brcmfmac4350c2-pcie");
 BRCMF_FW_CLM_DEF(4355, "brcmfmac4355-pcie");
+BRCMF_FW_CLM_DEF(4355C1, "brcmfmac4355c1-pcie");
 BRCMF_FW_CLM_DEF(4356, "brcmfmac4356-pcie");
 BRCMF_FW_CLM_DEF(43570, "brcmfmac43570-pcie");
 BRCMF_FW_DEF(4358, "brcmfmac4358-pcie");
@@ -78,7 +79,8 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0x000000FF, 4350C),
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
 	BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
-	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFFFFF, 4355),
+	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0x000007FF, 4355),
+	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFF800, 4355C1), /* rev ID 12/C2 seen */
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
 	BRCMF_FW_ENTRY(BRCM_CC_43569_CHIP_ID, 0xFFFFFFFF, 43570),
@@ -1994,6 +1996,11 @@ static int brcmf_pcie_read_otp(struct brcmf_pciedev_info *devinfo)
 	int ret;
 
 	switch (devinfo->ci->chip) {
+	case BRCM_CC_4355_CHIP_ID:
+		coreid = BCMA_CORE_CHIPCOMMON;
+		base = 0x8c0;
+		words = 0xb2;
+		break;
 	case BRCM_CC_4378_CHIP_ID:
 		coreid = BCMA_CORE_GCI;
 		base = 0x1120;
@@ -2590,6 +2597,7 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4355_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID, WCC),
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 28b6cf8ff286..6e27e3966655 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -72,6 +72,7 @@
 #define BRCM_PCIE_4350_DEVICE_ID	0x43a3
 #define BRCM_PCIE_4354_DEVICE_ID	0x43df
 #define BRCM_PCIE_4354_RAW_DEVICE_ID	0x4354
+#define BRCM_PCIE_4355_DEVICE_ID	0x43dc
 #define BRCM_PCIE_4356_DEVICE_ID	0x43ec
 #define BRCM_PCIE_43567_DEVICE_ID	0x43d3
 #define BRCM_PCIE_43570_DEVICE_ID	0x43d9
-- 
2.35.1

