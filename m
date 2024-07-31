Return-Path: <linux-wireless+bounces-10713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4D94263E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8349B2475D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04EB16CD32;
	Wed, 31 Jul 2024 06:12:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536A16C875;
	Wed, 31 Jul 2024 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406322; cv=fail; b=d0Ggp9eRI4OHzuuSE+qUVW0MpEizP6WI3Tbh+C7uSaNjOXlp7pLWilxEVg1ZHO6G97smnlfrVBfoGiRuWDajYBTsP4cnlEcV3xeMXMYBmsySzenGTjGFWjrHQ+arH6lL1mp37zJbU63n/KZ4ArS+ng/kDXtt7dnjy34OAshF0Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406322; c=relaxed/simple;
	bh=lKn7tedXjLdpYoxPuq/HfCw3vPweUEjpaIRuIff6PWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UhTk6jVJ81jaM0a+LNae5zSdx6EwZUSpEePPdYIYyJvilrbB1aesxQnbeX7iECF2o1YIlDZ+bR9HXMuoSdaQMabU5eFayvJ6zj8fFRJod7dflnGSM2r8vblq1YywugqlmGiJ7BEoKjZuuQJvSaCd2Vmi+U9ToteFoAEAXVcr8mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejYoXQ48BVWMG04moR/Iol5Hyc4JdHHzxtFKpKC58rDzPUSmke4HIxW2/bhiglnkR0EGZJRF7//gABl0JNiQvbgE0esg4L+9w05m+YvPzTeV3PqR12tC3Z+R9VRc2dgnN0TjRNrlRe02zwrMM51VZ6/WvFpTfmNmmcNRy4xXZpeceEHV22A4cekqvjXAwSFTXJEi2d32kzPlGL2VP2DBtp7jTLPHbU7fTmGeXAq3vFRrVzIUpSqxfhrgk+BHAe9VvSnFnDPU7wXu1LQWdAGWPQRCLKelgDB82Znc198lzq4kjkD65FkXTvA3AIVQhtdZtk8I7DlRgcdgxMT9Lhpa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2JPbJjR30bz0tWINXyBq+rwGz3WBsWM8w7Fol41l0I=;
 b=gZj4ygLea/EFna5IqwYEFpNt+PtcaRj8p2zKw4UJwu3AxvNNBDlyrSIbnIa2wpy/KoiPwElU/PH8/BBOd7rsYcWa8SQNwhNmCLrNdFacx8dwdM9w0ZhF8TRL+Phwt7MTlhtc/QDFYTcRq5B41xnT/tT5wudvCwfR+IjdaW2B2DMCeJHhRv1JGbJ7V+yngyFro4aRX4rIVZDDsmzWSeWyrQJdPGDrmXACyaIaOCrVi0lvVpd9W6sD+UUBNX4fu0KCQvek9kDD3hic3rYInyGj38HmXAoSbwS8Pvo8MvCqIwMFMBhS8KpAv6ImONNYhFZQ2hcVm5t9WUyrSq4XC/O5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB6580.apcprd03.prod.outlook.com (2603:1096:101:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 06:11:56 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:11:56 +0000
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
Subject: [PATCH v6 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Wed, 31 Jul 2024 14:11:31 +0800
Message-Id: <20240731061132.703368-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731061132.703368-1-jacobe.zang@wesion.com>
References: <20240731061132.703368-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: c93f608b-9231-492b-306e-08dcb127ae3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xeSlYMkrJK9LBi0kMMgNwM1Cm6adjBlUskOuL61To17M+ia0ud1QgHTOROc7?=
 =?us-ascii?Q?tHjvzLQPEfIJpF9Fl4hLfj5EuI+wBcLzrxOoqfzoJGkaheXcoLdj5DJubmm8?=
 =?us-ascii?Q?b249l3wOeSAUv79fmzJEUdEHPYYA8vuNh7OFsiZEij1mk5V7soa8LiTsIpud?=
 =?us-ascii?Q?+DtcF6/A1CUdmc3rAHgMA/b23soC4UAopDlN82lHmRuhePqXJQM8okXyksl9?=
 =?us-ascii?Q?b3lCQKMwk5ZUPLckhjFUvTIu9ORVaiXN9jODqtY7E6xdUUJnbfUcpEVhgZJv?=
 =?us-ascii?Q?ZCLjKi9XG7co59PKC0oRczRIQIQFpgPsgKSJ3UjHDd9vG2D5+WbX/Db8YQaf?=
 =?us-ascii?Q?S6zHhc6GLEhHigrw1OelpkMiyMlr8t1nVk/pM2LL1D5VhlxFzmFMS1t9gM25?=
 =?us-ascii?Q?5RRuKeEfY8hRSwDYb/OUsuxgC+b69lPflOLq3rObUh/2Ep53r1ssxNcXM751?=
 =?us-ascii?Q?b/4OhSTAHH6wviGdhllGqKH7oYyFTyawY0O3kquAl+ydWXWC+gvShIa2jAQ+?=
 =?us-ascii?Q?v48gRNGTml8Dx8yzgshoQmQfGRDoQgEfW3TkqDaBt+Heh2I+f7BB+zuR/6EK?=
 =?us-ascii?Q?YmHyYT7Xpcqc2WvuRvOWGzi1mVXw0BHRQ3T9SWvVyQ+In5+ei5f+lHSvonmD?=
 =?us-ascii?Q?1qu29c4wwt2e8TrfwGQVdNTx6ZAXu5q32zXCc4vDfidk71/fXg+OnRoG/huq?=
 =?us-ascii?Q?j00H1iXHajfeJBVKn+HbhIP0K1FOa1reNk9+X4/4hCZSdKa9rqIC1lqw2fJz?=
 =?us-ascii?Q?twZ7kZjqQwV53jVqXINoYbdADW7VswSiBIZrb7TrFsYazEK4yQz8vWQz1Bff?=
 =?us-ascii?Q?uHakTk/oyxwD1PQxfa+qln4YDhKYd5ez01ClfF8d+lsZT9hXoHCCupKth/cx?=
 =?us-ascii?Q?2yEdtfS7FH4zZji/4bhcVyocWsVo6lHsfAOvlz5gSVmzZnRYJKuzsQojWTtO?=
 =?us-ascii?Q?bopBB2DO3KmUe7VCpYdtT3on5/0Qjze1rxQIaf7qKBv2Em3Xmn+AQbj8OOxs?=
 =?us-ascii?Q?soR1j7Lum1mpEKye8SjooyA5RJBZMFxNKczXQBIb5jOR38UCez148F6iOarq?=
 =?us-ascii?Q?BUONunUXE7JjINjpG0TiX02umtsp7TKcGHQVmiUnShCPnZOYLHsNe9FYMA6a?=
 =?us-ascii?Q?/pfpCm501n7EiSlehS2Laf1Pbqi8dbt7ZZ8S1bjX7jgBrT3J3Wd+P6iRJ/5k?=
 =?us-ascii?Q?6LBlZJZzXOgEdecZ9gvlmMsowZEzlJK4R37W54JGY3q0vccuDWbWM7sqN13S?=
 =?us-ascii?Q?xy/2kZioCWcCEN2O5CIGplMNkyIeDaQDjMw5wE75YmOnD9p3TtxCz1q6neKr?=
 =?us-ascii?Q?rhHXR4W9UHMhL7kTI4VjUx1glEVQJUKbE6YB8a0SUuqLJysSk4agNcl2Ks5j?=
 =?us-ascii?Q?Ex3XL6s1gvEVMD5dhv2EU4bq/BlIqifeK8CmlCbpUoFE27dpQp/RJo9xuCAo?=
 =?us-ascii?Q?9y69cfPkbUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6x3pci9TbOdvkU8LqY9QkeRY6nhAmZJUBFTmkwfzygC8+zy1921d+ebJU4d4?=
 =?us-ascii?Q?VQbYTnAaJRPmcA6y39AF5Gqs6iX5xrF5qzF+PwoIhL6sIn/rBHEC/Urq8qqZ?=
 =?us-ascii?Q?4BMHiosTaNIAlkDrQXKa7MprH8IUpeVZGIPG6uRqR6clxtYqZLDdAtiRSA/d?=
 =?us-ascii?Q?pkN2zv059c8KyrIYiqkkw9h3ihR2/+36V315TUAxjECS0TFM40ZjpsDIbGhw?=
 =?us-ascii?Q?6WsvxWHcYJHYER4QaKFKxYgXbFtSWHYJ55+a1tnIFL2Kyr+5iWYzw+ThhRHl?=
 =?us-ascii?Q?YTVihCdyWZwyIjy+4xl8H5LBWnq12b6oJ9rbkUcqtCEqERbFum+yzAbBlKW8?=
 =?us-ascii?Q?KmFO9z8pZ1KQ3PE9UbGCAyj7G1giw2ctus74cfXy715avj6Ypybm7E46iF4p?=
 =?us-ascii?Q?/HEHXXRiXAjVarV1GWsAewTQVZqrfnrMejx6mSAaQ3QYqc5VWcPPLVcly83w?=
 =?us-ascii?Q?AlG4lDrYV4JxucTOMaOyBOUexCJEvq1S1zNX58DFF3b/o8wVIW+Oq1TdF97B?=
 =?us-ascii?Q?O8w7tT8ziXGsw9LgW2U4wUz3hI0YINInLE6vx1go3dupLVm4XpemwCL6goJz?=
 =?us-ascii?Q?coKjcskMpOrJU6UiCjPXSMBaRa8bCH5UuaklIS7KnVtUhMc6vWGdJnTrx8OB?=
 =?us-ascii?Q?NyluCP1CPIOAnCXAl+ODOZ64Zv3OcJ3txcxTDpB5YYfVqQiD+rPcMUal9CSz?=
 =?us-ascii?Q?MAayO6bHeB/WqA0jERrFsWEaHlFhrZ2Q1V7umaorJyjHtBg05jeoe++pfkSe?=
 =?us-ascii?Q?v4O/SYYrjQD2YXJlJ/w89/XTpFK/K51UebOBawQNH6NHvFbT9riBG1nWz/Df?=
 =?us-ascii?Q?dcmQJUWLzphf6XgSabtv+KYRQlJjT5liSxfY2PwhXEGbOaOu/UNxnvvssTA5?=
 =?us-ascii?Q?xLU3FfPxgXoajB8v4kHyUuYmcVKYxf4TlqmxoLyoteiUS6XjmG7YoHe0aBwX?=
 =?us-ascii?Q?qHhKMWtMv7eMZrlVItyj8stJlj1q46ToEmywuGwc6p8V7VZSfpisPpMkYBqM?=
 =?us-ascii?Q?Wm7WDwiN8TKlTc4Av1xoEC0y8yrskNJedEWqirdgjRA5duMuNVUWhbzLa9VR?=
 =?us-ascii?Q?EDmM+8ECclaOa2itTH+TDjZx/lXJzrRki1IVthbYRRx8v97IHnvLAzIIYFFz?=
 =?us-ascii?Q?omWLuFxQz4apzwSBy6gg1xB5WaIdBgJfzfOmketNUB/wXxQ21SOWIgW/Gh9L?=
 =?us-ascii?Q?UBG22qlbe3edVntwLhwoEO3UMftPCZll5iEzZHRrQtOFp59cQ/b5uorMp06g?=
 =?us-ascii?Q?KLwQa6hQv0u5fjqkNHKqY5VyiUaIRzLzdz9swGgPutEujRpyNbjRihBY0TvM?=
 =?us-ascii?Q?E1ll2EH47P5INMyQUZYyZeBGDdkEDiKPfZefPDR8nej2I0WnSPxzK2iPgyzw?=
 =?us-ascii?Q?JG9EStpTU/pOR38bRPx1MVbbaOP5xCQ/KqRx07x/DIkBNK22gjPU4H2ApUkj?=
 =?us-ascii?Q?uU66Ink/6qeCJfrXn1xVg/nNzzgJTVFOwUtsn1NA6HdgFLyZzrL6REzTWSed?=
 =?us-ascii?Q?p5mTwuyEaT++xlt5afQijeZcvDLq9gLdEGdq/+u07jHlfr+rN2pn34MkYclm?=
 =?us-ascii?Q?RLkE7ojsqEjGh1fnUF4nCvDX8t/aGjDEa0DUOLzz?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93f608b-9231-492b-306e-08dcb127ae3d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:11:56.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8A/M1K6JtLWhIZ2ymMDLQHmWMbtXXyAft9VekNQW5zCc+c9Ans2dVePgJujW8cS85SH6imbUGIhEjRRnmWe4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6580

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a62..7e0a2ad5c7c8a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -70,12 +71,16 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
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
+		return;
+
 	/* Apple ARM64 platforms have their own idea of board type, passed in
 	 * via the device tree. They also have an antenna SKU parameter
 	 */
@@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (!IS_ERR_OR_NULL(clk)) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		clk_set_rate(clk, 32768);
+	} else {
 		return;
+	}
 
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
-- 
2.34.1


