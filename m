Return-Path: <linux-wireless+bounces-9383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59F911D8E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5321C210B1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7164F17167A;
	Fri, 21 Jun 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cHROco4E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2068.outbound.protection.outlook.com [40.107.7.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21033171677;
	Fri, 21 Jun 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956427; cv=fail; b=bp2ZHv2cXALa2L0ma2MQ5UwW+vE/9iFJhOPHhhedzDcyRrrOhqciLAboByeSrnLbQSOVkYSUqmYomp7ohO9bhCfGiDmWQ3K6Gl2GqMWDbo8XU4RfqyZmeRh7LPraMQSIHSWkOVpdvxxzD8Vx25YnLVcRHxw8PX6t/bSQTWUoYDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956427; c=relaxed/simple;
	bh=rCz00Uli2faMqJJSU5LHpor3/j9sZt6gkTHezCzSQnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q3xZci/vWrEohxSDjy7pPYhOI0QspF/HZfs+o+LEYmxNm/thHfYW+1hihWVNIPkNHsXgUDmRx5dAK//lfA1F/0HvqCEA3YiRIT2VYYktz97r9iFg0nxMInGegyLXzFwy54/Oy2e2j5YzqJWsRwVKL60nobYDOrC4B8v82e+cXvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cHROco4E; arc=fail smtp.client-ip=40.107.7.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw/neFAc2Yz3C8GpD8Aml3WHZG0zpbL2AN79KIkpPQcucAtyDHf4XJKO4K+0seR0hXeVZzKnJmG2AEbmNdUB4kR+/yt7kdqwNjhn5F+iDMIDxTdNfwrW6kAwk5RBxEkFyD4cPJkyTD+Z9MlJc9S/jYAQUEqkavjvYUHGqfRCAn9EwUiYUR2PfDT7/a9FDi4I9QE33pKg78fWNfX9MiHW8ohF0Cx6sI4HE2h8KbBs81l7ZgXUuzqqNYV1Aza6Y3cemvKCADaRM/VvFjaH7MO/ZyhZsPrSXSVPbYp/NNOTJw0h4qVhmQwwAA3djxcxqFAfpgv/wDB3THJcTPWCMxjNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsuiSCNjDFYiyxR8M0UNu87k8nejJMNOt35czm6Qd7I=;
 b=QS3Awpgh2IagWRyIC1u+x6VOaSDRrDxGKyV1z7bBWhTe3a4YQvNeQ4nD4sM9ITAGXcjDsSyEdRTEZVHqxIdovhIcjXxWMmNkGub7LY7MsbG08RqFADUFaztJVWZDiCJReJbsIAF7E0vXNN8zZ78LTltsYPn+2ZGxmp73vRa30F4vsXcbci88ewpLtqNXiB0eLTYE8bf3gZu7foRzetQIkQ72E8O6DfwwpqZLXD9S5u49O/l6p4sQqkLHK2HnTNvkFZ3vgbWfTecdbxr4+gSe7fMZfmAPgst6kgvpilCYHRtswRQHO7m+8YvGCu5R5O0BX2Iod9Ptv8I1ZMRWmkw5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsuiSCNjDFYiyxR8M0UNu87k8nejJMNOt35czm6Qd7I=;
 b=cHROco4EYNm8GYSFN4oTqUZJqoO9rpoigA/D3I/k+H1vcHJEgYroZb8AyLAtH4LuimVZCOvp5KBrW4LiCBq6FpSPvN4lc+g1W3MjAstA/bNAg2nto+eZFL2ON2ACeW/O1uL5Z0ejEJYYNp+XcURnwd8ZMSLF4fTyZMonzml3XTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:53:39 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:39 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 19/43] wifi: nxpwifi: add ie.c
Date: Fri, 21 Jun 2024 15:51:44 +0800
Message-Id: <20240621075208.513497-20-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6da158f1-980d-493d-7080-08dc91c742e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eNubAaywsZgqaXSL7uOdHATyB1Kp26yh4npUBzBhuPQj0xcMDYdawE7/k5mq?=
 =?us-ascii?Q?YfrEFHHKjrofccalh0JIlkYVLIXyDmGoAjFK9rdS/Xh4XTWFy+zyk+UqQptl?=
 =?us-ascii?Q?liSZ4H4u/1MkV++sUaS38rYXMMAJeu1d/FCxJCb9tZ02iVpkKxf3/OGUAEQb?=
 =?us-ascii?Q?t25MxsxJ4M0Iuyrg7FF1lnCOPy7ECxmTNCJ185XibtDART4AYctJV51YkA1z?=
 =?us-ascii?Q?bY1Grdi7dS1DGz9ktBmBHT2AENdnBdwmWXF/Q1p3lp79AUOfyidCBTquhnq7?=
 =?us-ascii?Q?d7dT1xVYSdW6eJdK33W+GTK7lBYKbOmqKLgrMwi/I/x0OmgmAA/ysfwvJTYR?=
 =?us-ascii?Q?kdMSQD20eeUI4KCbvs6rCUty/nYwl/lz/wLXc2ZiiW/LcdC+j9aOyIqWKpsL?=
 =?us-ascii?Q?tX95jsXRnPhkbvZd8sI9fZxd+yQ2316KJas+A+7+SW8Nzy4HvnoVVbSKNWHG?=
 =?us-ascii?Q?tfumYHFXqp8CGs/D9tlhjteFiWuNlrNcXeuKP6TfwlFbremTDtlyWZ84NIBQ?=
 =?us-ascii?Q?bCecjajw38eEZ91+SjLvcIHIYMLO1NAVNM9Fcj8WCQOSfE3c9OtuVX2NPFJ/?=
 =?us-ascii?Q?+5w3+IGuGR4v19yPZvMwvTSFFZQhQK4UKEdIPNob/Ndb1/FlcrV0kPfy3J4w?=
 =?us-ascii?Q?BIn4TEYsC2cA200KUeBC0igqHocy5LYwEd04wZyCv62YmBamdvo5Fl1eL+VN?=
 =?us-ascii?Q?2HHx3XOnyhDQZ54ItqEw7LOl3y0pD5g5rAfYj1vIDXHBmYnuN/eSjrkb87fz?=
 =?us-ascii?Q?uowED9538LTJdHErlQWx1M9ynOLErFTriJO53roqrnIIVPE2aAfFKqZIcLh3?=
 =?us-ascii?Q?6vva2C2oyFFQQTkxLg75Vo/RojMCMUhAMHn31njEnLu/4H3h80o9ZHjnlpnS?=
 =?us-ascii?Q?nu5DdEoCdLRYAIVdMamnLCFAGaFN7CZq4V7haWLqIphCUpRGhgBm59/hGcpG?=
 =?us-ascii?Q?9NY8SL3M98OrDLV6F92eIs4lwkNTEot2ydLVS2JoGtYXbegS+xnA/UHkW/PA?=
 =?us-ascii?Q?hIbr/6XwkbvREeALiWJVnI1m3AhbG2qDjetXfq6YyXrf53TEb/2PhnzpOJhp?=
 =?us-ascii?Q?1AYvZtB7lmlZwWSg9WfiYqrS53M/+PmA4hbhbGwA84K/L1BhOYwjpsREmyQD?=
 =?us-ascii?Q?OUZq52rOY4KhKyRmU7zuw0I3LSIxU0sotignCMN0KZeDOtX2s4oB+llDEo/+?=
 =?us-ascii?Q?vCubCH4qMx3SuKK6G7PtzxIkWXtu46o/4AhswTvnKU3uDbR/0v8Cm2ZDk/5k?=
 =?us-ascii?Q?LIzppjBE4kDNmrdMOpo43m3BEcVTnXdYIHrDzFKV4VOn5z8flynTwriMFgdI?=
 =?us-ascii?Q?5VTaT85aX+yk8cbj+qooP5LF+JaHTgVYqNYzGIoDorzo6SHNj3NHmQ1mDBNV?=
 =?us-ascii?Q?Kjos91I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGitULrlmTWl6oL4MoZpHLQbslpC+ovLXTmvCd1BZPQ7jB4Ns0i17tdJK8uB?=
 =?us-ascii?Q?QDo33XlZqsJJlRF9qD04JptTd4zpaEbx5yhMh5Y9Eem0N77gtiKgnrYfSSap?=
 =?us-ascii?Q?py9/vwZ+kUOKYprxOcRMiGaFOEprQZe9PR7gq8E/dKUXenS3b8RGsq2sMb5U?=
 =?us-ascii?Q?AI2dUUwmE2GKW+WpN7XNlALoFVoS8BGG2DPPAcpYueohB4Ab4tj/JPMm/Um7?=
 =?us-ascii?Q?25kNyeFEgKvpVoUqfqimcsPgtgtj1HQWQjBgl8H7/Zycst/Tpu8ibZ/Mz8cT?=
 =?us-ascii?Q?EoENC9xuRrJek4S4O0KaqyOTuJDtykM1fB6/+v86hCKR3/7iSSn6Hc2vXZuC?=
 =?us-ascii?Q?HeV4gqExAFRAxQk0MVxF8u4e1UxxTlDv1CYZK9G3FnZL0hRQCMoJOWZsN7VY?=
 =?us-ascii?Q?7yANLixYkRZLmV1C39if1XDrWxOpZg2nCtf7kTAKglg5yqc6XA3iQfdSNiVj?=
 =?us-ascii?Q?jzJtN8yPIflc3Z0XvgMVdQZlXyN0uZn5GmQxG5NsFK7hsyPTpAmgNXL5wnDV?=
 =?us-ascii?Q?lBk9OdvSayStHWl3Y7a0tN2LI9HVjtLjhp4AGttx+UYs/ClB8Ptb/7+BjgD+?=
 =?us-ascii?Q?B1ieMumyehwJ6ygi5iYtvRV38SYKhMLlb0rfKieg2f8BhwtFGeO5hV4wlRIw?=
 =?us-ascii?Q?HPDQYLRFOz0zTB29JEcKi1nl8nkmE1N+QbrWPLmNxXyg2EcOWIyYihuJ/ipJ?=
 =?us-ascii?Q?MV1KJsR+XgbChFlEk3cKZpTVCBjW8Z5RjdgRbDVxXjFBYur3ygE8r2daN+YT?=
 =?us-ascii?Q?Q/U84lQC2n8n5811+lftmB2NHHaR2U9GgV5q0+GLAq45Vr8ITYtg+6D3Q5oR?=
 =?us-ascii?Q?KZz1d7K9H2jxyUb8HrBVtqIcUs1KTdZiurPUtktV06hZnsRPjmmFw9QZwcTl?=
 =?us-ascii?Q?eZLNHbOgy19YSqK8v9REh7rVZJy0s1KO8gzloexctVZEgvcUVHEog77oAO4z?=
 =?us-ascii?Q?rJyvq7GXrQoL7yJrEQMSVou8gZT8sDrtgj0NRQBvnfjQAetZPRoPcmVvlB3U?=
 =?us-ascii?Q?p1exetBtsUrXlvW4ugcf2XUKT9Kn0/ym/bYTxvesNJMgwiztPsBipT9Qzs0R?=
 =?us-ascii?Q?YG+dyaLfbYX7oQV6QNgI/Crq7os8MBLpBBq03ipKfNiTRSyehCcC8nXOnsJl?=
 =?us-ascii?Q?6Gq4eJJzXlLdM6uFz5412r6kFaQJLe11NhB+n+qaXfqTAS4gsm9FWdgruD+w?=
 =?us-ascii?Q?I3boEuY35FJdF2N9qgMX+++9BHv0MxKyw8Uo2FrJlNwfqD6MXlfvAaTSTvXu?=
 =?us-ascii?Q?uTsUCaQyCXvK9Rrq8Rmaw2tJuMciIKj2ADAgyICoavGMc/oPNulFUxK8OgK+?=
 =?us-ascii?Q?ABODlVd8JmeDRmA73RI8wj4A8Fo2uHO9hUbrloatLWTsqDqzuFV79/GZwqIN?=
 =?us-ascii?Q?I4mkUjIlpAG565ZHtntEq4wKFYyzqylZuMZ35SwXjKuD2vMqAiyBUmMSioYe?=
 =?us-ascii?Q?dvh1bDBUfOqHqEps6TxD85//7SHEKr2Y9WOqO8fSY/NND+VrQIpj0/DrxtkW?=
 =?us-ascii?Q?Mr20ORpdQlLmjgTVQnC1XiZGnu6Xocbhiq2Tqf63+piwdxQ5GR42uvOaWIdh?=
 =?us-ascii?Q?Yd7LXLH1OKKnjupVk/YyQUnG+TCZ/rkqNt/PvoZP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da158f1-980d-493d-7080-08dc91c742e8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:39.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dryi7Wb/QQUjBB7/kaW7l8zmS8vI7J8kF9hjHmzQfr4qZw1GvhSh3ygL2kuSEjurSiHHTccLIjW9tIvTLUs/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/ie.c | 502 ++++++++++++++++++++++++++
 1 file changed, 502 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/ie.c b/drivers/net/wireless/nxp/nxpwifi/ie.c
new file mode 100644
index 000000000000..cfe16e68d068
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ie.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: management IE handling- setting and
+ * deleting IE.
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+
+/* This function checks if current IE index is used by any on other interface.
+ * Return: -1: yes, current IE index is used by someone else.
+ *          0: no, current IE index is NOT used by other interface.
+ */
+static int
+nxpwifi_ie_index_used_by_other_intf(struct nxpwifi_private *priv, u16 idx)
+{
+	int i;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie *ie;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i] != priv) {
+			ie = &adapter->priv[i]->mgmt_ie[idx];
+			if (ie->mgmt_subtype_mask && ie->ie_length)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+/* Get unused IE index. This index will be used for setting new IE */
+static int
+nxpwifi_ie_get_autoidx(struct nxpwifi_private *priv, u16 subtype_mask,
+		       struct nxpwifi_ie *ie, u16 *index)
+{
+	u16 mask, len, i;
+
+	for (i = 0; i < priv->adapter->max_mgmt_ie_index; i++) {
+		mask = le16_to_cpu(priv->mgmt_ie[i].mgmt_subtype_mask);
+		len = le16_to_cpu(ie->ie_length);
+
+		if (mask == NXPWIFI_AUTO_IDX_MASK)
+			continue;
+
+		if (mask == subtype_mask) {
+			if (len > IEEE_MAX_IE_SIZE)
+				continue;
+
+			*index = i;
+			return 0;
+		}
+
+		if (!priv->mgmt_ie[i].ie_length) {
+			if (nxpwifi_ie_index_used_by_other_intf(priv, i))
+				continue;
+
+			*index = i;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+/* This function prepares IE data buffer for command to be sent to FW */
+static int
+nxpwifi_update_autoindex_ies(struct nxpwifi_private *priv,
+			     struct nxpwifi_ie_list *ie_list)
+{
+	u16 travel_len, index, mask;
+	s16 input_len, tlv_len;
+	struct nxpwifi_ie *ie;
+	u8 *tmp;
+
+	input_len = le16_to_cpu(ie_list->len);
+	travel_len = sizeof(struct nxpwifi_ie_types_header);
+
+	ie_list->len = 0;
+
+	while (input_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		ie = (struct nxpwifi_ie *)(((u8 *)ie_list) + travel_len);
+		tlv_len = le16_to_cpu(ie->ie_length);
+		travel_len += tlv_len + NXPWIFI_IE_HDR_SIZE;
+
+		if (input_len < tlv_len + NXPWIFI_IE_HDR_SIZE)
+			return -1;
+		index = le16_to_cpu(ie->ie_index);
+		mask = le16_to_cpu(ie->mgmt_subtype_mask);
+
+		if (index == NXPWIFI_AUTO_IDX_MASK) {
+			/* automatic addition */
+			if (nxpwifi_ie_get_autoidx(priv, mask, ie, &index))
+				return -1;
+			if (index == NXPWIFI_AUTO_IDX_MASK)
+				return -1;
+
+			tmp = (u8 *)&priv->mgmt_ie[index].ie_buffer;
+			memcpy(tmp, &ie->ie_buffer, le16_to_cpu(ie->ie_length));
+			priv->mgmt_ie[index].ie_length = ie->ie_length;
+			priv->mgmt_ie[index].ie_index = cpu_to_le16(index);
+			priv->mgmt_ie[index].mgmt_subtype_mask =
+							cpu_to_le16(mask);
+
+			ie->ie_index = cpu_to_le16(index);
+		} else {
+			if (mask != NXPWIFI_DELETE_MASK)
+				return -1;
+			/* Check if this index is being used on any
+			 * other interface.
+			 */
+			if (nxpwifi_ie_index_used_by_other_intf(priv, index))
+				return -1;
+
+			ie->ie_length = 0;
+			memcpy(&priv->mgmt_ie[index], ie,
+			       sizeof(struct nxpwifi_ie));
+		}
+
+		le16_unaligned_add_cpu
+		(&ie_list->len,
+		 le16_to_cpu(priv->mgmt_ie[index].ie_length) +
+		 NXPWIFI_IE_HDR_SIZE);
+		input_len -= tlv_len + NXPWIFI_IE_HDR_SIZE;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP)
+		return nxpwifi_send_cmd(priv, HOST_CMD_UAP_SYS_CONFIG,
+					HOST_ACT_GEN_SET,
+					UAP_CUSTOM_IE_I, ie_list, true);
+
+	return 0;
+}
+
+/* Copy individual custom IEs for beacon, probe response and assoc response
+ * and prepare single structure for IE setting.
+ * This function also updates allocated IE indices from driver.
+ */
+static int
+nxpwifi_update_uap_custom_ie(struct nxpwifi_private *priv,
+			     struct nxpwifi_ie *beacon_ie, u16 *beacon_idx,
+			     struct nxpwifi_ie *pr_ie, u16 *probe_idx,
+			     struct nxpwifi_ie *ar_ie, u16 *assoc_idx)
+{
+	struct nxpwifi_ie_list *ap_custom_ie;
+	u8 *pos;
+	u16 len;
+	int ret;
+
+	ap_custom_ie = kzalloc(sizeof(*ap_custom_ie), GFP_KERNEL);
+	if (!ap_custom_ie)
+		return -ENOMEM;
+
+	ap_custom_ie->type = cpu_to_le16(TLV_TYPE_MGMT_IE);
+	pos = (u8 *)ap_custom_ie->ie_list;
+
+	if (beacon_ie) {
+		len = sizeof(struct nxpwifi_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(beacon_ie->ie_length);
+		memcpy(pos, beacon_ie, len);
+		pos += len;
+		le16_unaligned_add_cpu(&ap_custom_ie->len, len);
+	}
+	if (pr_ie) {
+		len = sizeof(struct nxpwifi_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(pr_ie->ie_length);
+		memcpy(pos, pr_ie, len);
+		pos += len;
+		le16_unaligned_add_cpu(&ap_custom_ie->len, len);
+	}
+	if (ar_ie) {
+		len = sizeof(struct nxpwifi_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(ar_ie->ie_length);
+		memcpy(pos, ar_ie, len);
+		pos += len;
+		le16_unaligned_add_cpu(&ap_custom_ie->len, len);
+	}
+
+	ret = nxpwifi_update_autoindex_ies(priv, ap_custom_ie);
+
+	pos = (u8 *)(&ap_custom_ie->ie_list[0].ie_index);
+	if (beacon_ie && *beacon_idx == NXPWIFI_AUTO_IDX_MASK) {
+		/* save beacon ie index after auto-indexing */
+		*beacon_idx = le16_to_cpu(ap_custom_ie->ie_list[0].ie_index);
+		len = sizeof(*beacon_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(beacon_ie->ie_length);
+		pos += len;
+	}
+	if (pr_ie && le16_to_cpu(pr_ie->ie_index) == NXPWIFI_AUTO_IDX_MASK) {
+		/* save probe resp ie index after auto-indexing */
+		*probe_idx = *((u16 *)pos);
+		len = sizeof(*pr_ie) - IEEE_MAX_IE_SIZE +
+		      le16_to_cpu(pr_ie->ie_length);
+		pos += len;
+	}
+	if (ar_ie && le16_to_cpu(ar_ie->ie_index) == NXPWIFI_AUTO_IDX_MASK)
+		/* save assoc resp ie index after auto-indexing */
+		*assoc_idx = *((u16 *)pos);
+
+	kfree(ap_custom_ie);
+	return ret;
+}
+
+/* This function checks if the vendor specified IE is present in passed buffer
+ * and copies it to nxpwifi_ie structure.
+ * Function takes pointer to struct nxpwifi_ie pointer as argument.
+ * If the vendor specified IE is present then memory is allocated for
+ * nxpwifi_ie pointer and filled in with IE. Caller should take care of freeing
+ * this memory.
+ */
+static int nxpwifi_update_vs_ie(const u8 *ies, int ies_len,
+				struct nxpwifi_ie **ie_ptr, u16 mask,
+				unsigned int oui, u8 oui_type)
+{
+	struct ieee_types_header *vs_ie;
+	struct nxpwifi_ie *ie = *ie_ptr;
+	const u8 *vendor_ie;
+
+	vendor_ie = cfg80211_find_vendor_ie(oui, oui_type, ies, ies_len);
+	if (vendor_ie) {
+		if (!*ie_ptr) {
+			*ie_ptr = kzalloc(sizeof(*ie_ptr), GFP_KERNEL);
+			if (!*ie_ptr)
+				return -ENOMEM;
+			ie = *ie_ptr;
+		}
+
+		vs_ie = (struct ieee_types_header *)vendor_ie;
+		if (le16_to_cpu(ie->ie_length) + vs_ie->len + 2 >
+			IEEE_MAX_IE_SIZE)
+			return -EINVAL;
+		memcpy(ie->ie_buffer + le16_to_cpu(ie->ie_length),
+		       vs_ie, vs_ie->len + 2);
+		le16_unaligned_add_cpu(&ie->ie_length, vs_ie->len + 2);
+		ie->mgmt_subtype_mask = cpu_to_le16(mask);
+		ie->ie_index = cpu_to_le16(NXPWIFI_AUTO_IDX_MASK);
+	}
+
+	*ie_ptr = ie;
+	return 0;
+}
+
+/* This function parses beacon IEs, probe response IEs, association response IEs
+ * from cfg80211_ap_settings->beacon and sets these IE to FW.
+ */
+static int nxpwifi_set_mgmt_beacon_data_ies(struct nxpwifi_private *priv,
+					    struct cfg80211_beacon_data *data)
+{
+	struct nxpwifi_ie *beacon_ie = NULL, *pr_ie = NULL, *ar_ie = NULL;
+	u16 beacon_idx = NXPWIFI_AUTO_IDX_MASK, pr_idx = NXPWIFI_AUTO_IDX_MASK;
+	u16 ar_idx = NXPWIFI_AUTO_IDX_MASK;
+	int ret = 0;
+
+	if (data->beacon_ies && data->beacon_ies_len) {
+		nxpwifi_update_vs_ie(data->beacon_ies, data->beacon_ies_len,
+				     &beacon_ie, MGMT_MASK_BEACON,
+				     WLAN_OUI_MICROSOFT,
+				     WLAN_OUI_TYPE_MICROSOFT_WPS);
+		nxpwifi_update_vs_ie(data->beacon_ies, data->beacon_ies_len,
+				     &beacon_ie, MGMT_MASK_BEACON,
+				     WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P);
+	}
+
+	if (data->proberesp_ies && data->proberesp_ies_len) {
+		nxpwifi_update_vs_ie(data->proberesp_ies,
+				     data->proberesp_ies_len, &pr_ie,
+				     MGMT_MASK_PROBE_RESP, WLAN_OUI_MICROSOFT,
+				     WLAN_OUI_TYPE_MICROSOFT_WPS);
+		nxpwifi_update_vs_ie(data->proberesp_ies,
+				     data->proberesp_ies_len, &pr_ie,
+				     MGMT_MASK_PROBE_RESP,
+				     WLAN_OUI_WFA, WLAN_OUI_TYPE_WFA_P2P);
+	}
+
+	if (data->assocresp_ies && data->assocresp_ies_len) {
+		nxpwifi_update_vs_ie(data->assocresp_ies,
+				     data->assocresp_ies_len, &ar_ie,
+				     MGMT_MASK_ASSOC_RESP |
+				     MGMT_MASK_REASSOC_RESP,
+				     WLAN_OUI_MICROSOFT,
+				     WLAN_OUI_TYPE_MICROSOFT_WPS);
+		nxpwifi_update_vs_ie(data->assocresp_ies,
+				     data->assocresp_ies_len, &ar_ie,
+				     MGMT_MASK_ASSOC_RESP |
+				     MGMT_MASK_REASSOC_RESP, WLAN_OUI_WFA,
+				     WLAN_OUI_TYPE_WFA_P2P);
+	}
+
+	if (beacon_ie || pr_ie || ar_ie) {
+		ret = nxpwifi_update_uap_custom_ie(priv, beacon_ie,
+						   &beacon_idx, pr_ie,
+						   &pr_idx, ar_ie, &ar_idx);
+		if (ret)
+			goto done;
+	}
+
+	priv->beacon_idx = beacon_idx;
+	priv->proberesp_idx = pr_idx;
+	priv->assocresp_idx = ar_idx;
+
+done:
+	kfree(beacon_ie);
+	kfree(pr_ie);
+	kfree(ar_ie);
+
+	return ret;
+}
+
+/* This function parses  head and tail IEs, from cfg80211_beacon_data and sets
+ * these IE to FW.
+ */
+static int nxpwifi_uap_parse_tail_ies(struct nxpwifi_private *priv,
+				      struct cfg80211_beacon_data *info)
+{
+	struct nxpwifi_ie *gen_ie;
+	struct ieee_types_header *hdr;
+	struct ieee80211_vendor_ie *vendorhdr;
+	u16 gen_idx = NXPWIFI_AUTO_IDX_MASK, ie_len = 0;
+	int left_len, parsed_len = 0;
+	unsigned int token_len;
+	int err = 0;
+
+	if (!info->tail || !info->tail_len)
+		return 0;
+
+	gen_ie = kzalloc(sizeof(*gen_ie), GFP_KERNEL);
+	if (!gen_ie)
+		return -ENOMEM;
+
+	left_len = info->tail_len;
+
+	/* Many IEs are generated in FW by parsing bss configuration.
+	 * Let's not add them here; else we may end up duplicating these IEs
+	 */
+	while (left_len > sizeof(struct ieee_types_header)) {
+		hdr = (void *)(info->tail + parsed_len);
+		token_len = hdr->len + sizeof(struct ieee_types_header);
+		if (token_len > left_len) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		switch (hdr->element_id) {
+		case WLAN_EID_SSID:
+		case WLAN_EID_SUPP_RATES:
+		case WLAN_EID_COUNTRY:
+		case WLAN_EID_PWR_CONSTRAINT:
+		case WLAN_EID_ERP_INFO:
+		case WLAN_EID_EXT_SUPP_RATES:
+		case WLAN_EID_HT_CAPABILITY:
+		case WLAN_EID_HT_OPERATION:
+		case WLAN_EID_VHT_CAPABILITY:
+		case WLAN_EID_VHT_OPERATION:
+			break;
+		case WLAN_EID_VENDOR_SPECIFIC:
+			/* Skip only Microsoft WMM IE */
+			if (cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+						    WLAN_OUI_TYPE_MICROSOFT_WMM,
+						    (const u8 *)hdr,
+						    token_len))
+				break;
+			fallthrough;
+		default:
+			if (ie_len + token_len > IEEE_MAX_IE_SIZE) {
+				err = -EINVAL;
+				goto out;
+			}
+			memcpy(gen_ie->ie_buffer + ie_len, hdr, token_len);
+			ie_len += token_len;
+			break;
+		}
+		left_len -= token_len;
+		parsed_len += token_len;
+	}
+
+	/* parse only WPA vendor IE from tail, WMM IE is configured by
+	 * bss_config command
+	 */
+	vendorhdr = (void *)cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+						    WLAN_OUI_TYPE_MICROSOFT_WPA,
+						    info->tail, info->tail_len);
+	if (vendorhdr) {
+		token_len = vendorhdr->len + sizeof(struct ieee_types_header);
+		if (ie_len + token_len > IEEE_MAX_IE_SIZE) {
+			err = -EINVAL;
+			goto out;
+		}
+		memcpy(gen_ie->ie_buffer + ie_len, vendorhdr, token_len);
+		ie_len += token_len;
+	}
+
+	if (!ie_len)
+		goto out;
+
+	gen_ie->ie_index = cpu_to_le16(gen_idx);
+	gen_ie->mgmt_subtype_mask = cpu_to_le16(MGMT_MASK_BEACON |
+						MGMT_MASK_PROBE_RESP |
+						MGMT_MASK_ASSOC_RESP);
+	gen_ie->ie_length = cpu_to_le16(ie_len);
+
+	if (nxpwifi_update_uap_custom_ie(priv, gen_ie, &gen_idx, NULL, NULL,
+					 NULL, NULL)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	priv->gen_idx = gen_idx;
+
+ out:
+	kfree(gen_ie);
+	return err;
+}
+
+/* This function parses different IEs-head & tail IEs, beacon IEs,
+ * probe response IEs, association response IEs from cfg80211_ap_settings
+ * function and sets these IE to FW.
+ */
+int nxpwifi_set_mgmt_ies(struct nxpwifi_private *priv,
+			 struct cfg80211_beacon_data *info)
+{
+	int ret;
+
+	ret = nxpwifi_uap_parse_tail_ies(priv, info);
+
+	if (ret)
+		return ret;
+
+	return nxpwifi_set_mgmt_beacon_data_ies(priv, info);
+}
+
+/* This function removes management IE set */
+int nxpwifi_del_mgmt_ies(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ie *beacon_ie = NULL, *pr_ie = NULL;
+	struct nxpwifi_ie *ar_ie = NULL, *gen_ie = NULL;
+	int ret = 0;
+
+	if (priv->gen_idx != NXPWIFI_AUTO_IDX_MASK) {
+		gen_ie = kmalloc(sizeof(*gen_ie), GFP_KERNEL);
+		if (!gen_ie)
+			return -ENOMEM;
+
+		gen_ie->ie_index = cpu_to_le16(priv->gen_idx);
+		gen_ie->mgmt_subtype_mask = cpu_to_le16(NXPWIFI_DELETE_MASK);
+		gen_ie->ie_length = 0;
+		if (nxpwifi_update_uap_custom_ie(priv, gen_ie, &priv->gen_idx,
+						 NULL, &priv->proberesp_idx,
+						 NULL, &priv->assocresp_idx)) {
+			ret = -1;
+			goto done;
+		}
+
+		priv->gen_idx = NXPWIFI_AUTO_IDX_MASK;
+	}
+
+	if (priv->beacon_idx != NXPWIFI_AUTO_IDX_MASK) {
+		beacon_ie = kmalloc(sizeof(*beacon_ie), GFP_KERNEL);
+		if (!beacon_ie) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		beacon_ie->ie_index = cpu_to_le16(priv->beacon_idx);
+		beacon_ie->mgmt_subtype_mask = cpu_to_le16(NXPWIFI_DELETE_MASK);
+		beacon_ie->ie_length = 0;
+	}
+	if (priv->proberesp_idx != NXPWIFI_AUTO_IDX_MASK) {
+		pr_ie = kmalloc(sizeof(*pr_ie), GFP_KERNEL);
+		if (!pr_ie) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		pr_ie->ie_index = cpu_to_le16(priv->proberesp_idx);
+		pr_ie->mgmt_subtype_mask = cpu_to_le16(NXPWIFI_DELETE_MASK);
+		pr_ie->ie_length = 0;
+	}
+	if (priv->assocresp_idx != NXPWIFI_AUTO_IDX_MASK) {
+		ar_ie = kmalloc(sizeof(*ar_ie), GFP_KERNEL);
+		if (!ar_ie) {
+			ret = -ENOMEM;
+			goto done;
+		}
+		ar_ie->ie_index = cpu_to_le16(priv->assocresp_idx);
+		ar_ie->mgmt_subtype_mask = cpu_to_le16(NXPWIFI_DELETE_MASK);
+		ar_ie->ie_length = 0;
+	}
+
+	if (beacon_ie || pr_ie || ar_ie)
+		ret = nxpwifi_update_uap_custom_ie(priv,
+						   beacon_ie, &priv->beacon_idx,
+						   pr_ie, &priv->proberesp_idx,
+						   ar_ie, &priv->assocresp_idx);
+
+done:
+	kfree(gen_ie);
+	kfree(beacon_ie);
+	kfree(pr_ie);
+	kfree(ar_ie);
+
+	return ret;
+}
-- 
2.34.1


