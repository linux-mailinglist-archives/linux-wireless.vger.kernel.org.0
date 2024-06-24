Return-Path: <linux-wireless+bounces-9483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6506B9144A2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 10:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DCE1C20904
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006EF7FBA4;
	Mon, 24 Jun 2024 08:24:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C9762FF;
	Mon, 24 Jun 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217454; cv=fail; b=iYMWMJgPEvLMQSwy2PMdlNQRn5+YHvnv0lKZgJ0jCT+vH1OeL1p1Y3vCBs+EsCUuh+fKvpg58iQ0SdLrc0/cPg7iil/DckvNkNo3H+CVV9V0SFL86hxNOkF1Zqe3qHYc8bE64PrB03/98lVXxWtdI6eQlscRQxsbdADOeQRNPWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217454; c=relaxed/simple;
	bh=5x8qacw50qOCNZX/84FwUSO8mSQF8PunKiIffwR9EDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZoyMHD6kEV0CTFUujtw2Lj8KYM5i95+n9ylLmWCWgmyaILKd8/2pJT3W8bACCEooLEQKyFq8bKCOgmKsxmhfzrbxxjUwkC1wItjgungQTjUEMzRn9f81RcV0fc88GeqjQhLHi2CRck9pgznNDvRfRn8i7ReNsq2ZXTkZv/JEO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxaIWcf22e0MxNjpNOCy6hkVoJB7x3j8QhAnIild/1BGAUubB4CCxvXjlvn14MnL3RBPS10MEGO8XKRy/owMeqlxlKDMNgWwwU3JdUTlq72mC7736vARhEN5nNk0Eb5remF00W3AysL8nqa9GEYuu+GWHaFkDBlWK/ySykW11+mwNmntlpfguB9xTY1leMpeizoSftrRBGo4un3t1vlAc3ORVABN8lnDCn4Wu2C0sCl67w2jjAZr27cJJAON/1OkuIQo9lhgpKR9QUqYgIFoy5AtCpVZTZpZbShkeCrFJmQNxKfm/MjHbIR9SikNvnafXreV2FlAMZ9c0JOtKlm+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVtxdk8x4vZfLLq9NLeNtFKEm+EISHpS6u1vd+CAgzY=;
 b=YCnmL5RTzSGkKb7zjwQMOMAq9o7OKhiH9Dzzq0xhTDCIeMHFrV6Z66JN+pFdDEHETi+QUpO8yZodyS2fxs0sZ2ZSk3uLdLntfFnCe97/CdKVr+8wBCxH/HhLp7BdyvxRQIw/7yUcJl1v7vl8EWr06n0w7mzovmdzDu+4q3Wo9Pf/KkOXmord8ZSZ2kV6C5usCkmreLRM/3pmmJN67e/4y4ofkmUivs7lsYitNVQUvCKJmm6EXioSVLw+238AddhcaszzbWVN8mM2uBaXK2TZN2g7RZyWtG8Dq2SnUV4j9YfJlqJWA6DT3AyXZPO7LpGeWVA4ph+sE7RMTWFw0CaV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by OSQPR03MB8600.apcprd03.prod.outlook.com (2603:1096:604:290::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 24 Jun
 2024 08:24:11 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7698.024; Mon, 24 Jun 2024
 08:24:11 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com
Cc: kvalo@kernel.org,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	megi@xff.cz,
	robh@kernel.org,
	efectn@protonmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nick@khadas.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v2 2/5] net: wireless: brcmfmac: Add optional 32k clock enable support
Date: Mon, 24 Jun 2024 16:19:03 +0800
Message-Id: <20240624081906.1399447-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624081906.1399447-1-jacobe.zang@wesion.com>
References: <20240624081906.1399447-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|OSQPR03MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7cf8f3-bdee-4c1c-cd0e-08dc94270684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddgJBY8Wj8cDc+Nl3G3bYOxP58wO+mBeN4Y4ivcGsnAB4PhQik0T08oCDrL1?=
 =?us-ascii?Q?XH0IzGGpo2rfSa/+5z10QsmV6Tv77aogkXw9Kcm8c1CtlwO3h2p+O8nscMyv?=
 =?us-ascii?Q?sl+3jiXkp7/PJQZlhP8bTCAv7GbaBFXGPfoQlSeT5dzkOrTqEVr1+xpwVm7n?=
 =?us-ascii?Q?cr9K8dfWZIdY2XsWw+Ignggd/R5VyOSNIymzmLkJ/rXS00br6LAheZSVSwn2?=
 =?us-ascii?Q?mi4qmcsbUWzVEa4CY22LjWQyHPpYOIsV7v50AraNDcifeFdXxpSEQqWmNZ+9?=
 =?us-ascii?Q?xNRUxCZdX5HzcPv7vwRWt+dLgqp0i88pZHBjyGqECaWmaDeaX7WIgBmoCfGX?=
 =?us-ascii?Q?m14DIMHoaoudFT71gQSiNG6VVkWJXSB8iG/AbCs7kLUMQ9HRQ6Udf2uON0qd?=
 =?us-ascii?Q?lB94/mDJ9Xrne8/KaZS+ga6lh/Z52gy4plBJBbOq9Y6+Bmo+1HX5KNELVkPG?=
 =?us-ascii?Q?GtkU6LGPtvwbLCYup1v2r43ZfV2+8TpFlh3qNdbgz9Qp89TcMtRtRcJs0Vjo?=
 =?us-ascii?Q?1UxzYESMknlILa2gpNjg73XThUPpD1HzA9FtGG/9klJJ1Z1l8m0wvPFv5EFS?=
 =?us-ascii?Q?8SikRRxCqe5znCUW7vbARiW3BIm+rmgOM1/gNM9GR6SFZIHJn5pfjfy68Qma?=
 =?us-ascii?Q?jXOUK9XZjRP2DkkP7UnrK9PNsc/G4nacRRglefnG8wq6lVnLjOSFSajJQMMt?=
 =?us-ascii?Q?5GqTP2yGbiYUMhn3/7Vc7na/A4UutV/9glATjZXfUKU09EM6OE1xrh27JEmR?=
 =?us-ascii?Q?6LHflSDPkdCxHFlsAIZUzQtw9p+OFfE+PRbkqmALaUFvuLDJz9beyJWlmhXj?=
 =?us-ascii?Q?A0VQeWeJeAZC6xYV/paj33g8HvABOvvKQnlT0FFVgNIgJnLWvOw5w+SZvBCS?=
 =?us-ascii?Q?gGKgEVv/Qv+C1VbruEE75G15VV/ANbM3fSb4B3q14o9zbIk/IIeujnlPxpME?=
 =?us-ascii?Q?JyHc7S1pOpRZNyFF9ioD8E3VjG2ctK2y/JdJu+OqsSzmjD3tsDEIbeFxcouV?=
 =?us-ascii?Q?RQe+y5f+sVFn990s8IVRCKfoqMEvLvrA6HxwHu8RaXW4/G2FXi1Z52a/887L?=
 =?us-ascii?Q?Cogqlc2fwaMfggr+8wM716MmC63ccjbNvujSMOqQd2SbIRX6B54XMdVX4sqe?=
 =?us-ascii?Q?TOwylaT+9/4f16/+sTXN2hsygc+2mqqsOwbmumlzXblMyKVG2XM2SftOKTS7?=
 =?us-ascii?Q?jaFWyO0iB/qM/cefgrSrwA2AKjrKh4Zbrpi5V7kQy6wvvs59Uxn3vCzWWDDu?=
 =?us-ascii?Q?I14/luc3yz2aASLc9A/965RJoaNogIJCSJFoPMmqZDvKucdJlg33kv4Rqko4?=
 =?us-ascii?Q?0ZwTipVbkFoC0mJqNUxZGz9RAWbL4MingFLHJIFykKmJ4H/KhCTbkodICoJq?=
 =?us-ascii?Q?OMvBGJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETymAqVmfoqGVNQNxbA0yCe+a6Ov9ddimmZVS4V3PPSa3NZ0XTJi+R61bdQo?=
 =?us-ascii?Q?BM94+Oahh3eLon2/8E+bVdnDck0s3Ah6nGKjsY2I0y1B5RKlROj6KxZE3YiY?=
 =?us-ascii?Q?BWiQQYvULFUy1EWmhnONTFy9AHuo4T5E+edhgS5s9n7o6m3pq8vKK2rOqB9X?=
 =?us-ascii?Q?KQPCDAu4rU0kC/CXa5JzDAe6L40Uza9GibuWVCwsZ+rpUgjEZuiRrUg/fnAG?=
 =?us-ascii?Q?LzVTr+ASqLX1U/xC+PAeJQoyTzzMqef1FwiOQStjz1e5VnCqAB49d/QA0hlP?=
 =?us-ascii?Q?E3NsD9THl5XrR7UACvW4z3/tYVnMeLf/0lJfL0hmqtfEifJm6pXSo7iCmKPo?=
 =?us-ascii?Q?jhsGcPx2flcTwV6IcT2zur18NNnDk4DZxAPMoLCi0vddysRClM8C1jwcVUyJ?=
 =?us-ascii?Q?SnpEqiK672IpT4TVr+i2AjQvyNq4FlVaGFDAuCZPoIg0KKxbipRTn4GntqKP?=
 =?us-ascii?Q?tbIEaw+iCckmG2TnEyjKZV9jUA8C5sWiOLpoWXG/4SXOxeem0sWXt2JK2Fpi?=
 =?us-ascii?Q?GMMpCMTSE7nxo80yIC95owE2CuXG+KGvdkbHO3k+C29Ht9pft2WrO6x/Omb/?=
 =?us-ascii?Q?yJkxrRs8bur7fnZ3esR62ASo2MD4esorBTpMFjGSY8GiK3FHgZNbN8h6+iJE?=
 =?us-ascii?Q?6WLUyn4c/vH6EW4xAfqXN7o/RTYPT2Z8gvVUKpz37FF4Gqmgut7ex7URK4uZ?=
 =?us-ascii?Q?s2t4l1eKRfxzrH8GxsrLvhqvTlcA8dk6e6lXY+ZL/vonyNlrZD6pORM2gQFS?=
 =?us-ascii?Q?7DGMkEQLAr90LAzOysR5YUxgUs5XwFUCWwVY2/cQw1rCC7BbXd5YdPiEVtxn?=
 =?us-ascii?Q?JaeCGNJba8Uf7W0Y6P8gBS83ubLLRpxmdomM6PI6C+41vg2VXt6TnvEZLWI6?=
 =?us-ascii?Q?q+civ2sV51v+L8LhB0AneRl8yll2YzcOQQuyFJi7FK2uU5HkuM3Jka9eXXJf?=
 =?us-ascii?Q?v4hgZGS6DvsQgYT/mzHUeaARj0YktiqqTtZqS8uePUstA0mnnJoynZpUauRU?=
 =?us-ascii?Q?/azPCuKyaM6wVwO7H2aItaBj/6atxrEw42Sh603BdPNeOLKOmkaqB8Vtz8OH?=
 =?us-ascii?Q?QzoMQT+qbRPi2TvkLD5rwkTr0S4A3V5phJ6q+onMKSYDGGwukrFMbgzGDAQR?=
 =?us-ascii?Q?ZDDsjaCQD7NtnQqsdocNP2Pao/YsV57Vu5PjJfYoEr0rXAQ+h12TYXjhLQtJ?=
 =?us-ascii?Q?8BZ2NnUGRsgJy4nFeBiQl5y5Z2NiA50rgJFzb8oGmFQceqw2cXXzgJyA3bCS?=
 =?us-ascii?Q?K8soHRYGXsYlDxOuaXeIjf7EUYa7EkhjGOA1HVQvNOB12fvt8XEVYM0bJa5p?=
 =?us-ascii?Q?UCgYiXcorFaROUKH6X1CXd2uLLfEACJY1IDVZG64LkW4+zFwt7bZMVc74ErS?=
 =?us-ascii?Q?EgKhMxdQcZP1ne15FCt+EInQ+emH1LMKiFbATTFpLrKJJOmwIrQpiQOBORRG?=
 =?us-ascii?Q?mn6hjm4EQPrrg3KaPruvwFPo38sHc6v7AY8YQDrjuNGIftXK90giSFsNixSy?=
 =?us-ascii?Q?KBqnINMYWmo5131UzeppbMx6igJDCr+WkrjG62LJPCqRSNcUIWe8SIUZ3WLE?=
 =?us-ascii?Q?6B04lq4fpTXmjesvLl2OODm2xJ0xqqVujP0K53TG?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7cf8f3-bdee-4c1c-cd0e-08dc94270684
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:24:11.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nf582qAsSzUH4V9efmXW7NaknchpiGkgSk0iqCO/Yn6uSyBp2n6/eV/3NrZH79e5Grd8iF4ULvbixFdG3n5K2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8600

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 06698a714b523..4a7eb83a60ffc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
@@ -2411,6 +2412,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct brcmf_pciedev *pcie_bus_dev;
 	struct brcmf_core *core;
 	struct brcmf_bus *bus;
+	struct clk *clk;
 
 	if (!id) {
 		id = pci_match_id(brcmf_pcie_devid_table, pdev);
@@ -2422,6 +2424,14 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	brcmf_dbg(PCIE, "Enter %x:%x\n", pdev->vendor, pdev->device);
 
+	clk = devm_clk_get_optional_enabled(&pdev->dev, "32k");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	if (clk) {
+		brcmf_dbg(PCIE, "enabling 32kHz clock\n", pdev->vendor, pdev->device);
+		clk_set_rate(clk, 32768);
+	}
+
 	ret = -ENOMEM;
 	devinfo = kzalloc(sizeof(*devinfo), GFP_KERNEL);
 	if (devinfo == NULL)
-- 
2.34.1


