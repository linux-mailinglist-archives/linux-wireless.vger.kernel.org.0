Return-Path: <linux-wireless+bounces-9258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AA90FB1C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9937B281F23
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E711417577;
	Thu, 20 Jun 2024 02:00:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F955661;
	Thu, 20 Jun 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848838; cv=fail; b=QfOOpZSGutSEICJrvySMu0i0duStg+M0qyYA3TwanLwXzLJSGEef1esS594/yia3xgnLiXUZJJlT6ezU58+ZwhQKXi7t9rqSoUxRf63ZCi5kJ8S9cvscdCJQ54jXBcAoNRbuutFf9iEz4CGXyQOZTOhx0l/GTaB6rqrsXqioDvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848838; c=relaxed/simple;
	bh=JKm7f4jtAY2sHDalCM2Xqolu/jJM4YRl+PJzHvyg1/g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sbcDzbVlAazDE98mUTNQRe+V4eQD908oCoFFLIQbl9Xyb8Da7c4w+d8AzWm4IqpWR7I/him6yVgtHBbm4xqPnckOKafEJq+k8MSQ22bJZ/Lln15y0QHhjNGEZge0EsdnsI2mFpXh9RaNWQ6r1BGNaXGk4FkojsVbkqnQOas56RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBUF4acAz3B65YztNFIfUz0JtE6fUcxAa8T+zh+4huBuWxP3FhJPyvuRI+Y9Jhc0HVJF6s+cpFzOtLrkwxavSJAXKlMjLLHJutl9DyPtEhgK5p278/0JbRk3+10Lwu1509Ghet20xHa2+XSfu5f64d4qUxvBhw3N1AC/meKSiO9AMhNGs+w6u/qduX51QWDV4Xicp2/ZJ8BW5BQmvIldB9OX9V7GYlB2eX1FxF8yqlXAFR2pGx1P8iYehhY3HO8kMl8/1CXjBmEZGYY1kXevk0e2vChouRSGIQju+zGjA2YETVZZRnKGgnPNLIdlhTw1Pb7UpmeJsFBE8AXJvOGBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqQ8qHXMRYZYoBjMnXVSeOC8ylMh6Wm1P1xNrZa7wEY=;
 b=ft3xekpWeZc8ayzBXnrt+xzhHN8WFlwZ+dDCj8BZc43aJfpZm6NaNpHiHyA+G24a9zUTKzHpA90CKX6lSkouVnb2JCUVmu4zyMrqJPjmGKzfYvZE4g5hfQx6zeOU81LrivURueQTdpCr4TX4rJuzVp1GqF96cFLXKQ0+1j0Meuq31eb8Wz9Pi0iIZTicAwGxfOVxbXQvwpyKJtcTbJ1Ue0oiRCIJUVnXmDwSBTwB5aQN3Ks3+G6f/tNVHgcX9nGYwy2Hj3Kk+q0wd2NWI9/yCdWf8Yrm7f0USxmhhyFljd3lqzklSQQICCRFuI4AlFwI/MszX138BLo+Q3kx2HsnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7323.apcprd03.prod.outlook.com (2603:1096:990:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 02:00:27 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Thu, 20 Jun 2024
 02:00:27 +0000
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
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nick@khadas.com,
	efectn@protonmail.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v1 0/3] Add AP6275P wireless support
Date: Thu, 20 Jun 2024 10:00:12 +0800
Message-Id: <20240620020015.4021696-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 3889ba85-1db1-4749-b898-08dc90ccc131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|366013|376011|7416011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lAxR2jw6iwKJiFeCw4eIsnByWKzxLa7D01B/RAeEm057039mQ0jRv5xPLm1P?=
 =?us-ascii?Q?mqXv9/4Zh/MpqaKByFAxSkeVf+yMViNWklV/ipVw/gW9VOPuZJy19m7YZei9?=
 =?us-ascii?Q?GsaL6cqkBTEYdQb7fTktHCopQiDf6bLCDUyLy/yXDVo21+FWO4fioEzQA9Eq?=
 =?us-ascii?Q?TDFDphpkPsqItWtlnGGAWxwFb5GHYTwSL/qJrvUoV2fK8fkMd+02xKKcz66J?=
 =?us-ascii?Q?nuNPp7JVSrb4NaCODOXcrnHtY09ZKY24tJcMdRGv9HwbPa2D9Yr90Dplii7P?=
 =?us-ascii?Q?DVP0tOps1o0PQ71Ys3jOXIldkDsJv5q5G2vgW790NvyJGdtYHSB2tMNSFsGF?=
 =?us-ascii?Q?3d91/DLN64p4Ggfw4bYTJo3CnQesfQNpys8dPY/fXmGkjlSDhJFsOiBEvWP7?=
 =?us-ascii?Q?9p20m41b42tRoavB880N7sdn9ctCpYluJ/leKfOQ6ycYJGWBzFeSAT3eZOFU?=
 =?us-ascii?Q?u3o5Yyij9W8ii3bayjitNGvcsTrJiCTenAum64+7TMJU2wpVKyUKsa8u3Nx9?=
 =?us-ascii?Q?tf6veGqxsnuqa9/UdW2c8S2EXUIaqymtrewJ/7A17BJdkGkWvkRxov588BAp?=
 =?us-ascii?Q?/o/gRnBSPLZHTbIuWeMu+fcSYtGihsCyv4PehpM/pxUah2aTdUAaTtDPqjlm?=
 =?us-ascii?Q?d6rUjK+CKtV6HcG/6rC5fQ7BKm3+KXklBMHRKgCd1MAsQU9LSjFr9YWsf7uV?=
 =?us-ascii?Q?FZsUN5nVIGMnGzz28odbGMW+Yv/LhGB+SayM8bFtooy4Ohg0GxX3czfgsY0O?=
 =?us-ascii?Q?ELf31Pmyt8AjO2HBEUCV4cJfXnqlZu28VY7BNuTOIH0gy8rLmNk7xcUvWih9?=
 =?us-ascii?Q?lkBPPz+I85QqqAP+CYWAE7F+6KgMaTegcAG2UkK0FewUVF6f5QtBqV/J8qCr?=
 =?us-ascii?Q?7tSQI/SblCNppp71DyiM2xMGRRHdLXzqrAyo2K3p3u+cDC1rwldBMvGH4+PU?=
 =?us-ascii?Q?B/wgH31fDV/FD3U2qD4oT+7QSm+Qe9XiBkpN8a+PqQwVU29LD7SqTy1SA6fc?=
 =?us-ascii?Q?NzfmcROuvslFbCY4SM7s05n2eUqSdJDMCHJbp0Plyw8sW9oa5be2RU3i2GwD?=
 =?us-ascii?Q?vc9NdpoDrbjpyb40B5yisx9h8nfHfi8tna9UQGQ1ywUAMDSQGWgwNgS32Lft?=
 =?us-ascii?Q?AquPGuvw4cLuIfgKSlOtnVxWju57Nxl9/t6hn74AITQTwNTjlV0AM2mYLgbl?=
 =?us-ascii?Q?fFID/I6fS2r1L3DjGz47kNUmgp3I0Tb1PC682/C2+3QXdEiZDVCjMPEPaVTI?=
 =?us-ascii?Q?oSL/198FyKzMQmUFLMkiTw7aNBH/uqEdTGvyH+P3yzH473w3QWoY+Fse7/iV?=
 =?us-ascii?Q?owWjISS70neLZG9vVfL/DWNde+mxk6pTcaq/vrHVfngVU+sws/DDhB5oZEs0?=
 =?us-ascii?Q?UWkuK80=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(366013)(376011)(7416011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CJ5tlaVlcIgey+U0emOdOwEaIzbAJE/0xXDJ5mI2VZuIiytZZ9aV4hZy3ktq?=
 =?us-ascii?Q?oPBmAKNIBXZQVkkwyAXXbg4eT+6TNC0jctO04FvObApYonwIXl9S6B6P7k2t?=
 =?us-ascii?Q?n9sk0JO+0pUih1gsTa3yIygrPuUmxdoDzxjoCIuC5AetO3RvQVYrOR4GlVz3?=
 =?us-ascii?Q?KO0GJ4s3dSp57F7dtRur2r2pJ0rbPRhhgMkws6+EDw7EZ/83ZNj2ABHSj9oU?=
 =?us-ascii?Q?/TB8+cNoVqwrEX8lC7yn6ZnfhUAy6GxD8JBCOWrGV86f6WLXcsADV14i5PZ3?=
 =?us-ascii?Q?UKJvARSmN2Nb1aUfTaR48mNmuzetQtfi0Ffp02fRV56sgfyiWh4SyA+WSBDU?=
 =?us-ascii?Q?U2tJb8e3SFhMc2aXhGKGNZpE2/hz5dtZPK7y+TNxAGXXjNxyT4bVIdBsf/EK?=
 =?us-ascii?Q?9iDxTmG5wztPW7ZDnwtlvZ0MWzessIAXPwY27A/oz4UsnrRG+B8SlZn7ZDvS?=
 =?us-ascii?Q?ItSBwVfrLg8pf2WFOzs521yiKl6UBwTFSiNTpCQIi52eGWmBZ/suAxQcOqiv?=
 =?us-ascii?Q?RsPAZRdpmIAIPK2MmUegpyOyA6RidOcwY94JUtbPO0+jsOjlYaK29UC9/sEI?=
 =?us-ascii?Q?DdAUggZ0I/EYTyIAI9sN45PUOw0YsWa7/j6ktWrHcAIjW0/uRarQANev65Lm?=
 =?us-ascii?Q?JxKRZqjtDgcDq+f9MaqFmgj+JrbqIM+q8WhWnky3WpPE01fHv5qbovarM5Wl?=
 =?us-ascii?Q?8HkAu2bYbNObwDlnhoh2/SBoFiI3crUhRjq4sC4+8W/viF4VvqqfU9HuOW8q?=
 =?us-ascii?Q?tA6qfJZs+XTConc/x80C5q9d35logM6HYGzjwN2cr5wDAPrlmTagetAoCZ4+?=
 =?us-ascii?Q?z+nY1dDYhMFAUiQdRE2o5s1ko+YlARKjeU4xON/lTYOUSmL79b8fUeqi+u9b?=
 =?us-ascii?Q?Taxh3dqHEuDbXbKKIsedrEmk0lRi4S/LV3Obca0JrMnPy+KzxOW68LpN6i2n?=
 =?us-ascii?Q?yMvXlNGohuWncKt0/3L3fZzgJoxKbxxWlUI+pluMNVIMTjN5xfBa4UcI2cQp?=
 =?us-ascii?Q?bqPBvTp4dkFv+0xrGaCgZ6E+xG3FxH+DAeq0Y9p3MNKAE8Ic+qbfmKiD/ROs?=
 =?us-ascii?Q?Xu6Gc/F5ZBvC+k98JW9MFWoUytGnvcRRJKFIlfHKQRXaoQuIzd36KYRRpfu6?=
 =?us-ascii?Q?Nmjo1sPmms1eFju/if7vYLp5BQIYy0Zkb6B7i1U7/NjyZQVrj8aWAxNMJfhg?=
 =?us-ascii?Q?otY1DnYC2B/jAGzfIbXsGTiXyLqnK9iQDxZ9oSp8GMPuFqm0ZGwRU28Q406P?=
 =?us-ascii?Q?JukR97HtSBBf2YYPt/nEwdo/nzU7EI3CKoeC4WYNalR1//8YwLRfoCxTwYAF?=
 =?us-ascii?Q?j7rEmSjoKEFFaWzkpO+Ld7FDZ/a2+ARgRsC8APXlSOldxUClSmCyXrBUM2GA?=
 =?us-ascii?Q?p+pb2xB/2C3DTc/NQI8nYn2Wi1z+ggomaWzAnx99CzzIZDJcQkw+wQ0+VJom?=
 =?us-ascii?Q?Lh+3ja09ACJnj+sivuSTuD5AgsTVAN5XTEoZ48oNf8yBxigUHKWpe816FX4w?=
 =?us-ascii?Q?JyamULlNmef8DUFjwC2CXIlqLJ7J9a95XtIhqx2qVN5vUYRUoYj+eqoCaAFA?=
 =?us-ascii?Q?92jXcrozkn2l/vMaxDK2AZIOE8gqdVhZ7cCwbhvD?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3889ba85-1db1-4749-b898-08dc90ccc131
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 02:00:27.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ar1eX1iXCxPk6KzxoC8WrGugXTlU1RzoeIa1VweyfRHFV/QpwsxQBrgSqwA6kdsOKDxuqQw+J6RBE7ct/47YZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7323

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock 
for Wi-Fi module and extend the hardware IDs table in the brcmfmac 
driver for it to attach.

Jacobe Zang (3):
  arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
  net: wireless: brcmfmac: Add optional 32k clock enable support
  net: wireless: brcmfmac: Add support for AP6275P

 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c  | 15 ++++++++++++++-
 .../broadcom/brcm80211/include/brcm_hw_ids.h     |  2 ++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.34.1


