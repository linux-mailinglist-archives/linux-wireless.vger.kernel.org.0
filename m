Return-Path: <linux-wireless+bounces-29029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08147C63B35
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B000F3A38BC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52232C93C;
	Mon, 17 Nov 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ljsr0+zE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838732C333;
	Mon, 17 Nov 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377325; cv=fail; b=fNNqzSAB2XRm1U9x7HKKYuuEB2HztkE9xs006pkoyhU/NF7bTCHQ5FSpM4LJ869H5Z71BAflXFiHMuIVr1VzixXMJlEF+SoTrJ2sgQvb0HyHyhNSzM6gcFi/xDetoTDehxXuHrYDORGxD+8tZNtJB8bd4sbElq9HBKmX+0cANHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377325; c=relaxed/simple;
	bh=dmXnz92fgaynsBsm1WSk7j8qT+m1PaydJgc8CA4ILlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrjFxm2IrYYMBxNISZMQ+2R7TSHXUW64oyaPe0bTHelfhmzDJdaai7N91MUI+xuXO5UonRGLjwomQCSBZgkVKOxNUGuXA/hFy+iwWUnVJBSrIUBdd1Lh14tEXGXNeNJZM2pOrqcKO+M7hea+gU5pDAXQzg8eCcjZEKFZ334Dk/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ljsr0+zE; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V59PpIeZvjt69Fw0ranG99y47Ed4I5hJlENV+TWbs0fnkZCd4BQm7Robd50kopbaKlE4fdsujFV8K2NHvwOOo/l/xvlEPRbCWLcXJmcoMcSN6O3IPisSJI3W6asPdUYs4ryuX0Pe/ubjPynVzutHdQxt8ta5yYvR9jJXfQ6+Fgl9rM18Je6YISPL9JdxVSIbkYmGbfNN/Wcxn9ELWGCjWYGUhmCEeHPIwT4wnjferoUeXQTpOICFd2i9nHVXDVH0/K2p6U4GsxVFwV090r2QWWet3fqVb310GMNgj1R8BhaI1IZBJcLYzRPUb/FWDjAguEmlEPkQ4yTyHoYUYt6XeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSkaNzW/Qb7iFnTiltkW9fdTKPa5+L9tUxXEFC4aJes=;
 b=IyypXN1B58U31UnrvKw50K4WukyFtqTvKB3mH/NV+REBnibFYHp5XdWp+WuRSTZmVKeZ8cZlva0osEYZoFMnn0KHcR99+k6r51lxxh+aHqhLe7jGZruHRrLpd/pFZPbslbldBsqnuGq6+cJSzfYV7o35hfza6cWqvI2xaXtHtNikR0qaCNBegfYzFdxLfn0P9GgFKR3Kcjyjg211mZYSoO7ow7spQldVWACPjgtzicp3YUBVGuA4bPOfUaRTyoeIW/b1dyBJUW6M4EWDqjv/YCMgZz2Or79xA5uaGtN3TrEu63A1VSrDPaidpV7sQXS9G+RehtIYVpgGo7oSPYyLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSkaNzW/Qb7iFnTiltkW9fdTKPa5+L9tUxXEFC4aJes=;
 b=Ljsr0+zEsb3M1X7Y0vdvv95lYdo8iPQvZGjdJJ69Aah0vFXxwQicU3a+lv77AD9ZBX7Wj78dRZwEK7ksywvvF09bxljWAoJgDfzroxlgxAo/UNiqCiTfHUucYw0q+Z14bzB3FZ9vYQQmEGqkROCJlZMhukdaX6k9ywn5b7x3Ebvw6QFbOZqfvuVJwaLIFZQtz7j7i7rtTYPOadtkh+QMhF22h57zoAuQVJOToij0pFbH4IX7lIBYIRk2A4M5deWM4z9F0blJlPr4JyRHCucQ8UlOy6HqbNICmHEJprI26NluoqpvbE/Mn1rd0oLxkeoA8JbKh8GOV9RqDiqNZQwObA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GVXPR04MB11542.eurprd04.prod.outlook.com (2603:10a6:150:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:01:58 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:01:57 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 03/22] wifi: nxpwifi: add initial support for 802.11ax
Date: Mon, 17 Nov 2025 19:00:27 +0800
Message-Id: <20251117110046.2810811-4-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GVXPR04MB11542:EE_
X-MS-Office365-Filtering-Correlation-Id: e2510eb3-4072-4242-e5fd-08de25c8b9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kqsek7uoWjAS4ky3nvDsdS3D46qsyvuAi3etd/zq1gNURt0mgw4sqM6t7dFN?=
 =?us-ascii?Q?n9o9M8wI2aKMuiDuzUFcorDZIVz3TztKIJthCBi/NnHOHj3KK5dsQjZy6ACg?=
 =?us-ascii?Q?oCpMJoG9rMO2rI2PapDFURsj3Yh+dCrPjqG8D5NHM0IU7y+8DebVAc98rR53?=
 =?us-ascii?Q?5ttzD0/K10mKqWzr0bAqmnJIUNEijNbBWAwU4UseoyKm25WaYMFOxesbzOhp?=
 =?us-ascii?Q?cjcFyCdu+7fIA1PEllC7Mshs5oah/bxEPr4wGkHyTmrqo49fQEUU8DHFvEHy?=
 =?us-ascii?Q?KZfXbJSVNN2sVvd58ZgppWTcepiV6pU9+XCl9ZNXMUi3t+R55FgXKNg3aNoK?=
 =?us-ascii?Q?T4dCo4KskDrajDKJBmGbL+oNBOGqZj84u/MljYR6qRM46Pc8dE8N+HrLDEzv?=
 =?us-ascii?Q?Z+5WnKtiGHkWHH9xCBFQB8zRX6mCKluNQ4E5T8wW2x+xDCpaNd24klIUkVK8?=
 =?us-ascii?Q?S1G81IVUNsc3d1QKvzYXE+ST8xOvlj8p0MIVc+RydVzdGeVP2wtrzo18Kh97?=
 =?us-ascii?Q?cD3U0SYsHoLoBRMFzYqRtj3D/8vtiIcmqg1JEzgvMNaaydi+nx3aP2wtebWp?=
 =?us-ascii?Q?Eqc9jbGAMcUX6jLqLOEx1wsXNn8+5exNNkCV54atmCeaABzoBav3HHD1PvUi?=
 =?us-ascii?Q?3fxOB5rEBFtZhXU1WtOIt3l3gQZv63/eatI8dcz5dOIau1EJfUB9HLPD+Hvx?=
 =?us-ascii?Q?o7MQBmxWWhI77L7lpVrYrr+J0rRWE+PYC4Yp6VqXaG8uP6gDYzS9rVXQws1b?=
 =?us-ascii?Q?8vgIhacg3Sxd8J9+szzwhJ1Om1ENC8U20kcvn6h5HWaS4PGMDbwGuezDEBib?=
 =?us-ascii?Q?KUUgN/aYHG/ohcIZJzKt/3QlgTX0vgG0N9ht+X6EDq1Jg+IYfEvxbVjWnBnR?=
 =?us-ascii?Q?jxGL2FrPwzvMGfLnP7FBGkLDJXRUZ7RD4/06jIrNOYXGlJhRC+NzS6/mnCj0?=
 =?us-ascii?Q?/6UwzHNgF6l4QGYJEaEgOK+4HHTc03a6EW//Rehor4jwd5vlkOZTFLgZrDUJ?=
 =?us-ascii?Q?tEiEUlI8VyrICEn0oV6OQlLiP0ZC67N9t78PChteWW/2BsG2CaAVqjLo1w+W?=
 =?us-ascii?Q?bWQV4mR+TqTnmgA0q9LPURL9P5M+hXd5A++/QoieDIbgAiidtNgOl3CDD9UW?=
 =?us-ascii?Q?22aDtDpcVKkJn/zBJQpK2OunqU0v9D/GlqOlkmMmDP5ckNvHCdm9dvw4RhpD?=
 =?us-ascii?Q?KpsSVpRi+ZX7LlgWBemJvRFM/VvXTUGA+RXG8rLT9hhSBZ7jAMjOlHJJD1OC?=
 =?us-ascii?Q?uUdWmygFhsyIEkMmJeAoW3alrXcRvSKUTVNv3x0vymz7cfrsEmzNhNBpH8SG?=
 =?us-ascii?Q?KAZRc+awGb+WdL5seqxW4qial+CD1qqEUwgRk29cNurJlqv0d6figWiGA2n1?=
 =?us-ascii?Q?HtUWA5KrlIMMLHDBQD9G1MVclri4kmxbuovtyF4F11Q2vAw3JgpYcqpuuIBO?=
 =?us-ascii?Q?ir72GHLo0rLPPR07uCMczPedATBYI2oyBrAR/DRdj+6aN5jt7xbMH9tJZCwg?=
 =?us-ascii?Q?yEAyVZ04SNyDfp1QNGbmO1H0v2Q8O7VYbjTf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V9JmKqR/Rh8DZ7SrFRPCqnTf0JFbDR2LGUAMk3gTvxd/ddkg4Vqvk1cvBDVx?=
 =?us-ascii?Q?DBmIlNmJk//XNwRZuAgYL7mnyzkOBd1+GAl32L+9N0+OS9myx09G/vpp0RLK?=
 =?us-ascii?Q?y7erlwys9N1wkhb2feCvfazgnq/pznklcb26Mff9V4iIETcJJ3azIrWAYeBh?=
 =?us-ascii?Q?Rw4mAs0atEc+lM0/zKqmb7oa7opIkzHDcPCFoaehkLozGUkHTFRuUOEC5DuF?=
 =?us-ascii?Q?j2V2vSTgVG5Hef7DoOgGcElmyWqi2E+Dlx3DkrUrQpzIUijUU3jqAgXo+EeQ?=
 =?us-ascii?Q?+vXWga0JBYcXFUckApvSytLsBSSxRPSHOz+lJ9Fkw3ketzLyomLZ56Wgm8tK?=
 =?us-ascii?Q?1n1Gn1or2oMqhdkxWbyqSuvWiMFuIFCuVczTj1LRglfK3zGO47bIsH900tsu?=
 =?us-ascii?Q?fGcIYZEl4KJC1XbIdcF+hGpwCweCBywemQbqwtZ6SVhWwwA9NY5HwH17NGIY?=
 =?us-ascii?Q?fPP+mRsRKyrHFUlQ1bzm2MzbcVH1OB0OkX5o+NRJcWMowBCvVB34CHeH6mGA?=
 =?us-ascii?Q?ElISiaoTjUYjAsuWjCNzwBiw+GwfvjGQvI44DAwTbxCIpTmAmKSefGsjMJmY?=
 =?us-ascii?Q?xD7G+JXeK2aia6uyWbZ1EqafLz4niBvIQCBgVYeV3Ac0GNNvIGcNPK1O8b6n?=
 =?us-ascii?Q?nrujx3TvGHnvDCyvTbPXjMF8ISbm3s+BjD73nxqJE2JGNJRnXloaUOLdk4uM?=
 =?us-ascii?Q?NknSPeiTED9RdoOcjqhkEBAJ3Ly2sZl9wEHDX4/uDKrJ5Gaa6HMD1L9kdasA?=
 =?us-ascii?Q?r6FZTp5UIgDO6Jt2tv767MTfwFURXYi+moKZnFqgBzfA4WzXXxj6iy27STSP?=
 =?us-ascii?Q?vcnZkm0D5sG9k0VlIjxEyXAzjXJ91tprI8Eoj6GaoL5f881JYkMP38QBs7OZ?=
 =?us-ascii?Q?F4R+U4yXlt6MRpYnEn9BeNr6Q0HQlN4MJGk9ZqcOHZaFxaSifmGxg4hN1MtA?=
 =?us-ascii?Q?5t9PCPRugWM+nZx6JuKVfnAk4KZaisOVhw6tBrRr9Dd1x7ZajssqfKO0h7l/?=
 =?us-ascii?Q?7pQZ/lcLPxwGZQK965KkVUl05Cgwuqoq/hNj04Jyg7mKzBRqhXnP2qEjh6wM?=
 =?us-ascii?Q?SyLPnvLawdowhiBdYEyxJo9JrTQjXEYM1pKnxDEoNRHEbHCAnX1hER08NAuU?=
 =?us-ascii?Q?7tD4ScrW7dmFXef/R+Qi6FF8CuYaI0h6z0H2LYTxpO1h/mHwvLu2+f/h+Hfd?=
 =?us-ascii?Q?Qt/+2RBkdsgKNlqabPGtAZAs83a7r5M0JgU5+cLafPNI75XTBSQvTuBaQyTh?=
 =?us-ascii?Q?cbGqzVStINsKBzzt25t8hb4/o0agEGQcT9rVGbWrq9D0EW1UX5wUfYz2f+6i?=
 =?us-ascii?Q?WLi/FbE3gV3GIOjbZG7tg1ff2zTuV+4of88Nym4E/+fOIvMQcl4qupjDL8P0?=
 =?us-ascii?Q?F+vQlpuok38QWphuHlcIJXIH8bbw9MtHOtonmRuAcJ9bc3pUctCczZ4VulRi?=
 =?us-ascii?Q?7mzdsxpk/gV67NVFnMTH4/tX/cUlFXoYkaQllsmau01zZW2c+TwZWCSyC/xZ?=
 =?us-ascii?Q?hN7D7/EXQtaIAw62metF5MFqepItEw6k3HdIb+943+5L6f0839qUzuCw6Mi0?=
 =?us-ascii?Q?wPAKHZjBg55YDrFiAElNtxwpvUstUbF7lzz6mFI5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2510eb3-4072-4242-e5fd-08de25c8b9d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:01:57.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xt88e/0RJduptBvoNm7Iz1aW5eeIQrOdudKJ9tiRVIac/3lRe9n6+eLzY3N29FXzyc7xcyVODH6VwUi0nv1O+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11542

Introduce 802.11ax feature support for both client and AP modes,
with coordination between the driver and NXP firmware.

- In client mode, the firmware assists the association process via
  HOST_CMD_802_11_ASSOCIATE. The driver converts 802.11ax IEs from
  cfg80211 parameters into TLVs and appends them to the host command.

- In AP mode, the driver converts 802.11ax IEs into parameters for
  HOST_CMD_11AX_CFG, which are passed to the firmware for configuration.

This patch adds logic to handle HE (High Efficiency) capabilities,
including MAC/PHY features, MCS maps, and TWT (Target Wake Time)
negotiation. It also includes support for various 11ax-specific
firmware commands such as OBSS PD, beamforming, TXOMI, and BTWT.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 596 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h |  77 +++
 2 files changed, 673 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
new file mode 100644
index 000000000000..de531c18f545
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -0,0 +1,596 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ax
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ax.h"
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *user_he_cap = NULL;
+	u8 header_len = sizeof(struct nxpwifi_ie_types_header);
+	u16 data_len = le16_to_cpu(hw_he_cap->header.len);
+	bool he_cap_2g = false;
+	int i;
+
+	if ((data_len + header_len) > sizeof(adapter->hw_he_cap)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "hw_he_cap too big, len=%d\n",
+			    data_len);
+		return;
+	}
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)hw_he_cap;
+
+	if (he_cap->he_phy_cap[0] &
+	    (AX_2G_40MHZ_SUPPORT | AX_2G_20MHZ_SUPPORT)) {
+		adapter->hw_2g_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_2g_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_2g_he_cap_len);
+		adapter->fw_bands |= BAND_GAX;
+		he_cap_2g = true;
+		nxpwifi_dbg_dump(adapter, CMD_D, "2.4G HE capability element ",
+				 adapter->hw_2g_he_cap,
+				 adapter->hw_2g_he_cap_len);
+	} else {
+		adapter->hw_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_he_cap_len);
+		adapter->fw_bands |= BAND_AAX;
+		nxpwifi_dbg_dump(adapter, CMD_D, "5G HE capability element ",
+				 adapter->hw_he_cap,
+				 adapter->hw_he_cap_len);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		if (he_cap_2g) {
+			priv->user_2g_he_cap_len = adapter->hw_2g_he_cap_len;
+			memcpy(priv->user_2g_he_cap, adapter->hw_2g_he_cap,
+			       sizeof(adapter->hw_2g_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_2g_he_cap;
+		} else {
+			priv->user_he_cap_len = adapter->hw_he_cap_len;
+			memcpy(priv->user_he_cap, adapter->hw_he_cap,
+			       sizeof(adapter->hw_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_he_cap;
+		}
+
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+			user_he_cap->he_mac_cap[0] &=
+				~HE_MAC_CAP_TWT_RESP_SUPPORT;
+		else
+			user_he_cap->he_mac_cap[0] &=
+				~HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	adapter->is_hw_11ax_capable = true;
+}
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc)
+{
+	u16 bss_band = bss_desc->bss_band;
+
+	if (bss_desc->disable_11n)
+		return false;
+
+	if (bss_band & BAND_G)
+		return (priv->config_bands & BAND_GAX);
+	else if (bss_band & BAND_A)
+		return (priv->config_bands & BAND_AAX);
+
+	return false;
+}
+
+int nxpwifi_fill_he_cap_tlv(struct nxpwifi_private *priv,
+			    struct nxpwifi_ie_types_he_cap *he_cap,
+			    u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap = NULL;
+	u16 rx_nss, tx_nss;
+	u8 nss;
+	u16 cfg_value;
+	u16 hw_value;
+	int ret_len;
+
+	if (bands & BAND_A) {
+		memcpy(he_cap, priv->user_he_cap, priv->user_he_cap_len);
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)adapter->hw_he_cap;
+		ret_len = priv->user_he_cap_len;
+	} else {
+		memcpy(he_cap, priv->user_2g_he_cap, priv->user_2g_he_cap_len);
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)adapter->hw_2g_he_cap;
+		ret_len = priv->user_2g_he_cap_len;
+	}
+
+	if (bands & BAND_A) {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream >> 8);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream >> 8) & 0x0f;
+	} else {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream) & 0x0f;
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->rx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->rx_mcs_80, nss);
+		if (rx_nss != 0 && nss > rx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT || cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->tx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->tx_mcs_80, nss);
+		if (tx_nss != 0 && nss > tx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT || cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	int ret_len;
+
+	if (!bss_desc->bcn_he_cap)
+		return -EOPNOTSUPP;
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)*buffer;
+	ret_len = nxpwifi_fill_he_cap_tlv(priv, he_cap, bss_desc->bss_band);
+	*buffer += ret_len;
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &cmd->params.ax_cfg;
+	u16 cmd_size;
+	struct nxpwifi_ie_types_header *header;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CFG);
+	cmd_size = sizeof(struct host_cmd_11ax_cfg) + S_DS_GEN;
+
+	he_cfg->action = cpu_to_le16(cmd_action);
+	he_cfg->band_config = ax_cfg->band;
+
+	if (ax_cfg->he_cap_cfg.len &&
+	    ax_cfg->he_cap_cfg.ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+		header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+		header->type = cpu_to_le16(ax_cfg->he_cap_cfg.id);
+		header->len = cpu_to_le16(ax_cfg->he_cap_cfg.len);
+		memcpy(he_cfg->tlv + sizeof(*header),
+		       &ax_cfg->he_cap_cfg.ext_id,
+		       ax_cfg->he_cap_cfg.len);
+		cmd_size += (sizeof(*header) + ax_cfg->he_cap_cfg.len);
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &resp->params.ax_cfg;
+	struct nxpwifi_ie_types_header *header;
+	u16 left_len, tlv_type, tlv_len;
+	u8 ext_id;
+	struct nxpwifi_11ax_he_cap_cfg *he_cap = &ax_cfg->he_cap_cfg;
+
+	left_len = le16_to_cpu(resp->size) - sizeof(*he_cfg) - S_DS_GEN;
+	header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+
+	while (left_len > sizeof(*header)) {
+		tlv_type = le16_to_cpu(header->type);
+		tlv_len = le16_to_cpu(header->len);
+
+		if (tlv_type == TLV_TYPE_EXTENSION_ID) {
+			ext_id = *((u8 *)header + sizeof(*header) + 1);
+			if (ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+				he_cap->id = tlv_type;
+				he_cap->len = tlv_len;
+				memcpy((u8 *)&he_cap->ext_id,
+				       (u8 *)header + sizeof(*header) + 1,
+				       tlv_len);
+				if (he_cfg->band_config & BIT(1)) {
+					memcpy(priv->user_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_he_cap_len =
+						sizeof(*header) + tlv_len;
+				} else {
+					memcpy(priv->user_2g_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_2g_he_cap_len =
+						sizeof(*header) + tlv_len;
+				}
+			}
+		}
+
+		left_len -= (sizeof(*header) + tlv_len);
+		header = (struct nxpwifi_ie_types_header *)((u8 *)header +
+							    sizeof(*header) +
+							    tlv_len);
+	}
+
+	return 0;
+}
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &cmd->params.ax_cmd;
+	u16 cmd_size;
+	struct nxpwifi_11ax_sr_cmd *sr_cmd;
+	struct nxpwifi_ie_types_data *tlv;
+	struct nxpwifi_11ax_beam_cmd *beam_cmd;
+	struct nxpwifi_11ax_htc_cmd *htc_cmd;
+	struct nxpwifi_11ax_txomi_cmd *txmoi_cmd;
+	struct nxpwifi_11ax_toltime_cmd *toltime_cmd;
+	struct nxpwifi_11ax_txop_cmd *txop_cmd;
+	struct nxpwifi_11ax_set_bsrp_cmd *set_bsrp_cmd;
+	struct nxpwifi_11ax_llde_cmd *llde_cmd;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CMD);
+	cmd_size = sizeof(struct host_cmd_11ax_cmd) + S_DS_GEN;
+
+	he_cmd->action = cpu_to_le16(cmd_action);
+	he_cmd->sub_id = cpu_to_le16(ax_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		sr_cmd = (struct nxpwifi_11ax_sr_cmd *)&ax_cmd->param;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		tlv->header.type = cpu_to_le16(sr_cmd->type);
+		tlv->header.len = cpu_to_le16(sr_cmd->len);
+		memcpy(tlv->data, sr_cmd->param.obss_pd_offset.offset,
+		       sr_cmd->len);
+		cmd_size += (sizeof(tlv->header) + sr_cmd->len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		beam_cmd = (struct nxpwifi_11ax_beam_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = beam_cmd->value;
+		cmd_size += sizeof(*beam_cmd);
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		htc_cmd = (struct nxpwifi_11ax_htc_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = htc_cmd->value;
+		cmd_size += sizeof(*htc_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		txmoi_cmd =	(struct nxpwifi_11ax_txomi_cmd *)&ax_cmd->param;
+
+		memcpy((void *)he_cmd->val, txmoi_cmd, sizeof(*txmoi_cmd));
+		cmd_size += sizeof(*txmoi_cmd);
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		toltime_cmd = (struct nxpwifi_11ax_toltime_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &toltime_cmd->tol_time,
+		       sizeof(toltime_cmd->tol_time));
+		cmd_size += sizeof(*toltime_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		txop_cmd = (struct nxpwifi_11ax_txop_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txop_cmd->rts_thres,
+		       sizeof(txop_cmd->rts_thres));
+		cmd_size += sizeof(*txop_cmd);
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		set_bsrp_cmd = (struct nxpwifi_11ax_set_bsrp_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = set_bsrp_cmd->value;
+		cmd_size += sizeof(*set_bsrp_cmd);
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		llde_cmd = (struct nxpwifi_11ax_llde_cmd *)&ax_cmd->param;
+
+		memcpy((void *)he_cmd->val, llde_cmd, sizeof(*llde_cmd));
+		cmd_size += sizeof(*llde_cmd);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &resp->params.ax_cmd;
+	struct nxpwifi_ie_types_data *tlv;
+
+	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		memcpy(ax_cmd->param.sr_cfg.param.obss_pd_offset.offset,
+		       tlv->data,
+		       ax_cmd->param.sr_cfg.len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		ax_cmd->param.beam_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		ax_cmd->param.htc_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		memcpy(&ax_cmd->param.txomi_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.txomi_cfg));
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		memcpy(&ax_cmd->param.toltime_cfg.tol_time,
+		       he_cmd->val, sizeof(ax_cmd->param.toltime_cfg));
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		memcpy(&ax_cmd->param.txop_cfg.rts_thres,
+		       he_cmd->val, sizeof(ax_cmd->param.txop_cfg));
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		ax_cmd->param.setbsrp_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		memcpy(&ax_cmd->param.llde_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.llde_cfg));
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u8 nxpwifi_is_ap_11ax_twt_supported(struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct element *ext_cap;
+
+	if (!bss_desc->bcn_he_cap)
+		return false;
+	if (!(bss_desc->bcn_he_cap->mac_cap_info[0] & HE_MAC_CAP_TWT_RESP_SUPPORT))
+		return false;
+	if (!bss_desc->bcn_ext_cap)
+		return false;
+	ext_cap = (struct element *)bss_desc->bcn_ext_cap;
+
+	if (!(ext_cap->data[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
+		return false;
+	return true;
+}
+
+bool nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				   struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap;
+
+	if (bss_desc && (!nxpwifi_is_ap_11ax_twt_supported(bss_desc))) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "AP don't support twt feature\n");
+		return false;
+	}
+
+	if (bss_desc->bss_band & BAND_A) {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_he_cap;
+	} else {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_2g_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_2g_he_cap;
+	}
+
+	if (!(hw_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "FW don't support TWT\n");
+		return false;
+	}
+
+	if (!(user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "USER HE_MAC_CAP don't support TWT\n");
+		return false;
+	}
+
+	return true;
+}
+
+u8 nxpwifi_is_sta_11ax_twt_req_supported(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	u8 ret = 0;
+
+	if (ISSUPP_11AXENABLED(priv->adapter->fw_cap_ext) &&
+	    (priv->config_bands & BAND_GAX || priv->config_bands & BAND_AAX)) {
+		if (priv->config_bands & BAND_AAX)
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)priv->user_he_cap;
+		else
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)priv->user_2g_he_cap;
+		ret = user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	return ret;
+}
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &cmd->params.twt_cfg;
+	struct nxpwifi_twt_setup *twt_setup;
+	struct nxpwifi_twt_teardown *twt_teardown;
+	struct nxpwifi_twt_report *twt_report;
+	struct nxpwifi_twt_information *twt_information;
+	struct nxpwifi_btwt_ap_config *btwt_ap_config;
+	u8 i;
+	u16 cmd_size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_TWT_CFG);
+	cmd_size = sizeof(struct host_cmd_twt_cfg) + S_DS_GEN;
+
+	twt_cfg_cmd->action = cpu_to_le16(cmd_action);
+	twt_cfg_cmd->sub_id = cpu_to_le16(twt_cfg->sub_id);
+
+	switch (twt_cfg->sub_id) {
+	case NXPWIFI_11AX_TWT_SETUP_SUBID:
+		twt_setup = (struct nxpwifi_twt_setup *)
+			twt_cfg_cmd->val;
+
+		memset(twt_setup, 0x00, sizeof(struct nxpwifi_twt_setup));
+		twt_setup->implicit = twt_cfg->param.twt_setup.implicit;
+		twt_setup->announced = twt_cfg->param.twt_setup.announced;
+		twt_setup->trigger_enabled = twt_cfg->param.twt_setup.trigger_enabled;
+		twt_setup->twt_info_disabled = twt_cfg->param.twt_setup.twt_info_disabled;
+		twt_setup->negotiation_type = twt_cfg->param.twt_setup.negotiation_type;
+		twt_setup->twt_wakeup_duration =
+			twt_cfg->param.twt_setup.twt_wakeup_duration;
+		twt_setup->flow_identifier = twt_cfg->param.twt_setup.flow_identifier;
+		twt_setup->hard_constraint = twt_cfg->param.twt_setup.hard_constraint;
+		twt_setup->twt_exponent = twt_cfg->param.twt_setup.twt_exponent;
+		twt_setup->twt_mantissa = twt_cfg->param.twt_setup.twt_mantissa;
+		twt_setup->twt_request = twt_cfg->param.twt_setup.twt_request;
+		twt_setup->bcn_miss_threshold = twt_cfg->param.twt_setup.bcn_miss_threshold;
+		cmd_size += sizeof(struct nxpwifi_twt_setup);
+		break;
+	case NXPWIFI_11AX_TWT_TEARDOWN_SUBID:
+		twt_teardown = (struct nxpwifi_twt_teardown *)
+			twt_cfg_cmd->val;
+		memset(twt_teardown, 0x00,
+		       sizeof(struct nxpwifi_twt_teardown));
+		twt_teardown->flow_identifier =
+			twt_cfg->param.twt_teardown.flow_identifier;
+		twt_teardown->negotiation_type =
+			twt_cfg->param.twt_teardown.negotiation_type;
+		twt_teardown->teardown_all_twt =
+			twt_cfg->param.twt_teardown.teardown_all_twt;
+		cmd_size += sizeof(struct nxpwifi_twt_teardown);
+		break;
+	case NXPWIFI_11AX_TWT_REPORT_SUBID:
+		twt_report = (struct nxpwifi_twt_report *)
+			twt_cfg_cmd->val;
+		memset(twt_report, 0x00, sizeof(struct nxpwifi_twt_report));
+		twt_report->type = twt_cfg->param.twt_report.type;
+		cmd_size += sizeof(struct nxpwifi_twt_report);
+		break;
+	case NXPWIFI_11AX_TWT_INFORMATION_SUBID:
+		twt_information = (struct nxpwifi_twt_information *)
+			twt_cfg_cmd->val;
+		memset(twt_information, 0x00,
+		       sizeof(struct nxpwifi_twt_information));
+		twt_information->flow_identifier =
+			twt_cfg->param.twt_information.flow_identifier;
+		twt_information->suspend_duration =
+			twt_cfg->param.twt_information.suspend_duration;
+		cmd_size += sizeof(struct nxpwifi_twt_information);
+		break;
+	case NXPWIFI_11AX_BTWT_AP_CONFIG_SUBID:
+		btwt_ap_config = (struct nxpwifi_btwt_ap_config *)
+				 twt_cfg_cmd->val;
+		memset(btwt_ap_config, 0x00,
+		       sizeof(struct nxpwifi_btwt_ap_config));
+		btwt_ap_config->ap_bcast_bet_sta_wait =
+			twt_cfg->param.btwt_ap_config.ap_bcast_bet_sta_wait;
+		btwt_ap_config->ap_bcast_offset =
+			twt_cfg->param.btwt_ap_config.ap_bcast_offset;
+		btwt_ap_config->bcast_twtli =
+			twt_cfg->param.btwt_ap_config.bcast_twtli;
+		btwt_ap_config->count =
+			twt_cfg->param.btwt_ap_config.count;
+		for (i = 0; i < BTWT_AGREEMENT_MAX; i++) {
+			btwt_ap_config->btwt_sets[i].btwt_id =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].btwt_id;
+			btwt_ap_config->btwt_sets[i].ap_bcast_mantissa =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_mantissa;
+			btwt_ap_config->btwt_sets[i].ap_bcast_exponent =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_exponent;
+			btwt_ap_config->btwt_sets[i].nominalwake =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].nominalwake;
+		}
+
+		cmd_size += sizeof(struct nxpwifi_btwt_ap_config);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "Unknown sub id: %d\n", twt_cfg->sub_id);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &resp->params.twt_cfg;
+	u16 action;
+
+	action = le16_to_cpu(twt_cfg_cmd->action);
+	twt_cfg->sub_id = le16_to_cpu(twt_cfg_cmd->sub_id);
+
+	if (action == HOST_ACT_GEN_GET &&
+	    twt_cfg->sub_id == NXPWIFI_11AX_TWT_REPORT_SUBID) {
+		struct nxpwifi_twt_report *twt_report =
+			(struct nxpwifi_twt_report *)twt_cfg_cmd->val;
+
+		memcpy(&twt_cfg->param.twt_report, twt_report, sizeof(struct nxpwifi_twt_report));
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.h b/drivers/net/wireless/nxp/nxpwifi/11ax.h
new file mode 100644
index 000000000000..fba6850eec03
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11ax
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AX_H_
+#define _NXPWIFI_11AX_H_
+
+/* device support 2.4G 40MHZ*/
+#define AX_2G_40MHZ_SUPPORT BIT(1)
+/* device support 2.4G 242 tone RUs */
+#define AX_2G_20MHZ_SUPPORT BIT(5)
+
+/* 0 indicates support for HE-MCS 0-7 for n spatial streams
+ * 1 indicates support for HE-MCS 0-9 for n spatial streams
+ * 2 indicates support for HE-MCS 0-11 for n spatial streams
+ * 3 indicates that n spatial streams is not supported for HE PPDUs
+ */
+static inline u16
+nxpwifi_get_he_nss_mcs(__le16 mcs_map_set, int nss) {
+	return ((le16_to_cpu(mcs_map_set) >> (2 * (nss - 1))) & 0x3);
+}
+
+static inline void
+nxpwifi_set_he_nss_mcs(__le16 *mcs_map_set, int nss, int value) {
+	u16 temp;
+
+	temp = le16_to_cpu(*mcs_map_set);
+	temp |= ((value & 0x3) << (2 * (nss - 1)));
+	*mcs_map_set = cpu_to_le16(temp);
+}
+
+bool nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				   struct  nxpwifi_bssdescriptor *bss_desc);
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap);
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc);
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+
+int nxpwifi_fill_he_cap_tlv(struct nxpwifi_private *priv,
+			    struct nxpwifi_ie_types_he_cap *he_cap,
+			    u16 bands);
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+u8 nxpwifi_is_sta_11ax_twt_req_supported(struct nxpwifi_private *priv);
+
+#endif /* _NXPWIFI_11AX_H_ */
-- 
2.34.1


