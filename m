Return-Path: <linux-wireless+bounces-13294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA2989AA2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E70F1C21361
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC9D17B4E5;
	Mon, 30 Sep 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y4m0l6gT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED0E175D4C;
	Mon, 30 Sep 2024 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678290; cv=fail; b=BUhESopk8ifaNlTKEUvtJTue6WqCzB5ar/jKsCL0aoNaSxu28uL0WqDGDWPsbBY1pOaQ7WWgD2tIAaZy1Ak5OVRpZafipjPpysygLX5N3qG5i9s86LbS6BMaeyAOyrFp+3uel4g0X1H2LGGJZuM8Sew1k9nwXKyc9/0HOA5QzAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678290; c=relaxed/simple;
	bh=VcdB3JgYG/LipjeVhob7QqQ6ZzmkJ4CKhEJwHXVB//g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=or1MbLZZU7fo4bvsf3d8o44gf3iAuISb+weovO2hHoih1J8eysw4FwVh9HVDcvbBBHA9mTKFGzCbqeAQ8S4VnfRYfGFd2Dokg5PuuGJt/eYSkUDm8U8nq/9W88F8nV0PUEHnV2dCym5xqMXDNZxrImNV1EBMj21ipRsTf2gY+Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y4m0l6gT; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyE8LsQ9MaRrJhBMvTEOsU8DX0fTnqh1hY8KgUCA+wA9c7wIoTI47BPOcmlW9bCqgC0xqiI7y6UoRytevE15oXgsgndoB2sEILmYtXkqpky253PiqwMnKqhxwca4oOq2eVSGIujAIxanUtO1ye714JC08yhBn4vEi4aJ6aNwTaXVqgKQTuzJDd761N19YrFgv64pBC+Ql62UhpmRhoIK0z3xqnmZKJBd5zpD3EUjwmYVM+BeSrWe6Mo342rp/ApKlbCZgMe0HAKzTACkt2ORP6HFqR1A0UWqwYCX6CyovzXAM+FlUPtAIfAw1cVm5+W0MO0qIHTLJABUjVRcHqRR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0zDSZeBOyt17vs6ECOwPsjkNRNjt2O0icKdovxCG/4=;
 b=xbaYCF4Rj/uxe4ayX9mOQEPf/cGZu6xI+/jnGkZ1CnUgH1xo0w2CmhNGKX2wlF90PMBbR6TCa+SrizwuepFS1F78Ll5TNb3Fkw+22ss2G2LB4WCc/K5cz5CbCc2WGWbvhUMYVqdsx6ZJc1MBS8ADqEfOiZ0hzqhCbWkYJ9r4Y1E9TJ4wgQlrrlD7PXIYYHxKdyWqH8h707NCdEkaJDiCz52S0yXTop/86YMlrIfJ6xp8VBovJIdhS1wi721nqoPpOvcxCWveXv27VhhmNckEKXtWwHtXrSfGlfL2J7ejSdE/7j71Fu/S9k0RJ7h9CMpz9Tln6eNxxtAdncTK19cySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0zDSZeBOyt17vs6ECOwPsjkNRNjt2O0icKdovxCG/4=;
 b=Y4m0l6gTBTsnkXhZw89r5v7rPTvbM4i6kE5onkoldSYeBmw33P4k71PUMHd4P3Ho51oRtoW3Tky1qBn/iM7dZAh69FlED+/ntkfLTg4NqUHdR1j2OhRcTeEErR/Gp7hfdppeaqKL3I75dvhy8aLAeTm5hi1X33HDSHIMhntEn/WYypjNhRMt6qCTEEeuwdA+uxtmshXQPIrZtNFfu6E8MH2eBT0ikG/qto1M+Js/PDC8uD3aGNhZp4ijw/wAm5uYC3wG5mHC6k58OxFND6urYP7yD9gyLmQfyxxwPOjclFrJL5SBT/nHvxiHajAWzGcGJaMKBb+6F6vT7GUzYT0qDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 06:37:55 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:37:55 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 09/22] wifi: nxpwifi: add configuration files
Date: Mon, 30 Sep 2024 14:36:48 +0800
Message-Id: <20240930063701.2566520-10-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b8cb65-6d35-4c79-8adf-08dce11a6a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?okzMDGbH7ZIZe3zLajWC6HhI6hQduQhg+kzAKHlBKmzI3hc/V0oMEARD267j?=
 =?us-ascii?Q?0dp/jZCVdEc8AvQthSFXbwHmGeA2Gx9wEjJaaGTR72UfqHJO7QNTEPPUH/Qw?=
 =?us-ascii?Q?YgwIADpc9tHRRdQRLN0oRVi7Gq7vnbRqetNa7JxEjNeJ1U8s8YgeVUPNNORL?=
 =?us-ascii?Q?kCK2wCCnetXVI/s3jnu6qxa1yaJBLx5D3J7nEW82/iu5ZPQlJkR/Bxor3cwE?=
 =?us-ascii?Q?OCxL1k0GSt/5MW2Q+OTX7uaaGOMXwmzouWegif1n2am2hMIA+OUAS9EPd8z1?=
 =?us-ascii?Q?t+k3V8CFrmCXuHL6SKX5ak+ewv2BH0J6BPnnO8e1Vq84R1vk8aiySxPhs7T+?=
 =?us-ascii?Q?0Fl3lzbxnyqHSoNlB+5M4pk5YQfE/9r+HIaaHLdUExHPUvOHrU9v+WvAggkT?=
 =?us-ascii?Q?VXjji8FdlMqvUyPr4jYqlt/vBprFVqTTHApv/6Styf90XKYQKLlMw7Z0Q7EU?=
 =?us-ascii?Q?3WCZldrxX2FLVBsMHcERk7W7R0VZo51N1b9fYhTJhrpO+UDPG2uyYdaohiX4?=
 =?us-ascii?Q?Kwa4a9PCB/SXMlWr2RTzDqq/pr77z1ZkkMGWsG2Si0oVlfBycM+i2azJDJSQ?=
 =?us-ascii?Q?aUf47VbQnrHSg9ZdrH/+d/wxwr4ql/YkeLqG5V6v713IxKsAMNzxiX9g8t1w?=
 =?us-ascii?Q?/xoMo3L9SUJHFOICf4oEr8NlmFy5CnSi9u+4YimL9AXLUKpz2+IQeXcw0/l8?=
 =?us-ascii?Q?ww+kIWPEsaF0U1hLgWeJMVRmAKL6xk2czFYWCEJm6LNKSDVAVnchamKlR3GL?=
 =?us-ascii?Q?4o+ICpIZGDOZrtw+maJClOH1suKrAqghP77MjdP2bzqFt/Q/iePGQkfb/vCR?=
 =?us-ascii?Q?vf8znY8Obt9yX6RL2C1iqjhrGBCQQr7WQvO2UyYTALCjx2F0p1GGVSGfl74b?=
 =?us-ascii?Q?56+BNcBh0hfrXkf34KJqTbyWh153D1XiSHfodOt6gDhxxEhvsYb3ZousmSY5?=
 =?us-ascii?Q?7ExEyqZUuy0gtM76JzHLvmjcqqpt+727yqLp0NuwzHUAHYVKQ9xHzA9/dh4Z?=
 =?us-ascii?Q?g9OYdr/fsDKvigZCTSSnhsPTgl7IrmMw+Op+14ELnB1nNvcD7CAWdMXwdczy?=
 =?us-ascii?Q?agGTxYGabUPZxbIqWPKcha51AHND7qYpM/MwOSWGUgL1ULUBmShq6IAid+xH?=
 =?us-ascii?Q?1mlQ5dBLaoB8ks7tf8LJ5yVonVhXlDoVt8x/eEjvGkg+4SQ2up4+4OPXaQr/?=
 =?us-ascii?Q?X1OuNabRj0s08ECyAWCO8nsN1JBfGZzke3fdwBmiYlnNcCb8pKBu/oPly5Ns?=
 =?us-ascii?Q?rrRcOGJeB2Ubw1GSbrdcRKLOJ5wICTkDzmdHGqgHZJYuEkirWGR2L7HJV9CW?=
 =?us-ascii?Q?Uw8uca63thgk/ROskqI1T40TFTOE3w7jMss322+wHuCcsQuEesJcwZq9d8tH?=
 =?us-ascii?Q?ScX2H+ydj2UEn2pVJA7HU/5438CwCgXMeqF/BfgR6twbzpdnuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IXjXCrp+X6Bww818I+BRrrER2SCoR90MpXAjMMDjhO1o9+l2c2xmUX9ZSuwq?=
 =?us-ascii?Q?ronzX+PBneRyqVRgScKRmBUr6/2CWQFiEwVZKJB2vc2uTvFzQGhD9jtaMo8S?=
 =?us-ascii?Q?Y2lrim2Nk7s6FpXebN1nLAU7BeHZtJxcZkQhjPDXrxDOnx69HJXQtxPOJs+R?=
 =?us-ascii?Q?lHgM4U6bFtI5f9yCatHv79F/eRxLRaThHXsNjS+mZYP7UD86tZ7LU564Xcjy?=
 =?us-ascii?Q?eO2oc9noPcbTdjTXYgYwBRWGo4bqUhC4vo6cD+gC8bbodkr1A7IS4B44FRKp?=
 =?us-ascii?Q?BnKwkRkKcywdOMhj5Jz0H0eclQMFTvPmBn1i7fhbWxEv6wAAPcKG8ZMLOcYc?=
 =?us-ascii?Q?nkjkkkwqQuGIMt2cMpPId1Zuw/gBJgSbJ9XAyV2tiV8Io6+n88W+ZwBLhE5I?=
 =?us-ascii?Q?NiuKT2QPg2kcOgHTKooefsIC43p/vsil/wUv9HTur38aXPjJJScH0PV/o4Ht?=
 =?us-ascii?Q?5WLQn8AZy4oscZlZ4XYWUZCcrCTc6/L/ZCWBhqAgwmUvVxQSxe0J8JNk/WdL?=
 =?us-ascii?Q?Lqy++MkLFpzjmxrF8J6zYTeG5rWdwPZviAcoN2n1EwuaGWWZYkDZKOBipsbF?=
 =?us-ascii?Q?kzUJniZeH/zt2WCos/EXBKumle9QOFVGmyxNEGEdANPj8yrDlF28fZNulbny?=
 =?us-ascii?Q?fbVDoJaZrDKA/Qpcwkg7umf6RFsu87Pv5eTl/LPZTdRH10NagzqTQkToSuYO?=
 =?us-ascii?Q?EzOrY9l0xLrDKxytKSgwFVo9nk53YbKHXNduVm7x2Uwr4jSMHNqCHYcJg4tl?=
 =?us-ascii?Q?DED6DNULXUttEgRH2rSlp0EQ1tXxkcVI3d9Th+JAMrmAkt7tlbiLQY+Lo8RI?=
 =?us-ascii?Q?k5SmcyYoMPP4WScxjMjbYUyF90hcoD8J2L6xR2HQCA8jpTS67u+lxBL+uCZu?=
 =?us-ascii?Q?74gFnRtEWrfNuSM0mkEFE1rurTRWfZ0o+qZvf+OUqkkoJ2c90F+t+/WeTRUw?=
 =?us-ascii?Q?3GsGLFtoeiS9yq4tGg1os+ofEbjz6R24TtVSZYkwRvXoRQDEnDB+e6Hlg6tA?=
 =?us-ascii?Q?tBWiualYEwCRM1nS0JDbZrB1A7I/+iPStpo2wOXn6tOL9gRuRvPSoS1J6viQ?=
 =?us-ascii?Q?K4yN1A+lBxKbr5fKQaVPnbLsoNKcFIvcDgx1APiKk4KVjldBmDSb8Y9Kwdjm?=
 =?us-ascii?Q?QEdCHoPsaAA4vgVJmMuBSj3fzbtQBRDE2s5gjGrHvFRVw+AmrspQZggd4ikR?=
 =?us-ascii?Q?L1z6pEOIZkNh3ssh2OjHU/V6tXF42tzfH2EJcn3cUBTvSgsJZ/uhDH2/hoeJ?=
 =?us-ascii?Q?76/k2MZiWOCpskiEnNPztULQbRsJUL/5rCoTjRMK9Mu9ZoY5N7WpXOwDstFN?=
 =?us-ascii?Q?pj+uQSCwwYjJ1nIEhdx5zE+gXZSpafl+E10THrgCoXECuznE2Ban3P0qCBje?=
 =?us-ascii?Q?4jGOgYpS794gNUSA10xwcaFs4ayqFrXRMJDKev23qj+LyO+BqFaDQjiL04Wp?=
 =?us-ascii?Q?p3PzcHDe9KoDRkoKxFckG5ux1rSxrxbXKZPMxI3uhodEvnr3r1kTjgvrq6A3?=
 =?us-ascii?Q?XHYoolM2pjL3lqrtFOhVfmpYzkvhFVQOsKSguyraRkUxZ9WfLlawuRMfp5Gm?=
 =?us-ascii?Q?ca5E5YdpAmvWekK530paRAEnclHmanU5njwNQdka?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b8cb65-6d35-4c79-8adf-08dce11a6a7f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:37:55.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vd03RmSgqgOSi7p8I5YNYOcOC88+A+aWCazHTxdYMVKVBIDMRVMsciTLAvqqYbbhlNj+Lqxu2uDMc0na/fgl4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

File cfg.h defines constants and data structure used to configure
nxpwifi.

File sta_cfg.c supports common configuration functions used to
configure nxpwifi or get status of nxpwifi.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfg.h     |  874 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c | 1311 ++++++++++++++++++++
 2 files changed, 2185 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg.h b/drivers/net/wireless/nxp/nxpwifi/cfg.h
new file mode 100644
index 000000000000..6d13655f5a8c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg.h
@@ -0,0 +1,874 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: ioctl data structures & APIs
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_CFG_H_
+#define _NXPWIFI_CFG_H_
+
+#include <linux/wait.h>
+#include <linux/timer.h>
+#include <linux/ieee80211.h>
+#include <uapi/linux/if_arp.h>
+#include <net/cfg80211.h>
+#include <net/lib80211.h>
+
+#define NXPWIFI_BSS_COEX_COUNT	     2
+#define NXPWIFI_MAX_BSS_NUM         (2)
+
+#define NXPWIFI_MAX_CSA_COUNTERS     5
+
+#define NXPWIFI_DMA_ALIGN_SZ	    64
+#define NXPWIFI_RX_HEADROOM	    64
+#define MAX_TXPD_SZ		    32
+#define INTF_HDR_ALIGN		     4
+/* special FW 4 address management header */
+#define NXPWIFI_MIN_DATA_HEADER_LEN (NXPWIFI_DMA_ALIGN_SZ + INTF_HDR_ALIGN + \
+				     MAX_TXPD_SZ)
+
+#define NXPWIFI_MGMT_FRAME_HEADER_SIZE	8	/* sizeof(pkt_type)
+						 *   + sizeof(tx_control)
+						 */
+
+#define FRMCTL_LEN                2
+#define DURATION_LEN              2
+#define SEQCTL_LEN                2
+#define NXPWIFI_MGMT_HEADER_LEN   (FRMCTL_LEN + FRMCTL_LEN + ETH_ALEN + \
+				   ETH_ALEN + ETH_ALEN + SEQCTL_LEN + ETH_ALEN)
+
+#define AUTH_ALG_LEN              2
+#define AUTH_TRANSACTION_LEN      2
+#define AUTH_STATUS_LEN           2
+#define NXPWIFI_AUTH_BODY_LEN     (AUTH_ALG_LEN + AUTH_TRANSACTION_LEN + \
+				   AUTH_STATUS_LEN)
+
+#define HOST_MLME_AUTH_PENDING    BIT(0)
+#define HOST_MLME_AUTH_DONE       BIT(1)
+
+#define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DEAUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DISASSOC >> 4))
+
+#define AUTH_TX_DEFAULT_WAIT_TIME 2400
+
+#define WLAN_AUTH_NONE            0xFFFF
+
+#define NXPWIFI_MAX_TX_BASTREAM_SUPPORTED	2
+#define NXPWIFI_MAX_RX_BASTREAM_SUPPORTED	16
+
+#define NXPWIFI_STA_AMPDU_DEF_TXWINSIZE        64
+#define NXPWIFI_STA_AMPDU_DEF_RXWINSIZE        64
+#define NXPWIFI_STA_COEX_AMPDU_DEF_RXWINSIZE   16
+
+#define NXPWIFI_UAP_AMPDU_DEF_TXWINSIZE        32
+
+#define NXPWIFI_UAP_COEX_AMPDU_DEF_RXWINSIZE   16
+
+#define NXPWIFI_UAP_AMPDU_DEF_RXWINSIZE        16
+#define NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE   64
+#define NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE   64
+#define NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE   64
+#define NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE   64
+
+#define NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT  0xffff
+
+#define NXPWIFI_RATE_BITMAP_MCS0   32
+
+#define NXPWIFI_RX_DATA_BUF_SIZE     (4 * 1024)
+#define NXPWIFI_RX_CMD_BUF_SIZE	     (2 * 1024)
+
+#define MAX_BEACON_PERIOD                  (4000)
+#define MIN_BEACON_PERIOD                  (50)
+#define MAX_DTIM_PERIOD                    (100)
+#define MIN_DTIM_PERIOD                    (1)
+
+#define NXPWIFI_RTS_MIN_VALUE              (0)
+#define NXPWIFI_RTS_MAX_VALUE              (2347)
+#define NXPWIFI_FRAG_MIN_VALUE             (256)
+#define NXPWIFI_FRAG_MAX_VALUE             (2346)
+#define NXPWIFI_WMM_VERSION                0x01
+#define NXPWIFI_WMM_SUBTYPE                0x01
+
+#define NXPWIFI_RETRY_LIMIT                14
+#define NXPWIFI_SDIO_BLOCK_SIZE            256
+
+#define NXPWIFI_BUF_FLAG_REQUEUED_PKT      BIT(0)
+#define NXPWIFI_BUF_FLAG_BRIDGED_PKT	   BIT(1)
+#define NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS   BIT(3)
+#define NXPWIFI_BUF_FLAG_ACTION_TX_STATUS  BIT(4)
+#define NXPWIFI_BUF_FLAG_AGGR_PKT          BIT(5)
+
+#define NXPWIFI_BRIDGED_PKTS_THR_HIGH      1024
+#define NXPWIFI_BRIDGED_PKTS_THR_LOW        128
+
+/* 54M rates, index from 0 to 11 */
+#define NXPWIFI_RATE_INDEX_MCS0 12
+/* 12-27=MCS0-15(BW20) */
+#define NXPWIFI_BW20_MCS_NUM 15
+
+/* Rate index for OFDM 0 */
+#define NXPWIFI_RATE_INDEX_OFDM0   4
+
+#define NXPWIFI_MAX_STA_NUM		3
+#define NXPWIFI_MAX_UAP_NUM		3
+
+#define NXPWIFI_A_BAND_START_FREQ	5000
+
+/* SDIO Aggr data packet special info */
+#define SDIO_MAX_AGGR_BUF_SIZE		(256 * 255)
+#define BLOCK_NUMBER_OFFSET		15
+#define SDIO_HEADER_OFFSET		28
+
+#define NXPWIFI_SIZE_4K 0x4000
+
+enum nxpwifi_bss_type {
+	NXPWIFI_BSS_TYPE_STA = 0,
+	NXPWIFI_BSS_TYPE_UAP = 1,
+	NXPWIFI_BSS_TYPE_ANY = 0xff,
+};
+
+enum nxpwifi_bss_role {
+	NXPWIFI_BSS_ROLE_STA = 0,
+	NXPWIFI_BSS_ROLE_UAP = 1,
+	NXPWIFI_BSS_ROLE_ANY = 0xff,
+};
+
+#define BSS_ROLE_BIT_MASK    BIT(0)
+
+#define GET_BSS_ROLE(priv)   ((priv)->bss_role & BSS_ROLE_BIT_MASK)
+
+enum nxpwifi_data_frame_type {
+	NXPWIFI_DATA_FRAME_TYPE_ETH_II = 0,
+	NXPWIFI_DATA_FRAME_TYPE_802_11,
+};
+
+struct nxpwifi_fw_image {
+	u8 *helper_buf;
+	u32 helper_len;
+	u8 *fw_buf;
+	u32 fw_len;
+};
+
+struct nxpwifi_802_11_ssid {
+	u32 ssid_len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+};
+
+struct nxpwifi_wait_queue {
+	wait_queue_head_t wait;
+	int status;
+};
+
+struct nxpwifi_rxinfo {
+	struct sk_buff *parent;
+	u8 bss_num;
+	u8 bss_type;
+	u8 use_count;
+	u8 buf_type;
+	u16 pkt_len;
+};
+
+struct nxpwifi_txinfo {
+	u8 flags;
+	u8 bss_num;
+	u8 bss_type;
+	u8 aggr_num;
+	u32 pkt_len;
+	u8 ack_frame_id;
+	u64 cookie;
+};
+
+enum nxpwifi_wmm_ac_e {
+	WMM_AC_BK,
+	WMM_AC_BE,
+	WMM_AC_VI,
+	WMM_AC_VO
+} __packed;
+
+struct nxpwifi_types_wmm_info {
+	u8 oui[4];
+	u8 subtype;
+	u8 version;
+	u8 qos_info;
+	u8 reserved;
+	struct ieee80211_wmm_ac_param ac[IEEE80211_NUM_ACS];
+} __packed;
+
+struct nxpwifi_arp_eth_header {
+	struct arphdr hdr;
+	u8 ar_sha[ETH_ALEN];
+	u8 ar_sip[4];
+	u8 ar_tha[ETH_ALEN];
+	u8 ar_tip[4];
+} __packed;
+
+struct nxpwifi_chan_stats {
+	u8 chan_num;
+	u8 bandcfg;
+	u8 flags;
+	s8 noise;
+	u16 total_bss;
+	u16 cca_scan_dur;
+	u16 cca_busy_dur;
+} __packed;
+
+#define NXPWIFI_HIST_MAX_SAMPLES	1048576
+#define NXPWIFI_MAX_RX_RATES		     44
+#define NXPWIFI_MAX_AC_RX_RATES		     74
+#define NXPWIFI_MAX_SNR			    256
+#define NXPWIFI_MAX_NOISE_FLR		    256
+#define NXPWIFI_MAX_SIG_STRENGTH	    256
+
+struct nxpwifi_histogram_data {
+	atomic_t rx_rate[NXPWIFI_MAX_AC_RX_RATES];
+	atomic_t snr[NXPWIFI_MAX_SNR];
+	atomic_t noise_flr[NXPWIFI_MAX_NOISE_FLR];
+	atomic_t sig_str[NXPWIFI_MAX_SIG_STRENGTH];
+	atomic_t num_samples;
+};
+
+struct nxpwifi_iface_comb {
+	u8 sta_intf;
+	u8 uap_intf;
+};
+
+struct nxpwifi_radar_params {
+	struct cfg80211_chan_def *chandef;
+	u32 cac_time_ms;
+} __packed;
+
+struct nxpwifi_11h_intf_state {
+	bool is_11h_enabled;
+	bool is_11h_active;
+} __packed;
+
+#define NXPWIFI_FW_DUMP_IDX		0xff
+#define NXPWIFI_FW_DUMP_MAX_MEMSIZE     0x160000
+#define NXPWIFI_DRV_INFO_IDX		20
+#define FW_DUMP_MAX_NAME_LEN		8
+#define FW_DUMP_HOST_READY      0xEE
+#define FW_DUMP_DONE			0xFF
+#define FW_DUMP_READ_DONE		0xFE
+
+struct memory_type_mapping {
+	u8 mem_name[FW_DUMP_MAX_NAME_LEN];
+	u8 *mem_ptr;
+	u32 mem_size;
+	u8 done_flag;
+};
+
+enum rdwr_status {
+	RDWR_STATUS_SUCCESS = 0,
+	RDWR_STATUS_FAILURE = 1,
+	RDWR_STATUS_DONE = 2
+};
+
+enum nxpwifi_chan_band {
+	BAND_2GHZ = 0,
+	BAND_5GHZ,
+	BAND_6GHZ,
+	BAND_4GHZ,
+};
+
+enum nxpwifi_chan_width {
+	CHAN_BW_20MHZ = 0,
+	CHAN_BW_10MHZ,
+	CHAN_BW_40MHZ,
+	CHAN_BW_80MHZ,
+	CHAN_BW_8080MHZ,
+	CHAN_BW_160MHZ,
+	CHAN_BW_5MHZ,
+};
+
+enum nxpwifi_chan_offset {
+	SEC_CHAN_NONE = 0,
+	SEC_CHAN_ABOVE = 1,
+	SEC_CHAN_5MHZ = 2,
+	SEC_CHAN_BELOW = 3
+};
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
+	BAND_GAC = 32,
+	BAND_AAC = 64,
+	BAND_GAX = 256,
+	BAND_AAX = 512,
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
+struct nxpwifi_11ax_he_cap_cfg {
+	u16 id;
+	u16 len;
+	u8 ext_id;
+	struct ieee80211_he_cap_elem cap_elem;
+	u8 he_txrx_mcs_support[4];
+	u8 val[28];
+};
+
+#define HE_CAP_MAX_SIZE   54
+
+struct nxpwifi_11ax_he_cfg {
+	u8 band;
+	union {
+		struct nxpwifi_11ax_he_cap_cfg he_cap_cfg;
+		u8 data[HE_CAP_MAX_SIZE];
+	};
+};
+
+#define NXPWIFI_11AXCMD_CFG_ID_SR_OBSS_PD_OFFSET 1
+#define NXPWIFI_11AXCMD_CFG_ID_SR_ENABLE         2
+#define NXPWIFI_11AXCMD_CFG_ID_BEAM_CHANGE       3
+#define NXPWIFI_11AXCMD_CFG_ID_HTC_ENABLE        4
+#define NXPWIFI_11AXCMD_CFG_ID_TXOP_RTS          5
+#define NXPWIFI_11AXCMD_CFG_ID_TX_OMI            6
+#define NXPWIFI_11AXCMD_CFG_ID_OBSSNBRU_TOLTIME  7
+#define NXPWIFI_11AXCMD_CFG_ID_SET_BSRP          8
+#define NXPWIFI_11AXCMD_CFG_ID_LLDE              9
+
+#define NXPWIFI_11AXCMD_SR_SUBID                 0x102
+#define NXPWIFI_11AXCMD_BEAM_SUBID               0x103
+#define NXPWIFI_11AXCMD_HTC_SUBID                0x104
+#define NXPWIFI_11AXCMD_TXOMI_SUBID              0x105
+#define NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID       0x106
+#define NXPWIFI_11AXCMD_TXOPRTS_SUBID            0x108
+#define NXPWIFI_11AXCMD_SET_BSRP_SUBID           0x109
+#define NXPWIFI_11AXCMD_LLDE_SUBID               0x110
+
+#define NXPWIFI_11AX_TWT_SETUP_SUBID             0x114
+#define NXPWIFI_11AX_TWT_TEARDOWN_SUBID          0x115
+#define NXPWIFI_11AX_TWT_REPORT_SUBID            0x116
+
+struct nxpwifi_11axcmdcfg_obss_pd_offset {
+	/* <NON_SRG_OffSET, SRG_OFFSET> */
+	u8 offset[2];
+};
+
+struct nxpwifi_11axcmdcfg_sr_control {
+	/* 1 enable, 0 disable */
+	u8 control;
+};
+
+struct nxpwifi_11ax_sr_cmd {
+	/* type */
+	u16 type;
+	/* length of TLV */
+	u16 len;
+	/* value */
+	union {
+		struct nxpwifi_11axcmdcfg_obss_pd_offset obss_pd_offset;
+		struct nxpwifi_11axcmdcfg_sr_control sr_control;
+	} param;
+};
+
+struct nxpwifi_11ax_beam_cmd {
+	/* command value: 1 is disable, 0 is enable */
+	u8 value;
+};
+
+struct nxpwifi_11ax_htc_cmd {
+	/* command value: 1 is enable, 0 is disable */
+	u8 value;
+};
+
+struct nxpwifi_11ax_txomi_cmd {
+	/* 11ax spec 9.2.4.6a.2 OM Control 12 bits. Bit 0 to bit 11 */
+	u16 omi;
+	/* tx option
+	 * 0: send OMI in QoS NULL; 1: send OMI in QoS data; 0xFF: set OMI in
+	 * both
+	 */
+	u8 tx_option;
+	/* if OMI is sent in QoS data, specify the number of consecutive data
+	 * packets containing the OMI
+	 */
+	u8 num_data_pkts;
+};
+
+struct nxpwifi_11ax_toltime_cmd {
+	/* OBSS Narrow Bandwidth RU Tolerance Time */
+	u32 tol_time;
+};
+
+struct nxpwifi_11ax_txop_cmd {
+	/* Two byte rts threshold value of which only 10 bits, bit 0 to bit 9
+	 * are valid
+	 */
+	u16 rts_thres;
+};
+
+struct nxpwifi_11ax_set_bsrp_cmd {
+	/* command value: 1 is enable, 0 is disable */
+	u8 value;
+};
+
+struct nxpwifi_11ax_llde_cmd {
+	/* Uplink LLDE: enable=1,disable=0 */
+	u8 llde;
+	/* operation mode: default=0,carplay=1,gameplay=2 */
+	u8 mode;
+	/* trigger frame rate: auto=0xff */
+	u8 fixrate;
+	/* cap airtime limit index: auto=0xff */
+	u8 trigger_limit;
+	/* cap peak UL rate */
+	u8 peak_ul_rate;
+	/* Downlink LLDE: enable=1,disable=0 */
+	u8 dl_llde;
+	/* Set trigger frame interval(us): auto=0 */
+	u16 poll_interval;
+	/* Set TxOp duration */
+	u16 tx_op_duration;
+	/* for other configurations */
+	u16 llde_ctrl;
+	u16 mu_rts_successcnt;
+	u16 mu_rts_failcnt;
+	u16 basic_trigger_successcnt;
+	u16 basic_trigger_failcnt;
+	u16 tbppdu_nullcnt;
+	u16 tbppdu_datacnt;
+};
+
+struct nxpwifi_11ax_cmd_cfg {
+	u32 sub_command;
+	u32 sub_id;
+	union {
+		struct nxpwifi_11ax_sr_cmd sr_cfg;
+		struct nxpwifi_11ax_beam_cmd beam_cfg;
+		struct nxpwifi_11ax_htc_cmd htc_cfg;
+		struct nxpwifi_11ax_txomi_cmd txomi_cfg;
+		struct nxpwifi_11ax_toltime_cmd toltime_cfg;
+		struct nxpwifi_11ax_txop_cmd txop_cfg;
+		struct nxpwifi_11ax_set_bsrp_cmd setbsrp_cfg;
+		struct nxpwifi_11ax_llde_cmd llde_cfg;
+	} param;
+};
+
+#endif /* !_NXPWIFI_CFG_H_ */
diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_cfg.c b/drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
new file mode 100644
index 000000000000..cf7f1f146d97
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
@@ -0,0 +1,1311 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: functions for station ioctl
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+#include "cfg80211.h"
+
+static int disconnect_on_suspend;
+
+/* Copies the multicast address list from device to driver.
+ *
+ * This function does not validate the destination memory for
+ * size, and the calling function must ensure enough memory is
+ * available.
+ */
+int nxpwifi_copy_mcast_addr(struct nxpwifi_multicast_list *mlist,
+			    struct net_device *dev)
+{
+	int i = 0;
+	struct netdev_hw_addr *ha;
+
+	netdev_for_each_mc_addr(ha, dev)
+		memcpy(&mlist->mac_list[i++], ha->addr, ETH_ALEN);
+
+	return i;
+}
+
+/* Wait queue completion handler.
+ *
+ * This function waits on a cmd wait queue. It also cancels the pending
+ * request after waking up, in case of errors.
+ */
+int nxpwifi_wait_queue_complete(struct nxpwifi_adapter *adapter,
+				struct cmd_ctrl_node *cmd_queued)
+{
+	int status;
+
+	/* Wait for completion */
+	status = wait_event_interruptible_timeout(adapter->cmd_wait_q.wait,
+						  *cmd_queued->condition,
+						  (12 * HZ));
+	if (status <= 0) {
+		if (status == 0)
+			status = -ETIMEDOUT;
+		nxpwifi_dbg(adapter, ERROR, "cmd_wait_q terminated: %d\n",
+			    status);
+		nxpwifi_cancel_all_pending_cmd(adapter);
+		return status;
+	}
+
+	status = adapter->cmd_wait_q.status;
+	adapter->cmd_wait_q.status = 0;
+
+	return status;
+}
+
+/* This function prepares the correct firmware command and
+ * issues it to set the multicast list.
+ *
+ * This function can be used to enable promiscuous mode, or enable all
+ * multicast packets, or to enable selective multicast.
+ */
+int
+nxpwifi_request_set_multicast_list(struct nxpwifi_private *priv,
+				   struct nxpwifi_multicast_list *mcast_list)
+{
+	int ret = 0;
+	u16 old_pkt_filter;
+
+	old_pkt_filter = priv->curr_pkt_filter;
+
+	if (mcast_list->mode == NXPWIFI_PROMISC_MODE) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: Enable Promiscuous mode\n");
+		priv->curr_pkt_filter |= HOST_ACT_MAC_PROMISCUOUS_ENABLE;
+		priv->curr_pkt_filter &=
+			~HOST_ACT_MAC_ALL_MULTICAST_ENABLE;
+	} else {
+		/* Multicast */
+		priv->curr_pkt_filter &= ~HOST_ACT_MAC_PROMISCUOUS_ENABLE;
+		if (mcast_list->mode == NXPWIFI_ALL_MULTI_MODE) {
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: Enabling All Multicast!\n");
+			priv->curr_pkt_filter |=
+				HOST_ACT_MAC_ALL_MULTICAST_ENABLE;
+		} else {
+			priv->curr_pkt_filter &=
+				~HOST_ACT_MAC_ALL_MULTICAST_ENABLE;
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: Set multicast list=%d\n",
+				    mcast_list->num_multicast_addr);
+			/* Send multicast addresses to firmware */
+			ret = nxpwifi_send_cmd(priv,
+					       HOST_CMD_MAC_MULTICAST_ADR,
+					       HOST_ACT_GEN_SET, 0,
+					       mcast_list, false);
+		}
+	}
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: old_pkt_filter=%#x, curr_pkt_filter=%#x\n",
+		    old_pkt_filter, priv->curr_pkt_filter);
+	if (old_pkt_filter != priv->curr_pkt_filter) {
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_MAC_CONTROL,
+				       HOST_ACT_GEN_SET,
+				       0, &priv->curr_pkt_filter, false);
+	}
+
+	return ret;
+}
+
+/* This function fills bss descriptor structure using provided
+ * information.
+ * beacon_ie buffer is allocated in this function. It is caller's
+ * responsibility to free the memory.
+ */
+int nxpwifi_fill_new_bss_desc(struct nxpwifi_private *priv,
+			      struct cfg80211_bss *bss,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	u8 *beacon_ie;
+	size_t beacon_ie_len;
+	struct nxpwifi_bss_priv *bss_priv = (void *)bss->priv;
+	const struct cfg80211_bss_ies *ies;
+
+	rcu_read_lock();
+	ies = rcu_dereference(bss->ies);
+	beacon_ie = kmemdup(ies->data, ies->len, GFP_ATOMIC);
+	beacon_ie_len = ies->len;
+	bss_desc->timestamp = ies->tsf;
+	rcu_read_unlock();
+
+	if (!beacon_ie) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    " failed to alloc beacon_ie\n");
+		return -ENOMEM;
+	}
+
+	memcpy(bss_desc->mac_address, bss->bssid, ETH_ALEN);
+	bss_desc->rssi = bss->signal;
+	/* The caller of this function will free beacon_ie */
+	bss_desc->beacon_buf = beacon_ie;
+	bss_desc->beacon_buf_size = beacon_ie_len;
+	bss_desc->beacon_period = bss->beacon_interval;
+	bss_desc->cap_info_bitmap = bss->capability;
+	bss_desc->bss_band = bss_priv->band;
+	bss_desc->fw_tsf = bss_priv->fw_tsf;
+	if (bss_desc->cap_info_bitmap & WLAN_CAPABILITY_PRIVACY) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: InterpretIE: AP WEP enabled\n");
+		bss_desc->privacy = NXPWIFI_802_11_PRIV_FILTER_8021X_WEP;
+	} else {
+		bss_desc->privacy = NXPWIFI_802_11_PRIV_FILTER_ACCEPT_ALL;
+	}
+	bss_desc->bss_mode = NL80211_IFTYPE_STATION;
+
+	/* Disable 11ac by default. Enable it only where there
+	 * exist VHT_CAP IE in AP beacon
+	 */
+	bss_desc->disable_11ac = true;
+	/* Disable 11ax by default. Enable it only where there
+	 * exist HE_CAP IE in AP beacon
+	 */
+	bss_desc->disable_11ax = true;
+
+	if (bss_desc->cap_info_bitmap & WLAN_CAPABILITY_SPECTRUM_MGMT)
+		bss_desc->sensed_11h = true;
+
+	return nxpwifi_update_bss_desc_with_ie(priv->adapter, bss_desc);
+}
+
+void nxpwifi_dnld_txpwr_table(struct nxpwifi_private *priv)
+{
+	if (priv->adapter->dt_node) {
+		char txpwr[] = {"nxp,00_txpwrlimit"};
+
+		memcpy(&txpwr[8], priv->adapter->country_code, 2);
+		nxpwifi_dnld_dt_cfgdata(priv, priv->adapter->dt_node, txpwr);
+	}
+}
+
+static int nxpwifi_process_country_ie(struct nxpwifi_private *priv,
+				      struct cfg80211_bss *bss)
+{
+	const u8 *country_ie;
+	u8 country_ie_len;
+	struct nxpwifi_802_11d_domain_reg *domain_info =
+					&priv->adapter->domain_reg;
+	int ret;
+
+	rcu_read_lock();
+	country_ie = ieee80211_bss_get_ie(bss, WLAN_EID_COUNTRY);
+	if (!country_ie) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	country_ie_len = country_ie[1];
+	if (country_ie_len < IEEE80211_COUNTRY_IE_MIN_LEN) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	if (!strncmp(priv->adapter->country_code, &country_ie[2], 2)) {
+		rcu_read_unlock();
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "11D: skip setting domain info in FW\n");
+		return 0;
+	}
+
+	if (country_ie_len >
+	    (IEEE80211_COUNTRY_STRING_LEN + NXPWIFI_MAX_TRIPLET_802_11D)) {
+		rcu_read_unlock();
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "11D: country_ie_len overflow!, deauth AP\n");
+		return -EINVAL;
+	}
+
+	memcpy(priv->adapter->country_code, &country_ie[2], 2);
+
+	domain_info->country_code[0] = country_ie[2];
+	domain_info->country_code[1] = country_ie[3];
+	domain_info->country_code[2] = ' ';
+
+	country_ie_len -= IEEE80211_COUNTRY_STRING_LEN;
+
+	domain_info->no_of_triplet =
+		country_ie_len / sizeof(struct ieee80211_country_ie_triplet);
+
+	memcpy((u8 *)domain_info->triplet,
+	       &country_ie[2] + IEEE80211_COUNTRY_STRING_LEN, country_ie_len);
+
+	rcu_read_unlock();
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11D_DOMAIN_INFO,
+			       HOST_ACT_GEN_SET, 0, NULL, false);
+	if (ret)
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "11D: setting domain info in FW fail\n");
+	else
+		nxpwifi_dnld_txpwr_table(priv);
+
+	return ret;
+}
+
+/* In infra mode, an deauthentication is performed
+ * first.
+ */
+int nxpwifi_bss_start(struct nxpwifi_private *priv, struct cfg80211_bss *bss,
+		      struct cfg80211_ssid *req_ssid)
+{
+	int ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bssdescriptor *bss_desc = NULL;
+	u16 config_bands;
+
+	priv->scan_block = false;
+
+	if (adapter->region_code == 0x00 &&
+	    nxpwifi_process_country_ie(priv, bss))
+		return -EINVAL;
+
+	/* Allocate and fill new bss descriptor */
+	bss_desc = kzalloc(sizeof(*bss_desc), GFP_KERNEL);
+	if (!bss_desc)
+		return -ENOMEM;
+
+	ret = nxpwifi_fill_new_bss_desc(priv, bss, bss_desc);
+	if (ret)
+		goto done;
+
+	if (nxpwifi_band_to_radio_type(bss_desc->bss_band) ==
+				       HOST_SCAN_RADIO_TYPE_BG) {
+		config_bands = BAND_B | BAND_G | BAND_GN;
+	} else {
+		config_bands = BAND_A | BAND_AN;
+		if (adapter->fw_bands & BAND_AAC)
+			config_bands |= BAND_AAC;
+		if (adapter->fw_bands & BAND_AAX)
+			config_bands |= BAND_AAX;
+	}
+
+	if (!((config_bands | adapter->fw_bands) & ~adapter->fw_bands))
+		priv->config_bands = config_bands;
+
+	ret = nxpwifi_check_network_compatibility(priv, bss_desc);
+	if (ret)
+		goto done;
+
+	if (nxpwifi_11h_get_csa_closed_channel(priv) == (u8)bss_desc->channel) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Attempt to reconnect on csa closed chan(%d)\n",
+			    bss_desc->channel);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	nxpwifi_stop_net_dev_queue(priv->netdev, adapter);
+	netif_carrier_off(priv->netdev);
+
+	/* Clear any past association response stored for
+	 * application retrieval
+	 */
+	priv->assoc_rsp_size = 0;
+	ret = nxpwifi_associate(priv, bss_desc);
+
+	/* If auth type is auto and association fails using open mode,
+	 * try to connect using shared mode
+	 */
+	if (ret == WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG &&
+	    priv->sec_info.is_authtype_auto &&
+	    priv->sec_info.wep_enabled) {
+		priv->sec_info.authentication_mode =
+			NL80211_AUTHTYPE_SHARED_KEY;
+		ret = nxpwifi_associate(priv, bss_desc);
+	}
+
+done:
+	/* beacon_ie buffer was allocated in function
+	 * nxpwifi_fill_new_bss_desc(). Free it now.
+	 */
+	if (bss_desc)
+		kfree(bss_desc->beacon_buf);
+	kfree(bss_desc);
+
+	if (ret < 0)
+		priv->attempted_bss_desc = NULL;
+
+	return ret;
+}
+
+/* IOCTL request handler to set host sleep configuration.
+ *
+ * This function prepares the correct firmware command and
+ * issues it.
+ */
+int nxpwifi_set_hs_params(struct nxpwifi_private *priv, u16 action,
+			  int cmd_type, struct nxpwifi_ds_hs_cfg *hs_cfg)
+
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int status = 0;
+	u32 prev_cond = 0;
+
+	if (!hs_cfg)
+		return -ENOMEM;
+
+	switch (action) {
+	case HOST_ACT_GEN_SET:
+		if (adapter->pps_uapsd_mode) {
+			nxpwifi_dbg(adapter, INFO,
+				    "info: Host Sleep IOCTL\t"
+				    "is blocked in UAPSD/PPS mode\n");
+			status = -EPERM;
+			break;
+		}
+		if (hs_cfg->is_invoke_hostcmd) {
+			if (hs_cfg->conditions == HS_CFG_CANCEL) {
+				if (!test_bit(NXPWIFI_IS_HS_CONFIGURED,
+					      &adapter->work_flags))
+					/* Already cancelled */
+					break;
+				/* Save previous condition */
+				prev_cond = le32_to_cpu(adapter->hs_cfg
+							.conditions);
+				adapter->hs_cfg.conditions =
+						cpu_to_le32(hs_cfg->conditions);
+			} else if (hs_cfg->conditions) {
+				adapter->hs_cfg.conditions =
+						cpu_to_le32(hs_cfg->conditions);
+				adapter->hs_cfg.gpio = (u8)hs_cfg->gpio;
+				if (hs_cfg->gap)
+					adapter->hs_cfg.gap = (u8)hs_cfg->gap;
+			} else if (adapter->hs_cfg.conditions ==
+				   cpu_to_le32(HS_CFG_CANCEL)) {
+				/* Return failure if no parameters for HS
+				 * enable
+				 */
+				status = -EINVAL;
+				break;
+			}
+
+			status = nxpwifi_send_cmd(priv,
+						  HOST_CMD_802_11_HS_CFG_ENH,
+						  HOST_ACT_GEN_SET, 0,
+						  &adapter->hs_cfg,
+						  cmd_type == NXPWIFI_SYNC_CMD);
+
+			if (hs_cfg->conditions == HS_CFG_CANCEL)
+				/* Restore previous condition */
+				adapter->hs_cfg.conditions =
+						cpu_to_le32(prev_cond);
+		} else {
+			adapter->hs_cfg.conditions =
+						cpu_to_le32(hs_cfg->conditions);
+			adapter->hs_cfg.gpio = (u8)hs_cfg->gpio;
+			adapter->hs_cfg.gap = (u8)hs_cfg->gap;
+		}
+		break;
+	case HOST_ACT_GEN_GET:
+		hs_cfg->conditions = le32_to_cpu(adapter->hs_cfg.conditions);
+		hs_cfg->gpio = adapter->hs_cfg.gpio;
+		hs_cfg->gap = adapter->hs_cfg.gap;
+		break;
+	default:
+		status = -EINVAL;
+		break;
+	}
+
+	return status;
+}
+
+/* Sends IOCTL request to cancel the existing Host Sleep configuration.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int nxpwifi_cancel_hs(struct nxpwifi_private *priv, int cmd_type)
+{
+	struct nxpwifi_ds_hs_cfg hscfg;
+
+	hscfg.conditions = HS_CFG_CANCEL;
+	hscfg.is_invoke_hostcmd = true;
+
+	return nxpwifi_set_hs_params(priv, HOST_ACT_GEN_SET,
+				    cmd_type, &hscfg);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_cancel_hs);
+
+/* Sends IOCTL request to cancel the existing Host Sleep configuration.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+bool nxpwifi_enable_hs(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_ds_hs_cfg hscfg;
+	struct nxpwifi_private *priv;
+	int i;
+
+	if (disconnect_on_suspend) {
+		for (i = 0; i < adapter->priv_num; i++) {
+			priv = adapter->priv[i];
+			nxpwifi_deauthenticate(priv, NULL);
+		}
+	}
+
+	priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA);
+
+	if (priv && priv->sched_scanning) {
+#ifdef CONFIG_PM
+		if (priv->wdev.wiphy->wowlan_config &&
+		    !priv->wdev.wiphy->wowlan_config->nd_config) {
+#endif
+			nxpwifi_dbg(adapter, CMD, "aborting bgscan!\n");
+			nxpwifi_stop_bg_scan(priv);
+			cfg80211_sched_scan_stopped(priv->wdev.wiphy, 0);
+#ifdef CONFIG_PM
+		}
+#endif
+	}
+
+	if (adapter->hs_activated) {
+		nxpwifi_dbg(adapter, CMD,
+			    "cmd: HS Already activated\n");
+		return true;
+	}
+
+	adapter->hs_activate_wait_q_woken = false;
+
+	memset(&hscfg, 0, sizeof(hscfg));
+	hscfg.is_invoke_hostcmd = true;
+
+	set_bit(NXPWIFI_IS_HS_ENABLING, &adapter->work_flags);
+	nxpwifi_cancel_all_pending_cmd(adapter);
+
+	if (nxpwifi_set_hs_params(nxpwifi_get_priv(adapter,
+						   NXPWIFI_BSS_ROLE_STA),
+				  HOST_ACT_GEN_SET, NXPWIFI_SYNC_CMD,
+				  &hscfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "IOCTL request HS enable failed\n");
+		return false;
+	}
+
+	if (wait_event_interruptible_timeout(adapter->hs_activate_wait_q,
+					     adapter->hs_activate_wait_q_woken,
+					     (10 * HZ)) <= 0) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "hs_activate_wait_q terminated\n");
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_enable_hs);
+
+/* IOCTL request handler to get BSS information.
+ *
+ * This function collates the information from different driver structures
+ * to send to the user.
+ */
+int nxpwifi_get_bss_info(struct nxpwifi_private *priv,
+			 struct nxpwifi_bss_info *info)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bssdescriptor *bss_desc;
+
+	if (!info)
+		return -EINVAL;
+
+	bss_desc = &priv->curr_bss_params.bss_descriptor;
+
+	info->bss_mode = priv->bss_mode;
+
+	memcpy(&info->ssid, &bss_desc->ssid, sizeof(struct cfg80211_ssid));
+
+	memcpy(&info->bssid, &bss_desc->mac_address, ETH_ALEN);
+
+	info->bss_chan = bss_desc->channel;
+
+	memcpy(info->country_code, adapter->country_code,
+	       IEEE80211_COUNTRY_STRING_LEN);
+
+	info->media_connected = priv->media_connected;
+
+	info->max_power_level = priv->max_tx_power_level;
+	info->min_power_level = priv->min_tx_power_level;
+
+	info->bcn_nf_last = priv->bcn_nf_last;
+
+	if (priv->sec_info.wep_enabled)
+		info->wep_status = true;
+	else
+		info->wep_status = false;
+
+	info->is_hs_configured = test_bit(NXPWIFI_IS_HS_CONFIGURED,
+					  &adapter->work_flags);
+	info->is_deep_sleep = adapter->is_deep_sleep;
+
+	return 0;
+}
+
+/* The function disables auto deep sleep mode.
+ */
+int nxpwifi_disable_auto_ds(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ds_auto_ds auto_ds = {
+		.auto_ds = DEEP_SLEEP_OFF,
+	};
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_PS_MODE_ENH,
+				DIS_AUTO_PS, BITMAP_AUTO_DS, &auto_ds, true);
+}
+EXPORT_SYMBOL_GPL(nxpwifi_disable_auto_ds);
+
+/* Sends IOCTL request to get the data rate.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int nxpwifi_drv_get_data_rate(struct nxpwifi_private *priv, u32 *rate)
+{
+	int ret;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_TX_RATE_QUERY,
+			       HOST_ACT_GEN_GET, 0, NULL, true);
+
+	if (!ret) {
+		if (priv->is_data_rate_auto)
+			*rate = nxpwifi_index_to_data_rate(priv, priv->tx_rate,
+							   priv->tx_htinfo);
+		else
+			*rate = priv->data_rate;
+	}
+
+	return ret;
+}
+
+/* IOCTL request handler to set tx power configuration.
+ *
+ * This function prepares the correct firmware command and
+ * issues it.
+ *
+ * For non-auto power mode, all the following power groups are set -
+ *      - Modulation class HR/DSSS
+ *      - Modulation class OFDM
+ *      - Modulation class HTBW20
+ *      - Modulation class HTBW40
+ */
+int nxpwifi_set_tx_power(struct nxpwifi_private *priv,
+			 struct nxpwifi_power_cfg *power_cfg)
+{
+	int ret;
+	struct host_cmd_ds_txpwr_cfg *txp_cfg;
+	struct nxpwifi_types_power_group *pg_tlv;
+	struct nxpwifi_power_group *pg;
+	u8 *buf;
+	u16 dbm = 0;
+
+	if (!power_cfg->is_power_auto) {
+		dbm = (u16)power_cfg->power_level;
+		if (dbm < priv->min_tx_power_level ||
+		    dbm > priv->max_tx_power_level) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "txpower value %d dBm\t"
+				    "is out of range (%d dBm-%d dBm)\n",
+				    dbm, priv->min_tx_power_level,
+				    priv->max_tx_power_level);
+			return -EINVAL;
+		}
+	}
+	buf = kzalloc(NXPWIFI_SIZE_OF_CMD_BUFFER, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	txp_cfg = (struct host_cmd_ds_txpwr_cfg *)buf;
+	txp_cfg->action = cpu_to_le16(HOST_ACT_GEN_SET);
+	if (!power_cfg->is_power_auto) {
+		u16 dbm_min = power_cfg->is_power_fixed ?
+			      dbm : priv->min_tx_power_level;
+
+		txp_cfg->mode = cpu_to_le32(1);
+		pg_tlv = (struct nxpwifi_types_power_group *)
+			 (buf + sizeof(struct host_cmd_ds_txpwr_cfg));
+		pg_tlv->type = cpu_to_le16(TLV_TYPE_POWER_GROUP);
+		pg_tlv->length =
+			cpu_to_le16(4 * sizeof(struct nxpwifi_power_group));
+		pg = (struct nxpwifi_power_group *)
+		     (buf + sizeof(struct host_cmd_ds_txpwr_cfg)
+		      + sizeof(struct nxpwifi_types_power_group));
+		/* Power group for modulation class HR/DSSS */
+		pg->first_rate_code = 0x00;
+		pg->last_rate_code = 0x03;
+		pg->modulation_class = MOD_CLASS_HR_DSSS;
+		pg->power_step = 0;
+		pg->power_min = (s8)dbm_min;
+		pg->power_max = (s8)dbm;
+		pg++;
+		/* Power group for modulation class OFDM */
+		pg->first_rate_code = 0x00;
+		pg->last_rate_code = 0x07;
+		pg->modulation_class = MOD_CLASS_OFDM;
+		pg->power_step = 0;
+		pg->power_min = (s8)dbm_min;
+		pg->power_max = (s8)dbm;
+		pg++;
+		/* Power group for modulation class HTBW20 */
+		pg->first_rate_code = 0x00;
+		pg->last_rate_code = 0x20;
+		pg->modulation_class = MOD_CLASS_HT;
+		pg->power_step = 0;
+		pg->power_min = (s8)dbm_min;
+		pg->power_max = (s8)dbm;
+		pg->ht_bandwidth = HT_BW_20;
+		pg++;
+		/* Power group for modulation class HTBW40 */
+		pg->first_rate_code = 0x00;
+		pg->last_rate_code = 0x20;
+		pg->modulation_class = MOD_CLASS_HT;
+		pg->power_step = 0;
+		pg->power_min = (s8)dbm_min;
+		pg->power_max = (s8)dbm;
+		pg->ht_bandwidth = HT_BW_40;
+	}
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_TXPWR_CFG,
+			       HOST_ACT_GEN_SET, 0, buf, true);
+
+	kfree(buf);
+	return ret;
+}
+
+/* IOCTL request handler to get power save mode.
+ *
+ * This function prepares the correct firmware command and
+ * issues it.
+ */
+int nxpwifi_drv_set_power(struct nxpwifi_private *priv, u32 *ps_mode)
+{
+	int ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 sub_cmd;
+
+	if (*ps_mode)
+		adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_PSP;
+	else
+		adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_CAM;
+	sub_cmd = (*ps_mode) ? EN_AUTO_PS : DIS_AUTO_PS;
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_PS_MODE_ENH,
+			       sub_cmd, BITMAP_STA_PS, NULL, true);
+	if (!ret && sub_cmd == DIS_AUTO_PS)
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_PS_MODE_ENH,
+				       GET_PS, 0, NULL, false);
+
+	return ret;
+}
+
+/* IOCTL request handler to set/reset WPA IE.
+ *
+ * The supplied WPA IE is treated as a opaque buffer. Only the first field
+ * is checked to determine WPA version. If buffer length is zero, the existing
+ * WPA IE is reset.
+ */
+static int nxpwifi_set_wpa_ie(struct nxpwifi_private *priv,
+			      u8 *ie_data_ptr, u16 ie_len)
+{
+	if (ie_len) {
+		if (ie_len > sizeof(priv->wpa_ie)) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to copy WPA IE, too big\n");
+			return -EINVAL;
+		}
+		memcpy(priv->wpa_ie, ie_data_ptr, ie_len);
+		priv->wpa_ie_len = ie_len;
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: Set Wpa_ie_len=%d IE=%#x\n",
+			    priv->wpa_ie_len, priv->wpa_ie[0]);
+
+		if (priv->wpa_ie[0] == WLAN_EID_VENDOR_SPECIFIC) {
+			priv->sec_info.wpa_enabled = true;
+		} else if (priv->wpa_ie[0] == WLAN_EID_RSN) {
+			priv->sec_info.wpa2_enabled = true;
+		} else {
+			priv->sec_info.wpa_enabled = false;
+			priv->sec_info.wpa2_enabled = false;
+		}
+	} else {
+		memset(priv->wpa_ie, 0, sizeof(priv->wpa_ie));
+		priv->wpa_ie_len = 0;
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: reset wpa_ie_len=%d IE=%#x\n",
+			    priv->wpa_ie_len, priv->wpa_ie[0]);
+		priv->sec_info.wpa_enabled = false;
+		priv->sec_info.wpa2_enabled = false;
+	}
+
+	return 0;
+}
+
+/* IOCTL request handler to set/reset WPS IE.
+ *
+ * The supplied WPS IE is treated as a opaque buffer. Only the first field
+ * is checked to internally enable WPS. If buffer length is zero, the existing
+ * WPS IE is reset.
+ */
+static int nxpwifi_set_wps_ie(struct nxpwifi_private *priv,
+			      u8 *ie_data_ptr, u16 ie_len)
+{
+	if (ie_len) {
+		if (ie_len > NXPWIFI_MAX_VSIE_LEN) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "info: failed to copy WPS IE, too big\n");
+			return -EINVAL;
+		}
+
+		priv->wps_ie = kzalloc(NXPWIFI_MAX_VSIE_LEN, GFP_KERNEL);
+		if (!priv->wps_ie)
+			return -ENOMEM;
+
+		memcpy(priv->wps_ie, ie_data_ptr, ie_len);
+		priv->wps_ie_len = ie_len;
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: Set wps_ie_len=%d IE=%#x\n",
+			    priv->wps_ie_len, priv->wps_ie[0]);
+	} else {
+		kfree(priv->wps_ie);
+		priv->wps_ie_len = ie_len;
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: Reset wps_ie_len=%d\n", priv->wps_ie_len);
+	}
+	return 0;
+}
+
+/* IOCTL request handler to set WEP network key.
+ *
+ * This function prepares the correct firmware command and
+ * issues it, after validation checks.
+ */
+static int
+nxpwifi_sec_ioctl_set_wep_key(struct nxpwifi_private *priv,
+			      struct nxpwifi_ds_encrypt_key *encrypt_key)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct nxpwifi_wep_key *wep_key;
+	int index;
+
+	if (priv->wep_key_curr_index >= NUM_WEP_KEYS)
+		priv->wep_key_curr_index = 0;
+	wep_key = &priv->wep_key[priv->wep_key_curr_index];
+	index = encrypt_key->key_index;
+	if (encrypt_key->key_disable) {
+		priv->sec_info.wep_enabled = 0;
+	} else if (!encrypt_key->key_len) {
+		/* Copy the required key as the current key */
+		wep_key = &priv->wep_key[index];
+		if (!wep_key->key_length) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "key not set, so cannot enable it\n");
+			return -EINVAL;
+		}
+
+		memcpy(encrypt_key->key_material,
+		       wep_key->key_material, wep_key->key_length);
+		encrypt_key->key_len = wep_key->key_length;
+
+		priv->wep_key_curr_index = (u16)index;
+		priv->sec_info.wep_enabled = 1;
+	} else {
+		wep_key = &priv->wep_key[index];
+		memset(wep_key, 0, sizeof(struct nxpwifi_wep_key));
+		/* Copy the key in the driver */
+		memcpy(wep_key->key_material,
+		       encrypt_key->key_material,
+		       encrypt_key->key_len);
+		wep_key->key_index = index;
+		wep_key->key_length = encrypt_key->key_len;
+		priv->sec_info.wep_enabled = 1;
+	}
+	if (wep_key->key_length) {
+		void *enc_key;
+
+		if (encrypt_key->key_disable) {
+			memset(&priv->wep_key[index], 0,
+			       sizeof(struct nxpwifi_wep_key));
+			goto done;
+		}
+
+		enc_key = encrypt_key;
+
+		/* Send request to firmware */
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_KEY_MATERIAL,
+				       HOST_ACT_GEN_SET, 0, enc_key, false);
+		if (ret)
+			return ret;
+	}
+
+done:
+	if (priv->sec_info.wep_enabled)
+		priv->curr_pkt_filter |= HOST_ACT_MAC_WEP_ENABLE;
+	else
+		priv->curr_pkt_filter &= ~HOST_ACT_MAC_WEP_ENABLE;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MAC_CONTROL,
+			       HOST_ACT_GEN_SET, 0,
+			       &priv->curr_pkt_filter, true);
+
+	return ret;
+}
+
+/* IOCTL request handler to set WPA key.
+ *
+ * This function prepares the correct firmware command and
+ * issues it, after validation checks.
+ *
+ * Current driver only supports key length of up to 32 bytes.
+ *
+ * This function can also be used to disable a currently set key.
+ */
+static int
+nxpwifi_sec_ioctl_set_wpa_key(struct nxpwifi_private *priv,
+			      struct nxpwifi_ds_encrypt_key *encrypt_key)
+{
+	int ret;
+	u8 remove_key = false;
+
+	/* Current driver only supports key length of up to 32 bytes */
+	if (encrypt_key->key_len > WLAN_MAX_KEY_LEN) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "key length too long\n");
+		return -EINVAL;
+	}
+
+	if (!encrypt_key->key_index)
+		encrypt_key->key_index = NXPWIFI_KEY_INDEX_UNICAST;
+
+	if (remove_key)
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_KEY_MATERIAL,
+				       HOST_ACT_GEN_SET,
+				       !KEY_INFO_ENABLED, encrypt_key, true);
+	else
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_KEY_MATERIAL,
+				       HOST_ACT_GEN_SET,
+				       KEY_INFO_ENABLED, encrypt_key, true);
+
+	return ret;
+}
+
+/* IOCTL request handler to set/get network keys.
+ *
+ * This is a generic key handling function which supports WEP and WPA.
+ */
+static int
+nxpwifi_sec_ioctl_encrypt_key(struct nxpwifi_private *priv,
+			      struct nxpwifi_ds_encrypt_key *encrypt_key)
+{
+	int status;
+
+	if (encrypt_key->key_len > WLAN_KEY_LEN_WEP104)
+		status = nxpwifi_sec_ioctl_set_wpa_key(priv, encrypt_key);
+	else
+		status = nxpwifi_sec_ioctl_set_wep_key(priv, encrypt_key);
+
+	return status;
+}
+
+/* This function returns the driver version.
+ */
+int
+nxpwifi_drv_get_driver_version(struct nxpwifi_adapter *adapter, char *version,
+			       int max_len)
+{
+	union {
+		__le32 l;
+		u8 c[4];
+	} ver;
+	char fw_ver[32];
+
+	ver.l = cpu_to_le32(adapter->fw_release_number);
+	sprintf(fw_ver, "%u.%u.%u.p%u.%u", ver.c[2], ver.c[1],
+		ver.c[0], ver.c[3], adapter->fw_hotfix_ver);
+
+	snprintf(version, max_len, driver_version, fw_ver);
+
+	nxpwifi_dbg(adapter, MSG, "info: NXPWIFI VERSION: %s\n", version);
+
+	return 0;
+}
+
+/* Sends IOCTL request to set encoding parameters.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int nxpwifi_set_encode(struct nxpwifi_private *priv, struct key_params *kp,
+		       const u8 *key, int key_len, u8 key_index,
+		       const u8 *mac_addr, int disable)
+{
+	struct nxpwifi_ds_encrypt_key encrypt_key;
+
+	memset(&encrypt_key, 0, sizeof(encrypt_key));
+	encrypt_key.key_len = key_len;
+	encrypt_key.key_index = key_index;
+
+	if (kp && kp->cipher == WLAN_CIPHER_SUITE_AES_CMAC)
+		encrypt_key.is_igtk_key = true;
+
+	if (!disable) {
+		if (key_len)
+			memcpy(encrypt_key.key_material, key, key_len);
+		else
+			encrypt_key.is_current_wep_key = true;
+
+		if (mac_addr)
+			memcpy(encrypt_key.mac_addr, mac_addr, ETH_ALEN);
+		if (kp && kp->seq && kp->seq_len) {
+			memcpy(encrypt_key.pn, kp->seq, kp->seq_len);
+			encrypt_key.pn_len = kp->seq_len;
+			encrypt_key.is_rx_seq_valid = true;
+		}
+	} else {
+		encrypt_key.key_disable = true;
+		if (mac_addr)
+			memcpy(encrypt_key.mac_addr, mac_addr, ETH_ALEN);
+	}
+
+	return nxpwifi_sec_ioctl_encrypt_key(priv, &encrypt_key);
+}
+
+/* Sends IOCTL request to get extended version.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int
+nxpwifi_get_ver_ext(struct nxpwifi_private *priv, u32 version_str_sel)
+{
+	struct nxpwifi_ver_ext ver_ext;
+
+	memset(&ver_ext, 0, sizeof(ver_ext));
+	ver_ext.version_str_sel = version_str_sel;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_VERSION_EXT,
+				HOST_ACT_GEN_GET, 0, &ver_ext, true);
+}
+
+int
+nxpwifi_remain_on_chan_cfg(struct nxpwifi_private *priv, u16 action,
+			   struct ieee80211_channel *chan,
+			   unsigned int duration)
+{
+	struct host_cmd_ds_remain_on_chan roc_cfg;
+	u8 sc;
+	int ret;
+
+	memset(&roc_cfg, 0, sizeof(roc_cfg));
+	roc_cfg.action = cpu_to_le16(action);
+	if (action == HOST_ACT_GEN_SET) {
+		roc_cfg.band_cfg = chan->band;
+		sc = nxpwifi_chan_type_to_sec_chan_offset(NL80211_CHAN_NO_HT);
+		roc_cfg.band_cfg |= (sc << 2);
+
+		roc_cfg.channel =
+			ieee80211_frequency_to_channel(chan->center_freq);
+		roc_cfg.duration = cpu_to_le32(duration);
+	}
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_REMAIN_ON_CHAN,
+			       action, 0, &roc_cfg, true);
+	if (ret) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "failed to remain on channel\n");
+		return ret;
+	}
+
+	return roc_cfg.status;
+}
+
+/* Sends IOCTL request to get statistics information.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int
+nxpwifi_get_stats_info(struct nxpwifi_private *priv,
+		       struct nxpwifi_ds_get_stats *log)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_GET_LOG,
+				HOST_ACT_GEN_GET, 0, log, true);
+}
+
+/* IOCTL request handler to read/write register.
+ *
+ * This function prepares the correct firmware command and
+ * issues it.
+ *
+ * Access to the following registers are supported -
+ *      - MAC
+ *      - BBP
+ *      - RF
+ *      - PMIC
+ *      - CAU
+ */
+static int nxpwifi_reg_mem_ioctl_reg_rw(struct nxpwifi_private *priv,
+					struct nxpwifi_ds_reg_rw *reg_rw,
+					u16 action)
+{
+	u16 cmd_no;
+
+	switch (reg_rw->type) {
+	case NXPWIFI_REG_MAC:
+		cmd_no = HOST_CMD_MAC_REG_ACCESS;
+		break;
+	case NXPWIFI_REG_BBP:
+		cmd_no = HOST_CMD_BBP_REG_ACCESS;
+		break;
+	case NXPWIFI_REG_RF:
+		cmd_no = HOST_CMD_RF_REG_ACCESS;
+		break;
+	case NXPWIFI_REG_PMIC:
+		cmd_no = HOST_CMD_PMIC_REG_ACCESS;
+		break;
+	case NXPWIFI_REG_CAU:
+		cmd_no = HOST_CMD_CAU_REG_ACCESS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return nxpwifi_send_cmd(priv, cmd_no, action, 0, reg_rw, true);
+}
+
+/* Sends IOCTL request to write to a register.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int
+nxpwifi_reg_write(struct nxpwifi_private *priv, u32 reg_type,
+		  u32 reg_offset, u32 reg_value)
+{
+	struct nxpwifi_ds_reg_rw reg_rw;
+
+	reg_rw.type = reg_type;
+	reg_rw.offset = reg_offset;
+	reg_rw.value = reg_value;
+
+	return nxpwifi_reg_mem_ioctl_reg_rw(priv, &reg_rw, HOST_ACT_GEN_SET);
+}
+
+/* Sends IOCTL request to read from a register.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int
+nxpwifi_reg_read(struct nxpwifi_private *priv, u32 reg_type,
+		 u32 reg_offset, u32 *value)
+{
+	int ret;
+	struct nxpwifi_ds_reg_rw reg_rw;
+
+	reg_rw.type = reg_type;
+	reg_rw.offset = reg_offset;
+	ret = nxpwifi_reg_mem_ioctl_reg_rw(priv, &reg_rw, HOST_ACT_GEN_GET);
+
+	if (!ret)
+		*value = reg_rw.value;
+
+	return ret;
+}
+
+/* Sends IOCTL request to read from EEPROM.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int
+nxpwifi_eeprom_read(struct nxpwifi_private *priv, u16 offset, u16 bytes,
+		    u8 *value)
+{
+	int ret;
+	struct nxpwifi_ds_read_eeprom rd_eeprom;
+
+	rd_eeprom.offset =  offset;
+	rd_eeprom.byte_count = bytes;
+
+	/* Send request to firmware */
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_EEPROM_ACCESS,
+			       HOST_ACT_GEN_GET, 0, &rd_eeprom, true);
+
+	if (!ret)
+		memcpy(value, rd_eeprom.value,
+		       min((u16)MAX_EEPROM_DATA, rd_eeprom.byte_count));
+	return ret;
+}
+
+/* This function sets a generic IE. In addition to generic IE, it can
+ * also handle WPA and WPA2 IEs.
+ */
+static int
+nxpwifi_set_gen_ie_helper(struct nxpwifi_private *priv, u8 *ie_data_ptr,
+			  u16 ie_len)
+{
+	struct ieee80211_vendor_ie *pvendor_ie;
+	static const u8 wpa_oui[] = { 0x00, 0x50, 0xf2, 0x01 };
+	static const u8 wps_oui[] = { 0x00, 0x50, 0xf2, 0x04 };
+	u16 unparsed_len = ie_len, cur_ie_len;
+
+	/* If the passed length is zero, reset the buffer */
+	if (!ie_len) {
+		priv->gen_ie_buf_len = 0;
+		priv->wps.session_enable = false;
+		return 0;
+	} else if (!ie_data_ptr ||
+		   ie_len <= sizeof(struct element)) {
+		return -EINVAL;
+	}
+	pvendor_ie = (struct ieee80211_vendor_ie *)ie_data_ptr;
+
+	while (pvendor_ie) {
+		cur_ie_len = pvendor_ie->len + sizeof(struct element);
+
+		if (pvendor_ie->element_id == WLAN_EID_RSN) {
+			/* IE is a WPA/WPA2 IE so call set_wpa function */
+			nxpwifi_set_wpa_ie(priv, (u8 *)pvendor_ie, cur_ie_len);
+			priv->wps.session_enable = false;
+			goto next_ie;
+		}
+
+		if (pvendor_ie->element_id == WLAN_EID_VENDOR_SPECIFIC) {
+			/* Test to see if it is a WPA IE, if not, then
+			 * it is a gen IE
+			 */
+			if (!memcmp(&pvendor_ie->oui, wpa_oui,
+				    sizeof(wpa_oui))) {
+				/* IE is a WPA/WPA2 IE so call set_wpa function
+				 */
+				nxpwifi_set_wpa_ie(priv, (u8 *)pvendor_ie,
+						   cur_ie_len);
+				priv->wps.session_enable = false;
+				goto next_ie;
+			}
+
+			if (!memcmp(&pvendor_ie->oui, wps_oui,
+				    sizeof(wps_oui))) {
+				/* Test to see if it is a WPS IE,
+				 * if so, enable wps session flag
+				 */
+				priv->wps.session_enable = true;
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "WPS Session Enabled.\n");
+				nxpwifi_set_wps_ie(priv, (u8 *)pvendor_ie,
+						   cur_ie_len);
+				goto next_ie;
+			}
+		}
+
+		/* Verify that the passed length is not larger than the
+		 * available space remaining in the buffer
+		 */
+		if (cur_ie_len <
+		    (sizeof(priv->gen_ie_buf) - priv->gen_ie_buf_len)) {
+			/* Append the passed data to the end
+			 * of the genIeBuffer
+			 */
+			memcpy(priv->gen_ie_buf + priv->gen_ie_buf_len,
+			       (u8 *)pvendor_ie, cur_ie_len);
+			/* Increment the stored buffer length by the
+			 * size passed
+			 */
+			priv->gen_ie_buf_len += cur_ie_len;
+		}
+
+next_ie:
+		unparsed_len -= cur_ie_len;
+
+		if (unparsed_len <= sizeof(struct element))
+			pvendor_ie = NULL;
+		else
+			pvendor_ie = (struct ieee80211_vendor_ie *)
+				(((u8 *)pvendor_ie) + cur_ie_len);
+	}
+
+	return 0;
+}
+
+/* IOCTL request handler to set/get generic IE.
+ *
+ * In addition to various generic IEs, this function can also be
+ * used to set the ARP filter.
+ */
+static int nxpwifi_misc_ioctl_gen_ie(struct nxpwifi_private *priv,
+				     struct nxpwifi_ds_misc_gen_ie *gen_ie,
+				     u16 action)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	switch (gen_ie->type) {
+	case NXPWIFI_IE_TYPE_GEN_IE:
+		if (action == HOST_ACT_GEN_GET) {
+			gen_ie->len = priv->wpa_ie_len;
+			memcpy(gen_ie->ie_data, priv->wpa_ie, gen_ie->len);
+		} else {
+			nxpwifi_set_gen_ie_helper(priv, gen_ie->ie_data,
+						  (u16)gen_ie->len);
+		}
+		break;
+	case NXPWIFI_IE_TYPE_ARP_FILTER:
+		memset(adapter->arp_filter, 0, sizeof(adapter->arp_filter));
+		if (gen_ie->len > ARP_FILTER_MAX_BUF_SIZE) {
+			adapter->arp_filter_size = 0;
+			nxpwifi_dbg(adapter, ERROR,
+				    "invalid ARP filter size\n");
+			return -EINVAL;
+		}
+		memcpy(adapter->arp_filter, gen_ie->ie_data, gen_ie->len);
+		adapter->arp_filter_size = gen_ie->len;
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR, "invalid IE type\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* Sends IOCTL request to set a generic IE.
+ *
+ * This function allocates the IOCTL request buffer, fills it
+ * with requisite parameters and calls the IOCTL handler.
+ */
+int
+nxpwifi_set_gen_ie(struct nxpwifi_private *priv, const u8 *ie, int ie_len)
+{
+	struct nxpwifi_ds_misc_gen_ie gen_ie;
+
+	if (ie_len > IEEE_MAX_IE_SIZE)
+		return -EFAULT;
+
+	gen_ie.type = NXPWIFI_IE_TYPE_GEN_IE;
+	gen_ie.len = ie_len;
+	memcpy(gen_ie.ie_data, ie, ie_len);
+
+	return nxpwifi_misc_ioctl_gen_ie(priv, &gen_ie, HOST_ACT_GEN_SET);
+}
+
+/* This function get Host Sleep wake up reason.
+ */
+int nxpwifi_get_wakeup_reason(struct nxpwifi_private *priv, u16 action,
+			      int cmd_type,
+			      struct nxpwifi_ds_wakeup_reason *wakeup_reason)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_HS_WAKEUP_REASON,
+				HOST_ACT_GEN_GET, 0, wakeup_reason,
+				cmd_type == NXPWIFI_SYNC_CMD);
+}
+
+int nxpwifi_get_chan_info(struct nxpwifi_private *priv,
+			  struct nxpwifi_channel_band *channel_band)
+{
+	return nxpwifi_send_cmd(priv, HOST_CMD_STA_CONFIGURE,
+				HOST_ACT_GEN_GET, 0, channel_band,
+				NXPWIFI_SYNC_CMD);
+}
-- 
2.34.1


