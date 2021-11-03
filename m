Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABFD443C3C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 05:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKCEfa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 00:35:30 -0400
Received: from mail-bo1ind01olkn0156.outbound.protection.outlook.com ([104.47.101.156]:53440
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhKCEfa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 00:35:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXj8pwCkQAQaclhUYFsAEVqBUpJ1ULDVAraLnbxw9wqRBU0qxS9o0tc2jFabbo5MR2BwBjuBKASOmz1KU52O6CcaKv59R/h5QZGVKZ6ATEG9H+60fPE1if6/L9Jj2p6LD3CbBhEhy3zxIZfFxT7S/PeNCbNdc8Q15VM5yS1dECYuAixpADGy+mslfg84ar4h0bP4Keb7dCf1fVmM/Ile3/PgpkAwdLgDMQ00IMKDUQI+KmYeIOKIWhOqCgHPKuGO7t2ovA8C84up3C2ne//a8mVN+r/RWOw/KxXEKLv3TLF+bK6ueIRBjr6etpEYId3Xnz8dWjz4gqSKXCueI93IKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZvYxcE/09lCN/d26KOQu8Mvwnxp/onEvCAolLHLH1c=;
 b=kpHAl1N9PPiaI/5MCSljqXltNq6sp62hMhgmd9jblkgsFX9GHxYx6D46AlyzUQoHOOxLjy0m1ix2BUKKzF8rd0mm2az/3PWVOsh1xmpeH11ODLEV3ArtpjYjwXU/rp4OUK+7VcaxG5BaDuMEWVxXA7l9jryWwbr4n6ex1WGtBy6a3Es/70Od0QfaEhqvP50lQJqvSWGxFHp+oQ6iceDEi1Ch9jEj6JZqx8xdhz/culnkVYzfj4UWXLStKtyzUJunKwhMl30WyZACEozHmOm7mGTnGtxt8FIUysY1a6lL23zRESdHAzlhe0MoUIWLhX9mS286w2h8hSceOlTYD7LX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZvYxcE/09lCN/d26KOQu8Mvwnxp/onEvCAolLHLH1c=;
 b=WIyBAvY4caeOaKRFIZjeSpizTy5otDOX//Vzr6hljxF50q1spPwBMJCDGWdwqEeifk4Vp/QQADu5aVyeSBKtshavhfI3YR+id6PNgrwjBhbUsesjQwBILOEf65zFJjP1yRou7FR8gkkxEJeATlY3MWZRYvQxQ01LI8rN88r0SpncI92o0/5p+oRJ0G/dq9F7JVgzuaXW89Q5RQEaykTFlXyYVoGzfqaSm+xOrbbz6s5QEInD85pFMGOFqFVWgMxvXVY0xwSm4mKKwzgaV7LtZxy8fZST414G98z0r2Q7DU3XHX7oiTxz8byArQqLd/repUdxzRxu6Ox7/mtQzSexyg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (20.182.78.205) by
 PN1PR01MB0832.INDPRD01.PROD.OUTLOOK.COM (10.174.146.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Wed, 3 Nov 2021 04:32:49 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 04:32:49 +0000
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
Subject: [PATCH v3 3/3] brcmfmac: Add support for BCM4355 on Apple hardware.
Thread-Topic: [PATCH v3 3/3] brcmfmac: Add support for BCM4355 on Apple
 hardware.
Thread-Index: AQHX0Gvbb+rSopgGIUuQy18nab02BA==
Date:   Wed, 3 Nov 2021 04:32:49 +0000
Message-ID: <0DE89E9A-36D4-4638-BD2A-CD4B404CF620@live.com>
References: <PNZPR01MB441560BA8BBD148C882BA9EFB88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44158B4844B8224735985ABAB88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PNZPR01MB44158B4844B8224735985ABAB88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [uGv559+TTCZhp9uTOsgdk+xeFlnnvY+smmBaZCUh0UGmdFest9IxKZACqDNX4NG2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 797ee0ea-3604-4e04-b28f-08d99e82fe2f
x-ms-traffictypediagnostic: PN1PR01MB0832:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ToGwYRo+/WPYq74YepWCWCMfWkQqM3BGNyNPlqKxBtSLFj8BuBiiZHkowHHMl4uYR5WQZ6Yc72gUqLffdDMS7JPa8odtoKLUafc581K8Gd8EFYs40Hw4ksMl6wYT4QsC3rXosjBHuB94XaPy0doLzjuYO3KeY3I0vudhb5YzoKL9dM25qWuoDYVEQqDOZkRmvdwyz9hinMMf8cEfzFsujfk1ajlRA6QwyVYYp8bJTsxC1XNR8jxGVn/WFG9l8IttLSjl5pxc/HkZrbEPwC/eY9ab+bO5+TScnIVtHsI35Tort2gyw9/v/8y5imitsG9WwsRcEX/0HK+etF/OVqAQcSKYrG67hqtDzIpx5jI1iH+gCTjsEbY4d0P315rggdGBA6JZrt0IhN9LaBFiFygliahEmHyQJ+V0vJ2Wx0gJgJ/i92uirOF0O9EekIPWxoHx7q0dLIXNABv8avnUkzFM1Evz6BUJCLF94xLDaROizA6BelKIK699gkcPhaAniZ29vViJKWdxp7iYpuInMHrwmuxPc2qWstj0kbjlzRukm9I=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 4s+VEDfo/xn5hns5QVRs6Jq+qDAXgtR6EAjlcu+Sh3Wk2ESd6r/QH6vPyWqX15ZebgXasyJiLqWYiigq2weTN5NeidNoKvleDzNQUf9NoQ6nbf7+VVgY/plSaSP6tlNiNM/Enw3vrSbj0dbwGnZfx/qv8gW3RGBZX4t2EHg1h6oiOLrua80Q2ZOaDrAQfioISbAAHKFoBJpgJWraxo43XyDAykwPPJ3cbEe3hqBOX+YWl68W84k5VW537GAiepqbBNqQQysKUcpaG7CV6q1smg7OiHfopuqokOlqfhRosR/01f79XEyD+Gbr26Qe8p21bm7A9EXBqcbaIPeSAcpsMPz3bX7aqhxZUeAYl3zy4tWKvimzmba9doPsr2CMZcqfOIY/SfkibY6dkO7kL/bS6f5CYQZ4r/XaIdQRV+QNWCSCsrntzrp9yyMAPycm+y+bAaXy0r8rG/WRdOxiCMUwyrNBQY0cTkq6mRRDRkW71TBnRICuQ6liVGoEw9J9lcK6SUfNWRbf3uWbtfVky76YCmFEaMg/aXFHYgeDEsGb51PmxnU7GtUddXTUtQRfVwklG/hnEy1bLCxH5tetmX0X2vWnDHiyFqFI2djAPJCrm775rG+cCBPMnqe9k/koqXvdwXNtT/dJpmlv6ZXuA6MzsikAmLSHT3Wi39r2ftmKeXk2vw8+b3nQ3MuyLpuwvBpDkbtiYbJ18iFTletgKRXCLpKNHFkOexkG9XnTaSTwZGgoKf5EnrNNXtquPmL/+RvSQrrRYoHsZB9XzOEIEBd54w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BA20AFE67A0824CB363B21B327A7909@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 797ee0ea-3604-4e04-b28f-08d99e82fe2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 04:32:49.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PR01MB0832
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

This patch adds the necessary ids required to support BCM4355 Chip on Apple=
 Macs with T2 Chip

V3- Make plain text

This patch is based on the original patch by Aun-Ali Zaidi <admin@kodeit.ne=
t>

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c       | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c       | 3 +++
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 1e1b23bf4..7086de030 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -724,6 +724,7 @@ static u32 brcmf_chip_tcm_rambase(struct brcmf_chip_pri=
v *ci)
 		return 0x200000;
 	case BRCM_CC_4359_CHIP_ID:
 		return (ci->pub.chiprev < 9) ? 0x180000 : 0x160000;
+	case BRCM_CC_4355_CHIP_ID:
 	case BRCM_CC_4364_CHIP_ID:
 	case CY_CC_4373_CHIP_ID:
 		return 0x160000;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 6f0166b33..19e8238fe 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -49,6 +49,7 @@ enum brcmf_pcie_state {
 BRCMF_FW_DEF(43602, "brcmfmac43602-pcie");
 BRCMF_FW_DEF(4350, "brcmfmac4350-pcie");
 BRCMF_FW_DEF(4350C, "brcmfmac4350c2-pcie");
+BRCMF_FW_DEF(4355, "brcmfmac4355-pcie");
 BRCMF_FW_CLM_DEF(4356, "brcmfmac4356-pcie");
 BRCMF_FW_CLM_DEF(43570, "brcmfmac43570-pcie");
 BRCMF_FW_DEF(4358, "brcmfmac4358-pcie");
@@ -68,6 +69,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwn=
ames[] =3D {
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0x000000FF, 4350C),
 	BRCMF_FW_ENTRY(BRCM_CC_4350_CHIP_ID, 0xFFFFFF00, 4350),
 	BRCMF_FW_ENTRY(BRCM_CC_43525_CHIP_ID, 0xFFFFFFF0, 4365C),
+	BRCMF_FW_ENTRY(BRCM_CC_4355_CHIP_ID, 0xFFFFFFFF, 4355),
 	BRCMF_FW_ENTRY(BRCM_CC_4356_CHIP_ID, 0xFFFFFFFF, 4356),
 	BRCMF_FW_ENTRY(BRCM_CC_43567_CHIP_ID, 0xFFFFFFFF, 43570),
 	BRCMF_FW_ENTRY(BRCM_CC_43569_CHIP_ID, 0xFFFFFFFF, 43570),
@@ -2362,6 +2364,7 @@ static const struct pci_device_id brcmf_pcie_devid_ta=
ble[] =3D {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID),
 	BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4355_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID),
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h =
b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index eb3f361a2..8536a285d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -36,6 +36,7 @@
 #define BRCM_CC_4350_CHIP_ID		0x4350
 #define BRCM_CC_43525_CHIP_ID		43525
 #define BRCM_CC_4354_CHIP_ID		0x4354
+#define BRCM_CC_4355_CHIP_ID		0x4355
 #define BRCM_CC_4356_CHIP_ID		0x4356
 #define BRCM_CC_43566_CHIP_ID		43566
 #define BRCM_CC_43567_CHIP_ID		43567
@@ -69,6 +70,7 @@
 #define BRCM_PCIE_4350_DEVICE_ID	0x43a3
 #define BRCM_PCIE_4354_DEVICE_ID	0x43df
 #define BRCM_PCIE_4354_RAW_DEVICE_ID	0x4354
+#define BRCM_PCIE_4355_DEVICE_ID	0x43dc
 #define BRCM_PCIE_4356_DEVICE_ID	0x43ec
 #define BRCM_PCIE_43567_DEVICE_ID	0x43d3
 #define BRCM_PCIE_43570_DEVICE_ID	0x43d9

