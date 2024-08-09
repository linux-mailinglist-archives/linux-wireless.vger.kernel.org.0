Return-Path: <linux-wireless+bounces-11182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BB294CD8E
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551A2283AB7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8E193090;
	Fri,  9 Aug 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c4NwyK7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE67193073;
	Fri,  9 Aug 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196772; cv=fail; b=WL/dOZfzm2W9J9IdV7KKSDPi1bEXlRNdbpfe+p4b0+pZUXHVSq1Rn8Y7h0WmBfIoaF6Oy42dMVtX9gfelkDzay+Zo/VGq34thsXmNzdyfWZRdKl6xgKp+DrCL2poskALJi3mK8Zfb4EpLC8f3XYqdCzyGIt2U82uUobNqwQ4wgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196772; c=relaxed/simple;
	bh=1PYHA52R/1nqpCMGwdQLlFvxUwx/4pnaicj2K/AnL0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tG+0RQ5v60KEKtMBpwWszQktnXUFDGiyn2TZzYxlFunCU6GpL59JjegAdY8z5MuSr32OFxosHQzTo1nvlyIHCe55Yilq0nWzb2l5m0CFM7Dh7TjXKp4B4psHpLU8RAB12YUTDetwKMaX0MTlZM2CjCTYoAlqNLHoj3UHJf3HsTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c4NwyK7q; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKLWnG0GLd+ctBpycvoh8cjI2gBbTFcy0uQlcEaR5Gt7qOn0QCve6WQ37i/tuiloE08r0ZKFE5e7vtKq4QHcuOrAu0l4NcKZIZSjivA0ujfSEv/g7kQEVgjnccVImnj0459qmSUTFj0kbwr7sSyUOCh8fEY3HUDpp5nz3wW2GfJxR/0qjAB87lvbBtyoW8jzfwHyKi/ryMUbK+S/bmgQRZ8qs1lai1R2Te4StkOruyUGoM/tEfgArKEozqsES5oXvHOWQ6HkNIUlQEcBoxgWGAfvlQHv2x4YPM1t8BB2KKXn/hu4BBxK8T0l9IEZ68BKnBjrnDXUn3Am/B2K0XIt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2JYIEZb85X9tKSGLC0rFm03ywjVIAcFU04p57FJP7Q=;
 b=LNW0onlzqyUW1qWcdA3rV6gW6ElZ7yGy1j9Jdo8SafG8VGuf+t4MkixUqePI0pvJ3nq9PytXwIDn+ixJJdijzNT3YLCvfRGXZRWHrOTocsSBtF+/hXFzwNzbcMbVoZRk32OsyV/Vg8kxe4zr288WhUnuXqY2W1Tq8hwq4AnlFLkMy5zUnUV/u7yNlyAYXNbqaAKwc6XBiU+escASFSfl4A5nzp7TCwphz1KLRRD1ip/dynem0qLfDbo50VnHe9MdWSoq2noQ/6JVDZ+ibhbnH212qKcjQ+DOp7A2PbZLbXt4OqfqbKJur1q0TudaZf1tEgnRZxuMgbu96bHKBeXJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2JYIEZb85X9tKSGLC0rFm03ywjVIAcFU04p57FJP7Q=;
 b=c4NwyK7q1FP6OUaJHzLgmMR1ah+DfDeXBm2/PE6/7QC+tqw1xjWHi/RAUyn8S69pjOKAKJ823cAtPewzwzD0axreYspALbEFsA7Fa3mU/stXcjjwqzzuTYDzgp3lpH06GrsDHrncRhh3X1yqak0cSGzxqVPpLCeRHvnV1ViDdseubjcFTBXXrVS/q+fvPJK15fMNfQ00tuMaOxgVCuEMm9d5Yd/4aKMfaTghFYqnDxgsrkST9MD0NBPA7X8TX435UKGSwehMIB8u3mGvLELjnuOXIBaTrlJWvgeXhzcUnq28XKiICQ2YxYBHVzMc4KIXFRuty6Q265G94lCeBLsvRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:46:07 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:07 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 05/43] wifi: nxpwifi: add 11n_aggr.h
Date: Fri,  9 Aug 2024 17:44:55 +0800
Message-Id: <20240809094533.1660-6-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b5f62cda-65cf-4ba1-f207-08dcb858175a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nhv+EPUR94wZbO76TK9UV/l266aCKVyD4+TBEPOBex79k9EkQ4ncFkie2U1P?=
 =?us-ascii?Q?DDB8FuFD2+7/z2hDqaSRvDQ6/L/xZhpc5rO9Wu4xKMom7KgiGfOVoSuwngrD?=
 =?us-ascii?Q?pcmraG4LkzXa4NYw9MyL0xeHMfFVhfsfx2yKcR6jOp6YA2PBTRSR0T+ef6Y1?=
 =?us-ascii?Q?nPvOiwmMUcLz4pB9leWhuJEX4V1VElTGk5CjSBw6eJf/X0Jacp14fppQ0SPS?=
 =?us-ascii?Q?tXUldXm2nAFCPprNjFYfazE/YS+APhQClQXi+9U611U2SbY3wer6aVP9hM4d?=
 =?us-ascii?Q?I5wOCTy1Dcjiz41D8snQIn7iQToccazBEV97/jNYxRHOQ/EYJxzZ+xHCswue?=
 =?us-ascii?Q?ZxGcFDN3JRsrOVZTky1A+vglsCHbLY7yWldb4HLajiLyNWWx25v69VjPleRv?=
 =?us-ascii?Q?RikfjfAXhI5hKKZHA/z5FGlvha8hiiHAhudKjQt24uuEJoAd9llakXs73tLy?=
 =?us-ascii?Q?45mbxs3eHBoo6Rbc9vYKZphgBsQbKucW5yiWqtMeLB0lZM54QUP5i3yg8dCy?=
 =?us-ascii?Q?qsqb6D+PgADY1F/P8SxzedwPfiAdVouC6fF+UPuxgYvxDK8MuRtOZd/HsEw+?=
 =?us-ascii?Q?/KEYX3gQyiGuFK7oO0S18GwwFmv7QFO+SckySuztcy+t9tEQVhqNrch5zUE6?=
 =?us-ascii?Q?7zTc07cPsoUK7nkUvBLCg/RB5dXITHW+Mu27tfduBM9nTbyKqDkNztcAIzdj?=
 =?us-ascii?Q?punxXupxLZb8suEwpOKJ+/dtGcTyo5xUnlbTESEAXHzd8ATa5YnaqLNh49/G?=
 =?us-ascii?Q?vVODg53/8xxQzmwzuA7BLIjuR9H5dkDQ1V+3ST6sISDsnXFiKDGToSge4OT+?=
 =?us-ascii?Q?hvKZKGF5ZsBZQ/FVrMT5jXr0ZqJPK4BlZpZCwXriD0TKCz6dpgUSeDFByhNy?=
 =?us-ascii?Q?R5zmvtCd0RfM0p/o0U1i3KnkPSF6mB9Yb0F50TdkgPfZLsiRw4bDiNPTa7kc?=
 =?us-ascii?Q?IrteuP2uTCWW+hp+tkt+W7Jc3Xhv+rJYasZZXDSboLlN+Z0USe6LSpNf7NM2?=
 =?us-ascii?Q?eTZWIvPIQCylCOXOFQbUKPTun9oYQVhJu71GC9DkIXVjhyEUMbmvGZtg0Qju?=
 =?us-ascii?Q?YfSWRSj432ucHtuIL+xOPwPics+hFVRfO5T6+qBPA3tK65xYJFxxV8riEBUZ?=
 =?us-ascii?Q?t9J4OC5J8WlIT7GWrgiYS9mIrrxH9aWeLgq0RyxqMP4uqTVEp6FZqH5K4eOQ?=
 =?us-ascii?Q?WKcV0jbYX+l0BEfSqjvVb2UMKCotxcXYH/uHEzpt914o8Xc6nCWbUbAJicln?=
 =?us-ascii?Q?NDfKR/5nPke9s/0pdIIbhKZ2peL+bH+2ay5eLbYrt03Rf5NblRpLYMY8kO4i?=
 =?us-ascii?Q?/x6LqdXyeZzKlFm1u7f5oMDLrGjy8Pd6hoMGcoEWpxeUMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GmGMDYK5ZfaVUqgHspHnZBdDcuUwQTmrMcDo8aO4eIIp/4HyGSeHa+VIm+Pj?=
 =?us-ascii?Q?qhuygpQpVNbF3GRwFW0deuA7pzv2dIYeZNuYEm8rWFzxCoOoNOO+e78VUxuy?=
 =?us-ascii?Q?6C9XSvDUzqgUg+ftuRMTtXVrOO4dCIHKdgbTweDbnild964nPmJ/sN7otxdX?=
 =?us-ascii?Q?2wDFghFvD3brSc341JdTdujdpoGGtB4AS1TTkxV/lyIw8wPmCuUafk9pTLSy?=
 =?us-ascii?Q?FjzDz8wDz5r0fJcrKe4qcTvk5pv8PrOBP/QmC02Q2dBsJmfturxwPmpwHy3z?=
 =?us-ascii?Q?ocaBOtwiFgUDWp1N91aQrkODtHTK3snDy5TbK5Zo0SaMUXfuDLnXfjr2s+tD?=
 =?us-ascii?Q?laKkAu3aT36FJGhH4xGLLivR3rLZFvovmB+F7gJTIurmU/p9Es7PZ1ntB8Yq?=
 =?us-ascii?Q?7AtZrJJIsw+TVXEeJY1encLkZHwuXhcPXpjet9LPxcKtozar0gS3putHP6RM?=
 =?us-ascii?Q?QoBW4FPTKn6ErykNYVE/9ulc+Bm12djmn62XHwJ2mLg6IFoS2u0W5j4w73wh?=
 =?us-ascii?Q?XQsIyi4tmuWvXMYwoQCSjzsTzs21yQuYmBw4FRZak/2qMfwJl3cMCuP5vxqr?=
 =?us-ascii?Q?AJuY9X4HRDpSjJhX5QU+G031GCGuCvSq9arm3nVEQsyAkZ9RZytEPxQfZRc9?=
 =?us-ascii?Q?+mrwO3q+yCSp+OWbBi1Tath/8vrATRiOj9dUKUJHNu5RzCVqzuKFZfAVbFWB?=
 =?us-ascii?Q?W3fI+w5Fxct7uTT0zQcBfzsGmyVbglaYY1Fop4yK+A6NYwqmU4fTjXZiq1C1?=
 =?us-ascii?Q?4M+C2Mn8XFvrkdlHGSpNemneP8Sp2tVoYCNBrHrEzTHijL7IMK+xEGofrfIw?=
 =?us-ascii?Q?mpoydmt2fkE+ymBF1obyei+wPw7r6vIqdwZW6DT+dm0oR83Et2F/GDAf2krw?=
 =?us-ascii?Q?/eK1bSQUruoFI3VPnrnr3y8BOzrrRaqsEFEn1qlbh61n+L1eQazEwzXHEntE?=
 =?us-ascii?Q?znUbPiBWU6O0TwrVsuhy9kSGU5wuwWH++s7Qqp40Z9ZCUCluxHf6jqDuTmxP?=
 =?us-ascii?Q?eS7v0u0aJyD0yOPbATyq1LrGm8Y6tuas19Su7vP/Q58tnS44GM1C7w5eyOEb?=
 =?us-ascii?Q?ev8UlwSoBS8FabySwBM6Vn6XWg768Xcqmh2sa0c+c1Wj/5YXaRAH+r2NRWpt?=
 =?us-ascii?Q?L3a6fwIic1LFME4EYjuJghTYzZ7sGPhL2orclTOzkkagBe6/CduF68k3nYFE?=
 =?us-ascii?Q?Uap5hL4nqxAiCKjyU7rBtUKduWbMjAx8IQZxhKRCsjQdM6aRw1Thy//LGNQF?=
 =?us-ascii?Q?5+N2nMfFNhWUHUkEDS2GrUBWK8nuDtqg5wtXE974plBHpBpTTUNfAjq10DFe?=
 =?us-ascii?Q?/KIfDcQPOQIO+JmY5UqR40X6AAoWtJ/XX4Bgo/pzyd/FzCLuGEUk+P4BEfco?=
 =?us-ascii?Q?Srnjq6Mq6gd/ejCNEtD8wCBi+p1T+5lEw2M27lB0PC2wW1dyGuNjUZah/9cU?=
 =?us-ascii?Q?v2oxEAwy/MXudmf52NQ09rSKLOgn9bo5C9nlUFW9sXSADVboiR1KDAa4Qp6S?=
 =?us-ascii?Q?AqLZmE6rKIdU4iPGsDu8OZmZnBKObWVHsKzsaafKSWGykvrgv8aCfHME+tSY?=
 =?us-ascii?Q?Ao9Wh1Tjt5WQ5BXovzr1J+D5J1xQ+jXjJQ2p2LXtEypoX4t+D8EufkTrZMnd?=
 =?us-ascii?Q?K0R5kvlw4+wuAR10VQG/HDLWndCW5aucJeGFTjfiDGXM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f62cda-65cf-4ba1-f207-08dcb858175a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:07.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClL5zfgT1eaLwHURsHJhAcB60zt9q6ng/n8775Z9GPXpnpPINd6lL/6pNQ+dfzNqVc4k9rsC1ebiZd8SoadcZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

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


