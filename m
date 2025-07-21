Return-Path: <linux-wireless+bounces-25718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DCBB0BC8F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F217A31B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF77627E7FC;
	Mon, 21 Jul 2025 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jZPGiXxQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872A27C875;
	Mon, 21 Jul 2025 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079478; cv=fail; b=ujWtxF4tnym0Oi8RT/NVuxHq2C7v0QwQG6yLeyLdwSYHBkh7OMN4JT6E1R/2zn6vcx8DpIDf6WYHAPDYdejsg92NtZF+nhrm402ytxa+EKSqpJ16kVb1vR1CHpg+stvW3mWWvaW1gfBsbSogKx9e6QU15+zTzx14pF0zLWNMP5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079478; c=relaxed/simple;
	bh=Sp5ream8d4ltJaU0f2F+b+W+/yZEy4Wd3naedb5Pc44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEnjJpP5UN20wCszKI17Rp4Cu+gYmfWcD+fTifNCRWIEx4J68d3ShIqYLqwoIcUtCUD7PPQRduV6pUBORizcUEewWoDVpiZh9BvIXiz57zsry4JTyQUTef65F8yVXsa1bfct1zY9ezvMjG1x8qAjPsAktZknAkanGX7uf+5txvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jZPGiXxQ; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgFgOAz5ng2YQMHWvk0HJtLZdRdrrgBkxkp2MbzIkjMHkO8ggXbuK/EftebxW2cPvkYP4ygMRTjvIPnnZoOXaA5HQbTxf7irLw2JKZnJe6lOQ5b0/+oLzxLFNV5+DCjAt2u5er78bt+N+UgV95eJ5/CpDSMe/LS88iIfsj6G6wt7eVlQmvUQHukvFzcyZrOvR+3e3Pp9iBh772UuDJjRwL1ARly1NpPlc0tiyunbXLYZA/7fVr48IVUznP2z5fCqFSO6NU7R6Fb1ajBiAnUas4TJaFP1yPvZmEpVzFUP2T4em6E1NRQev9CdFkMX47gy+XJ/CSn4GgMVD6sZEau44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr/UOLwahkdUZLN8kiRRL+1StoTr2Kan9qHafPUEv/0=;
 b=uNfyozKFNOYAz7uzW6PD6dlovb0uxZvleuIBVRSs3FWHkYDgdvbmCVeeE2U4dbcrwYIuuvEU9uZJvxiKlaf87X9b2fiRHAHkAX9DlBC20spypACZcFBH3/bhMlkZN0H8b14cMvs8eMamacWBqZXKjUO0ntfhOWyThFHQW4D0lnLSzOmjjh8RrKLfHtFzkSUv9Mc27UVTxuYW+6obFZlfmUW3+KAbcuqEKiNkuDvgkLdeGMCG8jmvhP5yZnBT2AN4bSYlNaUSr47AgwYIVA+xvwZ+/cWUVzag5+rNAnQgKo/RvXP97dmeg7xTWpPX2xrYF6H/+UQ0lcCyzH4AybO20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr/UOLwahkdUZLN8kiRRL+1StoTr2Kan9qHafPUEv/0=;
 b=jZPGiXxQ/7bFE7i8VIBjNvwqnaycFmnp0thFe88sP2mbCr0ryv7x307+Mez0u1ZKktbUufYa/9swsP2yigKlBqiPPzaCiqDpTKVK4QJa0b44hYuaB9uGASEVwHw3dvzNUaDqv+cUcKHBmsl7vrA2av/qzQsYwPAsGau4bYVU9z3hf+1wdtYD14yNePf50GGKIoxiDQV0obrPv4cZapKCbJ+yp9QRz+VH5CfpzcFGkiCxSfiGEaSZME+NsyOKljGXQY7pyQt7h1OOqapy3iOE5PLTTvxQqFfkTYYAaTZE80ynE87yU+a7ceUabrKdH+ZUjW7dwKZvbRu+MjEQjChnTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:31:14 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:31:14 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com,
	jeff.chen_1@nxp.com,
	brian.hsu@nxp.com
Subject: [PATCH v4 04/22] wifi: nxpwifi: add 802.11h file
Date: Mon, 21 Jul 2025 14:26:23 +0800
Message-Id: <20250721062641.2001796-5-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
References: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|DU2PR04MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a52301d-28fe-452c-2a2b-08ddc82030c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vmcjoNRmC2ZQLaCgKiM/P/6u366tE0NBbwYnSveTkK06lYWv13cg+gFJnLqi?=
 =?us-ascii?Q?6NBhH3vLucykjGlig55S6HWyZ5j32ifAv3kvIYPoXvnQObqE272OFWm8pNb5?=
 =?us-ascii?Q?07Fap4xfKudRXzxr44qhHPXmFJq+dUka3XNMBn/OhUdm02a6aZEh1Oy1OKOY?=
 =?us-ascii?Q?kHvQMPIvfEqL+rgeyYZbHvb/UvtbWFIHHpR4bXiJKp4RWGYHv9lnAlS0qvNL?=
 =?us-ascii?Q?KmHhI+e1Gf9efgZ6g98hmOy8XeC9x0JfNmWkz/O2s72CwA8jOkAuZxQGU2hV?=
 =?us-ascii?Q?anV3jsSbAJ8eoh7t12C5gAzrnd4lGqP/MKqIPCmACx3Puj8Kua2c4xY8PzmM?=
 =?us-ascii?Q?79dxHyC/pmvvHQfUW13tolHzFSyy29+TmLDKYqlgG+5Wucsh2re/me2ahqNb?=
 =?us-ascii?Q?51SnESi+bpoh0J7+kZHnTuILFHqQbKUMBTTLjlJJCkso4nPHA/NbULXyWqtz?=
 =?us-ascii?Q?NUeWXIX8cxdCX21c7as5DuT3lJfiPeITnT1NFa0F0fhFo3v+IeqPrsyoKnx9?=
 =?us-ascii?Q?aEyVez0T3RaVwgMchIHEK2gJiehgobz55UxqfXnnRvC8r2Oh8RIYwX3DaoHU?=
 =?us-ascii?Q?VAV2U3AbFOz5nlWORjjofDi0f4kY7dvJ6/QFbt90nY6WVUDGm/UqsYgsPaJB?=
 =?us-ascii?Q?fu+ombXM3mdmOVNbDHt6Xh/ALzHOJ9ja9LTERQfz0h9v0pQy9z91uMG4/MRu?=
 =?us-ascii?Q?HLkd4sqB/8USgeI2svLu2ksAaGM8jC370jBXU1BK2qDm5Mbz9NQ4oto0ocDq?=
 =?us-ascii?Q?9tyttc7z3MvxTKay76fsiOalgy1Z5uIibORT6ZtNlR+4jounW4wKHkkB42he?=
 =?us-ascii?Q?R7nVdkIRLOpQtwUKNFIsZkf0xgRyHHXp48U//NxEly+SQK7C84w3zb5g8pdu?=
 =?us-ascii?Q?TgzTM/gFSOf5vhOfKH5mun/KC/QVe1pobNUfvgoH9ngM+tT3slqPv3CTOJfU?=
 =?us-ascii?Q?2R8GrWXtyvcaRzgUe7M+wSAXqRgxifrkkoRPb+WbfYaZ2GX+3Cb1FMQxX9Im?=
 =?us-ascii?Q?c2rEIZCGPnG9GzrH1CqpUiswwmT9qiroGY7lDfgVCE6G5OjJq8CwOrr383lq?=
 =?us-ascii?Q?EUquWeTlufdP3dRAvZ5Cvg8bQGqEmPQaQgu7DZhPh70zyz7hJMI2Y4I7apq0?=
 =?us-ascii?Q?s7DNWgRVawWTxxU1WayLhNOa/111bFvK/sMhBsIRemZOz5t/7jJ0ALdAa5a3?=
 =?us-ascii?Q?uomGyWOMAOkyYD24vqJkXGLYUNyhsjQbpYN7ycyvJhyyTqHhwNPRd/3un7mk?=
 =?us-ascii?Q?33F0gHOV4BaaMCc/KYFlcz4KnA5P7jVgfGXw6R9HGjNhMutilEiVovWMAgN0?=
 =?us-ascii?Q?i09P5cc+RlnQdLHER7No5Z719bFEF6BxgRtW+SBKlmz4Npzcq6GUg0vGbF69?=
 =?us-ascii?Q?st4FuPaH/8tFxKyiy+Of+kcafKicokPjqXaV0N4eEnYs1R1bpB14WK0KTZqA?=
 =?us-ascii?Q?YPLRXwgsLCeVOR40Y8LysJ7Ne4NADhaZjU1ti7vwYDEDGT3b9iqAzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8j1M+v+iWBgDdsUk4kH25QvrkLcoF1ZP76Gqg/vB7XXoeN1G2Nr+YwkI4gKu?=
 =?us-ascii?Q?XpCZzJnIrLgH4ilqMw3YrA6ICNI3ivKq4mrk2CUhDwzEFh/yQZfhNU+zlWAu?=
 =?us-ascii?Q?DpVNyOWMjqWIa8Eir6UNnPoHDIGdIi8JtesQJsmKG4SCBmfpVxavw25QmfpX?=
 =?us-ascii?Q?qAHXQ4aZ8jPuwrVmQ+jTdHpnd7EW7JvAmHkNI+YLFPOK6Pz4eoEKnr/rIlau?=
 =?us-ascii?Q?JuWoKuURg6T4I0sNyV+GnxTBHis8NSPMRn4b7DxXEGqd4gVBOobkecW2BPYt?=
 =?us-ascii?Q?skmQsJWUJf49Q2/i3lXU+ZMKT5XIjljMlAq3G/uahnT+lY7cF5R8X/Qo7c5U?=
 =?us-ascii?Q?AnoggYv6ZGpRCdKuVatfoorQKWWy26dWuwxzeJiygP1hBJdoztYHj6S1ERW+?=
 =?us-ascii?Q?yAw5leu6+9Jnbt5766NicOr4LszDUfhtqLQRARn0TH+4MeKBZwYxsslHlUEs?=
 =?us-ascii?Q?2c5nSH2892g3OM19mNyNYaX5oBZEOPIXs+bVlOC625AQA3/qIs1eBcoRcPox?=
 =?us-ascii?Q?JjNsbcKFOFTw2DAs0Vk1W6LwpmHKyiH7+vGXjVQoDsldw6blCa4zfzEsGXoF?=
 =?us-ascii?Q?+HTso66l7dj5M2lsoYKpZoJNO4iuQlIWXBFhhtu9UKoZ1FUa5h1f4bkqgeyT?=
 =?us-ascii?Q?Bc6DrAHxPi+sdgRJ2Y/fISWie7BQS5gvExYFe1qJLxNoyEQeiGHi4xRyuHB9?=
 =?us-ascii?Q?q1qHsrBQwWKbIVhXMiBPUvcPpMbHYdtObngSCoSWBp+gnYN5xm/tBjF6SCfX?=
 =?us-ascii?Q?XnfdeoGU4Xi7nJ2qaw/hY6zqsEznbFvh4wFNuK2q3DdcFX/Y+hBkb9GRyhOp?=
 =?us-ascii?Q?YVbsCHVg5N1ib08Nkn2ti1QP2kUkTtex5op2FzEa32PL8aIiPpSFmdh/f5CF?=
 =?us-ascii?Q?D0T1R7LA1tiogaxpNVAFzen9c6euRqT0wdZoDj302GjXkug3zgcBLO3e/GTy?=
 =?us-ascii?Q?LR387uhm2Nev7VXOa3094NGO3jJZ86Tte6TqD3wy095RQKNXfD5zLTN/VAIU?=
 =?us-ascii?Q?uPqg98pg9plRwiLOL303pON0UlpOyOxFIyffetg6tlzG/Zaxg8kJIEdDRL/A?=
 =?us-ascii?Q?MhCvDCaecZSU4ga9VLKErpvbP3COUoWPqI1s7sq1i4NR3cer7EaCDQtcLLib?=
 =?us-ascii?Q?VkgXV8rfa/ObU7AE+ed6/Hk6ZtvzsIeNylUI24zXVS/wzsVdI0RJoxtKo/2X?=
 =?us-ascii?Q?+fS7T6Etp180rpZi0Vsu+6U1iBdd1LUNZx9rMYt+cFvBKqL/XcGTuZF+5sMy?=
 =?us-ascii?Q?oG29dTSPLS4Qd6o2C3gS7ypWwquVcRVAstOExzLOtUxuHVWh2CuR0TpMQCEr?=
 =?us-ascii?Q?bhCitPRlRpNgK25wHHYtFXp37kqxZNGZQocH4lTMIybiBDlCnKCPXZAVSenE?=
 =?us-ascii?Q?9vdE348LFA1j8hN6H0IFCLYyiPsTEtT9W4QpZmKSANTtaC1zcZ7ZENlfyp4V?=
 =?us-ascii?Q?YWAkQ1DiXbwlwlxej3jo6dIAWuWRcfhkbz/fReihWW37mMhL/uIt2y8juOet?=
 =?us-ascii?Q?XHDAtH7TjzZ8YJxPMVjiDMiDzCAfLbanNio4TuyTFCZJWf2DxGPniaoW8LdC?=
 =?us-ascii?Q?++McDCxgmzq/KD3j0I51po+OuospqdbixW15++Fn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a52301d-28fe-452c-2a2b-08ddc82030c0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:31:14.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwmRdRmkttKgFic21nCcbJ6DMcZDOgYj2LCM3pLO6JHm4qvZAznEXMYjHy/RC1xmslXqU87aqfOI8fggzHjc7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967

File 802.11h is used to support 802.11h features (DFS and TPC).

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11h.c | 346 +++++++++++++++++++++++++
 1 file changed, 346 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/11h.c b/drivers/net/wireless/nxp/nxpwifi/11h.c
new file mode 100644
index 000000000000..0e077a3ff06c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11h.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11h
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "main.h"
+#include "cmdevt.h"
+#include "fw.h"
+#include "cfg80211.h"
+
+void nxpwifi_init_11h_params(struct nxpwifi_private *priv)
+{
+	priv->state_11h.is_11h_enabled = true;
+	priv->state_11h.is_11h_active = false;
+}
+
+inline int nxpwifi_is_11h_active(struct nxpwifi_private *priv)
+{
+	return priv->state_11h.is_11h_active;
+}
+
+/* This function appends 11h info to a buffer while joining an
+ * infrastructure BSS
+ */
+static void
+nxpwifi_11h_process_infra_join(struct nxpwifi_private *priv, u8 **buffer,
+			       struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_header *ie_header;
+	struct nxpwifi_ie_types_pwr_capability *cap;
+	struct nxpwifi_ie_types_local_pwr_constraint *constraint;
+	struct ieee80211_supported_band *sband;
+	u8 radio_type;
+	int i;
+
+	if (!buffer || !(*buffer))
+		return;
+
+	radio_type = nxpwifi_band_to_radio_type((u8)bss_desc->bss_band);
+	sband = priv->wdev.wiphy->bands[radio_type];
+
+	cap = (struct nxpwifi_ie_types_pwr_capability *)*buffer;
+	cap->header.type = cpu_to_le16(WLAN_EID_PWR_CAPABILITY);
+	cap->header.len = cpu_to_le16(2);
+	cap->min_pwr = 0;
+	cap->max_pwr = 0;
+	*buffer += sizeof(*cap);
+
+	constraint = (struct nxpwifi_ie_types_local_pwr_constraint *)*buffer;
+	constraint->header.type = cpu_to_le16(WLAN_EID_PWR_CONSTRAINT);
+	constraint->header.len = cpu_to_le16(2);
+	constraint->chan = bss_desc->channel;
+	constraint->constraint = bss_desc->local_constraint;
+	*buffer += sizeof(*constraint);
+
+	ie_header = (struct nxpwifi_ie_types_header *)*buffer;
+	ie_header->type = cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+	ie_header->len  = cpu_to_le16(2 * sband->n_channels + 2);
+	*buffer += sizeof(*ie_header);
+	*(*buffer)++ = WLAN_EID_SUPPORTED_CHANNELS;
+	*(*buffer)++ = 2 * sband->n_channels;
+	for (i = 0; i < sband->n_channels; i++) {
+		u32 center_freq;
+
+		center_freq = sband->channels[i].center_freq;
+		*(*buffer)++ = ieee80211_frequency_to_channel(center_freq);
+		*(*buffer)++ = 1; /* one channel in the subband */
+	}
+}
+
+/* Enable or disable the 11h extensions in the firmware */
+int nxpwifi_11h_activate(struct nxpwifi_private *priv, bool flag)
+{
+	u32 enable = flag;
+
+	/* enable master mode radar detection on AP interface */
+	if ((GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) && enable)
+		enable |= NXPWIFI_MASTER_RADAR_DET_MASK;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_802_11_SNMP_MIB,
+				HOST_ACT_GEN_SET, DOT11H_I, &enable, true);
+}
+
+/* This functions processes TLV buffer for a pending BSS Join command.
+ *
+ * Activate 11h functionality in the firmware if the spectrum management
+ * capability bit is found in the network we are joining. Also, necessary
+ * TLVs are set based on requested network's 11h capability.
+ */
+void nxpwifi_11h_process_join(struct nxpwifi_private *priv, u8 **buffer,
+			      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (bss_desc->sensed_11h) {
+		/* Activate 11h functions in firmware, turns on capability
+		 * bit
+		 */
+		nxpwifi_11h_activate(priv, true);
+		priv->state_11h.is_11h_active = true;
+		bss_desc->cap_info_bitmap |= WLAN_CAPABILITY_SPECTRUM_MGMT;
+		nxpwifi_11h_process_infra_join(priv, buffer, bss_desc);
+	} else {
+		/* Deactivate 11h functions in the firmware */
+		nxpwifi_11h_activate(priv, false);
+		priv->state_11h.is_11h_active = false;
+		bss_desc->cap_info_bitmap &= ~WLAN_CAPABILITY_SPECTRUM_MGMT;
+	}
+}
+
+/* This is DFS CAC work function.
+ * This delayed work emits CAC finished event for cfg80211 if
+ * CAC was started earlier.
+ */
+void nxpwifi_dfs_cac_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_chan_def chandef;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_cac_work);
+
+	chandef = priv->dfs_chandef;
+	if (priv->wdev.cac_started) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "CAC timer finished; No radar detected\n");
+		cfg80211_cac_event(priv->netdev, &chandef,
+				   NL80211_RADAR_CAC_FINISHED,
+				   GFP_KERNEL);
+	}
+}
+
+/* This function prepares channel report request command to FW for
+ * starting radar detection.
+ */
+int nxpwifi_cmd_issue_chan_report_request(struct nxpwifi_private *priv,
+					  struct host_cmd_ds_command *cmd,
+					  void *data_buf)
+{
+	struct host_cmd_ds_chan_rpt_req *cr_req = &cmd->params.chan_rpt_req;
+	struct nxpwifi_radar_params *radar_params = (void *)data_buf;
+	u16 size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_CHAN_REPORT_REQUEST);
+	size = S_DS_GEN;
+
+	cr_req->chan_desc.start_freq = cpu_to_le16(NXPWIFI_A_BAND_START_FREQ);
+	nxpwifi_convert_chan_to_band_cfg(priv,
+					 &cr_req->chan_desc.band_cfg,
+					 radar_params->chandef);
+	cr_req->chan_desc.chan_num = radar_params->chandef->chan->hw_value;
+	cr_req->msec_dwell_time = cpu_to_le32(radar_params->cac_time_ms);
+	size += sizeof(*cr_req);
+
+	if (radar_params->cac_time_ms) {
+		struct nxpwifi_ie_types_chan_rpt_data *rpt;
+
+		rpt = (struct nxpwifi_ie_types_chan_rpt_data *)((u8 *)cmd + size);
+		rpt->header.type = cpu_to_le16(TLV_TYPE_CHANRPT_11H_BASIC);
+		rpt->header.len = cpu_to_le16(sizeof(u8));
+		rpt->meas_rpt_map = 1 << MEAS_RPT_MAP_RADAR_SHIFT_BIT;
+		size += sizeof(*rpt);
+
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "11h: issuing DFS Radar check for channel=%d\n",
+			    radar_params->chandef->chan->hw_value);
+	} else {
+		nxpwifi_dbg(priv->adapter, MSG, "cancelling CAC\n");
+	}
+
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
+int nxpwifi_stop_radar_detection(struct nxpwifi_private *priv,
+				 struct cfg80211_chan_def *chandef)
+{
+	struct nxpwifi_radar_params radar_params;
+
+	memset(&radar_params, 0, sizeof(struct nxpwifi_radar_params));
+	radar_params.chandef = chandef;
+	radar_params.cac_time_ms = 0;
+
+	return nxpwifi_send_cmd(priv, HOST_CMD_CHAN_REPORT_REQUEST,
+				HOST_ACT_GEN_SET, 0, &radar_params, true);
+}
+
+/* This function is to abort ongoing CAC upon stopping AP operations
+ * or during unload.
+ */
+void nxpwifi_abort_cac(struct nxpwifi_private *priv)
+{
+	if (priv->wdev.cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "failed to stop CAC in FW\n");
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "Aborting delayed work for CAC.\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+	}
+}
+
+/* This function handles channel report event from FW during CAC period.
+ * If radar is detected during CAC, driver indicates the same to cfg80211
+ * and also cancels ongoing delayed work.
+ */
+int nxpwifi_11h_handle_chanrpt_ready(struct nxpwifi_private *priv,
+				     struct sk_buff *skb)
+{
+	struct host_cmd_ds_chan_rpt_event *rpt_event;
+	struct nxpwifi_ie_types_chan_rpt_data *rpt;
+	u16 event_len, tlv_len;
+
+	rpt_event = (void *)(skb->data + sizeof(u32));
+	event_len = skb->len - (sizeof(struct host_cmd_ds_chan_rpt_event) +
+				sizeof(u32));
+
+	if (le32_to_cpu(rpt_event->result) != HOST_RESULT_OK) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Error in channel report event\n");
+		return -EINVAL;
+	}
+
+	while (event_len >= sizeof(struct nxpwifi_ie_types_header)) {
+		rpt = (void *)&rpt_event->tlvbuf;
+		tlv_len = le16_to_cpu(rpt->header.len);
+
+		switch (le16_to_cpu(rpt->header.type)) {
+		case TLV_TYPE_CHANRPT_11H_BASIC:
+			if (rpt->meas_rpt_map & MEAS_RPT_MAP_RADAR_MASK) {
+				nxpwifi_dbg(priv->adapter, MSG,
+					    "RADAR Detected on channel %d!\n",
+					    priv->dfs_chandef.chan->hw_value);
+
+				wiphy_delayed_work_cancel(priv->adapter->wiphy,
+							  &priv->dfs_cac_work);
+				cfg80211_cac_event(priv->netdev,
+						   &priv->dfs_chandef,
+						   NL80211_RADAR_CAC_ABORTED,
+						   GFP_KERNEL);
+				cfg80211_radar_event(priv->adapter->wiphy,
+						     &priv->dfs_chandef,
+						     GFP_KERNEL);
+			}
+			break;
+		default:
+			break;
+		}
+
+		event_len -= (tlv_len + sizeof(rpt->header));
+	}
+
+	return 0;
+}
+
+/* Handler for radar detected event from FW.*/
+int nxpwifi_11h_handle_radar_detected(struct nxpwifi_private *priv,
+				      struct sk_buff *skb)
+{
+	struct nxpwifi_radar_det_event *rdr_event;
+
+	rdr_event = (void *)(skb->data + sizeof(u32));
+
+	nxpwifi_dbg(priv->adapter, MSG,
+		    "radar detected; indicating kernel\n");
+	if (priv->wdev.cac_started) {
+		if (nxpwifi_stop_radar_detection(priv, &priv->dfs_chandef))
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "Failed to stop CAC in FW\n");
+		wiphy_delayed_work_cancel(priv->adapter->wiphy, &priv->dfs_cac_work);
+		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+	}
+	cfg80211_radar_event(priv->adapter->wiphy, &priv->dfs_chandef,
+			     GFP_KERNEL);
+	nxpwifi_dbg(priv->adapter, MSG, "regdomain: %d\n",
+		    rdr_event->reg_domain);
+	nxpwifi_dbg(priv->adapter, MSG, "radar detection type: %d\n",
+		    rdr_event->det_type);
+
+	return 0;
+}
+
+/* This is work function for channel switch handling.
+ * This function takes care of updating new channel definitin to
+ * bss config structure, restart AP and indicate channel switch success
+ * to cfg80211.
+ */
+void nxpwifi_dfs_chan_sw_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct nxpwifi_uap_bss_param *bss_cfg;
+	struct wiphy_delayed_work *delayed_work =
+		container_of(work, struct wiphy_delayed_work, work);
+	struct nxpwifi_private *priv = container_of(delayed_work,
+						    struct nxpwifi_private,
+						    dfs_chan_sw_work);
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	if (nxpwifi_del_mgmt_ies(priv))
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "Failed to delete mgmt IEs!\n");
+
+	bss_cfg = &priv->bss_cfg;
+	if (!bss_cfg->beacon_period) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: AP already stopped\n");
+		return;
+	}
+
+	if (nxpwifi_send_cmd(priv, HOST_CMD_UAP_BSS_STOP,
+			     HOST_ACT_GEN_SET, 0, NULL, true)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to stop the BSS\n");
+		return;
+	}
+
+	if (nxpwifi_cfg80211_change_beacon(adapter->wiphy, priv->netdev,
+					   &priv->beacon_after)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "channel switch: Failed to set beacon\n");
+		return;
+	}
+
+	nxpwifi_uap_set_channel(priv, bss_cfg, priv->dfs_chandef);
+
+	if (nxpwifi_config_start_uap(priv, bss_cfg)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Failed to start AP after channel switch\n");
+		return;
+	}
+
+	nxpwifi_dbg(adapter, MSG,
+		    "indicating channel switch completion to kernel\n");
+
+	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0, 0);
+
+	if (priv->uap_stop_tx) {
+		netif_carrier_on(priv->netdev);
+		nxpwifi_wake_up_net_dev_queue(priv->netdev, adapter);
+		priv->uap_stop_tx = false;
+	}
+}
-- 
2.34.1


