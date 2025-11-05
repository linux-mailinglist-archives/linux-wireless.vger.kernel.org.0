Return-Path: <linux-wireless+bounces-28591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60178C35431
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39165624447
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4124030C617;
	Wed,  5 Nov 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZvhBIwPr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01D30E0F7;
	Wed,  5 Nov 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339800; cv=fail; b=sNikhJ+03igN8cnhhb80j/n85UTc12LaxRa1ESI+qWUA/nZ360HxIMMKB8HRvpbILPAji28xjVizz2mY4Vqb4J1VbVXgCN97ItP75ebZlBy/cegQ/QeWFZ82EDvMm5ocV8aYeI/HT/eHVutCf4y4uCqgDJLfw1Zr1oz0DcGGM7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339800; c=relaxed/simple;
	bh=4oco+9hJOb0eXWJxQ9fn+mdn5Q9OLOIgdaI/cVAk9Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRFfH6KiZN8MC2m+OnSnZZnDqBi5GFETwYwy3M4PLV0qokS2Uz9phz8JvSGeH3dPxaLAJRJfHWIAiFRvQ/JUM7yAY1evMNZh9DopUnJ/vl1W8tgxRfYW8hlaLyYPhqS4fFRgPfonAhRdWFOYj2+1GvCpK3rZ2/8jUUfMiDwT92A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZvhBIwPr; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1UoaPsWAlYP5SC4FmUGHjMPLMnCqhNykXfrPSEc1XK/NANIkVGesRZ+ZOPIEuSq748GIsD28IP3GCkH4bE/6xS7dXQXZDnLM+Ncy91P0EXWkFipAv4sWlgyHYUd7Iprl20wcmDLL2lqznc25aS3SecFaDxfJTfqkT6Z5047NhwW67/7uc9A8nXZsupZhe+pfGK81rOgK4g5E/HrdkepTSJb9mRvv37E1o2uwl9j6CxkS1ojw0yhfJrnzT2xWaGVlpX0KUnkiOpgbeD5B/UtRqlstZPuub+ww7Gv4k9l4cmuIc2OGChwER0RxC1dYkHfTWkDVW3WXP8VCn5esKJu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzeNsvO01GJbO6yeDFMvxvvutfrLpMlnr+d3sV+O7go=;
 b=tfqKkloM6oZkGnT/ZCahbuRGYkMPGa+jtJBBKNKt0CIOr5I+yBTVDfXlf0TWgA+lb3K6TCi8C1JHenKsaGdgMQheIp5avgS+EZtU6L/GMbvuPjq2T2BfZyvh1b4Dbh+0EQTgarYzKaDU/YlD2Y+j1sVqu+nqsSs2nbxBRHSm9PGY8NZdrvH3YQHkmxwaaZ24C/o5zAJXBgUHx++12aU2ErydCduTfNXyEGdtvI9qK6M/rVnmkWvsKgsH6YJK8mbwPPhc9CAOSphogWO004ediaWUayey1j+ufJ2epMsAAOGyw38rt9t2DE+VJuggcA38NRsmRPNqkWcB2pMuQMsOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzeNsvO01GJbO6yeDFMvxvvutfrLpMlnr+d3sV+O7go=;
 b=ZvhBIwPr3KHFTEBI13npqmystuTNn7vBhGUOnrr5rUCr1+onc+s9oGwjY2KiN2UBDLdvUABBWGlwa8TS74+YJ1sAWw2STTMESK5/DMizFTU09uCVmShfyqGxfQ2w48rfJ6xQvBUobxGIjVRgsNcqN5vIC/12j/BLp7VBzzzy6U3fyiTwtLCkbwx/FAGhhALTVb6k1OekiS2KAokBWGM/ieHuxD8zG9ejdoyEjmnet6qlhzuwHgbAl9WB5TOvd4cxwRPdt15lruQHFUETKbzjUESR2hiYyRfFdvo8Qt2psDg4mWxm7/28jWyciDhzsaL1xYYB/oE2zYcIRPp3NMtE/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 10:49:39 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:39 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 13/22] wifi: nxpwifi: add data path support for STA and AP modes
Date: Wed,  5 Nov 2025 18:47:35 +0800
Message-Id: <20251105104744.2401992-14-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 03323cbd-41f0-45fc-089c-08de1c59050d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCqhZCZVTjYC8g5FCXysfQ9ptQY0HF+kBuaZ0USRDHvqgkhny46mvkulvrEl?=
 =?us-ascii?Q?AbJPY7Zv+iYx35HkVPrUmjDj0cU9N5+sjp4AS9ctPy32vDxhAHlSTEATl+WR?=
 =?us-ascii?Q?rTyG4mRANk2uhQry/Yvfg9WdPbb+PIKmXbgHv/JelhNof0Q5cPoM1ebaHSS2?=
 =?us-ascii?Q?+MVFdoyLyX6Mgv+z7yXbnUZvPwi5lLhyL1KP7ntQn6RbE/w5zb4XDjQ+onz9?=
 =?us-ascii?Q?o7YH73wa8gDw0Q2NZt0kGb9WkKd/pUfI5RX0PEuUrGzg8T6FxzzfXY5hzfhq?=
 =?us-ascii?Q?umtpUE/N81HuCHhGN78rgVQbsrtWSRX3OaN0QAC0V3h1askGrTleGmEZ/qSt?=
 =?us-ascii?Q?RcgKpD4AuGNjfDPu/UA3QblIdDiKaW8EIgH3C/tJa4AW7L1PWODpYKZdMN3L?=
 =?us-ascii?Q?J02hg7+zwI4IFHCk2vJc5ZYgZapI4vS3rY03fDrtcy3eK/YIhjm0vRru3sP+?=
 =?us-ascii?Q?cYXpk9v08QC33lqviCehjpXyIZ4t241cGktMbHql2BP9vpCuJ8ZFLvIjYB5q?=
 =?us-ascii?Q?O+ga3mVw/ycdes71ONr4wBsDqWlkrBh9cL3SvjIgA0i+UQV23JxTGjhY+0Hp?=
 =?us-ascii?Q?WWqnNcLekPqMkJE5/wxHRo2j45pHcjKgYa4sqCuTlGmF0xefBdCOJruwf7uo?=
 =?us-ascii?Q?FOX0dCyBQkT+X8Q6F5SN3hGgX4lJ/a9naAphssABBIkU3qtA6Lz32I0B30qy?=
 =?us-ascii?Q?6OZ7u1mlEE86jV182GxlsA7xZNVSTxAD4WyKJNi1jvHpXkpNAuSvuKxAfqrs?=
 =?us-ascii?Q?u6H14tshrRBJMxhMFRDR0JNdAVqG/GLJIDi0EbbJF/9nXKDW3+F4K4DfRPf7?=
 =?us-ascii?Q?Vc2FJUoCr37ZZvTrpW1fXWFjqVfbA+x8Ph8tQS8SUBySys2ucWitEZCKyhOI?=
 =?us-ascii?Q?X0Q9uaIKKhHiDljeYft1yUdFjv0rT4tWEXjfJVT9D0FFbnFzi+p9iRkVHcHE?=
 =?us-ascii?Q?BPBpywIuJX7C2mMnSyhk2Hg315dLxUxxP+qQma4724kNb7uEgmYsm6wWFFDn?=
 =?us-ascii?Q?jHDPxXYITpqt8BjmfVoE1Sq1SsMuDHECVYkR+fjbZe5VnhszPK+YoI5sF9HH?=
 =?us-ascii?Q?fFOfmyhKXDdMSj7ttM6OcXIzhmqpu/Oi0gbXLpVncx4rMR/NVp4I+bsdS2gl?=
 =?us-ascii?Q?pTTuoYCvwNadWqQLm6xX/NowjaFtDbcecAwyZn6P/Piwl2no/pnvfDSZfKtw?=
 =?us-ascii?Q?HS6jlVNpNMqHBeEYPv/Pv7Xz9yA9YpfJeFsD0SMvAD0mg6qjRR6VMi8AP+qu?=
 =?us-ascii?Q?Vc0g6dEKns+HGrLUqrwfv6cFb8PHySkqtpWoz551SibZi08TyGhr9/lsPGLf?=
 =?us-ascii?Q?03FAKv4ssDHflfYtcOfnUF+IcY+WXY4j7ToVNXaIeSoWUvOFd/oRN4HufXUv?=
 =?us-ascii?Q?2QW/Nxiq0fSB+9S9h+VLAmImntJ4s+Fa2tOwmP8PQjnDzAzlaVs0mVn5ZMw7?=
 =?us-ascii?Q?azzeSUCZztkW6Uynl9mTy8bkuBILtlv8Y1IyYIedWIo/Vvyq/wdw0jdyFoLk?=
 =?us-ascii?Q?vN0fo1zl1BGlZAzKxqmsiSJXvVudl1N1MxdP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xHo8SpqdRhzgGQ7sHX5wRa76mQ9SsxQrHmzBMDYmJgYjnd5qrQjLhaAFYfKU?=
 =?us-ascii?Q?OMfr+9J/Skt87vcv10r3IvrUKNi4goAkFipgvs2LZUoZkhqcRtV8Wvq1sp2d?=
 =?us-ascii?Q?cYG0pvL2XQQ3BPTjrBv0pa27IqwAO/oNyiHit19XJH5OZ/jiAhho6GRMtW0h?=
 =?us-ascii?Q?83+YrzBKI4k+YeJfYqPzDSUeWv9cvDVu7dNljYAR36qlc3q386ysvYOUc1oZ?=
 =?us-ascii?Q?tdAWXGRFVq0Zxe1Si+ki3mL50k0E3eAsPshqFsUWuSiv1ZOIh5TqDQWNJ3/X?=
 =?us-ascii?Q?rSDbcQosZiJfkrbc68Iy22nXnHUc8Wge5lZKOZ2MUlN01f2J2WannqbNG9hP?=
 =?us-ascii?Q?zxPCVFtiDPvBK8MN8SBzcpgobz/Y6iq4sIAM0DhMfjQqEmLcQj2WspX1hSd3?=
 =?us-ascii?Q?rQUcMk/3AXW/nxeBGhkKwcrPh6xh3W6KBdzKIgj53cttxaG3GW5xChWFyMtE?=
 =?us-ascii?Q?zG3DTEwZs/QqgwxLoOKjYXBE0QJOiGt9kWeyxNi+QxirUrA/Wct6hz49kJfw?=
 =?us-ascii?Q?b6ozjVtNanaZD5L7UcNrHL8PTlszrhIa35+4dF2grOc9NnU2Yf/h5GDFmMzn?=
 =?us-ascii?Q?WkPlbbyrvoctU5OSN6H4XfRY0DOO0IA8t1P8eG5H7+pIE6ItBSlNae+3UtHn?=
 =?us-ascii?Q?B1/Yv3h02vI6fJTd+O4jx31c4osTOMqulkMN5fWFHRu2uLmDYN2VP0QAIdJT?=
 =?us-ascii?Q?eNZ5496l/VaboBQzrG0jYl+aYZgvmQyiYqvyTWgZuQ5OlIisSVn0kr9nyTg4?=
 =?us-ascii?Q?uBQpJ+hx4QNune99XTjsU+5TJvaoaQa+c6dlxjuWYxpvZjpFKTorb0TDVbLM?=
 =?us-ascii?Q?A+O6nKATjWeKOzz1XFKHjjoYXxUYLRt1sJieQvQ01AeY9jSBa5k2g80JNo6x?=
 =?us-ascii?Q?/9BtjByNfBVgURYVJegt8qnNQcW//75He9NswAN4OQsEjLvcnKkigj3mOylA?=
 =?us-ascii?Q?PU/uKpUNWFjlcrS+ct+L4xoPdnKC9L893ptCaU/Znh9zGu4du3675PtrUQkU?=
 =?us-ascii?Q?LzaMRJ0WDTSREpGSNp841WkhqV03TZdnOKUBeuo3hFtWqQpnK6HQu5w1znj5?=
 =?us-ascii?Q?6uKVw466kfasFA0t1thBOwox3C9TgMqJg1AfFG1w2Wm3GGkbE2DV9bU9sLw6?=
 =?us-ascii?Q?YQzrdwSzu2VBdqTLbRuOa1gfQUrPylPJuW+q2+HnFUxt623E4Ruk7U8kD/EF?=
 =?us-ascii?Q?VQZD6tMVjDro+GVt+2swfPihHU/YalPh3KiNdagkfIwl9zIo+y6LVPW605ye?=
 =?us-ascii?Q?CrarcP5BHrjpCNFgDQuwz66qzBbJgxPo+Y3oUrQVulXhnEqP0ItEyYCb4whr?=
 =?us-ascii?Q?ps50X0dUj9VW+lWheJ/4J6vflSRrIIqXqyjdZZzZl0+5fvSKjIagJbSXrw0e?=
 =?us-ascii?Q?XPcLnYc1yqIRRnygMVaLzCkS2vvdbjSHq0vrJSAZIZZSW6RNsHa22yhgUMtv?=
 =?us-ascii?Q?d+5JkXl2hsu/SPxXCAYBixHoC3Iqqng5042pKKQcpTR+4dDTB7SSslOIxuvj?=
 =?us-ascii?Q?uxMsk0McH3sJ++JLjBqx+m4vZwRgglVkoP/NGww8+YNqbV9VZSgdNOS4b+P+?=
 =?us-ascii?Q?89BG6OWkGXmO6zPWeGgTbQNpcAug92EBGDDuWTyY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03323cbd-41f0-45fc-089c-08de1c59050d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:39.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X11FDiQOet4J40m/uWrOTYEAT2a2x0G5VKs9txJQf191zlvX4dYVh0x4SB8MKpVIW0Y56f7cgZTLFeRnd0fUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10770

This patch introduces the data path implementation for the nxpwifi driver,
covering both transmit (Tx) and receive (Rx) handling in station (STA) and
access point (AP) modes.

Key components added:
- sta_rx.c: RX packet processing for STA mode
- sta_tx.c: TX packet preparation and NULL frame handling for STA mode
- uap_txrx.c: TX/RX logic for AP mode, including bridging and forwarding
- txrx.c: Common TX/RX logic shared across roles

Features include:
- Ethernet frame reconstruction from 802.11 headers
- TxPD/RxPD handling and alignment
- WMM priority and packet delay calculation
- 11n RX reordering support
- Bridged packet queuing and forwarding in AP mode
- TX status reporting and completion callbacks

This is a foundational step toward enabling full data path support for
nxpwifi in both client and AP roles.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c   | 250 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c   | 208 ++++++++
 drivers/net/wireless/nxp/nxpwifi/txrx.c     | 358 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c | 506 ++++++++++++++++++++
 4 files changed, 1322 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_rx.c b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
new file mode 100644
index 000000000000..32252021d948
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <uapi/linux/ipv6.h>
+#include <net/ndisc.h>
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/* This function checks if a frame is IPv4 ARP or IPv6 Neighbour advertisement
+ * frame. If frame has both source and destination mac address as same, this
+ * function drops such gratuitous frames.
+ */
+static bool
+nxpwifi_discard_gratuitous_arp(struct nxpwifi_private *priv,
+			       struct sk_buff *skb)
+{
+	const struct nxpwifi_arp_eth_header *arp;
+	struct ethhdr *eth;
+	struct ipv6hdr *ipv6;
+	struct icmp6hdr *icmpv6;
+
+	eth = (struct ethhdr *)skb->data;
+	switch (ntohs(eth->h_proto)) {
+	case ETH_P_ARP:
+		arp = (void *)(skb->data + sizeof(struct ethhdr));
+		if (arp->hdr.ar_op == htons(ARPOP_REPLY) ||
+		    arp->hdr.ar_op == htons(ARPOP_REQUEST)) {
+			if (!memcmp(arp->ar_sip, arp->ar_tip, 4))
+				return true;
+		}
+		break;
+	case ETH_P_IPV6:
+		ipv6 = (void *)(skb->data + sizeof(struct ethhdr));
+		icmpv6 = (void *)(skb->data + sizeof(struct ethhdr) +
+				  sizeof(struct ipv6hdr));
+		if (icmpv6->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
+			if (!memcmp(&ipv6->saddr, &ipv6->daddr,
+				    sizeof(struct in6_addr)))
+				return true;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/* This function processes the received packet and forwards it
+ * to kernel/upper layer.
+ *
+ * This function parses through the received packet and determines
+ * if it is a debug packet or normal packet.
+ *
+ * For non-debug packets, the function chops off unnecessary leading
+ * header bytes, reconstructs the packet as an ethernet frame or
+ * 802.2/llc/snap frame as required, and sends it to kernel/upper layer.
+ *
+ * The completion callback is called after processing in complete.
+ */
+int nxpwifi_process_rx_packet(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	int ret;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct rxpd *local_rx_pd;
+	int hdr_chop;
+	struct ethhdr *eth;
+	u16 rx_pkt_off;
+	u8 adj_rx_rate = 0;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+
+	rx_pkt_off = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
+
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX)))) {
+		/*  Replace the 803 header and rfc1042 header (llc/snap) with an
+		 *    EthernetII header, keep the src/dst and snap_type
+		 *    (ethertype).
+		 *  The firmware only passes up SNAP frames converting
+		 *    all RX Data from 802.11 to 802.2/LLC/SNAP frames.
+		 *  To create the Ethernet II, just move the src, dst address
+		 *    right before the snap_type.
+		 */
+		eth = (struct ethhdr *)
+			((u8 *)&rx_pkt_hdr->eth803_hdr
+			 + sizeof(rx_pkt_hdr->eth803_hdr) +
+			 sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+
+		memcpy(eth->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(eth->h_source));
+		memcpy(eth->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(eth->h_dest));
+
+		/* Chop off the rxpd + the excess memory from the 802.2/llc/snap
+		 * header that was removed.
+		 */
+		hdr_chop = (u8 *)eth - (u8 *)local_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)local_rx_pd;
+	}
+
+	/* Chop off the leading header bytes so the it points to the start of
+	 * either the reconstructed EthII frame or the 802.2/llc/snap frame
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (priv->hs2_enabled &&
+	    nxpwifi_discard_gratuitous_arp(priv, skb)) {
+		nxpwifi_dbg(priv->adapter, INFO, "Bypassed Gratuitous ARP\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	/* Only stash RX bitrate for unicast packets. */
+	if (likely(!is_multicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest))) {
+		priv->rxpd_rate = local_rx_pd->rx_rate;
+		priv->rxpd_htinfo = local_rx_pd->ht_info;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA ||
+	    GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		adj_rx_rate = nxpwifi_adjust_data_rate(priv,
+						       local_rx_pd->rx_rate,
+						       local_rx_pd->ht_info);
+		nxpwifi_hist_data_add(priv, adj_rx_rate, local_rx_pd->snr,
+				      local_rx_pd->nf);
+	}
+
+	ret = nxpwifi_recv_packet(priv, skb);
+	if (ret)
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "recv packet failed\n");
+
+	return ret;
+}
+
+/* This function processes the received buffer.
+ *
+ * The function looks into the RxPD and performs sanity tests on the
+ * received buffer to ensure its a valid packet, before processing it
+ * further. If the packet is determined to be aggregated, it is
+ * de-aggregated accordingly. Non-unicast packets are sent directly to
+ * the kernel/upper layers. Unicast packets are handed over to the
+ * Rx reordering routine if 11n is enabled.
+ *
+ * The completion callback is called after processing in complete.
+ */
+int nxpwifi_process_sta_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret = 0;
+	struct rxpd *local_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ta[ETH_ALEN];
+	u16 rx_pkt_type, rx_pkt_offset, rx_pkt_length, seq_num;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(local_rx_pd->rx_pkt_type);
+	rx_pkt_offset = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_length = le16_to_cpu(local_rx_pd->rx_pkt_length);
+	seq_num = le16_to_cpu(local_rx_pd->seq_num);
+
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
+
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
+			    skb->len, rx_pkt_offset, rx_pkt_length);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (priv->adapter->enable_net_mon && rx_pkt_type == PKT_TYPE_802DOT11) {
+		ret = nxpwifi_recv_packet_to_monif(priv, skb);
+		if (ret)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret && (ret != -EINPROGRESS))
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		if (ret != -EINPROGRESS)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	/* If the packet is not an unicast packet then send the packet
+	 * directly to os. Don't pass thru rx reordering
+	 */
+	if (!IS_11N_ENABLED(priv) ||
+	    !ether_addr_equal_unaligned(priv->curr_addr,
+					rx_pkt_hdr->eth803_hdr.h_dest)) {
+		nxpwifi_process_rx_packet(priv, skb);
+		return ret;
+	}
+
+	if (nxpwifi_queuing_ra_based(priv)) {
+		memcpy(ta, rx_pkt_hdr->eth803_hdr.h_source, ETH_ALEN);
+	} else {
+		if (rx_pkt_type != PKT_TYPE_BAR &&
+		    local_rx_pd->priority < MAX_NUM_TID)
+			priv->rx_seq[local_rx_pd->priority] = seq_num;
+		memcpy(ta, priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+	}
+
+	/* Reorder and send to OS */
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, seq_num, local_rx_pd->priority,
+					 ta, (u8)rx_pkt_type, skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_tx.c b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
new file mode 100644
index 000000000000..6611db254931
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_tx.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station TX data handling
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
+
+/* This function fills the TxPD for tx packets.
+ *
+ * The Tx buffer received by this function should already have the
+ * header space allocated for TxPD.
+ *
+ * This function inserts the TxPD in between interface header and actual
+ * data and adjusts the buffer pointers accordingly.
+ *
+ * The following TxPD fields are set by this function, as required -
+ *      - BSS number
+ *      - Tx packet length and offset
+ *      - Priority
+ *      - Packet delay
+ *      - Priority specific Tx control
+ *      - Flags
+ */
+void nxpwifi_process_sta_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	unsigned int pad;
+	u16 pkt_type, pkt_length, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+	u32 tx_control;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*local_tx_pd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+	skb_push(skb, sizeof(*local_tx_pd) + pad);
+
+	local_tx_pd = (struct txpd *)skb->data;
+	memset(local_tx_pd, 0, sizeof(struct txpd));
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+
+	pkt_length = (u16)(skb->len - (sizeof(struct txpd) + pad));
+	if (pkt_type == PKT_TYPE_MGMT)
+		pkt_length -= NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	local_tx_pd->tx_pkt_length = cpu_to_le16(pkt_length);
+
+	local_tx_pd->priority = (u8)skb->priority;
+	local_tx_pd->pkt_delay_2ms =
+				nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		local_tx_pd->tx_token_id = tx_info->ack_frame_id;
+		local_tx_pd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (local_tx_pd->priority <
+	    ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl)) {
+		/* Set the priority specific tx_control field, setting of 0 will
+		 *   cause the default value to be used later in this function
+		 */
+		tx_control =
+			priv->wmm.user_pri_pkt_tx_ctrl[local_tx_pd->priority];
+		local_tx_pd->tx_control = cpu_to_le32(tx_control);
+	}
+
+	if (adapter->pps_uapsd_mode) {
+		if (nxpwifi_check_last_packet_indication(priv)) {
+			adapter->tx_lock_flag = true;
+			local_tx_pd->flags =
+				NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET;
+		}
+	}
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(struct txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		local_tx_pd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!local_tx_pd->tx_control)
+		/* TxCtrl set by user or default */
+		local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
+
+/* This function tells firmware to send a NULL data packet.
+ *
+ * The function creates a NULL data packet with TxPD and sends to the
+ * firmware for transmission, with highest priority setting.
+ */
+int nxpwifi_send_null_packet(struct nxpwifi_private *priv, u8 flags)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd;
+	struct nxpwifi_tx_param tx_param;
+/* sizeof(struct txpd) + Interface specific header */
+#define NULL_PACKET_HDR 64
+	u32 data_len = NULL_PACKET_HDR;
+	struct sk_buff *skb;
+	int ret;
+	struct nxpwifi_txinfo *tx_info = NULL;
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags))
+		return -EPERM;
+
+	if (!priv->media_connected)
+		return -EPERM;
+
+	if (adapter->data_sent)
+		return -EBUSY;
+
+	skb = dev_alloc_skb(data_len);
+	if (!skb)
+		return -ENOMEM;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->pkt_len = data_len -
+			(sizeof(struct txpd) + adapter->intf_hdr_len);
+	skb_reserve(skb, sizeof(struct txpd) + adapter->intf_hdr_len);
+	skb_push(skb, sizeof(struct txpd));
+
+	local_tx_pd = (struct txpd *)skb->data;
+	local_tx_pd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+	local_tx_pd->flags = flags;
+	local_tx_pd->priority = WMM_HIGHEST_PRIORITY;
+	local_tx_pd->tx_pkt_offset = cpu_to_le16(sizeof(struct txpd));
+	local_tx_pd->bss_num = priv->bss_num;
+	local_tx_pd->bss_type = priv->bss_type;
+
+	skb_push(skb, adapter->intf_hdr_len);
+	tx_param.next_pkt_len = 0;
+	ret = adapter->if_ops.host_to_card(adapter, NXPWIFI_TYPE_DATA,
+					   skb, &tx_param);
+
+	switch (ret) {
+	case -EBUSY:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: host_to_card failed: ret=%d\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		break;
+	case 0:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, DATA,
+			    "data: %s: host_to_card succeeded\n",
+			    __func__);
+		adapter->tx_lock_flag = true;
+		break;
+	case -EINPROGRESS:
+		adapter->tx_lock_flag = true;
+		break;
+	default:
+		dev_kfree_skb_any(skb);
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: host_to_card failed: ret=%d\n",
+			    __func__, ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		break;
+	}
+
+	return ret;
+}
+
+/* This function checks if we need to send last packet indication.
+ */
+u8
+nxpwifi_check_last_packet_indication(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 ret = false;
+
+	if (!adapter->sleep_period.period)
+		return ret;
+	if (nxpwifi_wmm_lists_empty(adapter))
+		ret = true;
+
+	if (ret && !adapter->cmd_sent && !adapter->curr_cmd &&
+	    !is_command_pending(adapter)) {
+		adapter->delay_null_pkt = false;
+		ret = true;
+	} else {
+		ret = false;
+		adapter->delay_null_pkt = true;
+	}
+	return ret;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/txrx.c b/drivers/net/wireless/nxp/nxpwifi/txrx.c
new file mode 100644
index 000000000000..e6e0bcb14e91
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/txrx.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: generic TX/RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "wmm.h"
+
+/* This function processes the received buffer.
+ *
+ * Main responsibility of this function is to parse the RxPD to
+ * identify the correct interface this packet is headed for and
+ * forwarding it to the associated handling function, where the
+ * packet will be further processed and sent to kernel/upper layer
+ * if required.
+ */
+int nxpwifi_handle_rx_packet(struct nxpwifi_adapter *adapter,
+			     struct sk_buff *skb)
+{
+	struct nxpwifi_private *priv =
+		nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+	struct rxpd *local_rx_pd;
+	struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+	int ret;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	/* Get the BSS number from rxpd, get corresponding priv */
+	priv = nxpwifi_get_priv_by_id(adapter, local_rx_pd->bss_num &
+				      BSS_NUM_MASK, local_rx_pd->bss_type);
+	if (!priv)
+		priv = nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_ANY);
+
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop RX packet\n");
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	nxpwifi_dbg_dump(adapter, DAT_D, "rx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+	memset(rx_info, 0, sizeof(*rx_info));
+	rx_info->bss_num = priv->bss_num;
+	rx_info->bss_type = priv->bss_type;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP)
+		ret = nxpwifi_process_uap_rx_packet(priv, skb);
+	else
+		ret = nxpwifi_process_sta_rx_packet(priv, skb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_handle_rx_packet);
+
+/* This function sends a packet to device.
+ *
+ * It processes the packet to add the TxPD, checks condition and
+ * sends the processed packet to firmware for transmission.
+ *
+ * On successful completion, the function calls the completion callback
+ * and logs the time.
+ */
+int nxpwifi_process_tx(struct nxpwifi_private *priv, struct sk_buff *skb,
+		       struct nxpwifi_tx_param *tx_param)
+{
+	int hroom, ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct txpd *local_tx_pd = NULL;
+	struct nxpwifi_sta_node *dest_node;
+	struct ethhdr *hdr = (void *)skb->data;
+
+	if (unlikely(!skb->len ||
+		     skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hroom = adapter->intf_hdr_len;
+
+	if (priv->bss_role == NXPWIFI_BSS_ROLE_UAP) {
+		rcu_read_lock();
+		dest_node = nxpwifi_get_sta_entry(priv, hdr->h_dest);
+		if (dest_node) {
+			dest_node->stats.tx_bytes += skb->len;
+			dest_node->stats.tx_packets++;
+		}
+		rcu_read_unlock();
+		nxpwifi_process_uap_txpd(priv, skb);
+	} else {
+		nxpwifi_process_sta_txpd(priv, skb);
+	}
+
+	if ((adapter->data_sent || adapter->tx_lock_flag)) {
+		skb_queue_tail(&adapter->tx_data_q, skb);
+		atomic_inc(&adapter->tx_queued);
+		return 0;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(skb->data + hroom);
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+	nxpwifi_dbg_dump(adapter, DAT_D, "tx pkt:", skb->data,
+			 min_t(size_t, skb->len, DEBUG_DUMP_DATA_MAX_LEN));
+
+out:
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, DATA, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode && adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case -EINVAL:
+		nxpwifi_dbg(adapter, ERROR,
+			    "malformed skb (length: %u, headroom: %u)\n",
+			    skb->len, skb_headroom(skb));
+		fallthrough;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n",
+			    ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+
+	return ret;
+}
+
+static int nxpwifi_host_to_card(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb,
+				struct nxpwifi_tx_param *tx_param)
+{
+	struct txpd *local_tx_pd = NULL;
+	u8 *head_ptr = skb->data;
+	int ret = 0;
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: priv not found. Drop TX packet\n");
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+		return ret;
+	}
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+		local_tx_pd = (struct txpd *)(head_ptr + adapter->intf_hdr_len);
+
+	ret = adapter->if_ops.host_to_card(adapter,
+					   NXPWIFI_TYPE_DATA,
+					   skb, tx_param);
+
+	switch (ret) {
+	case -ENOSR:
+		nxpwifi_dbg(adapter, ERROR, "data: -ENOSR is returned\n");
+		break;
+	case -EBUSY:
+		if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA) &&
+		    adapter->pps_uapsd_mode &&
+		    adapter->tx_lock_flag) {
+			priv->adapter->tx_lock_flag = false;
+			if (local_tx_pd)
+				local_tx_pd->flags = 0;
+		}
+		skb_queue_head(&adapter->tx_data_q, skb);
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+			atomic_add(tx_info->aggr_num, &adapter->tx_queued);
+		else
+			atomic_inc(&adapter->tx_queued);
+		nxpwifi_dbg(adapter, ERROR, "data: -EBUSY is returned\n");
+		break;
+	case -EINPROGRESS:
+		break;
+	case 0:
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "nxpwifi_write_data_async failed: 0x%X\n", ret);
+		adapter->dbg.num_tx_host_to_card_failure++;
+		nxpwifi_write_data_complete(adapter, skb, 0, ret);
+		break;
+	}
+	return ret;
+}
+
+static int
+nxpwifi_dequeue_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	struct sk_buff *skb, *skb_next;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_tx_param tx_param;
+
+	skb = skb_dequeue(&adapter->tx_data_q);
+	if (!skb)
+		return -ENOMEM;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		atomic_sub(tx_info->aggr_num, &adapter->tx_queued);
+	else
+		atomic_dec(&adapter->tx_queued);
+
+	if (!skb_queue_empty(&adapter->tx_data_q))
+		skb_next = skb_peek(&adapter->tx_data_q);
+	else
+		skb_next = NULL;
+	tx_param.next_pkt_len = ((skb_next) ? skb_next->len : 0);
+	if (!tx_param.next_pkt_len) {
+		if (!nxpwifi_wmm_lists_empty(adapter))
+			tx_param.next_pkt_len = 1;
+	}
+	return nxpwifi_host_to_card(adapter, skb, &tx_param);
+}
+
+void
+nxpwifi_process_tx_queue(struct nxpwifi_adapter *adapter)
+{
+	do {
+		if (adapter->data_sent || adapter->tx_lock_flag)
+			break;
+		if (nxpwifi_dequeue_tx_queue(adapter))
+			break;
+	} while (!skb_queue_empty(&adapter->tx_data_q));
+}
+
+/* Packet send completion callback handler.
+ *
+ * It either frees the buffer directly or forwards it to another
+ * completion callback which checks conditions, updates statistics,
+ * wakes up stalled traffic queue if required, and then frees the buffer.
+ */
+int nxpwifi_write_data_complete(struct nxpwifi_adapter *adapter,
+				struct sk_buff *skb, int aggr, int status)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_txinfo *tx_info;
+	struct netdev_queue *txq;
+	int index;
+
+	if (!skb)
+		return 0;
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	priv = nxpwifi_get_priv_by_id(adapter, tx_info->bss_num,
+				      tx_info->bss_type);
+	if (!priv)
+		goto done;
+
+	nxpwifi_set_trans_start(priv->netdev);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT)
+		atomic_dec_return(&adapter->pending_bridged_pkts);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_AGGR_PKT)
+		goto done;
+
+	if (!status) {
+		priv->stats.tx_packets++;
+		priv->stats.tx_bytes += tx_info->pkt_len;
+		if (priv->tx_timeout_cnt)
+			priv->tx_timeout_cnt = 0;
+	} else {
+		priv->stats.tx_errors++;
+	}
+
+	if (aggr)
+		/* For skb_aggr, do not wake up tx queue */
+		goto done;
+
+	atomic_dec(&adapter->tx_pending);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	if (atomic_dec_return(&priv->wmm_tx_pending[index]) < LOW_TX_PENDING) {
+		txq = netdev_get_tx_queue(priv->netdev, index);
+		if (netif_tx_queue_stopped(txq)) {
+			netif_tx_wake_queue(txq);
+			nxpwifi_dbg(adapter, DATA, "wake queue: %d\n", index);
+		}
+	}
+done:
+	dev_kfree_skb_any(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_write_data_complete);
+
+void nxpwifi_parse_tx_status_event(struct nxpwifi_private *priv,
+				   void *event_body)
+{
+	struct tx_status_event *tx_status = (void *)priv->adapter->event_body;
+	struct sk_buff *ack_skb;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!tx_status->tx_token_id)
+		return;
+
+	spin_lock_bh(&priv->ack_status_lock);
+	ack_skb = idr_remove(&priv->ack_status_frames, tx_status->tx_token_id);
+	spin_unlock_bh(&priv->ack_status_lock);
+
+	if (ack_skb) {
+		tx_info = NXPWIFI_SKB_TXCB(ack_skb);
+
+		if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS) {
+			/* consumes ack_skb */
+			skb_complete_wifi_ack(ack_skb, !tx_status->status);
+		} else {
+			/* Remove broadcast address which was added by driver */
+			memmove(ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16),
+				ack_skb->data +
+				sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN, ack_skb->len -
+				(sizeof(struct ieee80211_hdr_3addr) +
+				NXPWIFI_MGMT_FRAME_HEADER_SIZE + sizeof(u16) +
+				ETH_ALEN));
+			ack_skb->len = ack_skb->len - ETH_ALEN;
+			/* Remove driver's proprietary header including 2 bytes
+			 * of packet length and pass actual management frame buffer
+			 * to cfg80211.
+			 */
+			cfg80211_mgmt_tx_status(&priv->wdev, tx_info->cookie,
+						ack_skb->data +
+						NXPWIFI_MGMT_FRAME_HEADER_SIZE +
+						sizeof(u16), ack_skb->len -
+						(NXPWIFI_MGMT_FRAME_HEADER_SIZE
+						 + sizeof(u16)),
+						!tx_status->status, GFP_ATOMIC);
+			dev_kfree_skb_any(ack_skb);
+		}
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
new file mode 100644
index 000000000000..abdb7305211d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: AP TX and RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "main.h"
+#include "wmm.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/* This function checks if particular RA list has packets more than low bridge
+ * packet threshold and then deletes packet from this RA list.
+ * Function deletes packets from such RA list and returns true. If no such list
+ * is found, false is returned.
+ */
+static bool
+nxpwifi_uap_del_tx_pkts_in_ralist(struct nxpwifi_private *priv,
+				  struct list_head *ra_list_head,
+				  int tid)
+{
+	struct nxpwifi_ra_list_tbl *ra_list;
+	struct sk_buff *skb, *tmp;
+	bool pkt_deleted = false;
+	struct nxpwifi_txinfo *tx_info;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	list_for_each_entry(ra_list, ra_list_head, list) {
+		if (skb_queue_empty(&ra_list->skb_head))
+			continue;
+
+		skb_queue_walk_safe(&ra_list->skb_head, skb, tmp) {
+			tx_info = NXPWIFI_SKB_TXCB(skb);
+			if (tx_info->flags & NXPWIFI_BUF_FLAG_BRIDGED_PKT) {
+				__skb_unlink(skb, &ra_list->skb_head);
+				nxpwifi_write_data_complete(adapter, skb, 0,
+							    -1);
+				if (ra_list->tx_paused)
+					priv->wmm.pkts_paused[tid]--;
+				else
+					atomic_dec(&priv->wmm.tx_pkts_queued);
+				pkt_deleted = true;
+			}
+			if ((atomic_read(&adapter->pending_bridged_pkts) <=
+					     NXPWIFI_BRIDGED_PKTS_THR_LOW))
+				break;
+		}
+	}
+
+	return pkt_deleted;
+}
+
+/* This function deletes packets from particular RA List. RA list index
+ * from which packets are deleted is preserved so that packets from next RA
+ * list are deleted upon subsequent call thus maintaining fairness.
+ */
+static void nxpwifi_uap_cleanup_tx_queues(struct nxpwifi_private *priv)
+{
+	struct list_head *ra_list;
+	int i;
+
+	spin_lock_bh(&priv->wmm.ra_list_spinlock);
+
+	for (i = 0; i < MAX_NUM_TID; i++, priv->del_list_idx++) {
+		if (priv->del_list_idx == MAX_NUM_TID)
+			priv->del_list_idx = 0;
+		ra_list = &priv->wmm.tid_tbl_ptr[priv->del_list_idx].ra_list;
+		if (nxpwifi_uap_del_tx_pkts_in_ralist(priv, ra_list, i)) {
+			priv->del_list_idx++;
+			break;
+		}
+	}
+
+	spin_unlock_bh(&priv->wmm.ra_list_spinlock);
+}
+
+static void
+nxpwifi_uap_queue_bridged_pkt(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct sk_buff *new_skb;
+	struct nxpwifi_txinfo *tx_info;
+	int hdr_chop;
+	struct ethhdr *p_ethhdr;
+	struct nxpwifi_sta_node *src_node;
+	int index;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					     NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Tx: Bridge packet limit reached. Drop packet!\n");
+		kfree_skb(skb);
+		nxpwifi_uap_cleanup_tx_queues(priv);
+		return;
+	}
+
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		     sizeof(bridge_tunnel_header))) ||
+	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		     sizeof(rfc1042_header)) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	     rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX))) {
+		/* Replace the 803 header and rfc1042 header (llc/snap) with
+		 * an Ethernet II header, keep the src/dst and snap_type
+		 * (ethertype).
+		 *
+		 * The firmware only passes up SNAP frames converting all RX
+		 * data from 802.11 to 802.2/LLC/SNAP frames.
+		 *
+		 * To create the Ethernet II, just move the src, dst address
+		 * right before the snap_type.
+		 */
+		p_ethhdr = (struct ethhdr *)
+			((u8 *)(&rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->eth803_hdr)
+			 + sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+		memcpy(p_ethhdr->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(p_ethhdr->h_source));
+		memcpy(p_ethhdr->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(p_ethhdr->h_dest));
+		/* Chop off the rxpd + the excess memory from
+		 * 802.2/llc/snap header that was removed.
+		 */
+		hdr_chop = (u8 *)p_ethhdr - (u8 *)uap_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)uap_rx_pd;
+	}
+
+	/* Chop off the leading header bytes so that it points
+	 * to the start of either the reconstructed EthII frame
+	 * or the 802.2/llc/snap frame.
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "data: Tx: insufficient skb headroom %d\n",
+			    skb_headroom(skb));
+		/* Insufficient skb headroom - allocate a new skb */
+		new_skb =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		if (unlikely(!new_skb)) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "Tx: cannot allocate new_skb\n");
+			kfree_skb(skb);
+			priv->stats.tx_dropped++;
+			return;
+		}
+
+		kfree_skb(skb);
+		skb = new_skb;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: new skb headroom %d\n",
+			    skb_headroom(skb));
+	}
+
+	tx_info = NXPWIFI_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+
+	rcu_read_lock();
+	src_node = nxpwifi_get_sta_entry(priv, rx_pkt_hdr->eth803_hdr.h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+		src_node->stats.last_tx_rate = uap_rx_pd->rx_rate;
+		src_node->stats.last_tx_htinfo = uap_rx_pd->ht_info;
+	}
+	rcu_read_unlock();
+
+	if (is_unicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest)) {
+		/* Update bridge packet statistics as the
+		 * packet is not going to kernel/upper layer.
+		 */
+		priv->stats.rx_bytes += skb->len;
+		priv->stats.rx_packets++;
+
+		/* Sending bridge packet to TX queue, so save the packet
+		 * length in TXCB to update statistics in TX complete.
+		 */
+		tx_info->pkt_len = skb->len;
+	}
+
+	__net_timestamp(skb);
+
+	index = nxpwifi_1d_to_wmm_queue[skb->priority];
+	atomic_inc(&priv->wmm_tx_pending[index]);
+	nxpwifi_wmm_add_buf_txqueue(priv, skb);
+	atomic_inc(&adapter->tx_pending);
+	atomic_inc(&adapter->pending_bridged_pkts);
+
+	nxpwifi_queue_work(adapter, &adapter->main_work);
+}
+
+/* This function contains logic for AP packet forwarding.
+ *
+ * If a packet is multicast/broadcast, it is sent to kernel/upper layer
+ * as well as queued back to AP TX queue so that it can be sent to other
+ * associated stations.
+ * If a packet is unicast and RA is present in associated station list,
+ * it is again requeued into AP TX queue.
+ * If a packet is unicast and RA is not in associated station list,
+ * packet is forwarded to kernel to handle routing logic.
+ */
+int nxpwifi_handle_uap_rx_forward(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ra[ETH_ALEN];
+	struct sk_buff *skb_uap;
+	struct nxpwifi_sta_node *node;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	/* don't do packet forwarding in disconnected state */
+	if (!priv->media_connected) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "drop packet in disconnected state.\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	memcpy(ra, rx_pkt_hdr->eth803_hdr.h_dest, ETH_ALEN);
+
+	if (is_multicast_ether_addr(ra)) {
+		skb_uap = skb_copy(skb, GFP_ATOMIC);
+		if (likely(skb_uap)) {
+			nxpwifi_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			nxpwifi_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+				    priv->stats.rx_dropped++;
+				    dev_kfree_skb_any(skb);
+			return -ENOMEM;
+		}
+	} else {
+		node = nxpwifi_get_sta_entry_rcu(priv, ra);
+		if (node) {
+			/* Requeue Intra-BSS packet */
+			nxpwifi_uap_queue_bridged_pkt(priv, skb);
+			return 0;
+		}
+	}
+
+	/* Forward unicat/Inter-BSS packets to kernel. */
+	return nxpwifi_process_rx_packet(priv, skb);
+}
+
+int nxpwifi_uap_recv_packet(struct nxpwifi_private *priv,
+			    struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_sta_node *src_node, *dst_node;
+	struct ethhdr *p_ethhdr;
+	struct sk_buff *skb_uap;
+	struct nxpwifi_txinfo *tx_info;
+
+	if (!skb)
+		return -ENOMEM;
+
+	p_ethhdr = (void *)skb->data;
+	rcu_read_lock();
+	src_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_source);
+	if (src_node) {
+		src_node->stats.last_rx = jiffies;
+		src_node->stats.rx_bytes += skb->len;
+		src_node->stats.rx_packets++;
+	}
+	dst_node = nxpwifi_get_sta_entry(priv, p_ethhdr->h_dest);
+	rcu_read_unlock();
+
+	if (is_multicast_ether_addr(p_ethhdr->h_dest) || dst_node) {
+		if (skb_headroom(skb) < NXPWIFI_MIN_DATA_HEADER_LEN)
+			skb_uap =
+			skb_realloc_headroom(skb, NXPWIFI_MIN_DATA_HEADER_LEN);
+		else
+			skb_uap = skb_copy(skb, GFP_ATOMIC);
+
+		if (likely(skb_uap)) {
+			tx_info = NXPWIFI_SKB_TXCB(skb_uap);
+			memset(tx_info, 0, sizeof(*tx_info));
+			tx_info->bss_num = priv->bss_num;
+			tx_info->bss_type = priv->bss_type;
+			tx_info->flags |= NXPWIFI_BUF_FLAG_BRIDGED_PKT;
+			__net_timestamp(skb_uap);
+			nxpwifi_wmm_add_buf_txqueue(priv, skb_uap);
+			atomic_inc(&adapter->tx_pending);
+			atomic_inc(&adapter->pending_bridged_pkts);
+			if ((atomic_read(&adapter->pending_bridged_pkts) >=
+					NXPWIFI_BRIDGED_PKTS_THR_HIGH)) {
+				nxpwifi_dbg(adapter, ERROR,
+					    "Tx: Bridge packet limit reached. Drop packet!\n");
+				nxpwifi_uap_cleanup_tx_queues(priv);
+			}
+
+		} else {
+			nxpwifi_dbg(adapter, ERROR, "failed to allocate skb_uap");
+		}
+
+		nxpwifi_queue_work(adapter, &adapter->main_work);
+		/* Don't forward Intra-BSS unicast packet to upper layer*/
+
+		if (dst_node)
+			return 0;
+	}
+
+	skb->dev = priv->netdev;
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* Forward multicast/broadcast packet to upper layer*/
+	netif_rx(skb);
+	return 0;
+}
+
+/* This function processes the packet received on AP interface.
+ *
+ * The function looks into the RxPD and performs sanity tests on the
+ * received buffer to ensure its a valid packet before processing it
+ * further. If the packet is determined to be aggregated, it is
+ * de-aggregated accordingly. Then skb is passed to AP packet forwarding logic.
+ *
+ * The completion callback is called after processing is complete.
+ */
+int nxpwifi_process_uap_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret;
+	struct uap_rxpd *uap_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u16 rx_pkt_type;
+	u8 ta[ETH_ALEN], pkt_type;
+	struct nxpwifi_sta_node *node;
+
+	uap_rx_pd = (struct uap_rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
+
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	    sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet for struct ethhdr: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
+
+	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	     le16_to_cpu(uap_rx_pd->rx_pkt_length)) > (u16)skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, offset=%d, length=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset),
+			    le16_to_cpu(uap_rx_pd->rx_pkt_length));
+		priv->stats.rx_dropped++;
+		rcu_read_lock();
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->stats.tx_failed++;
+		rcu_read_unlock();
+
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret && (ret != -EINPROGRESS))
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		if (ret != -EINPROGRESS)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type != PKT_TYPE_BAR && uap_rx_pd->priority < MAX_NUM_TID) {
+		rcu_read_lock();
+		node = nxpwifi_get_sta_entry(priv, ta);
+		if (node)
+			node->rx_seq[uap_rx_pd->priority] =
+						le16_to_cpu(uap_rx_pd->seq_num);
+		rcu_read_unlock();
+	}
+
+	if (!priv->ap_11n_enabled ||
+	    (!nxpwifi_11n_get_rx_reorder_tbl(priv, uap_rx_pd->priority, ta) &&
+	    (le16_to_cpu(uap_rx_pd->rx_pkt_type) != PKT_TYPE_AMSDU))) {
+		ret = nxpwifi_handle_uap_rx_forward(priv, skb);
+		return ret;
+	}
+
+	/* Reorder and send to kernel */
+	pkt_type = (u8)le16_to_cpu(uap_rx_pd->rx_pkt_type);
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, le16_to_cpu(uap_rx_pd->seq_num),
+					 uap_rx_pd->priority, ta, pkt_type,
+					 skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
+
+/* This function fills the TxPD for AP tx packets.
+ *
+ * The Tx buffer received by this function should already have the
+ * header space allocated for TxPD.
+ *
+ * This function inserts the TxPD in between interface header and actual
+ * data and adjusts the buffer pointers accordingly.
+ *
+ * The following TxPD fields are set by this function, as required -
+ *      - BSS number
+ *      - Tx packet length and offset
+ *      - Priority
+ *      - Packet delay
+ *      - Priority specific Tx control
+ *      - Flags
+ */
+void nxpwifi_process_uap_txpd(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct uap_txpd *txpd;
+	struct nxpwifi_txinfo *tx_info = NXPWIFI_SKB_TXCB(skb);
+	int pad;
+	u16 pkt_type, pkt_offset;
+	int hroom = adapter->intf_hdr_len;
+
+	pkt_type = nxpwifi_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
+
+	pad = ((uintptr_t)skb->data - (sizeof(*txpd) + hroom)) &
+	       (NXPWIFI_DMA_ALIGN_SZ - 1);
+
+	skb_push(skb, sizeof(*txpd) + pad);
+
+	txpd = (struct uap_txpd *)skb->data;
+	memset(txpd, 0, sizeof(*txpd));
+	txpd->bss_num = priv->bss_num;
+	txpd->bss_type = priv->bss_type;
+	txpd->tx_pkt_length = cpu_to_le16((u16)(skb->len - (sizeof(*txpd) +
+						pad)));
+	txpd->priority = (u8)skb->priority;
+
+	txpd->pkt_delay_2ms = nxpwifi_wmm_compute_drv_pkt_delay(priv, skb);
+
+	if (tx_info->flags & NXPWIFI_BUF_FLAG_EAPOL_TX_STATUS ||
+	    tx_info->flags & NXPWIFI_BUF_FLAG_ACTION_TX_STATUS) {
+		txpd->tx_token_id = tx_info->ack_frame_id;
+		txpd->flags |= NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS;
+	}
+
+	if (txpd->priority < ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl))
+		/* Set the priority specific tx_control field, setting of 0 will
+		 * cause the default value to be used later in this function.
+		 */
+		txpd->tx_control =
+		    cpu_to_le32(priv->wmm.user_pri_pkt_tx_ctrl[txpd->priority]);
+
+	/* Offset of actual data */
+	pkt_offset = sizeof(*txpd) + pad;
+	if (pkt_type == PKT_TYPE_MGMT) {
+		/* Set the packet type and add header for management frame */
+		txpd->tx_pkt_type = cpu_to_le16(pkt_type);
+		pkt_offset += NXPWIFI_MGMT_FRAME_HEADER_SIZE;
+	}
+
+	txpd->tx_pkt_offset = cpu_to_le16(pkt_offset);
+
+	/* make space for adapter->intf_hdr_len */
+	skb_push(skb, hroom);
+
+	if (!txpd->tx_control)
+		/* TxCtrl set by user or default */
+		txpd->tx_control = cpu_to_le32(priv->pkt_tx_ctrl);
+}
-- 
2.34.1


