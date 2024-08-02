Return-Path: <linux-wireless+bounces-10850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E5945675
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 04:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0335C1C229A7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9342F127E0D;
	Fri,  2 Aug 2024 02:57:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE027D07D;
	Fri,  2 Aug 2024 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567470; cv=fail; b=T/GWunQvZ945Rkm60yApv0GA0IrC/JGdyVwhEJBqB4VogAXLhygAN+dZ+cD1JRpoOfZUTzlZhTA1qEiZHbNHt9/W0AVtvv26xHEuvj7I1EwxD+qL1V/LW6N1lYYMoFoZgHqqZk68PzjrduXtjDX8kFO5DjleVM8gGXgl7scv4ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567470; c=relaxed/simple;
	bh=Hj31UWyGA0IC+mVrPj+rbfZZs4gycOVcOkXoVDYffXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsCR+Hc+8rn7BNQ9OlyYfun0+7dUz6/R/Yk82D9obJEOKJudr2d23RHjfqXc/BqBRiqiz7t5e4dncBD0n1lItWePGxK5oKB4UdfGM0RWTVZvIe8D3yef5XXUFxtYjzc6A+luJgWPt8QuMjhxGYaDoJObOss6oXKhjn0HNAJvzds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYX7jMJKZu3PZyIUVvgfcuFPyIZ2n1PXO5OX7z8qwCiBBf5JameTuhYjiwZAqBVnzNYtPmxObmvfmIgIy5FEcVmKdzo37jkFRbR1uEaOQCh2JLT746k4Mhc32aZpmPtO29YV6TTxiOrR0iTrG9gAziTQJN4H7kn1agW5/wjOr9QgNZ2FtXR7A/9Zr5Pd4BgeWK0UfMM+TG32AjPA9ZYHXmR4XpGkKKdYzA3IPADLNjBsaCffPueWSVErKzEg6tKyvSrv8uKE/q6fuFDP9f19pBF2T3TACTIdrd7Qq6zlF+2bOnLI26p7Xf2hU190kooLtZKf8WocZR085mOFH+6Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAO72JuUorceKuploBqGPOSQX5RXcXw6TJTS1USCqJk=;
 b=ZqJwxosoCxm8H4dhgIeFxhzswoJKnpY7auKPSnF6GGW6fj0xb/Qje9lkCJk43CAYr/YzC3NzJMWQoo7c38aC3hQ8KSnpqYo3YzgpHLaX1zsc7KyRbknlLI9QlrnxAKV+BnJ/3g2tL74ouSM+gxbGMJvm2u2SSHBIJZskiOTP3dX61hQyimhE2zJ+V5DvSFDD1Aw77PIOrcmpUNOyCkHC6JH2hHuwfCpwFNfOPuR9s7KkjPIEuA3U6cVpDpZm8KrrYbMoUs6soqQ1wzVXZ53LMOudFoeVXICdPPqU+76823ry+ydZM3JywMSe4A+AD35fct7GQNQyLbBePuU2kg1lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8376.apcprd03.prod.outlook.com (2603:1096:820:12c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 02:57:45 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Fri, 2 Aug 2024
 02:57:45 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	arend.vanspriel@broadcom.com
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	megi@xff.cz,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v7 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Fri,  2 Aug 2024 10:57:14 +0800
Message-Id: <20240802025715.2360456-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802025715.2360456-1-jacobe.zang@wesion.com>
References: <20240802025715.2360456-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c940205-3505-46d6-6f88-08dcb29ee22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYWZRUc3KWFRQAIOr9w5WQlcC/jqDpcDOskjB4/AYUqvQtapxuzsuw+sJk+O?=
 =?us-ascii?Q?GOI7ZPuzIwgtRJEUy4JowuLIol8a8TTTvR04G+Be6TzcILCdXw/4dTgtO3vO?=
 =?us-ascii?Q?3rgB61M377pbw0yTU8vqI6RWqOxlj6mtDUA1PfI/q1ecI7ATrvmCOIo14Fne?=
 =?us-ascii?Q?LTOX87Nl197jnbgre8mpQ0KfOQeWo4RSioLbBPthVjn3Pjapvm8Bx8js1/G9?=
 =?us-ascii?Q?ZvSrJLQ8D+lPsx1Oo8pyewcoIIl1ujpHO8HrictVo792V/5nFJ4dwIkdnNtX?=
 =?us-ascii?Q?AouYKdsVWYnDbTNAC6tl30QkR85NywNuLMdNF8nvNqWdiqgRYiplI3QdEvno?=
 =?us-ascii?Q?I6Ur/h6/ygVCfatpbJkf1IH0aJwVzwkBQaqGsYxhPGEcqxVwDrYMvsvhlrbm?=
 =?us-ascii?Q?rNYJUCrAKtUumLbVpc2isMGDtKSnl10Zpg2PmZ3DbSYkDfaE/w+pHgcsLzEF?=
 =?us-ascii?Q?dAdvRSc5l01O5B6qx93wO8N1A9KU17QByV3qur2w1bzXMMSl/odrlcdg986y?=
 =?us-ascii?Q?u/x4XJfq9B2F+MbYjt0F0IT06j2jb1vFWUtv9SI6rDqSbzDxX9jk+cpr7Hje?=
 =?us-ascii?Q?hLOEDqZRH1JhXEOCJdqQl0XFrrkNmDH3f8KRS9fdS/KZRxrmKwTNegnFOlxZ?=
 =?us-ascii?Q?IjexccOCXN7D2+U4FXjbXYhuV5quVXs7VD9cosfOsIVGinZlD2S2pK4u6KAP?=
 =?us-ascii?Q?hVWuUQVD849/XTpc5dSOcUR8W8o3G/Xf3OALvKWG4iE+36kkzazqYP7+QQfA?=
 =?us-ascii?Q?u/dXZk4G7Jb3LthKHTWwNSZd5B/ACHZQAGeR2R8X6nVOa24LSFD6OlmBAu80?=
 =?us-ascii?Q?be5XDFbSFj/jj/+ybkkP8LNQ+DjixccMVAt6kyYxQ32IuzVCJ+kKYhzZRDKk?=
 =?us-ascii?Q?RBQV70qwHb3DL7jUUlZ5+bgMX32+E3kvZn/QarISUJ39/3csZG/2aSXtq2tE?=
 =?us-ascii?Q?LX9yat9R3IeiJRJ3sEUKj6HcXmRi8/5Y+mJghzoAzxRAGxpfwP8LQgqAl+Ex?=
 =?us-ascii?Q?maPEFuQnlQSEY9DKfxpOTGsGrDRLDjmxH9sVuxfGWA2cIUcBxcRUclenkv9g?=
 =?us-ascii?Q?WCq8QIms5JMEjgKM/aIGEJPIniYhuJPpwHp90kZbN6UZjeEjntwfoOCzjlWG?=
 =?us-ascii?Q?elsBjg1p/7MHqTsbVWdqrXPYJnxbrxgna3Nm6cS9t8u2RsJaimsbXZJRyGjY?=
 =?us-ascii?Q?41adYHDSB2verMR+ZuJHyh1f/99o35L23BFlRyeru/lEfB3Fh630/X9ubaKh?=
 =?us-ascii?Q?8k9OeFPMFnhWCnCPBCBojx8xyA1tbprXBZWKzptvT2975oQ9wLREwrXGeV07?=
 =?us-ascii?Q?2kuTSSVQ4mWrLH3uao9qlIBQiul4jkFdqrfTM+KAj+ReGGqd+3GOHt6zzu0S?=
 =?us-ascii?Q?4QbNBYEGy1PpBVOCnpbw/iDCXEIZhWR/VvLPjIthfD50EthwCNEjhiDSEMyc?=
 =?us-ascii?Q?Y2LfCDJwzVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Op77CUQGdBa6AHnhvI+i26MNCv8pboNPVZOqn8eLMV7XpUFoC9R69XDV7en?=
 =?us-ascii?Q?JXBmDKZaQ/wgZgk7i2LjSR6K+la5Y8KM3fJ15Jy9YHIzbutsH5fGIKq8sgcY?=
 =?us-ascii?Q?a3Yt0w7kYsy1jCRjCIPAG2yIgXjk/eAnd9a+0h9fsWxb4Q3BOxEzTO4huXvJ?=
 =?us-ascii?Q?A6MgJp4On/Xa+yYr31uC3xUeSIjUD9EnSBXlzUENawArNI+FFhYWD1ebMnio?=
 =?us-ascii?Q?dWmXlgyKnEWihDnZrffgFQ4y8hKjatsOj8xAns1UlmTn1YD8tYrNyDrCxeRO?=
 =?us-ascii?Q?0lFNNKIpbIYEtuy5FHGg+g4ZdWYfVw2pCTc8TwMnJ/0/2oEFeT8OD4JzsgIr?=
 =?us-ascii?Q?u5Vl0/rGWYMMB1apwuhX/FahhBpFyWbx7lBVzwBC2xhzI5KofuTe176Xgje6?=
 =?us-ascii?Q?JZKuIWjXIbEuFdzQtnlgGauUIwdiHTLtsRPqcMaFbOOo+RRh49szKqCK98Ry?=
 =?us-ascii?Q?ftZ5LnDvwieU/OsSimovfZAFnZbKgj+6UETX0b9QLaQxnhEPxCaH106D5cHM?=
 =?us-ascii?Q?+OjtbG+2fhUqvE8HrTfxNj9Q2glgLWvtcWsVx1nj33bobHnkB8O2unnHRta+?=
 =?us-ascii?Q?EOdhByp8jDn5Pzt9CFQ8wZgkDvSU4FGc2/VQ3kjQqOCQk8nLtmm7MDA4cHql?=
 =?us-ascii?Q?9PA3fDdDADyR9PiMjCfLSjFpFwUJC6JOK82TwlPQWKq+XgG1VRif54JR6W6E?=
 =?us-ascii?Q?7FoTGkhf1RMwJld4ni8IChUH2takye1sMwA+iNi3oIADp+UaI9ErWcPqEeFW?=
 =?us-ascii?Q?8X5ivEZ5z3eWB5tTs5rXWYEIZyrw3ovaNaiQR8mRgYWdskG6yKNimub/2vh3?=
 =?us-ascii?Q?m6/4sp/wxcQpGhjx5n8M89jLgY+P5g+4aYqzJh7WNGC2Ws9uEHqRcgA3F9Mv?=
 =?us-ascii?Q?VqvNEk1lJNGdinR8BeFBUWk1rMToV32HcdjWhV/JmQANxPCNAAw7431Hdq9H?=
 =?us-ascii?Q?zm+yxiZGZgwEvl8j8e453PSEYOd1WvCZjACwRErRFhboKsHttAkt50kZNHp9?=
 =?us-ascii?Q?/5QZ9vzYMnNR3+okbdVUjb0HleZ2NglCWCwzWszviap9GShwtEfa9Bi/zIlw?=
 =?us-ascii?Q?fqrBncXelMe1RgtRHa/KvcTo60DyyfYehotAFm65l+XKbbsn94fSw3PM1/4h?=
 =?us-ascii?Q?jGVcvb6nQY76g5y9v4A9axUyEUL9zDCMKkkOKXSMLSL6uDHzSXAj3wuUJD50?=
 =?us-ascii?Q?NkjD6pU6TLcqki2jxabDk+puNw6KdmmKI+N5P5z1fF02rziacAOIjZOJyELH?=
 =?us-ascii?Q?gHirzLjgcs3c9ygPlCtF4uzRgMqzAF3WDh8+f60qGUrLnLg/VFZnTwwD/3PI?=
 =?us-ascii?Q?hS15+lV1Y7MC0+33CZAbW902/bpMzacO71/irjs8XyhIzrxA11yuWFFlBX/d?=
 =?us-ascii?Q?IKAl2Ovc7LUVIOXcS5JZC2FSi5VD8QaRdqGiBPXhXIgrbqj9opxGmu1nxaAA?=
 =?us-ascii?Q?0fIFDQyO9HG0Vjj6pt1wLzlm7EMaMm45NmHT4raSd00uAt4dZOIzP8MveElO?=
 =?us-ascii?Q?F06tq/knxyIkBkJAuAcvsSwrLYkG+EJvnBe6f6rrrfRBYWtcdUdjzhgbBFxN?=
 =?us-ascii?Q?YoTBvI7XI03zi/Ibhmhn0HLv77/8XgApKD4JPjPT?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c940205-3505-46d6-6f88-08dcb29ee22d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 02:57:45.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGyaBiboU+mVcIaorx290VcoZmi7d41BFPm8D5pDUprC03T2i/AoeGJayI0w0yfWHyvJj/+MHCTt7QyJPALvaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8376

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe. Change function prototypes from void
to int and add appropriate errno's for return values.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
Change-Id: I21bf9e21b275452369dce1f50c2f092eded6376c
---
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 49 +++++++++++--------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  4 +-
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a62..75773f65a9076 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct device *dev,
 	return 0;
 }
 
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		    struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
 	u32 irqf;
 	u32 val;
 
+	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
+		return PTR_ERR_OR_ZERO(np);
+
 	/* Apple ARM64 platforms have their own idea of board type, passed in
 	 * via the device tree. They also have an antenna SKU parameter
 	 */
@@ -105,7 +110,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return PTR_ERR_OR_ZERO(board_type);
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -113,33 +118,37 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
-
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);
 
 	of_get_mac_address(np, settings->mac);
 
-	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+	if (bus_type == BRCMF_BUSTYPE_SDIO) {
+		if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
+			sdio->drive_strength = val;
 
-	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
-		sdio->drive_strength = val;
+		/* make sure there are interrupts defined in the node */
+		if (!of_property_present(np, "interrupts"))
+			return PTR_ERR_OR_ZERO(np);
 
-	/* make sure there are interrupts defined in the node */
-	if (!of_property_present(np, "interrupts"))
-		return;
+		irq = irq_of_parse_and_map(np, 0);
+		if (!irq) {
+			brcmf_err("interrupt could not be mapped\n");
+			return -EINVAL;
+		}
+		irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		brcmf_err("interrupt could not be mapped\n");
-		return;
+		sdio->oob_irq_supported = true;
+		sdio->oob_irq_nr = irq;
+		sdio->oob_irq_flags = irqf;
 	}
-	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
-	sdio->oob_irq_supported = true;
-	sdio->oob_irq_nr = irq;
-	sdio->oob_irq_flags = irqf;
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (!IS_ERR_OR_NULL(clk)) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		return clk_set_rate(clk, 32768);
+	} else {
+		return PTR_ERR_OR_ZERO(clk);
+	}
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
index 10bf52253337e..8111286fc4b0c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
@@ -3,10 +3,10 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 #ifdef CONFIG_OF
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		    struct brcmf_mp_device *settings);
 #else
-static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 			   struct brcmf_mp_device *settings)
 {
 }
-- 
2.34.1


