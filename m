Return-Path: <linux-wireless+bounces-28585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABFEC3540F
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60E6622C2D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104CA30F535;
	Wed,  5 Nov 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b+H50cna"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EA30DEDD;
	Wed,  5 Nov 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339768; cv=fail; b=SSiESza1cBZjJzS/Zqp2jjsAq+l/Hs1EqdkapAzO3o0/ZJOK73g+sLZRiKQKi1vhh2zpNUKspDfpc15EgtLlQpjsn82/h8xHXWfMEs7R7a3YPQgCmk1uFwmAIn+DM9RufTvR3q/ED0DAXNPAwQuohSkv/0liI8/XHWEQfv0CdZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339768; c=relaxed/simple;
	bh=UHZ7PRwV0hHcZFYdxv1UXkMALGGN10juQsnp4qNh2Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aLxkLAiqkPODrHS/dJsGBAXGIlIrHbj1n3OW8dQRNE/iCFwQao04Gl36arm+NTtN6//m4HC1o7k5/qluqT26/R1cIH3EmxbYVuZ1HLMAsQtp70ws6lQt9rxU/L4IrHamRGsiNZKmbVPHgRXD4xTHYHY3eh0l/xzJ2mdYu/jkb34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b+H50cna; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWHaC/lnXPrmtFdJVVoWQHK4wQmBFjIlIDaiemHN4Ppcwqu1GrryWem2wQnTKZd0XB61XLkQvz7GWU9OxoL8x2LV5zFlgxx7iaNzm6NitBMBzHarLLq/IE226cwRDJfCz7cEBOZE7ZU2TcMmQiJd305QIxYIZjkGgh2/pE5GU1HANLgFWqMbw109Peop42+PlJYSO6FJiTXdw5HtUrHdTsnpWLDk5Aq9dF0YYC03eH5anDGY2YDXqmdfbnuAlY6XQeHD9NsyXO4cy5uDOBV/+jyJs2acIBYREu4M7DFF7loRMqHLW0pQtzOc18d+m0KX6HsH/iYYZRLCqrYeXOrEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR1yYUzvG/ealrl1zh/FXkUOhWE5IWRO8ELfhsKHRFM=;
 b=chQdmmKnj5UrHFWKecpuGI6JyUp7HKp0SszRAFFOWZ8fZnnezMT2papuCS5fAqSrsSvUapJ0sT6oO0KZ5Xba/hNXxLOjz4HRHcSttY1JeIg254DV9+qO9DLm6zSCWkzbBEBd5oVEOMnvAkvWzTuCMQ7wH25we8KqS4tDJ8hInm5SoUUrDiMC/4cCIGGBfbjySr+qrStHJqhLRXpIZABfJ6dg8ni0S/yIW7HeD4IQmth76zmOPWr+wWHU2vbU8fIEMnpYN0GGuopdTnEZnHgqCdMha5M3ek3bzrGpSF2dx/xlN+Sgq+bBtM/HfNgoLoyF7YO6flG2i93dkoQoYY6kwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR1yYUzvG/ealrl1zh/FXkUOhWE5IWRO8ELfhsKHRFM=;
 b=b+H50cnamWW5cudMCk2V3brxPql87Vp5n3i+ZV9m1XiumXUlKknMHl9tfzfylt95ffpMT8QBCNgEMbZcpy8P0Xt6QFXXehQ9eCVpzL25ENQ3mDNdje3FtClEgN0jxZDfZx4NoDNKDsPcRWHc6tiNOXFccWeenMaQPSL/SOZPfndC2FfjgyutTdASF+6S333HmkTfFm6Isl0w93x6gYCZOTPZJUuQrFmLZMii5f3jNCtI9Pkm5/AFw/L7Rz+U5ebQBkoydoLbM4mFhTtZrXIldRZyqqj4Ep0Wan5fS38aTElXRHaI6djK5i7gIWjsfG7gp9qqsRkW5UI8nBWIlg9o9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DBAPR04MB7429.eurprd04.prod.outlook.com (2603:10a6:10:1a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 5 Nov
 2025 10:49:18 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:18 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 07/22] wifi: nxpwifi: add join and association support
Date: Wed,  5 Nov 2025 18:47:29 +0800
Message-Id: <20251105104744.2401992-8-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|DBAPR04MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 603b17d1-7692-4b7b-1546-08de1c58f7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jPZ2K5aqWqelUFVmwqOwDEGfOESyIhnnrU06gqEcdYW7JJ0v3PHu6qp4H+Bb?=
 =?us-ascii?Q?s1UTmYyWUkSzoUHSjxHn0pI4WIvUxbhQ1sr5dQpvme2/UIaXaxtpGvIuGDF1?=
 =?us-ascii?Q?QTYz/gdnx+hCOmTGDn09HYMa/fJyZ5lbG6nIIxA4SsRLfX8rHk4pfISbD3wh?=
 =?us-ascii?Q?ujlLssa3PcyipX+gwlm/X6wgu9vr/WpColBrNgPLxN+4OPjGpEgMbNN80P6K?=
 =?us-ascii?Q?nhqaEV/kYUEBMcu+YYspkDWUSBLv1mJ+eTeEhGWdy5Fk1VZ626X2y7wcF1/B?=
 =?us-ascii?Q?vHM3R0STLZQOAa2OX/8cSwMHYZVl47bFXBYm0JiF6dTSd8Im/afPoVcGQL5f?=
 =?us-ascii?Q?Fd8eW0pRZ2ggzACOu5g1Z1J4atzw/2dIFNbt1NEONIBi/cxt7YYqATyHUQBc?=
 =?us-ascii?Q?u3Mw/BBjSVm1iI2eUks+9GEUkNVBii3JAlflUIsqTTLuOE2OXnlU9wwkkQt3?=
 =?us-ascii?Q?YDBFvIYBlt0OPtsF+FwwSphHFhqRAdXve3Pn4BhwYLs8fp09uPTfWSGOKzPj?=
 =?us-ascii?Q?4ZPae5TD2fpCUXzPGLTvVMctIkTZU4d4lbffRfguV/ABYnNRBUKUmCAUq3oc?=
 =?us-ascii?Q?q5YMiaMKdZnXTNRiyyAsUUsSzEtuQy7xIAq4w/YwbXJbKEBCBHUSabLIe0Or?=
 =?us-ascii?Q?VQQ/msMsrj50VZnbv8Gu6AEs3rL6ZacpXUBFS0JW7UFSq4+LnHDaOvRrLyBR?=
 =?us-ascii?Q?tc3T1rbQ6d0FAFWHxjfM0dL0SaULIgKs2qBjc1uGLUonf7bPUd23cnvQdu7v?=
 =?us-ascii?Q?zkfafKK/rx5ZlZJY0dfCq4tuqU6ncfQEFNwPsna1AeIfPOYIw1GM1ccmIB9v?=
 =?us-ascii?Q?wPIPNrHkBdOmwdvoIp6J/rMHitmfeIBtN5om9aLeeM6B+Ub7nTgkHZ0OWJAf?=
 =?us-ascii?Q?6YuhXGgzBjNF6UlRqAtmUUpzflI5sia1ivmsmv2gL2UOpFzGGflwLT/jDbh+?=
 =?us-ascii?Q?rquVvOC8w1GHy/hG1RgCLVeOmRAz8rD7Bf+AMt2Yk0HRrJjRARhKRRboawRk?=
 =?us-ascii?Q?p/M135VJLBzyd0bufnBM0F+WWsFCmbr1B79CFkbTeY1BU2iB3jWvxFTU85iM?=
 =?us-ascii?Q?U8PhaOzmUalyKkCbVRuENDDMBWWiB3xN4VIyau+jJ+LUxlo7gofOfcTgtG7Z?=
 =?us-ascii?Q?9sbQgeaFtnEIAG8h65wH+grULAQe2K+ZiM7WOYvXVtYJcG/ArKlO0n3s3ub1?=
 =?us-ascii?Q?wFwoEdk4gAjEQKlV05LJI4xDQLEnFwcacdcjX9PtMbn4CV+5j2sPHArH14FS?=
 =?us-ascii?Q?/Z55sFjB0CfJIbPUoVw6JYB5IRLyHmh67cbACUKAwvlOfTNoaps98KEeR7wu?=
 =?us-ascii?Q?hRKlq3JF7I+KL1lxgVpInJV5I3auWjaYcYW2lDRSPgvSunJXYndjodsn6twQ?=
 =?us-ascii?Q?rGFKBYFZ/gL3LyDKZzRgpruIUK/0wZWpZ33ot9+HwXvIw9hvuOPKLn/XaIhG?=
 =?us-ascii?Q?Wx9RHwBDPAqNfQjtz+c9WIkC8bCGl/h4qhgtqnqQBoUawb8mq7BQfTDXDyn8?=
 =?us-ascii?Q?RleiIl0K5YB6gJCwiIJ6dKr+ID+wyRRZD7yr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D3/G7Y76G9KDh39G21ZQ9ZpfJpHqS7Xw1Zf+eQK/2r7bnbceXAr31S3mGnn/?=
 =?us-ascii?Q?1XKqegkCtRiG2KV3PH6Ho31qwXRnJnz6zMgIlrOVH2TQquuyuGyNnN+2D4UJ?=
 =?us-ascii?Q?nH7erNVcv9f9XKhNeMhSgpKAoH72RUS4JDHwxZ6nopgnZV+56/EnMErwAwB8?=
 =?us-ascii?Q?yaeTU7gGh8uyn3zyIzrvcnKxDAcTGYIHYX4qheI4N7MzNXleKf1f/tPfKWqI?=
 =?us-ascii?Q?xlK3pLJMFPKf+PNvrGzftOvRP7bAseSSkYIrufW1X7zDIGTeEjeR9g6xhyOQ?=
 =?us-ascii?Q?h/ut8Cm+b44mLVlw943/qnv/Px+KCcFhGbfUg4uPPsWoNasPBJhUtu5NQLLC?=
 =?us-ascii?Q?4ng42WIoNK5UmVVvJL/naH+3VkXPjGR5Ue7JcU2T/NqOQjU2604oq9uYMJP+?=
 =?us-ascii?Q?1Q4gvQCI50XTbEfiyZArpzUaT5vFOQGk/Wo6vQZ8lJzUW02lje6pjUBcwSHf?=
 =?us-ascii?Q?kk80+KHJFmNL1Vm0FS416w3TTr+NhvAzSDz9or8i+dEEPK9kkE+rHARNUg0H?=
 =?us-ascii?Q?W3AGWFAyNWuyGMpcP6XgoC7A3NsmP7z3sxxS04AoQVWHvgGWQImiphx5P/kz?=
 =?us-ascii?Q?KEbYAfwP7YkDvReaV+3BZblq87t3s6gnzwKzz+o/B3oBnVJyK3AUav8mgRLY?=
 =?us-ascii?Q?RhcO0YNxsbXFpRji1GN5l4d4vTgmyfYMmUMWejPucBSdN2Me1yd+4OhOmI1P?=
 =?us-ascii?Q?w8TujCF5kTAWbBAP1AaatZaS8K+qhrIourbMInx+YnStJ1Vh+QhfO+JVcQo/?=
 =?us-ascii?Q?ql3sSoSFZFOsGNdiEq73ikFkvcQtZ6K353solFDNLCQFR0Syjv1G66NB2b42?=
 =?us-ascii?Q?Ga+DjwSDTzMi2IaVs5RtM8Tboyml0rpLlh7BbXPO2hvP1GtvnRjzKv1RYdiy?=
 =?us-ascii?Q?Xc9ylvW+d/eLM8GmMo0B9lqz2CR0FWXYKH52lCG5pShfg5WqKuPNJ0RJOF3C?=
 =?us-ascii?Q?EG43gwiPJZ2qNkqo7sxjO4QncvdE8cWHZR227NDatAYFNYTY+jTv5R00xXQa?=
 =?us-ascii?Q?BHRfQ+nQl2fsEkmG/sp5X4HL+lN7ZyNgLWaB4g/89jQZNu4lCug6627RraWD?=
 =?us-ascii?Q?dOXZtEIl+BLVPQHhivmVO5siivYjn2RKwd7pd6FcekKh62h+rc1JaRdF+oT9?=
 =?us-ascii?Q?uyxTk/Hp0FiTU5fmNsK4LdcMSbI/eVkFD0LWztFgkGia/Doi8tjUsDS21jw3?=
 =?us-ascii?Q?6cimvHnLNcS/toXk1FrRKsz0CG91dUB85g9guABuFgBc0Ihbhxq+SocEF6Mr?=
 =?us-ascii?Q?X/LfKllVcy/2ZPQD/yhm9MxBbLRPyzDdFzWJZJODiarotQRmMLxRaPP6rphK?=
 =?us-ascii?Q?a8KQh+lukTYJozYmT0Qz84CCFM2QwP2lBIawRxALfx/mfkhbTsvBRsXfR9Yg?=
 =?us-ascii?Q?Zw+r69OUuwUnLHZytCIzZ46JjvBBi0O10P/7BalY5LHvx49tC5J5YtB9n0ZS?=
 =?us-ascii?Q?26epu8NqlsWh3I9HIO8rY7E8SIlVsFKeyX2NFzYf2ZBn7g4R5A8yg1/80lia?=
 =?us-ascii?Q?EziBqyny6OhEsmAbf8THM8GOayVQFLbGtzIElG5OMpWN0L4Jzra/SX+IVM1l?=
 =?us-ascii?Q?6AbCVQpXA59pz1ctcv0ZF1ztzPfiHNJt6z00jWks?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603b17d1-7692-4b7b-1546-08de1c58f7fa
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:18.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0NaQsSxhiHR1KfzXYqoHH1hBAHdnXFfNm7oDa7lYlOA3ziSJi5AKfKREPUjKPyuG47I2jDUTXXmz2ovJMtQEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7429

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
 drivers/net/wireless/nxp/nxpwifi/join.c | 911 ++++++++++++++++++++++++
 1 file changed, 911 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/join.c b/drivers/net/wireless/nxp/nxpwifi/join.c
new file mode 100644
index 000000000000..1ecbce9e67b0
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/join.c
@@ -0,0 +1,911 @@
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
+/* Append a generic IE as a pass through TLV to a TLV buffer.
+ *
+ * This function is called from the network join command preparation routine.
+ *
+ * If the IE buffer has been setup by the application, this routine appends
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
+	/* If there is a generic ie buffer setup, append it to the return
+	 *   parameter buffer pointer.
+	 */
+	if (priv->gen_ie_buf_len) {
+		nxpwifi_dbg(priv->adapter, INFO,
+			    "info: %s: append generic ie len %d to %p\n",
+			    __func__, priv->gen_ie_buf_len, *buffer);
+
+		/* Wrap the generic IE buffer with a pass through TLV type */
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
+		/* Copy the generic IE buffer to the output buffer, advance
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
+		/* Reset the generic IE buffer */
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
+/* This function appends a WPS IE. It is called from the network join command
+ * preparation routine.
+ *
+ * If the IE buffer has been setup by the application, this routine appends
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
+	/* If there is a wps ie buffer setup, append it to the return
+	 * parameter buffer pointer.
+	 */
+	if (priv->wps_ie_len) {
+		nxpwifi_dbg(priv->adapter, CMD,
+			    "cmd: append wps ie %d to %p\n",
+			    priv->wps_ie_len, *buffer);
+
+		/* Wrap the generic IE buffer with a pass through TLV type */
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
+/* This function appends rsn ie tlv for wpa/wpa2 security modes.
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
+ *      - WPA/WPA2 IE
+ *      - 11n TLV
+ *      - Vendor specific TLV
+ *      - WMM TLV
+ *      - Generic IE
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
+	/* Append vendor specific IE TLV */
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
+		dev_err(adapter->dev,
+			"invalid AID value 0x%x; bits 15:14 not set\n",
+			aid);
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


