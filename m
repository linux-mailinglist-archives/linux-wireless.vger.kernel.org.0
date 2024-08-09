Return-Path: <linux-wireless+bounces-11189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA4394CD9B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A57BB2245B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A161953BA;
	Fri,  9 Aug 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iyzyz+dZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385B194C7A;
	Fri,  9 Aug 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196801; cv=fail; b=RE9oPTeUA7wtzM45czdOSOVyc2IRmefpDgoEHEMVuoRi03bZ2cfvvhb++6/gpT8BPNDRsV95fMhtgV6alCQNPTjAcT72azn+g57vmAdFoh//FyqtSRlt8+Wr93u9dXZmbJo0uqOYY2H32e9+ChPv/WE9x5ufUD5Vr4Qdy0d0V14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196801; c=relaxed/simple;
	bh=k+6zGxyVG1oHfEMaZJ1tZmZPn1aVqjrQTSlzPkuQNeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ftt+p+ZtxISYKhTboYLBDbJTKxFitGrq5nI8WJIIaX44NjKi1i7R+C6dsi95hrnC0SxpjNPp2n+XIyyIn4FaVE3oNGXYk/sJsuoUeNqM4sfcxDIag5wsdN76jVSkIj8m5NkpemVeFFmJCjBGbp71wJLMQb8U1/SdTKxkKGdAXB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iyzyz+dZ; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eublVJg7prreQ0DHPvggGDRUFkzR4U/9tvxkuucjuYCM+rv9qBIFyKutceNkOePDq3y0xSIEupB27M3aGCXMbP3iK52imrTeMBnoaNYwFSf13G4kSL+vgrrCUVIpTQZN9ArlYKlJVDRbceY3YXJLIHeYguNatT/IvbIekMmF8yJNQ0RPugLvO/PYDnJQ6kB3XxlFkI0LKHIkEB0ClGuxEymunX+CWtJWaJp3LSiFtAZEKT4BNtZufDObE20jrs3neOZxTzCxeymbQBsc3VX6e8Hcnlgqk4DI3wzbb7giSucYtNqu13Z5ERkx09h/Me/VelDu/67sCVD2WVRIy1bVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHAERgpawj6urAJBLMjMifC6Z4ESZURpTzU16XE03EY=;
 b=Uc7Ig7NqcsCQdtGxsVxZlqCWv+C2v5Dpo3+Gm2u/j/s7NYj4eNGjSfe2noY6z1t6UUoaPRXERk1mmomSL9iGi56mngCa6w38blTertD/qbctmhRh6vHqeJs8nxnND036X6VKflZ0pwb6PHFdjsXkcdjso8s5xse2isChUBQtLQt0pX4/lY08flqNBdOruSrJLbz+KQqejXe4IKtwhaiCPuBmD9lcOZikSN6SJYRcJcPXFcbbBQiQtRpbaThXmtN/XfhniguYMTZ/DPb8btmWEMQjArgfvqcTD8pmaQny2p3Crxh+Sj69rRHH980nD+wT3Digbx4LRuViGfAEKLbsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHAERgpawj6urAJBLMjMifC6Z4ESZURpTzU16XE03EY=;
 b=iyzyz+dZF2wMQj2E21fNfC8f5UBBYNpmfPg9l+TLxOm1j5Lif2Z9HFZcVpXSW3mTbybk4+XSbrXYApCr8Go3oOQ8aG4Q3S8H8+mwOf3pe9/PJbKkMrXRVE845FFDR2s78y57dRNnGOMPD3jhKmoneh+j9pvcSIsvSwGHzrncoNVlNpLpuTkUUE0/6ChHhLm8WYDfmdR4PRN3xXIYxyCZ6kpWcIZKLPP3N5ZdBdGgsrW0zCWcIL8FMaDINJKgps1UKhIQk8hpIP2Q199lx7j83v5BztfYD+ynR1Ku02oSErglByKgczULSZMu8x90z4rafgytUQLwlFlHlFP7WqPMSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:31 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:31 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 12/43] wifi: nxpwifi: add cfg.h
Date: Fri,  9 Aug 2024 17:45:02 +0800
Message-Id: <20240809094533.1660-13-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdf206a-d532-4063-9e58-08dcb85825cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ZO6+0q4Lm1uIvU42kOdHNBN/7wOYmd93rwOdVG4Qm+mFvUexS64y3OB3Ghk?=
 =?us-ascii?Q?8fQ+phm2Onyh+zGsw0WrFuTKQxXMQV75/vbKZ6g52fPDBTuodlpRhzwPm7ii?=
 =?us-ascii?Q?H4u0RNbkxojKVShrrrVuC/4YauZfZtPbQES/F6Q5dVYJN3uFQanG9kwQ80Ew?=
 =?us-ascii?Q?kIWe7HcevegpgZZKcZSpIBUYrZbsr+/e4E053JMCnUKotDnLgxJ9acE9VT7P?=
 =?us-ascii?Q?53AHn+OVNoSnnnTZHBLWRcEzgS1aTmk1TQ2C7y/0CVC52imV5lVkCXhb/6Ni?=
 =?us-ascii?Q?lnPt9sxkMG15F/t8s26hDpSuHwgHwASUR2K6UYWNRxtkrlhrHWDNtMBoVqzj?=
 =?us-ascii?Q?aAzYjSy2z1Wg0zKwVBuWEBIHAQqkqGaftd+N+ywJvJHmZKmUIKsoDhaQIbI6?=
 =?us-ascii?Q?bgoA1bLE42d7kuRZxv4M6PPI7myUlXCwG9GamYbcfuK/uCD1Bpte55+hUcPM?=
 =?us-ascii?Q?cFSaPQu3EjcLFgZIl9ro8BOS9MF1ozoqE8xena2dLQFVP1aQoXNzCPhhIxcc?=
 =?us-ascii?Q?cl3s2fk45XVwVVVeaz0fj2t9LwAWNabS6mkb2VC9jaQGc7WoA0k7Rg9k7dzF?=
 =?us-ascii?Q?4QNn+aC6cXDo1ZKGiB2TYENUTIlTUjqVNc/Zf1Wmk579rAKfTThqUoKTFN81?=
 =?us-ascii?Q?X9xEO1ovBPLeqtwVtonnRqtGCgJidw7QFBPwG3+yMFcalUF0b0ek03aANiCk?=
 =?us-ascii?Q?6FipWJ5ZqDoPHa+jWh79CbFEFfeJLylrdwSXnstO9kG8kJgdhcU3jlIBYUnl?=
 =?us-ascii?Q?0tt447fQQ/2s/UAHsVx9I+EzMElsoTApMTNdwnWyxrXtA/xeznKTUf7FfNb1?=
 =?us-ascii?Q?yd/+x7Yl06/UoUQPibpERJrFgfjZKrpa6xFifX3650hgKXHPuV9QmBWHsyMP?=
 =?us-ascii?Q?9MhOH5o+nV79KTDRSvRZ23wl9DnLgO3pitOwvP9jrj80xv01/oUZUHreHU96?=
 =?us-ascii?Q?6UuaA2tNAJ65fQl2onJHanBYDyWrvNLbblP8PQO+mW+wCO+4BJ0AygJJitZG?=
 =?us-ascii?Q?LgBZ7+HPcaEEviKLFnRtfblUgiJgeeteM11rj+3z/iGGPN2nN+PEsD0dGZyC?=
 =?us-ascii?Q?Q0N10e+7u+s10IdiiZEyavMIxRWk/l4iME2uBGtsFs/d07bcJd1HoidJartT?=
 =?us-ascii?Q?ZGr2zZbl9y/YK1ra/rMX5vvyWncsDeD9mxHBzjbNoWIx22WjUiMGPEpDL3Mx?=
 =?us-ascii?Q?21++BOpJXwIyTKyTJ371PX1zaOACHYzw1lEtJpw9xOP+eRBvG56/fB2R33aD?=
 =?us-ascii?Q?GSRiQIvXODIsOVIiZQbb6p13Jd2xbmB4lfcTXL2+suk+9SJFS8vxRiUwIVnm?=
 =?us-ascii?Q?f/UTsb3eBG+7jPQJx/erHSN2TnzCFgqyZHWxCy6CC0e7Rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ma8NFNfBcwNFKnpkqiJz2uz9sX3N6HuvJnwplnFR8dIZi3QZhlscJb1GKsd?=
 =?us-ascii?Q?IBmozcz2GcxtHk5g6bTmTsTetY1MkOY3UJDjaNoD/YOqBztghqIP3jI2E9is?=
 =?us-ascii?Q?95cWiqsRWwjP0MTciGkGGyrrTTQ+V0j1gcJyrCk6uqXSzWQog9+aUvxQlaTn?=
 =?us-ascii?Q?timPM34lgNzbUWUKuTg9zBwWylO6na0gU2RrY9LpDSxwF5RzS9bf88kAQB0P?=
 =?us-ascii?Q?NyAS/bEgTqHVYNX99mbZVkNOByPEa+l+ZoXYS9d50eFe4YPA1o0BIKpVlL8p?=
 =?us-ascii?Q?eoucUyL8BR2W5t0Ne/tXHUmo1GA5l9wtrCuX8bucFRHjFnshlAO72QygYLI5?=
 =?us-ascii?Q?gzebyPNkQCsuoKPhzrxbq+913vFlmT2c5cCRbohPbaq+IFDmeYUPXOksDIgj?=
 =?us-ascii?Q?UC5FYd0SjmkTYuo0hbw8Or+vsVeO6LYAvDg6S74+BsN9t9FLPb9Qn8kVyn7N?=
 =?us-ascii?Q?vTxr2JpMntw+73cQdFAQg4SSg9t5SSRLzcUyXHryKrnrBFRlTMb1ttyT7u6x?=
 =?us-ascii?Q?w8bo5xMSuKgrrleZykSIPhwCe07mml43kTesAQaG+xOaeyoCN2Db0MqaRYj1?=
 =?us-ascii?Q?/1ngxPz82/RMpcg/XtrjZsC4hRvMJWZxqazq9aKyrj/MmPqCRsLaX+CrCn0M?=
 =?us-ascii?Q?D0TLOcvbmIbZtU4H9XEwib2awlbrTn+JVXaWpHWkZA8UoDf5gsJS0hqp2PbG?=
 =?us-ascii?Q?8EDIWByM2lHTll+Ar5NwVyb1k0lg6tEsJgSMDeqtvK9FYKBNQ8CcvPNVClEg?=
 =?us-ascii?Q?vGf7Eoq19ABnNCMqyMb8vzn7CbUu4ymOGnTpv6cNkIx1y8uVmrWyrnieq7Pj?=
 =?us-ascii?Q?8bFYfzAJn8+9K+zz5r9uN73Cpg5obn8Ygotp/bC9szDFz3sz9kvGfyqqfUZJ?=
 =?us-ascii?Q?mewb4xKX7xI4MO7lHUD07I2bMgefL129OB564KyO9D5ilbHeIQuL7yzNghSy?=
 =?us-ascii?Q?XKC1NVfzFLXmeBDHxn7iKG/B0wZfSBqV9p8PqipPkFYiwdQoKPLh7mRAR/TL?=
 =?us-ascii?Q?ZN4QCmelRGkRTZTMTFlbO5MT78bSCoUElIJOQMRQoq/oIYvtSPS22uiIGJND?=
 =?us-ascii?Q?n3nwLlTLzk1Ojj/sztjRA2uOK9eCdm5pqIrFC0pWPNSz9Mkt/OcKiZHaX+mq?=
 =?us-ascii?Q?LcucEJ/C99Fuf6TCyurLaWdJAuWOYrJ1Ttv1a3UfU3abcNz0/ri/5ono+05i?=
 =?us-ascii?Q?JadkbV5itGv0HPlNuHoAfl1UJnl9EpR1amsUW7DTu3+glgCgoz4m/fqPCcNI?=
 =?us-ascii?Q?VGvvwO5D47E4mB8j7d8PVJ9mH/+eg+7LX+ECUc7ok8tcLl6MwokFwV6NfOke?=
 =?us-ascii?Q?kSFyObFgZOckK0W5SxMGXUryNLfjoD+YIXLdUMYA/dtPADO/gRids+vTObVe?=
 =?us-ascii?Q?5uw2Fm032YcXgKKIUI2T6JTwBugBlQPS9U4piC4XbrRPHYf6j4nT04jOzKkV?=
 =?us-ascii?Q?Le1Z9nDSMrcVMteko7/DpZuFyyaYJhF+6KI2R2GbYYTOADCzAhKOdzMS4879?=
 =?us-ascii?Q?gF+WQlRBelMHSkdeN7vTZhipbsNkbmJZodu8y2OrSdpPDPyc0TLk+OHLdfHE?=
 =?us-ascii?Q?TNzGZn0+kQk/bPgojFPx9NeLfqvgp3yVq2Q8ylRxprceKaGOJRHS1Vx/HMF5?=
 =?us-ascii?Q?TalTJj8QTSO1hf+ITqjS39FXGeuWBhd1yGQDZeVWN24p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdf206a-d532-4063-9e58-08dcb85825cf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:31.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKQjyv0BZe1pgyE1wyURf5g9+R+CFquKWik/xJboKd00EnJx1rB+tEgcyxfggvvifIMCAGIfb50I6Gxi+FK1Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 drivers/net/wireless/nxp/nxpwifi/cfg.h | 445 +++++++++++++++++++++++++
 1 file changed, 445 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg.h b/drivers/net/wireless/nxp/nxpwifi/cfg.h
new file mode 100644
index 000000000000..b55dfb872b76
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg.h
@@ -0,0 +1,445 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: ioctl data structures & APIs
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_IOCTL_H_
+#define _NXPWIFI_IOCTL_H_
+
+#include <net/lib80211.h>
+
+enum {
+	NXPWIFI_SCAN_TYPE_UNCHANGED = 0,
+	NXPWIFI_SCAN_TYPE_ACTIVE,
+	NXPWIFI_SCAN_TYPE_PASSIVE
+};
+
+#define NXPWIFI_PROMISC_MODE            1
+#define NXPWIFI_MULTICAST_MODE		2
+#define	NXPWIFI_ALL_MULTI_MODE		4
+#define NXPWIFI_MAX_MULTICAST_LIST_SIZE	32
+
+struct nxpwifi_multicast_list {
+	u32 mode;
+	u32 num_multicast_addr;
+	u8 mac_list[NXPWIFI_MAX_MULTICAST_LIST_SIZE][ETH_ALEN];
+};
+
+struct nxpwifi_chan_freq {
+	u32 channel;
+	u32 freq;
+};
+
+struct nxpwifi_ssid_bssid {
+	struct cfg80211_ssid ssid;
+	u8 bssid[ETH_ALEN];
+};
+
+enum {
+	BAND_B = 1,
+	BAND_G = 2,
+	BAND_A = 4,
+	BAND_GN = 8,
+	BAND_AN = 16,
+	BAND_AAC = 32,
+};
+
+#define NXPWIFI_WPA_PASSHPHRASE_LEN 64
+struct wpa_param {
+	u8 pairwise_cipher_wpa;
+	u8 pairwise_cipher_wpa2;
+	u8 group_cipher;
+	u32 length;
+	u8 passphrase[NXPWIFI_WPA_PASSHPHRASE_LEN];
+};
+
+struct wep_key {
+	u8 key_index;
+	u8 is_default;
+	u16 length;
+	u8 key[WLAN_KEY_LEN_WEP104];
+};
+
+#define KEY_MGMT_ON_HOST        0x03
+#define NXPWIFI_AUTH_MODE_AUTO  0xFF
+#define BAND_CONFIG_BG          0x00
+#define BAND_CONFIG_A           0x01
+#define NXPWIFI_SEC_CHAN_BELOW	0x30
+#define NXPWIFI_SEC_CHAN_ABOVE	0x10
+#define NXPWIFI_SUPPORTED_RATES                 14
+#define NXPWIFI_SUPPORTED_RATES_EXT             32
+#define NXPWIFI_PRIO_BK				2
+#define NXPWIFI_PRIO_VI				5
+#define NXPWIFI_SUPPORTED_CHANNELS		2
+#define NXPWIFI_OPERATING_CLASSES		16
+
+struct nxpwifi_uap_bss_param {
+	u8 mac_addr[ETH_ALEN];
+	u8 channel;
+	u8 band_cfg;
+	u16 rts_threshold;
+	u16 frag_threshold;
+	u8 retry_limit;
+	struct nxpwifi_802_11_ssid ssid;
+	u8 bcast_ssid_ctl;
+	u8 radio_ctl;
+	u8 dtim_period;
+	u16 beacon_period;
+	u16 auth_mode;
+	u16 protocol;
+	u16 key_mgmt;
+	u16 key_mgmt_operation;
+	struct wpa_param wpa_cfg;
+	struct wep_key wep_cfg[NUM_WEP_KEYS];
+	struct ieee80211_ht_cap ht_cap;
+	struct ieee80211_vht_cap vht_cap;
+	u8 rates[NXPWIFI_SUPPORTED_RATES];
+	u32 sta_ao_timer;
+	u32 ps_sta_ao_timer;
+	u8 qos_info;
+	u8 power_constraint;
+	struct nxpwifi_types_wmm_info wmm_info;
+};
+
+struct nxpwifi_ds_get_stats {
+	u32 mcast_tx_frame;
+	u32 failed;
+	u32 retry;
+	u32 multi_retry;
+	u32 frame_dup;
+	u32 rts_success;
+	u32 rts_failure;
+	u32 ack_failure;
+	u32 rx_frag;
+	u32 mcast_rx_frame;
+	u32 fcs_error;
+	u32 tx_frame;
+	u32 wep_icv_error[4];
+	u32 bcn_rcv_cnt;
+	u32 bcn_miss_cnt;
+};
+
+#define NXPWIFI_MAX_VER_STR_LEN    128
+
+struct nxpwifi_ver_ext {
+	u32 version_str_sel;
+	char version_str[NXPWIFI_MAX_VER_STR_LEN];
+};
+
+struct nxpwifi_bss_info {
+	u32 bss_mode;
+	struct cfg80211_ssid ssid;
+	u32 bss_chan;
+	u8 country_code[3];
+	u32 media_connected;
+	u32 max_power_level;
+	u32 min_power_level;
+	signed int bcn_nf_last;
+	u32 wep_status;
+	u32 is_hs_configured;
+	u32 is_deep_sleep;
+	u8 bssid[ETH_ALEN];
+};
+
+struct nxpwifi_sta_info {
+	u8 peer_mac[ETH_ALEN];
+	struct station_parameters *params;
+};
+
+#define MAX_NUM_TID     8
+
+#define MAX_RX_WINSIZE  64
+
+struct nxpwifi_ds_rx_reorder_tbl {
+	u16 tid;
+	u8 ta[ETH_ALEN];
+	u32 start_win;
+	u32 win_size;
+	u32 buffer[MAX_RX_WINSIZE];
+};
+
+struct nxpwifi_ds_tx_ba_stream_tbl {
+	u16 tid;
+	u8 ra[ETH_ALEN];
+	u8 amsdu;
+};
+
+#define DBG_CMD_NUM    5
+#define NXPWIFI_DBG_SDIO_MP_NUM    10
+
+struct nxpwifi_debug_info {
+	unsigned int debug_mask;
+	u32 int_counter;
+	u32 packets_out[MAX_NUM_TID];
+	u32 tx_buf_size;
+	u32 curr_tx_buf_size;
+	u32 tx_tbl_num;
+	struct nxpwifi_ds_tx_ba_stream_tbl
+		tx_tbl[NXPWIFI_MAX_TX_BASTREAM_SUPPORTED];
+	u32 rx_tbl_num;
+	struct nxpwifi_ds_rx_reorder_tbl rx_tbl
+		[NXPWIFI_MAX_RX_BASTREAM_SUPPORTED];
+	u16 ps_mode;
+	u32 ps_state;
+	u8 is_deep_sleep;
+	u8 pm_wakeup_card_req;
+	u32 pm_wakeup_fw_try;
+	u8 is_hs_configured;
+	u8 hs_activated;
+	u32 num_cmd_host_to_card_failure;
+	u32 num_cmd_sleep_cfm_host_to_card_failure;
+	u32 num_tx_host_to_card_failure;
+	u32 num_event_deauth;
+	u32 num_event_disassoc;
+	u32 num_event_link_lost;
+	u32 num_cmd_deauth;
+	u32 num_cmd_assoc_success;
+	u32 num_cmd_assoc_failure;
+	u32 num_tx_timeout;
+	u8 is_cmd_timedout;
+	u16 timeout_cmd_id;
+	u16 timeout_cmd_act;
+	u16 last_cmd_id[DBG_CMD_NUM];
+	u16 last_cmd_act[DBG_CMD_NUM];
+	u16 last_cmd_index;
+	u16 last_cmd_resp_id[DBG_CMD_NUM];
+	u16 last_cmd_resp_index;
+	u16 last_event[DBG_CMD_NUM];
+	u16 last_event_index;
+	u8 data_sent;
+	u8 cmd_sent;
+	u8 cmd_resp_received;
+	u8 event_received;
+	u32 last_mp_wr_bitmap[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_wr_ports[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_wr_len[NXPWIFI_DBG_SDIO_MP_NUM];
+	u32 last_mp_curr_wr_port[NXPWIFI_DBG_SDIO_MP_NUM];
+	u8 last_sdio_mp_index;
+};
+
+#define NXPWIFI_KEY_INDEX_UNICAST	0x40000000
+#define PN_LEN				16
+
+struct nxpwifi_ds_encrypt_key {
+	u32 key_disable;
+	u32 key_index;
+	u32 key_len;
+	u8 key_material[WLAN_MAX_KEY_LEN];
+	u8 mac_addr[ETH_ALEN];
+	u8 pn[PN_LEN];		/* packet number */
+	u8 pn_len;
+	u8 is_igtk_key;
+	u8 is_current_wep_key;
+	u8 is_rx_seq_valid;
+	u8 is_igtk_def_key;
+};
+
+struct nxpwifi_power_cfg {
+	u32 is_power_auto;
+	u32 is_power_fixed;
+	u32 power_level;
+};
+
+struct nxpwifi_ds_hs_cfg {
+	u32 is_invoke_hostcmd;
+	/*  Bit0: non-unicast data
+	 *  Bit1: unicast data
+	 *  Bit2: mac events
+	 *  Bit3: magic packet
+	 */
+	u32 conditions;
+	u32 gpio;
+	u32 gap;
+};
+
+struct nxpwifi_ds_wakeup_reason {
+	u16  hs_wakeup_reason;
+};
+
+#define DEEP_SLEEP_ON  1
+#define DEEP_SLEEP_OFF 0
+#define DEEP_SLEEP_IDLE_TIME	100
+#define PS_MODE_AUTO		1
+
+struct nxpwifi_ds_auto_ds {
+	u16 auto_ds;
+	u16 idle_time;
+};
+
+struct nxpwifi_ds_pm_cfg {
+	union {
+		u32 ps_mode;
+		struct nxpwifi_ds_hs_cfg hs_cfg;
+		struct nxpwifi_ds_auto_ds auto_deep_sleep;
+		u32 sleep_period;
+	} param;
+};
+
+struct nxpwifi_11ac_vht_cfg {
+	u8 band_config;
+	u8 misc_config;
+	u32 cap_info;
+	u32 mcs_tx_set;
+	u32 mcs_rx_set;
+};
+
+struct nxpwifi_ds_11n_tx_cfg {
+	u16 tx_htcap;
+	u16 tx_htinfo;
+	u16 misc_config; /* Needed for 802.11AC cards only */
+};
+
+struct nxpwifi_ds_11n_amsdu_aggr_ctrl {
+	u16 enable;
+	u16 curr_buf_size;
+};
+
+struct nxpwifi_ds_ant_cfg {
+	u32 tx_ant;
+	u32 rx_ant;
+};
+
+#define NXPWIFI_NUM_OF_CMD_BUFFER	50
+#define NXPWIFI_SIZE_OF_CMD_BUFFER	2048
+
+enum {
+	NXPWIFI_IE_TYPE_GEN_IE = 0,
+	NXPWIFI_IE_TYPE_ARP_FILTER,
+};
+
+enum {
+	NXPWIFI_REG_MAC = 1,
+	NXPWIFI_REG_BBP,
+	NXPWIFI_REG_RF,
+	NXPWIFI_REG_PMIC,
+	NXPWIFI_REG_CAU,
+};
+
+struct nxpwifi_ds_reg_rw {
+	u32 type;
+	u32 offset;
+	u32 value;
+};
+
+#define MAX_EEPROM_DATA 256
+
+struct nxpwifi_ds_read_eeprom {
+	u16 offset;
+	u16 byte_count;
+	u8 value[MAX_EEPROM_DATA];
+};
+
+struct nxpwifi_ds_mem_rw {
+	u32 addr;
+	u32 value;
+};
+
+#define IEEE_MAX_IE_SIZE		256
+
+#define NXPWIFI_IE_HDR_SIZE	(sizeof(struct nxpwifi_ie) - IEEE_MAX_IE_SIZE)
+
+struct nxpwifi_ds_misc_gen_ie {
+	u32 type;
+	u32 len;
+	u8 ie_data[IEEE_MAX_IE_SIZE];
+};
+
+struct nxpwifi_ds_misc_cmd {
+	u32 len;
+	u8 cmd[NXPWIFI_SIZE_OF_CMD_BUFFER];
+};
+
+#define BITMASK_BCN_RSSI_LOW	BIT(0)
+#define BITMASK_BCN_RSSI_HIGH	BIT(4)
+
+enum subsc_evt_rssi_state {
+	EVENT_HANDLED,
+	RSSI_LOW_RECVD,
+	RSSI_HIGH_RECVD
+};
+
+struct subsc_evt_cfg {
+	u8 abs_value;
+	u8 evt_freq;
+};
+
+struct nxpwifi_ds_misc_subsc_evt {
+	u16 action;
+	u16 events;
+	struct subsc_evt_cfg bcn_l_rssi_cfg;
+	struct subsc_evt_cfg bcn_h_rssi_cfg;
+};
+
+#define NXPWIFI_MEF_MAX_BYTESEQ		6	/* non-adjustable */
+#define NXPWIFI_MEF_MAX_FILTERS		10
+
+struct nxpwifi_mef_filter {
+	u16 repeat;
+	u16 offset;
+	s8 byte_seq[NXPWIFI_MEF_MAX_BYTESEQ + 1];
+	u8 filt_type;
+	u8 filt_action;
+};
+
+struct nxpwifi_mef_entry {
+	u8 mode;
+	u8 action;
+	struct nxpwifi_mef_filter filter[NXPWIFI_MEF_MAX_FILTERS];
+};
+
+struct nxpwifi_ds_mef_cfg {
+	u32 criteria;
+	u16 num_entries;
+	struct nxpwifi_mef_entry *mef_entry;
+};
+
+#define NXPWIFI_MAX_VSIE_LEN       (256)
+#define NXPWIFI_MAX_VSIE_NUM       (8)
+#define NXPWIFI_VSIE_MASK_CLEAR    0x00
+#define NXPWIFI_VSIE_MASK_SCAN     0x01
+#define NXPWIFI_VSIE_MASK_ASSOC    0x02
+#define NXPWIFI_VSIE_MASK_BGSCAN   0x08
+
+enum {
+	NXPWIFI_FUNC_INIT = 1,
+	NXPWIFI_FUNC_SHUTDOWN,
+};
+
+enum COALESCE_OPERATION {
+	RECV_FILTER_MATCH_TYPE_EQ = 0x80,
+	RECV_FILTER_MATCH_TYPE_NE,
+};
+
+enum COALESCE_PACKET_TYPE {
+	PACKET_TYPE_UNICAST = 1,
+	PACKET_TYPE_MULTICAST = 2,
+	PACKET_TYPE_BROADCAST = 3
+};
+
+#define NXPWIFI_COALESCE_MAX_RULES	8
+#define NXPWIFI_COALESCE_MAX_BYTESEQ	4	/* non-adjustable */
+#define NXPWIFI_COALESCE_MAX_FILTERS	4
+#define NXPWIFI_MAX_COALESCING_DELAY	100     /* in msecs */
+
+struct filt_field_param {
+	u8 operation;
+	u8 operand_len;
+	u16 offset;
+	u8 operand_byte_stream[NXPWIFI_COALESCE_MAX_BYTESEQ];
+};
+
+struct nxpwifi_coalesce_rule {
+	u16 max_coalescing_delay;
+	u8 num_of_fields;
+	u8 pkt_type;
+	struct filt_field_param params[NXPWIFI_COALESCE_MAX_FILTERS];
+};
+
+struct nxpwifi_ds_coalesce_cfg {
+	u16 num_of_rules;
+	struct nxpwifi_coalesce_rule rule[NXPWIFI_COALESCE_MAX_RULES];
+};
+
+#endif /* !_NXPWIFI_IOCTL_H_ */
-- 
2.34.1


