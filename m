Return-Path: <linux-wireless+bounces-9369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3245911D64
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1842CB21A4E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612516DEDC;
	Fri, 21 Jun 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CPO+hxdK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956516D31E;
	Fri, 21 Jun 2024 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956373; cv=fail; b=X68jBBQoA/EWPU6FGWcZYUs+g8/ST1L0cX3L5Z8pHkax59+prPSgM+6tjRz2ojD+CRHXWIMFfJagidRAnvbV9mrp2UIuwvKzxcTrJ5gbGXlQiSfrCsOvG2z7csYVIOccEn8hIv9PfgrCniBbQLXswClp2nG9GmtGTZYqgccjVes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956373; c=relaxed/simple;
	bh=+s2RwZ3XGIcjdkAqdrgZINYg9aP/PcbWlRDNiRANEhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqeE+Vj9JgnpPdEPQXXCCg2oyFGnh9v5IbPVzCpYprYabygbUtQOllg21mYR76uu9+FEWgZfPO6TVGcTI58T66t0euYWPWtxn6uvCDbMOIJ+gXm1kIJEupp+bOPw5pwHogXhXI61DlOULs0uEfI+NuLFD390DAQE5UIWeQE3BNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CPO+hxdK; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l88q11UDDjmU3+wZxXdO/22mSwN30bx1umdjgItHpHCQh93ydYYf4awoOdaWhQDn4PXsXLDQ63CmGdx3Sh0Zvn2/yWWUTjjMKf0XiJvHbygUHTsZNXqOXjfXf2homv8BJAN5x1UdCT1CVJZC0MvJ7nfn3TxwoqVSAlY9F4gIbnlQgDme/PC9KDZjxz3CVRvrSD9G8o4fZJbcxj7WoO0IthJ2CEXocE6ED9L7D1GmK0Ue+CaS45h8KxobVkMjE1L8s5M/oHP6tSNklZL4RCp5AXBqFv928uHi83+Y8qSeV6nJBt1AVpPRCsTYU1wqPMh9TcezyW0UwWfF++375NurCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKRQr41pWma60HDhQhSWeHxcJvU7O3Psl5qZsePcfwc=;
 b=e8LC4/24mR5MdFc6j/7pkLhoixAFyz1LwM/iHAi2wfVdX/u3VDvF/IcfDhwTXdVblcVfi9oX9sVPwQfR/yjtk2jHwgrZhiCH5hKG3c2EduNkckcu22GeAuvtyE+AkykLgYz67k6gSRdZG1Dcj2vNAFxUAIHwTCmYMs9XQtaiLTH/bxHu6gSRVeBBLelgSaTur9RonAlF4iwFvDp/AqZSaO8cZTJ6Nx0lBuEX0snMuLsj5kT+xpxAC5ezORFIb21tHdwW4y5eMSVfnkNavn6GofIYziFgNH/Ifk3ELv0jEsigUI35ykgoiMDhTjv42/W258L4Yf2m/1qu67QJwcwzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKRQr41pWma60HDhQhSWeHxcJvU7O3Psl5qZsePcfwc=;
 b=CPO+hxdKk6NAyArdLRxyedDaRB5wiPu2f9SRJbMLDUoS6FlpXxRIGd0AMwvUuMsVI0Ycz8BsYxR0qdSYJW5z7LbebmTlDVU6/gH+FzyeH15Y0GYmgvt5/6AbfxddLnOQxVBs8Nzc6QGrea1XaNNcZw2wtU7CC23vQNiz0gNxV0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:52:48 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:52:48 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 05/43] wifi: nxpwifi: add 11n.h
Date: Fri, 21 Jun 2024 15:51:30 +0800
Message-Id: <20240621075208.513497-6-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 300c1ff5-7799-4392-b512-08dc91c724be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/AiZw0YeAUEFeuQgHla1Folxmi/lyL7YGd3dWLw7ihY1/ITqsEssN+A6+SZ0?=
 =?us-ascii?Q?bZu3IkVSfihuwnutxKksYlnM/4RM6acItmPX6L+v4XQGXv8nXlR3nxjlp8IS?=
 =?us-ascii?Q?2LdHqRkMYnpU75zV3hd2ocPfDcDqbQVFHlqmAOalIy7WTWelFnkLZa8oGj5/?=
 =?us-ascii?Q?G3ZzaZOhmCEv04LCQY0vjUOwKXMOzx2e6JGVA/gtmf3ZxIOzrYHKeacnSt7x?=
 =?us-ascii?Q?283FNq0ONTd5uLtGSq7TxVstsZzs/JjO5oo3t9fy9y5ppwMUYSsEjphra4l0?=
 =?us-ascii?Q?WFul3pRE1HlC3UTGvPfIynP86uG28qsT7Gg8pxCtj8evFXseYAPxR2nWLFSJ?=
 =?us-ascii?Q?pmqkvJ7Psbquro4fSwGPqApD4Dq3N/1JSORdFNJ12SpFI/NblFMP9Y5qSzbn?=
 =?us-ascii?Q?Fx4Yl0asY79Owjn3TTNBAYAMqVvoR9E4ESPyH74/LJIDCih6GMFdiDEpSTJW?=
 =?us-ascii?Q?hARwX1y0GviMHaPLUGLTE0ezxh1PSQKlIDoOpd1qNZolZSQfjpjc7o/KBmeR?=
 =?us-ascii?Q?CyzRek1s6iI6PNnhTGSBabnnH0oL9vdS0N0k1PMD0bZdDbXDM9fOmQI5SNNW?=
 =?us-ascii?Q?BRsxuWJOaKAL1eHGyslOiC1TZRmIsoL31VFXtqbTtWuZm/sldsA+MYitGQgj?=
 =?us-ascii?Q?JzjYfZXM8j9zubBFWTjp9qYdb8kgMuk86PptwPg+gVP1k2RmWFsy7c13OUaG?=
 =?us-ascii?Q?fQjkNjjtiXF/AnTGa7IFgcRmPPfY8GG+Z/DGxxBFobQded6KRdtwa6K2H3km?=
 =?us-ascii?Q?0OQLlFfi61P9n0PcD+WwnaIB27X0a+rNd5IY1mBJq723QEemm4LHLNQuA3Tn?=
 =?us-ascii?Q?J/06AUPQ2xlBSEaaWzWrtB28ijD8U7MH2KoD3NpAVj+yVG8WMVE6zDkCmSor?=
 =?us-ascii?Q?kzqwC2lzmzXD7pG/TUY//WZxXOKRzv0UQm2XgjMtFwJGhlfsiOf34cIUep3g?=
 =?us-ascii?Q?xJF+E35zp2LJe7Ri4q7gTr76QS0/v0LMkuxme9jVnTbxI5Fq/Aept/BHgf5i?=
 =?us-ascii?Q?S5pMjZBPpub1zGBQx5IQRPMc1dWF3EXf6PEQTms1uR3d6Ncey5XryjVWQxb3?=
 =?us-ascii?Q?ZloyTI7V3qv88Oih9xmWW2Bc5LFlL2zz54muPPMSpJCuw5raMqNwEEHlumBl?=
 =?us-ascii?Q?88QkwrQqdJww+JlYNI7AMRikq2mKWOEyT0Pyir3uo1RG5rqBA7lxuBFd0ykd?=
 =?us-ascii?Q?A3OIDIgMQ8zqZjLsdqxc3p7zB2UaAVInvdpLOI4xbiifZTzFN/pXa96ZM4o4?=
 =?us-ascii?Q?+L/9wCslmXrlNScBcnzkbkc3fvWSxUzNf8r5TUyiZuSt6feiu0qMJFP28Xee?=
 =?us-ascii?Q?9nZEDv8r+i7NBx1yvtajHQ/JkMs2P+8kUV6+GXvT08jSw0trZ/xBdpSU/v+/?=
 =?us-ascii?Q?i9WXEVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WP8lrubR2YCiq7Xlk1NMHr6IxNpM/nlv0igeJMOaKnKbcfhryibvxev8iJR+?=
 =?us-ascii?Q?RK1buTLq9yz+gjoe8aVY8LebzybF0xOpnCfhZMbqM6RCeH1epM8UFSUXv++q?=
 =?us-ascii?Q?v7haO4hFFcLRkVqkbZpU1M2UlzhPNiyZOu8gU0n9HMPFyOt2Ro0cl59jBKoB?=
 =?us-ascii?Q?Bl5GPbARioKoSC5H25jKjiX3+WKZW3EdH3+k0Ca6Gv0dgSkOpuyU0UskgRMS?=
 =?us-ascii?Q?JfnHsiwtcqKdS3BKMq6+Z4wSkQKD4O0R911Kvn/Y0QVlUkg2GuxzuvXeura0?=
 =?us-ascii?Q?+SE7KtiKtqGmjp+k0qZUj4STndp34z1Wkl0wNSqZ5zRntAd+lb8BEbdsGUSH?=
 =?us-ascii?Q?9nQT5a4IkLDAYxrUoRPTDL6pXGjBPkSBdSK4/Q45IIwbhPs8rk2oTT3jP4qT?=
 =?us-ascii?Q?VJh1XpZCqXyqZwRI6zKSpnmEUMoaA3XVHBf59IfC9B/9Z8tXiaqWoj/HU8Eq?=
 =?us-ascii?Q?W0KV0CR73zEZ2kvqFyZmkqn5bqtErLykDbySFxZ1/z1vBlBHbcIWqnEENMpX?=
 =?us-ascii?Q?JQ7brTyjGF/M0N42b9XSKzLHmpSm8sydu0Li2jgb9aFs+k7Mcsyp88Ylc44F?=
 =?us-ascii?Q?aLaFtUZhivtK35/nvcVDbuGQ8vmT6wBAvtWmHru3offo46b140PrFJzoH+QO?=
 =?us-ascii?Q?gsOwOKnjXZC5TdZvzG6TQmATuXhS1ycEoEXiDtzNZCbv6U/1lMo4LiyZcvEX?=
 =?us-ascii?Q?gdLKOuWVVcW6CKLPcjjBK8g/Hq3gv+DCGQbiIYNRUqwyLhiahwJ7+yVA2EcW?=
 =?us-ascii?Q?8KJHkgoVRUBeDJBQMA0SPe4VT7TOWwBVpnvMwX+PrgmuELa4ftCb9scYt0n2?=
 =?us-ascii?Q?n5XZXpL6gK6l8+9gp1USIVFznMpAbXo7IBMSyQrlx19DnJ3HSStsMrWrxcJA?=
 =?us-ascii?Q?xEI4F1rBi4FwNRN+QhZkVCifAPhbUkAA8kPSafVX6OT8UWpqD/VDmMN2G0KE?=
 =?us-ascii?Q?7H+LmxQJ8Gt+/3bXdzqsQKMBzj0Iznc89xbyLoUGXMC1wa/1Uy8VxjfE3F6s?=
 =?us-ascii?Q?ynQgmY4Vm6NtIel1CCg/XLncMDCSCzS+CDEq+wPJV57yJVItD3fEdRELEWLd?=
 =?us-ascii?Q?d4is+K87YU91GlKlOcfoD8LETQolWlgRv+Ll0lyftnKIInz2ydU2RU8zs7xZ?=
 =?us-ascii?Q?ggDsllaZtW/LtzQqLazCpJe2vL9mpvj1vrsQVv0/qKEr2VcvM60GhhohyBgg?=
 =?us-ascii?Q?P/Qkdu7/PFVIO8v46s4DHqVHsR2lYsvzPcLeH9Q6bZ4mVZIf05LS2+kja2GV?=
 =?us-ascii?Q?j4mwirtN/PIGLrrxcotND0Q7/vRfNwkeXSfgJUzFZCzlc1cYH21N6cTNxZVj?=
 =?us-ascii?Q?EYcpgUbewuTETvN8DrXryJMSou/cZmmWtHRHyWQaanpifVpZCE6rzeIQ6X1Z?=
 =?us-ascii?Q?Thju44WxLQXN1E0uRwsBRp1O71B6Wl016RwJarfZDXu7AsaqKA2JNs1XLMmM?=
 =?us-ascii?Q?GtBZgAkSO6VmYfshidnKDiVzeJcg1C08eOD/eVfdba+4VrcNBwuzvp+Dd1WI?=
 =?us-ascii?Q?rKJ9rv+EZh0ek/MiGFCzGWp534G0tZW9ZvZot82Vc1P5BYvnaBRDETanAUm+?=
 =?us-ascii?Q?mHpK1FFLcLLH+jRI60AJOcAkYgTatfgj7xfV4nIt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300c1ff5-7799-4392-b512-08dc91c724be
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:52:48.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/t1w2YkyDkiV2/UTaDuIPgmUwrap2U98gkpbpBqYWA7Q9S8wvcS7iYFiKVMTMeyMpFDrQTK/6MNfsntgDdfhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
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


