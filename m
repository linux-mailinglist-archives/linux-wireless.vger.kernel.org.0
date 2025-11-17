Return-Path: <linux-wireless+bounces-29026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC085C63B29
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2E6E36289D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351C32AAB1;
	Mon, 17 Nov 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dg2waFWc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F0127280F;
	Mon, 17 Nov 2025 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377314; cv=fail; b=BT5S/q8F2mY9qAnf8XmjMnat49n5MMtThAYifgIe/9dFfZgbF7QkgylZXTgtj9EIinrz4xx9N4qBW4iosInyFloTY6T6tZtuQaYsFqIDtEbG+WavTyBi6YCRhcTrrYcrurx2RxzjAkU8EkDcbxn1yCx461JxSoNf6whIQ1eDO8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377314; c=relaxed/simple;
	bh=L6PHgk2F6qNb27xNyl5CTTAD3eoPnmroC/APKjXT09s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aWN1ge72fZE+Sbkq9265xNCaeOJJmO2+jgVmb7rDnS00CE2/hIEJaH5gjq6Tnq5OTsbiW6h9FtJdNqlnIXuEGHMQ/rtbos1sMjt68ARqmliu9McFBcO7aPMcNi2vbGWzIcOjageEQFcmqCTKGYIjeFV5vkxrVAIcmMxARrg92c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dg2waFWc; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBiH5sDHVDMFD/EdiMQc9mPnA3Z4PFZra4MsTIX1px5JUmKkGKxtLKHKF1hvdijOF/pF2rgCejWQZz+mlgfJq53r3OnCUj/sxd9SAZVOY1uU+yuvwiUPjvviu+ut8ZRWrUU0HJkGQIydPrAmpYEMxKwmpzkzEdtiNMKw3ftSdDHUhSHWCBDepuJGaj5+1917rnVJndKk/eBOOOE3D+9GfbwnEbJNmxQEbD/T6n7a6cWk+8zmvyUiRVUjiHGzxFJw4T7C4zNMI/nxcUzUmwXnSRFOcY78jUcWVvh9ppwivQAvuhLunqgJbvW+k3CYsk/FG+ndnZ1MkLq0+TptdSBKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE2yEkDC+/n9cMNgNoI7aiNGfB1SO4T0SypxjPwFtac=;
 b=IAO7ZxP6VqbDdrG40vWA40r3NOixTFvPz482J/3qay4L8qtRJxSMQQs/ywBoaZpoTaY9KwiV05lZXxoZqJIKDUx1nL/kqmZfyPfmcVB0epLW+6OTzb83nYSIupcbZtTWWsru1Ynha3FcCIJda13+ApTWhNHitqivdVkyw36EzGLqTYwk0tjykzdtapUKKOdDS+jjw18Br1N0RXR8PCjTMK9uofWdC9Rg7UZMzkMlJOK3aVGOmbAJNsstBKflGXVMdmGafgbCqlECfgECETBrpBQA3c+87CoZ5uf/ro0thOcpmzjREX2lnvV3BLYz0vvB71CuK/bXE2GvX8xAS+s7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE2yEkDC+/n9cMNgNoI7aiNGfB1SO4T0SypxjPwFtac=;
 b=Dg2waFWc6MGcDNh4MZO/mPxJNoZoY8CntkdLTfDDH5kMpu/yA2RQ/O1cmo6yjU73e7qRnsCWEgOgNn/cRTNAT2xFCMnfm6vGKyCXjI85hLjioojl0QPApdzZTbyiWIuk8coSkI2Ef+xsKr6SvjNVX15+9St7YWxx45ptFf+t6GoNrzMsQTWt8FdGjDxS4Z5rVRCokIEYQ+qx1eEMDqfFCeCkIPVHHELD3lUBumoJbXLQBx7gDTCqr3XMk0tvqsLEG7vmIdFSwYyxTKcQqRXTgH39Z096MpvCDuzbQ31vbYksMy6b9TSeA+zLjFdA7tcNZMJ3Xi255qHJudjHTCIDEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB11542.eurprd04.prod.outlook.com (2603:10a6:150:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:01:48 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:01:48 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Date: Mon, 17 Nov 2025 19:00:24 +0800
Message-Id: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB11542:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f338438-9845-4541-2791-08de25c8b420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/TXbCOnuksH57QuRbndmP95d69qGL5rJSjctnUyr/JOGV0LHD9VFn6JiwLik?=
 =?us-ascii?Q?ElgROfkYRVexAtiLmrI+NEt2RmTZDuGI2an2Z4Q+f+/THv82MWy6kc07ewfo?=
 =?us-ascii?Q?gS3gu7TDtDqCA7TlrHa2Ok2KUqgqOdgTSYCs31X0bN+EHrFuWScNjoxxarXg?=
 =?us-ascii?Q?3PlNJL/O9ZOLS6CzvWJdYhM70/IXwd1b2xmRg5j3bbN9D/YbhhpUrQ8GKbIv?=
 =?us-ascii?Q?JAu45DN8rEKezsYolPlHDbi5IDle86thZCQDycAPmZ2/VDqNpcBU8JZsI23I?=
 =?us-ascii?Q?mrTnPBsFhew2NbpDjEV6VcwQ/AvBPHrPrPt5yVzj4LdzB76Io/Y6c1BSzl3G?=
 =?us-ascii?Q?Zp6tLEQgQrX1f2S/UG0HXBJWpoiUEV/9kklxsf/pK0KkH6p3i8gffUY9KLif?=
 =?us-ascii?Q?mVbsNGKI010QhUg0ER+FnpHovJD3yNinAtfd7TWqu+qEc1Ij2rWWNYCuLYIN?=
 =?us-ascii?Q?jFO/1fUNDgN/o/T8gNd7wVQc3+OWLMLFcGl/6D2U957qqw9cNKhYm4QqvQkr?=
 =?us-ascii?Q?fJ4Nz3mLpB7kxHjSd/JBfDS2ZDItfOZ2rDd6AoXBzZaJmDDaWJDIsgtlRNmK?=
 =?us-ascii?Q?7WeJ9fIqbWgS5hrHMirb2YA9tjAd7+RuZkdFu0VlryvOorZCW6C/vHRpKf5k?=
 =?us-ascii?Q?sxF5AHHbDtG6SpZjOkipy5W6clL3OQGjb1Q18V4Q3Klu+OmACUODLsCCbjtz?=
 =?us-ascii?Q?CdkUMaYzLZ45w94T3ONc/TZJU9alpddNzPArrv0LSx9Zd1GbsteIRTFL/M05?=
 =?us-ascii?Q?b49EowtBR5hbNaJPgqWQ5tUmDQQPNwcbopwv2puYBMF3eJHcSKpwKVb/8mt0?=
 =?us-ascii?Q?7Bf5T/oRFPL/4/1HvEtvvUDVDHo4MMelrI6zcwTPBB3zUV1pwo8pFiShKHKr?=
 =?us-ascii?Q?SLQYBxNiHRsH5u2Y38ckLjye+l+yagFEqDkTt+/pyIkvhG6YfVk0e51cx9zy?=
 =?us-ascii?Q?3XS1dM8BMccSfYh27AEjk3G3AuJgFni/4wGwi4ukf/Ry5mkDrpZym8RWCbWT?=
 =?us-ascii?Q?4EyrsWbCBu0gEoTWzZOpzzUoJc+N9yOpaxX2toIXwjmRkV4ZhcUKOS7UPgt3?=
 =?us-ascii?Q?K/+Ninv5QtTDIf8AUZpssH2NxRu9IjYYT2MzFva+nqQ+RdM9eccgmVcfkaMF?=
 =?us-ascii?Q?lfwFyLaiUoiOE3d2TGKOUNhd3ULHkVoTywzu5TIrOMJ7q2Gkpwdra+2ZHtID?=
 =?us-ascii?Q?jzCjzAmA2zRs/7NA+p2TiWa0V9AIGZq4ke2e641RNM73/r9IR1sLXZrRai8Z?=
 =?us-ascii?Q?Wf3qGncXsZuXAtftot+FxvQf2AlnSkT3X0VKdA4K2KRZueeNYuYZJyFiIIGO?=
 =?us-ascii?Q?fxd7PqPv+6ppKqKo4EfioDNbnJ4aRV1zvjYzH7sFp+riicaLn3OeWELj7V/d?=
 =?us-ascii?Q?O6Bdh4QS6oQbSo6oAfzoHAqh5TkK1Fee27ZEdPGHD0nA/mkUsLUEHvdWUwO/?=
 =?us-ascii?Q?S823mYxgas+2oCmYdccU2BlpT9puPVA3Km/y67MfCjsPnZ6FXu3dBBidEucg?=
 =?us-ascii?Q?gkm/QoXPkZclv2mofYcNvPVNZoxOUBFuVkrh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zse2AHrrr2rp7V4oTv1InWK812vQKx6B8UZ801jkTMGM7jGxdMaof4G+1fh6?=
 =?us-ascii?Q?LmLM57BsbFOc5y/GMxlt0IZRaNLDreXdsBxBZKSY7fshsoxjMHLh2a7rG+rL?=
 =?us-ascii?Q?LddKleepcKeDa2VFq+zhWhJE2mR4TUIRCzMi5igaOFdV4B8X/rfONh11vJxy?=
 =?us-ascii?Q?n7aqNO0L8sW2nzK1o3f6fYBGRKyUe7NqUKOfEXWesTYc2Ea7nX+G60IL84K0?=
 =?us-ascii?Q?y6TCE+HJrvnTJUQOw2/xPY9RrSTBW55nHEvMSvfgsKg7SFae3cRE6XPT216h?=
 =?us-ascii?Q?w5o4hXqvhbp3DUchfJ8t46WMDKeTYpn5Jy1LVFOHKtTRnx/3RKwnI9NL0GKv?=
 =?us-ascii?Q?u9qslxncUTPBdzkOHY5UiVAEU+Flu9LCFZbK6bWjppKqScRePcgqkz67yuVa?=
 =?us-ascii?Q?iCtVIpzCKDgaYuFOiQBAuLJEcqeSj+Gn2tUa53TfTLtxOuJ4gI8uJzS/f4VG?=
 =?us-ascii?Q?SsHKB3st4yg7Qm2Kg2hIdnSGnViqpUe/XbFC763PWbDY1ssP1e8mDBoefBGi?=
 =?us-ascii?Q?gDhc3fm1TY6PPmghjcEKt2cA7rT1dhbL16cNlQIpdTMPASAMHre3hDUibmls?=
 =?us-ascii?Q?gYMbxAUmzJfwN3i96g2TiXG0gHarYz43eAhYBm60RIzeKB865l8bLaRR+nKN?=
 =?us-ascii?Q?WpLnPkhRbSNpI22tJz/lefn8AhKGDGmaQQn03eEZejJac5Qjv5PyyQ3LEpPs?=
 =?us-ascii?Q?CfsetUoGB+KFkiqF9E+kiACRQkpp7L208Ry2axB+Sf9TgYfpKfe0PygrKiE0?=
 =?us-ascii?Q?sY+nYKzoEuMiU/AlIVJ23ssrgmCLtkEdfndZduqrz6v6coo7xUBVk8ZIKRer?=
 =?us-ascii?Q?rMJPIYTwpcZMK1vGmFtSStpIbuKdddtaB4CxBRSg/9iphnJFjfUxjNPQK+PT?=
 =?us-ascii?Q?oNVWCA2XT9W4msKsYSkiUaRKl7Sqo33jTDUlrePpkEjIkzhvQtc6cBDRj5Vk?=
 =?us-ascii?Q?+6pvFzETrlvboCAHu7TaGdIUVAvbHEOc7Poa/ljUA1DVwZbsTtlXPD+3nNpQ?=
 =?us-ascii?Q?MOraXTnzLMDVCaoWc3c1Q5Mm4CUBIb660sp5IhTzhfSvuUdKjebSx6N4paKR?=
 =?us-ascii?Q?aYHXwMUUfpdbye4WN0qJUj84G2IIvCLyDfhAQVdZmDqdD0SbcrgqbWsMNL6H?=
 =?us-ascii?Q?9jr4VBBjC1x9KQWkRXHolqVoPEo++p5WCegxsDBb6XmMlZ3cQslrx4/mQ4mT?=
 =?us-ascii?Q?phyMD2VsRhhqeyiYjg8UrCY0Zoa59hoycWVsVdl0jyko7MAwOqD522btt9Pk?=
 =?us-ascii?Q?sWXeWY0LUDuuiYU5uwOyJwPRFnGBT1lKlLnzmxAjn0RpEHpx8mh0KbZbKs1E?=
 =?us-ascii?Q?og9vYYls9JIcQYZgPwguocrSrxfpbCwhIi8/0yCYjtDoXvo4mzlHxiF9nv3v?=
 =?us-ascii?Q?aGUVYiQ3N2TOsxrLf8bLWDBWtxnUBvHnjDygKggqlsOm2IlSxrR8LATP3BS4?=
 =?us-ascii?Q?K5bX0i8ptEGqeVqzh6tonKbEN9p+zGedQUsOVhKm3sfFmkTlue+WOoatqFDt?=
 =?us-ascii?Q?43og3hUJ0rrEzz57sgnJQAvl3afHziAy8+3yKMVcgX1gkdopthCjxjl2rKyQ?=
 =?us-ascii?Q?Y4lmjVwu3ozgY3V76v0JY851eHN2CTr3PATzqCCX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f338438-9845-4541-2791-08de25c8b420
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:01:48.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmbP3deWcaTCGLH2Pps8tSZc9CdCUoMIQV6Ohy82q0O2HfgMgPUv9ivab813sNfZl9yMCl256+BpnZg+wdkkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11542

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

 MAINTAINERS                                   |    8 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  289 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   33 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c       |  596 +++
 drivers/net/wireless/nxp/nxpwifi/11ax.h       |   77 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  346 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  887 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  164 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  275 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  924 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  984 ++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 4049 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  475 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1283 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1221 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2400 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  500 ++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  680 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  910 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1834 ++++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1836 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2859 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2649 +++++++++++
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
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1570 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  132 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1379 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 49 files changed, 37813 insertions(+)
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


