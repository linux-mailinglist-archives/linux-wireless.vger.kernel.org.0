Return-Path: <linux-wireless+bounces-26136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340DBB1A661
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B4E162CCC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11F2749C9;
	Mon,  4 Aug 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bw1wjtKv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632626CE2A;
	Mon,  4 Aug 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322366; cv=fail; b=OHP89MsguipANwcb/awGdD6EYrO368kkpgX6CqRWdsIBYfzt1VLYiiREWHHKejx6cNxXgo/7kyEtu14cFAX6Kzf/kjKdGi6pEo6PtTIWwJ7fZNnK6V10iJjrajumrVQGwPmTw/Zhmzwb1UyW5kiBBOaqF2O3cgQ7EYq/h28Auvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322366; c=relaxed/simple;
	bh=6rSUBXvNLFnsRfPaWgFLj0r3btQpCncV6lMauYUKvww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdHqGPDhopjyhCQyLRv+Aib4Bjj1kVFWE7bzHo9FegbyyuJONhNogu9hHdHUL4RlPClPkzzHgV5TGcp0eclpfBsLmMtO71VOEpbZV17GUD19xABxJO2okrK+eM7uqh7S9Ja0TqABGeu9FUOzSqOTm/UzkLyVhW5mjwszcvKUZ8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bw1wjtKv; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjX2dnZW5HFABbOVQbRoHmx992KQxaO+Z07RGyjJjXDjeqPzPZtIbOolrewvWP9bXUlGJnwvs/olshT9K4qlp4V7EHHNqW+Io3Ct0Rx55OtU2eEVRSrKKLG2S1KXBHAiRYc+N5LnaAkfIyjf/9rA9/zVD93BbVOb3AD7wT8Orp+GIajmTYoS2wyUIE0feJJ+wCWTF+T7e/PPC8OWNvQa152MMh91CO9yDI6n0OpjVBCvwUSma+Ifp0+kWFGZSGPby0J+9OJfQFjEditH8NBsG7r7vygxC8zhUTag9jrNjUG2Jt8FMCmLcNjSNEul8PrzHZ+vkAPyycgp8y9zHT4dCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnfX4uLMOn/c+WDrrywXalJIOPtag9icdLkSm+WoqQU=;
 b=hZAZkycC+1APkbPEtz8rFT0FYz31stJQkLxRGgXNieHWpWNq5JJcjcYIcHPAfRJ0A+CUcG245MWRPPrWZMfNq7yd/6zBtIcxpGnhHQX7TjQLrG1PUCRzrME1cf/GMxtYJ6h5EZK/l1qYQ4JE8Fxs/NTQBZBt7o+5luNH+fbA+IaZPADVEtJbr9Kv5I9OAn2lw4ed9T188cmNenH5Kw5VBhby1o9cZ9PLy+GxoaW1Q4elMJy0EIxwTnHDJAXi7FNQwJ2MLFR0Ny+04rFS1xkRMx7luD/wVhUEAN0V9UK4I/tPKXnvzBsxhyG8srRPaieeLyDrwuT9Ypxb+MlbP6NC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnfX4uLMOn/c+WDrrywXalJIOPtag9icdLkSm+WoqQU=;
 b=bw1wjtKvT7ukaALjC7hBifLqFXUfJnbaOlYiU1etAXvxOXo1lOOrbUzi/EzD9mSfJ3x1UreCUm9Sddj+2COACnswnf3VDO/NpGhdCYSYGsBxKzYLihdwsD1FH9fumvBI7u6AzjI5cEhm+hUDfWjbTSUcYC+GwMM+mUSr6y+izBxQSID+8jurDJGH42rOtGENgVCcpD7OcAOjFrn+NUbQp5OpkxGBNG98Mvt0+DAScSXKho2Y07KiOb9gpxqIqLgkzVa8fNygk4ln7Gsqo7aSLYsk4td283V/5lBd3wQy4noWZyu2s0R22aII+wS6KXQxodaHNbp/+Lnw2q6JCTOqag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:45:59 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:45:59 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	brian.hsu@nxp.com,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v5 06/22] wifi: nxpwifi: add scan.c
Date: Mon,  4 Aug 2025 23:40:02 +0800
Message-Id: <20250804154018.3563834-7-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c4a290-d777-4a12-36ef-08ddd36e01f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IUiXop/EKelz58yzqa8dAMwdpVWrUfLBPAVb8HiJRYt3YqiPF6zfKai+NYN3?=
 =?us-ascii?Q?1BNAY0Zyik6w4Ft3nH3VAp2hOQltuFrlmJaMy9XLkGgNA8c4sfN8DJOVbpZV?=
 =?us-ascii?Q?TJGWc3uKD3DZtL4FQ5HWZCJKYyYcQ/+bhZkLQjb9+Tch2pehH66KAlcf3EpR?=
 =?us-ascii?Q?DgPWNumw5iEdhZajztWrIN5UNF7iGMcgBd6K+MikkWPu3qDE2PivITwGy3jJ?=
 =?us-ascii?Q?gimteJcMsEyqfB5On/Db3pvcnte8t/Fq5gDcFnEW95fZgEwkXwFpAQAF/Ah/?=
 =?us-ascii?Q?Jgj37psnrEucKD1g2+x0ez7javlv9WiqFnhtMzGy2WUm3lFrUf92WcpvM65L?=
 =?us-ascii?Q?XjFMz9S4V0rHQixzqCQv+34pa5J0xkZ0cpJyjHkufMhnn8zrrCyECQ9LVXOI?=
 =?us-ascii?Q?0DIJ0Du8h6EBIlrN3ze7/PmRcJHT/hVraDb2k4R12oZ1ySxy45Riqy+ND3sZ?=
 =?us-ascii?Q?TJQiCPdbpaS4uZAvgSHixELXRhIdmFVEMJZxx27Zyr0t7o2mlE7830meer9o?=
 =?us-ascii?Q?nkyQX3G/U/81gW/ScODPiXz2XKdCqU5bXt1+vC5eBQBnZAJ15bsihPlH12Kk?=
 =?us-ascii?Q?PXtH7uKU7yEZoDjr+vCm+R2ncYwMJjPl13dFItf8m/suy5BWpnHbXgQbDZb/?=
 =?us-ascii?Q?35QHPz17rjlzXKo4p0gPc/kmZAkhW+Q6UFDaWycAgNWEX8bPlxpD53IJ/5tR?=
 =?us-ascii?Q?e+4opg3IwFit5YwrOiWtMKZ63oxRan/eto3KlwcV6yrqQEE71zaG08YLGe2e?=
 =?us-ascii?Q?+YyqMSZtCT5+/W+0Fn5h8snyK8P5+PrIIRbn0TfLKUlht+xabKdX1/BSFxqC?=
 =?us-ascii?Q?Tcpej/H/Ao7D2TtguAoVqdrk4aEiGYujNLtR1Ny8FkA/azfFvxkQbhxlIpjV?=
 =?us-ascii?Q?CNmEEA2pDAlXXhsyxMzZ+U+e+Btzz4hEpsUM9RehpVWKqiHGhEIFKlEMdHcf?=
 =?us-ascii?Q?PJmS2AbJtrphlrGft3rgc/Ua+GSx4iVYtZSfBqexdQWCC4lYlKQep6wwQOsQ?=
 =?us-ascii?Q?GzL2wtVZygOYoxCmiE/cRhV0vkULcQB5QoEAYrMK2NEIwLl8jVyCynGZO+B2?=
 =?us-ascii?Q?Nzehpig/fk5HBslld88l+Qy6baqBaf4lJAvBkJZKGTNmocElF4tgzKKIZUGo?=
 =?us-ascii?Q?aIx/ANamIyya131oVJIK2v2FIM/SUKbFR+tQbWidYsTX7qZL4VHN7eE1NK4C?=
 =?us-ascii?Q?vb+9h+XmVsZqd164Bs+RPpDelhfx7YLmMEBnWu3d4HYJNRMb2vvvOmoBf0rA?=
 =?us-ascii?Q?2orYLEWMlKOez59F/IK6F7CDBu/ZCCWALRXO7bD9u94JZAiLDJKbHSgzBadD?=
 =?us-ascii?Q?z639nxo/SFzbqwtLlB5vaPJLxZMhVajWiQKQvX2ElJMoaktR+iJMA35iRDw0?=
 =?us-ascii?Q?0j35/+E7Oh51aZblbi+00As8M97QYNIjjxb7ztN+lSvOcB3231EhZE+3/7OC?=
 =?us-ascii?Q?mheg500l3k1h7BvDTOEe76ZYKIcpdRXjwehkTAQJD/fZRfhb4Rk9Bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C3N41PkgynayR7zlrc4U7ER40n+MSrpUsYlO0vFg5wK8T+BeThmr8EI3dksY?=
 =?us-ascii?Q?eBQ5w0LzU/Wqv0npoqm75aEY+z2CSJVyB6bKy2hqmPyl6nhkVMB7aNk0lAwV?=
 =?us-ascii?Q?kY3TIPxEFY/BiuklZ+LSxAlbsDQ7kp3YkcupCzasJfITFvfMk5iRiDAwrkjs?=
 =?us-ascii?Q?nKJSRarbhUjFwb2EAXpHOLIliONbwGvg6OMCKye6+IHRJqEsWRakgOcX0KQQ?=
 =?us-ascii?Q?x3l2v6O+mxcj6HWRuKqS5X+B42pz9zWK46b8NNYPxNCESRQjHHxGF3u8csRZ?=
 =?us-ascii?Q?H/ZEn7Lvpej9/FN18J22Q3y5HNeW2IjAzmmD9myY5SjE5Zku+fMDi3U3PkXn?=
 =?us-ascii?Q?6g2AUvQb6rQJKBjsJQXyoJ9tnRbD46+vR4Vr+b5eJwjKgi7mEzwOR89PSEQb?=
 =?us-ascii?Q?s6aNk74Djj1P+UWtFQVahn7dM0LPp05MsNm2cE31uAmJdqiDCUJVF6nO0ic2?=
 =?us-ascii?Q?X6PN+4WVfkaHrsMBMT6epHKULhjTZWXuUq6S5J53Z2p8iwyxtbgtA+ynRfJC?=
 =?us-ascii?Q?WMfURluYfvMGdLJouLj8Q/oHIqoIrFmFI/GcXCIdzFiCS8ycEmg50mVTvMIk?=
 =?us-ascii?Q?nH32jTC9AmMS+dsKzHwWr6WU8f78spnP0UN0e3AF9uEEd0XmG0IyfIoZVVn9?=
 =?us-ascii?Q?Wl6qh48SSORN4f3hnibqh79WUld6hdCqQ3r4e/tsRk+tF6k08G655mvaxEj/?=
 =?us-ascii?Q?HYcZzxt1GhSkcXqMU0CXhjWurmlGpO2k/vkPHFxGfnQFP7F4giQHHEzlr+bi?=
 =?us-ascii?Q?jSK8/8GM6wfzIhgXeBVYj7QqF4jkPvjpl9IltN3Ylh8LThUvOEDJAn0cO2NE?=
 =?us-ascii?Q?idUDZCWU5ObnCQ0JPFoAxKAfA4RlfLWyVfuLRgHQRxeIft59ctyURh1Zui8D?=
 =?us-ascii?Q?oKTPGBqZL03zLlkUMMq7qQeYyI7Fa9hfBn7MbCoxD0ABGP1Mi9p+fL4FHk9A?=
 =?us-ascii?Q?hT3du9lFEEUjpoh29I97yXZ9pEA4wjiiTJ6l4JUJnP/bs847OiKXT4c1rYoA?=
 =?us-ascii?Q?g0gCvQIoOWQ2FBwyJ9KIeay+gFDJoJq3Irg7yaO3RxujPVeotFqzNth5tN7f?=
 =?us-ascii?Q?Tx6inNxcR7RdbxyarI6R4FXaMNyEq0nx8f10ePnX/kZNUpVuNSibrxRQa+h7?=
 =?us-ascii?Q?mQ2KbTIK84yNuL/PsjZ3/qe5S4d+yMDRR6zb8fYx51WYeUY0/WH/kFCZoLv1?=
 =?us-ascii?Q?UvK+KEg5yNS0Nd6SKeyaIruafhvTQSqxD0jv+L6jkQF7t9l0gK3RIqppIoVw?=
 =?us-ascii?Q?ub25VpUAcvV/VgPRPpqiRGy+IUZrXgN6iQuHIWsDChnXVPgG05TNDJL4Zdgq?=
 =?us-ascii?Q?+/O3XCdErq64tAojSEfbU7vD3WaZeU7I88gbj7/75iTFZgmv7Vcasa1NQzwT?=
 =?us-ascii?Q?WLXyM7itwjyOSaFfqeP7WjjPcT38Im5ioXVvTiYM2Cay7/Nkohck63RXYHaV?=
 =?us-ascii?Q?y2JVObJ3ZhsYv/KOx0/vBHQYAPM9o9LqUixpj/R3C6LxURqP2lH0hErpXrHY?=
 =?us-ascii?Q?l1Uvnt9OgkhTKm0uh6UJ7n5LlR/sfoP7EH1h++NHHaQlP9Y6z5eIKBUUtAed?=
 =?us-ascii?Q?aM/+/U2JoneaVIKSOQwEK/xzipliyr/9DtK7Kjsz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c4a290-d777-4a12-36ef-08ddd36e01f4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:45:59.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg98brkRgKknxOUfqSxAxoJHSKjUytd+FjuhVNas+xr4Y+UoPmsEzDQjoXg0WnjmjRCkkpa/SNB/ti1J+pc6LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

File scan.c is used to support scan process.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/scan.c | 2805 +++++++++++++++++++++++
 1 file changed, 2805 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/scan.c b/drivers/net/wireless/nxp/nxpwifi/scan.c
new file mode 100644
index 000000000000..be710cfd1708
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/scan.c
@@ -0,0 +1,2805 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: scan ioctl and command handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cmdevt.h"
+#include "11n.h"
+#include "cfg80211.h"
+
+/* The maximum number of channels the firmware can scan per command */
+#define NXPWIFI_MAX_CHANNELS_PER_SPECIFIC_SCAN   14
+
+#define NXPWIFI_DEF_CHANNELS_PER_SCAN_CMD        4
+
+/* Memory needed to store a max sized Channel List TLV for a firmware scan */
+#define CHAN_TLV_MAX_SIZE  (sizeof(struct nxpwifi_ie_types_header)        \
+			    + (NXPWIFI_MAX_CHANNELS_PER_SPECIFIC_SCAN     \
+			    * sizeof(struct nxpwifi_chan_scan_param_set)))
+
+/* Memory needed to store supported rate */
+#define RATE_TLV_MAX_SIZE   (sizeof(struct nxpwifi_ie_types_rates_param_set) \
+			     + HOSTCMD_SUPPORTED_RATES)
+
+/* Memory needed to store a max number/size WildCard SSID TLV for a firmware
+ * scan
+ */
+#define WILDCARD_SSID_TLV_MAX_SIZE  \
+	(NXPWIFI_MAX_SSID_LIST_LENGTH *					\
+		(sizeof(struct nxpwifi_ie_types_wildcard_ssid_params)	\
+			+ IEEE80211_MAX_SSID_LEN))
+
+/* Maximum memory needed for a nxpwifi_scan_cmd_config with all TLVs at max */
+#define MAX_SCAN_CFG_ALLOC (sizeof(struct nxpwifi_scan_cmd_config)        \
+				+ sizeof(struct nxpwifi_ie_types_num_probes)   \
+				+ sizeof(struct nxpwifi_ie_types_htcap)       \
+				+ CHAN_TLV_MAX_SIZE                 \
+				+ RATE_TLV_MAX_SIZE                 \
+				+ WILDCARD_SSID_TLV_MAX_SIZE)
+
+union nxpwifi_scan_cmd_config_tlv {
+	/* Scan configuration (variable length) */
+	struct nxpwifi_scan_cmd_config config;
+	/* Max allocated block */
+	u8 config_alloc_buf[MAX_SCAN_CFG_ALLOC];
+};
+
+#define NXPWIFI_WPA_CIPHER_SUITE_TKIP		SUITE(WLAN_OUI_MICROSOFT, 2)
+#define NXPWIFI_WPA_CIPHER_SUITE_CCMP		SUITE(WLAN_OUI_MICROSOFT, 4)
+
+static void
+_dbg_security_flags(int log_level, const char *func, const char *desc,
+		    struct nxpwifi_private *priv,
+		    struct nxpwifi_bssdescriptor *bss_desc)
+{
+	_nxpwifi_dbg(priv->adapter, log_level,
+		     "info: %s: %s:\twpa_ie=%#x wpa2_ie=%#x WEP=%s WPA=%s WPA2=%s\tEncMode=%#x privacy=%#x\n",
+		     func, desc,
+		     bss_desc->bcn_wpa_ie ?
+		     bss_desc->bcn_wpa_ie->vend_hdr.element_id : 0,
+		     bss_desc->bcn_rsn_ie ?
+		     bss_desc->bcn_rsn_ie->id : 0,
+		     priv->sec_info.wep_enabled ? "e" : "d",
+		     priv->sec_info.wpa_enabled ? "e" : "d",
+		     priv->sec_info.wpa2_enabled ? "e" : "d",
+		     priv->sec_info.encryption_mode,
+		     bss_desc->privacy);
+}
+
+#define dbg_security_flags(mask, desc, priv, bss_desc) \
+	_dbg_security_flags(NXPWIFI_DBG_##mask, __func__, desc, priv, bss_desc)
+
+/* This function parses a given IE for a given OUI.
+ *
+ * This is used to parse a WPA/RSN IE to find if it has
+ * a given oui in PTK.
+ */
+static u8
+nxpwifi_search_oui_in_ie(struct ie_body *iebody, u8 *oui)
+{
+	u8 count;
+
+	count = iebody->ptk_cnt[0];
+
+	/* There could be multiple OUIs for PTK hence
+	 * 1) Take the length.
+	 * 2) Check all the OUIs for AES.
+	 * 3) If one of them is AES then pass success.
+	 */
+	while (count) {
+		if (!memcmp(iebody->ptk_body, oui, sizeof(iebody->ptk_body)))
+			return NXPWIFI_OUI_PRESENT;
+
+		--count;
+		if (count)
+			iebody = (struct ie_body *)((u8 *)iebody +
+						sizeof(iebody->ptk_body));
+	}
+
+	pr_debug("info: %s: OUI is not found in PTK\n", __func__);
+	return NXPWIFI_OUI_NOT_PRESENT;
+}
+
+/* This function checks if a given OUI is present in a RSN IE.
+ *
+ * The function first checks if a RSN IE is present or not in the
+ * BSS descriptor. It tries to locate the OUI only if such an IE is
+ * present.
+ */
+static u8
+nxpwifi_is_rsn_oui_present(struct nxpwifi_bssdescriptor *bss_desc, u32 cipher)
+{
+	struct ie_body *iebody;
+	u8 ret = NXPWIFI_OUI_NOT_PRESENT;
+	u32 oui = cpu_to_be32(cipher);
+
+	if (bss_desc->bcn_rsn_ie) {
+		iebody = (struct ie_body *)
+			 (((u8 *)bss_desc->bcn_rsn_ie->data) +
+			  RSN_GTK_OUI_OFFSET);
+		ret = nxpwifi_search_oui_in_ie(iebody, (u8 *)&oui);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+/* This function checks if a given OUI is present in a WPA IE.
+ *
+ * The function first checks if a WPA IE is present or not in the
+ * BSS descriptor. It tries to locate the OUI only if such an IE is
+ * present.
+ */
+static u8
+nxpwifi_is_wpa_oui_present(struct nxpwifi_bssdescriptor *bss_desc, u32 cipher)
+{
+	struct ie_body *iebody;
+	u8 ret = NXPWIFI_OUI_NOT_PRESENT;
+	u32 oui = cpu_to_be32(cipher);
+
+	if (bss_desc->bcn_wpa_ie) {
+		iebody = (struct ie_body *)((u8 *)bss_desc->bcn_wpa_ie->data +
+					    WPA_GTK_OUI_OFFSET);
+		ret = nxpwifi_search_oui_in_ie(iebody, (u8 *)&oui);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+/* This function checks if driver is configured with no security mode and
+ * scanned network is compatible with it.
+ */
+static bool
+nxpwifi_is_bss_no_sec(struct nxpwifi_private *priv,
+		      struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (!priv->sec_info.wep_enabled && !priv->sec_info.wpa_enabled &&
+	    !priv->sec_info.wpa2_enabled &&
+	    !bss_desc->bcn_rsn_ie &&
+	    !bss_desc->bcn_wpa_ie &&
+	    !priv->sec_info.encryption_mode && !bss_desc->privacy) {
+		return true;
+	}
+	return false;
+}
+
+/* This function checks if static WEP is enabled in driver and scanned network
+ * is compatible with it.
+ */
+static bool
+nxpwifi_is_bss_static_wep(struct nxpwifi_private *priv,
+			  struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (priv->sec_info.wep_enabled && !priv->sec_info.wpa_enabled &&
+	    !priv->sec_info.wpa2_enabled && bss_desc->privacy) {
+		return true;
+	}
+	return false;
+}
+
+/* This function checks if wpa is enabled in driver and scanned network is
+ * compatible with it.
+ */
+static bool
+nxpwifi_is_bss_wpa(struct nxpwifi_private *priv,
+		   struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (!priv->sec_info.wep_enabled && priv->sec_info.wpa_enabled &&
+	    !priv->sec_info.wpa2_enabled &&
+	    bss_desc->bcn_wpa_ie) {
+		dbg_security_flags(INFO, "WPA", priv, bss_desc);
+		return true;
+	}
+	return false;
+}
+
+/* This function checks if wpa2 is enabled in driver and scanned network is
+ * compatible with it.
+ */
+static bool
+nxpwifi_is_bss_wpa2(struct nxpwifi_private *priv,
+		    struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (!priv->sec_info.wep_enabled && !priv->sec_info.wpa_enabled &&
+	    priv->sec_info.wpa2_enabled &&
+	    bss_desc->bcn_rsn_ie) {
+		/* Privacy bit may NOT be set in some APs like
+		 * LinkSys WRT54G && bss_desc->privacy
+		 */
+		dbg_security_flags(ERROR, "WPA2", priv, bss_desc);
+		return true;
+	}
+	return false;
+}
+
+/* This function checks if dynamic WEP is enabled in driver and scanned network
+ * is compatible with it.
+ */
+static bool
+nxpwifi_is_bss_dynamic_wep(struct nxpwifi_private *priv,
+			   struct nxpwifi_bssdescriptor *bss_desc)
+{
+	if (!priv->sec_info.wep_enabled && !priv->sec_info.wpa_enabled &&
+	    !priv->sec_info.wpa2_enabled &&
+	    !bss_desc->bcn_wpa_ie &&
+	    !bss_desc->bcn_rsn_ie &&
+	    priv->sec_info.encryption_mode && bss_desc->privacy) {
+		dbg_security_flags(INFO, "dynamic", priv, bss_desc);
+		return true;
+	}
+	return false;
+}
+
+/* This function checks if a scanned network is compatible with the driver
+ * settings.
+ *
+ *   WEP      WPA      WPA2    encrypt                  Network
+ * -enabled -enabled -enabled   mode   Privacy WPA WPA2 Compatible
+ *    0       0       0         NONE      0     0   0   yes No security
+ *    0       1       0          x        1x    1   x   yes WPA (disable
+ *                                                      HT if no AES)
+ *    0       0       1          x        1x    x   1   yes WPA2 (disable
+ *                                                      HT if no AES)
+ *    1       0       0         NONE      1     0   0   yes Static WEP
+ *                                                      (disable HT)
+ *    0       0       0        !=NONE     1     0   0   yes Dynamic WEP
+ *
+ * Compatibility is not matched while roaming, except for mode.
+ */
+static int
+nxpwifi_is_network_compatible(struct nxpwifi_private *priv,
+			      struct nxpwifi_bssdescriptor *bss_desc, u32 mode)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	bss_desc->disable_11n = false;
+
+	/* Don't check for compatibility if roaming */
+	if (priv->media_connected &&
+	    priv->bss_mode == NL80211_IFTYPE_STATION &&
+	    bss_desc->bss_mode == NL80211_IFTYPE_STATION)
+		return 0;
+
+	if (priv->wps.session_enable) {
+		nxpwifi_dbg(adapter, IOCTL,
+			    "info: return success directly in WPS period\n");
+		return 0;
+	}
+
+	if (bss_desc->chan_sw_ie_present) {
+		nxpwifi_dbg(adapter, INFO,
+			    "Don't connect to AP with WLAN_EID_CHANNEL_SWITCH\n");
+		return -EPERM;
+	}
+
+	if (bss_desc->bss_mode == mode) {
+		if (nxpwifi_is_bss_no_sec(priv, bss_desc)) {
+			/* No security */
+			return 0;
+		} else if (nxpwifi_is_bss_static_wep(priv, bss_desc)) {
+			/* Static WEP enabled */
+			nxpwifi_dbg(adapter, INFO,
+				    "info: Disable 11n in WEP mode.\n");
+			bss_desc->disable_11n = true;
+			return 0;
+		} else if (nxpwifi_is_bss_wpa(priv, bss_desc)) {
+			/* WPA enabled */
+			if (((priv->config_bands & BAND_GN ||
+			      priv->config_bands & BAND_AN) &&
+			     bss_desc->bcn_ht_cap) &&
+			    !nxpwifi_is_wpa_oui_present(bss_desc,
+							 NXPWIFI_WPA_CIPHER_SUITE_CCMP)) {
+				if (nxpwifi_is_wpa_oui_present
+						(bss_desc, NXPWIFI_WPA_CIPHER_SUITE_TKIP)) {
+					nxpwifi_dbg(adapter, INFO,
+						    "info: Disable 11n if AES\t"
+						    "is not supported by AP\n");
+					bss_desc->disable_11n = true;
+				} else {
+					return -EINVAL;
+				}
+			}
+			return 0;
+		} else if (nxpwifi_is_bss_wpa2(priv, bss_desc)) {
+			/* WPA2 enabled */
+			if (((priv->config_bands & BAND_GN ||
+			      priv->config_bands & BAND_AN) &&
+			     bss_desc->bcn_ht_cap) &&
+			    !nxpwifi_is_rsn_oui_present(bss_desc,
+							WLAN_CIPHER_SUITE_CCMP)) {
+				if (nxpwifi_is_rsn_oui_present
+						(bss_desc, WLAN_CIPHER_SUITE_TKIP)) {
+					nxpwifi_dbg(adapter, INFO,
+						    "info: Disable 11n if AES\t"
+						    "is not supported by AP\n");
+					bss_desc->disable_11n = true;
+				} else if (nxpwifi_is_rsn_oui_present
+						(bss_desc, WLAN_CIPHER_SUITE_GCMP_256) ||
+						nxpwifi_is_rsn_oui_present
+						(bss_desc, WLAN_CIPHER_SUITE_CCMP_256)) {
+					return 0;
+				} else {
+					return -EINVAL;
+				}
+			}
+			return 0;
+		} else if (nxpwifi_is_bss_dynamic_wep(priv, bss_desc)) {
+			/* Dynamic WEP enabled */
+			return 0;
+		}
+
+		/* Security doesn't match */
+		dbg_security_flags(ERROR, "failed", priv, bss_desc);
+		return -EINVAL;
+	}
+
+	/* Mode doesn't match */
+	return -EINVAL;
+}
+
+/* This function creates a channel list for the driver to scan, based
+ * on region/band information.
+ *
+ * This routine is used for any scan that is not provided with a
+ * specific channel list to scan.
+ */
+static int
+nxpwifi_scan_create_channel_list(struct nxpwifi_private *priv,
+				 const struct nxpwifi_user_scan_cfg
+				 *user_scan_in,
+				 struct nxpwifi_chan_scan_param_set
+				 *scan_chan_list,
+				 u8 filtered_scan)
+{
+	enum nl80211_band band;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int chan_idx = 0, i;
+	u16 scan_time = 0;
+
+	if (user_scan_in)
+		scan_time = (u16)user_scan_in->chan_list[0].scan_time;
+
+	for (band = 0; (band < NUM_NL80211_BANDS) ; band++) {
+		if (!priv->wdev.wiphy->bands[band])
+			continue;
+
+		sband = priv->wdev.wiphy->bands[band];
+
+		for (i = 0; (i < sband->n_channels) ; i++) {
+			ch = &sband->channels[i];
+			if (ch->flags & IEEE80211_CHAN_DISABLED)
+				continue;
+			scan_chan_list[chan_idx].band_cfg = band;
+
+			if (scan_time)
+				scan_chan_list[chan_idx].max_scan_time =
+					cpu_to_le16(scan_time);
+			else if ((ch->flags & IEEE80211_CHAN_NO_IR) ||
+				 (ch->flags & IEEE80211_CHAN_RADAR))
+				scan_chan_list[chan_idx].max_scan_time =
+					cpu_to_le16(adapter->passive_scan_time);
+			else
+				scan_chan_list[chan_idx].max_scan_time =
+					cpu_to_le16(adapter->active_scan_time);
+
+			if (ch->flags & IEEE80211_CHAN_NO_IR)
+				scan_chan_list[chan_idx].chan_scan_mode_bmap |=
+					(NXPWIFI_PASSIVE_SCAN | NXPWIFI_HIDDEN_SSID_REPORT);
+			else
+				scan_chan_list[chan_idx].chan_scan_mode_bmap &=
+					~NXPWIFI_PASSIVE_SCAN;
+
+			scan_chan_list[chan_idx].chan_number = (u32)ch->hw_value;
+			scan_chan_list[chan_idx].chan_scan_mode_bmap |=
+				NXPWIFI_DISABLE_CHAN_FILT;
+
+			if (filtered_scan &&
+			    !((ch->flags & IEEE80211_CHAN_NO_IR) ||
+			      (ch->flags & IEEE80211_CHAN_RADAR)))
+				scan_chan_list[chan_idx].max_scan_time =
+				cpu_to_le16(adapter->specific_scan_time);
+
+			chan_idx++;
+		}
+	}
+	return chan_idx;
+}
+
+/* This function creates a channel list tlv for bgscan config, based
+ * on region/band information.
+ */
+static int
+nxpwifi_bgscan_create_channel_list(struct nxpwifi_private *priv,
+				   const struct nxpwifi_bg_scan_cfg
+				   *bgscan_cfg_in,
+				   struct nxpwifi_chan_scan_param_set
+				   *scan_chan_list)
+{
+	enum nl80211_band band;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int chan_idx = 0, i;
+	u16 scan_time = 0, specific_scan_time = adapter->specific_scan_time;
+
+	if (bgscan_cfg_in)
+		scan_time = (u16)bgscan_cfg_in->chan_list[0].scan_time;
+
+	for (band = 0; (band < NUM_NL80211_BANDS); band++) {
+		if (!priv->wdev.wiphy->bands[band])
+			continue;
+
+		sband = priv->wdev.wiphy->bands[band];
+
+		for (i = 0; (i < sband->n_channels) ; i++) {
+			ch = &sband->channels[i];
+			if (ch->flags & IEEE80211_CHAN_DISABLED)
+				continue;
+			scan_chan_list[chan_idx].band_cfg = band;
+
+			if (scan_time)
+				scan_chan_list[chan_idx].max_scan_time =
+					cpu_to_le16(scan_time);
+			else if (ch->flags & IEEE80211_CHAN_NO_IR)
+				scan_chan_list[chan_idx].max_scan_time =
+					cpu_to_le16(adapter->passive_scan_time);
+			else
+				scan_chan_list[chan_idx].max_scan_time =
+					cpu_to_le16(specific_scan_time);
+
+			if (ch->flags & IEEE80211_CHAN_NO_IR)
+				scan_chan_list[chan_idx].chan_scan_mode_bmap |=
+					NXPWIFI_PASSIVE_SCAN;
+			else
+				scan_chan_list[chan_idx].chan_scan_mode_bmap &=
+					~NXPWIFI_PASSIVE_SCAN;
+
+			scan_chan_list[chan_idx].chan_number = (u32)ch->hw_value;
+			chan_idx++;
+		}
+	}
+	return chan_idx;
+}
+
+/* This function appends rate TLV to scan config command. */
+static int
+nxpwifi_append_rate_tlv(struct nxpwifi_private *priv,
+			struct nxpwifi_scan_cmd_config *scan_cfg_out,
+			u8 radio)
+{
+	struct nxpwifi_ie_types_rates_param_set *rates_tlv;
+	u8 rates[NXPWIFI_SUPPORTED_RATES], *tlv_pos;
+	u32 rates_size;
+
+	memset(rates, 0, sizeof(rates));
+
+	tlv_pos = (u8 *)scan_cfg_out->tlv_buf + scan_cfg_out->tlv_buf_len;
+
+	if (priv->scan_request)
+		rates_size = nxpwifi_get_rates_from_cfg80211(priv, rates,
+							     radio);
+	else
+		rates_size = nxpwifi_get_supported_rates(priv, rates);
+
+	nxpwifi_dbg(priv->adapter, CMD,
+		    "info: SCAN_CMD: Rates size = %d\n",
+		rates_size);
+	rates_tlv = (struct nxpwifi_ie_types_rates_param_set *)tlv_pos;
+	rates_tlv->header.type = cpu_to_le16(WLAN_EID_SUPP_RATES);
+	rates_tlv->header.len = cpu_to_le16((u16)rates_size);
+	memcpy(rates_tlv->rates, rates, rates_size);
+	scan_cfg_out->tlv_buf_len += sizeof(rates_tlv->header) + rates_size;
+
+	return rates_size;
+}
+
+/* This function constructs and sends multiple scan config commands to
+ * the firmware.
+ *
+ * Previous routines in the code flow have created a scan command configuration
+ * with any requested TLVs.  This function splits the channel TLV into maximum
+ * channels supported per scan lists and sends the portion of the channel TLV,
+ * along with the other TLVs, to the firmware.
+ */
+static int
+nxpwifi_scan_channel_list(struct nxpwifi_private *priv,
+			  u32 max_chan_per_scan, u8 filtered_scan,
+			  struct nxpwifi_scan_cmd_config *scan_cfg_out,
+			  struct nxpwifi_ie_types_chan_list_param_set *tlv_o,
+			  struct nxpwifi_chan_scan_param_set *scan_chan_list)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret = 0;
+	struct nxpwifi_chan_scan_param_set *tmp_chan_list;
+	u32 tlv_idx, rates_size, cmd_no;
+	u32 total_scan_time;
+	u32 done_early;
+	u8 radio_type;
+
+	if (!scan_cfg_out || !tlv_o || !scan_chan_list) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "info: Scan: Null detect: %p, %p, %p\n",
+			    scan_cfg_out, tlv_o, scan_chan_list);
+		return -EINVAL;
+	}
+
+	/* Check csa channel expiry before preparing scan list */
+	nxpwifi_11h_get_csa_closed_channel(priv);
+
+	tlv_o->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
+
+	/* Set the temp channel struct pointer to the start of the desired
+	 * list
+	 */
+	tmp_chan_list = scan_chan_list;
+
+	/* Loop through the desired channel list, sending a new firmware scan
+	 * commands for each max_chan_per_scan channels (or for 1,6,11
+	 * individually if configured accordingly)
+	 */
+	while (tmp_chan_list->chan_number) {
+		tlv_idx = 0;
+		total_scan_time = 0;
+		radio_type = 0;
+		tlv_o->header.len = 0;
+		done_early = false;
+
+		/* Construct the Channel TLV for the scan command.  Continue to
+		 * insert channel TLVs until:
+		 *   - the tlv_idx hits the maximum configured per scan command
+		 *   - the next channel to insert is 0 (end of desired channel
+		 *     list)
+		 *   - done_early is set (controlling individual scanning of
+		 *     1,6,11)
+		 */
+		while (tlv_idx < max_chan_per_scan &&
+		       tmp_chan_list->chan_number && !done_early) {
+			if (tmp_chan_list->chan_number == priv->csa_chan) {
+				tmp_chan_list++;
+				continue;
+			}
+
+			radio_type = tmp_chan_list->band_cfg;
+			nxpwifi_dbg(priv->adapter, INFO,
+				    "info: Scan: Chan(%3d), Band(%d),\t"
+				    "Mode(%d, %d), Dur(%d)\n",
+				    tmp_chan_list->chan_number,
+				    tmp_chan_list->band_cfg,
+				    tmp_chan_list->chan_scan_mode_bmap
+				    & NXPWIFI_PASSIVE_SCAN,
+				    (tmp_chan_list->chan_scan_mode_bmap
+				    & NXPWIFI_DISABLE_CHAN_FILT) >> 1,
+				    le16_to_cpu(tmp_chan_list->max_scan_time));
+
+			/* Copy the current channel TLV to the command being
+			 * prepared
+			 */
+			memcpy(&tlv_o->chan_scan_param[tlv_idx],
+			       tmp_chan_list,
+			       sizeof(*tlv_o->chan_scan_param));
+
+			/* Increment the TLV header length by the size
+			 * appended
+			 */
+			le16_unaligned_add_cpu(&tlv_o->header.len,
+					       sizeof(*tlv_o->chan_scan_param));
+
+			/* The tlv buffer length is set to the number of bytes
+			 * of the between the channel tlv pointer and the start
+			 * of the tlv buffer.  This compensates for any TLVs
+			 * that were appended before the channel list.
+			 */
+			scan_cfg_out->tlv_buf_len =
+				(u32)((u8 *)tlv_o - scan_cfg_out->tlv_buf);
+
+			/* Add the size of the channel tlv header and the data
+			 * length
+			 */
+			scan_cfg_out->tlv_buf_len +=
+				(sizeof(tlv_o->header)
+				 + le16_to_cpu(tlv_o->header.len));
+
+			/* Increment the index to the channel tlv we are
+			 * constructing
+			 */
+			tlv_idx++;
+
+			/* Count the total scan time per command */
+			total_scan_time +=
+				le16_to_cpu(tmp_chan_list->max_scan_time);
+
+			done_early = false;
+
+			/* Stop the loop if the *current* channel is in the
+			 * 1,6,11 set and we are not filtering on a BSSID
+			 * or SSID.
+			 */
+			if (!filtered_scan &&
+			    (tmp_chan_list->chan_number == 1 ||
+			     tmp_chan_list->chan_number == 6 ||
+			     tmp_chan_list->chan_number == 11))
+				done_early = true;
+
+			/* Increment the tmp pointer to the next channel to
+			 * be scanned
+			 */
+			tmp_chan_list++;
+
+			/* Stop the loop if the *next* channel is in the 1,6,11
+			 * set.  This will cause it to be the only channel
+			 * scanned on the next interation
+			 */
+			if (!filtered_scan &&
+			    (tmp_chan_list->chan_number == 1 ||
+			     tmp_chan_list->chan_number == 6 ||
+			     tmp_chan_list->chan_number == 11))
+				done_early = true;
+		}
+
+		/* The total scan time should be less than scan command timeout
+		 * value
+		 */
+		if (total_scan_time > NXPWIFI_MAX_TOTAL_SCAN_TIME) {
+			nxpwifi_dbg(priv->adapter, ERROR,
+				    "total scan time %dms\t"
+				    "is over limit (%dms), scan skipped\n",
+				    total_scan_time,
+				    NXPWIFI_MAX_TOTAL_SCAN_TIME);
+			ret = -EINVAL;
+			break;
+		}
+
+		rates_size = nxpwifi_append_rate_tlv(priv, scan_cfg_out,
+						     radio_type);
+
+		/* Send the scan command to the firmware with the specified
+		 * cfg
+		 */
+		if (priv->adapter->ext_scan)
+			cmd_no = HOST_CMD_802_11_SCAN_EXT;
+		else
+			cmd_no = HOST_CMD_802_11_SCAN;
+
+		ret = nxpwifi_send_cmd(priv, cmd_no, HOST_ACT_GEN_SET,
+				       0, scan_cfg_out, false);
+
+		/* rate IE is updated per scan command but same starting
+		 * pointer is used each time so that rate IE from earlier
+		 * scan_cfg_out->buf is overwritten with new one.
+		 */
+		scan_cfg_out->tlv_buf_len -=
+			    sizeof(struct nxpwifi_ie_types_header) + rates_size;
+
+		if (ret) {
+			nxpwifi_cancel_pending_scan_cmd(adapter);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/* This function constructs a scan command configuration structure to use
+ * in scan commands.
+ *
+ * Application layer or other functions can invoke network scanning
+ * with a scan configuration supplied in a user scan configuration structure.
+ * This structure is used as the basis of one or many scan command configuration
+ * commands that are sent to the command processing module and eventually to the
+ * firmware.
+ *
+ * This function creates a scan command configuration structure  based on the
+ * following user supplied parameters (if present):
+ *      - SSID filter
+ *      - BSSID filter
+ *      - Number of Probes to be sent
+ *      - Channel list
+ *
+ * If the SSID or BSSID filter is not present, the filter is disabled/cleared.
+ * If the number of probes is not set, adapter default setting is used.
+ */
+static void
+nxpwifi_config_scan(struct nxpwifi_private *priv,
+		    const struct nxpwifi_user_scan_cfg *user_scan_in,
+		    struct nxpwifi_scan_cmd_config *scan_cfg_out,
+		    struct nxpwifi_ie_types_chan_list_param_set **chan_list_out,
+		    struct nxpwifi_chan_scan_param_set *scan_chan_list,
+		    u8 *max_chan_per_scan, u8 *filtered_scan,
+		    u8 *scan_current_only)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_num_probes *num_probes_tlv;
+	struct nxpwifi_ie_types_scan_chan_gap *chan_gap_tlv;
+	struct nxpwifi_ie_types_random_mac *random_mac_tlv;
+	struct nxpwifi_ie_types_wildcard_ssid_params *wildcard_ssid_tlv;
+	struct nxpwifi_ie_types_bssid_list *bssid_tlv;
+	u8 *tlv_pos;
+	u32 num_probes;
+	u32 ssid_len;
+	u32 chan_idx;
+	u32 scan_time;
+	u32 scan_type;
+	u16 scan_dur;
+	u8 channel;
+	u8 radio_type;
+	int i;
+	u8 ssid_filter;
+	struct nxpwifi_ie_types_htcap *ht_cap;
+	struct nxpwifi_ie_types_bss_mode *bss_mode;
+
+	/* The tlv_buf_len is calculated for each scan command.  The TLVs added
+	 * in this routine will be preserved since the routine that sends the
+	 * command will append channelTLVs at *chan_list_out.  The difference
+	 * between the *chan_list_out and the tlv_buf start will be used to
+	 * calculate the size of anything we add in this routine.
+	 */
+	scan_cfg_out->tlv_buf_len = 0;
+
+	/* Running tlv pointer.  Assigned to chan_list_out at end of function
+	 * so later routines know where channels can be added to the command
+	 * buf
+	 */
+	tlv_pos = scan_cfg_out->tlv_buf;
+
+	/* Initialize the scan as un-filtered; the flag is later set to TRUE
+	 * below if a SSID or BSSID filter is sent in the command
+	 */
+	*filtered_scan = false;
+
+	/* Initialize the scan as not being only on the current channel.  If
+	 * the channel list is customized, only contains one channel, and is
+	 * the active channel, this is set true and data flow is not halted.
+	 */
+	*scan_current_only = false;
+
+	if (user_scan_in) {
+		u8 tmpaddr[ETH_ALEN];
+
+		/* Default the ssid_filter flag to TRUE, set false under
+		 * certain wildcard conditions and qualified by the existence
+		 * of an SSID list before marking the scan as filtered
+		 */
+		ssid_filter = true;
+
+		/* Set the BSS type scan filter, use Adapter setting if
+		 * unset
+		 */
+		scan_cfg_out->bss_mode =
+			(u8)(user_scan_in->bss_mode ?: adapter->scan_mode);
+
+		/* Set the number of probes to send, use Adapter setting
+		 * if unset
+		 */
+		num_probes = user_scan_in->num_probes ?: adapter->scan_probes;
+
+		/* Set the BSSID filter to the incoming configuration,
+		 * if non-zero.  If not set, it will remain disabled
+		 * (all zeros).
+		 */
+		memcpy(scan_cfg_out->specific_bssid,
+		       user_scan_in->specific_bssid,
+		       sizeof(scan_cfg_out->specific_bssid));
+
+		memcpy(tmpaddr, scan_cfg_out->specific_bssid, ETH_ALEN);
+
+		if (adapter->ext_scan &&
+		    !is_zero_ether_addr(tmpaddr)) {
+			bssid_tlv =
+				(struct nxpwifi_ie_types_bssid_list *)tlv_pos;
+			bssid_tlv->header.type = cpu_to_le16(TLV_TYPE_BSSID);
+			bssid_tlv->header.len = cpu_to_le16(ETH_ALEN);
+			memcpy(bssid_tlv->bssid, user_scan_in->specific_bssid,
+			       ETH_ALEN);
+			tlv_pos += sizeof(struct nxpwifi_ie_types_bssid_list);
+		}
+
+		for (i = 0; i < user_scan_in->num_ssids; i++) {
+			ssid_len = user_scan_in->ssid_list[i].ssid_len;
+
+			wildcard_ssid_tlv =
+				(struct nxpwifi_ie_types_wildcard_ssid_params *)
+				tlv_pos;
+			wildcard_ssid_tlv->header.type =
+				cpu_to_le16(TLV_TYPE_WILDCARDSSID);
+			wildcard_ssid_tlv->header.len =
+				cpu_to_le16((u16)(ssid_len + sizeof(u8)));
+
+			/* max_ssid_length = 0 tells firmware to perform
+			 * specific scan for the SSID filled, whereas
+			 * max_ssid_length = IEEE80211_MAX_SSID_LEN is for
+			 * wildcard scan.
+			 */
+			if (ssid_len)
+				wildcard_ssid_tlv->max_ssid_length = 0;
+			else
+				wildcard_ssid_tlv->max_ssid_length =
+							IEEE80211_MAX_SSID_LEN;
+
+			if (!memcmp(user_scan_in->ssid_list[i].ssid,
+				    "DIRECT-", 7))
+				wildcard_ssid_tlv->max_ssid_length = 0xfe;
+
+			memcpy(wildcard_ssid_tlv->ssid,
+			       user_scan_in->ssid_list[i].ssid, ssid_len);
+
+			tlv_pos += (sizeof(wildcard_ssid_tlv->header)
+				+ le16_to_cpu(wildcard_ssid_tlv->header.len));
+
+			nxpwifi_dbg(adapter, INFO,
+				    "info: scan: ssid[%d]: %s, %d\n",
+				    i, wildcard_ssid_tlv->ssid,
+				    wildcard_ssid_tlv->max_ssid_length);
+
+			/* Empty wildcard ssid with a maxlen will match many or
+			 * potentially all SSIDs (maxlen == 32), therefore do
+			 * not treat the scan as
+			 * filtered.
+			 */
+			if (!ssid_len && wildcard_ssid_tlv->max_ssid_length)
+				ssid_filter = false;
+		}
+
+		/*  The default number of channels sent in the command is low to
+		 *  ensure the response buffer from the firmware does not
+		 *  truncate scan results.  That is not an issue with an SSID
+		 *  or BSSID filter applied to the scan results in the firmware.
+		 */
+		memcpy(tmpaddr, scan_cfg_out->specific_bssid, ETH_ALEN);
+		if ((i && ssid_filter) ||
+		    !is_zero_ether_addr(tmpaddr))
+			*filtered_scan = true;
+
+		if (user_scan_in->scan_chan_gap) {
+			nxpwifi_dbg(adapter, INFO,
+				    "info: scan: channel gap = %d\n",
+				    user_scan_in->scan_chan_gap);
+			*max_chan_per_scan =
+					NXPWIFI_MAX_CHANNELS_PER_SPECIFIC_SCAN;
+
+			chan_gap_tlv = (void *)tlv_pos;
+			chan_gap_tlv->header.type =
+					 cpu_to_le16(TLV_TYPE_SCAN_CHANNEL_GAP);
+			chan_gap_tlv->header.len =
+				    cpu_to_le16(sizeof(chan_gap_tlv->chan_gap));
+			chan_gap_tlv->chan_gap =
+				     cpu_to_le16((user_scan_in->scan_chan_gap));
+			tlv_pos +=
+				  sizeof(struct nxpwifi_ie_types_scan_chan_gap);
+		}
+
+		if (!is_zero_ether_addr(user_scan_in->random_mac)) {
+			random_mac_tlv = (void *)tlv_pos;
+			random_mac_tlv->header.type =
+					 cpu_to_le16(TLV_TYPE_RANDOM_MAC);
+			random_mac_tlv->header.len =
+				    cpu_to_le16(sizeof(random_mac_tlv->mac));
+			ether_addr_copy(random_mac_tlv->mac,
+					user_scan_in->random_mac);
+			tlv_pos +=
+				  sizeof(struct nxpwifi_ie_types_random_mac);
+		}
+	} else {
+		scan_cfg_out->bss_mode = (u8)adapter->scan_mode;
+		num_probes = adapter->scan_probes;
+	}
+
+	/*  If a specific BSSID or SSID is used, the number of channels in the
+	 *  scan command will be increased to the absolute maximum.
+	 */
+	if (*filtered_scan) {
+		*max_chan_per_scan = NXPWIFI_MAX_CHANNELS_PER_SPECIFIC_SCAN;
+	} else {
+		if (!priv->media_connected)
+			*max_chan_per_scan = NXPWIFI_DEF_CHANNELS_PER_SCAN_CMD;
+		else
+			*max_chan_per_scan =
+					NXPWIFI_DEF_CHANNELS_PER_SCAN_CMD / 2;
+	}
+
+	if (adapter->ext_scan) {
+		bss_mode = (struct nxpwifi_ie_types_bss_mode *)tlv_pos;
+		bss_mode->header.type = cpu_to_le16(TLV_TYPE_BSS_MODE);
+		bss_mode->header.len = cpu_to_le16(sizeof(bss_mode->bss_mode));
+		bss_mode->bss_mode = scan_cfg_out->bss_mode;
+		tlv_pos += sizeof(bss_mode->header) +
+			   le16_to_cpu(bss_mode->header.len);
+	}
+
+	/* If the input config or adapter has the number of Probes set,
+	 * add tlv
+	 */
+	if (num_probes) {
+		nxpwifi_dbg(adapter, INFO,
+			    "info: scan: num_probes = %d\n",
+			    num_probes);
+
+		num_probes_tlv = (struct nxpwifi_ie_types_num_probes *)tlv_pos;
+		num_probes_tlv->header.type = cpu_to_le16(TLV_TYPE_NUMPROBES);
+		num_probes_tlv->header.len =
+			cpu_to_le16(sizeof(num_probes_tlv->num_probes));
+		num_probes_tlv->num_probes = cpu_to_le16((u16)num_probes);
+
+		tlv_pos += sizeof(num_probes_tlv->header) +
+			le16_to_cpu(num_probes_tlv->header.len);
+	}
+
+	if (ISSUPP_11NENABLED(priv->adapter->fw_cap_info) &&
+	    (priv->config_bands & BAND_GN ||
+	     priv->config_bands & BAND_AN)) {
+		ht_cap = (struct nxpwifi_ie_types_htcap *)tlv_pos;
+		memset(ht_cap, 0, sizeof(struct nxpwifi_ie_types_htcap));
+		ht_cap->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		ht_cap->header.len =
+			cpu_to_le16(sizeof(struct ieee80211_ht_cap));
+		radio_type =
+			nxpwifi_band_to_radio_type(priv->config_bands);
+		nxpwifi_fill_cap_info(priv, radio_type, &ht_cap->ht_cap);
+		tlv_pos += sizeof(struct nxpwifi_ie_types_htcap);
+	}
+
+	/* Append vendor specific IE TLV */
+	nxpwifi_cmd_append_vsie_tlv(priv, NXPWIFI_VSIE_MASK_SCAN, &tlv_pos);
+
+	/* Set the output for the channel TLV to the address in the tlv buffer
+	 *   past any TLVs that were added in this function (SSID, num_probes).
+	 *   Channel TLVs will be added past this for each scan command,
+	 *   preserving the TLVs that were previously added.
+	 */
+	*chan_list_out =
+		(struct nxpwifi_ie_types_chan_list_param_set *)tlv_pos;
+
+	if (user_scan_in && user_scan_in->chan_list[0].chan_number) {
+		nxpwifi_dbg(adapter, INFO,
+			    "info: Scan: Using supplied channel list\n");
+
+		for (chan_idx = 0;
+		     chan_idx < NXPWIFI_USER_SCAN_CHAN_MAX &&
+		     user_scan_in->chan_list[chan_idx].chan_number;
+		     chan_idx++) {
+			channel = user_scan_in->chan_list[chan_idx].chan_number;
+			scan_chan_list[chan_idx].chan_number = channel;
+
+			radio_type =
+				user_scan_in->chan_list[chan_idx].radio_type;
+			scan_chan_list[chan_idx].band_cfg = radio_type;
+
+			scan_type = user_scan_in->chan_list[chan_idx].scan_type;
+
+			if (scan_type == NXPWIFI_SCAN_TYPE_PASSIVE)
+				scan_chan_list[chan_idx].chan_scan_mode_bmap |=
+					(NXPWIFI_PASSIVE_SCAN |
+					 NXPWIFI_HIDDEN_SSID_REPORT);
+			else
+				scan_chan_list[chan_idx].chan_scan_mode_bmap &=
+					~NXPWIFI_PASSIVE_SCAN;
+
+			scan_chan_list[chan_idx].chan_scan_mode_bmap |=
+				NXPWIFI_DISABLE_CHAN_FILT;
+
+			scan_time = user_scan_in->chan_list[chan_idx].scan_time;
+
+			if (scan_time) {
+				scan_dur = (u16)scan_time;
+			} else {
+				if (scan_type == NXPWIFI_SCAN_TYPE_PASSIVE)
+					scan_dur = adapter->passive_scan_time;
+				else if (*filtered_scan)
+					scan_dur = adapter->specific_scan_time;
+				else
+					scan_dur = adapter->active_scan_time;
+			}
+
+			scan_chan_list[chan_idx].min_scan_time =
+				cpu_to_le16(scan_dur);
+			scan_chan_list[chan_idx].max_scan_time =
+				cpu_to_le16(scan_dur);
+		}
+
+		/* Check if we are only scanning the current channel */
+		if (chan_idx == 1 &&
+		    user_scan_in->chan_list[0].chan_number ==
+		    priv->curr_bss_params.bss_descriptor.channel) {
+			*scan_current_only = true;
+			nxpwifi_dbg(adapter, INFO,
+				    "info: Scan: Scanning current channel only\n");
+		}
+	} else {
+		nxpwifi_dbg(adapter, INFO,
+			    "info: Scan: Creating full region channel list\n");
+		nxpwifi_scan_create_channel_list(priv, user_scan_in,
+						 scan_chan_list,
+						 *filtered_scan);
+	}
+}
+
+/* This function inspects the scan response buffer for pointers to
+ * expected TLVs.
+ *
+ * TLVs can be included at the end of the scan response BSS information.
+ *
+ * Data in the buffer is parsed pointers to TLVs that can potentially
+ * be passed back in the response.
+ */
+static void
+nxpwifi_ret_802_11_scan_get_tlv_ptrs(struct nxpwifi_adapter *adapter,
+				     struct nxpwifi_ie_types_data *tlv,
+				     u32 tlv_buf_size, u32 req_tlv_type,
+				     struct nxpwifi_ie_types_data **tlv_data)
+{
+	struct nxpwifi_ie_types_data *current_tlv;
+	u32 tlv_buf_left;
+	u32 tlv_type;
+	u32 tlv_len;
+
+	current_tlv = tlv;
+	tlv_buf_left = tlv_buf_size;
+	*tlv_data = NULL;
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: SCAN_RESP: tlv_buf_size = %d\n",
+		    tlv_buf_size);
+
+	while (tlv_buf_left >= sizeof(struct nxpwifi_ie_types_header)) {
+		tlv_type = le16_to_cpu(current_tlv->header.type);
+		tlv_len = le16_to_cpu(current_tlv->header.len);
+
+		if (sizeof(tlv->header) + tlv_len > tlv_buf_left) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "SCAN_RESP: TLV buffer corrupt\n");
+			break;
+		}
+
+		if (req_tlv_type == tlv_type) {
+			switch (tlv_type) {
+			case TLV_TYPE_TSFTIMESTAMP:
+				nxpwifi_dbg(adapter, INFO,
+					    "info: SCAN_RESP: TSF\t"
+					    "timestamp TLV, len = %d\n",
+					    tlv_len);
+				*tlv_data = current_tlv;
+				break;
+			case TLV_TYPE_CHANNELBANDLIST:
+				nxpwifi_dbg(adapter, INFO,
+					    "info: SCAN_RESP: channel\t"
+					    "band list TLV, len = %d\n",
+					    tlv_len);
+				*tlv_data = current_tlv;
+				break;
+			default:
+				nxpwifi_dbg(adapter, ERROR,
+					    "SCAN_RESP: unhandled TLV = %d\n",
+					    tlv_type);
+				/* Give up, this seems corrupted */
+				return;
+			}
+		}
+
+		if (*tlv_data)
+			break;
+
+		tlv_buf_left -= (sizeof(tlv->header) + tlv_len);
+		current_tlv =
+			(struct nxpwifi_ie_types_data *)(current_tlv->data +
+							 tlv_len);
+	}			/* while */
+}
+
+/* This function parses provided beacon buffer and updates
+ * respective fields in bss descriptor structure.
+ */
+int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
+				    struct nxpwifi_bssdescriptor *bss_entry)
+{
+	u8 element_id;
+	u16 elem_size = sizeof(struct element);
+	struct ieee_types_fh_param_set *fh_param_set;
+	struct ieee_types_ds_param_set *ds_param_set;
+	struct ieee_types_cf_param_set *cf_param_set;
+	u8 *current_ptr;
+	u8 *rate;
+	u8 element_len;
+	u16 total_ie_len;
+	u8 bytes_to_copy;
+	u8 rate_size;
+	u8 found_data_rate_ie;
+	u32 bytes_left;
+	struct ieee_types_vendor_specific *vendor_ie;
+	const u8 wpa_oui[4] = { 0x00, 0x50, 0xf2, 0x01 };
+	const u8 wmm_oui[4] = { 0x00, 0x50, 0xf2, 0x02 };
+
+	found_data_rate_ie = false;
+	rate_size = 0;
+	current_ptr = bss_entry->beacon_buf;
+	bytes_left = bss_entry->beacon_buf_size;
+
+	/* Process variable IE */
+	while (bytes_left >= 2) {
+		element_id = *current_ptr;
+		element_len = *(current_ptr + 1);
+		total_ie_len = element_len + elem_size;
+
+		if (bytes_left < total_ie_len) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "err: InterpretIE: in processing\t"
+				    "IE, bytes left < IE length\n");
+			return -EINVAL;
+		}
+		switch (element_id) {
+		case WLAN_EID_SSID:
+			if (element_len > IEEE80211_MAX_SSID_LEN)
+				return -EINVAL;
+			bss_entry->ssid.ssid_len = element_len;
+			memcpy(bss_entry->ssid.ssid, (current_ptr + 2),
+			       element_len);
+			nxpwifi_dbg(adapter, INFO,
+				    "info: InterpretIE: ssid: %-32s\n",
+				    bss_entry->ssid.ssid);
+			break;
+
+		case WLAN_EID_SUPP_RATES:
+			if (element_len > NXPWIFI_SUPPORTED_RATES)
+				return -EINVAL;
+			memcpy(bss_entry->data_rates, current_ptr + 2,
+			       element_len);
+			memcpy(bss_entry->supported_rates, current_ptr + 2,
+			       element_len);
+			rate_size = element_len;
+			found_data_rate_ie = true;
+			break;
+
+		case WLAN_EID_FH_PARAMS:
+			if (total_ie_len < sizeof(*fh_param_set))
+				return -EINVAL;
+			fh_param_set =
+				(struct ieee_types_fh_param_set *)current_ptr;
+			memcpy(&bss_entry->phy_param_set.fh_param_set,
+			       fh_param_set,
+			       sizeof(struct ieee_types_fh_param_set));
+			break;
+
+		case WLAN_EID_DS_PARAMS:
+			if (total_ie_len < sizeof(*ds_param_set))
+				return -EINVAL;
+			ds_param_set =
+				(struct ieee_types_ds_param_set *)current_ptr;
+
+			bss_entry->channel = ds_param_set->current_chan;
+
+			memcpy(&bss_entry->phy_param_set.ds_param_set,
+			       ds_param_set,
+			       sizeof(struct ieee_types_ds_param_set));
+			break;
+
+		case WLAN_EID_CF_PARAMS:
+			if (total_ie_len < sizeof(*cf_param_set))
+				return -EINVAL;
+			cf_param_set =
+				(struct ieee_types_cf_param_set *)current_ptr;
+			memcpy(&bss_entry->cf_param_set,
+			       cf_param_set,
+			       sizeof(struct ieee_types_cf_param_set));
+			break;
+
+		case WLAN_EID_ERP_INFO:
+			if (!element_len)
+				return -EINVAL;
+			bss_entry->erp_flags = *(current_ptr + 2);
+			break;
+
+		case WLAN_EID_PWR_CONSTRAINT:
+			if (!element_len)
+				return -EINVAL;
+			bss_entry->local_constraint = *(current_ptr + 2);
+			bss_entry->sensed_11h = true;
+			break;
+
+		case WLAN_EID_CHANNEL_SWITCH:
+			bss_entry->chan_sw_ie_present = true;
+			fallthrough;
+		case WLAN_EID_PWR_CAPABILITY:
+		case WLAN_EID_TPC_REPORT:
+		case WLAN_EID_QUIET:
+			bss_entry->sensed_11h = true;
+			break;
+
+		case WLAN_EID_EXT_SUPP_RATES:
+			/* Only process extended supported rate
+			 * if data rate is already found.
+			 * Data rate IE should come before
+			 * extended supported rate IE
+			 */
+			if (found_data_rate_ie) {
+				if ((element_len + rate_size) >
+				    NXPWIFI_SUPPORTED_RATES)
+					bytes_to_copy =
+						(NXPWIFI_SUPPORTED_RATES -
+						 rate_size);
+				else
+					bytes_to_copy = element_len;
+
+				rate = (u8 *)bss_entry->data_rates;
+				rate += rate_size;
+				memcpy(rate, current_ptr + 2, bytes_to_copy);
+
+				rate = (u8 *)bss_entry->supported_rates;
+				rate += rate_size;
+				memcpy(rate, current_ptr + 2, bytes_to_copy);
+			}
+			break;
+
+		case WLAN_EID_VENDOR_SPECIFIC:
+			vendor_ie = (struct ieee_types_vendor_specific *)
+				current_ptr;
+
+			/* 802.11 requires at least 3-byte OUI. */
+			if (element_len < sizeof(vendor_ie->vend_hdr.oui))
+				return -EINVAL;
+
+			/* Not long enough for a match? Skip it. */
+			if (element_len < sizeof(wpa_oui))
+				break;
+
+			if (!memcmp(&vendor_ie->vend_hdr.oui, wpa_oui,
+				    sizeof(wpa_oui))) {
+				bss_entry->bcn_wpa_ie =
+					(struct ieee_types_vendor_specific *)
+					current_ptr;
+				bss_entry->wpa_offset =
+					(u16)(current_ptr -
+					      bss_entry->beacon_buf);
+			} else if (!memcmp(&vendor_ie->vend_hdr.oui, wmm_oui,
+					   sizeof(wmm_oui))) {
+				if (total_ie_len ==
+				    sizeof(struct ieee80211_wmm_param_ie) ||
+				    total_ie_len ==
+				    sizeof(struct ieee_types_wmm_info))
+					/* Only accept and copy the WMM IE if
+					 * it matches the size expected for the
+					 * WMM Info IE or the WMM Parameter IE.
+					 */
+					memcpy((u8 *)&bss_entry->wmm_ie,
+					       current_ptr, total_ie_len);
+			}
+			break;
+		case WLAN_EID_RSN:
+			bss_entry->bcn_rsn_ie =
+				(struct element *)current_ptr;
+			bss_entry->rsn_offset =
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_RSNX:
+			bss_entry->bcn_rsnx_ie =
+				(struct element *)current_ptr;
+			bss_entry->rsnx_offset =
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_HT_CAPABILITY:
+			bss_entry->bcn_ht_cap =
+				(struct ieee80211_ht_cap *)(current_ptr +
+							    elem_size);
+			bss_entry->ht_cap_offset =
+				(u16)(current_ptr + elem_size -
+				      bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_HT_OPERATION:
+			bss_entry->bcn_ht_oper =
+				(struct ieee80211_ht_operation *)(current_ptr +
+								  elem_size);
+			bss_entry->ht_info_offset =
+				(u16)(current_ptr + elem_size -
+				      bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_VHT_CAPABILITY:
+			bss_entry->disable_11ac = false;
+			bss_entry->bcn_vht_cap = (void *)(current_ptr +
+							  elem_size);
+			bss_entry->vht_cap_offset =
+				(u16)((u8 *)bss_entry->bcn_vht_cap -
+				      bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_VHT_OPERATION:
+			bss_entry->bcn_vht_oper =
+				(void *)(current_ptr + elem_size);
+			bss_entry->vht_info_offset =
+				(u16)((u8 *)bss_entry->bcn_vht_oper -
+				      bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_BSS_COEX_2040:
+			bss_entry->bcn_bss_co_2040 = current_ptr;
+			bss_entry->bss_co_2040_offset =
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_EXT_CAPABILITY:
+			bss_entry->bcn_ext_cap = current_ptr;
+			bss_entry->ext_cap_offset =
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_OPMODE_NOTIF:
+			bss_entry->oper_mode = (void *)current_ptr;
+			bss_entry->oper_mode_offset =
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
+		case WLAN_EID_EXTENSION:
+			struct element *elem = (struct element *)current_ptr;
+
+			switch (elem->data[0]) {
+			case WLAN_EID_EXT_HE_CAPABILITY:
+				bss_entry->disable_11ax = false;
+				bss_entry->bcn_he_cap =
+					(void *)(current_ptr + elem_size + 1);
+				bss_entry->he_cap_offset =
+					(u16)((u8 *)bss_entry->bcn_he_cap -
+					      bss_entry->beacon_buf);
+				break;
+			case WLAN_EID_EXT_HE_OPERATION:
+				bss_entry->bcn_he_oper =
+					(void *)(current_ptr + elem_size + 1);
+				bss_entry->he_info_offset =
+					(u16)((u8 *)bss_entry->bcn_he_oper -
+					      bss_entry->beacon_buf);
+			default:
+				break;
+			}
+			break;
+		default:
+			break;
+		}
+
+		current_ptr += total_ie_len;
+		bytes_left -= total_ie_len;
+
+	}	/* while (bytes_left > 2) */
+	return 0;
+}
+
+/* This function converts radio type scan parameter to a band configuration
+ * to be used in join command.
+ */
+static u8
+nxpwifi_radio_type_to_band(u8 radio_type)
+{
+	switch (radio_type) {
+	case HOST_SCAN_RADIO_TYPE_A:
+		return BAND_A;
+	case HOST_SCAN_RADIO_TYPE_BG:
+	default:
+		return BAND_G;
+	}
+}
+
+/* This is an internal function used to start a scan based on an input
+ * configuration.
+ *
+ * This uses the input user scan configuration information when provided in
+ * order to send the appropriate scan commands to firmware to populate or
+ * update the internal driver scan table.
+ */
+int nxpwifi_scan_networks(struct nxpwifi_private *priv,
+			  const struct nxpwifi_user_scan_cfg *user_scan_in)
+{
+	int ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct cmd_ctrl_node *cmd_node;
+	union nxpwifi_scan_cmd_config_tlv *scan_cfg_out;
+	struct nxpwifi_ie_types_chan_list_param_set *chan_list_out;
+	struct nxpwifi_chan_scan_param_set *scan_chan_list;
+	u8 filtered_scan;
+	u8 scan_current_chan_only;
+	u8 max_chan_per_scan;
+
+	if (adapter->scan_processing) {
+		nxpwifi_dbg(adapter, WARN,
+			    "cmd: Scan already in process...\n");
+		return -EBUSY;
+	}
+
+	if (priv->scan_block) {
+		nxpwifi_dbg(adapter, WARN,
+			    "cmd: Scan is blocked during association...\n");
+		return -EBUSY;
+	}
+
+	if (test_bit(NXPWIFI_SURPRISE_REMOVED, &adapter->work_flags) ||
+	    test_bit(NXPWIFI_IS_CMD_TIMEDOUT, &adapter->work_flags)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "Ignore scan. Card removed or firmware in bad state\n");
+		return -EPERM;
+	}
+
+	spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+	adapter->scan_processing = true;
+	spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+
+	scan_cfg_out = kzalloc(sizeof(union nxpwifi_scan_cmd_config_tlv),
+			       GFP_KERNEL);
+	if (!scan_cfg_out) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	scan_chan_list = kcalloc(NXPWIFI_USER_SCAN_CHAN_MAX,
+				 sizeof(struct nxpwifi_chan_scan_param_set),
+				 GFP_KERNEL);
+	if (!scan_chan_list) {
+		kfree(scan_cfg_out);
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	nxpwifi_config_scan(priv, user_scan_in, &scan_cfg_out->config,
+			    &chan_list_out, scan_chan_list, &max_chan_per_scan,
+			    &filtered_scan, &scan_current_chan_only);
+
+	ret = nxpwifi_scan_channel_list(priv, max_chan_per_scan, filtered_scan,
+					&scan_cfg_out->config, chan_list_out,
+					scan_chan_list);
+
+	/* Get scan command from scan_pending_q and put to cmd_pending_q */
+	if (!ret) {
+		spin_lock_bh(&adapter->scan_pending_q_lock);
+		if (!list_empty(&adapter->scan_pending_q)) {
+			cmd_node = list_first_entry(&adapter->scan_pending_q,
+						    struct cmd_ctrl_node, list);
+			list_del(&cmd_node->list);
+			spin_unlock_bh(&adapter->scan_pending_q_lock);
+			nxpwifi_insert_cmd_to_pending_q(adapter, cmd_node);
+			nxpwifi_queue_work(adapter, &adapter->main_work);
+
+			/* Perform internal scan synchronously */
+			if (!priv->scan_request) {
+				nxpwifi_dbg(adapter, INFO,
+					    "wait internal scan\n");
+				nxpwifi_wait_queue_complete(adapter, cmd_node);
+			}
+		} else {
+			spin_unlock_bh(&adapter->scan_pending_q_lock);
+		}
+	}
+
+	kfree(scan_cfg_out);
+	kfree(scan_chan_list);
+done:
+	if (ret) {
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		adapter->scan_processing = false;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+	}
+	return ret;
+}
+
+/* This function prepares a scan command to be sent to the firmware.
+ *
+ * This uses the scan command configuration sent to the command processing
+ * module in command preparation stage to configure a scan command structure
+ * to send to firmware.
+ *
+ * The fixed fields specifying the BSS type and BSSID filters as well as a
+ * variable number/length of TLVs are sent in the command to firmware.
+ *
+ * Preparation also includes -
+ *      - Setting command ID, and proper size
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_802_11_scan(struct host_cmd_ds_command *cmd,
+			    struct nxpwifi_scan_cmd_config *scan_cfg)
+{
+	struct host_cmd_ds_802_11_scan *scan_cmd = &cmd->params.scan;
+
+	/* Set fixed field variables in scan command */
+	scan_cmd->bss_mode = scan_cfg->bss_mode;
+	memcpy(scan_cmd->bssid, scan_cfg->specific_bssid,
+	       sizeof(scan_cmd->bssid));
+	memcpy(scan_cmd->tlv_buffer, scan_cfg->tlv_buf, scan_cfg->tlv_buf_len);
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_SCAN);
+
+	/* Size is equal to the sizeof(fixed portions) + the TLV len + header */
+	cmd->size = cpu_to_le16((u16)(sizeof(scan_cmd->bss_mode)
+					  + sizeof(scan_cmd->bssid)
+					  + scan_cfg->tlv_buf_len + S_DS_GEN));
+
+	return 0;
+}
+
+/* This function checks compatibility of requested network with current
+ * driver settings.
+ */
+int nxpwifi_check_network_compatibility(struct nxpwifi_private *priv,
+					struct nxpwifi_bssdescriptor *bss_desc)
+{
+	int ret = 0;
+
+	if (!bss_desc)
+		return -EINVAL;
+
+	if ((nxpwifi_get_cfp(priv, (u8)bss_desc->bss_band,
+			     (u16)bss_desc->channel, 0))) {
+		switch (priv->bss_mode) {
+		case NL80211_IFTYPE_STATION:
+			ret = nxpwifi_is_network_compatible(priv, bss_desc,
+							    priv->bss_mode);
+			if (ret)
+				nxpwifi_dbg(priv->adapter, ERROR,
+					    "Incompatible network settings\n");
+			break;
+		default:
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
+/* This function checks if SSID string contains all zeroes or length is zero */
+static bool nxpwifi_is_hidden_ssid(struct cfg80211_ssid *ssid)
+{
+	int idx;
+
+	for (idx = 0; idx < ssid->ssid_len; idx++) {
+		if (ssid->ssid[idx])
+			return false;
+	}
+
+	return true;
+}
+
+/* This function checks if any hidden SSID found in passive scan channels
+ * and save those channels for specific SSID active scan
+ */
+static int nxpwifi_save_hidden_ssid_channels(struct nxpwifi_private *priv,
+					     struct cfg80211_bss *bss)
+{
+	struct nxpwifi_bssdescriptor *bss_desc;
+	int ret;
+	int chid;
+
+	/* Allocate and fill new bss descriptor */
+	bss_desc = kzalloc(sizeof(*bss_desc), GFP_KERNEL);
+	if (!bss_desc)
+		return -ENOMEM;
+
+	ret = nxpwifi_fill_new_bss_desc(priv, bss, bss_desc);
+	if (ret)
+		goto done;
+
+	if (nxpwifi_is_hidden_ssid(&bss_desc->ssid)) {
+		nxpwifi_dbg(priv->adapter, INFO, "found hidden SSID\n");
+		for (chid = 0 ; chid < NXPWIFI_USER_SCAN_CHAN_MAX; chid++) {
+			if (priv->hidden_chan[chid].chan_number ==
+			    bss->channel->hw_value)
+				break;
+
+			if (!priv->hidden_chan[chid].chan_number) {
+				priv->hidden_chan[chid].chan_number =
+					bss->channel->hw_value;
+				priv->hidden_chan[chid].radio_type =
+					bss->channel->band;
+				priv->hidden_chan[chid].scan_type =
+					NXPWIFI_SCAN_TYPE_ACTIVE;
+				break;
+			}
+		}
+	}
+
+done:
+	/* beacon_ie buffer was allocated in function
+	 * nxpwifi_fill_new_bss_desc(). Free it now.
+	 */
+	kfree(bss_desc->beacon_buf);
+	kfree(bss_desc);
+	return ret;
+}
+
+static int nxpwifi_update_curr_bss_params(struct nxpwifi_private *priv,
+					  struct cfg80211_bss *bss)
+{
+	struct nxpwifi_bssdescriptor *bss_desc;
+	int ret;
+
+	/* Allocate and fill new bss descriptor */
+	bss_desc = kzalloc(sizeof(*bss_desc), GFP_KERNEL);
+	if (!bss_desc)
+		return -ENOMEM;
+
+	ret = nxpwifi_fill_new_bss_desc(priv, bss, bss_desc);
+	if (ret)
+		goto done;
+
+	ret = nxpwifi_check_network_compatibility(priv, bss_desc);
+	if (ret)
+		goto done;
+
+	spin_lock_bh(&priv->curr_bcn_buf_lock);
+	/* Make a copy of current BSSID descriptor */
+	memcpy(&priv->curr_bss_params.bss_descriptor, bss_desc,
+	       sizeof(priv->curr_bss_params.bss_descriptor));
+
+	/* The contents of beacon_ie will be copied to its own buffer
+	 * in nxpwifi_save_curr_bcn()
+	 */
+	nxpwifi_save_curr_bcn(priv);
+	spin_unlock_bh(&priv->curr_bcn_buf_lock);
+
+done:
+	/* beacon_ie buffer was allocated in function
+	 * nxpwifi_fill_new_bss_desc(). Free it now.
+	 */
+	kfree(bss_desc->beacon_buf);
+	kfree(bss_desc);
+	return ret;
+}
+
+static int
+nxpwifi_parse_single_response_buf(struct nxpwifi_private *priv, u8 **bss_info,
+				  u32 *bytes_left, u64 fw_tsf, u8 *radio_type,
+				  bool ext_scan, s32 rssi_val)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_chan_freq_power *cfp;
+	struct cfg80211_bss *bss;
+	u8 bssid[ETH_ALEN];
+	s32 rssi;
+	const u8 *ie_buf;
+	size_t ie_len;
+	u16 channel = 0;
+	u16 beacon_size = 0;
+	u32 curr_bcn_bytes;
+	u32 freq;
+	u16 beacon_period;
+	u16 cap_info_bitmap;
+	u8 *current_ptr;
+	u64 timestamp;
+	struct nxpwifi_fixed_bcn_param *bcn_param;
+	struct nxpwifi_bss_priv *bss_priv;
+
+	if (*bytes_left >= sizeof(beacon_size)) {
+		/* Extract & convert beacon size from command buffer */
+		beacon_size = get_unaligned_le16((*bss_info));
+		*bytes_left -= sizeof(beacon_size);
+		*bss_info += sizeof(beacon_size);
+	}
+
+	if (!beacon_size || beacon_size > *bytes_left) {
+		*bss_info += *bytes_left;
+		*bytes_left = 0;
+		return -EINVAL;
+	}
+
+	/* Initialize the current working beacon pointer for this BSS
+	 * iteration
+	 */
+	current_ptr = *bss_info;
+
+	/* Advance the return beacon pointer past the current beacon */
+	*bss_info += beacon_size;
+	*bytes_left -= beacon_size;
+
+	curr_bcn_bytes = beacon_size;
+
+	/* First 5 fields are bssid, RSSI(for legacy scan only),
+	 * time stamp, beacon interval, and capability information
+	 */
+	if (curr_bcn_bytes < ETH_ALEN + sizeof(u8) +
+	    sizeof(struct nxpwifi_fixed_bcn_param)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "InterpretIE: not enough bytes left\n");
+		return -EINVAL;
+	}
+
+	memcpy(bssid, current_ptr, ETH_ALEN);
+	current_ptr += ETH_ALEN;
+	curr_bcn_bytes -= ETH_ALEN;
+
+	if (!ext_scan) {
+		rssi = (s32)*current_ptr;
+		rssi = (-rssi) * 100;		/* Convert dBm to mBm */
+		current_ptr += sizeof(u8);
+		curr_bcn_bytes -= sizeof(u8);
+		nxpwifi_dbg(adapter, INFO,
+			    "info: InterpretIE: RSSI=%d\n", rssi);
+	} else {
+		rssi = rssi_val;
+	}
+
+	bcn_param = (struct nxpwifi_fixed_bcn_param *)current_ptr;
+	current_ptr += sizeof(*bcn_param);
+	curr_bcn_bytes -= sizeof(*bcn_param);
+
+	timestamp = le64_to_cpu(bcn_param->timestamp);
+	beacon_period = le16_to_cpu(bcn_param->beacon_period);
+
+	cap_info_bitmap = le16_to_cpu(bcn_param->cap_info_bitmap);
+	nxpwifi_dbg(adapter, INFO,
+		    "info: InterpretIE: capabilities=0x%X\n",
+		    cap_info_bitmap);
+
+	/* Rest of the current buffer are IE's */
+	ie_buf = current_ptr;
+	ie_len = curr_bcn_bytes;
+	nxpwifi_dbg(adapter, INFO,
+		    "info: InterpretIE: IELength for this AP = %d\n",
+		    curr_bcn_bytes);
+
+	while (curr_bcn_bytes >= sizeof(struct element)) {
+		u8 element_id, element_len;
+
+		element_id = *current_ptr;
+		element_len = *(current_ptr + 1);
+		if (curr_bcn_bytes < element_len +
+				sizeof(struct element)) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "%s: bytes left < IE length\n", __func__);
+			return -EFAULT;
+		}
+		if (element_id == WLAN_EID_DS_PARAMS) {
+			channel = *(current_ptr +
+				    sizeof(struct element));
+			break;
+		}
+
+		current_ptr += element_len + sizeof(struct element);
+		curr_bcn_bytes -= element_len +
+					sizeof(struct element);
+	}
+
+	if (channel) {
+		struct ieee80211_channel *chan;
+		struct nxpwifi_bssdescriptor *bss_desc;
+		u8 band;
+
+		/* Skip entry if on csa closed channel */
+		if (channel == priv->csa_chan) {
+			nxpwifi_dbg(adapter, WARN,
+				    "Dropping entry on csa closed channel\n");
+			return 0;
+		}
+
+		band = BAND_G;
+		if (radio_type)
+			band = nxpwifi_radio_type_to_band(*radio_type &
+							  (BIT(0) | BIT(1)));
+
+		cfp = nxpwifi_get_cfp(priv, band, channel, 0);
+
+		freq = cfp ? cfp->freq : 0;
+
+		chan = ieee80211_get_channel(priv->wdev.wiphy, freq);
+
+		if (chan && !(chan->flags & IEEE80211_CHAN_DISABLED)) {
+			bss = cfg80211_inform_bss(priv->wdev.wiphy, chan,
+						  CFG80211_BSS_FTYPE_UNKNOWN,
+						  bssid, timestamp,
+						  cap_info_bitmap,
+						  beacon_period,
+						  ie_buf, ie_len, rssi,
+						  GFP_ATOMIC);
+			if (bss) {
+				bss_priv = (struct nxpwifi_bss_priv *)bss->priv;
+				bss_priv->band = band;
+				bss_priv->fw_tsf = fw_tsf;
+				bss_desc =
+					&priv->curr_bss_params.bss_descriptor;
+				if (priv->media_connected &&
+				    !memcmp(bssid, bss_desc->mac_address,
+					    ETH_ALEN))
+					nxpwifi_update_curr_bss_params(priv,
+								       bss);
+
+				if ((chan->flags & IEEE80211_CHAN_RADAR) ||
+				    (chan->flags & IEEE80211_CHAN_NO_IR)) {
+					nxpwifi_dbg(adapter, INFO,
+						    "radar or passive channel %d\n",
+						    channel);
+					nxpwifi_save_hidden_ssid_channels(priv,
+									  bss);
+				}
+
+				cfg80211_put_bss(priv->wdev.wiphy, bss);
+			}
+		}
+	} else {
+		nxpwifi_dbg(adapter, WARN, "missing BSS channel IE\n");
+	}
+
+	return 0;
+}
+
+static void nxpwifi_complete_scan(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	adapter->survey_idx = 0;
+	if (adapter->curr_cmd->wait_q_enabled) {
+		adapter->cmd_wait_q.status = 0;
+		if (!priv->scan_request) {
+			nxpwifi_dbg(adapter, INFO,
+				    "complete internal scan\n");
+			nxpwifi_complete_cmd(adapter, adapter->curr_cmd);
+		}
+	}
+}
+
+/* This function checks if any hidden SSID found in passive scan channels
+ * and do specific SSID active scan for those channels
+ */
+static int
+nxpwifi_active_scan_req_for_passive_chan(struct nxpwifi_private *priv)
+{
+	int ret;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 id = 0;
+	struct nxpwifi_user_scan_cfg  *user_scan_cfg;
+
+	if (adapter->active_scan_triggered || !priv->scan_request ||
+	    priv->scan_aborting) {
+		adapter->active_scan_triggered = false;
+		return 0;
+	}
+
+	if (!priv->hidden_chan[0].chan_number) {
+		nxpwifi_dbg(adapter, INFO, "No BSS with hidden SSID found on DFS channels\n");
+		return 0;
+	}
+	user_scan_cfg = kzalloc(sizeof(*user_scan_cfg), GFP_KERNEL);
+
+	if (!user_scan_cfg)
+		return -ENOMEM;
+
+	for (id = 0; id < NXPWIFI_USER_SCAN_CHAN_MAX; id++) {
+		if (!priv->hidden_chan[id].chan_number)
+			break;
+		memcpy(&user_scan_cfg->chan_list[id],
+		       &priv->hidden_chan[id],
+		       sizeof(struct nxpwifi_user_scan_chan));
+	}
+
+	adapter->active_scan_triggered = true;
+	if (priv->scan_request->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
+		ether_addr_copy(user_scan_cfg->random_mac,
+				priv->scan_request->mac_addr);
+	user_scan_cfg->num_ssids = priv->scan_request->n_ssids;
+	user_scan_cfg->ssid_list = priv->scan_request->ssids;
+
+	ret = nxpwifi_scan_networks(priv, user_scan_cfg);
+	kfree(user_scan_cfg);
+
+	memset(&priv->hidden_chan, 0, sizeof(priv->hidden_chan));
+
+	if (ret)
+		dev_err(priv->adapter->dev, "scan failed: %d\n", ret);
+
+	return ret;
+}
+
+static void nxpwifi_check_next_scan_command(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct cmd_ctrl_node *cmd_node;
+
+	spin_lock_bh(&adapter->scan_pending_q_lock);
+	if (list_empty(&adapter->scan_pending_q)) {
+		spin_unlock_bh(&adapter->scan_pending_q_lock);
+
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		adapter->scan_processing = false;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+
+		nxpwifi_active_scan_req_for_passive_chan(priv);
+
+		if (!adapter->ext_scan)
+			nxpwifi_complete_scan(priv);
+
+		if (priv->scan_request) {
+			struct cfg80211_scan_info info = {
+				.aborted = false,
+			};
+
+			nxpwifi_dbg(adapter, INFO,
+				    "info: notifying scan done\n");
+			cfg80211_scan_done(priv->scan_request, &info);
+			priv->scan_request = NULL;
+			priv->scan_aborting = false;
+		} else {
+			priv->scan_aborting = false;
+			nxpwifi_dbg(adapter, INFO,
+				    "info: scan already aborted\n");
+		}
+	} else if ((priv->scan_aborting && !priv->scan_request) ||
+		   priv->scan_block) {
+		spin_unlock_bh(&adapter->scan_pending_q_lock);
+
+		nxpwifi_cancel_pending_scan_cmd(adapter);
+
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		adapter->scan_processing = false;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+
+		if (!adapter->active_scan_triggered) {
+			if (priv->scan_request) {
+				struct cfg80211_scan_info info = {
+					.aborted = true,
+				};
+
+				nxpwifi_dbg(adapter, INFO,
+					    "info: aborting scan\n");
+				cfg80211_scan_done(priv->scan_request, &info);
+				priv->scan_request = NULL;
+				priv->scan_aborting = false;
+			} else {
+				priv->scan_aborting = false;
+				nxpwifi_dbg(adapter, INFO,
+					    "info: scan already aborted\n");
+			}
+		}
+	} else {
+		/* Get scan command from scan_pending_q and put to
+		 * cmd_pending_q
+		 */
+		cmd_node = list_first_entry(&adapter->scan_pending_q,
+					    struct cmd_ctrl_node, list);
+		list_del(&cmd_node->list);
+		spin_unlock_bh(&adapter->scan_pending_q_lock);
+		nxpwifi_insert_cmd_to_pending_q(adapter, cmd_node);
+	}
+}
+
+void nxpwifi_cancel_scan(struct nxpwifi_adapter *adapter)
+{
+	struct nxpwifi_private *priv;
+	int i;
+
+	nxpwifi_cancel_pending_scan_cmd(adapter);
+
+	if (adapter->scan_processing) {
+		spin_lock_bh(&adapter->nxpwifi_cmd_lock);
+		adapter->scan_processing = false;
+		spin_unlock_bh(&adapter->nxpwifi_cmd_lock);
+		for (i = 0; i < adapter->priv_num; i++) {
+			priv = adapter->priv[i];
+			if (priv->scan_request) {
+				struct cfg80211_scan_info info = {
+					.aborted = true,
+				};
+
+				nxpwifi_dbg(adapter, INFO,
+					    "info: aborting scan\n");
+				cfg80211_scan_done(priv->scan_request, &info);
+				priv->scan_request = NULL;
+				priv->scan_aborting = false;
+			}
+		}
+	}
+}
+
+/* This function handles the command response of scan.
+ *
+ * The response buffer for the scan command has the following
+ * memory layout:
+ *
+ *      .-------------------------------------------------------------.
+ *      |  Header (4 * sizeof(t_u16)):  Standard command response hdr |
+ *      .-------------------------------------------------------------.
+ *      |  BufSize (t_u16) : sizeof the BSS Description data          |
+ *      .-------------------------------------------------------------.
+ *      |  NumOfSet (t_u8) : Number of BSS Descs returned             |
+ *      .-------------------------------------------------------------.
+ *      |  BSSDescription data (variable, size given in BufSize)      |
+ *      .-------------------------------------------------------------.
+ *      |  TLV data (variable, size calculated using Header->Size,    |
+ *      |            BufSize and sizeof the fixed fields above)       |
+ *      .-------------------------------------------------------------.
+ */
+int nxpwifi_ret_802_11_scan(struct nxpwifi_private *priv,
+			    struct host_cmd_ds_command *resp)
+{
+	int ret = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_802_11_scan_rsp *scan_rsp;
+	struct nxpwifi_ie_types_data *tlv_data;
+	struct nxpwifi_ie_types_tsf_timestamp *tsf_tlv;
+	u8 *bss_info;
+	u32 scan_resp_size;
+	u32 bytes_left;
+	u32 idx;
+	u32 tlv_buf_size;
+	struct nxpwifi_ie_types_chan_band_list_param_set *chan_band_tlv;
+	struct chan_band_param_set *chan_band;
+	u8 is_bgscan_resp;
+	__le64 fw_tsf = 0;
+	u8 *radio_type;
+	struct cfg80211_wowlan_nd_match *pmatch;
+	struct cfg80211_sched_scan_request *nd_config = NULL;
+
+	is_bgscan_resp = (le16_to_cpu(resp->command)
+			  == HOST_CMD_802_11_BG_SCAN_QUERY);
+	if (is_bgscan_resp)
+		scan_rsp = &resp->params.bg_scan_query_resp.scan_resp;
+	else
+		scan_rsp = &resp->params.scan_resp;
+
+	if (scan_rsp->number_of_sets > NXPWIFI_MAX_AP) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "SCAN_RESP: too many AP returned (%d)\n",
+			    scan_rsp->number_of_sets);
+		ret = -EINVAL;
+		goto check_next_scan;
+	}
+
+	/* Check csa channel expiry before parsing scan response */
+	nxpwifi_11h_get_csa_closed_channel(priv);
+
+	bytes_left = le16_to_cpu(scan_rsp->bss_descript_size);
+	nxpwifi_dbg(adapter, INFO,
+		    "info: SCAN_RESP: bss_descript_size %d\n",
+		    bytes_left);
+
+	scan_resp_size = le16_to_cpu(resp->size);
+
+	nxpwifi_dbg(adapter, INFO,
+		    "info: SCAN_RESP: returned %d APs before parsing\n",
+		    scan_rsp->number_of_sets);
+
+	bss_info = scan_rsp->bss_desc_and_tlv_buffer;
+
+	/* The size of the TLV buffer is equal to the entire command response
+	 *   size (scan_resp_size) minus the fixed fields (sizeof()'s), the
+	 *   BSS Descriptions (bss_descript_size as bytesLef) and the command
+	 *   response header (S_DS_GEN)
+	 */
+	tlv_buf_size = scan_resp_size - (bytes_left
+					 + sizeof(scan_rsp->bss_descript_size)
+					 + sizeof(scan_rsp->number_of_sets)
+					 + S_DS_GEN);
+
+	tlv_data = (struct nxpwifi_ie_types_data *)
+		(scan_rsp->bss_desc_and_tlv_buffer + bytes_left);
+
+	/* Search the TLV buffer space in the scan response for any valid
+	 * TLVs
+	 */
+	nxpwifi_ret_802_11_scan_get_tlv_ptrs(adapter, tlv_data, tlv_buf_size,
+					     TLV_TYPE_TSFTIMESTAMP,
+					     (struct nxpwifi_ie_types_data **)
+					     &tsf_tlv);
+
+	/* Search the TLV buffer space in the scan response for any valid
+	 * TLVs
+	 */
+	nxpwifi_ret_802_11_scan_get_tlv_ptrs(adapter, tlv_data, tlv_buf_size,
+					     TLV_TYPE_CHANNELBANDLIST,
+					     (struct nxpwifi_ie_types_data **)
+					     &chan_band_tlv);
+
+#ifdef CONFIG_PM
+	if (priv->wdev.wiphy->wowlan_config)
+		nd_config = priv->wdev.wiphy->wowlan_config->nd_config;
+#endif
+
+	if (nd_config) {
+		adapter->nd_info =
+			kzalloc(struct_size(adapter->nd_info, matches,
+					    scan_rsp->number_of_sets),
+				GFP_ATOMIC);
+
+		if (adapter->nd_info)
+			adapter->nd_info->n_matches = scan_rsp->number_of_sets;
+	}
+
+	for (idx = 0; idx < scan_rsp->number_of_sets && bytes_left; idx++) {
+		/* If the TSF TLV was appended to the scan results, save this
+		 * entry's TSF value in the fw_tsf field. It is the firmware's
+		 * TSF value at the time the beacon or probe response was
+		 * received.
+		 */
+		if (tsf_tlv)
+			memcpy(&fw_tsf, &tsf_tlv->tsf_data[idx * TSF_DATA_SIZE],
+			       sizeof(fw_tsf));
+
+		if (chan_band_tlv) {
+			chan_band = &chan_band_tlv->chan_band_param[idx];
+			radio_type = &chan_band->radio_type;
+		} else {
+			radio_type = NULL;
+		}
+
+		if (chan_band_tlv && adapter->nd_info) {
+			adapter->nd_info->matches[idx] =
+				kzalloc(sizeof(*pmatch) + sizeof(u32),
+					GFP_ATOMIC);
+
+			pmatch = adapter->nd_info->matches[idx];
+
+			if (pmatch) {
+				pmatch->n_channels = 1;
+				pmatch->channels[0] = chan_band->chan_number;
+			}
+		}
+
+		ret = nxpwifi_parse_single_response_buf(priv, &bss_info,
+							&bytes_left,
+							le64_to_cpu(fw_tsf),
+							radio_type, false, 0);
+		if (ret)
+			goto check_next_scan;
+	}
+
+check_next_scan:
+	nxpwifi_check_next_scan_command(priv);
+	return ret;
+}
+
+/* This function prepares an extended scan command to be sent to the firmware
+ *
+ * This uses the scan command configuration sent to the command processing
+ * module in command preparation stage to configure a extended scan command
+ * structure to send to firmware.
+ */
+int nxpwifi_cmd_802_11_scan_ext(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *cmd,
+				void *data_buf)
+{
+	struct host_cmd_ds_802_11_scan_ext *ext_scan = &cmd->params.ext_scan;
+	struct nxpwifi_scan_cmd_config *scan_cfg = data_buf;
+
+	memcpy(ext_scan->tlv_buffer, scan_cfg->tlv_buf, scan_cfg->tlv_buf_len);
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_SCAN_EXT);
+
+	/* Size is equal to the sizeof(fixed portions) + the TLV len + header */
+	cmd->size = cpu_to_le16((u16)(sizeof(ext_scan->reserved)
+				      + scan_cfg->tlv_buf_len + S_DS_GEN));
+
+	return 0;
+}
+
+/* This function prepares an background scan config command to be sent
+ * to the firmware
+ */
+int nxpwifi_cmd_802_11_bg_scan_config(struct nxpwifi_private *priv,
+				      struct host_cmd_ds_command *cmd,
+				      void *data_buf)
+{
+	struct host_cmd_ds_802_11_bg_scan_config *bgscan_config =
+					&cmd->params.bg_scan_config;
+	struct nxpwifi_bg_scan_cfg *bgscan_cfg_in = data_buf;
+	u8 *tlv_pos = bgscan_config->tlv;
+	u8 num_probes;
+	u32 ssid_len, chan_idx, scan_time, scan_type, scan_dur, chan_num;
+	int i;
+	struct nxpwifi_ie_types_num_probes *num_probes_tlv;
+	struct nxpwifi_ie_types_repeat_count *repeat_count_tlv;
+	struct nxpwifi_ie_types_min_rssi_threshold *rssi_threshold_tlv;
+	struct nxpwifi_ie_types_bgscan_start_later *start_later_tlv;
+	struct nxpwifi_ie_types_wildcard_ssid_params *wildcard_ssid_tlv;
+	struct nxpwifi_ie_types_chan_list_param_set *tlv_l;
+	struct nxpwifi_chan_scan_param_set *temp_chan;
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_BG_SCAN_CONFIG);
+	cmd->size = cpu_to_le16(sizeof(*bgscan_config) + S_DS_GEN);
+
+	bgscan_config->action = cpu_to_le16(bgscan_cfg_in->action);
+	bgscan_config->enable = bgscan_cfg_in->enable;
+	bgscan_config->bss_type = bgscan_cfg_in->bss_type;
+	bgscan_config->scan_interval =
+		cpu_to_le32(bgscan_cfg_in->scan_interval);
+	bgscan_config->report_condition =
+		cpu_to_le32(bgscan_cfg_in->report_condition);
+
+	/*  stop sched scan  */
+	if (!bgscan_config->enable)
+		return 0;
+
+	bgscan_config->chan_per_scan = bgscan_cfg_in->chan_per_scan;
+
+	num_probes = (bgscan_cfg_in->num_probes ?
+		bgscan_cfg_in->num_probes : priv->adapter->scan_probes);
+
+	if (num_probes) {
+		num_probes_tlv = (struct nxpwifi_ie_types_num_probes *)tlv_pos;
+		num_probes_tlv->header.type = cpu_to_le16(TLV_TYPE_NUMPROBES);
+		num_probes_tlv->header.len =
+			cpu_to_le16(sizeof(num_probes_tlv->num_probes));
+		num_probes_tlv->num_probes = cpu_to_le16((u16)num_probes);
+
+		tlv_pos += sizeof(num_probes_tlv->header) +
+			le16_to_cpu(num_probes_tlv->header.len);
+	}
+
+	if (bgscan_cfg_in->repeat_count) {
+		repeat_count_tlv =
+			(struct nxpwifi_ie_types_repeat_count *)tlv_pos;
+		repeat_count_tlv->header.type =
+			cpu_to_le16(TLV_TYPE_REPEAT_COUNT);
+		repeat_count_tlv->header.len =
+			cpu_to_le16(sizeof(repeat_count_tlv->repeat_count));
+		repeat_count_tlv->repeat_count =
+			cpu_to_le16(bgscan_cfg_in->repeat_count);
+
+		tlv_pos += sizeof(repeat_count_tlv->header) +
+			le16_to_cpu(repeat_count_tlv->header.len);
+	}
+
+	if (bgscan_cfg_in->rssi_threshold) {
+		rssi_threshold_tlv =
+			(struct nxpwifi_ie_types_min_rssi_threshold *)tlv_pos;
+		rssi_threshold_tlv->header.type =
+			cpu_to_le16(TLV_TYPE_RSSI_LOW);
+		rssi_threshold_tlv->header.len =
+			cpu_to_le16(sizeof(rssi_threshold_tlv->rssi_threshold));
+		rssi_threshold_tlv->rssi_threshold =
+			cpu_to_le16(bgscan_cfg_in->rssi_threshold);
+
+		tlv_pos += sizeof(rssi_threshold_tlv->header) +
+			le16_to_cpu(rssi_threshold_tlv->header.len);
+	}
+
+	for (i = 0; i < bgscan_cfg_in->num_ssids; i++) {
+		ssid_len = bgscan_cfg_in->ssid_list[i].ssid.ssid_len;
+
+		wildcard_ssid_tlv =
+			(struct nxpwifi_ie_types_wildcard_ssid_params *)tlv_pos;
+		wildcard_ssid_tlv->header.type =
+				cpu_to_le16(TLV_TYPE_WILDCARDSSID);
+		wildcard_ssid_tlv->header.len =
+			cpu_to_le16((u16)(ssid_len + sizeof(u8)));
+
+		/* max_ssid_length = 0 tells firmware to perform
+		 * specific scan for the SSID filled, whereas
+		 * max_ssid_length = IEEE80211_MAX_SSID_LEN is for
+		 * wildcard scan.
+		 */
+		if (ssid_len)
+			wildcard_ssid_tlv->max_ssid_length = 0;
+		else
+			wildcard_ssid_tlv->max_ssid_length =
+						IEEE80211_MAX_SSID_LEN;
+
+		memcpy(wildcard_ssid_tlv->ssid,
+		       bgscan_cfg_in->ssid_list[i].ssid.ssid, ssid_len);
+
+		tlv_pos += (sizeof(wildcard_ssid_tlv->header) +
+			le16_to_cpu(wildcard_ssid_tlv->header.len));
+	}
+
+	tlv_l = (struct nxpwifi_ie_types_chan_list_param_set *)tlv_pos;
+
+	if (bgscan_cfg_in->chan_list[0].chan_number) {
+		dev_dbg(priv->adapter->dev, "info: bgscan: Using supplied channel list\n");
+
+		tlv_l->header.type = cpu_to_le16(TLV_TYPE_CHANLIST);
+
+		for (chan_idx = 0;
+		     chan_idx < NXPWIFI_BG_SCAN_CHAN_MAX &&
+		     bgscan_cfg_in->chan_list[chan_idx].chan_number;
+		     chan_idx++) {
+			temp_chan = &tlv_l->chan_scan_param[chan_idx];
+
+			/* Increment the TLV header length by size appended */
+			le16_unaligned_add_cpu(&tlv_l->header.len,
+					       sizeof(*tlv_l->chan_scan_param));
+
+			temp_chan->chan_number =
+				bgscan_cfg_in->chan_list[chan_idx].chan_number;
+			temp_chan->band_cfg =
+				bgscan_cfg_in->chan_list[chan_idx].radio_type;
+
+			scan_type =
+				bgscan_cfg_in->chan_list[chan_idx].scan_type;
+
+			if (scan_type == NXPWIFI_SCAN_TYPE_PASSIVE)
+				temp_chan->chan_scan_mode_bmap |=
+					NXPWIFI_PASSIVE_SCAN;
+			else
+				temp_chan->chan_scan_mode_bmap &=
+					~NXPWIFI_PASSIVE_SCAN;
+
+			scan_time = bgscan_cfg_in->chan_list[chan_idx].scan_time;
+
+			if (scan_time) {
+				scan_dur = (u16)scan_time;
+			} else {
+				scan_dur = (scan_type ==
+					    NXPWIFI_SCAN_TYPE_PASSIVE) ?
+					    priv->adapter->passive_scan_time :
+					    priv->adapter->specific_scan_time;
+			}
+
+			temp_chan->min_scan_time = cpu_to_le16(scan_dur);
+			temp_chan->max_scan_time = cpu_to_le16(scan_dur);
+		}
+	} else {
+		dev_dbg(priv->adapter->dev,
+			"info: bgscan: Creating full region channel list\n");
+		chan_num =
+			nxpwifi_bgscan_create_channel_list
+			(priv, bgscan_cfg_in,
+			 tlv_l->chan_scan_param);
+		le16_unaligned_add_cpu(&tlv_l->header.len,
+				       chan_num *
+				       sizeof(*tlv_l->chan_scan_param));
+	}
+
+	tlv_pos += (sizeof(tlv_l->header)
+			+ le16_to_cpu(tlv_l->header.len));
+
+	if (bgscan_cfg_in->start_later) {
+		start_later_tlv =
+			(struct nxpwifi_ie_types_bgscan_start_later *)tlv_pos;
+		start_later_tlv->header.type =
+			cpu_to_le16(TLV_TYPE_BGSCAN_START_LATER);
+		start_later_tlv->header.len =
+			cpu_to_le16(sizeof(start_later_tlv->start_later));
+		start_later_tlv->start_later =
+			cpu_to_le16(bgscan_cfg_in->start_later);
+
+		tlv_pos += sizeof(start_later_tlv->header) +
+			le16_to_cpu(start_later_tlv->header.len);
+	}
+
+	/* Append vendor specific IE TLV */
+	nxpwifi_cmd_append_vsie_tlv(priv, NXPWIFI_VSIE_MASK_BGSCAN, &tlv_pos);
+
+	le16_unaligned_add_cpu(&cmd->size, tlv_pos - bgscan_config->tlv);
+
+	return 0;
+}
+
+int nxpwifi_stop_bg_scan(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_bg_scan_cfg *bgscan_cfg;
+	int ret;
+
+	if (!priv->sched_scanning) {
+		dev_dbg(priv->adapter->dev, "bgscan already stopped!\n");
+		return 0;
+	}
+
+	bgscan_cfg = kzalloc(sizeof(*bgscan_cfg), GFP_KERNEL);
+	if (!bgscan_cfg)
+		return -ENOMEM;
+
+	bgscan_cfg->bss_type = NXPWIFI_BSS_MODE_INFRA;
+	bgscan_cfg->action = NXPWIFI_BGSCAN_ACT_SET;
+	bgscan_cfg->enable = false;
+
+	ret = nxpwifi_send_cmd(priv, HOST_CMD_802_11_BG_SCAN_CONFIG,
+			       HOST_ACT_GEN_SET, 0, bgscan_cfg, true);
+	if (!ret)
+		priv->sched_scanning = false;
+
+	kfree(bgscan_cfg);
+	return ret;
+}
+
+static void
+nxpwifi_update_chan_statistics(struct nxpwifi_private *priv,
+			       struct nxpwifi_ietypes_chanstats *tlv_stat)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 i, num_chan;
+	struct nxpwifi_fw_chan_stats *fw_chan_stats;
+	struct nxpwifi_chan_stats chan_stats;
+
+	fw_chan_stats = (void *)((u8 *)tlv_stat +
+			      sizeof(struct nxpwifi_ie_types_header));
+	num_chan = le16_to_cpu(tlv_stat->header.len) /
+					      sizeof(struct nxpwifi_chan_stats);
+
+	for (i = 0 ; i < num_chan; i++) {
+		if (adapter->survey_idx >= adapter->num_in_chan_stats) {
+			nxpwifi_dbg(adapter, WARN,
+				    "FW reported too many channel results (max %d)\n",
+				    adapter->num_in_chan_stats);
+			return;
+		}
+		chan_stats.chan_num = fw_chan_stats->chan_num;
+		chan_stats.bandcfg = fw_chan_stats->bandcfg;
+		chan_stats.flags = fw_chan_stats->flags;
+		chan_stats.noise = fw_chan_stats->noise;
+		chan_stats.total_bss = le16_to_cpu(fw_chan_stats->total_bss);
+		chan_stats.cca_scan_dur =
+				       le16_to_cpu(fw_chan_stats->cca_scan_dur);
+		chan_stats.cca_busy_dur =
+				       le16_to_cpu(fw_chan_stats->cca_busy_dur);
+		nxpwifi_dbg(adapter, INFO,
+			    "chan=%d, noise=%d, total_network=%d scan_duration=%d, busy_duration=%d\n",
+			    chan_stats.chan_num,
+			    chan_stats.noise,
+			    chan_stats.total_bss,
+			    chan_stats.cca_scan_dur,
+			    chan_stats.cca_busy_dur);
+		memcpy(&adapter->chan_stats[adapter->survey_idx++], &chan_stats,
+		       sizeof(struct nxpwifi_chan_stats));
+		fw_chan_stats++;
+	}
+}
+
+/* This function handles the command response of extended scan */
+int nxpwifi_ret_802_11_scan_ext(struct nxpwifi_private *priv,
+				struct host_cmd_ds_command *resp)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_ds_802_11_scan_ext *ext_scan_resp;
+	struct nxpwifi_ie_types_header *tlv;
+	struct nxpwifi_ietypes_chanstats *tlv_stat;
+	u16 buf_left, type, len;
+
+	struct host_cmd_ds_command *cmd_ptr;
+	struct cmd_ctrl_node *cmd_node;
+	bool complete_scan = false;
+
+	nxpwifi_dbg(adapter, INFO, "info: EXT scan returns successfully\n");
+
+	ext_scan_resp = &resp->params.ext_scan;
+
+	tlv = (void *)ext_scan_resp->tlv_buffer;
+	buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN);
+
+	while (buf_left >= sizeof(struct nxpwifi_ie_types_header)) {
+		type = le16_to_cpu(tlv->type);
+		len = le16_to_cpu(tlv->len);
+
+		if (buf_left < (sizeof(struct nxpwifi_ie_types_header) + len)) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "error processing scan response TLVs");
+			break;
+		}
+
+		switch (type) {
+		case TLV_TYPE_CHANNEL_STATS:
+			tlv_stat = (void *)tlv;
+			nxpwifi_update_chan_statistics(priv, tlv_stat);
+			break;
+		default:
+			break;
+		}
+
+		buf_left -= len + sizeof(struct nxpwifi_ie_types_header);
+		tlv = (void *)((u8 *)tlv + len +
+			       sizeof(struct nxpwifi_ie_types_header));
+	}
+
+	spin_lock_bh(&adapter->cmd_pending_q_lock);
+	spin_lock_bh(&adapter->scan_pending_q_lock);
+	if (list_empty(&adapter->scan_pending_q)) {
+		complete_scan = true;
+		list_for_each_entry(cmd_node, &adapter->cmd_pending_q, list) {
+			cmd_ptr = (void *)cmd_node->cmd_skb->data;
+			if (le16_to_cpu(cmd_ptr->command) ==
+			    HOST_CMD_802_11_SCAN_EXT) {
+				nxpwifi_dbg(adapter, INFO,
+					    "Scan pending in command pending list");
+				complete_scan = false;
+				break;
+			}
+		}
+	}
+	spin_unlock_bh(&adapter->scan_pending_q_lock);
+	spin_unlock_bh(&adapter->cmd_pending_q_lock);
+
+	if (complete_scan)
+		nxpwifi_complete_scan(priv);
+
+	return 0;
+}
+
+/* This function This function handles the event extended scan report. It
+ * parses extended scan results and informs to cfg80211 stack.
+ */
+int nxpwifi_handle_event_ext_scan_report(struct nxpwifi_private *priv,
+					 void *buf)
+{
+	int ret = 0;
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u8 *bss_info;
+	u32 bytes_left, bytes_left_for_tlv, idx;
+	u16 type, len;
+	struct nxpwifi_ie_types_data *tlv;
+	struct nxpwifi_ie_types_scan_rsp *scan_rsp_tlv;
+	struct nxpwifi_ie_types_scan_inf *scan_info_tlv;
+	u8 *radio_type;
+	u64 fw_tsf = 0;
+	s32 rssi = 0;
+	struct nxpwifi_event_scan_result *event_scan = buf;
+	u8 num_of_set = event_scan->num_of_set;
+	u8 *scan_resp = buf + sizeof(struct nxpwifi_event_scan_result);
+	u16 scan_resp_size = le16_to_cpu(event_scan->buf_size);
+
+	if (num_of_set > NXPWIFI_MAX_AP) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "EXT_SCAN: Invalid number of AP returned (%d)!!\n",
+			    num_of_set);
+		ret = -EINVAL;
+		goto check_next_scan;
+	}
+
+	bytes_left = scan_resp_size;
+	nxpwifi_dbg(adapter, INFO,
+		    "EXT_SCAN: size %d, returned %d APs...",
+		    scan_resp_size, num_of_set);
+	nxpwifi_dbg_dump(adapter, CMD_D, "EXT_SCAN buffer:", buf,
+			 scan_resp_size +
+			 sizeof(struct nxpwifi_event_scan_result));
+
+	tlv = (struct nxpwifi_ie_types_data *)scan_resp;
+
+	for (idx = 0; idx < num_of_set && bytes_left; idx++) {
+		type = le16_to_cpu(tlv->header.type);
+		len = le16_to_cpu(tlv->header.len);
+		if (bytes_left < sizeof(struct nxpwifi_ie_types_header) + len) {
+			nxpwifi_dbg(adapter, ERROR,
+				    "EXT_SCAN: Error bytes left < TLV length\n");
+			break;
+		}
+		scan_rsp_tlv = NULL;
+		scan_info_tlv = NULL;
+		bytes_left_for_tlv = bytes_left;
+
+		/* BSS response TLV with beacon or probe response buffer
+		 * at the initial position of each descriptor
+		 */
+		if (type != TLV_TYPE_BSS_SCAN_RSP)
+			break;
+
+		bss_info = (u8 *)tlv;
+		scan_rsp_tlv = (struct nxpwifi_ie_types_scan_rsp *)tlv;
+		tlv = (struct nxpwifi_ie_types_data *)(tlv->data + len);
+		bytes_left_for_tlv -=
+			(len + sizeof(struct nxpwifi_ie_types_header));
+
+		while (bytes_left_for_tlv >=
+		       sizeof(struct nxpwifi_ie_types_header) &&
+		       le16_to_cpu(tlv->header.type) != TLV_TYPE_BSS_SCAN_RSP) {
+			type = le16_to_cpu(tlv->header.type);
+			len = le16_to_cpu(tlv->header.len);
+			if (bytes_left_for_tlv <
+			    sizeof(struct nxpwifi_ie_types_header) + len) {
+				nxpwifi_dbg(adapter, ERROR,
+					    "EXT_SCAN: Error in processing TLV,\t"
+					    "bytes left < TLV length\n");
+				scan_rsp_tlv = NULL;
+				bytes_left_for_tlv = 0;
+				continue;
+			}
+			switch (type) {
+			case TLV_TYPE_BSS_SCAN_INFO:
+				scan_info_tlv =
+					(struct nxpwifi_ie_types_scan_inf *)tlv;
+				if (len !=
+				 sizeof(struct nxpwifi_ie_types_scan_inf) -
+				 sizeof(struct nxpwifi_ie_types_header)) {
+					bytes_left_for_tlv = 0;
+					continue;
+				}
+				break;
+			default:
+				break;
+			}
+			tlv = (struct nxpwifi_ie_types_data *)(tlv->data + len);
+			bytes_left -=
+				(len + sizeof(struct nxpwifi_ie_types_header));
+			bytes_left_for_tlv -=
+				(len + sizeof(struct nxpwifi_ie_types_header));
+		}
+
+		if (!scan_rsp_tlv)
+			break;
+
+		/* Advance pointer to the beacon buffer length and
+		 * update the bytes count so that the function
+		 * wlan_interpret_bss_desc_with_ie() can handle the
+		 * scan buffer withut any change
+		 */
+		bss_info += sizeof(u16);
+		bytes_left -= sizeof(u16);
+
+		if (scan_info_tlv) {
+			rssi = (s32)(s16)(le16_to_cpu(scan_info_tlv->rssi));
+			rssi *= 100;           /* Convert dBm to mBm */
+			nxpwifi_dbg(adapter, INFO,
+				    "info: InterpretIE: RSSI=%d\n", rssi);
+			fw_tsf = le64_to_cpu(scan_info_tlv->tsf);
+			radio_type = &scan_info_tlv->radio_type;
+		} else {
+			radio_type = NULL;
+		}
+		ret = nxpwifi_parse_single_response_buf(priv, &bss_info,
+							&bytes_left, fw_tsf,
+							radio_type, true, rssi);
+		if (ret)
+			goto check_next_scan;
+	}
+
+check_next_scan:
+	if (!event_scan->more_event)
+		nxpwifi_check_next_scan_command(priv);
+
+	return ret;
+}
+
+/* This function prepares command for background scan query.
+ *
+ * Preparation includes -
+ *      - Setting command ID and proper size
+ *      - Setting background scan flush parameter
+ *      - Ensuring correct endian-ness
+ */
+int nxpwifi_cmd_802_11_bg_scan_query(struct host_cmd_ds_command *cmd)
+{
+	struct host_cmd_ds_802_11_bg_scan_query *bg_query =
+		&cmd->params.bg_scan_query;
+
+	cmd->command = cpu_to_le16(HOST_CMD_802_11_BG_SCAN_QUERY);
+	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_bg_scan_query)
+				+ S_DS_GEN);
+
+	bg_query->flush = 1;
+
+	return 0;
+}
+
+/* This function inserts scan command node to the scan pending queue.
+ */
+void
+nxpwifi_queue_scan_cmd(struct nxpwifi_private *priv,
+		       struct cmd_ctrl_node *cmd_node)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+
+	cmd_node->wait_q_enabled = true;
+	cmd_node->condition = &adapter->scan_wait_q_woken;
+	spin_lock_bh(&adapter->scan_pending_q_lock);
+	list_add_tail(&cmd_node->list, &adapter->scan_pending_q);
+	spin_unlock_bh(&adapter->scan_pending_q_lock);
+}
+
+/* This function appends the vendor specific IE TLV to a buffer.
+ */
+int
+nxpwifi_cmd_append_vsie_tlv(struct nxpwifi_private *priv,
+			    u16 vsie_mask, u8 **buffer)
+{
+	int id, ret_len = 0;
+	struct nxpwifi_ie_types_vendor_param_set *vs_param_set;
+
+	if (!buffer)
+		return 0;
+	if (!(*buffer))
+		return 0;
+
+	/* Traverse through the saved vendor specific IE array and append
+	 * the selected(scan/assoc) IE as TLV to the command
+	 */
+	for (id = 0; id < NXPWIFI_MAX_VSIE_NUM; id++) {
+		if (priv->vs_ie[id].mask & vsie_mask) {
+			vs_param_set =
+				(struct nxpwifi_ie_types_vendor_param_set *)
+				*buffer;
+			vs_param_set->header.type =
+				cpu_to_le16(TLV_TYPE_PASSTHROUGH);
+			vs_param_set->header.len =
+				cpu_to_le16((((u16)priv->vs_ie[id].ie[1])
+				& 0x00FF) + 2);
+			if (le16_to_cpu(vs_param_set->header.len) >
+				NXPWIFI_MAX_VSIE_LEN) {
+				nxpwifi_dbg(priv->adapter, ERROR,
+					    "Invalid param length!\n");
+				break;
+			}
+
+			memcpy(vs_param_set->ie, priv->vs_ie[id].ie,
+			       le16_to_cpu(vs_param_set->header.len));
+			*buffer += le16_to_cpu(vs_param_set->header.len) +
+				   sizeof(struct nxpwifi_ie_types_header);
+			ret_len += le16_to_cpu(vs_param_set->header.len) +
+				   sizeof(struct nxpwifi_ie_types_header);
+		}
+	}
+	return ret_len;
+}
+
+/* This function saves a beacon buffer of the current BSS descriptor.
+ *
+ * The current beacon buffer is saved so that it can be restored in the
+ * following cases that makes the beacon buffer not to contain the current
+ * ssid's beacon buffer.
+ *      - The current ssid was not found somehow in the last scan.
+ *      - The current ssid was the last entry of the scan table and overloaded.
+ */
+void
+nxpwifi_save_curr_bcn(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_bssdescriptor *curr_bss =
+		&priv->curr_bss_params.bss_descriptor;
+
+	if (!curr_bss->beacon_buf_size)
+		return;
+
+	/* allocate beacon buffer at 1st time; or if it's size has changed */
+	if (!priv->curr_bcn_buf ||
+	    priv->curr_bcn_size != curr_bss->beacon_buf_size) {
+		priv->curr_bcn_size = curr_bss->beacon_buf_size;
+
+		kfree(priv->curr_bcn_buf);
+		priv->curr_bcn_buf = kmalloc(curr_bss->beacon_buf_size,
+					     GFP_ATOMIC);
+		if (!priv->curr_bcn_buf)
+			return;
+	}
+
+	memcpy(priv->curr_bcn_buf, curr_bss->beacon_buf,
+	       curr_bss->beacon_buf_size);
+	nxpwifi_dbg(priv->adapter, INFO,
+		    "info: current beacon saved %d\n",
+		    priv->curr_bcn_size);
+
+	curr_bss->beacon_buf = priv->curr_bcn_buf;
+
+	/* adjust the pointers in the current BSS descriptor */
+	if (curr_bss->bcn_wpa_ie)
+		curr_bss->bcn_wpa_ie =
+			(struct ieee_types_vendor_specific *)
+			(curr_bss->beacon_buf +
+			 curr_bss->wpa_offset);
+
+	if (curr_bss->bcn_rsn_ie)
+		curr_bss->bcn_rsn_ie =
+			(struct element *)(curr_bss->beacon_buf +
+					   curr_bss->rsn_offset);
+
+	if (curr_bss->bcn_ht_cap)
+		curr_bss->bcn_ht_cap = (struct ieee80211_ht_cap *)
+			(curr_bss->beacon_buf +
+			 curr_bss->ht_cap_offset);
+
+	if (curr_bss->bcn_ht_oper)
+		curr_bss->bcn_ht_oper = (struct ieee80211_ht_operation *)
+			(curr_bss->beacon_buf +
+			 curr_bss->ht_info_offset);
+
+	if (curr_bss->bcn_vht_cap)
+		curr_bss->bcn_vht_cap = (void *)(curr_bss->beacon_buf +
+						 curr_bss->vht_cap_offset);
+
+	if (curr_bss->bcn_vht_oper)
+		curr_bss->bcn_vht_oper = (void *)(curr_bss->beacon_buf +
+						  curr_bss->vht_info_offset);
+
+	if (curr_bss->bcn_he_cap)
+		curr_bss->bcn_he_cap = (void *)(curr_bss->beacon_buf +
+						curr_bss->he_cap_offset);
+
+	if (curr_bss->bcn_he_oper)
+		curr_bss->bcn_he_oper = (void *)(curr_bss->beacon_buf +
+						 curr_bss->he_info_offset);
+
+	if (curr_bss->bcn_bss_co_2040)
+		curr_bss->bcn_bss_co_2040 =
+			(curr_bss->beacon_buf + curr_bss->bss_co_2040_offset);
+
+	if (curr_bss->bcn_ext_cap)
+		curr_bss->bcn_ext_cap = curr_bss->beacon_buf +
+			curr_bss->ext_cap_offset;
+
+	if (curr_bss->oper_mode)
+		curr_bss->oper_mode = (void *)(curr_bss->beacon_buf +
+					       curr_bss->oper_mode_offset);
+}
+
+/* This function frees the current BSS descriptor beacon buffer.
+ */
+void
+nxpwifi_free_curr_bcn(struct nxpwifi_private *priv)
+{
+	kfree(priv->curr_bcn_buf);
+	priv->curr_bcn_buf = NULL;
+}
-- 
2.34.1


