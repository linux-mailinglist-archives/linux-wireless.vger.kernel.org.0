Return-Path: <linux-wireless+bounces-9486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C629144AB
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 10:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45881C22048
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056A1304B0;
	Mon, 24 Jun 2024 08:24:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08E4AECE;
	Mon, 24 Jun 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217464; cv=fail; b=I6f/nEegv40kX8QCqeZd9D7TV+CCAGealjkW/ID0tYyrshqkXAkWjrsGcmSGW0EyOZmPY2JjPn9mnOsp0GpqR8nqWsMMaj4gfoUP9G5xpg004mTmGW11pjYhV2ZmdlYoz6jcNskRQ/yYoHl8VzhuQ8QEWpMBluK/i/iRXnBKQ5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217464; c=relaxed/simple;
	bh=zCaJ/XpOaJn7Eb4L5mVmG0pEaANRjFksDhUP1yLCRvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PxyGY+ASgrw8C++hlAaX404A1+aJ9Zz69HEFy2UNgPV2WUrd54YnIept88cRUD9zooQnWg1+6oeavax6vySmsXgiUPTg1Y7RrDAVE+GgOnwNDM301Mf0XQPbTCCY8rTiNYQnMZInEYYTVKMyBU88M7shw15TsexHkafqx+x0Y2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn7YPeYUK5E4t1gT9XcA5PoygykNZTDqj6EMGj0ZnkAaRIKFnnzqNY1ar19G2IYHCCnercmdy8V8PgPbHO2uZEX65HSLMrREm3oLs8TbR1J5ArpkzlVJ0jgk6T4ilMkxrelnXcaYE7AmIhh8PbGaRO5irucMXphVklgcSUj13oHaKmVpU/Tlpky1S9HnAT1xro9WxW9krm7D4iA6fZtEjyMjjMH2YX+wYjAxsSnh9kaRXvW0TOIJnKT3QbH4Xow3wVtYV9F28mFGxr77H2c2Yt25DHUFC1IgT95xYzH2M7Emr+qS7LiwCZwcbD5NSP5BUgAUw0OAdymuAptEM6P6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9trhTuPRCq9gQO7cQvzRswHrFojwncCECe2MITkmqU=;
 b=GSZSUSDVPK6Si7cMQ4hcBMoX67nz2BQaaNSUpc8ajH5CXPo5tQay+ugRpirqHnhB4mHd9deqijOKaDpigZuXH5Rp71tNSEstRUUCf3H/UyZz6/zrt+ys2YFTXuBR/1cl7WWRekGM+fW8opGq5uloshEpWvatgQ1Aa2mhsNaZX0Gc598fwhZ3EBfScpBczadN6Pu1n/mgdQl8qPQirKTWZVhx9kBD6K4QeNjYohbcp4qmOdrIqc2u/dv23qe6gF853WGuf0eHBYxBwH3OXKwPNMx5K27RPzh2uHmqEFHJb/eIvuksBucyuUd5gAEKwhvYcu/FPTZkMhMqyUxUVIpUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by OSQPR03MB8600.apcprd03.prod.outlook.com (2603:1096:604:290::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 24 Jun
 2024 08:24:21 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:24:21 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com
Cc: kvalo@kernel.org,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	megi@xff.cz,
	robh@kernel.org,
	efectn@protonmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nick@khadas.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v2 5/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Mon, 24 Jun 2024 16:19:06 +0800
Message-Id: <20240624081906.1399447-6-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624081906.1399447-1-jacobe.zang@wesion.com>
References: <20240624081906.1399447-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|OSQPR03MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 946c6577-dc06-465d-b7c3-08dc94270c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vBz2ntisGOAWjirzlr5/y2QXpRZsROKRE8hBkOFgn4Ieh7UmWmI+KWaWcqTR?=
 =?us-ascii?Q?ZMv5Ao+0XFuH2nWqfmEW6JdpEq5wQPFEI0q9ylvU0yMTNUjVdNUH/+WMV9H4?=
 =?us-ascii?Q?w0Na7VkCQBkY1m2vdw2Bwh8vgUxxDS/VRqV5cx9p8oCghO9Z81OHOsxBRCIr?=
 =?us-ascii?Q?njS5IXFf9SjAyGNyrMiMPU4oWsPOLnx8pcjT4pZ+e3pch7HI9YyAitHFsXD2?=
 =?us-ascii?Q?Z9yDCXScSrqfkrj+zrVr5kf3l9+Q7g3aybHol0k0nSVACmu+sFnZLPqGYHD2?=
 =?us-ascii?Q?0DIOR2MXG56epZHpGWdOkHFkVhTc/1b8fNIt7fM76TtOsxG3QvfcBUfDwcxk?=
 =?us-ascii?Q?pKX5Is+du84u2iAW4O5S+OjOxd7oN8r5NaE9qF0e5HrGQ8JFkW2wT0y90BQa?=
 =?us-ascii?Q?4/NfFEc/mD6qBy4Yx/r1mBEQSEj5iERFXynQoX1ZQ17iE62SdkePlGV8Pc4J?=
 =?us-ascii?Q?FicYODfBKJ4JhW7dJYfq/btR3p20veG4HVFEJEtc78Obx/lrv6miGOHYRN5d?=
 =?us-ascii?Q?nuSyV0KnZTridbwKlW9wdP0BSeqmOjG4VaKCyrBzbqPzMN9tloFjGqTxm6Hu?=
 =?us-ascii?Q?O3jb21rQaJCeWdgxWk6GFF81ar0FYH+6LpSbUb2RBO19uhqfr79v3q1YL3Ey?=
 =?us-ascii?Q?zO+d8Ch4MBr0xE8WUaUuya5noDh3laA/ZFH/rWI12kDya/fjaT9KWOdCRN1j?=
 =?us-ascii?Q?tJloafh0DZccBzllN/Z8TERttVi5dhrXSynTslnHNGhRazh+WoiLDswOwTy/?=
 =?us-ascii?Q?+VSvWfsmlUjQu2iZ5F6OfGVZTHKDp61EhWZTNuL24kzfNULTI4WBKdZcst13?=
 =?us-ascii?Q?unrkV+2sFNNQ4JYUYByrKJOB/gpfMpSGebMMRPpT+q9ooUhmsgw6IDEnFIsT?=
 =?us-ascii?Q?aRcUeThJGpBBH97Ugec5tnmL95oc5xkoz0zfuRWLlHBCi/1TujgsJK2w72HP?=
 =?us-ascii?Q?0bHVNCWu4JJJrGZzxG4/qVmOZNGLDlhRDnnc+BMO4uqA9pikyE6/vbRpY7/e?=
 =?us-ascii?Q?O/7Ik4EztYSKYZpGyZiS99dP8u6mfu43Rz/Udl54h3OpZIMXsC11tJucmczU?=
 =?us-ascii?Q?Pw9mCS6Ukfz1LWOPvtDTG5uJImGQsqbiizC+uY/r9kVuFSVi/XkDARBZQIcA?=
 =?us-ascii?Q?zS3ceKY4YbcFGonZJTHIC++wiQ4BUqj4ib6a4gqBSIWs185K247bjUBi+Vna?=
 =?us-ascii?Q?qxNWiP0oXBGF+xtrWnlWBCkg/VTT+qEANwtJhuPzGPCCjjcAUiabqsJvFYNL?=
 =?us-ascii?Q?K/ofOY0QLOxP0m9qwZwcytMYhLxJnvobRoMGzUOvwZO3HUAzDmz5ry2WQ1nz?=
 =?us-ascii?Q?y6d1dYM7lq9X+oWdySjJQ/ymtxpTY69vyzweiQ3vvH4hAk/0uNpBesfWKVif?=
 =?us-ascii?Q?pVvdRL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DPjrPaSn8WrhMjXngdzN/DoSff4XjSsfQJWEalvES8Le3fqsAabMjatzhtY1?=
 =?us-ascii?Q?XpnL4qU4r93D6CX9vlsH7fsLOKVXq+ILOo3RtI3JLOygAkj0q69iO7FhRaZj?=
 =?us-ascii?Q?cRzEfaUQEpFuLDhIHXOYzg1d9NQV5Fs4GrK4jDPMjdT6U5SMY+J0aLZoBQkx?=
 =?us-ascii?Q?YFxGun6dTTyR7KWfsqh6BuLr3oCrYm+hgU6iFBvp/x8zGLabpVKXHPmQRBJB?=
 =?us-ascii?Q?hooBkvv2bPl9Z90g9M6VEQUI8Hvs0yTNmvDjX12X4B3DEV5gTK2A1ue13boJ?=
 =?us-ascii?Q?T09HyouV8ue7q0NfBMNFxvgOPDxw/iksZGFQVcmUhP0bP/c/omrGlwMvkqja?=
 =?us-ascii?Q?GlMcTx7B46IYgreSKLXNJPMQNhQcSr+TPj4VBeT5gyhXbAKfJkHbnpBfc2qW?=
 =?us-ascii?Q?mPM9d3RvdCiaYDhfX6nxBN8i3PIa7Np3PtjpnYB/NOWBmtxcJor9fbODpJUD?=
 =?us-ascii?Q?wuOWeGixT4DDAJyC9DKq+z/f21v8RsVodeByaM3BzN7Km8yIBlG9AbSSaKvX?=
 =?us-ascii?Q?vyDw/VN1iwuhmczsnW3Ei+b7KqhABGlc+lr/HIaBfBmXg4oOhd4IaQ3xIqtA?=
 =?us-ascii?Q?JrysK76hORWpKI9alSsf39sfJJlpVTF0v7RQRtrcv9QMqtXB2nwkQhz/XEa2?=
 =?us-ascii?Q?K5w4pkEGNxOLg7zrGPSBXW2xTQCItqPUvcoqDTL8UDUOvQB81rJF/hvqVsRC?=
 =?us-ascii?Q?zayaCUbq3prIU8np7tYWXnOkK5UMs+ee6C6lhn2g2+M48wxTWsdt0DPNp4/H?=
 =?us-ascii?Q?cxW/o7xYrfOLkPN6VkY2Hw2FRmMUZOghk7PEpN886LrRAjlawdsSr5QwH351?=
 =?us-ascii?Q?0zT1j92hQ5b8wSZWRD7m4yEvLoPUngGUYyUlkJpHdzxCxaZ7hUHvxAf8n1C7?=
 =?us-ascii?Q?AKea0v2DkHUGvUBzYU293KYS+JKlOGjF5OTrQBEE/qbSllRr+otf91HF2j6K?=
 =?us-ascii?Q?OUxBwYOjUDqSMNz5pbseys6AUVCcV2dxB+Ta3PKkCnqyKlqcvbcdXQ8vRXXQ?=
 =?us-ascii?Q?tBnmHuus8HeFcptNkr4MKNVXqb4ppATgwTD3M0KgraYQ0yc4gK7pRps/9bLd?=
 =?us-ascii?Q?hb22Emv9c88sUfC8jpuL2KJq0RbZOdfnKsiPD+AQxgeDZmI+v2f8qYCfvZFE?=
 =?us-ascii?Q?OwbUazeIf6a5XELlGcpWMn9B/7ieFOAqqIHjNDFsHgr33qwf235Vg7KkI13+?=
 =?us-ascii?Q?cGALVv3c23v//bp9cjALosUVtcBVr9H9e5XKJQK6Bs94eX9jlM42EbpXSMX8?=
 =?us-ascii?Q?/bSOmlGJ3cYCgEiKi/HmAgx3MiQ0g/yJZeQ0d6mletN+p2LOJDV2svHGlb8K?=
 =?us-ascii?Q?AnYRGLYW3I41NZcNzhPFX3tYTsw5SAdMvEG/4NyoXUO5lYzK/WR0Qo2uC+wW?=
 =?us-ascii?Q?uLXzWWPK8xQx4PPVmw7TqiyPXGqZqG11/DxMuBX+uYFdvWsTuHVTBSiepWAW?=
 =?us-ascii?Q?r8inrlbjjf+QmD4IRmfJ47W+3svaSs9lBfNyu/ac2+Y8nVU7QV+LqvXezPp1?=
 =?us-ascii?Q?Lcc+im0wOiN0H7eGYZxdArAf3o99ibO4Z2EKyeGrM0J1ZPkqRnuuKTjh9aW3?=
 =?us-ascii?Q?akgkmSGBZcYGi8flXA9iwHMdnD5XicSC2X6hMHcb?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946c6577-dc06-465d-b7c3-08dc94270c8c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:24:21.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Fo32Xp3omB9d/iP4xiFLiuA1Fs8jxRdncDGfe7T02oxqU/yd3kV8HjLIgcMwI7/pyFcqDyuIZ3d2SSpU9my9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8600

AP6275P Wi-Fi module connected via the PCIe interface.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index b9e39a62c3b32..fd22ade92210c 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM4329
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.34.1


