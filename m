Return-Path: <linux-wireless+bounces-9260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B577D90FB23
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 04:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE84283798
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 02:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686122EED;
	Thu, 20 Jun 2024 02:00:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1A1DDEE;
	Thu, 20 Jun 2024 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848842; cv=fail; b=GtDtwlMfTmbQ/D6/6AYwoOqRnKQpGoq4NvCaHsWkkuvu6SS1Kf8EZYhV1P6NQbdxiZHvb6HH00kyTz16T+268MPAu/uFj0XCi1UClbBMXqU4m2+V5ZAA3iRJeksTYDqXmBZ6jSOf1AJoH3oV7ZrnOyjSkhHQek/4nbYFSPpLeYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848842; c=relaxed/simple;
	bh=5SjvhV8LsLkXpc92LgrhOzzGVhdGbQw8CnCP6pHW+3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MAnpmUqNKoO90OCXwH4CZk6JLxJM+zor2AvGj3ecfgbT87K65snGEugyrKGMRKd2pRnCvE6mlpXzz8oOJ931l/xpdsu3UOt9Ptb6svqpBkmJk5NCpwBhlto89phkDo3LX1uAHCNeooIAoIhTQkFkNdhrYdDkdV8a14XPFMz+NJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjAtLp4ogYh9Av550FuUSPy48Q+fPNi38asCXdkT6qWlga+eqV1FH0qXvlJWb7vB095FnBfqTw57o7jJwK7ys07bbSquT9Mwn1lVhk8z+asm11YiYVdYIlWX/wYWL7SzO+hB30WtU/yNHBV57Q2euOMDRFwTcI5FRt4CG9eHw228uTm7I82dR2HW1y1aoHj4dX094hFPw50qY1vhnotnofX7+/AV2KkZahH33hJHdO4V4H1uPOynbPYsrg4aViB1+5FyB8Jx/YBqJgSaGK4NrqE/RKXjMAxkTwAJBfpwMY8HEpHMm6Ud2P1cf182I+SFXSGG6sdej2w+AaUqqfVXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkVurDLG07C+m6bhwpnrsDKZOwn11qTfnd6KEOFHxhw=;
 b=RkZNrbrFVvn3WjtXjGnlzkeQ7lxdI1udI5mWD5Q7zJMQc0JAdj/AoVGe2LTDc0G6naqWvBZsf0lBj2iAzSpj6aJR4eBItyLFajwb9VUeWuQ2BGMExwx+HZlc67hb9/CvHSXxcNGarMfGQklQxhanee9USL2qKHubQjGp7zENQCW4Dnhz7YYFcrz8s1vE5bRIyZZzDXPddX2yo7BUkGAS+OY3KIt7Is9Nk3b5a4q6SfLqqwW5IZDWzPg1Q7tNPaF41a1z+DPC6LDtRKju45TX0ddl/cTpbv5PLUh0lml7P/3s1vkm++DbiSgWSbOHkYh+4gcdAUWsXV0G6KNIsIwwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7323.apcprd03.prod.outlook.com (2603:1096:990:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 02:00:33 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Thu, 20 Jun 2024
 02:00:33 +0000
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
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nick@khadas.com,
	efectn@protonmail.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v1 2/3] net: wireless: brcmfmac: Add optional 32k clock enable support
Date: Thu, 20 Jun 2024 10:00:14 +0800
Message-Id: <20240620020015.4021696-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620020015.4021696-1-jacobe.zang@wesion.com>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 543bd33e-76a7-44ce-607f-08dc90ccc51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|366013|376011|7416011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kd1HIC62lZCb8yMBfnmviq2h9u8AtfuunTq60eRrLguJk2Y+MCF7WoKg0gVn?=
 =?us-ascii?Q?O6P7oJ/ruyuShzxkNHZHae23ehBD3B95BnvS1W7omHO+wCxw0I12cbGpmBre?=
 =?us-ascii?Q?21CGKDmF2UEKjJAlCRbTJ9jLxd2qcbVa2bDkNm9vU2skCIXmnGxeAzARMzMk?=
 =?us-ascii?Q?wucdkLYFveQv5CJbCcAjv5zHHZr0iMMbdacQ16Ng86LHUXtwi12/Q77XWUyH?=
 =?us-ascii?Q?T6ALeC49E1qnRvO5lYVtKgndj4z2xvH1ewa5SJEtT3ButiIQ6ba/Ra1ZstzW?=
 =?us-ascii?Q?kWdDPm2UcOMnkUjQz33blaTgR1hxWy4MQaMjtm/kO/LBnr2Fg98zl3XuaTue?=
 =?us-ascii?Q?C4c8eD1fxbNdRElZ3TaKt0aQA3YeGzstU7GJ4QDYl9aoqJg4BnJNu0PRbrl9?=
 =?us-ascii?Q?2j/vigD+GCpKNss0mrmOA2TLo4BKCB9f7F6OWwvfEpKJQdJ/TBAP4COn2yIK?=
 =?us-ascii?Q?9XTlDc83dgxTNrA1M5rzUfi2rB7kA3trVXfd4XDain7yANtaVo6W95zkW2SM?=
 =?us-ascii?Q?VR9FeEepkhtkkGuG2/r124bWxTcC+s3x1H9HZMrocAU6idM/cBbC6ypyvcd/?=
 =?us-ascii?Q?r4WH12ph3srh2d9zZgQKrFlP/Bn/BF9TFtNUcXSK3QBuq022rrHyt4wwCNLx?=
 =?us-ascii?Q?S5JMjCU96E1oLPb6HXK99f1gE2fLic6q0mLEMlY4xC94fV8LGIRvJpy3sNwV?=
 =?us-ascii?Q?tvtljTy6bGpi/EXfUxdwZ01K7oam3XSP8Gng8nJQCWUDspfpVIKwyvCjACGH?=
 =?us-ascii?Q?AaiofTgtflsGj1pmsARpyrXI3+BK9jQpd+yFcrDG4RRwywFtS8hS8Cj8fBS7?=
 =?us-ascii?Q?ABml6e5VLblSL53fOOOotrPOxa+c1novOJJ1YhKqH6PlzxrSyp4sTtJZFlNm?=
 =?us-ascii?Q?6PYGyl8b9Ot1M4CyoIn+eY8P85oLgn3fO3fV5Y/tlnrmkxrQ9FuoU25dCiwb?=
 =?us-ascii?Q?iOuFr/PvRRJ/P6v/ISlkoUG+bxj23FNqdOgX8PlE31WoYIZXKQDiai4dOj05?=
 =?us-ascii?Q?SkyhcgWpYgpsMKaNGAIHv7phhfx2c2NvEXHFWrmEP6M68NIRWqJYIlLWhDWX?=
 =?us-ascii?Q?n9lDMHNd/i48d2+lEMOOyK+uPbCEy+jn6li2/ycjXNh8OhGHK6fcH65XhtVz?=
 =?us-ascii?Q?dMvypvwse82qPxbBvS/Z0DriBWvfSgQAkppNTeBHpVStKtH8w9KRd7tFS6su?=
 =?us-ascii?Q?qipZi1eF9xyKGotd8Gv076KDVdUkS3RVB7lJHCHJV2r0JHtNfmVhBu/lbaSQ?=
 =?us-ascii?Q?Rvro7scN38PVS8AuAiL8p7GiPCMw3qnsMDamXNVBPs7y+Tk+Yq54puZf0ynP?=
 =?us-ascii?Q?jiuP4Cfu9Tk4u2cwtIAcIseWMVvrvx1ctDfDpVFoDdJCLuGEc4TLfn8Jppow?=
 =?us-ascii?Q?HLtbNjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(366013)(376011)(7416011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTsCvNPjMBDLAxliKcWzFromRPDT3rtSy6C8zKLQmJK1xMvhRbsksR/kl3bl?=
 =?us-ascii?Q?xryVufDPnN0UCFo/2Tmv7y4htqjnqw3qVFnAIZe8Vs8k1CsOeNy4rjlzrErU?=
 =?us-ascii?Q?M78ZyHfTXJU6Fm1hGckdFH2v7Ubq+K2eET6Q82DC2yr/laIt0Ov6AFzcvxUg?=
 =?us-ascii?Q?eog5euvB6jvDAPIHnVd7fYlHquUzc3o4hNXEe+Y/WT+2NAhUCgow0y25io41?=
 =?us-ascii?Q?vv0oKc0+NncFvKSBP7O9hpkCcTG3l64LPLF9j9zNSCvUA/OZ2seQwNSXgZGM?=
 =?us-ascii?Q?XboOVh8kSga0M52e7NsI8DUY/1qvqwIQUpN92dsXppaLOL4mCziUNGiSUi76?=
 =?us-ascii?Q?N37d3tXXejTMU15o5xHtSG0uD41qw7ah2l3keigQ1u/FLNZjSjMzTrgZ4w/a?=
 =?us-ascii?Q?Qhr2gq9wVKzEJw+u++3VX+lDmNhtqfo+O3wQ4ZSZyjp+8FYHgSwSzwrIpFCq?=
 =?us-ascii?Q?1tNLwiUQCfbk6LahqYNXRRgXdN+wZ8A+IKi89UZ5WsMcnmVKjLfEMvnZY6W+?=
 =?us-ascii?Q?kvKJIgmiZm/baKediu0gr4k4qNzlP5+zEktkVWZkECAjbtxWk1KShnM71A9b?=
 =?us-ascii?Q?7H3zUNOMoj3nvomcxELoviLAYvUfjUWcIPZgzxRNppUWtIE/BOqBlX3ULI23?=
 =?us-ascii?Q?T9JDxWwl+BX3CK0xz/aB85AwsihYA9s+57o6cV7RUStZdRM5DYCtxQHzu1Mu?=
 =?us-ascii?Q?S1TpzzdW1E8IeKCqvKBk37++0AsdZUL+CMUOfkAjQmieIxRMDhC5KMO4hSau?=
 =?us-ascii?Q?8w+84tX+hNNaGByPdt89U+MrOM9gIzhGcJBCRkoEoOWeER2x1P9l3Hq0GnZB?=
 =?us-ascii?Q?nLGBcr3y28gWlCI01JdRXo6+JFD3fSAAZE9VtgnmZBWi2b0wy4Nh3R6S1Jv1?=
 =?us-ascii?Q?8Q/FiiLsOt1wOYhq3lnQF8xj+iJUpxfZFEQ7XpdtOyBSjvCkeeErucFdQ5ey?=
 =?us-ascii?Q?GPU9w0lPVL8no6mRy2wp/tCf3wkCXgkPlxVDZN3oGOrTU2gLbeO+yWBtLvLO?=
 =?us-ascii?Q?tRwtfRmCE4c69FLoAyb5Rgsx/AB0OpyUd7+yTchLSb44fyi8SoQhDvQJiXx7?=
 =?us-ascii?Q?DDWsERu25pi5w/awQjSHzb+FiBSdWIW2Lq5iyXHJ+Em/crzOC/8OwwcLAY8U?=
 =?us-ascii?Q?IqR/6lyduV2jmgD4LdlL+MPopb9bFpSAXhCDTlcWJocvkUlB+nVfhW05/AFG?=
 =?us-ascii?Q?RvQ4Xm0L8LKTVDIi6ISYmacISTzWoIV+TL+EqPsSbpO0B1icw/Kruv1HvkuE?=
 =?us-ascii?Q?lfDfRRGh09MjrrqcVUCLy4a/74EfVUVZE86X53PIIxzeDCLOvaWmxVFZY/kR?=
 =?us-ascii?Q?13+eqhIZlGhAcBtWOAbLofSu3u8f4p4BkhtdRahJnIJNNbik8vTldiNXykSx?=
 =?us-ascii?Q?21/IgWon1kcM+MN2NIeimWBC7Q3YG6JJrgM8BKtPHfYcVlT/R5pCYcfv66wY?=
 =?us-ascii?Q?vZxHFhl2pADUy/mPtm1aEtv3KtwQtqCC0Kb9FJE2BVDXflOXMD3VKBzV2inS?=
 =?us-ascii?Q?CTVHzUsPOnD0HRf/2u1kLyKyzv7fmS8VRUHJVLNDDH8bTkUaUdW7xi1kojNq?=
 =?us-ascii?Q?u1Jd5YQgpGZXH3DavNA3GZ0ooJWzi7vag2vBrOow?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543bd33e-76a7-44ce-607f-08dc90ccc51e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 02:00:33.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Plwdek2JhgaZRn8R9ndd32MvoodXSXkvdFdWYoMlVe4ed4VARqC01dNu5kK6u0rbvOVPDW3tnP2LNTciknoFQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7323

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 06698a714b523..f241e1757d7e3 100644
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
+		dev_info(&pdev->dev, "enabling 32kHz clock\n");
+		clk_set_rate(clk, 32768);
+	}
+
 	ret = -ENOMEM;
 	devinfo = kzalloc(sizeof(*devinfo), GFP_KERNEL);
 	if (devinfo == NULL)
-- 
2.34.1


