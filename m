Return-Path: <linux-wireless+bounces-26150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB6B1A691
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36027A4381
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30427A46A;
	Mon,  4 Aug 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Byhldk7H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269E27A124;
	Mon,  4 Aug 2025 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322417; cv=fail; b=sQH9vkjBwyQ2GbII4Eumr2z4zq53Uf/3amR8wzkI853O5VhBhMK4t8FyK0kRGTZLjz2nSvgZP284ovjiAzt2VFQaTyyywuc1yFybBi9nkbmPpVCcMXYag9RZhPgSyfRotHsCHx1eSKBsQBRo3lLLTDe3dnV9AcORiB75gF2phAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322417; c=relaxed/simple;
	bh=tbGVa74KyBvl0cVjHwtcnv1GQhg17yxqDAXMGJn3JvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEh8/r7jWyPqhWgPBFsUx9fFlBaS8uptnD4v+KeXyGaVwKZvWJPA558sIP21YquOCCYuBMvUyr6EPk8MEiEyKpVjQJLiU6AZUH8XwkHeOdUTtFqVUeLQnX/xz+ODvPIxImrOjuEFk8sg2ZgOAcQUxo3estMbNtf/pEKoUn7nYCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Byhldk7H; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deUkxDnnMKAPu13ipMoxOWwOEsJU0hPeKgzyN6sWC6xLrYNgyM9KdXgmly9xObKlzqeP6c5U77jCboYEsDYMdbs/edI7fDq/Jm/+WXvbKntIBpjI0xtqeqsFjtlPgVOTrmwxbGH8i04hvzdKtiHjnYzMVzLhEfF1CtR9GfUo+2aKZVj9FKPHdzVAehaW0SxHSqkvqrUDqprdu0i1Csx7m/L+l1p9hGcFFyIH+Kx8GhWxxd6VAq4h/ZKF7iQYBD8hAXGhr1GAVH9Q1Z7q2ckUxus0zTZZ9R5VL/nCSRtgxb0xQ8dj2NJfDE0znDCLz9NTfei+JnPlTOfA3/YwZVWakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nLakjgoUeTIb5zI8lClXJwfFxtBo4bwb/hfgZNFfHg=;
 b=wBwN5PRq1cwuAfb+B0S812ImvJnZ7PlKLsbfziu3C35EhnpTDFyJ6yiPXJyUy44h6g0egYyObPZxPTL3LgSdxs7xbgXXo7lAzeiQXXbVFXGh1ScznQ8jMGR53RLuMk+u4LmnmqPNI2SYeDWSrakdgDHmT+jCEjNeBmtsNApCT3rRwjloOuUUM1bbNCbMPztoO2L1gLF0NDcYKFaqOmi19/6lSavxJzatACzidMJ79pNr0hZ+KELvfuYlTWzSkQSxoC/nm16T3IZZVCri8qdo4ro4llxkX6+troFDVADld3g5JSTEa7JSIi2WDb9xll/VYTTeM3yyu1iEDRrRXLvViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nLakjgoUeTIb5zI8lClXJwfFxtBo4bwb/hfgZNFfHg=;
 b=Byhldk7HBjBiKG3MEL40wI7dZy7tsns54iyskAKcdCQVg822dD1AC+2jSbHheYSKZ4ibPIBujYSEY79iYAOFEPXh/i43JT5BKpMB07lFr1+xPRyWjVVVrJ/evzFkofWfpsP+2gAaM8yWn344YU88J9foCJx0rNX9Z+yg2O0GeUjIdcxUZ2TCYBbgi0AdK41p/oMzF53JA/pc3XJK+Xoia6NpStiJRfZOhkD6i38AppI7kApiQcVmku19mg5Yu2XjQh38JXTnVzfwTz0CGHz7vKfvMPXXGA8HFsrWso6uggBZDcEICVIB85H/kyMDAZYxYtgqm6kLK3EzLgOc7YmFtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA1PR04MB11432.eurprd04.prod.outlook.com (2603:10a6:102:4f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 15:46:43 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 15:46:43 +0000
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
Subject: [PATCH v5 20/22] wifi: nxpwifi: modify sdio_ids.h
Date: Mon,  4 Aug 2025 23:40:16 +0800
Message-Id: <20250804154018.3563834-21-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf842e10-e53d-44e6-2e6a-08ddd36e1c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QbWgDoNL/AX8v5Jf0tq7OSUb/mcCQNSb6HIIZ4D2X0ArgZo/NwyWOfsnRI6s?=
 =?us-ascii?Q?2gDEZiExv7i/F1vHT4cqRGHIDkkS07hFGpuXAg4FUzxYQ9xZkrq1dtT8oyT+?=
 =?us-ascii?Q?l/PuS8Xp4b7dyQvCOkkHRAPnzHMmmzoOAmXo9Cnk4d2aLiH22jscdz/uZVWa?=
 =?us-ascii?Q?CyPm4Nnc/pTd6xAV/QxpXOXYrhR3CGLWvQIc2622gLNStWm0CE4l9K0KOrhD?=
 =?us-ascii?Q?AT57fBpxTqbXo9yGXOIWhMy4UUDZ9nD/alcsfSyRZUPBnfOfzqY+yVy2CQqZ?=
 =?us-ascii?Q?TTep7YiGLDCCptZeNAP2taN6RYmndYMubIUHW/KKUs1LGsDCApUFOXgB9Oom?=
 =?us-ascii?Q?XJpfcmdb5AJZjNpLjsq3QstiZqTPDIgolhtHsv2FGIAcvFqE8cJtK1oreSTk?=
 =?us-ascii?Q?/2U6oCtOW55MuhALCyac2qJDlSBl9L55cEQMr9olH5zbBMoN+i2d61GquxJC?=
 =?us-ascii?Q?V5nMe/a0MbREua0T370TRibhC1T1r0N/1ay/kHfjwZ5Zw0wluILDqOXUs9Ti?=
 =?us-ascii?Q?OvMQjbgKsFTjpjxGt/9xXnj5UNacAVC5l3RnKMkXBxag7z3OcVoKtKUDbJXp?=
 =?us-ascii?Q?9wCgt2MiAfJrRFYVHZXaRLVqd7xFt8Z6F8f85CesW3QEnRKPnGUvzIpdBCeR?=
 =?us-ascii?Q?GXtYLGAuoyHc95tLEKsbHIzUCzSEClkSSe7gXU5hYMjoBttFndFvxj75mzK/?=
 =?us-ascii?Q?wcIYwy7LeIUCSdIzYiirHnatWfrvHfvOnlQdjDuIJTaPF0r74MGzWvEZ5gmj?=
 =?us-ascii?Q?+kgMb+0NQq4mTGnPWW8Iafps+XKTCFv5a88vnwfusfBswRUMFKfyZ0+J8dTU?=
 =?us-ascii?Q?EPpCTt5N8bhnKdpyqjf/xzmIqCsn3D6CMBm74vlbJKwUonXIKowuylaKHwIZ?=
 =?us-ascii?Q?8kF5b/mOEHIYIm3QVgy4T5jC9MNjV2krzpNQdyb8MsV+k12jXtQJEnzNs4qu?=
 =?us-ascii?Q?WHeFF2y2Nb/5PEDdoTRCiHjn8vNtkpaDIGMVaYiK9mnPe0+yu5k6CVQKy7ZK?=
 =?us-ascii?Q?p3zSfcafbIvNpPVGwCusmsW5d8rJokk/3YMPJHFeTPjYBpc/obSmXySDhaCT?=
 =?us-ascii?Q?TosYSRZlglMaIiewbNLEdomCCpHsrWzPi4AIj+D6EqRLrmhg/brqgHcUwbpF?=
 =?us-ascii?Q?7e5tSkAN001F0TT/ItlX9M4Y8BOvHpvXXOORXMUVv8lflR8OkcOWykiEAjHJ?=
 =?us-ascii?Q?lYXHUK4jAWjrsvPBngXlODLpP9s9Vbpwvhxba8gC8lhxPvrJgiFij24kzQ4B?=
 =?us-ascii?Q?gZuRhqPpkmYkytAc3E85C6ZGDqBRvNIRX66rczKqTS+aoRIKxPoQ5+RZH0xo?=
 =?us-ascii?Q?ISNfY/8Pk2xC51zdNZhZ9+oc/yy0qkAOB/NbwhXi5hIZfw0jWQ/Y/BdKZfkZ?=
 =?us-ascii?Q?3ccF3cCpYtHy1sFQcxeY5dT8rUDUhSFgNafQjtGcebvtJBMFS9G2ghT+iipH?=
 =?us-ascii?Q?Mn6ByJGC075kmJlivODWxSw5gHnBBXvlEjCRL01PwkRbmP5nz7n1aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzglvYt7voNgYqmIFPI+u3AHstfXw743dfiKuCsxtoAbdCquzLroqDcfE0oB?=
 =?us-ascii?Q?cwDVQCgnm5gc/iOBLX/EaIi9+RpjzLwEnHxB8Elo0NNgfQ1z6kq4wS8DgK8Z?=
 =?us-ascii?Q?4yiCbvVCD0xu6ZNAx3iUL92vFDy/oK+BrrBX7DgRPdW3kHacInmNPokFLe+n?=
 =?us-ascii?Q?Dd8l/haD/j5gsTI6fVc/Cd5HuI7nUgqEVpoJmwxVERzmPYH1TpEDw4PejcmU?=
 =?us-ascii?Q?/EVFgqtOSVH/bz6BwWDKRi8eV7XAgYlfK4nc/Qmyptqg/Bg3N3rXLr+9Xj3g?=
 =?us-ascii?Q?4s0FAgattzpd7aBB112qLab7JUuBSehXaHaEfbPrYVzdIKazz2B6z8IRnyFk?=
 =?us-ascii?Q?F1UcpwyamzAvTxTpNPzdwhVjcm5tfoGhdcoyPJ6xVftpNbxG/ieS1Cplos9f?=
 =?us-ascii?Q?Y7VENjrbCKdU/sEYc/tRTX1QBQ5P9RPXxb3ShVVxnfkxEK8nAWsqevF7ib24?=
 =?us-ascii?Q?kvpw0uJ3gTdjsNpJOgtWdI75mUI//TunxzJ0o+swlSwkG0J23lZ2kr3qo/pw?=
 =?us-ascii?Q?BLU0qBVI4gfFNgWmz7Hi2oFgSqxHTkkZmbnpV4Gob9voN5rjw91+kVkXFju3?=
 =?us-ascii?Q?l9HeDSVfrwPJiOR3O7TUCjuT71LDOkQXB82NRubOzHoy2gJph/DOEvCGVhaB?=
 =?us-ascii?Q?as9rVSCzB7AqsXdWUy+sABXgUaFytQXawjnAvK66a+09HkQUEirL7w8NvCko?=
 =?us-ascii?Q?5p7jPlov7S7cUGDVz1JqmIosZM4/4ltasE0Hi/eBYQkkJeooDYo5m2rwgseB?=
 =?us-ascii?Q?E+9cZYMgFtwh6JRARe7IAyi8j4i1zK8aep1cNbKhpv7OV3Ml6TJNHf1nHuB8?=
 =?us-ascii?Q?ydkb3lsya/gT1RdFml+4VNQtfl40F9iVdrEbWQ9GaQM/McRVOfAxGBXHkqq9?=
 =?us-ascii?Q?uKbDuRKc1NnXV83dmwk1fzQQoXXZpu2imYI9lKoUqBjJg8pbVfCTXdI3PimY?=
 =?us-ascii?Q?EhpeTLDpsgMFwzz2mGlv9LYcDVb2A6wkSpNFp+Vj2fJQ8U8suN3Bo3GHKqYd?=
 =?us-ascii?Q?NIQFHEguCXeTyY32/KcSyRWMZILnLvgJL52yOv9AcS6ESIUjaNn4csoYQ2n4?=
 =?us-ascii?Q?Gzbt2PKmkX+SQTPVrvbXmxs2xVHBzs9tK6SoMfg3VgV6qtYfugwuWESP5Bc3?=
 =?us-ascii?Q?Utmsgm8GCXeIHkffw2sqAgT6+S0wibyZV5kg57ejbqFp6HLnma5GOLaBx2u4?=
 =?us-ascii?Q?BupwV8faL6bOg/NuS7QSzCaOKCo4IEsXlDgKqKY9chjDrgbZ8c8WQyPvs6Yb?=
 =?us-ascii?Q?NsBaW/kwtfPKoQr5e0ykbMGjnZqq8JRPD+0HbhtqneJSp/vjoaWZBzsgbudm?=
 =?us-ascii?Q?OMUrwI+RPaUKYt2kZYh8wkdQ0wT7ADVyT5S9lOiIhRcJa0+N5EGNUpaQu/Op?=
 =?us-ascii?Q?StunP7ZPET/wkXGaxifTJXvLDTJomGsJLYafaiwwBfTH7hZ0GjuYXyYUkVhn?=
 =?us-ascii?Q?slH6cX32s36hbPw7szCHQI3WNyEyf9G5y59j0Uwot96JPyEgbbENME9WPW85?=
 =?us-ascii?Q?PW2k1j1Fv61iM5n3a1PRsXdNs4RMtqeD7tuNOJ8UhHjAZsMWWnXvM23YhnD9?=
 =?us-ascii?Q?eJBWIFN98WEa/yLXwii8GT9CXRNeJx4qoa9A/rv/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf842e10-e53d-44e6-2e6a-08ddd36e1c81
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 15:46:43.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOhPYFKg57a27d9c3++BoCeHmI2wC8dfUB8xRK87hwKwbFz316l2KpiJPmox3D8lhhwJSxZPHmRcM0QoNVaeWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11432

Add nxp sdio vendor id and iw61x device id.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index fe3d6d98f8da..9109ef8fb0c6 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -116,6 +116,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.34.1


