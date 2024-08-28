Return-Path: <linux-wireless+bounces-12108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF8961D2A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D871284BE0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 03:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C10114E2E3;
	Wed, 28 Aug 2024 03:49:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606A14BF8A;
	Wed, 28 Aug 2024 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816993; cv=fail; b=dkOAVAF1BWVOIHvE9ZkmOLdb9fYPH1xhqIEKc8Jq5wC1KM5d+ESka+JL6JF0EwXokwltGAF/tO1qalHCZIohsp7xWwFV5K0ftKnszhUzRpy3PzD8lmuJaszZf0rMC9xQbPTL1c2Fsrvh9rnynp77h6H6mFtWe0AklnPoio2o/gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816993; c=relaxed/simple;
	bh=SkJCMMdxlPiXHgrU+t4Un0L3oRjoKWUvMNm29UdJmfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0QVSSYh3l58ZhikJrClSYspio/CZzplYTxntzsQC5AxpxGJxo28yIImiCylMXYUXBEWbdnTb79EGcioHWSM2HmrO0PEgg78X90Y50C2b6xnxZ0SPaeriGTlX3t5Iiq2vTsU8OiZZmr8b9kQ5pQy+vPV9t1DCs05ufDpJKOopIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hutjUKLEXDzS1riJNs3QfUi3oyoEfmgzXsBucSsyeTvzsQEF9BfLKJdJ/0hMQoabji43Xc9eseGJsooQpyqAWOoneaHq4EMkQtQy8yLgd6gdTfZ/v6+YvHJN3FxO4mRc7RApKFhI8zSPNKowfglXnMgqAjDotIf81fPip1CQ6LlnqIq9ZUEahfQEtCwyMyK7Tcp5yBWRt05nHOs7Ax+JZV/350tKm5oCKKTRfJYVJHAmoBGo1xpUJC4Me57lFzkjJ71dWnqxrkC6K/pLIdLG5IQePRsj0P65OqEI8yIR4pNvBnzt3dUYcRLhm4eWh1NsvSEJ7H4ip2vh5rc0uamXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTgJ8ZwxW+KugQc0Y9vNTj7zyjU/ry5rYyMRb49SIxk=;
 b=H+zxmz8yjdiOFttS7DfP1URNk20EdhYlaVql0CATEAPqyXNoDp4lUXAbuGLRiyzTrpfn5XoJKo8BlvNRIbH0P6iC3R2UHInXOHRuSQxp5SX28LE1vVyZaT08f5cLUaN66Hxr2tTb/wVQqtNglXfCE/LA3b45Q0XHivA+lYeQXPNm/J9K+u4i+0kra9Pwf/G9WU5nuZk9KuFMIbVrPiXBpcFuKIOLsBJk0x8iq8GEowanNpnWFXEGgULadWzlaenWMxbrHgrhhPe6r2gYZxaZ45ELkhx8cU1MFJck+KrvJyBEi4cVpKorWXCWBC69imqt8l0z5BkY23pgKQW4RRrYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8233.apcprd03.prod.outlook.com (2603:1096:990:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 03:49:50 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:49:50 +0000
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
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v12 3/5] dt-bindings: net: wireless: brcm4329-fmac: change properties enum structure
Date: Wed, 28 Aug 2024 11:49:13 +0800
Message-Id: <20240828034915.969383-4-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb56d1f1-195f-4b61-d6c8-08dcc71477a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0pOuRTGUhVbpSr3xT3/Mz1SFSTtvNgAL0nz4bkFh6+cuic7YX+l46lLXwDR?=
 =?us-ascii?Q?mGTQb/wj9Y0S9tiWZCnqPNZqlJAMwg6s408wasn3YzOLndF5UTUdYE0m01ci?=
 =?us-ascii?Q?eSMzP8GEWkHodoiirFghJj5ivGBDUXX1KFeDmQzFnDIKv9fj82OOWjP6FZ38?=
 =?us-ascii?Q?ptBz+AoWFwhjjk3qp42VuWDas+3R9bS/5APfV7wGwwQtbPwwuQrNBjjk+Oku?=
 =?us-ascii?Q?x2AR/WqwFmiOpvm8VKKX3LhlUkWzL6xGCquG6bFWNnBnpAHKL+FBy/6n7IzM?=
 =?us-ascii?Q?xANFAwufaQezaujHYdlODb2FVw1cPqY/m3iLIPrOhohns++2tWr1B69PXvsk?=
 =?us-ascii?Q?bRtT0OZCL0RICOE2OsNgvvirvhcf7t2kI7mACoQY3yYrgQFyNokxwPcILdKS?=
 =?us-ascii?Q?Hgzn41h8E+HsIc/538rbvKxny1+U4a13XA5dzEjK9DX3I8BH9gvNDjzgvK3a?=
 =?us-ascii?Q?9McVEyrGJfKpy6p+fKBeNATwIpZBR+Zsaro8LB1YL51DCOgnAEiQo2PORocC?=
 =?us-ascii?Q?thXyxHApogEkdmTEGT8/NNYTSezLH1OTSj798WpGQQMXFELBQFU82mioURis?=
 =?us-ascii?Q?W3wqWZ0PLX1HNaw/YG9He16BZAyv1PQr1zqFbpLAKLQXPH4ZNar/NlfIWOVB?=
 =?us-ascii?Q?3tzx9daUeIosj4KN4X1mKRdU5zu9XXzJBl7GA1sgOcS0mNzhxifSW52s+fcr?=
 =?us-ascii?Q?HwqUX65Hw+IyTRmJ32kAhV0jjSiIJi0gLsXBxY8+QNJgczOSw6auOob1Otp+?=
 =?us-ascii?Q?poMhLn68XpO2m3C54yto6wPvokHRDDtWC4WOkUOxXj+enMRAYKHDtrk1dLO5?=
 =?us-ascii?Q?o6Rz5OoXRevmQTmwc3wvQ/zvY9bf+8d6X1QArSxd5us1OfFa1fIkIA81pG0U?=
 =?us-ascii?Q?cvctkcletpQbyCR6qWuOJzTlbuNKKpx2Vie3lh2QkKwGfhE4l+A3OsgtLGHJ?=
 =?us-ascii?Q?nbFIdy0gFilD+01e03ftqHMnKccgQXGKBhur1XhLZRsXqVyoY8o/cALOnkpN?=
 =?us-ascii?Q?DCldU8UuSq8ds8uILIIq/KJLTZ5eMfmIDmuco+d1cg4JygIZgqPsJo2RvYQS?=
 =?us-ascii?Q?dus+sZVW8dCqv17P1Xm+eXiEjcZF2XoM5gxBcYWnucQMA61NEM8gzQmYXQ1H?=
 =?us-ascii?Q?cZ8XaslMrikyM6aTtA4pCo1LFwbenQe9cIjrJ2LJTDYsdePyJ8hdFUVu/PaU?=
 =?us-ascii?Q?MW1cenWzfMOocPiBjnoeI4HaWTyJ4JT0wQvZDdVyb0wEA61M3sCe1Y2Fqi5Q?=
 =?us-ascii?Q?+jppBDGxizEzxLJbiWQH6UcnTySkzxLwVubw//U7PjHPBkblC9JgLpJ9Eaen?=
 =?us-ascii?Q?u8PceGxY4M7q4wYgV0wr2VOXNmhy9D5RLTa8noeYRiEfjFaLRowOK82dDm4G?=
 =?us-ascii?Q?kK2fXg0x9TBt0UeTzhQ25o8Syd3hRPBE8cR2MMWqJo0jhGXfCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/aaYBb0icbemNm7AFSNogF4gKp7FhbgmhLK0XD0VErke9FrAG+1ZDnjVBUJw?=
 =?us-ascii?Q?OyQWaL9FkDF0+V6xWTiSLVnsdB5lb8I51mnleaT0QvaZ74qe6qCEq+Bv/qW4?=
 =?us-ascii?Q?Gs1TgwUEHHCru2IKoCR9cfpRDVR2UljYsZVvqt+diDTF4XYgcKzx2sTKX47e?=
 =?us-ascii?Q?MdIPX2uT4ud7eKagjJUFTNQ1zVmiwIJuxFhJSnsJCIOU1G1iMqTRNsXYWcOQ?=
 =?us-ascii?Q?+74ukAA8LwySpxEBIqlqRtqgKnydfYT5UwGytzcn6Cc9n52LBXwJp0I/4qO7?=
 =?us-ascii?Q?/iQRb6Orfacf4GAdBUx+i2Im93V+ceba7m8JRvfRowvD/dUXJ0izBp7fb2Dl?=
 =?us-ascii?Q?FtIXN04vYuF3PBzLEoH4jHG5SUGxiwTBoRWMLzWkJwSO2A94x8fqAL0+jEnb?=
 =?us-ascii?Q?3pTqLDs/BsDXKwRcSjWGPyzP9BfS/i+O1VCnD/ycz5j/rqV3M3R/uIuFYKak?=
 =?us-ascii?Q?hYQPi3M2O+j4d4OumeIdZm5ATzMuNN7MOdnj/RTHslfxnjXfiRhsvi2+vylL?=
 =?us-ascii?Q?3z9W9BvnG3tK1dLVE17+tG4YVj+lQGDY00Kz5x0f7Zp/JiOkwVzJkhuDFBkq?=
 =?us-ascii?Q?zoks0FZNW1/2VcQOKpykvuZwKghpty+mSzSEc2gtR2NM185s5VkjO1PfBsRH?=
 =?us-ascii?Q?owxO5xyAhe+oQFt+HazRFFEB9T4X0og4FkUVFLkbKtl/lPScLTj5k7CCPumr?=
 =?us-ascii?Q?A7EQ5wp/XTBb8L5O/k2hvQhMvSCDJjSb0V/gpcn+8iWvzhwpC0ESG+RO/mDg?=
 =?us-ascii?Q?ZjsLGad0/96yYbH/amcf72LeebAhAPK/eHF7fWq7UZrIUaO0caViqYh9IujR?=
 =?us-ascii?Q?GObJoD/Px3RVZ6DdLm6sHSdxwiocMeHoFOjQDzCrRSGsF+347IzG7JAFYliC?=
 =?us-ascii?Q?LkmlCP7Pjfkx67o6V+QB90GswMsdCoYMJ4FHFSvtOYloPRYz0DJn5uTBKSrP?=
 =?us-ascii?Q?eAJbgSS0qgKDxXd4Gnh61LQjUBeb+pvxRVEaHY0hI6QB2ZupYwMRUuHjfnXS?=
 =?us-ascii?Q?1JJTmlhFRO8IPEM2qduznFjt0UjhA6Yc+gKHY7YYOoD5l7WHUszV6mcAepdK?=
 =?us-ascii?Q?N2N2+2hRspDeiU/TBI3mMyIq7KUTh54g8LGltJkbo51B5BpId1XcS0fSo37G?=
 =?us-ascii?Q?Ob3bDw9pNPs250gtY6QbQAjCYK1rGNi6POHSE+MiLmtDd/H1RjjX4PBCyKrX?=
 =?us-ascii?Q?VQkU1XYxcm4yoliquEybyTDQTDLt0gtU1dh9sKR9xVy4lE7TCOlLvr2GdhJk?=
 =?us-ascii?Q?OYPhOZyojXVfJfK+/c1/mw44z9cWSyJYTGth2L4Ntz31hZl70pY05AZO1nKp?=
 =?us-ascii?Q?TIwJggPoQNqxRRq31al2TE/SANG/Z+GGkLJ4F0ZduOiBcNIAUVwNG0rWp87i?=
 =?us-ascii?Q?GnarWmmgeNbJPj4Ts6+2RUJjMsayd3bMopHZJRdsvfTX189HaRWYDxVKOiMj?=
 =?us-ascii?Q?5z6IhNKqIGEzX+MShbg61EsifIO0lTH1LkEPzGI4C0DrdXp55xfYW7kB4lks?=
 =?us-ascii?Q?h0sxgGOs4o9iA9aYbp/OOr7GII9BaOG5ctGSexOHMXIrF/CzhEHalkvmQO+3?=
 =?us-ascii?Q?kt+wJZnixAYUEehVxtUr9LRwp2DKOnpKyBMTjMQP?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb56d1f1-195f-4b61-d6c8-08dcc71477a1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:49:50.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUKXElNTXU2o1YfiZEUX6QhDVoB8kgad8gOrl1Zj+fyNDnIkW2jx/tU3j8CADOJjcABLuiZCLpbqevzy2huzGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8233

Add "brcm,bcm4329-fmac" as fallback compatible for wireless devices that
used PCI ID based compatible. So that can pass the compatible check in
driver.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../net/wireless/brcm,bcm4329-fmac.yaml       | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index a3607d55ef367..4870caed5f75e 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -27,7 +27,6 @@ properties:
               - brcm,bcm4341b0-fmac
               - brcm,bcm4341b4-fmac
               - brcm,bcm4341b5-fmac
-              - brcm,bcm4329-fmac
               - brcm,bcm4330-fmac
               - brcm,bcm4334-fmac
               - brcm,bcm43340-fmac
@@ -46,14 +45,17 @@ properties:
               - cypress,cyw43012-fmac
               - infineon,cyw43439-fmac
           - const: brcm,bcm4329-fmac
-      - enum:
-          - brcm,bcm4329-fmac
-          - pci14e4,43dc  # BCM4355
-          - pci14e4,4464  # BCM4364
-          - pci14e4,4488  # BCM4377
-          - pci14e4,4425  # BCM4378
-          - pci14e4,4433  # BCM4387
-          - pci14e4,449d  # BCM43752
+      - items:
+          - enum:
+              - brcm,bcm4329-fmac
+              - pci14e4,43dc  # BCM4355
+              - pci14e4,4464  # BCM4364
+              - pci14e4,4488  # BCM4377
+              - pci14e4,4425  # BCM4378
+              - pci14e4,4433  # BCM4387
+              - pci14e4,449d  # BCM43752
+          - const: brcm,bcm4329-fmac
+      - const: brcm,bcm4329-fmac
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.34.1


