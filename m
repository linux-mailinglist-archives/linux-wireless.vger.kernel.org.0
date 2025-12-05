Return-Path: <linux-wireless+bounces-29508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A890CA647C
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 07:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50CF4303A134
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 06:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2AB225413;
	Fri,  5 Dec 2025 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rl/0U0tK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E41CAB3;
	Fri,  5 Dec 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917828; cv=fail; b=Fmda6hOZQhlaCB9ln29pj6Egj+qpN7aGGKUWjpnUvY93dRc6lWwK9hpHc29B95/5CK1VMrirRCcAFtBsrjXg4drC68IHENQwHADqu7uNz/SAi0eOAnSpObYhUmBgwatyQ3kLMF5ynJNHnKCRG9Eb8t2YyLGtmdBVka9i0nJAVuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917828; c=relaxed/simple;
	bh=uS4e6Tnm9kxbpXZXEKGPLp/NadDGQL83TN616Mky6xU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UU9s3Bsskj8XxEvcoUC4qFwVK8Ajzzpmae+MzKUXbqdQdehypN+Q+oRN3hKhwlje/dN3LkO5CuGuxo9MIOKDg/9nR4LdCP0lx8+nW6UZlphfgNpSYvCdv5TthPW3+ba9CqQZC4pCNoJzmLWgfBbMYuHeCy8CtupCel5sXZIdVCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rl/0U0tK; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b039coQPBf31I8d/l10AlJ1FvsRxfiWUUcCYfjfhu+Rl9forxegh0EhGGQQNIiZfoTD3TySQuT8yvb4Lgh/9rPXA+3IpxryUtYakUGAtjvoeKPDtF1Gp3NtIiLpaMAcLB3/zaK3v0J8kDjLdH3LHJa+OEe7jjjyzfodqMIzOsDyOFf4I2wSpSW5V1C+b/d2GIMdiCfjJP5ikiS3gKOpJVdK+wKmmoQlBVv+PG+AItxbt1aQG8Oemtmv2HVtZSIM3VcUVdzHjeg+zHo8jkeO6oR8W8UnErPgRsEhe/MOZseS+kebjk/CIFwwSH4JRmNhfU2/+wrMI4mmB/ALsu6E/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF5eXyN+VCmeNBh4aUKbXluVic0fVrB4cyFaNo8wsew=;
 b=dwvGg4vMEzwb3CTMlw/q8ApwrA9Z0veSJ1se+tEMF9K2XWPA3brdrXqq+Q8NCKJqzj6w9kPHAPook4IzuYKWLrM8s4wQAQsyNWp129Max1TSJK9+1lyfjGDUstvrKh6pBhIv6jsYeztSw06Jg3wD/mYDkDOk7h2UQ7GZllqmrQ/gYhxtwvbxMOQtFsCIArCI+rbzKshr3NnRo0wfe2KzFD4BwZyzV2at8qNwOFjDKbG8gNqtj6hDVL7WHCGvepFBqv0tRkqi2lcw/HczOG+YoxuIJ25pa5oON+XmknrU9pE8ptOF/4obikMo5xf/I3DXUsdoUoe0pOKEc6qAYTUpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF5eXyN+VCmeNBh4aUKbXluVic0fVrB4cyFaNo8wsew=;
 b=Rl/0U0tKL0VnzzRafiJXn2vZMJ8uuDxwdoLOrObixuR35aHBB0hJIBGl16g4jDV/8lSCy0OvDqgz8x2lSV72S/317YKRisASIC9fDvcQquRxl/f6TJAbd4DdQu7gcPLlnTCQislXPKmAectPFYMY971HUSdOnJBGIIUFncIImz6VolJiSLILOrfzuyUD+3bqNvK27ZYnfvwkPTkZVzuq9IKStsA2bB4BG8w9ME8uehc4Z6Y2wCveE7yUsqWZKSAXEVlMfP8kUC2djmoTszBQ/CgIKbkrpcfqAqn8PZecDNN3B7tDpr7Z66vmh5kJpljrZRT+00Iq8+x9IgztfDnYyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PA4PR04MB9245.eurprd04.prod.outlook.com (2603:10a6:102:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 06:57:01 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 06:57:01 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v8 00/22] wifi: nxpwifi: create nxpwifi to support
Date: Fri,  5 Dec 2025 14:55:23 +0800
Message-Id: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PA4PR04MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 72baa564-835e-4713-7e39-08de33cb7d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CnnScbpsd5p+1x+N0zF9m+wP1OtggSSP7spDXWqaxxqr8pqctM0nDePH1Koq?=
 =?us-ascii?Q?SKO7lQmMC7cxbyHFOLIpDC6ssECaO44xK5bfTUvhjYLhmu7gln0c8fdE2hZE?=
 =?us-ascii?Q?0EW5IW9PqvJWDui223xREBKSqvmS9Sc3+CQFuvhzEsfd3lKoby50Vt+Taghe?=
 =?us-ascii?Q?iqH8nyIis9b/xVWuyc7k6srP3IGGdUrj7dnFQ16MuURnByz4Ab8Z14yFH4cm?=
 =?us-ascii?Q?a5p5Pjz/lkkM6sTBzsIyXIFAgT9V2CVM7FeqAs0yB685rzSIpL2YqKdZm/kS?=
 =?us-ascii?Q?zzKESaD4wiqbmPQhjaVWthntZe+c2i9oXEZvg52CFVesrT2WCa1fVeOveOZJ?=
 =?us-ascii?Q?OZ+uIsjfxXPUqHbMy8eda2++X6tLfHusD1smOU2Y9xxqdQ4y/Z3lEUj6K5eb?=
 =?us-ascii?Q?JYiUXss5qX1Af6+4PZrEAPT6FCulN3PxxPZbVZj0hDx1KjDUIrQh9ZPRpabh?=
 =?us-ascii?Q?xGuWRZJvmLXJhYH/n5sBJ1asfWdGBSAsIXwDJkuQIRt4ixkN2HQptQ60awhr?=
 =?us-ascii?Q?1xYBCH6cY4kHKSll3uiv07y8TH7YCzvB+mqsoawspWEGqKqoZYAwcdLPHbMD?=
 =?us-ascii?Q?EAa64Vc5Z5Ju2h14QUKPRlpVK5dQIqjAgk8kKZBizjiq8SaDAW9U3+6Hbw/R?=
 =?us-ascii?Q?GQCXFL6ejXFpzBWH+9rwR+vT1y44PgmXUAPmhQ1NcvMDk8L1On22qQhEVrDp?=
 =?us-ascii?Q?9/HcYazcTnqzg/8ceYjyw3i0RZtT3GBnx2CZjBwCFHrbOrRqMAPpAAZL+PIk?=
 =?us-ascii?Q?3dKvuDUU0xrBHXXiKmYnyF3HCo11bQNv2zD04Kpg8KaCUgRHaM9wfkdpHZAK?=
 =?us-ascii?Q?EgXazVHnnDJup/lFSHR9aHzhfbJM9qWZMCR9Qg+uwU6bn328eTShLr9CZmaJ?=
 =?us-ascii?Q?tzcjB7Vyo0p9701IJ2/afS6rnSb8blL1LgCcCLmxivXOl9mTL+ojVI+YJneG?=
 =?us-ascii?Q?jEDEow2uQhuU3DBydGSPXXcoQAwpeHYPwtUnGZgJo1/T77Hwg2pn1BudU9mG?=
 =?us-ascii?Q?mdMxRksWfde10h+93oAMpN3pkMebMT+KW15HZsX3UYmgfhG+sAVnRvecSE/1?=
 =?us-ascii?Q?eTFzNZlsfjUj/56nKq/CxRK8A8aPj33/jXpJEL8r5X4HUKTxvOnzJqadAAMg?=
 =?us-ascii?Q?o8NC8/+qUzM8pVd3HJZy0wXeIhAqIBgjBAAog5R40qpUX75LOA+98EOPbFNx?=
 =?us-ascii?Q?Ye67haTsNs1F3qupq7PqrCnJRsTFr/stKeULvOZFXVjekSOFBXl/N0Eiufng?=
 =?us-ascii?Q?Bc1ZB9ZaeWLkYK4oHgHYIUd1cGvaH2ox27dIAY2sd5q1W/3QpEP4NE5F4Rds?=
 =?us-ascii?Q?VLPwwfL1o08zRRet1rHelS+pod4jTlsXOJa5lkoVuupWktc6fgI7M4K+IPFF?=
 =?us-ascii?Q?bqsNMejvRxc7hLS1Nis3C/0C/kjHyy6ojEFPu/kCKsdX2yuC4pB1HIlJGmjo?=
 =?us-ascii?Q?kZX7YxRhVfeHPJ20Kl0CsBggACmxr9lSoDXLI204Dqe5YvH+I4s0+YXjpviF?=
 =?us-ascii?Q?tPv358QmzwNk/ZeB+vZhQIsAYoXnKLwtITcjW+ivX1zf3QaX4XOUGFx/jw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dEbEgGOwK3hCmZPrr9tHO0BY40g3cmFJkeKt71a08AGYgqJAPQXq8idviMhB?=
 =?us-ascii?Q?V/nNwTVj9/Ne+QrIWMIcQlJCoVq31eXqWi33L03O1Y818Mkl5LO24UEOpcrk?=
 =?us-ascii?Q?uVv2iUeYIIRzQI9DbfCJQBNB73TeRUWyMTGvjx/HtkgfiRe91o3YBEs61sF3?=
 =?us-ascii?Q?K7N5N5UWIDeng4G27uadp2QI7vWQU4EvN68riitDC5M3vz7ptuHxE1ZtnC8Y?=
 =?us-ascii?Q?KycLHlzc9bjB/R2LDW5uurq5bF7UBj/HETEJvKngrkKxuVk9VYiQvXXyTK8r?=
 =?us-ascii?Q?NzFwcWcEC6MNQ+fSbNl3bRrwFQ4T3SZHtsQtxTRvHoPq0zOYCz94DagxsxEI?=
 =?us-ascii?Q?iYlb6yGQGLGBb9cAwzq2IUqTyfLuHDfNll4wBHeIg0WuIjq+5vSNn+YWwis9?=
 =?us-ascii?Q?TE/9KlUMob5wgOcBo5LFG3t/exg5wpiqty01knEJy8OkZsU0ntjglAuIsWo2?=
 =?us-ascii?Q?QCPCGyPvW20v6WbhfuY4xHaao1rfiaGoxx32iHbfAzt7MVLHmi2+u72qflUm?=
 =?us-ascii?Q?MFC0N4v2Ax2otNNvwXKbJhQjmIxZ7pZSgo6utE0/+n9WdfeePos+TAl/LRyC?=
 =?us-ascii?Q?/z0BoAEO9NpnWmzl0qfm5tw1B4ItdN8cUyDRe5v1FIugfOsk5kzxUZkzkCtZ?=
 =?us-ascii?Q?W1Mc5jVQopL16NX45V3l5SLh0Ln2K1E6uqsklcJtMI5cvRyqdGXwnN3SRto1?=
 =?us-ascii?Q?XQdwoRK/jqvbUayRI8UpDP/z5tNrQPjF71xnaYcCyIiqyhPYJjzzdO5SWlQc?=
 =?us-ascii?Q?jUeRt8KaIQYgs2GOa94RFsBd1MC93/o52orR0z2qThvOH4VZ/bMsTUI47l11?=
 =?us-ascii?Q?wi4xQI4A0fgd/vt45LdLTA9Qnjp2Ukwviq/ao5iWqWgRP18rZo1Z4y4ppugj?=
 =?us-ascii?Q?QaJIhA3sXoLQFdZwYx2ht9jPJixwiFEmEZfpJefG8nYzTxzE2eJjlZzBxCva?=
 =?us-ascii?Q?UcBdCaFN+1sIzilZAYUyUYe3jTc0Fy/c6oz5h+VUKwxPRCx5n+feuVa37eX+?=
 =?us-ascii?Q?mZHZd3/vRza1FffMRB1LhUH44ZyeDhiBPEH8X7hf+cTMUoowfQv5RkZYv1sa?=
 =?us-ascii?Q?xZs2+QykBJkA0vjqKPhGUQbPfVOdQSh43WA3xScJriM9uDIEeJIjbGz8Pgy9?=
 =?us-ascii?Q?W2oEqFfGKHfATgO/CmYAY6ZO41i/WhXmepeiqH63xGJt3vD3A6771lACQUmJ?=
 =?us-ascii?Q?0PYcnEKmWaRtrIEZks0sdMUDLDO2zE+yWWzmxl7IAR/ZnWNIkY6VNvzT9Xyb?=
 =?us-ascii?Q?a4VE6Uk/wougDoQ5xF38PRbzsp89Y0ylhzRzUsFLEzSAO9UmnjShZDcK7l3e?=
 =?us-ascii?Q?tiFiB4gMadEtyghnLev4Eo4YytexbiXXH9PPPirabehJRRJbjnUadKgnPkxs?=
 =?us-ascii?Q?sLmCAULCw6NfOIZeCCAWBJbTo/bCRWmOpPdxRWgM74RhsOHhx1DPL48fdSdJ?=
 =?us-ascii?Q?LWOi7poL7q3cb5zLKeaciPTxzeTqbldmmKe8H6E41s1m+tA9AkYi2ZqAfxaX?=
 =?us-ascii?Q?VRTfLtmhFdhRj9EmIkX5itUyHecx8nr5aoRMHi5sr4g0wLxYcZ8+saUfg2LD?=
 =?us-ascii?Q?vC0i23eo1IGjH730jY6yO2ElqaYpTeZZQZ+qio/d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72baa564-835e-4713-7e39-08de33cb7d5a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:57:01.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8KVuBOs8nZQTnAcxpvH/yJuzbDJlj0YyTS6WtcTGUD4fLoUqoSe34/5o9UYbp9Ic+jFckv5RdJi2k4cLAsb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9245

This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP
IW611/IW612 chip family. These chips are tri-radio single-chip solutions
with Wi-Fi 6(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4.
Communication with the external host is via SDIO interface. The driver is
tested on i.MX8M Mini EVK in both STA and AP mode.

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

Firmware binaries can be obtained from:
https://github.com/nxp-imx/imx-firmware/tree/lf-6.12.34_2.1.0/nxp/FwImage_IW612_SD/

Change history:

v8:
  - Standardized multi-line comment style across nxpwifi driver files to Linux kernel
    convention.
    /*
     * ...
     */
    No functional changes.
  - Fixed workqueue cleanup and error path ordering in nxpwifi_add_card(): ensure
    proper termination before resource free to avoid race conditions.
  - Corrected spelling mistakes in source code and comments for better readability
    (e.g., Dimentions -> Dimensions, interfacces -> interfaces).
  - Added Device Tree binding schema for NXP IW61x SDIO devices (nxp,iw61x.yaml),
    including properties for compatible, reg, interrupts, wakeup pin, and optional
    calibration data.

v7:
   - Addressed review feedback from v6
     - Removed unused variable `ext_rate_info` in `nxpwifi_rxpdinfo_to_radiotapinfo()
     - Radiotap handling fixes:
       - Converted fields to `__le16`/`__le64`
       - Applied `cpu_to_le16()`/`cpu_to_le64()` for endian correctness
       - Replaced `jiffies` with `ktime_get_ns()/1000` for timestamp
       - Validated channel frequency conversion and removed redundant code
   - General cleanup of endian conversions and Sparse warnings
     - Improved HE capability setup via `_ieee80211_set_sband_iftype_data()`
     - TWT configuration fixes:
       - Updated structs to `__le16`/`__le32`
       - Corrected debugfs write helpers for endian conversions
       - Removed redundant conversions in `nxpwifi_cmd_twt_cfg()`
     - Scan handling fixes:
       - Changed OUI variables to `__be32`
       - Used `le16_to_cpu()` for `ext_cap->header.len`
       - Moved element pointer declaration outside `switch`
     - HW spec parsing fix:
       - Added `le32_to_cpu()` before `GET_MPDU_DENSITY()`
     - Cfg80211 handling fix:
       - Moved `legacy_rates[]` definition outside `switch` block

v6:
   - Removed custom locking (main_locked, main_proc_lock, more_task_flag)
   - Refactored main process to rely solely on workqueue
   - SDIO interrupt now only queues main_work; avoids direct call to nxpwifi_main_process()
   - Introduced atomic iface_changing flag to block main process during interface transitions
   - Split monolithic main process logic into helper functions for better readability
   - Improved exit logic to avoid lost-kick scenarios and ensure all pending tasks are processed
   - Replaced rcu_read_lock()/unlock() pairs with guard(rcu)() for modern kernel style
   - Code cleanups based on review feedback

v5:
   - Fixed build errors introduced in v4.

v3:
   - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
   - Extend driver version string with hotfix number.
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
  wifi: nxpwifi: Add 802.11n support for client and AP modes
  wifi: nxpwifi: add initial support for 802.11ac
  wifi: nxpwifi: add initial support for 802.11ax
  wifi: nxpwifi: add support for 802.11h (DFS and TPC)
  wifi: nxpwifi: add support for WMM
  wifi: nxpwifi: add scan support
  wifi: nxpwifi: add join and association support
  wifi: nxpwifi: add channel/frequency/power (cfp) support
  wifi: nxpwifi: add configuration support
  wifi: nxpwifi: implement cfg80211 ops for STA and AP modes
  wifi: nxpwifi: add firmware command and TLV definitions
  wifi: nxpwifi: introduce command and event handling infrastructure
  wifi: nxpwifi: add data path support for STA and AP modes
  wifi: nxpwifi: add debugfs support for diagnostics and testing
  wifi: nxpwifi: add ethtool support for Wake-on-LAN
  wifi: nxpwifi: add utility and IE handling support
  wifi: nxpwifi: add driver initialization and shutdown support
  wifi: nxpwifi: add core driver implementation
  wifi: nxpwifi: add initial SDIO bus driver support
  wifi: nxpwifi: add NXP vendor and IW61x device IDs to sdio_ids.h
  wifi: nxpwifi: add Kconfig and Makefile for kernel integration
  wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver

 .../bindings/net/wireless/nxp,iw61x.yaml      |   85 +
 MAINTAINERS                                   |    8 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  293 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   33 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c       |  596 +++
 drivers/net/wireless/nxp/nxpwifi/11ax.h       |   78 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  354 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  895 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  162 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  280 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  952 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  993 ++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 4058 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  480 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1309 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1232 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2409 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  509 +++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  687 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  923 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1853 ++++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1831 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2930 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2688 +++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1357 ++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3456 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  872 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  257 ++
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  211 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  362 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1248 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  493 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  517 +++
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1581 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  133 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1418 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 50 files changed, 38314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/nxp,iw61x.yaml
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


