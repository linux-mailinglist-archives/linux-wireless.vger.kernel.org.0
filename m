Return-Path: <linux-wireless+bounces-35516-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGQRCo8N8Wn1cAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35516-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:42:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFCB48B3F7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E98430662BD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667B38D6A9;
	Tue, 28 Apr 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eBRsoKQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E939383C88;
	Tue, 28 Apr 2026 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405297; cv=fail; b=XUrCRhh4xqV5cZwU9x30MPp263dwhagY+gQm9Skv/LBoEZ5zBGcDW1oVsBgOk0AHyZLB5x3PgM7KryWx0TzSR3rvj06UEzG80mD3CjJkP1J8McpJopAfNgt7clNNHpi2iWAopLwcgnFPLDx0UKmyZ/2aOHX6bfL0OGjhYohvgsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405297; c=relaxed/simple;
	bh=6ooA/Jd0hZ2M690fe3iUH3BPL9FuRPNq+3/spwnWmLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzC09PR25Js4lYd1QCUQnVsWAer/nYtThAg2437zzko8B29yckW3p5KhXP2p+YR2VKjBoS4aBBQOFiu6YVfOseyrjsNPpH0ljdHgrSL6Edgtl2TLXqfmpZ/OO0I5fk8Cl9KgTVHmUqtjkq5TSJuTezLdJbWYRHtG7SR0/17AQR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eBRsoKQu; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqKN8YxT+Z+OQ9d+sDkGg4rpPquiHtgU56bvIHR3UqrB+embxTuu/geu0rNMBH8/O/88aRTCUWfhXGgRovEnD2nUiAVxtDM28D4KnTiF5NiNm05QmpZ3qXCFCMz3lxfp+xbV270EVELs92qZCUw7Z+ppgjiVvOOIRSa0daN+Y17mTYVRRt0b6KhtqN6OwKOBTSiqaGgAMH387SOEkQivc4OeFEtubSZwjb06+vjAvCVMR80D/WxfsHtiHVLdw6y+PmDld3DjSMRKKE3FOgh+VKzNE9uL+Z4MYKeFIYB+UBP8nOPyQ1Cn0LNy+rWGUbB6ni7tX3CrA0ZeEP5c4ACpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MvYR4wpJpDTeZR9rFdvYyKRpJeqrlf0p6o+rhg6ROM=;
 b=lNeseXMBZlkERd4tzQC31CxhOh9pg8FYvWMV9d51xTERgc2njrrWiSRnYBKR4REZ8an5zjvGsiXIZL++M7pBsc4EH+w7hFK/HOdfmqRHS2ULbUxwBjDhnCH8DURfDwKUe3cV/ml3nsy5TAaOhH5E8aczluMvqLSTYSxT/xYqVVUW94QGaFXQXO+ZaDcqa7+A5AnbzJyIwLw1HI2/wi4YZSLW+z73VqfLna27RLhfBOorb5RBLVBN6NrZoQGtMEgcVuZRPs2MYukMD/hEMi02f4SVuBBMDa5mV6JRT3QxQKUCYBC5muaE6ssDYkF+tY9sRnWhlJJIn0sFww+Op5SArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MvYR4wpJpDTeZR9rFdvYyKRpJeqrlf0p6o+rhg6ROM=;
 b=eBRsoKQuxJ3DY9+1ZRUrcncfkeOxjrIqpgTUdksrp/tfSt3oXxfkbbxRgXjJUR7vYyNEj2jqS/qJOwSNnfnOvXSeeso0+rRKORMkh+lpVCJIzbkrf+OU6/rXHsAzdI7gHkAf+myL9xDcw6qgVVQ529/KQVY04Gijh+as3jMhzVnFUapNf3kfBplI8fsAiwP6O/7I+M50jSyk6uB78eu9UQ4joEkxTpxtgtBxyvfOcVDIntsk/aNb8kAlbr+Bg0yLS+pbAXPxY19D5+0rHDo4LFxN029/MGywmuCQi6b1yxsGbl4wg4shMdpZknkS1f7WovT6Gu3aMMjHXnvTV23wOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS5PR04MB11371.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 19:41:29 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:41:29 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 03/22] wifi: nxpwifi: add initial 802.11ac support for STA and AP modes
Date: Wed, 29 Apr 2026 03:40:02 +0800
Message-Id: <20260428194021.785252-4-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428194021.785252-1-jeff.chen_1@nxp.com>
References: <20260428194021.785252-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::33) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS5PR04MB11371:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2af235-5c8a-40c6-1acf-08dea55e2471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	fn9hHB8CHL5gqnvwUCxYJSXN+a1EHeAqWTt62tBB5rWB9Cj5DOdoXsM9PqeBPjyFUNNip5hEfuuniua1YOal2isCbB3LWo90YO92cfrnhtP6Az8pMMKcI9Fbeb6A7E66RGdYTwFfBQYhpC1ve6hx3/jKJnZgbDo8OaFeTZBRwxvxlHz2zaEkCsXAgOa0eQExBhCmFtLQ0uM+mFtdSB7sSGQ5P+86JfBJJjBUBnn68kO1X7OQezMjmjrHcvPOnTVmVly3nfcPR3XcNEgbDbS2Xa6edk9PrPdFdjMmG3nXKeg06qpqFpocTG8aPdWGE8gzqD8lUilPj/m4mPzrQH6jwlQcsdHQKjlhjTGnwOlXEuLNAObZgiv8hgE49DVZZOAvYUZPez17zD66F5+rduxarEJFUfsEbLd/3QEnWBEj35Du0GTrv+lb7fhjfMavSdwa+oS3GrpEk9+gi49VR3akj/eWFbT5/GwNxrFr94LMQl9BAaAPD9Kka+/5KPR9+Y8LJIWcW23rI25qtxNIjmSHGNpOAwWVAVDfY88nX3rOvcaZ2p4d2lcZg/XFtqblExVvCK76XFlY10h9C13io+AQQIJw5qB9HCNnRIXhHIfapLn12bkYd/FgBScB9Cx9vuaKTE/Az+2iYgDiHK2R1zY7/GjkfEkzh+SsbboRkEirJxh5CNNJjW1V1cD7AeL1Ek8fOwmWhtN+DmJ2XL2Xe3dp//myiajQVzlKIRkGXzp7Z3vbO4cJzDWbhB97j0TI09fjB6O89OVb1FPTraORS19aJa9Vr6OgJQkZXH6Zh+kO1Oc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XWNAeTXftrOw5a9EJ+XzlI4U5fijMmFZPxD7H86VHzYrtLFdfMRU9D999EVP?=
 =?us-ascii?Q?hBhXK3bYFNWxsl4vg0lXIryas5xQLTTGLgCb9AnTpaoVyscJexn+X7ItmGaL?=
 =?us-ascii?Q?irjEUanOL5261TUcGCROwmucQEcXt1TVgJYB+Tibe8kYwnX24vHq/0uzf9zG?=
 =?us-ascii?Q?o5uFbbnrPU9NyhA0XNJ0h/sLEY6QkFufpxp7oowp7sTohF6bIv5xUoUR+AKv?=
 =?us-ascii?Q?RcBf9CD49YPeMSjO5KCTctCQd+d/eHjcBuEfZP9iqeKkv1iifoy1TPoNPexH?=
 =?us-ascii?Q?4ZHb5uuMrNU6O4pDp2bFh4vQTW7R4aH/btQYoNHimNC9NnFq63zOPP/zlI3G?=
 =?us-ascii?Q?5nnfosiVG+uSQa1Ef/hFPONfj1UI4K3DAoI5n06vFT+vI1uHHXZaszQPmc21?=
 =?us-ascii?Q?fchD2nzrg18slOdUJ2lclI1/M7/+HUtNFmDdL8yB4sqZuHXeC0SdRRusoRWQ?=
 =?us-ascii?Q?z/6ta8frjGnCQ9is03VGYGL/NXwLDiBkoYx+mD+K1GgFbO7tmCjW5qBbWA3b?=
 =?us-ascii?Q?W1M6Dz6PDJRTPW9R2lLtma6/6CAZigqXFcVqHTJK/m2TcPDAkXDEqaMiJZ46?=
 =?us-ascii?Q?s5tp6Alb/JU3VdwXoCTpU2LZGB4LFhSMbjrURMHw7Snwq5TPrJ9L6KkPxyfi?=
 =?us-ascii?Q?kXoAw8SOuSopwHfFF4H6F7dCKSYexuKTZnN8ygnomcBO5xASQbT+gGFIz1IS?=
 =?us-ascii?Q?9GnlWewvpjuK8A1ZZu6ZgK6uO5gT5rYFbKPINwDEWoNS2ARC+VzlhPcJcQBH?=
 =?us-ascii?Q?fWHAAaiduz4NN/Nlcmnf7km/vRA5wOTd/Dt2WTV0N+mGP0MyWlFjzoX85FBO?=
 =?us-ascii?Q?8UmmakaujGYuTYGZQp911+/j0j9WbtAEPT6YAUeZztFe8+7yix2iH4APYbqi?=
 =?us-ascii?Q?Jul3kqQhwu3icUQ7L7aBmWj80aD9Tkj8CSSBp86EptL8tEFhm21zSZAhPVtS?=
 =?us-ascii?Q?CoFkDHcbzvGZpIYVPw5pn6Hwz2HuoQyHUi6aX0sxUBVXCZlQIV7zZa8utFmJ?=
 =?us-ascii?Q?ArI3MGphFo/irE80O7F6ovpoATG5I7lEbeWff3I2/TN+RkdqatN1sNHQL5iu?=
 =?us-ascii?Q?gwwkpKNPtZBDlV6/ag4XkS3LF4mjRCRZzcLfrodENb99HjsmlOT60nIn7TwR?=
 =?us-ascii?Q?YizbAG18LsOe6AM5Lf7PKRcgBExaRYd3789yXJMuC5/yvAp3LBLykaXTaxsH?=
 =?us-ascii?Q?jEYRNwlolglwsCGkw/kMpK1NrLMh99oIueDciV/HsfuUYTxoL2NK5AEbf/pg?=
 =?us-ascii?Q?8fNBxQuvgBeYil5LFTnnYo8tqwVLWt/J9VI2SqzShGS5mIkW1RUANvu9W6zr?=
 =?us-ascii?Q?nPcRhFwtQ4/s38SggoMrllggefJEYS03DKfWs2JJyeVy77Dn72yHNwnMiMpe?=
 =?us-ascii?Q?gPCZ9Js+gSBrmAJlQ3ZhVT8ruHnQkkRW6rDJSJCcXite+f/dX5+NHVB9Q3SS?=
 =?us-ascii?Q?srvCMFb4ktDfaeNn+NPZwL03agAv30irakMlwJfTAOzTPr4JgZTuMh8b6/Sy?=
 =?us-ascii?Q?tjLU2wwuV0oKmB0CDI3eD3EEAAFqMX3Sbl8lNcw6gCrBX+cNoLK0gGPftM+q?=
 =?us-ascii?Q?dLW1j15iaa3dNK1faDoNAPzXNH16uqtjnTK716swF1OqcPZrUDvlu8gIenF1?=
 =?us-ascii?Q?Xz40anP9iCBa/+toD+ZKCiTyMYJLfiqEIndr5WDw36FDEdwXkFI+FyzjVA7v?=
 =?us-ascii?Q?BWjq3LwciFtflYV+uyE1QRwn3KaU5BfmZ5RypCfO9FfOtW9FWW2wWjecIpKW?=
 =?us-ascii?Q?C/iuT/5tfA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2af235-5c8a-40c6-1acf-08dea55e2471
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:41:29.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8WN6AXFF/z6+v1FqCLT+WD+JnKPW8Mfzk8y3YFsYWlRtmjSB7iHBu3XCnuC1KN4Qix7z6FuPPWd8bA5iakwqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11371
X-Rspamd-Queue-Id: AAFCB48B3F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35516-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add initial 802.11ac support for both station and AP roles, enabling
VHT capability negotiation and configuration through firmware assisted
commands.

For station mode, convert VHT elements from cfg80211 into firmware TLVs
and append them to HOST_CMD_802_11_ASSOCIATE. For AP mode, convert
VHT elements into parameters for HOST_CMD_11AC_CFG and pass them to the
firmware for configuration.

Handle VHT capabilities, VHT operation, and operating mode notification
elements to allow proper setup of 802.11ac features.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 280 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  33 +++
 2 files changed, 313 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..117d06c35401
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nxpwifi 802.11ac helpers
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ac.h"
+
+/* Map VHT MCS/NSS to highest data rate (Mbps), long GI. */
+static const u16 max_rate_lgi_80MHZ[8][3] = {
+	{0x124, 0x15F, 0x186},	/* NSS = 1 */
+	{0x249, 0x2BE, 0x30C},  /* NSS = 2 */
+	{0x36D, 0x41D, 0x492},  /* NSS = 3 */
+	{0x492, 0x57C, 0x618},  /* NSS = 4 */
+	{0x5B6, 0x6DB, 0x79E},  /* NSS = 5 */
+	{0x6DB, 0x83A, 0x0},    /* NSS = 6 */
+	{0x7FF, 0x999, 0xAAA},  /* NSS = 7 */
+	{0x924, 0xAF8, 0xC30}   /* NSS = 8 */
+};
+
+static const u16 max_rate_lgi_160MHZ[8][3] = {
+	{0x249, 0x2BE, 0x30C},   /* NSS = 1 */
+	{0x492, 0x57C, 0x618},   /* NSS = 2 */
+	{0x6DB, 0x83A, 0x0},     /* NSS = 3 */
+	{0x924, 0xAF8, 0xC30},   /* NSS = 4 */
+	{0xB6D, 0xDB6, 0xF3C},   /* NSS = 5 */
+	{0xDB6, 0x1074, 0x1248}, /* NSS = 6 */
+	{0xFFF, 0x1332, 0x1554}, /* NSS = 7 */
+	{0x1248, 0x15F0, 0x1860} /* NSS = 8 */
+};
+
+/* Convert 2-bit MCS map to highest long-GI VHT data rate. */
+static u16
+nxpwifi_convert_mcsmap_to_maxrate(struct nxpwifi_private *priv,
+				  u16 bands, u16 mcs_map)
+{
+	u8 i, nss, mcs;
+	u16 max_rate = 0;
+	u32 usr_vht_cap_info = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_AAC)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* Find max supported NSS. */
+	nss = 1;
+	for (i = 1; i <= 8; i++) {
+		mcs = GET_VHTNSSMCS(mcs_map, i);
+		if (mcs < IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			nss = i;
+	}
+	mcs = GET_VHTNSSMCS(mcs_map, nss);
+
+	/* If not supported, fall back to 0-9. */
+	if (mcs == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		mcs = IEEE80211_VHT_MCS_SUPPORT_0_9;
+
+	if (u32_get_bits(usr_vht_cap_info, IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK)) {
+		/* Support 160 MHz. */
+		max_rate = max_rate_lgi_160MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 not supported in NSS6. */
+			max_rate = max_rate_lgi_160MHZ[nss - 1][mcs - 1];
+	} else {
+		max_rate = max_rate_lgi_80MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 not supported in NSS3. */
+			max_rate = max_rate_lgi_80MHZ[nss - 1][mcs - 1];
+	}
+
+	return max_rate;
+}
+
+static void
+nxpwifi_fill_vht_cap_info(struct nxpwifi_private *priv,
+			  struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (bands & BAND_A)
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_a);
+	else
+		vht_cap->vht_cap_info =
+			cpu_to_le32(adapter->usr_dot_11ac_dev_cap_bg);
+}
+
+void
+nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			 struct ieee80211_vht_cap *vht_cap, u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u16 mcs_map_user, mcs_map_resp, mcs_map_result;
+	u16 mcs_user, mcs_resp, nss, tmp;
+
+	/* Fill VHT capability info. */
+	nxpwifi_fill_vht_cap_info(priv, vht_cap, bands);
+
+	/* RX MCS set: min(user, AP). */
+	mcs_map_user = GET_DEVRXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.rx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.rx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.rx_highest = cpu_to_le16(tmp);
+
+	/* TX MCS set: min(user, AP). */
+	mcs_map_user = GET_DEVTXMCSMAP(adapter->usr_dot_11ac_mcs_support);
+	mcs_map_resp = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
+	mcs_map_result = 0;
+
+	for (nss = 1; nss <= 8; nss++) {
+		mcs_user = GET_VHTNSSMCS(mcs_map_user, nss);
+		mcs_resp = GET_VHTNSSMCS(mcs_map_resp, nss);
+		if (mcs_user == IEEE80211_VHT_MCS_NOT_SUPPORTED ||
+		    mcs_resp == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      IEEE80211_VHT_MCS_NOT_SUPPORTED);
+		else
+			SET_VHTNSSMCS(mcs_map_result, nss,
+				      min(mcs_user, mcs_resp));
+	}
+
+	vht_cap->supp_mcs.tx_mcs_map = cpu_to_le16(mcs_map_result);
+
+	tmp = nxpwifi_convert_mcsmap_to_maxrate(priv, bands, mcs_map_result);
+	vht_cap->supp_mcs.tx_highest = cpu_to_le16(tmp);
+}
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_vhtcap *vht_cap;
+	struct nxpwifi_ie_types_oper_mode_ntf *oper_ntf;
+	struct ieee_types_oper_mode_ntf *ieee_oper_ntf;
+	struct nxpwifi_ie_types_vht_oper *vht_op;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 supp_chwd_set;
+	u32 usr_vht_cap_info;
+	int ret_len = 0;
+
+	if (bss_desc->bss_band & BAND_A)
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_a;
+	else
+		usr_vht_cap_info = adapter->usr_dot_11ac_dev_cap_bg;
+
+	/* VHT Capabilities element. */
+	if (bss_desc->bcn_vht_cap) {
+		vht_cap = (struct nxpwifi_ie_types_vhtcap *)*buffer;
+		memset(vht_cap, 0, sizeof(*vht_cap));
+		vht_cap->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		vht_cap->header.len  =
+			cpu_to_le16(sizeof(struct ieee80211_vht_cap));
+		memcpy((u8 *)vht_cap + sizeof(struct nxpwifi_ie_types_header),
+		       (u8 *)bss_desc->bcn_vht_cap,
+		       le16_to_cpu(vht_cap->header.len));
+
+		nxpwifi_fill_vht_cap_tlv(priv, &vht_cap->vht_cap,
+					 bss_desc->bss_band);
+		*buffer += sizeof(*vht_cap);
+		ret_len += sizeof(*vht_cap);
+	}
+
+	/* VHT Operation element. */
+	if (bss_desc->bcn_vht_oper) {
+		if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+			vht_op = (struct nxpwifi_ie_types_vht_oper *)*buffer;
+			memset(vht_op, 0, sizeof(*vht_op));
+			vht_op->header.type =
+				cpu_to_le16(WLAN_EID_VHT_OPERATION);
+			vht_op->header.len  = cpu_to_le16(sizeof(*vht_op) -
+				sizeof(struct nxpwifi_ie_types_header));
+			memcpy((u8 *)vht_op +
+				sizeof(struct nxpwifi_ie_types_header),
+			       (u8 *)bss_desc->bcn_vht_oper,
+			       le16_to_cpu(vht_op->header.len));
+
+			/* Negotiate channel width; keep peer's center freq. */
+			supp_chwd_set = u32_get_bits(usr_vht_cap_info,
+						     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK);
+
+			switch (supp_chwd_set) {
+			case 0:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 1:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_160MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			case 2:
+				vht_op->chan_width =
+				     min_t(u8, IEEE80211_VHT_CHANWIDTH_80P80MHZ,
+					   bss_desc->bcn_vht_oper->chan_width);
+				break;
+			default:
+				vht_op->chan_width =
+				     IEEE80211_VHT_CHANWIDTH_USE_HT;
+				break;
+			}
+
+			*buffer += sizeof(*vht_op);
+			ret_len += sizeof(*vht_op);
+		}
+	}
+
+	/* Operating Mode Notification element. */
+	if (bss_desc->oper_mode) {
+		ieee_oper_ntf = bss_desc->oper_mode;
+		oper_ntf = (void *)*buffer;
+		memset(oper_ntf, 0, sizeof(*oper_ntf));
+		oper_ntf->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		oper_ntf->header.len = cpu_to_le16(sizeof(u8));
+		oper_ntf->oper_mode = ieee_oper_ntf->oper_mode;
+		*buffer += sizeof(*oper_ntf);
+		ret_len += sizeof(*oper_ntf);
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg)
+{
+	struct host_cmd_11ac_vht_cfg *vhtcfg = &cmd->params.vht_cfg;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AC_CFG);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_11ac_vht_cfg) +
+				S_DS_GEN);
+	vhtcfg->action = cpu_to_le16(cmd_action);
+	vhtcfg->band_config = cfg->band_config;
+	vhtcfg->misc_config = cfg->misc_config;
+	vhtcfg->cap_info = cpu_to_le32(cfg->cap_info);
+	vhtcfg->mcs_tx_set = cpu_to_le32(cfg->mcs_tx_set);
+	vhtcfg->mcs_rx_set = cpu_to_le32(cfg->mcs_rx_set);
+
+	return 0;
+}
+
+/* Initialize BlockAck parameters for 11ac. */
+void nxpwifi_set_11ac_ba_params(struct nxpwifi_private *priv)
+{
+	priv->add_ba_param.timeout = NXPWIFI_DEFAULT_BLOCK_ACK_TIMEOUT;
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_UAP_AMPDU_DEF_RXWINSIZE;
+	} else {
+		priv->add_ba_param.tx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_TXWINSIZE;
+		priv->add_ba_param.rx_win_size =
+			NXPWIFI_11AC_STA_AMPDU_DEF_RXWINSIZE;
+	}
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.h b/drivers/net/wireless/nxp/nxpwifi/11ac.h
new file mode 100644
index 000000000000..edc01b35d5b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: 802.11ac (VHT) definitions
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AC_H_
+#define _NXPWIFI_11AC_H_
+
+#define VHT_CFG_2GHZ BIT(0)
+#define VHT_CFG_5GHZ BIT(1)
+
+enum vht_cfg_misc_config {
+	VHT_CAP_TX_OPERATION = 1,
+	VHT_CAP_ASSOCIATION,
+	VHT_CAP_UAP_ONLY
+};
+
+#define DEFAULT_VHT_MCS_SET 0xfffe
+#define DISABLE_VHT_MCS_SET 0xffff
+
+#define VHT_BW_80_160_80P80 BIT(2)
+
+int nxpwifi_cmd_append_11ac_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+int nxpwifi_cmd_11ac_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ac_vht_cfg *cfg);
+void nxpwifi_fill_vht_cap_tlv(struct nxpwifi_private *priv,
+			      struct ieee80211_vht_cap *vht_cap, u16 bands);
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


