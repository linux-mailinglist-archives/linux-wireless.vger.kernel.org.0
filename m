Return-Path: <linux-wireless+bounces-9706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FA91D05F
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E56C1F21866
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FC980035;
	Sun, 30 Jun 2024 07:36:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99397E799;
	Sun, 30 Jun 2024 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719732998; cv=fail; b=sUmpvlpDp1+GwQKNU9JfKi4eZyS/4emaDs3lBKND0dYm/w8H10gKSjv8qWhVwlwUhIlTpSDCsve6Uw0Vvf8KsuHqtBSbQfdQ98eg5OL4h56PqpggzIVGO0LzolYfcf3yZOlYLD51OvqZQg1arKPOdRCHOUhCe7XrNKFyESvKINY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719732998; c=relaxed/simple;
	bh=vWsxgyPPy+lqPR60WhEVa1ByrikD4MWxuQOgbCyKqj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmkgYvCnjyl9WMD2b8UKPSCsTLK+/AP/3cDwlKqOMqxhXtJZor8UJ3q9SzFyDAogRkFfkflAIfn3lce3hVtD4wDQ+MITFWLQagouh9gNSQ40tx3eGnDGbTEDdQ9VWRsSGY8MyKHSk0jASJZui020PaKqTlF0HdXKMxwUCQGakdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjojMZlONJOa5q9tDETzdIYnyO3AO5vMRcVASPbCeo/6K+KsqnhOSM8vr7tLRDEdrkA7IrcOY8pZP3xg0ljEY0OcFZZw28X7i/5hvkW+aLNRnfC8DjDIn8GS7LU8lrETVzDkImmBSnUKaAvwh9z1H/Nd2gLm8FZHddIfzaWfw4enOSbnkTi6h5ICKsWjR97zpbT9IdgZDoVGH5XpBpX4uCRWCExrDHE7u0E/T2/d755ZhA2HMohtHcJMXKTQPYly6RJJEGIXS7QSchIa9hk6uI2W0NDkC1WY2vNXavDa1Lxr3+tdX/Ut+nkApcW/5sknaC/DfeU24PihcdbgrM901A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8CW5kZAiyuWTO5Q1dV+wgslotDDSDogr6Cs508PlV8=;
 b=ePDuwtvjcMUvn9Ocu1DI5rLQwf1IPcprOyexAtI5x1iZW2zuzzl6GVATL7mmoC0RP/D6QdGiShP7xiDfstaqpxxNmuqxvqDDUOSEsfwWzZRsrCQ5kZTw2vsOYnz7gO/GwVrl9FXeXWC1jhHzu8NRFJo9chmJ69N/FXAkgPTEnNJb7yIO4bqKwxMId/XQfJXFqSbWtnN/Wp74aIncuOYBr+bJqVJOw9jgKxMruysWaYF+ah4a3fOdka8J03GqD8ZeMlcxthPYB3481nInJ5cIWz5YezNkoXNHSrl9U4y4mHgAh4dXh01mwFOyV+fgg+poDjqag3G+I9lLQSk+nHrnBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7234.apcprd03.prod.outlook.com (2603:1096:301:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 07:36:34 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 07:36:34 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org
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
Subject: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Sun, 30 Jun 2024 15:36:04 +0800
Message-Id: <20240630073605.2164346-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630073605.2164346-1-jacobe.zang@wesion.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|PUZPR03MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: f63cd49e-f8bf-4b5c-521c-08dc98d75e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uOxtn+nyl4809V3q2DLRkzIWuId8N1y0W0v+YXkFU16C/13AhGBEuupYzhfl?=
 =?us-ascii?Q?zEoXhYDyswTBo3STsh8sGzwi5arwf5dOIsllWQcSRimaNYDKRftLPiMguoVv?=
 =?us-ascii?Q?Mfl1zbw5QLYv11RQP/1OMw51ODwwXKYNfli/n55YEJMtkqrwG3zoFppiKiyF?=
 =?us-ascii?Q?bGZReHKDD2iq6LJtIkrnS2dsazl88qSF6EOBx9rkV4G+GuRYXCVIyDcoQ3oP?=
 =?us-ascii?Q?l3lAfT9bd0O7b+qHyj8l9v/3mm4Y//9fKKeF5Jz5h7igv8SWHWaQkRgQwJAT?=
 =?us-ascii?Q?flAVS7ZYdarnzh7gHDYOZFL6cd4/mfdCx7Y28aupKKD7Blja7gwcnwFMMMWY?=
 =?us-ascii?Q?H950HQOQkCKD1ndsCtIsiPxQmha2/FhhXTn5hBEAIoBn9RgP1w0nVTxf7yky?=
 =?us-ascii?Q?KjueOcbazTxF+rbOYr0Yvbl+qYyQVWYzm/jUJsduW/DcBv7iG7nIGoacdSan?=
 =?us-ascii?Q?iUS4BfLJ/vps0nBQDtu+NQcN4yCgGB+EHdbNzArzo1sei7nsmWq9/RxJE48b?=
 =?us-ascii?Q?/64RpwzYqCBOiKmMMHzdZrg4kJpqbJoexE48wqXtari1qX4d2iu4RU0zosO6?=
 =?us-ascii?Q?zowTeuvVvuvKsKOcw6ub02yGZSLrCam14gOGeo0ArOwwnVl/BIfTePs/BisK?=
 =?us-ascii?Q?ilqILT8R1kD+VcOhk5ufi/kUv67wKvzqKAo1V+OiEa3jXmKOt3THuHHMHNez?=
 =?us-ascii?Q?wjLxtS5i2y5kSHyonn/AmlBvjaAgYWvMnT8dF2iBMJak9DozD0vcxrMraamj?=
 =?us-ascii?Q?eVotYhl12BmJSqeSmRc7nHDlI/Lq8j32JYPYYFHl4UWo9NeSAFcloxspTUvr?=
 =?us-ascii?Q?oDtY4QBzUT32Wvt+o7GGOdFPBR4I3Amv1pHI28M8RlKPGciousmk6yErBKZt?=
 =?us-ascii?Q?S5Kxfy+R9htcyI17RQ/x4nx4wX2IuHwllZMgGtmtabwR7WNNo8Mi6E5bNN2j?=
 =?us-ascii?Q?mVurDHZCBrKiU7qURigrfaRSvwhCp0h//GY2j0nHpnZn6J6ifTJAv1BLLu32?=
 =?us-ascii?Q?k0vDXaVeciA6nTr3fz/gmiGcga87WwHen4hF4b2cbidMrw8KLsEzaHuBXC03?=
 =?us-ascii?Q?GHCbcvhaWNkxA4eDlqb3c5z1WbZM+5gSLv3f7BaE77OPvUzDSXANQTYSqvnY?=
 =?us-ascii?Q?6w0aigHZCk0lQNiDVCVoKvBjP9dRS76zMcZj5M1By4hHyd48folp5xwFK4Ap?=
 =?us-ascii?Q?TX3Bg2CI5144MeYHnwxEenCW9ZWxhaghy05cF3MylUK8llUAjG2pK41QaYqS?=
 =?us-ascii?Q?05tskBD00yrDcTnEFqpdSi/HcNBsQurPQRrj4bCuOg7hMM+DAGhru9+Ou5Iy?=
 =?us-ascii?Q?ijqSp2SueSZOJXGgE87Qez0Ad3asgAR0KaCm66TqeZ2ZmCNjX/79m4pOBJFe?=
 =?us-ascii?Q?c2H2Ujo8n2zZkR1Tw9KQNdqdP4FMfkeuhIhy+Otis9XO6L9FxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LFsK+RESDKWFPCwPvHi9gMRCofKk/W3e4H+F+jWFvTvNkpJTxhkGqGRIazU?=
 =?us-ascii?Q?Vu1a+WG3TivhfqWcZu1B7hdT0VsKI6OVfG6ql4/wY5fI+GX24nSiO24KCy3p?=
 =?us-ascii?Q?m+SQBF6cfHPudKmgAIPProu6GK24n8h4KljoHxeokcIQ0MK/rdaeA04ahKdf?=
 =?us-ascii?Q?3m9qlGmPfx49mykoTPxptTvDU2pq6h22jd1zL3QICdVLmZorceVu26lMajtZ?=
 =?us-ascii?Q?jtcYSXZwG9XjnlqncjYjNohCInSFXakHOVdq4jaPW5CrNJ9o6tgjHr3c3kwG?=
 =?us-ascii?Q?YV3IaxHZ8Z3G8xGwKU11AXgDU6tpEQy72UIm0rld5J4ifwcYbtIZnLaXr4Lv?=
 =?us-ascii?Q?v3q5xGFg5aNTGw1DipNxC4yR2EuRrw7xfmqoFadwRN8AgcwLiSCiDPfexSjk?=
 =?us-ascii?Q?uUWGSrjJHNNr2qWnYVdrH12D229YzQbmfAoZh6825MDr/OOHm2l4b4mz65zJ?=
 =?us-ascii?Q?JvgkuE1dsaLDh2laeiW8fD7yU2+fGIE4I+kxjiPn+tMJ+wcxU/kKFu5yUz8T?=
 =?us-ascii?Q?9UG0x/FZMVJNnRtfPOb2BJF2UQE87lusVFNFdx9tlfjdSiIhQoWFRVuRi6tW?=
 =?us-ascii?Q?NDIuqAl6Bo6yJ0H+oTM+ipF5Xeq/XJ4LMmeRDhwUObWOsgACyZfdR4M1M5vY?=
 =?us-ascii?Q?mhupurVVDF7dRc0zuy9iysIupfNJ5dkbR/9OZvlX5HXFexdPHYV4rWEJZjrm?=
 =?us-ascii?Q?3AgvOom20uu4xthk1lXzJ+UL9eKTttjVbhl3ODzlX6qx3+q0pSFmkMCG2F4k?=
 =?us-ascii?Q?TJttPnUqDhh6DR4Rr3+IGordYgzO09sdJ9fLxxshZ+UcX9WkgKj84KbD8JSg?=
 =?us-ascii?Q?iU4rNi4UzbaI6l1Ty4SokWUa3VaK7dU0UiZqWHmHFrgNnGt1TGud9FbqzwSQ?=
 =?us-ascii?Q?ErLb410f5i8bFAOm4wvSU9qNalMcn0ZqkBhfr6/lm7Oa+pTzWPjggq0x9UEo?=
 =?us-ascii?Q?PLhQ61crGRFMxqF3wWe0+xJ+GoWI0C1L7IpqCE3TsPY/FfxmfU+9dpgjivrv?=
 =?us-ascii?Q?8jnRsOBQy6Z5uZcuo2Ev3bXcyYTGxE5An9Oxh49b2OUW9VkyHq6qp6Z14Xvf?=
 =?us-ascii?Q?6J2TnPZbHkTyAgkdGamCg5lY+pt125paEoIjoFch6m/JCLqQP80Z38KxU/Xg?=
 =?us-ascii?Q?DLjYyaOrh0xoDLO9O07/JfBR7iTZwXYO7WkBP41mVx/w/VSqmffipVXqQirt?=
 =?us-ascii?Q?igtNeQipOYUu+t/T6+WGeYtGYeMZk/9TCRZO04rtrgGIHz0+D2AcaPxefnko?=
 =?us-ascii?Q?thsGDA3vXUN61WXVpv5wjaIXqXE/9Ws3OGKGljsKRy8CwRrv1THorNOBHjd+?=
 =?us-ascii?Q?yOzlvKxDcCZil6N78z0NTIUf3OOpMWca5TBZaZIo9lG2KmWDg/Xsb2LwCzBX?=
 =?us-ascii?Q?G3zjqChyAd9D/G0dypPMfX/4ulmWbDhCFG9T/Y1l9Ug30qxa8YpPyJ9E8Xh5?=
 =?us-ascii?Q?Pell1E26K1puTA+SjT1jxgWbDoAYUE8X5G+ygBaP+iC5+zPX6y/0qSCVC3Br?=
 =?us-ascii?Q?X3C+hHoLt6cZluZYvQ+dgoiE9qkTJY6BcvQedxhhkpM1sw5zhmRulq0i6nFZ?=
 =?us-ascii?Q?xS/3C20eD+GncZKFFza/vLiNPXOTD/XW+ZzYU0rZ?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63cd49e-f8bf-4b5c-521c-08dc98d75e2e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 07:36:34.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRcX0eYwEqw+FMvZsMiVJItloXHzxKzvxF8CxVtdIK0o3HFzfFPHFuf2oLFu8VVHlLn72OPY/9zgtv4oanW4Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7234

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 06698a714b523..e84f562fc91b8 100644
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
 
+	clk = devm_clk_get_optional_enabled(&pdev->dev, "lpo");
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


