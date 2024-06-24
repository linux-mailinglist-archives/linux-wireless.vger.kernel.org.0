Return-Path: <linux-wireless+bounces-9485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB119144A8
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0641F23DDF
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE340130A66;
	Mon, 24 Jun 2024 08:24:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9C1304B0;
	Mon, 24 Jun 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217461; cv=fail; b=HdXuYl3crZSUUBLSpSSAwt1W8rPVYCuI2IBqqUdQjZR9/xAWDyNORJ4kO8inQ8PGloaOYcH8qOQRwCLffNvN4e/Jce2qNHDmvBhC2OtBr06uEfJduREIbKpSHjfyuAbBXL7Q75hrVo69BxbzBwPApY1wyiybWZGQfmAeA+f9fSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217461; c=relaxed/simple;
	bh=DIHi0oXkObx5p42I/dAdkcyH7jHtWGc/zH0NbyApprw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XkPazWQdngqdEJeit+l0mGX9Q3v0appjNx8Qcmmc7KFZRhkMIDnxMR67PX85C7ryDs2Kgk2jrtWW3+5DBK5tl8AdyzMYdKD37jKcYZc9ifdvMmW32hOCMOltGCbVgoU74k7hWYLTG5PL1JEXzzCPlc0MUnQohE8DdILL32+MDVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKRowdWMMXwekj7a00NfVrr1wbIOlK5Hj5Xr44q0wusFYnhlttNpDMDCPlpZ60AXHNWVxOBNwcEv/na5doS0oA1oNJ0lNDPGDBsbSzGB/QH0tv0sipAf+BqapoKqnl2xTb5vTqbT3FdYX0XJAjRLJ+7PBSrA7KRNj4EMmdfq58kAoaRVfzRPBh5aK/bBewv50fFA1PckePGcbVWmhcT52WDEHQ+x8Be3fOkIXTAsfjeBv7emVCb2Pe5/YdyTXSoDhcqziqy8faR4PmuVRvf8S5GZuzA01aFAS8CUfNjLhm8s7PHK9+85Ix46YGzFagSxwjSq+vyoxKdC+WMlAiOYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPs1cZLtwuxBYusx9pZNsqRF91GCf4SBs8sIuK9cMs4=;
 b=O4tA4EWjD2qQYG2rz87csX2ZmS7RDJbSjYv2etKFJIyjkam3sWLUE5qjOgqkxHX8PPzkTFZiCub+tPnNpgPLPGCpOlRfdYDazm3II1x1Gbj1FDN31jJmFPQN8Y1euRwa0W0E0I+FAQbWlTA3MeGbbzS14dcLz087UunTDpKpW8PsTvliY6Ix4ij3cUHps4o+hj1WICzZUfFC7gy61VqUNdJQd8KgF5ngVWFCriZz9DpxzvFuT7goXqiTHP6ztIG9Ky1fw8EC0SXVAgnE3RoqK6pA/cTrngC9q/ypsg60Dcc19R4n55Mj31x6dcLmhziUxpTAjDiiAPPXbqwDmj9v2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by OSQPR03MB8600.apcprd03.prod.outlook.com (2603:1096:604:290::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 24 Jun
 2024 08:24:18 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:24:18 +0000
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
Subject: [PATCH v2 4/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description.
Date: Mon, 24 Jun 2024 16:19:05 +0800
Message-Id: <20240624081906.1399447-5-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 53c1c4ce-74f1-4917-137e-08dc94270a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EbI+wqIFTwUkzi9k4pf8Kfr19opaP+YiN7fmsgcnq6NuvWArCOqvkLXXc4fs?=
 =?us-ascii?Q?TJdEbDQMm4Apk0k/xqjuc7Kdpj2dJ0eS/mzTulxbt1I421YTL/ezDui7Lmhg?=
 =?us-ascii?Q?O3jb6oEgFsylqK0pJ2m/KN9h6M1v/pEAuoHlM3LMk/RHk7VkP7nAC5ekytoc?=
 =?us-ascii?Q?4GQ87v0grcrSeAVE9AeuPDnKL9Jb6YoAkAAUr8JG22O2552QH3GBVwafypvC?=
 =?us-ascii?Q?poSIALGAXYFfP5BKZRs0HMi/MddxO5UXq1wgLHdundMi0PxFLzF7C00RnNfN?=
 =?us-ascii?Q?gNzO3eKzar+aJnquuTRD8ribG/EQdfvAMY1T8EUA5GDHVd/2nAJpb8BwXx0A?=
 =?us-ascii?Q?Adlb6n6LXA7B1EaaKIvtalAFMBmF6D3nNPyE9Z4Ysbr5AdUl58n4MhvOsZdv?=
 =?us-ascii?Q?LyBGN6eFb5vOqUyO6ri925t4UPLEotudGjQecldXhSQzea3Kby2pHOZUl/mh?=
 =?us-ascii?Q?SdGENgsiCtpTzLjujTmy9X5loqCjseha8wRNXHwaSqa2YCTJq34SZzduTmWq?=
 =?us-ascii?Q?6+4fDtGA4u+l4Exhd+4hcCq75JJK/v0qqXXmAmVM/XXIgoTe8Gt3EvrzLUpp?=
 =?us-ascii?Q?ugc+JCEtHafwjju7/fxlP1CXzDxU+qJG8S5SLBhJ8liN4aILy6OtQYwCTPpa?=
 =?us-ascii?Q?NC+YFoqCWfzapE7dYGNS73+PjeuSMAVns/B3NiV8DsORJIjMKYnidEZXXXEb?=
 =?us-ascii?Q?He90l/dY8fY+XRY2WRCXUr38IJzKpC2RA5pYNZXYamYsbXFODAMbZ1EAVRAC?=
 =?us-ascii?Q?RthXtHsx/muver8bC/gvO4eLz+xx556+yj9+ePy7EYaV31LG87qxE4rXOxpv?=
 =?us-ascii?Q?TYt4exZyf0iP9qDVbIwv8QjFDUbvJ7IYdh3viXHCYSqkbT+4SCqP5PKezfU4?=
 =?us-ascii?Q?kMskHSg8VFRbCvYnabSoJHr/3uAvx+2yom5e1DjQSDwxRkf+6tOYjCJ9LHFy?=
 =?us-ascii?Q?WjRM8wYoR6AhudysIYobe8LERl1uTbFWyyGM8RclHJxQQMUQ9wxOtsVSfFWx?=
 =?us-ascii?Q?zFObF33DUB1cDEAHXIedijeRFNmHo/D/fg/1OANcY5M/PGFig2Z3AlbNYHG6?=
 =?us-ascii?Q?a+k796mESyIMOWT8NmkPWFp09go/0bWJJRDEiR0Z/4aQv8qy2F8mCsbT63mB?=
 =?us-ascii?Q?4vl/fNS3aTWVLBl4boekqGDUzRGnYgQ6x88Q6zXN6h7IzilX3OVKSBmZQqn7?=
 =?us-ascii?Q?2I8kVadbL66Q6hEe7nmCvjGwNO12S+0jQzyrzKobhc2iW0q0IiH6BLOr2mhH?=
 =?us-ascii?Q?sFPZulkQDD2vPUUV5awX4oGY86e0YnDdESHHVnRly82x67OqDZOdNMc/FzVT?=
 =?us-ascii?Q?Rh6H5lp4cd/TYvANp43rrn5hMQ0cd6uVQhsh0PpB4yqWOxnYdadQ0qsumd17?=
 =?us-ascii?Q?02h+mKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PveMgQG2mb3tyWA7MKThmchcmp2PMldTt5SDKRtkPTpjhJaZLm1PjM5FVbON?=
 =?us-ascii?Q?2Ed2pPc+HglOSwHNRUIM4wXBl8lCs0O22EQG3unKIbgUdQQqSuYwp7ZRf5nb?=
 =?us-ascii?Q?d4c1f4R0RCrN/zBWPfCeAsTkGgJl/jvvXAkaH1+6l2OGAGEYw4LMYCYKlc3/?=
 =?us-ascii?Q?EBWrZxb5zFrHTtXatyq6gFQZLrND5U1HqiQn5AmcipUjtV1SgVkJk3lb/E1q?=
 =?us-ascii?Q?hWWFD0ZR7wo7YsVBTJmBWCB+Ibo1OfU+2Bnm9Wbo9fyIreM59c1sFhSGz1fb?=
 =?us-ascii?Q?XxWBJCIOPEAKsSURWwE4Rnj/eJTuTsznLn6KFMS1LJxRcb1YQXnafE1U56Iv?=
 =?us-ascii?Q?jJOFRsjvVPYBUAFDnO1hJO3+BKm00EnKhDh7tuyNJtAmQTWmlim36d6pISDv?=
 =?us-ascii?Q?67bzVgnssnXGyI4UsCzGaXFy8EHx1KXAvUIY3sBkAQrWAavCLISxFj9Y6BHy?=
 =?us-ascii?Q?wwt+RD76JcH3M0s5N/HmqlCKC5O8Qaz02/A3g7Nq+6CqmIq5VoUw7yp3TWkX?=
 =?us-ascii?Q?Vx2vKe6r8ETQYj5rq2Z86JIbAB9LWjDF+mHxiCwGV+lrENdcDmO4gBJLrN8U?=
 =?us-ascii?Q?HtYNUMpLjYRrxB2jqAHPhVksqv4JtNiO66vSwtKPGpVzdXWCe9vXgp1an2FI?=
 =?us-ascii?Q?Sw83w3AlKSw8ztV04FdF0ZFYlEUXz4qfeGOSTY/5oiPtiFwzUirelYszIgRT?=
 =?us-ascii?Q?h5ext5MuQhWQt71446fcgCRGriACGgQdU93eHsq26ecodqDc7lAiseolcoI8?=
 =?us-ascii?Q?E6w0gCwJvBwjK1tVZm1kqDof4hZl4Rk3lFzM3SAd5qk1BvG9m+7e1ijAquDq?=
 =?us-ascii?Q?qthEfhQtTcOpccz63WHdPVPEAJA2V2WXGu2qANzbDrlGCvlXyqLhtQIxpAfn?=
 =?us-ascii?Q?SPmiyZHk19vaQGFiOyAscuTHr3/EG1FiK+gsOe40JJO16pxN3Q6AMBqsLd/A?=
 =?us-ascii?Q?700fUzAuLatG8tqEWxl8RhAmIfnlfz3Jfab2X2by4ZgKf2isp+PLzoWpfu2m?=
 =?us-ascii?Q?XnO8vCwpJiEt+CcHISKaq4uZWcgufb8AJ8VrojjAxc/nH3RYnUN/mGk/lbAh?=
 =?us-ascii?Q?YLPUHHWBKyg7HSaFErfSdMKCBWDu7PHMS1uN399/639TiJWTHEk+riq17cMI?=
 =?us-ascii?Q?wH1P0KV1bdrKq02/OpYw1gKtiFjQTaBgsgb9N6zoz2pRmrF4ciIbSlNadKyq?=
 =?us-ascii?Q?Ki7ucpl+b5UtcM/Oem2eUGg4GjdaO17PQqRhv4ql1DmpIr44WNfAq9DMks+2?=
 =?us-ascii?Q?ACA675fn6r2ZnvYfzf7KWGeeQ0Es/CCJGCh1/Gk2S4Ub7ZQzgxNxuT7wsywD?=
 =?us-ascii?Q?kS8IbiUL+xKVELDLk8bPJPIN0Xp42wCLGU1jYZgqshzQqSGctxSHJ3dU629r?=
 =?us-ascii?Q?WrPZCIlMXPDSxlGcIkZTLs5vu1vW8LP6sCvZhXcTXWARn0zhJd4AXgWp/17K?=
 =?us-ascii?Q?0dIFpjQoeBZvF5WxI2fnvgjObAYAcugaJFMLVKHW1Fzrv/VCJ6m6V13CUFAv?=
 =?us-ascii?Q?OdCrlUFBy/7haNDxOFbYaqem9Xrj8lhH2pSCYttSyQMLinMM2tbOv8c0f57L?=
 =?us-ascii?Q?2ybf33q0bjq8xtzyDUDmojRoVaUlEz1yopje/tyu?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c1c4ce-74f1-4917-137e-08dc94270a7e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:24:18.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zgS7mazjAhFtHjvgEF9DneSPyP48z6aZ8V4kghrFefnUJyCk3sby3AH5OPXK1eOELI7jLpwc9SJ51SrUY+KJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8600

Add clocks and clock-names for brcm4329-fmac.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..b9e39a62c3b32 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -121,6 +121,15 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    description: phandle to the clock connected on rtc clock line.
+    maxItems: 1
+
+  clock-names:
+    description: Names of the supplied clocks.
+    items:
+      - const: 32k
+
 required:
   - compatible
   - reg
-- 
2.34.1


