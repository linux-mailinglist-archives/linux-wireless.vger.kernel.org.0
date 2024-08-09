Return-Path: <linux-wireless+bounces-11192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0794CDA2
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1191B1F225C3
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED16A196DA2;
	Fri,  9 Aug 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QXHs0eM9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13C195FD1;
	Fri,  9 Aug 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196812; cv=fail; b=hAcZxJmoqBEpM8pniAYttQwix02kvxImLuFVT+vrOBbDF83TcnEFU5jlFKFbG7OWSZw5oBXofPD4nbQLrMKRk0sFtb4aQT0kJ4uFgKOawO1PfGhIaqssVpbylfWR7MInc9OoqG5Jognf8W2NmUdskAIcxZ2UNi3N6/gvDetMwzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196812; c=relaxed/simple;
	bh=sByoiV5NuBr0ysCpf+1cJYFnV3SLEXnzmkAnOe4dkWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDRGqAtVMCpbbTpze8+ZCd79Nv8vAk7VSvmJu9Im04A8RbiuOYhm3TlbgvMgyF2Oq7zJ8QRL0XmHSZR6rLFUUU4OJF4HpzfaMwf6wcQXACUdD5UogFtzXxorZAiZq9sxct4+LUL+WMaYlQHcBRMBS5aHB/L6Xnc68Iw2fIKLPY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QXHs0eM9; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKL8LRqNbW8d+pK4RE7GKxbyhZ/C7murC1/vP9u1so9LXuNFJACzLGXPH+gWg+Sgx7dF21jHp/idsguLxIaU6HEW1heTJa90mgBHAamznnAVi3OBsclxOMYWkMBI+cWCGxhML5krAwhJXehKpCp9rb3j0rvoxjpWTrkJqT1vrRyOhOyIUj3EgmbzRVRQLmh4b4ACkLgmODqEtpqlyHqa/LbPgNA5F0QUXzoTd/ysTHJnOOjEuTJnBMpYlCxxMtVfPsivknApjwK6hlemxVdmyT+LQ63fHIF4o+1opOBQ9vhPSB0lPAzi/z+XiySer60CGYQUJo4roZEnVVA58JAJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGvR0ke1v2oz4HbFeWbRfJE+qQcT48Bau5a3yFnvMvI=;
 b=rpBUCGhSkLdZnldI2jxJrd270TFPmHLnKfuqXPR5p1iEzHJxZ08K3WXG1twchYQc0XHb58v3msXU+EVlBtWE+WObZ/2/edrOsP+4VeH5v5VBC1G9RhC6jwa+XLFJDqgoOkTVYY89buiQDcOgB2dunwwzhcPmq/fwYnogDNOxPPj7NmGuadvJWvdZZU9fja8IsfVcuMoB5fxJuyp1H+xik7nHjFG6DwySJOpG6VQ/gjPqpaBzTLVMcRHgSP7Q2EdW9nS2tzDR6o49+Y3K8eRKRAHgy6WSB6YjQVzM7Iiv0m29qt86jse+/+Q/1dY8CZn/gD0AYlVsYSqTX+vxLrgqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGvR0ke1v2oz4HbFeWbRfJE+qQcT48Bau5a3yFnvMvI=;
 b=QXHs0eM9Lfw+dJFKpOP0QhCwveB9/XxL1wksVI1gkLs4OR8xhPN1kJVhRoWGQNdFbQXW4NHda1rL6v6waBBfrdEgYnw16AcqENdpqmXXwt45e1kH+1LFryoSx/hqUpS9y7KrYJ0ZlblwD3IW7PNRiYVh65/v0Nu+elI7iUowO1ajZj9u6KkLTTB+LyEseGjctxBqqywn69TzcVxzTZ/+slkHFo0PUmuC+FZ8TZDkgowhck4xvoDQaoK7Lp3fq61/yao2L/s0Knp/cPFSkOqjRc9w7ZNRl3Kegj6tgPSFibKi95MdWJKLY+7kLoyfnKBVWkrJfUJ3TzjTyWIaoLVsrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:46:40 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:40 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 15/43] wifi: nxpwifi: add cmdevt.h
Date: Fri,  9 Aug 2024 17:45:05 +0800
Message-Id: <20240809094533.1660-16-yu-hao.lin@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GVXPR04MB9949:EE_
X-MS-Office365-Filtering-Correlation-Id: 1223687d-3b3c-43c3-48ae-08dcb8582b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vn7QgSK4FTTpuCYxU30O9Zr1DRrnasqQUhzGn163yFGiwAUC7ZJQmf97XilV?=
 =?us-ascii?Q?wp/tHQbnJzB5VaoLn6+Y50mItvjBjwMzpFcmh+qcYvNMcmCGNabJX72gcgH9?=
 =?us-ascii?Q?WiOuOFzE/p+TcKMyUZFu7q/2gwpwY7drBO2jQb6LvpQs8z6EpWgzoMI2PT9D?=
 =?us-ascii?Q?4sQz02L0gmU6gQZ0PSZVSnpNvCfGNurp5J/NE9jD1KI1PPipdj25aRJwLwQK?=
 =?us-ascii?Q?ajqvH5Ge8RRlCUU5mpCNGPpo63/VANoRM1pn1oLqK1KZ0t81lbEY8GCxOjn6?=
 =?us-ascii?Q?r258FZX++QbRYS8oI5PKm5PJqZ2E5HATk2F/NmbZ/tf2FVT0Wfek4lo543TT?=
 =?us-ascii?Q?anojkU2k+EZ0jqvDkwl4zxOpRZY2YGwiZmp+Tfz8JwwmHczpf8WtIlvQFIml?=
 =?us-ascii?Q?AM3SDMu/ST6lUh+E89vnsT3RQN7yvkWCVSq4NJv+3DndDJBqpOE80zJBzPdL?=
 =?us-ascii?Q?BfNaXyiZqaFvMk9EJrU+OROY8byFH+03pIPAbfRera5pz1nsHRU3eFBEQZFR?=
 =?us-ascii?Q?Z/Q3QX+scGkzRKd+y4dFFtt6yde9fLpuzNUarDcvlGYVv7cA80Gx3XFqKPHr?=
 =?us-ascii?Q?Dyu3JcJzj2caRlVOyNk49AeymTIeXvb/M3IuIHFqk6dgrHiym+tUuc8M1YCO?=
 =?us-ascii?Q?yLb1+6415TrNbghZ2F0+z8Z5LpyuaLRdcThx2wFAMPh6jIfpfhlz/mZyLok+?=
 =?us-ascii?Q?9Q5egd4uLZB8CTR8dXAO7KWWSorhu0U3FC3Y1Qp6QwOrKBXDS3Ll7DPTsurh?=
 =?us-ascii?Q?qfk35b43/mcRgtuGCmOKW6t1KDfdTlDxkt/6YJ9UJR9CYYjdBGmINFIDeopU?=
 =?us-ascii?Q?3I8pNcrIAbz2NwWOAnfiyehlw5980V03+Cctjkbkv0JAzAzn7LepexdR4Za/?=
 =?us-ascii?Q?AatIlSKWfXOdazzm1MDucZwRvLFDSIJBcyGU/LOvWvBbPLiapzS9GQha56Tb?=
 =?us-ascii?Q?QueJkZGwLRYZQj3llvSDWtI0hqqhM9k13XGcQnIKSWo3KRehf2BC+T9Wwrhu?=
 =?us-ascii?Q?4JSgV0cRTBEryjxW0kR+2sWkge7m7UqfHFm8hSjZIE+BE8cX3znBj3h2h6Yl?=
 =?us-ascii?Q?Y7lY1CM/YihAFIzxpSYZY6/RzSpwcB+SUi7JIzWc/szdWOaY2iRtduxf/GL+?=
 =?us-ascii?Q?P24hUGn0VBwCCDJR2sR39u4rhUetZ+AtFyU0k3W+7bv4KVzgpc+1ncqk6Pvs?=
 =?us-ascii?Q?3hOEkLDxhVxapd+aNleeYEiZ8t40tzuTpf9HWIE83lik8vjzKuCsCQ+yBQ4T?=
 =?us-ascii?Q?7s9LK9DIObu0G4KAGomQ/U4ncDlOPwpIXqVtMRwM3wBQCsg8cqRclyf23yzT?=
 =?us-ascii?Q?soyX/Xeqx+0ZjuFSrRrIT3i4hfXZVpfssWDPbFqpZDlqfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cfpJc6JF4Y1wbEpSSJXuGRfLbDS+7V+qeok8gV5Le71q7JZ00xSsWRcvHYAM?=
 =?us-ascii?Q?wZMLONvfcs9sYkTCbwbzx14ZrSbYvmfNVhrJ+/yWgDimnXuYzvHWsqmhz0Ex?=
 =?us-ascii?Q?NXwrcoRXmieRlGlBXQI7KCo1W2i42o965UGVdsSdIKUwM2PpbmyPqtEkFpRo?=
 =?us-ascii?Q?JldjMrO1pPpdF2Gue+TEhCk8mVZxpB1Cz+g1RkYUvuX5CNSCOAFF1dWfcgCB?=
 =?us-ascii?Q?BTXKtJ+66gmV2i5oeCUulm2JmE5qlOamlpnyTavTo1VuKH0UUQZzWG/he+bp?=
 =?us-ascii?Q?9eOY3JuDaGqI0qqs76Qu4EIvk9aiO/c8TbjndTXQhOlbLWvnL66Rez225IZ5?=
 =?us-ascii?Q?Wh1+JLr6skKWdXHl2BFsHOs4WZ7x3boGaa8cNiKP/hARyg0wH6H4+STTIsuZ?=
 =?us-ascii?Q?Bgh88dylB3WJi7AslMn4OA2lN6g33VAtMAzzkK8pyQRp64H3MPMt0mCHwCZq?=
 =?us-ascii?Q?eXwP7V4eD4sld/XQydJgIrGifObNww30T5FliLL/SjYqlO6tdJOf3TnGveBm?=
 =?us-ascii?Q?Bq4qwtIzxWWr3LqXBOaaSKLgr8ffJTTOj/qUy6/FtQ2kgnrG+Aj/NGsNCLnV?=
 =?us-ascii?Q?Fd2Xjtl8lWa6HohgK+vbUXwiTS5I4BzlPoG3/LeIy/wxNeA7UKwxmNHwgMYI?=
 =?us-ascii?Q?iF06hZJ65LUhg1dcdWVnEnpMrMZcu/QQs45xG7rt14L9R14cgRFuYGtA75hW?=
 =?us-ascii?Q?OcNWYXM4MbtrCgacJXhvXx1x2OJzFo6efFVj/SajeaLoTi24o5TTTlw7janb?=
 =?us-ascii?Q?VVPV2j0yTWvNQtbdJNF09LpWvBCsKzCOUwDwL+jkpUCzuDBFT06WN/uurd9f?=
 =?us-ascii?Q?4h029WSfyZ8yI27X39wE64TPyb+DrYM5enXyRixzZpNl2nBGm5iYEtq9MZhM?=
 =?us-ascii?Q?HGEgaFvi+f/X8aT3xjvAF6T+nKQqy286NueOpSfjyFp0DPSChsNUU+MMB0dB?=
 =?us-ascii?Q?OhD+y46a3Xb2v0hinBC64yCPhj47vKxSoo2HCeG6j8bVG3IMUvq3+o+anfet?=
 =?us-ascii?Q?ZL3myXOIEVVP93eP8RrPqgo6jINp6yHrSMJxfQWbsVW+x3rpaZjlv8+rpuun?=
 =?us-ascii?Q?QEH7xuypzkUHOfXlT9FLAfH/j4PixvuW521SXTPC0T0Yjf45E+sUPP3EMKUV?=
 =?us-ascii?Q?p7h7dVE20kNIB7DOaB5lPvXavWWk4CuQ/jOfPIVO+wBCpni19mXKZZKYQxM1?=
 =?us-ascii?Q?7DYNKz3I4+tu10nFPSj65u690yD+jOA4M4CF4MjN4PaExD1kWi/qSd4+GedY?=
 =?us-ascii?Q?IVcmzUZ+agVngS3BPI8NTuk+jczo5KXybOpNT/h8nTjnahHVV3Mns3Lapbry?=
 =?us-ascii?Q?g9YeuEozbJeBoy84RUYX12b379ShH0DyDhQJp5NANuQ0w6j9jzskhoy1tD4S?=
 =?us-ascii?Q?7m+oCpxkFLPVE/XKcYTKlUxfXNeqUy4s6VNMWKAfSwAuQI5nvjh0VH07JrQl?=
 =?us-ascii?Q?8SkLniLe3MwXLfWSGZeeaSP3RDHVXR9ZeICIKV+YxbMtvNVFHG+YlphTZoHl?=
 =?us-ascii?Q?FMk+BfvtpdNr4uusIDyhSK+mSDgwODVvsA8HSkK+ZcTheVecyH3cKvYHdPYf?=
 =?us-ascii?Q?0SzZtONZsM3sxsTdZ/d+Dk6ABqvHNH77H2eG188VlephQeAqVA5kXECERDqQ?=
 =?us-ascii?Q?9aoCEjhx9DLb0dFV2Elav/2+l7iLUNJQASo9yFVU4q7h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1223687d-3b3c-43c3-48ae-08dcb8582b82
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:40.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgTsWdsRO/dpL8cDoeaAK6MkzQ32HsPOBzwXCqfVwH46Nk2WbsYmbIP/si6TrWABOz4r+o4mDuvCp5iPPLV4KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h | 92 +++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/cmdevt.h b/drivers/net/wireless/nxp/nxpwifi/cmdevt.h
new file mode 100644
index 000000000000..a7774151fa5d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cmdevt.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: commands and events
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_CMD_EVT_H_
+#define _NXPWIFI_CMD_EVT_H_
+
+struct nxpwifi_cmd_entry {
+	u16 cmd_no;
+	int (*prepare_cmd)(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *cmd,
+			   u16 cmd_no, void *data_buf,
+			   u16 cmd_action, u32 cmd_type);
+	int (*cmd_resp)(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			u16 cmdresp_no,
+			void *data_buf);
+};
+
+struct nxpwifi_evt_entry {
+	u32 event_cause;
+	int (*event_handler)(struct nxpwifi_private *priv);
+};
+
+static inline int
+nxpwifi_cmd_fill_head_only(struct nxpwifi_private *priv,
+			   struct host_cmd_ds_command *cmd,
+			   u16 cmd_no, void *data_buf,
+			   u16 cmd_action, u32 cmd_type)
+{
+	cmd->command = cpu_to_le16(cmd_no);
+	cmd->size = cpu_to_le16(S_DS_GEN);
+
+	return 0;
+}
+
+int nxpwifi_send_cmd(struct nxpwifi_private *priv, u16 cmd_no,
+		     u16 cmd_action, u32 cmd_oid, void *data_buf, bool sync);
+int nxpwifi_sta_prepare_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node,
+			    u16 cmd_action, u32 cmd_oid);
+int nxpwifi_dnld_dt_cfgdata(struct nxpwifi_private *priv,
+			    struct device_node *node, const char *prefix);
+int nxpwifi_sta_init_cmd(struct nxpwifi_private *priv, u8 first_sta, bool init);
+int nxpwifi_uap_prepare_cmd(struct nxpwifi_private *priv,
+			    struct cmd_ctrl_node *cmd_node,
+			    u16 cmd_action, u32 type);
+int nxpwifi_set_secure_params(struct nxpwifi_private *priv,
+			      struct nxpwifi_uap_bss_param *bss_config,
+			      struct cfg80211_ap_settings *params);
+void nxpwifi_set_ht_params(struct nxpwifi_private *priv,
+			   struct nxpwifi_uap_bss_param *bss_cfg,
+			   struct cfg80211_ap_settings *params);
+void nxpwifi_set_vht_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params);
+void nxpwifi_set_tpc_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params);
+void nxpwifi_set_uap_rates(struct nxpwifi_uap_bss_param *bss_cfg,
+			   struct cfg80211_ap_settings *params);
+void nxpwifi_set_vht_width(struct nxpwifi_private *priv,
+			   enum nl80211_chan_width width,
+			   bool ap_11ac_disable);
+void nxpwifi_set_sys_config_invalid_data(struct nxpwifi_uap_bss_param *config);
+void nxpwifi_set_wmm_params(struct nxpwifi_private *priv,
+			    struct nxpwifi_uap_bss_param *bss_cfg,
+			    struct cfg80211_ap_settings *params);
+void nxpwifi_config_uap_11d(struct nxpwifi_private *priv,
+			    struct cfg80211_beacon_data *beacon_data);
+void nxpwifi_uap_set_channel(struct nxpwifi_private *priv,
+			     struct nxpwifi_uap_bss_param *bss_cfg,
+			     struct cfg80211_chan_def chandef);
+int nxpwifi_config_start_uap(struct nxpwifi_private *priv,
+			     struct nxpwifi_uap_bss_param *bss_cfg);
+
+int nxpwifi_process_event(struct nxpwifi_adapter *adapter);
+int nxpwifi_process_sta_event(struct nxpwifi_private *priv);
+int nxpwifi_process_uap_event(struct nxpwifi_private *priv);
+void nxpwifi_reset_connect_state(struct nxpwifi_private *priv, u16 reason,
+				 bool from_ap);
+void nxpwifi_process_multi_chan_event(struct nxpwifi_private *priv,
+				      struct sk_buff *event_skb);
+void nxpwifi_process_tx_pause_event(struct nxpwifi_private *priv,
+				    struct sk_buff *event);
+void nxpwifi_bt_coex_wlan_param_update_event(struct nxpwifi_private *priv,
+					     struct sk_buff *event_skb);
+
+#endif /* !_NXPWIFI_CMD_EVT_H_ */
-- 
2.34.1


