Return-Path: <linux-wireless+bounces-26152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24EEB1A694
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DB5188E88C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F1327B4EE;
	Mon,  4 Aug 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e7+RBxwo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02C27A47E;
	Mon,  4 Aug 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322419; cv=fail; b=c4dwZtRpJ0gGySlu6W+8o+qN4bQAc+s6i8bghEFUbfCkt8SW0rG/yblUvGtv93nCdFnmcLpZsDswbu1nMzkMw/mXCcIHiJdQCj/aQtI8otd3fwbx3xyKV17Blil28cGIYo3H3heHKth5g8BpfOH6hKQUejLIwr+kZgKhqjFB40M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322419; c=relaxed/simple;
	bh=y+6iWGVWx3pemkaBT6LZnheTJeTTmn368udBZ57Il1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8c3WaVRjxXG13XFHLl47HuAj0SJZxauEZqhwEOMRAPG38u1bIS1hwPK6U8q13ZJyMWeqYJuqwG33JzcLqEiiiQaxA8ItxQxHmF7q7ctX2oMJkdfYZPegAvDJYTFNgTP/jbscrHFfKsv4xG6d8Poxr2q7+HyolMrKj0mriLBE7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e7+RBxwo; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXvh19QiGaEARFwGofGltp8JMadKYc0cr3kg4THIMiIJEJwawu6S1I2NVwk/1nlNOg9YQ5hb3Wj/9JnfB94n6RfQE/1aZZ98Q/SEC2SmAN9s+Gp6i/1VcV7s9T8qTfEWvCmstWTn60h9NTe0sWvMiVV9tVXt/gGsDkFXn/OevAwuzhtO1bATngFPG6AQiJpcs3eCEkwOE9lyi4+fmow2o0y8cLHCQETW+p9427NkEVXasrOEgPMS2O6ha8LyA8+d67abiqD7zE2x5qUS/JiKvpEFiTPgrJr6yyZr7dwH/hYnvRsVHRd1MbpjgTelzaBb+1Yn+3hAV6lglBDfNr5eoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kspVvPOQ32Mq8jps6u59IJV2aO8DQegA36P1eCl7Xbo=;
 b=LYyN09h51RLIhtJUK19k+5oPvhZ+7hb5bwWHvN1pqCkhZTaC9aWWER8+sXxn+pM8xZV/tHoxnFH3y+O2/0yfw4fkVyDiJT9vLC//6yHkQFf1BJxp73TLDMEbKhhtGO81shMtALemWRGsz0ZvSeaHLHhtE7jZjVXieUCU19bibIh2+3sjRTptG9X5T5KenJDxpYR1jYW+k/goTuq6QK5RTQpSySwq5kExRzf4pBdboIZfupyxXMKD9Yxpt97ODS7xyS1Fiqa7ciO6v4nGsSUny23g1/a5Dkt5Ese+0SNcfCza00CWA8L9hiLib4I6L0NQxoTb4c49hkYFBw7EkfhhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kspVvPOQ32Mq8jps6u59IJV2aO8DQegA36P1eCl7Xbo=;
 b=e7+RBxwo7VQf2zr5X4GEqS6FnqTbnYmyFc4OgX4Y3xvdIGl3hRmjKRewLrdAEcXCkh5mAOzAIYUHi1z1IHbvok4bZrEvil1vFbQacY1tKo7ljkoXdIdN77Neyp1+4MSqnyGbMNhh3jBNDnWIL2T1TxZJ2Mx6r0aO7NHxyNBDOCj6ZfscSoLyaWwnzveRipmOw5W2vHj4sMBZ8F0lGmKrgnqBdNlntFaIHcrnRYglT6FH4BLvVyzuC1eyha6ztJZ+asCAdZnSY4Wb4HFEjwBp4N6+/vcmxahyNXJrCLo+/vDZzBAborXaY7qRLQfDSJbXiZyXeycm0ojvoiFU/q3bhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB11432.eurprd04.prod.outlook.com (2603:10a6:102:4f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:46:50 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:46:50 +0000
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
Subject: [PATCH v5 22/22] wifi: nxpwifi: modify MAINTAINERS file
Date: Mon,  4 Aug 2025 23:40:18 +0800
Message-Id: <20250804154018.3563834-23-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA1PR04MB11432:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf3d710-527f-4c00-ef69-08ddd36e204b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M480XCh0qMp8Rora4Q/TH+Cl+HTRS0d/S+XWvKVj59haSDQHhYSsW3uLjVGq?=
 =?us-ascii?Q?rfUuqzmJlaoHDmGF45iMHwQK+ONZ1sm3ycLfrchhhGp1sUIKPiGlcpscv0vv?=
 =?us-ascii?Q?YtPn17ah5lGDHDaysYEMRzeoRS1pS7ONIsMpgZpOMOBeMgh8cOfYTSgXqag4?=
 =?us-ascii?Q?xOiG9ZU2Sj8xzw5ZfJSzdnMkG2IZqz/9aeiyYJ57sD5XG3DhfPI0sCEXn0QL?=
 =?us-ascii?Q?e+SODlSAc3mdXS4mCJDsN5fk9nMmXjonsgGZh9jHbFypI6dyk3r62AdWHZmA?=
 =?us-ascii?Q?vYC9GAuvOQ4Ja/7jRUgxWtFPQ5yqOlgD74Qs9kpsoJsUwQI3TkJeDSm6Eo2e?=
 =?us-ascii?Q?1COTQk8Gy3rdpVWRDxRpoaD4YOrDK6HtkeSbcSJcHUhOT31/TGC2+nNVQgid?=
 =?us-ascii?Q?H6emUAOzp4Y+l1PFMIBOgksV7d8POg1QIpkWdF1Y0jimMD8G9wQDpAxJHCFg?=
 =?us-ascii?Q?3betYgqtBklBKxqiGhbH4esaHYcBDzpCLuT40XtxDUYSjMid7BQByDHxr+W6?=
 =?us-ascii?Q?E+KznOP5qZ/LXJx/8i1rXvmsGkrLKt+uyayhMLlr7jSmyj16JNgObTTDdfMM?=
 =?us-ascii?Q?ugLs5AUYTALCSOiUstD4W+h5rCUbUfT5sYkviFmOB6exnm0gGb6XVhoa7CAB?=
 =?us-ascii?Q?JclUYS/GN/dT709KgyMEjL6HR4Slsj/XT1vKgExa89My4fb/qazDsMstXzel?=
 =?us-ascii?Q?6ur0bvjHRpiSHpJeORKOgi0JPcN3Ag67zxnKLHV8KtDb/tbxh0NmMh+lTdbZ?=
 =?us-ascii?Q?MJGPg4MUgSWxP3oxx6gwO/HoOOs4QH9RfWjZ41Okw6dCcsHvY+p1nxflBtAE?=
 =?us-ascii?Q?WpNUenyDSdlNFIyW+qMaigF/6wWr3a+GQNbed0oIccypFJECQ2O5UuJehQQl?=
 =?us-ascii?Q?KarbZpHeZLWpDPp/PZSbj/b3DA2Hj82Hj+3SKk5E2ErqEK5WdylyKILIctI3?=
 =?us-ascii?Q?DrNfI1DoA94egzzsw8dsbXYkK0EIbo9ATNTvvt8tqrzd0klZ4QoqexDoRhug?=
 =?us-ascii?Q?AakazdIzxbRPFqiCjb05Ff/roYk6zb8JcKAvaPNwzs8hiDNNDoU28/qk0Da4?=
 =?us-ascii?Q?qKqwm+/MvOe21Gn+qXVPvBPRG3uY8b4CxEqrF6bzewxRuqRub1HWEstJyR+8?=
 =?us-ascii?Q?5/DpZnjSpx7dJQ/TPGDasYS6za4KMWidXYlM+x+1B1MNJvavJyDRi+isO1FX?=
 =?us-ascii?Q?V8v73vMynbfcNOzrwABebZcqf6ON0RuZMtMFa7DpZBbvZXZR/dOxmG5K9YlV?=
 =?us-ascii?Q?fX4dPuMm2e+/I4K0wiaWNi99+dXlA92uEIr4lBDW/ZHuOCCh+z5heQJw1ykH?=
 =?us-ascii?Q?tBdKlIaCIkOPZlgkLc/Co0YawNVX1eJS6YhWhI2poUo4NQ3Zk3vqTnzWqlnC?=
 =?us-ascii?Q?OaDJkj5/i/G29WvCoHkOFl09qbplbUwTsof3KcpN4133XxE8ST0RCxGnjEY+?=
 =?us-ascii?Q?zh4vCMinPKAfv3/jVd5ChmjTKAM0rIhUov0L4rDCSbsJJc3oY9Ot8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?77nQRdT1UPV09CY8HHJoZq41NNe+rjovqHTnDGegViTK36Xz6M6h8nHXuKae?=
 =?us-ascii?Q?+2XX5emcpKYfCt3kgJi1aNH1tyy+UvPuXrURgPAl3zZGCjMt2U+Si2lAum3S?=
 =?us-ascii?Q?D3HDt1fMa00G8rDUsszhbN62WtMQgTX6q9mX2USt/ZZpxoxgSHOLvkpuq2FX?=
 =?us-ascii?Q?8Ij+q0UHkUyvyjuywoH9fzCeSdXDBe038w+DyG8+mrzUuhAX+t6VlGhbbDWc?=
 =?us-ascii?Q?SaatGfrQS1n68aTHhTKWHvYgI2Z/q1cQbgWyf5JJ2avajCyvDO1ey+l6GR6O?=
 =?us-ascii?Q?nps5jqv/F++kwp/3Bve/i68Ka+vz61CAc2JSCclg7lydOseHNKR3EDgnCPP0?=
 =?us-ascii?Q?qKXldCR+U5cUhMLwf+Z3DHu9GraBuLVaHNT3RmZwCSuKSK3XX/UlEgMoa+GX?=
 =?us-ascii?Q?/itEVEOsnhh6YxgsJ6w+Jix+b5WZ8TX3beS/GXGoiSWmoy7/2yEcweBlNexl?=
 =?us-ascii?Q?J0uS2DJ4hFs6cXPxy5GoZQXAi6T3ZrQv1V5ye2IhiKUmzoB6XFK0X/kZLujz?=
 =?us-ascii?Q?4yQZn8K5Il5+ITezvwT7byInWakcFVY0I0APu4Q5ir5UX0e6kZqohRBDGbQ9?=
 =?us-ascii?Q?X0bFryFQVZjTJq5fAm5a817Mkm+BTew/6JYsbBj8E72hcmkhKRabE4xDL/EI?=
 =?us-ascii?Q?RW/lU/RAFB3W1V7cv5OaJH2N22fWYSksU6ZHCOqEfepGEdpOQqc9NLeZZqvj?=
 =?us-ascii?Q?aKoD0q91IUR6bcAtuuzoYIyAPh2qapmaX864RWp14fX+nRvE4KRGRfULPmKX?=
 =?us-ascii?Q?/OTOVzIs/N7hjvbdjFUAOO9rdwIJtx/UT5w0ZQgnAcIY+vOhQOF3dcsA+hVY?=
 =?us-ascii?Q?n1ax8NpGld7wcE7kSMSfeske3hlBEBfNQNaksXSU+Isx5waiiI98uD0HaCwE?=
 =?us-ascii?Q?/DPz+RJfQj3Re5WrdHTSVw9TxUkjpBzUe0wjGngU1HqDI0m5RQGyp2rgGND+?=
 =?us-ascii?Q?a84ToUMsEzjlw6PbKCcR6eb2V2wkGNDPljZrsIkfKNLu/Ze72v3yR0nyGJKU?=
 =?us-ascii?Q?rNKfj3vcTCMeXaiFGI3eMbBXQVmpZXRlz1NPE/+F0XZf7CVRofkYAo6Ptrn8?=
 =?us-ascii?Q?ilJw8JAJywNnSnw+ulya8IH3HLg1/slNcwpqpiXQ0mhSpaJAhc5z6dzkBgdE?=
 =?us-ascii?Q?kwwQ+3XxCTlI6TuMQcoVbld4im7JsLnhMLb67LP8teFqH3QScWpWpYLnPh5p?=
 =?us-ascii?Q?NfRsQESrLZqqBIpeem9zy/fqPNFpkV7ec31hyPlFJUE8fNE1zp1bY6hv0Wad?=
 =?us-ascii?Q?CVQX4gwo1dd5jIDaUEgnw6PpRE3g5l222stabeSXjJ37g10sJ5YAckI55OF1?=
 =?us-ascii?Q?fQCEr4WQ2dJE25psPtDD87/KUwxBtTHipaZ9OpZxT+O11FhQLWlXQw5YgCc3?=
 =?us-ascii?Q?KPhoqPgmXKNrG5YJrDf0CA+zt6Cxs8pKuGYBKizjYzSwWBELTq+dMaPUPtRM?=
 =?us-ascii?Q?xaYUnRs5SWWyml4+mJRTA/2mJ7hpNZR7p6wQ5JeLFiAN/zZddeqSS4tGJULf?=
 =?us-ascii?Q?K9+mNy6zrC7ewQN8Ee8r+zQXNkhmu3kpni8GzRlj2BWjcJDiUTdZTLttEyUX?=
 =?us-ascii?Q?EIxZRGLUGbWb5fwKpaI/uaQsLqwHwlCFvLcUkkXV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf3d710-527f-4c00-ef69-08ddd36e204b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:46:50.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkOX0+A1vWwbasMw/vFd0jTQcLooWXHlMd7VFYftcgSX4Tvd/l570mGfG7B7CNPPKKcflvNgbRXIEgTZs0Ff/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11432

Add nxpwifi related information to MAINTAINERS file.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b968bc6959d1..43305d7779f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18125,6 +18125,15 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP NXPWIFI WIRELESS DRIVER
+M:	Jeff Chen <jeff.chen_1@nxp.com>
+R:	Francesco Dolcini <francesco@dolcini.it>
+R:	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
+R:	Brian Hsu <brian.hsu@nxp.com>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/nxp/nxpwifi
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


