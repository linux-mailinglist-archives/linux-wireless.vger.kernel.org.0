Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D13443C3A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 05:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKCEem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 00:34:42 -0400
Received: from mail-bo1ind01olkn0156.outbound.protection.outlook.com ([104.47.101.156]:21973
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhKCEel (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 00:34:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+F/NVCUEe4XcXHs3aDIo9oJhRV9MMc15iZhq0zB5Y/Z8squ2o66dlh+vU7kNc1mHeVfbZPkYFaCv32QgxiMKUyyv50um6D4LyhYVNkND5qYPAqc5fDHF59JlzMmcwXkgB3D7aQ9pwSjO5XfDOEs7mGN151bIFryezn4csmKW4OlDBoFLTYGLRGjVMInCRDZl4/oqRsQrmAsD2QC5UgcbzyCdeiUbgDExEfekZfqoWNnPwamSWiQ9WweMMLnyXO+MC5BRDeTurOshPZELIzJzq5JrWfW/DqzWy6C5cJJsu5E2wLKPlfAlJOqGcCVHp5KA3cA1CnUUFi4gaay6t0ojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+7Y27stqYGa1VpjA0sUmeYnXAvjOqZUUoGHa2UEOB8=;
 b=bCKYGPzOdz3y1b4mho9FT1pehXFxCK42yxxVv8aEW1oUeE5FR9ayKQF0h+GegBeVKsS8cJvfspxWqv/GpgVSbxy3rLofsvkhggcvMsk2UQGg/CZfDjevEttZOHCA9gi83EUhIo2n29WEjE4lQ0rL9JIP2Ml6h5Efdusp+GbrpoSbo9MB/huhcf7N4wM+max0PdNj0uvidB/RXLDce1nZGsV0kkXFsJrfYaXVpeuZtmRG399FlXKVh3eNbLzfMoI2KatKXyiBHmC8MoxD9pYq6qp2E2gq37z0bbajTA4ke/GljkwBJUxkRJ3SLtn0ivYD1GPWxj+w+hUW8JdG1t/VAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+7Y27stqYGa1VpjA0sUmeYnXAvjOqZUUoGHa2UEOB8=;
 b=M3fKxPGNKCKZbxzXtFz7YQ8FEJsZgBBi1bU/hdulKT8Vr4iYrEPgKZAiutTJdOIA7znnKwgfuj9clcgPaaVKE19RhflnJMJ8ZHxVWUxyabCAnSAyZS+NHTGMzkTSErZPP8ibgNP4ukxCRPngYWmxhBrGh1nDaMa/MFdIfbxCN0Jokj7TwWS9bJKjcT0+0HQN4VisFjqA836Miz7rW4SHigbW51PyUL1A2tqCiz2IFL+IEqsECIgxvOe7rbUYfXZRGLASOs996TDwF+UsGhsRN9o1oj7BYoFdR90BHUSwyNMEftKFBIqrwnUjaWM2ZT9JvbJrhh0HA7QFdV9Cy2tfmQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (20.182.78.205) by
 PN1PR01MB0832.INDPRD01.PROD.OUTLOOK.COM (10.174.146.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Wed, 3 Nov 2021 04:32:00 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 04:32:00 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "chi-hsien.lin@infineon.com" <chi-hsien.lin@infineon.com>,
        "wright.feng@infineon.com" <wright.feng@infineon.com>,
        "chung-hsien.hsu@infineon.com" <chung-hsien.hsu@infineon.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] brcmfmac: Add support for BCM4377 on Apple hardware.
Thread-Topic: [PATCH v3 2/3] brcmfmac: Add support for BCM4377 on Apple
 hardware.
Thread-Index: AQHX0Gu+lsbLJwElwk25UKkbzzSmHA==
Date:   Wed, 3 Nov 2021 04:32:00 +0000
Message-ID: <0F1947F9-0836-43A9-B58A-2EF561CEC7B7@live.com>
References: <PNZPR01MB44158945D6957B942147A0D2B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB4415A4F531F4A058D76C4064B88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PNZPR01MB4415A4F531F4A058D76C4064B88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NkAdsF8XBGAzbBYI9xFNIOh2qfE7ssUSvY8Bvz6nLvRknsHfIWNoa3CnxZyC6LaX]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0251b9e-b3c2-432d-f5cb-08d99e82e0bd
x-ms-traffictypediagnostic: PN1PR01MB0832:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKb9295cOpK/1Q/kqbD7b6XQUhFRRWSd25koShMaTOq2OLmSBPiV6Fy/sUL8grkXaFy0jwOmRJIVhmYqF4jTbay7SR6P/sPTwk4Y+MJO4s7lXkoK3uA2NFem3OPaZ8vJNz1oZPY3FON/+STihes3D1yNKQ/+q7uF21HhY10Px+M2MsEPO/+9BHVVhVq9IdZhyTTFp1Rlwf3GW2aEfY9ovlEKs7vS8q/MVfi0o14/sous4gJOv0vfoKKGKfSwSdw54QjUz4T9/ZQaggGD+ofY8khZ2gB/th89L0xNY8VF9YSuexl9Z1NABlAcVXGP8HNGltbWjoS1L1XoRhdiQGzWJjuamgFNoEXiFd9TPYIuoFZcoE7gHGNNP12npQY2KAdVKLTgvr2/wXkkiwL7s0qYxCkCEOupYa67fFt+uCys3dTA5mpSXw5pcZ50BXwM8WTho6P6Z8m8pJTE5vtjrh0WrXtn7yqMZN2HDAjnpcSyfHZ34ycln6x9nGxL01saRztfjKQ1Z/JgKnQkz1hXz45TApwoCGxaL6pcXZPQtdTFhgw=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: WvedDxknup/f5PQvIzEljSViR2heCiOTUk/AKkJUGwmwxh+5547KHdfafo8gB+HG47wTwkvu2mdf6u0hihQfrnM5noRQUJLtZsel1HGanKlFOROtthQsZfek9GztFBtJ9GclgA1MMPHoCYjKnsV++YUZq4YZS7kZj4p5C6Ao930BrN0wZxiebfyRbvVydLSH1D7O6QF9S9Ty2ZLEgCxuzjoOaK4l5WMCwY9oi4elizrFszPutDFzeRnuL8PfYHxxdPbt67ceTCO5lvf5GNZd8g7Fm7aRex3pnwVnpVG8G8Je1kYxOm0xZygtsfidnD8ga4skCS9b0+C53F8+Yg6ADF6go++cie2rZLKLmwKTRByizLHB9M2xRcSQDV0OMbjTi8/NArbXP9kmdQ2mme6gt0YzL6mmL7/cN8ZiFjFBq6kAMjcbLFGjVDzxEzWzmVDs7pJ+Nfr5OL1eTdVp+lMhKBRaZcWHwBbSR7UuRYT3iM2xrz4zIzgSOHPdr+ua1CbkPTLskRkxdxtuI9iau/VFc6LunmpIPJL1nbKW1QaDq7qVfq9t5fmTQEgv+BtcZdL3tFe9ItRsVIgXZuPl3bNLIcxwsG1JO0L4l2G85tue/20/lyWIx+363ZEwt1UCsPmPi/ZDmjP9CM/Cky9qzvtm11OpKwx4vsu+m1CosMAIrDmM6i6B5ctz1tFsWFFvEv7557YpC4a0L9Ue5mawvGMnDEA77zbDkA4xoO5Ty8dIZlg9gvrOw70tLNJzwsi1l4NA/8bsBDLJTd66yNf3JSGrCw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D41675CB7399747A5EA9907FF37461A@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c0251b9e-b3c2-432d-f5cb-08d99e82e0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 04:32:00.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PR01MB0832
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

This patch adds required ids to support BCM4377 Chip found on certain Apple=
 Macs with T2 chip.

V3- Make plain text

Based on original patch by Aun-Ali Zaidi <admin@kodeit.net>

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 .../broadcom/brcm80211/brcmfmac/chip.c        |  4 +++
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 32 +++++++++++++++----
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 ++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 1bf0fa8f0..1e1b23bf4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -727,6 +727,8 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_pri=
v *ci)
 		return 0x160000;
 	case CY_CC_43752_CHIP_ID:
 		return 0x170000;
+	case BRCM_CC_4377_CHIP_ID:
+		return 0x170000;
 	case BRCM_CC_4378_CHIP_ID:
 		return 0x352000;
 	default:
@@ -1428,6 +1430,8 @@ bool brcmf_chip_sr_capable(struct brcmf_chip *pub)
 		reg =3D chip->ops->read32(chip->ctx, addr);
 		return (reg & (PMU_RCTL_MACPHY_DISABLE_MASK |
 			       PMU_RCTL_LOGIC_DISABLE_MASK)) =3D=3D 0;
+	case BRCM_CC_4377_CHIP_ID:
+		return false;
 	case BRCM_CC_4378_CHIP_ID:
 		return false;
 	}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce8c552c6..6f0166b33 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -59,6 +59,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
+BRCMF_FW_DEF(4377, "brcmfmac4377-pcie");
 BRCMF_FW_DEF(4378, "brcmfmac4378-pcie");
=20
 static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] =3D {
@@ -81,6 +82,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwn=
ames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377),
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFFF, 4378),
 };
=20
@@ -586,23 +588,33 @@ brcmf_pcie_reg_map(struct brcmf_pciedev_info *devinfo=
, u32 reg)
 {
 	switch(reg) {
 	case BRCMF_PCIE_PCIE2REG_INTMASK:
-		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4377_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_INTMASK;
+		else if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
 			return BRCMF_PCIE_64_PCIE2REG_INTMASK;
 		return reg;
 	case BRCMF_PCIE_PCIE2REG_MAILBOXINT:
-		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4377_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_MAILBOXINT;
+		else if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
 			return BRCMF_PCIE_64_PCIE2REG_MAILBOXINT;
 		return reg;
 	case BRCMF_PCIE_PCIE2REG_MAILBOXMASK:
-		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4377_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK;
+		else if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
 			return BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK;
 		return reg;
 	case BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_0:
-		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4377_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_0;
+		else if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
 			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_0;
 		return reg;
 	case BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_1:
-		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+		if(devinfo->ci->chip =3D=3D BRCM_CC_4377_CHIP_ID)
+			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_1;
+		else if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
 			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_1;
 		return reg;
 	default:
@@ -1018,7 +1030,10 @@ static void brcmf_pcie_intr_disable(struct brcmf_pci=
edev_info *devinfo)
=20
 static void brcmf_pcie_intr_enable(struct brcmf_pciedev_info *devinfo)
 {
-	if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+	if(devinfo->ci->chip =3D=3D BRCM_CC_4377_CHIP_ID)
+		brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK,
+				       BRCMF_PCIE_64_MB_INT_D2H_DB);
+	else if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
 		brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK,
 				       BRCMF_PCIE_64_MB_INT_D2H_DB);
 	else
@@ -1053,7 +1068,9 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, voi=
d *arg)
 	struct brcmf_pciedev_info *devinfo =3D (struct brcmf_pciedev_info *)arg;
 	u32 status, mask;
=20
-	if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
+	if(devinfo->ci->chip =3D=3D BRCM_CC_4377_CHIP_ID)
+		mask =3D BRCMF_PCIE_64_MB_INT_D2H_DB;
+	else if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
 		mask =3D BRCMF_PCIE_64_MB_INT_D2H_DB;
 	else
 		mask =3D BRCMF_PCIE_MB_INT_D2H_DB;
@@ -2363,6 +2380,7 @@ static const struct pci_device_id brcmf_pcie_devid_ta=
ble[] =3D {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_2G_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID),
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h =
b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 242df778f..eb3f361a2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -50,6 +50,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
 #define CY_CC_4373_CHIP_ID		0x4373
 #define CY_CC_43012_CHIP_ID		43012
@@ -85,6 +86,7 @@
 #define BRCM_PCIE_4366_2G_DEVICE_ID	0x43c4
 #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
+#define BRCM_PCIE_4377_DEVICE_ID	0x4488
 #define BRCM_PCIE_4378_DEVICE_ID	0x4425
=20
=20

