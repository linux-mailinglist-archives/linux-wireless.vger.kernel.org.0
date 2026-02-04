Return-Path: <linux-wireless+bounces-31557-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APqxIeiLg2lWpAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31557-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:11:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E91BAEB753
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 19:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39C13082D86
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EFA428479;
	Wed,  4 Feb 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oVfgw6ZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E642316D;
	Wed,  4 Feb 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228333; cv=fail; b=K6ss9C4g8brdI6gUZQOoEpIzQzdhQDEHT77NR7epyVRZrwBLQj3nT9AzrExepVSx/s2K4H94NwpGrn71GgMHLs1ozjB+O4Xzu5PAW33DOBy8tB8GV8ja1FL0qzGx8N1ydZVVq3dFLpXhXK5akhUPFT3Y9ZKsdAadYoFyq/Xf33s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228333; c=relaxed/simple;
	bh=HVEFDZf8EwBk0JvLvJTj2fFDiCE+LBK7RfovK1SONKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oq5eAipH/2IhFHKllGFqbZbm3VuPpkQmQEUAX4SrlKKhcjk0LoPmuxAnSRfugmXNb3F8ukOh9AVHxsc23mY3zqBKRmsPXbVvAWMo0ZGB+4qdo/GoPK6rNVNAnPFhUi2JZQIF57tx/ABnWqwf4s8TqPPS46EInxA5WlE6zODmTG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oVfgw6ZW; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oeb0y8u0LMIBz3SB7KCfWcC1bGmRtuPAMxjOFlaDwriKmZWPxgsfr7gOxj/KjA7Lj6zA2OAcW6+Op+YOdwZKBPq1CFbD48w8PvL4D+0z9iAXGAQyXhjHgODcBV/0gbN3xrN9a5wETDAscEw82JcXM/F1eMHYcBQmJ5ODH5zfHg2v2V7wYdQjzUZ1LWLievyS2NJeyEzz7u263Sdt+fvZOj/bXAxJkD+wG7Xh/h2EIfHxSqRo2+Dky38Og9Yrr+ummnl9Dmdg0dKC5AfG981NPu8QfAjS+EQDrqnbyp2qVc/hzzbZU8dQaLbmkvcRmHI6QwmjFi1EJb0LzOWVKiv74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcSPYBv7x2jsowhnfO/nfbNx5GB5FOGBDfK5Yoad+eA=;
 b=l1XQekPSJftR/np3NcaL3OwS9tuWk3UEttpsBL/TrbZBTACNUc+P8+TdKg0T87fb8AJnuZZ+S8RTjgGMCd3OzJHnSpVUMltBYjx5htJSl3JFHJObgl5NeXfuwabudXhWnznGZHF43b+BS35DedrI6kEP+rpTlSV4mXJ18XtpbXLIAP4XgjlZ3ZPxli92fTJrbWENdrl13Kd5ZsKHbmSwRZSXAA7buoSKGNne4/Ab+MoJ7xd/RllGM/OajsOBtY0cWixSvq0GkyJjigb+hInj7KyWb2i2ZXXfMJGpjq5n2GFkGI2L8cj1eg1ZPVWzWwluexvApNawJ2+iOQHg/G1oMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcSPYBv7x2jsowhnfO/nfbNx5GB5FOGBDfK5Yoad+eA=;
 b=oVfgw6ZWMWkHKUdk87YVk8+7bVHem4QLz36887nM4cikY5o7HfwgAKJ9YhLmLkSCCQYZuW5MPQqV9QLTEbBkBJAhL58TOxFuNIme9Uz9LkqhHFe1kbSSU2kUzTsUI0Hm4LMbwM1D+3mu9Nf5v/9GC/2nywnhDIQpRfmXJklP3xgXPCZ1V1LZfz10HFDps0cWtHBVtb4K7RHkI9NM/q+dtxdL7OQJqNI3PwHlsIfDobaxq5Eq/r5vtlRlJTISE4Wr8C9/16w2WDf9AgS87R9mfxeVvc0LTHDIE3ve8+x/ORY06SqgLSVDeNQ8nzqS2sZ1gs2tfm1OxnhZ65Pi2Wc2QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB12314.eurprd04.prod.outlook.com (2603:10a6:150:30f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 4 Feb
 2026 18:05:30 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 18:05:30 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v9 08/21] wifi: nxpwifi: add channel/frequency/power (cfp) support
Date: Thu,  5 Feb 2026 02:03:45 +0800
Message-Id: <20260204180358.632281-9-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204180358.632281-1-jeff.chen_1@nxp.com>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB12314:EE_
X-MS-Office365-Filtering-Correlation-Id: 354097b2-28e8-4bec-0a42-08de6417fb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXP4GqXlYQOM/TaTY9hMpwgV3F4mNuJ70P8/6xHjxsETa6kf88OGByNp3gzC?=
 =?us-ascii?Q?hPanLuQxpRQ52o+97/K9UHxDRyVUibuozZz/6fd5N6oYj6HUUeSy0f0CGrRF?=
 =?us-ascii?Q?E5MPgbfjXShRv1mEoddqGhSH7hDNJ9SDN9W2rRfGxhQj9SAtynywIvGq4Xn9?=
 =?us-ascii?Q?h/h8CCvv97NEz3L1vH3Fv9U8XgdPF9/iiu8qokdBTLAp7DdkMjWRpasvSmVk?=
 =?us-ascii?Q?PxxkipKirD+0hKgE8BI24Le6cH+S0KRPNXIHcgk6+P7EgQLwxwRkAdXwYbhy?=
 =?us-ascii?Q?aqhBQNPzcLg/Adq8zgrdZlBHdAY4jvh5TFvBcsyAf2BZvUw7k4BIiqEwaSKs?=
 =?us-ascii?Q?Z4Ip6Auo7/FC2I6jt/3CoF2gyRccIPnCM6xLrnFzbBli5WouOkBDXWNY8l8q?=
 =?us-ascii?Q?o8vKUSv64DzfXu9nrIVw2Q2yRpl0TW6wgruEaAA1y2oS3I7YOdubDZnD+FnG?=
 =?us-ascii?Q?t+8ZByoyJqOVwS9ZiIyzH/yK9bWmM5R5KkBm77ahIXmfvGQNUioS8E041e58?=
 =?us-ascii?Q?WPqY6ZlHEQwqIlw9WQAKEzVcOKl21lCUM0k7JDpDbOXy7Nc/fbXJNn1XNfIN?=
 =?us-ascii?Q?oxK2/65cnPg+aJYFe33sagyUHMhmLPtejNip4/YO4E7fOAPwjCT397Qvy1SR?=
 =?us-ascii?Q?xs7f/Dj1IJ934XtLB/WyHlDP5NjH0yM1uJF064s7NnEAwHPR339cdq3N4452?=
 =?us-ascii?Q?NGULIjUjHBxx00FD8GYTfcrbLHZOtRIN0nTgMXPMAheqXz91Nz22Jeov6PCm?=
 =?us-ascii?Q?JKNtFc+0jXmEWi2Dc8cGstu0JW4qgxqpAaD7ZIWU3oRX+kzJfZpl5e/SWqnp?=
 =?us-ascii?Q?7o2NV3wBCc6ZlCT0Vl8CZ+8WKOcnUFsuvTgjLqCf0GjLchapvUvM5iqQ3WtA?=
 =?us-ascii?Q?phH0AlGPYCSzzjkhbpF+ifYsusKbQ+f6BgY0yykBiaFxfPGVgtJdrIbUsntc?=
 =?us-ascii?Q?T4zm9u25nKLnC19+Im8bBvoztXWlENwvOfLOKulZZ/CfpvwfroejbyseuoEq?=
 =?us-ascii?Q?GAupuehBeFYuZGTrCBMI+JgCGrS4xbynW4TAZiYqjKVwZYUzQoguOtpQY3Fo?=
 =?us-ascii?Q?whRK9QrKGKAHDzJj7ulvdANJMgbh+zXYOIwRBSoqfNyP3f8mOR32A34K2Dd1?=
 =?us-ascii?Q?gC3X8UpThAl6FQ2vKTE0Wtx4TDPjkwSBVExG5qgIz91V5Q82tJYsZaXhdc4X?=
 =?us-ascii?Q?FoMLGFCsBPnl8SbWWYrjw5ec0TtHJADyk3AMyFGjKxsqsdeRkLlRLGXZKTt7?=
 =?us-ascii?Q?NfTfF9pv2YyN1LZRw4Vc3VsF7T/BsY0WDVXNA7jtRsrc4/GqWusDazEF78WS?=
 =?us-ascii?Q?rNvJzBuZq/luBKtCvx1x/EoI2jF+a+IG/5jJ73blopHd5l88lJvOYUurj3BS?=
 =?us-ascii?Q?gNFum9sCzZStLzw+0uiExDSparSkAy0BAxrVvadgI6AFpqjrZkEzTFiklm/5?=
 =?us-ascii?Q?xA7S6nWnVhuTpqb+m9kU8LmhRQ6+ohc9z+p9a1pb//AEifSMkN73DCm3ay2f?=
 =?us-ascii?Q?StBOyPsAeDP8BfVJjLDkpG7cIQfnndHC02vK0B2f5FxywdAONkzikhHXgT3x?=
 =?us-ascii?Q?x911m0ELv8tYHfILGCLm8kTicAdBsa/8FL5QEfBmKkEGcYaljQ5A+q6k8nkD?=
 =?us-ascii?Q?Irk6uN6A40uDDne7OrR2ZfE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sWACDKeVrpW/OHAdHAb2HpW7Nno3ZJO8NXoadC2dR8JzYwbRwmQd7wOwQmTo?=
 =?us-ascii?Q?pv8UcJGKmTQ3mdUtR0BpfqNAnM649pc26bRRqG97it+1gsmOi7uElcysPNt5?=
 =?us-ascii?Q?MFT2I/K8nTM0hP6nxwuumGfqS1C+SVcXyxUdS3En1c2P1vQLZCi2jy2byYrM?=
 =?us-ascii?Q?e/I9uMxGcTTs/s2Ot1M/YGYl8PCTDpauWnJIrl9AiIIIURWHMtrpJoy7ZpZQ?=
 =?us-ascii?Q?cxcy+kFc3i76Y9A6X5FNMahG0q1rnUbUn3nm3qOQ+Bd10fafgB1DFh1CANOm?=
 =?us-ascii?Q?OLWDBU/7L+XJdt/m7hJmKPdxEdCD4JwJ5hv96fegPY2A6A8fOImkJg7q02iM?=
 =?us-ascii?Q?GzNklQLOZiBMc95/R1+YKKUYOlx5CYvwaFha21LrIagQa5WTH7yD/7k2HPL+?=
 =?us-ascii?Q?CI50vzr0pzLWXAGKMpzeUFSyV1WpLR5IaULScU3CrSox3RXKtaSNMFSZf4ve?=
 =?us-ascii?Q?o/Opc+8uBYMW81HDzHay+Pf9pDWb23nlRHph1fSsfL34uP2Ns1/5exbGUZ1p?=
 =?us-ascii?Q?d7fIU1uy6ZIaYBCgxFqXcD1+DPXAtD84aro5nRGM9Y97pxiTfVYLF7WpcTmz?=
 =?us-ascii?Q?v5P8ZRuz/TjsblFFMgTY3Ztb9Z/wvaUYiUU+7X9noWZ0huKXSjbzI/90WgIX?=
 =?us-ascii?Q?LKjOKsOJ0vC1q3mLOkVJhkskZ+tRv52KuqyBT7fuMb0IGu+tlLRemzDpDk6u?=
 =?us-ascii?Q?MJ2UDD17kR1cnnjlCk+w7rujRp4znyU61SmDjYQpt72xzRx1n/b6muOW2fIH?=
 =?us-ascii?Q?yZdg1M2U2xfTRm3c6gaiaD0SuB/DBMOHInenihnfV+2ti3S7oq4gfHHEi/CL?=
 =?us-ascii?Q?3Uv0GAe1ZVP1xVpkJ7NCduiEPA2giZngLeFQuyf2LipSgb7PYNEYOAo5yp3a?=
 =?us-ascii?Q?f5iOoY7DlozSAA7k24YcCTlpTvKstMk8tdTsiSfy4QKRo5/yqC0k9Lc5/1I2?=
 =?us-ascii?Q?Ly9m9gjUqtm5Hh5y1DYctW9V3KQeBEfPSLPDiPRL5NdflZ/ENc2RcQ763txz?=
 =?us-ascii?Q?1CFBZ5bikUApjgB1na2dlW0Kh+ZYrHhfkCGUK18T1x1Vy7T/LML2je5hE1mc?=
 =?us-ascii?Q?pGAgFVa8QQqhgSKBs5QlmogefqsHs6ycf1tvRK0sCeIbEjzGglKnYpSsEE0l?=
 =?us-ascii?Q?HxlGCP4UOkDhITteaDK6oZv1W19y8qX2++CVErBA3QS9zJX8b0bz/2o9eH4+?=
 =?us-ascii?Q?vO5gqYKoZf0TBSR/+XXDtW/VYSx0+wDYp8bl5RzSs4/QWEeh6+mYcSDLUEAy?=
 =?us-ascii?Q?hlY5WMGSBjJiZavZvuylbrbF3CfAIXbJITipAqbm0jh1Oca5c9LLbeOrlhra?=
 =?us-ascii?Q?Ol8LOwQBWzJmxtPs1kqSNfVH2RBzi5BqpollEqQ4UglGIEWhVPJThgGAU9h5?=
 =?us-ascii?Q?moUhN3W4niZZuedmNLraZo5O9DjbVTPZ9XLeEADyllUQl4mZRjboVUvgSTIb?=
 =?us-ascii?Q?rkd32KmOg+blzQUXnHDD/LLiU5/iaK4dIMnG4u+KWT8N/3FEIR2jO5O/QAZp?=
 =?us-ascii?Q?c/rgp0xolVhMJn8IsXREePPoB0E25pd3aPyJ3yz0cNfvV55BWA3KcTqt2LiU?=
 =?us-ascii?Q?JtGpGEaIjiWLDBUpjllgfw4grJmVqQjI0QGmwrtsw6WgwNtDRpieACXlj0mz?=
 =?us-ascii?Q?LkPDWTFX4c0047xOQkhA14akesXgt14jAN+lQggVp7ZNGQ926X8fIWCSB4vv?=
 =?us-ascii?Q?7rHJL/xoii0SSJCr7sNOOxYuHIcLdR8W48qUkRSNpwOrMIJWNkKFMXobrA5A?=
 =?us-ascii?Q?EKudVPmWGw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354097b2-28e8-4bec-0a42-08de6417fb96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 18:05:30.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUjxJXpEmcfxTy9ufAP6vMpjNSP+EZ7twY0+Liv3D3KnCZBEVZ0W/75ofhnTCFRwfl4HoM0TEFUtnkmZDT2r/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12314
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31557-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E91BAEB753
X-Rspamd-Action: no action

Introduce cfp.c to provide channel, frequency, and power-related utilities
for the nxpwifi driver.

- Defines supported data rates for 802.11a/b/g/n/ac
- Implements rate-to-index and index-to-rate mapping for HT/VHT formats
- Provides region code to country mapping for 802.11d support
- Adds helpers for:
  - Determining active/supported data rates
  - Mapping channel/frequency/power (CFP) triplets
  - Adjusting RX data rate index
  - Extracting rates from cfg80211 scan requests

This module serves as a foundational component for rate control,
regulatory compliance, and scan/join operations.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfp.c | 458 +++++++++++++++++++++++++
 1 file changed, 458 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfp.c b/drivers/net/wireless/nxp/nxpwifi/cfp.c
new file mode 100644
index 000000000000..e4adbeb6a09c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfp.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi: Channel, Frequency and Power
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cfg80211.h"
+
+/* 100mW */
+#define NXPWIFI_TX_PWR_DEFAULT         20
+/* 100mW */
+#define NXPWIFI_TX_PWR_US_DEFAULT      20
+/* 50mW */
+#define NXPWIFI_TX_PWR_JP_DEFAULT      16
+/* 100mW */
+#define NXPWIFI_TX_PWR_FR_100MW        20
+/* 10mW */
+#define NXPWIFI_TX_PWR_FR_10MW         10
+/* 100mW */
+#define NXPWIFI_TX_PWR_EMEA_DEFAULT    20
+
+static u8 supported_rates_a[A_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0xb0, 0x48, 0x60, 0x6c, 0 };
+static u16 nxpwifi_data_rates[NXPWIFI_SUPPORTED_RATES_EXT] = { 0x02, 0x04,
+					0x0B, 0x16, 0x00, 0x0C, 0x12, 0x18,
+					0x24, 0x30, 0x48, 0x60, 0x6C, 0x90,
+					0x0D, 0x1A, 0x27, 0x34, 0x4E, 0x68,
+					0x75, 0x82, 0x0C, 0x1B, 0x36, 0x51,
+					0x6C, 0xA2, 0xD8, 0xF3, 0x10E, 0x00 };
+
+static u8 supported_rates_b[B_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x16, 0 };
+
+static u8 supported_rates_g[G_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0x30, 0x48, 0x60, 0x6c, 0 };
+
+static u8 supported_rates_bg[BG_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x0c,
+					0x12, 0x16, 0x18, 0x24, 0x30, 0x48,
+					0x60, 0x6c, 0 };
+
+u16 region_code_index[NXPWIFI_MAX_REGION_CODE] = { 0x00, 0x10, 0x20, 0x30,
+						0x31, 0x32, 0x40, 0x41, 0x50 };
+
+/* mcs_rate: first 8 entries for 1x1; all 16 for 2x2. */
+static const u16 mcs_rate[4][16] = {
+	/* LGI 40M */
+	{ 0x1b, 0x36, 0x51, 0x6c, 0xa2, 0xd8, 0xf3, 0x10e,
+	  0x36, 0x6c, 0xa2, 0xd8, 0x144, 0x1b0, 0x1e6, 0x21c },
+
+	/* SGI 40M */
+	{ 0x1e, 0x3c, 0x5a, 0x78, 0xb4, 0xf0, 0x10e, 0x12c,
+	  0x3c, 0x78, 0xb4, 0xf0, 0x168, 0x1e0, 0x21c, 0x258 },
+
+	/* LGI 20M */
+	{ 0x0d, 0x1a, 0x27, 0x34, 0x4e, 0x68, 0x75, 0x82,
+	  0x1a, 0x34, 0x4e, 0x68, 0x9c, 0xd0, 0xea, 0x104 },
+
+	/* SGI 20M */
+	{ 0x0e, 0x1c, 0x2b, 0x39, 0x56, 0x73, 0x82, 0x90,
+	  0x1c, 0x39, 0x56, 0x73, 0xad, 0xe7, 0x104, 0x120 }
+};
+
+/* AC rates */
+static const u16 ac_mcs_rate_nss1[8][10] = {
+	/* LG 160M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 160M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 80M */
+	{ 0x3B, 0x75, 0xB0, 0xEA, 0x15F, 0x1D4, 0x20F,
+	  0x249, 0x2BE, 0x30C },
+
+	/* SG 80M */
+	{ 0x41, 0x82, 0xC3, 0x104, 0x186, 0x208, 0x249,
+	  0x28A, 0x30C, 0x363 },
+
+	/* LG 40M */
+	{ 0x1B, 0x36, 0x51, 0x6C, 0xA2, 0xD8, 0xF3,
+	  0x10E, 0x144, 0x168 },
+
+	/* SG 40M */
+	{ 0x1E, 0x3C, 0x5A, 0x78, 0xB4, 0xF0, 0x10E,
+	  0x12C, 0x168, 0x190 },
+
+	/* LG 20M */
+	{ 0xD, 0x1A, 0x27, 0x34, 0x4E, 0x68, 0x75, 0x82, 0x9C, 0x00 },
+
+	/* SG 20M */
+	{ 0xF, 0x1D, 0x2C, 0x3A, 0x57, 0x74, 0x82, 0x91, 0xAE, 0x00 },
+};
+
+/* NSS2 note: the value in the table is 2 multiplier of the actual rate */
+static const u16 ac_mcs_rate_nss2[8][10] = {
+	/* LG 160M */
+	{ 0xEA, 0x1D4, 0x2BE, 0x3A8, 0x57C, 0x750, 0x83A,
+	  0x924, 0xAF8, 0xC30 },
+
+	/* SG 160M */
+	{ 0x104, 0x208, 0x30C, 0x410, 0x618, 0x820, 0x924,
+	  0xA28, 0xC30, 0xD8B },
+
+	/* LG 80M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 80M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 40M */
+	{ 0x36, 0x6C, 0xA2, 0xD8, 0x144, 0x1B0, 0x1E6,
+	  0x21C, 0x288, 0x2D0 },
+
+	/* SG 40M */
+	{ 0x3C, 0x78, 0xB4, 0xF0, 0x168, 0x1E0, 0x21C,
+	  0x258, 0x2D0, 0x320 },
+
+	/* LG 20M */
+	{ 0x1A, 0x34, 0x4A, 0x68, 0x9C, 0xD0, 0xEA, 0x104,
+	  0x138, 0x00 },
+
+	/* SG 20M */
+	{ 0x1D, 0x3A, 0x57, 0x74, 0xAE, 0xE6, 0x104, 0x121,
+	  0x15B, 0x00 },
+};
+
+struct region_code_mapping {
+	u8 code;
+	u8 region[IEEE80211_COUNTRY_STRING_LEN];
+};
+
+static struct region_code_mapping region_code_mapping_t[] = {
+	{ 0x10, "US " }, /* US FCC */
+	{ 0x20, "CA " }, /* IC Canada */
+	{ 0x30, "FR " }, /* France */
+	{ 0x31, "ES " }, /* Spain */
+	{ 0x32, "FR " }, /* France */
+	{ 0x40, "JP " }, /* Japan */
+	{ 0x41, "JP " }, /* Japan */
+	{ 0x50, "CN " }, /* China */
+};
+
+/* Convert 11d country code to region string. */
+u8 *nxpwifi_11d_code_2_region(u8 code)
+{
+	u8 i;
+
+	/* Look for code in mapping table */
+	for (i = 0; i < ARRAY_SIZE(region_code_mapping_t); i++)
+		if (region_code_mapping_t[i].code == code)
+			return region_code_mapping_t[i].region;
+
+	return NULL;
+}
+
+/* Map supported rate index to AC/VHT data rate. */
+u32 nxpwifi_index_to_acs_data_rate(struct nxpwifi_private *priv,
+				   u8 index, u8 ht_info)
+{
+	u32 rate = 0;
+	u8 mcs_index = 0;
+	u8 bw = 0;
+	u8 gi = 0;
+
+	if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_VHT) {
+		mcs_index = min(index & 0xF, 9);
+
+		/* 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if ((index >> 4) == 1)	/* NSS = 2 */
+			rate = ac_mcs_rate_nss2[2 * (3 - bw) + gi][mcs_index];
+		else			/* NSS = 1 */
+			rate = ac_mcs_rate_nss1[2 * (3 - bw) + gi][mcs_index];
+	} else if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_HT) {
+		/* 20M: bw=0, 40M: bw=1 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (gi == 1)
+				rate = 0x0D;    /* MCS 32 SGI rate */
+			else
+				rate = 0x0C;    /* MCS 32 LGI rate */
+		} else if (index < 16) {
+			if (bw == 1 || bw == 0)
+				rate = mcs_rate[2 * (1 - bw) + gi][index];
+			else
+				rate = nxpwifi_data_rates[0];
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		/* 11n non-HT rates */
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+
+	return rate;
+}
+
+/* Map supported rate index to data rate. */
+u32 nxpwifi_index_to_data_rate(struct nxpwifi_private *priv,
+			       u8 index, u8 ht_info)
+{
+	u32 mcs_num_supp =
+		(priv->adapter->user_dev_mcs_support == HT_STREAM_2X2) ? 16 : 8;
+	u32 rate;
+
+	if (priv->adapter->is_hw_11ac_capable)
+		return nxpwifi_index_to_acs_data_rate(priv, index, ht_info);
+
+	if (ht_info & BIT(0)) {
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (ht_info & BIT(2))
+				rate = 0x0D;	/* MCS 32 SGI rate */
+			else
+				rate = 0x0C;	/* MCS 32 LGI rate */
+		} else if (index < mcs_num_supp) {
+			if (ht_info & BIT(1)) {
+				if (ht_info & BIT(2))
+					/* SGI, 40M */
+					rate = mcs_rate[1][index];
+				else
+					/* LGI, 40M */
+					rate = mcs_rate[0][index];
+			} else {
+				if (ht_info & BIT(2))
+					/* SGI, 20M */
+					rate = mcs_rate[3][index];
+				else
+					/* LGI, 20M */
+					rate = mcs_rate[2][index];
+			}
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+	return rate;
+}
+
+/* Return current active data rates (depends on connection). */
+u32 nxpwifi_get_active_data_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	if (!priv->media_connected)
+		return nxpwifi_get_supported_rates(priv, rates);
+	else
+		return nxpwifi_copy_rates(rates, 0,
+					  priv->curr_bss_params.data_rates,
+					  priv->curr_bss_params.num_of_rates);
+}
+
+/* Find Channel/Frequency/Power by band and channel or frequency. */
+struct nxpwifi_chan_freq_power *
+nxpwifi_get_cfp(struct nxpwifi_private *priv, u8 band, u16 channel, u32 freq)
+{
+	struct nxpwifi_chan_freq_power *cfp = NULL;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch = NULL;
+	int i;
+
+	if (!channel && !freq)
+		return cfp;
+
+	if (nxpwifi_band_to_radio_type(band) == HOST_SCAN_RADIO_TYPE_BG)
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_2GHZ];
+	else
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_5GHZ];
+
+	if (!sband) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: cannot find cfp by band %d\n",
+			    __func__, band);
+		return cfp;
+	}
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		if (ch->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		if (freq) {
+			if (ch->center_freq == freq)
+				break;
+		} else {
+			/* Find by valid channel. */
+			if (ch->hw_value == channel ||
+			    channel == FIRST_VALID_CHANNEL)
+				break;
+		}
+	}
+	if (i == sband->n_channels) {
+		nxpwifi_dbg(priv->adapter, WARN,
+			    "%s: cannot find cfp by band %d\t"
+			    "& channel=%d freq=%d\n",
+			    __func__, band, channel, freq);
+	} else {
+		if (!ch)
+			return cfp;
+
+		priv->cfp.channel = ch->hw_value;
+		priv->cfp.freq = ch->center_freq;
+		priv->cfp.max_tx_power = ch->max_power;
+		cfp = &priv->cfp;
+	}
+
+	return cfp;
+}
+
+/* Return true if data rate is set to auto. */
+u8
+nxpwifi_is_rate_auto(struct nxpwifi_private *priv)
+{
+	u32 i;
+	int rate_num = 0;
+
+	for (i = 0; i < ARRAY_SIZE(priv->bitmap_rates); i++)
+		if (priv->bitmap_rates[i])
+			rate_num++;
+
+	if (rate_num > 1)
+		return true;
+	else
+		return false;
+}
+
+/* Extract supported rates from cfg80211_scan_request bitmask. */
+u32 nxpwifi_get_rates_from_cfg80211(struct nxpwifi_private *priv,
+				    u8 *rates, u8 radio_type)
+{
+	struct wiphy *wiphy = priv->adapter->wiphy;
+	struct cfg80211_scan_request *request = priv->scan_request;
+	u32 num_rates, rate_mask;
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	if (radio_type) {
+		sband = wiphy->bands[NL80211_BAND_5GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_5GHZ];
+	} else {
+		sband = wiphy->bands[NL80211_BAND_2GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_2GHZ];
+	}
+
+	num_rates = 0;
+	for (i = 0; i < sband->n_bitrates; i++) {
+		if ((BIT(i) & rate_mask) == 0)
+			continue; /* skip rate */
+		rates[num_rates++] = (u8)(sband->bitrates[i].bitrate / 5);
+	}
+
+	return num_rates;
+}
+
+/* Convert config_bands to B/G/A band */
+static u16 nxpwifi_convert_config_bands(u16 config_bands)
+{
+	u16 bands = 0;
+
+	if (config_bands & BAND_B)
+		bands |= BAND_B;
+	if (config_bands & BAND_G || config_bands & BAND_GN ||
+	    config_bands & BAND_GAC || config_bands & BAND_GAX)
+		bands |= BAND_G;
+	if (config_bands & BAND_A || config_bands & BAND_AN ||
+	    config_bands & BAND_AAC || config_bands & BAND_AAX)
+		bands |= BAND_A;
+
+	return bands;
+}
+
+/* Get supported rates in infrastructure (STA/P2P client) mode. */
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 k = 0;
+	u16 bands = 0;
+
+	bands = nxpwifi_convert_config_bands(adapter->fw_bands);
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		if (bands == BAND_B) {
+			/* B only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_b\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_b,
+					       sizeof(supported_rates_b));
+		} else if (bands == BAND_G) {
+			/* G only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_g\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_g,
+					       sizeof(supported_rates_g));
+		} else if (bands & (BAND_B | BAND_G)) {
+			/* BG only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_bg\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_bg,
+					       sizeof(supported_rates_bg));
+		} else if (bands & BAND_A) {
+			/* support A */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+		}
+	}
+
+	return k;
+}
+
+u8 nxpwifi_adjust_data_rate(struct nxpwifi_private *priv,
+			    u8 rx_rate, u8 rate_info)
+{
+	u8 rate_index = 0;
+
+	/* HT40 */
+	if ((rate_info & BIT(0)) && (rate_info & BIT(1)))
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 +
+			     NXPWIFI_BW20_MCS_NUM + rx_rate;
+	else if (rate_info & BIT(0)) /* HT20 */
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 + rx_rate;
+	else
+		rate_index = (rx_rate > NXPWIFI_RATE_INDEX_OFDM0) ?
+			      rx_rate - 1 : rx_rate;
+
+	if (rate_index >= NXPWIFI_MAX_AC_RX_RATES)
+		rate_index = NXPWIFI_MAX_AC_RX_RATES - 1;
+
+	return rate_index;
+}
-- 
2.34.1


