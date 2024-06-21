Return-Path: <linux-wireless+bounces-9371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D980D911D68
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD272830B1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B716EBF2;
	Fri, 21 Jun 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tbu4V/JC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26516EB78;
	Fri, 21 Jun 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956380; cv=fail; b=ObmMvGJGfn/+YeLGtShj8fTcmOFke7avmia2Knp5t6AD8PUnkz2cnrJKBacANbwVvK2993td4V+oyOTTZd65hC/MaffEc4RmznSA0R9Yx/P4rb2qRo8f4mQpjg0Rhkds4wf5iTBYE7VEn0Eellr4v/xePzZBlh7Uuv2OVsbPO/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956380; c=relaxed/simple;
	bh=mFwmBSvJLZ7f6jOt6OcpAXbxX3cuiCfiiuaDCO2V7bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KM1ctF96jjtT/vPxNETY0XSL0wfxRZm8upyIec6HrMcO5PaDHAdvRSO5/ZA8cQ4XrMdTaOUsIOORo101sj5nMUCiyoauvLJr206Rx1A61TYbuwjdShFEE6CxNl+D5b9lZseyw+wMwSebcMGrYSSROMEfnc2vODZgsgreWk+J/dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tbu4V/JC; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJi/bmxhfGzN3ytAIEOz1hFS1IqVtBQk0JxVtMoI3b285j06Ssqdjmxo6aaFFf1DOBs0HYjNJoVfChGVIldDhHBRMyzksWICJTrVwWX64neu7XdEjEwcoJfiShxaFVjNzeNSkuLLskKED97MjWxQn0BaIDGlhKJ/efmx6o7wcL5CosYxBfNa+sORdA6r94YaWgLG/2U8Qe/clf9qdhIEtkdWimlj6sfIS+YhAu0xp+zUsL1i6B6R7+NRJs4FEl9HUcUtXHZ1uuvvyCRAGw2bxYM9CnPebB0i7HDZi63nmfWOFs4U4JXX9OT5AUfdPpGFMMMTnsjDLL5pzYQVchlihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTC0Du6ORTJMxynMG2wa9WJHDamonh41INI58D+OQvw=;
 b=atTuXzaX2UW6LDTx3jyYe+o4gURDIDkrvixwyhwO5CCTiGBCHt4tBOIu391H3jDwLzKAAQPGdpYh5Av+qd/lHUXdO4GWpSzYi/dZ20ODlYWjkMhnCdEbGkTFRef40CXULjsa2hc81TdyAQt2bMyVOuc3pOVCBqhovQmsxnOqU58lLjE/++47jVC9mrPJoRfSaul7kcANUD1B1LBnFo9hhl1N497N1yDXm9UdCwcXy4QFQqdYcCBJG4ZV3zJjNd+rh0b2CFo+qOQVh1F4BrTxOLHw8fxekazsMqrAjRiimRahLeZwdEG619Mhdyz0SDZyn3uOIo7fOHRG9o5AU6xutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTC0Du6ORTJMxynMG2wa9WJHDamonh41INI58D+OQvw=;
 b=Tbu4V/JCLXJtyXIQEVUZpgJP4UBWzZVcrZ0ulaFdj42e7mmeAcHw3b89q6wo8sDZccdJdTsrtNuUp8YhElOxpv2GwBpzZCX/gAuwl+kDN+DugISJFQgHALYj0br9uhbqVeG9RECHigJARBLA/nj0T94ucamHxCh8VW9y3Kw1aRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:52:55 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:52:55 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 07/43] wifi: nxpwifi: add 11n_aggr.h
Date: Fri, 21 Jun 2024 15:51:32 +0800
Message-Id: <20240621075208.513497-8-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34a767eb-da12-489b-deb6-08dc91c728d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZnU5lUPdihh85N6TsKgXbdaLpl5/9gZ/uaOKJFaUY3GeOxNmwNuiZSNatmg?=
 =?us-ascii?Q?1om57/vr9tTBr3U4rV3k2jwvxS8Q7+rPjyBcNEz7DSrpVF9k9cN4mfB7qxl9?=
 =?us-ascii?Q?0933n/qF7fdYXVgyMDieeoTGpkhRvHR2QH3QyoejH86RlLVehJHeWqtWhSwx?=
 =?us-ascii?Q?SA3NmS5PLzsqS98cPecuLIXGdESHNC3AdbUOXIMOWUu56Yzj2nsodkDwIBx5?=
 =?us-ascii?Q?owPwZ/4/UjD/2rkDTy51IKaPhPMBcTUVY5pITM4ZXgPNZetG13kO+Y8w4Odx?=
 =?us-ascii?Q?/PcFqXPvn8FCTbS8HZ1kv1hIHR2L7ejYNSUHclqE5Ph5jkOeSZVeZaewPEeQ?=
 =?us-ascii?Q?5UhEMDJ+uIjK/xnnSr49yQduG8jnIkNt1snUvA6Z0lWTRUpZee7tDIeTevfX?=
 =?us-ascii?Q?GesFghdIT1Z6qHyb9nAqC+0WgGnkAwXQTTV8pjPtyXU6jV9JNgYAIlSdLOQb?=
 =?us-ascii?Q?SZWY/SePgD5F1lc7pXgqVEaRjjQTLoBeMMt5dIqkZ9qbduZCK0225ic6zI5h?=
 =?us-ascii?Q?V2KCPerS1whNAwNqyYu5tRkSz1y5bQ7059L/G69j/SLNYF8m3cjcuxabjovP?=
 =?us-ascii?Q?5t6vjBHDWSnzsTrF8VUQ7x1qzTG4/NkM0gRLKP/db1Y5xfoRifnWKZoZcXlR?=
 =?us-ascii?Q?ucVy87qGv/cdHogbIcIAYotBwPThCgL3TIlrasLHwmZLsAz4ZOMrwDWYUahA?=
 =?us-ascii?Q?+B80XtXbw+X3jlZEffYjcmEW5pqEi05STSgu6RE61ghNtfTWkWCjwQ0asl43?=
 =?us-ascii?Q?KkU4uEhrUE8aOb3UcuYQJTJ6CY2+GMqUlKHvV3YReSX1a1p4MgPZtj5wO7hc?=
 =?us-ascii?Q?y+MJtrzUcd+fpinQ07GMDgA+MIiz1D2dtOHeR/xbubD1FKSQqs6Gp+F2jhVC?=
 =?us-ascii?Q?hUG1maruvv+kE01z+2p59A7J+1rHvJ4XsuA68/aIP8omOWcMNdfPZP3t7xuF?=
 =?us-ascii?Q?USDkFTqRodZNpPGI6oN75O1qNcIZz904xWf/d8Z1W/sAIaPfLtL3gWhqEtQo?=
 =?us-ascii?Q?YBW77l/fCRnmlmc3FoydKzl9RQ9Xbhx/G24tVyh00nJAJByGQeItxK6mNOJG?=
 =?us-ascii?Q?bBo/IuYdGrSiuMfKSvFAxs14CVqL24j3n+PsaAkqKuQIqTUjIgI20WwUbIaz?=
 =?us-ascii?Q?XDnaWBbRGj43qdlbDsXSMcKDlTd/B7P5LDz0TRzhRD9ZyiJQC+AeiPEyARs9?=
 =?us-ascii?Q?kHCWB8+WGJOTWK7tPBOZZrlI7ezZQcWtJ52wqkRepZn1rLrTbbbNriIAu7gv?=
 =?us-ascii?Q?WKhn+Con0y7qWPHEnLbnRzEGzgKtbAfxG93B5RogtVYVfXJ5R/pb5UAUtm0M?=
 =?us-ascii?Q?NTpqxxKdPAA8lTwoFEogEjiWpEnSjFy7yNOXFLR56QfTnGIhYXf/va4LgKbk?=
 =?us-ascii?Q?v8i1CMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jwIsEacNDDjOrQ7+xJqPrnz4NEGB/A4eJmsJjmyE5/VKk1BYjXB32vKu7ZEd?=
 =?us-ascii?Q?Jc2JxtgIZDMhE9gR1DZiPa+26o3wf8dI/A4++OHzhDXsaJrtUN3bmbP0NtMj?=
 =?us-ascii?Q?4D0y/XKJSKIxsSrYTLAA6JuoCToXKBSX1cHax2eeM7w/0niP9vQLm2MnZY1y?=
 =?us-ascii?Q?Ei3Skkf2EBXnoNJ7BCAqEub0iJT7fAkcGa84Qb5YVuxdAfdBeW6cYIcvBNjs?=
 =?us-ascii?Q?pqzXO+u6d+PsC810wln2SuOsccU4KauI85V/4Hi7nFxh0WNN1JtDnapsrD12?=
 =?us-ascii?Q?Zh2S9qg4vrQPbqQwGPhyf3bkul/QdrqMTunvliG7iF+iQB/y7AZuSyj2wQug?=
 =?us-ascii?Q?FgzhpKWgSTdXSJI0EDyZgxtPaqeNLSMAs8yJFI+uwdZhYplU+L48fFwkuFe6?=
 =?us-ascii?Q?1RUw2vw/oYa9iPsC1FR+vi6Dzmdzg18ok8N/nCza1do3n3zbyZT5CnDSAPl2?=
 =?us-ascii?Q?LaqtOVMHqLOt8mZn023JgmnDLeN+/6hXUkwf764mDoprDknJAAcvwV5ssXfZ?=
 =?us-ascii?Q?GbIFR793exk1re4/WLsKzFZWf2nHpwZOOAksCWhmhvo4/7QJT2MVfJB1RjiE?=
 =?us-ascii?Q?npjuwWQu7+WiqNDGBom4a8PwI8hgIRN4narcRxBbtbPaav8jlXDzszLPVUIK?=
 =?us-ascii?Q?Wx174F/imuw8Wahuz5LmX2CDtOjWqNuMYtNwIVSuOrz+DaF7VTBoc2jT8LwP?=
 =?us-ascii?Q?LDS1uEj9J2xrChNbtr8uk3DY6udDk4PuomGsEqP5OYR3EJSvWtPO0EhUtsQy?=
 =?us-ascii?Q?h0CvRqoLNIqtuSnY7PR+yiCn6uByT14jtxm2qLNciW1mp+K1TSJn/CLRVhy0?=
 =?us-ascii?Q?u8f3OYkGWAMxd4dGB5yvi1/AsqU1UIPKFu3Kvq62FsO7BZstDdkGSlO7daNc?=
 =?us-ascii?Q?RDlpE/3s0LovpJ6u4Kp36TJ62vFVcG8uAR7tGeis0ZiPxm168WG8QuO6eQ+w?=
 =?us-ascii?Q?xorhUZN0P5dDqMCaVwP/UcENj8xx7sK9K+Y3jMr0yc8vDYdGf4bEu4hL/Qxl?=
 =?us-ascii?Q?X9sYnJ93YiFDOmBvCOUcfh84Xjvl6G484N7zEh2Dgri+6fzQXDtQJ1D1a4V5?=
 =?us-ascii?Q?Frl/BdCI4JtGWHn5ar/nfWLrb6iaEAeoNjW+rFVnVeTArpC8b7UikXEglHzq?=
 =?us-ascii?Q?iwCHliANT8zxwQhRDwf+BQSGkqwhw0cJsDk7s+qCdRjAjTLyPtOUxGIUDVSC?=
 =?us-ascii?Q?pscp+zIkLUdiRiL/9dKgA+E6ngK4/kwOsgLpSguCKPZP0rI12TQxRqoK+jL3?=
 =?us-ascii?Q?fxIxlBgyNWXl3EQAKGy6VMyxGEi5j3Lecp8P2tpABsYuvs3lRySks53fuiPj?=
 =?us-ascii?Q?z55TbZK5wtmVR//c9YSGLSDPX7vXYxibWYNL9KxpEi/We5HgfIZOLshXFiA3?=
 =?us-ascii?Q?opYR351AU7uhEjfYsg5FaynB9ycmudkb1/vYPPAN3L/JFE4iGxKytxoN0L1C?=
 =?us-ascii?Q?+nmsKpR8xxkoeu7ey/Lk0KmZNjZGdxwUs+VijlnwxngTz3yK09H8i96OHjNt?=
 =?us-ascii?Q?wfBOOwp33LOOT3lISxitJzYVmV9gTv5rDtQYBtfueLzMnQY65RrcaNtAnj3s?=
 =?us-ascii?Q?Mwq3oeI1kDzuS+j2XcdbXwjnN+dWhL5M/gLB/056?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a767eb-da12-489b-deb6-08dc91c728d9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:52:55.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaRMNjBWt3w0JDjTIS1YK2U04Wt/gowbZFyECq86mu9Wzv4j9oHeLL+KrPKDQNQCgUl7FxyEdWMwmFtoNDnJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
new file mode 100644
index 000000000000..be9f0f8f4e48
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11n Aggregation
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11N_AGGR_H_
+#define _NXPWIFI_11N_AGGR_H_
+
+#define PKT_TYPE_AMSDU	0xE6
+#define MIN_NUM_AMSDU 2
+
+int nxpwifi_11n_deaggregate_pkt(struct nxpwifi_private *priv,
+				struct sk_buff *skb);
+int nxpwifi_11n_aggregate_pkt(struct nxpwifi_private *priv,
+			      struct nxpwifi_ra_list_tbl *ptr,
+			      int ptr_index)
+			      __releases(&priv->wmm.ra_list_spinlock);
+
+#endif /* !_NXPWIFI_11N_AGGR_H_ */
-- 
2.34.1


