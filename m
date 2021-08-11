Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5872E3E948A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhHKP2s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 11:28:48 -0400
Received: from li1434-30.members.linode.com ([45.33.107.30]:46086 "EHLO
        node.akkea.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233149AbhHKP2r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 11:28:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id F1DD455E34E;
        Wed, 11 Aug 2021 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628695703; bh=b7JOzQ7/TcIXJ+1xsV8fU//FIHLEIeJIfwUyuQmCl3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iccELBwttGPeD+eJ4R2VKeXkgCkyf7wOa9tCwHNDWnSjh09mk7WwJaopsgVq7rTQ5
         H/gmx03cdwQsi2ndjQ7yne+b2tLj+0fCurKBW03Ai8YXp1TOQG3U9j2NjWE28QBQjD
         bVaofoenBXVC7/4Yr9SOebN8NHXH4y+NilzqzFaY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GYwtDr3AM2FV; Wed, 11 Aug 2021 15:28:23 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 6894255E34D;
        Wed, 11 Aug 2021 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1628695703; bh=b7JOzQ7/TcIXJ+1xsV8fU//FIHLEIeJIfwUyuQmCl3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iccELBwttGPeD+eJ4R2VKeXkgCkyf7wOa9tCwHNDWnSjh09mk7WwJaopsgVq7rTQ5
         H/gmx03cdwQsi2ndjQ7yne+b2tLj+0fCurKBW03Ai8YXp1TOQG3U9j2NjWE28QBQjD
         bVaofoenBXVC7/4Yr9SOebN8NHXH4y+NilzqzFaY=
From:   Angus Ainslie <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v2 1/3] brcmfmac: add 43752 device ids
Date:   Wed, 11 Aug 2021 08:28:02 -0700
Message-Id: <20210811152804.2379405-2-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811152804.2379405-1-angus@akkea.ca>
References: <20210811152804.2379405-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add HW and SDIO ids for use with the SparkLan AP6275S

Signed-off-by: Angus Ainslie <angus@akkea.ca>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c     | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 2 ++
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 1 +
 include/linux/mmc/sdio_ids.h                                  | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 633d0ab19031..485ddeb436ae 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -990,6 +990,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359),
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 45037decba40..c9954da6c5cd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -727,6 +727,8 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_priv *ci)
 	case BRCM_CC_4364_CHIP_ID:
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
+	case CY_CC_43752_CHIP_ID:
+		return 0x170000;
 	default:
 		brcmf_err("unknown chip: %s\n", ci->pub.name);
 		break;
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 00309b272a0e..9d81320164ce 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,6 +52,7 @@
 #define BRCM_CC_4371_CHIP_ID		0x4371
 #define CY_CC_4373_CHIP_ID		0x4373
 #define CY_CC_43012_CHIP_ID		43012
+#define CY_CC_43752_CHIP_ID		43752
 
 /* USB Device IDs */
 #define BRCM_USB_43143_DEVICE_ID	0xbd1e
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 12036619346c..a85c9f0bd470 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -75,6 +75,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
 
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
-- 
2.25.1

