Return-Path: <linux-wireless+bounces-11195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9885D94CDA8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CCF1C214A0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C27198833;
	Fri,  9 Aug 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/hmNLA2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355E197A9F;
	Fri,  9 Aug 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196820; cv=fail; b=Yi6n1n3MU8FZrwqm5H1eMONAXNIY3UPgoYD92Io5OM3xkF6QRZQ0LeV0BsD6WtDJ6Tj5f2JqQyS3IVAKSJU2iCEbWXYJTKf1WPwbHrdArsohcI/G1XXRWe6TTr7O8skK01T1ao1VbF7H/+Moqyp4dU3AcvpvHXxmaoe3QQQzPj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196820; c=relaxed/simple;
	bh=iPW7EHV4dQiVydUK5ulmopwJMF61KcLFxV9VKtsRCjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LCqCfLgGW0ASUaPVzoFt3DELHoyYzbzXRJDLMta7fChWSb550HC7VhqqBsGls+eW0eBNOd9XL0RILt6hOvaC81htpH/hKM6O2JjAKqiCUy6HTZJLOvVobCSP8JOtRHio+HDRGgIE7sDSpwyZssvEmCOsQ7OPK6ahzQS92H7psHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T/hmNLA2; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyA+qKbl4OM6JoGDokQvb/tQOB6Zm7rz/iUbuWtSv6KlS9CAEX/eruP1sdJhzyvRXL3ZvBmaNvgZrscNu7pF6iTaAHnOiBTth12tzK8V+MGwJJF/Z+muw0nTjSIPdOeK4sBaqBSNBq+6eFuyjF6taPvERa0rR+ls5KV1eIf2oajZEiqN0oS4OzHuEfxLXjlXYtZp3OMnTHJrpVt8Wv2G1d4vjvgh9ah+NyWA0MXH+4imZwisc6iVS824bTQQLDI2MIssAirocF7FVoLpa47p3gbcq45Wkc+/XMHwi8ngbtSuc2Vi6M9psM7nSlIjr1C6CCdlnr+Q+LfTWTo2h8svtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp/RnIW8RGclZufIVPDrZzne5U+G9qMYZazV6y6yN1o=;
 b=GTPphNxh/GXjDOWevUPlv9rUNwX/UFtOqV/YMAbCrVrpqFbQym5y/PfTY1f7y+4OpIVJ/Y9P1SMr8zNyiySRxvfX/dDqziRtvsfxSUCGq6MhhR+l9vunXyyS/aC/wqxSXyou/EoBvppEYX8dDZ1xnLq+bKQ6Dgyks9REVo/jqpcXqsrmKxTVTkTn7Gm+uI9b2AICCMGUSMhA37hOH7Eb0Bjmd7PesHGg3YF/nfgBcvQ8ie7jIjB7OV7I8vvsFphK6DhhZuakIOOXVDoiIuOtJcl27ahBjMFOEJwtNfEr9uNwPcS9yFXSZ7DoeONR+jSODP9hvDQQLqf5v2/MhvYElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp/RnIW8RGclZufIVPDrZzne5U+G9qMYZazV6y6yN1o=;
 b=T/hmNLA2VdEnKJROxaPm7cLClIHcdKQbd1nWN/L0xBNMWOKd8332v23ve1tHU63tZzlYsAtKz/4RWaV+dmBvwHlVfdqXPZBdS9HLb8vTE2gZwbuUU8vAEzJOmYPSIE/Mvi4lY+7/PWpyBDVCl4UhoaloUHjfWuixWwjNP1ly/mueZ7F3c1HyxBH14nv+NoAaWyj5NligNu2Hy4PxUR3Dm9IHTJjYlVbsTsGTb1I3MumqFCYUfjU33A3VHT2AA6cHUZgiD1886w9SJCWK3MTUXz/da8QJ9lrd+vjHuEJSVvzm3jHSd7Bsz58qyxO2pye4/vAhPF4msLBcnlR8vXXRSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:46:50 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:50 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 18/43] wifi: nxpwifi: add ethtool.c
Date: Fri,  9 Aug 2024 17:45:08 +0800
Message-Id: <20240809094533.1660-19-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6311fd95-07d1-45f9-76f8-08dcb858311e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YYBA6ZwFrWZ3LsfEcFHyMBYniIfMSGQghhhuVP3KTbs+zsi7G1I/yipCxGTf?=
 =?us-ascii?Q?megnmUhERjnd7hxG2XG07ntWz8tupFJTNeqdjt//MlobxqiBeyG80b/NNCIP?=
 =?us-ascii?Q?RBrl2SLJsGrEjJWcS3C8RyChjNEXfEWwXunhdkI6fZXBESIgGmM2zW5GneQ0?=
 =?us-ascii?Q?8HGS2tlH4/opwLOiMMvu0o7en2dtHgaxCZyrn8BZRjZZUn5Hx1CUWhIGVisI?=
 =?us-ascii?Q?+9MAJGvGSdNqlChiRvm6nBUXOOVhgoD0Rx2n+C/WUHfjhMPk/rjbAyYBg81F?=
 =?us-ascii?Q?myBgkmTOTbKlZTVaW/X/zwzWsQ8gbdEiwWixn84QgqKK1uIlGr9viAqsINPE?=
 =?us-ascii?Q?6DrBNulaMjmla+J3vCcjuSBL3jjK/R5SWymGWjFYx5r4ehUUtpyiNEVTZGLS?=
 =?us-ascii?Q?r+mW47PnRDwH0RO6MbYulQoxfGI+27rRz/lkZ6QCBEG4YtTwyaQsDfuHxdOk?=
 =?us-ascii?Q?XWrxlDhCpPqKlmmcvLnU1NrkA3umgLy6KfevR9khxwRYYLePxFT9kXwoh6/e?=
 =?us-ascii?Q?pozmScckd9vLsbPl2mGUEtbI2FewVaHWaD8nM8Oiju8yYXJazl5ehq9MJ38B?=
 =?us-ascii?Q?QjfA847ofPaWCDrvx0AEP6HvO5g/SBExTBoah4Y6vAxElEAzY8365WtVWwM4?=
 =?us-ascii?Q?uafH19PxRDyE817Aesvi3WErcDQ3XgRv+i62npw+iHmh9KjNuDtCkkUdAb+N?=
 =?us-ascii?Q?IXhBEKWkk0CdY7Lh7J3x7IY8z7Q4bciI+0LlFbbNS26ze2LW8Ttcbfspy+j5?=
 =?us-ascii?Q?cC6N+mE+gWo4Sc51uA3UE95OOVaLYnk2k9Hee94cwk83WtUhdLfEbEttRQHm?=
 =?us-ascii?Q?Hr4x94SOMvt6TV7FalHfebLMw/uEdbz2RsiN4wa7VMV1puVyBPBfwifGw4eu?=
 =?us-ascii?Q?2MYxF5LgJ9mYKZ7sS42cY81rz/wHjflAKpy1tyTlUyIjL8LrUn4PGsUiAsUB?=
 =?us-ascii?Q?UM7Eb4HAnFPSTLIDP3/V2fWiwPAAPQ/eMAA8pfIhleRZQPJ8WTUqt4oqyxQG?=
 =?us-ascii?Q?UBFPRANXaCeoairshOy9AkulAx9j+dHeY57LAOn6FwL1+EbrLKnVWDBMEDIa?=
 =?us-ascii?Q?D0U34kcjkWkPxT/FJioI9TpeOx+6WAmwLTOHQLThIYiwQnCMaLTVV0XJZntd?=
 =?us-ascii?Q?eOzuwy+JLPQ96vbBpfFH75qfLbhYuL8RUgh/g+e6Drq2tgp5YELe22jKF+Cr?=
 =?us-ascii?Q?vDRqEm6PcmwCjEtGuEgQ54kZEavjyNVewVridBLwxtzLrXuAAhoN+RUO6Cs/?=
 =?us-ascii?Q?WlIpAPwJQ5eC+LFm2lfWnGG3iZFXJnkuOxDWMy6mT4G+6fAmMduAhgs4N4rQ?=
 =?us-ascii?Q?0utcSCe33KjLRdcgwlv0LHcTq4d7s8ezIVHAdl3/BwLnIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+3OlpeWA0FDIf3rdAcc97iZ1wcsJAV9IS4v6Tfujl39m2jsP33Jyu1DBX/Cf?=
 =?us-ascii?Q?03KPtcJCv58Un60qTyuo4X+uUfwTWEVY6OEZ9PIoMcDtmaUkF1BOwNP8E/Y8?=
 =?us-ascii?Q?6okvyjXrfPR9G+sdh2YnB1f5aIZ7ot1GK1QX7dab6WUpyL61GZzt1XEhQrr7?=
 =?us-ascii?Q?P/t3qhW53FvAEBUmjM1SO45/8YrqcPd07nb/v6OiqGH4Sf/EbRJ9iMC09T46?=
 =?us-ascii?Q?NiiBie9v93VUAar2Ux8NtkQeW7kZXqOD+MOZAhOTeWS4Ps9st94Gv3pwMsDW?=
 =?us-ascii?Q?GPE91ifUmDivhJCg6rA0YESny+ORmsrdMDE/bco4lzHAfRnwsHI08XmffVNe?=
 =?us-ascii?Q?UXdlGMWKvzRJy6x98ZIHGF+eTQWsGzird1VFlgiLIs+UQ/R5rxRlDP0eSA4b?=
 =?us-ascii?Q?TTsJlYx3WiVIV6AX0NA9yUXK4swajieqHkSj4te27jzvUnkzdw83R4M5VWkS?=
 =?us-ascii?Q?/T1x7Xyjx+NR622hNy9BqVwIsJhoXeSpOkFO5HxMI71fJRwhtb2kqsKAQ7kr?=
 =?us-ascii?Q?p8g5uSqEJPtAMuXIa9TugewBEla02wyPSbWp/dIt5+yz+6m+dZVVroihO/JH?=
 =?us-ascii?Q?rACR8ekSBH5aiy489ZQE7uudmN9ljZrIzvv025ibWa1VhvtJgnR+5trac7KU?=
 =?us-ascii?Q?Ga2OojJoK+mNmvwY9saTRoq8fPxG3AbfZXW29iShVu9pljWmWqfsAJUmnYBP?=
 =?us-ascii?Q?pd/PfOJpxFoTPSjUMVB1TMW3baBDWU5o+2OM9lZ4vuAGPKJvgef3i4czon8b?=
 =?us-ascii?Q?WGrw9umo664ReVbzm7BE7mQohS7YLX2o4aKGUeCdcV6xt58rnrnPfdiXuOAf?=
 =?us-ascii?Q?8fSJvf5NFsvlrg5nbpTKznCCDDXDPIl0hc6l5W9alC3r1WjAn00kHrqT34F1?=
 =?us-ascii?Q?fXMcfXSAlUfCMkNpULZn3sW+DA2rGsjcg9sBVaU8SRYhrnxOYdvUTy6Ubj65?=
 =?us-ascii?Q?PYCwBY6TOFGZ7ed95eEeqmxplaafXF0V8F0xAlX1GCO1bmarg3r42SxwqKsz?=
 =?us-ascii?Q?PMQzkbhxT7fbS/EuFT+ty3nsRAw2aJF2bHFt4mjzt0Dd6+u0LEKX/sHkjsdg?=
 =?us-ascii?Q?BQgSe2QBUQZoaafB6v8EsHnx5Gqej9OgYTlY4D9syKC/OSJJK40G9No8Ugj4?=
 =?us-ascii?Q?pxsrQSQXZo/2qxsJvUQJudbqmK65yElheEFhj49CP3w73o/bMpg9BEUF6wqZ?=
 =?us-ascii?Q?1c2CNCNwlvaqxSqRzfcTrcNs+vqrhb4T8e7MA0qf+yj6pVTNv8T8pZk9JMgF?=
 =?us-ascii?Q?/XKXDPz6wjcXsomzl/DH7+6DgBwgB0K9OC6IzNUbOImONgipJ2uplCyBmebx?=
 =?us-ascii?Q?+nFGNjmCJSNt1iYyU599mmXq588Qi3xLVOExjC7HI1C7DxMsEiRdTzG5cgFQ?=
 =?us-ascii?Q?wTaIAFO5ng7itJx/wRdf9Fje+r0pRFIkg2eZ98blDum3iHDNckh12nS4aLQH?=
 =?us-ascii?Q?wiuqkbIeDj8o5Z0UYADjrHl5h2QTR4vUC7zwuyuxMenScvB30/vVCCNoNuY+?=
 =?us-ascii?Q?qoMDp0t1xJCgBjERp6ZtnYYz4SikMcwH9YrfoO+dkPvP9PtG9E/BtaymOvne?=
 =?us-ascii?Q?pjWAXHpRewH48nonyDAURkrK1lb5sT78kqtDfJL/Eweu7hnnlRFpRPKj4/5w?=
 =?us-ascii?Q?hdIhXesyLWsT8GJsi4lEJZt/fwaoCh514/YBbK13FvS8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6311fd95-07d1-45f9-76f8-08dcb858311e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:50.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hy4jXdfSqiqY8CjPJMSsmTS2IEEtKT276UrQOb9V7r6hBFDD+sFZcZw44ena4ZCTzhbPqDc58+5YdT6VkEGevQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/ethtool.c | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/ethtool.c b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
new file mode 100644
index 000000000000..6cefa6e6f5b3
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ethtool.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: ethtool
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+
+static void nxpwifi_ethtool_get_wol(struct net_device *dev,
+				    struct ethtool_wolinfo *wol)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	u32 conditions = le32_to_cpu(priv->adapter->hs_cfg.conditions);
+
+	wol->supported = WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_PHY;
+
+	if (conditions == HS_CFG_COND_DEF)
+		return;
+
+	if (conditions & HS_CFG_COND_UNICAST_DATA)
+		wol->wolopts |= WAKE_UCAST;
+	if (conditions & HS_CFG_COND_MULTICAST_DATA)
+		wol->wolopts |= WAKE_MCAST;
+	if (conditions & HS_CFG_COND_BROADCAST_DATA)
+		wol->wolopts |= WAKE_BCAST;
+	if (conditions & HS_CFG_COND_MAC_EVENT)
+		wol->wolopts |= WAKE_PHY;
+}
+
+static int nxpwifi_ethtool_set_wol(struct net_device *dev,
+				   struct ethtool_wolinfo *wol)
+{
+	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
+	u32 conditions = 0;
+
+	if (wol->wolopts & ~(WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_PHY))
+		return -EOPNOTSUPP;
+
+	if (wol->wolopts & WAKE_UCAST)
+		conditions |= HS_CFG_COND_UNICAST_DATA;
+	if (wol->wolopts & WAKE_MCAST)
+		conditions |= HS_CFG_COND_MULTICAST_DATA;
+	if (wol->wolopts & WAKE_BCAST)
+		conditions |= HS_CFG_COND_BROADCAST_DATA;
+	if (wol->wolopts & WAKE_PHY)
+		conditions |= HS_CFG_COND_MAC_EVENT;
+	if (wol->wolopts == 0)
+		conditions |= HS_CFG_COND_DEF;
+	priv->adapter->hs_cfg.conditions = cpu_to_le32(conditions);
+
+	return 0;
+}
+
+const struct ethtool_ops nxpwifi_ethtool_ops = {
+	.get_wol = nxpwifi_ethtool_get_wol,
+	.set_wol = nxpwifi_ethtool_set_wol,
+};
-- 
2.34.1


