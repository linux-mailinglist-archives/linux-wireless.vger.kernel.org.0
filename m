Return-Path: <linux-wireless+bounces-10649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A09405E2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7409A1C210D7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA6D1662F8;
	Tue, 30 Jul 2024 03:31:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020135.outbound.protection.outlook.com [52.101.128.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDE15FA73;
	Tue, 30 Jul 2024 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310276; cv=fail; b=q1PGH4mveBct/8Hndn58aimModRFiiziFcRjaH2Jhru4oFJzzqUBifmZrqxEbX/oqG4QGdCp3tq2V7itkDk0M1Dupeg3lzYt0hX8aQB6VlE3ifsI2BFpskNxTU14cGsZvFLzvfKMfWOqlLwk1hFrHbwX6IO2MH/dFv5XF+FlJic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310276; c=relaxed/simple;
	bh=uL82/wogyoRCq3mcXnifCJK981f+VZHcY1NalDUMBmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciwEApxZlPkIG+UWTc6xYF7RFxh621YySyiwNXCydAYifo4lHKUF92kny6wfLyHrDdbIF41uuLctLyzMMt9VI+Ctx9lzW3MUYk3mXNEitOjwPodz3G7fDPVT/NkWgOyRf0vIGk+iPCwaIyW4U3GcKZZ2ahb+T8xg5jegBvWmP9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.128.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOLF5RFbs9YpD9fCEg1MCK9uN0SnIB59QLyNTiXxiKAH0oBPNry0NiSNpMMi2ITgsYwaXLKhmy4nIF5bBw/5FZQz2iA1zb4Zb/jozbTF5gozXtP8/FptaBckUA8JCDU4bjIDPRU1zCrOmg5qlYeQXCm7cey0y4Tx72bW9uJEktKM0om7JSieQ7l64LondP+nt4pD0y9trhG1pGU0SEjRl4Tmu3bMj9RmG5QE8tg/hzxIQ6U0LVOIUgxpPg8oLKcf3W6zO4BLBQuXxO6Oo2mynKSYBrJcFqX9ecEspSXisw8TtjxeAOIRlQMPVDv5AFChuxECkIVwxeSzp7jTdmt59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI47zx0yd/mcR8Vkmrbc2IcjL56mTtLT1d9YrKiBBoQ=;
 b=AMV9bbabeWrW5icWtMAI34CsVHzw5YEu8IMzsKGFcET83HAIQwrqEaU2YDXvc4K/GAORQd4PfhB406IVzE56QV8zGtaLWwICj6oSHFwwAd8/Pq7az5GwCc6Nc77FCI3JYPUJsCDbm2ybBqxgAdacGW6kTD61Y2YnPdCaNUcyvhKWM24HoxhbSZDTQIxCy8TABIxYhpjUI/C+rHbfMyj+GJyExYvH5Gw8vIAmHbSzFipR3OxfkoZE9yuv0lWMQawpbKHBW2z897h8oh4X4CC0RTIg0nKnCcBE4qjfByX3s1LMTiPzT+wZ5nSehMV9IETSuEMrPFbuKUfhFpMYHoD/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7705.apcprd03.prod.outlook.com (2603:1096:400:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 03:31:13 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Tue, 30 Jul 2024
 03:31:13 +0000
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
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Date: Tue, 30 Jul 2024 11:30:50 +0800
Message-Id: <20240730033053.4092132-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730033053.4092132-1-jacobe.zang@wesion.com>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa517ff-e9dc-40e8-fc1b-08dcb048100d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JceNe8CBuE0xYD8mhhIiXXCp7E7QYsnDQZPPKD3Sl2swSy41o32XHfzCkxYr?=
 =?us-ascii?Q?5bWd4yogXIkEJD2Tg2SWIPv0JR//qjye09kB4jDZVodH1rdT/rN1fkt09XQN?=
 =?us-ascii?Q?SY8FQUqW36mgqdNC5IhNIEKzu1cpV5ZepD7xiDEcX64ei9XhNZ9QilTU+OiA?=
 =?us-ascii?Q?T2wqWJim21vbJ5X6SOfo+v8DvNUB/6qA2mBu2ACRt9iMt7eHJiPMYi7YV3x5?=
 =?us-ascii?Q?0ajkztMrBwyd5uvrxk3RkGCJR5yKD9vMHqksqtpzU/Jp+zW3VMgeQh8Q7NOu?=
 =?us-ascii?Q?zoFcEpomQ6lJVWJyxG8MHC62WSLoQ/qFaalIXLh9IA2mDJ8RWHf2pC2w8ErQ?=
 =?us-ascii?Q?z9WNWtgewvcWa8NR9FSGXqJUjVhBWzY2T99E/f1KYrE3a44JN5q1OeZ5Xjl4?=
 =?us-ascii?Q?qtgX3rV07TmBZYMoUA4u4eZNwzNdW/65/Qb4v5qfTz03OtEE1tWncBuKEbkg?=
 =?us-ascii?Q?DagxlS5WC2WIqssD0vNuxcr8XSJ+7Mh+8eSdEnKZijLKF7BPnGGYZjp9n55t?=
 =?us-ascii?Q?1k1Mh7xyeNt2Efnjxq1k0dyYF2SqP/wMOG4GHHqLLX+d9bJptfd4b+DqYW5n?=
 =?us-ascii?Q?qxeelrmkQZwQHF83Kr9K6j3K0MCQ13jcIV648E+x0BiDtSXSLS5jrurtzbPt?=
 =?us-ascii?Q?eLA0M9XJkwPLw4f9m8hoBPCJmQCpcjfBlW/V1ZndNFdl6ezWoSA1x8EY7jk0?=
 =?us-ascii?Q?MAMVHrRt+cuchgs3mlPpXfl2Wg7ug3v3lbl+jWUkOg/RaXFaXlWjPl9TyOSW?=
 =?us-ascii?Q?p3107S8lycRhy/xcBPb8SnB+0Lk8qOrqdNYLFS2v3ABhSwdf1MtuCArjljOE?=
 =?us-ascii?Q?Fl0uPfJc1IWJYLU1hwdeasxJEsrP6lhoc084oJdkzQYp2V/ukQb4JtBJ57yp?=
 =?us-ascii?Q?mDjRb1F+H3R4MUe/q5e+iiIAeFKKbCC0K2BtVhfnBROWO1lWHxo2kXcYOkIT?=
 =?us-ascii?Q?Va22LFoi4sKXEayfipFnjlbB8xp3kHyvv11hweUWCprszRcTHQiFoV1YZfGp?=
 =?us-ascii?Q?2UZBW9gSo5Xb4cBTYthT+gnjUvvdDhYsRVPVhS/yfJLtuPAkYetHShEwKZmu?=
 =?us-ascii?Q?8fiArJfOvRWdMxEAVOWLDcKk9O2x5JBUUSuw7kaGoH7zCiVzI5q5I1ncikqV?=
 =?us-ascii?Q?KQlp67AOCYQUg7yjPaGjznCJQfL4RKkucMcIK0xWPGEwzU8L9mMcpRlisz/I?=
 =?us-ascii?Q?ezueYmkIpdqGy4GL8Z79KA2fsd9/IjwnNzVd066qbdXe/xjaRBulpqSarJ5F?=
 =?us-ascii?Q?vnf2FOAFpJTLK4UDNbG94umAQWn+A18mEMCmXdi1hGg3ab/4U/qIT8D1FUaX?=
 =?us-ascii?Q?tbqrUJWnBpFCRCpZ4JrAoYwUtv7PTmWPJrQqBFn1wPLcCrdiktFVklhsYF7t?=
 =?us-ascii?Q?dHmDCTxeTr6nZHCZ6wJjMpEzLyed7ueozeUErUsA4/ZpnPyjjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RK2nuIO1iEkeREDVsMd3PSVjpMBFMq19krZ/LaBPrLNPg/wIHm2kGNumpAK0?=
 =?us-ascii?Q?85/Ue8aPruzUwapCwgKNs+Cbkvm0vpzzKQld2h4NMBRgsT4lByXsCdGxcZLy?=
 =?us-ascii?Q?rdX4h97m+EhOTgcmyJzrGzqxwfLJLZnNe+hAI6uZpzmY9e63cC5uRc2Do2ID?=
 =?us-ascii?Q?ft8PVQzjc6CL/feAjzOzmdyUVy2T9Vg/xTlh8SB+C5dThcGu1OlL06dTy8Ba?=
 =?us-ascii?Q?yC4KMvU4enFi0gR2eh4EauyK5D3lHPwWmJupLD1NN4eIwwMbsX28p8CC2DY9?=
 =?us-ascii?Q?8YHv1L41Jw8OxsWzUo8ccleZHqBCJgSpiS/1Y/2jNcpUmbAdWpwilp7cDwYA?=
 =?us-ascii?Q?IX6a+Cpn0vl1hn0vBCXsQY67u4D0qonOqKRd4HPdXTFrDvh6q/2lp6R5R/89?=
 =?us-ascii?Q?A1gMrZzYruNGgtz7rZyqx6Rq7Z/QL+5Re1S7w9gWl2cnif8kSJIcBv8+nW/g?=
 =?us-ascii?Q?5R6Wx64SgN8e9qFwfCUMHWR8sFh/O4vP4CMsMi/GMdQ4AZ+cSL9BabQKMio6?=
 =?us-ascii?Q?j6iElUZipYVOy4bZ9C7O+m6Y4Gb8PEbCaW+9daAkfsTbTJDT3MGgWOqWQIgI?=
 =?us-ascii?Q?EPLLXuCfgNNq/CP0hOUYIYSx28oIRvw2zB1/3B5lVNCOfL0i6qO2+jBLfp0v?=
 =?us-ascii?Q?T11B8acM+1EEW403C3fp0eIksDQj0dACzRn4G/dmthQFoHbA73J8QxpBuep2?=
 =?us-ascii?Q?THr8V5gYuphrhTpKJyY4luq6IJBdBQMo28cOurKoQygBVqGQZakzv2sUhUjS?=
 =?us-ascii?Q?qCIlAuOIKPmQZTfSuQy5ez4cRr3XaAhCrhTv/Js1Bwgk6nIYS/nrs1SIwloO?=
 =?us-ascii?Q?nMQ8jChermxO6MDNpqH+jJ3lBIrb81Ity1nwWId87CKLinAE+P8DH2wTWgUY?=
 =?us-ascii?Q?hfgtH9X6L+YnL33aSAyBUVtL1JLWHplCLnSPAlDeapdNF76wRUgMu5wO/mbP?=
 =?us-ascii?Q?4oThULD+JdW5kZ2kPDGB4GT+NdNz4w642LMR2ftpdzTI/2Ok0NtKRb0n36hL?=
 =?us-ascii?Q?Y8KvRpfbBuKxoVP3tXf16boa7rkD1zWxYZ1lGt1VZr9tP1ILXLMx2Lek3Ogw?=
 =?us-ascii?Q?XPoIdV8kExwg+xgnCcmZYCpAG2K0LeTioqx+hBwvmX27EuSl2rdobVcoksZU?=
 =?us-ascii?Q?Owz2ohY8exqX2E66ni3Cd+ZkNn0tlxzWYmy2G+mDlWjhyNyiHltV5bwoEnY4?=
 =?us-ascii?Q?iRQbllCPjfHbjWHaR2Hm0nNeMDwySU20Gq55anKXkZ1wTXaZXLgqgpTPnJ4D?=
 =?us-ascii?Q?dErD6yQisXvZeHuxSVFJ1KBV/Pdd5VqDg1Px1w5Mhjai/7G4Vrx+TnMp1QA/?=
 =?us-ascii?Q?thGzr1p77+OKvyBwPZaivu64Wsbme6aC4Nmg67yAsPY9dR4BFzgPFnOw142I?=
 =?us-ascii?Q?7JiuWg0XhFGSqTk63g8yy7CheE3rpmPc8063Zc9Fq5LTri7MXVL3RRODyWhQ?=
 =?us-ascii?Q?+MBthYQrSCY3hB1oRp6Fcj7entwLAgu0GC7yQi4/5inwt4rifX3aOHgvHP/M?=
 =?us-ascii?Q?gAkWHEsNS1mwc9Oc+B3RBXaVp2Z5zuBtZhE9Umdv8/nc6iakBIi4cgLClxtu?=
 =?us-ascii?Q?lfF3E5C17jOYshg5Ksk6gmx6NzZf5LWYmdhmHiNA?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa517ff-e9dc-40e8-fc1b-08dcb048100d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 03:31:13.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4T1W0sC09j9eNgXIcA7WAS5C/6MfEZXtkbRqFto6+W6i2njFqrRfzJUzqLi7QJgdrWVB/2TUl5OidCFwYOzS8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7705

Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
external low power clock input. In DTS the clock as an optional choice in
the absence of an internal clock.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 2c2093c77ec9a..a3607d55ef367 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -122,6 +122,14 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    items:
+      - description: External Low Power Clock input (32.768KHz)
+
+  clock-names:
+    items:
+      - const: lpo
+
 required:
   - compatible
   - reg
-- 
2.34.1


