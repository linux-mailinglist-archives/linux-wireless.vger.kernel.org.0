Return-Path: <linux-wireless+bounces-25716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9589AB0BC8D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A3D7AAE63
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2DA279DB1;
	Mon, 21 Jul 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UnFzFZE1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98E27A918;
	Mon, 21 Jul 2025 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079472; cv=fail; b=lG1JxwynRl+62+LLjcOlMBsMlfUiiRQps5vXddLDJ5oiQ9XA4jiQlwVaxWY52A1KfqN2Oyt8DXLD86R1c3YEjWYya4G/vpdwVdBsKWucmFvTCsIFjwvIiGAcqWDUmcy7toA4hsCvE3i3P4+dZm2PVRp2X+mpVg7WpfF4YDlF9xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079472; c=relaxed/simple;
	bh=MbO2aFggRR2SoJDhJEFn+hrnY+7BmbSKc0tbGO9YGfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=giT5P70d86Zk06j7g5GDxadqQCHiaEcixgKVSKRmUKKrWWyzta1sr65Jz0qu8u8ptv6YjK5eplpr+mf/y2PbhGYEtGuIMg+Xc3RPdcMw8Ai85JiCVHVzvC/o6FfYdvrTR6SduBcOguQfX74eglUageGLX8Y6jn9wVhaP/kWZCsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UnFzFZE1; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvo5RM87zgOK8NHboOW7Xgkv8rAYn808hLh+vhPtQuGUFp7X/q0oxEmoWaZODDL2fvpIiq1K4v4EgnPqF3uk0MPyopPWYuD70CTVegReO/lSRRUF329xCbtf+MUHcc1vyRSkpTJdqR35mMGEOvUdzpZkzwbhIYUL0bFI6KOof8oedhfMoAbtHk/FcJ2J3z/gqdwaCPPfIn4ML2We0PgKD6zAoIv0Y8VYjXEkHV/m9R7HxVPkJOprG7tGDVxDhxhgZ1SPoTWPYsxRbz3YKjn5RugM0/ZLpfOoj44c+XdpUFVS6YWu2VzQk1EgsxzzvLqGzm9Wd7wQKy8nJaz3efdwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09wXWMVbXdzLS4W3d0Reytc3xkm7L+30i+h7kO2zJhs=;
 b=Og3oAGrTNI15OSi4eFQ89KJjy7NvyfGI4BNaIFaFZ4bayowYCUDfsrfuCAd4G+YxFTrC8NZtvzsVONb83UaQBHXHJ2ky9I/lu93sARRcM2rPbjDV8mcI/VPa8inUYH9Gp6zc1xUEz4K2higRJQzBUoTwVUUWJOedi1rx94+S3dIyqZAEZUM5BDSppoKBpc4l8DVSbWiO+r3huRIxC6cPdz4FDhW7ip91O0ZaQM+WE6ZL4hlVFX6iwR4++0W/t0KDoA4aaItwWxSyT/4UoPt139Alcsi4F65cVPn3gIT0hMlP6JOBlbTeG0kl6lu+lEqnDlBopYSKcuPoHs81ckPWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09wXWMVbXdzLS4W3d0Reytc3xkm7L+30i+h7kO2zJhs=;
 b=UnFzFZE1pVULYBUo+OLfwPcsMxS/9b3FacktmyT2E3tJKLLw9YF5ZoTTTdZTOZSFPSMGKZNnPlreXleAJj3AR83L28ebyq15+PDWi4RSaKAIKf7d5oWLHouIHn8F0N5DbhXfEZTixEkSL0crXnW0THA5zfBbAgE0mw2liZ2FhE3sU7uHz6RYzPHZwRLbHackC2T5G01S2l0fkTNxq325BqjPSVzjAxfM5l+ztZHECs40ydLQ5yp59mM0V8xtlTaCnSMNs+zN/rvu7ufZlUrs3DeW0qc/TUFZCcZAOLwLYS9JY4ZTiTuzDzAvntU7GBSP/GwykE9u5xXuUD28flvh4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:31:07 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:31:07 +0000
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
Subject: [PATCH v4 02/22] wifi: nxpwifi: add 802.11ac files
Date: Mon, 21 Jul 2025 14:26:21 +0800
Message-Id: <20250721062641.2001796-3-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95e87abd-14f1-4f0c-038d-08ddc8202c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2YLBWO7ExAfsbree71O/WWtnogL+2Hszr9ahpfNW1lEwWPH1Icc7yPY9O0F?=
 =?us-ascii?Q?wqhX5khnyqbC7qwowx1WBEAe/TFEccNo/vm5VGCDaBqg/6YXjEYJOHsG/vVf?=
 =?us-ascii?Q?UOVwpQdLDT0G2xSG7DmT3xzUHY4pfrbpfPw2H37f1IvxHYng1na+iGN1WlwK?=
 =?us-ascii?Q?ecwqUv4REq3pE9Liw8pNgl01fUaApVJe2ZN7wviAZtbQdJsvMChM+8PUavO8?=
 =?us-ascii?Q?VCP1I02lFRpv1hRJ74cEFCxmcwRFjFkRHQoNobuYbTMQRABs3An34NLUBZld?=
 =?us-ascii?Q?w482uizL5J97AFdrRIBZI0TPGomyJPt8h6TBX9LvskVAeZUIkueNB0HNswke?=
 =?us-ascii?Q?NMJK1PO2CeDLIYw8RXnLFchO3PCzp41usgT1dfoYb0yrqjxQ4yrC1W6VO3+p?=
 =?us-ascii?Q?mpp1yA6AuFpDQKVZarBHTPJ1imtxTeUAKDutHzDKMlsO53f0BCQN2NqXBpFN?=
 =?us-ascii?Q?M1LhZkrTKp75Wq1pcwWWy5jrg0xOWYTbXxFwUuqP/fWtVaRRGdRQ+9xOv5mP?=
 =?us-ascii?Q?jx2cBSq8BsV5Nz1wAuuKE1MfHqVjAn84nrEKFPPXe1GAiF4Tngs7oxmj/8sg?=
 =?us-ascii?Q?W4GwX+KaDQm2bfU0P6oUknjzwiAeH1p2TBoZI236O6vjiG0HmCiMYHvnkWmE?=
 =?us-ascii?Q?WPtkuVvjQXAlxatepGH2I6d+HUI04m5gPoins21h06q/tOO8cWqdQnN0E480?=
 =?us-ascii?Q?1VKhA1HmvcWJPnsSjHkQNxokvT+ivQkeh+1dUpx+uwanylU4PExhdJ0iCZLq?=
 =?us-ascii?Q?HEVe4PT1OuYq7lCGs10kTVGnkqHsxcDFGxaUS07d1NfPa9CC26S4HfyJts6n?=
 =?us-ascii?Q?Fs7wJES9xUE86/8R6tMeUFtHZAIE1tK35MC0rWmmXD7r4WxcFz5hEgrpfnrB?=
 =?us-ascii?Q?fQHvpOQOtAeJiVYt0rWnscLzqfyWZ5XOklRhHflkiY6UPlE7Syts85WpNEzv?=
 =?us-ascii?Q?mdNALp81/mJD+fEjcliap1t+GihVZPk1sfgpdTkK/qIdiGPYYQL0MVkvkiOj?=
 =?us-ascii?Q?lWPt4c4xzAo+XE0pmIcXK/Eho+Dtlt8O065hHToqrcNOILvOr+mUZ1URZhqU?=
 =?us-ascii?Q?GsJiqJfokwx4UE8qUrPec7A7av5PesoIDBTfctYm3OncJK2Om7lkjyl8UGIv?=
 =?us-ascii?Q?cRs1D8moHSwDOyEdtSCTC/il2Ftvdg4pSkCfX1azvtV9lUSXpVtmupsUAhdV?=
 =?us-ascii?Q?c+yXk9KoNQufQeDo6bcHFRGtd8NVjI1FIlB6KAUmTu5sExQSwOTjKu0oL+M4?=
 =?us-ascii?Q?svvc1fGnraDec5Dpiodh+wbIx9WYYjga3c3cz7kYixhVvmuvKlgjzO46WHLJ?=
 =?us-ascii?Q?9HUBr0TI+W8v58MpvOa8a3pjUifFi5ncvQgsE7MFi2rwGApKXxy3yFCKnidp?=
 =?us-ascii?Q?3fp0BoRMD2a038GABPXdCL8gI2sq0OdCvuO2AjV2f/PHjKzhah+stG1RG1nQ?=
 =?us-ascii?Q?dwkD7fsb1b/SyHBCui2flWbo0lC6cQHVVJhc2tUJWwK03SeG/TV+pQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?StOC6GM1zTCTjj86aCr8ZK1tCOdHdL3jeoL1ymJZzEcjcC4nC6+pX2VHl370?=
 =?us-ascii?Q?v1DqCFsJ2qJBuXBs5XOQ7n/jcaIAqd+OzZqzpcJgAs6MINcGXtnT/xNLwcD4?=
 =?us-ascii?Q?OnpIhjE6evWso3yC2eOZRSlXqie7EH/vdee+ngK97hlF7Faqx+si97dg26XW?=
 =?us-ascii?Q?AyBiY+0EIcSdYjo+vowxjR99BkDzOK2jaGgsvDJeBWiG/nveeOpplsJrIHpT?=
 =?us-ascii?Q?eeIsfqXyNVz1+ZNA/BCfR4u81DdpID5RsBrE7Mbkt9OFFsBBBuTVeHUOAjL0?=
 =?us-ascii?Q?kj6mD2nkmtxio+kuhjc8zemsBP1nRmWo2FjO71GNV/fdSeRzeisgKGUosgli?=
 =?us-ascii?Q?G/xuqPQT/WP/8f6U555DaYXrEYXOUcQxvKGNZtYwRz10MI1VMo7mmxMaS5sN?=
 =?us-ascii?Q?d2Rsez8aFminEMgPcREleNqGI2N356pMA/yR0rGWUMXufwrArgEsnE4ysDl4?=
 =?us-ascii?Q?S5D9u8nh54snYef6unK51hnHUbE99M3r3ZBpRBfRMlJTIuduNZntfX0j6DoP?=
 =?us-ascii?Q?slsMSxlV3p/VocNAwll4wHySmD+8B5ZMmB/lP8ZeUXDHNoFJyepBHJANZODj?=
 =?us-ascii?Q?WcTcZ5bObMb3SfeSSWfTlfiDcHURezYfP098XRxRK5Al3BVT8EAyGeHcbOZC?=
 =?us-ascii?Q?yT6sbMMIWeD+UWI6TmBBel+9u+R+Cib0n0YkYYRJVfCs00qX0HFF7/qUXZp6?=
 =?us-ascii?Q?BXMoThveWxZ5lO0JijNdW863W81QlDYv3D3pCa0QSyMQZdYRzD0lVYlmETT4?=
 =?us-ascii?Q?n/jjL9ymQyIL/9r5HTioLXnP3Tnk2/UgxgJ7Cf+Kcxn+pnB3KzyvWyQ8ktEd?=
 =?us-ascii?Q?DukAU1QDT/2NBAh8hHXM018wUyFk+sUhgg0JAdapyfQbR4AwzMTdxrUyUCGZ?=
 =?us-ascii?Q?cReA/nzkoIJ6kJQ4axpaB3k5fMR/mCo93HcXI0GZJUzYw8slegfvPnOYsDBn?=
 =?us-ascii?Q?T86AJ8ckuq02PGvdbrf5+4JIDyLCo31ED3+F+2u4Ynbo3eUyR/pjmSLd/1AG?=
 =?us-ascii?Q?pjKlKJs2oLJfLL2ZRfmFWn4waFHnhUyo7/2XPeawh1ofseyykkdcPm90v87U?=
 =?us-ascii?Q?C5zSPKkIds0TS9dAseSlIKEtlAhbB/qDS24RfcgxO5ldJSOglTX8qzIsn5fl?=
 =?us-ascii?Q?bq3vbunP/ZQW00nSzHnReUOKmgO2X1S7pZ2JUVyI+Fx6ZERihNDaP8MiKt3k?=
 =?us-ascii?Q?cPQ69mIUXDVG+0QySqGwb2HTTUgawNMKS+e3rMzn5LdjWNZl75QtQF4NIyAn?=
 =?us-ascii?Q?ZLbqxtZbSsJp6UHYD1MyhgvdlaXaHePHBVRlOccol+W/cq7OFu4ld2HjftG8?=
 =?us-ascii?Q?2vIZ05kLsVpKYnhwSR2xMQUuwoH4e9oGDxUX+jUYhr6PNLRMaIocBAPWti+v?=
 =?us-ascii?Q?cJNADrsFWKreq0GuFEo+XwYOcdCQUSyi/3j71mr0HZAlxBJFewilgATo/9xA?=
 =?us-ascii?Q?BdS93a9mGjFH6MKI1WZ5Av++8myL5cU2gRNr59eSIFHWsT0el3wB1fRd4o7P?=
 =?us-ascii?Q?AuwPWO3qNeacQex9hXS2ZrjO3H6EC1A1Y8Qj+FiOlyJ2sNC8lurim/xpz/ys?=
 =?us-ascii?Q?0wtvfw1+cml0dT423cAyJoojn/y9Rf5OFUtl/YEu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e87abd-14f1-4f0c-038d-08ddc8202c7a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:31:07.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBeTI5WVp28Jc7QKc2GE70aCFAqlAst5UKedVK20ITYn29EsGs6hojdRVxex6s8iu5rwGAWDwvSpEECMtpfVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967

For client mode, NXP firmware will help association process via
host command HOST_CMD_802_11_ASSOCIATE. IEs for 802.11ac should be
converted from parameters passed from cfg80211 to TLVs appended
to host command HOST_CMD_802_11_ASSOCIATE.

For AP mode, IEs for 802.11ac should be converted from parameters
passed from cfg80211 to host command HOST_CMD_11AC_CFG.

Files in this commit will support 802.11ac features based on above
descriptions.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ac.c | 289 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ac.h |  32 +++
 2 files changed, 321 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ac.c b/drivers/net/wireless/nxp/nxpwifi/11ac.c
new file mode 100644
index 000000000000..dde983d88945
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.c
@@ -0,0 +1,289 @@
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
+/* Tables of the MCS map to the highest data rate (in Mbps) supported
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
+/* This function converts the 2-bit MCS map to the highest long GI
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
+static void
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
+	/* VHT Capabilities IE */
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
+	/* VHT Operation IE */
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
+			/* negotiate the channel width and central freq
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
+	/* Operating Mode Notification IE */
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
+/* This function initializes the BlockACK setup information for given
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
index 000000000000..c89956f247f4
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ac.h
@@ -0,0 +1,32 @@
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
+
+#endif /* _NXPWIFI_11AC_H_ */
-- 
2.34.1


