Return-Path: <linux-wireless+bounces-11504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C24953F43
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 04:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCE21C218B3
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 02:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF2482D8;
	Fri, 16 Aug 2024 02:06:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7863BBF0;
	Fri, 16 Aug 2024 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774013; cv=fail; b=Olw9q/HdRgM+EsFOWUS66YvvjsFTcniS6y20CNb4jO2lqn9yiR6vHCMJu2e1K2pjPtQB61gcPDI0OmyqgS5jFK1MPcxTH/NJA617ZHWoPwTE4FZTc2L6m8nCEY3dMW4aAKXGdDao0goIqGRG1qfj8LOmMIIKEgnDiJGjDeWcOe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774013; c=relaxed/simple;
	bh=ON/D0bX5FmRz9tP2jBxTEYAprEQaIrEd/TINebfhyt4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tqB6ugcm65ETNWsZJboPlDkC7ZcADO0rPN7e3Om2fg01NyN+Y/tW4IT2lX4VRxmoHq1bqwcGZsIMbUclLUvCBbkip41XJoL8kG4Xn/YEs0v7cdqaE/3qAOHzrlK6Gly4HBtVM16V97jS9rdwF0MsuiuuMWna21xhoOLSU+LQKp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5GgktiF+Fi92JwTcFS+ZaLOgZFb+l+LxiswSLjhvAzhy8noxJEtx0omnRq5cIFY7VNl9pn6UC5q8oDErbNqiLGBUGSboDRei0F74kMdJGAglj5ROnAqKdSt3VSnI3Er8M1solHgFzkOEtuVi2E7FnhV/PKu50JPSsLKIaBQrvm/YNZ5JmGWfbmX3p9hHgfBvr5JJKo8U7qXN9DmXBYrXyf+qb5+QDU+MH0li2nISPGZUACCS/INsXbHf9W5AmTvqzlCd+JW5p2eM+KJymN05Nd9YjXFfyZ0Xe2q/TpNU30ZeY2NP6kDYSZeecs227bk1cor21vdCU9gLJwNO1HjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLz2Unga3pVVVL9ZcincJhgpQpCS4mP/H4JgF1SDOrA=;
 b=MKDZPjWfEZty8U/T+OvhnQbkgzSGUp4oHZU2PhQ9bCjM3LDZYrV+9OK5LvORGP9eBtN82qnmtvnRGX9mdawodoE1FxN9t0kV0kSTndshEprZFfRxNjZbxKNaG0YoIJB3fWM8ekMFVOQc6BMJit7G0JuUvgEGewbDcTYCae/hoPZqy5rBAkEl4wBCE9+v5F51qV9TVb8LVI+poFlt+d40KgWQmFjU2IuNOmk8l4/y0FyQhJ7JiLOiLxmugYjbvbiMtUpkz629sO8/Hu4MuOLO5+FARYsiQvwAjbWhQgI+DlU0Ybv8aH1Cr7JM1ejmlUGKMwtf4maVcwxqNkQXuVEmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7444.apcprd03.prod.outlook.com (2603:1096:101:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 02:06:46 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 02:06:45 +0000
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
Subject: [PATCH v11 0/4] Add AP6275P wireless support
Date: Fri, 16 Aug 2024 10:06:31 +0800
Message-Id: <20240816020635.1273911-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: d0930263-1830-4b4a-b51a-08dcbd981494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8AgHSnTyOcxo+MzX8buct0o6Sg83Cxm0oPuj+r1iJnzCvt4Nd+IL8LgTsgN?=
 =?us-ascii?Q?Olgeko98vaZBDsaq1fVCmwD6w3n4NMY1fTBk7HlSLSZfcXDxuI/KEtd3pPvK?=
 =?us-ascii?Q?/4DlSo0EOFa+BF+NZZUb4NrLkuHhNKTe2h4UrcTuzYjTgLFCjtelgzvVQqpM?=
 =?us-ascii?Q?h+sI/TE8g8n0jss+kA9nWo1mdBu7AhUFPFogQblvQCA/f6s0zX8pDbqqPNmM?=
 =?us-ascii?Q?38AVJ8656m+SWtoq84wBOUIXRza7YJm8+ujHdJZAi/RQLi/zrZxq9wbt9gXu?=
 =?us-ascii?Q?oOAHn3SvwaypxVu1vvW71ZI0mqhZvDZLxwo4J2Km0B/NzErGvWUXTrZZXwDU?=
 =?us-ascii?Q?NvbiW7EXJPQea30OFy7sintpZWsOqgTt3kqzmF57u8m+K+fYU/+Dpe+ZOmYP?=
 =?us-ascii?Q?TKxD9/futut9bUTp2mZfdd1OPiUY1bK08zak0SdcHZ3wFkqhIwZj46k2EYdZ?=
 =?us-ascii?Q?FUB5Dv3XQnRd41MJ0xDR1nkx/FGc1e7Meo+nbF6GneXGLwTHMvGZtH/FiIQr?=
 =?us-ascii?Q?S/KF45jxD9euzM8qKWn8dabsmaCZti1Oxc9/qXJRxflQEDRU30zr1t1/mgAK?=
 =?us-ascii?Q?FHxSj5H17lFFZ1Y5GjJ6cf5ruNujDUpO6vMsLvsZYkjDxvaKaDNd+wW2c20j?=
 =?us-ascii?Q?r20GA4hyrx3C9ViqcmjQ5DuwIfG8bpktipI/xULsVOpUcR2F5ja2FRBY3E8J?=
 =?us-ascii?Q?NcenT0/XCTFVnNbnJ3NftE+YOPJTKbTrBeJ23WG48PnRN8liUGMiF1V0uQAa?=
 =?us-ascii?Q?Ofwsq6uIEEwcg0v5A3kQRb6dUR47kHy+3lsh9cXZA8qRBu4zywQ6vY0sxsNh?=
 =?us-ascii?Q?mEjrinxVl2jc9vIhNBy6+mHKnsNdo25X7ed2BfF3QuY+4KUZz1V9902wRH3A?=
 =?us-ascii?Q?tea4VfPYlVmo6OQwAKJqQsMLn50zrOi1FRwK82yMaT5et5fZIrgHjLX5AXN+?=
 =?us-ascii?Q?jSh7DSknW7ImbZIuzK0DSzXF61dQHzn1cYqVtINY7jDtyWKXr0oMctPwUvr6?=
 =?us-ascii?Q?DES/bNowDDtPiPBR7M3SIVRYslUctV32VO16IMqP2iM59oO/2en8WM22gMHg?=
 =?us-ascii?Q?Mp53i5HhBhC09ZiOaQ7Oz9aD9y3S9s1dS2pVZx87aLnuJq6b/lhM5nmenMvm?=
 =?us-ascii?Q?TOGdzZpzeGyKIUTF8oACVcQZ20z2O1giBc61zuydj8D5fSwzeGCVNm9jTakG?=
 =?us-ascii?Q?6pZhBmtBEUDdlQOXlNfEd6dG1ZkAyFcHL2txeTUvuN6Ogn8ENS1HH9+raFQw?=
 =?us-ascii?Q?fgzW8U5gDDnLEgm13nPUuQH2eHUE/1Fkrf/UTsjGphVZAeWy53Q1phgfsX5r?=
 =?us-ascii?Q?A23+0Xi9t+KYnx8pE0N4oW9U2be66oG1WK5/UTdzdPhxaNzh0YhC2U9BL/M2?=
 =?us-ascii?Q?7WcuTI6kMLkagawBOIml1p4EWQSkxaZbZ+JJvr51icUtVnmp2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HiDeGk/OV/W7xfHW5RLDSdv/uXKCimPwgMbKGxKHKGmH7xbhJKmbm677b6Wk?=
 =?us-ascii?Q?8XoW6vgtVajxYLh6B610O3KoHa3KOhVlKn4TVSXZPDjUDjjiRWqdX19TXX3f?=
 =?us-ascii?Q?RLzSDaTTUnQZsfxgsN13DjMi/QXS+tGvdUvruJf8iVKxNc19yhZizalnbZhu?=
 =?us-ascii?Q?fq+YrKXul4oAfz0KimQmj4H1iE+8NatR0krhgACh4ZRYEpvaOtR1i02QGguB?=
 =?us-ascii?Q?+HDIhs1TqMvOJagbrIOM6e0cXgK7uOEx8PAWdzuK3SGZmhyA9hJil1wsrgz7?=
 =?us-ascii?Q?jfVy+gl91jz047XtyByBIanMk2hp/ZyIhG0AdaB5/OyJcdtQLzAlnL1+2NfR?=
 =?us-ascii?Q?t/HIBJQ+4VL0uleiEmAveLo06FKyEOUAfvvXmVzOcPbmPrWBwAQOvpzpEVXl?=
 =?us-ascii?Q?xWGkeCloow4oWrB0jNgD+I4hcO0Apiixzy9RY34feBRgdSB7R31o3kSjFlz1?=
 =?us-ascii?Q?nxHnDyf9PFpJKDFcXaipygvVXbntULQGd2teCQH+7E7zDJeA34DEw0uuVZyR?=
 =?us-ascii?Q?nEUpgimIQqMmENBf9dzLGjGxHtpQFo914tpsV88YJH5gfZSwfmD79hAyxPj7?=
 =?us-ascii?Q?T26XbT4RsgQntmxAP0PBKSw2TuXaSmbIlwDg0tp+2+ChpFUvUMkRH+QtKQD2?=
 =?us-ascii?Q?j1X0r1YWlcRRGJe9wb36iL6GweWrOfs+W7vIFddE5VPSLYJ0GTlrSbmS/zHP?=
 =?us-ascii?Q?ltCRzexHHYXs3uxa5M8TsiBCCD4jpILjAxGojF/tN9sK+nNvtZ8MI3pKqNqz?=
 =?us-ascii?Q?XXJUUlrcNIWraxk6fKAoDzkQTtjZRKL7KT8ziE8LnD2a20SUpPHbKVer8rz6?=
 =?us-ascii?Q?EKwFyk6SQs2gKAnSRf8tfRn+aU2j8zlyC35T+2wRCqgNbJ1pKwu6rmB5ylm4?=
 =?us-ascii?Q?HyPQu8Nx7bQ7i9oc1mPKPYwDyn9zx+vZo3Rv7EPmk+oPUbQbr61pcZptlQ91?=
 =?us-ascii?Q?wcPWfC8rjNdhN3ApRpoEK8/09zKU+dqks/lpMi+sBVoabLjTNrOeUDc1xjGz?=
 =?us-ascii?Q?kgLPtxGIrrw2C1Paey7x0BjXEvDf7AS/pJMAtUkv6VMKvNcS6404OGm3NLNS?=
 =?us-ascii?Q?QoX6tMy+Zmmv/xPD0vIvjY+2HrJV0QsO4NxqEmNa7RXyhS9z3hQGm5X8B0gs?=
 =?us-ascii?Q?QBauI5ogtjDxuvC+PHFDWNL65Vn3RyMbS76pKU5ReHWZYzmLy4qZ0ec3yvZq?=
 =?us-ascii?Q?oIn03sINgMEwhTbPcaEKc49bbxDfK1qF2leiXArxFF1XXFch73MAworSROau?=
 =?us-ascii?Q?fOehpbZviJ92TVy1HP1GgYl7cm7MsjXZr2AmpTV9MObN5hZE7AHDDAgsgcI/?=
 =?us-ascii?Q?dyAIXKIHQz6MawnORaeYQpR76EWn0/2r+0AqlS7QV1+YhxZ/rgaeIsoJT5iF?=
 =?us-ascii?Q?cRh4zvzgc3wPBIAEpwEE9SyITLWJGxy6ODQlqNyrV4eKc1iZ9At8cruOjcPP?=
 =?us-ascii?Q?e7AM5ZyTuameRVHkqT27BNXjjrsM+Pd3RKwbdksyBH1olkrpCVIwHA5/i/vi?=
 =?us-ascii?Q?mA10AFg0KIAtS+4fAY9Nuxl3VdSZIaZxpFN03wbhx+kfeNMqW6GG/LgVZs6J?=
 =?us-ascii?Q?ObRy2/eoPA5/X9KdkgPAFFSTdDu7B9QLoTTzCZBcYjf+TcvvFfBbTWJRe9GV?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0930263-1830-4b4a-b51a-08dcbd981494
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:06:45.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrHoqNErsPXtRsqox6cBlZkk5kozmx8RDNMlkHcAZkpZrAhKOk9St6XjgU7yPXXSg9fYIacqgtYYDskJYepbPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7444

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

Changes in v11:
 - Retain interrupt check in of.c
 - Split DTS and submit separately 

 - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/

Changes in v10:
 - Use ret instead unused probe_attach_result in sdio.c 

 - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/

Changes in v9:
 - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
 - Add if statement for brcmf_of_probe in common.c
 - Retain modifications to of.c other than the return values

 - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/

Changes in v8:
 - Add appropriate errno's for return values that will be
    send to bus when error occurred.
 
 - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/

Changes in v7:
 - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
    value, move clock check to the end of brcmf_of_probe
 - Add "brcm,bcm4329-fmac" compatible for wifi node

 - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

 -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/

Changes in v5:
 - Add more commit message to the clock in bindings
 - Use IS_ERR_OR_NULL as a judgment condition of clk

 - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/

Changes in v4:
 - Change clock description in dt-bindings
 - Move enable clk from pcie.c to of.c
 - Add compatible for wifi node in DTS
 - Add random seed flag for firmware download

 - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/

Changes in v3:
 - Dropped redundant parts in dt-bindings.
 - Change driver patch title prefix as 'wifi: brcmfmac:'.
 - Change DTS Wi-Fi node clock-name as 'lpo'.
 
 - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/

Jacobe Zang (4):
  dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
  dt-bindings: net: wireless: brcm4329-fmac: add clock description for
    AP6275P
  wifi: brcmfmac: Add optional lpo clock enable support
  wifi: brcmfmac: add flag for random seed during firmware download

 .../net/wireless/brcm,bcm4329-fmac.yaml       |  9 +++
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
 .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 29 +++++++---
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +--
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 55 ++++++++++++++++---
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++---
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 +
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 9 files changed, 104 insertions(+), 32 deletions(-)

-- 
2.34.1


