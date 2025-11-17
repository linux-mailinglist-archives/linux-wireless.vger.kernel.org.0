Return-Path: <linux-wireless+bounces-29033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB0C63B65
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA691365B6F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9166132E13B;
	Mon, 17 Nov 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ghkUWHXh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4232E128;
	Mon, 17 Nov 2025 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377344; cv=fail; b=Pt9YE5hNUIwCROo9rwvJPj0Cin4XsQWIw3eaj9HjFgwPMjXIenQmPNDTPXkyrKlK/uCeIQXwjgyBgAUmmWaVlwO4Wnfxz2ZGHAXF8Y9G1adcEU4L3DDjrj+JMZzgTrNrm0/4d0QU7+wbTu2Dbh0KMFz/btJH9Bt6I0gS9TKVk08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377344; c=relaxed/simple;
	bh=2HFcbU0FsntzqpnpN6t6rrAPGL7b9YpI3IfzK5hEVX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkZvQw1TJcWl/Y5RRJ3Lu0+e4GhOLERhhX3H5JppaNcR1+NphZe5vKiX57ljucxYGBRpRiW6JXHTkmeFrV03PWqfX5+/Z4SRrgEcl0sekgPke7+zj5fhctsqRLtl9bpHnFcFboAO0HPSP7FkmRqqtNlawymEvMKSmUZbRPXViC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ghkUWHXh; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl/hm+fMVfL/l/+/8Jk6zsSYNRUf8wNWmUZpOzuIp2F9AzlOZGPp2aYzOyqq17BwSMZnP9YP/pYjRh+2IRsG5bZCIV/DxFoJ0oz98jNekpnAw5vhkwDidZqLevJtq3ZUI/SGGWuOWRzukrDvhFQIrxMGOABbXtd30HLQJVq0KPgcoQKN1fSgdT0RtmlUUN163efEfBOiQwk2iO5jHdhHFB3tNSdS53VkQ+mL8wr3BrEv09DjlDdp9MooWgSVeYbPXR1cGTo35syQh/yGCL34PQeSBv64h2ijMeqHefFmSzhC/rs4nB28QG1XAslNuwnhKRFMCKpmsMOkwCe+zsmokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP//6Hv1NGOuHsEHampGz7cgh9SbEYx9OUQkuSb3HI4=;
 b=sxQ6qhsh0/MiuSNnT4gkwMKcYmlR/mowgWefUcnkmN4oiyR7ai3K5u7PLE6o11uZEYAvqkX46odn9AY3iXrKtykRXyOh5qSwTN42OmTFCA29h2cey0e2T0khyJ+3IFXEE1oywnfkeOc43omw3SJV+i2q4GDnFsAYUsFlGCksyOkIIRIeNETEVDSqawwcSHNnOOqFF8GY7eIiVqwxvG+vOdB3LLuBifkDMwDvJi2ExDsMHiNIrYxzzkeZtoLIpIs58nMYalEVNtjqIpIPtDGB0vj2aoxqED2yDRPknccsm4zzGSiVmT8kMkMf4HN8JNL8JW+3grusNSb2B0fDcLpBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP//6Hv1NGOuHsEHampGz7cgh9SbEYx9OUQkuSb3HI4=;
 b=ghkUWHXh+pO26wSFZUOM8RDCe0xAZdAUuWFIvgF/jf4DKZWp8NzgFQIrnsOXPW2AlHo0uWVZzwyR8G5n6NyJ+XKC2PUJ0oDkezQeCyRlprFg8Il/tltf3LnBn5DLE9er/Q/55rUnh8hlqrl7kPrVSkOcQrkCKZkhydX8OSgYnESlpctjJvpz4LcaaaeHa3rujmaKfRfBSyHIx2fwFXvRSR3P9jvviimSAaidyQffiO0yuAtMPHSCQ78VcDDcfUxlFaiBPjbgrM88n8xHQAEIv/qLa6OHfRmvazOeyzmgPTMF3hrjbYOXjRX8QdRpvrhYzgvgfzRwBdcuZo84aE215A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS1PR04MB9309.eurprd04.prod.outlook.com (2603:10a6:20b:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:02:14 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:02:14 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 07/22] wifi: nxpwifi: add join and association support
Date: Mon, 17 Nov 2025 19:00:31 +0800
Message-Id: <20251117110046.2810811-8-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ff00a7f-abee-488e-0844-08de25c8c1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JgJhrg2C+Jb0YIm6P3Yz0GNIl6JzV00BucoN0NP2hqyaIcR5LaTbUby6R/6n?=
 =?us-ascii?Q?5IJmx48jtVGXgCNi8Nut1BMTZ8Vbll5koPc+u3sIhlYpPJAfdsEh1gM0IFW1?=
 =?us-ascii?Q?Unq/ZLb+RoD27d0ZFbt5fRLGGhwlGoXtIt493ojyP8T6IrWDpzK6OFZKq2LQ?=
 =?us-ascii?Q?Cq7oYTF+bBOWoKOMNg0uyhKzVDthc19CGKo91knivn7i1oQfVrBeoggP+6O7?=
 =?us-ascii?Q?OzHY+4g8UAoy34nB4O+zU7Lp5vFvMMVdzed3SSDkDet5zFsgqbCYEwfzYKMS?=
 =?us-ascii?Q?cDjanswWVGkVsl3qVaJVhWK/JAv08oKIMa4aGQqg20Hpv5mQRzLuqQjMfJhG?=
 =?us-ascii?Q?fBaUyo+s6I11ErxKlKSnWK17GdNoOoiAt/YUMiIaf4BtsK2iUUA4qxhsRlvn?=
 =?us-ascii?Q?xke7Rp/oHst5i3TquJLWKnPlUzjlicvD2LJg7cCrW9N6wb0Vrbm0kUpgmqCm?=
 =?us-ascii?Q?Hawen23OFsFwfvGYUU3YP3jDnOfmtTyfhdVwZM44OVV9+GpNOQj4kGmanVvx?=
 =?us-ascii?Q?upOAkKUzEo7WU3sJ1pszurLHyzMb94hOrYB5dqLVvd/Nxv7YmLfXW+PK6fgs?=
 =?us-ascii?Q?EiND8M9Qtw5Q16BvntOFlfTJg2nQhfntmzKYj0DcstaskYYdwF7g4UWR+DK2?=
 =?us-ascii?Q?/B7cFdcrFQVA7giQKkAzUrwcliYTuFs71AzTv63TQTka+trSmT2mcuuKDRst?=
 =?us-ascii?Q?INN9S1UObOa6GIKqwTaWcBrXSyGZYDDLK8cIC3a3GX+9lypxF+TmA7VUmemc?=
 =?us-ascii?Q?/QTeu2bog86Fmw4Pq72dpv2Ai+R/c2tWN0PPlZ4PVdLTlEzBfyDRPoOp/FrK?=
 =?us-ascii?Q?vN8U7eUL2TH3cD2a/e2cvGNxQ33UsmRtBAgO/beD9R0Bdso0lOJgOAG6Lqbe?=
 =?us-ascii?Q?aLt4Y2xAtbMyqokT/chjwUm4ijkLivicHi4SEWzH5h1X/n8YIcjDHN6NxwvI?=
 =?us-ascii?Q?i2+Y4NXjfJJQP0epy/25fdisQ2xhGYXSmM6q9Zt1ZoGH3ZGRvEco7jF188/V?=
 =?us-ascii?Q?Svns65wHhOsEcuGOlS94jnVBLxrn1SQAEO/VSfPvIWJI6hju1Bku7GvP+jEm?=
 =?us-ascii?Q?Nem2yi9En1LXV8lpEhZUkdnZHVBeDjXI0br612hp8/sqFiBjcWAwj9m+WI3/?=
 =?us-ascii?Q?l3MvIEtB3EelBl2RggTzmhKdBkfdfxszuqbLEscQBcOLtNdEAjLQ/bUE/8Tm?=
 =?us-ascii?Q?Ryyk05cQ4k7JDh+Hgi56IeNbSLYjb++ft0SlqDmGS6DRIbWzfZuH8nbsgvS1?=
 =?us-ascii?Q?6HKruSFfPRKh0HW8qM20YrsEpTOVvaLh4yFAH39SJgqn4Rov8BkB6ljsqO/a?=
 =?us-ascii?Q?jUyUB1gmuQTOVy1Mpad5U13OfJNT/JcFXH7x3q6LYXDank6jMpklA9OEJwky?=
 =?us-ascii?Q?zSWTPgxHjfu3SVRp5KtbAY0vv+Uc1QXL0v4Thxz57WmnxJpgAx0kcMM/tssW?=
 =?us-ascii?Q?CsSVp0da6fKVAS0yaja7zme/TxacQpC8vIRJ4ndOqZrtXxIJAtPDmpwZE87d?=
 =?us-ascii?Q?OnvUjT+iPbsamRO1tRj/Xxn70DpwyiXSJVV1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?12GbETha+qIyJwTBGkQ5klAv0I0SVxALSzEdEHSMICobIOl5d+NQVQZJajAE?=
 =?us-ascii?Q?7BQDj7S/5UXyEQBE1rssdWVazbTKYmYYpMtRb2O94ZpiTvvyPMXuh9lALVPA?=
 =?us-ascii?Q?lBW6H7aa+12oZhUfUiOvFc9yLxFSEzU5mUFrF2kIGCq4QLn61NEUNQf+hI2B?=
 =?us-ascii?Q?4GEEcxtkX/FceDNwooRSvUlwpX6MKV4NMIr0rJXnkYSPq992t71jRnA/qN0D?=
 =?us-ascii?Q?i5VdF3Nsd2+CTnYIRIZs01ZpRgr4ZPs1fmNTzS/K3+My9iRmaHmek4eG1osz?=
 =?us-ascii?Q?9pAxDDV1NbiEd01RvCk1Ngq90T/hfrhi+62tmF0Fo4zwUz31r+4ftFriJM/Z?=
 =?us-ascii?Q?P+Ylid+rKnGZiSEaKZyni60h3fTHdMCUrl6HGI/0Mb1xZoLrvdOwPsrEmFbp?=
 =?us-ascii?Q?eN4dzxHk8rltaRBkCK/qI9kpzcU2UWth7A8qoCpkc6wVmUUVgXtFg0xFrlpU?=
 =?us-ascii?Q?n5NeMmAq6Kh70JNVDEvLPieEy9LrrrELk9iK2T5L649YR7kkA7imt5AP56Cb?=
 =?us-ascii?Q?6OJIZKGh+bcjjKCRrSY6a9pO8+sYHq6JDRHzVNUp+RtdpjwxKLwwFKjnxHsS?=
 =?us-ascii?Q?MX5XXE8/0H6kj+Nem3GeKtNHVbGopi+YOgpouuu8/z9WXos8zI5gVKGnT37i?=
 =?us-ascii?Q?1+Vc9r4XfUnQjZevqx/bODFZEUJi27wpG1yBorP+eXwX6uuMtvmANTCKaoJy?=
 =?us-ascii?Q?I/2QRe7N4Pq72lfHmDfbc0Yu2/L6a7xbrU2iiy1HVVXED+LWNu5ZNNSUuZGf?=
 =?us-ascii?Q?EEh7B1ToBTNmhpU95cpGTwy9RALBZJ+LUrvxFh+x8mciU6CDYB4v/41bWPQx?=
 =?us-ascii?Q?jxoWMmuMJBSzfKz2ofzDCWfZ3JfzmYWR7Z7QhrZLGoo4xh9FpfyfVyzo+AjO?=
 =?us-ascii?Q?MTherGOu4uGxVX5B709Pdl5fMSOQgHYU9LjkbSFK7oUqQykoXQpK8tHCRHWe?=
 =?us-ascii?Q?2AiJL0TKWnVie86ss2iyXIUcNFTvqjUfjYRy1ztfY7dsj4mwyWSoPScw8CIh?=
 =?us-ascii?Q?Ak2qCNS5ZENgBErSXsXE8mI6W4ac4l+nMN3vXa5mDHQMwJ/q3MGXQ0b/xxDH?=
 =?us-ascii?Q?8qN5tAtfLGDHePrGWQ5YataFr4Wozw10hCFp3y7o9ntxFFPJKgKXy0rgFG7N?=
 =?us-ascii?Q?FR3N0hObllrDIOzwwyWiFk04R1pqV6LvWCx17SOhA24yImU+2cnxWqA8Im1T?=
 =?us-ascii?Q?7kyS2xmxNFd6sHuzt606f0aXFCM4OsXOt5/4OpLwizL540izRcLvzMmvAaR5?=
 =?us-ascii?Q?iOtbKNj1XertpjER6sJok+7osZDkEEU2tQfP8OqqaoNBzJWjTcKO6RXIzwwt?=
 =?us-ascii?Q?3/DA0CKTja/qtmLFIF9PwlZ5ZSAhMYqzNjDI0eSZi1UCuI/O6xCHopakx0Mx?=
 =?us-ascii?Q?rIM7uqDj+KtrzDVsK7mWSksIwaicSytoyph9Xzajut9cSbYHflE1Mk+YEbU4?=
 =?us-ascii?Q?j7bWP7/zwJW+u4jPzxmjyrskP4ED5x79GfD/jta1Wgj9JWUqp577LQpbEksF?=
 =?us-ascii?Q?5azkacRJ9fXN87so17WPbRaPQ2ykzkPIkE74bb4V4Y/dnATfZHaxaM6Gu+yB?=
 =?us-ascii?Q?8ePmtmiuYkatOrnjsCdjGVjkkb8rqdz9W6/JpNcW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff00a7f-abee-488e-0844-08de25c8c1d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:02:11.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7WNiHZjUwB5/ouHrk01XD5J9eRg1Tp2EYzDb2nXefyQ8eKE4tX7ryvF/ZWi93tTf5Iuk9QOVtn8VAjHrElI+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9309

Introduce join.c to implement infrastructure mode association and
deauthentication logic for the nxpwifi driver.

- Implements association command construction, including:
  - SSID, channel, rates, authentication, WPA/WPA2/RSN IEs
  - 802.11n/ac/ax capability TLVs
  - WMM and vendor-specific IEs
  - TSF synchronization and scan result integration
- Handles association response parsing and connection state updates
- Adds support for deauthentication (infra, AP, adhoc)
- Updates current BSS parameters and enables data path upon success

This patch enables full STA-mode association flow with cfg80211
integration.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/join.c | 910 ++++++++++++++++++++++++
 1 file changed, 910 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/join.c b/drivers/net/wireless/nxp/nxpwifi/join.c
new file mode 100644
index 000000000000..ba58df07b84c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/join.c
@@ -0,0 +1,910 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: association and ad-hoc start/join
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
+#include "11ac.h"
+#include "11ax.h"
+
+#define CAPINFO_MASK    (~(BIT(15) | BIT(14) | BIT(12) | BIT(11) | BIT(9)))
+
+/* Append a generic element as a pass through TLV to a TLV buffer.
+ *
+ * This function is called from the network join command preparation routine.
+ *
+ * If the element buffer has been setup by the application, this routine appends
+ * the buffer as a pass through TLV type to the request.
+ */
+static int
+nxpwifi_cmd_append_generic_ie(struct nxpwifi_private *priv, u8 **buffer)
+{
+	int ret_len = 0;
+	struct nxpwifi_ie_types_header ie_header;
+
+	/* Null Checks */
+	if (!buffer)
+		return 0;
+	if (!(*buffer))
+		return 0;
+
+	/* If there is a generic element buffer setup, append it to the return
+	 *   parameter buffer pointer.
+	 */
+	if (priv->gen_ie_buf_len) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: %s: append generic element len %d to %p\n",
+			    __func__, priv->gen_ie_buf_len, *buffer);
+
+		/* Wrap the generic element buffer with a pass through TLV type */
+		ie_header.type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+		ie_header.len = cpu_to_le16(priv->gen_ie_buf_len);
+		memcpy(*buffer, &ie_header, sizeof(ie_header));
+
+		/* Increment the return size and the return buffer pointer
+		 * param
+		 */
+		*buffer += sizeof(ie_header);
+		ret_len += sizeof(ie_header);
+
+		/* Copy the generic element buffer to the output buffer, advance
+		 * pointer
+		 */
+		memcpy(*buffer, priv->gen_ie_buf, priv->gen_ie_buf_len);
+
+		/* Increment the return size and the return buffer pointer
+		 * param
+		 */
+		*buffer += priv->gen_ie_buf_len;
+		ret_len += priv->gen_ie_buf_len;
+
+		/* Reset the generic element buffer */
+		priv->gen_ie_buf_len = 0;
+	}
+
+	/* return the length appended to the buffer */
+	return ret_len;
+}
+
+/* Append TSF tracking info from the scan table for the target AP.
+ *
+ * This function is called from the network join command preparation routine.
+ *
+ * The TSF table TSF sent to the firmware contains two TSF values:
+ *      - The TSF of the target AP from its previous beacon/probe response
+ *      - The TSF timestamp of our local MAC at the time we observed the
+ *        beacon/probe response.
+ *
+ * The firmware uses the timestamp values to set an initial TSF value
+ * in the MAC for the new association after a reassociation attempt.
+ */
+static int
+nxpwifi_cmd_append_tsf_tlv(struct nxpwifi_private *priv, u8 **buffer,
+			   struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_tsf_timestamp tsf_tlv;
+	__le64 tsf_val;
+
+	/* Null Checks */
+	if (!buffer)
+		return 0;
+	if (!*buffer)
+		return 0;
+
+	memset(&tsf_tlv, 0x00, sizeof(struct nxpwifi_ie_types_tsf_timestamp));
+
+	tsf_tlv.header.type = cpu_to_le16(TLV_TYPE_TSFTIMESTAMP);
+	tsf_tlv.header.len = cpu_to_le16(2 * sizeof(tsf_val));
+
+	memcpy(*buffer, &tsf_tlv, sizeof(tsf_tlv.header));
+	*buffer += sizeof(tsf_tlv.header);
+
+	/* TSF at the time when beacon/probe_response was received */
+	tsf_val = cpu_to_le64(bss_desc->fw_tsf);
+	memcpy(*buffer, &tsf_val, sizeof(tsf_val));
+	*buffer += sizeof(tsf_val);
+
+	tsf_val = cpu_to_le64(bss_desc->timestamp);
+
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: %s: TSF offset calc: %016llx - %016llx\n",
+		    __func__, bss_desc->timestamp, bss_desc->fw_tsf);
+
+	memcpy(*buffer, &tsf_val, sizeof(tsf_val));
+	*buffer += sizeof(tsf_val);
+
+	return sizeof(tsf_tlv.header) + (2 * sizeof(tsf_val));
+}
+
+/* This function finds out the common rates between rate1 and rate2.
+ *
+ * It will fill common rates in rate1 as output if found.
+ *
+ * NOTE: Setting the MSB of the basic rates needs to be taken
+ * care of, either before or after calling this function.
+ */
+static int nxpwifi_get_common_rates(struct nxpwifi_private *priv, u8 *rate1,
+				    u32 rate1_size, u8 *rate2, u32 rate2_size)
+{
+	int ret;
+	u8 *ptr = rate1, *tmp;
+	u32 i, j;
+
+	tmp = kmemdup(rate1, rate1_size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	memset(rate1, 0, rate1_size);
+
+	for (i = 0; i < rate2_size && rate2[i]; i++) {
+		for (j = 0; j < rate1_size && tmp[j]; j++) {
+			/* Check common rate, excluding the bit for
+			 * basic rate
+			 */
+			if ((rate2[i] & 0x7F) == (tmp[j] & 0x7F)) {
+				*rate1++ = tmp[j];
+				break;
+			}
+		}
+	}
+
+	nxpwifi_dbg(priv->adapter, INFO, "info: Tx data rate set to %#x\n",
+		    priv->data_rate);
+
+	if (!priv->is_data_rate_auto) {
+		while (*ptr) {
+			if ((*ptr & 0x7f) == priv->data_rate) {
+				ret = 0;
+				goto done;
+			}
+			ptr++;
+		}
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "previously set fixed data rate %#x\t"
+			    "is not compatible with the network\n",
+			    priv->data_rate);
+
+		ret = -EPERM;
+		goto done;
+	}
+
+	ret = 0;
+done:
+	kfree(tmp);
+	return ret;
+}
+
+/* This function creates the intersection of the rates supported by a
+ * target BSS and our adapter settings for use in an assoc/join command.
+ */
+static int
+nxpwifi_setup_rates_from_bssdesc(struct nxpwifi_private *priv,
+				 struct nxpwifi_bssdescriptor *bss_desc,
+				 u8 *out_rates, u32 *out_rates_size)
+{
+	u8 card_rates[NXPWIFI_SUPPORTED_RATES];
+	u32 card_rates_size;
+	int ret;
+
+	/* Copy AP supported rates */
+	memcpy(out_rates, bss_desc->supported_rates, NXPWIFI_SUPPORTED_RATES);
+	/* Get the STA supported rates */
+	card_rates_size = nxpwifi_get_active_data_rates(priv, card_rates);
+	/* Get the common rates between AP and STA supported rates */
+	ret = nxpwifi_get_common_rates(priv, out_rates, NXPWIFI_SUPPORTED_RATES,
+				       card_rates, card_rates_size);
+	if (ret) {
+		*out_rates_size = 0;
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: cannot get common rates\n",
+			    __func__);
+	} else {
+		*out_rates_size =
+			min_t(size_t, strlen(out_rates), NXPWIFI_SUPPORTED_RATES);
+	}
+
+	return ret;
+}
+
+/* This function appends a WPS element. It is called from the network join command
+ * preparation routine.
+ *
+ * If the element buffer has been setup by the application, this routine appends
+ * the buffer as a WPS TLV type to the request.
+ */
+static int
+nxpwifi_cmd_append_wps_ie(struct nxpwifi_private *priv, u8 **buffer)
+{
+	int ret_len = 0;
+	struct nxpwifi_ie_types_header ie_header;
+
+	if (!buffer || !*buffer)
+		return 0;
+
+	/* If there is a wps element buffer setup, append it to the return
+	 * parameter buffer pointer.
+	 */
+	if (priv->wps_ie_len) {
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: append wps element %d to %p\n",
+			    priv->wps_ie_len, *buffer);
+
+		/* Wrap the generic element buffer with a pass through TLV type */
+		ie_header.type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+		ie_header.len = cpu_to_le16(priv->wps_ie_len);
+		memcpy(*buffer, &ie_header, sizeof(ie_header));
+		*buffer += sizeof(ie_header);
+		ret_len += sizeof(ie_header);
+
+		memcpy(*buffer, priv->wps_ie, priv->wps_ie_len);
+		*buffer += priv->wps_ie_len;
+		ret_len += priv->wps_ie_len;
+	}
+
+	kfree(priv->wps_ie);
+	priv->wps_ie_len = 0;
+	return ret_len;
+}
+
+/* This function appends rsn element tlv for wpa/wpa2 security modes.
+ * It is called from the network join command preparation routine.
+ */
+static int nxpwifi_append_rsn_ie_wpa_wpa2(struct nxpwifi_private *priv,
+					  u8 **buffer)
+{
+	struct nxpwifi_ie_types_rsn_param_set *rsn_ie_tlv;
+	int rsn_ie_len;
+
+	if (!buffer || !(*buffer))
+		return 0;
+
+	rsn_ie_tlv = (struct nxpwifi_ie_types_rsn_param_set *)(*buffer);
+	rsn_ie_tlv->header.type = cpu_to_le16((u16)priv->wpa_ie[0]);
+	rsn_ie_tlv->header.type =
+		cpu_to_le16(le16_to_cpu(rsn_ie_tlv->header.type) & 0x00FF);
+	rsn_ie_tlv->header.len = cpu_to_le16((u16)priv->wpa_ie[1]);
+	rsn_ie_tlv->header.len = cpu_to_le16(le16_to_cpu(rsn_ie_tlv->header.len)
+							 & 0x00FF);
+	if (le16_to_cpu(rsn_ie_tlv->header.len) <= (sizeof(priv->wpa_ie) - 2))
+		memcpy(rsn_ie_tlv->rsn_ie, &priv->wpa_ie[2],
+		       le16_to_cpu(rsn_ie_tlv->header.len));
+	else
+		return -ENOMEM;
+
+	rsn_ie_len = sizeof(rsn_ie_tlv->header) +
+					le16_to_cpu(rsn_ie_tlv->header.len);
+	*buffer += rsn_ie_len;
+
+	return rsn_ie_len;
+}
+
+/* This function prepares command for association.
+ *
+ * This sets the following parameters -
+ *      - Peer MAC address
+ *      - Listen interval
+ *      - Beacon interval
+ *      - Capability information
+ *
+ * ...and the following TLVs, as required -
+ *      - SSID TLV
+ *      - PHY TLV
+ *      - SS TLV
+ *      - Rates TLV
+ *      - Authentication TLV
+ *      - Channel TLV
+ *      - WPA/WPA2 element
+ *      - 11n TLV
+ *      - Vendor specific TLV
+ *      - WMM TLV
+ *      - Generic element
+ *      - TSF TLV
+ *
+ * Preparation also includes -
+ *      - Setting command ID and proper size
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *cmd,
+				 struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_802_11_associate *assoc = &cmd->params.associate;
+	struct nxpwifi_ie_types_host_mlme *host_mlme_tlv;
+	struct nxpwifi_ie_types_ssid_param_set *ssid_tlv;
+	struct nxpwifi_ie_types_phy_param_set *phy_tlv;
+	struct nxpwifi_ie_types_ss_param_set *ss_tlv;
+	struct nxpwifi_ie_types_rates_param_set *rates_tlv;
+	struct nxpwifi_ie_types_auth_type *auth_tlv;
+	struct nxpwifi_ie_types_sae_pwe_mode *sae_pwe_tlv;
+	struct nxpwifi_ie_types_chan_list_param_set *chan_tlv;
+	u8 rates[NXPWIFI_SUPPORTED_RATES];
+	u32 rates_size;
+	u16 tmp_cap;
+	u8 *pos;
+	int rsn_ie_len = 0;
+	int ret;
+
+	pos = (u8 *)assoc;
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_ASSOCIATE);
+
+	/* Save so we know which BSS Desc to use in the response handler */
+	priv->attempted_bss_desc = bss_desc;
+
+	memcpy(assoc->peer_sta_addr,
+	       bss_desc->mac_address, sizeof(assoc->peer_sta_addr));
+	pos += sizeof(assoc->peer_sta_addr);
+
+	/* Set the listen interval */
+	assoc->listen_interval = cpu_to_le16(priv->listen_interval);
+	/* Set the beacon period */
+	assoc->beacon_period = cpu_to_le16(bss_desc->beacon_period);
+
+	pos += sizeof(assoc->cap_info_bitmap);
+	pos += sizeof(assoc->listen_interval);
+	pos += sizeof(assoc->beacon_period);
+	pos += sizeof(assoc->dtim_period);
+
+	host_mlme_tlv = (struct nxpwifi_ie_types_host_mlme *)pos;
+	host_mlme_tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+	host_mlme_tlv->header.len = cpu_to_le16(sizeof(host_mlme_tlv->host_mlme));
+	host_mlme_tlv->host_mlme = 1;
+	pos += sizeof(host_mlme_tlv->header) + sizeof(host_mlme_tlv->host_mlme);
+
+	ssid_tlv = (struct nxpwifi_ie_types_ssid_param_set *)pos;
+	ssid_tlv->header.type = cpu_to_le16(WLAN_EID_SSID);
+	ssid_tlv->header.len = cpu_to_le16((u16)bss_desc->ssid.ssid_len);
+	memcpy(ssid_tlv->ssid, bss_desc->ssid.ssid,
+	       le16_to_cpu(ssid_tlv->header.len));
+	pos += sizeof(ssid_tlv->header) + le16_to_cpu(ssid_tlv->header.len);
+
+	phy_tlv = (struct nxpwifi_ie_types_phy_param_set *)pos;
+	phy_tlv->header.type = cpu_to_le16(WLAN_EID_DS_PARAMS);
+	phy_tlv->header.len = cpu_to_le16(sizeof(phy_tlv->fh_ds.ds_param_set));
+	memcpy(&phy_tlv->fh_ds.ds_param_set,
+	       &bss_desc->phy_param_set.ds_param_set.current_chan,
+	       sizeof(phy_tlv->fh_ds.ds_param_set));
+	pos += sizeof(phy_tlv->header) + le16_to_cpu(phy_tlv->header.len);
+
+	ss_tlv = (struct nxpwifi_ie_types_ss_param_set *)pos;
+	ss_tlv->header.type = cpu_to_le16(WLAN_EID_CF_PARAMS);
+	ss_tlv->header.len = cpu_to_le16(sizeof(ss_tlv->cf_ibss.cf_param_set));
+	pos += sizeof(ss_tlv->header) + le16_to_cpu(ss_tlv->header.len);
+
+	/* Get the common rates supported between the driver and the BSS Desc */
+	ret = nxpwifi_setup_rates_from_bssdesc(priv, bss_desc,
+					       rates, &rates_size);
+	if (ret)
+		return ret;
+
+	/* Save the data rates into Current BSS state structure */
+	priv->curr_bss_params.num_of_rates = rates_size;
+	memcpy(&priv->curr_bss_params.data_rates, rates, rates_size);
+
+	/* Setup the Rates TLV in the association command */
+	rates_tlv = (struct nxpwifi_ie_types_rates_param_set *)pos;
+	rates_tlv->header.type = cpu_to_le16(WLAN_EID_SUPP_RATES);
+	rates_tlv->header.len = cpu_to_le16((u16)rates_size);
+	memcpy(rates_tlv->rates, rates, rates_size);
+	pos += sizeof(rates_tlv->header) + rates_size;
+	nxpwifi_dbg(adapter, INFO, "info: ASSOC_CMD: rates size = %d\n",
+		    rates_size);
+
+	/* Add the Authentication type */
+	auth_tlv = (struct nxpwifi_ie_types_auth_type *)pos;
+	auth_tlv->header.type = cpu_to_le16(TLV_TYPE_AUTH_TYPE);
+	auth_tlv->header.len = cpu_to_le16(sizeof(auth_tlv->auth_type));
+	if (priv->sec_info.wep_enabled)
+		auth_tlv->auth_type =
+			cpu_to_le16((u16)priv->sec_info.authentication_mode);
+	else
+		auth_tlv->auth_type = cpu_to_le16(NL80211_AUTHTYPE_OPEN_SYSTEM);
+
+	pos += sizeof(auth_tlv->header) + le16_to_cpu(auth_tlv->header.len);
+
+	if (priv->sec_info.authentication_mode == WLAN_AUTH_SAE) {
+		auth_tlv->auth_type = cpu_to_le16(NXPWIFI_AUTHTYPE_SAE);
+		if (bss_desc->bcn_rsnx_ie &&
+		    bss_desc->bcn_rsnx_ie->datalen &&
+		    (bss_desc->bcn_rsnx_ie->data[0] &
+		     WLAN_RSNX_CAPA_SAE_H2E)) {
+			sae_pwe_tlv =
+				(struct nxpwifi_ie_types_sae_pwe_mode *)pos;
+			sae_pwe_tlv->header.type =
+				cpu_to_le16(TLV_TYPE_SAE_PWE_MODE);
+			sae_pwe_tlv->header.len =
+				cpu_to_le16(sizeof(sae_pwe_tlv->pwe[0]));
+			sae_pwe_tlv->pwe[0] = bss_desc->bcn_rsnx_ie->data[0];
+			pos += sizeof(sae_pwe_tlv->header) +
+				sizeof(sae_pwe_tlv->pwe[0]);
+		}
+	}
+
+	if (IS_SUPPORT_MULTI_BANDS(adapter) &&
+	    !(ISSUPP_11NENABLED(adapter->fw_cap_info) &&
+	    !bss_desc->disable_11n &&
+	    (priv->config_bands & BAND_GN ||
+	     priv->config_bands & BAND_AN) &&
+	    bss_desc->bcn_ht_cap)) {
+		/* Append a channel TLV for the channel the attempted AP was
+		 * found on
+		 */
+		chan_tlv = (struct nxpwifi_ie_types_chan_list_param_set *)pos;
+		chan_tlv->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
+		chan_tlv->header.len =
+			cpu_to_le16(sizeof(struct nxpwifi_chan_scan_param_set));
+
+		memset(chan_tlv->chan_scan_param, 0x00,
+		       sizeof(struct nxpwifi_chan_scan_param_set));
+		chan_tlv->chan_scan_param[0].chan_number =
+			(bss_desc->phy_param_set.ds_param_set.current_chan);
+		nxpwifi_dbg(adapter, INFO, "info: Assoc: TLV Chan = %d\n",
+			    chan_tlv->chan_scan_param[0].chan_number);
+
+		chan_tlv->chan_scan_param[0].band_cfg =
+			nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+
+		nxpwifi_dbg(adapter, INFO, "info: Assoc: TLV Band = %d\n",
+			    chan_tlv->chan_scan_param[0].band_cfg);
+		pos += sizeof(chan_tlv->header) +
+			sizeof(struct nxpwifi_chan_scan_param_set);
+	}
+
+	if (!priv->wps.session_enable) {
+		if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
+			rsn_ie_len = nxpwifi_append_rsn_ie_wpa_wpa2(priv, &pos);
+
+		if (rsn_ie_len == -ENOMEM)
+			return -ENOMEM;
+	}
+
+	if (ISSUPP_11NENABLED(adapter->fw_cap_info) &&
+	    !bss_desc->disable_11n &&
+	    (priv->config_bands & BAND_GN ||
+	     priv->config_bands & BAND_AN))
+		nxpwifi_cmd_append_11n_tlv(priv, bss_desc, &pos);
+
+	if (ISSUPP_11ACENABLED(adapter->fw_cap_info) &&
+	    !bss_desc->disable_11n && !bss_desc->disable_11ac &&
+	    (priv->config_bands & BAND_GAC ||
+	     priv->config_bands & BAND_AAC))
+		nxpwifi_cmd_append_11ac_tlv(priv, bss_desc, &pos);
+
+	if (ISSUPP_11AXENABLED(adapter->fw_cap_ext) &&
+	    nxpwifi_11ax_bandconfig_allowed(priv, bss_desc))
+		nxpwifi_cmd_append_11ax_tlv(priv, bss_desc, &pos);
+
+	/* Append vendor specific element TLV */
+	nxpwifi_cmd_append_vsie_tlv(priv, NXPWIFI_VSIE_MASK_ASSOC, &pos);
+
+	nxpwifi_wmm_process_association_req(priv, &pos, &bss_desc->wmm_ie,
+					    bss_desc->bcn_ht_cap);
+
+	if (priv->wps.session_enable && priv->wps_ie_len)
+		nxpwifi_cmd_append_wps_ie(priv, &pos);
+
+	nxpwifi_cmd_append_generic_ie(priv, &pos);
+
+	nxpwifi_cmd_append_tsf_tlv(priv, &pos, bss_desc);
+
+	nxpwifi_11h_process_join(priv, &pos, bss_desc);
+
+	cmd->size = cpu_to_le16((u16)(pos - (u8 *)assoc) + S_DS_GEN);
+
+	/* Set the Capability info at last */
+	tmp_cap = bss_desc->cap_info_bitmap;
+
+	if (priv->config_bands == BAND_B)
+		tmp_cap &= ~WLAN_CAPABILITY_SHORT_SLOT_TIME;
+
+	tmp_cap &= CAPINFO_MASK;
+	nxpwifi_dbg(adapter, INFO,
+		    "info: ASSOC_CMD: tmp_cap=%4X CAPINFO_MASK=%4lX\n",
+		    tmp_cap, CAPINFO_MASK);
+	assoc->cap_info_bitmap = cpu_to_le16(tmp_cap);
+
+	return ret;
+}
+
+static const char *assoc_failure_reason_to_str(u16 cap_info)
+{
+	switch (cap_info) {
+	case CONNECT_ERR_AUTH_ERR_STA_FAILURE:
+		return "CONNECT_ERR_AUTH_ERR_STA_FAILURE";
+	case CONNECT_ERR_AUTH_MSG_UNHANDLED:
+		return "CONNECT_ERR_AUTH_MSG_UNHANDLED";
+	case CONNECT_ERR_ASSOC_ERR_TIMEOUT:
+		return "CONNECT_ERR_ASSOC_ERR_TIMEOUT";
+	case CONNECT_ERR_ASSOC_ERR_AUTH_REFUSED:
+		return "CONNECT_ERR_ASSOC_ERR_AUTH_REFUSED";
+	case CONNECT_ERR_STA_FAILURE:
+		return "CONNECT_ERR_STA_FAILURE";
+	}
+
+	return "Unknown connect failure";
+}
+
+/* Association firmware command response handler
+ *
+ * The response buffer for the association command has the following
+ * memory layout.
+ *
+ * For cases where an association response was not received (indicated
+ * by the CapInfo and AId field):
+ *
+ *     .------------------------------------------------------------.
+ *     |  Header(4 * sizeof(t_u16)):  Standard command response hdr |
+ *     .------------------------------------------------------------.
+ *     |  cap_info/Error Return(t_u16):                             |
+ *     |           0xFFFF(-1): Internal error                       |
+ *     |           0xFFFE(-2): Authentication unhandled message     |
+ *     |           0xFFFD(-3): Authentication refused               |
+ *     |           0xFFFC(-4): Timeout waiting for AP response      |
+ *     .------------------------------------------------------------.
+ *     |  status_code(t_u16):                                       |
+ *     |        If cap_info is -1:                                  |
+ *     |           An internal firmware failure prevented the       |
+ *     |           command from being processed.  The status_code   |
+ *     |           will be set to 1.                                |
+ *     |                                                            |
+ *     |        If cap_info is -2:                                  |
+ *     |           An authentication frame was received but was     |
+ *     |           not handled by the firmware.  IEEE Status        |
+ *     |           code for the failure is returned.                |
+ *     |                                                            |
+ *     |        If cap_info is -3:                                  |
+ *     |           An authentication frame was received and the     |
+ *     |           status_code is the IEEE Status reported in the   |
+ *     |           response.                                        |
+ *     |                                                            |
+ *     |        If cap_info is -4:                                  |
+ *     |           (1) Association response timeout                 |
+ *     |           (2) Authentication response timeout              |
+ *     .------------------------------------------------------------.
+ *     |  a_id(t_u16): 0xFFFF                                       |
+ *     .------------------------------------------------------------.
+ *
+ *
+ * For cases where an association response was received, the IEEE
+ * standard association response frame is returned:
+ *
+ *     .------------------------------------------------------------.
+ *     |  Header(4 * sizeof(t_u16)):  Standard command response hdr |
+ *     .------------------------------------------------------------.
+ *     |  cap_info(t_u16): IEEE Capability                          |
+ *     .------------------------------------------------------------.
+ *     |  status_code(t_u16): IEEE Status Code                      |
+ *     .------------------------------------------------------------.
+ *     |  a_id(t_u16): IEEE Association ID                          |
+ *     .------------------------------------------------------------.
+ *     |  IEEE IEs(variable): Any received IEs comprising the       |
+ *     |                      remaining portion of a received       |
+ *     |                      association response frame.           |
+ *     .------------------------------------------------------------.
+ *
+ * For simplistic handling, the status_code field can be used to determine
+ * an association success (0) or failure (non-zero).
+ */
+int nxpwifi_ret_802_11_associate(struct nxpwifi_private *priv,
+				 struct host_cmd_ds_command *resp)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret = 0;
+	struct ieee_types_assoc_rsp *assoc_rsp;
+	struct nxpwifi_bssdescriptor *bss_desc;
+	bool enable_data = true;
+	u16 cap_info, status_code, aid;
+	const u8 *ie_ptr;
+	struct ieee80211_ht_operation *assoc_resp_ht_oper;
+	struct ieee80211_mgmt *hdr;
+
+	if (!priv->attempted_bss_desc) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: failed, association terminated by host\n",
+			    __func__);
+		goto done;
+	}
+
+	hdr = (struct ieee80211_mgmt *)&resp->params;
+	if (!memcmp(hdr->bssid, priv->attempted_bss_desc->mac_address,
+		    ETH_ALEN))
+		assoc_rsp = (struct ieee_types_assoc_rsp *)&hdr->u.assoc_resp;
+	else
+		assoc_rsp = (struct ieee_types_assoc_rsp *)&resp->params;
+
+	cap_info = le16_to_cpu(assoc_rsp->cap_info_bitmap);
+	status_code = le16_to_cpu(assoc_rsp->status_code);
+	aid = le16_to_cpu(assoc_rsp->a_id);
+
+	if ((aid & (BIT(15) | BIT(14))) != (BIT(15) | BIT(14)))
+		nxpwifi_dbg(adapter, ERROR,
+			    "invalid AID value 0x%x; bits 15:14 not set\n", aid);
+
+	aid &= ~(BIT(15) | BIT(14));
+
+	priv->assoc_rsp_size = min(le16_to_cpu(resp->size) - S_DS_GEN,
+				   sizeof(priv->assoc_rsp_buf));
+
+	assoc_rsp->a_id = cpu_to_le16(aid);
+	memcpy(priv->assoc_rsp_buf, &resp->params, priv->assoc_rsp_size);
+
+	if (status_code) {
+		adapter->dbg.num_cmd_assoc_failure++;
+		nxpwifi_dbg(adapter, ERROR,
+			    "ASSOC_RESP: failed,\t"
+			    "status code=%d err=%#x a_id=%#x\n",
+			    status_code, cap_info,
+			    le16_to_cpu(assoc_rsp->a_id));
+
+		nxpwifi_dbg(adapter, ERROR, "assoc failure: reason %s\n",
+			    assoc_failure_reason_to_str(cap_info));
+		if (cap_info == CONNECT_ERR_ASSOC_ERR_TIMEOUT) {
+			if (status_code == NXPWIFI_ASSOC_CMD_FAILURE_AUTH) {
+				ret = WLAN_STATUS_AUTH_TIMEOUT;
+				nxpwifi_dbg(adapter, ERROR,
+					    "ASSOC_RESP: AUTH timeout\n");
+			} else {
+				ret = WLAN_STATUS_UNSPECIFIED_FAILURE;
+				nxpwifi_dbg(adapter, ERROR,
+					    "ASSOC_RESP: UNSPECIFIED failure\n");
+			}
+
+			priv->assoc_rsp_size = 0;
+		} else {
+			ret = status_code;
+		}
+
+		goto done;
+	}
+
+	/* Send a Media Connected event, according to the Spec */
+	priv->media_connected = true;
+
+	adapter->ps_state = PS_STATE_AWAKE;
+	adapter->pps_uapsd_mode = false;
+	adapter->tx_lock_flag = false;
+
+	/* Set the attempted BSSID Index to current */
+	bss_desc = priv->attempted_bss_desc;
+
+	nxpwifi_dbg(adapter, INFO, "info: ASSOC_RESP: %s\n",
+		    bss_desc->ssid.ssid);
+
+	/* Make a copy of current BSSID descriptor */
+	memcpy(&priv->curr_bss_params.bss_descriptor,
+	       bss_desc, sizeof(struct nxpwifi_bssdescriptor));
+
+	/* Update curr_bss_params */
+	priv->curr_bss_params.bss_descriptor.channel =
+		bss_desc->phy_param_set.ds_param_set.current_chan;
+
+	priv->curr_bss_params.band = (u8)bss_desc->bss_band;
+
+	if (bss_desc->wmm_ie.element_id == WLAN_EID_VENDOR_SPECIFIC)
+		priv->curr_bss_params.wmm_enabled = true;
+	else
+		priv->curr_bss_params.wmm_enabled = false;
+
+	if ((priv->wmm_required || bss_desc->bcn_ht_cap) &&
+	    priv->curr_bss_params.wmm_enabled)
+		priv->wmm_enabled = true;
+	else
+		priv->wmm_enabled = false;
+
+	priv->curr_bss_params.wmm_uapsd_enabled = false;
+
+	if (priv->wmm_enabled)
+		priv->curr_bss_params.wmm_uapsd_enabled =
+			((bss_desc->wmm_ie.qos_info &
+			  IEEE80211_WMM_IE_AP_QOSINFO_UAPSD) ? 1 : 0);
+
+	/* Store the bandwidth information from assoc response */
+	ie_ptr = cfg80211_find_ie(WLAN_EID_HT_OPERATION, assoc_rsp->ie_buffer,
+				  priv->assoc_rsp_size
+				  - sizeof(struct ieee_types_assoc_rsp));
+	if (ie_ptr) {
+		assoc_resp_ht_oper = (struct ieee80211_ht_operation *)(ie_ptr
+					+ sizeof(struct element));
+		priv->assoc_resp_ht_param = assoc_resp_ht_oper->ht_param;
+		priv->ht_param_present = true;
+	} else {
+		priv->ht_param_present = false;
+	}
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: ASSOC_RESP: curr_pkt_filter is %#x\n",
+		    priv->curr_pkt_filter);
+	if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
+		priv->wpa_is_gtk_set = false;
+
+	if (priv->wmm_enabled) {
+		/* Don't re-enable carrier until we get the WMM_GET_STATUS
+		 * event
+		 */
+		enable_data = false;
+	} else {
+		/* Since WMM is not enabled, setup the queues with the
+		 * defaults
+		 */
+		nxpwifi_wmm_setup_queue_priorities(priv, NULL);
+		nxpwifi_wmm_setup_ac_downgrade(priv);
+	}
+
+	if (enable_data)
+		nxpwifi_dbg(adapter, INFO,
+			    "info: post association, re-enabling data flow\n");
+
+	/* Reset SNR/NF/RSSI values */
+	priv->data_rssi_last = 0;
+	priv->data_nf_last = 0;
+	priv->data_rssi_avg = 0;
+	priv->data_nf_avg = 0;
+	priv->bcn_rssi_last = 0;
+	priv->bcn_nf_last = 0;
+	priv->bcn_rssi_avg = 0;
+	priv->bcn_nf_avg = 0;
+	priv->rxpd_rate = 0;
+	priv->rxpd_htinfo = 0;
+
+	nxpwifi_save_curr_bcn(priv);
+
+	adapter->dbg.num_cmd_assoc_success++;
+
+	nxpwifi_dbg(adapter, MSG, "assoc: associated with %pM\n",
+		    priv->attempted_bss_desc->mac_address);
+
+	/* Add the ra_list here for infra mode as there will be only 1 ra
+	 * always
+	 */
+	nxpwifi_ralist_add(priv,
+			   priv->curr_bss_params.bss_descriptor.mac_address);
+
+	netif_carrier_on(priv->netdev);
+	nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+
+	if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
+		priv->scan_block = true;
+	else
+		priv->port_open = true;
+
+done:
+	/* Need to indicate IOCTL complete */
+	if (adapter->curr_cmd->wait_q_enabled) {
+		if (ret)
+			adapter->cmd_wait_q.status = -1;
+		else
+			adapter->cmd_wait_q.status = 0;
+	}
+
+	return ret;
+}
+
+/* This function associates to a specific BSS discovered in a scan.
+ *
+ * It clears any past association response stored for application
+ * retrieval and calls the command preparation routine to send the
+ * command to firmware.
+ */
+int nxpwifi_associate(struct nxpwifi_private *priv,
+		      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	/* Return error if the adapter is not STA role or table entry
+	 * is not marked as infra.
+	 */
+	if ((GET_BSS_ROLE(priv) != NXPWIFI_BSS_ROLE_STA) ||
+	    bss_desc->bss_mode != NL80211_IFTYPE_STATION)
+		return -EINVAL;
+
+	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info) &&
+	    !bss_desc->disable_11n && !bss_desc->disable_11ac &&
+	    priv->config_bands & BAND_AAC)
+		nxpwifi_set_11ac_ba_params(priv);
+	else
+		nxpwifi_set_ba_params(priv);
+
+	/* Clear any past association response stored for application
+	 * retrieval
+	 */
+	priv->assoc_rsp_size = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_ASSOCIATE,
+				HOST_ACT_GEN_SET, 0, bss_desc, true);
+}
+
+/* This function deauthenticates/disconnects from infra network by sending
+ * deauthentication request.
+ */
+static int nxpwifi_deauthenticate_infra(struct nxpwifi_private *priv, u8 *mac)
+{
+	u8 mac_address[ETH_ALEN];
+	int ret;
+
+	if (!mac || is_zero_ether_addr(mac))
+		memcpy(mac_address,
+		       priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+	else
+		memcpy(mac_address, mac, ETH_ALEN);
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_DEAUTHENTICATE,
+			       HOST_ACT_GEN_SET, 0, mac_address, true);
+
+	return ret;
+}
+
+/* This function deauthenticates/disconnects from a BSS.
+ *
+ * In case of infra made, it sends deauthentication request, and
+ * in case of ad-hoc mode, a stop network request is sent to the firmware.
+ * In AP mode, a command to stop bss is sent to firmware.
+ */
+int nxpwifi_deauthenticate(struct nxpwifi_private *priv, u8 *mac)
+{
+	int ret = 0;
+
+	if (!priv->media_connected)
+		return 0;
+
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+	priv->host_mlme_reg = false;
+	priv->mgmt_frame_mask = 0;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_MGMT_FRAME_REG,
+			       HOST_ACT_GEN_SET, 0,
+			       &priv->mgmt_frame_mask, false);
+	if (ret) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "could not unregister mgmt frame rx\n");
+		return ret;
+	}
+
+	switch (priv->bss_mode) {
+	case NL80211_IFTYPE_STATION:
+		ret = nxpwifi_deauthenticate_infra(priv, mac);
+		if (ret)
+			cfg80211_disconnected(priv->netdev, 0, NULL, 0,
+					      true, GFP_KERNEL);
+		break;
+	case NL80211_IFTYPE_AP:
+		ret = nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+				       HOST_ACT_GEN_SET, 0, NULL, true);
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/* This function deauthenticates/disconnects from all BSS. */
+void nxpwifi_deauthenticate_all(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	int i;
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+		nxpwifi_deauthenticate(priv, NULL);
+	}
+}
+EXPORT_SYMBOL_GPL(nxpwifi_deauthenticate_all);
+
+/* This function converts band to radio type used in channel TLV.
+ */
+u8 nxpwifi_band_to_radio_type(u16 config_bands)
+{
+	if (config_bands & BAND_A || config_bands & BAND_AN ||
+	    config_bands & BAND_AAC || config_bands & BAND_AAX)
+		return HOST_SCAN_RADIO_TYPE_A;
+
+	return HOST_SCAN_RADIO_TYPE_BG;
+}
-- 
2.34.1


