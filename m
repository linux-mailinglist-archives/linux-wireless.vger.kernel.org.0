Return-Path: <linux-wireless+bounces-25722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C843B0BC95
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DFF17A3CA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAB7283140;
	Mon, 21 Jul 2025 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ePF/rlw6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A8280CCE;
	Mon, 21 Jul 2025 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079498; cv=fail; b=ZFOD8ckzKtB7mf7UDJVuZ4ZsWRnAnZMV7G2pdtpn+b4GhHWLpkc+kFNUDxv1B++GDBtELxwd1veDyVKN4Zyvesca0H0hKa+7faSgTu0okMyBR9RTWNyU9ZW+mZlZjYio0NMDM4QqMDlR9/xsqE7GQ/xrUHXtAZT2hSL1zoZstAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079498; c=relaxed/simple;
	bh=ods0zNX2YgjEyEjSlEoBnvRmij94TNjhUmbfK5y5xYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvTgBtv2248fOsDAONdfYe1emFHqiklB4eb1qsMWKeXwA0awF2Z/TMfZLZLYnAphw4wE0OVkcPNremxLGOj2Tiwp1dtj8zm4rw4/oxx6inaag9u4CizoU+RKSzsjjjit36CbUZ0oMijWE0VfYKzkjIBnEv17DMiRVyJbKU/esSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ePF/rlw6; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5Ut7AzIoqBQnZX9m2/kyp/leDaKkKy4coYXCwHsVmr9S3FU8sETQwD9FL+/lLYb9MeSOJuvlphU/dTdg0+xCfrIFMO7Qgc+bO9fwd+0jb6qYozFYnuqsoprdjrPMldR0bIr88sME7BS6mU6LegnWxTVKoWpoS+gvK+EFGlqwHzu4/QhZ/wC8soQwqjctfseYbv5EgDmJaiaWRcuqBF7gAnI9NcBp6aboWQkY20fYHo0QkhNojCzMOWI586ZsD5DqoAAJsadgvQ3UeNFuP8fkDkstgGDcfjbQgXx3vqcdGtUInKwiVVtdYqM4okPxRbCqUapSbOkrvB4xcC5zXlkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDSDSOoi4+B0iCnDms9yNKaC31zModLrb7EIF8saVbA=;
 b=KzeMb8BJhTrRW4Ks3ibVIK6Ywxwyddgv32xFhbzqvzCJ6fUnZJ8gx7cT4g38A4kp12vu399E8/xaE22x5RaWReOUeqpqxGJlJve9gOXAuPBv4npv3s6n5Ggf/sKD6hc/93Cp+27YwCuCdhf51nLEjI1vThg8GPZ0Yzh7A3adMiKxdNxWar/SlKN7NmDyVJzW+wBH0O8nrSGiH8pnehIgf+X/LXS3/LmQriBM6kgO2C0Sy+8QH5ybhdOQZKrIQJC/Esvi3rUxG+mXOk5LAsel71avcQaTa1FPOKc5sWtBV5KBy4faqBa00rhtoGmBWIqPV+v6+6eOWEFnTeAwFT1CRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDSDSOoi4+B0iCnDms9yNKaC31zModLrb7EIF8saVbA=;
 b=ePF/rlw6QyoIRckDpNZFH9htgJvBuIt/6k1QDy1ye13e++sIDWbVa49kpWmoeBUnOabkNF2t20KbzuH4bcw0XIKRV5os6XIg1hfV2vuEq56SvLGoGvDY46IDK4KzO7GSGiq1BaheIeNoe8n0b5DOhocTa6RedhzCvwvrnN1TBF/LdCN4OMZ1sipJSrqPXsjKQdjT/1wD2JwHo7/lmIbUtwdnO4twD3fzJldn33cmlYPSQINp5GT4FCVX6wcuxzz2Tp3sBvwnX/Jx4+P5PD68kg49EFIeVD6Z2t+6+9vJrswoQ11RpyZngCeB7MF/1F09J7jDNo7j/E1YNbfIAGjUcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:31:28 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:31:28 +0000
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
Subject: [PATCH v4 08/22] wifi: nxpwifi: add cfp.c
Date: Mon, 21 Jul 2025 14:26:27 +0800
Message-Id: <20250721062641.2001796-9-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d75030d-ef38-4f5d-5aef-08ddc8203965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nG6+9EGfzl8f1uZFq1RTsQ+8rtnBxmK7Xx7El767ajKc4U2xF2/hmhPxPLzx?=
 =?us-ascii?Q?uL1FuXeJL6+kMHmLlBhRxyicvVIc8BGsfGDeXRSBI4iYdhWkwODUqF7bSCMR?=
 =?us-ascii?Q?VRLKcS0gmnHFe6VXM8dOfq3wz1DshFvZJFIa5qEBU/FNptsBUsLomTwek7jq?=
 =?us-ascii?Q?d5eS5AYmhSuk5CkN/BAeQiFaLUJkMCdTi7/ehTpd1scPl+3+QsKP/HxOEc9j?=
 =?us-ascii?Q?v3t+/MyiSoQvxAN4qDMu+0FR7XEEjBcIQ4Jzja7PvefDuKhHda0rzAEK6s/Z?=
 =?us-ascii?Q?VRq/CMj0OUcNUhPr1H+4sA9n6Kx+w7lasoy/EeYNMfq5Ho3V4qJ00JKCWzWV?=
 =?us-ascii?Q?6V0/yGV0BlYZBivlLfEKvP6SViUqv21pGesepTXNmtlCTA5BOYV0Zv3GnTgN?=
 =?us-ascii?Q?uXXWoQ4O4iQMGWeNzzbKz3jYAeoxhedC1wzc+8wAQmiV6HtluHW3xt+Oe2hw?=
 =?us-ascii?Q?V5MS1Cv1ZAUOl0FTpTu+64cwsEOWWjduKqmUVgq1Gz9FUtAWth9vaTCLAstC?=
 =?us-ascii?Q?J9YTc71UCJd50fLQSUD0xGt35eN4vF5BECOdsITs15Ct6z5vE2lY6EoUYBlJ?=
 =?us-ascii?Q?IJFYIGSpD03HIitjO4Yb1iXtEzfPWroPYIknhB+fFHfsg5ZOXynI1P3+cnkb?=
 =?us-ascii?Q?bOGCqq6Sf9wzs0xzrCFC72+DxXOOEBuocmD7/WyjSAKtUcwvfytDaDM7ycvr?=
 =?us-ascii?Q?fGdghMDRHVau0y0w/Ae+avcMPj4q6/eApJ1kkg5EBCwwbP3GInyDDd8fG0cJ?=
 =?us-ascii?Q?/ZtSm6fHMqRLpq3zI8Bnp/L9flK0yf6Rz2h4mqWMepPQwLlkHAYh/k7H+r5D?=
 =?us-ascii?Q?Ww7qWOGw8tVyE2JJJyrAIhbspI8XRlrJic3p9W5hUteyKG6qr7D9+kcS0me2?=
 =?us-ascii?Q?QuwdpR5Rj9rYQYgtWfaix5SzdVnLLuYtbHX/muMc5oaHUzNEp4EAJyymttef?=
 =?us-ascii?Q?PV7eLT8g9SdzJ1DEfvCtLRmTZBunkg64coidDb264XBMudJ8QEB1cxwTE7yM?=
 =?us-ascii?Q?4+cjasHHb/AzKfFRK8eLH+ZtStg7Z5hR/3GRW8TVw1aAO1FI/fk3vsmOB1v0?=
 =?us-ascii?Q?DH11DJCs6pDuuNy9EOU4PDs8HX5H4zzuVqFIPuWPilzIy0C+onCdFI8P/oVv?=
 =?us-ascii?Q?ImKQm9HK5tq4k+cLltluY1+KD9xZZf8ksyHEC+uaH/W3kXnixTy6BvlOjmnm?=
 =?us-ascii?Q?sXt6tQ4jvkKQCjcbjo7Cs/Byt8/phTbkwd0kzSxzrC0+GKoVM70vGPLeY5FV?=
 =?us-ascii?Q?bi7GsaJKQ5Whlj+GtcWeIvkOQzps4uNbzY/zfcQyzI5xKIR3osOGvXfAQ7YR?=
 =?us-ascii?Q?fuep6dwCnKYq4dqBKSURqOz6c+gLkOznoH3WBlrSzqtUGVYhjalpgDQpIg8H?=
 =?us-ascii?Q?6fbI+RqnL4V/OnL9HiS6Rx5fNz0UcVjNvbUt1iDPGHJh9f2m/n5f2V2Zkoz/?=
 =?us-ascii?Q?1k0FBFokmDo3AcrkqFhwdxYdPRNwwpYarbo88+7eAekfPDxIeBPH9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nvVCDCBu5Bm9rCgbtT5Xy1JQJEaDeI5FHoPbZVFR5MBDjuog2kl43/Yccijl?=
 =?us-ascii?Q?Hgw7yRK6Bnx/bG1ivkDW9MVv0pQdV/HQZx6/AutFKVw/6XQsCkncoPRYB6qz?=
 =?us-ascii?Q?z/WDvDOJvd/9xylOCiGsHeLvfaktbrhwDB+Ok4SdZb1z2CsbPCMog3E6vhk2?=
 =?us-ascii?Q?rQ6F13gQXbLB413TbmaZg8zQ33rTC6ZahECrBDnl3yhWV0Vq+OLoCPCzD7bN?=
 =?us-ascii?Q?JrfK1XKzk0MDw+C7A7gOEbvRK7yGM4wmfOqa0YqutP3uf/oCurFwNsqOVzxw?=
 =?us-ascii?Q?27Igh3jUTtcxEDk/8m8HbOcxYJcFbpWT0lOAoLJzhu+1+2nn9CnBI9suhR+h?=
 =?us-ascii?Q?Pasf3TpWf4TmOUX6r9sJfkXOthi5uJZd6/nWjBiuAeN7EIkpgvKoGwk9bIN7?=
 =?us-ascii?Q?7H9MXi1KcLjUR4uSA5EY0AGUWfL2GOSBLKFHUjZo57qgPglliuKl/22by/Ac?=
 =?us-ascii?Q?qpp4yo46gVvfZx5keqFW6HiB3mZZZvZwUcF1bVsNDTsgbN47Ut9+FZ72AePe?=
 =?us-ascii?Q?7Sb3utCAed1EJ1Y8qaqQw5Fw7JcEKLzaywlpHz5VyrfK/a9tMTm+XEAbk9p9?=
 =?us-ascii?Q?FKPcODzvJpKVzpo+KHkFV0wsMHiwfmmOUTu8EOtu/xdyIJr22KUGWd6ymmP8?=
 =?us-ascii?Q?FOuVPihfzYbGDFAgg9mks8rb5Mo5Yv7En15KEQChLYNMLc9F1m/53S7Il35I?=
 =?us-ascii?Q?Tt+m1X7gaxTQxb160PURQYmY5AfJu/2CKTTcaaNuTrZq5FOvYs2GHAiDy2BF?=
 =?us-ascii?Q?sDukuD5c9S21v1EqFZ0QP4DozX4LcGUPPWJR5XW1f6GDtoUcT2uMhksrsDls?=
 =?us-ascii?Q?ArjpLZGovOW2va4HSL/ittfxy/OXnG6Wk0mgacjd1ouxNsuqnLYTWCL6avhR?=
 =?us-ascii?Q?jcWYssey2QAON8P6FTNMddOis4UXPT+AhurE7IiToaosW6K223yhanzH+JVv?=
 =?us-ascii?Q?n3o18/f3Krw++C4UhknaFb+YrLTq0iIfj8lh+ljKNyBXVJp1jP2xj2dAf8p9?=
 =?us-ascii?Q?150ZOTOfPPStd8Cwz0cDsUWQdEbcy+843dNwwfJ6kv8Z1le11pGpIXpTtPZb?=
 =?us-ascii?Q?i7PPsQOqGrbV0XTnjnKy9ywPY1TpWBVxHyJNG9nxiCoqH2KE0AYCk/XpXBmn?=
 =?us-ascii?Q?1ZrZVTymgCZgJfUVd/RwAYoXt1LjLKdJ4hUpOW/xqGNhraxy9TS8GBT0SZDq?=
 =?us-ascii?Q?F/i8/p8QqJl5sM4wiTUN126wMq8+43k16UQ+zrE8BnhNPJr8eODyGbsAbx37?=
 =?us-ascii?Q?2VwWOX401eLhNuPOh/EP6OWG99lX+sJWwsMxEPPMQiZ+vIiS/k+JUcqeuZGr?=
 =?us-ascii?Q?pSLMmtyfej0JatsXJkv5LTLgz5A6i+yC09fLl0aPCbpP/Be4nZx+ILiyYBMR?=
 =?us-ascii?Q?XuLSUmC653Mc8fslacvLo805ykYdsXrnT+ACVNhJrizgdSG1mON3kvb4KTkH?=
 =?us-ascii?Q?yo0u16q2VwzhKCkRDsrW3q2g2QeM/ahFw+1LXO7KI6qI927ZxDvmoA7hmKlE?=
 =?us-ascii?Q?G6+Y5pJ2lUjG5I8CffEx0JST+wMFRLDZnR1xtdoNIZZd0cbbu9u1teslIktb?=
 =?us-ascii?Q?4LVp/fXRIEBa7dIceNQf1uo0yMePGm6Sfl5B5xX+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d75030d-ef38-4f5d-5aef-08ddc8203965
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:31:28.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Edh2jQ6wndmVdiSPyK3R69eUB5+Erkth0kJbpgSsMdQ89AIiY0on1g6A2+Ls8GsIFwOBUuGI98sMAAD4sSWXbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967

Files cfp.c supports functions related to channel/frequency/power.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/cfp.c | 475 +++++++++++++++++++++++++
 1 file changed, 475 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfp.c b/drivers/net/wireless/nxp/nxpwifi/cfp.c
new file mode 100644
index 000000000000..cd0dd4a25d2a
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/cfp.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: Channel, Frequency and Power
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "cfg80211.h"
+
+/* 100mW */
+#define NXPWIFI_TX_PWR_DEFAULT         20
+/* 100mW */
+#define NXPWIFI_TX_PWR_US_DEFAULT      20
+/* 50mW */
+#define NXPWIFI_TX_PWR_JP_DEFAULT      16
+/* 100mW */
+#define NXPWIFI_TX_PWR_FR_100MW        20
+/* 10mW */
+#define NXPWIFI_TX_PWR_FR_10MW         10
+/* 100mW */
+#define NXPWIFI_TX_PWR_EMEA_DEFAULT    20
+
+static u8 supported_rates_a[A_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0xb0, 0x48, 0x60, 0x6c, 0 };
+static u16 nxpwifi_data_rates[NXPWIFI_SUPPORTED_RATES_EXT] = { 0x02, 0x04,
+					0x0B, 0x16, 0x00, 0x0C, 0x12, 0x18,
+					0x24, 0x30, 0x48, 0x60, 0x6C, 0x90,
+					0x0D, 0x1A, 0x27, 0x34, 0x4E, 0x68,
+					0x75, 0x82, 0x0C, 0x1B, 0x36, 0x51,
+					0x6C, 0xA2, 0xD8, 0xF3, 0x10E, 0x00 };
+
+static u8 supported_rates_b[B_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x16, 0 };
+
+static u8 supported_rates_g[G_SUPPORTED_RATES] = { 0x0c, 0x12, 0x18, 0x24,
+					0x30, 0x48, 0x60, 0x6c, 0 };
+
+static u8 supported_rates_bg[BG_SUPPORTED_RATES] = { 0x02, 0x04, 0x0b, 0x0c,
+					0x12, 0x16, 0x18, 0x24, 0x30, 0x48,
+					0x60, 0x6c, 0 };
+
+u16 region_code_index[NXPWIFI_MAX_REGION_CODE] = { 0x00, 0x10, 0x20, 0x30,
+						0x31, 0x32, 0x40, 0x41, 0x50 };
+
+/* For every mcs_rate line, the first 8 bytes are for stream 1x1,
+ * and all 16 bytes are for stream 2x2.
+ */
+static const u16 mcs_rate[4][16] = {
+	/* LGI 40M */
+	{ 0x1b, 0x36, 0x51, 0x6c, 0xa2, 0xd8, 0xf3, 0x10e,
+	  0x36, 0x6c, 0xa2, 0xd8, 0x144, 0x1b0, 0x1e6, 0x21c },
+
+	/* SGI 40M */
+	{ 0x1e, 0x3c, 0x5a, 0x78, 0xb4, 0xf0, 0x10e, 0x12c,
+	  0x3c, 0x78, 0xb4, 0xf0, 0x168, 0x1e0, 0x21c, 0x258 },
+
+	/* LGI 20M */
+	{ 0x0d, 0x1a, 0x27, 0x34, 0x4e, 0x68, 0x75, 0x82,
+	  0x1a, 0x34, 0x4e, 0x68, 0x9c, 0xd0, 0xea, 0x104 },
+
+	/* SGI 20M */
+	{ 0x0e, 0x1c, 0x2b, 0x39, 0x56, 0x73, 0x82, 0x90,
+	  0x1c, 0x39, 0x56, 0x73, 0xad, 0xe7, 0x104, 0x120 }
+};
+
+/* AC rates */
+static const u16 ac_mcs_rate_nss1[8][10] = {
+	/* LG 160M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 160M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 80M */
+	{ 0x3B, 0x75, 0xB0, 0xEA, 0x15F, 0x1D4, 0x20F,
+	  0x249, 0x2BE, 0x30C },
+
+	/* SG 80M */
+	{ 0x41, 0x82, 0xC3, 0x104, 0x186, 0x208, 0x249,
+	  0x28A, 0x30C, 0x363 },
+
+	/* LG 40M */
+	{ 0x1B, 0x36, 0x51, 0x6C, 0xA2, 0xD8, 0xF3,
+	  0x10E, 0x144, 0x168 },
+
+	/* SG 40M */
+	{ 0x1E, 0x3C, 0x5A, 0x78, 0xB4, 0xF0, 0x10E,
+	  0x12C, 0x168, 0x190 },
+
+	/* LG 20M */
+	{ 0xD, 0x1A, 0x27, 0x34, 0x4E, 0x68, 0x75, 0x82, 0x9C, 0x00 },
+
+	/* SG 20M */
+	{ 0xF, 0x1D, 0x2C, 0x3A, 0x57, 0x74, 0x82, 0x91, 0xAE, 0x00 },
+};
+
+/* NSS2 note: the value in the table is 2 multiplier of the actual rate */
+static const u16 ac_mcs_rate_nss2[8][10] = {
+	/* LG 160M */
+	{ 0xEA, 0x1D4, 0x2BE, 0x3A8, 0x57C, 0x750, 0x83A,
+	  0x924, 0xAF8, 0xC30 },
+
+	/* SG 160M */
+	{ 0x104, 0x208, 0x30C, 0x410, 0x618, 0x820, 0x924,
+	  0xA28, 0xC30, 0xD8B },
+
+	/* LG 80M */
+	{ 0x75, 0xEA, 0x15F, 0x1D4, 0x2BE, 0x3A8, 0x41D,
+	  0x492, 0x57C, 0x618 },
+
+	/* SG 80M */
+	{ 0x82, 0x104, 0x186, 0x208, 0x30C, 0x410, 0x492,
+	  0x514, 0x618, 0x6C6 },
+
+	/* LG 40M */
+	{ 0x36, 0x6C, 0xA2, 0xD8, 0x144, 0x1B0, 0x1E6,
+	  0x21C, 0x288, 0x2D0 },
+
+	/* SG 40M */
+	{ 0x3C, 0x78, 0xB4, 0xF0, 0x168, 0x1E0, 0x21C,
+	  0x258, 0x2D0, 0x320 },
+
+	/* LG 20M */
+	{ 0x1A, 0x34, 0x4A, 0x68, 0x9C, 0xD0, 0xEA, 0x104,
+	  0x138, 0x00 },
+
+	/* SG 20M */
+	{ 0x1D, 0x3A, 0x57, 0x74, 0xAE, 0xE6, 0x104, 0x121,
+	  0x15B, 0x00 },
+};
+
+struct region_code_mapping {
+	u8 code;
+	u8 region[IEEE80211_COUNTRY_STRING_LEN];
+};
+
+static struct region_code_mapping region_code_mapping_t[] = {
+	{ 0x10, "US " }, /* US FCC */
+	{ 0x20, "CA " }, /* IC Canada */
+	{ 0x30, "FR " }, /* France */
+	{ 0x31, "ES " }, /* Spain */
+	{ 0x32, "FR " }, /* France */
+	{ 0x40, "JP " }, /* Japan */
+	{ 0x41, "JP " }, /* Japan */
+	{ 0x50, "CN " }, /* China */
+};
+
+/* This function converts integer code to region string */
+u8 *nxpwifi_11d_code_2_region(u8 code)
+{
+	u8 i;
+
+	/* Look for code in mapping table */
+	for (i = 0; i < ARRAY_SIZE(region_code_mapping_t); i++)
+		if (region_code_mapping_t[i].code == code)
+			return region_code_mapping_t[i].region;
+
+	return NULL;
+}
+
+/* This function maps an index in supported rates table into
+ * the corresponding data rate.
+ */
+u32 nxpwifi_index_to_acs_data_rate(struct nxpwifi_private *priv,
+				   u8 index, u8 ht_info)
+{
+	u32 rate = 0;
+	u8 mcs_index = 0;
+	u8 bw = 0;
+	u8 gi = 0;
+
+	if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_VHT) {
+		mcs_index = min(index & 0xF, 9);
+
+		/* 20M: bw=0, 40M: bw=1, 80M: bw=2, 160M: bw=3 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if ((index >> 4) == 1)	/* NSS = 2 */
+			rate = ac_mcs_rate_nss2[2 * (3 - bw) + gi][mcs_index];
+		else			/* NSS = 1 */
+			rate = ac_mcs_rate_nss1[2 * (3 - bw) + gi][mcs_index];
+	} else if ((ht_info & 0x3) == NXPWIFI_RATE_FORMAT_HT) {
+		/* 20M: bw=0, 40M: bw=1 */
+		bw = (ht_info & 0xC) >> 2;
+
+		/* LGI: gi =0, SGI: gi = 1 */
+		gi = (ht_info & 0x10) >> 4;
+
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (gi == 1)
+				rate = 0x0D;    /* MCS 32 SGI rate */
+			else
+				rate = 0x0C;    /* MCS 32 LGI rate */
+		} else if (index < 16) {
+			if (bw == 1 || bw == 0)
+				rate = mcs_rate[2 * (1 - bw) + gi][index];
+			else
+				rate = nxpwifi_data_rates[0];
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		/* 11n non-HT rates */
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+
+	return rate;
+}
+
+/* This function maps an index in supported rates table into
+ * the corresponding data rate.
+ */
+u32 nxpwifi_index_to_data_rate(struct nxpwifi_private *priv,
+			       u8 index, u8 ht_info)
+{
+	u32 mcs_num_supp =
+		(priv->adapter->user_dev_mcs_support == HT_STREAM_2X2) ? 16 : 8;
+	u32 rate;
+
+	if (priv->adapter->is_hw_11ac_capable)
+		return nxpwifi_index_to_acs_data_rate(priv, index, ht_info);
+
+	if (ht_info & BIT(0)) {
+		if (index == NXPWIFI_RATE_BITMAP_MCS0) {
+			if (ht_info & BIT(2))
+				rate = 0x0D;	/* MCS 32 SGI rate */
+			else
+				rate = 0x0C;	/* MCS 32 LGI rate */
+		} else if (index < mcs_num_supp) {
+			if (ht_info & BIT(1)) {
+				if (ht_info & BIT(2))
+					/* SGI, 40M */
+					rate = mcs_rate[1][index];
+				else
+					/* LGI, 40M */
+					rate = mcs_rate[0][index];
+			} else {
+				if (ht_info & BIT(2))
+					/* SGI, 20M */
+					rate = mcs_rate[3][index];
+				else
+					/* LGI, 20M */
+					rate = mcs_rate[2][index];
+			}
+		} else {
+			rate = nxpwifi_data_rates[0];
+		}
+	} else {
+		if (index >= NXPWIFI_SUPPORTED_RATES_EXT)
+			index = 0;
+		rate = nxpwifi_data_rates[index];
+	}
+	return rate;
+}
+
+/* This function returns the current active data rates.
+ *
+ * The result may vary depending upon connection status.
+ */
+u32 nxpwifi_get_active_data_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	if (!priv->media_connected)
+		return nxpwifi_get_supported_rates(priv, rates);
+	else
+		return nxpwifi_copy_rates(rates, 0,
+					  priv->curr_bss_params.data_rates,
+					  priv->curr_bss_params.num_of_rates);
+}
+
+/* This function locates the Channel-Frequency-Power triplet based upon
+ * band and channel/frequency parameters.
+ */
+struct nxpwifi_chan_freq_power *
+nxpwifi_get_cfp(struct nxpwifi_private *priv, u8 band, u16 channel, u32 freq)
+{
+	struct nxpwifi_chan_freq_power *cfp = NULL;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *ch = NULL;
+	int i;
+
+	if (!channel && !freq)
+		return cfp;
+
+	if (nxpwifi_band_to_radio_type(band) == HOST_SCAN_RADIO_TYPE_BG)
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_2GHZ];
+	else
+		sband = priv->wdev.wiphy->bands[NL80211_BAND_5GHZ];
+
+	if (!sband) {
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "%s: cannot find cfp by band %d\n",
+			    __func__, band);
+		return cfp;
+	}
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		if (ch->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		if (freq) {
+			if (ch->center_freq == freq)
+				break;
+		} else {
+			/* find by valid channel*/
+			if (ch->hw_value == channel ||
+			    channel == FIRST_VALID_CHANNEL)
+				break;
+		}
+	}
+	if (i == sband->n_channels) {
+		nxpwifi_dbg(priv->adapter, WARN,
+			    "%s: cannot find cfp by band %d\t"
+			    "& channel=%d freq=%d\n",
+			    __func__, band, channel, freq);
+	} else {
+		if (!ch)
+			return cfp;
+
+		priv->cfp.channel = ch->hw_value;
+		priv->cfp.freq = ch->center_freq;
+		priv->cfp.max_tx_power = ch->max_power;
+		cfp = &priv->cfp;
+	}
+
+	return cfp;
+}
+
+/* This function checks if the data rate is set to auto.
+ */
+u8
+nxpwifi_is_rate_auto(struct nxpwifi_private *priv)
+{
+	u32 i;
+	int rate_num = 0;
+
+	for (i = 0; i < ARRAY_SIZE(priv->bitmap_rates); i++)
+		if (priv->bitmap_rates[i])
+			rate_num++;
+
+	if (rate_num > 1)
+		return true;
+	else
+		return false;
+}
+
+/* This function gets the supported data rates from bitmask inside
+ * cfg80211_scan_request.
+ */
+u32 nxpwifi_get_rates_from_cfg80211(struct nxpwifi_private *priv,
+				    u8 *rates, u8 radio_type)
+{
+	struct wiphy *wiphy = priv->adapter->wiphy;
+	struct cfg80211_scan_request *request = priv->scan_request;
+	u32 num_rates, rate_mask;
+	struct ieee80211_supported_band *sband;
+	int i;
+
+	if (radio_type) {
+		sband = wiphy->bands[NL80211_BAND_5GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_5GHZ];
+	} else {
+		sband = wiphy->bands[NL80211_BAND_2GHZ];
+		if (WARN_ON_ONCE(!sband))
+			return 0;
+		rate_mask = request->rates[NL80211_BAND_2GHZ];
+	}
+
+	num_rates = 0;
+	for (i = 0; i < sband->n_bitrates; i++) {
+		if ((BIT(i) & rate_mask) == 0)
+			continue; /* skip rate */
+		rates[num_rates++] = (u8)(sband->bitrates[i].bitrate / 5);
+	}
+
+	return num_rates;
+}
+
+/* Convert config_bands to B/G/A band
+ */
+static u16 nxpwifi_convert_config_bands(u16 config_bands)
+{
+	u16 bands = 0;
+
+	if (config_bands & BAND_B)
+		bands |= BAND_B;
+	if (config_bands & BAND_G || config_bands & BAND_GN ||
+	    config_bands & BAND_GAC || config_bands & BAND_GAX)
+		bands |= BAND_G;
+	if (config_bands & BAND_A || config_bands & BAND_AN ||
+	    config_bands & BAND_AAC || config_bands & BAND_AAX)
+		bands |= BAND_A;
+
+	return bands;
+}
+
+/* This function gets the supported data rates. The function works in
+ * infra mode by printing the band and returning the data rates.
+ */
+u32 nxpwifi_get_supported_rates(struct nxpwifi_private *priv, u8 *rates)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	u32 k = 0;
+	u16 bands = 0;
+
+	bands = nxpwifi_convert_config_bands(adapter->fw_bands);
+
+	if (priv->bss_mode == NL80211_IFTYPE_STATION) {
+		if (bands == BAND_B) {
+			/* B only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_b\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_b,
+					       sizeof(supported_rates_b));
+		} else if (bands == BAND_G) {
+			/* G only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_g\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_g,
+					       sizeof(supported_rates_g));
+		} else if (bands & (BAND_B | BAND_G)) {
+			/* BG only */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_bg\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_bg,
+					       sizeof(supported_rates_bg));
+		} else if (bands & BAND_A) {
+			/* support A */
+			nxpwifi_dbg(adapter, INFO, "info: infra band=%d\t"
+				    "supported_rates_a\n",
+				    priv->config_bands);
+			k = nxpwifi_copy_rates(rates, k, supported_rates_a,
+					       sizeof(supported_rates_a));
+		}
+	}
+
+	return k;
+}
+
+u8 nxpwifi_adjust_data_rate(struct nxpwifi_private *priv,
+			    u8 rx_rate, u8 rate_info)
+{
+	u8 rate_index = 0;
+
+	/* HT40 */
+	if ((rate_info & BIT(0)) && (rate_info & BIT(1)))
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 +
+			     NXPWIFI_BW20_MCS_NUM + rx_rate;
+	else if (rate_info & BIT(0)) /* HT20 */
+		rate_index = NXPWIFI_RATE_INDEX_MCS0 + rx_rate;
+	else
+		rate_index = (rx_rate > NXPWIFI_RATE_INDEX_OFDM0) ?
+			      rx_rate - 1 : rx_rate;
+
+	if (rate_index >= NXPWIFI_MAX_AC_RX_RATES)
+		rate_index = NXPWIFI_MAX_AC_RX_RATES - 1;
+
+	return rate_index;
+}
-- 
2.34.1


