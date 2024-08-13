Return-Path: <linux-wireless+bounces-11338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1B94FF9A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C543E1C22BD4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A4187868;
	Tue, 13 Aug 2024 08:20:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073717D8A6;
	Tue, 13 Aug 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537236; cv=fail; b=fwsOAydJxJVJipsWidR49Dpa+4bQbIsnLLyegpV5FfP6Q8MRZDufgG3aV4E7p+Llm2mo4kM1V9sAx8+GBBaWPWx43gLfgwyXSGD2grmFPQZYgPJBsLZTRjocvfacX8nc982D7sNl/9xLdpZb3RGKZLSrzxBZzC1YB63Zffu7MqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537236; c=relaxed/simple;
	bh=AyXwZpIbxBRf84MlIw8HPcqsU+uVrkk4+1qelC++a04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/9MLa6L+uUNlrzg4T9gc10htoCW/vG5aY3rOT4O3R+RjhIw6vxEqx/DkknSqKzVvQwOdGJA1DBDGM6xp0kwuiDv/2eyhirwL9qbXliBb7iuwhtJdmRIz79Z6pAERhs8KBciwpiCwAesrdCXltYUyYXa+W4LWeuCfhFVoRQQIaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vd7UQRCfdrkv6hjWBgP0771o/B1rqzoJz4Ai1iCyrRFB8jiU8EFes7LsrwZrTBz/Fv2GjK+yXFjVCr6d7Tk1PlS7A9W547rJ6GCFh9XUHrojrgMOb3rgjUBUkUVdwkSw4Nbv6a5G3YiY42Goi5xClfmse1C8Vw+RRcXZnEMh+vXpXXNjbBXYi03kX555iFB5Y8iZagxgg2Oquj6RW6ufO/UrATqZp1rZTYz8a8JBi+SQRPWzN4aHnxc2Pe99uS//pFl7zdXd26yOF4DJc9QISLqwy7nwxegWWuSG7RcTnCp2Ie6ODIhBnWkM64idNrgI9Av1YJqO+egpQl+9BwsBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QpzFC4HD49dy4gOxRxAJivncpeQIUALprUAIvm2Oc4=;
 b=FimB1DGBRn/RTunVI6MmwWfJQiV4KoxFq9AAxj90x5nnfcoYJvAgKUta2H0UB/jULQr8ig23NwkFcSpOM6yNJIC2bSvJeHQKkqyn6OEg5CXOtpFatXQ2GxN/wvN0sdHLCVZ8rZYtsN71bKAuDp7aqdKHkVRV5kn44LcM6EJB0LPSvuyf8UZIxgxw3irBpsqmZmBUOjIximGrmC+J+fnSy+XDqPjzMfd6Zc3RjViB7rgOXW/QgdR1vNY/s74yYhka+VAeDmd8CAZ6vZDrkEMs5fnJqyOaTKgZdxzywK4IPSeOJDkzKjZ7AOpu8iHMPgXixbqe0/GN/daSKHO/GOw3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB8198.apcprd03.prod.outlook.com (2603:1096:405:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 08:20:33 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 08:20:33 +0000
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
	Jacobe Zang <jacobe.zang@wesion.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Sai Krishna <saikrishnag@marvell.com>
Subject: [PATCH v10 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Tue, 13 Aug 2024 16:20:06 +0800
Message-Id: <20240813082007.2625841-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813082007.2625841-1-jacobe.zang@wesion.com>
References: <20240813082007.2625841-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TY0PR03MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a133dc-f2e6-41ec-bb11-08dcbb70cd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6TvM9X/dHdXO3h80Pzi8vIY6ybDOVmXWF/Zv6KV2SLbhQ6FyHMx3JQS9py+n?=
 =?us-ascii?Q?36a+p3kKW8Dr2uKz681NRuaLa7JaYKrt1mMuziZJMCyNp8DO9sTc3+B2Db/T?=
 =?us-ascii?Q?iS51Ps6El+zERw0jvExQFyNCmW8xpkVZWvLp0jkwTB/qYGoTahNLaUJ0xIgP?=
 =?us-ascii?Q?42WjWRUHrco4U2H/+cGWSChQig/bfd9/8P/5GFTIbwvQUVbqL+sWpuRDTzRS?=
 =?us-ascii?Q?DkXFTEUG1s5xnQ9+1KtI65EhWoUxPrdZ7nKKJMiw/OORgk91Q6ygbumgxowV?=
 =?us-ascii?Q?SNLXrNTUfLpHSLOr0Lnqa1fNo80LRPArAX+avxHyttopUKLlazwUZWNR5oxj?=
 =?us-ascii?Q?eWSPkZeBzxxspnKxRlttVV1gXw2PJTFvfzeFtXP4W9ljXJtBn47hrRogDeSU?=
 =?us-ascii?Q?8tBqFzhBsf8B3C4qoSG0J5jJjVjArH9bcEushOn9AUwN2hJ11JcAjOXst081?=
 =?us-ascii?Q?XxmWlehB4jNyfc1SEfqQZeAnrjST3OylR0Q4T+np3cI15mhYBwHgm855FoJ6?=
 =?us-ascii?Q?s/helAzilRvshWY7AhsYyg7XUptB3sosU5n9FRsh89XczzgQWeENtIV8ojXp?=
 =?us-ascii?Q?IAFKo7662yYIPqFEH/WIAY/6tGA6jHVrDF88x/GREjJUOg/tSqde+9EjfWEd?=
 =?us-ascii?Q?m9poLeAQp/fORlKlpTExYgZWzXml1NJIwtaYWclBrYN9qeLm5hW/M9exG2ua?=
 =?us-ascii?Q?QKWzkiJgp/aFh7/WZ9cbaweb//oP+yZ3/YllfEHiZgoZbFJJNnbQHf698e3K?=
 =?us-ascii?Q?2n73ehhZ2XAaaW2LxhMcP++cKwX98AUAdAc4+csU5aS+8KcKjZo7aKiMerVo?=
 =?us-ascii?Q?KTt/REPwmUhXtJ9v4diJzs5Z7ideAAKPZ13c+u+2UgWSec4kRab3Jqhtz+rU?=
 =?us-ascii?Q?1TYbYTrjoHQfy5tLc6BEo2HTIB2od/zfT13dvZDQiHdp5EB74PZU5w0kc16z?=
 =?us-ascii?Q?LlszUPlkH/nVVcyA1hFQJu7iwQreT7IsvMbBmWA+HE1BmJmyaUuGCxK/eiAy?=
 =?us-ascii?Q?mU1xJyxgnGg+ykYS5MtFcNtZNBNXEjQD16KHVklQ7qVNTzdkEZqTs2ejz+2g?=
 =?us-ascii?Q?dPPVmnvp8JOTPLnTtOKYeRHQnlP33T/u437LKocGysVGFY1yLijQfvkR6kbk?=
 =?us-ascii?Q?5zZp9kLypeFxADc5Y6QgQt47HzY+OwJKZ3d3RL6qlabcpZzlD4KdYSLMmS4Z?=
 =?us-ascii?Q?kDO8OjqmD6+90tJSmApKufHvmW3viFkZQJsHvscnpqF2aJtCNiB11QcA9Yb4?=
 =?us-ascii?Q?21OTbO4HH9hzSiJb4BoMhTOFRF7FIUFay2q39LVbilwElnnazMOYE+89gXLp?=
 =?us-ascii?Q?TcnEZTP0fu1uJVMD3p4P46cnpMfu9SNVDKUEEyyww1wgP08+je0KZYMo78l3?=
 =?us-ascii?Q?OTCT3sQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?59sqRKLyfsnpbVEZAwrWrXioNNbmW89PIRr8nnNFfp7ypyHQJzQJ4YJmOVfO?=
 =?us-ascii?Q?Apvn+0DEHOg2D8aB5A77rBFkiiUKlggYQeGihL/rvA6T7D7ymvSMYpg03JxS?=
 =?us-ascii?Q?yuACVSX53+r/BCXz31ufHX2iu016JhN6Bi0xvgUiEfuCc1twsUrJDS2ZYRfn?=
 =?us-ascii?Q?YZ99dg3XY8o1f9EbCWmW9OZSwzhLrqTbFzycgKVJ1IFODwtroHHXkYktZwWr?=
 =?us-ascii?Q?lm6Q2050ygXLtNI+sDWKB5amkcVW66EJJnauKnb8cJz7fuJGCiAjKCqC+nuS?=
 =?us-ascii?Q?BVz1/d4/qp0xg/ZVi7Oo38VuhMPOLZ7Vat3uz4Y76m9hMQ/oy5N2KuZsv9JD?=
 =?us-ascii?Q?nyUHQrB7YKkW1BGIfHCxa7fjJ9tnskd9b1DUerXxZpC3ala6VnphqiNcDqoW?=
 =?us-ascii?Q?2F87hZOJCS/iobN2c3om4dP7jjaxtBP+ntoATVUKJUxEBHwOB59YK5WAXyZ9?=
 =?us-ascii?Q?fb9vLaZOAgxnWAs/C6ZTuS8i7wo4+Rh+c80/iJhxHOn6jfhDHlpNNCSHJGlF?=
 =?us-ascii?Q?kquwq6uNVwJRsA6htSvq3OKO8puvYfqpIUwPjZDx4mrmD1Dunjwow32TFPKN?=
 =?us-ascii?Q?Gj5Are6ZkzxFK/bJ0FUFhR0eJKIHOnyljPgedIB3qqg6U68UYsv0ODCcT+S2?=
 =?us-ascii?Q?JfSCJL3823fZ+BsLWWiuSc9mgshcu55mKkdFzrxsLzW2gsW563UR0lZO6SSp?=
 =?us-ascii?Q?Oz2ycr+DCJnIQJzY/crJmy2yKp6DRLzPIjbxCzVca8hsur5MHhNNA7eyxSgG?=
 =?us-ascii?Q?E+moN+phZ0KkproqRMy/OgR+pomHGeU3ofNideajyx8KrDh6viyephJj7rPk?=
 =?us-ascii?Q?DBVWXh+P/wbFXkEuhndRW3BKIHP7OZF16WmojkMf9xwKREwdNyADLJCn8EgS?=
 =?us-ascii?Q?cUWsYQ/gVJwt+/QwT95Br3Au27g5w2V5dXTcyDSSJS0t5tSGfVrGRUc2h1xB?=
 =?us-ascii?Q?y/wJ7yzAZZOd9KMOhIP52U2g3V8z6EKT3a5FthxpfaxK6GtjCDZl93GoMKsu?=
 =?us-ascii?Q?o68dNn8uPsWene/Tr+HkT5b4Fi5QqemYUyN8Blotq8wQrdPUH8Q6JByQIkfv?=
 =?us-ascii?Q?KtRn/Q91xlTZc4tU1yvmTmvnS0eJ1PgXcxaabklgbGr/r7nWjT7IHG+QGgd0?=
 =?us-ascii?Q?V/l3mDDscGcokJtBcUL9uNfKMUcQCqzPFhv6xZ1pg+aokbvHvWytuDFLmPg2?=
 =?us-ascii?Q?Ts5TaOu50JBltYsryv8e5iZ/P1QrsWH/SQ5MkMRdjl5NiBBzzQIPaWe1f3Xp?=
 =?us-ascii?Q?GaNCFVAqbVF8/j9ILqMwB86Rn1+Vlthr60FAv6dJagTkloWzlNcso/ENJGcG?=
 =?us-ascii?Q?MCJZa7dl7paOm/FQdX3jeL3ayLFYUbNW1yH8yztDiznAOsbKOHA5Bu9UJmBV?=
 =?us-ascii?Q?aLbb6KJs/D5JXktK08VZ052dfYlI7YAuII5/ETP5UIPktTMnMZ2SuvpU7rlf?=
 =?us-ascii?Q?usows3Me83mYzXkcifwZUDDir7tfqumu+q3LeB+fBkOjgx3JBw77qrnQxmGM?=
 =?us-ascii?Q?bh06oEHPxRiLGqSf9jZcHdQSqZpeirc6meBTVSOlzby3hPpF1Ko8VkGpXnT9?=
 =?us-ascii?Q?4f5cVk/54JwEYE0ifoOpco5jMR29+qJV8F39bm15?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a133dc-f2e6-41ec-bb11-08dcbb70cd2b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:20:33.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCO42TpiT/sOCvw8boo0tzUzozv4alzGaCIsPGoynFZda70zKoOTfTYR1f5sVSWflPpujKPqMUSTfiq5oNCqbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8198

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe. Change function prototypes from void
to int and add appropriate errno's for return values that will be
send to bus when error occurred.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
 .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++---
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
 7 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 13391c2d82aae..b2ede4e579c5c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* try to attach to the target device */
 	sdiodev->bus = brcmf_sdio_probe(sdiodev);
-	if (!sdiodev->bus) {
-		ret = -ENODEV;
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
 		goto out;
 	}
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..58d50918dd177 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,7 +561,8 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		brcmf_of_probe(dev, bus_type, settings);
+		if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
 		brcmf_acpi_probe(dev, bus_type, settings);
 	}
 	return settings;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a62..f19dc7355e0e8 100644
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
-		    struct brcmf_mp_device *settings)
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings)
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
+		return 0;
+
 	/* Apple ARM64 platforms have their own idea of board type, passed in
 	 * via the device tree. They also have an antenna SKU parameter
 	 */
@@ -105,7 +110,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return 0;
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
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
+			return 0;
 
-	/* make sure there are interrupts defined in the node */
-	if (!of_property_present(np, "interrupts"))
-		return;
+		irq = irq_of_parse_and_map(np, 0);
+		if (!irq) {
+			brcmf_err("interrupt could not be mapped\n");
+			return 0;
+		}
+		irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
+
+		sdio->oob_irq_supported = true;
+		sdio->oob_irq_nr = irq;
+		sdio->oob_irq_flags = irqf;
+	}
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		brcmf_err("interrupt could not be mapped\n");
-		return;
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (!IS_ERR_OR_NULL(clk)) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		return clk_set_rate(clk, 32768);
+	} else {
+		return PTR_ERR_OR_ZERO(clk);
 	}
-	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
-	sdio->oob_irq_supported = true;
-	sdio->oob_irq_nr = irq;
-	sdio->oob_irq_flags = irqf;
+	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
index 10bf52253337e..ae124c73fc3b7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
@@ -3,11 +3,12 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 #ifdef CONFIG_OF
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings);
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings);
 #else
-static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-			   struct brcmf_mp_device *settings)
+static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+			  struct brcmf_mp_device *settings)
 {
+	return 0;
 }
 #endif /* CONFIG_OF */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 06698a714b523..c34405a6d38b8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2457,6 +2457,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 6b38d9de71af6..462fc669b959c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3943,7 +3943,7 @@ static const struct brcmf_buscore_ops brcmf_sdio_buscore_ops = {
 	.write32 = brcmf_sdio_buscore_write32,
 };
 
-static bool
+static int
 brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 {
 	struct brcmf_sdio_dev *sdiodev;
@@ -3953,6 +3953,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	u32 reg_val;
 	u32 drivestrength;
 	u32 enum_base;
+	int ret = -EBADE;
 
 	sdiodev = bus->sdiodev;
 	sdio_claim_host(sdiodev->func1);
@@ -4001,8 +4002,9 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 						   BRCMF_BUSTYPE_SDIO,
 						   bus->ci->chip,
 						   bus->ci->chiprev);
-	if (!sdiodev->settings) {
+	if (IS_ERR_OR_NULL(sdiodev->settings)) {
 		brcmf_err("Failed to get device parameters\n");
+		ret = PTR_ERR_OR_ZERO(sdiodev->settings);
 		goto fail;
 	}
 	/* platform specific configuration:
@@ -4071,7 +4073,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	/* allocate header buffer */
 	bus->hdrbuf = kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
 	if (!bus->hdrbuf)
-		return false;
+		return -ENOMEM;
 	/* Locate an appropriately-aligned portion of hdrbuf */
 	bus->rxhdr = (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
 				    bus->head_align);
@@ -4082,11 +4084,11 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	if (bus->poll)
 		bus->pollrate = 1;
 
-	return true;
+	return 0;
 
 fail:
 	sdio_release_host(sdiodev->func1);
-	return false;
+	return ret;
 }
 
 static int
@@ -4451,8 +4453,10 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* Allocate private bus interface state */
 	bus = kzalloc(sizeof(struct brcmf_sdio), GFP_ATOMIC);
-	if (!bus)
+	if (!bus) {
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
@@ -4467,6 +4471,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 				     dev_name(&sdiodev->func1->dev));
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
+		ret = -ENOMEM;
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
@@ -4474,7 +4479,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	ret = brcmf_sdio_probe_attach(bus);
+	if (ret < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
 		goto fail;
 	}
@@ -4546,7 +4552,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 9a105e6debe1f..f7db46ae44906 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	if (!brcmf_usb_dlneeded(devinfo)) {
 		ret = brcmf_alloc(devinfo->dev, devinfo->settings);
-- 
2.34.1


