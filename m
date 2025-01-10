Return-Path: <linux-wireless+bounces-17299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F55A089BE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BB2188C7A9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE32080D2;
	Fri, 10 Jan 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="m2Djh5DM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9C207E02;
	Fri, 10 Jan 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497220; cv=fail; b=Oem+PCnpr7fUHHNitfuDmKzmUDSfBI+5fheSQPoAi4bYmXbOKlNYMGirwbKXNsCuddqHL/pB+NvgAbX8OgLvl4c9wBgjGtHsulrvMdXFic4fukCtL8/e2M6OMYDjMBBEdG5Ugwbtmd2al4rs1nnrRLMy2m9V2OWLag+iaaSxNag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497220; c=relaxed/simple;
	bh=qobj6G+593UvCJ2IHCUHccFnL6Fclzm+HsyFp194Bao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kXyp6xu4XNiPHGcu9xKexBat/tlb6akLos5rVX9NcglFnCjF6hjOH2DkBHtys2NUxXNny6rSgQC8wB6ygZRBzDgM/pEowYZPA9Qj9ibcwRAHz+aB8TD/BgI6OwjEwOLBgHM3aE1Nex55F8rCE5K0Ig+DRdCFJjvdCEOYVS0sPWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=m2Djh5DM; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijrPPYY8b7AMN3VzLKLMFcO/vNySCLmmX5eyyGbCUrorfOZCJGi53l9G/+h47QBMPktfaXzUpEdXQG0uZc75t8GBJDBGLoJYcsjIEAGbabMgojMMCH+BWpaDWnUE9wonNwPEXNzy8WKumExmsK4CM2faO6dmni5yLYupV30Lz3VVe1F27PDWWZyesov/z6Jar6G3foz3pRdPZO0CkogALuIA5/wN1DEevkRWSoq7JfpYnaE61jxXQ7H8QbDR+ZMVPMs/lLYkCzrBwrBBXTDrY/qg3X49szPWU07o804xe9ZVO3AVJMYQueqvjtYGTuVsLWKCcb28TRVSj/ZNogIKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObuvQrM6K7PmVdpYk05YI2HrEhMl3SOEwV5saoVTjyc=;
 b=Wc90wG5pa8BJ+HELTqnAtP7itJ04wVIeYFsDZh5ytN9AYCR0w2HQ0DNl6l/F8Fh26MFiovWWWIsp6ox+ML9dLYtCQ6RL2j1VvnCs23z5AMPYRMGNm0fnqs7IDkBVSH7raWrI8WVKrftB/y9Kj34nOxossyXXXhEmWEPClfDrmt1WLlGXVqBSZW0WR4NgejUjaVpg6mEA0EVUlV56bnH+Ufn1dk/d5zv1KbA4aHTEpbNNesByp88m1Z+vPW61On99jpYKwYzi50D/gptiFic/hjaMRPIqK2Uwxr4hUAXPeuOpsE67ig9WGGvVXUISh8O+t0MGOp16xjhhhksYRVJEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=temperror action=none
 header.from=leica-geosystems.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObuvQrM6K7PmVdpYk05YI2HrEhMl3SOEwV5saoVTjyc=;
 b=m2Djh5DMpqxnw2SouOMYLSPu6RrJ/jWlD3YqkCKyREssAAsaug288rcHV2B9/nUWJz4UKnMUvSH89KLOCq5OWYBW8ZMSS7Iyf8l5+FDc9eCtK0ZgZ10PoCMf092hrqP3j1pVyW18+nuNlZKJR6MJ+zKEBPY2n+XUif0v5aNBd3I=
Received: from AS8PR07CA0045.eurprd07.prod.outlook.com (2603:10a6:20b:459::16)
 by GVXPR06MB9609.eurprd06.prod.outlook.com (2603:10a6:150:1e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 08:20:09 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:20b:459:cafe::27) by AS8PR07CA0045.outlook.office365.com
 (2603:10a6:20b:459::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.6 via Frontend Transport; Fri,
 10 Jan 2025 08:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=leica-geosystems.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of leica-geosystems.com: DNS Timeout)
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Fri, 10 Jan 2025 08:20:07 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 10 Jan 2025 09:20:07 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: rfkill-gpio: enable booting in blocked state
Date: Fri, 10 Jan 2025 09:19:01 +0100
Message-Id: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jan 2025 08:20:07.0511 (UTC) FILETIME=[7550CE70:01DB6338]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|GVXPR06MB9609:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 09e97ef2-3c1b-491c-f71d-08dd314f97df
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOFCgJeDqHXgNjNCRbB7xy27RLjLK7w2pt0vadxE0lI6+Vz1jWfBYlZKumbZ?=
 =?us-ascii?Q?+Q8X6smrwVkxz5YwjgEDKvzGkd/cFLyZrBf7WZuufayA3loz81eG+sgf1Tin?=
 =?us-ascii?Q?tKMmXeZczAnMJx9H/myUldPOtEMaloprVpfaiDDz3ir9xBNELRTPrNGj0gp2?=
 =?us-ascii?Q?07vZKq4nCPpatPwRtfMZnR3PpEmF4Di9OVYLgmhIPmpzwDK6Jg0AbSwslBFC?=
 =?us-ascii?Q?V8CzExJBO82iFd5KchNgG96pfhUlRqUMWs+yHPZoMY6m3NAryAONpVB+sQMZ?=
 =?us-ascii?Q?CfAVefHuBNKQva6xIcUZjpmCQ8D61yoBOTePuNwUcfGB7PaO/2jouBGkujK4?=
 =?us-ascii?Q?6f+nSkT+1fmbbw3lJMmW4/1mr/PvJfag5xoisWcnjcEcQaTkivG5jZm+qJEX?=
 =?us-ascii?Q?w1XRu2UR9XjV9PBRCaHpTozCddnOV/L2lVjydr7e4+OSkydsD6be1oxAgK4t?=
 =?us-ascii?Q?LxEZzn1drHQmCG+sZ6hrdOllnu77HMgubXcnbS9B+fQlxBNSXbSHqIk1a7Cr?=
 =?us-ascii?Q?ch9RMnkXHoZBPAMNIiHkYh+JgIsMiQGiRCk3Lwj/yuXUPOHnGaamLu8KTJJk?=
 =?us-ascii?Q?Fnhq51FbHikWxTGUxo5Jbc/FqiPJYk7VfotMcbzbIPzvLhuR0zmGyWJQfkzZ?=
 =?us-ascii?Q?ooit4iUy06070sGjj2yD0LypOAMmfIXgwS+yOgKpzbtVk4rzCCIzDAIFFTNe?=
 =?us-ascii?Q?W9pbh3atplfSeeqU3mQOflpd6xqyltOgnjHO90VFdkSVallQvCKMPdvqC0YH?=
 =?us-ascii?Q?sUl4bQRMbJ4HpOtrISG+aNod1WW8xsLsV2fTJ6DG/A6Fcfa9gusGLftdSOV9?=
 =?us-ascii?Q?2ihML9iFnRoBOF8xNWCtzxdjpJ+baoJuA963Z/OCvJt/DoYrltmGQ9FiJKwN?=
 =?us-ascii?Q?4G0wA12Q4eV12q9Z47fE5IyZVa+Yd4YnaIWsWlrV5FiXgJAvYq006DcFyDf9?=
 =?us-ascii?Q?sAmLARPGi0ULnBObK0JNqWp/WIkjhXfAiAAJ0nzECYzXSHjDl8zZWBUH0t3A?=
 =?us-ascii?Q?vr/4FTrBk8f+7uoQ+i3W4R2LM44uYUZMCPVRsksiOB9FkHPHHL4Qst5cfiIa?=
 =?us-ascii?Q?Z09n91HdP3bHA0iTFBBW0tNwHZGqIChs6EmxLKmx6xRZPz+aI6kPZa67Jfeo?=
 =?us-ascii?Q?/9aj9hS8h7QoC0MDWlsyWeXDixOM5SWFWVHfgH+sVaFUMupfwjC90k2VEWXf?=
 =?us-ascii?Q?JCprgmbEAzuZoy5faGaSOsRAjONewjgrxE7dPvWkXiOe6DLoZPJNqmILcKuV?=
 =?us-ascii?Q?CqxW4GeZ8+fmVuUG8+C2oRoArzNmA4CS6KTHcFZ6JdrV7HCG2K5AALbg46v6?=
 =?us-ascii?Q?WJxylRxmRfLAvfn1D2Ok3D87IxhpGtfp2O+PbByGlAJLyRk5HIjXzmZKODue?=
 =?us-ascii?Q?zJxYdPyJKxObf8UTf29bawHGOiqGsrKzT4Rzws5iIE4zM4w9BT1gqk088bHD?=
 =?us-ascii?Q?3yvrbwUrVno2cbGMxtYXydWU28b4+ZWa4s74IOW32uw0KwCX2slI1Ua3au++?=
 =?us-ascii?Q?p73DiiSj4eSC4wQ=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 08:20:07.5755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e97ef2-3c1b-491c-f71d-08dd314f97df
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9609

By default, rfkill state is set to unblocked. Sometimes, we want to boot
in blocked state and let the application unblock the rfkill.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 Documentation/devicetree/bindings/net/rfkill-gpio.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
index 9630c8466fac..22f26f1a3856 100644
--- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
+++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
@@ -32,6 +32,10 @@ properties:
   shutdown-gpios:
     maxItems: 1
 
+  default-blocked:
+    description: configure rfkill state as blocked at boot
+    type: boolean
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


