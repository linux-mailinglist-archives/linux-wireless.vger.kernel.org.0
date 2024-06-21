Return-Path: <linux-wireless+bounces-9374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F732911D6E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01B6B23FB4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E216F262;
	Fri, 21 Jun 2024 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UkAwWe33"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2068.outbound.protection.outlook.com [40.107.8.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C516F0F9;
	Fri, 21 Jun 2024 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956395; cv=fail; b=oPwSqmtbEw7lkaYlwcTVkCrtSftmOMjM9ZFcXk82OWn7YEpDsXVtewtRxui3N/5CnM+67oafs47NF8C/4PJZfwYTpPo3DGvRc6COVHzZCum+aug6T57N1AzECqx3M6griL0uq1ussqEjlrAR2E/bGlrWyI9AQj/qlUWLNQD030I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956395; c=relaxed/simple;
	bh=3dplxlyXW1Zxy4YiHEztF/HjtUnRFoQ00VkskttUzp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oolwbWEkUh48fBftZOn8+mR9rORipqhNA5IjLGlZTQUj8jTtfgUoKf30zezo+swqfBO0ozU6qmQYoh6gTvImEVMnbpkC0CAzUydkoAe09uPcSWDJNGQqEucJCD86GwekR3lpl2vwDOEzBuCBPKFzROPOEesA9O5RSQoI8Ff76tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UkAwWe33; arc=fail smtp.client-ip=40.107.8.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO1HvPKybj4Lhm1QLuYtD5874AQRE/zsMzOX6D8s9+LHd/rVMsSZRTF6qkID6ICly3YsT/N3S/cWZLtNqxI7Doi2FsqkWHwXzlMU4RANPPJgXAj2bzWU5T9pIuCPDJgoY2HKF2UKym9q1dAuzGjgF6xseY7IHTC6lr7BRQQ/JjCEPWlOVwfhinjxgciw6ZXnjrp13r7uCFaV1ikgjUgG18Oe+AXgICl5enzU9fMUZc7mxfeVzlYE+EPL3WnYVFA4kyL6qW3KY1WWJy/H/coaNWK7csqsryA+bG+lRTAh9/QBOWihK5glL6BCybnF1v+QIj5uA+MtBg731bYQmz5KNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO0oyfsuJoweQWi578zh5DQ2EF8aGbVqEv8amPR9EFw=;
 b=WeU+LL6bqrp6xqlisHjNYzjQzW5jd7rlKrpLigbHJqSaZy43LnBR92rSjvr9zkmS3zb4IiJNG3ohTK4CtnlTO2LqHSwbWGU21SDaYQL2CZEiW76OfCpDcOQlG7O3ENoFnSf+PdsiwF2hppq/WzsdPXM1G9XYZX2pttOe/tr5o+qiId39JUMfLnRXKXY6RVCSQlF7MGajhp7bzfpTt8Gi3HcOQzAXtNWwYlPYi3QTa4NiPJRTOZlbKDGtA36E1Vjox+J2pDll2uf7JwfqPGYyXq9jGYXvDY14caw9YebJMYeYQduuU0Z0frL/ipdlzAGqeYV/fsKVbvY+V3u+ofBmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO0oyfsuJoweQWi578zh5DQ2EF8aGbVqEv8amPR9EFw=;
 b=UkAwWe33AQnQVDtpUx5UMy+zN9nB1qtku+j5cZpKauOPYMeZIqjsZcGjd0AicXdT5blnZpQF9qAMYIFksNs/LQ1YPI8lkO1Ep1JyFsSj43IsQGy6mUIk0jYD53twghT6vdK0qMU5shxxVwi0VUN4j9RXpHZfH9iCCrPoamX8WjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:53:11 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:53:11 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 11/43] wifi: nxpwifi: add cfg80211.h
Date: Fri, 21 Jun 2024 15:51:36 +0800
Message-Id: <20240621075208.513497-12-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6090dcfa-c2e5-4d66-f139-08dc91c73259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gIscUlDGZRQ81VjOpuF1qa+VI3WljGnyhbRXiwbNbyP7KN47lAnWoIXk0s1d?=
 =?us-ascii?Q?brm/bK5JYXnRLVsOCYWvWpQTmkiWjCxNEADypEx3z4uw9aiWqMYpTOm4wM8Z?=
 =?us-ascii?Q?s81dFmiQ3rK/U/Kd4+kekLzoNbwgYNqpQ6az6lJKNYX1/PesLx83K6Lj2oPs?=
 =?us-ascii?Q?ba4f2XkZ3Uj8mcgxGh4KiTowdzWh2+YbYNodhvxvolFXNZlea2m20zrJiMFW?=
 =?us-ascii?Q?b1QCer2ZJKfMX7ut1fysIGZZvkekAeXbBSBlz7YI6xnYkHIGuH9cmNxU6Ld3?=
 =?us-ascii?Q?8lE2ns0JaB2d7amgeESyKqmWsFQA+7ODaJlwMuQE5FRRZ9Y7UiBFFLPERaaC?=
 =?us-ascii?Q?wiA7tyKohVTD9CnRGyvgO4My/f8IYfBar4gmRRVBlyP8C2Yt3ulubM04Kg0r?=
 =?us-ascii?Q?f6Y7gOFLdO/xJBa4L6JBFjdrGsFp60121tS6ldRp64XmizkEor/08Lo0lURd?=
 =?us-ascii?Q?Ta4lIK56Td5grrYtvfJHh1fLvJICg1/5S2kfVkZZK1AGR1n1pyoOFX4EvBhV?=
 =?us-ascii?Q?4R/gt7FBtFNo5Amr6LKq1IgDAfcObrj/jbGArRWgDpMzUVQM7qGQOkoG/ckX?=
 =?us-ascii?Q?Ur8xUgJ3HezKgbuWeHva71XzqaJETeSWo/04cWmuBx2Hf/KJikYDEhjJcul1?=
 =?us-ascii?Q?+aNAZO1LDrxCeIeR6SUdojXl+uBSdsN2jqGVU2mRKtBDAuA6LnU3AMkY5UGP?=
 =?us-ascii?Q?5BQMmVXwR+sJekGSpi0mKPRTR5akcd6J5KSNjsO6LsEI5Tq89gagLnxiA535?=
 =?us-ascii?Q?gIgC8iGPVbep+XNObLVdSmRFSzrHIUaeNode9YgVSLRGGQLtCpUrd9knq0ng?=
 =?us-ascii?Q?40wQ1ZJwqrc1KYV/mKn7J57L5cvBWPG7HWsQlKHAch4R9SHa6U8Cj4iE2hu+?=
 =?us-ascii?Q?7fnPfmCbAbMAh5uBoFXPdkf7tMXvN0VPuHu1UYN7nkXAHanwVnfOwrr0Bo2s?=
 =?us-ascii?Q?zcmOAhiN0Fbqc5X8S98mrr1bQ6bdaq1BZ/G7gp22doBiGTQGKLf5P9cruSPb?=
 =?us-ascii?Q?4vYalpZKWt2KVN7DD+rXXRaLf/W2HOGO5p3KAjOt4AlDb7oPiv8mjcituTWz?=
 =?us-ascii?Q?GYn3QIA0r0IDQNNEHDOzmfA1/19gr16Pt98Gofigo8xkJ2Ht9IcNcr/735IG?=
 =?us-ascii?Q?XRJCnKDG081Ylui7edXdOdhZGFOc51tFLdoA/smJK/bZ1+3TsH5WDWXZRu2D?=
 =?us-ascii?Q?gNVnFx3YNZLDQQwqW+VtHcpC552tbr1xjRfUPF4PaRH+m/fkh2azbuB5VEd0?=
 =?us-ascii?Q?xxk7EyMtofKJal0kpPV/Dhlqz9FkKzxq7W+eyfqGgMq3jO027K9jZayYN95e?=
 =?us-ascii?Q?pbPhLcry3AO0e84yH4DrK9d9vaTQTGmnrTbhv1Vv1fc6ZIm/jsHS1btoaVOb?=
 =?us-ascii?Q?5kbLWXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5hY2wsE3StsnZkYjDHbMYD5uQFkjyWQG0YbTweoYDYlW2C5p+HpMNeZaQpL?=
 =?us-ascii?Q?NNQTe+AszuO4307TNAq377yqM/J0v0NPWzpDSN+XS0dWh7Bx5fN5cpNqmJY9?=
 =?us-ascii?Q?fXInB6Svey5nf7JvyFKwgTxLVm0PdE1MXdrUCTkGiIqcGYxsZPfsJrVCqTAa?=
 =?us-ascii?Q?IGDD6Et4D+c/a6fzv3GE8d9eV4lXch+vEeB65s4aAKsDBUp5XoHEIpEztIn+?=
 =?us-ascii?Q?LltJF7A7ajYIFDAep/tAhDzO19G9ER5nCJfuylVtgTAUXIojDoJQhRpnBq6l?=
 =?us-ascii?Q?6on5eQJqBa2qwKoZn5n3Xbst3FWXzV8sLiq6XyZ1telNp1Qp8hxJ6kfcyU7g?=
 =?us-ascii?Q?v8cStNYUBov6yMTXkg+SiaW4f1gjH9Pei4kCbH8jlyBQX8ZG5eoije9i3Tqu?=
 =?us-ascii?Q?eBtnvimqTVUoo+GvRZVXuSxV/SpGbVCbyPTIRB3oFsvYwnXF5ejaJbmXWbAw?=
 =?us-ascii?Q?speyKSOP83ZDvvrrx05Ibgmc2Ca8AjcwX0OFVcpnvZk3YsB8dXjjicznqL+6?=
 =?us-ascii?Q?FdnKanlEmy6cXOFYEgVGP56HxtM6fJGtyocUeuLw8e/MlPOafHdlpqrURxBc?=
 =?us-ascii?Q?a11IaIjNgFea7wZ7+g7B1gBT8frSpdMqmdP4e82HC5QIuEsMTYNB2Bx0PxpQ?=
 =?us-ascii?Q?/S0uIqj3yzgXkPgtTs84LiV98q5wqrkc5zWXpxxdiRvtd84rQmPBhSoDeWGQ?=
 =?us-ascii?Q?ipAaBT2jO6SCFivF74BWP9BcOpK1h8ABvfhECauDG5hxbVldbf0BR06W2TeT?=
 =?us-ascii?Q?zotZdJElmlc/eesa2kZlVMwp6l9Gz5sbLiFZa7uTkT5G3EpLrWdmTzFiWzJq?=
 =?us-ascii?Q?lWw2pTShYTXO1DDXVrtpMEMGfwvXMFQ41nk1gvYr3cUHjbbpCho8bPQpbG2q?=
 =?us-ascii?Q?VugvyriwGDy1gb0O4bxkMk2kl8PCHByEIqO/9V+kpF6dO5MBT2Pl56dOAhbK?=
 =?us-ascii?Q?xGvCv/iEbjaYjS4P2QT0YJYuCMuEWAWTbctkFdEPYHw/9P5Z/IKFAhvpP61Z?=
 =?us-ascii?Q?JuQXp1c0okmx3Q9SUo0WWgt8dEo3ixf9Vdfqx3oYhbowEkuxTjK+7slQjS6+?=
 =?us-ascii?Q?x6yolHsiZ8eD+zSABOAc1iMARzbcSKxz5maJ8WnS6k5jYx+TGyGHoFp0cGs/?=
 =?us-ascii?Q?Ih6WAoba8CwVe6bSic83RfwYq9YgMQOeEIL/ZUDggdPE8HOvWc664/gCx+P0?=
 =?us-ascii?Q?oUar7YHs7yWcvjEaYqS2EmK/cvvjVDZfnTJmT+Eq+mWbYKlJ1pt2zR6L2nQy?=
 =?us-ascii?Q?zvGePe2nIwtQ5fKrLzetXgO7H5JNh3dtwmt3Jogrq0f48w9k8PUL8SNWe2No?=
 =?us-ascii?Q?N0D3QjRMAK5yMt8f6D9ojsNope8rWjK8OX3cN88Rj2fbQyD3EFBo/a+jcr6Y?=
 =?us-ascii?Q?BiRCE3wvL4u4KAnDUaDcpV0MXxMwgvDsTLQRyjhvw2N25iIBrYFwsjWmO7EG?=
 =?us-ascii?Q?lYjuvYWBqq83asKqaffkobyIS6O7dAUdHT4DNKKJi+pkt5DjmezoDkmYJVgN?=
 =?us-ascii?Q?Bz0J+yIrWMcgCu5Xa1y3cckSTmVmjTY1hPMZm56jU5whidMd6oibfyzJ1KdT?=
 =?us-ascii?Q?QEr72XrMKhBhgApjp2eD4X+7KmVwl3o0D7dw46qg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6090dcfa-c2e5-4d66-f139-08dc91c73259
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:53:11.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkRIHgbgwhK9Nan4K+jZlUptqwP6vrTZVeC3DOP6FVwS97c7+iJDrM4FCwbFMbWOGDkXNMoKyPK8LO3CRzodbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg80211.h b/drivers/net/wireless/nxp/nxpwifi/cfg80211.h
new file mode 100644
index 000000000000..086ec9ca4cc9
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg80211.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: CFG80211
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef __NXPWIFI_CFG80211__
+#define __NXPWIFI_CFG80211__
+
+#include "main.h"
+
+int nxpwifi_register_cfg80211(struct nxpwifi_adapter *adapter);
+
+int nxpwifi_cfg80211_change_beacon_data(struct wiphy *wiphy,
+					struct net_device *dev,
+					struct cfg80211_beacon_data *data);
+
+#endif
-- 
2.34.1


