Return-Path: <linux-wireless+bounces-11507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC237953F50
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 04:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F11B25493
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211557CA7;
	Fri, 16 Aug 2024 02:07:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D947DA64;
	Fri, 16 Aug 2024 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774022; cv=fail; b=oXd8tN6tGcuGHyy712CN3IqK7vDJe4Zvmz/AQPwn/Hn2DKqT7dwoI7qSE1txHwkuHX7CZTj1ahq/A/JK3dZc5u+t/n+ckW7ZUN2/LwmnLL0GIEGKldL7dSXkcfvIuHp2UrX8SkohPZOTT7jec0XzQgKrIkdzOgz4FPKhuMbr8wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774022; c=relaxed/simple;
	bh=BqbQOwwYDw5/7P+wXqeJ1Sr17ivASmsIDzY5VFLbi5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRO4/T6w6Lzalg9p9lrUnnoDlbHsQk0/4U9UjM4vOx96AE4rCTLWSKx+t+YbGqMpDj1Zo4c1HlNoywOJOLA4Jk5hDr4ruSTMNUs/tgA4dhG8TR7BuGWywjOYij5IhmlqST5xytw3aLhiHIk1+/le0/hPWkQgvx/BfRFtqAXzvT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnBnAiHY/3HfX1evdMmM9OAU/pkmcxIpMbqusOgeVTlXdSVnLCrWZuUGu9dISHnmx459Q0cot2+OUgBWtdcotUgkAhR98g2LpFQ0hMehPFhvsiPRUy2lwNVf939mC54NniJsr4SPBp35T07x++VFniDxaNqoKe+lF2Y/hqGA9Tap4so48K8u1AfL36REY6LDEQCk2foD9SL8tWDZSTYJ8UeMZVo5LnS9ZzbO20PacX9lqxYvjFLBvMl7qutuOX0Qqf2d3MiAcAWdQx7qRXXfJkUFtQCN6xNX+7Tu3xbnbWhH9P0Dp0bOE4LX/W/VBGnFrkHUYdiJUXkOULeIvM3H4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPnvZm+FRad2ukpz6C2NIKwXiB1oULTjmbAvSb1O8AA=;
 b=WUj5WvarYKx50+58KEv0H5eMsWIV4dQa0aiDWIqRMPJ7D9gwsz813OUI1i603sf7X+CXIkG8Ak9z7jbx9wi5xuZARTJDwiOThrT6lbksBmRuxOi2S91lyIc4mPwzXFnjSui8/54D+cK3hUhYBjQ1HPmRjW8QZOLqP0z2bZ0DqciD6383/l+7GDqH/Lfqbv/MuT3iwhl4LXn0yYelfP32rB7i1Qq9HGQDBU+Hpiy4cNFFe1Cbhip4nign7UixYG5aVe4XpAEE54/rzfEHiCbjGNJPWqfouiWiuI0pfw5khkk6nyZdPNddZbXPqAxLFBmA4ocJ1ttKZRXOku4Ic3QBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7444.apcprd03.prod.outlook.com (2603:1096:101:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 02:06:57 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 02:06:57 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	saikrishnag@marvell.com,
	megi@xff.cz,
	bhelgaas@google.com,
	duoming@zju.edu.cn,
	minipli@grsecurity.net,
	yajun.deng@linux.dev,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	christophe.jaillet@wanadoo.fr,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v11 3/4] wifi: brcmfmac: Add optional lpo clock enable support
Date: Fri, 16 Aug 2024 10:06:34 +0800
Message-Id: <20240816020635.1273911-4-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816020635.1273911-1-jacobe.zang@wesion.com>
References: <20240816020635.1273911-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c07a08-05b5-4c57-d06c-08dcbd981b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NGRyFr4tMK382zkcp+U5JY/JeEAAw0VPOAo96Sw7hPmDrWpuqyt6ov/Pjh74?=
 =?us-ascii?Q?HA3WUXBfI9rDb/xh0rWUqK5LQUCVkTLN6suqWhwV9QwqgH63tOrO3hzHpMCZ?=
 =?us-ascii?Q?l8k9DKwUARsP1UPsLnkoiJ+9BYnEm305Y/1k9JkdLZS5Ny9cygMLhBi22LMI?=
 =?us-ascii?Q?1ePq91t6HG6XtfrEFvPA5xOl+/+GL/DfeVReaZ3mXfFVDqZ4LPPqVJkqEzOc?=
 =?us-ascii?Q?JP9eOkx6FcsCrKYye1CnBv+mN5lcS/VH8kDAaCVGxeg0ilB+ErIdrJ5Uw07w?=
 =?us-ascii?Q?0pOIxHdtpKsfuDj/N7rjPsrpajur/ylJu1jrWeY7zQmXcWX4bKWTqGn7QK2i?=
 =?us-ascii?Q?RBYE+9nFVp+lvfrIcCMx4IFyGiZ9FxuMVktQ82bMDGREGjoDchlSdol1N4p5?=
 =?us-ascii?Q?5GpcG/a47GOepVSRb6p6py4KPOtxtzcLwhJGvchC7/b8wjja7qzu/WeEGRem?=
 =?us-ascii?Q?Stixl3SpyhKS92tvA4rqcMFEsIFi9ZofFfFhDdJZUKXg5+qdajHrc3G2xi9O?=
 =?us-ascii?Q?1yvV7UtUm+pc8iDtmxGJ+/jhnQWo9yVvLAwpmqaF2MyLDPBez6qmTy0hPVHM?=
 =?us-ascii?Q?lKtVHHxlGh8UncxSXEwT1Tx8XgJ5hhYKAPrJ/U2KyN9Rwhtu8vXJ0wWT4C+p?=
 =?us-ascii?Q?UOY+y2uQpCEuviosLmYzvPE18s6e1+vcMWicQ+ZVySJy2zpBaNcKlG+AyGLf?=
 =?us-ascii?Q?xPvyVkgWLwzUoXKRL37FMLjaw3e0RiVPTl7rmGwlNm7Uqk+zDVFTww6F5ltN?=
 =?us-ascii?Q?QA4iCzJUIgpH30oplCacYi8m5Z56DK9AsctunDnhpJoDmU0J7QV3bop/Fbz4?=
 =?us-ascii?Q?Ped5gCVHzo7VsfaTelgypcEuIgm+vMaFVkHV2Fv3M5AACOsIROkiYxmHDPh0?=
 =?us-ascii?Q?QtQQ4EtlPYIToNR84oZRawjfrcurwqQ3e4EFLmRW9MbGQmmVTV2RsQtD7n1K?=
 =?us-ascii?Q?chRMcaMOfvmKSIqfWIw6CL9gVsUzZN8IHQ8pysuvxGowmEU4dFmHwpWqBgxQ?=
 =?us-ascii?Q?j2MfdktU5ue12pXndEcySLPrK5mGrWob635iK2HeTPDzm9lukPiWPq0H954u?=
 =?us-ascii?Q?S7S8kOEYGR+ZUxzMzwvCeLWUrVtGUOuaTrT0XkghNSr3KgLYjaTVgZvZJ3GU?=
 =?us-ascii?Q?99fAQuAxfFoaVUY/Y1i+jQ7gcIefg/41Hu3DjWEsbmC3p7acQx5hQVtan26B?=
 =?us-ascii?Q?/laxVB++3b4yZiEklRpfvq6uaeMvql9Wcm/2uY4S1Jp6T/gsqI78rdzrXwet?=
 =?us-ascii?Q?McSaCei0/4/EKButVcF5WND/YEFUKkkgwPe4nXYCfrYxGQ5XNHrH2CV0awfv?=
 =?us-ascii?Q?1XsdCREeygR1iayt1RddsCn5QuHckSvjR5cWQM5+1+OMzipUgT+8/MSrO+Wk?=
 =?us-ascii?Q?LnpzY/NooWYQ9sPLuvaSBp5y11UGpoP/eOjXsnUo4y3B9MMFsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OYligwI1ozFul/r3GXVBarJ+UaG3tIpeL1KDI2g0cT/UYvVDe0svWz+xHSOc?=
 =?us-ascii?Q?E53z6p4wf5kXSa4Aw+FR96L13W6llqiX6k1JopkkH1UlAfSl0kRjZmdgvZ0x?=
 =?us-ascii?Q?2sCOMSJ3t9qWrbY6P7BWu+PeDHJDLvg9ovsFLKu8bbswxJ4QSFHy+1dwfAR4?=
 =?us-ascii?Q?y5kw1/VitMrXADq5O9XQ1WONjGpxtWlCRxJmMrXD4jJbj7CTnCgyv6ulvnca?=
 =?us-ascii?Q?PbGXwVBFKZttxND5/eZWhFLBRHR9Vg6lk2je9mb22ECy920sUV9zBZOTptH1?=
 =?us-ascii?Q?IO970sjVCI//4BV0E3917dZX2bMJIOlTcxmpNvvt774VOq2AlYFL3LpXaZGq?=
 =?us-ascii?Q?HOUReZAhuBBEyF29pUWK0+8LTLeG66jS1HJ/WPbof3X5oJOn82jKXLWh6f9Z?=
 =?us-ascii?Q?n0UgcnNeQ8151RiApOEROSV/O80hu0X5X6YJtdOFy3KJxyr1Vng0nyjj+5hD?=
 =?us-ascii?Q?ZKk9iYaTu16zt+MQv7CFi0hS51/gD3h4AyXralq9vYs1uDYxKdXgvfkVqulz?=
 =?us-ascii?Q?HUSx+Hz5LjfroiePjDuem/h+1q9xObk61BApBU81qZNJ/WGapiEGOESOZ/h0?=
 =?us-ascii?Q?gRqh8AZ96vztTn8ZWquZdvVCdEU8KmeTMAe5YMnVnz6/Oe1ezNTLDu1V4Z7I?=
 =?us-ascii?Q?mM8LRwdKYux0Mvt6Rm4T5f+sRYQf5RdA4CoVAjMJ5m5zg7+FCsZ5g7iDvvo7?=
 =?us-ascii?Q?kGZKq9x7qZ9kMmc2WmKynYLy+SDkDviEKo/zKp9CrixUQEw+pRH/NDh8GA29?=
 =?us-ascii?Q?ikvIOexydlFQm5xdo4IGV0T4nZV06TaiXZOwBuQLMiPPhkYwJUm/+Vu4Ho+V?=
 =?us-ascii?Q?MtoEDtZG3PRyCXEtHOSgXQ66rPMwpqU1+fzj2XB+KLvLTwes97srJN4cbay/?=
 =?us-ascii?Q?5sYE62ugOne3J9zsb2LfndQvh4f1j5oZRR3U0fygW2t9hsKOvZEELXFb/3n1?=
 =?us-ascii?Q?FRBWmLkSBG/5AKXDCP+kXMORFbvb+vtlRifaAFVleno+Wlxq+7OfHDnnNuy6?=
 =?us-ascii?Q?dyc34zzA+iZR9vdL6CGiz1/vPcn3POwREWBLQLSvA1YefKUjN8vj8tDohBry?=
 =?us-ascii?Q?pLzGr4fP8mJX5eqolwJ3EMmhiQbJ6JO1auDHJV5H+DdbWGD5sIJ6UGSzM5GW?=
 =?us-ascii?Q?UdaK0BLyN8AA06xUphqTBnDFs/LGWBkWYR54/kX4pDH37oIwG9zSlKm5uHKi?=
 =?us-ascii?Q?Llzy/JPqbfs9jNoUJvG+uocRWjjgNsPpJKvmAd8VEHuF4e/Jo1+yIblV5a19?=
 =?us-ascii?Q?lZFTLm0Hv2JE40tbG8zEebh1mDHEA3tUDCzKbNnsVNIa+CDUnx/jpHYE17Lz?=
 =?us-ascii?Q?2kpf/fNXpkXQHx6JgRurXffJjQecXNk/sX/UXiUVg5BEJEvOJbSENajpSyf6?=
 =?us-ascii?Q?W0HPykuRJ14EddHzhG54lDS7Y2rOZ0Wlb+3EziCF9MvtwXRn6nNI2PR2zpYe?=
 =?us-ascii?Q?4q5IKjBzUbi1Pe7JG4qCakPSDJONv7yYlckK0HCHZNpu76VWVYMFQ0CNOPs0?=
 =?us-ascii?Q?ehJs/LmjGv4HEMyaOcaa5vZ3YjsOTJUBVyVmvYbwKU7tERS0oRobKKcJ9hBm?=
 =?us-ascii?Q?7MZ1QpvSnO2yqCGWcXAh5OOytAN9R8NUsdPlXrX9?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c07a08-05b5-4c57-d06c-08dcbd981b48
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:06:57.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSMaZXD3AMO2SA62qEyvkbS4eV4ObmtQie13E3QN4s3KqNlOQ4qftwxs9F8miVAXb8rGwWhCfwIc2uw0ur4oXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7444

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe. Change function prototypes from void
to int and add appropriate errno's for return values that will be
send to bus when error occurred.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +--
 .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 29 +++++++++++++------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +++---
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++++++-----
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
 7 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 13391c2d82aae..b2ede4e579c5c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* try to attach to the target device */
 	sdiodev->bus = brcmf_sdio_probe(sdiodev);
-	if (!sdiodev->bus) {
-		ret = -ENODEV;
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
 		goto out;
 	}
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..58d50918dd177 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,7 +561,8 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		brcmf_of_probe(dev, bus_type, settings);
+		if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
 		brcmf_acpi_probe(dev, bus_type, settings);
 	}
 	return settings;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a62..5a66d64919209 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct device *dev,
 	return 0;
 }
 
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings)
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
 	u32 irqf;
 	u32 val;
 
+	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
+		return 0;
+
 	/* Apple ARM64 platforms have their own idea of board type, passed in
 	 * via the device tree. They also have an antenna SKU parameter
 	 */
@@ -105,7 +110,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return 0;
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
-
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);
 
 	of_get_mac_address(np, settings->mac);
 
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
+	clk_set_rate(clk, 32768);
+
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+		return 0;
 
 	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
 	if (!of_property_present(np, "interrupts"))
-		return;
+		return 0;
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		brcmf_err("interrupt could not be mapped\n");
-		return;
+		return 0;
 	}
 	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
 	sdio->oob_irq_supported = true;
 	sdio->oob_irq_nr = irq;
 	sdio->oob_irq_flags = irqf;
+
+	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
index 10bf52253337e..ae124c73fc3b7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
@@ -3,11 +3,12 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 #ifdef CONFIG_OF
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings);
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings);
 #else
-static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-			   struct brcmf_mp_device *settings)
+static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+			  struct brcmf_mp_device *settings)
 {
+	return 0;
 }
 #endif /* CONFIG_OF */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 06698a714b523..c34405a6d38b8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2457,6 +2457,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 6b38d9de71af6..462fc669b959c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3943,7 +3943,7 @@ static const struct brcmf_buscore_ops brcmf_sdio_buscore_ops = {
 	.write32 = brcmf_sdio_buscore_write32,
 };
 
-static bool
+static int
 brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 {
 	struct brcmf_sdio_dev *sdiodev;
@@ -3953,6 +3953,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	u32 reg_val;
 	u32 drivestrength;
 	u32 enum_base;
+	int ret = -EBADE;
 
 	sdiodev = bus->sdiodev;
 	sdio_claim_host(sdiodev->func1);
@@ -4001,8 +4002,9 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 						   BRCMF_BUSTYPE_SDIO,
 						   bus->ci->chip,
 						   bus->ci->chiprev);
-	if (!sdiodev->settings) {
+	if (IS_ERR_OR_NULL(sdiodev->settings)) {
 		brcmf_err("Failed to get device parameters\n");
+		ret = PTR_ERR_OR_ZERO(sdiodev->settings);
 		goto fail;
 	}
 	/* platform specific configuration:
@@ -4071,7 +4073,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	/* allocate header buffer */
 	bus->hdrbuf = kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
 	if (!bus->hdrbuf)
-		return false;
+		return -ENOMEM;
 	/* Locate an appropriately-aligned portion of hdrbuf */
 	bus->rxhdr = (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
 				    bus->head_align);
@@ -4082,11 +4084,11 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	if (bus->poll)
 		bus->pollrate = 1;
 
-	return true;
+	return 0;
 
 fail:
 	sdio_release_host(sdiodev->func1);
-	return false;
+	return ret;
 }
 
 static int
@@ -4451,8 +4453,10 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* Allocate private bus interface state */
 	bus = kzalloc(sizeof(struct brcmf_sdio), GFP_ATOMIC);
-	if (!bus)
+	if (!bus) {
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
@@ -4467,6 +4471,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 				     dev_name(&sdiodev->func1->dev));
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
+		ret = -ENOMEM;
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
@@ -4474,7 +4479,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	ret = brcmf_sdio_probe_attach(bus);
+	if (ret < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
 		goto fail;
 	}
@@ -4546,7 +4552,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 9a105e6debe1f..f7db46ae44906 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	if (!brcmf_usb_dlneeded(devinfo)) {
 		ret = brcmf_alloc(devinfo->dev, devinfo->settings);
-- 
2.34.1


