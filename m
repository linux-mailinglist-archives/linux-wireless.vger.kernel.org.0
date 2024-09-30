Return-Path: <linux-wireless+bounces-13302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE3989AB1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4372833DB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E20C185E53;
	Mon, 30 Sep 2024 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ra0Cg1i1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02D183CC7;
	Mon, 30 Sep 2024 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678323; cv=fail; b=hLiQcplL86ksUTteM+ccLNO0llHrHKwk56+hYFPKfb6pNM+dFPvhFIsKM4827rFT/l8wQamNJfEiO1ynfLOYaZS4fqGinlMPiswGNrdAlf6fmPhyhvcY7ZrD8ukl9lJnKitBLcSQIAHC+pQDOXmAmw0gwgTYfnLYGIftq9xfumY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678323; c=relaxed/simple;
	bh=phzpkL3hvWwhFAZK9c6zhaK0kDiACcLy4HEF+9VaZBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ceZpJ7YxZ1wmBcR9Z9XkFjWr7KLESkimQsK5tu2RcJzJsIoPYpVYp9mDfW5ycMgQ0+nXrW+lHQek54h/IiC5lYqRD5wqGH5DSvaZj76DDHQRQmENkQ7+Pil+hNBykNkI2YxbNCDpBX9HTz+lgi+4ynudXpsE+I8VJxv02jSSVUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ra0Cg1i1; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbKpSCQdkn3Dv8ZIg8ddfL2cet8yjsApLoly6mT/amrEDPZgJHIBXRsqOWAqKTVPVxQny4VxqZyw8io7qZKzbKDud8bpVKmfYO/zbE2vF8Na2y+AEugc5vkTGUH2urYNhFe4gWE8nJCp54VKj8MdNiJ702eWneXONbxJ5NwjLZPQh0ptgACrhvo1eqJZz9vsw5LAD7BAJrZ99L//e1o8KnNyIrzGHqwSo5kBfNNxYICn+NzK5CUvBEzcya5/RiQYKANvE6/BdFuOxnSqtA56c1mza2LeNlKO98Uj8K1sOqcSeeuS5a4moGmXiBklFUJAn0mLHa5kx8VWqvoXGHvWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97/Xe14j3xdA5vSNX4xd+D6m5GBm6YuqYlLUoXjUL/s=;
 b=B11IMPtCaz6togZ2aVOolobSfpwX/LEQEy4D8bo+5Mbib9sqXCWGRGOqbiVYikrzD1REITfvX1Z/HnrW+DuyI5umB8IFGe0BzYdg6JoxjqFrHDjhcoPxI5Q9HcFsrbOBLoqOJs7dmR/54gjV7wCF8jOxc4Z9K6WK+FMwdrMr389avD97/kKtTyIOZ8iXQXhVZNE0nO5nxEvWI/WIBfIHJJG5NfAHZaWljzu889ELIqBPxD/NAsSEfFGf80E2NMrKJmMrGGe1KXl+PXTU7Suk0VQ1c/0iBy6SrUHMOEQ31ihqDDy9jzawG2PaejKnQdtKap00EWtnDxkveHTrdAGyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97/Xe14j3xdA5vSNX4xd+D6m5GBm6YuqYlLUoXjUL/s=;
 b=Ra0Cg1i1baQzU8u1wOWs4G+RsPm9+8THCP/f5XjTHAxDNFd2I46sf1ck5odTiikT+pJrAo6FsMr5E/JnDZ20G0M12Pr8m4eK0a5mr15T3nOC00BVC8k2nitXBS5Hj5haYePUFeMRu4pYhwOvp85IGKrt1yeZo2uY8B9p/iqA9vN45XCK/s+dj2LzY4X/bzCouyA2pBonDKq2MdQ0TSf3lhfXBeTKU//xRTMlELgVE5evCT9vW83LZUClNQ/aBECsoQKM5npeQyIMP+Cgwgitu992bwDSNm1bIkiTbY2oV44dP5Xh8XFNE2UJOPOTyhSKAJf68lwsVF36ephtA3Wghw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 06:38:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:38:37 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 22/22] wifi: nxpwifi: modify MAINTAINERS file
Date: Mon, 30 Sep 2024 14:37:01 +0800
Message-Id: <20240930063701.2566520-23-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|VI1PR04MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efd967f-7d11-4781-1e18-08dce11a832f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sr8b8UoKZllS2lnRF+VWoP9jKOKjN+Hg645oT4YdqsFU5KvscpFTwA+Z6E1y?=
 =?us-ascii?Q?XQ21Hb396T1DGayG0v5UzbJKu7alsDVZZItb2SsiWxw9lOmuOxgyfv2+Or7K?=
 =?us-ascii?Q?UhG5i1TSVJmfgU4fH57Kvyf3RT27+YMuHca9vJOAuW0oupkK8ZPqvjcM0Y0Z?=
 =?us-ascii?Q?WtDqyc9g3BFtw+Jqks19x/m89PNPAhHFVD830nLiyIOEEtIYhcAkMWuYi2JL?=
 =?us-ascii?Q?2XD4Fie8FdpfFPCc8LDPSm0C8l+JRzctRtX+Vv64lVHTuGrQzuLOx7ycYUHN?=
 =?us-ascii?Q?8gpeqABpdbNI8WkQdarmZhNZlW9Xvyse8iSs8/CecuL4k2yKh0cY0l6fvJv+?=
 =?us-ascii?Q?F7459E4YapbxoGUIppdCldTRNz3FkRUWvlpaVwklFwOUTkVqF3YF30NEBcdv?=
 =?us-ascii?Q?5JPbdsRpiOyf25jEdUh/5iFQ5xEU5S1fNtIhLLF905BJhHUBIv455mxwji4u?=
 =?us-ascii?Q?5eaN4Ywme3zEXZvxP2cBzEUwXBeonVH4etPEf9yplx/bUULYKktPfUJnwWz+?=
 =?us-ascii?Q?3bcJZqCvcK61bEIgbFj5Xrz39WM7RM5uFanB0KHezJqRMM3Xt57m3qLzZ7SD?=
 =?us-ascii?Q?8MgIGWus2xFxoglepDSMElHdGEhckzVek7++fyB5KerMTCHZfQCCUaHQOl6w?=
 =?us-ascii?Q?2OWNZDAEABld2dK0zk7INGVNY29Gkkj8g3vCoZslhOHORjSJVe573tF6xLMW?=
 =?us-ascii?Q?LkKzJ7ZRTU4a9bzOOR6RqeZLXRSJEYa3A7krZapOosmpQ55BU4JWEsgA6nPy?=
 =?us-ascii?Q?w8Xmmn48V4p1EFJxLPbQtoJ+yRCMtOmFYfyCwZyAy4lxr88CZPDDCmk/Km8C?=
 =?us-ascii?Q?ReB3SGSbhnpxX3KVC+6W0K6T1Gwot3i78knBWtanjtb2azLBEO73W+3exNBM?=
 =?us-ascii?Q?y96I6iGFxbUSH3Dcw4R/ihfrJLdY6tr8WC2eHtSJznCqMLmVPBkJoWj1O4xg?=
 =?us-ascii?Q?oRz1A85XOza0nt1OWmvKvlJj2uentcA8Fo798VDVZT+vEEezM4bH7+TnBtoq?=
 =?us-ascii?Q?CzpTC7uRbkzHohzB4VTZt46GCWToediqJQPr7O97hZN1WPwWP1QSF7m/6Ljl?=
 =?us-ascii?Q?5NBArVhEA16Ew7M2rjYVtjNtkkhHMYUSl4TiLF/p5Lxb+XQfpQlv9X3ncHmq?=
 =?us-ascii?Q?VD7miWzrSZqvLp3U6GHmZt6vJ2tKVrEu1zgbrtKe7Uo3m6lwnvTy0U5S5Bc7?=
 =?us-ascii?Q?dDrlzEWpTL4U8kGVfufc6BlpH1VD7/+7lvSX1PAnMyNnKkvlKS3bhZSm4B4k?=
 =?us-ascii?Q?iEMMKjIs5JacbZETVGtvO7Hp2WMdmrVeqv/Eskae/hImNHTK+CvXvJbKqQQm?=
 =?us-ascii?Q?FJEGQjudfvbzLpvA7U7uXqLcKnkGlsHkPjClhKMXsdprgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QfuMISdBeeDP8zEr0pI3S5+ibnk6RkLNIXxSLVyeiXM6DUXW78rn6cKauPge?=
 =?us-ascii?Q?7VdZsF9NYkrasx7fPKQrrN4m82zVJM7vS2LDXm3i9tm+0O7ywg7M0aVlhXBt?=
 =?us-ascii?Q?cB9m8VJLDqg+rB9HSipTK2cE78Amd807lNoly1OJmIH0B+RYol0wopzBw0Jf?=
 =?us-ascii?Q?OBAoOqFBsLqa6yxQwBzmIQWoTAhVv/Qy80SAwZSvGMPw3Xz1sWyN/Y8jKA1V?=
 =?us-ascii?Q?NwrAuZdjQ5K2U1Hnz+f/poqIVYzWc81olQ7w/EQ3aRPGfGTg3iUi/V57Ioxj?=
 =?us-ascii?Q?qD85V2m9dUpC5Yl7qJLAH8JWWwtcApnpi5Yn31jVVCok1AroLym/1eWbyOkS?=
 =?us-ascii?Q?ClxSjQcp+qTWr+8nrCnzm2PC6ewBkfnZ0G0YLIsbymT1KUbjwOFyA2/w50f8?=
 =?us-ascii?Q?6yao7YiTxzTRhiBrTKFjEQrGhU2BjuHLPQ/vjDjDuasEAl4jxycd5Ly9+nK9?=
 =?us-ascii?Q?0l8cMtvn7ootMYrW1NC943zS+Xs89Go/jnHza4ehsMZqqNcFRplO3Gp0EInE?=
 =?us-ascii?Q?ivIoe0NruqxPMoU44gUPPjn6mWxrvxyIP655whBfYZTXJf2O99OxwOXnywSH?=
 =?us-ascii?Q?gdxl0Ak1GTxMzx7E6RoazwiAsudQlBQ0hAvjMHfzEQrSMP1PEwMOkeI5KEkQ?=
 =?us-ascii?Q?h30r9L0UgCaVKk8x8cL26jwJnR0mW7LH0S98uS+UM1bbQqRLcm+SkKr33q3w?=
 =?us-ascii?Q?tRYBo6ulEvPtryyJOGUWXwPeCwlekDznA78yPJ7yuswFhAvRHjR/Zu4GnUPv?=
 =?us-ascii?Q?zGj9K03DXQnumF2MiAl1RVVi/ni7pbztfIM50ia/zchmhUOc9PYwFuYDBk82?=
 =?us-ascii?Q?CSqUqhVQFYTP2TcJBUv9LsMfuW5tckmv/4Ljd/ZtU7skhD/CbNzx2G89pL1R?=
 =?us-ascii?Q?Ger0qKCeeEjYpiwUj2eqcCBzHXmUJWZK7hKPAKXvfzusjUb106dHX2dWWB6S?=
 =?us-ascii?Q?+iipFfO2iWX1+tBVqWdFyNfNb2Q2+AVUpCdgIuG9DEjq2cHOneNrd6EAAzhy?=
 =?us-ascii?Q?AVfYDCcD6rCYJwmZr38DsCLEsLMhqm/RjD04jk1POHsV8hg2IOC9wXCp0vWd?=
 =?us-ascii?Q?OB7W0zzS1ANoCWCdhGIABchm6caaSC+cthyOtwqZv9Ubyd/zVEA+nvRn6p9D?=
 =?us-ascii?Q?rvxI05hRF31AtUcyaKB8nr6Na2rDi71YA9+R3yjtjb4PVtlD51xoYEydVyWB?=
 =?us-ascii?Q?okuvmH3y9yqUIZVFUNOJNJM6/Ml7/NzQZn8JeHikTyaP5X9fSZqpagBrGawd?=
 =?us-ascii?Q?xxRRJg18LBaP1WIgi0a2xawTKGDMaDFZjbQFOpsF+M38NR9P7NPc+OHBOdIL?=
 =?us-ascii?Q?fefQKQOmJFWI2vWr5MAIeXS6pUnHwf4fXWulezHUUCCQFU504wdhDJmJzVZd?=
 =?us-ascii?Q?K6sqJiTf5YZ4a5pWC/kOH0JtdM/a94KZar1y2FefIOYrcpaEDAcVeBRkgnc8?=
 =?us-ascii?Q?I/wo/1UozmYnoGaH804MezC4iX4sNDP7IUuRdF3tTSNZxDFOX5rbV2MlDMsC?=
 =?us-ascii?Q?Dm+CL+67J9JSl0nCgGmY2c7cQEtRxnV44YEN0iOQ8X4Q+gr3TmBAsIqSuqIe?=
 =?us-ascii?Q?AnTyBCtgkY33nfDinBn3s2nNrRigibm8U9/oQU9h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efd967f-7d11-4781-1e18-08dce11a832f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:38:36.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pHQBWFmF/32i+caYXvZKRGFaIY9jNc05pLEnZQ8sXubrNm0B1sy6GcFuhVRQGSiwKt+CI6OApVH2x5v7tMADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7056

Add nxpwifi related information to MAINTAINERS file.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fcd6f802a5..9846759b0c99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16526,6 +16526,13 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP NXPWIFI WIRELESS DRIVER
+M:	David Lin <yu-hao.lin@nxp.com>
+R:	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/nxp/nxpwifi
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


