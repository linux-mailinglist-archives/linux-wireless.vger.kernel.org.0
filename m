Return-Path: <linux-wireless+bounces-9380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B2911D84
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B69C283A7A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070DC16FF5A;
	Fri, 21 Jun 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V0u37CUe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E316FF36;
	Fri, 21 Jun 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956412; cv=fail; b=jZXzCbMMPbhgnV5WfodLfb93yLKEzDnZEnlRRMHDVIt9H3o8THcMBCAJEQKrrmXSnlaMLpenz+wkGzj9djoD7AGLVbGPwg+dIrZXxyGk/eTkQj5QODhiyUOfHXlq/sYYoj1udHYAO8K7jSZTUSsfD+eBMXVxm0Ir4iXLhBk6blA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956412; c=relaxed/simple;
	bh=mvA4LH9J4HyE3Bh49/UOaR/HaM8DFdOj9h6R0CtjV80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KqTAeCr3/qRuAJpVega7igDcawilFSABs47JfOUSimIumtDNsCboaeyFwqlsOMTZugRLuCnXhGh3IffUHnUySjIZOPYz9pN13uDz2pBTL5naGbLlOeHCFwhGSVDhQVsV0LnGu9fmdMn3jMaev161sYJxLii/8TpeIcugpAHuuTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=V0u37CUe; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX2Nm/y+gxAnQOYvQPvVACPGcIqcTH6WWJVBrPY5P95/r635/7Pn1wJt6TGsX4i4osZYIng9IAXyVecUPVMv9JAHVrQjAa0Q/iTqYDA3TgEuVMIyrTjbgwQVaaRfBreaMtjvzK2Us2rJAhsF2zdO8A2h6/7EE04m692WVwVYPONDjNVzpXhM4f8wlHLVwHhfR+hhsrA1HT9wNTiD1htHFVJswKURwykWEYrqlm8yzfesb8iiyQylcBEsq9nIBkRe6XQltVtNw2NABQGKzklE9X0d5H2gY0BNFOAx7v6xBXnFPT7QYo/d7UyqA90R1/CXlX20nEHA1sOVlw+uNShnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7fLqB4wnyaH6ytFNpYg24/WN+k1D88xA+QUejWYlsw=;
 b=WI10RFiRaUGzpQXW08iBAEDfjLsot8JyDHzXg8Z3YCwYcuXylmHoX8XEvBNFN/V0+e8ZsvhaIkYP/D0s59F00wmz4ige0kWDSnBS1PyNCJO4vFp3XHOPkmhDZxE+aYIvsijtwlij1DczF+Ds2QU5e9C8zEKNTukeMGZzqWXx02h/5qgsxETc0WJk86YPoPTzY9EP9eMdX0iDpAODW4PCuZSDIHIyk44UyQXaKrqBzrr5jsnlNaXBZXC1sc3qX/Pe4uj4ZmZ1Iv8EM6CKv+7pCpE3qk3sNQVTQiQ3g4XAxu0dy+BRO56TCQ+7QKHfsY+yZ6g6MV3N3EGonGw6TW8Q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7fLqB4wnyaH6ytFNpYg24/WN+k1D88xA+QUejWYlsw=;
 b=V0u37CUeKkfILMnDWu88rhKtagkbAW7Auwknjj2JQGgntBuyRHPWm5QRe0K7ZaEpLvg7KsWZIDjb7cSd1PfW7Cdqm+L63Xdywbdd86gxI3VM52UhsQfeBnpnWESH2W8NGdY35IKY1pc3yFdPptJ5wx5YGoHcHaoZfVMULkd7gPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:53:27 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:27 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 16/43] wifi: nxpwifi: add decl.h
Date: Fri, 21 Jun 2024 15:51:41 +0800
Message-Id: <20240621075208.513497-17-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: be5906c5-b39e-42bc-bb0b-08dc91c73bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vwTIFp9L/AlZe9yE9VcKlvncGmidiWw6dYS2t5ldDBry1SOb++fuLIV3HwGU?=
 =?us-ascii?Q?PnLGo8GK+L+88BJbWNE4b/jYoUf71196VbnDXD1XWST9zKkjzfnsBGgL/Hub?=
 =?us-ascii?Q?WF30uOEjyizNZAgqm+H8xACy9XhfxtLQa+F+mlTaPlqnGq3Xcx2FQqzbCZpR?=
 =?us-ascii?Q?L1RlGyIU11XISfYoeQLRzQh6PIi4iG5R+8Noo9ohkfoMgeLqwAzz0D/+88Be?=
 =?us-ascii?Q?fpJTsZWy0RCBFvA0NCnTN8lKi8Vvymkpa8/vBctuk4e+fCs7eEVgEaTCEBOk?=
 =?us-ascii?Q?KpMGYLje7hZkPmin+StfLyCnr5WX8IbOyg6egu73tWtrisbzzdCvrf/DcgR1?=
 =?us-ascii?Q?ESgfZd5sO/4EcoeAaYMCT0d0w4LFU0HZVtXpWTiM5TgfB2G/V9eRnHY8+5QN?=
 =?us-ascii?Q?KhJ1VZiYP7dg/QcdcPqENxVlHW5Iv2g0Ug9Ii/XDkIiZN5NZlz1FKqTCaXcA?=
 =?us-ascii?Q?5VwFknAQOxwXjOoHEGjXa61iJRngIbQg9QhdJnwpb4jFRUf1SKlGTrFTjluh?=
 =?us-ascii?Q?5yqgBRNhqjRWI7GqY8V8jH0jm0SadiQorIJNyqAj7TIiTKm42xfTuVPtq1mY?=
 =?us-ascii?Q?aaUn6Cqy2avgB6MmeZQM0U9M0LMmnl8jesZPsLEiV7Of3vV7UOqe+73Phw8p?=
 =?us-ascii?Q?yg+cnyse+4SzkxcFTT5udIzYWaaNVuIE+bRmtuwU4WYD8Q8XaEtG/qsb7vvi?=
 =?us-ascii?Q?l7fxJOFDmvJZfRiw21dbYJ87yAe0K6xtJoosjyOckjHup3rlytY1rCVhRGjA?=
 =?us-ascii?Q?03hmrmXLma7Wy/6b3xgLjpBba50W8UEeHEIWW35E9KiuQdb9cdqM3PsjYk0w?=
 =?us-ascii?Q?mdJKHSe9qNqj5tTU59htUoR7KSK65D66ztpthiOCwFC2WDlcxP21AR8VxJxP?=
 =?us-ascii?Q?G/yb/pNiiEe+OxOi37SjpLsfmi+H7ZFWACb/NRLdanMcvkwi+del4AgsQa6U?=
 =?us-ascii?Q?V7YMsLSAPAV3dMQpZHQT6TbARygQmjxfR3W5Ml6fE5DUDybsu/Cq3pbfEWV6?=
 =?us-ascii?Q?ZbbheADNkAmYkrDewl4YulBo9axzxhFKi7Y+5Yt+DJFi2NwW63ZrjozqGWgX?=
 =?us-ascii?Q?aHIgDstAtCnm92/M5bdmr7eQ7DKIutIa6SrRALAfXhHmqXmgWj9I/yICJm2V?=
 =?us-ascii?Q?LlP3eYz9HU9buLW9X8h7qGiEFbGp2z+mSgVolAWixkhrJ63zBDpZlOiIbLkI?=
 =?us-ascii?Q?SQZ3sSRl6ZWzZvQT2vECMqhIUIv3lv0z110cigKPXN3VjzZ1otKJ8fkfqWT1?=
 =?us-ascii?Q?ot5gW1q2cag6FbEkENryrN1VfSpSewq4MZGcMnvXveDmNGo4zZzqtDKnrwFQ?=
 =?us-ascii?Q?Sy3P88UIk8A+HAEhbmnpnYJS5RLZHE82FW6SPQZohO83z3MRjSyU2wuDeJYQ?=
 =?us-ascii?Q?ycp17Yo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LO45ySEYhnCnnOMDWklvI/pmx1g2kUTfsdsiUZlMg+K6WHyGCl1F1Hh0CzTG?=
 =?us-ascii?Q?HBZSKL22psoRcb9Ut9Csf9OUL/CSN65QfnDN9s7UV87F3INXqlsTHqAjdpsF?=
 =?us-ascii?Q?VO+5JTkGYxIgCcjcwAuhOwvHyvRGuFmSbL0DUqd7D2dllvQ4UM9aH2Jw9lCy?=
 =?us-ascii?Q?xy97MH8UTbtCPRJ9wwy3AACpSAewE6hdTjwOsca4i88+hlE19ZYy9A7ajbCQ?=
 =?us-ascii?Q?l7L1O4uJvHaiQSVGkorx6I1AzxOpqDM7C+LFXfhBketT5lwCUeUzfCjQIEVz?=
 =?us-ascii?Q?KPcYPpZd/h/v7lf7nhf2/PBuLED5pRwfBzbyBEHsIvaeAHDtPE9wlbeWm9JQ?=
 =?us-ascii?Q?5c/gxEU0JujNZCv+UjaUxCjRZMQhmFsgHuwgTm9n+1WTGVXn514CnqMZdSP+?=
 =?us-ascii?Q?FiLgBBO5sM9iwknzCTD72ifC11waEcAg7qaeOZpLJ3fMbMQ4mvOh6ke/hSMp?=
 =?us-ascii?Q?3bQMs+IiXz9ob/IqkcA46mYk0O8KSoA83OEOfXzwhwpnPL78h3wipF16oL3w?=
 =?us-ascii?Q?pEnu6TxBUUftN4k1zf07B9WaGx47k1J9wxaJuZjBFc8DOeogaRgB5uwmFsy6?=
 =?us-ascii?Q?2LRQzJx1NTLqVLbgOIs+g9vV4G/+7ZkBs2FD0Lx1MuoXzQDt0sAKMhlhvsqz?=
 =?us-ascii?Q?+unVRQ7+IkRWyQUbmIbgdNRVdY0nr0b45D/9VoEEdmHyK+f42Z4ugezOAaZ8?=
 =?us-ascii?Q?HhxYebmBGLnBBQyWrmjeg1ABm6Dmyoja/V13VrYsK+8RrToOq6W8cQwylzGP?=
 =?us-ascii?Q?bRGICKunbdvZmete27imReNaP91mROjwKf+cPVHgWT6Mf5NrdUGScY8PERHo?=
 =?us-ascii?Q?h77KxRfhs4P4C0pNLZrTDpp0ak4JTaK6nKAEXcSsaErnAele5BWoBozSItYX?=
 =?us-ascii?Q?kBIdl8Mp+HTMTOgV5bHtwEL5xqY4j8yq3tTW5WGqcOk/u1SknJ0XjLa0tPuz?=
 =?us-ascii?Q?7w6Oa7F2mfbN8LcNUSxBCxbUY4I0fIAacV8CmvlHGs2c4X/xb5Lsxevyely5?=
 =?us-ascii?Q?rGmCxiDle9lxBCT+1pokeXwBWE0WOogA5Xi4N9YUNFz0TEri5S9ytDXcfyJe?=
 =?us-ascii?Q?/x54YVd58pyp4pt62JyhbyQKBVAx5PElmMDOvwrI3yYD3/WmYcAmqc682EPS?=
 =?us-ascii?Q?v34O5dU+qi7ztulhZoi03bb/p5d0aYDLlTCTl6lGDf9UuURJf4epUn7shd3w?=
 =?us-ascii?Q?TcBuCo+sIURcAi1l3ON3G1h5IxBH/e2fN3HG9HhqURYP3mjGdyXqlZfmZ1yy?=
 =?us-ascii?Q?/LxR4V7wisB/SE3qtGe/H6HQsrpS5fTEJM7ap7LFPaNDqyZWaid0dUlXRjAx?=
 =?us-ascii?Q?iHBefUenjQY8lEjXw5W+72jtCPa+9N537M4vVOS2uK+S9INT4ri5M/6P7hnV?=
 =?us-ascii?Q?jUiMy4x2PfG7UaGbRysTt6nARms5iblOHi4oyjX0dPqkhXnSJaSNwNTOzuR1?=
 =?us-ascii?Q?Lw5Y9TlbrPAgC2iDutFTIGepnwc60xYAXCbbwwjq3IRoXA9nsPIDft1P/BbR?=
 =?us-ascii?Q?p3JwX6x1HK6yUvtL2lp1tnhSpjE/czAfr6QbWaC8dLI7OPeDogcpctxKDpiT?=
 =?us-ascii?Q?J+KZq1m7MIMAtv4jiBLrfGwZapfFzy/i2bCofuyh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5906c5-b39e-42bc-bb0b-08dc91c73bdd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:27.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ3TtO8jEDxwg3bNnn3GNNkSBRa413zGIBOaB97342qUKzly0odjum5WHIcUivw05IJ21AJa1EVT6AVa4ZZfWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/decl.h | 299 ++++++++++++++++++++++++
 1 file changed, 299 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/decl.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/decl.h b/drivers/net/wireless/nxp/nxpwifi/decl.h
new file mode 100644
index 000000000000..1d4dee4a5f48
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/decl.h
@@ -0,0 +1,299 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: generic data structures and APIs
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_DECL_H_
+#define _NXPWIFI_DECL_H_
+
+#undef pr_fmt
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/wait.h>
+#include <linux/timer.h>
+#include <linux/ieee80211.h>
+#include <uapi/linux/if_arp.h>
+#include <net/cfg80211.h>
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
+struct ieee_types_wmm_ac_parameters {
+	u8 aci_aifsn_bitmap;
+	u8 ecw_bitmap;
+	__le16 tx_op_limit;
+} __packed;
+
+struct nxpwifi_types_wmm_info {
+	u8 oui[4];
+	u8 subtype;
+	u8 version;
+	u8 qos_info;
+	u8 reserved;
+	struct ieee_types_wmm_ac_parameters ac_params[IEEE80211_NUM_ACS];
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
+#endif /* !_NXPWIFI_DECL_H_ */
-- 
2.34.1


