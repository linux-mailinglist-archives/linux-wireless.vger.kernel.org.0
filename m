Return-Path: <linux-wireless+bounces-11184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E3B94CD92
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D55282694
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6DE1922DF;
	Fri,  9 Aug 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IERCpAIE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0281922DC;
	Fri,  9 Aug 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196781; cv=fail; b=CQfSnJC4qjwb5G/b8TvEvw+5vId4W7H6/kRxD+EV9vSK84hGTKW6Kcn2fh8BQsyjKIoVznGydDpVXDAMEuLlP1oB5MexjQ1NQBIhHFiFN6/i1678vAwxf195gSWXYziYrXfno7xwcPGIi+6leVcDF5jtz3lO20NAQvRyz/Qu50g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196781; c=relaxed/simple;
	bh=HmCvO/h8f91FB38TkMqSXKC1ZLseN1Fu2LSi9ffWw30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9ccwiQdtRroQujlX+6kXlTwNbWfrWlUWbAUpB94288na0AfIlsDZqNMWkleo/eqaC4jnX7AHOjreVJyaz4pG2EHtXK6LPeVt+fs140h3mQfSv2ycXRmetZPrqui/SjV6mdp1e/cF4bXnBp6kSPT02OeeoFN/IABIXH/tWfyZJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IERCpAIE; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKNyefCRETeGx9A1Ss/OTQT0B+L9MZuGuBMCyjzhjvF42jIioD9G7zIEoIbcLkzO90k/VJB6Ie43e7gDd22TqEwM+qALSuudNdyhPSNsZ5Ra1QgVCJsCRSeXyKBL2icQLfmKGZ8cexUeK9xkCF0DLvWq0R30EHzJsBe/sn04fesifD8K+MELpLD2FS4kdMRpvAGQmx7SotgzbJJpqrP0W75ciiU6ed3uAPokK/M+bxVMIX3OSeoq9UZ4pXU11HME/HIqynqkk61DcaJeIlInpn2uPWI4u50EUTBTpowTx6Iwu8Lp9tLjVjDzi5HvShshIBJI3W6EFDD6cSyJ6uUEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnoqNv9SsjBuB8ksFnZAg7FWy8hlM2Jgzz2zuFH81bM=;
 b=k422csFsSjuwiA5NX371907ybXT1BnNgJWvuvhJtYm09cVtKKGErdrC4yYWf7L/bCS6BMQKdbofpoRuX5FfhVHp0Hu/JINuXGcoNISlVw8/2LjxBxCYWYx2l75FP4ukhsNX1TifH53z+R/ObHd7tl0LlKvOdf/7MALvxv1J4Yehek2uaKQlZ0NGvJWhyaz7u/1WLdd4ZyEo6k2ubqMhtaWHU3HHdk2d13b4FgR6leJw6an1rL9leTNOlf+MBFpJVQxscUqAxQ9YJv51TOv3J/Q8nJXw7K1hOfrU1RI69u3hWwL1L5RrWBjL/rKhd+lOFY1+glkO9OkqmDIXY1/L3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnoqNv9SsjBuB8ksFnZAg7FWy8hlM2Jgzz2zuFH81bM=;
 b=IERCpAIEIDqhS1FybAp8ageh1udhdGidN+vPmK6qnYS7EJP6NYiedYXovVlSQ+ljNS1ZEWn5So4tTRWypclW113rQO6/ViGHNBCcBASY1mo6u6VrWT51xfEq7oXB6DQUpG0PC/04SkwwfZW4XPBz8LOYQBEoErV0xf5o9GHSGy+uXYl2YMUyn7pL4I/fa+mT0JcHmGxoVSHKjG7kieti0BeAhYlovVaZo3r43HVg3n7GiceI12Kmd7bnE37l4vgHmGvJary9b4SU8Zcoc7HHTSurUr3QlpFySY4SHNnGbbhoILIRBfpul/hWg+fJ3ONrQ1iMhEVPlFmRluy4LCMY1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:14 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:14 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 07/43] wifi: nxpwifi: add 11n.h
Date: Fri,  9 Aug 2024 17:44:57 +0800
Message-Id: <20240809094533.1660-8-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90bb5ae2-1267-46e4-bfd2-08dcb8581bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lI1pzkn3f9HQs6DQwlhtSsZqMVwp8h9birE4g4mvi+whTYbEfXoqSH2ajCdN?=
 =?us-ascii?Q?63KUg3W0ItlmprKDeyV010l9s6B3wV46SOBxWwj1ogLpafEYJ7lAC3mPApNy?=
 =?us-ascii?Q?jjUyoUOuPnelPSFvDDo0bCskuWHrjkZICjOql5uWMNw+4NTMc5el2C+qmR8+?=
 =?us-ascii?Q?G5nhiEAnYuW/Z8AvsqfVi3o/bQ2wnYZkCVOWELlgQ78Us0xBMioavC2apGqx?=
 =?us-ascii?Q?L5f6lZpwNpxZeM5WcVseXLrxFtcWh7IXYiwIpyMnFnjNjYQ7ut/nS25IvmVh?=
 =?us-ascii?Q?9sTC+Jg3qjOI9/6Zf+vTd3/WaAcrMuRbuFoguEqDDELdclmNQ3RHr7CInIP3?=
 =?us-ascii?Q?gMXaINtWUgwOb25/LvVTy99S4k/it7vyooFf9czcYOdgcpOfcr/GngrpyYch?=
 =?us-ascii?Q?cosAWk6WF9IWV08USW7h+KMcyUm/idFWfXNTQtNjRwum+GlNzKDQ2/n4BiZ6?=
 =?us-ascii?Q?QbZ1Yv2+VYSWj9pwD5UcHaBcmOjEzDyOGEfE24qacoTX3f2JeWohYV9XBtWl?=
 =?us-ascii?Q?yimwJge1S3ivfqWjzzPtOhxrzshKz/5NA+RMNsEmzVvhDC+FleTB/flodCr4?=
 =?us-ascii?Q?QxdmK7z9hvRZp4iqY8VHDbGIcGxBPgURWp73k8Yi+EYW9igubWvkVNScOqDL?=
 =?us-ascii?Q?DqT/pFY4bdt+tja/jQCDwf9V6mYr2uWi6jueOXmAOtW+sac4aR+5QkiB0SEf?=
 =?us-ascii?Q?VdA5hVGbb501IZ9BjGVgEOsjnoDf435jA4cRCfVX/dkCqDBXJGbZ/jV2PS8C?=
 =?us-ascii?Q?g/7OvHJlhEAarFx7rfUPZgfmD8eYKI8AUNvG9LwRTPaZbiG7CThDk7ssjsuo?=
 =?us-ascii?Q?rMgsTopNYmxYwazJASTEf67HIwppHEapICDcM4SJedm8t96kKGtkHopftI7u?=
 =?us-ascii?Q?p9Cs5H/ZheaB3RtjZHUwZAUtyYhECiQbZvmYGSdWNeYhAGZRX274T1uCRcZF?=
 =?us-ascii?Q?Db8GpFnu4ZfvewwxeBjw7Y+Xi9NRMmOVq8dpuqW/pQuhjwVWfRBqgjzgKGka?=
 =?us-ascii?Q?XGFefsrSxOLV9jbk0bSraiPrHb58bQsEHVrC0AQVUKabraGteHjjomU4iCBc?=
 =?us-ascii?Q?k3zpNbKn2Y7fZKBYpTWTJ2rYcDcmrh6jQN1Y4350QyhWvFVQiaSQzIcigp7N?=
 =?us-ascii?Q?uzv2XNZueY+yVBKqRDR9tp94CiXs8RwNNkqYce9UxDTbK+r8ACw/m4oxFkcu?=
 =?us-ascii?Q?kYqAzzKKBIJjK8UNYJzcJaHZJNIrObP0CRbif6cni0YH3PARo35V2BGFOqyJ?=
 =?us-ascii?Q?2kf3K24PMcRDmW3JWDaw/kfJp/XttgqEBHNxsN+g4dTFenqWpIX/GWs6dbi2?=
 =?us-ascii?Q?65mF0TnHeckYbIh0IiTf7y+uyYyiS/1LSLjNUn+hDvAyxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YCMXDcHdJWqv+eXzs8u4b45wGnQmWIDafjWQ6fIi0eu7mLQciHWKqUzFojUW?=
 =?us-ascii?Q?pJbj+HpyKidCuP3qlH7gS2uW3dY1VIY7qXiG2uvbDN3U+iHfUiQGXH11ardb?=
 =?us-ascii?Q?katUiIZaP6orWYvAB1ncpaC73BCdp6eT/sm9v7QCo6DNLWrKkphrE4KzBLOq?=
 =?us-ascii?Q?THrIcvH+Kb8Xn7m1SjfSTy6AtMlt+PuueEXRGuPa5TTzaTHeLLGqnEinxXRM?=
 =?us-ascii?Q?rkkkj1sXXTZc0S3KfypQJq1uIqItb6iFE8OEMmYrhnZwJISu7JQo64V7dC9e?=
 =?us-ascii?Q?7Aj0Swtz+okUibVn3Kj/etlTApmGPuc33o4+DlwZ/9LVTRkaPGJvK1W2XmRM?=
 =?us-ascii?Q?6O3X3Wo0GUYjRxmMWagy1xS8lMXMg5LFcPvOcdHyYbdsOu+HFIpB6XhCrr4w?=
 =?us-ascii?Q?gYuRva6iYiarEHxUtmlMuIhF7Vckhe8ZK+uK036MAtBbkh93Yc9VAxQcCFKd?=
 =?us-ascii?Q?PrthjWnqt0bQ0/hX18Nkb9iWB4/D7FI7ZwAFDX4k+55MUkBWnkuwEIvwoMDr?=
 =?us-ascii?Q?m774kC/NZkouefImMnQyg3vVsEZ0W9rxdkW8FMsvuLV8xcjSY6KWY8ugRo/Q?=
 =?us-ascii?Q?mHA6bQBIaWm08JB1iqqCRTtkxNyWLwAmLNrOJCm8T0I40djxszMq/7GWToAB?=
 =?us-ascii?Q?A4LkpbWOKWTV3A+nN4LSNKXNIWMrlXhAZPWufj//kkpXKpqwACxtx5SGcwga?=
 =?us-ascii?Q?6Q2hFugkLZ/YylU7QA0L3Oiz+EJxda4T25LAeE6BTmEcjiIx+cfUIQ1OJqCi?=
 =?us-ascii?Q?fcsnBpCkO5s+3ioQPR8/bQgmgKM7YJJ7zNrSXlg11351x6I/K3dxv3E/z1fR?=
 =?us-ascii?Q?LJC7TcPUN+Jji05E+dk7Zmn+z3DQDvgw3gIVhnP5WTPoLqoDOwhC/YjxhpS3?=
 =?us-ascii?Q?BurqluAFAQ7SFuS+FeW3bBaK4f1jFqswtNe4rw7ALyGOm4f/DCvBJ1VcE9wA?=
 =?us-ascii?Q?lof4HVf4z5eRwLi3n/qnZjV0lebZsahldNLzE0fz6uCkjDXQ2P4OqbqMbzW9?=
 =?us-ascii?Q?+9TXdDdkJO7SA90BEsbfIwaTX0CXWCKyfCy2jl/bo3rTgp5x0L4NS854hwqO?=
 =?us-ascii?Q?veGgl0NGK6CRpGHFoXXVYYVEe6lonFt/OnHXhU7xR94ksgJpGRWWfzakUOs7?=
 =?us-ascii?Q?0ntpiFbj3FCXxmw3ephOd3HyUvfilnto/7VSDFGj9YvGtOf9QTYaoB1kQEiW?=
 =?us-ascii?Q?KXOfd8b+XxPvuW7jmwP7hIXFKmRayIUJ9DeBsNuCAapK2f/RfjimWflgxz+0?=
 =?us-ascii?Q?C66X41LnmcCC6HiUgrRU88X8Qg73Da/AYKzf0dVurFE1H5/fz3KbmKlsI6pw?=
 =?us-ascii?Q?56eDu5EU6wPOXjdvDk7850iCP1xrnUHOc3J0LjygCtzogoh3oCiHFNYoroBC?=
 =?us-ascii?Q?W1AKSJJrzgh+i9yHjLyuwFEXpgGnZKynI3MO77jQ1tDdZ1rwYGTAl6OqSCHY?=
 =?us-ascii?Q?082jDYNuPzrGUm9VYqCR9N5I3gDAfNJ5YB2L/fsm+jC846nhjtb4d8Ad7Stx?=
 =?us-ascii?Q?lv/fim/Tg9+RhIA3moxJ7+nQxz/QsKmSc9w+fyxYD3SOofnAll745rSmHxiX?=
 =?us-ascii?Q?8jFxhi3bTUi8DHf4sJgPU8sx0SuZTXx2qEaZ+ok+Jnu8KjuwJbuzpXoKz9IW?=
 =?us-ascii?Q?a6rJE2e4lhLsdagqFhhUhDMY/6kZIpcb4a2pryIy5Iv/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bb5ae2-1267-46e4-bfd2-08dcb8581bac
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:14.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZzDcDq+//xsCa/xNSsj1N8XJmVdPBWbOkc0igpcQDVxqPFIZxJjHemv9A5qlE6v46jdatHLuILaSmyL0ltIqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

---
 drivers/net/wireless/nxp/nxpwifi/11n.h | 163 +++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n.h b/drivers/net/wireless/nxp/nxpwifi/11n.h
new file mode 100644
index 000000000000..9d983aea3a39
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_H_
+#define _NXPWIFI_11N_H_
+
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+#include "wmm.h"
+
+int nxpwifi_ret_11n_delba(struct nxpwifi_private *priv,
+			  struct host_cmd_ds_command *resp);
+int nxpwifi_ret_11n_addba_req(struct nxpwifi_private *priv,
+			      struct host_cmd_ds_command *resp);
+int nxpwifi_cmd_11n_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_ds_11n_tx_cfg *txcfg);
+int nxpwifi_cmd_append_11n_tlv(struct nxpwifi_private *priv,
+			       struct nxpwifi_bssdescriptor *bss_desc,
+			       u8 **buffer);
+int nxpwifi_fill_cap_info(struct nxpwifi_private *priv, u8 radio_type,
+			  struct ieee80211_ht_cap *ht_cap);
+int nxpwifi_set_get_11n_htcap_cfg(struct nxpwifi_private *priv,
+				  u16 action, int *htcap_cfg);
+void nxpwifi_11n_delete_tx_ba_stream_tbl_entry(struct nxpwifi_private *priv,
+					       struct nxpwifi_tx_ba_stream_tbl
+					       *tx_tbl);
+void nxpwifi_11n_delete_all_tx_ba_stream_tbl(struct nxpwifi_private *priv);
+struct nxpwifi_tx_ba_stream_tbl *nxpwifi_get_ba_tbl(struct nxpwifi_private
+						    *priv, int tid, u8 *ra);
+void nxpwifi_create_ba_tbl(struct nxpwifi_private *priv, u8 *ra, int tid,
+			   enum nxpwifi_ba_status ba_status);
+int nxpwifi_send_addba(struct nxpwifi_private *priv, int tid, u8 *peer_mac);
+int nxpwifi_send_delba(struct nxpwifi_private *priv, int tid, u8 *peer_mac,
+		       int initiator);
+void nxpwifi_11n_delete_ba_stream(struct nxpwifi_private *priv, u8 *del_ba);
+int nxpwifi_get_rx_reorder_tbl(struct nxpwifi_private *priv,
+			       struct nxpwifi_ds_rx_reorder_tbl *buf);
+int nxpwifi_get_tx_ba_stream_tbl(struct nxpwifi_private *priv,
+				 struct nxpwifi_ds_tx_ba_stream_tbl *buf);
+int nxpwifi_cmd_recfg_tx_buf(struct nxpwifi_private *priv,
+			     struct host_cmd_ds_command *cmd,
+			     int cmd_action, u16 *buf_size);
+int nxpwifi_cmd_amsdu_aggr_ctrl(struct host_cmd_ds_command *cmd,
+				int cmd_action,
+				struct nxpwifi_ds_11n_amsdu_aggr_ctrl *aa_ctrl);
+void nxpwifi_del_tx_ba_stream_tbl_by_ra(struct nxpwifi_private *priv, u8 *ra);
+u8 nxpwifi_get_sec_chan_offset(int chan);
+
+static inline u8
+nxpwifi_is_station_ampdu_allowed(struct nxpwifi_private *priv,
+				 struct nxpwifi_ra_list_tbl *ptr, int tid)
+{
+	struct nxpwifi_sta_node *node = nxpwifi_get_sta_entry(priv, ptr->ra);
+
+	if (unlikely(!node))
+		return false;
+
+	return (node->ampdu_sta[tid] != BA_STREAM_NOT_ALLOWED) ? true : false;
+}
+
+/* This function checks whether AMPDU is allowed or not for a particular TID. */
+static inline u8
+nxpwifi_is_ampdu_allowed(struct nxpwifi_private *priv,
+			 struct nxpwifi_ra_list_tbl *ptr, int tid)
+{
+	u8 ret;
+
+	if (is_broadcast_ether_addr(ptr->ra))
+		return false;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP)
+		ret = nxpwifi_is_station_ampdu_allowed(priv, ptr, tid);
+	else
+		ret = (priv->aggr_prio_tbl[tid].ampdu_ap !=
+		       BA_STREAM_NOT_ALLOWED) ? true : false;
+
+	return ret;
+}
+
+/* This function checks whether AMSDU is allowed or not for a particular TID.
+ */
+static inline u8
+nxpwifi_is_amsdu_allowed(struct nxpwifi_private *priv, int tid)
+{
+	return (((priv->aggr_prio_tbl[tid].amsdu != BA_STREAM_NOT_ALLOWED) &&
+		 (priv->is_data_rate_auto || !(priv->bitmap_rates[2] & 0x03)))
+		? true : false);
+}
+
+/* This function checks whether a space is available for new BA stream or not.
+ */
+static inline u8
+nxpwifi_space_avail_for_new_ba_stream(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	u8 i;
+	size_t ba_stream_num = 0, ba_stream_max;
+
+	ba_stream_max = NXPWIFI_MAX_TX_BASTREAM_SUPPORTED;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		if (priv)
+			ba_stream_num +=
+				list_count_nodes(&priv->tx_ba_stream_tbl_ptr);
+	}
+
+	if (adapter->fw_api_ver == NXPWIFI_FW_V15) {
+		ba_stream_max =
+			       GETSUPP_TXBASTREAMS(adapter->hw_dot_11n_dev_cap);
+		if (!ba_stream_max)
+			ba_stream_max = NXPWIFI_MAX_TX_BASTREAM_SUPPORTED;
+	}
+
+	return ((ba_stream_num < ba_stream_max) ? true : false);
+}
+
+/* This function finds the correct Tx BA stream to delete.
+ *
+ * Upon successfully locating, both the TID and the RA are returned.
+ */
+static inline u8
+nxpwifi_find_stream_to_delete(struct nxpwifi_private *priv, int ptr_tid,
+			      int *ptid, u8 *ra)
+{
+	int tid;
+	u8 ret = false;
+	struct nxpwifi_tx_ba_stream_tbl *tx_tbl;
+
+	tid = priv->aggr_prio_tbl[ptr_tid].ampdu_user;
+
+	spin_lock_bh(&priv->tx_ba_stream_tbl_lock);
+	list_for_each_entry(tx_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
+		if (tid > priv->aggr_prio_tbl[tx_tbl->tid].ampdu_user) {
+			tid = priv->aggr_prio_tbl[tx_tbl->tid].ampdu_user;
+			*ptid = tx_tbl->tid;
+			memcpy(ra, tx_tbl->ra, ETH_ALEN);
+			ret = true;
+		}
+	}
+	spin_unlock_bh(&priv->tx_ba_stream_tbl_lock);
+
+	return ret;
+}
+
+/* This function checks whether associated station is 11n enabled
+ */
+static inline int nxpwifi_is_sta_11n_enabled(struct nxpwifi_private *priv,
+					     struct nxpwifi_sta_node *node)
+{
+	if (!node || (priv->bss_role == NXPWIFI_BSS_ROLE_UAP &&
+		      !priv->ap_11n_enabled))
+		return 0;
+
+	return node->is_11n_enabled;
+}
+
+#endif /* !_NXPWIFI_11N_H_ */
-- 
2.34.1


