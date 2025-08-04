Return-Path: <linux-wireless+bounces-26130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDF5B1A655
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0465E6228EE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694EB21A43D;
	Mon,  4 Aug 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XiHv1m7r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535820E717;
	Mon,  4 Aug 2025 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322322; cv=fail; b=aAP6WAHbDI39/Zsw3QCUoe0x/uEYd6dPt0x6kS7LEUI9JZeJ+CfYiYYfutoXJhByUKBpQp8tEd9kbr4/IWITdAfMPZKnbWjjVXj0TwWYjZjnlgm/8uKLDUhqid5SXpQllSdaM8OwvE5cRKVFMdd+POVJ1ASq1Cl/0FOljplRDaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322322; c=relaxed/simple;
	bh=jYacK3C8pZpr6AvLykBGVs2wbGtzryC55yV+LcGddQU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UwDVjqSbeholWG35i5HGoiVsh1Fs5supHdyJGOOr2I3BGDsgoOBwXA/nVB+nFCPEy/+n+0dVD99bD/KUf8rguOLuPPoqRMwVkifZUVaINRJ3fOkXW97ZgwsjbP4eNEVQBZvRio4NhOspIsD9dcOc/qwg4zV5MN3AADmd9n4Xz/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XiHv1m7r; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrxSGIxLhfyWL0A970wxpKjoHW6tPEJmuIEJaZmi+Ro09+tLI8ryTFoaXNvnL2zy+I7BtJKkwS8JgqMikkOtaaVj3Zw2csTERHAH089mQefey+PiTC6w8BPh8AulckVbHyhXEhrHV0IAvEo9lmhxNGlnahARaWHYOJf9XtfKk3enAPG7x2P0pLm7Aol2KetK6KrCLk9XLIBrF3JAgthrqfwVocB1G13a/LTcSai6AvAkRAho6kugJf51aL1wzws1BzPTZ0XTy1qqPHGuW347Kk3NScSyVEXqG76VqWk6+/JxFSDuSnRAKEx0Y7+uR8y6LpAIm0EsyZQoiPmyooJkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2xFYO1LC01Wcp7ftbKi37Ak1y2cQrT34puTF0dNWo4=;
 b=e3j9HhtuFG5yMaeA21ri1seFnyqM1B/mosLlauYlWBomh+e/3W3Bj7kv0XsHER3esZfNmOT0GtRoVyHwYO5SwV0OurTTczU+VDSmSukPo05zIBDEZjIMxYg4JKlfEw3QQlXBfMpZodIZTo0RhfBxTOUQSoDvnT+yS59OsFzAf9MyQBDCnYGz2tZTWHMN7OluA62deI+tu84bPQ+3JXhBTEWhOdsFLhzkNmj9GdBrh6qd6qSVPYThT3SFm/+11CTKyNc9JmznTwu2gNWt+QhCNowEwZr8ba+UuN7vPdQ5RfhsL9hkTVH0sqn1YTYUgo1mfLGQ142j8Uqbj02PciK4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2xFYO1LC01Wcp7ftbKi37Ak1y2cQrT34puTF0dNWo4=;
 b=XiHv1m7rBPcgTqrw3dE2ZwMPtb/ApPafSxLrGaZBzWQ1rWa0lvLM6aSp/nEjC3COOyFvm7+jbsWtV9jjyVtUUuvJNy5KwptQDqRHf+YEwW7eX38LN2MXUrdsWo/0cOtuatraw+hp2AHztJt7hPKkXuCr9YzRyBVY0loaLg0Q2y1mBwz2M2YD0O8cqq2mo89zeOt8GVpMtdt53bAFSm070htivwOj2vJAuf2ib3IFleLtAKb7Bw199bwCq2K9DkvHocLrRGH5xK/y6VoYfsjGKeqFSpSX3yspgU4KNP4Q3C7jF+y5l2CT+OptlAmtTqzKL8jPDOQQc2GcYIilVI4kgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:45:15 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:45:15 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	brian.hsu@nxp.com,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v5 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Date: Mon,  4 Aug 2025 23:39:56 +0800
Message-Id: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: cb56ac82-3417-4c84-8090-08ddd36de7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eujYaBhetYA3bBs4gb0c9W8hfM3ThD9PEWYOOpRGPf8Vw8O9Hvj6ETJyDma0?=
 =?us-ascii?Q?+WV4K6Zv1NFHVFl8YpatIxpGISPIyL8oS5EO67Y6D21KwB3M5sl4tuOhzl1t?=
 =?us-ascii?Q?7+890G9LbVEG8Y9vcOYoSY9IPvwqSyFdWKJvuvblD1PNcxcMvxhsOUdQP2KA?=
 =?us-ascii?Q?KSXj+jmsIlT5cCSaTgeTM1jVFGLwD9S4NATBVEGk6FNlQjfO97MrcT+FI/4P?=
 =?us-ascii?Q?B1FmAZ5Z3y+kYNC3bSXTiHOKcc+tS+12xrLX7UAaF5OfeDJFZdaLqh4Rz92j?=
 =?us-ascii?Q?T1cVV4PXBf9RqEVH7g/bwvWv23t9dI5jITq030/fL1WD9AWeel2zUcsYjqm7?=
 =?us-ascii?Q?HT4kbtd78zsZqjUG0d8AdX61+BqOZvXC8uAL+ccR7v2lxB/M/RQdE3FhAmN7?=
 =?us-ascii?Q?l6f3IF/PWU9hujGX8o/Q4/WreaLYl3gM4uUW2scSMhgiRlBKFQWxrZerki+4?=
 =?us-ascii?Q?tztuit+hhI6SSXZOmTwGgWa3jquNJSApU02r6OiMikdaKhXHUJZri+4wSbYa?=
 =?us-ascii?Q?qZlozqnZT+iTSQMvrvFWEwo4eyoidrdB+567/j8n6OYTM/3Px8o9nmq7JyYD?=
 =?us-ascii?Q?6saNlAEEyjJkF4DMtlWHnm7GniFWYBa4ZuAO8NHcZ8HzEuweEiyOa9HE+oJu?=
 =?us-ascii?Q?RIB3beIH+AU1oIq2Eb+EFn2oL9q81f+eCOd7mxq7/R3IT7PZ20Wtb0GkVFnv?=
 =?us-ascii?Q?XM+miXa8UWsUXiGDQHBDtmU1LfGV48TTvpRA/jc8PpgqCkGeWH+J3gdnep8v?=
 =?us-ascii?Q?88gOERtsenB+E+9LAcboLX/gYkcbiLqgrbk+P0ttaBjoVsdkikEcECwP4JCG?=
 =?us-ascii?Q?tLp/Ew+iCOJ7OtJ4/0Hnez4oQPsB8VO/Uw5nwNi/GojnrEPUmQpA/q1Y4/Ev?=
 =?us-ascii?Q?AeD2wsk4vNFiD6NNH2HyrP9CygJYAJREwfyk96oj4qh77eTpZ/tVpsfML9NF?=
 =?us-ascii?Q?dKsByLOm3pgLYsmCQSvEBQiHc6snFiAo7RRD4/1Cc0ZG9nxSZCerW7UbbPFq?=
 =?us-ascii?Q?pqxlPG602uobGfHZ6EzTXRCB1WqGzOEVeCJbdk3E5n2E3QUZXY9u5O+kgUty?=
 =?us-ascii?Q?Q6yIHA/X83/FtRGyp+cl8wTWehJGv4GD7h7AszSEvXhTRA3fjGq2GX7A5vAP?=
 =?us-ascii?Q?32A9UB2xAP30oK4aBLiQThyyBL7HT/xf3qq+DcwNjIUF8BOwn7BN1RNwHp2B?=
 =?us-ascii?Q?aLkMJaahu423SEhfVriZIo7wb+0t1ymS7hbfmCTWoolC+1a6iW5P39D2eCfL?=
 =?us-ascii?Q?A/lozDYL/FpzjIGafihi4ilZ9/z32A0O6wkQwO4Fl9pir1/Ps4YG60vo3LBL?=
 =?us-ascii?Q?gQ9ECyA7KDJkpUhZNvmZrJ11t37owZ8tf5iFxBMYXUb/A6x7m/G1egXFNZDo?=
 =?us-ascii?Q?iGCg/9FrxxWdNVTr9pFoo8zuV7E/drQNDjGVYmGak/DYrgWeTkLICZvXycYu?=
 =?us-ascii?Q?Fbq3cA437mQ8BtIv9FJSXoWTimYV+S/Dzt28nCezcs17VWKJvfYxXr3jdzcT?=
 =?us-ascii?Q?mNOOisQ1SkF3lGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nPIn50xiHMyEAunXQXeM07CDvyFubAW05dkJzJtzQLfHmBarOK4wUSIL+g7q?=
 =?us-ascii?Q?p9LDR0WS+9VcueQxbw9cmKuZfEPPvmKj9h+l8SIy4TwVeWMF3TTF12aiYJnA?=
 =?us-ascii?Q?+4auyjeMs8gfA0xB94iRtUbd+MCmzV8ItO+E+51dWQZ2460Ji2h3Bl64K/56?=
 =?us-ascii?Q?YNoK6gpw6c+ulOICQ1inqeKBYIkOwVSvv9/owlFhdOhd9D2HvvpfFco9BoLd?=
 =?us-ascii?Q?KbeX7OGoPHasWpXW55Y3/KOmmq+ConmB3MgG2HXAaRSgcMae+Y/KyKq8Qkh7?=
 =?us-ascii?Q?uWoUqVrNs9V4IcnP2/EUdk5oq5LNOSLp749INXVzD1D4lj9GqHbTwVyJFhEa?=
 =?us-ascii?Q?xKg3ATaLdEDp/5/D7seknZH2ZduUvRjoll0nqPCgPlkeyP7H75Ar8GRjZvdT?=
 =?us-ascii?Q?/ldk2p82quOLaDrm2bwy6iuvDP3quhwYw83R9UWNVOviOdDTXq63aBlmvdG/?=
 =?us-ascii?Q?xK5SJXk8OLctxI/ZWm5hWzpAsiRmTdV96gJfqZh32pxHaNHGGqqizB1VFdiB?=
 =?us-ascii?Q?3E1YjWC74lFUJSTPFqqFqUBEEJjGY40GJJ13pu4+nKV0FnzsmT1bPhwj2JeZ?=
 =?us-ascii?Q?+EtjD2NmJPiOyxAWAmbfhY96TqOfFcFGBffQHsirbutW3bg/fjWxu17Z2m8Z?=
 =?us-ascii?Q?PbKMLmFeUANSapJ+BFnl1OFmiB7jef093IErvYxdNLQXWUNaD8Y78dV6AbI9?=
 =?us-ascii?Q?SLcc90fJ4UT3EkulkCeiXuRs3RAThRkhRuECpMjW3MUPY0VS5pGwh5/RzYNc?=
 =?us-ascii?Q?ZRQcw3EYqp4EjBfa9erOVQHkoU6ckM2fVSuechT9a7Uv3MPdS7JAzPm47vfG?=
 =?us-ascii?Q?gmaQFp0dKm9DOlMHJyLZKRbjsARKnNe3XfL/a7rsNDhuWRRpcGmdOksR/nYU?=
 =?us-ascii?Q?cfzIKMBGoKCq61f83VLeg9/yM0eb1+rYmHnGOD5Rhujd9qw60WQctwC48DDM?=
 =?us-ascii?Q?VrCy5TanqQkE0zHjO79EkT2N9bTyUXe3TnbYeNmXuD/NdEkolgyLLBdOuVG9?=
 =?us-ascii?Q?4b3PxLpjx53afcxNeA/c8xiYnqmkhoWG25SGGX9l+pSxzEhfZffX5CGYjFkZ?=
 =?us-ascii?Q?jL6W2k+0BrcDsx6e/snMfIXTH+a1STMqtke1VcXTI2Io58rogUypAJgEUdnw?=
 =?us-ascii?Q?OWgdMm6SFbH/drIdlMPelwG3Y2ujYIzcQcn6EkUzTtezHvdNzke9u9LBEUgW?=
 =?us-ascii?Q?f3FbK+k9iK/I0nXcva2ZaDg0aq7QyiOv3hCZRnP5q5z78MKwwwu7xW1W0wkB?=
 =?us-ascii?Q?6r5vrj7WXSBMknIqjdH3bQtZIQ6QoZhlpWuC7vKF18Npa2cJ4zYQfWb0hg4g?=
 =?us-ascii?Q?TW3PjlR9Dr9sJQle07uPnEN94777ro7ArpKeFf3tjnrLdpl57q++gj+CgX5G?=
 =?us-ascii?Q?NoRsmdg8FbXsspOJQiOLR8+cGu0a22o4X7iDeqIMG7JCpRMPnSEZWb0zpCdF?=
 =?us-ascii?Q?adk6oFILG7CBsgyyys2mmU5cJ7FpKutLpMJPLfKJLEP86mZ62yHcM6Jio7rj?=
 =?us-ascii?Q?faM7W+DjTTZMKGSCTdocqUVZEMsQjj51FlL6g4Smi5GFs0Qd8nzJbZD3HuGm?=
 =?us-ascii?Q?ulsSMkJtJGchuH5eDQNeSy1XqyAidBjf/zJQqqbp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb56ac82-3417-4c84-8090-08ddd36de7f1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:45:15.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrStcV5zRMxoM4dqeVnqj5kh1Q5xSnSiM+1L2lAaD41xSUgPw/rbI5VBSPvESY9xXxbZg0UVDe7XtPjM2+nQmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP IW61x
chip family. These chips are tri-radio single-chip solutions with Wi-Fi 6
(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4. Communication with the
external host is via SDIO interface. The driver is tested on i.MX8M Mini
EVK in both STA and AP mode.

This driver is not based on mac80211. It derives from mwifiex, but due to
significant differences in firmware architecture, host command interface,
and supported features, it was not feasible to extend mwifiex without risk
of regressions. Thus, a new driver is introduced. Future NXP Wi-Fi chipsets
will also be supported under `nxpwifi`.

The driver passes checkpatch. WPA2/WPA3 personal/enterprise is currently
handled in host via wpa_supplicant/hostapd.

v4 adds support for TWT, monitor mode, WPA3 Enterprise Suite-B, and various
fixes and improvements. See below for full changelog.

Data sheet is available at:
https://www.nxp.com/docs/en/data-sheet/IW612.pdf

Change history:

v5:
   - Fixed build errors introduced in v4.

v4:
   - Added support for TWT (STA mode)
   - Added support for Monitor mode
   - Added support for WPA3 Enterprise Suite-B
   - Bug fix: In BGN/AN HT40 mode, throughput was 50% lower than expected
   - Bug fix: In STA 2.4G HE40 mode, throughput was 80% lower than expected
   - Use wiphy work instead of general workqueue for cfg80211 ops
   - Introduced RCU protection for ba, rx_reorder, and sta_lists
   - Used per-TID spinlock for tx_ba / rx_reorder lists to improve
     concurrency
   - Replaced mutex_lock with wiphy_lock
   - Reverted "use tasklet for Rx" (back to workqueue)
   - Refactored HE capability handling for better clarity and
     maintainability
   - Used standard kernel helpers for MAC address handling
   - Replaced proprietary nxpwifi_ieee80211 with standard ieee80211_mgmt
     structure
   - Used u32_get_bits() for VHT capability field access
   - Replaced LOW_PRIO_TID with TC_PRIO_BESTEFFORT for skb priority
   - Removed static WPA/RSN OUI table; now derived from cipher suite ID
   - Removed redundant helper functions: has_vendor_hdr and has_ieee_hdr

v3:
   - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
   - Extend driver verion string with hotfix number.
   - Remove Rx mlme work.
   - Remove all useless check of netif_carrier_ok().
   - Merge decl.h to cfg.h.
   - Remove unnecessary check for wiphy parameters setting.
   - Synchronize following commits from Mwifiex:
     wifi: mwifiex: replace open-coded module_sdio_driver()
     wifi: mwifiex: Fix interface type change
     wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
     wifi: mwifiex: increase max_num_akm_suites
     wifi: mwifiex: duplicate static structs used in driver instances
     wifi: mwifiex: keep mwifiex_cfg80211_ops constant
     wifi: mwifiex: Fix uninitialized variable in
                    mwifiex_cfg80211_authenticate()
     wifi: mwifiex: remove unnecessary checks for valid priv
     wifi: mwifiex: Fix memcpy() field-spanning write warning in
                    mwifiex_cmd_802_11_scan_ext()
     wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()

v2:
   - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
   - Remove useless header file semaphore.h.
   - Use static variable for cookie.
   - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
   - Use error number for error code.
   - Remove unnecessary private ie definitions.
   - Remove mutex async_mutex and related code.
   - Remove unnecessary work queue.
   - Add the support for PSK SHA256.
   - Use tasklet for Rx.
   - Remove unused functions.
   - Remove compile warning.

Jeff Chen (22):
  wifi: nxpwifi: add 802.11n files
  wifi: nxpwifi: add 802.11ac files
  wifi: nxpwifi: add 802.11ax files
  wifi: nxpwifi: add 802.11h file
  wifi: nxpwifi: add WMM files
  wifi: nxpwifi: add scan.c
  wifi: nxpwifi: add join.c
  wifi: nxpwifi: add cfp.c
  wifi: nxpwifi: add configuration files
  wifi: nxpwifi: implement cfg80211 ops
  wifi: nxpwifi: add host command file
  wifi: nxpwifi: add command and event files
  wifi: nxpwifi: add data path files
  wifi: nxpwifi: add debugfs file
  wifi: nxpwifi: add ethtool.c
  wifi: nxpwifi: add utility files
  wifi: nxpwifi: add initialization file
  wifi: nxpwifi: add core files
  wifi: nxpwifi: add sdio bus driver files
  wifi: nxpwifi: modify sdio_ids.h
  wifi: nxpwifi: add makefile and kconfig files
  wifi: nxpwifi: modify MAINTAINERS file

 MAINTAINERS                                   |    9 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  289 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   32 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c       |  590 +++
 drivers/net/wireless/nxp/nxpwifi/11ax.h       |   72 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  346 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  895 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  167 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  275 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  938 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  984 ++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 4071 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  475 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1284 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1230 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2401 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  501 ++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  684 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  911 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1716 +++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1850 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2805 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2656 +++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1319 ++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3449 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  868 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  250 +
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  208 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  358 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1234 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  490 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  506 ++
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1580 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  132 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1379 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 49 files changed, 37725 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

-- 
2.34.1


