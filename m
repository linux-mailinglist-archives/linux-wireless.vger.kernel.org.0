Return-Path: <linux-wireless+bounces-17758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB6BA170C9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 17:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7553A1334
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787151EC004;
	Mon, 20 Jan 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="WzbnlDRV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010009.outbound.protection.outlook.com [52.103.67.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802381E9B37;
	Mon, 20 Jan 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391857; cv=fail; b=LUjdipt6ayq0duODUedZc7bv/7cWMDydwBCMjEHaB80W61BMG4bw6LgkanGzBB7T18fc3Vk0XOgk+orLW9GuBwi5EpPILdoYBB9SXs+ngz1RA9KWrMxWBtB1RuPW33/t9YKGO9Ul8uojGZzcuxmxEqVHupi0kXY9TDqpd240j8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391857; c=relaxed/simple;
	bh=EHzjaZWIXVDuchesRu1Mw/ybYuqofthYxASuGlPDiUM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mw6D2O2DOpITM6P1pxjL1XPWZP3ZusqTXO3C+DBzgmYDdOxCRV+ucahpwF1YnWO/Zvnv/RgU/LAW1y76VAyETBgxA2qXg7wQvsAAEWxE6xx6mJkoH1536oTox7rswyShGzMenMmxBjrx5w83OYOb/MiD0iUwpe1Cf7Vs/NcopUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=WzbnlDRV; arc=fail smtp.client-ip=52.103.67.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGYhkwBK2j/iuG52Is0/DQt9FKz5DdtkcRRQbw+nkIaI8f5IJ0CXjISCrQQdCXXCnDgAbzo5hVC3Z65CeRX99Z2mepmCa34Q4BcajNhH9Nqp1joFY1BYkWy6ZyyNIx+2ZB15Z6E7l1kTrxPGg3G+ky9EiSrSxEMk0rzMqZajBDA8Um5Dns4kXULWuicA1oA42UeV7nXyPVg3EEukOwY7DJTD2Qp4xoEPdO/qzD/lODI6WB0DoAFrJFeaw/NHsPyQyMoofqrgOWbTBmfT2CSiBgwsYwZdRQjH0R7sgEmMOGM/0rQXwY4fofxCkIAGFJZdr6H+Fi8W8/iHMn1zYKHc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Btzavl53HHeTbQ/uROUfvWR582fRgyouaTqAWccQUE=;
 b=zG9YrHpBjqbfjoeTqkuuppY6+HzUVVf3FfnllHWO9lbRkzwUb5UzN70dPM/+qoY2TnxyHcA1ZHsJ8x8Oi7V2lsaTD6gfcqnrzGztwENbYdgKJjhZZkElX4vZ6YvbQZ2dxny4qCT8O5adPOTPhHSx2cvHd40jBH2N8h6q1lwrVBoWWuZeE7UIWRxEIGvHZmYdCPOI6WW6E5tPE5+B10pV8hf9Rt/W+E6o7yAiU8XwdP8lMlnxNmKFY02nY5OfdM0ye3/lv5WJ4tThBsK5qq7BuYCgneZTY9zUGt35DJ+vRgxOW6ko3k6EC6+m6u206WDQE1hk6+p12L1qQd7rMbX+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Btzavl53HHeTbQ/uROUfvWR582fRgyouaTqAWccQUE=;
 b=WzbnlDRV9FHkUoQ3YF4g4IX2nrwXHOaWr3pSLBJX6gx1HhFXNi3uqncgejlNaqbyhAFPvnklplyx6fcEzlk+qm2FSZc/VOH4+NhhE4Vxz9zvb7K7PHVN8f5pRlUq/loYtguCvWMY6vr9Nns6kEnBqukJh3q1jSPO9REhu8Y2aBeEoMl+0uWeUB6zdJ5NBtvbS4JC8u5lyXNBr1Ixc/mwPse12NrQX95hfWx78Ai+7ec5nR2T9b0C/ktu8cS6rji74ql/UiLkoljNTBUV6F1Yw9fxLxPbRz1VZVhzVt5UZZy1II8kzteo7eAu0rU1v9y7gm3BY+BCaz0jY+/GPCtwpg==
Received: from MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:3e::12)
 by PN2PR01MB9923.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 16:50:49 +0000
Received: from MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8d8:4de:ff79:7668]) by MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8d8:4de:ff79:7668%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 16:50:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Arend van Spriel
	<aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>, Hector Martin
	<marcan@marcan.st>, Janne Grunau <j@jannau.net>
CC: Orlando Chamberlain <orlandoch.dev@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] wifi: brcmfmac: use random seed flag for BCM4355 and BCM4364
 firmware
Thread-Topic: [PATCH] wifi: brcmfmac: use random seed flag for BCM4355 and
 BCM4364 firmware
Thread-Index: AQHba1t06RYmbdFGZUWJR5WG2iWgEA==
Date: Mon, 20 Jan 2025 16:50:47 +0000
Message-ID: <47E43F07-E11D-478C-86D4-23627154AC7C@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA1PR01MB2555:EE_|PN2PR01MB9923:EE_
x-ms-office365-filtering-correlation-id: c77e38e5-606d-45dd-678e-08dd3972971e
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmpI8tRyoOXaSUmOkLVCBKasc5E2meS7BDtk6cJoQT0Zy8hfvN+USgr5EDr0Jzq2tvjdqFngV9I4QZy93Fwlsr4oyZh0aborHiMu2gdl4K1+3nTCKaW5MM73X2/eN6Octn3mgto4s9beqh4i5+TYlASwr5wROiksHSDxdbz1bEI5k0/0Oxxwb8YUtiOjfBZlCqxYgRyWerfd8f9JHWJ/Tkymm97Fs3Ex/+EqsLSFdm1I4yUpXLrz9n8UssGxKt3D+cHNyKLVTyPkvheaGOQNmyp/IGeR6aapcm1gxXQ4yZeZoYm6WfxbS1TEXOPIYlcf+NI2itxKh5zq7UsSm6vaStZiaG2l8UsISzxHOEf9W4yZVedhFKPChxByLEWQ/XQpKJWR5V+p+jfy79r3+bEIgxA5OboII85vDF7V+ZtEE3olc5Qjvknigia3F47MoxoqaWVUgfB23Y5oQ+7Sq3yjeKVF5kBo+5n5MGUedoheaYLTIAlsUtirvRXfJI+tfV+lWKTcBggnZRZggjrNKz2DX6zT2u7KQ7afYAepKg9ZXRcbafxbnAryQu2fsF+0D7tigE42C9vg5+xBWBXKEobBUK0Zh68MNjsL/AsVh43zXl9PV+qW4jxwiGUiA5r5XVy9qnwypHy9dNcRKWiTo7JwCf9fJUcI15VThQu530UPkt6jwXRENXKf8hKYsWn/m2aUKBB/1l7D5aXdNZ/HdmNu53pzBrKlPf46aFJdKCeUjZ5QKRQxrBKYByws4QQTb9+pFIw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|5062599005|19110799003|8062599003|461199028|15080799006|7092599003|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nQ53R7HK9yG17z+dj8OHSiknN/arT3pLZVVqlj8d+dsJbhtB8l4LNuz1gFhM?=
 =?us-ascii?Q?9mV3TvQh5vUFh92qd+LItdfKNhYXceMzKnJDl6UNvFgn7FX4wZ1TBP8Oit7A?=
 =?us-ascii?Q?LXkwI6SPZ4gpGHdLLbqeystvoXWEVMRj1TmBZE+jn+dB2Os4zOYi7aibkS8j?=
 =?us-ascii?Q?dOwag3/pUblE6+MavKV1Er/YDtYIKwPXuaJ57xqOR1eaWAPSV++Xo2FeqDzF?=
 =?us-ascii?Q?KuLC1aTRFwzPeRr+ntG54rEx4fbFQ55XaVTdC2RTNaD3PDt8mRWHL4lktX3v?=
 =?us-ascii?Q?yRyWvN5ltlNM2WP/pyt/ErjPHDBfsR0Eg1n08oXTA1lMdhZXbyEYv8EUmVpl?=
 =?us-ascii?Q?qpNWEbdBSAos9c+9Bx4QFMiOeOpNggNaY6VjvXkTHNTS3hE0xyXOv8S0zhwL?=
 =?us-ascii?Q?/15UNn21tzs/BbJdp7ZK9tR82fpvef7JKmP2WBwQGlnuxF2nh3qMNPu8gxjs?=
 =?us-ascii?Q?jrRfeFcGPXlke0m3AKwN+plmeHnvwupszlRl3kSwMPdhvzGTkmFBVN9wBaxY?=
 =?us-ascii?Q?Nx5JMSGuVlu/HBklz0gtRRANo5x/SABMXC7YwZ7wZH0iQKVbIysSQPNiZjGC?=
 =?us-ascii?Q?JeBwyo5kh2NE8BiyKEaLrwxml9ZrOBYjaqwDq7Ngua1Z3JgP+iz1lhXI7CHs?=
 =?us-ascii?Q?E7Ao6AV/fsu0cZL+pJ+PL4ScaKeNP85TsepxI5LCseVuHU1C7HbN10RkfJkC?=
 =?us-ascii?Q?FNcdYie/ssxSakuPYg6YQ/ER6ZOcy3DbmRREZQAKhbz3PGqM9ZwuCqr/uPaG?=
 =?us-ascii?Q?h7ZWlFHwxOQ10R7RAy8P4ROD+nb4/OAthKUDs6DuUuiC4pmeBxUuzVvYDzVB?=
 =?us-ascii?Q?SvNIoqAdiwAeAri5eZve5zuTIa+fj5PCVU79anFcIaxi+boLFVR+IrCQ0rnp?=
 =?us-ascii?Q?VEZttKCtz5rTAm+cBsz7rOPk4Prb/+2aasjUJ+NyLKpPWZ04MTtK4rCS6Wh8?=
 =?us-ascii?Q?+ghU0EnISqsdOKDZrkQECTlh2B+f4LNvWSECwe9znvp16je313uT7b6zfWjV?=
 =?us-ascii?Q?SKFYXxWU+S2GZwPc9DitZmWoeJljhGVhaZD5IjfA0cbOQHIc1u/mPuHx/Otk?=
 =?us-ascii?Q?KGKoljhlehO+pExTnhZ8jtg6InHbAP+wg0Xxs9J/7MM8gEVQmiM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aC2FCI5Xybb3Ye1sP2Gm50H41uVGDga52VFMlwMJ8uiGFiKXJypEKXlkn5zr?=
 =?us-ascii?Q?LIKDbTOC2tfhc96RM0cuG3GBOswWadztDkmOnJKFTDUHMyjuXQMSUiaUgLS8?=
 =?us-ascii?Q?Rc4R6wVUgKBrORt+KcR6v+J1TP2pVf8i+f3Dlbcp6vNiCiilWPmP5V8jQqkO?=
 =?us-ascii?Q?JxJSN6Z6dddcNo5hBptWuAyxzKFDQyIKbrpmMgG8iJZ+IlbLNlc2Bh6WLLG/?=
 =?us-ascii?Q?nRijjoaTndrnGs50VJncnSuYEmx8i6GMVLfR4xYl9pjdW+kyExhMU3iR7uE9?=
 =?us-ascii?Q?bKywuaZ3b2vOqPhZuSfFzxuL6um/DTJ7uLxFA6jmMi3gbP2P6Ehv2736EZUi?=
 =?us-ascii?Q?5jtx80hMZBJaEg5Yi/1xDSKtwgs6SqUB3SLCkk+/2H/HA25gQpHoHEfAtkTR?=
 =?us-ascii?Q?xNyR4oQdB0ELnnN6rwWOYXEDIZNdPuvZk3SxoSjrDMJP4a2MBx/Daq2y0CJs?=
 =?us-ascii?Q?53oyQWXVOMeZLTFnepi1BUiPlAwSz0UbM52xQYLQooLdOP9+ITb3FZX7b0oW?=
 =?us-ascii?Q?qkSCQt7gri4nr7vmwgkbI0in1Zcr/JXczGcz2bzgV+V8xlrnfXMqkIsg35A+?=
 =?us-ascii?Q?xVFGdH4OyaRIFaCQrgtdPt0tJG288/ZyKoF+VqiDcuOnXm1rXuZ3y1cmBvBD?=
 =?us-ascii?Q?3CXAAOak2seVh2h9KP5AZ0pX5ZYAyDLKh1ZuleV1ASNCna0MEFAu8Veo03pc?=
 =?us-ascii?Q?t3K+tkTEqAmyDrtNDBIh9ErcQrZg8GjUVPnGCP+28Ssjch6/zuqiu7aVdQ9h?=
 =?us-ascii?Q?mDrfdlBLJMAMVMVRVOSo4Rp3kH1kX+llp20+UwPq+Fwkiw3VnmTlGrvw6eBr?=
 =?us-ascii?Q?4xd+rymtSxqXpvl2Tobg2Rs/aVC9bGsS295wzRFGeJ6+fqYDgnEVGJvSJyqm?=
 =?us-ascii?Q?X7dJGeb/Mzc4GzxNDBIcl05ZunDBVUhxkSwtglo/UpyES567m59cgmZVypXL?=
 =?us-ascii?Q?UFONJM1H3eKgIfdzzTt6un8Da9/q/vTaVITSz5eswzNMaPulcgDgIHAdts0N?=
 =?us-ascii?Q?s/Wlfq/n2DHc6sZX4zul8Nl/3iAXX4xUt2Z5QbvLpzTAtFgVffi8HUMuxaf2?=
 =?us-ascii?Q?9lDnsfQDxyS7DoF2V5vYz+t/6Hh87mgBA5pknvG9XwlyWWCPeyrzxGL5rma9?=
 =?us-ascii?Q?TwagYX4bPc2aUT50f1UW0Z1hnxOZbKRjPphG7gs7h1kgPBIaxDrkX+8RTy0E?=
 =?us-ascii?Q?15UJIvBMf7c3iLPO7so+lAJS1nASOhztAThleh5zaZLjVvCcsRiBJnhs/ZjP?=
 =?us-ascii?Q?goUKGaQGlfXT71P1ir3FSY1aQ/qRxwPmJLyXwfOCJbIYSWy0xwAD52gWQn0S?=
 =?us-ascii?Q?uFGkRllr2BM37QelSG8Om+EK?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33D6DC4152FB744E9B8E42B0DE1C753B@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA1PR01MB2555.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c77e38e5-606d-45dd-678e-08dd3972971e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 16:50:48.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9923

From: Aditya Garg <gargaditya08@live.com>

Before 6.13, random seed to the firmware was given based on the logic
whether the device had valid OTP or not, and such devices were found
mainly on the T2 and Apple Silicon Macs. In 6.13, the logic was changed,
and the device table was used for this purpose, so as to cover the special
case of BCM43752 chip.

During the transition, the device table for BCM4364 and BCM4355 Wi-Fi chips
which had valid OTP was not modified, thus breaking Wi-Fi on these devices.
This patch adds does the necessary changes, similar to the ones done for
other chips.

Fixes: ea11a89c3ac6 ("wifi: brcmfmac: add flag for random seed during firmw=
are download")
Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index e4395b1f8..d2caa80e9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2712,7 +2712,7 @@ static const struct pci_device_id brcmf_pcie_devid_ta=
ble[] =3D {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4350_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE_SUB(0x4355, BRCM_PCIE_VENDOR_ID_BROADCOM, 0x4355, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4354_RAW_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4355_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4355_DEVICE_ID, WCC_SEED),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4356_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43567_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43570_DEVICE_ID, WCC),
@@ -2723,7 +2723,7 @@ static const struct pci_device_id brcmf_pcie_devid_ta=
ble[] =3D {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_2G_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_5G_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43602_RAW_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4364_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4364_DEVICE_ID, WCC_SEED),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_2G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4365_5G_DEVICE_ID, BCA),
--=20
2.39.5 (Apple Git-154)


