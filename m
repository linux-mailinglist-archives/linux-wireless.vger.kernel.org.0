Return-Path: <linux-wireless+bounces-10598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D593EDD9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421F21C21BB3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 07:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9814584A36;
	Mon, 29 Jul 2024 07:01:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0B82D8E;
	Mon, 29 Jul 2024 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236509; cv=fail; b=HgyIMP9TGFZIV9+I6ZLXSKVL4/qlX90QQJSbSfaYQ2/6Je796lVJCz9XlERBFZxnD4gKcNS3XOryFsXdp7izM2qlS5OFQJGbThAkKZ+GkSz0Ak7Z9PeYcudH06LxB7jqRZWUAdVxsy/0pCrLx0GBdqkCSznxONerZMY7LZF8dqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236509; c=relaxed/simple;
	bh=cXyDpjpIJHRlBBUmaIxf3V2a+SUXjH6qhWX4t0CSBeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EhUyDflFufIZq54HlE0McKK8ZPFOFyys34npM2iaoRK4g5awCNV39SGRkhJJC0kWiWEFK7mzQUnECEmtTyVEdSPhv4MMZOc1iM+m+BNP0yJZ+7ykaJs8ZtN2zoHN4CrIsZI8e+uOqtDYABQLBk8c3AMmqkJAhpP8Al4TfFyd+BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVVeg96k9o5VF9+PZDfyYi68Sp46EoLqxtk0U5+NC48OdUZ3PwBm82FDF2oOO9aOyH5ZaQpNeoT19aTIDWxcjohjQC1It6Tg1KY/4oZxZgWEhBz7kxqhK17BhIDVexfnsdksmQu/zRIgMEXKlFYLGXOfZh7P8yvcaq45xZiqCkfG6hyESIrkpSZgAgJ+d6JnzwSGxeEH1Z00PfCGIxiPB60CM4oAG8j/xfj7Y1xV0xX0qYEeh4E1hM5p/d3jWUTLzxXl0XdYOFW1MGFx2/Rm5qxDEj7eOyojyj9uIAd1Z+NeTNFsnUoAgvoZWilVl9GTtwGLpgL2iiJjVMtot8hKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYKJs4frLMyY/hHebaJZVjY+NW1dFhFvHLypRIA/l2U=;
 b=iTSO1mS6kISU5RDTw0tnkDYSZBNGflamOQx84wbxWYRiNqXWRtlw9VOosmLJREm8usrO8oooBNkI4FeKZ2V+fAEU8GquG0zs0ST1/C9RM0e2gsOItdqDQtROKHaFEIw9YLOr91YRJ6zRhHnxCxbpBUa0sYPHDh0dqzXIpDoxVNO6tpd1ZjIrYjVGsOGm+2AdjNwEd1J5ypSQfLRjWk0Kdfryweqm0/in9xQn+eIWBkRe0OV+tGVBunf7c+ct1JX5R862KyB2xXeHWswRPyksqWomgyqdy5UUN/n7QNsG17h6iJU7asB9/WmgReJCcKYmv/SbOBASbVgD4nI0PhOhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB6881.apcprd03.prod.outlook.com (2603:1096:400:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 07:01:41 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 07:01:41 +0000
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
Subject: [PATCH v4 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Mon, 29 Jul 2024 15:01:01 +0800
Message-Id: <20240729070102.3770318-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729070102.3770318-1-jacobe.zang@wesion.com>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::18) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TY0PR03MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 998c9d03-e556-4e1f-7a48-08dcaf9c4c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O0+qyjkQkBylSilyjGcy0dagB5lyFs3sU+qjJfu3eOg7+4Fz4MmME9S7GKtm?=
 =?us-ascii?Q?2Vcs9uc1bdme7UX1+HARLD/H26U2+p0cGVlqZq0sCY//XAmpOtazPK2m7GX2?=
 =?us-ascii?Q?xfLHjP2c3d5g1e3D/LedYfqDe/gSr96Q5A5epb7nzX2pklJ3msGnAOrXWUYC?=
 =?us-ascii?Q?sxu38L+eMXF+W1b+PaFHT+5dhQ+Jhx8UJiTKqK89HcxiynF8p8H7/2u0e+jM?=
 =?us-ascii?Q?EfxqTzgsZmHIRBn6OXGnTpkJ/gD1F2fhWR/b7fZrA3TrJU6IDEbm4iMhycfi?=
 =?us-ascii?Q?N3pdMQ5sa0VS9sfdQmPnpp7U1PqvH8B97t1FPDIATVjb5Y5Y3y28zmWV/N5b?=
 =?us-ascii?Q?i9vsSACfYN75J84tqoohssI4zU2TlD1knUpecdcdsW+xsWYa8W5ia62uVjWk?=
 =?us-ascii?Q?lT+3eZtvKfTU7AycxhHyh+DVtebriGFCyDX/ECcSKgo9n7EBH2Ob2v7+Aans?=
 =?us-ascii?Q?aCVn4AnTjqcd6QzXjXsKC5J6RxvLC4tt7QHJhStOMrgNjFULO/ukhibEXNkk?=
 =?us-ascii?Q?/tjRDk1SLCZluntfcQrdKGfYdp4i+789P0NpNLAlNhFjnh4mgczRn8HWeCuw?=
 =?us-ascii?Q?+yvRV2gW2F1HsYd1CcoE6F1XSUcbGduqeD/y9VCZ0Oh4AOgaQLpVWOdyiE+C?=
 =?us-ascii?Q?uS+RjNt+rUr70PxCRJVwB789OrK2Bp81iCHKTX0iNciehgZa5pN+sEbXGgBi?=
 =?us-ascii?Q?/7LuIFghI0OSYfWU0HfgWtZI7P6IQqIXKhQ4OQXy8doOzUJSdPOtGu0iSbvA?=
 =?us-ascii?Q?UY8fOHP52R19UrugYWkqNb5L60zsvZKG2FQh1YraHwMCGrvoioxWyvNn1aL1?=
 =?us-ascii?Q?4KMoIDvqvJR5jj7k5pKgAIQ/29uhuE5BaYkch9sW85688YVxTvldCTe+IbzU?=
 =?us-ascii?Q?GT14zDKfCk4YwW3ANxpEt5xzi32j+QnaJu9ZgOu3mvwTMnDVJe2RdnF3dXur?=
 =?us-ascii?Q?Z1q9d62eaWxvKbJtzD4voI052hlhMRra8/PlScOOQLQRBivgNu7xdCZiXK88?=
 =?us-ascii?Q?kfucroicSKvQU3aMnG33Gb1H4m23/pj6X7tFxPiIr6BwORgy9QrJ53/kmq8x?=
 =?us-ascii?Q?SfHA+rdoNMbMlcbByxhPrJ2MFtYTNvyStngudLCRTkKJlW3aVwj72GlXO3AV?=
 =?us-ascii?Q?SIYEv1k/1MqAB9ZbLoYtTNTSMFvHCKN3lJqazXiLzwEdWy8HSImZmhlhJJqk?=
 =?us-ascii?Q?QIoNH9w39HepLfIGVKdTYiktg3a4kjSSQ2jmgnGNkPIVKlnifL5F+iisT99n?=
 =?us-ascii?Q?lGc1i0vuw5CUOyknnEgknvqlTPh03wtP0ynmLIoAYVX114vi+8j3bLTz5/LB?=
 =?us-ascii?Q?XucTaqpqWdwK420oI/YHUUw0+KXT4e9BfbXASRJTbncZDFCVbKA7G/LDGD/V?=
 =?us-ascii?Q?O5Fkc8nLU5JZxO0M/LIlvWr5d3elL02zRIL5/tdmmdeeSTytGbdGVpFCWx8N?=
 =?us-ascii?Q?afCEi4tQL5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKbVvkpj42oYOm+R9e65BfOOJo0puAb+ScO1WDAsJFlGRn6ztrQCmQJ6XKaM?=
 =?us-ascii?Q?n3BXZthyfXwsEPgieoO7rTR5ZhDYAaVfIeA8n8eZf896srejOm3wSI9gKo58?=
 =?us-ascii?Q?Bn6F1MXxwXREAALFtyhQAC2S2gZifXRhs1krISGEmNbMaErmVfAZWiRtZaRs?=
 =?us-ascii?Q?YeQ7keD7ZK/w2K3ZrOWkGjDpOAxe1boU8CbD/PVZPVPUrKQnZ9wIv9sxaS/g?=
 =?us-ascii?Q?HQDugUmB3BTiJ5cDYajk0VLdNPLVW2vLEoJSbqZtXNKZdUpT7+pBu1DmIH9w?=
 =?us-ascii?Q?7x9yDak1twuQ5xs+zCgtGyD2dGcydzK82g3eUZ94IO2Z7wqrPJmjtCg3GUgt?=
 =?us-ascii?Q?es+mJnzxUyYbR6dpfPQIZT/KwWu/xWXkjWuu4fOAKNQdOHuMilDi6zlhiQ6c?=
 =?us-ascii?Q?mnv42EuC758EkwF5zSpNCFDcWiAewBvEH22BLA7023zniovYx8SZ2wW3ebDN?=
 =?us-ascii?Q?QcS68RZgGl0PTc0jD0sk8B1nWDEYdkrg4jJX+cmA3ZXA4xUl4HNzIp+8/YD/?=
 =?us-ascii?Q?4fHZZb+Hakgxp6YHmxYWx8r60K2pixpEF/KmVHF6NpE1m+ARr0rtbry1Dpij?=
 =?us-ascii?Q?HDrdDXCQzSiCaIIQgg91CVzFZtHjMaMLK6W1tSUzbbu6po1KfZ1vWaBmQ9NC?=
 =?us-ascii?Q?InnFSx821ioArg0fLmd9p2BQ1vF/UQ/7QTHibmM6iJku1Ek54R1vVj/i/vnj?=
 =?us-ascii?Q?OYj8GvUjJhSuIOJKHEFuHtTgQu7tXYw05l3kOtdosMx7VzCcFara6LhC24yY?=
 =?us-ascii?Q?+sf0FT+FKGKP8/hbMad/teoVgbP+ArzGxTMVbe6LCv/1bXc7iEsrJ6unWBV3?=
 =?us-ascii?Q?GA6bY0Vqz82D5dUy9PbMiVlK2sCixJIBeBDoj2LCEaicHTPxlzqWnCQDH5mn?=
 =?us-ascii?Q?sl3qxtxP+SrkIiuWh3uXNMOVrpxOUAk6h5ov+U/4WkFdEQP0r02j740VybaC?=
 =?us-ascii?Q?XeNH8Zd3EE+aApgmt/wmYdMLuAr7Fg6bZlvK5d79/5LGeFFRZp2GPlcGm9FC?=
 =?us-ascii?Q?ye3hpBM/GIUPhSphK2vB46x7VGmlsfTucWTT7fIUGeFN59B5u0RbNNwEJQ1g?=
 =?us-ascii?Q?8VaebtCJ58CpeOMTL4M2wv55cQ4fGvScqn9neDzkDhykcsvuSwUJeIQRLTFv?=
 =?us-ascii?Q?fg0apbJmISikDq96a37BBOVyw5EDaqH4ArR3hQ/Xv1UK4vlHJPs3q4lYOwkH?=
 =?us-ascii?Q?trW4VRIaHbRsQCShEgyMihl0kba0uSyiezVFsHehbi5RGIjptYskzlSqh7nC?=
 =?us-ascii?Q?G0tyDPTtZcl85u8Z9auXE0A5bWHA0t+UZZwn+HgoR//LGdoUPGoQjfZVxw7G?=
 =?us-ascii?Q?sj1MfaE3zwzdG7ebtFyxAITqKKBTI99cRh4e+QkNzG+NPt0V6kEVTxGUbBP8?=
 =?us-ascii?Q?l2dur0h05JN9d2JjHaJurpmH/rHorqK2CTwjeg64HNRjIcxmW8g74O66N0BI?=
 =?us-ascii?Q?JJCo9BPVjrmc+1dmkiRZP4zunhGXpr6LTnbGlwzPkAGacxIdAfvtReYKXSd0?=
 =?us-ascii?Q?MTyZMShNCBR2jd4hoA3kmNd8rheNt8gL/bt5SsH/XHYvWeaFbhYzSKXUE/7k?=
 =?us-ascii?Q?TkzYFPMHEMxrkXAy3j1ttl67WjXw/VfpSgKt28ih?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998c9d03-e556-4e1f-7a48-08dcaf9c4c8d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:01:41.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuO/4+HoiNfJv7yNSLNrQZRUZBLnu9NH1s9ZIe15iWo1Co4wL+rLMeRmV6eEcoGO9ZHLOabrvCyuu+J5oScMBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6881

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a62..4db188a41fd52 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -70,6 +71,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
@@ -113,6 +115,13 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (IS_ERR(clk))
+	if (clk) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		clk_set_rate(clk, 32768);
+	}
+
 	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 		return;
 
-- 
2.34.1


