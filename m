Return-Path: <linux-wireless+bounces-11339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F394FFA4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E997AB23304
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 08:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A6B18A94E;
	Tue, 13 Aug 2024 08:20:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2124.outbound.protection.outlook.com [40.107.117.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2698189BB7;
	Tue, 13 Aug 2024 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537242; cv=fail; b=u05qr6hSLuzXmqN0K5CPFkqETS3fFPkv2hMoTTY5ZfwH/n39Fa/YHNWuHn/Ale2R47N1Z/EoVoA6mY+OCN8QbH9bNaGRa2iu537uIdlKhBAR7Ef6CqyLb92J2w/qKkcPXWMrQcFjWEa5wyDwSpS5pCUR9fFp+BZeXTkyZFKISUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537242; c=relaxed/simple;
	bh=z/JMI1ioorJsC5rpgzgpHUYttwWsJh+gThzg/mM6S6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKAUgZ3UQDbo1zMikeHeIPx0cI0GGAT+8ktg7DDsZPCq/iMYZsHLAeGFobDFl6urSNnsUwLF2Iw3DfBULpHk0J98dCNnLa8CVvXLTSfNB72d3NkNDKGii3NsxLkGVhZJb1Z8SmNp+IDfv9IGvzT8C5azSM8Dkgu5QT0d+EL2Ojo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEfanvXXwafeOfAWxv3I3SonX5KgMZTfYDZiUEh7H5ttTUKlNGKxS+0VhuB2L52LF2JEdAfjeH+/JgpMjZOFUiH2fHcN/nqkIHeA/tV70EQrMahlyZuFO47xwkHAU3ZGU5vrKDdvtNhDFmOUo3OrakteS3dXHb6c7TMSrQuECrJWY0ythKlXaTPa8nNp60oQ6XD0JevbbRTCi7GsFWkLev0MPQ/vZh0/ki5keO0fcI5319RKGE3KFcUYXg3NluecYmm/KPLx/Ztii1KekNoJA2M9vIYyR9J25Ngs7L9kf84scXW1wyGi37l8i+vt4T9VKgUcPnAkHgebQfG606ZAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWqN2d2WV5H3rjNNY/SuBA/Is/G4XlfllfCP+MEOJRA=;
 b=MRyxElc6Z7kfLutIJk9revrFg3wXcasGZd0RDKGDluVMT8LJV4UVYWb5KpyzKJNZ6qK8MsUDsx2z7R7XUp2IR01aFohFoLOUylW03rhqn2i9mR3hKsETfCojark3oTn5LCm+kCTznZV0eO/pBEE/2nR45ja8uDuTYqQ6+U+y8Bxd7NWcuJf9qC3H5YRncWP30ZQwsFPW1wy2LajrzRCIyds9GYFjNuslSS4pEs57n7P3vr6eiSD+1RfK2oLqYKRYrAwnhyoJPV8FfcbzuAMVkqET91L0JqSwSFizNyoBZ/9ELztiR/jBjOQRHvUZyviY22PZxyJ20N1XenWaKuqbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB8198.apcprd03.prod.outlook.com (2603:1096:405:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 08:20:36 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 08:20:36 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	megi@xff.cz,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v10 5/5] wifi: brcmfmac: add flag for random seed during firmware download
Date: Tue, 13 Aug 2024 16:20:07 +0800
Message-Id: <20240813082007.2625841-6-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813082007.2625841-1-jacobe.zang@wesion.com>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TY0PR03MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3fca04-3fa3-466e-0fc6-08dcbb70cf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mhJKwADc7s0WlA1fwjFYvmet66CbmFXvcEHVcVImEk2xjMfbmccDQeaIiYp4?=
 =?us-ascii?Q?1ZdcV5XSLAGlw62nadBQ+YFmBVzqeuxsCLcAkx1v/BR6ZDBi41zwYcTr3Hvs?=
 =?us-ascii?Q?nB2qag1bJ6InHv8ivr3rSNlvHvAH5apLs3p5039mOZ937Jft0BPW3Ds1hQnO?=
 =?us-ascii?Q?rn4WympIu+3j5KdY0H1gP5tNZSrhj7Dx+B9AVotWj7X/GZ/KgTDuXbXijA2S?=
 =?us-ascii?Q?4r4+9jYxExjUuZvH5rKRXD2bwbTacWZfSN9Z4yXuUg2ggndYbT6gi2GoL9Si?=
 =?us-ascii?Q?HsNbawnQsv3YqNAc1wSxSRuBXt+14TZLrrmLkVTkLFJSY0xnoAt8Ia9+XqhO?=
 =?us-ascii?Q?wW13m5EgSeRwbWsL+DcijSaDsP8ZcThvhGEFqBhLzLFKoNbjc+W4ekGXcyX9?=
 =?us-ascii?Q?oM6glk6yhBB35LgZSSpRHAve0ARdFCUeA/wwJUN66ZH1SHeiTFAjHaDPsxF5?=
 =?us-ascii?Q?IKKq01vGavCEBpnwf6N6huknjMTpEMnWWK2D2tBT5cfvRisKlUwP6JTvzMG4?=
 =?us-ascii?Q?mBJYKnKKsFzRqfD301W+wdG40FwgRwW3Cj7jvrTnHFuwb+8EYwr4ep6CCNEi?=
 =?us-ascii?Q?+tiA4kGP+eo+ete4BIOulH/JGuIg/RjBDLPZz87QriWFFAfBsSGIO/NX0DrA?=
 =?us-ascii?Q?seGzNJAsbak9gD795oXzhUHVBOUWh7TpuGJahY0wknuy+Gzwn8b3Po3+GkKl?=
 =?us-ascii?Q?Ld4hPhKBeGXX3prhlMe1VQr6e35guIb2kcpPC3ppVCbelAJwTmkMHisWSV/m?=
 =?us-ascii?Q?UoCc1281Y6VwGGqIVWubeLqs4Pbgi/ukVkVQ+Jzqe0kbgKqiC2FFI6c1ShLH?=
 =?us-ascii?Q?pwvPkQZ469Xv21XEM3k0pQXBx+NH97O8iU6QjniZyVrrbfnNTYqd18VXL5t9?=
 =?us-ascii?Q?TllMnsHtwjSKolCLwkFvmXUKcOPpFcfq+czJNxfPRgweu81jjPI+0e6tFM2B?=
 =?us-ascii?Q?J5Y2FgoZGuyxlba4auxHI+W4EYi7qZrr/LZYOlbtPVIGLsAbleNVnncul1i2?=
 =?us-ascii?Q?CkPEbNSgHg56RzGdlZnJ87ESit4l3n4hkASbXF+1hIXV0q01EB0VuXYQ7mXz?=
 =?us-ascii?Q?Wyg0Qh6qw1chKmFGBq7zP24UhUDk0HsWKYeVQtOZCgALjTLrsgdE4QiPRXsT?=
 =?us-ascii?Q?NetBQKedK/ScSB3ZfAmqcvyUk7PEOB7Y9jncwXA74YvdoJQjlDxW8ZUoa6X5?=
 =?us-ascii?Q?L3ClXC3OdKZ+Su5zVEGVBMSlO07OPNGA61u5QdpyYHYCCCY42z17yN6SipTZ?=
 =?us-ascii?Q?ltQwkoclsFkw9j/f2uUooiAO7nB1d8Iq0suRUqkfn6YraIh0KiaKK5httkG6?=
 =?us-ascii?Q?F1U6Zm4RvRloTwgrLFDh+y+gDo6cw/Kvoa1yogmeI6GyVnrqGIeeEGAM8LGH?=
 =?us-ascii?Q?sqXS50w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pAaIpsX8MDBxfJd1w4k05ZwROQiiFkz6OBajOfqYl1/DyHR8UeUBlUdMLTRz?=
 =?us-ascii?Q?S/sWUzjIOtajK+MkRhZ1Nv2Hb9jl+FyHseCBgfiLu2WvwbwqgrsCD7HmqNxW?=
 =?us-ascii?Q?pm0jgCBj3TO9ef9Zl57eunh4/PpTJc5TKbQMYjJISbFUJ/EcFOWoXbTeOx1+?=
 =?us-ascii?Q?4rZ6fhAJRec8680rkP37pKhLnyxoXbx20uSrLiuml8u8n040bX6ihs56n5bN?=
 =?us-ascii?Q?NyYhCZHblNCtnXl14eD2hViFWK4WJFyEJNiCY1PYjmQnfvqtqrZxwwPdJtet?=
 =?us-ascii?Q?OAzyXfc2rTFlZCAq3A9+otYi8jDPYSqQ6MpLBGUqeVAjzIHDK8W/U4FSn18z?=
 =?us-ascii?Q?4+Wq8fofiH02hoxaJo60F1rdBEdGyJvWGNe70YHL4Fu+aLOhFnILq511sRrR?=
 =?us-ascii?Q?X9lxB0mBHvejfG1y3dhRKE1xPm45gKqxNxxDWveEMSmE93WgYOH7vD0gg9gv?=
 =?us-ascii?Q?FAeKrVMhp2pg07aHtf7Ak6wkMhnREbRCCQK1HbXLos90YwMABHKJn6JoTuXB?=
 =?us-ascii?Q?StttsxaiYGQhQTwle3DAXJ5Y0aJBchmVLB4+Ir2MuqzS3BQ0Ya597tTqJM3t?=
 =?us-ascii?Q?aEl8V8JfBI2MO5KTLC7wJi+t51hF+vS1Cftx/dhmalmGsY5e3zNxPcJ5unI5?=
 =?us-ascii?Q?0f/ejmQ7eR4WoHU2DS5x2LTdvqZQmZ28N5Y2HxfRcpvmEIWrnFh04ZXTiGkm?=
 =?us-ascii?Q?emvz8JaB5g5P+NFDe+PQHG2q3C8M75IHeX1gAP1C3uGw/G32Jo9tCUkZXch+?=
 =?us-ascii?Q?ae8KqXrrfORGQJPUrTGbFon9mUs9qfdksG6WAe0zOT9IHOKUhRRmcFGPsDOJ?=
 =?us-ascii?Q?8tMArBz2t4VcYCP1qB7nffENNiYJMgkKUxbQWzWsZsl5x9mRxr/RGdQFqPVX?=
 =?us-ascii?Q?BY4WcJagQ5LIMMiXhVJEv9+6iTRuhT5PBq23VP3DQN3ZqVsl8svtwdBmmjYx?=
 =?us-ascii?Q?u4bN2KUNHxaBt9vOk34QZTJHYVJUX1g9AMhhUZ+FpqPBaNLBoJxPmYimRSev?=
 =?us-ascii?Q?WuO6JHs8QVyH+egHJH9RcO8kGoKqJzr457M6SpzUaKnsTF21f6eUaB2AAl2e?=
 =?us-ascii?Q?kjkB75/0QyQa0GaWCpMo4MptOlt7BqBnao4yZRvU3MfPVGjtzfIy54VAgDrg?=
 =?us-ascii?Q?/+KppciW7EnFmn5d8WLDqoz4n0H4QUIP7ZBjLJ5h/YtYmIRykBi2D8e03okd?=
 =?us-ascii?Q?JRVntuvjSPknGzR0kSNnTAY63uzrv8f5fJsY2H+Sv4I28wSiX2DSm8xjeL8i?=
 =?us-ascii?Q?CRPSVZKhhOQtvX9Ld6Wz0Th+mCYb+ZUKzWbgS92JQ2nGlV9YatoZ4E+cLVpG?=
 =?us-ascii?Q?45edPzAGTQLJlh+LoZIkXuI9tYHQrohnUdbU8Z5H6kr1ULqXP2mPOTzRKxZP?=
 =?us-ascii?Q?xsWKxRC7oVbQgMjuyFR4WKVpFD/0hdE4mWu8lY9fQLCGVyeZrIsjkfGcWdE7?=
 =?us-ascii?Q?vshgJZ2F8a8fOXT43uf6caejMlAjBrctulnL68HckDNBSZIqlXsIniSs0GQP?=
 =?us-ascii?Q?5z3j7mA83S5yWsItNnJSZRUyaVbTiT9zo8pljGnvqJlgNeeAFpdcd8HA1KtB?=
 =?us-ascii?Q?bye/r6Xlq40BxWQnCXDLFYdDHUjPCP6sy9ClUtzn?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3fca04-3fa3-466e-0fc6-08dcbb70cf30
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:20:36.8388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9J5kkelgHudKCKdSb2ne4yebNd4Dy3LSJtDYWOtuppjEON7hJkry7KcqBNeZeJFyz+6BJhZDuAO0s6Tky6vwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8198

Providing the random seed to firmware was tied to the fact that the
device has a valid OTP, which worked for some Apple chips. However,
it turns out the BCM43752 device also needs the random seed in order
to get firmware running. Suspect it is simply tied to the firmware
branch used for the device. Introducing a mechanism to allow setting
it for a device through the device table.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 52 ++++++++++++++++---
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index c34405a6d38b8..e88fa4cd62a1d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
+BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
 BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
 BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
 BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
@@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
@@ -358,6 +360,7 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+	bool fwseed;
 #ifdef DEBUG
 	u32 console_interval;
 	bool console_active;
@@ -1720,14 +1723,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
-		if (devinfo->otp.valid) {
+		if (devinfo->fwseed) {
 			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
 			struct brcmf_random_seed_footer footer = {
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
 
-			/* Some Apple chips/firmwares expect a buffer of random
+			/* Some chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
 			 */
 			brcmf_dbg(PCIE, "Download random seed\n");
@@ -2399,6 +2402,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 }
 #endif
 
+struct brcmf_pcie_drvdata {
+	enum brcmf_fwvendor vendor;
+	bool fw_seed;
+};
+
+enum {
+	BRCMF_DRVDATA_CYW,
+	BRCMF_DRVDATA_BCA,
+	BRCMF_DRVDATA_WCC,
+	BRCMF_DRVDATA_WCC_SEED,
+};
+
+static const struct brcmf_pcie_drvdata drvdata[] = {
+	[BRCMF_DRVDATA_CYW] = {
+		.vendor = BRCMF_FWVENDOR_CYW,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_BCA] = {
+		.vendor = BRCMF_FWVENDOR_BCA,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC_SEED] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = true,
+	},
+};
+
 /* Forward declaration for pci_match_id() call */
 static const struct pci_device_id brcmf_pcie_devid_table[];
 
@@ -2480,9 +2514,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
-	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
+	bus->fwvid = drvdata[id->driver_data].vendor;
+	devinfo->fwseed = drvdata[id->driver_data].fw_seed;
 	dev_set_drvdata(&pdev->dev, bus);
 
 	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
@@ -2668,14 +2703,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		PCI_ANY_ID, PCI_ANY_ID, \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		(subvend), (subdev), \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
@@ -2703,9 +2738,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
 
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 44684bf1b9acc..c1e22c589d85e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,6 +52,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_43752_CHIP_ID		43752
 #define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
 #define BRCM_CC_4387_CHIP_ID		0x4387
@@ -94,6 +95,7 @@
 #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
 #define BRCM_PCIE_43596_DEVICE_ID	0x4415
+#define BRCM_PCIE_43752_DEVICE_ID	0x449d
 #define BRCM_PCIE_4377_DEVICE_ID	0x4488
 #define BRCM_PCIE_4378_DEVICE_ID	0x4425
 #define BRCM_PCIE_4387_DEVICE_ID	0x4433
-- 
2.34.1


