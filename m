Return-Path: <linux-wireless+bounces-9385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8143911D93
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0D2284117
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382A172762;
	Fri, 21 Jun 2024 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUL1Ey08"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2046.outbound.protection.outlook.com [40.107.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF57171E6A;
	Fri, 21 Jun 2024 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956431; cv=fail; b=GGo9LFkHI6QuYR9xuIqkuVAT5tGE2gSvrhg0aPcRoCB8fnkx4EvD0uoGm3gIQQlv8WhDsRH6RC8jPVCnkjFj26UPLX1/AWT5rqNkgIJubbyw4CFWpnz3ypwTHnVqT8GIDTF49eXp1c2FODLiMazO1ABiBSN+gROuoSDvO4lC+eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956431; c=relaxed/simple;
	bh=+Hc38o8j24z5H8NImnvPilD/fhU5NEpS24m3JhDdxE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jidpjJvhS5bR2vji299K+LMg6P5rQXo/znuuxhp0g+HUlslK/aM36nvDgLmu/a4rMU/IdM504M7ZLLyVSBME7UkvnfDdqUetmHNitBeEN/FE/WGXd8sNcOBMPAo6ODRDEY3WrEz5Lc7jh2Gj3geXk0YNqxJjbRDIU7kFyn7wjSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MUL1Ey08; arc=fail smtp.client-ip=40.107.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu3HUPMGAzMZafN6ZUVcVPN8aHKb/m5VuN77EICIY2SO/CGGTZWMG4wI7npRn1uPdwOz6UGmAYq5mC8sl7tMrIrAPiGiTtuGJC2zBIrSK83hWEdAjtAV0hHRhRTT3RRxVRWgkOEMuroQuiE7mSARYDUP/o7LgseQorV9He7LyiL4M641y55cWEC3O9Uygyh7fxlwB2zcjIudDpqci/OITkJ7k+Qt+okn26zpD9tUUKjIyz3BZoQQmIbllofiFJDfnG6yxUXn2SdIyGSzoJRS9iLVVnb3l8my379B8bUd7u/j6mDiAVPcjUalEcm4QxUvHnKQzmRbvYExpfFttcSwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFc39Lj0uGo092n8QLjDs8jPw9mCJvcmIKCEJw+1DeE=;
 b=YXczyMr9BFLt99R31oqXuka8GZCsIafeatY7B4FIkSkAVnzy9ND20KNCXgcMZCHpB5bb7PYzF4/dqZb3cVqxKxllwkkiB2zu0FT6CmBBs33t1D4p1WM7ZMaEMD4h/HXZ5E9N4JoGZZCt88cz/BGD9bqw9TyF5+16pbnxih4Zh8c4TVR5FrmFwyGKxs8mEcwYERFx3U++kMz1Y43NT+ED1lya3fldxxXRxBqzqxG78MVkArumXuhdWbh/aPPuai8MRQKLHwQgsYPzPhr3TUnCagQluU5JlkSfs6AiY87PNIe3z2barhTl9/JUmii205mggBGFFY99Nus2XQad+DhFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFc39Lj0uGo092n8QLjDs8jPw9mCJvcmIKCEJw+1DeE=;
 b=MUL1Ey08FWdnSqRfXQqG3IEDF4m++HSdzo/zAJ1ehT+KflNGrWo2YuILNBSNkRIQRcmjAiGuJwFMDdH9Bhs8f8YDGTBFOWUkAc9MxI6DDH4qsqc70iY2bFyQpEJ/xCm5e2tTnnLdro6bCKPYywaDyWNBjlNcurBWGJ17mZ108qI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:53:44 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:44 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 21/43] wifi: nxpwifi: add ioctl.h
Date: Fri, 21 Jun 2024 15:51:46 +0800
Message-Id: <20240621075208.513497-22-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e06da8-24e2-41ab-01bf-08dc91c74665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBj3RHjaXlVNoOhOBzI9tHIPoAAOrWbdWZbYS1z8+xcjuwZsRnok8ofpZkgi?=
 =?us-ascii?Q?ut0R89cio6k1Qfc8Vys1LhfJenju3ugcilZ2hbruKZkokKCbJYnR4gibkarD?=
 =?us-ascii?Q?7ByPcTFq5xSTc+FxECtkyxa3Slyox2fKi8LlysBIBRL3Aq83TB8hdxnX+DSL?=
 =?us-ascii?Q?ujjrGnwv/KwJwZieTWr8D1/SPmHFdJtIOrPDlyzQ40DrPWGn4t8pDJOVFmQs?=
 =?us-ascii?Q?WpYs/kU2SWOoYxWtgU6DiEBxPa/2/nEa6ThPYK1DvV/8aA7o8RJGNES5XM0N?=
 =?us-ascii?Q?ge2+T7P7pw2slLQSMexw+1WyxzPMxxcnQCgIejhv/w9zGxoQqFZ8XpbWWgZL?=
 =?us-ascii?Q?DwxOA1J7y4JQSS013QP7G1VoCgP89joqDVUFlLtCjkGaUgfeZgYAyk1m4JbK?=
 =?us-ascii?Q?X12aC2uFoR7RAGPW+kNbrVNDaZASw9xCVIGzuuzNpJ6gan+j1r/IEhf3tBj5?=
 =?us-ascii?Q?JlSOqc3rl0oG4jD+ZfTTzXJ9vZOmQt4B5H3lA4aePdjq4swUrASh5oPIghQS?=
 =?us-ascii?Q?aDJkgNrYqxBqK+4QvRnO18hmThI2sjEav9stsR0I5Oz99OMedg47YHQbe801?=
 =?us-ascii?Q?yVmb3SGe7ZWH5Olad5xSADZ5Aqua7WEzIQ+61CII8a68YXiIAPGPGtUDJT8g?=
 =?us-ascii?Q?zoHPpOWrSMrZOAYzTtU/baFDeWs7OWNbxniyFpxjxQJWVkKty7o7AbU6rwKj?=
 =?us-ascii?Q?nvBh+T923Zh/P2UKSj0ReD8I2n0c0Smf8L0yGNkj2QxK9/bn6tzLnkGjuDxr?=
 =?us-ascii?Q?Ye9Gv11wfJ9fpYMOcLpzqC0iVn04bNxdLQtia+c4GHwy5Z/WPUNVqOu0ptkZ?=
 =?us-ascii?Q?h2ICwX30NaHWHzEujCkfNinb7Arjg4IH4mOUiXpY9oyY3q5EdIezGMWT/IdN?=
 =?us-ascii?Q?LmuMcM92ueUY67846eNlGXX0gvw/xMLLVDa0cIa+It0purzznc5yXO0yxIY0?=
 =?us-ascii?Q?35k2jTKgz/toQt9MPbxmgtS9M0+3KiaO5E/916YhF5PwFfo17KCALap4sDBt?=
 =?us-ascii?Q?1IGGCX4XDRhw9eel8ef1WEx6iNnPoDyaAKTLOSk+Bw5koaob2TiwpdstK1wG?=
 =?us-ascii?Q?70DKfIll48z7HkyHgU1gPUlnvypvAao1z/HXuAT1Bs+hudiUh5+DCmDM4Qw1?=
 =?us-ascii?Q?0fyILG8k0Yq4XkzyCd+lzFJlfDQC2nCrTofG5AK2Fcxpx+POd6F1dLncMkOr?=
 =?us-ascii?Q?Oz1uxRW9b0lRWxSh7v3/4Y0IiQXOOop2KXIJGL4wHCMG3biZGbnx+5dc2pm1?=
 =?us-ascii?Q?jvVlgZNAtyTOVbhxb3qRMmi6AusmyiKQGkoAAftYbjfU71gPB/ONXf+5DuOW?=
 =?us-ascii?Q?dkjd+Cvg1EiiBG6+82AOrmfGAsi5KgFnQgM0P6dkaRr3ccJdv/JNgN31om2h?=
 =?us-ascii?Q?eVvmfPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mde35GWc+sSFU3Qf+eVHlh5oaMCKEMjjVr1d0aeVq0Rdgk3edWoLOYbF0E4o?=
 =?us-ascii?Q?0mV4K5u34uawlM/N4bVHrCqPk70kCd2cqKnSyuCoeXLLWea5J4fR7bhnLuC0?=
 =?us-ascii?Q?JOyZNuaw1XRtcmJhYRu2apc7UlUOpG13BR3yfavDKOZTwspm3Z1Y1XE7B8sa?=
 =?us-ascii?Q?1Tx+2lkHLSKeh2hj2aFvhnDlOkB3m1MAdpbrHXzu0qTrwd2jHtpEnh6mZFNZ?=
 =?us-ascii?Q?ljuKcxUNwg+u/te6nyo/CKN91yN/YSZ47/EZ8tSmN34wLTrX7QvNl7ucKwbm?=
 =?us-ascii?Q?lLEfQWm6mOTEFxIuJ+snzqfLHcaKDIXwOriOC4BNFjFMXahwqZfzXGy5cM+u?=
 =?us-ascii?Q?yYklYi6mfZfTbT+E6KRyPHpfKr1EJrzv+Z6qoDyV6NQBx/TuuGkbMJ5n7FUh?=
 =?us-ascii?Q?HpAnpetE15TNKYng5lcbzlFNyo8nzUELneYRSqjk3cjlMlq6550UZhK6hnPX?=
 =?us-ascii?Q?kxw3iBQnMYJ7fPYxYDE/vrF7XOr/wWGFSvEQxDAIiZNPCAJxVRAFiG5ZhOhC?=
 =?us-ascii?Q?wPmNa+Pn/1OIzF3pCxbFxe8qpQ/ZmmUSoAJ+kqLMrzxHTaSJEb/Zjo6dvIEC?=
 =?us-ascii?Q?3cOOrXrNbz/4jSJLfcb0OKTDHMGnMSrGww/31DH2X3ZVXmN39zElZnnYe8KP?=
 =?us-ascii?Q?ll1hKfU7LTZ/4p/LKLWo3ubkmHCCTnY1TN7uTOGdGGLDWbcRRbT65nZFMrSv?=
 =?us-ascii?Q?1idP+7x/0+9meVYpvy+l7Wjg2UZpYuDPC6S0cw3fAwmw+KUj/y7nUSYVHoWQ?=
 =?us-ascii?Q?UlvCsizFJpV/7KFNoD6b1SER+ZvQ7TdN7/VSyWW+1DyS7dYChief6JGg/XMa?=
 =?us-ascii?Q?X+EkbwadhFCdsMGYG+mANFmguOZBz1UA/Dru2Fu4ncyrPLKOnq+wWlSb6UX/?=
 =?us-ascii?Q?VqiGIKec1MW8wWn9ZrAbIIz8eMV59UVf4f1LWuvK0Fvixe6mNooX/ReemalG?=
 =?us-ascii?Q?cdDXF7fwmOv0mneLM6m5EQS0wnX/ygct9aUVRhAfrkk0w+6MMsBJ7skhYqly?=
 =?us-ascii?Q?NG4O4M6gbz7IjTT/nJxmB8yXMSUTPit82o9YA/rgeuNdMHIoZSPKCjfAcC5l?=
 =?us-ascii?Q?MroBY0c1hR1DbCnd9hMzrkvwgrJ7iooXBWP0wan2eYK+KymPJGna5GwD89WJ?=
 =?us-ascii?Q?ReItTEoq/hkmChKvLSZX04XaXT09p8RhV4rOMNow784xeaN/xEybJQNy+J5j?=
 =?us-ascii?Q?nfu/h9v7uD+1RWS5F1RtqLvHUXtpdx4sPNC+SQ+V2pG9uFQlHcpGqEqDQTMt?=
 =?us-ascii?Q?Trj127CMfhyjq7DWErtif86s/MUhySV3bIMn1nd6cdiR6nPFttCsOTOsVw09?=
 =?us-ascii?Q?/9iaVpm/VEQFsSpx9dEFTHLetBV7liCS+IvyJXeHWBHx6EgJkpFbQB6Q0dPU?=
 =?us-ascii?Q?CqFp4gZAP+v/5Cc98gRFL74EqcgUZkKtBxD897eWh20U8CbEeccaqjHs5f2Q?=
 =?us-ascii?Q?nVYortj8S0UYES0+Yi0R0xrXgYYHABk6iZSu5CFNXIQ2QkFHArb2MHyfYW1k?=
 =?us-ascii?Q?bJpQWD3WrlPNy+qfIJ0Vq2OV5ZOGhLL05+pb8FnWO2DjuPJ/ebuYyqt64T8j?=
 =?us-ascii?Q?s3UYvW69QXIYpnsG3j2s6clXR8I1IUuCHdOCzQEG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e06da8-24e2-41ab-01bf-08dc91c74665
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:44.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1X8P2BO3H0IhteIHzB+M2JZxYHPIQJS5N3pEtWmw3BfjIkcIvm07VM89jH7NqOm4aV3E9wHsYT4hQsdZLcgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/ioctl.h | 445 +++++++++++++++++++++++
 1 file changed, 445 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ioctl.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/ioctl.h b/drivers/net/wireless/nxp/nxpwifi/ioctl.h
new file mode 100644
index 000000000000..b55dfb872b76
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ioctl.h
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


