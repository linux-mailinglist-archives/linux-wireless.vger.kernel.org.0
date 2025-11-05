Return-Path: <linux-wireless+bounces-28599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F99C353C7
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1625A347AB9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E1313539;
	Wed,  5 Nov 2025 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U4j2pdks"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F631326D;
	Wed,  5 Nov 2025 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339819; cv=fail; b=eEQ7cn2/T1ndJaH6VKMv3zf4obQVTnYTV2reVJq8M/MXBc+LTcpLnkEZKZNj5WY4JwJkKssfDYNY8K4AqmCbdxWvEx55uuEbHviBBQw+AKxjm7GMSPu8/Z+enZ5LGMXBkZPyn4SQeow1DCCefeHEzfHakeEz4b67GbiyoBV9MAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339819; c=relaxed/simple;
	bh=rjFAqmGAunq+A2rVobUf29rfxL8J2FaKZJh3XTvufAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDzJBGu+vsnXH/Yy7FNm2MW66u/5de9JuteJ1u4/WvRh+LnRAMweAOdLir/U1JwhnewDAFtoan7IiHrk/y2DL3Qs5dW2J2o7lfET9mXKYnSLYHqNPyx2jo5DVuCfPVjEcxULTawWB2rusID4nrBT3mF606D90qpxLcjRagB7DUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U4j2pdks; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsP0p5WYxfRkgqL/TXT3pcWlh3o0TzxqSZ1M+cnjNliLbFgumZ45+DYloVWwnxNrGDf3rc51cxX4Pq/BJho72jI2TwVHTq36BuyquGysZ9ruNNSC0So+a5eru+/w7MSRhyDPcUkR1U5gJdh2QmKnbZVAHd9by9Yt5l3+yZcqe7BOjovuB8O9adWOPOIflv66VRqx0M1/xWb8VUKljcisNf3szn5pTiS8B8sOwZtArD970pF+7i24Pz7VqMZtwuJwoh13TZWcmkZJUTdW0gzKQ1YPY3bjqDx8EUI/5IhG7Xxv0Yp0WF3oDonVEhbM/3d2jp+dsDDKU3EM34KfeNbiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sziBrxCTUL3VebxBPrHbiNIG5zbwEbusRVwj6Nhm1Qc=;
 b=m8wcojkgmy4/lbLeFahHvWhe7+ttuZqfTb2A8ij3M3tGNEH2vO6v0ibm3/UMUdkf8Yo3CxsQXKKgMji0sGEOUt1o8E4mSa9hU2g1nD2BxTO+B5d/slNkkEjHafVRNsRVPZLedDRCZFrA8pXfhPN5ya7fzD+CyCh/B7WNTM2gmKi962bX0IBFflals0Z7szZtLkkluDZ6XVjiR9TOvh5qMnxHjDkqPBP24fp7LZP3YhCTkUG3rvonIMyboBPoqAdqkVeTmCFKfMidrZI7DSI4KrXswZKtF0xKBky668csMynkheSURuxUWtjMXOQ0Z7qiYCzxmePXAfHoXniQR9aN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sziBrxCTUL3VebxBPrHbiNIG5zbwEbusRVwj6Nhm1Qc=;
 b=U4j2pdksD3oZQXF5e4eSUOXsSKNcHOQKeDunu9oM8ft5FKqqolr6WEUu5T2iOnQfEacch8P/mrjeB8vwRIN22VDm8X3HhStriZlrEPgFm584qM5EMAL+vI6xDGyH9UFuYMEQ+cSAfF18sk6qLlPOe81PvUZSs3pp10O31yJhhtF6eDasY8hO9GllhpclaZGGJjLz/2svPd5lUWy7lUxqXzi4juO3xIz1Iy0w//AFTMHbbezucG09pZlBqCEuYdymr6JY2jTdfhKJMjJnaKEPHP7X4B1CvaXHnnmjby5pgjaJDuYc3o2qefAsj0EuEVCEqW5ywi6CLKpWT6w2qo2ZzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 10:50:04 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:50:04 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 21/22] wifi: nxpwifi: add Kconfig and Makefile for kernel integration
Date: Wed,  5 Nov 2025 18:47:43 +0800
Message-Id: <20251105104744.2401992-22-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA1PR04MB10770:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f31638d-77b4-4976-66ed-08de1c5913a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jTiXGZo8pCAwZSShTB4ebQ/OSwrOmBDIqf03/muNV7CWWcG1K4/H4P5p0XBF?=
 =?us-ascii?Q?mEerHt84TWVapWwXkprSOYxC52YI6a/p0xmN4ua4KKcXr1MGyqlBYE6zSIdy?=
 =?us-ascii?Q?2rwH0UcO5s9hbl/SNKW3lbQKBey5Ko1iBzaCSr4ELGIrFyAqtm5Hdg/yj9A0?=
 =?us-ascii?Q?6Ie34PjGqxLlvnLlh/t08VbO2W2NDE73gQ7R1OfpRQHrGWsth449E5MKxX0Z?=
 =?us-ascii?Q?PhC5UGjJoxJuxjc31c96Jb/UGZL6BmdU8Ke/tc/VVYDVu9KkCnuOrNBMbybe?=
 =?us-ascii?Q?I1oDoLW2tuBhJD0wNEopf3j2IGOcvzbzcXP9c4R/+fj17QhJ06OzL/jjYlLY?=
 =?us-ascii?Q?oK31agYP14vouWS/lhVtxjmV5pVOQc2xLdLEyL8RRcQYXPR12hFGn+voyXK/?=
 =?us-ascii?Q?u3LJsbqMsKMmH8+e/ZdQaHrenkkDdfWafw/CxlC5YgHFQKdTfnTJtezOVcc2?=
 =?us-ascii?Q?NZhixHbgonT6ftHcKD+1Ne4EDAbLjVrMd9KjCdcBfqE45Ua7z5YK97YO0fzU?=
 =?us-ascii?Q?lmHpxkSp1zddyY1DgSd6jznkxtKbojfyiVHQHShk0OdPwou7pWUh9ScKpAab?=
 =?us-ascii?Q?LnNpZKrbwU6NE1RgjELbSf8D46Nz9MWIAKpWsWlLlis+HZJ+FSunXcooZ4zi?=
 =?us-ascii?Q?aCrxABNZR8efZ56jb1E6839UJVoVe+rN34CPq3Ddcl0hfQUJrYazPgmwuOTG?=
 =?us-ascii?Q?KM7/aD7Id3vWlJzLTuWsKHULjYbMZHnld+a6PtFuPPXbg7iuFTR556j2dN5t?=
 =?us-ascii?Q?sjCyV/Qxp3yPLEsjJ6iDwx6Na3ZKY2/oBL/Hz1RBXxuYR6azloenDaFGHqnm?=
 =?us-ascii?Q?fHzYFtQfBiD17dRnG93PmEXkItR0NYHySbH1/f6HyWQ+AlGQZmxWIocssHXV?=
 =?us-ascii?Q?PVUynk+VKKgWuHEAdvOB1NYo6l27y84NGBAtGBnfXi/xbnTbXniYCYJ/mWC1?=
 =?us-ascii?Q?gQLCoS8LI9ckFmKo2kL1/NmKc9BfC/fCdNgl9yl+/JrtD1+oyCLXMwsQFwJd?=
 =?us-ascii?Q?g12tMiP8vU7Fr7RRarZyuAl9dcs/RfAzrXei+E3BpPJZyFHJMtACtG6svQoo?=
 =?us-ascii?Q?wUVPbKUbEhTabsL7xgMsk5v1tpdJ+d6CVs/LUY0omCF0vdBWYpsCzW9L5X08?=
 =?us-ascii?Q?aU6OwQIPUpxltmVoT/funVggK7Sm8OYGdSTmgytUeKkAKdCJA4gTbW73m2k+?=
 =?us-ascii?Q?1P/CNzLNfnX3hEjo+KYETguAR3MSB8EMn+jsfULK/CYzhmeeM2ZquSJs3Ilu?=
 =?us-ascii?Q?BNxyqyadVN5PTwvz24bKIQ1BrFMx+TmSf6lIbkSTqrxbXGSZhvHFZcsIGuax?=
 =?us-ascii?Q?CfZ/+MpFGya/2Z9CE/gCTUALoAZZ5lzVUU/iZAw07K+MKP7KEfkETTK5PIm/?=
 =?us-ascii?Q?FrDzy9OITwIUqiI1iNyBkQOuEmKwMmZ7HM5Dh5mTod4w5QmBGJqOouV0TPwI?=
 =?us-ascii?Q?o8BkWbzwYwRLhXsbTsdVFhpOdW+SCxdqKCSjCqlzGwQPoZWjl6dGDD+OO25s?=
 =?us-ascii?Q?wiKgpSAhIYFioe2G9vu1BW4cfoJOhEog6RrR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Soev8aRdec6EypYYPBPS2gqy69QBJ0JQv+M1JK29/q2K7fZuTHKk8fh2iDWQ?=
 =?us-ascii?Q?EeyDSD2HzJTuEEYpfro2dEAABnr7pTEqmd3SjCs6/4uhdXCJLHly+lA8WqyL?=
 =?us-ascii?Q?kU69JSX93I+3jx3LbFL0aK9qx9Iv0gEVNd21uemtTZBcqhQXlToN380uzKoE?=
 =?us-ascii?Q?UgltcVqZjBu1Kfi+OAWgzw388ajEXA54+RhAtqomiowqMv6qSDlDNouUGl8e?=
 =?us-ascii?Q?hmr+1B65h9GfjYay3yX5sS0Xc4iEgI1A0fSnsuj/6+v3LA/sxfLICV/q6vLR?=
 =?us-ascii?Q?LLqcBzH60hC+FTIUqisUtfVgZzoCOHr0ltdFysBNxRKYw2Cbpcn6UuZmScqz?=
 =?us-ascii?Q?NDl0yDj2OumkiDtH4Sis4cncikzJFz+nvHMhhIcvgwL31LoC8520WpxP/NRU?=
 =?us-ascii?Q?K1PpKYlxGnA7sviEX9tOA6VYU5gJBZe/WftPSOgGh58xjeZGsF9g73qETXVC?=
 =?us-ascii?Q?EhWTlGCT2d9meHNGGlk8kxIq4n2t6oRn/g1koaF5aSoV+hKEQdoDb+pm3d3f?=
 =?us-ascii?Q?fqoWoFGC/vuWhBhjjKKzjsuxxoBOSWHvVFlsaxDBPXhHHVpZR4XSO4Y8qwug?=
 =?us-ascii?Q?bROAFB5W2m4DQ5Ajl1+B5gK74f1FvyVW1Tyv9GPsfXovD54ku1l+WELCZWeR?=
 =?us-ascii?Q?B0w5eXAeBPVru+MSU+vgHHz3KjtKlJDkPSPDzVDhBYfhY7a4aWKTF7Lq2SRF?=
 =?us-ascii?Q?Yi+ynGqsBuLN0hyu5nAtd79HJyEpk67zy40AFop1E/XmcwL8qvwAHuDK0RCU?=
 =?us-ascii?Q?+e10GM/xQremN5FkPCpm9lRnKpA//Edm3O3CeEEyCYIVVUHc6iuI7jpoIqx1?=
 =?us-ascii?Q?ql53fS0pk5QEbjg34IZIBDndLIpE/QYPgP9joOKm4kctRnAJKY5f8Z8PL6aw?=
 =?us-ascii?Q?0yScA8NBNW9FhWCP7pmyBWeOUv2H4pRnTHn2uB6a5+qyRWHFGB7EGFpVYeeJ?=
 =?us-ascii?Q?9c+EkJyVVu1uKfCe6wYfCvfCUh3g4xjGnW+cWbKoX47tuOQy98ZMQiiKo9xL?=
 =?us-ascii?Q?zc7mgNz6hkLvztnb3DK4YgofjlzTY9hYzxhq5WENaFEBrPabSC0f7L4i5x2v?=
 =?us-ascii?Q?kb944piJeVpg8JaNA53c/3Hvu5szcDgZYBAASbjrcCIKlABEjYtiNiFScg30?=
 =?us-ascii?Q?ZQVM9hTvyAI6k07OqbjbSOGZIB3s9vHHQoU4fOCxQbmUD+tFMqYaecxK2Yu0?=
 =?us-ascii?Q?PfRciyw2CFRdxMoFm0X9YGFz3PCV4YWHAxZhANYZvNtK1VRUmemPAFOfNJbW?=
 =?us-ascii?Q?X/bFwqadjfP9W0Jq4SWx/ai7q8cAKz/PWM/sfIDMHpDLI8uZ4fnwBtxEuKLb?=
 =?us-ascii?Q?WJDw2B4SRITzWohyP3/sy9eAHLgI4W6D9tQ1Yj7EbVEL2mHssccdyPIr1wNQ?=
 =?us-ascii?Q?oskJtw7RfYiIW6PtcIJhNC8HTfYnnyLthlUxe75SfrA27b1S+G4zdYDCvBpI?=
 =?us-ascii?Q?8hvIYOTGbbuqSyqxx5qLVRd2y62ySOsY3pr5B1V41KQax9B6oLviBovuPm5T?=
 =?us-ascii?Q?UMaON8Nvl4uXpfrhjPsjKqjSn90hcYUycP3HRnoEHdX6Q/AgS6mjIUlxboqP?=
 =?us-ascii?Q?mf2+e42NUza+N14Eq6ug7W+BqfQx+gJOqYqAs1II?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f31638d-77b4-4976-66ed-08de1c5913a8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:50:04.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6lblrwhBLkxttIlt4qtJA5RZ+YoMxqHJLagmuXkiHgKONn7jsxDji6ZQo5PujKGWLtVqnRsNDoIgD0ttiUc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10770

Introduce Kconfig and Makefile entries to integrate the nxpwifi driver
into the kernel build system. This allows the driver to be configured
and compiled as part of the kernel tree.

Changes include:
- Adding WLAN_VENDOR_NXP entry under drivers/net/wireless
- Defining NXPWIFI and NXPWIFI_SDIO config options
- Creating Makefiles for nxp/ and nxpwifi/ directories
- Registering nxpwifi and nxpwifi_sdio as build targets

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 39 +++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..4d7b81182925 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/nxp/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..0c6b3cc719db 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_NXP) += nxp/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/nxp/Kconfig b/drivers/net/wireless/nxp/Kconfig
new file mode 100644
index 000000000000..68b32d4536e5
--- /dev/null
+++ b/drivers/net/wireless/nxp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_NXP
+	bool "NXP devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_NXP
+
+source "drivers/net/wireless/nxp/nxpwifi/Kconfig"
+
+endif # WLAN_VENDOR_NXP
diff --git a/drivers/net/wireless/nxp/Makefile b/drivers/net/wireless/nxp/Makefile
new file mode 100644
index 000000000000..27b41a0afdd2
--- /dev/null
+++ b/drivers/net/wireless/nxp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_NXPWIFI)	+= nxpwifi/
diff --git a/drivers/net/wireless/nxp/nxpwifi/Kconfig b/drivers/net/wireless/nxp/nxpwifi/Kconfig
new file mode 100644
index 000000000000..3637068574b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NXPWIFI
+	tristate "NXP WiFi Driver"
+	depends on CFG80211
+	help
+	  This adds support for wireless adapters based on NXP
+	  802.11n/ac chipsets.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi.
+
+config NXPWIFI_SDIO
+	tristate "NXP WiFi Driver for IW61x"
+	depends on NXPWIFI && MMC
+	select FW_LOADER
+	select WANT_DEV_COREDUMP
+	help
+	  This adds support for wireless adapters based on NXP
+	  IW61x interface.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi_sdio.
diff --git a/drivers/net/wireless/nxp/nxpwifi/Makefile b/drivers/net/wireless/nxp/nxpwifi/Makefile
new file mode 100644
index 000000000000..8f581429f28d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2011-2020 NXP
+#
+
+
+nxpwifi-y += main.o
+nxpwifi-y += init.o
+nxpwifi-y += cfp.o
+nxpwifi-y += cmdevt.o
+nxpwifi-y += util.o
+nxpwifi-y += txrx.o
+nxpwifi-y += wmm.o
+nxpwifi-y += 11n.o
+nxpwifi-y += 11ac.o
+nxpwifi-y += 11ax.o
+nxpwifi-y += 11n_aggr.o
+nxpwifi-y += 11n_rxreorder.o
+nxpwifi-y += scan.o
+nxpwifi-y += join.o
+nxpwifi-y += sta_cfg.o
+nxpwifi-y += sta_cmd.o
+nxpwifi-y += uap_cmd.o
+nxpwifi-y += ie.o
+nxpwifi-y += sta_event.o
+nxpwifi-y += uap_event.o
+nxpwifi-y += sta_tx.o
+nxpwifi-y += sta_rx.o
+nxpwifi-y += uap_txrx.o
+nxpwifi-y += cfg80211.o
+nxpwifi-y += ethtool.o
+nxpwifi-y += 11h.o
+nxpwifi-$(CONFIG_DEBUG_FS) += debugfs.o
+obj-$(CONFIG_NXPWIFI) += nxpwifi.o
+
+nxpwifi_sdio-y += sdio.o
+obj-$(CONFIG_NXPWIFI_SDIO) += nxpwifi_sdio.o
+
+ccflags-y += -D__CHECK_ENDIAN
-- 
2.34.1


