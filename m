Return-Path: <linux-wireless+bounces-9373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544CB911D6C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B5C1C21086
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4416F0C3;
	Fri, 21 Jun 2024 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WnTseNM1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C216D4F1;
	Fri, 21 Jun 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956389; cv=fail; b=IxNH9rE9acwL/A98BQP4HNPVEydgnIC3uNqZlWahWmQqorUOTCpnX9wk+j4NNrZgZp6Q19Dv9sy7MqubSHlUVwmjAiYrla7yoGkMPO1LaXJJfi6CbI5cSZwasgKhXm4bFfMgp5mq5rmNCKmejWBbqP7wGAFzrUOKn1iO6N0TYQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956389; c=relaxed/simple;
	bh=tz4DGMMNSo4TPmxoDzXcyXduJhbSew6/kiAaMBufKN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMpYLdZf7of6k4O6A+BhFfc0NGSspW/WAko06EoD3Q/c4qvhldSBUBIbzkIR7RpB4Sg9ylve823kWszQnusDa9XzKc29Z776BtIqEFjreZoU1VgU+1Bk3OfrHslSn4qXp9PASzeZSpq6M+z7nyZUBI4NtpLS7RDpNg5PiYIwilw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WnTseNM1; arc=fail smtp.client-ip=40.107.14.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guINo3TtX/0tOio0nVXyAjH0CPKHXzqfNkj9GycqCBrf1qhANKW1qG+U+uclMUdFfz3zTcXdZwf39aw4uZYZj/MhlCmPu3szse9fNVPOUiuhx4PsPIeiSLCtduOAB1CNsdD0OBccixNfPy32ov6NXH8puHiKNMF+eDQtcr7VEpEYEa7Ez/jbPWd7jr+1YBs8cgSXnRqXIbk+BXIftLxBLTT3ZHOw4jz+wwGSIVWW3Be44FxEoAB1YOE18TYnrL+iDxLZhRUXkpQvZ1YMXUlU+wVb7kbDaGjFZSe9SMGlNVd5qHJ/lipV/IzNyAJHXNoaxurDet4RTp0fecntsAXx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/SyoI9cRkq2Kyo0xPSJ0d2ojtuvkST/zzCy665dN/0=;
 b=CZ7m47O8RM7X1XxrfhW6mN8YfuyqcWhoxz7zybT4Y5euz7YPjshSHY8iPx6Emr0PcFl8k86cnTnH51lC0xrK6r3GHmRgCWgyvu6IZB0EmxvC4clX16qbwJ+Qctpq1Sl9cK/i6FPZypi00ssJpo6gTzRuen5c/Rq3VBTfWek258IgTIqa1EigAXuPFaUCaQmJDDOS99YqR9XA3AUg2FpGB4NXfSGszi/8L6zjOvs55YZ6pQZKWBKQNMzixJD7GhY1q3B5Xcrn1jl2tPKMyEtJPEQaohHaOu9/7yepEi8ay8uFGZNa5r+B99XkdsLX6BJyEOAXQNeyy8rnvs+aNWRVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/SyoI9cRkq2Kyo0xPSJ0d2ojtuvkST/zzCy665dN/0=;
 b=WnTseNM1VSpGcyUrBHnnDIfDZck1EoTO07o6t++P1rcSZG2CbokeGUrEw/MTF3ENon20LCM6rN0MRXmyDTRUfmHwEEoo4qO/ss9MykmJWkr2HF9gVu5D0gMFiwSbPiF0ghr94DvMKmEqAbttIQI4iBlSLEWgOeMHpv++uKgKr3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:53:02 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:02 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 09/43] wifi: nxpwifi: add 11n_rxreorder.h
Date: Fri, 21 Jun 2024 15:51:34 +0800
Message-Id: <20240621075208.513497-10-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DB9PR04MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 05371deb-261b-46a4-ac90-08dc91c72d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UU4zvWuY7918vYvAbGrp4SbyzlIMbcK2gpaXNwEVIQESPjXVPEND7KSYRz5z?=
 =?us-ascii?Q?i/9CFcKgmqBohwam0nrdFflj71kjE0ATsf8CShpwHI2sc5tVA/1l7073CYeB?=
 =?us-ascii?Q?cDj+W5yrSeD4e5bdF/4qCY1wTVcMoVWSmeeId+bIat389zZ+Kuzf4jkgdM84?=
 =?us-ascii?Q?rXQk6mto2WNEmqxCioXZNkFKJ0PYrsxrwJ3FCX9PVrXWhlUieTs95TG3FXQe?=
 =?us-ascii?Q?toEkWXhx9B72V+l53pI/k1/Oap/iFp1hWfWL4c3awtZHfTPN6y+NHBi39ilK?=
 =?us-ascii?Q?2M0s0KBQOzGaTzZNZ5j1TiYfdf0b4qX8BlNRBM+BECEJNajczBm6H2GOR/wV?=
 =?us-ascii?Q?2tZpQGrFdyRbj5ky1q7Bm0HDS3cVuLKfSRq5T08uxTdD1DXA8ytipnHlhCTs?=
 =?us-ascii?Q?GxAs0yTaya4dbztUxtOy9vK7cp61ZhpmYdBxWcsDy0M6BZXkv2A6ibLuqfbs?=
 =?us-ascii?Q?QbCCf2O6LfDbZmu9dwBSVHDVN+io3ptvmR9m1Uo54z4nCyiGj0CXv8Kq2xU5?=
 =?us-ascii?Q?dbe92+IGST4O232as09bZ0GRWAgKCEq4ccfCe75PvddSpmiEn64/Bs0oj+DX?=
 =?us-ascii?Q?sUjcpTGicRd34C1nw5GHTeurlQMEnPmIPyeDFGmdR14wakkgBwjC7PFU0pKJ?=
 =?us-ascii?Q?feLZQgp1z2jnT5+lEUSw7nl5f4rfncX3/mmtRQSdV5nz75SoK9aqE1/1umQR?=
 =?us-ascii?Q?fp2l9Whnjv5czJfrp2dK7OZ5rRe3o1ih77fEanLrYyEgG0Ux3tMnasYRdv2T?=
 =?us-ascii?Q?GWPVIpv6sohUk8Mx98RH5H1hRNT9hxuhce0FgqHCOxKKcNNHwm41j4j2zEqI?=
 =?us-ascii?Q?5ENgDsyp/2yL7IG9jTOt8u+Xg4LsHwp3z9j4cJghImmGzqLa2AM4CFrYhNOK?=
 =?us-ascii?Q?AIddA+GZlFuUeBwdWnrqIUJ+N6iCz1AK8T0LzeMWxX7FdilD64oWxGB3Q1mb?=
 =?us-ascii?Q?aoK/94h3t3SimumaEyxM9z4vNXvxmMd3OdNy23gur/pH/M3iJNBDXoQOV0Ai?=
 =?us-ascii?Q?2y5Jpv/QDODBfegAw6h4FMj8t+0bjNcIuwT+xunIOo0U4TAR0Kvz8aQejKq2?=
 =?us-ascii?Q?lJf0lsq2OpSIJA5F0zVEy2J/RxXiRa+wq3CNdNM7kX/CeLxTI0CtYjer6Owm?=
 =?us-ascii?Q?+BH+OQ0GTfVV9Zo/NIt2gSSVJes+W2EjV5dNpIRZg7zj2+J39Z1knROAgdNL?=
 =?us-ascii?Q?E1xinH3v8MZcXKE1HjnXrru2fm3mtwVxvsCm/qTEnB9yrID0zwDETOVeI9k1?=
 =?us-ascii?Q?d3EP/YAZLR8ZFTJsuAM4FU21rggNKXJvO+QvjtNduPnVUHbadnNi2AOiQYGj?=
 =?us-ascii?Q?VT+sq9/TshUEU5lwCydEpqwmaTvnniszGPbRKC4HhxsHZFWIgPVc7vUxIurx?=
 =?us-ascii?Q?/9rMPpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhtSAnXi4TODGxKzlEw+XGmp9/HZxvjRSPpDogdmuHHedV+J415UaBS9J608?=
 =?us-ascii?Q?FWyFmKXJl9srmMjpoKwmskmYoB3/cudMlUyH6/nZXxo5/EnXF0vS/SEfTxpi?=
 =?us-ascii?Q?t34zRGW/854kRXJs8hn+5MIvZBRLgzDrp0xeD6U226mO/v+JrLwcEK+By98N?=
 =?us-ascii?Q?SV/IRpyZcB2FWd4wM05oi9pudNGAr43XTlA87kGAI7rY7pUiVgUKvjkgCbVJ?=
 =?us-ascii?Q?srcRvFdZJMJENoi7y+YWYQkOnP5b9bEEaffTFGFUVorUuWH0/8Xucb4hxTIH?=
 =?us-ascii?Q?hNwRQoXOqjQOMuNZ8YiMw057Stt3Qr2u/3hpR8N+SD2qPrxUbN7VRrpjqG17?=
 =?us-ascii?Q?nLZm8ClA0JX3Ui7tliiMo4AK5F44gQvEus+qx90WdybLxGWVcQM62RIdYXU6?=
 =?us-ascii?Q?2GK9tXpA3S/8xoqBYVSCmBm3n31BuRvhoHgK4gGO+kyRLlbhpjB7e/pqyKW5?=
 =?us-ascii?Q?nX7IdZNgUPhc+ZMnrT3x2XQhSbpQRf4kqwDCcng4N39Ix8PdhcnvYeHuLLE6?=
 =?us-ascii?Q?LlAWN4yTJyy2mDzRLgUrKhvynr3hktYMqXcgLLx4S264Zm92LhLq6/txO3+b?=
 =?us-ascii?Q?8xod7LdhoLhOwO+K/9nnboDqktjLIfLZAJRGW32a13OrVGQbOG9OxfWfTDrq?=
 =?us-ascii?Q?cSzkJrSkHn/h1tg+tuB/i9ubckTnN4SBiV++SqKjqrHnbz2KhrLvYOgj4j4E?=
 =?us-ascii?Q?jLSAZsZZyGWvzHzLMvnt2GyePn0sTIzgNm88omm88GkRIdXxJv5f/1T1Qk9w?=
 =?us-ascii?Q?ELyWUVOdJOm+UoGZImyFk8qM+s8+mzC3lCCHfbUj/XMpMYn35864SMJTdYp2?=
 =?us-ascii?Q?DIjMRrzGnOoF8Tg9FatyUq1ci3+uEQiVEhQuD+5XXcUWKgaYDsceaQjP64Ks?=
 =?us-ascii?Q?Rm3Ev35LJLNLD9K4UayQFt5yy9pDKVmFnW9oVIk4VSJc1mbSk9UesJakZ3KR?=
 =?us-ascii?Q?L2sJnpm5QHpxJ1zxH+A69ASoI4+wxP+NZv7kUqMW7Hcj2g+r4kXsZKiYRTlW?=
 =?us-ascii?Q?hB+GFHEMgX3OavlnBt0UuWr/rYUB2MQ9y8wtBkVuL8mY6m2QCfLjCCnMM7Qk?=
 =?us-ascii?Q?sYS0wAnQ49o0TweezIA9LRkDWGZrwJWuH6igzXAX1AXnsj9Nvu9RqDLuAGcw?=
 =?us-ascii?Q?y90MtzezaHSMzNjB+WYXQjGTJo+xtCGY0QihGzkrAAtq3c7LH0tgV5BZNkkI?=
 =?us-ascii?Q?QsnRSFkrApRp5z/+2Ro2UWI435GvOEPswdA/vTbDmuXx1ccI4xOY5iS3Lqy0?=
 =?us-ascii?Q?r/3HNJUYOcP8RIAE8f/wnCdT+jPBdPG6NTv+QAEY8UxxxTfzzTruc+vTR7pO?=
 =?us-ascii?Q?NonlN1gMpIq/cxIfA2mBQWRb+C5+S0yUaQliIx80Rw3ll08N10RDB+7pV9TX?=
 =?us-ascii?Q?NTsP0SigOFDxdKxHqtOmTxcLBJpbJKI/kxmrRuPyHBP7E2hCjLlcv6h/Hpwg?=
 =?us-ascii?Q?6oquFeyZVIf1CZIHNrPDuBON6sTZqDnH99GJFhn7aBEziPAEVUBvpUI0Ih05?=
 =?us-ascii?Q?WfRFWsvVzvsKg9Ihww7NtYTBX8KZ4N2vzhkV8DGL68MHI7qo9Bc2WPY5aLGD?=
 =?us-ascii?Q?gZtdAXZV+P4UOUJcKH8/XjbDtiO3eCBRSIypylq5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05371deb-261b-46a4-ac90-08dc91c72d0e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:02.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M78blKWX0EvTsD/uDlbghv1sy6Zi5O8w0cSO5aiYyE0cmX+VfQsDuOfiAtSMS+faFa+aRMw4EmjDjppHKlaRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
new file mode 100644
index 000000000000..9b5dd4899f0e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n RX Re-ordering
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_RXREORDER_H_
+#define _NXPWIFI_11N_RXREORDER_H_
+
+#define MIN_FLUSH_TIMER_MS		50
+#define MIN_FLUSH_TIMER_15_MS		15
+#define NXPWIFI_BA_WIN_SIZE_32		32
+
+#define PKT_TYPE_BAR 0xE7
+#define MAX_TID_VALUE			(2 << 11)
+#define TWOPOW11			(2 << 10)
+
+#define BLOCKACKPARAM_TID_POS		2
+#define BLOCKACKPARAM_AMSDU_SUPP_MASK	0x1
+#define BLOCKACKPARAM_WINSIZE_POS	6
+#define DELBA_TID_POS			12
+#define DELBA_INITIATOR_POS		11
+#define TYPE_DELBA_SENT			1
+#define TYPE_DELBA_RECEIVE		2
+#define IMMEDIATE_BLOCK_ACK		0x2
+
+#define ADDBA_RSP_STATUS_ACCEPT 0
+
+#define NXPWIFI_DEF_11N_RX_SEQ_NUM	0xffff
+#define BA_SETUP_MAX_PACKET_THRESHOLD	16
+#define BA_SETUP_PACKET_OFFSET		16
+
+enum nxpwifi_rxreor_flags {
+	RXREOR_FORCE_NO_DROP		= 1 << 0,
+	RXREOR_INIT_WINDOW_SHIFT	= 1 << 1,
+};
+
+static inline void nxpwifi_reset_11n_rx_seq_num(struct nxpwifi_private *priv)
+{
+	memset(priv->rx_seq, 0xff, sizeof(priv->rx_seq));
+}
+
+int nxpwifi_11n_rx_reorder_pkt(struct nxpwifi_private *,
+			       u16 seqNum,
+			       u16 tid, u8 *ta,
+			       u8 pkttype, void *payload);
+void nxpwifi_del_ba_tbl(struct nxpwifi_private *priv, int tid,
+			u8 *peer_mac, u8 type, int initiator);
+void nxpwifi_11n_ba_stream_timeout(struct nxpwifi_private *priv,
+				   struct host_cmd_ds_11n_batimeout *event);
+int nxpwifi_ret_11n_addba_resp(struct nxpwifi_private *priv,
+			       struct host_cmd_ds_command
+			       *resp);
+int nxpwifi_cmd_11n_delba(struct host_cmd_ds_command *cmd,
+			  void *data_buf);
+int nxpwifi_cmd_11n_addba_rsp_gen(struct nxpwifi_private *priv,
+				  struct host_cmd_ds_command *cmd,
+				  struct host_cmd_ds_11n_addba_req
+				  *cmd_addba_req);
+int nxpwifi_cmd_11n_addba_req(struct host_cmd_ds_command *cmd,
+			      void *data_buf);
+void nxpwifi_11n_cleanup_reorder_tbl(struct nxpwifi_private *priv);
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rxreorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta);
+struct nxpwifi_rx_reorder_tbl *
+nxpwifi_11n_get_rx_reorder_tbl(struct nxpwifi_private *priv, int tid, u8 *ta);
+void nxpwifi_11n_del_rx_reorder_tbl_by_ta(struct nxpwifi_private *priv, u8 *ta);
+void nxpwifi_update_rxreor_flags(struct nxpwifi_adapter *adapter, u8 flags);
+void nxpwifi_11n_rxba_sync_event(struct nxpwifi_private *priv,
+				 u8 *event_buf, u16 len);
+#endif /* _NXPWIFI_11N_RXREORDER_H_ */
-- 
2.34.1


