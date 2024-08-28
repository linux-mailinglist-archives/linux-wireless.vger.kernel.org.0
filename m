Return-Path: <linux-wireless+bounces-12106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC3961D24
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8708B22AA1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 03:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46014A095;
	Wed, 28 Aug 2024 03:49:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2130.outbound.protection.outlook.com [40.107.215.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF588145A18;
	Wed, 28 Aug 2024 03:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816985; cv=fail; b=ASDd+EifkbmKB4+sq3J3cNoly4MxIMiRDQoEsWVChlzAf7WJFcT5ZTxJ3oV5tqEhA5fBWTjXpG3t06wVIEBaCWDj6wEBVQ1ThCyMRbXBVsnLQ/Xu7KATStDrwDj0hr9qRtE1zRfa79C7CJ2nrBQAxRWZKKeOMHXAVE5kxwdCtAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816985; c=relaxed/simple;
	bh=2VnM3Xke/V+FBPoCBZ6dXFpkeLfGCL5kEesF20cliAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mLfy4vlWL070YzbUyiJUnJFey5Opx7UG7MK3Vuk9Axx1pYbRuEdAQ6C91pQSbFeJxMX6gIr3EUYwU+jtE8JSytg39qyRHCi+mq7k1kp1nmQWgxDq9jLOgneYASiJ1jLO31xZDWgfNrzuKbP3sd5wrqavW14P09RyNhmmSJlBEtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VF4ROkMCTvqbVWvWuO+siwdL2PFM7/4tIWT7jl1D49k67Y0q6+z5+Z+SBv784D9RYKiIYtXwSsVVHJWwiRpuORx/BcgR22mF6TKhRCsR5xenvFWA56FfVHNLTVoqrqc+RGp6popHmM9YGfoay+LLSjV/Vb9T5CPCeIVA6rDF0mMf1ZkgXS7Nzq1ftl6iI/d/IcLPLRtLV/o202vgFVcelugiv5WFooazwvNAUe+5HHK68CULGUu9vcoPdTZQHl9HUB/hnwaFWwU5jF5PAa0Nmfzrw1vvX51J00nvD1I+oLsZgHo9/H/WLhYeFMYWqwgvXgf//92rjKlhDTtf11o8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ZCKui3FOaZbR8MmUilWzOmfwqy4Ji7tdvVIJh0aaI=;
 b=Yicqcftoxwl9Uu5TM1acXk1ljNWPP8Z77hi+Kay9scuFLSVZ42pmvR4M9H3dPFdjPQGXfAqaG1ZyAvN/+LILpugvQO1NDzp9sBK2udTcM04DOLAL6pGacS3CNh8TFosqPuT/A7sB9NvwVq/6oExtRyeKydSAzctrdu/A1aIE5nBLWQg3Ab9t+k8vbi1aLUnydXaIU8qPkmsmmFHhO/4YsvGLNxsFUwAtZ4rqGbHmMlm3nBlqTr2fZlLTv88L9RcZsyc1cdY5dawG8sGE0GmSdeGQ+Sj9EUsUAQuxplKE+o2i7uAX/34X5pEmfdOEvV+JtemqQMzPw3aE7YxzhXq5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8233.apcprd03.prod.outlook.com (2603:1096:990:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 03:49:42 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:49:42 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	saikrishnag@marvell.com,
	megi@xff.cz,
	bhelgaas@google.com,
	duoming@zju.edu.cn,
	minipli@grsecurity.net,
	yajun.deng@linux.dev,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	christophe.jaillet@wanadoo.fr,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Wed, 28 Aug 2024 11:49:11 +0800
Message-Id: <20240828034915.969383-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828034915.969383-1-jacobe.zang@wesion.com>
References: <20240828034915.969383-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 643bac91-6bb4-431a-b6ba-08dcc71472c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5mBaryhj7vGaTdDHUw4kg4wVTD3gTi5cql0g0qdoJIv6xPfP7NLKXSWsZ7Ml?=
 =?us-ascii?Q?PeAoMtI5A1aijQ8NmZeGoDc1OfRCjwGOZQQQ0nnhbd4IJJL5AzHigr90n77k?=
 =?us-ascii?Q?KZekVpAaihiRKh14rnngmvFHku9UTNv6sEyOHN+USsDEK7v8L7OVBW0QoKJJ?=
 =?us-ascii?Q?welx30rgXDFSZUrtRnaNtoBsuXEfiJctvUgzFfil+VOajxSg6dH7Fm+bM/dS?=
 =?us-ascii?Q?ps0x8abLXnoVtegVTFOlKjGmaP86spIA5pb7UiPlCzLixik7wtPJdA6Fdg0g?=
 =?us-ascii?Q?WMu4+0ceJdtSDWoaED5qoJiY4gqpOwfdyReJFBCAPq53fSqhu9olMmuP4hPm?=
 =?us-ascii?Q?Qeqwl2+NNTDAfqFTZT2ESazuxfHxb0Y7+aBrXdJnaYuqqv1Mclxc/s4QMcTS?=
 =?us-ascii?Q?dKUx74tF/eVTcwnWLudRDOx3HwH60xgpPyJfafme0C+K5MytNFes6ZV0YJhl?=
 =?us-ascii?Q?0SWRtKqFcil2awpE1+b8PUkADn2jTPshO8eCCdbT6Ob0Msg7X20RW9oq3GuS?=
 =?us-ascii?Q?SkEOYAlpCV+9R2UK++cU3IpgG/X/OU52LVRFNQm6BxOOoNaZec5Wwbr1pDyd?=
 =?us-ascii?Q?GHItgFJKam8SUSz0QTo1pqwEds7Xnm/hKW1FqGQhTZpKn4O+BZcA0e4cBsGf?=
 =?us-ascii?Q?OxBhxxKw31fbCCmKwvsf8oYF76YtkaKLhwhwfFBQddctSVfTrgK7MSRFmFAr?=
 =?us-ascii?Q?ImRBwMlv5lU8vgKabNfkIweV/DULz9BOJ5xPo35KKzOr4Z5gys2QYBaozSZb?=
 =?us-ascii?Q?GZ6A5AZes0iC7u2OIXN527m/IbVYyjgwEZkpNL+fibzgYjHhAoJrDJv93dmU?=
 =?us-ascii?Q?hTNzAJBE4UkWn1vqFVGzMnyCyPwezigFp0p3vcYi9k93PNjyHJYBnCB96rSv?=
 =?us-ascii?Q?qe490HNlSohb3KQgcfAswndXrYtVp0OhY9HuO2n/r+aNOhOmq7TFWNJalWI/?=
 =?us-ascii?Q?nHDKXA9CFs/7eKXDVm82qrhc49Yq0OmIdYLHQhuRTsj16D4Fv0XRPUM7LxDv?=
 =?us-ascii?Q?bgA5thqeEg5W8zlKjak4Blh7+qkD/tvfH3Y+bYw5R7SijmOOxD69D5k9C5h7?=
 =?us-ascii?Q?8AvHBWjX/A14/K4G8bURN6GLxF8Dq+SRvlZXiTNQpSCqaYw1tQ0/T4qWJe6n?=
 =?us-ascii?Q?bzb9TDbU2GgkYwyGwOYqdjP+/VRXOl3K5x/Brvmi6ffuKHKmi4KhaQSgGBAT?=
 =?us-ascii?Q?854tmNKpl2clHm7YE0F5qJtdwDiZHGcPlpTiqhbZUT7KytOZeNOkMCDV2nWj?=
 =?us-ascii?Q?oZOWpKuTMWd0/LqsXgj2Eh7fMjauXmj73rjT5SnHoRAFa8nVnMhimX5Ck0rg?=
 =?us-ascii?Q?g6v3Yd0wv5AOg3yFJ+c0s4HmMBEFsfccPpE+ztcXkM4jgeVHv0jjirh0A5GF?=
 =?us-ascii?Q?lLUy3m4BO3mQBmmBel7PRu5Nm2wrB23dO4OMe7odkg0BD4OSRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NgZ6cCeoYz5pNvVKPr/XDgpy+i4JRTLdQ0zo48IY/rM9+qfUb5LUabD1+ETI?=
 =?us-ascii?Q?Oqov8mv4DmCvXa71Wpl58BkkBapIJIbKwoW3XF80OJTwu1cickmejJDmBSmE?=
 =?us-ascii?Q?y6GVw0w28YeQ4VdiYJDO5a/jM0MUy0g0VZxB7LsqvLgIahoGGfM/7mQNMFMT?=
 =?us-ascii?Q?ZVJuHYk87dNOzAGHpZSYHICkvdtt7J119yjQK+8sqoaZuZMAgA20yIM6G88Q?=
 =?us-ascii?Q?w/PVRHigwLIdV6VKuOvdDrn/qC0ehfdySMMfxJsxXFiMz1P0o//U66NhaNO+?=
 =?us-ascii?Q?XQgjZlG+V9smzNag1dBrcBdydBn5/16SDn9tYHM+pKb6bAunL91KI1nETXl8?=
 =?us-ascii?Q?N11TU+4Ed88SmwyJEwWoiTFK7HUIOA7gRmhJPwowAjMiDCX699JeylVnffg3?=
 =?us-ascii?Q?mFK+V0Pof8EzggAnBq+VQwKjz0cpFV6oGe3n4lkCJmIa8ITaX2mOg+t5RKTu?=
 =?us-ascii?Q?/+on5BvuRBvfmKjsO/GYXxxOjyR0XDU9Ke10K2fg0eJC849htPPplsigOAI5?=
 =?us-ascii?Q?Jn2c+PzXkZ5aBKJpZ1CkBHKmNU2qwQYpZZOM9voc8FBkAztzHEmsB2j+jJf0?=
 =?us-ascii?Q?WVuBqugNPFPsKrS3zAx7E7/7BVgdZOze2li5kb0nMHrFCNaBudDkciOG33+7?=
 =?us-ascii?Q?h5eozpSOHymn4xlM9pPs9C9Cpu3H20DFzjRu3nw3tBu//B8+4T+ao+K0ljSl?=
 =?us-ascii?Q?StruLzn3q3mxNd+qDIfQk5q2gJOFy9ibaLsD6lR8soG2uRAcmf7d51xDxrMF?=
 =?us-ascii?Q?/Fo1tCn+dO6KegMgQDTu9STb7HuxqDW3uHbr8dBKTc196q8nhQqPiZ/T5NG9?=
 =?us-ascii?Q?U7KhshdCnDKz/kD4xtnXuDELRRm3CUaUznZWSFQPfX1/yiUf4hpan0uhF/GI?=
 =?us-ascii?Q?GgTp51C4dCczuWyk0I+LCZVCOxav+arJbSKYB6BDmGirmXriyUXAUjM/rp0k?=
 =?us-ascii?Q?BAtK3FZYW9yvTpB4sGV6mAUN8GcqaP5PR5cSaEEQSJpsconUIQBL1Nj5c64X?=
 =?us-ascii?Q?8/Xlxqq9L9YYAH1pH0+tIqwDLYOlI2wJ/1PzBPGDJZ8NlL81E12Kf6RuCoNq?=
 =?us-ascii?Q?Qls8EbX59xsivejAc3QFcK6Gu5JTgFvzNhPPCsh5DUK3FyoqIQpZeZHlvB/8?=
 =?us-ascii?Q?IbJAyMnk30np0n263ay/+RjHxUZ5n3SYxykGU8xfUTexen9q/w2jpGm2qQ1S?=
 =?us-ascii?Q?soDd6UUUBNswNxHGcA4gljf32+/Y6o0E0b3rlbLuPsjaF3CmpGOyvzThtjx5?=
 =?us-ascii?Q?fEZKawHrVD8UJcrUJwT4uEIZ/rAHsSxouAEhRw3Hl2dGDnYonaRItd/Geon5?=
 =?us-ascii?Q?IzKtbT1mxInu97u/o7tPGhPdnGUh/sVXbhga2C2mVQMY3TKGPVuIRr4cIoY2?=
 =?us-ascii?Q?n9DgW0ScXfp01nTfgAen1NCsUV+Y87LODFttdL7JmuAoIoRm5APDMDIPMCho?=
 =?us-ascii?Q?r0PCbV+mu2waOKxfk+8XVYqOfPng77Ek3CkDYFyAs+Tk6qFGzU2d7QXeqLzt?=
 =?us-ascii?Q?z1vgaA3M1gq/MoMBL4i72IFlxLIFvV2RdiqY+yq8YnNAqmhnUbXKk1QYXda4?=
 =?us-ascii?Q?YQoE7O1KIJRbvCRjf5Zz65khHYDj1qFvD8vXU+Z6?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643bac91-6bb4-431a-b6ba-08dcc71472c2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:49:42.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAcA3MxFYtaVlMpAgVelyexRbuK9aHB9U9i/1OzkgaHgTago/zXPrlDGaS0ev/btyCUZiGymmTKBd5SR9AsTfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8233

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..2c2093c77ec9a 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM43752
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.34.1


