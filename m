Return-Path: <linux-wireless+bounces-9375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E51911D70
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0F51F21315
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28A16F27E;
	Fri, 21 Jun 2024 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vbzp8wIl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2068.outbound.protection.outlook.com [40.107.8.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601016F269;
	Fri, 21 Jun 2024 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956398; cv=fail; b=EcCzHvw/5mZmHInszWJNX2mjj30whl0otn7rULP5SJ3twtI7iWIhR9ak3LK8N3BMaU0RgyV3CFfHnkU6DZOPwyfCEo9GTc01cVRrFzTAnYKC5TVnazWiLLF9d8hjwSbDtJgGTF2zTl7YVh1p7W2w13frqu4AaIoeRVpOC4ePlWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956398; c=relaxed/simple;
	bh=uEpY8cDKF0IEOBKttlAGcwDVWN/AfVZM4YwiyAE3Se8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R8nsNnwjxvGP+D+FU7qU6T6TCKc8EtebB7wMeDhJDflWwCdqDjVK5iDFASZce7xJ/UivJzRXmvw+guJpFPsTg7+GWHo8mB45FrJl/5E3wJGARhzhUuv027fQcvILcz9HGNk3qdmOjI+qLbZYkHIRJeY7kli+Kr2+5Cue5ZCzHdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vbzp8wIl; arc=fail smtp.client-ip=40.107.8.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdu8PME5SNxNfVJk9X6a/aWXd5KxTVnTjY1GXTUt5yCVBL9TZ6PnLRwbb9FLa5hBWwNoe+tL85EfztoIOgKtUcrhk/SbryDv9nlKlELYtdNvWgOo15S9fRj5munVtbmF+vg8SJ5W2szpGTUJtKvxi/4mgt24G30zQDX422+kfOcAg5M8JUWnM42VhYdePAfFnPcusQ/P9UHkuVOqv4N+wNiHQ8aEGUggsv5L5N9sDuuIgqasBSNPmDyw8Tv8nK9m+hvUl8FrczUQ93w+cl3di2m4JfFPp3bYJGeNXhmPMA+9LA4SeQ/0DTJsI/nbldb1h1STTHdWT7S2gQQogAfX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GU6nIhsdc9DdTeK08hBh9rOdAUEaagjd8/3z87/I9w=;
 b=WFvbsMTIOIwayEIIjZRwQqKOVFPlJ2VcF6VHi8euFX6QqmHqNzRmY9mkjW0pMmyWmgsu54lP4kgTGP/CIeknvNvxatSzmARaPC3PkB2Dptx9Qm2vNDQ3FW/DdHu7YRZE0tnds27b15VmUcc0yzRvMae59GbkNJoZBJrnFxZWVgd4g7JJf/DmsKl567o7/ZJaraE2Fl/i7aS+PXXn6XDXVk0IBH125f7embJ0zzhMrNdmWZ4HYVLcsOAEb1epicJzlZQOhxGPMVxa+ygGkRxrcw6+JGRUn81Lfv7flERdkO9qGP9cTTmLQn74HfaNm5/suOxcYY6TqL56wKlF97E9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GU6nIhsdc9DdTeK08hBh9rOdAUEaagjd8/3z87/I9w=;
 b=Vbzp8wIlR+HFZlsjecYBGRBQAEgG/tTJelazmfw/m+LYZjcrBTXYEppEpamtZtztCOQuJ5EOCgGBfPrlLtMzeEwWF3WKhQX9Py0BkW9y5/cpyI/Hp/jHYgr4QPhxGjwjva/9U41DHLayVMyJpIDhwAo8s4Mplf9gisP0symr694=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:53:14 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:14 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 12/43] wifi: nxpwifi: add cfp.c
Date: Fri, 21 Jun 2024 15:51:37 +0800
Message-Id: <20240621075208.513497-13-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a6f778-bd9c-4d42-52ef-08dc91c73415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a5tl6gOEhIK38lxLQ2WltU0qnCOlZsTQZ8bXL8yCyfMk3Y4+ZAPFMcag5o0n?=
 =?us-ascii?Q?/Owm4LezNOzDgYvBcHlZFA1ya7NQowrNQKykcejkRa4EB9zS0v0SznGwzHLR?=
 =?us-ascii?Q?LuKrA8bSMVYcF1WR/JJO3rLOyQSXvqUI/Gu7Bo0Hpnmskv6PWiDZI/n/w9se?=
 =?us-ascii?Q?H7tJOyQrsVieg7zZ1/0THpypIN/MKMZ9slmFpdYa6utpLAAq1fsf1eMI2EMV?=
 =?us-ascii?Q?bNCfqReCqq6fV57FwdrY2po41QZRhsR3WT65JURJP7tctAHl2vwX9JYBOlul?=
 =?us-ascii?Q?iqWGnUYjxaTk7qXfSc5p2YjR7TWeFmRoReUPDeJ4eZ51bnmHtO16VMkb6I5e?=
 =?us-ascii?Q?942TCfRa5vw2Go57HjRiVSqsqQCZiL9AVc7amFEhiA68LxL0xWU5NlpunHWA?=
 =?us-ascii?Q?/qbNA6qHd68pCv5b9F6mBpXSKwTOkAQwWIPTGr1eIEm3R3vBHXSw2j4xybS7?=
 =?us-ascii?Q?kUa0qe+w8gtZcEVFOMUy4KNcQtnCX3Rk8nyV3fJYr7XhoEaxEa+5T7UMMojM?=
 =?us-ascii?Q?8pz5iyf2uM4KjjWphHYrKG978AyErpkUDB6pUoDXIIQyvYJldaKFAX7f/Vmn?=
 =?us-ascii?Q?P0Dhg09uGAncADtf5O92APx2GoHtjOdczMpGGrqrHtIH8lQYVH+jeBJQTEa9?=
 =?us-ascii?Q?7a44ZbEafFYj1kWzqUn10nr4+O+I2Bvduh07v5fFi6+vdzAd5KooNFHt1+CC?=
 =?us-ascii?Q?2QTVhAk3YsZ3ahDB4UGHrmW5YBgntbIJ4SOwbtoFk4Kp/Mb2Vl8oIoayR0Mw?=
 =?us-ascii?Q?QrsZhJiA8/5VY4ZmhzSOK6Wu68xOI0ZZlEHgNa+zhKpbeCDH5eXQy++LPBrL?=
 =?us-ascii?Q?0M67+L878a1KIF/o2kifLxVn/sIjHRdFOxtjw+MMoBEvPhe9uQPxcI2D7DNZ?=
 =?us-ascii?Q?AtlvZMyxqJt973fIwxd8oOxbwIjCSaVGUDZ5P58h6pXD0y+4P08Yk34K4Dbv?=
 =?us-ascii?Q?iyYOjW/2UlNS112tLjMotVDqzcukuN4sL+khNU1f7h3ZlvemWxK1URnKgUPT?=
 =?us-ascii?Q?qgC3JGSqg1Hj5txJuAZMOnD3XjJj7NEGkXXy74Z9u7Qo0lsrcftZN+w0gbcL?=
 =?us-ascii?Q?uYZDF1UDJZ2xAhYVWjXBZUIjyYEUqX7EHiiNcNsTb/6WVXtIND7Bjqcdfazq?=
 =?us-ascii?Q?H2gMPqGZds0g3ctMOCVJRCx2NmfO0LcSeXxAAn3nvi+JbmKwKeQ/kk0er0Da?=
 =?us-ascii?Q?QSLYCeF0YpHRYJ5eRSztmNh7gmMQZmPnN+n26d3iRJH076uRu489YQBBCvpL?=
 =?us-ascii?Q?jNru0ycg15xtUAry5PKB2+xggt+DMRJwtcE8Y0OzmDib5ywJgRpdv2Q8zdJm?=
 =?us-ascii?Q?ad1CpD3DbExiM3ulcfYAUWix1t7WVQ/ns7AFQdcQbCHOtXC6M1CzuQBTxfqz?=
 =?us-ascii?Q?U9eKS2c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YHekFwP7ddtvymjXoikNox4DU91Dl0C3WJP0TLlCUCtZ0giF05HYWdcuf0La?=
 =?us-ascii?Q?rMHB63EeJmafdc8blW3c1HnCZ1lFHTnl/6Zyr1Bw1tzQjhkS8bH3v4FOmDsX?=
 =?us-ascii?Q?FMACeZplLFrBjVg39PYDWeRa1rvwK0wobwPONS3decIutSLUFDJlK/SzFAP5?=
 =?us-ascii?Q?8yMkKqdx7R7vxOvV+2d++Pu9sk/FLAipp6j5Xlo5QSIFs2oZggjjXwNDfK2s?=
 =?us-ascii?Q?5z9GIzgYm11HD29qMNmEVRprXse9PUdug5qAFXSnDICfIt2e64qBIPFPhqn9?=
 =?us-ascii?Q?xNDCueste/Of7OrBDXEtbYyCMCDffdIfoZGj6dYXYpsM1HL8BC8A5tdvhS5l?=
 =?us-ascii?Q?Tgz7ta57JMJ8MHwdvfVfzk7eEf3VjClPaXGJAlcsw+HeRPxaVg1V/EYqRpwm?=
 =?us-ascii?Q?O/wlkSoO84wc75/SqyPqRBiP0hI39ZK5HlxNVxZKX4bnfSCwwUEPcNBZvfnC?=
 =?us-ascii?Q?X94NNoXbiQkfPuq7IIQYTZp+BOZkVBzYQHBAeHGI7uJDJU8pPRUzekQxr5CO?=
 =?us-ascii?Q?ZMhAfrfmwy1pFHHIBCmkBfczIS/IBZrjK3T6NssyaCPIldH6Z4A/nWQuAS7v?=
 =?us-ascii?Q?w7w2SBPn4W8X8V0/WrsnMAQAJBFCx0gDrjUz92szXPdkhDDF04SjaDNcqiO8?=
 =?us-ascii?Q?XiUvs6M5Zm526f2J/8n5fUYpjqsN+wlbaGKAv9O/6x/fDjpaZdnQUQAyKjGD?=
 =?us-ascii?Q?v5PTlxDHVUBq/Wyqhi+5hl+2H48cXBh13/1qwm24D+9oT6mqYo3DReUmjRlI?=
 =?us-ascii?Q?Y2yng+PO/m5gUOUyi3sVdDSDvhpKXhHRF4uubvd30BmX86xTIQXCr+yYoUif?=
 =?us-ascii?Q?mmgD78OCLjpimDkq0ucYlJ0UDLJEZWWIJvQdTIUXg5pWK0GiHM9dCSff6rg+?=
 =?us-ascii?Q?9n+93hzWpgrci2EdMBFUE/jD77VE21+AiBy5TE0K7gEccTH9UUEpp1P76/Qg?=
 =?us-ascii?Q?gIvZKJIviSQ5/79IHEl+eHWzBZQ3QkVluGcDzsRye3TclM4mi8NVvhHHYU9x?=
 =?us-ascii?Q?LdecYwpPbd/DVfiq+E/uWy6+6txuvrHd+yyi2xj227KbD1WuAGKqF70m6PSj?=
 =?us-ascii?Q?9A5VxkUL+jJAbNx+3XgDjqYzdCuUdaP4t2z3rQyVTXsRIAmMfgSqlXWHNjQn?=
 =?us-ascii?Q?MuIEbrKNPrE7pVvkJw6j5X26drnH8RPOc5f+ItmmWOPJFBHKqtK2S9dadm9r?=
 =?us-ascii?Q?uwZ8LGTDufZNzGS40qaZXzJzP4/nJLreQzOfTgisigZRHJpGIaMDWcPMAHo3?=
 =?us-ascii?Q?Rx/VwLjwC1Dii7QJYvCv20xHJOJmVyKP5t0i/GDjIRdtCWEm1QjZR6JMR+Ri?=
 =?us-ascii?Q?NrPr3on8B5/nB7f3a9fgBnnj6Mv1fHm1ot8uNJBNpcY6Wyqevd4hfo+pZbBV?=
 =?us-ascii?Q?3Itaw/eSNcOsyiUDrzuR4kLIQvsoMXjbLYxaswvKObzzLC6WgsMMdRQGyS7K?=
 =?us-ascii?Q?2Dxmh+wP8Os/Y6aDZbEQM2tgpEdzidxOFRzsl1rqgzNPMHe1eff9WFMH+Ufx?=
 =?us-ascii?Q?D5056ItQyLWNCob1ljrhnSkBq/VsXsuADZfFhvoGwamXRr7GKHiasztvmmnR?=
 =?us-ascii?Q?xoGEA8CE+RDC1HGWY3JiExMkWn6KNtSiXlE0ca4K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a6f778-bd9c-4d42-52ef-08dc91c73415
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:14.1645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/GV2acD0GSxaEbWg4GSpSSneltpMc4DvTiByJ+K/EjN6lbGPsKmApYAX4QUX5SConOa8mga++Wv7c4V13+WiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfp.c | 484 +++++++++++++++++++++++++
 1 file changed, 484 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfp.c b/drivers/net/wireless/nxp/nxpwifi/cfp.c
new file mode 100644
index 000000000000..4fcd2add9b66
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfp.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: Channel, Frequency and Power
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
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
+static u8 supported_rates_n[N_SUPPORTED_RATES] = { 0x02, 0x04, 0 };
+
+/* For every mcs_rate line, the first 8 bytes are for stream 1x1,
+ * and all 16 bytes are for stream 2x2.
+ */
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
+/* This function converts integer code to region string */
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
+/* This function maps an index in supported rates table into
+ * the corresponding data rate.
+ */
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
+/* This function maps an index in supported rates table into
+ * the corresponding data rate.
+ */
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
+/* This function returns the current active data rates.
+ *
+ * The result may vary depending upon connection status.
+ */
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
+/* This function locates the Channel-Frequency-Power triplet based upon
+ * band and channel/frequency parameters.
+ */
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
+			/* find by valid channel*/
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
+/* This function checks if the data rate is set to auto.
+ */
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
+/* This function gets the supported data rates from bitmask inside
+ * cfg80211_scan_request.
+ */
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
+/* This function gets the supported data rates. The function works in
+ * both Ad-Hoc and infra mode by printing the band and returning the
+ * data rates.
+ */
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	u32 k = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		switch (adapter->config_bands) {
+		case BAND_B:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_b\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_b,
+					       sizeof(supported_rates_b));
+			break;
+		case BAND_G:
+		case BAND_G | BAND_GN:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_g\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_g,
+					       sizeof(supported_rates_g));
+			break;
+		case BAND_B | BAND_G:
+		case BAND_A | BAND_B | BAND_G:
+		case BAND_A | BAND_B:
+		case BAND_A | BAND_B | BAND_G | BAND_GN | BAND_AN:
+		case BAND_A | BAND_B | BAND_G | BAND_GN | BAND_AN | BAND_AAC:
+		case BAND_B | BAND_G | BAND_GN:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_bg\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_bg,
+					       sizeof(supported_rates_bg));
+			break;
+		case BAND_A:
+		case BAND_A | BAND_G:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+			break;
+		case BAND_AN:
+		case BAND_A | BAND_AN:
+		case BAND_A | BAND_AN | BAND_AAC:
+		case BAND_A | BAND_G | BAND_AN | BAND_GN:
+		case BAND_A | BAND_G | BAND_AN | BAND_GN | BAND_AAC:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+			break;
+		case BAND_GN:
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_n\n",
+				    adapter->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_n,
+					       sizeof(supported_rates_n));
+			break;
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


