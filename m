Return-Path: <linux-wireless+bounces-9367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AFE911D5E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFF2282A69
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A81D16D9CA;
	Fri, 21 Jun 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O+ishUq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8D16D9A5;
	Fri, 21 Jun 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956366; cv=fail; b=TP3a03UgmQ8TKdFcpIz3/+CRrQmV96T16dQJwEOUl1zOxa+YYYztNiuDcs6xbfLrPJRWk6tEyhHlGbVFC+wZ+GPdoHVzpN2mFy3xCGO1ggiWj/k904TdCKfGHV/FWzCWbDEDhABQzc9MMgQ8XKACt7KphTHeGTJGQCR5oBhMTmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956366; c=relaxed/simple;
	bh=LLzkHu0h9E9YdY7PJfgq5nNTslIulLjkOHOJ2hAXBcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQw9taqAmLXFxsf2ORkLXALK1seM+GtSmRVcg2I6giHFQx2GoIsrk8S2ivivhOLkKejQksRoY2pXqIKAA4KlMhLv483lRC5NjWg8+fMhtRfiyBIQ12ShATK1fSoAZtAUEhQa8kA7ufWal4lyOadJlJ80gqiF5lwZuP+hC3Y2BUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O+ishUq1; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwP79VBmXWxV1fkMSBlpgi+wSkTT1DFTRZ81fUiIjvGEBlDfU2AJ3BRNGP7JhzXecCtcBGzYLp+W4JgtszplmjBbusskWqhfYa3gYGc74CGzXn0ezrqgHhFg6tSPDvpoQzu/U0Ei4xNTJWz0JKK36T2MQMs/BsFdAoaapGlgAhrOArhttMT0eKtkZubktoC4crgylBfFWfGdlhEfbqt+lrldzBvvawLgQByghkebxmnz2V9U/2Zuiyl9i+s4umvMbzJ3Spbtezcf9YI+U1vk5ljuwWcZESMeNWE0TMHBuxkOaAyOnJ4kgi0gcDMc1I1ObSoFmb2QUq11bKB0OkWMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HafID6muxkDGDhFzNj2vFIwIKuvfQPQRcrZ2D1BQu78=;
 b=BmkT/I5XCGS12g+H/qFjwhMhlOSIJopGPnPUcHdJsH0BdseLZH3Cvik/IMC0ZmJT9AFnn5GDMpnku0j9IIQ4BCpepgfW2MD4KWNyfX/J2mCzqWHXLkt3QPY2hJIiTXoa09d2116dkcdUTemb5UHIYio6R73yy19sQMtclfW8YDtpZefdxC+Emi9B13d2wWnvhcnwH3EssfhOMyrKbIyyo7fo4T5Wan3CuOjKP55CERXt5swWQ4sGFssOaxAxCzHFXWzthY1Rgp9PJiM/Gh0nLweACmRooLx9yHiH+Zl9yceD5g12+VlxrVip+rQsjxblWCJCG2/sCFuhc+4ddwqWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HafID6muxkDGDhFzNj2vFIwIKuvfQPQRcrZ2D1BQu78=;
 b=O+ishUq13Y2IcWeD/gWd5obWrTkv+RM62t0L/9ImM7+pNP6M0AfVtmniqR9dbKEBCUuMHBCshdA9RpozXXKaWVfJU/JyP7EOaN7G14mCdTRzCeWrAtHbGu38Ajk0eJzfYN5yIeut0HipxuEt5yH2qADcBmn3+xvPwlK+TP2XhLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:52:41 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:52:40 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 03/43] wifi: nxpwifi: add 11h.c
Date: Fri, 21 Jun 2024 15:51:28 +0800
Message-Id: <20240621075208.513497-4-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48effe7f-fe0c-4caa-6cdb-08dc91c7203e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l23u21YEdfQd6XBELvu9AaSqBCqn3fKuLokWPDM1V8t1mdQVJHC+NHKY/WAi?=
 =?us-ascii?Q?O7vExmij4o/jT6wAlBzfTTfkFxZkccIomRVwB88bJmzHRbgAvVjBrn73PbvM?=
 =?us-ascii?Q?7RLeHuI5mNN1hsCTxAEMn0i87hEUtfrK7dJZ64G4lPpJgvkihSl+Acalw68E?=
 =?us-ascii?Q?SPEfL9b1Q/Oy4/CRK83Uga6a6nP/rEbBv3KhhHIowdKf2sLH6KruPrm1DVno?=
 =?us-ascii?Q?8KkF2oI+vSW4j/t32GxDQATEf52R8oslGsRFMDlrtlDt2s+aLvyViwj4sYin?=
 =?us-ascii?Q?WVxmTYFzDFCgsV0GooS+GMBIjXzBFypgh9jhfxD/shpV/WFTbuBQAQofDlLQ?=
 =?us-ascii?Q?fhAuLEa1kd46/q6OfvS+8NWCQWj3ikU4kvQgPEmuKPlt/PYBB9BC8XQ86MVA?=
 =?us-ascii?Q?WeM1SxuxXz5BLL0XhBgtTJ3RJgyrmDFjKidZbIxYYsudDmCz4Uw9MlMtT4n+?=
 =?us-ascii?Q?aK7PSIXzNW09bX/RAxY6lqfMTEPzq6Lls+nWf//DzFp5J5Gu2aVbUIV9FVHC?=
 =?us-ascii?Q?p5xlXECCcSBtoIDd0Z9PUpxDgz47+xJSZBaKh5exbm5MHlEcVTVZVkEaviXj?=
 =?us-ascii?Q?L//eVxTukTz3RC6Ig8wP2SmIxxnbB4SbU7WZC2v4vnQXnbOvMiT1bgc1E96f?=
 =?us-ascii?Q?bNQprGDA+WD/W0AtvpPUxRFV9cI3aGsVOE8zcosoLcSOYRrdwgw+NlqGjjqX?=
 =?us-ascii?Q?xMSMOFd47et87Vb/IBR/FLFmbydAEvQGp5Hj83JbsGdHVY1qn46X/cuB/Bp8?=
 =?us-ascii?Q?A5xkOtjEzl4j+iltFsA7o5Wr0W7xw1MlWJuT4JvT8F6+RDt4WevFc8Z0qjQD?=
 =?us-ascii?Q?sxAxTG4rGbACLlr9C/Pgev5yhKyiqwX2cMry8zRiCvjcEpwBf2FLbhchwQdT?=
 =?us-ascii?Q?HTwD3Q1Bvj9FfDr0DwGh27xHnVrte5RpKLZDlsaovZwWslwPWhZPXyYS7FCS?=
 =?us-ascii?Q?kjbrbdOQoaMNee8745TJmoiVKO9ID1ErZZ/3/UA408t+6BTrpA6+QgR0SZ6V?=
 =?us-ascii?Q?MeiVK0ZLNgkUJw/sKf+lXEjTd4c6ErlkCex4yDA5R7g2ChWT43qdwjqf+HvA?=
 =?us-ascii?Q?y3SWhx2JyrwENeT9iFsxCS8Sv83Ux0EAzpFS9Lz4deUHP4Hwk7lax2OiIuC5?=
 =?us-ascii?Q?62dMMnOOrFKaYy8im8mSSUnSPy25/4eBpWxkkYdCo9REnl8wSzJ7XwXVOFbR?=
 =?us-ascii?Q?9bsBGbCzi2aQZyadW1tV7n6mGhaKw/JKCGI1rIx61T8/wuV30n+sdAGCbgUf?=
 =?us-ascii?Q?Om5dqz2PUKxeMXqqEcLJwRsvZQ+e2DxdiD3qoNuHx4oV0sak3hKLsfrtO/qg?=
 =?us-ascii?Q?6cRIBLfyGRs1w1DzujMNkPILnT7a7Tip5CxCTdd2u7/k6gtOY5ABEKgB2Fpo?=
 =?us-ascii?Q?5czy1dU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b4RJtbNr+5qqaXrozDxfyTxixtWcgUgkbmclPs9jqK2l5GIjMxrRfptNmwP0?=
 =?us-ascii?Q?lgIC/JI40cdM3AI/lf/rRCVa0HZX6wqX+AyaMsNTj/JgcvLzf40Jl+KpJv8x?=
 =?us-ascii?Q?uTq9AA904Fx8TZPdnSw487VTMoXoq5ki8gt0D3tdfincUvVTN+sdYw1E4Mms?=
 =?us-ascii?Q?aBgTCr76BwwIQm4bHAc7lTHT70pDEiNZPnttdrm8faDSGAvxHl6QuP3dISMk?=
 =?us-ascii?Q?baECqAmKz5fqNFhwpX6bAoyi1dQUYrDumJXNf5GVeQq5b3M8PCLa21IAlIoT?=
 =?us-ascii?Q?alPz88cgFZQgniW29DhfZ9Cuc9YpZV8ij3a+vYY2pHei/SjsNIa2i4dIN6Ye?=
 =?us-ascii?Q?rjZG97K+Zaf60+o/m4jQWhDpTw/FoTZ96w3UovodUvLgqlvlPHmzX7DxxA4r?=
 =?us-ascii?Q?RTAVTjjbKGzBZjgI7fkIx58owwjdvhZ/qhMoaqZs39dD1KCwRsPNq0A5mvND?=
 =?us-ascii?Q?joOO8bNDItTXIMDw3EMze/rO7BSqM3qgU7mMjHsJzAhDnMmSlh8UjH3n2e4h?=
 =?us-ascii?Q?SU3kOpVVjWOQuqWC3xzZ0r0t4W0Qvd7mNp2YfC/ntGH76cvPOCrhbICFoUC7?=
 =?us-ascii?Q?Gfm51JEeji14PRF9XLesZJCjxhanQwTf3Nrm9BA7nSm/dY8396WCcjBW24rv?=
 =?us-ascii?Q?urSp5NiFiVXJ4FRHjjP9o0zcHwa4N2A6MszwFczF6gJv/ZGI2S2PJLB4PfIf?=
 =?us-ascii?Q?5wf1yg6iZE19qflgMx2MllvU2BtMIQc6zyg5fe9jCOhyqBLG5v+OMM3vjYrX?=
 =?us-ascii?Q?KbMm6gx6DLfDJstYCJ2U3EOijqutjC9KunpG0Wkqanzl/iOQMpezki0mE1Ur?=
 =?us-ascii?Q?EVdD/kU2Dl2XynfJ93+ZHk0qbWFHhAgTAL59QeGhdOpamtZpzhFVfnTT5DIh?=
 =?us-ascii?Q?ohsCOu0Ke/KcSR+3MaLe9urKPWFoVB4/HkI2HUFuHJ732dt/HtCwPC5C+Idn?=
 =?us-ascii?Q?/oX7wrAuPjuNnrsv5v6gQm5NbaYNholNMwjWLJY5vIw3SvY8WAET+oxr5Nv3?=
 =?us-ascii?Q?7zRNOXjrZX3cmPp5sB9BGDtIUhfcIZbQUYcvfforF1quc8O6l828WATVgfP0?=
 =?us-ascii?Q?BIisP04DmpQ9eenLZo5JKOndwLFvp+ps9qCSzFdU6Q/n8Sf7mmnjY8b8qan6?=
 =?us-ascii?Q?7uKkBEEyKx5W5MJI1p3zs6D2J0We9dzmITzBTM7iRD5wMe+QtClPJaKjheYq?=
 =?us-ascii?Q?INzQ1EN/sZKuORQ9RgFffAbEncThipti+kq8iFaS4BP//rKP1vPQ0uaE1/ZV?=
 =?us-ascii?Q?n/1gkwlfb7kmCgSWMpP4lPtnAWebhwnMnoiaVK6KOp8NI4JqjbioYT5PH1Vs?=
 =?us-ascii?Q?kKzBptnG0evgooSluJ9RK0EAdXO9clI7rGkR/cf9Jn29ZtfXYUEGYVz9AyRI?=
 =?us-ascii?Q?NYXL5L0kn+TqEV7NcNEsnatNH7nVe0yOLDVccLyPG3sD4Yiw1sjhUFc3FNy1?=
 =?us-ascii?Q?nPFRH8vvG2SitFFKSjUskUSDXovKAf8WwNYVkQokvSAO5qTlafp7PRsnVJkr?=
 =?us-ascii?Q?Yi/q03IIKeV79xqkn4NPCap6YBHYNl34BJ08U8Y5nYvG55dAaOPaIM8+Kqnw?=
 =?us-ascii?Q?vtZyTsXxusILTvrOFAKpOHXd4pnl9xF8TMkL6xFb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48effe7f-fe0c-4caa-6cdb-08dc91c7203e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:52:40.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW4dS6IdpjcEnuCt7mwjthBgn8e+5R2HH8FvuIOBOZ1ptcQ3wXrnTBAQhcpowXzopDkfkB/UsVBcqxDaYYTVwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 432 +++++++++++++++++++++++++
 1 file changed, 432 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..4bd21e1686e6
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11h
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "fw.h"
+#include "cfg80211.h"
+
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv)
+{
+	priv->state_11h.is_11h_enabled = true;
+	priv->state_11h.is_11h_active = false;
+}
+
+inline int nxpwifi_is_11h_active(struct nxpwifi_private *priv)
+{
+	return priv->state_11h.is_11h_active;
+}
+
+/* This function appends 11h info to a buffer while joining an
+ * infrastructure BSS
+ */
+static void
+nxpwifi_11h_process_infra_join(struct nxpwifi_private *priv, u8 **buffer,
+			       struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_header *ie_header;
+	struct nxpwifi_ie_types_pwr_capability *cap;
+	struct nxpwifi_ie_types_local_pwr_constraint *constraint;
+	struct ieee80211_supported_band *sband;
+	u8 radio_type;
+	int i;
+
+	if (!buffer || !(*buffer))
+		return;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	cap = (struct nxpwifi_ie_types_pwr_capability *)*buffer;
+	cap->header.type = cpu_to_le16(WLAN_EID_PWR_CAPABILITY);
+	cap->header.len = cpu_to_le16(2);
+	cap->min_pwr = 0;
+	cap->max_pwr = 0;
+	*buffer += sizeof(*cap);
+
+	constraint = (struct nxpwifi_ie_types_local_pwr_constraint *)*buffer;
+	constraint->header.type = cpu_to_le16(WLAN_EID_PWR_CONSTRAINT);
+	constraint->header.len = cpu_to_le16(2);
+	constraint->chan = bss_desc->channel;
+	constraint->constraint = bss_desc->local_constraint;
+	*buffer += sizeof(*constraint);
+
+	ie_header = (struct nxpwifi_ie_types_header *)*buffer;
+	ie_header->type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+	ie_header->len  = cpu_to_le16(2 * sband->n_channels + 2);
+	*buffer += sizeof(*ie_header);
+	*(*buffer)++ = WLAN_EID_SUPPORTED_CHANNELS;
+	*(*buffer)++ = 2 * sband->n_channels;
+	for (i = 0; i < sband->n_channels; i++) {
+		u32 center_freq;
+
+		center_freq = sband->channels[i].center_freq;
+		*(*buffer)++ = ieee80211_frequency_to_channel(center_freq);
+		*(*buffer)++ = 1; /* one channel in the subband */
+	}
+}
+
+/* Enable or disable the 11h extensions in the firmware */
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag)
+{
+	u32 enable = flag;
+
+	/* enable master mode radar detection on AP interface */
+	if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) && enable)
+		enable |= NXPWIFI_MASTER_RADAR_DET_MASK;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				HOST_ACT_GEN_SET, DOT11H_I, &enable, true);
+}
+
+/* This functions processes TLV buffer for a pending BSS Join command.
+ *
+ * Activate 11h functionality in the firmware if the spectrum management
+ * capability bit is found in the network we are joining. Also, necessary
+ * TLVs are set based on requested network's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability
+		 * bit
+		 */
+		nxpwifi_11h_activate(priv, true);
+		priv->state_11h.is_11h_active = true;
+		bss_desc->cap_info_bitmap |= WLAN_CAPABILITY_SPECTRUM_MGMT;
+		nxpwifi_11h_process_infra_join(priv, buffer, bss_desc);
+	} else {
+		/* Deactivate 11h functions in the firmware */
+		nxpwifi_11h_activate(priv, false);
+		priv->state_11h.is_11h_active = false;
+		bss_desc->cap_info_bitmap &= ~WLAN_CAPABILITY_SPECTRUM_MGMT;
+	}
+}
+
+/* This is DFS CAC work queue function.
+ * This delayed work emits CAC finished event for cfg80211 if
+ * CAC was started earlier.
+ */
+void nxpwifi_dfs_cac_work_queue(struct work_struct *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct nxpwifi_private *priv =
+			container_of(delayed_work, struct nxpwifi_private,
+				     dfs_cac_work);
+
+	chandef = priv->dfs_chandef;
+	if (priv->wdev.cac_started) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "CAC timer finished; No radar detected\n");
+		cfg80211_cac_event(priv->netdev, &chandef,
+				   NL80211_RADAR_CAC_FINISHED,
+				   GFP_KERNEL);
+	}
+}
+
+static u8 nxpwifi_get_channel_2_offset(int chan)
+{
+	u8 chan2_offset = SEC_CHAN_NONE;
+
+	switch (chan) {
+	case 36:
+	case 44:
+	case 52:
+	case 60:
+	case 100:
+	case 108:
+	case 116:
+	case 124:
+	case 132:
+	case 140:
+	case 149:
+	case 157:
+	case 165:
+	case 173:
+		chan2_offset = SEC_CHAN_ABOVE;
+		break;
+	case 40:
+	case 48:
+	case 56:
+	case 64:
+	case 104:
+	case 112:
+	case 120:
+	case 128:
+	case 136:
+	case 144:
+	case 153:
+	case 161:
+	case 169:
+	case 177:
+		chan2_offset = SEC_CHAN_BELOW;
+		break;
+	}
+
+	return chan2_offset;
+}
+
+static void nxpwifi_convert_chan_to_band_cfg(u8 *band_cfg,
+					     struct cfg80211_chan_def *chan_def)
+{
+	u8 chan_band, chan_width, chan2_offset;
+
+	switch (chan_def->chan->band) {
+	case NL80211_BAND_2GHZ:
+		chan_band = BAND_2GHZ;
+		break;
+	case NL80211_BAND_5GHZ:
+		chan_band = BAND_5GHZ;
+		break;
+	default:
+		break;
+	}
+
+	switch (chan_def->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+		chan_width = CHAN_BW_20MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		chan_width = CHAN_BW_40MHZ;
+		if (chan_def->center_freq1 > chan_def->chan->center_freq)
+			chan2_offset = SEC_CHAN_ABOVE;
+		else
+			chan2_offset = SEC_CHAN_BELOW;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		chan2_offset =
+			nxpwifi_get_channel_2_offset(chan_def->chan->hw_value);
+		chan_width = CHAN_BW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+	default:
+		break;
+	}
+
+	*band_cfg = ((chan2_offset << BAND_CFG_CHAN2_SHIFT_BIT) &
+		     BAND_CFG_CHAN2_OFFSET_MASK) |
+		    ((chan_width << BAND_CFG_CHAN_WIDTH_SHIFT_BIT) &
+		     BAND_CFG_CHAN_WIDTH_MASK) |
+		    ((chan_band << BAND_CFG_CHAN_BAND_SHIFT_BIT) &
+		     BAND_CFG_CHAN_BAND_MASK);
+}
+
+/* This function prepares channel report request command to FW for
+ * starting radar detection.
+ */
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf)
+{
+	struct host_cmd_ds_chan_rpt_req *cr_req = &cmd->params.chan_rpt_req;
+	struct nxpwifi_radar_params *radar_params = (void *)data_buf;
+	u16 size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_CHAN_REPORT_REQUEST);
+	size = S_DS_GEN;
+
+	cr_req->chan_desc.start_freq = cpu_to_le16(NXPWIFI_A_BAND_START_FREQ);
+	nxpwifi_convert_chan_to_band_cfg(&cr_req->chan_desc.band_cfg,
+					 radar_params->chandef);
+	cr_req->chan_desc.chan_num = radar_params->chandef->chan->hw_value;
+	cr_req->msec_dwell_time = cpu_to_le32(radar_params->cac_time_ms);
+	size += sizeof(*cr_req);
+
+	if (radar_params->cac_time_ms) {
+		struct nxpwifi_ie_types_chan_rpt_data *rpt;
+
+		rpt = (struct nxpwifi_ie_types_chan_rpt_data *)((u8 *)cmd + size);
+		rpt->header.type = cpu_to_le16(TLV_TYPE_CHANRPT_11H_BASIC);
+		rpt->header.len = cpu_to_le16(sizeof(u8));
+		rpt->meas_rpt_map = 1 << MEAS_RPT_MAP_RADAR_SHIFT_BIT;
+		size += sizeof(*rpt);
+
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "11h: issuing DFS Radar check for channel=%d\n",
+			    radar_params->chandef->chan->hw_value);
+	} else {
+		nxpwifi_dbg(priv->adapter, MSG, "cancelling CAC\n");
+	}
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef)
+{
+	struct nxpwifi_radar_params radar_params;
+
+	memset(&radar_params, 0, sizeof(struct nxpwifi_radar_params));
+	radar_params.chandef = chandef;
+	radar_params.cac_time_ms = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_CHAN_REPORT_REQUEST,
+				HOST_ACT_GEN_SET, 0, &radar_params, true);
+}
+
+/* This function is to abort ongoing CAC upon stopping AP operations
+ * or during unload.
+ */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+	}
+}
+
+/* This function handles channel report event from FW during CAC period.
+ * If radar is detected during CAC, driver indicates the same to cfg80211
+ * and also cancels ongoing delayed work.
+ */
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb)
+{
+	struct host_cmd_ds_chan_rpt_event *rpt_event;
+	struct nxpwifi_ie_types_chan_rpt_data *rpt;
+	u16 event_len, tlv_len;
+
+	rpt_event = (void *)(skb->data + sizeof(u32));
+	event_len = skb->len - (sizeof(struct host_cmd_ds_chan_rpt_event) +
+				sizeof(u32));
+
+	if (le32_to_cpu(rpt_event->result) != HOST_RESULT_OK) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Error in channel report event\n");
+		return -1;
+	}
+
+	while (event_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		rpt = (void *)&rpt_event->tlvbuf;
+		tlv_len = le16_to_cpu(rpt->header.len);
+
+		switch (le16_to_cpu(rpt->header.type)) {
+		case TLV_TYPE_CHANRPT_11H_BASIC:
+			if (rpt->meas_rpt_map & MEAS_RPT_MAP_RADAR_MASK) {
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "RADAR Detected on channel %d!\n",
+					    priv->dfs_chandef.chan->hw_value);
+				cancel_delayed_work_sync(&priv->dfs_cac_work);
+				cfg80211_cac_event(priv->netdev,
+						   &priv->dfs_chandef,
+						   NL80211_RADAR_CAC_ABORTED,
+						   GFP_KERNEL);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
+			}
+			break;
+		default:
+			break;
+		}
+
+		event_len -= (tlv_len + sizeof(rpt->header));
+	}
+
+	return 0;
+}
+
+/* Handler for radar detected event from FW.*/
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
+	if (priv->wdev.cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+	}
+	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
+			     GFP_KERNEL);
+	nxpwifi_dbg(priv->adapter, MSG, "regdomain: %d\n",
+		    rdr_event->reg_domain);
+	nxpwifi_dbg(priv->adapter, MSG, "radar detection type: %d\n",
+		    rdr_event->det_type);
+
+	return 0;
+}
+
+/* This is work queue function for channel switch handling.
+ * This function takes care of updating new channel definitin to
+ * bss config structure, restart AP and indicate channel switch success
+ * to cfg80211.
+ */
+void nxpwifi_dfs_chan_sw_work_queue(struct work_struct *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_chan_sw_work);
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (nxpwifi_del_mgmt_ies(priv))
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
+
+	bss_cfg = &priv->bss_cfg;
+	if (!bss_cfg->beacon_period) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: AP already stopped\n");
+		return;
+	}
+
+	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+			     HOST_ACT_GEN_SET, 0, NULL, true)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (nxpwifi_cfg80211_change_beacon_data(adapter->wiphy, priv->netdev,
+						&priv->beacon_after)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
+	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
+
+	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Failed to start AP after channel switch\n");
+		return;
+	}
+
+	nxpwifi_dbg(adapter, MSG,
+		    "indicating channel switch completion to kernel\n");
+	wiphy_lock(priv->wdev.wiphy);
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0);
+	wiphy_unlock(priv->wdev.wiphy);
+
+	if (priv->uap_stop_tx) {
+		if (!netif_carrier_ok(priv->netdev))
+			netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


