Return-Path: <linux-wireless+bounces-10710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC6B942630
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B911F220C8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 06:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671A168488;
	Wed, 31 Jul 2024 06:11:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA2161339;
	Wed, 31 Jul 2024 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406317; cv=fail; b=P7G/FeMWfKQnUumgr1aQB2Rx0mXt9sCwsJ+97hUeA5tvSySD1jNXu28RafAf7+uwNy0Ip3k2iAZLyrA0u3jZN2/yJRBdHcZJP1wgY0R6EELoUxrVG7RWM71hcSEOGLfIBZN2vqOFvOf4Df71K1uG6lwJlvJMm3f79t0u0Xd0l24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406317; c=relaxed/simple;
	bh=c3OyYI6gBGc9rajDwrTjSV90xTmvhmR0ytPVyIoJBqY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=azfMfZmiPgnORPAoV9F5OqPpdL8dZUeoIZEaTOxz+ZGYUprf1hVFT4y6IKcBCSA+vH7DmAAmIoS9Pch4JyFM7wnlNP35YCsDkFi2fZsbh+a0B4DP/4nIbWbpAX6nn31l2zf2C3/I1qL9FlST73pIkrIwCXLRxuEfjycHQXxU1d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLz8cEY7wKMCYn7Fm58RQoQUo8qVE+/HMN6bM8EkpHPr6jSfhpWNpPweyWRDPfItHjipGSwA4Svm46qP/babFcQYYbA1c3rMX1B6/CIJfsx+6TQDwn/U7gO9FaiAZG7yLV08lhc9c7xRWmJ6z3Yt2EegIMFIQUKgnJfAARVboeyrD2XORQ94Zg/pLk4jLK+xBB2hu/zi7cj6URvixxkUsZT/NccSL7curY/c0A7QYxSXE/2R1msDYDK99tUuGHTbuleMwxJituXqSy6x4iejh4a9tR07DoBopl/DjjZrnFmNp/3EHIF9jKjtBRxZbf3TFpiWTv3yVSPbDjQeFWSLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbOn+5Jztqji1KYkvERHMkPDDcacjowK1k7DqyMA0LY=;
 b=MZGqdZllwhclWl6ZdkoyTJm+PTb9pyF8JIlJh6gRb53HMEXE13wsGUWXKC+nAZYfNdY+FoJW3jpPkUeOkXV9YrNTV+/1XmXDCkR0MhDprrHbaGMYdivapx8QOA2NvQIGPVHKfBmCqIzcKB4It9g7T0iLQ2NUAU6/yYQlRoaauhAv6orIc262hlkEPDXzwNo7SSDK8fi4YTOPA4/lf54qQiMlRwd5/KzvbrJZH04dL/MjPiiWy5TtyQhcV0RNwBL35jyrRvp2d9923gdzsEBfUqKunyWI1e5LuRbNs0E0pEbYz3qC/tMj5Ruq9Utz8wEGU9SyR2+WSSKaov2IgfvNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB6580.apcprd03.prod.outlook.com (2603:1096:101:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 06:11:46 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:11:44 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	arend.vanspriel@broadcom.com
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
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v6 0/5] Add AP6275P wireless support
Date: Wed, 31 Jul 2024 14:11:27 +0800
Message-Id: <20240731061132.703368-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: e86a9612-36ab-4a47-d9d1-08dcb127a6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYqPjl+cgCFppLHKcCfFBR/bBBWoWUsbC58tXyTdbKQ65yVi9MvsmuIy2zaP?=
 =?us-ascii?Q?0aFy/dk2CuWLiS6xn44kdWznU5NaqC45wFjqKjy8/FW15rtjqXfvFkWdjamx?=
 =?us-ascii?Q?F5ih6eMTMbJt7uFJ+1G96yn7hZ0oSob/fRXkdvxNsjpl0WUGoJMMoVnSzyXG?=
 =?us-ascii?Q?5hF1Tu5hzqxSpLd1d6l62rLteJIaXZX9gYt10TeWebMmH4SScYaltYTGPC3s?=
 =?us-ascii?Q?ZFJxZ6Otuopz/vlcsGjIM2Qx6AuiDamwcxh+Yu+J5r92pA3dqTLaV+vgbMa5?=
 =?us-ascii?Q?azamAx+LeIXbY8GaFPPnZEhi0GhYq7X3yRZWbs4vmkusRanGVx21KSTbYuTH?=
 =?us-ascii?Q?VSPfJ7wVsIyI8wJMRRp5cZNZJFqoHzHvl1OUzuT05G9taThXmulO9+9ZCcQs?=
 =?us-ascii?Q?XIWL9p1+jQs2wtmP8ZlcW+Q6ObiCvuL3n4MAC+dpsrDnOWSQxwrjLWkvnI0B?=
 =?us-ascii?Q?2LQF08rdMH6qCj0bEZOyAr+hCSyNtsOfPcxWTsqA0obvakiDnR3bUEDdb62X?=
 =?us-ascii?Q?Y2VtV6M2aEhJr5jYS52t46tZ3S+WxfGoo+aF1dPh3CLlY4ctR/PmacTg1Wjo?=
 =?us-ascii?Q?TXLVbEzIaGiXaZoIzCKXhPEvZTtyRMYSww/QUaxjXUzvSQnbYEUMlqW2i4Bo?=
 =?us-ascii?Q?gGMnE2HHWH1jm3qiLtRgYwRAg3mXxKyDoK6GE8b+dS/CHWVz8Xa0EflKr0Bd?=
 =?us-ascii?Q?fvGqkWIHEH+YRwxCixQypLwMjKAVI4clFyLy7gFTi2GrGfEL032DXT/7yAU1?=
 =?us-ascii?Q?W3wxLi+/06eT9E3x4O0KWpYK4TSezPgjtKofPJNohU/x+MQcDaCqnj4ru0sE?=
 =?us-ascii?Q?8614yrBRTDoZ8hM6+B5IjrgBPdg9DUVa5Eq71w4WcW5LHIrF397rGO07hBl4?=
 =?us-ascii?Q?qZZ1NMIVSepYLF3w00SWg2xmY2cl4x+AxBiQH6Wu3kQPO1CpF/yujTm7Cuc8?=
 =?us-ascii?Q?RbD3vX8nwvD0r1z2MF0c0/JFvk9frxKcT96IEuRPKnCtmz7MYCnIUKkgFyvq?=
 =?us-ascii?Q?uQfXAabAkmmNv2NMDjRu0S7Qx+rkV+lobImKh62uGFqXmNbdOanCnFQq/kmH?=
 =?us-ascii?Q?KIfDMHbxOA8qap5IBuuDwoW9hpf+kL/cBU37G3Fb/SY2HWAsjNB9ZSPj9x09?=
 =?us-ascii?Q?P6GqJwt+eH/11+yXKkgRGjmlck8d+81hGZ6AcNWaerj8CmNvtRVxoT5x9lcg?=
 =?us-ascii?Q?vv5UsUJwo7DV/7BJh+8a7yjjeufvAXNUp44cerPgvI+N805lnVE0aD5SPwhi?=
 =?us-ascii?Q?IciA1LcoJMKz76gkGVtliH7MeyTszb3bqTl7S+7ZngIxxJ4G/vrAokgtvAhQ?=
 =?us-ascii?Q?trheHKTsPhrWWwyp5wAUGQLEuaqNuqUUpMGJSJVx3DKk0l0KCnDncDqhi173?=
 =?us-ascii?Q?ivdZDI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AgyOYG77rMuyb0PnrroWh2n5ghyT/n/F92BooX+yteQDJttD61GbpWjf6Qjc?=
 =?us-ascii?Q?2A/Iv5C42P2D2cC5OOF9wh6WohENs3lmNYS0N0sATvCrDXxC+grJpPnfdZpX?=
 =?us-ascii?Q?6voQWgLk9Km8LOZUuDNdnx5qA2VaXEXGiuRWUcuBEJWva5LwvGsgobB01Xqm?=
 =?us-ascii?Q?Cx9+9wgRQ5UzmCXF8SJjQmJcBrvvCW+HLXoB8rtmlawmyhGn9IVKheTihuYi?=
 =?us-ascii?Q?oDXraFM7v3wflKaIlc2G9ZEW1/xQ+PFKi2yEeSxwwONRkHA6vW4rjifBHYad?=
 =?us-ascii?Q?jz/qbUwg7xII0mhvVqYCJpPfm2L/KlXyUDy/R05vzyJzus0v2iYu+6f+sGTu?=
 =?us-ascii?Q?+DmjsRjEIWOpM/Z/EUdJsXcZcnnQceH6KO3OMZbxBKRadHbtGrq6vVjQoDmT?=
 =?us-ascii?Q?LNRGz3ra3uRxJzSls58dR3qTU0hpEhzTdEDUkkBvJk5by1jN6sMfWbxncnav?=
 =?us-ascii?Q?nVkmf0qDH7sAacG1YTcsF1kwmfNhirQTPyt94MmCoy4yPuzx1kJO1DQOhUPf?=
 =?us-ascii?Q?zXKS6pv15KyiTzXsN9iW6UBp5BeGVcKGk7Nd8BR0F4itCOGNGY9yurDVSyfm?=
 =?us-ascii?Q?p0RQy7Mpq3poM3IsRUVaRPnk0pFF1viBFp1FASKsLJaNct7DBqncCfVDtgN4?=
 =?us-ascii?Q?Z9NRP/fyXlEwY3OE53SX5eCypY2mM6AdFKF9F5z06DvIlztc1J9GCbe6NbYh?=
 =?us-ascii?Q?tpuJEAribwRSzEb6hXGXfgyEdoBAPuXbz02v+EbBrwDE2r5+Kj0Pp+oeyH8M?=
 =?us-ascii?Q?L8BDh62IYtX/9it2YNIBnkskbIBJc+RSy23pIeDba1pHC7vYB1UQGoh0auNF?=
 =?us-ascii?Q?8otVHbcKK4QCuhFXYa6yslG4bk98H4x8z1eIGAp2RFSvk4nKzTytdzxRxbyO?=
 =?us-ascii?Q?wHClUXGTk6YKuM15gLqFAGF4QcAukeSyCagHyRl1Zk9dp1QmGx4EouKcI9ZE?=
 =?us-ascii?Q?q+jxlCwuZRudHD7wuYI4/kP/+8BghoNWoTAphXNUBQt8i393zv7PSUDbY/pO?=
 =?us-ascii?Q?mKHrDCXWk5ScTzLV5y40of952r4cxL64U8iTRdjavo+01Qs4lGirVM46WWIB?=
 =?us-ascii?Q?Hzxcdv7lJxsBhrBoCVM1o4HVKoovf5hVSjPwAlm61nPptUh/d/H4/WYgQQlU?=
 =?us-ascii?Q?AtllnXKzZk423coEg3SrPv+9xLq6d5zC+Zkv8nZ1I+ZEAQTYztl0VIoU8iSf?=
 =?us-ascii?Q?usQ/EDtHo82iCpYedznp1E+Ey3uRwrFNH+WgK6ibASB49jK/3mxM2lfB1zWv?=
 =?us-ascii?Q?tGsV+DuHEQ+fXUo1/1a7uLiH8t4V3k0XsRC/II/KG2MqJFyH2wek6+Pe3UEb?=
 =?us-ascii?Q?Dmoy3cnhoZZGbOr/HNRGs8e+Jf7eDsrD7PnSa8HKR/PEWkB1XtVnzmKiT7gO?=
 =?us-ascii?Q?5Ml6JjIPhcfmvASZK+WLDv/yHFTygqoEmw7fhsNgHq3kXpQvpm8USYO1fpp5?=
 =?us-ascii?Q?flYAKywAHA+ugiOyZqrXINLdv+97puB8vlvjTF/cRTb55xwXc5+bo5JxCGhd?=
 =?us-ascii?Q?nIxB5wdkBq1rFkBSPRvSUnu9k1ANCXm+teEw80K0ySANS5CIAOjHOhAoDV1L?=
 =?us-ascii?Q?mw+9lC8YM0EWzzMiweKeKVZPbKG2KVjmt4FLW6+1?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86a9612-36ab-4a47-d9d1-08dcb127a6dc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:11:44.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX/uf3TdPF+kBOWp/3/BMQcDdMmUW4S+JxPl4BfW8POLoLOTK1kpLp6xyiVHKClqd6tD22CHWvbH6DA7YVMa3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6580

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

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

Jacobe Zang (5):
  dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
  dt-bindings: net: wireless: brcm4329-fmac: add clock description for
    AP6275P
  arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
  wifi: brcmfmac: Add optional lpo clock enable support
  wifi: brcmfmac: add flag for random seed during firmware download

 .../net/wireless/brcm,bcm4329-fmac.yaml       |  9 ++++
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 16 ++++++
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 12 ++++-
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 52 ++++++++++++++++---
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 5 files changed, 82 insertions(+), 9 deletions(-)

-- 
2.34.1


