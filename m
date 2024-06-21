Return-Path: <linux-wireless+bounces-9365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29456911D5A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBA61C20D7A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20716D32F;
	Fri, 21 Jun 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SD7bYNxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF016C869;
	Fri, 21 Jun 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956360; cv=fail; b=FfHzm/qz8m9kKk9oU4i5Wt4o7H3+5+myOqXKedyBC9mGcOudopQWgCgk9QynVgQV5BAwfnboS1pMlDCqPlRmkZeEIYp/uJHbxpIomM54mdBYlpClt7RNKpY0rLYDFVOCOF9tGWQm1rPDe3w9ElKXlWEmWv/S1r0XklMuTMJwNxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956360; c=relaxed/simple;
	bh=/CqqwbsuFNyN9I/zT1ZQ3O+fAGUOKJIFD3bPUT+sX8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZkIOfWoyBoAaPqUX52X9vWIPOySh09NTtlP52JFRe583ms7X5RYtXdcTaEw9ZYl3s+O0YeIOO8fYXu1u66wsTmg0aZNRu0WSDWme+vaXLpQZnP/8+Viy7bxmgSKUIwDMIeWA6V7P5/I3mPYsah9xE/1JUmi0HBXSAzX6r3Bp6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SD7bYNxt; arc=fail smtp.client-ip=40.107.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4esDpauijT7HHdqZt2Q1bTW+8+I7ExqTWFQvVd0VGKPN5/dts5yz+ALsQBBMK3TSKCrF1X6861jJzCtok/FG7FZs2mjCmiU9uweWATTnMkz0fTSEiBUekG33oLhaPG+Y3d3na4FlNn3ok4ifoSa30+y1OGMz5G/5nOkrac4rlNS2wIRKbAvKdWyY5V10ekmkqbMpyHfSrlulU+gsZnv0tqlyzb2MXGvIhEfV/dmiOkecWbayNZ6xTw8TWfhqw+NkTC7ori+w/gEOPNdn6+2PoxHNT1/7okJveSTvqDqUfAW4Xb56T3BiQpQP/v48rEW/tlRpPayBa4G449KjOGHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xynYrVUvjJKWmvUnozM32d3mC1JgZR6wFOtGF2B/a4Y=;
 b=Dc0RVQoJn6J3BX09DDaTlJ34J2hA4N45eIfkn5c8QMNUg+/YfgEaR17+LQ/vd21cn/2es/9+A+uyeZUCnemMJd0StDugIciFCUlK7LO77z8Xz1nao/tMSWY2M/V0J8hpXI/09Ao5WK3mtrkcycezW2NLFkdm3oBawQZpn7suEcKDvyYWP9qsSzc24NPCHa19neuMXXssZ5KwRRAc1vUe4cW1vlKpacojRIK8VudTbCup88AhF1wrEKpdH314zQubh5/sIXLVlx+LZTBmV66gygpPf7rN63SI7l6UBW9658uTwBvpdyiKNp13Sv25TQqDMXkhi/ykRCOB9+CppwgNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xynYrVUvjJKWmvUnozM32d3mC1JgZR6wFOtGF2B/a4Y=;
 b=SD7bYNxtklyehatbxT6/rvMfpJZwwCi8vvcI4Zibc0UNUJ2gARpIreVvZI+R1KhTZeOzNoOqhtiwB3+tnVYCflBjymvhGWU/qhebg34KukYq2TljBO0JHRJceFiPoVQEQVvEfmzf3Ywcx2lso8+5KAZV2PU9gZwZ2LorZsbZqAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:52:34 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:52:34 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 01/43] wifi: nxpwifi: add 11ac.c
Date: Fri, 21 Jun 2024 15:51:26 +0800
Message-Id: <20240621075208.513497-2-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ea7208d-399f-48a8-6e1d-08dc91c71c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Me9liTswT8+Pjy3txlFHKCR03wakUOZHXJoGk+E0HblAoPLaZ9RZnlPSgAlg?=
 =?us-ascii?Q?GnSfei/jIh3gj6G9TQN6iOFbHXHryDV9jcnmyQgGZmtYv1uHqoM4x5Pxo/gK?=
 =?us-ascii?Q?b8gDGXWhcuY8Q+EL0Wz8JTtdSipfpw9NxPJ4vZK7YgyGZoQghZatq9B3xAEF?=
 =?us-ascii?Q?Px+rPID+suNBGaBUmeTPEZuM7XPUdGqvA+9mXDKCbYniJV2Br6ndMa6FVRia?=
 =?us-ascii?Q?T+w2nexB650StQlbaI8icjFbmN0aNirwmDeMS8sS+3Md6AdmLmHIyCYo6wrr?=
 =?us-ascii?Q?TexVi//Cc/hQ0RuiBz5fu7Modgs5Ntffw19QcgUzOltv0vxLPHZFe9j5rLOb?=
 =?us-ascii?Q?UlpwLPTTqmawY7UIMbicrNp9o2WIfTvN9Dljc96jnxk4KYrqC3RJBdwEPqxC?=
 =?us-ascii?Q?immJ49FB+6+8NnuToi+l7/IJOrbMu2+th5cCSWP31qMxnEgdqq1EithDJhdt?=
 =?us-ascii?Q?OhhUVYUhFAqwa6cYVHg8slvgMnKQI6X75JjdNUlJYyr9d5swpYBpMYuYlIkb?=
 =?us-ascii?Q?G+ozCDl9PH9GnAmUmSWSrhn71S8T1IuKg/puYZmqe9EHX4ERz8BIycqA194x?=
 =?us-ascii?Q?dk2/pzNQZXRn0+pRRNkwwcoX69y76swDFkH+hGN700X3p8zq5p9Jc3yVVGQf?=
 =?us-ascii?Q?qY1A31xwO+yxZ82cwHXUQCaU3A91w2LKChwRvcTWusTQDLh1gTHBZAqmYCqZ?=
 =?us-ascii?Q?GVgzOEn2FUjHQLreXU1h44uHkk0aCHprsvGoX379CHdPlvVCQEwYYDkMIVsI?=
 =?us-ascii?Q?tQ31z1gtNuh2T9rB5x9ewwNHyCuYOaSrbY8rEj6Vn1tAQkTrayPdyYTAYKf2?=
 =?us-ascii?Q?r9UixCPdX2q+H1YMOFmIuIxJEIpZXI+Pyz/ALLKlBLZSzoytHWC512Ft9RXP?=
 =?us-ascii?Q?vRtRMZf+jMkYh/u3DJpF/5xaZjA6rfhdZeYOfhKo8LHXMeua+Ufkjda6zWfJ?=
 =?us-ascii?Q?Q3IFcbrm3grFWNnf0vHHFz5l9RiV9JIplmr2gqyklqGDDiNyxs4wvfiQUTwm?=
 =?us-ascii?Q?XScY8mFvcOygPM0jTqO32TD1Kpgo1Tlf3+3ELhdsca5IDDFrLRIAkLJM9NW8?=
 =?us-ascii?Q?LLIjPHNph1a/SHQmFIQCoVypxs9MFVF8hgqg/ScRzCIhZ6ikml9rcoicQ3vP?=
 =?us-ascii?Q?8UPHETyYm6h3HiazPFD1iuYCWlD7KWu9B5f+sEt6SotOxBOTX9jncRtulHsT?=
 =?us-ascii?Q?b4eh0Z3VdT7WTuG4gpuSTBls10mYnsG7ENGS9mx7K6SjYkNP3OSNu7u7PMD/?=
 =?us-ascii?Q?MMspWqaPsTd1s1NCzRoRez9NvDqkeBegCgTax2Z87wH3ImSjODJmBLSWdB1k?=
 =?us-ascii?Q?8ofxMIHFf17fbFqbx28hKBdtd/qzrEEM94D+2iunG6m9p2cyRCdP7+R/MzoC?=
 =?us-ascii?Q?MaNcGSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JxLmUSIIwhhF54N9x/5ggsdEjE9FvFdpk1DeuFDbbaikPVOo/05iwPw2y8Pm?=
 =?us-ascii?Q?VAQuUsazI+5qA2SC6R6BtqckcEMci+Oa2P6ocEMu0z9H1ZrGvZGew47QfBHs?=
 =?us-ascii?Q?Z41VX7gF+2B8JZ74dAJ/Y6+Iz5Soc6Jd9rntsYFl2P9OSG6E0MPzef9jtVvX?=
 =?us-ascii?Q?/evoBOJaEx8FajkA6cj1vIEppPux76NhvVEb/2b5spm2a1zcxF/SpVXuxlNc?=
 =?us-ascii?Q?nfE0QpmjixbjjgcL47EkafTIvA/zr+pkPv3/PHblECglWwaGCLJ7Oqh077fj?=
 =?us-ascii?Q?3gLR9d4FbYSrdeDEmqzMFeIUagzfsFXaI1KwtxljQsSuWYaww3sfRrM2TQHz?=
 =?us-ascii?Q?MLlWUM5WcKqvjkhPPquw9XWYCU5EOUPTt/M3a4mf0HiQDncA3eqp8ZQ5jvO5?=
 =?us-ascii?Q?SsDKQTv/MG4GeqnpsyrnCT1r1IPASrTlXxVeFZB/Sz3J+lZoeP7Ti1R/4S0r?=
 =?us-ascii?Q?OakZVZjcA22uj/dpHBV8BdH/zYGRRJq4HfwQ1DUFdwcjbXI+JZr9U7hP736p?=
 =?us-ascii?Q?Yz02O4uEzvRC5peaNTOnB+Jys9XAcYJDpf1JySAtfLXaRG+Apdr59JLvRMb/?=
 =?us-ascii?Q?vNLSNS4AQvp7cUj3C4ckezmg25KMX2jEknJ/iuvCely9952NMrEDR6C33sLi?=
 =?us-ascii?Q?LA3b+tw0DqXPOfq5nBiFkuvsjWrLCuBtnYWBnjlWQOEREAmCCzsdjVXZyI0v?=
 =?us-ascii?Q?g6zLcL5vRqpNCzkqh8UrB/fMueTo4W3DzmX6MSNrJe6Y12ZsZR9i0fOjmMQH?=
 =?us-ascii?Q?yb5/zACLcuyI3H74kPQJb0ErqLh3BLj9hS7Dfkq01CoKeQN7at36Uyzo96wv?=
 =?us-ascii?Q?rHfhbC4/kODybWGnAkygCaFz5IWlQQ29QmE49iMfZIGUOo+fkx/ty87wu+sm?=
 =?us-ascii?Q?RYvL+++yCLx0yhLFwv+w2HpxlsnlPIFDyhy5m3bnTtuyXGUv7gvQyM137WjQ?=
 =?us-ascii?Q?T8YGK9OkbVfTBzZqm9eqX5gI4b7w9CPILSx/eKGX4XqVwcefvHFNwXIf3u/W?=
 =?us-ascii?Q?8h5peewkJxyrklKetgCw0dYK5CmiNHSZE3kMVxxQ3BsiazJMvWXzah2JRhSa?=
 =?us-ascii?Q?PJnz6WcLjx2Pbdy3Z5GfDlMBKsA//kXcoVgBpAo9cQumNZeYx5WJcY+Er6Sh?=
 =?us-ascii?Q?oAqiVPwBG9lLSK9GlommJqrLOWfm4YKt7xKW+zs6xHqufvre4OqGDD6e58r/?=
 =?us-ascii?Q?F+EgljOdbVTJEZG7EcCsjFtfgGaqjm43Jn1QY4R9KMZ4w01lyD0oTXk8KhQu?=
 =?us-ascii?Q?sY/vZGO4ZEcVL1RS9w+HAxe3ll//8Fk9WEe7oHfzS/IVmAgWs5QkXZt2QR+p?=
 =?us-ascii?Q?iFv2PGkIlzHoYavM/yzhgbY+Rnm8v2+iH4yp/v+SfLIChw9lKsajJu2Js77L?=
 =?us-ascii?Q?u4pBes/tQO1GviqMGrEv1Y0inXgohqX2SnDkHGQwgaKCxw3zcUmt3hZPZyd6?=
 =?us-ascii?Q?zZBfNCgqspj58UIZctHvE4KA/ox+6hxdxZ5iSVsRfBzzUtj9UQLGvYWP4KUZ?=
 =?us-ascii?Q?alzkOZzjc7jOu/6ffb8BimmTv0CHtJJ0sqZDAtgF3X3oJdT82t7ee4tkVv6r?=
 =?us-ascii?Q?SFtvkMxjo1QwDYNGHQY14rcM6JlzTAZMXcxL9kcq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea7208d-399f-48a8-6e1d-08dc91c71c76
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:52:34.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYh04AYBsLp0r7vn7M1SJDQadyzl/7wNM0SJY17l2r8R/s2pr87HtxotVX97M7mLOSnbKh5MWu3burh7b/XL3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 366 ++++++++++++++++++++++++
 1 file changed, 366 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..3e14ee602cdc
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ac
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "ioctl.h"
+#include "fw.h"
+#include "main.h"
+#include "11ac.h"
+
+/* Tables of the MCS map to the highest data rate (in Mbps) supported
+ * for long GI.
+ */
+static const u16 max_rate_lgi_80MHZ[8][3] = {
+	{0x124, 0x15F, 0x186},	/* NSS = 1 */
+	{0x249, 0x2BE, 0x30C},  /* NSS = 2 */
+	{0x36D, 0x41D, 0x492},  /* NSS = 3 */
+	{0x492, 0x57C, 0x618},  /* NSS = 4 */
+	{0x5B6, 0x6DB, 0x79E},  /* NSS = 5 */
+	{0x6DB, 0x83A, 0x0},    /* NSS = 6 */
+	{0x7FF, 0x999, 0xAAA},  /* NSS = 7 */
+	{0x924, 0xAF8, 0xC30}   /* NSS = 8 */
+};
+
+static const u16 max_rate_lgi_160MHZ[8][3] = {
+	{0x249, 0x2BE, 0x30C},   /* NSS = 1 */
+	{0x492, 0x57C, 0x618},   /* NSS = 2 */
+	{0x6DB, 0x83A, 0x0},     /* NSS = 3 */
+	{0x924, 0xAF8, 0xC30},   /* NSS = 4 */
+	{0xB6D, 0xDB6, 0xF3C},   /* NSS = 5 */
+	{0xDB6, 0x1074, 0x1248}, /* NSS = 6 */
+	{0xFFF, 0x1332, 0x1554}, /* NSS = 7 */
+	{0x1248, 0x15F0, 0x1860} /* NSS = 8 */
+};
+
+/* This function converts the 2-bit MCS map to the highest long GI
+ * VHT data rate.
+ */
+static u16
+nxpwifi_convert_mcsmap_to_maxrate(struct nxpwifi_private *priv,
+				  u8 bands, u16 mcs_map)
+{
+	u8 i, nss, mcs;
+	u16 max_rate = 0;
+	u32 usr_vht_cap_info = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_AAC)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* find the max NSS supported */
+	nss = 1;
+	for (i = 1; i <= 8; i++) {
+		mcs = GET_VHTNSSMCS(mcs_map, i);
+		if (mcs < IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			nss = i;
+	}
+	mcs = GET_VHTNSSMCS(mcs_map, nss);
+
+	/* if mcs is 3, nss must be 1 (NSS = 1). Default mcs to MCS 0~9 */
+	if (mcs == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		mcs = IEEE80211_VHT_MCS_SUPPORT_0_9;
+
+	if (GET_VHTCAP_CHWDSET(usr_vht_cap_info)) {
+		/* support 160 MHz */
+		max_rate = max_rate_lgi_160MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 is not supported in NSS6 */
+			max_rate = max_rate_lgi_160MHZ[nss - 1][mcs - 1];
+	} else {
+		max_rate = max_rate_lgi_80MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 is not supported in NSS3 */
+			max_rate = max_rate_lgi_80MHZ[nss - 1][mcs - 1];
+	}
+
+	return max_rate;
+}
+
+static void
+nxpwifi_fill_vht_cap_info(struct nxpwifi_private *priv,
+			  struct ieee80211_vht_cap *vht_cap, u8 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_A)
+		vht_cap->vht_cap_info =
+				cpu_to_le32(adapter->usr_dot_11ac_dev_cap_a);
+	else
+		vht_cap->vht_cap_info =
+				cpu_to_le32(adapter->usr_dot_11ac_dev_cap_bg);
+}
+
+void nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			      struct ieee80211_vht_cap *vht_cap, u8 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 mcs_map_user, mcs_map_resp, mcs_map_result;
+	u16 mcs_user, mcs_resp, nss, tmp;
+
+	/* Fill VHT cap info */
+	nxpwifi_fill_vht_cap_info(priv, vht_cap, bands);
+
+	/* rx MCS Set: find the minimum of the user rx mcs and ap rx mcs */
+	mcs_map_user = GET_DEVRXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.rx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.rx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.rx_highest = cpu_to_le16(tmp);
+
+	/* tx MCS Set: find the minimum of the user tx mcs and ap tx mcs */
+	mcs_map_user = GET_DEVTXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.tx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.tx_highest = cpu_to_le16(tmp);
+}
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_vhtcap *vht_cap;
+	struct nxpwifi_ie_types_oper_mode_ntf *oper_ntf;
+	struct ieee_types_oper_mode_ntf *ieee_oper_ntf;
+	struct nxpwifi_ie_types_vht_oper *vht_op;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 supp_chwd_set;
+	u32 usr_vht_cap_info;
+	int ret_len = 0;
+
+	if (bss_desc->bss_band & BAND_A)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* VHT Capabilities IE */
+	if (bss_desc->bcn_vht_cap) {
+		vht_cap = (struct nxpwifi_ie_types_vhtcap *)*buffer;
+		memset(vht_cap, 0, sizeof(*vht_cap));
+		vht_cap->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		vht_cap->header.len  =
+				cpu_to_le16(sizeof(struct ieee80211_vht_cap));
+		memcpy((u8 *)vht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_vht_cap,
+		       le16_to_cpu(vht_cap->header.len));
+
+		nxpwifi_fill_vht_cap_tlv(priv, &vht_cap->vht_cap,
+					 bss_desc->bss_band);
+		*buffer += sizeof(*vht_cap);
+		ret_len += sizeof(*vht_cap);
+	}
+
+	/* VHT Operation IE */
+	if (bss_desc->bcn_vht_oper) {
+		if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+			vht_op = (struct nxpwifi_ie_types_vht_oper *)*buffer;
+			memset(vht_op, 0, sizeof(*vht_op));
+			vht_op->header.type =
+					cpu_to_le16(WLAN_EID_VHT_OPERATION);
+			vht_op->header.len  = cpu_to_le16(sizeof(*vht_op) -
+				      sizeof(struct nxpwifi_ie_types_header));
+			memcpy((u8 *)vht_op +
+				sizeof(struct nxpwifi_ie_types_header),
+			       (u8 *)bss_desc->bcn_vht_oper,
+			       le16_to_cpu(vht_op->header.len));
+
+			/* negotiate the channel width and central freq
+			 * and keep the central freq as the peer suggests
+			 */
+			supp_chwd_set = GET_VHTCAP_CHWDSET(usr_vht_cap_info);
+
+			switch (supp_chwd_set) {
+			case 0:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 1:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_160MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 2:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80P80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			default:
+				vht_op->chan_width =
+				     IEEE80211_VHT_CHANWIDTH_USE_HT;
+				break;
+			}
+
+			*buffer += sizeof(*vht_op);
+			ret_len += sizeof(*vht_op);
+		}
+	}
+
+	/* Operating Mode Notification IE */
+	if (bss_desc->oper_mode) {
+		ieee_oper_ntf = bss_desc->oper_mode;
+		oper_ntf = (void *)*buffer;
+		memset(oper_ntf, 0, sizeof(*oper_ntf));
+		oper_ntf->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		oper_ntf->header.len = cpu_to_le16(sizeof(u8));
+		oper_ntf->oper_mode = ieee_oper_ntf->oper_mode;
+		*buffer += sizeof(*oper_ntf);
+		ret_len += sizeof(*oper_ntf);
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg)
+{
+	struct host_cmd_11ac_vht_cfg *vhtcfg = &cmd->params.vht_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AC_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_11ac_vht_cfg) +
+				S_DS_GEN);
+	vhtcfg->action = cpu_to_le16(cmd_action);
+	vhtcfg->band_config = cfg->band_config;
+	vhtcfg->misc_config = cfg->misc_config;
+	vhtcfg->cap_info = cpu_to_le32(cfg->cap_info);
+	vhtcfg->mcs_tx_set = cpu_to_le32(cfg->mcs_tx_set);
+	vhtcfg->mcs_rx_set = cpu_to_le32(cfg->mcs_rx_set);
+
+	return 0;
+}
+
+/* This function initializes the BlockACK setup information for given
+ * nxpwifi_private structure for 11ac enabled networks.
+ */
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+					   NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+					   NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+					   NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+					   NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE;
+	}
+}
+
+bool nxpwifi_is_bss_in_11ac_mode(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_bssdescriptor *bss_desc;
+	struct ieee80211_vht_operation *vht_oper;
+
+	bss_desc = &priv->curr_bss_params.bss_descriptor;
+	vht_oper = bss_desc->bcn_vht_oper;
+
+	if (!bss_desc->bcn_vht_cap || !vht_oper)
+		return false;
+
+	if (vht_oper->chan_width == IEEE80211_VHT_CHANWIDTH_USE_HT)
+		return false;
+
+	return true;
+}
+
+u8 nxpwifi_get_center_freq_index(struct nxpwifi_private *priv, u8 band,
+				 u32 pri_chan, u8 chan_bw)
+{
+	u8 center_freq_idx = 0;
+
+	if (band & BAND_AAC) {
+		switch (pri_chan) {
+		case 36:
+		case 40:
+		case 44:
+		case 48:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 42;
+			break;
+		case 52:
+		case 56:
+		case 60:
+		case 64:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 58;
+			else if (chan_bw == IEEE80211_VHT_CHANWIDTH_160MHZ)
+				center_freq_idx = 50;
+			break;
+		case 100:
+		case 104:
+		case 108:
+		case 112:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 106;
+			break;
+		case 116:
+		case 120:
+		case 124:
+		case 128:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 122;
+			else if (chan_bw == IEEE80211_VHT_CHANWIDTH_160MHZ)
+				center_freq_idx = 114;
+			break;
+		case 132:
+		case 136:
+		case 140:
+		case 144:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 138;
+			break;
+		case 149:
+		case 153:
+		case 157:
+		case 161:
+			if (chan_bw == IEEE80211_VHT_CHANWIDTH_80MHZ)
+				center_freq_idx = 155;
+			break;
+		default:
+			center_freq_idx = 42;
+		}
+	}
+
+	return center_freq_idx;
+}
-- 
2.34.1


