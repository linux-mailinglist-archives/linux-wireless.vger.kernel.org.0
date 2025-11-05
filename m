Return-Path: <linux-wireless+bounces-28581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC906C353EA
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0628468895
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D4830DEB5;
	Wed,  5 Nov 2025 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PiohkE6P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC930DEDD;
	Wed,  5 Nov 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339753; cv=fail; b=BrPFkI2+0jQqbWccFjmYrT2uq5YIT5SY1+nOUYJAhWupwNJxPtNHXm9EdWjNEtNP/JBOEAlXwmHZupq+2Lpn1KgTPDtkIEM7SMX8HqQQ67w/c1D1hRom5X5rruwzAJDxqRQHQ/iKYk6wsyZDXiO4Xy3SLLQu7aIKCQhbQfATzUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339753; c=relaxed/simple;
	bh=eUZtNrkF0dwI2GgxGyzi+rS4Z8yD4zEbrHntvMoncbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdLCaJxYQi/SPBzQjoP1jzUgxUjMd07zfhgt3e6KyhJ1OLuqfq9WgOtAFZgA3ShGIi7jQxKjTP5Hkl4SkY/fci5Rrbs58uupefBON0jmsoYHNwQOIvjPaPw3pKEQAbUglVrY4n1Wr0vMoFGH5qj6b2++t7e2stNMO8veWkltJHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PiohkE6P; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMCEKuWVRdUFIUW1M/TjPBheHeyQg2pGARfqIx49E08bOrM1WL+NowWfxLD7ribgtVRG0LLIEC33AQSvP48KuTtXD7GhyGqNckr06QapYyb7tHAFVZgUfpTF4uPMTyGy2Vx+s9qi3M3CXoSI3gTnC/dDP92mm83eHPTL8Z59TRj6fUa7wQS3tTKfwj1eIJ/Lj1Tf03nIZMb/6U4vyzG5k0DUUpeCwER0qBoQ257t3LrND2S8yfKiy8Cp6KxLBCkQ7WQG8Hcy96ackX7e5++AqLfVzA/6lAvSOhcw7CmJTQmqYq8kkHv4auVDRzVFpjv94e5xUaeoLetRQZtjgPmRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03cID/TAq5SEHMtx0/2dash1asebZSDmAazOz1BXFzo=;
 b=f2wLAcEYTXul6PDNGGzD6W0a53fapaaJmTgbK4QZsXVXkH2ToEwBzFbWBjjBVkO5iAwH1cizDLaZjrmNY9iyrl8+WFxyBOuysYX3l3w6VMfXHfDqauwg3os1thiDcC+8sDLeQEYfTaN7YQUJFQjQzQkxZJCucpESoqLzIxEs4ovDRY+zoqGq7BQJIciffjJu2ld4tLl21bt2tNoa3qY64n94Jxu0OwjDusE52BA8fpET3w8wulneA8deP9wPUMQvyp/zeI59vZNhtosMALHewZ6/fXOLEXApGHkibyFncPkuMicn2OjTHjB0lEq8Y9BUPBaYkMg18F+7qTcR9ahc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03cID/TAq5SEHMtx0/2dash1asebZSDmAazOz1BXFzo=;
 b=PiohkE6PAXVx3dglO/ODnUSFWhjTZycGGUlgqGvw3cqINUg7YJ4j7np+sJqvpM8ZHEtsJg2QdmFelxP/NOVgzsK7OMC9lUaVAaaD8R6FmaXJPCfAtf/cUa4eBHuDPj0Vu9+vu+sAmkmCfMTCvWP8DO66FtFhvbZ8KkoMLM9Jw7st17z8N1fwAPXkK6NHLMMd2P3nquhEfzF0v+gjegZRboxq29ezgIoPWf2ps1Hl764RkVsOnbMQw8K8I4JT6FYl0hHEIax8O0wg7eRJ0LjR4k+R61T1M1hJEnpRl/3SE4JKVR12eKYfBdgmECHPkvNtOX8vFy2vBmIFnKbv9HfEcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA4PR04MB9293.eurprd04.prod.outlook.com (2603:10a6:102:2a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 10:49:05 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:49:05 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 03/22] wifi: nxpwifi: add initial support for 802.11ax
Date: Wed,  5 Nov 2025 18:47:25 +0800
Message-Id: <20251105104744.2401992-4-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA4PR04MB9293:EE_
X-MS-Office365-Filtering-Correlation-Id: d82a98ba-2766-4e35-db19-08de1c58f03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Mg8aWICPsfUe/2uvfr1mtdJwwgfAXmipnS4ejHQFlJsNaOiiLkXT/rD/JiK?=
 =?us-ascii?Q?4gcs1tKWZBE3Y+6w7FonwnOo33IVAzYwWLUbsI5RduD01R5rnJXwBRqGTNHf?=
 =?us-ascii?Q?QanIa0SDV+URnIWzzNH9ojRyzQ8zm9Wu8VvwPLaX1ojk5fQvq0tZCIqqPrDg?=
 =?us-ascii?Q?Q4bOAU3h8WYorXRuo68dAJ1ShDYFTIVooMY88QvI52XKsKzFwpg/gCgLD2Dv?=
 =?us-ascii?Q?y8JYwQaoY8Tlae/Rmd+4MbOR5RpuJfZgcLxY7ZEGghIAcrxd9IiEDdTzflml?=
 =?us-ascii?Q?CnLR3J/R5Y1lSElkoANWxcRKN8VyzQcTj2R9AeWHEkDFT30pXf3aLvXsWQ3f?=
 =?us-ascii?Q?PAiVrttY86d+FcxJFk6NxzNaN3oSUcg2kku0UMUA30VPkegDy+P+QJyEie2e?=
 =?us-ascii?Q?D4m21jpcpj1gYpionjl6SSZBY/3YPk0bMnecFEk5FPiPuu2LYz/P13M7sIax?=
 =?us-ascii?Q?hvx1FSAgytmlGIM3G9a/cL8aD4Vyt6Uh/dzA+4qwryrFGR8RxJDs/9e5cqom?=
 =?us-ascii?Q?Y3dnbpJLRG9bcH+2o0jSnlezRWiSJlfSvi7Fb2Hn3GLpRS5A+5KO1HUcFAb6?=
 =?us-ascii?Q?GbhpU8nuzu5iDyl5nxazh3ZCznQm/FMdtSddDEiMY/EtFm0eFiglRscyz0Ar?=
 =?us-ascii?Q?nc+mgM+i/AWj03h6mf51nudA02+q8b1o5r2Si1CrzcuIdIPWdUb9rY3abh6H?=
 =?us-ascii?Q?Mrk1b2y35Bgv9x4rYJMLPTsHNLuigoczRm5cX+RSoGK3S8aE/xxke41s2BSj?=
 =?us-ascii?Q?Uhwb+RUK9g9R+5vDpl3igWBDGlD+Us7vsN9jQFnERuugDIvnBM2ROvGkP3Lr?=
 =?us-ascii?Q?n4G11JFMYxOLfr9mhkojsNUNF6dtF21JNgBUxHGD6Wd4V54n3bmuk+i1QGc+?=
 =?us-ascii?Q?omIcRIJiAWtYPqofRc7SuIJDa94Ydlbj3q0YKhH6ea+iMzV4LXOLUU2QDUMX?=
 =?us-ascii?Q?BDuMvMbPViQS3cncFDEOYOfJO1xout64TWTMBCcTnWMnGekWcILE3VVkCU8t?=
 =?us-ascii?Q?UxgKb7cyjg8rydi+UJHqkK5OfJuQ9os2pSD9S7xVO9yhlj995mqh9Pqe6uL+?=
 =?us-ascii?Q?faV1pfnN03oSn2f0yNTmE553xSSNj5QIjs7MX9zo3hAz0S77O+B36MzZNqS3?=
 =?us-ascii?Q?9r3dAkf2fqRI7oQ+MY51xyWPGA5bUaUHSUso7et2C9SCMy+K3boOh5EM8yCT?=
 =?us-ascii?Q?zZb/Fc4aMuUOHCgiyyle7h30UJZqUUktRBpCoe1IIxhnPYc8Rwjn7ZTyuVSb?=
 =?us-ascii?Q?zSfN+AJvb3GW96f+3DR3salEnEQDQbRgIluqBgWMjpz0v3WtECRF5y1JU54L?=
 =?us-ascii?Q?j/1ymomQTJpMAvNxRbUvRDL02RJRv+q89SuDCpPBCMq68QYlfN5nGVqtHOE0?=
 =?us-ascii?Q?SRmlbuZOhcTOTBTnil1QWTS0OkMdgpJITJbyjiUdvCOEHDGW5lradP/uJRbq?=
 =?us-ascii?Q?UaQkK8NEP2e9RS28CSl1XLUO66GC2hhT8Sxye541vJLxYjMYwvCHWumxsmNc?=
 =?us-ascii?Q?GHxSxiHnPQaa7aHfO2LcmjhLmy+m3Kxh9uZV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VcisbVobJ7llDQV5wOesdveR75T5SJBZDKymR96Q57LLYOCTGE8MC+zqzFZ8?=
 =?us-ascii?Q?by679FZNjbX+V6dNzPWZJd14DpdVB11QwIWZu3/ZudPKPD0jJLwN+DDEyYEE?=
 =?us-ascii?Q?jXNQTgY9YvH9DaGQQ33sGT/JqBgrIjMBOFmHFYAQvYx5G2dnD8NF5OXGagSB?=
 =?us-ascii?Q?lOZR0PjUyOUKqGEBIE28sbC838CM8KlCJXzexc+/XFVnz2+R/Z7vf0o1uVwz?=
 =?us-ascii?Q?mjeuT9H/qVSiNN7nGk8eRR6aHsQIGIWaxt7qwUPbRRrzSbJZiDbPy6RKbU7z?=
 =?us-ascii?Q?Y6rX8si5Esup4vKTedsRgjlCeZKlz8JNgrQ2oBzS2VSnKUk7WCyX+L/b1D/x?=
 =?us-ascii?Q?vXJ/Ws1KbfAbiM9GE828mHboU5L9kMXUUh2/4BTl2DiClFQXa5McKb4V0IkW?=
 =?us-ascii?Q?9VBXAOLUDcm5+35EPbMT5cHQG5Fxz6AgW5zyuIQCwf2GTWduNOCYR0SUqvdK?=
 =?us-ascii?Q?FJFyQ7bstN6CX9hCkzpJHo7HcSimdNRrKr0sS6n0/E5r+SmTBTOj0vLDVQ2Y?=
 =?us-ascii?Q?8qbOFudDON3Q8+BF6EwJM5P96gDVbLuNFhxTowhE/9KjagbQ3bBDsJbd2OUn?=
 =?us-ascii?Q?BSMXz+G/z9A3c+FH7f+C9werZKcTD6KLqMNOdqKLf2J9iJoj7V4HWaBGzyNm?=
 =?us-ascii?Q?g7hx9tbqTZyXe9DS57f+cEEcDJBjVaGYkbHcLwKw4BF13DVuhy4ITL/x9Ud4?=
 =?us-ascii?Q?nm+iaJ/bPdm6+xNgJA1/rxb5GZixRODFCYZg+6isnyJYU5H4q2f2cm1QQtil?=
 =?us-ascii?Q?Y1sCgouoNcsNV21ofvwW9NTW7RwQ6s+vcnBvIyCta4LeKSVL/z59fdAEjvD+?=
 =?us-ascii?Q?EaTFqXqB5NvueHLzHIDqx5oqZFebIJRYeWVwTeYX8etZbFraniePD6yyOQuz?=
 =?us-ascii?Q?JwjH7C9eI77tKXiP0j/htGrG+7FM5pL5d55Vn2v0xzwLRaF1vobDkBuKu3+m?=
 =?us-ascii?Q?RcOI2uYFH3VXJMvyJZWdXpOVJofOKU1yUU6En+7O69xoqIijsGwc6uscP0Ko?=
 =?us-ascii?Q?QylQzGHjrcBZWno6XqOI0yjl09uy6Aq1seJtfIzS9xeRp35cMv6/x2gPETup?=
 =?us-ascii?Q?rkK2jwZzwuLckTQFRgLPpFPOk8Tg6JNilTjiWcok9X/G9bb4xI9ePOK/g6Do?=
 =?us-ascii?Q?la+Jwdoran4AMFQrV18Eiea0FtFvfAwDGpvMdDAZ3v3YE4Q0KQBqq+AGBA3p?=
 =?us-ascii?Q?rKx60rY0FglCHorKYhPSWgFVSKD0YWktTU0ou81Ol36p2cf0Nc8dZ7w4Q1on?=
 =?us-ascii?Q?16NKevCDhQH6d85u9OamlFaCtaUsKZUGiMpvubDauqVDFQMXLeEMCQE7b08J?=
 =?us-ascii?Q?mqfrcPBqd9ojOVRKfNMoOmgqYd8Ag4cQDyoY1Xn/4zT7ITmCJCMD1XC27XGq?=
 =?us-ascii?Q?SIwiCziL7u3L1a5sljO3z5SxsJ2cyzWcJEL4J2aN1iqVJMtJsx8MY4fY+Dt6?=
 =?us-ascii?Q?dnL9oKQ+LpFfXvOT5XW2E2WYejVvA9uX+jzQI6GgYjuP9M8UdCol7wZwo8su?=
 =?us-ascii?Q?4lXFYxkqEPRbR9+8O0/0Fj6bxjZU3DzLN91F61PvCRpEEWUgXG2RCGBPdsYE?=
 =?us-ascii?Q?iQa9dG/Y2AsNYdz9KdnWhCK1bubeE0MFHCA2hgPl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82a98ba-2766-4e35-db19-08de1c58f03e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:49:05.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvMjxdhUmZHtFkyhzZc13MJAaSELYXacchXr+PJQ8qZxWzrsr5QO/duJgi+CrGex0oWJYNO8wuFw4ONH2KNsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9293

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
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 615 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h |  77 +++
 2 files changed, 692 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
new file mode 100644
index 000000000000..b49041e7649f
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -0,0 +1,615 @@
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
+		nxpwifi_dbg_dump(adapter, CMD_D, "2.4G HE capability IE ",
+				 adapter->hw_2g_he_cap,
+				 adapter->hw_2g_he_cap_len);
+	} else {
+		adapter->hw_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_he_cap_len);
+		adapter->fw_bands |= BAND_AAX;
+		nxpwifi_dbg_dump(adapter, CMD_D, "5G HE capability IE ",
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
+	left_len = resp->size - sizeof(*he_cfg) - S_DS_GEN;
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
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CMD);
+	cmd_size = sizeof(struct host_cmd_11ax_cmd) + S_DS_GEN;
+
+	he_cmd->action = cpu_to_le16(cmd_action);
+	he_cmd->sub_id = cpu_to_le16(ax_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		struct nxpwifi_11ax_sr_cmd *sr_cmd =
+			(struct nxpwifi_11ax_sr_cmd *)&ax_cmd->param;
+		struct nxpwifi_ie_types_data *tlv;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		tlv->header.type = cpu_to_le16(sr_cmd->type);
+		tlv->header.len = cpu_to_le16(sr_cmd->len);
+		memcpy(tlv->data, sr_cmd->param.obss_pd_offset.offset,
+		       sr_cmd->len);
+		cmd_size += (sizeof(tlv->header) + sr_cmd->len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		struct nxpwifi_11ax_beam_cmd *beam_cmd =
+			(struct nxpwifi_11ax_beam_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = beam_cmd->value;
+		cmd_size += sizeof(*beam_cmd);
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		struct nxpwifi_11ax_htc_cmd *htc_cmd =
+			(struct nxpwifi_11ax_htc_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = htc_cmd->value;
+		cmd_size += sizeof(*htc_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		struct nxpwifi_11ax_txomi_cmd *txmoi_cmd =
+			(struct nxpwifi_11ax_txomi_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txmoi_cmd->omi, sizeof(*txmoi_cmd));
+		cmd_size += sizeof(*txmoi_cmd);
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		struct nxpwifi_11ax_toltime_cmd *toltime_cmd =
+			(struct nxpwifi_11ax_toltime_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &toltime_cmd->tol_time,
+		       sizeof(toltime_cmd->tol_time));
+		cmd_size += sizeof(*toltime_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		struct nxpwifi_11ax_txop_cmd *txop_cmd =
+			(struct nxpwifi_11ax_txop_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txop_cmd->rts_thres,
+		       sizeof(txop_cmd->rts_thres));
+		cmd_size += sizeof(*txop_cmd);
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		struct nxpwifi_11ax_set_bsrp_cmd *set_bsrp_cmd =
+			(struct nxpwifi_11ax_set_bsrp_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = set_bsrp_cmd->value;
+		cmd_size += sizeof(*set_bsrp_cmd);
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		struct nxpwifi_11ax_llde_cmd *llde_cmd =
+			(struct nxpwifi_11ax_llde_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &llde_cmd->llde, sizeof(*llde_cmd));
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
+
+	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		struct nxpwifi_ie_types_data *tlv;
+
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
+u8 nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				 struct nxpwifi_bssdescriptor *bss_desc)
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
+		struct nxpwifi_twt_setup *twt_setup;
+
+		twt_setup = (struct nxpwifi_twt_setup *)
+			twt_cfg_cmd->val;
+
+		memset(twt_setup, 0x00,
+		       sizeof(struct nxpwifi_twt_setup));
+		twt_setup->implicit =
+			twt_cfg->param.twt_setup.implicit;
+		twt_setup->announced =
+			twt_cfg->param.twt_setup.announced;
+		twt_setup->trigger_enabled =
+			twt_cfg->param.twt_setup.trigger_enabled;
+		twt_setup->twt_info_disabled =
+			twt_cfg->param.twt_setup.twt_info_disabled;
+		twt_setup->negotiation_type =
+			twt_cfg->param.twt_setup.negotiation_type;
+		twt_setup->twt_wakeup_duration =
+			twt_cfg->param.twt_setup.twt_wakeup_duration;
+		twt_setup->flow_identifier =
+			twt_cfg->param.twt_setup.flow_identifier;
+		twt_setup->hard_constraint =
+			twt_cfg->param.twt_setup.hard_constraint;
+		twt_setup->twt_exponent =
+			twt_cfg->param.twt_setup.twt_exponent;
+		twt_setup->twt_mantissa = cpu_to_le16(twt_cfg->param.twt_setup.twt_mantissa);
+		twt_setup->twt_request =
+			twt_cfg->param.twt_setup.twt_request;
+		twt_setup->bcn_miss_threshold =
+			cpu_to_le16(twt_cfg->param.twt_setup.bcn_miss_threshold);
+
+		cmd_size += sizeof(struct nxpwifi_twt_setup);
+		break;
+	case NXPWIFI_11AX_TWT_TEARDOWN_SUBID:
+		struct nxpwifi_twt_teardown *twt_teardown;
+
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
+		struct nxpwifi_twt_report *twt_report;
+
+		twt_report = (struct nxpwifi_twt_report *)
+			twt_cfg_cmd->val;
+		memset(twt_report, 0x00, sizeof(struct nxpwifi_twt_report));
+		twt_report->type = twt_cfg->param.twt_report.type;
+		cmd_size += sizeof(struct nxpwifi_twt_report);
+		break;
+	case NXPWIFI_11AX_TWT_INFORMATION_SUBID:
+		struct nxpwifi_twt_information *twt_information;
+
+		twt_information = (struct nxpwifi_twt_information *)
+			twt_cfg_cmd->val;
+		memset(twt_information, 0x00,
+		       sizeof(struct nxpwifi_twt_information));
+		twt_information->flow_identifier =
+			twt_cfg->param.twt_information.flow_identifier;
+		twt_information->suspend_duration =
+			cpu_to_le32(twt_cfg->param.twt_information.suspend_duration);
+		cmd_size += sizeof(struct nxpwifi_twt_information);
+		break;
+	case NXPWIFI_11AX_BTWT_AP_CONFIG_SUBID:
+		u8 i;
+		struct nxpwifi_btwt_ap_config *btwt_ap_config;
+
+		btwt_ap_config = (struct nxpwifi_btwt_ap_config *)
+				 twt_cfg_cmd->val;
+		memset(btwt_ap_config, 0x00,
+		       sizeof(struct nxpwifi_btwt_ap_config));
+		btwt_ap_config->ap_bcast_bet_sta_wait =
+			twt_cfg->param.btwt_ap_config.ap_bcast_bet_sta_wait;
+		btwt_ap_config->ap_bcast_offset =
+			cpu_to_le16(twt_cfg->param.btwt_ap_config.ap_bcast_offset);
+		btwt_ap_config->bcast_twtli =
+			twt_cfg->param.btwt_ap_config.bcast_twtli;
+		btwt_ap_config->count =
+			twt_cfg->param.btwt_ap_config.count;
+		for (i = 0; i < BTWT_AGREEMENT_MAX; i++) {
+			btwt_ap_config->btwt_sets[i].btwt_id =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].btwt_id;
+			btwt_ap_config->btwt_sets[i].ap_bcast_mantissa =
+				cpu_to_le16
+				(twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_mantissa);
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
index 000000000000..a570a1c23edd
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
+u8 nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				 struct  nxpwifi_bssdescriptor *bss_desc);
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


