Return-Path: <linux-wireless+bounces-29516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24118CA64B0
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 08:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53DEE321225D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029DB2F5A01;
	Fri,  5 Dec 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E3WLdllU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8582C0262;
	Fri,  5 Dec 2025 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917861; cv=fail; b=drDNFIK7ZEOkNxd4/zDKpvTqNZzMHbOtzKpEwSCCUkfnqSoOG0Gt0E9jPEYAfugZCFd24g4T8OAcIgVq9ehiq7cnz53Gt1DQq7of5fKzktUgPEa44t6kxr8IXOxda1qbh3AL0ONzbtTtj4CwVai/xRnQ6lEcY9WSfvqiv11NAfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917861; c=relaxed/simple;
	bh=kYkzyO1EoafeYonlCe/cyYNvOh/sWJ+QfD7ZAw6tOoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+cy18BlIBAd34P8jCaFcLpTNeXPjbC8a96Cy4HDU3EAAxnffAJ522v9Cg4IhVcr/m9UCP1uRjXu1ztnIobDNT9KqUEueSqH0tgI3qshc7mtBGUcw74wR1AZynUXmkHj16vjWnelfBAZmpj0dDt4u7veoDulCPowwwkugB4Lmss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E3WLdllU; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0bIpCuEh88PG2dUrKJ6R2g12BNyQrjxTLKXDOMAfCtdEx1PM9Vx+H5PbzB8MKyMX0oqsRJ2yEKp0e+o11mVf4RdURC/TBG38UgrjKD8MQRXO8CMF76EJT7mYWfZl4IwnzIBdixh7KN7EYRT6eSy92mbT0Zaz6zII7b82YwMLfZqjxVKs0kbeQkOJxqczzbHdXwAIyzrKFImntKc75jD7rnJhkiR8gaG+aovxduSHgGTqe6NyyOdMPMHSj90IdlSaxe6i5gYB8oVlLsp5+Ezy+8Joe0jQl25WtaaP1daMnb9WN/T9bZN13g73Quv7j15EyDJ5QumEFulbqfN+SbMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eZXTVlqantPYJ8UzPX4fajdWePg1ZF3egyATKzu1rQ=;
 b=qG9ag8IfoV+sE5k/SVd8NEMyVeC/jUVkgspHzcLQ+L+VhJuXNDyH2MfbV9M9yi+hgTYrUsVV227Z0R9E8HZokv76qQ364zjv9lKHStpTDdGn5xUW0myGwHZnglX4v3VWvLuenkT0bM6ZJH+GvZMSNxvQliUKYPytOV7uDvXoZvkzzOGAgkDc1nTquSxdPJKPOjJ4dbKsVp1bCSMuMihWqleM/8dQEOt6UwcmlVz0lf0BAhShvR08aW0IOjL44jYkn8jSCd2VdYvnMKbwXvN5Spt/o7xSw8w9PckzgEbZQG5758OTxi0OErEc/wKAhZd40iG4b+XdPC/dTYxZk4ZrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eZXTVlqantPYJ8UzPX4fajdWePg1ZF3egyATKzu1rQ=;
 b=E3WLdllUScy10Bq2ggEWayaPVrov0BU3CtSEVX3AxR7jOaWcVR4JAHRTBXiM5SiVxuvUVUPzTdtAMbJD3VQ+u4kG1S0DnjeI3hLopR633KcOwhT7Zhv9CX6cxGzOK5BSfgWDDgWBAmVkmzbSP1wx4O18gvczaL6IB7H0oFH3rtebBXShUIukjxaaLlQmjMQBCT58Zex9RM0gkWYQ1Mfi/Ury/czgqLd+t7TdwhUsEgWVvRv3xAJaO7ekL1zDqTkMEaE0UcepQB4BKQLltQaSEMRKVuhVyAIDl/GXsoTvOuWFLAclydFLg4kGGdYY3MTvjmif8D8bMB4VBKcSgVwxWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PA4PR04MB9245.eurprd04.prod.outlook.com (2603:10a6:102:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 06:57:26 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 06:57:26 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v8 08/22] wifi: nxpwifi: add channel/frequency/power (cfp) support
Date: Fri,  5 Dec 2025 14:55:31 +0800
Message-Id: <20251205065545.3325032-9-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PA4PR04MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fac1d2-2c46-43e2-b5b2-08de33cb8c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mkW3412Nq2FpiuGJPNAI+oCr/H9DE6nd8s5MGfs4HDnRa8CcxnFRasyXwIof?=
 =?us-ascii?Q?T3I61cw6e8/XVCeuvAI+jgDMACe9Qnfy2q2GJiiagi0RsFMIhvQDCdcNNsed?=
 =?us-ascii?Q?xn1IHVEhumCypsvh7o29pLDb0s4RzMOxbFQrPDg8PRqyfUf1VYi0ku7X9bQh?=
 =?us-ascii?Q?PgAASCpzv6k8YnrbwqsdohfX5wo0/eE2BDqRtaDgeVLVEYlpHG3VhbeI9Wwc?=
 =?us-ascii?Q?7SCKgFVODcXysRNLdrIOIWd5RPv/wEV5+wyV26wPBdToqP4ybnPfzAkLULnE?=
 =?us-ascii?Q?1Hy6yh+6MWgarw6+FHeYFcqfo+AmLYHoVLYn4KW6ddMdYEz+CmsiOFXV6dz9?=
 =?us-ascii?Q?GXR4vz/k4GIlByoxvgiDV0GTfxnc0lj8x3FJxmizGILjlI8O+6k+9FLdr19a?=
 =?us-ascii?Q?jfUpquqC/SRDhs6QEkrb8257ATetVmVU2vTGhQXmCcxqjPvXi6Y5939zEp/O?=
 =?us-ascii?Q?qhvGwOSDo6WwkH6Oan1bhmrSkMfHgI2ZtpT0BsOHnQX1c36GBZOj2CCEc8bn?=
 =?us-ascii?Q?RUnEXIE3f8r743Yr3HVhZ4+FsRSUim6K6TQPbg6v77zoz5lZk3zE0fan4sQW?=
 =?us-ascii?Q?MqHxZz7LTOCAscctFJhnKl5K3F24Fk5RSuAkC1ISo2KinQLIToaDX0yZFubK?=
 =?us-ascii?Q?1HCrMO5RPxGJZ3N8jIoVFP/2C5CHz/9Kmk3kq/6U+zFecUk7U2z2XIPmBchR?=
 =?us-ascii?Q?vkxwGzB919XxSu9qAUyiet1YIisPnMD02kKNws4g2vCs/vlPVx/5OsVbE3ep?=
 =?us-ascii?Q?pDUgmIjqRxAxX7H+zoGDJJJvSanWxFIIL6i6U1byJKhyVNFx0SmCP0sxXSe2?=
 =?us-ascii?Q?WznE8S095IXTjASLIrtf3nao2Au8erm1lciKyaCGsFUtZrw9i4areTa3tDdg?=
 =?us-ascii?Q?G09697UKeWX45wdtDlkjHiS4nowKiLYRIcSO9nowZZ4KxMQhLp016dBlG8Ef?=
 =?us-ascii?Q?N+PXxJI79KgbGNFSHcMSXQ8ai1OTbV1pJe7qnLfcWUSiADOvy/QSStMUcEMk?=
 =?us-ascii?Q?//7k9c9ZmuDGER5Pt210jwKEguyB/k4EcYHGa4pK1ssE2GrwjFkMssIoPodo?=
 =?us-ascii?Q?4+mBjMzD5fXSmGNXNZ2tTgzkGAMOAA8r4P8kUFie9mpc9e7nlWN4Gt+Ov0wT?=
 =?us-ascii?Q?8rBnajto8QYFUscv8me7P38IPi77cbJO3DRSlDqCXvY8HI9XHSHYXpgvapOS?=
 =?us-ascii?Q?qfsEovrDeQ40P6Mr7LiAxUYGCSo6sX2xSEU8VnYAjLxjN3kVO2S0VzcJu3/q?=
 =?us-ascii?Q?bPjVPDOkhCofc+meOUreWrOx5KOqyQKQFDbr8YEptADFf2Aby42XJwrkNphh?=
 =?us-ascii?Q?vIwDgcVKKNjw6RBKd6HeX8fhl9LK577jer/xp6s/OXgruN5/yBIshpsmSv5M?=
 =?us-ascii?Q?LDz2SW/kpVyNEbVs36igeF2oTEYjnZCxVCGBcw/cAUKQpREExzScn+dDPg3c?=
 =?us-ascii?Q?xa+GB7TbSdG/ggNHtEMwUjh8FHGBLAnmCPCeEnnVUcg1SAdG9uK5cpyhLVsY?=
 =?us-ascii?Q?wOnEUPxvLNoWMTrjjpRLmWj2BXR+G8EFpCM1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLFaKgFXeLWuYaRdtHT9mStYKmwLV79SalhWOn6Q9eCD7fv8SRylag5Yxiq9?=
 =?us-ascii?Q?iu5UOtk9ju7Fx0QRouPFUyKnvYmYKBpYQJ9GOwmhkgCfdBN5cCNhTm2IFIUi?=
 =?us-ascii?Q?z3E0JwcIAdGvXbsuACLzIyvqz3rT79lMsTUAMbVDkzSTd43oVxIw26O84T6C?=
 =?us-ascii?Q?ocfTJXiR/raH2aa+SVMQ3ntvd8p3OfLZ8VHqynnb9PHzPePkht3d4XYDGZ7k?=
 =?us-ascii?Q?OKyXhbxvBDCizGgdQ9QB3oGDhm2tPoWRNn9l9inDxv3KDw6Zn6v8LKNr3UuS?=
 =?us-ascii?Q?HH5GHvZ+bpPYLa7ULPfsvT6YS1HHOUgKltVLcPK2BuGs2BU4TH27IU75vcgv?=
 =?us-ascii?Q?WF4wTglJako8OpqY7+MMDrl/kbqFgF4tSHh3fnF/EGWDkdQzJFvTIPwlAX6b?=
 =?us-ascii?Q?j1tofBbs5MvDDhhvuOHeaGLCFmUEIrnxxCacCwzuZCZ1yDbT7fx1NCh/m5aK?=
 =?us-ascii?Q?8MDdgFsngVonQ+OM/YVGWUFDSx+5CuJY8BXJ9eC4t2vYlc4nIFhnliG9qJvY?=
 =?us-ascii?Q?Zg9hEFbMVyrSDkE1YoYLO18mraWvHTnD1Dq+pGn/AvRdeIsRdqCFFDg2cuoF?=
 =?us-ascii?Q?5H0jd4g2lVkJvLr5UTGX/QcRpS/+QtlnGNZyOwtN+h9bZiapJYWXe9jx0Ttw?=
 =?us-ascii?Q?dghnKsWIs62c9K3A5pU0/NiuNafVSmUqti9sVqfCS5ozWJvfwCQDeypYnDu9?=
 =?us-ascii?Q?jY42Hh+NLSMdNJnMx30pPvgg2YPyIVOTS/SaGdaVejLyycMQsXoWRrn1fGGG?=
 =?us-ascii?Q?dNgYMYduobdyMpbs7VMM2aoZ+dD7p+gMiK2a25+A3HSW/Ce0rKqaora5UsSq?=
 =?us-ascii?Q?3Tqf0wb0uOR1DjyLdFa1HLjs3+/ZLB9ennI+sNIkYROin2LNypXDsprr0Yxo?=
 =?us-ascii?Q?WCTdemacjh8FkRudXr4UtW+9wzXtLVNVD63tQoq+ACMsEsW5FtN7DCsGszdd?=
 =?us-ascii?Q?qptoCq3vO7JczZkToh3qEcCnKQmdml8hvew75kMl6c0HvGA9U7ERCG+lDWyo?=
 =?us-ascii?Q?Oggq1i7vby7fKCdy1qwHLRgddHQ2qFxpF5cwGQSIctkmEThuQXtJdqWf5cA4?=
 =?us-ascii?Q?qJ/VAqNtLmPDmaQpF2MAI449l8Aafp5CUSvtvdTQjqn9KH1xcCCiz2UbVk33?=
 =?us-ascii?Q?eaO2HyENxZEJQHbKBCgEUjQZOd4FIGLUOI6xfxxOirvD8xM8+uxqlCVDcTTb?=
 =?us-ascii?Q?EeeXnaqJyB4mg0SIf8c8w7e03VxzhFykpivhXD7MkbYpRaUliX23laCOKBTR?=
 =?us-ascii?Q?zzr5PV+54my8TyzeckF/y0anbV26IPkMmHfDi2+sY0HPpHM+mTVuIcbb6r+j?=
 =?us-ascii?Q?ERAlMtcCwE4TVBhgAHLrEtUpP9DGaL62HXTnwK6rdLJCgn4AYvCXrBZ0O1hu?=
 =?us-ascii?Q?4dpsDP+WmGjDibLJmRjXpkBXjVHJ7WBwYrjc1d9s/uQevXheyWZRZFebj3Nt?=
 =?us-ascii?Q?YoOWxiCRROCy9osJ0Qk9FAcnJhNwK5xCiEQieDfSbWXf0EezbrcyMRO5H44c?=
 =?us-ascii?Q?f2EfNmWWxUHzRJVMGHL9M3QDL3LQe3WpSW4icLnbXknNZVtWsRiXCGsxX2Gt?=
 =?us-ascii?Q?oh8weedrk7ORCx5Qm7SIljqN3XhEyV6Gz7Okqsl0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fac1d2-2c46-43e2-b5b2-08de33cb8c6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:57:26.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJi6uYH4+MrGVc9w+qJu3FuOIwLDR/IfQmBUJRzWqcJ5BT9qWQ4yX0wuzFJBD/fLsLAz8VxcKQlkcQbC2iqFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9245

Introduce cfp.c to provide channel, frequency, and power-related utilities
for the nxpwifi driver.

- Defines supported data rates for 802.11a/b/g/n/ac
- Implements rate-to-index and index-to-rate mapping for HT/VHT formats
- Provides region code to country mapping for 802.11d support
- Adds helpers for:
  - Determining active/supported data rates
  - Mapping channel/frequency/power (CFP) triplets
  - Adjusting RX data rate index
  - Extracting rates from cfg80211 scan requests

This module serves as a foundational component for rate control,
regulatory compliance, and scan/join operations.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfp.c | 480 +++++++++++++++++++++++++
 1 file changed, 480 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfp.c b/drivers/net/wireless/nxp/nxpwifi/cfp.c
new file mode 100644
index 000000000000..fad742646d0f
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfp.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: Channel, Frequency and Power
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cfg80211.h"
+
+/* 100mW */
+#define NXPWIFI_TX_PWR_DEFAULT         20
+/* 100mW */
+#define NXPWIFI_TX_PWR_US_DEFAULT      20
+/* 50mW */
+#define NXPWIFI_TX_PWR_JP_DEFAULT      16
+/* 100mW */
+#define NXPWIFI_TX_PWR_FR_100MW        20
+/* 10mW */
+#define NXPWIFI_TX_PWR_FR_10MW         10
+/* 100mW */
+#define NXPWIFI_TX_PWR_EMEA_DEFAULT    20
+
+static u8 supported_rates_a[A_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0xb0, 0x48, 0x60, 0x6c, 0 };
+static u16 nxpwifi_data_rates[NXPWIFI_SUPPORTED_RATES_EXT] = { 0x02, 0x04,
+					0x0B, 0x16, 0x00, 0x0C, 0x12, 0x18,
+					0x24, 0x30, 0x48, 0x60, 0x6C, 0x90,
+					0x0D, 0x1A, 0x27, 0x34, 0x4E, 0x68,
+					0x75, 0x82, 0x0C, 0x1B, 0x36, 0x51,
+					0x6C, 0xA2, 0xD8, 0xF3, 0x10E, 0x00 };
+
+static u8 supported_rates_b[B_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x16, 0 };
+
+static u8 supported_rates_g[G_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0x30, 0x48, 0x60, 0x6c, 0 };
+
+static u8 supported_rates_bg[BG_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x0c,
+					0x12, 0x16, 0x18, 0x24, 0x30, 0x48,
+					0x60, 0x6c, 0 };
+
+u16 region_code_index[NXPWIFI_MAX_REGION_CODE] = { 0x00, 0x10, 0x20, 0x30,
+						0x31, 0x32, 0x40, 0x41, 0x50 };
+
+/*
+ * For every mcs_rate line, the first 8 bytes are for stream 1x1,
+ * and all 16 bytes are for stream 2x2.
+ */
+static const u16 mcs_rate[4][16] = {
+	/* LGI 40M */
+	{ 0x1b, 0x36, 0x51, 0x6c, 0xa2, 0xd8, 0xf3, 0x10e,
+	  0x36, 0x6c, 0xa2, 0xd8, 0x144, 0x1b0, 0x1e6, 0x21c },
+
+	/* SGI 40M */
+	{ 0x1e, 0x3c, 0x5a, 0x78, 0xb4, 0xf0, 0x10e, 0x12c,
+	  0x3c, 0x78, 0xb4, 0xf0, 0x168, 0x1e0, 0x21c, 0x258 },
+
+	/* LGI 20M */
+	{ 0x0d, 0x1a, 0x27, 0x34, 0x4e, 0x68, 0x75, 0x82,
+	  0x1a, 0x34, 0x4e, 0x68, 0x9c, 0xd0, 0xea, 0x104 },
+
+	/* SGI 20M */
+	{ 0x0e, 0x1c, 0x2b, 0x39, 0x56, 0x73, 0x82, 0x90,
+	  0x1c, 0x39, 0x56, 0x73, 0xad, 0xe7, 0x104, 0x120 }
+};
+
+/* AC rates */
+static const u16 ac_mcs_rate_nss1[8][10] = {
+	/* LG 160M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 160M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 80M */
+	{ 0x3B, 0x75, 0xB0, 0xEA, 0x15F, 0x1D4, 0x20F,
+	  0x249, 0x2BE, 0x30C },
+
+	/* SG 80M */
+	{ 0x41, 0x82, 0xC3, 0x104, 0x186, 0x208, 0x249,
+	  0x28A, 0x30C, 0x363 },
+
+	/* LG 40M */
+	{ 0x1B, 0x36, 0x51, 0x6C, 0xA2, 0xD8, 0xF3,
+	  0x10E, 0x144, 0x168 },
+
+	/* SG 40M */
+	{ 0x1E, 0x3C, 0x5A, 0x78, 0xB4, 0xF0, 0x10E,
+	  0x12C, 0x168, 0x190 },
+
+	/* LG 20M */
+	{ 0xD, 0x1A, 0x27, 0x34, 0x4E, 0x68, 0x75, 0x82, 0x9C, 0x00 },
+
+	/* SG 20M */
+	{ 0xF, 0x1D, 0x2C, 0x3A, 0x57, 0x74, 0x82, 0x91, 0xAE, 0x00 },
+};
+
+/* NSS2 note: the value in the table is 2 multiplier of the actual rate */
+static const u16 ac_mcs_rate_nss2[8][10] = {
+	/* LG 160M */
+	{ 0xEA, 0x1D4, 0x2BE, 0x3A8, 0x57C, 0x750, 0x83A,
+	  0x924, 0xAF8, 0xC30 },
+
+	/* SG 160M */
+	{ 0x104, 0x208, 0x30C, 0x410, 0x618, 0x820, 0x924,
+	  0xA28, 0xC30, 0xD8B },
+
+	/* LG 80M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 80M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 40M */
+	{ 0x36, 0x6C, 0xA2, 0xD8, 0x144, 0x1B0, 0x1E6,
+	  0x21C, 0x288, 0x2D0 },
+
+	/* SG 40M */
+	{ 0x3C, 0x78, 0xB4, 0xF0, 0x168, 0x1E0, 0x21C,
+	  0x258, 0x2D0, 0x320 },
+
+	/* LG 20M */
+	{ 0x1A, 0x34, 0x4A, 0x68, 0x9C, 0xD0, 0xEA, 0x104,
+	  0x138, 0x00 },
+
+	/* SG 20M */
+	{ 0x1D, 0x3A, 0x57, 0x74, 0xAE, 0xE6, 0x104, 0x121,
+	  0x15B, 0x00 },
+};
+
+struct region_code_mapping {
+	u8 code;
+	u8 region[IEEE80211_COUNTRY_STRING_LEN];
+};
+
+static struct region_code_mapping region_code_mapping_t[] = {
+	{ 0x10, "US " }, /* US FCC */
+	{ 0x20, "CA " }, /* IC Canada */
+	{ 0x30, "FR " }, /* France */
+	{ 0x31, "ES " }, /* Spain */
+	{ 0x32, "FR " }, /* France */
+	{ 0x40, "JP " }, /* Japan */
+	{ 0x41, "JP " }, /* Japan */
+	{ 0x50, "CN " }, /* China */
+};
+
+/* This function converts integer code to region string */
+u8 *nxpwifi_11d_code_2_region(u8 code)
+{
+	u8 i;
+
+	/* Look for code in mapping table */
+	for (i = 0; i < ARRAY_SIZE(region_code_mapping_t); i++)
+		if (region_code_mapping_t[i].code == code)
+			return region_code_mapping_t[i].region;
+
+	return NULL;
+}
+
+/*
+ * This function maps an index in supported rates table into
+ * the corresponding data rate.
+ */
+u32 nxpwifi_index_to_acs_data_rate(struct nxpwifi_private *priv,
+				   u8 index, u8 ht_info)
+{
+	u32 rate = 0;
+	u8 mcs_index = 0;
+	u8 bw = 0;
+	u8 gi = 0;
+
+	if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_VHT) {
+		mcs_index = min(index & 0xF, 9);
+
+		/* 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if ((index >> 4) == 1)	/* NSS = 2 */
+			rate = ac_mcs_rate_nss2[2 * (3 - bw) + gi][mcs_index];
+		else			/* NSS = 1 */
+			rate = ac_mcs_rate_nss1[2 * (3 - bw) + gi][mcs_index];
+	} else if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_HT) {
+		/* 20M: bw=0, 40M: bw=1 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (gi == 1)
+				rate = 0x0D;    /* MCS 32 SGI rate */
+			else
+				rate = 0x0C;    /* MCS 32 LGI rate */
+		} else if (index < 16) {
+			if (bw == 1 || bw == 0)
+				rate = mcs_rate[2 * (1 - bw) + gi][index];
+			else
+				rate = nxpwifi_data_rates[0];
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		/* 11n non-HT rates */
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+
+	return rate;
+}
+
+/*
+ * This function maps an index in supported rates table into
+ * the corresponding data rate.
+ */
+u32 nxpwifi_index_to_data_rate(struct nxpwifi_private *priv,
+			       u8 index, u8 ht_info)
+{
+	u32 mcs_num_supp =
+		(priv->adapter->user_dev_mcs_support == HT_STREAM_2X2) ? 16 : 8;
+	u32 rate;
+
+	if (priv->adapter->is_hw_11ac_capable)
+		return nxpwifi_index_to_acs_data_rate(priv, index, ht_info);
+
+	if (ht_info & BIT(0)) {
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (ht_info & BIT(2))
+				rate = 0x0D;	/* MCS 32 SGI rate */
+			else
+				rate = 0x0C;	/* MCS 32 LGI rate */
+		} else if (index < mcs_num_supp) {
+			if (ht_info & BIT(1)) {
+				if (ht_info & BIT(2))
+					/* SGI, 40M */
+					rate = mcs_rate[1][index];
+				else
+					/* LGI, 40M */
+					rate = mcs_rate[0][index];
+			} else {
+				if (ht_info & BIT(2))
+					/* SGI, 20M */
+					rate = mcs_rate[3][index];
+				else
+					/* LGI, 20M */
+					rate = mcs_rate[2][index];
+			}
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+	return rate;
+}
+
+/*
+ * This function returns the current active data rates.
+ *
+ * The result may vary depending upon connection status.
+ */
+u32 nxpwifi_get_active_data_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	if (!priv->media_connected)
+		return nxpwifi_get_supported_rates(priv, rates);
+	else
+		return nxpwifi_copy_rates(rates, 0,
+					  priv->curr_bss_params.data_rates,
+					  priv->curr_bss_params.num_of_rates);
+}
+
+/*
+ * This function locates the Channel-Frequency-Power triplet based upon
+ * band and channel/frequency parameters.
+ */
+struct nxpwifi_chan_freq_power *
+nxpwifi_get_cfp(struct nxpwifi_private *priv, u8 band, u16 channel, u32 freq)
+{
+	struct nxpwifi_chan_freq_power *cfp = NULL;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch = NULL;
+	int i;
+
+	if (!channel && !freq)
+		return cfp;
+
+	if (nxpwifi_band_to_radio_type(band) == HOST_SCAN_RADIO_TYPE_BG)
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_2GHZ];
+	else
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_5GHZ];
+
+	if (!sband) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: cannot find cfp by band %d\n",
+			    __func__, band);
+		return cfp;
+	}
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		if (ch->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		if (freq) {
+			if (ch->center_freq == freq)
+				break;
+		} else {
+			/* find by valid channel*/
+			if (ch->hw_value == channel ||
+			    channel == FIRST_VALID_CHANNEL)
+				break;
+		}
+	}
+	if (i == sband->n_channels) {
+		nxpwifi_dbg(priv->adapter, WARN,
+			    "%s: cannot find cfp by band %d\t"
+			    "& channel=%d freq=%d\n",
+			    __func__, band, channel, freq);
+	} else {
+		if (!ch)
+			return cfp;
+
+		priv->cfp.channel = ch->hw_value;
+		priv->cfp.freq = ch->center_freq;
+		priv->cfp.max_tx_power = ch->max_power;
+		cfp = &priv->cfp;
+	}
+
+	return cfp;
+}
+
+/* This function checks if the data rate is set to auto. */
+u8
+nxpwifi_is_rate_auto(struct nxpwifi_private *priv)
+{
+	u32 i;
+	int rate_num = 0;
+
+	for (i = 0; i < ARRAY_SIZE(priv->bitmap_rates); i++)
+		if (priv->bitmap_rates[i])
+			rate_num++;
+
+	if (rate_num > 1)
+		return true;
+	else
+		return false;
+}
+
+/*
+ * This function gets the supported data rates from bitmask inside
+ * cfg80211_scan_request.
+ */
+u32 nxpwifi_get_rates_from_cfg80211(struct nxpwifi_private *priv,
+				    u8 *rates, u8 radio_type)
+{
+	struct wiphy *wiphy = priv->adapter->wiphy;
+	struct cfg80211_scan_request *request = priv->scan_request;
+	u32 num_rates, rate_mask;
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	if (radio_type) {
+		sband = wiphy->bands[NL80211_BAND_5GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_5GHZ];
+	} else {
+		sband = wiphy->bands[NL80211_BAND_2GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_2GHZ];
+	}
+
+	num_rates = 0;
+	for (i = 0; i < sband->n_bitrates; i++) {
+		if ((BIT(i) & rate_mask) == 0)
+			continue; /* skip rate */
+		rates[num_rates++] = (u8)(sband->bitrates[i].bitrate / 5);
+	}
+
+	return num_rates;
+}
+
+/* Convert config_bands to B/G/A band */
+static u16 nxpwifi_convert_config_bands(u16 config_bands)
+{
+	u16 bands = 0;
+
+	if (config_bands & BAND_B)
+		bands |= BAND_B;
+	if (config_bands & BAND_G || config_bands & BAND_GN ||
+	    config_bands & BAND_GAC || config_bands & BAND_GAX)
+		bands |= BAND_G;
+	if (config_bands & BAND_A || config_bands & BAND_AN ||
+	    config_bands & BAND_AAC || config_bands & BAND_AAX)
+		bands |= BAND_A;
+
+	return bands;
+}
+
+/*
+ * This function gets the supported data rates. The function works in
+ * infra mode by printing the band and returning the data rates.
+ */
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 k = 0;
+	u16 bands = 0;
+
+	bands = nxpwifi_convert_config_bands(adapter->fw_bands);
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		if (bands == BAND_B) {
+			/* B only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_b\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_b,
+					       sizeof(supported_rates_b));
+		} else if (bands == BAND_G) {
+			/* G only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_g\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_g,
+					       sizeof(supported_rates_g));
+		} else if (bands & (BAND_B | BAND_G)) {
+			/* BG only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_bg\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_bg,
+					       sizeof(supported_rates_bg));
+		} else if (bands & BAND_A) {
+			/* support A */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+		}
+	}
+
+	return k;
+}
+
+u8 nxpwifi_adjust_data_rate(struct nxpwifi_private *priv,
+			    u8 rx_rate, u8 rate_info)
+{
+	u8 rate_index = 0;
+
+	/* HT40 */
+	if ((rate_info & BIT(0)) && (rate_info & BIT(1)))
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 +
+			     NXPWIFI_BW20_MCS_NUM + rx_rate;
+	else if (rate_info & BIT(0)) /* HT20 */
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 + rx_rate;
+	else
+		rate_index = (rx_rate > NXPWIFI_RATE_INDEX_OFDM0) ?
+			      rx_rate - 1 : rx_rate;
+
+	if (rate_index >= NXPWIFI_MAX_AC_RX_RATES)
+		rate_index = NXPWIFI_MAX_AC_RX_RATES - 1;
+
+	return rate_index;
+}
-- 
2.34.1


