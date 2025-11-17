Return-Path: <linux-wireless+bounces-29045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA64C63BE4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B290342A8F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F318331A78;
	Mon, 17 Nov 2025 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xy5WFQVE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C703314C2;
	Mon, 17 Nov 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377383; cv=fail; b=RHNddmKtEruIzTqc5fJ33b0Mz4YV83tp80CD95UcghQvvmLfFtACF4eCkl+EsX00hm9za9F6FCIiNIRbZWZKDjWOpDLuF665rFbE5n3789F7vuBa/nVki+ncYHy95E7m0r8e5UBdJDYvPsr2VkydjaxmLuodYhusVBZCup5ZSEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377383; c=relaxed/simple;
	bh=zryv+5+SHEX0J8QT2KejgCRubi9iujp72JpNIQB/+4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J00G1m4Ljb0NDXBge/wbCGG6sPgkl4JvQ2hLul0QeTWXKtOFu9+k+R36nlmDc9Ahqn7z6V+0BpeXkzRteTGQZmg/QtZjqzdZlN5SYEcInNBQ+OAldtmIujkb1DQsEkUpBECNbr/Iapkr//w8D0wu/JPoIyi1CBNk4KMox/74diI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xy5WFQVE; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5HGKbwzqZQxoX6iKfy32CpuAgvZaangc56iNWA9ywnBhq+pA8kyk5uHZh1GdvIfO60OI+n9VC9slgSzKr8e3c2LK83Xx3aWVtfG2ET793Oy7pTUWJQY5KxddhW+q3cOkZ/pDWuf2oVwqmO4D6/QeTBwDLZVPa5Ank3pAMSv14h6wSQIjCjNgMOrQ6CSx7PfU1IZVTgUrzkGwyjvtMoq3QWbiEnzam0QZPtbm00MjhTo8zo/oC1qqsC9503+WY4/4dpErcdvLPDHRkTe1DbO4L/Lzv9+Z+wEYvZNt8C+bG5Ny76mbYgmR0+I2MOi8oIJBZKvVscNiRNzapwgB4/a2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX2a1NmZ3AIVcLhL12m9pV6XaH5oBPWgF6JGy+cwQcA=;
 b=EAHldzz1XYEZ7fYiCpZTD90rnA2FuZgcuKrUjSqip8JB57pCysKEZfAtt5BbxOFzqUZ6U5nFPXJpo8fWuoydtskGUGJG5EWwkiqO9YnMeDCLTP7H9TBJw4yVlMrnE1Wp8duIvztV6foNw2TJPJc7OQnzLW9bzFpHVZYP2T34BozIrViHkynLTHqFIWscmutSf8MuQ4/VW6Gtexd0LSwN7ayNgdoZWwo0Kk57w1rDK3xE8pDM7nLlt0K1/hIzf5FD4iXKFzyy4iosLsIAQIOc6hspBJNkTwpYCq2QTkqfnHOw9blIbnzTS5MIyAailBZfbH1bPr81F1AeLGmfqc2O5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX2a1NmZ3AIVcLhL12m9pV6XaH5oBPWgF6JGy+cwQcA=;
 b=Xy5WFQVE1alksxpue0M1bTt+nu+KrhUaO7MTMKpFXI1/Msxs/TwGCyXZRifnHvm089Kxf0O66AsjnIWmziMdjWY/LPYk4YY/WYf4TzMO657a2UsQtyvqwKEWZLaPkItvkby2NfQABwRTzRsiWgI0fwOPInSqBEzoiFFiZSxr5rbB3lgiRW1oy6xyxpvlcRXNX+TWYCYqu4Q4Z8HyH5ZqfHYTXBpnK9E3ssGOAlYbe0cwncka5OPvozIRQzzf8o6ogm84XKMew41nXYbTKvQEmMv7m9y98GeUL7KznXigoI6Y1jErS/aascPidPczz9PMeGMSgx7l69wrCK9zaYboiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS1PR04MB9309.eurprd04.prod.outlook.com (2603:10a6:20b:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:45 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:44 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 17/22] wifi: nxpwifi: add driver initialization and shutdown support
Date: Mon, 17 Nov 2025 19:00:41 +0800
Message-Id: <20251117110046.2810811-18-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS1PR04MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: efc2d5e0-c9e7-4c34-c46b-08de25c8d59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TnhNlOt94/VGzG/8Tu0w60UmnVxZVkC7rmVvWztB/XE4SuRFSfqRCTg4eEqi?=
 =?us-ascii?Q?C1XPDYq9xq275IgvlOo1Wb3RTkeiavHQRzVvQJ3YrJlRk6GGKe643J6o+A2/?=
 =?us-ascii?Q?PHsW/vVOt9H4Wbpz4nEU2cqii5xNjB6fKgQ6MCzs0jpldQVhrmPZw5RInwtb?=
 =?us-ascii?Q?66APSARYOtvnrtiDVO5ICq8iWkazI8gqgP2yx3xtKNXhmDDh046yfM8gSOl+?=
 =?us-ascii?Q?aLzkEzgNUPIjhHInLxDzC969HmzFD7t8sfqMuPgSHWDzITwdEdmUwFOscR2O?=
 =?us-ascii?Q?HP06Vb4AzvaJAWZrRduEyvTYYj/XQBbcY4eAxF1LojCRQavg+tjVLarnwGqA?=
 =?us-ascii?Q?eEdZlmJlokGNVWYSnNJGUwilijSh5xatYDJOfAmDAuztiZy2KvtBSn+fgUxz?=
 =?us-ascii?Q?70mLTDONIFZDa05FtD77tTwfPTVisGocLpr26yuKhfyFS6LpSJKyJoooawoo?=
 =?us-ascii?Q?hth+OEkvwae6gk8UUbd/LCIjqxeq08Tdiu4pjDuRucv2pbptJQG+FixhoXy1?=
 =?us-ascii?Q?+bsqtCdYlzGkyK/EiCKFqDbZiwncOWJY7/jmaLQSz3CoXGBrHKTGUxRbnKQu?=
 =?us-ascii?Q?ZtZMbzUNjstKhWJQyty2IdAG5G9C5KJfGrqcXuCxr97T7cjjl48fQ8RUMCwH?=
 =?us-ascii?Q?vprrXdfHRV6uXps1lRYRcImGrMWqBdJ6gubobzTL3MmK5sPm1UvbQTkAeNFJ?=
 =?us-ascii?Q?bt4NVK4VQA7BRFhVFa0CH4MUxHy8hNYeXM+u6drAgAdy+WY8xXzkDLbIrTi5?=
 =?us-ascii?Q?dynDe5s52RdS5U7Jlh7CEjQx+ZWalgID/xI0jqG65okYySz2j3A5HgdEmydz?=
 =?us-ascii?Q?JAMaYyhvP80voW5I+T9+tPXLEhy8SBYIgqTPM7RM4klt1oq7QE3piWk7rMbd?=
 =?us-ascii?Q?YdYUYPuylWVfLWUdxzneB9iAJf7QhexUu1tfkAaoTV6P+dlnm5OWZ2LNU5HT?=
 =?us-ascii?Q?lEyUaXjom+3E1CtZHncaLYsWkzYlVwGiqxB5ByqStjXsk/86LCBrvYLge08N?=
 =?us-ascii?Q?70q2OkqHXwwLqjPugcZafbjoS4ykP2fYwoSPraGkBz21Pr3/JW2K4pGTu14i?=
 =?us-ascii?Q?nqYZWhcsKQAbLCAgTCdsRB1B411CCfDlmyWU6R5RUj39TVUgGRYgy5q6u2Cy?=
 =?us-ascii?Q?w7aFBLnw02/WZPEA1Cz1OSG0hp+0dnYFG+M4mSaGGWf95ri10FuqZxO/Jlx6?=
 =?us-ascii?Q?gRumQPpGen3pU0B2GQF8lgQfueuPJowmaFMIDcQxFTsZOj91s0EOfEAZH7QY?=
 =?us-ascii?Q?oEGNSGsM2l5bSrL/Zu97/fxDxx/V99PKwd8Qjd5F/kQBr0PP4I3t1OCcpPsz?=
 =?us-ascii?Q?YLdVTNPPQa87sOa8ntjz13q300gOrcYTrRK0s+j0/5bW0YpcxDcKgOrAC5HC?=
 =?us-ascii?Q?399ZwFjDClR6NExg+mOmA7uJMqAMQuHWkd7V1w3iwo78AOZi+HXWOVKVhp/P?=
 =?us-ascii?Q?MJk0SL/YGWhtDqOhl/WUCAPlPW9n1RlOMF/QRyj8jlrENsfr8O4g9qLgsMsm?=
 =?us-ascii?Q?C196CxyS4qpFEmK5g0Wy7PjjrjOBlD/3R3Hi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gvj6HplvipjBFiNgx3ilbm8EJRvkfw7G+AdARIWAMWT77GVMhKlch6JY9svf?=
 =?us-ascii?Q?MYEEG1KBz3MQf3MtaKL1xNxevx4tlMFokjrZ9x0u0YgwdXqYz+kpG5Vwve4N?=
 =?us-ascii?Q?3EyEe1Noa2nrgL0J2SpljF//g71pnTZ3wF84CjKKrfrBvfvBo3loTbpTmkIG?=
 =?us-ascii?Q?Hik1tUMYQ33ooN+aDVGsXQkGiibfeEm3yW5yOZ/I3KQNrxqzt/STyisR/t+I?=
 =?us-ascii?Q?ck1H4NgH9a7hPpOQ3j4W49Y2Hyw1XMp6+nFPXEQnTe97yybcJJVS8zL4iokB?=
 =?us-ascii?Q?+73o1mehWJ6ctcT7YMaXu3D0a0sQtxj+7aRLsiUg4CbJqzN//TX3e4wd7nHj?=
 =?us-ascii?Q?mS1kM/BDxCsnwVpThBilzwOCaItUbzGUYz/+aPW7R1j+DfBTaEMJ3NOEuq3K?=
 =?us-ascii?Q?fJtjxsxyJKqn65ZUqF27nNCl49H4IH/AcNrWDrDjY2tHsB6bzUums8j9mOvG?=
 =?us-ascii?Q?XP5fl/GOBr09cglJAo1oaCDA+iw+AenqHeFVZNq7khl5KwBz85J7FsBS+rnV?=
 =?us-ascii?Q?wt14KACDJudd+GFHRgBV2rvUQ5k99fzsH8NWT4hliyQI6AFOdu+arO1LXI7I?=
 =?us-ascii?Q?3UHRHKMS/3FeRdpYxwboEcPPqs5qP8lbNgwuD2TNpoiZ0lNjEdLYiw7bX33i?=
 =?us-ascii?Q?x73rL4RIzBitsYGvod7FGuVlaI4zV7wTEoThsYmyQvD4VOGI8bG+g1nniSrY?=
 =?us-ascii?Q?TuZWGihRzQxhxTcGdu85uO1cchvYgyel6VR3dDr6ljm9eLlZYZdeWEARgQbI?=
 =?us-ascii?Q?TA5gZRBjxQvGhcjc7MN3OVH9T+kU5Ur1TIV+D4Ipp+GXdpYHFkUSAMtoKgOH?=
 =?us-ascii?Q?l5fgpcdB3Q/PPQ3tZniPWinP3IzV8WfoYAY56ahDRMEjZ9F9lVNr7ETYCLgz?=
 =?us-ascii?Q?/NFpH5PR//dC1JGCQecNAYU1p0O/lreuqH2tIHPfCmci6FwTl+H9XYvzK83a?=
 =?us-ascii?Q?AVYhsSfWeWCujcUDDkW6s1IGNhLzhCwhqAv/uYcYPHH/R4XjGk86iVNp6z/r?=
 =?us-ascii?Q?FmnsRTpOJdxSYzh7yux+OkcXUft1cU9IcndpuOEKUzQXGa6ULkkK81mYgXq0?=
 =?us-ascii?Q?oqR0R5Nx8qEz1mO3zxDT2e9dG0VH7S+ErzuygtuDE4GZva3isqaZoVp22dNH?=
 =?us-ascii?Q?/iSNA50ejF5yZPfcfEPmZ6THv9Eh0m+/I896exoUFhgAMq4Uym3oE46rDj40?=
 =?us-ascii?Q?ax6vIsHT22fXTfpuNmq56U5/oQyoHWbU99vH6v0pBHCUzYbc4Pfc4IhIaEaN?=
 =?us-ascii?Q?Oxw2KpebmBX8VDz+QpFCfNzO/6IMwFDdndyQbRylX1BvxGO8heItTTaentld?=
 =?us-ascii?Q?/vjzgk7pe2wKS8s4RDXhlqQ2qWY/rIlZzt9NbkD1wTsXDLnlP5OFAP5YmPYm?=
 =?us-ascii?Q?WsJJh7LoDbf4I/y1r+FnyLvftvuHWjz13QbQ4lDNucl65RINS0+f3rTcrnRu?=
 =?us-ascii?Q?uRFJQEYV+X4qk4sCfywAbb1xJTGkaKTM/9oMPoc7XJ3Vi2yp1F7FqK3UziZW?=
 =?us-ascii?Q?j9amhp9nuQpBQW+NKnb/C6LxtSz0FKbR7sNAhSWTtFMoYwvvQoI3Wsf9e9ug?=
 =?us-ascii?Q?Lxh6T6VAV/2LQgn/q/zi9gv8O+T6d8gA57FRBVGG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc2d5e0-c9e7-4c34-c46b-08de25c8d59a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:44.4470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxKsREkrfqk93N/vBp4y9DqqDoqsG7vVby3R4FeeFtQ5fBqzFZqYwPMUSTObVDNJv7bC29FhQRWyvlDVbCUxBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9309

This patch introduces the initialization and shutdown logic for the nxpwifi
driver, including setup of adapter and private structures, firmware
download,and resource cleanup.

Key features:
- Initializes adapter and private structures with default values
- Allocates and initializes command buffers, queues, and timers
- Sets up BSS priority tables for multi-interface coordination
- Implements firmware download and initialization sequence
- Provides shutdown and cleanup routines for safe driver removal
- Adds helpers for managing netdev queues and synchronization primitives

These foundational components are essential for bringing up the driver and
ensuring proper resource management across its lifecycle.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/init.c | 680 ++++++++++++++++++++++++
 1 file changed, 680 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/init.c b/drivers/net/wireless/nxp/nxpwifi/init.c
new file mode 100644
index 000000000000..7a47f585a1d9
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/init.c
@@ -0,0 +1,680 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: HW/FW Initialization
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "wmm.h"
+#include "11n.h"
+
+/* This function adds a BSS priority table to the table list.
+ *
+ * The function allocates a new BSS priority table node and adds it to
+ * the end of BSS priority table list, kept in driver memory.
+ */
+static int nxpwifi_add_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bss_prio;
+	struct nxpwifi_bss_prio_tbl *tbl = adapter->bss_prio_tbl;
+
+	bss_prio = kzalloc(sizeof(*bss_prio), GFP_KERNEL);
+	if (!bss_prio)
+		return -ENOMEM;
+
+	bss_prio->priv = priv;
+	INIT_LIST_HEAD(&bss_prio->list);
+
+	spin_lock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+	list_add_tail(&bss_prio->list, &tbl[priv->bss_priority].bss_prio_head);
+	spin_unlock_bh(&tbl[priv->bss_priority].bss_prio_lock);
+
+	return 0;
+}
+
+static void wakeup_timer_fn(struct timer_list *t)
+{
+	struct nxpwifi_adapter *adapter = timer_container_of(adapter, t, wakeup_timer);
+
+	nxpwifi_dbg(adapter, ERROR, "Firmware wakeup failed\n");
+	adapter->hw_status = NXPWIFI_HW_STATUS_RESET;
+	nxpwifi_cancel_all_pending_cmd(adapter);
+
+	if (adapter->if_ops.card_reset)
+		adapter->if_ops.card_reset(adapter);
+}
+
+/* This function initializes the private structure and sets default
+ * values to the members.
+ *
+ * Additionally, it also initializes all the locks and sets up all the
+ * lists.
+ */
+int nxpwifi_init_priv(struct nxpwifi_private *priv)
+{
+	u32 i;
+
+	priv->media_connected = false;
+	eth_broadcast_addr(priv->curr_addr);
+	priv->port_open = false;
+	priv->usb_port = NXPWIFI_USB_EP_DATA;
+	priv->pkt_tx_ctrl = 0;
+	priv->bss_mode = NL80211_IFTYPE_UNSPECIFIED;
+	priv->data_rate = 0;	/* Initially indicate the rate as auto */
+	priv->is_data_rate_auto = true;
+	priv->bcn_avg_factor = DEFAULT_BCN_AVG_FACTOR;
+	priv->data_avg_factor = DEFAULT_DATA_AVG_FACTOR;
+
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+
+	priv->sec_info.wep_enabled = 0;
+	priv->sec_info.authentication_mode = NL80211_AUTHTYPE_OPEN_SYSTEM;
+	priv->sec_info.encryption_mode = 0;
+	for (i = 0; i < ARRAY_SIZE(priv->wep_key); i++)
+		memset(&priv->wep_key[i], 0, sizeof(struct nxpwifi_wep_key));
+	priv->wep_key_curr_index = 0;
+	priv->curr_pkt_filter = HOST_ACT_MAC_DYNAMIC_BW_ENABLE |
+				HOST_ACT_MAC_RX_ON | HOST_ACT_MAC_TX_ON |
+				HOST_ACT_MAC_ETHERNETII_ENABLE;
+
+	priv->beacon_period = 100; /* beacon interval */
+	priv->attempted_bss_desc = NULL;
+	memset(&priv->curr_bss_params, 0, sizeof(priv->curr_bss_params));
+	priv->listen_interval = NXPWIFI_DEFAULT_LISTEN_INTERVAL;
+
+	memset(&priv->prev_ssid, 0, sizeof(priv->prev_ssid));
+	memset(&priv->prev_bssid, 0, sizeof(priv->prev_bssid));
+	memset(&priv->assoc_rsp_buf, 0, sizeof(priv->assoc_rsp_buf));
+	priv->assoc_rsp_size = 0;
+	priv->atim_window = 0;
+	priv->tx_power_level = 0;
+	priv->max_tx_power_level = 0;
+	priv->min_tx_power_level = 0;
+	priv->tx_ant = 0;
+	priv->rx_ant = 0;
+	priv->tx_rate = 0;
+	priv->rxpd_htinfo = 0;
+	priv->rxpd_rate = 0;
+	priv->rate_bitmap = 0;
+	priv->data_rssi_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->data_nf_last = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+	priv->bcn_nf_last = 0;
+	memset(&priv->wpa_ie, 0, sizeof(priv->wpa_ie));
+	memset(&priv->aes_key, 0, sizeof(priv->aes_key));
+	priv->wpa_ie_len = 0;
+	priv->wpa_is_gtk_set = false;
+
+	memset(&priv->assoc_tlv_buf, 0, sizeof(priv->assoc_tlv_buf));
+	priv->assoc_tlv_buf_len = 0;
+	memset(&priv->wps, 0, sizeof(priv->wps));
+	memset(&priv->gen_ie_buf, 0, sizeof(priv->gen_ie_buf));
+	priv->gen_ie_buf_len = 0;
+	memset(priv->vs_ie, 0, sizeof(priv->vs_ie));
+
+	priv->wmm_required = true;
+	priv->wmm_enabled = false;
+	priv->wmm_qosinfo = 0;
+	priv->curr_bcn_buf = NULL;
+	priv->curr_bcn_size = 0;
+	priv->wps_ie = NULL;
+	priv->wps_ie_len = 0;
+	priv->ap_11n_enabled = 0;
+	memset(&priv->roc_cfg, 0, sizeof(priv->roc_cfg));
+
+	priv->scan_block = false;
+
+	priv->csa_chan = 0;
+	priv->csa_expire_time = 0;
+	priv->del_list_idx = 0;
+	priv->hs2_enabled = false;
+	memcpy(priv->tos_to_tid_inv, tos_to_tid_inv, MAX_NUM_TID);
+
+	nxpwifi_init_11h_params(priv);
+
+	return nxpwifi_add_bss_prio_tbl(priv);
+}
+
+/* This function allocates buffers for members of the adapter
+ * structure.
+ *
+ * The memory allocated includes scan table, command buffers, and
+ * sleep confirm command buffer. In addition, the queues are
+ * also initialized.
+ */
+static int nxpwifi_allocate_adapter(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+
+	/* Allocate command buffer */
+	ret = nxpwifi_alloc_cmd_buffer(adapter);
+	if (ret) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc cmd buffer\n",
+			    __func__);
+		return ret;
+	}
+
+	adapter->sleep_cfm =
+		dev_alloc_skb(sizeof(struct nxpwifi_opt_sleep_confirm)
+			      + INTF_HEADER_LEN);
+
+	if (!adapter->sleep_cfm) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed to alloc sleep cfm\t"
+			    " cmd buffer\n", __func__);
+		return -ENOMEM;
+	}
+	skb_reserve(adapter->sleep_cfm, INTF_HEADER_LEN);
+
+	return 0;
+}
+
+/* This function initializes the adapter structure and sets default
+ * values to the members of adapter.
+ *
+ * This also initializes the WMM related parameters in the driver private
+ * structures.
+ */
+static void nxpwifi_init_adapter(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_opt_sleep_confirm *sleep_cfm_buf = NULL;
+
+	skb_put(adapter->sleep_cfm, sizeof(struct nxpwifi_opt_sleep_confirm));
+
+	adapter->cmd_sent = false;
+	adapter->data_sent = true;
+
+	adapter->intf_hdr_len = INTF_HEADER_LEN;
+
+	adapter->cmd_resp_received = false;
+	adapter->event_received = false;
+	adapter->data_received = false;
+	adapter->assoc_resp_received = false;
+	adapter->priv_link_lost = NULL;
+	adapter->host_mlme_link_lost = false;
+
+	clear_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	adapter->ps_mode = NXPWIFI_802_11_POWER_MODE_CAM;
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->need_to_wakeup = false;
+
+	adapter->scan_mode = HOST_BSS_MODE_ANY;
+	adapter->specific_scan_time = NXPWIFI_SPECIFIC_SCAN_CHAN_TIME;
+	adapter->active_scan_time = NXPWIFI_ACTIVE_SCAN_CHAN_TIME;
+	adapter->passive_scan_time = NXPWIFI_PASSIVE_SCAN_CHAN_TIME;
+	adapter->scan_chan_gap_time = NXPWIFI_DEF_SCAN_CHAN_GAP_TIME;
+
+	adapter->scan_probes = 1;
+
+	adapter->multiple_dtim = 1;
+
+	/* default value in firmware will be used */
+	adapter->local_listen_interval = 0;
+
+	adapter->is_deep_sleep = false;
+
+	adapter->delay_null_pkt = false;
+	adapter->delay_to_ps = 1000;
+	adapter->enhanced_ps_mode = PS_MODE_AUTO;
+
+	/* Disable NULL Pkg generation by default */
+	adapter->gen_null_pkt = false;
+	/* Disable pps/uapsd mode by default */
+	adapter->pps_uapsd_mode = false;
+	adapter->pm_wakeup_card_req = false;
+
+	adapter->pm_wakeup_fw_try = false;
+
+	adapter->curr_tx_buf_size = NXPWIFI_TX_DATA_BUF_SIZE_2K;
+
+	clear_bit(NXPWIFI_IS_HS_CONFIGURED, &adapter->work_flags);
+	adapter->hs_cfg.conditions = cpu_to_le32(HS_CFG_COND_DEF);
+	adapter->hs_cfg.gpio = HS_CFG_GPIO_DEF;
+	adapter->hs_cfg.gap = HS_CFG_GAP_DEF;
+	adapter->hs_activated = false;
+
+	memset(adapter->event_body, 0, sizeof(adapter->event_body));
+	adapter->hw_dot_11n_dev_cap = 0;
+	adapter->hw_dev_mcs_support = 0;
+	adapter->sec_chan_offset = 0;
+
+	nxpwifi_wmm_init(adapter);
+	atomic_set(&adapter->tx_hw_pending, 0);
+
+	sleep_cfm_buf = (struct nxpwifi_opt_sleep_confirm *)
+					adapter->sleep_cfm->data;
+	memset(sleep_cfm_buf, 0, adapter->sleep_cfm->len);
+	sleep_cfm_buf->command = cpu_to_le16(HOST_CMD_802_11_PS_MODE_ENH);
+	sleep_cfm_buf->size = cpu_to_le16(adapter->sleep_cfm->len);
+	sleep_cfm_buf->result = 0;
+	sleep_cfm_buf->action = cpu_to_le16(SLEEP_CONFIRM);
+	sleep_cfm_buf->resp_ctrl = cpu_to_le16(RESP_NEEDED);
+
+	memset(&adapter->sleep_period, 0, sizeof(adapter->sleep_period));
+	adapter->tx_lock_flag = false;
+	adapter->null_pkt_interval = 0;
+	adapter->fw_bands = 0;
+	adapter->fw_release_number = 0;
+	adapter->fw_cap_info = 0;
+	memset(&adapter->upld_buf, 0, sizeof(adapter->upld_buf));
+	adapter->event_cause = 0;
+	adapter->region_code = 0;
+	adapter->bcn_miss_time_out = DEFAULT_BCN_MISS_TIMEOUT;
+	memset(&adapter->arp_filter, 0, sizeof(adapter->arp_filter));
+	adapter->arp_filter_size = 0;
+	adapter->max_mgmt_ie_index = MAX_MGMT_IE_INDEX;
+	adapter->key_api_major_ver = 0;
+	adapter->key_api_minor_ver = 0;
+	eth_broadcast_addr(adapter->perm_addr);
+	adapter->iface_limit.sta_intf = NXPWIFI_MAX_STA_NUM;
+	adapter->iface_limit.uap_intf = NXPWIFI_MAX_UAP_NUM;
+	adapter->active_scan_triggered = false;
+	timer_setup(&adapter->wakeup_timer, wakeup_timer_fn, 0);
+	adapter->devdump_len = 0;
+	memset(&adapter->vdll_ctrl, 0, sizeof(adapter->vdll_ctrl));
+	adapter->vdll_ctrl.skb = dev_alloc_skb(NXPWIFI_SIZE_OF_CMD_BUFFER);
+	atomic_set(&adapter->iface_changing, 0);
+}
+
+/* This function sets trans_start per tx_queue
+ */
+void nxpwifi_set_trans_start(struct net_device *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++)
+		txq_trans_cond_update(netdev_get_tx_queue(dev, i));
+
+	netif_trans_update(dev);
+}
+
+/* This function wakes up all queues in net_device
+ */
+void nxpwifi_wake_up_net_dev_queue(struct net_device *netdev,
+				   struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_wake_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* This function stops all queues in net_device
+ */
+void nxpwifi_stop_net_dev_queue(struct net_device *netdev,
+				struct nxpwifi_adapter *adapter)
+{
+	spin_lock_bh(&adapter->queue_lock);
+	netif_tx_stop_all_queues(netdev);
+	spin_unlock_bh(&adapter->queue_lock);
+}
+
+/* This function invalidates the list heads.
+ */
+static void nxpwifi_invalidate_lists(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	list_del(&adapter->cmd_free_q);
+	list_del(&adapter->cmd_pending_q);
+	list_del(&adapter->scan_pending_q);
+
+	for (i = 0; i < adapter->priv_num; i++)
+		list_del(&adapter->bss_prio_tbl[i].bss_prio_head);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j) {
+			list_del(&priv->wmm.tid_tbl_ptr[j].ra_list);
+			list_del(&priv->tx_ba_stream_tbl_ptr[j]);
+			list_del(&priv->rx_reorder_tbl_ptr[j]);
+		}
+		list_del(&priv->sta_list);
+	}
+}
+
+/* This function performs cleanup for adapter structure.
+ *
+ * The cleanup is done recursively, by canceling all pending
+ * commands, freeing the member buffers previously allocated
+ * (command buffers, scan table buffer, sleep confirm command
+ * buffer), stopping the timers and calling the cleanup routines
+ * for every interface.
+ */
+static void
+nxpwifi_adapter_cleanup(struct nxpwifi_adapter *adapter)
+{
+	timer_delete(&adapter->wakeup_timer);
+	nxpwifi_cancel_all_pending_cmd(adapter);
+	wake_up_interruptible(&adapter->cmd_wait_q.wait);
+	wake_up_interruptible(&adapter->hs_activate_wait_q);
+	if (adapter->vdll_ctrl.vdll_mem) {
+		vfree(adapter->vdll_ctrl.vdll_mem);
+		adapter->vdll_ctrl.vdll_mem = NULL;
+		adapter->vdll_ctrl.vdll_len = 0;
+	}
+	if (adapter->vdll_ctrl.skb) {
+		dev_kfree_skb_any(adapter->vdll_ctrl.skb);
+		adapter->vdll_ctrl.skb = NULL;
+	}
+}
+
+void nxpwifi_free_cmd_buffers(struct nxpwifi_adapter *adapter)
+{
+	nxpwifi_invalidate_lists(adapter);
+
+	/* Free command buffer */
+	nxpwifi_dbg(adapter, INFO, "info: free cmd buffer\n");
+	nxpwifi_free_cmd_buffer(adapter);
+
+	if (adapter->sleep_cfm)
+		dev_kfree_skb_any(adapter->sleep_cfm);
+}
+
+/*  This function intializes the lock variables and
+ *  the list heads.
+ */
+void nxpwifi_init_lock_list(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i, j;
+
+	spin_lock_init(&adapter->int_lock);
+	spin_lock_init(&adapter->nxpwifi_cmd_lock);
+	spin_lock_init(&adapter->queue_lock);
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		spin_lock_init(&priv->wmm.ra_list_spinlock);
+		spin_lock_init(&priv->curr_bcn_buf_lock);
+		spin_lock_init(&priv->sta_list_spinlock);
+	}
+
+	/* Initialize cmd_free_q */
+	INIT_LIST_HEAD(&adapter->cmd_free_q);
+	/* Initialize cmd_pending_q */
+	INIT_LIST_HEAD(&adapter->cmd_pending_q);
+	/* Initialize scan_pending_q */
+	INIT_LIST_HEAD(&adapter->scan_pending_q);
+
+	spin_lock_init(&adapter->cmd_free_q_lock);
+	spin_lock_init(&adapter->cmd_pending_q_lock);
+	spin_lock_init(&adapter->scan_pending_q_lock);
+
+	skb_queue_head_init(&adapter->rx_mlme_q);
+	skb_queue_head_init(&adapter->rx_data_q);
+	skb_queue_head_init(&adapter->tx_data_q);
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		INIT_LIST_HEAD(&adapter->bss_prio_tbl[i].bss_prio_head);
+		spin_lock_init(&adapter->bss_prio_tbl[i].bss_prio_lock);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		for (j = 0; j < MAX_NUM_TID; ++j) {
+			INIT_LIST_HEAD(&priv->wmm.tid_tbl_ptr[j].ra_list);
+			INIT_LIST_HEAD(&priv->tx_ba_stream_tbl_ptr[j]);
+			INIT_LIST_HEAD(&priv->rx_reorder_tbl_ptr[j]);
+			spin_lock_init(&priv->tx_ba_stream_tbl_lock[j]);
+			spin_lock_init(&priv->rx_reorder_tbl_lock[j]);
+		}
+		INIT_LIST_HEAD(&priv->sta_list);
+		skb_queue_head_init(&priv->bypass_txq);
+
+		spin_lock_init(&priv->ack_status_lock);
+		idr_init(&priv->ack_status_frames);
+	}
+}
+
+/* This function initializes the firmware.
+ *
+ * The following operations are performed sequentially -
+ *      - Allocate adapter structure
+ *      - Initialize the adapter structure
+ *      - Initialize the private structure
+ *      - Add BSS priority tables to the adapter structure
+ *      - For each interface, send the init commands to firmware
+ *      - Send the first command in command pending queue, if available
+ */
+int nxpwifi_init_fw(struct nxpwifi_adapter *adapter)
+{
+	int ret;
+	struct nxpwifi_private *priv;
+	u8 i;
+	bool first_sta = true;
+	int is_cmd_pend_q_empty;
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_INITIALIZING;
+
+	/* Allocate memory for member of adapter structure */
+	ret = nxpwifi_allocate_adapter(adapter);
+	if (ret)
+		return ret;
+
+	/* Initialize adapter structure */
+	nxpwifi_init_adapter(adapter);
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		/* Initialize private structure */
+		ret = nxpwifi_init_priv(priv);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		ret = nxpwifi_sta_init_cmd(adapter->priv[i],
+					   first_sta, true);
+		if (ret && ret != -EINPROGRESS)
+			return ret;
+
+		first_sta = false;
+	}
+
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+	if (!is_cmd_pend_q_empty)
+		/* Send the first command in queue and return */
+		nxpwifi_main_process(adapter);
+	else
+		adapter->hw_status = NXPWIFI_HW_STATUS_READY;
+
+	return ret;
+}
+
+/* This function deletes the BSS priority tables.
+ *
+ * The function traverses through all the allocated BSS priority nodes
+ * in every BSS priority table and frees them.
+ */
+static void nxpwifi_delete_bss_prio_tbl(struct nxpwifi_private *priv)
+{
+	int i;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_bss_prio_node *bssprio_node, *tmp_node;
+	struct list_head *head;
+	spinlock_t *lock; /* bss priority lock */
+
+	for (i = 0; i < adapter->priv_num; ++i) {
+		head = &adapter->bss_prio_tbl[i].bss_prio_head;
+		lock = &adapter->bss_prio_tbl[i].bss_prio_lock;
+		nxpwifi_dbg(adapter, INFO,
+			    "info: delete BSS priority table,\t"
+			    "bss_type = %d, bss_num = %d, i = %d,\t"
+			    "head = %p\n",
+			    priv->bss_type, priv->bss_num, i, head);
+
+		{
+			spin_lock_bh(lock);
+			list_for_each_entry_safe(bssprio_node, tmp_node, head,
+						 list) {
+				if (bssprio_node->priv == priv) {
+					nxpwifi_dbg(adapter, INFO,
+						    "info: Delete\t"
+						    "node %p, next = %p\n",
+						    bssprio_node, tmp_node);
+					list_del(&bssprio_node->list);
+					kfree(bssprio_node);
+				}
+			}
+			spin_unlock_bh(lock);
+		}
+	}
+}
+
+/* This function frees the private structure, including cleans
+ * up the TX and RX queues and frees the BSS priority tables.
+ */
+void nxpwifi_free_priv(struct nxpwifi_private *priv)
+{
+	nxpwifi_clean_txrx(priv);
+	nxpwifi_delete_bss_prio_tbl(priv);
+	nxpwifi_free_curr_bcn(priv);
+}
+
+/* This function is used to shutdown the driver.
+ *
+ * The following operations are performed sequentially -
+ *      - Check if already shut down
+ *      - Make sure the main process has stopped
+ *      - Clean up the Tx and Rx queues
+ *      - Delete BSS priority tables
+ *      - Free the adapter
+ *      - Notify completion
+ */
+void
+nxpwifi_shutdown_drv(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	s32 i;
+	struct sk_buff *skb;
+
+	/* nxpwifi already shutdown */
+	if (adapter->hw_status == NXPWIFI_HW_STATUS_NOT_READY)
+		return;
+
+	/* cancel current command */
+	if (adapter->curr_cmd) {
+		nxpwifi_dbg(adapter, WARN,
+			    "curr_cmd is still in processing\n");
+		timer_delete_sync(&adapter->cmd_timer);
+		nxpwifi_recycle_cmd_node(adapter, adapter->curr_cmd);
+		adapter->curr_cmd = NULL;
+	}
+
+	/* shut down nxpwifi */
+	nxpwifi_dbg(adapter, MSG,
+		    "info: shutdown nxpwifi...\n");
+
+	/* Clean up Tx/Rx queues and delete BSS priority table */
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		nxpwifi_abort_cac(priv);
+		nxpwifi_free_priv(priv);
+	}
+
+	atomic_set(&adapter->tx_queued, 0);
+	while ((skb = skb_dequeue(&adapter->tx_data_q)))
+		nxpwifi_write_data_complete(adapter, skb, 0, 0);
+
+	while ((skb = skb_dequeue(&adapter->rx_mlme_q)))
+		dev_kfree_skb_any(skb);
+
+	while ((skb = skb_dequeue(&adapter->rx_data_q))) {
+		struct nxpwifi_rxinfo *rx_info = NXPWIFI_SKB_RXCB(skb);
+
+		atomic_dec(&adapter->rx_pending);
+		priv = adapter->priv[rx_info->bss_num];
+		if (priv)
+			priv->stats.rx_dropped++;
+
+		dev_kfree_skb_any(skb);
+	}
+
+	nxpwifi_adapter_cleanup(adapter);
+
+	adapter->hw_status = NXPWIFI_HW_STATUS_NOT_READY;
+}
+
+/* This function downloads the firmware to the card.
+ *
+ * The actual download is preceded by two sanity checks -
+ *      - Check if firmware is already running
+ *      - Check if the interface is the winner to download the firmware
+ *
+ * ...and followed by another -
+ *      - Check if the firmware is downloaded successfully
+ *
+ * After download is successfully completed, the host interrupts are enabled.
+ */
+int nxpwifi_dnld_fw(struct nxpwifi_adapter *adapter,
+		    struct nxpwifi_fw_image *pmfw)
+{
+	int ret;
+	u32 poll_num = 1;
+
+	/* check if firmware is already running */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (!ret) {
+		nxpwifi_dbg(adapter, MSG,
+			    "WLAN FW already running! Skip FW dnld\n");
+		return 0;
+	}
+
+	/* check if we are the winner for downloading FW */
+	if (adapter->if_ops.check_winner_status) {
+		adapter->winner = 0;
+		ret = adapter->if_ops.check_winner_status(adapter);
+
+		poll_num = MAX_FIRMWARE_POLL_TRIES;
+		if (ret) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN read winner status failed!\n");
+			return ret;
+		}
+
+		if (!adapter->winner) {
+			nxpwifi_dbg(adapter, MSG,
+				    "WLAN is not the winner! Skip FW dnld\n");
+			goto poll_fw;
+		}
+	}
+
+	if (pmfw) {
+		/* Download firmware with helper */
+		ret = adapter->if_ops.prog_fw(adapter, pmfw);
+		if (ret) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "prog_fw failed ret=%#x\n", ret);
+			return ret;
+		}
+	}
+
+poll_fw:
+	/* Check if the firmware is downloaded successfully or not */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (ret)
+		nxpwifi_dbg(adapter, ERROR,
+			    "FW failed to be active in time\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nxpwifi_dnld_fw);
-- 
2.34.1


