Return-Path: <linux-wireless+bounces-17588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0CA135CB
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 09:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E651887099
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0981C5F11;
	Thu, 16 Jan 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="XYRYscmD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336E15383A;
	Thu, 16 Jan 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017247; cv=fail; b=I9qYvjGr/Y9McHfA7c7W4i11OzvNNm9bDGvF7+8oSog4XjBgb84Ok5sKLSHh3ttnUWPwPlD+K+cJPG5baEMLLd6Kvzb1QRjdL7Hc6UHByH5sn+IX9S9NlBsXU8EZ2viI0nX5DKln0HHiQoojCf0SdNRLk4IaYSPZJuhBwBXttH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017247; c=relaxed/simple;
	bh=k9DiQ6UNQQEE041mCL9d1+o0oAtJa0dDnCHfifJMwp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rX84lbfBoaM8jQZsCODoBoarVA2GoCoI7ag5hGnDoBecM8k87cgNgAXU3Bxxs5ZL7Z8aigS+H50EYywQiABQWB4PcSuwvCPk0I6j798CVCVmZzehk4hBim17fcZYwxTsvZnF9x5U2J1Z1y9ajwgnnvDn3mkrqQXjnAZQVca4VPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=XYRYscmD; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvsCo6Jq2juUtw2qw5kpKwam51mZ+IJ4bz2lzLvz0xCBQ6/5/07Y+gkLIi1xWTc++FnxE69EEvH4IKklGtf5dN2U2RA2GhlL2OPBr+Eae7GlGpbMfc4ZTuzerCo9ILJSZvwSwEnE6bKW4Z75ayPK1/nPl5UPAHZgR23DyDGYr63JgVQVIUYy++8+wu8uFGhjWzXvKi8LnC3RmnTX3kDq11fuUNTyQvt5yp7eZLfPaoyHzMAcD6FBaWci4xbSiDdbKDhZ8wQ+mjkDMTmJi8ugkCbxWcWLv3zqfTen17ATtCeDCBK78xjDAHJJAj54JNAIkU20SN34BE24/XY5q3gzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ueF4qttOMg+T+txesb3Cb/FURkhpKEG79P9RCZIets=;
 b=LdW3tVgdjSCNlDOf7EhDIg+hzbNvYIBsFRcSEDixJXC4ibia9Bjwt3ks8fHvxfFWRQ4HWcUmDr+bFxm1xC2MC6efPSM47sj+8NznLU01ATdsgpUynFDknsbze74y+oUMStYuSogntqwfHJ4LIJWvGEiTOPn6haZXmF2LWSQ7OLwxAu1BXaPu/w5ylLE6m32XUCttrUYlrjot5tuvTxl3ZOytM8UqjuYOe/H+yn5r0qZC3/JuwE54IrPkCccO5VEPkOb9QrWmJJqoYuEF34P8NavmejedohhmaaqgLJe5RlwX7CFBYWoQ0YTkSHG40v9AvOGeHY16BSZkK3rZKR9Q+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ueF4qttOMg+T+txesb3Cb/FURkhpKEG79P9RCZIets=;
 b=XYRYscmDDuHG/BerkkT+7bY33GpW2vpSarUWF3TsWt9vX0WcpPbSkRSHOYbYFgPtcAid9RRC8zyy9Nx+HuPxPsTw1TfCwEvvIkvMS2TsvGDlPL4M97xhNb/bNvZH8na/JVDWef/qwUULbC2MQgiDfOBtg8o1lSaUaR+asAXCiAA=
Received: from DB9PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::7) by AM0PR06MB6497.eurprd06.prod.outlook.com
 (2603:10a6:208:1a2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 08:47:22 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::c4) by DB9PR01CA0002.outlook.office365.com
 (2603:10a6:10:1d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 08:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 08:47:22 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 16 Jan 2025 09:47:21 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	johannes@sipsolutions.net,
	p.zabel@pengutronix.de
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: rfkill-gpio: enable booting in blocked state
Date: Thu, 16 Jan 2025 09:47:01 +0100
Message-Id: <20250116084702.3473176-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2025 08:47:22.0008 (UTC) FILETIME=[4207C180:01DB67F3]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AM0PR06MB6497:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7690af9f-a0f1-434b-08bf-08dd360a64bf
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hwhM4h5UlrlYnBIlR0XejAx9PlOZicBnEPExetHExa10MKgxEWwScIJT0W6?=
 =?us-ascii?Q?ERhobgq+hhTOOyIbXDzGZgb/3GvoVTbRlgDfcDJVPJGYbmSER8+OOhcoDcIy?=
 =?us-ascii?Q?cYAzILwYVz0FSm80/lTaCVU7hlkKa0LvPhvIy8vH93as9S/78PhhbFmO3fpK?=
 =?us-ascii?Q?XCihMPrcSiDUJeNvLHJNOwK6pgoOBThVXm2/vpp2saLaSNOU4lVYyChxdecd?=
 =?us-ascii?Q?IcEwwlLnJ9t7/1lcqn1PkznTkah2yKtYhTME4nF3DJf0IRlfc7IUSHQHwOpD?=
 =?us-ascii?Q?S3swbgckC6nwrhOC9E/bqecSSFr3z2NEoeAeKXP5FM8TTesZR8oOg3SIUDrE?=
 =?us-ascii?Q?LL5d5J+h0/V/abvNoCZDr+UMUU8OG03SkZdSY+K3pSKoXlru0yoOwZOiRoWY?=
 =?us-ascii?Q?nqkMqILW26RDovgtVHx34eifbM6gNbOYQV3tOHBTe/rVHBen29CJ88wKhqew?=
 =?us-ascii?Q?HY5A3scc7I1nsLirpaqf/Bs5sIdVOONLAOCIhrHCWkGhrLIsAdix8fuYkYrr?=
 =?us-ascii?Q?vq28nunwtiI4xbaiHhIv8gGelc2VS/lhbmYDz+QRgIV31yhwWoj+I/ZwuKnN?=
 =?us-ascii?Q?FnYvDijj5k0cS7mRQK3jMQZUrwQpJ4FRrIzXYSXAjUzcITZHoqocQEs0oFns?=
 =?us-ascii?Q?OhL2e6LOAvCZVdtAvCYkb3eHiJXY5505WxRd9TT3uxPqsIkZW4Koft746xjc?=
 =?us-ascii?Q?rC7Unwq+ScspCwozq8e4KeYGE8nvv+sMdygdSvOsiA/izb7U1rLvRP6y0iu9?=
 =?us-ascii?Q?AN+hhgkSepWh/guroq4ie1RaAqvQIRG7kJnTup3ozliIgYaXtOSJIItNZxxO?=
 =?us-ascii?Q?IoFKukEejp4oVAt3BKJAKbv2jyAz763YGjfY/XvOZLnSD9R10UpXUS80gX66?=
 =?us-ascii?Q?LUZUowHKyI0f2g3SLrJtp7FMpMDeG+VkEWeMHxJWu3ttjEmIsDF0GAoWTdT0?=
 =?us-ascii?Q?ySSMhfGHdd7OS9n15PDpg5pauB473IJjHeKHOroAjedMY2HyUMG3PS/4gTG+?=
 =?us-ascii?Q?Nw7BZkAQCNMJlw7c3l07Xa3ag/Y7kyhgLgRM5ChhW3RbdCbbiy+mF2UOL+I4?=
 =?us-ascii?Q?DXiAUVSdosKA6hyj8lyizy1ZJLFJeqewcJWF3epcwjQyLDOReYi+VBfK10Sd?=
 =?us-ascii?Q?NuOw1nE2G+7o4bEcTKohjOoT9dFasU94awvbS4HYqF3Z6znCQnuNG9nsD87f?=
 =?us-ascii?Q?SwdE7Hir0NNWvijdB40Q1pDzzediI89VkauNeACv+/w/gIRqQ5vy4UJkuIpO?=
 =?us-ascii?Q?SyASGgB0AGKdfixgKla9C7EYp+zsIbI7JzpYWwOc1Ld6CfQ+pJBbkgzHH1/2?=
 =?us-ascii?Q?3Ux6aYTHMuMmGsV+4LfB/pMSyk+9nLJISDskwBv/m1ULpw5DFYQnjqsuc84/?=
 =?us-ascii?Q?nVixZDA+sYP82nH4PgzfQcjV06GhmwoFZzPAvQT4rDpvWszbdMdBAElK4q57?=
 =?us-ascii?Q?ilydRh2nJREyDsD6CWvIOhR44yXcCTov/tahwTPgF8pBYUm52qvhiw4yD0yZ?=
 =?us-ascii?Q?XgSFa5VHCUvMWWJZlQ0K0FDXWvuOVxD+nc7L?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 08:47:22.2730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7690af9f-a0f1-434b-08bf-08dd360a64bf
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6497

By default, rfkill state is set to unblocked. Sometimes, we want to boot
in blocked state and let the application unblock the rfkill.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
Changes in v2:
 - change "default-blocked" type from boolean to flag
---
 Documentation/devicetree/bindings/net/rfkill-gpio.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
index 9630c8466fac..4a706a41ab38 100644
--- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
+++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
@@ -32,6 +32,10 @@ properties:
   shutdown-gpios:
     maxItems: 1
 
+  default-blocked:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: configure rfkill state as blocked at boot
+
 required:
   - compatible
   - radio-type
@@ -48,4 +52,5 @@ examples:
         label = "rfkill-pcie-wlan";
         radio-type = "wlan";
         shutdown-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+        default-blocked;
     };

base-commit: 25cc469d6d344f5772e9fb6a5cf9d82a690afe68
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


