Return-Path: <linux-wireless+bounces-11197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E055E94CDAB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988BD282708
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64514198E93;
	Fri,  9 Aug 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i/WEKTQL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF21953AB;
	Fri,  9 Aug 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196827; cv=fail; b=BjxVbxDHoP17Ix0bVr7DQGyzLC4H9/ENPZeF4PVhv7xJOkF1vMJanMZervQkvgGylEzzurPDYPTZNB+zlKKJjoL8btkt2q1MzLig2qEhoFqfVbOATliIGOzm71OQxW5Wo+RLYTXwY17x7I3RlW3e2MagUj0RnuCBJvSH1ZAnJQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196827; c=relaxed/simple;
	bh=hK7zOgcNjCbIKSwTuKqkFzBfM58GUiUG2NZiiwmSfnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YgIYgkWswuOEf/8/24Vk2kdeD1WCal2weYsKcPtTG5c7UZTjsnWzFrQoJTApX5J97NZVSN/QbBgpbPPb8eoBg1wswig+5pyA7/VsmI8zCaLZknn/8tVhgtDvswJp/z34hkIzESQdd7rdzKELjCzL/SNzs+pKbhDuUg7lSz3ML6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i/WEKTQL; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDZivfAiMM2hYl0UIndA3i47xLpB7OY2PkKTFosfuS02ltr6zbGEXtZ5XObq8osJTtO5VWSRA0G0bQystgt8dk9Z8TRIXqnDbzy8MoY0Hk/ilNXQpG3rA0JEEF+mwhgJGO8riRRGluVH2fQCpB+UFMQfJ/8fyP8jDFY40H2uFreDXTzmiG5b4ga6lrdKs4ufIHwKJgA1pzyZFSG0BdWGJOFnYYde1CR7GipVp6CSia12fs7i/dpxOKywv2PVSjrwQ4b8bGh5AaoBhAbMr0RWE9xuFlTbli39lsK5sQvuf3xPis+xYL+XVR/5Di8/dmJE5JWZalRQAHkk4Rk1vzBOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlL3lNRkNR2Ks9TWo9qIvoqcIZ83j5ygjGypIb8mm10=;
 b=tZYFivJXfFpLXu3VDjYdPD9p8Uo4QX3R+XV1nYnpYgCW4XT1Quqj5prAmgNYR5RcOYI6zqrTeACzxy2esurJHzWhAev3vS/0y9YzIgwbQkrqrANOuhPDxGdK6OgWWrgmVY4rpdn6TtOlqlru3RHYAUjjehnCWykrRpTWP3PErofxZaUV2RbIS6pmkTzQBxShmBgv9Td5e4YxZzf0lkjZP9WIa/gAwLiLTia0x5rJZ5yuqxLjDhmivleSLPJJ16cOps8JBTHjTlnV1sEgy9tL8EXYWGoY3zt6CUoF0ZWo1oPI4RWSstr1+owLnDlNr8CJCGtUrGyhe5rWXMKjszkY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlL3lNRkNR2Ks9TWo9qIvoqcIZ83j5ygjGypIb8mm10=;
 b=i/WEKTQL0zEiS5DRVy5vJjxKGGfP6nuydWWPkNeL29W9wWxjRhhPtxk1GjLwaKgwZi6TXJjAUaD+8GRzG7V56F9M6Lf2qGkTeJW7Dqraj/HvLyfBmhKORUfFwWf64055k4YnVJuNDal1zSVOv0DKT6wHUuXOG23oUjwJUK8lp6mQkZBocl3eNd3d8jDDxXOQhW4uX3V/mSj9kw4Vl+rj1FZ7DcN28QTm6cDp8zCwmQWMl7L6jg/54NkRhIcX++BlXcCDKUm+upBiA9+cuo8k3vpoF5+tRtyCXY6eoraSxdQzoshr76fiOE1hG3jsGjIHgktVZ4UeTNp2ooPctPqUIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB9949.eurprd04.prod.outlook.com (2603:10a6:150:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:46:56 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:46:56 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 20/43] wifi: nxpwifi: add ie.c
Date: Fri,  9 Aug 2024 17:45:10 +0800
Message-Id: <20240809094533.1660-21-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 898e70b0-5eee-4a10-f227-08dcb85834da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wzXYlrDG2h6kMb1fPKxpqq6hLIp32o2EGCRD8U/YDB0Gwe8BGs1eZVSzHH5?=
 =?us-ascii?Q?EDofhzCsPE/3MUmxjGbaRBSqYMOtTMWrKw5HFG9c/+3bnE45HklR1MIm4POB?=
 =?us-ascii?Q?SkWpaeKZyroixUfbkoXyKjGMI9Zuq6KoPVPU1PW+ODXay5PiZh8V/57pIP1H?=
 =?us-ascii?Q?3kd05+kMiNP/skO5ZGlVR6OzpsxzrNv58l1F+myVK3Luga9dmq5ilB2hNKy5?=
 =?us-ascii?Q?NnwYMKFEshKgKFeqxm3/NQ/JqZbIA8EFXLMUdVVVydaxFrByH1a+KLW8u8iZ?=
 =?us-ascii?Q?j9EZhJHHlIazUQP5qQcFCFAf5wH+wRYXUM5HFrUzgIVWHWl3T04O/dFmAfqw?=
 =?us-ascii?Q?MkK8VElsuW0f/DRVVfTpgMzO4PnMjdxz00sPZUiCQxqK+AUNMhtHremZbmFl?=
 =?us-ascii?Q?ZXRQ6J9TyHXSspEp0M7cFSe0aTcCAPFnYRqKLhNlgsAEVYS+LOhc0ljBpvkA?=
 =?us-ascii?Q?KNTu+lu5T8pCKRpBmSSjO1Ic5kXRHZmL5nuO3a4pfE+vpTZEP2v4EeXTxLvz?=
 =?us-ascii?Q?9IXqJgA8q1YZo4rc3DR0QyNwzmnT/1JQXfxvTAIxvr+g6HVdIFXvcOZ3A369?=
 =?us-ascii?Q?VaUS2LyNM04fas/ED2xAdlIeEgZLuiC3jfDPe2MfwZXg9O+RXflj3SLywx4J?=
 =?us-ascii?Q?MRE4ZX+Y3m7C7IeubFzXsCl0FZOWRPeN3pcOP3O9BI6CKfNBa+waVdUP0SXh?=
 =?us-ascii?Q?nB4fUC9tciNbO8OkjCdffEOK14l1gGnK8BRiedfw5MgpB8YbNORxteOiiJR3?=
 =?us-ascii?Q?MKQu6335hO89bWt2k6IPuduDCo6V0wyAhpnWHUfoaOhlzPKmflyxPSdofKMx?=
 =?us-ascii?Q?pEJHw0IMLoHjo3YHZ0U/v4bNyDKBIs7Sr46Qq+lLF1q8q4MJAAvjsjy5Zxl+?=
 =?us-ascii?Q?+A53E35L9VCHMrp8olkVaeJtdsGvG8gVFLmhxyhFIz51WAQX2BpE6uECu5/j?=
 =?us-ascii?Q?bSdCKoa1y5nf0WAellI14unCrA7PPkwu6BJ5aGdL2Eb9ffnfQdC7j3vF8bUz?=
 =?us-ascii?Q?TIfiZVEPbAsRCbtElDbhvhroknokoN/TAB5IxjzgslgoCw1euSCb3ym02CTh?=
 =?us-ascii?Q?ncUPW1u7hJV5CfADShemL07YBwE9aSdpNmUvZXSRMrHpByq4Eov1W0J8Q3JR?=
 =?us-ascii?Q?OeLBVcZlOurbI9I+Wi2ayNbSsRw5KZRn4cLPbLiVAJwzPT2FtM5WoKP24E88?=
 =?us-ascii?Q?0M+Wi6dKZ1niyLKeSF6IdZlBhnjmFnFWXyxj0SUXFUseDjPOj3xS355HHyPh?=
 =?us-ascii?Q?/TgThj4O4i4C9qMqwgk3GpA0Ae1Xuvy83TXOxJ8aPnOawBon9YSIsU+mHmYS?=
 =?us-ascii?Q?hqP8LjmzGgnTxY+cTCsOSPldcPG8DoiG18jRUAXnSv4ULw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fbZXaNYiyCxrOnQgDYBup9wk0s3iR5mMnWz7xA5FkGT1K8pPs5h9KZIOjCu5?=
 =?us-ascii?Q?ZEUxH8KFOnPnwf2TDp98FdBHQTbS4/KRU6AEKc5HQE8dyyX3azKSGOZ3JQGz?=
 =?us-ascii?Q?QyyXa2q7HRrlPHnEV/xJU023y1umKZu3Na22d/G0c8wAZGmrahZ/mGwaiMq3?=
 =?us-ascii?Q?MRiMFFBqn6ahB9DkAF87QyH0svny01hYcXZaw4mePTqc8HIqabW//F+2Z5p2?=
 =?us-ascii?Q?Vg2v/pz6fjleWkWeB7LbHwWSqxIVzho/2PN7GCyCGVS6LMfEzxolVN23IKzH?=
 =?us-ascii?Q?ESpvIoHbScgJ6cbDSRZ5snMq2SDfL2wKUJ74n26dwq4TNSACmr2tGBI+wrtR?=
 =?us-ascii?Q?UK1lEfZM7NnI4bCxLb7WLVE9JhZNGpv3Ls4U5A1QJd9enB2Zmgs9o8zssfcg?=
 =?us-ascii?Q?USBHv3KzrGAHTHNYDUtwC2qNpVw/y20F5oolhZG1ik+qV+PjKrAgi7BfVIK7?=
 =?us-ascii?Q?+YE+pyAqPTBQki7zvIg974LIdV49Wc0eQT12WwSGdT+MNZHaYbgXiTv/qfiL?=
 =?us-ascii?Q?83h5f5ElHhO3b9cleT6E32FDdjV2Ukwc3HsDR/2z0mHMbSfDpwyvEtjWROBT?=
 =?us-ascii?Q?qyJ9MdN1AysMmmqWbG/EiIWMAlWIhXMb6eorlIXZan9e1vMljCZ8WXMFlocP?=
 =?us-ascii?Q?7k28COkAu8JyboIAmIC1xMMjzsrOo5jkz+0fdKBsr1ELYGONUcFh8e3El1kX?=
 =?us-ascii?Q?Mfowyl+yYoZ1F/5/A7BbNGUt1jd49M2rSvqUUnwOY+HnuDF5P09QWBPa2iBK?=
 =?us-ascii?Q?3b7WHXmfI7pYA15ns1NWnPsZqX6gkX4jliTbKShO00SMhvoYhUBIg0sqCZ2h?=
 =?us-ascii?Q?aq0sxucqcomhiIQ3cukqbtJpDLJTtjFCGwChkBEU/ahkdfk43z4KtS1wp28A?=
 =?us-ascii?Q?Q6wMHz0PQv1xPp2AlaAmGJK1oRZanedL9E1+wvVPuyoK09H8Oh3K/+St88eE?=
 =?us-ascii?Q?HdpBxWGQCiKSr0MPFDjtfAXPhVjh2fn5tXvIec2dN4ivWFHbwBJOyvXGraEx?=
 =?us-ascii?Q?f3BBvaN4jw2WAy80JiPiCy1Ac7bZV7S52dVIavtEKORtlj0JGkIYectDBHgk?=
 =?us-ascii?Q?0IXsaKvShqkXJXkx9brE5imI4fZjDkSdi1GMcEctUX6oOLQngDkTG7DLgaLO?=
 =?us-ascii?Q?R2kC7OrdVFXr0BUeoOLsr03NPM1H3dCnyeNNoRS1+dudV746YXphDhNe72yu?=
 =?us-ascii?Q?j5krNS4b82YWVYY5nN4wuM9NqHCr3RbpYpnPSPO13UVagsx66G+40pDrS9dP?=
 =?us-ascii?Q?3ppFtDz4hRqPzfau9GES8TQa56rH4Drb7AoiIxeMr+OjI0l1/2eLN/Mhg7XC?=
 =?us-ascii?Q?jpmWWrzsGSDP9JtMCu9+jLgx0FTlp63q58VXEfXgzD9YFrpGfiLpV1VYDzi8?=
 =?us-ascii?Q?jOKcFfhEpkzyZ8c9Bg0NVgStmptgHDDghTtYwJRZhLl+rKjitGfJBfxPo/8z?=
 =?us-ascii?Q?Z3QJs9hkZPW8n9TE99GKIwFTCw2pgLOB9IGsLVTyhBEtdVYdZer8ENs0YoOM?=
 =?us-ascii?Q?uYYSuzJ/PfE+Ok3OZ9/oMyb+HZmH0ykGVV5OqLkWwDCUag2/4rhN8wIPXJc8?=
 =?us-ascii?Q?jkRqGmzVHjYnkrh+gIgaaTWYdxlSPH32B8HWHdJIJJqLs0IByUUrzxU1Kuhz?=
 =?us-ascii?Q?9ZBqPMCEDOb+vwNc9jMWhlSXkjcMPT9jajqSN2q5AoJ5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898e70b0-5eee-4a10-f227-08dcb85834da
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:46:56.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXnAMe67PhX7UZI3NARWw5cej0gpXiiblq3DSOCyKmqpJQZ/PmZWO8QREwHIlVNBFU5ovPvzm/z5DvNToUcb0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9949

---
 drivers/net/wireless/nxp/nxpwifi/ie.c | 501 ++++++++++++++++++++++++++
 1 file changed, 501 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/ie.c b/drivers/net/wireless/nxp/nxpwifi/ie.c
new file mode 100644
index 000000000000..15bdc3c7a6fa
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/ie.c
@@ -0,0 +1,501 @@
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
+ * Return: true: yes, current IE index is used by someone else.
+ *         false: no, current IE index is NOT used by other interface.
+ */
+static bool
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
+				return true;
+		}
+	}
+
+	return false;
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
+	return -ENOENT;
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
+			return -EINVAL;
+		index = le16_to_cpu(ie->ie_index);
+		mask = le16_to_cpu(ie->mgmt_subtype_mask);
+
+		if (index == NXPWIFI_AUTO_IDX_MASK) {
+			/* automatic addition */
+			if (nxpwifi_ie_get_autoidx(priv, mask, ie, &index))
+				return -ENOENT;
+			if (index == NXPWIFI_AUTO_IDX_MASK)
+				return -EINVAL;
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
+				return -EINVAL;
+			/* Check if this index is being used on any
+			 * other interface.
+			 */
+			if (nxpwifi_ie_index_used_by_other_intf(priv, index))
+				return -EPERM;
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
+	struct element *vs_ie;
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
+		vs_ie = (struct element *)vendor_ie;
+		if (le16_to_cpu(ie->ie_length) + vs_ie->datalen + 2 >
+			IEEE_MAX_IE_SIZE)
+			return -EINVAL;
+		memcpy(ie->ie_buffer + le16_to_cpu(ie->ie_length),
+		       vs_ie, vs_ie->datalen + 2);
+		le16_unaligned_add_cpu(&ie->ie_length, vs_ie->datalen + 2);
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
+	struct element *hdr;
+	struct ieee80211_vendor_ie *vendorhdr;
+	u16 gen_idx = NXPWIFI_AUTO_IDX_MASK, ie_len = 0;
+	int left_len, parsed_len = 0;
+	unsigned int token_len;
+	int ret = 0;
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
+	while (left_len > sizeof(struct element)) {
+		hdr = (void *)(info->tail + parsed_len);
+		token_len = hdr->datalen + sizeof(struct element);
+		if (token_len > left_len) {
+			ret = -EINVAL;
+			goto done;
+		}
+
+		switch (hdr->id) {
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
+				ret = -EINVAL;
+				goto done;
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
+		token_len = vendorhdr->len + sizeof(struct element);
+		if (ie_len + token_len > IEEE_MAX_IE_SIZE) {
+			ret = -EINVAL;
+			goto done;
+		}
+		memcpy(gen_ie->ie_buffer + ie_len, vendorhdr, token_len);
+		ie_len += token_len;
+	}
+
+	if (!ie_len)
+		goto done;
+
+	gen_ie->ie_index = cpu_to_le16(gen_idx);
+	gen_ie->mgmt_subtype_mask = cpu_to_le16(MGMT_MASK_BEACON |
+						MGMT_MASK_PROBE_RESP |
+						MGMT_MASK_ASSOC_RESP);
+	gen_ie->ie_length = cpu_to_le16(ie_len);
+
+	ret = nxpwifi_update_uap_custom_ie(priv, gen_ie, &gen_idx, NULL,
+					   NULL, NULL, NULL);
+
+	if (ret)
+		goto done;
+
+	priv->gen_idx = gen_idx;
+
+ done:
+	kfree(gen_ie);
+	return ret;
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
+		ret = nxpwifi_update_uap_custom_ie(priv, gen_ie, &priv->gen_idx,
+						   NULL, &priv->proberesp_idx,
+						   NULL, &priv->assocresp_idx);
+		if (ret)
+			goto done;
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


