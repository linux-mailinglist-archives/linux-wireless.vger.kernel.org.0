Return-Path: <linux-wireless+bounces-11198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4C94CDAE
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47978B237F9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E131990B2;
	Fri,  9 Aug 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JCMBySCC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F55198E7A;
	Fri,  9 Aug 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196830; cv=fail; b=pIZItuPSEkYfFYk9Wi9zS8ojIxd3PA+AVgJyXDrWcfEIy/HS8vVczMI7s2578uUcUfDRjA0V/tQCt9AjdC++z1NJXnGuO+CddMovXbLt62Mn/857i9CWkvH4HA0fWf0HRtk+49DNNN67uikNvDUe/1UfNzMjTXixdDEXStkHoQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196830; c=relaxed/simple;
	bh=xKvPKqhPFcxDvxRT+XlZNSbIopHFE17bNCvofgIkhLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V20zr9/zAsL57vcdPp8gaIxqbghReltE1em74qvEbd3rb1ltgiJNPogwMU9KCpXiEJCCwhKxl6HpugZJoXIvqu+WqXn9PuR1f785JmOA25M3RXosJQSQvTsc/N2JIUlNjtCoTrX83nle4EdV/YDrw4mn/1YqisKKdZmPJdG2Z2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JCMBySCC; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgXhGrjcSx5hh8VzF3/SslH+ChT3GArYgc/LHYC2UjvoXEq/TS438dwghv2qpE1Ezqp4OL+Nv6cyMd+A4Zg8PKf85ugWgYkWuItQFzIguCUtpRsucAeRLlUOFIVZBL/v++d8h92UmVUNOuHIG+1xR4QK+mUnl1BaWqFPQuvs1JH8z04redo1b6mkK1c2QcpBSzaDcI1I22/3EXMF5XdcpEUtJTqPwcHUPh7n+daOgEMrVB/c4euGMPkSubRyRx8Ejtg+KDxVwRC2LgcVXkheAQYthrKh1IbvP4Iiqa0WBeM86qpojMQApqrM966BsNANCGvvsgcVAKBnHAih8FvY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX4zDpOaQmJjyeDmV1jRuzlR3oeTKyOqQha4c+FLJ2o=;
 b=wledxYsNZSHzKQCRIb1V41DJjRZQE2wImYbYuXUrtIWh4EWtyq/QhSOe7pTMmTPHIHCK+ecfpV26lyj3maivezDlDEP9r/fBcn4DoXx+Hk67w/NBoosDfuTKSihfFd+eAYB53HCMN31mwRvQX3joBJzynGKSIr2OmZyaTdYwtKPWYIfboUGKmtCTpevBm0zAxOIPgqnpIo8cPNGmQHeOZCVq54XaCwF/SS+nsvBapTgayNJFJf+UxAWCW3YK3o8XTjkuoPnxiREzSaE3cb7UfkrZOqUIVyYaI5kOAAZ2ped1twW7G0ieDFPn0E8iP2NDTvIrUJ7C3y5MC2aJYY3YBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX4zDpOaQmJjyeDmV1jRuzlR3oeTKyOqQha4c+FLJ2o=;
 b=JCMBySCC4RnqU/n41agO2OSojueJaZsSLz5yYsAYLtZ8lPVt2ObPVvUJ4g+J2tg6uayMoypRBqlJNCoUviStrGUNBERhlhk7MqEl76+PydPExAUy3HMYcHfLk8afy0N3AmdCTytdtrjni13yCQE53YMQukEangjEGcOBb8aPU+BGPtJDcnZ4Lm14zUTeHPHx14UcNlbJ57v+rBAGgIUoTS6sfUmSq7r3ORd/DWyW+AbeNLYURJnDY7Q/9kP8wsj8TwdO8MDyymly+iiBrgPkGc8Ml4QmbVndFRNafLiZFQYUIiviufytjIZ/03IVMY84LxNxchnhE/AZG2FFKqlgyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:00 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:00 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 21/43] wifi: nxpwifi: add init.c
Date: Fri,  9 Aug 2024 17:45:11 +0800
Message-Id: <20240809094533.1660-22-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 02b93104-c698-47d7-a8ba-08dcb85836d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ukg7Xr0Bv3OFMzT27qLUYfEoo/sXkLcnnKwkr4tJNe4u/fVRqhhPf9cUPsok?=
 =?us-ascii?Q?9xz+ANGYrAl5Sq1uNnt8Y00xmnOAk4jrdhtGwM20MyAVNqRisFMgC7VtuMIt?=
 =?us-ascii?Q?QAp3QJCiSMo45OzdsqOq5A1IX8n3Oxw0CfuUPnYc10hr9vH8IgugFIpluEnE?=
 =?us-ascii?Q?RAbzLy/kBK8iZsHLbpGaKFbuP9NZ4uKoauWepI/lB/y4thvjXIRNAbTWyaj2?=
 =?us-ascii?Q?pNoX4MsaLksIDV+qbVYExEvUXtKXu/SJdYcY9t9ME12KEf8NZA3R7ZwDAnYE?=
 =?us-ascii?Q?Ibhvglw+qZUQ5vJXb0Ne2EKxaswHAeaFd3w18BVAkNSbqrSpsavOw7cFN88N?=
 =?us-ascii?Q?5FYEe9rRvazW5El22JHU/+1+mSuxEg3/7G52zsUjFaaJraka2IPo6vJFTOum?=
 =?us-ascii?Q?ftI53rlF9TSfeZVs0eNuJq4dPilCHgN78hsPYrusV5YdzIv8MEKdSYR2uie5?=
 =?us-ascii?Q?8VoFqaQLNx5Zt2lR8oZaNoaQyXlXwMMuLPBoS3L6ifxlKLXPUU3orMYWUU5P?=
 =?us-ascii?Q?xytVpj0/alhOxr/F0sW7sulaQJLPCord4LBtG7lIBfnp1IMOSaAJDCR81mSd?=
 =?us-ascii?Q?Im8rSpBQDAOpBGTxw0VP5SXUTsyjiVl45tTdoR74G7QilRwWWSmTcSJtQPsO?=
 =?us-ascii?Q?uu50v/dx5clrISw6n/eQhPs/fni3xzADfNpZhj+YO49a7/6R5F4KA8vhd3KN?=
 =?us-ascii?Q?cLo4dHCqN6YZ9sI2WYj22jyHd3k5ye29vlGT39icM4/j2sS17/VCZ/3npacq?=
 =?us-ascii?Q?itBN5wh5uZvqQ69ciKpchbb65L7TUVEOH3rJtIV62/DX2o3BR49xg4/nHKLV?=
 =?us-ascii?Q?71yXadJdW2FruvMFTLhQetVe6ck8C9qqs1pUM0TpbMqL40BBRatqx+L4kzVt?=
 =?us-ascii?Q?8uLbTKdUrc2FApCP3+eESU7Gc3zJHZkpfI561RrsqHNtWtpNaiSPphRYnKdo?=
 =?us-ascii?Q?oEQ8+88lFGk58/LeTmZaqprKYPRrqXRYNuB9rWHlBAIb1H+FJ63SHAUkeyOL?=
 =?us-ascii?Q?CPNJutyuAdPkxVxJu05BY7YHoZlUU/abljQA+44GzZCdjbPXHkxGKlNErGtn?=
 =?us-ascii?Q?1BC5wb/CFklPe+WXjNJGgBWd3R0SfIjRpE3xuhVqZoKdJk0hhWhmZU26iMeQ?=
 =?us-ascii?Q?LtT96iXPv/Ib2b871W55Z6vRrx+VuyAC3PXhBtYnLRPB32JJlGFc+dKTipAA?=
 =?us-ascii?Q?+v3VIDR9+OwrF1A0NEm3l4ah1pt+iMy+iq85muBnvXmAGz88PfEsT12WOQBk?=
 =?us-ascii?Q?rY8OhbrftJ25tQrVmpn6tdc6DPRW5YAFriBtjONXaO1nQ9V5AJ5Nkj1i/kjK?=
 =?us-ascii?Q?kEuDHZBQzStgyuk7wHPWgPyx5d7xVa81OJL/+5KFYCMutw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nCvtqB1INoTecuF+I+WvJoNm6OjWMnkndPus/9yEBXVmhV9DUMf1y75BM7f?=
 =?us-ascii?Q?SpfbdOFubtXOKDWE8kP/40kTS5egZCWSe975pPPtyo5gfg6Gyf3vlPbUD32g?=
 =?us-ascii?Q?agRXK2dtL6wDGWVurB/VNJNMrXTy5VGPnf5sFBAq5OZIQICRtZ+AZwC5y5cJ?=
 =?us-ascii?Q?/8X3w9yEn7F8VQJeEg1jVSK6+wRNGim1aNTrll4N0hwoAG7VkG8QB1gM7fyc?=
 =?us-ascii?Q?5Q9cGrvoFF/6HVzfXdFGZZmVPbN7n09AtHBi6xs1S/m0B7KaowTx0g93sR0G?=
 =?us-ascii?Q?k80UBTIbGlLfym3OO31VmNX7E66binibzN0ptdEMrdwiw3EAXvDnM+A6mgZ8?=
 =?us-ascii?Q?vKv36IkMC1Y3WamViX+kc0u7XSWdqmEzQNBUhVzvtrynubllTOYqT7gQm3p4?=
 =?us-ascii?Q?NZ+OlYgkwMH6FzYSMGNzZ47X5sS8PDpSOEgcEWOmutgfw3gUYwZUQtLdJGDV?=
 =?us-ascii?Q?XX5yGsz1UWUh6uyBwIifJEmZS4RvfORYiira5bEfVQDDLXQFDzVO1uP+H5pc?=
 =?us-ascii?Q?4Riss+KT0OxOfMeQPA5rBkUVf9TiN8ZYEGhgZUjUjX90ppcjXrYiM5IfXjg1?=
 =?us-ascii?Q?8dWJ+jNxtd/8pEgOKgZeEVf05Axo/muALeq2oNtr9Rk68tf9UNMVD10zc0Cy?=
 =?us-ascii?Q?3t6F2icuMjCATmePzjyIY92+g3i1gL2cDTnnNYkLLobWJA1foKmXsmaS1Ovh?=
 =?us-ascii?Q?zCVlQrSrr7i5fnvyCLlPVx3kOTvme0yq0sVTj1UzvGX97tvC9GG7Mfp9wE6s?=
 =?us-ascii?Q?/c6Vw76mOE9MzcTTZ3kIuxNS5mP6NFXSa4Ja7NiwvQewvlej+j1i7owSiKPH?=
 =?us-ascii?Q?oW7nKKxnDY3J54FU68DjpNzCWwVs0B6NpdqblOCwqxEcb2X5YyNrvHlSCfpz?=
 =?us-ascii?Q?CYRKig92qU9m7TuigMJvwi8l+pwPK6JoidFGpRVKWMw6zwZfw7JJNoIZd6Xx?=
 =?us-ascii?Q?fHjv+LDIlGtOqVFuR66GeXLTd6mxvDWh2LMtOiUv59tlls2qtspFubU/ZlKa?=
 =?us-ascii?Q?sTVsjZtC8+/LtRYymrHaGGeWz7pkPqjgq0vx+cmczAknizrRZFWvEF6jIeoe?=
 =?us-ascii?Q?LaFqMCStSXZ/akWjuwXhZw5/YeKIhcdqG7RTRUcFwyYGBB1mJGuxzTzA8pVK?=
 =?us-ascii?Q?k58KJvLmbFXHA4A1wLPnOui+Tsea9wzOPtoQ/GEQZ2f+AkXNjXCTClT/uviR?=
 =?us-ascii?Q?pgjENLwVRrvJE1+7d35Y77LdSsgiHrapczLEsFUZa/qp5W0Phl2VAmuuvE8p?=
 =?us-ascii?Q?rrse5K4K66YV+0GYZUTJXYQrj6HQcQxj8xPBVqdQzCPhwVNMGnRkzSY6lLey?=
 =?us-ascii?Q?vraH5kJnjoyd0tCgx/bXL8Mtox1thI+JUmBSqGkx0w7FKRyMLPgEsVSiC/7s?=
 =?us-ascii?Q?0VftbFCzrCurZgRcDJCmv4WagrfWgX403pe1heAkMUZA4E0eLTiMD9TWVbvh?=
 =?us-ascii?Q?ayGBRukHkuleWzgCvRADli4Mwb7gPc8KRhC39zPPxADkXuaW7N13f7HWfEcW?=
 =?us-ascii?Q?vFcWax1OO9jhiIO8bPX+5xgtdEAxc2KOEEzH7KhpMPbXuEYkVh44kkTFCJz5?=
 =?us-ascii?Q?kc4llwO5Scj3oiAsJF4nnw04TmYWRxi0mM+sUkCa63rtvTHPa81wR0vuedgZ?=
 =?us-ascii?Q?7NPzeTNCULrurT2qSQOkZUWlgJ0eZNZjstmH9S4QTzPl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b93104-c698-47d7-a8ba-08dcb85836d1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:59.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG2tbCWYJsqyDQ8W8gLvNffKMvBdkiLRTrkyvp0LHIKAS6Jjj6p7fPzzUPtIEv8iUd62whpzNg+zlvo+cshmLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/init.c | 694 ++++++++++++++++++++++++
 1 file changed, 694 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/init.c b/drivers/net/wireless/nxp/nxpwifi/init.c
new file mode 100644
index 000000000000..05631f65aece
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/init.c
@@ -0,0 +1,694 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: HW/FW Initialization
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "decl.h"
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+
+/* This function adds a BSS priority table to the table list.
+ *
+ * The function allocates a new BSS priority table node and adds it to
+ * the end of BSS priority table list, kept in driver memory.
+ */
+static int nxpwifi_add_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bss_prio;
+	struct nxpwifi_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
+
+	bss_prio = kzalloc(sizeof(*bss_prio), GFP_KERNEL);
+	if (!bss_prio)
+		return -ENOMEM;
+
+	bss_prio->priv = priv;
+	INIT_LIST_HEAD(&bss_prio->list);
+
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+	list_add_tail(&bss_prio->list, &tbl[priv->bss_priority].bss_prio_head);
+	spin_unlock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+
+	return 0;
+}
+
+static void wakeup_timer_fn(struct timer_list *t)
+{
+	struct nxpwifi_adapter *adapter = from_timer(adapter, t, wakeup_timer);
+
+	nxpwifi_dbg(adapter, ERROR, "Firmware wakeup failed\n");
+	adapter->hw_status = NXPWIFI_HW_STATUS_RESET;
+	nxpwifi_cancel_all_pending_cmd(adapter);
+
+	if (adapter->if_ops.card_reset)
+		adapter->if_ops.card_reset(adapter);
+}
+
+/* This function initializes the private structure and sets default
+ * values to the members.
+ *
+ * Additionally, it also initializes all the locks and sets up all the
+ * lists.
+ */
+int nxpwifi_init_priv(struct nxpwifi_private *priv)
+{
+	u32 i;
+
+	priv->media_connected = false;
+	eth_broadcast_addr(priv->curr_addr);
+	priv->port_open = false;
+	priv->usb_port = NXPWIFI_USB_EP_DATA;
+	priv->pkt_tx_ctrl = 0;
+	priv->bss_mode = NL80211_IFTYPE_UNSPECIFIED;
+	priv->data_rate = 0;	/* Initially indicate the rate as auto */
+	priv->is_data_rate_auto = true;
+	priv->bcn_avg_factor = DEFAULT_BCN_AVG_FACTOR;
+	priv->data_avg_factor = DEFAULT_DATA_AVG_FACTOR;
+
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+
+	priv->sec_info.wep_enabled = 0;
+	priv->sec_info.authentication_mode = NL80211_AUTHTYPE_OPEN_SYSTEM;
+	priv->sec_info.encryption_mode = 0;
+	for (i = 0; i < ARRAY_SIZE(priv->wep_key); i++)
+		memset(&priv->wep_key[i], 0, sizeof(struct nxpwifi_wep_key));
+	priv->wep_key_curr_index = 0;
+	priv->curr_pkt_filter = HOST_ACT_MAC_DYNAMIC_BW_ENABLE |
+				HOST_ACT_MAC_RX_ON | HOST_ACT_MAC_TX_ON |
+				HOST_ACT_MAC_ETHERNETII_ENABLE;
+
+	priv->beacon_period = 100; /* beacon interval */
+	priv->attempted_bss_desc = NULL;
+	memset(&priv->curr_bss_params, 0, sizeof(priv->curr_bss_params));
+	priv->listen_interval = NXPWIFI_DEFAULT_LISTEN_INTERVAL;
+
+	memset(&priv->prev_ssid, 0, sizeof(priv->prev_ssid));
+	memset(&priv->prev_bssid, 0, sizeof(priv->prev_bssid));
+	memset(&priv->assoc_rsp_buf, 0, sizeof(priv->assoc_rsp_buf));
+	priv->assoc_rsp_size = 0;
+	priv->atim_window = 0;
+	priv->tx_power_level = 0;
+	priv->max_tx_power_level = 0;
+	priv->min_tx_power_level = 0;
+	priv->tx_ant = 0;
+	priv->rx_ant = 0;
+	priv->tx_rate = 0;
+	priv->rxpd_htinfo = 0;
+	priv->rxpd_rate = 0;
+	priv->rate_bitmap = 0;
+	priv->data_rssi_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->data_nf_last = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+	priv->bcn_nf_last = 0;
+	memset(&priv->wpa_ie, 0, sizeof(priv->wpa_ie));
+	memset(&priv->aes_key, 0, sizeof(priv->aes_key));
+	priv->wpa_ie_len = 0;
+	priv->wpa_is_gtk_set = false;
+
+	memset(&priv->assoc_tlv_buf, 0, sizeof(priv->assoc_tlv_buf));
+	priv->assoc_tlv_buf_len = 0;
+	memset(&priv->wps, 0, sizeof(priv->wps));
+	memset(&priv->gen_ie_buf, 0, sizeof(priv->gen_ie_buf));
+	priv->gen_ie_buf_len = 0;
+	memset(priv->vs_ie, 0, sizeof(priv->vs_ie));
+
+	priv->wmm_required = true;
+	priv->wmm_enabled = false;
+	priv->wmm_qosinfo = 0;
+	priv->curr_bcn_buf = NULL;
+	priv->curr_bcn_size = 0;
+	priv->wps_ie = NULL;
+	priv->wps_ie_len = 0;
+	priv->ap_11n_enabled = 0;
+	memset(&priv->roc_cfg, 0, sizeof(priv->roc_cfg));
+
+	priv->scan_block = false;
+
+	priv->csa_chan = 0;
+	priv->csa_expire_time = 0;
+	priv->del_list_idx = 0;
+	priv->hs2_enabled = false;
+	memcpy(priv->tos_to_tid_inv, tos_to_tid_inv, MAX_NUM_TID);
+
+	nxpwifi_init_11h_params(priv);
+
+	return nxpwifi_add_bss_prio_tbl(priv);
+}
+
+/* This function allocates buffers for members of the adapter
+ * structure.
+ *
+ * The memory allocated includes scan table, command buffers, and
+ * sleep confirm command buffer. In addition, the queues are
+ * also initialized.
+ */
+static int nxpwifi_allocate_adapter(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+
+	/* Allocate command buffer */
+	ret = nxpwifi_alloc_cmd_buffer(adapter);
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc cmd buffer\n",
+			    __func__);
+		return ret;
+	}
+
+	adapter->sleep_cfm =
+		dev_alloc_skb(sizeof(struct nxpwifi_opt_sleep_confirm)
+			      + INTF_HEADER_LEN);
+
+	if (!adapter->sleep_cfm) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc sleep cfm\t"
+			    " cmd buffer\n", __func__);
+		return -ENOMEM;
+	}
+	skb_reserve(adapter->sleep_cfm, INTF_HEADER_LEN);
+
+	return 0;
+}
+
+/* This function initializes the adapter structure and sets default
+ * values to the members of adapter.
+ *
+ * This also initializes the WMM related parameters in the driver private
+ * structures.
+ */
+static void nxpwifi_init_adapter(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_opt_sleep_confirm *sleep_cfm_buf = NULL;
+
+	skb_put(adapter->sleep_cfm, sizeof(struct nxpwifi_opt_sleep_confirm));
+
+	adapter->cmd_sent = false;
+	adapter->data_sent = true;
+
+	adapter->intf_hdr_len = INTF_HEADER_LEN;
+
+	adapter->cmd_resp_received = false;
+	adapter->event_received = false;
+	adapter->data_received = false;
+	adapter->assoc_resp_received = false;
+	adapter->priv_link_lost = NULL;
+	adapter->host_mlme_link_lost = false;
+
+	clear_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_CAM;
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->need_to_wakeup = false;
+
+	adapter->scan_mode = HOST_BSS_MODE_ANY;
+	adapter->specific_scan_time = NXPWIFI_SPECIFIC_SCAN_CHAN_TIME;
+	adapter->active_scan_time = NXPWIFI_ACTIVE_SCAN_CHAN_TIME;
+	adapter->passive_scan_time = NXPWIFI_PASSIVE_SCAN_CHAN_TIME;
+	adapter->scan_chan_gap_time = NXPWIFI_DEF_SCAN_CHAN_GAP_TIME;
+
+	adapter->scan_probes = 1;
+
+	adapter->multiple_dtim = 1;
+
+	/* default value in firmware will be used */
+	adapter->local_listen_interval = 0;
+
+	adapter->is_deep_sleep = false;
+
+	adapter->delay_null_pkt = false;
+	adapter->delay_to_ps = 1000;
+	adapter->enhanced_ps_mode = PS_MODE_AUTO;
+
+	/* Disable NULL Pkg generation by default */
+	adapter->gen_null_pkt = false;
+	/* Disable pps/uapsd mode by default */
+	adapter->pps_uapsd_mode = false;
+	adapter->pm_wakeup_card_req = false;
+
+	adapter->pm_wakeup_fw_try = false;
+
+	adapter->curr_tx_buf_size = NXPWIFI_TX_DATA_BUF_SIZE_2K;
+
+	clear_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags);
+	adapter->hs_cfg.conditions = cpu_to_le32(HS_CFG_COND_DEF);
+	adapter->hs_cfg.gpio = HS_CFG_GPIO_DEF;
+	adapter->hs_cfg.gap = HS_CFG_GAP_DEF;
+	adapter->hs_activated = false;
+
+	memset(adapter->event_body, 0, sizeof(adapter->event_body));
+	adapter->hw_dot_11n_dev_cap = 0;
+	adapter->hw_dev_mcs_support = 0;
+	adapter->sec_chan_offset = 0;
+
+	nxpwifi_wmm_init(adapter);
+	atomic_set(&adapter->tx_hw_pending, 0);
+
+	sleep_cfm_buf = (struct nxpwifi_opt_sleep_confirm *)
+					adapter->sleep_cfm->data;
+	memset(sleep_cfm_buf, 0, adapter->sleep_cfm->len);
+	sleep_cfm_buf->command = cpu_to_le16(HOST_CMD_802_11_PS_MODE_ENH);
+	sleep_cfm_buf->size = cpu_to_le16(adapter->sleep_cfm->len);
+	sleep_cfm_buf->result = 0;
+	sleep_cfm_buf->action = cpu_to_le16(SLEEP_CONFIRM);
+	sleep_cfm_buf->resp_ctrl = cpu_to_le16(RESP_NEEDED);
+
+	memset(&adapter->sleep_period, 0, sizeof(adapter->sleep_period));
+	adapter->tx_lock_flag = false;
+	adapter->null_pkt_interval = 0;
+	adapter->fw_bands = 0;
+	adapter->config_bands = 0;
+	adapter->fw_release_number = 0;
+	adapter->fw_cap_info = 0;
+	memset(&adapter->upld_buf, 0, sizeof(adapter->upld_buf));
+	adapter->event_cause = 0;
+	adapter->region_code = 0;
+	adapter->bcn_miss_time_out = DEFAULT_BCN_MISS_TIMEOUT;
+	memset(&adapter->arp_filter, 0, sizeof(adapter->arp_filter));
+	adapter->arp_filter_size = 0;
+	adapter->max_mgmt_ie_index = MAX_MGMT_IE_INDEX;
+	adapter->key_api_major_ver = 0;
+	adapter->key_api_minor_ver = 0;
+	eth_broadcast_addr(adapter->perm_addr);
+	adapter->iface_limit.sta_intf = NXPWIFI_MAX_STA_NUM;
+	adapter->iface_limit.uap_intf = NXPWIFI_MAX_UAP_NUM;
+	adapter->active_scan_triggered = false;
+	timer_setup(&adapter->wakeup_timer, wakeup_timer_fn, 0);
+	adapter->devdump_len = 0;
+	memset(&adapter->vdll_ctrl, 0, sizeof(adapter->vdll_ctrl));
+	adapter->vdll_ctrl.skb = dev_alloc_skb(NXPWIFI_SIZE_OF_CMD_BUFFER);
+}
+
+/* This function sets trans_start per tx_queue
+ */
+void nxpwifi_set_trans_start(struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++)
+		txq_trans_cond_update(netdev_get_tx_queue(dev, i));
+
+	netif_trans_update(dev);
+}
+
+/* This function wakes up all queues in net_device
+ */
+void nxpwifi_wake_up_net_dev_queue(struct net_device *netdev,
+				   struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_wake_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* This function stops all queues in net_device
+ */
+void nxpwifi_stop_net_dev_queue(struct net_device *netdev,
+				struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_stop_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* This function invalidates the list heads.
+ */
+static void nxpwifi_invalidate_lists(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	list_del(&adapter->cmd_free_q);
+	list_del(&adapter->cmd_pending_q);
+	list_del(&adapter->scan_pending_q);
+
+	for (i = 0; i < adapter->priv_num; i++)
+		list_del(&adapter->bss_prio_tbl[i].bss_prio_head);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+			for (j = 0; j < MAX_NUM_TID; ++j)
+				list_del(&priv->wmm.tid_tbl_ptr[j].ra_list);
+			list_del(&priv->tx_ba_stream_tbl_ptr);
+			list_del(&priv->rx_reorder_tbl_ptr);
+			list_del(&priv->sta_list);
+		}
+	}
+}
+
+/* This function performs cleanup for adapter structure.
+ *
+ * The cleanup is done recursively, by canceling all pending
+ * commands, freeing the member buffers previously allocated
+ * (command buffers, scan table buffer, sleep confirm command
+ * buffer), stopping the timers and calling the cleanup routines
+ * for every interface.
+ */
+static void
+nxpwifi_adapter_cleanup(struct nxpwifi_adapter *adapter)
+{
+	del_timer(&adapter->wakeup_timer);
+	nxpwifi_cancel_all_pending_cmd(adapter);
+	wake_up_interruptible(&adapter->cmd_wait_q.wait);
+	wake_up_interruptible(&adapter->hs_activate_wait_q);
+	if (adapter->vdll_ctrl.vdll_mem) {
+		vfree(adapter->vdll_ctrl.vdll_mem);
+		adapter->vdll_ctrl.vdll_mem = NULL;
+		adapter->vdll_ctrl.vdll_len = 0;
+	}
+	if (adapter->vdll_ctrl.skb) {
+		dev_kfree_skb_any(adapter->vdll_ctrl.skb);
+		adapter->vdll_ctrl.skb = NULL;
+	}
+}
+
+void nxpwifi_free_cmd_buffers(struct nxpwifi_adapter *adapter)
+{
+	nxpwifi_invalidate_lists(adapter);
+
+	/* Free command buffer */
+	nxpwifi_dbg(adapter, INFO, "info: free cmd buffer\n");
+	nxpwifi_free_cmd_buffer(adapter);
+
+	if (adapter->sleep_cfm)
+		dev_kfree_skb_any(adapter->sleep_cfm);
+}
+
+/*  This function intializes the lock variables and
+ *  the list heads.
+ */
+void nxpwifi_init_lock_list(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	spin_lock_init(&adapter->int_lock);
+	spin_lock_init(&adapter->main_proc_lock);
+	spin_lock_init(&adapter->nxpwifi_cmd_lock);
+	spin_lock_init(&adapter->queue_lock);
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+			spin_lock_init(&priv->wmm.ra_list_spinlock);
+			spin_lock_init(&priv->curr_bcn_buf_lock);
+			spin_lock_init(&priv->sta_list_spinlock);
+		}
+	}
+
+	/* Initialize cmd_free_q */
+	INIT_LIST_HEAD(&adapter->cmd_free_q);
+	/* Initialize cmd_pending_q */
+	INIT_LIST_HEAD(&adapter->cmd_pending_q);
+	/* Initialize scan_pending_q */
+	INIT_LIST_HEAD(&adapter->scan_pending_q);
+
+	spin_lock_init(&adapter->cmd_free_q_lock);
+	spin_lock_init(&adapter->cmd_pending_q_lock);
+	spin_lock_init(&adapter->scan_pending_q_lock);
+
+	skb_queue_head_init(&adapter->rx_mlme_q);
+	skb_queue_head_init(&adapter->rx_data_q);
+	skb_queue_head_init(&adapter->tx_data_q);
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		INIT_LIST_HEAD(&adapter->bss_prio_tbl[i].bss_prio_head);
+		spin_lock_init(&adapter->bss_prio_tbl[i].bss_prio_lock);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (!adapter->priv[i])
+			continue;
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j)
+			INIT_LIST_HEAD(&priv->wmm.tid_tbl_ptr[j].ra_list);
+		INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr);
+		INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr);
+		INIT_LIST_HEAD(&priv->sta_list);
+		skb_queue_head_init(&priv->bypass_txq);
+
+		spin_lock_init(&priv->tx_ba_stream_tbl_lock);
+		spin_lock_init(&priv->rx_reorder_tbl_lock);
+
+		spin_lock_init(&priv->ack_status_lock);
+		idr_init(&priv->ack_status_frames);
+	}
+}
+
+/* This function initializes the firmware.
+ *
+ * The following operations are performed sequentially -
+ *      - Allocate adapter structure
+ *      - Initialize the adapter structure
+ *      - Initialize the private structure
+ *      - Add BSS priority tables to the adapter structure
+ *      - For each interface, send the init commands to firmware
+ *      - Send the first command in command pending queue, if available
+ */
+int nxpwifi_init_fw(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+	struct nxpwifi_private *priv;
+	u8 i;
+	bool first_sta = true;
+	int is_cmd_pend_q_empty;
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	/* Allocate memory for member of adapter structure */
+	ret = nxpwifi_allocate_adapter(adapter);
+	if (ret)
+		return ret;
+
+	/* Initialize adapter structure */
+	nxpwifi_init_adapter(adapter);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+
+			/* Initialize private structure */
+			ret = nxpwifi_init_priv(priv);
+			if (ret)
+				return ret;
+		}
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			ret = nxpwifi_sta_init_cmd(adapter->priv[i],
+						   first_sta, true);
+			if (ret && ret != -EINPROGRESS)
+				return ret;
+
+			first_sta = false;
+		}
+	}
+
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+	if (!is_cmd_pend_q_empty)
+		/* Send the first command in queue and return */
+		nxpwifi_main_process(adapter);
+	else
+		adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+
+	return ret;
+}
+
+/* This function deletes the BSS priority tables.
+ *
+ * The function traverses through all the allocated BSS priority nodes
+ * in every BSS priority table and frees them.
+ */
+static void nxpwifi_delete_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	int i;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bssprio_node, *tmp_node;
+	struct list_head *head;
+	spinlock_t *lock; /* bss priority lock */
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		head = &adapter->bss_prio_tbl[i].bss_prio_head;
+		lock = &adapter->bss_prio_tbl[i].bss_prio_lock;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: delete BSS priority table,\t"
+			    "bss_type = %d, bss_num = %d, i = %d,\t"
+			    "head = %p\n",
+			    priv->bss_type, priv->bss_num, i, head);
+
+		{
+			spin_lock_bh(lock);
+			list_for_each_entry_safe(bssprio_node, tmp_node, head,
+						 list) {
+				if (bssprio_node->priv == priv) {
+					nxpwifi_dbg(adapter, INFO,
+						    "info: Delete\t"
+						    "node %p, next = %p\n",
+						    bssprio_node, tmp_node);
+					list_del(&bssprio_node->list);
+					kfree(bssprio_node);
+				}
+			}
+			spin_unlock_bh(lock);
+		}
+	}
+}
+
+/* This function frees the private structure, including cleans
+ * up the TX and RX queues and frees the BSS priority tables.
+ */
+void nxpwifi_free_priv(struct nxpwifi_private *priv)
+{
+	nxpwifi_clean_txrx(priv);
+	nxpwifi_delete_bss_prio_tbl(priv);
+	nxpwifi_free_curr_bcn(priv);
+}
+
+/* This function is used to shutdown the driver.
+ *
+ * The following operations are performed sequentially -
+ *      - Check if already shut down
+ *      - Make sure the main process has stopped
+ *      - Clean up the Tx and Rx queues
+ *      - Delete BSS priority tables
+ *      - Free the adapter
+ *      - Notify completion
+ */
+void
+nxpwifi_shutdown_drv(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i;
+	struct sk_buff *skb;
+
+	/* nxpwifi already shutdown */
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_NOT_READY)
+		return;
+
+	/* cancel current command */
+	if (adapter->curr_cmd) {
+		nxpwifi_dbg(adapter, WARN,
+			    "curr_cmd is still in processing\n");
+		del_timer_sync(&adapter->cmd_timer);
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+		adapter->curr_cmd = NULL;
+	}
+
+	/* shut down nxpwifi */
+	nxpwifi_dbg(adapter, MSG,
+		    "info: shutdown nxpwifi...\n");
+
+	/* Clean up Tx/Rx queues and delete BSS priority table */
+	for (i = 0; i < adapter->priv_num; i++) {
+		if (adapter->priv[i]) {
+			priv = adapter->priv[i];
+
+			nxpwifi_abort_cac(priv);
+			nxpwifi_free_priv(priv);
+		}
+	}
+
+	atomic_set(&adapter->tx_queued, 0);
+	while ((skb = skb_dequeue(&adapter->tx_data_q)))
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+
+	tasklet_disable(&adapter->rx_task);
+
+	while ((skb = skb_dequeue(&adapter->rx_mlme_q)))
+		dev_kfree_skb_any(skb);
+
+	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
+		struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+
+		priv = adapter->priv[rx_info->bss_num];
+		if (priv)
+			priv->stats.rx_dropped++;
+
+		dev_kfree_skb_any(skb);
+	}
+
+	nxpwifi_adapter_cleanup(adapter);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_NOT_READY;
+}
+
+/* This function downloads the firmware to the card.
+ *
+ * The actual download is preceded by two sanity checks -
+ *      - Check if firmware is already running
+ *      - Check if the interface is the winner to download the firmware
+ *
+ * ...and followed by another -
+ *      - Check if the firmware is downloaded successfully
+ *
+ * After download is successfully completed, the host interrupts are enabled.
+ */
+int nxpwifi_dnld_fw(struct nxpwifi_adapter *adapter,
+		    struct nxpwifi_fw_image *pmfw)
+{
+	int ret;
+	u32 poll_num = 1;
+
+	/* check if firmware is already running */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (!ret) {
+		nxpwifi_dbg(adapter, MSG,
+			    "WLAN FW already running! Skip FW dnld\n");
+		return 0;
+	}
+
+	/* check if we are the winner for downloading FW */
+	if (adapter->if_ops.check_winner_status) {
+		adapter->winner = 0;
+		ret = adapter->if_ops.check_winner_status(adapter);
+
+		poll_num = MAX_FIRMWARE_POLL_TRIES;
+		if (ret) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN read winner status failed!\n");
+			return ret;
+		}
+
+		if (!adapter->winner) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN is not the winner! Skip FW dnld\n");
+			goto poll_fw;
+		}
+	}
+
+	if (pmfw) {
+		/* Download firmware with helper */
+		ret = adapter->if_ops.prog_fw(adapter, pmfw);
+		if (ret) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "prog_fw failed ret=%#x\n", ret);
+			return ret;
+		}
+	}
+
+poll_fw:
+	/* Check if the firmware is downloaded successfully or not */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (ret)
+		nxpwifi_dbg(adapter, ERROR,
+			    "FW failed to be active in time\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_dnld_fw);
-- 
2.34.1


