Return-Path: <linux-wireless+bounces-26132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EABBB1A65D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9521A1888AFB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB6921C9E7;
	Mon,  4 Aug 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SI4PW2EL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A4253F00;
	Mon,  4 Aug 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322351; cv=fail; b=ewm/UnVtDEgDiyFSfg/3VwrwthqoMmgSF0UrKeAZXF1y77Z1Br7sx5nbWBUX/pY5spG0UsNsbaA9WobKAFD7y/4eLZW9fvyymDbX+VVwhdxSruSw0r3SpsTmeOtfQhHdB34ikrmfUr4cNCksDt3pDQJj31GJOnZRJc/EkrzCxsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322351; c=relaxed/simple;
	bh=MbO2aFggRR2SoJDhJEFn+hrnY+7BmbSKc0tbGO9YGfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ryk5HTKYjQoKHrCRjppQPj057k6/HRx6VxeBiwjEmb/pLFJ+ixrneYN59bQcuVFyqqxFwXec6fPPF/KRW66Vx+y1R78RpNT5UADVV4HmZRnoVEFdoplItbA9HqB0uCZOWjb8oK3Hbl2x5/KQH+flBxu4PJaQZPx9h867pdJrDdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SI4PW2EL; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1/rS4YjJYzXO1xL3UcGqZ97ZEo/kLAMmYfP5drxXhbR8SscYD1+0pV0rn9CTaLnX6o/YtMlAB9VYwBf+I7YD+1yoPFe7Djt1ol0KojtvQR4xK+naberDx/oReQFF7dL/3QVv7KY8nRoI/mb4Qdg54q4ZlQDg80RKW3VbAkGSQ1Ob1HoXti+vsnYKsANhvSO4kkLrt+BJ0CTkGwK7krZNBZ7wNuimwdepGT/9CftuSOV827ZyEMhDJwp79pMGCFKJdImz5Aoj3zMHp8oCauIuLuoY4y6MQgxN3BVEfk7HDdUgaFtDNMZkuWPf0n/FJynpXqb8NlpmKw70JKZAe0AaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09wXWMVbXdzLS4W3d0Reytc3xkm7L+30i+h7kO2zJhs=;
 b=Yam6CxKjrlQLcz4h4XeSKBRtRETwHAC9XSspRsUZzDufOPzPlKRSpD5rjG77BajZmHOdOWZS0TWAmobiWb2wsIy5Ox/g/YX0ThigqCTlmmJFrpPc2SAdZc5m7lezXmGLuruVNIH5P/F5Z+/Qwzbwkk1oAn4UU/zFvJvWsfO6cS559z9vwkeSZQOpcAkK3sPUn38HrXJhopVVG2CRA6KybEE0LFIgwv+eg4h2ahcDFGRvfWKZyvZykVJuisMLCO1zemS1BqgxxOz72+teyqsek3BZUlg+ny2yuaHOz9PMyelUmE+tiClYM95DOqektquo4Qyoyh6Wf7S+jlPrnOA6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09wXWMVbXdzLS4W3d0Reytc3xkm7L+30i+h7kO2zJhs=;
 b=SI4PW2ELFDyOUglWWad56dylOX3V5Ho3vNygpYbuDAzwmaQGA1rgGXLICYKnPux5RGjwjnI2jNH2QJ1lSk5RUWsXwFBGCtqmNG5at0i2eQH63h+tzDne1JPpx1fcJDkIgA46oupggoQ2lVMSN4HOMugqvNhEAyTP9sWlLQhkVKB/0+kECuk6+jO1KrgxdSfaBMFT8TjiOHzBMsJY35pVtvzzariWyihnJQLvDUNqsZoG8Cdr5TfZ1K1s7WuJUu2RSNlQ4ZJNy6skx/B4OD2/w294Jx44KLRC2KlEbNyV4E/uGehvE0FmddUXzZ4VPl23mmSOqhBfJAagKlpBDOUUEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:45:46 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:45:46 +0000
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
Subject: [PATCH v5 02/22] wifi: nxpwifi: add 802.11ac files
Date: Mon,  4 Aug 2025 23:39:58 +0800
Message-Id: <20250804154018.3563834-3-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddd47241-9b4f-4a48-d60a-08ddd36dfa29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHzQDea4EORsIjbsDUmtpi8y2F9sRzeqkFwLRyGfWl0vI3hObKA1ypRYpoqw?=
 =?us-ascii?Q?sJZRv70VhPAV9JUYB0MWrk1kkWJxTrUDGE2yybgFrOABiCvsslXmhl6WmiF9?=
 =?us-ascii?Q?MwKBQ2rfnQGCz0qMNP39fX/sMMKm23Kw4S/IA43ZMwjxN9cAGbWNcJYxjCFK?=
 =?us-ascii?Q?+bDCNP1gBfH7W3Q+ICZh9mAEFWuF1mLglaZ1+p5ei5RJd36j4EmrzqXkhxSE?=
 =?us-ascii?Q?CisK3zfKc/+Ce6HkY6LKxka3GEL5MMl6C7tgnKyUI81eAwe5DGsBLOt47FSs?=
 =?us-ascii?Q?l6Ggi8UWU88FHN+K6d8m7tVWWvC29iW/n120HTBU1gTD8oyyT2gGItJJI2t0?=
 =?us-ascii?Q?vjYn4tT0CelrwbQ4bxhl4wmrefTmzJXSMznuwjw0RxWiJPrbW7k5p13VIX2x?=
 =?us-ascii?Q?iXuCMssL1PDMBaGieSyJl9YZQH8QXEHRk+uiwmEPmTLA6iRmj3+CmS0yrj4w?=
 =?us-ascii?Q?NaHR74WGrO0IuHGoHP1ok7Cow2aSyTPE8cnvYsOAZdvD55SVVGratpBYr/M1?=
 =?us-ascii?Q?qBIo2SW6NAvQX9gwMvoiSTKJ46nLTiFmffD2pTu1CR4bzqrLk594ZfPhaG5M?=
 =?us-ascii?Q?j9oNoXuwm0km0Qahl8v1fMOZu1lMGdl880yxNlQIkXfT9EjNuJY34UdPwiSC?=
 =?us-ascii?Q?NTpOWruaG0owluWGcc1ebrqSpgmHc6+2hPkYF4+7oy9FEkWYHU5BuyAxBl2M?=
 =?us-ascii?Q?yE6nBGcF5E48l1OHrAhxCTU2kZcsF94Mvy23cdkmEPQFPrpSGDVSPriu6wM2?=
 =?us-ascii?Q?NaBKU9WpnhzSWmxFjdgiYxaQXhynkBcxcJO+NxvnREVPZzDnKquL3rEMpXIV?=
 =?us-ascii?Q?DWClV51L74LzeCm2lEJQRHJKJ298V0rZ8uOusME72+Cd82jsRJnq58eD1jFF?=
 =?us-ascii?Q?7+gd5g7PU2M3eW7WRataOkgtCExoSiX9TcnineTq5UKsyj2BknFRIyFhq3v3?=
 =?us-ascii?Q?5ZDR+o6ga6+k3Xrj9q+DlrIUXdYkY8StYlYk2Wp2zfEYOn5QysFodvW8x0Ja?=
 =?us-ascii?Q?jfctQ/ufROJ6pXv+UShzyt1yw5SSY3iLYASQ9eZwaqwpkuBDW49I1dCkRA8b?=
 =?us-ascii?Q?WU6rHf51FEYpUh4UdB24YCl+BQZIbnQz7T2/GRU+loDiyfxxnNOHH8xkbqlc?=
 =?us-ascii?Q?sRtotCaVcd1uXS3UtAmyJGkHIu9a3ztZCQQXglO40u+M3KHmpAdYIUAjKdiq?=
 =?us-ascii?Q?JweUdBUYx9genhKsDM7Kla2pDjuYVYt9K4U9+LhiTTR/VSa+5nJAPyioKq9q?=
 =?us-ascii?Q?EacnAYx4TgMiCcbVApPcxB0k77UOeum76UlATS2v41N9CgqZ36Qx0FZoIM8o?=
 =?us-ascii?Q?fMJ5mchuCJjcN0OrCqe+GtaLlQdkqsr3uUIYcPpmlRzj6OPS58NZaaUlujBV?=
 =?us-ascii?Q?i0BKIz9rfGA1H74dDDwZB38/3FGu8vLCJceGxIb6paUPzvVKYntdAcKcLy9N?=
 =?us-ascii?Q?UUozI4gHZjuqTp28C0uGTXe/Kzi1mgSQT6wwf4h8qWJRp5hz5st4/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4hxmQGnYT2eukGFUWWgswJiAfslCSeUDjextteCgPWuW37oKFlwnat8dQgOt?=
 =?us-ascii?Q?nlNpksxZBYYUFSfc1/02uF+1j3EqSQPUEr0/z/sr/VRV4extmHwKjNGnzWhC?=
 =?us-ascii?Q?MHqO+9DVBfyY7IY8QujH49Tb0zdSbir382Ozu/b1qzPZaJlfaEzJtmImyB6h?=
 =?us-ascii?Q?m5+9+EhxmWFb0k4kUP3onCYhSOaQ0vLDMnYy0e/WgFpTWadorhCDfthKYsXJ?=
 =?us-ascii?Q?tqZJLJaldl8E+KopTiBQvNBEyX9O6gOW7ANXB+q8hU4vcnOUPXX/p+naRZd+?=
 =?us-ascii?Q?u8XhW/1NVDn7cAU1RFZRsDdtS/1laOJssRGMuUlzAoCAav3niRiEsg+kPLvQ?=
 =?us-ascii?Q?jwkVkG69uLzRALbBXuKQE/E9exI9zmN8GmBz39airjpNu88BLM5T3DrATBwq?=
 =?us-ascii?Q?1rb4CzE3eid3MyZltvvWqcWxirgvbdQTxZ4D4OLdOSVsHdXzTqbJLscgL1Nv?=
 =?us-ascii?Q?8/XW2ZO5MkuPu1o3rkr7jucg5bqcEoWO0LawUKjCeIvw/gZ3/GLg6xSB81Hh?=
 =?us-ascii?Q?yQYBvPjbLRdGH5xA0sOisvnmRBY2LjxSdPp6e1YhbLIMSUQRFl5fgQzfWQIS?=
 =?us-ascii?Q?nItAcOK8z3Dwt7iZYit+2UlIX76N1vm/k1e+qfUeUU97BWNGM0zjGUMLRSdX?=
 =?us-ascii?Q?TKWpEO/CsRHIgI2fldYvBWLGwyJPEUG4+/masqUhq1JiEND+UPSltVE/zgoF?=
 =?us-ascii?Q?awVvQKjLOUfSi9hVOaufXc2lG3lOjmkar6teUHRkefFsX7k+PTAizJwwel38?=
 =?us-ascii?Q?suwVLElULUCiOEStpcXKe4I0x7mWbtTTIxlX9VlBXRBc66duhfp3QDWWN9Vm?=
 =?us-ascii?Q?lhjU5xlj4jBUaoXxsTQEqg6FlodcpgbLc8wN6FaK9qgNRH1gtMZeAZ7Jm6V9?=
 =?us-ascii?Q?6HEwO0iZr3+u8Ja6IWVjqOHbNOPj2NuVcVZ4iwFs2sh4tkIpnEnLN8I8hA7S?=
 =?us-ascii?Q?QkokvNIy3XXLefOzxD0aXYzUMzKS1w23Fwr3ADxgvd4+fgO8FsESw1MDWHav?=
 =?us-ascii?Q?XZl03W935H941R6KEBHLhjL9aMqGPG4hE1+R4qwyME3sqPBRtmPbuiSFsXsJ?=
 =?us-ascii?Q?WBId+0ZI+uQsZBBm2IUtZ87tcdQPaDnEaxpxkK78hj0jNgloT1MUSHdSmcxV?=
 =?us-ascii?Q?1zcXHXCpgUSN2WQEe0u8OQHyxbyrofm72wQGpRTfwsiCUhJn4bn3HsG6IpW5?=
 =?us-ascii?Q?Pe7tRVTa4i1WRHBYlGEg97Vz/MAo96Lx0mZlxzp7MxUQ3AWI6HiSuUrzidB+?=
 =?us-ascii?Q?P1tS9acRUBTwjW4gOYfU9W2Ow5+J2aq3tgWPH5JI0QfPwdzvqsAP4xLtOaGA?=
 =?us-ascii?Q?ABfoPGtzOh4d1wmi/P65F35ArEQPg+VXY030GoYo1JTibxwKmvgACH6YOsfK?=
 =?us-ascii?Q?oCQ8wmHr4r2AKzi5zw2nDaHi34sIv3UGbJXAkgT1jGNxjIxOOO6gsD5JiwbT?=
 =?us-ascii?Q?VW1Vdv8tA2jiFfm9lbHqwlCOt2bD7mlY0kDr4DjepVxyzTJ1PGrsyeT8UxW8?=
 =?us-ascii?Q?NyzCtJxhp7Ul2FfzTo52T20OgEQP+ITk8OIlAMGKFL8RR5gqKGGY3vHqtZPx?=
 =?us-ascii?Q?NtUW5x1624tlmTR0aezLNtwR1fwS1VaobGDG/huZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd47241-9b4f-4a48-d60a-08ddd36dfa29
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:45:46.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgJVDLqOPIPlJw6RASigswHzvBvm41FxGR+Pp26hBiET+w08ZCpcb3l1KRdoS2+loNj/9oL/UZl337xOcNGlTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

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


