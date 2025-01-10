Return-Path: <linux-wireless+bounces-17298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC1A089BA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E151188C768
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8BC207A1C;
	Fri, 10 Jan 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="Hb2BU193"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD4257D;
	Fri, 10 Jan 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497218; cv=fail; b=rxPA2G3LTzZbPX4OHrGipZH2RyMMlZmUdvrmjgxP8RgmJPThQgzqiSLjssIZBL1IptGT6y8O3dsW9DeCRVG1ypJZ1yjt73EddcRRXo52cWLZ9/au4oav6FKZqvy1l91lkHDEcQPCw+aD2ITHeKRta6T2EyUsd3aVcXyRoyn1RUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497218; c=relaxed/simple;
	bh=LDDJcUrXFkWKe5FKTIJ1hpQpKblSf4eAw0bOSHuH8iE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+oCidfBK3U5uQ8EIuWfSJy267h6RIM6Tpy2jlC4RB36hqPloPeknbS1WpxRKiVjdLOzuvyNgTTXnXsEugF59XhEmhrnXBQSi2NfqWt7VLSh7DHVfp4DEpYM0bEILk2yDhOwKYyhD+bdmRZajNZOL4loAQip+igjbzAsq9Oqvlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=Hb2BU193; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oP6oprrVhTeeLkDPyV0BxqRex6UEfFgLVvcd2fIqQP2b0OGQOQIZ0uDJvIBDTI1S6POGO2xdX9lD4aRqWg3utajNkY8jfjj/joiMhfteDJCI4zND1WZ8ulNolruXLg76mQD5VVAG/POMgk2W2DQH/XDgsFV6pGKggrDf3HRu+Gmh4vj3Tp12LRAQfpJrePHJmwzPPci2zUrrtBX74kuDIfyd1U6jJQhoG2plqzrsgwVPEiI5r2yih901W9/3Eb75Lv6AIpwuTkqAc10PdTKysmJvw9nrdBfMVrK8+Scb4JYv9nSglMjUPhVe9nR4ZEpx5mLx4EM8D3ywj9fDW5KJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7ePe8LrpbKbpFWmraqm2BTfhKZLA99rUCyeM3NWd/s=;
 b=jjD5eC8PRjVKMzBO6b4P6FFH94ZDcgdlj2neCvKUBzzvPTAXUO+qeE2bn5VWT2dfh204fpJtBVTv4qicyqBgaXf09SaTMifwSCesuhA5C04l/wkBHBwPBGrPM5p9N8jQTOMsXSxqIfkl/UYSu34FfYQLrUEHSkWu0rI30fBcfvQljhzurQvvKfh8sDzk5KQG3fn8qvmspta4nUiYUPM6dXJJsiP9nxUPSa99tNs5FbxLeEDIhI8i06oWS0Lh5RYZm5PVQnFVumPG3C5CKGc0w9AntEEyF154CNxbmJs81/Ctb6Plmhq+fFpdJ0RQEHnyyvm4jMuP2c55w9hCBpKRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7ePe8LrpbKbpFWmraqm2BTfhKZLA99rUCyeM3NWd/s=;
 b=Hb2BU193yYjTdzhi1EYMSCYOpSqYvQC0hpH9aitksFbwHJo4Vhrk4GmlzYG1fS5NviDl4isZTIgdP0TBV4XNt9v2LDnqvd2oY+tIoHsKF80XcW/6NDpBiv53/NNi63stY70xkEq94GuM0/tXAkea3e3xUMNbBhwof0QOPKpCe18=
Received: from AS8PR07CA0058.eurprd07.prod.outlook.com (2603:10a6:20b:459::15)
 by VI0PR06MB9747.eurprd06.prod.outlook.com (2603:10a6:800:21c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 08:20:11 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:20b:459:cafe::5c) by AS8PR07CA0058.outlook.office365.com
 (2603:10a6:20b:459::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.6 via Frontend Transport; Fri,
 10 Jan 2025 08:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Fri, 10 Jan 2025 08:20:11 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 10 Jan 2025 09:20:08 +0100
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
Subject: [PATCH net-next 2/2] net: rfkill: gpio: allow booting in blocked state
Date: Fri, 10 Jan 2025 09:19:02 +0100
Message-Id: <20250110081902.1846296-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
References: <20250110081902.1846296-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jan 2025 08:20:08.0371 (UTC) FILETIME=[75D40830:01DB6338]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|VI0PR06MB9747:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03912be0-91aa-4275-17ec-08dd314f9a47
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PNzEp44U+6aQdrmUQkUgVNYN/gdAW6WF3Kr6+U9usSajPF5LNfnVg56dvu9o?=
 =?us-ascii?Q?Jf7Igm32bCTcIPShi0b5tRle1X/GxLW9QskvwVGvUwZr/M13yTB6EAvW9YQC?=
 =?us-ascii?Q?lKBfcZq2DJkqzLB7A9sIopBVBrvkOQJyUDeITIXetClDHANrBqDlilDQomFi?=
 =?us-ascii?Q?OBf3AqNf3Bg3hJGNzYW+AHxp1ZwwLaxnF3JC9ZHxLWjYP2rcPmofNDaI0g14?=
 =?us-ascii?Q?/X4ICBxgqWVWLei2Cj7d3WlxUg7t5eF5WY1IDjwvWEYSvvy9NWoS1AHTkk5F?=
 =?us-ascii?Q?p00f/ffoPrD6X+/c6J71T4tyaaLFaPVMNRh+/7vTT9KHy8R6w2H9U3AdlU90?=
 =?us-ascii?Q?4GP5YurUxUDZPQvQXmRUcgzpM2XdCIDE5dH7hmwUqzYIZk1BV8fC9YyeHs6S?=
 =?us-ascii?Q?aJBp40y99MHEpWKdKUWT++JVoVoot7fy4FYJGPShQp0BQJtTE6HQ9QzUB0tt?=
 =?us-ascii?Q?ldZnvP3SmObQVKIkqJ06aiGGXLPpZf3uhCz8cQxMz/YZ+EPVLWQi/19Meh0D?=
 =?us-ascii?Q?P0QOJ91AyBlZP9n6ntxP/MskJrHfRJbZWqqvpRQLZbOe3ttG2jByf3/W6FWw?=
 =?us-ascii?Q?JI/OrYxA4JcKj81zjUF3nHnNk8b7IOSvfaBFhoQXUluZ+KYrGDelz/lIeue3?=
 =?us-ascii?Q?7DTuDgQwF5NqzUEMA8M4EXP7Uh6W5yVCBgmaMPen6+FhBVjIRHB9yhKs80xf?=
 =?us-ascii?Q?+V/7xNJKJ7sJsihXlRrIsE6htxjfdJqOnfItGrOfO8y6gcJ5WZlc23SJ4DtN?=
 =?us-ascii?Q?Go7WtAohZcJoUJxJCYnQdxrm+CkH9rsCKc3s8P897d5jWfM0cyfyyengJiBI?=
 =?us-ascii?Q?hlHLVFXawdPkjlOemnzik9V7xviHJSxj6NH1VIRWELKcVRpFnahTkMUnQSda?=
 =?us-ascii?Q?RZiV/cSCNLIkBD9H/rBcSC1xMQ/F83N2yks0ApqAvpLdGxAAmp71V6dXrL9k?=
 =?us-ascii?Q?f2tu9KF9GQZsdEPIMEu4GzRU6d9b2zZ9097ZFG5qrMTB1yBcYEiQSLYmJ2E9?=
 =?us-ascii?Q?2lcLEHk/yUygIBnlshIbqEP+oZzhQ1U6lBvV1kU8XajS2+6yXa8YjZ9eSZol?=
 =?us-ascii?Q?tAX6Byvx15HJdiJIZxfzHgQWgcneZeuANWChHODLOqDezsA9Z3u0uU61uDfk?=
 =?us-ascii?Q?4Xw7CKscfDDX3MPk71qo3b/tY+44p76SX4AILuPBUjTDDEkPk3qyqPVEIa12?=
 =?us-ascii?Q?XSvYt6EbTnojcvKeSAPvS0VHviOeUF3Iy26vlRBk/K6DQZbefjcYLU2LfzE2?=
 =?us-ascii?Q?bYNKOhkBHVuLEAch4ad6+JpQDooCYv6PS/vFNt+3G7tDH9FCCbnaFk9UP6xi?=
 =?us-ascii?Q?hclFc8AiYtGH7Oq6we4D2b9tEIG0iEPT++nRBYQMwlo/obnGu2SOTOrCguzm?=
 =?us-ascii?Q?KNwHSRs1XDSn1ldi6FdA3rZPdkIkrD+xZm4rHHCbxEHD1jM9R/CMY8oLVyL+?=
 =?us-ascii?Q?tL2Uf6QJIMoq/vVeUUOtY1oecyd/1utETthZeqIZ/xiYu5VkPT4vR/8P1090?=
 =?us-ascii?Q?SFKC70TdsH/GDvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 08:20:11.6068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03912be0-91aa-4275-17ec-08dd314f9a47
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9747

By default, rfkill state is unblocked and this behavior is not
configurable. Add support for booting in blocked state based on the
presence of a devicetree property.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 net/rfkill/rfkill-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 9fa019e0dcad..41e657e97761 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -162,6 +162,9 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 	if (!rfkill->rfkill_dev)
 		return -ENOMEM;
 
+	if (device_property_present(&pdev->dev, "default-blocked"))
+		rfkill_init_sw_state(rfkill->rfkill_dev, true);
+
 	ret = rfkill_register(rfkill->rfkill_dev);
 	if (ret < 0)
 		goto err_destroy;
-- 
2.34.1


