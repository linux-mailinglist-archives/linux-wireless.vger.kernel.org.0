Return-Path: <linux-wireless+bounces-29510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A44CA6483
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 07:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3585C306765C
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66942C0262;
	Fri,  5 Dec 2025 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ETFeuSqe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A82DE6F9;
	Fri,  5 Dec 2025 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917836; cv=fail; b=UIqxfxQ17StoJ/pglmPMI9e+KBG/7ekX89jdtdzaZFrtte16MvtWaGp0c2qOBSux1ufmAUVkBXE7+iWxgT/Tu+JfHsqqy0Wf1umRMXB487YtyQAItGm0QFzTrnEyaKzBeaohfRgj7KyQscupEmsgmkOHdkZaTkrrFad0rehLsO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917836; c=relaxed/simple;
	bh=0AVHa5wEo8ltyV8tLzRZPDH0t3Mk7rswCC4JKaF0xYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fo6Y/5N912t9B6XEqvjN7nTMLvrK+2fFtF7f7/H7rQy034LLCTGJVDOQkOmkF9kGneVKVk5I29t5vQYhV+le45khwU9kvwHvWHQfcN9ZkxA3aODZRInB+3WHMaHlgji+U7eJ5E8QwYgxaK0sstw8WKerYiWqb2XyhMOK9hxHAPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ETFeuSqe; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsBoq9YoGo7DMdk+h2n7ddgsrMrH9LaioqBWFfSORsj7Udw4b66pMu53T/mugh0zYmRl1kw2kzOy4xlm5w7yHm7VKYouBG/bVhMp/fsxY50y2IL8G6A2Y9jAdzl4F5bJtyfaiGzxwJQdzMDZ+ZebboipbUGqaIAdWyKKblspvMOEHm+mqxPivAEE82ZEzbZzIyF+0gCzyVvZA48+gM884pKDM9njuI/QJNeyH4WSDZ69gdr9nIBnlCRJ36ZfcYXRs82EdSDdKvL+v9OqCpJL04lt8eFgWr4bQvEMKQjwqPedmgRRZQL1K6hUIiRNbKT4c0n8i1xslLrNOprdWzOOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpjhL3z7E7Dq3LHx3H69ETo9YaLBDNwWfntgT8cVHUU=;
 b=MQYO2QxXblN6PcuAggf9V35LoSENpW6ycBxpkOdmWwkCKosGSumuZJXiEcfJFfyguPo3AUtVQgZuZ669KpMUJ3BfFEWp5Sqb1xNTAicCFov8zcNKt2ea4KrZizXlfMYQvo4xao56ySPOurSpfAY5nMawLnHsREnYQO3DuU0y+B3IlC+9lRMOqtA7bD4VKL9B47/tTY5bq1cl2YEyuXRfzrjZKSR+uMeLXruAvSxPSPNJwMx1Mdrs/2CnAlKwsNKC5dX6CthlipZ5nlsYJhpdVBD/X0qE7DmcVboZ5sdpetE51OzK0+NpKLW5y0imi9WcyGanyql6a3I3YyDs2Xj1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpjhL3z7E7Dq3LHx3H69ETo9YaLBDNwWfntgT8cVHUU=;
 b=ETFeuSqegWuez9zgUurmj4wfMSineaMo6NKXiiGkYMxYBbrljBNRbnTHglRI0Q0sTQVY4nXh4N6BM8xFRsz1XKmhnTOAur2JZbnGus1rVJOgJSXklbHkf2e0Y8nY6wIkKyDY63LVnqcGQQrnzPZao7UYa1EtloihP+z2fhrZciKqFDaXO3oVGnqTiFigUINUMETGSKQrcBJV539ZYotXmLoxtJmijlOMNVIMJCx9lxFfLIGx2VPMLNs8brU9v+BMVuzt9bR9vE+XeNrKasfErp2bLAgCeVjVoS96QO9LwQk596fubupABhLvcR3w6jd7g9gtvqBQtEUcRBRXYFNwaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PA4PR04MB9245.eurprd04.prod.outlook.com (2603:10a6:102:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 06:57:07 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 06:57:07 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v8 02/22] wifi: nxpwifi: add initial support for 802.11ac
Date: Fri,  5 Dec 2025 14:55:25 +0800
Message-Id: <20251205065545.3325032-3-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6744a42-4f4a-41e9-487b-08de33cb810d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qPDdJfimdFpfjFScX0rfNgyn70m4o2JS7FYxiOsL6J4qdRfpbXpzN+dtVCVr?=
 =?us-ascii?Q?rablz8cB167HTdWADpslens8E+Yil/Bc/m+jq7ITVWTof3QxGiBMEvmXYGk7?=
 =?us-ascii?Q?7ppN5rsFgUYaAdPrytpZivYUBaktt9O3lMiyckXdTMYF/VYc5VHwyppB7zm1?=
 =?us-ascii?Q?wgx81xxEYEGqVUqMIzxvEZ0widWskp1+XaoIj21+QYt4bNaoEiRAedauP5zI?=
 =?us-ascii?Q?gEw7lZHSxf0ezMd81FBQmqNdMm5504lR6ObGtt2K3ZGmps82QsDCSDV+2ypa?=
 =?us-ascii?Q?DKniRTfW44XU4fUvmMbfxqOnvCriHkJSbRVJV45nC22hS0BIFv4vw8NAzb1o?=
 =?us-ascii?Q?ZXJdpjjaRLlBuIFX1AhHZ2V9H5oFgENs8dd0U77M6mIc17H2Ck+4SGJn9hlE?=
 =?us-ascii?Q?uSV0/SyNvNjjsLrENzrh48WrijkWb+jhh2gFYly/DAdGy1YfTQD1Ib24eHvn?=
 =?us-ascii?Q?g/ZnJ7zeU1+gI75CBML/s+pufaPqjX+1Eo1RVFAPkGjAOJ3QDwVW+H/2srDi?=
 =?us-ascii?Q?/mCZahmbCSeDdw91ZGzLcWkh2NVRiqK9FEjybu9Hf5SP1cNvTyfY5Vxm6aX7?=
 =?us-ascii?Q?fgBM2rj0v5kxjUys6kKfrUT+FbWOGlz8qxc87gt21MlpX7G+qGUyLeqfkf21?=
 =?us-ascii?Q?6gPoS2B3or2L2mMGziMFQgXsgNQbJeEyPz3u9nVN2nbehNPdWLfRAVyoc51g?=
 =?us-ascii?Q?bWkqPh2R3f1Fk12ImMVtTyJAwnnrBT+C1WubLDphYRdHuwUMr3IUQiYKGevj?=
 =?us-ascii?Q?OF+ZjUcpCjFYkbkoTJW1FWdfC8LdBoaDPkzH1UQ0ugOVHaNUfNYRox5UEDEb?=
 =?us-ascii?Q?arYY/M4Na4lgI9u4sC7WnmmitHjlWWFwiihHz58e634SUivohyNcK/msV0NI?=
 =?us-ascii?Q?eq9/0eFZxkCEpCi5Q932o8IiV5DryPt5lvSKKO3bl+JsyGnjGVhPCWO+Xcfj?=
 =?us-ascii?Q?YnGxmrcclSXet5wEN86Pir1D0KUpwxxwFcLLGv9hlscjl19jOYEjkWoMMbk4?=
 =?us-ascii?Q?T+aqczoECvYuf4qpUCajBEK8tBTl/a0+C1AnPWdU6taTWY5vN9bRRQ6DPTcN?=
 =?us-ascii?Q?SYjHvhUvBjt5UMjtQ1YSdHpWu4+JA7HnrJ30nlrK1Ad5uFL1HZbHFxO+AwER?=
 =?us-ascii?Q?1jWs8dGEjknXioVxql+AmJ5+TcnXD08dFPOvlUaF6xillcRO7xL9WWfUZZUL?=
 =?us-ascii?Q?gn3SOTeF+hy/ipEdxRHQCmYkQVYZnAdc+9KD3/wj9FOm9OJ/aXmcI0mhCXbi?=
 =?us-ascii?Q?OCX0BFErkHIEpIGWbI9MTckoQ0rASBK2JNZtXUWrMbaRds6EPmBkKdmg/U8I?=
 =?us-ascii?Q?mdYHyroja2mXbpOt9vDWiZJiUdym8dzJU+IrBtnW2WO5TmR+KNq++fkJqZFU?=
 =?us-ascii?Q?t/BhVGYyQEA0KJ6G4YdzxoOfRO1mm8FcIWB1d/ZIKkxeDnPUiyhCneW/C0/X?=
 =?us-ascii?Q?q3ZlPsY4C4hY1EvRSy5G5/gfevAkLkBlsK3UW67xBRNsKCfI7cLQXqaOpbUh?=
 =?us-ascii?Q?N3szLxVZeV3h9t6XBzheu1qBBtf/glik9Nd5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NkcynGnHOAUJ3TEiltmbKz8HPzIihPKfgwQiU9B3pUBzQoHHp/oZfQVeCkVL?=
 =?us-ascii?Q?dsVXTyRN+WDBr8kCBcBcqqEEvnmT8Byt8p+MmNqAHWdbBhf0IvL+9kOoSTL9?=
 =?us-ascii?Q?8n9LBfiJ4cs1iuD116bEKzjaJdR01Hke81s0cGV8wodlXdrH2M5ss+t/juIV?=
 =?us-ascii?Q?ml01u1xOR/BnS4mLrf89UC8xvzLuGlQKKc1Xowe86gybKfWwIyaz3QN2YeRu?=
 =?us-ascii?Q?YJnfkvwAejvc/glJD6YrLUrFnlG9jPsFwdOEjWBL6RUVm+pFLgIxfd/E/Dco?=
 =?us-ascii?Q?L8OdYZtHgSHIWCBRW0SPiulTlGv1A8lKKywiBBS7T49uMVjYJ4xa4o8VqF2o?=
 =?us-ascii?Q?xzfKewEb8cOUY/LC94VkzBuUyzM4RNtcLFIX8u33XS/dgfjvPmQebhVZOrYM?=
 =?us-ascii?Q?A9v0b3LdfW+pXbq0+TxlJb1FyLrzwWosL4VRjrZL/TjefRCofpx4Xiys4j/1?=
 =?us-ascii?Q?OGa3xazVabUa39qzN+CnHJE+sLe5S0MKbECkaw1bz/UJLoGWxm3JmAqZt2az?=
 =?us-ascii?Q?1dHaBWhRl6LCtloefQwv8BRnTyhWea/3igJwpu7N0RQUEB2L0CofDLnobI7X?=
 =?us-ascii?Q?CY8dKP3jagd97BzNHM1FUY1u/O57D1DvK9wd2Gpg359MegHQtT3k0Ve3HeHM?=
 =?us-ascii?Q?E7uh6BhB9ObdAxMNE9On9+mc7b6aeidVoHmOq0fMVX551JQA5YyABo/h5N/q?=
 =?us-ascii?Q?PImeP2YUBRaB8kT1JTvWMEZfBHMtPgvcE7tJU6uCL9UP0DW+Ydlac5N2smo6?=
 =?us-ascii?Q?8lRbRXotNje0T5yUO6lFbaNhfOovhG6/vZKyVAg1PL2jRLkwzr4Y+W4ig+2a?=
 =?us-ascii?Q?8ch+Tx/Pl/soIVmV7H/Y0b02+NT8uv3WhVHiS6Y1KU7VYNs3n5We7UDGdTy5?=
 =?us-ascii?Q?yi/bHdzzuII7I5yWneV3TTkL+SFJBkD/i269Qht3popaOuxNlhpoADDQk3Zp?=
 =?us-ascii?Q?7xkrutnR/QQDSiATVN4AwKLcV+SAqyx6HSXMB/YfVqKzxYtAAiWc3rqG3Tz2?=
 =?us-ascii?Q?5jWuqioRTUR8vnLAltehcorTM8dnYt5mnpS6GKJGUhSUH/tbXEndCwEK1Pgq?=
 =?us-ascii?Q?J1ZhF71EoiopWIuW2C8G+AsuG32coVnrkFxCd8dSEH4qyI7/V8zwvRaO9rTM?=
 =?us-ascii?Q?F0/sHOdVDQo9MSQ/PWGaknOaYc1WFkJc3R+ddpvl7eTAsb+vOrblaAoL1Vwg?=
 =?us-ascii?Q?mU+IoY42ir/VYuYEMrr5Ll7uMhp+yPXSp3wJB8bLRyuBcNRWHiFIHF2ijS3G?=
 =?us-ascii?Q?FkbbABP/7nQ6ByOjMY7TsnSbzYnvieHbU9d4z45fOXe/1HaZvszKWD0DUFTo?=
 =?us-ascii?Q?ZVGVCsorSUnsXDolMePw1TTaJb6gxcle6/ObcXA1mKDcZ4O27nOIqVydt9Op?=
 =?us-ascii?Q?siLa1amf/TdbuBkGG1aY1iKSAkDSFPDVbvPprLGeKwG5jjg/I1TxJKUFLqWf?=
 =?us-ascii?Q?uLZqUOOT37dw93jSZogfAqAmbosM2g/zcnfSaZG1fyn3RFCzyXBRZWGqiqP3?=
 =?us-ascii?Q?Y+nm+RZ6+ppl0LfcYceJPuRe8j9d8ctmnMYWwc3MqGjelJMAdrIBGNOwJMUI?=
 =?us-ascii?Q?KwxwPar3qzNbfdCBdEieRnhkFlEU2FKZCcSIH0q9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6744a42-4f4a-41e9-487b-08de33cb810d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:57:07.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M49HoSJ5wqjIdtvb+B+3CZhQyDg9S2aPY0hYtsNqYP8+1UYUx2BOzmD2/cjUHW8uJQRBrBFD4SmRWmplHwOPRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9245

Introduce 802.11ac feature support for both client and AP modes,
with coordination between host driver and NXP firmware.

- In client mode, the firmware assists the association process via
  HOST_CMD_802_11_ASSOCIATE. The driver converts 802.11ac IEs from
  cfg80211 parameters into TLVs and appends them to the host command.

- In AP mode, the driver converts 802.11ac IEs into parameters for
  HOST_CMD_11AC_CFG, which are then passed to the firmware for
  configuration.

This patch adds logic to handle VHT capabilities, operations, and
operating mode notifications, enabling proper negotiation and setup
of 802.11ac features through firmware interaction.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 293 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  33 +++
 2 files changed, 326 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..6cf69abbd8c0
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ac
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ac.h"
+
+/*
+ * Tables of the MCS map to the highest data rate (in Mbps) supported
+ * for long GI.
+ */
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
+/*
+ * This function converts the 2-bit MCS map to the highest long GI
+ * VHT data rate.
+ */
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
+	/* find the max NSS supported */
+	nss = 1;
+	for (i = 1; i <= 8; i++) {
+		mcs = GET_VHTNSSMCS(mcs_map, i);
+		if (mcs < IEEE80211_VHT_MCS_NOT_SUPPORTED)
+			nss = i;
+	}
+	mcs = GET_VHTNSSMCS(mcs_map, nss);
+
+	/* if mcs is 3, nss must be 1 (NSS = 1). Default mcs to MCS 0~9 */
+	if (mcs == IEEE80211_VHT_MCS_NOT_SUPPORTED)
+		mcs = IEEE80211_VHT_MCS_SUPPORT_0_9;
+
+	if (u32_get_bits(usr_vht_cap_info, IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK)) {
+		/* support 160 MHz */
+		max_rate = max_rate_lgi_160MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 is not supported in NSS6 */
+			max_rate = max_rate_lgi_160MHZ[nss - 1][mcs - 1];
+	} else {
+		max_rate = max_rate_lgi_80MHZ[nss - 1][mcs];
+		if (!max_rate)
+			/* MCS9 is not supported in NSS3 */
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
+	/* Fill VHT cap info */
+	nxpwifi_fill_vht_cap_info(priv, vht_cap, bands);
+
+	/* rx MCS Set: find the minimum of the user rx mcs and ap rx mcs */
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
+	/* tx MCS Set: find the minimum of the user tx mcs and ap tx mcs */
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
+	/* VHT Capabilities element */
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
+	/* VHT Operation element */
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
+			/*
+			 * negotiate the channel width and central freq
+			 * and keep the central freq as the peer suggests
+			 */
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
+	/* Operating Mode Notification element */
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
+/*
+ * This function initializes the BlockACK setup information for given
+ * nxpwifi_private structure for 11ac enabled networks.
+ */
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
index 000000000000..6fc72fab251e
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11ac
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


