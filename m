Return-Path: <linux-wireless+bounces-28598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 182EFC3540C
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15E604F03FD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58E313520;
	Wed,  5 Nov 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MiQpRkC/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072483128D7;
	Wed,  5 Nov 2025 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339818; cv=fail; b=D9B8X41bNnEoAQCTomno6kNSzkSMUIUQI4up7trSCFuu9wd7H1DK3zRjnmUhHcicgaxDKgj1Jb42tiMJ09VgLRE9v8tYUozPlarKyQ2HgOhaWuLKDaUm/8U4tmf4zbs2XjYGxC++Z5/v3J/xPzhQ0292TbErBrc5DXER/eFO8Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339818; c=relaxed/simple;
	bh=ieQHswewcI9vmb8elMjvb9rtcS2vWi2v9KGUQ1S1aXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZ9WuvLfDqwoxPOrQWbCuQ9I77I0yxj9B3JxN16yvPoEFf/Z8xW6LMBh4+eXUuptl8ApXp0vitOwazutPJL7ikscRwRfbbTpoZfPyfLLTqPCyaQg6DfFS6PG/M7AWp5gvqgWFtkPUssVYORG7G++dos5hve8qH7ixntwHyNmxcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MiQpRkC/; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNdZx6YO8FxqDu+iTh755e8wnpTW8VFfZBdtM2HxHmXw+upnwOx+pDjQh5VpNC7lRuu+0l3UdhfEX6cTdy0c97yqXsHMJ07L8FgRQpRDdgqPvlMjXFEqF4U0ePr8Pn4oAdGW8G8JTRjtqyu1u0mbP9qjJzP9AO9lEaMhau+aKlVYUs2yl4jpNF0UiTXcyrWNBlqtsiq8AFD5rzMZVlme50jGbuiq+Q7qkSMhSkX8nZvUHkhI/sQNGwlgPWTvDrhPfsQLBH0qscCQK86sZsgEhhq+cC2l6uVE7yseDq2sa3O/urY162TUYnI4chCqbr0OG/2NKSa4bS8aQKcmk5TWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ5ZVipCRed0m6CzPGXErZtlBMAEKkk1mh55NVngcoQ=;
 b=HgLh1gle7q/Pa61VxJM5QcO+AfzmhcWmxsVUGvx6LJhflt7CebTPofZy52ZxXJrNZv5eBb/yqmLWrsPd2C8NRWgCZ/QGR916Pyd8aoG/HdPT6TramdDDXyDlXB2mb5HMnwb3YqpQbm+7qWVTNnKvj6WVq2GsLeg/VMqHWWSlISdGKw9ImoVUA5uaHEUYcW2nTJdIvF/Az91BeoS8WIe3IWNLnS/+xG/V4hl3+ynSrE+3eiQ24A377o/Y3AMzxEWzuKSpUS6vjCkp4Hira1/WhUx7r+51SB9HAEMw5wqhT7QOtewHUk/OpT5PIvgcV+FfZWqrgOtqM3Q5bQauAChDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ5ZVipCRed0m6CzPGXErZtlBMAEKkk1mh55NVngcoQ=;
 b=MiQpRkC/CwtW8at52FS8Js2dG4aUqdI1feo/gBDsWR6kWbZs5Hhrkgq6XVVAaSm7uoojewRaMwDmYATUO28E/moHP/zoAvNPMUHkLGDRYsNLOBC5khRqOcRVp8tUJmwPZ2GKu2VbarhaI0vrwBRw6CWgjPote7+B+toxT5rRcNgYPjBVe5MoxEi9dU+xxu8iJQ/mU9IjIwEpzlEGwa/JZzePonAZS1KV+9hjaLP4ugiq4qGMYlf/hKC2XKuc1UJVNPrF1eW5MRw3G5rN4gEawY9mUntx9nqjA21lz8cyXRpy+uYwxPd2Ao/TbI/8laBnrhOUmK1O+IGjb6mAVVoYpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 10:50:01 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:50:01 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 20/22] wifi: nxpwifi: add NXP vendor and IW61x device IDs to sdio_ids.h
Date: Wed,  5 Nov 2025 18:47:42 +0800
Message-Id: <20251105104744.2401992-21-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b56c834-43a6-448f-9677-08de1c5911de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e9ypFmtv3T74Ivd0BlSh3jkGHFYtN6wl4vVDLxC9KBLiuIXgE8itnfKaUO7I?=
 =?us-ascii?Q?BcjPipsLBuqr+UU647fGjRPVw4hqn0LyCY16HCyYhpfekHgt94Wnswwe5pM6?=
 =?us-ascii?Q?YF4PmfEJe09/o/mgcwcmFJO3grH3rGW1G8bH7Tg5h+iPINFpifHhaJ230jsU?=
 =?us-ascii?Q?pC28GS9Rnl0FxQiyK1eHNtc5Q0u2Yf87Pipo2j5GtQtKVdZqNH5QZ5eWTA3/?=
 =?us-ascii?Q?OqEeaa24FTRaCAjYe+DkWALIz+kbYaviStb47qyKJ5tKpzlc8T4G7ZGjyuGI?=
 =?us-ascii?Q?k7jpzdYQg4CZ/2GUm6XPEpWyE3cV483hGxWOtLK3dTe2v86aKYtgQoun/ncg?=
 =?us-ascii?Q?pnI5Od9v4ClEGTCJB4JvgC6YO5OaVGB9RI919YpypOBwFX7B46JGfxO9G7+1?=
 =?us-ascii?Q?/jeLs1cdcH99D+OCh53Rnhnn3SR0KEHButw3sZPGzlx7m1mbJ2geY8NBsDTH?=
 =?us-ascii?Q?qn1KuKnqlj4z6F6cNmu4vqHurQdFtNURoVL502+84KcGpH/QboklIb3rN/wO?=
 =?us-ascii?Q?hECUge7E4sq8lAtbs6PnnIqMNGAALDMup6LskiCes2cAX9spcofX/LzZvUjw?=
 =?us-ascii?Q?tzSu/sCklLReefiAwklZm+KhHX/c2is6SDuy+zzCn4+sMwCIq5GjnLQ6WKk2?=
 =?us-ascii?Q?7GppjxXhKDdyDKicpTnJSbVRq2hAU9/8E4FXqnl4P7e1BqNtPcdGCeX5TJlt?=
 =?us-ascii?Q?8ze96wWki+SdQobzHCehhG14KuwpUh+3T3bgn6KA9kiV4B2naIS6NYGOwy1T?=
 =?us-ascii?Q?iVaRZmCEuEHa2Az26OJWdYj+GwUxDd8W1dHoLmToC/MK0u90wN8Pe8ImY+RR?=
 =?us-ascii?Q?OVwQJ/GoXw3uvZx3RPJwNkeLE7ZJG8fUVhL10JPhFihRd/SgdwPR5LGs7bDA?=
 =?us-ascii?Q?gBlB813fytq2EzIRUaOOh9l14jzLAZofutMewjR/mmagFvr8LmXlJEUPXmQD?=
 =?us-ascii?Q?fKzLTbZq0LjjB0CXHtMh8cuAv1+SQJGpPhmUX8xq3jEAdSe42DPIkhD5zjc7?=
 =?us-ascii?Q?A0bIgnNd6I7Bf4pYyIXCaS8KsqTblF225CvPKBTe/94JMsGrmhvVlGx/hzQq?=
 =?us-ascii?Q?qeKeokXG79oQCwzGwWXmwpxfRFkPD4dt3zLCfa6YVsLFune6Zzwq2jCIQZ9H?=
 =?us-ascii?Q?BF92N9LKqa6bponPOABbCO4+vJa/tAaD1LWT2OhN8/ryfqqfahZL16fIm0Lv?=
 =?us-ascii?Q?hiCf0ZzygdJR2EX8dDaXmO+mPbceRYslGtMp+I4C3YX5KgCgOv/w52EBPbka?=
 =?us-ascii?Q?zx7Vu5AIvPL9yx5Vwk3kA7G2g2IGp+nWZ7dc64o1bwg83JY6YOIwMPeiagPz?=
 =?us-ascii?Q?XWTe86U3RD43NYXK4SzOcjBST1Q5plNy6okShcV2V9n2irr4hIS+WNlJ5FGa?=
 =?us-ascii?Q?rVZ9aGDJcFOiufshGomIy436DeO0nzgNm/ag3/pYTsl0mMGYjlJSpjzhoJ0b?=
 =?us-ascii?Q?yCZF0WE4oBU7Lm5M8+0Pdd0c5NU3RkfdH2I4iFot7WafAQHdkFpqhkFfC2rv?=
 =?us-ascii?Q?6B0mPJ2qQ3TVsYjjiPeqdPNS3Kol65pUkkTs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5MjyTKyCLhetS/Y863n8YiynMck1Sn/N4P9NqJPMtFUcRy9GeiDhWubNlhZo?=
 =?us-ascii?Q?AQo3LoiKaG0s2WarEBtGaKP8OMB44Svz+MvdLzqk1zvK96chige/L0BhL8oU?=
 =?us-ascii?Q?MLjkLmLoX5NvSde1N+BnWJZj074kBrcKtc0NNuFwr28PTIuQ028oFQ3BfyYE?=
 =?us-ascii?Q?NslnWlhmQI0kSHSLUtAjLYP+omsjbgZppUGisZpMMzn1yJw21YaPEqkC5cKq?=
 =?us-ascii?Q?wl8h7ILeSRBjJDUGpCk80VG8HL655Jzkjvq8J1YBCkZByj4nCfzlFwBn+K4j?=
 =?us-ascii?Q?L/012dkwWfl0kWPK65bSyvjy4zR9N70Km3PoDwABB+vZgds7cWDeQvMKIKjc?=
 =?us-ascii?Q?JSxyl7I78Kk7sIyD10sm8oHePdKZ43m4XQtugfNxYfeQYJ4UcF2GWvG0yc0+?=
 =?us-ascii?Q?ytc5cINR9fqm4VWKtOe2YDjlRAdZrDMNpNLGjNDiV5u4lLV9Fj7pKMf5upuY?=
 =?us-ascii?Q?2Y/dXQR6rojnzf0bBvPqddV9cwRGs2TKkIjGZ7vwmw80rIbAtDwwaMvy+r9/?=
 =?us-ascii?Q?vSoOCELmKZ5BszUxbgBUyR4PkpRZhzxOZcbGSxiySF+/iCjK1JyTkqO3IBZR?=
 =?us-ascii?Q?BSVucgyAcyknT1KgJ/Vw6sCGPIaY1wVOLHM3URT01q+VA752mWkmYoQCRSQW?=
 =?us-ascii?Q?1rhaRQHfXDB00g92FeU2lCK+QyPIrxLry6g5kFbG7Ia5k4tGTLO0g4utzefO?=
 =?us-ascii?Q?eMDObkt45vgFJZB8+vs56PAc9o26ErRYzwlUkiEvJoD2yL7b7ZPY9DLy6Aex?=
 =?us-ascii?Q?EHpuxS8cRpT57HGY8JDZlrHO8Wz03NjCwnAGcYD6rql0LcsIvBIYNwrEAUoo?=
 =?us-ascii?Q?LQWy5rvOkQFGLE14yUHSdrk5KW/cGBm2Uf/Amw9TnC+To6Bh2+4Gz9DB2OG6?=
 =?us-ascii?Q?+5qwsf2xqjOCuY9rqxd4JyXhKnQCHPmHOeOc5qVV4hQZBzgwyDZtjOinV5ge?=
 =?us-ascii?Q?38yzDmXCY08/BiINXhjPGvOyKGqMSPRdiyFejTgB1Wofmn9QvvzNrmrQPlo9?=
 =?us-ascii?Q?Nbcg7prFpcnSln9rZOubEUcOVN7ekVVfy8g2yahy5RpF5sbmk5Y+2qw+Yj/Z?=
 =?us-ascii?Q?tPc/Yjlml6CD0ri4Qhm3ilfPk9XQ9m3veiLw4dTxSsrL+xT6toha+iMAW4kw?=
 =?us-ascii?Q?EPWrT2leYkPoVuClsPFnl+l2zmMe0xljDzSwyVJ6PmUudl4WuA8OWDMEBdgh?=
 =?us-ascii?Q?/RDEEDylIuzQ13vyufi7FDfx0GOTwtj1Yqr8OGYzyrD7AUspzYyHyUedvXRT?=
 =?us-ascii?Q?A99lvmG9w5gO1QHuVNnJ3r++EB5UCK7t/Gz51aONiyUzw+x72OoUilwuMQAq?=
 =?us-ascii?Q?TLM7KL5ZHlL/mh0WZPZw3cbv8FfOGMLx4IUSO5lhR4P3R7iEXSkSHa4OI1Em?=
 =?us-ascii?Q?LfoLRvQTIMOqvUFN7ahDULHansvqhFAsyARN1C25u37EzDZ+H0in/M0UdCqa?=
 =?us-ascii?Q?gCob+98PiD3/qkbsqnCJ8SCnC7itcm0n01F1aMTNC55Sf4Kr8WbfLpSFU5de?=
 =?us-ascii?Q?Ul17vQd4ViIgTSoPct9rVwaXOXq68p/K0qSQgZLRdohR1pq+bNPVv5qVx/lo?=
 =?us-ascii?Q?qt0TeinbkiUJcZwQw8WuyXic7sQvCK7kpVW6DLHX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b56c834-43a6-448f-9677-08de1c5911de
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:50:01.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF0LwRp/ZeWbgjsPrzzM6ZcRUOeDDlW3m1hKZA7XHaxOakHdGeA6Scm9cmmB+V1LIt5lgV+4BS5szmwUNsCKkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10770

Register NXP's SDIO vendor ID (0x0471) and IW61x device ID (0x0205)
in the global SDIO ID list. This allows the nxpwifi SDIO driver to
match and bind to supported NXP Wi-Fi chips via the SDIO bus.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..39ac2b612e4a 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -116,6 +116,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.34.1


