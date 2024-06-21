Return-Path: <linux-wireless+bounces-9378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E73911D79
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99E4B23F98
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D616F900;
	Fri, 21 Jun 2024 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IcPFPhpZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014016F8ED;
	Fri, 21 Jun 2024 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956407; cv=fail; b=tZqwRuhx+3juGBZZxqWOVxO4nAJfOWdd+oiQY+CeezGOtpiTayAiyQqA2gZkkPRtZFt7b32cfauEPOjnKnBNvGijKpi90AdYQHrCvIMJqzdH2Bp7I+b8wboHmcZ91baqbhMd6htnuVW/DAgr7Rb/BhbuPt0ZP8E+rMGb3v/J/Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956407; c=relaxed/simple;
	bh=b9BACCGZPUQG3r7U52sbZC9QfzAACODw9hPhs8w41WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1DKAC0iPRNUP2PVOsQ3ojyxTmFJQB9JJCS79mV880VEqJmfVRYXmwNNBhuj6PMA5V638P177Shk7ZRmNgy6TyHQ8RY/+KrUqt+7OJXoBk6XO//RtgVEAnelPa40Z8FgJE/bcjQ7r0Fc+paOy+6z9O3f9NQF1sOOuT5KYljrib8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IcPFPhpZ; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXg8Bqq6bL3NUEEnSD5vYlFlk/YV39A3iKG/7a777gmRniq5J2rM7auAGHG8QAyPJJqlxV9Ic0dfrg3s1IRTbAA76xNxMhqjuJtJvWVVtddx/VX7Jz49eAa27bMhWMY6tnjdDHwlQ2z3KNsVRP6IQrHBt0jQS+nLnNbSGQh3JtdXsfRNGI3oBD2oIMqjpjVVHaLL26a6JjYlajsMDl/TeanMs7VhyjJR4+AceSPus8dek6lykWmu3qZ5vB52rt1YV7zbIPorJWR08h87p96Ot5jkGfTY4cJNGTbFoSr8U4gDTSxyfhtyTuqSDyOGARWwNfgDFCRvcKK2xxY5Kr6rHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JkUKaNqWRk/Y4SBf1iVQ7Kez44XgXRZzuriAUricH4=;
 b=UKd1t/PmhOK1ZkaK+tJuEreiS7qg5D5lvFo6m4VtiV6G2fU1Hpu3qYUoCmgV3Ggvx5edxtM8VOMw5OQTo3y53JcTgF54/gLNehe8Pd8mZNu+vbJOY68y6K6Fk96kMAeTkbacwpDL8ZR5Ff/zAoBbVNxAtEb5v4M6RgwV1hLjZkerkpgjXAf2gsTP5snEvxDBHpZ7kaNxlwOsguhFygfW+FA0NnqTNhFNpxX9fQwoGfKzpFNgL0XTt0p7g+ZF4hc3b4S4FwGcplFhENek1vHdTd0NKZIAE5Byd9xz6JBerBk2rqveu8cjdmg/JG9kaLDBag30QsYiru4ipwJ7IEiqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JkUKaNqWRk/Y4SBf1iVQ7Kez44XgXRZzuriAUricH4=;
 b=IcPFPhpZe3nrovfvG2D67HqhBga4mL4p5Z2tZtJB4AE3Z3hxmVcwOIzqjTS8LHvbwzPFV3u+D420vnGs5KPsr8s7Ld/ZSG/GWb7lUrON37WewjZA/SQ2B7WhxUGqCKjt1tmjt84oQ1wiVOa8wcPauMLFGiiKSV/DY71UOmEw9Ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:53:21 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:21 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 14/43] wifi: nxpwifi: add cmdevt.h
Date: Fri, 21 Jun 2024 15:51:39 +0800
Message-Id: <20240621075208.513497-15-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f0ae2b74-dfbc-457a-0a3e-08dc91c73834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mSK6JQu4bKbkICHHuWLE0y/Irqa/EaKjezw2UFfLQb6LnuH9fX/9+DJP8mOG?=
 =?us-ascii?Q?yQQt1mZaX49lzaOCvB9ONVwGb9Gqbz9il69D1chaXx4v1oJypNTCsall14qZ?=
 =?us-ascii?Q?Sbn0XJdTsqaDJ5mGVUFHW89CoHvSzLmMGOrf3wcarThLkbNLKR4ypGTMd9/s?=
 =?us-ascii?Q?NB9gWzFXJCyF0grZOtfuIKDG6g8uUWlWbr9TN6Z62Ww1Wy+3HdaLJnzaiQW1?=
 =?us-ascii?Q?SZ0n2dYF1Sh3vqplCZqvt/K0nDh4rlRvn6jQu2EfHZfnNNHlpNXGa2jqPk4f?=
 =?us-ascii?Q?+5aJTlqREXsVDu8QKpp7xBP80J3E7yTKRYIYa4dpMPNFjF9AsMxLuM9wksZn?=
 =?us-ascii?Q?0ETu9t7tDxZZkxBsFYntDr6f0EqHx/utml/89qLqd+SIYCitAxNdWyl9R4Qo?=
 =?us-ascii?Q?PRw0yL0x3Kk/QAPuIAZfyHkukfD1AIl9Zzp/ML4uq+FwjaM2MQqha96zGR4i?=
 =?us-ascii?Q?SYb5ldUWmBDHMxLiJ+Cf2JsWlwev+MIYMBtdIc6GL25LrPrh3n2utjCaRU8Z?=
 =?us-ascii?Q?l+md0Xwz2pXgY1ts6DL/6oJFt7HB95hESq2T+6SUT9mLjZ+DpgvQ4urJFPOm?=
 =?us-ascii?Q?SFXVDYCHQU1cb894DoYu424vDSgwRSXd4nDAJd0lwOI3bS4awTpPcfHiWIBh?=
 =?us-ascii?Q?2Dz+ffD8EJMUT5KKclkSs7s7vNLuB6brHJjw95MSA+Bhw2SYlJu0WGZ/519R?=
 =?us-ascii?Q?mTDWZg/VCBSmV5QPQ6+IbsmY8+9ht4rUhhXOz5zRDVj8JnKk34WCAn9l8BLR?=
 =?us-ascii?Q?aU13mHg7tBeYqxrYeIZ5LJCBCksC7DkMIQqRcylp0cZNGVkMaUpnjrrtY/e3?=
 =?us-ascii?Q?3l34yeELKy+iyJle49lw1JH+CF0lOfIq8F2n5JiBAtkCV2S1wmGicQE0IXnp?=
 =?us-ascii?Q?x1cHhra+ZFBhG3yrbslnkeSKpsFnr1KAfA7QvFN2I/czlLgn6a81MikjImm5?=
 =?us-ascii?Q?g7beH4qub+luC4G9g4RamdNg7mrfw04kTGlYv3A8dDwt1tk6EYa5wemSDqsE?=
 =?us-ascii?Q?AXoFJ3iuqtaQ12FOFq7Hu4kLZ+bYh2HcKiW7WaUH6S73MAtATsyMqJY2GWuZ?=
 =?us-ascii?Q?+QcMV0I3P6Hl8iZSE08cb4gEjmRDB1Pm32aHejV3Ob3x3YjsM/YMuk4tcZEy?=
 =?us-ascii?Q?AB0tLCNWZ4XHTo+MxdJBZ6jX/oZnu3F0ohWBFKdbbGawQqMxf1pUNb9vW5vC?=
 =?us-ascii?Q?KIEzCeEo7gU6EmTtCo46fiSK3nf3xGcplYbGTn+elPtSBQO4oCxnLv347J3K?=
 =?us-ascii?Q?78SRuRtNi+PucdT368SWNp85I/j/vdlJSF4xTKFDyXjizflh11wCnAgoQWZu?=
 =?us-ascii?Q?4UZYeI8Ij9POQEkFr/EfCN+BcGcsGqEkPK/7eoxLFal1IPEax46UE/5+tbc7?=
 =?us-ascii?Q?HHbBBgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1vZGR92btf2k3PHIaFB8myFIMlFqmtxoJjK5bHUTPgpHH0becH3Ut6Jvu2M?=
 =?us-ascii?Q?eOqzbi3cKhQSx63bNe23sm3oCLk56+CecIl02EJo4MYE74iPbA7DD8UOX1AM?=
 =?us-ascii?Q?qPtIr7FRTVH9ar4H0ICBucGj/X0wL4x27rfclnft8Q66IvZt8PTD8OvVurBi?=
 =?us-ascii?Q?754jBxzjSBqGpb8IWI47XGdc1khIUJtas12Lj1eZHJQc8FpvZNT1Hb1/5qUv?=
 =?us-ascii?Q?9GQKMaO2Y3kmd/y34CTxLUnjLAJU/7cPQq9Ru/ENtDoToPlTe2j2K+UQRfS4?=
 =?us-ascii?Q?sB6+fffvIujoJRuO3V2PqFE5+LfQx/OmAxUAjDwFeSUIvtTSQAOf+xwHU24D?=
 =?us-ascii?Q?Np/nBQutSpm/lHJDzVPjHaVsP1umACpGiUiwaFA39KM+QzQxoZifWHwme7P3?=
 =?us-ascii?Q?X/+ybv0h/GyPRv4e8oOWHVkwemgWCjwTMe2e9ZFBMPbqBMI7nPpo3veYAq2S?=
 =?us-ascii?Q?k2JRr+07rPGBcCFxrtOLrKbmeOHHgL6vzSM6l02oFWTfsudHPyinOGLQTzTT?=
 =?us-ascii?Q?QRr0mPSgMA6M2DloJMWQHAntcD8gxbF0GvTpVBvdJsNFET8XdC709VNegWEP?=
 =?us-ascii?Q?17C00BX76fiTMbSuvTrRo2u3ZLioT18+fSzO1pFa8CdPVfKDcVabT/9f93uL?=
 =?us-ascii?Q?Q8dLPPxNLv7wEGvTtKwmvsnKkraWpCuzh9xvd5zIJCr4PqupPpAv0HfTDrA8?=
 =?us-ascii?Q?iyWxyAs+9V/NgSo/LmHwX/9muIGah7o1+EfQJO2ThJNCOvPaESugpZLmOTyc?=
 =?us-ascii?Q?1MGgN9ry9jzXLz81BVF49E+ogZDfkrdKNnIxcH6mjF8zhl7aGRsdbb5oGNAs?=
 =?us-ascii?Q?k1YEK9Uj7dU2yhxFlT3vDN+O06r6U1zOQYmKfOcJn2BcjDFYzBod6aihQmya?=
 =?us-ascii?Q?BwdbzF1fpq7VbBvboHfuj0LZ8Mlyv9QR9IFGmUL5BXFpppp+2eSrUGlfflKr?=
 =?us-ascii?Q?ObXGKdKL9rI9eUhyz0IR0mpq92Tz/2TJu8zgTLWp5uusqa28I/4W8+pSwk3v?=
 =?us-ascii?Q?svtWym0UPNntvY99os1vW4LlQs0h8SWEYjEWiESpXT5qUy2kZzDu51Yw40g0?=
 =?us-ascii?Q?tswhsS8IBGNQeFz1frIuj4VeYO/mRlBcc2uBAU1eRvD5qIpCaz5KOlSjlxnV?=
 =?us-ascii?Q?gmQkJinrdyvv7vw/US80OGFdjpWGXS6GQorK8r/JGkmyrLMBoNiwjfTYePOM?=
 =?us-ascii?Q?YVAaz3YqwfNiPOVljnq8XYp4NAbkhYmJNTMtOgAp7dOu2j6oQzGcxHgE6O9W?=
 =?us-ascii?Q?RPQ/Xomb4Fvx72+nTXshINoiJ82vjPYnpMbrIvpKipBDhbMW/iVUmzv0SjFk?=
 =?us-ascii?Q?2iXQ938eZfuT9IE7QLeOqbH8nunZIvkdjty8G8NeQhQ2tVSpeZDNQrrNOgMz?=
 =?us-ascii?Q?UPx6Of0DyWp1B2oQ3DCHrfA0uazwu+/lg4rkvonN7yEwG7DXkQg5MUZvXBZC?=
 =?us-ascii?Q?wt9JrzVc+MaG3OlUuprDUoEdsSEGv/9ddCVM6KFP+omXnW8wJolJL7fEo0ip?=
 =?us-ascii?Q?iTLqHBTmmBsxJxxdAFFMfplklIftMJ/eNriAOsVi/H9gkM4wURYywht32/+a?=
 =?us-ascii?Q?59w4w+E3EbWXOBlUTznCCAo/xd4K2c7RCpulWuby?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ae2b74-dfbc-457a-0a3e-08dc91c73834
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:21.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2niKnbYc81inFLBrHjgGJ+/AH3AmwEqgXh7BtYKbq6Jug43rZiZH9luXS/5ulqad8EQXwBXqZ3jPJudsIjaY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
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


