Return-Path: <linux-wireless+bounces-29529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7718BCA6567
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 08:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F84313600B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE72FC88B;
	Fri,  5 Dec 2025 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j+QJXYb3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E312F83C2;
	Fri,  5 Dec 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917915; cv=fail; b=VKpCRP4Vc3jx6o3nVMkEHMKf7znozBZICTbGLvHcJKVSZGnM7vBfhceFmcgNTZJqe2CBTcHdlQjvRbNME/yevdbdolMjznxQD/oCDYGyo8qzBDXHDOxEXXBTbwgTKjGSUXQmfjmS7J6F6NloySGvPGklfLSY9UPEGfkaaDiie8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917915; c=relaxed/simple;
	bh=rjFAqmGAunq+A2rVobUf29rfxL8J2FaKZJh3XTvufAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CDPCAjLSfTZvI+UIvvSFXezdcpGlRMG2SI5l+oUYyC7MWKT7UhQkwN2Fgk8+759Sc3eKo8QtEjXng2GekSLcYePKFJKc63VrNRBCXg4ywArOhRRxQal3VK+IPHC1qA/QKqUjS3yXxOek+oln7S0L3t3RIbbiytI1lIFjsP9ZKqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j+QJXYb3; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOd9DIxaoroWCHSo1WS4Z/WmIhvwIoJ3HSnOduAswvic7NsSVY1O2e2bQ8qEcVntmB2iTI7K+AJ56d4UWWTZGfah8VQnXphU/NgLw94iyj79gt5QWpING645n+Z7SPhGp2MYHoOkIovRsmNRaeIiPlPPj3G4G0iHNutmqYOX2Y8NTVNFlS9SpRGUvoUu2kznN0Y2bAFLcvnaNsQFYwXxDfaFYacmOvWLU8qMWL1YT0nSM4hrcGePdfg2tbTPUF7juUDV5G1y0U2w+dn2mm/SqWT1IdvQUJYe6aDJHb8abjVpQnSPeZ7c0H5t9TYqkqsEgildV0SseganPE0X5/p/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sziBrxCTUL3VebxBPrHbiNIG5zbwEbusRVwj6Nhm1Qc=;
 b=KzgHfQwh0q5/nLmuolC4VuH0ixP6GiQ1sdFXk20AjTBfPTsyOY9oX2HuFyoGM0oqvC8n1EiuGlrDgyQyXVsRno3oJoPfQS2alxxLcr0jwFB049sdpd/f04pvqNf5Mp04FS+a/yNzIBy+7/CNTV1HtfOb3bg4fxf44a1yhiDnUCC/lX8/l170G0UFNOlx25OexUgmBQo1RbSe46X01N3+z6EmZoS1qYsHj5hgQtyuwcBYKLXDAWHN2PJVlL/N2EZiMO2NOyWluUCU0YlCBrlnZHC7Kzv5duOVjCGcaZ+yWt0Mzzna6uOeGYA28oOZ0UUru3HZufOpLke+3vIDm0otwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sziBrxCTUL3VebxBPrHbiNIG5zbwEbusRVwj6Nhm1Qc=;
 b=j+QJXYb3ZRt9tJFUGRkbq3AhtHKJkGN8QPBcjG4ZvEvEG6nWlGGy8LkjFSv+kjQyQnnCsun3k9oGpjWK+BvXAsCISJ4LJxH2w4u7V8w8N5nHxJC6iXYHZfKDhN/rLNGd163SNjH+1jxqeh/IlI/hoTfMyElI2c5nKCI3Xc7R83kYS/rLWBqSq5WJwtiH1nS19146QYuR1AUXq9V1NZvtZPQmLr3vtZUm6ymIvxSwq1OzYm/d+3dSjl6eicnYBEYv1QRo0q02Rp2ISfAHGfyzpDTTa8p0pMhJhKKhWHGhhzy3WRmMgVSkpVtF/3bcquNsHZtSJ8/2Ndk8wtvCX0r7Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:58:05 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 06:58:05 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v8 21/22] wifi: nxpwifi: add Kconfig and Makefile for kernel integration
Date: Fri,  5 Dec 2025 14:55:44 +0800
Message-Id: <20251205065545.3325032-22-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a43d95c-af51-4019-2aed-08de33cba3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pXIg59qe15PPxdUutWvhnwmtwpgge+5Yysuuoy4+BH3spHQ7K7Y2o70A/r4G?=
 =?us-ascii?Q?FVx5aX7oaZz6TDYQBxX7dODsuLraDvlE6X2GeQ3q83xSPNSXOZL54M1nzekz?=
 =?us-ascii?Q?dDmcdsR4VjojWSflUalEtsCVeB3CSth6zQ0oGOPWHr8nQc240VacMGFdwR38?=
 =?us-ascii?Q?haorKnNAasXocM8yRj+UnCMqFdcBc4EshGtvzlZpEmOM92tYXNna4EnHv4N3?=
 =?us-ascii?Q?r4G2voUkOI2J6NvngWhu6oTNgQP/lotUXVS4RlC0EP45WslqICHGUZ1alUQz?=
 =?us-ascii?Q?F7LU3g7LfNF03xMaGGa7FDsVwrEkX0YaH0eI3x4dJF7jAgbKbEwNZNAE23jz?=
 =?us-ascii?Q?dwe9Mb2zPnxx2PDvgBTf6SkVR6j2EuWde3dJsTEEB7z6DQ08ECTzfmR55rUM?=
 =?us-ascii?Q?TWrAqGHR5HN/KAQXRM57H9gf+YZauXkCJefz2WsHIn7DFmQLliFaVUrj2geY?=
 =?us-ascii?Q?aTE5wxpJh5FlIxZfVnxgaZVALjl7vIgRwg3sPDFlhYsLMNlhrzaBRwvHz2u6?=
 =?us-ascii?Q?ddUACZhvwKcRFMZOpoYykQAs8J2PtHXBR4468KjPGQAmsXjIaa5Mmq9RgIPu?=
 =?us-ascii?Q?O7Y9HoEtRO+xGVF7VYOXOeBgIhbpn8F++SS8ACaErJBPnu/tBJrw+5fMeY50?=
 =?us-ascii?Q?sQO+MCrCunqpmDoiOo/g7PK1eEFciwFgoqb8WsBvD2yumLzl5r1Y+kt4cUuO?=
 =?us-ascii?Q?9XqBTJfhOXz7Twv6TZjvedcFE7grMXoF1iCTuD9VKG7WlVgMxzQ0VzhPtdk0?=
 =?us-ascii?Q?gR6efO637WYvs8P9A+/ZGxBhbQGbEaYWJjk4mSBHTJV50OBmdyqOIXKqFzag?=
 =?us-ascii?Q?hYCkb2uY7eMVbhQ6InO/k/P4BMzkhGdujRiKjxKgnFYfV//CktMTlBmNTjBS?=
 =?us-ascii?Q?kQMc0fXRckWy6gGttdl3QqaqJIlTi/3RFx8wXmujHpED8rCGMXduwIHNID+U?=
 =?us-ascii?Q?6m5qtrOg8WLt+2Rz+i3OyMrck46yhPYXjzJPDPhkhKioUL1DS+DXfZ10HCCO?=
 =?us-ascii?Q?+c7hits4SO1O9az/7ClXhmnsv1dP2WzLQen7PK8b4WvG/wpnmYq4uxjbZN/n?=
 =?us-ascii?Q?LZjv+uN7ZKwkTpzDzvywDz7aJUP4IPLB80uYxNXUG1Uo2EilK7uD0NtIRbkN?=
 =?us-ascii?Q?1KfDahdFC6qyMFqcGegR6f68wxFIhJTCpyA27UKUyhMqHtRn6FchvZHsddUs?=
 =?us-ascii?Q?tJgNvd6Ap44z0/vYkIC8snQEwnatWMTREsRpoUIzQ0zKl8pNpfLv/umd3o3F?=
 =?us-ascii?Q?gecW/1SSd2r4PSLxZ7E0owi5h4PLevk2jyo9CDKKjSr5ZYeatcbJZXPF5Dqb?=
 =?us-ascii?Q?FMP51fWP7uTyLxpxwr7ZGMmMsc6lHmyWAX4gX/GXkfs9tpWl+VwuaEeLynaz?=
 =?us-ascii?Q?BlocWA0aLOOGIPGiRG+6l3x9RpyFmMwoAfDFJFqgmRsE0gz25KWIzPbQ39ZR?=
 =?us-ascii?Q?pL/+vNpiP1dtUw5ulbgSnk9+KlzemdFZ39GYdaQKt565Xmtj0vU1f5/aunBo?=
 =?us-ascii?Q?jR73BNvLIcHzWS5KRLY6Dr9r6FzXwH+KMgpm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cTo+uyFBNf68viZyCCDqfk+aDmBg2gMR9bUlsgEUH9Pnm2FIfwGcWdTGzgFB?=
 =?us-ascii?Q?2qkAnoZhHC/wtoeEYUn1EbHY1UgonmtqWjqV4aQbVLHDVudXK6XqzQGjU7tt?=
 =?us-ascii?Q?25e2I6V28rugCDlTQFAMbST1tuGbRlwbkUBRJJHAYt8oKYdh1J7LMC5GyFET?=
 =?us-ascii?Q?WLFra+7struf7lNz68bNGZtn08TYdmVwSAHsrvhPRPqEBbmF+Bw1m9Y4ZxuC?=
 =?us-ascii?Q?h1h/58BdoIW4lyQpPtUI7evWcSAmk3SRiUowgfv4OS4DMPnwRarpHSW9vnj8?=
 =?us-ascii?Q?b7OQ2mrbP8X2MBNsepBS0mZiZRFAmHVxFb+jzmOu2dP4mOiUiiCIMTAzQv5L?=
 =?us-ascii?Q?bGWk2pvjooBFqSKMNQmnXX/PkK/fCLEYBfl7Cx/18sG1MUbBLHGEI3Phx17b?=
 =?us-ascii?Q?p7GxdSFkVtnaimU43BmSc8pZx3fy9lNMf7nAed/IkXgyqM0qDf0znmZfU9sP?=
 =?us-ascii?Q?2UwrVTGydtTZeGx5T09dy6L5/GIUz/t5o+rRM6hw3ZGrPJsl8qWCn9pDCXBQ?=
 =?us-ascii?Q?lQAiVxyIkFYXu5YGw5gHv7usvkr1UeCn3t+J9hQaRuLzRuOD/VD4ZMJEiPMY?=
 =?us-ascii?Q?9XJ+zudUUl6N8xmtJZksbmG2/6GW4l09ZDF7i2BsiP7oQW+5bQdOS6sNVlcn?=
 =?us-ascii?Q?IQDTkEhA0S+3TBbxRKHHkgxSXAmqtz4+Fcva1vbaGd5gm1HkP8q1khlRXX1U?=
 =?us-ascii?Q?duTwhh8iAz8YVh07pcypXsInyV5oUN9yxvkcFmPgWPKGfZabnNuYUwWvdKmk?=
 =?us-ascii?Q?dyAiG3ieDXwF8+l0AWIIPDzV2WQfiu1F/h2pYFFaBYE9gXxEBi96dbrP8qx0?=
 =?us-ascii?Q?VVaSsJg4Dz3Vf7IA1yHYx9BJLrTqQ50Si23z7+2wA7/7fDJKQw8CAIQgVDKS?=
 =?us-ascii?Q?S+O2LtA3RqR2RT6IcOCXNhHzcOoGH/qc+248nmgNVHRB4M2e5ofVsYWzzUnj?=
 =?us-ascii?Q?FIa7BOJdrhiJXIW9UR+8Rs7CJFzxzXdkFdJMIAT1/mHUthMTdWqOr/TlENLL?=
 =?us-ascii?Q?BHGeoGhWg7NWYvZsnfcFETUyLNYORp/IaY5HrGvzwK0FSbjFqcLXuqgdwyLt?=
 =?us-ascii?Q?8WojeFqRJL5+pR5e7XImjWASfp12qtli7RSG5o5Zd3NIVexOj648vowVVDx/?=
 =?us-ascii?Q?6SVq99w2ys5U1q9Pw4+b/e23RVz4Wek0uXFov0NeK6/tcG/35v26/RW2rLx7?=
 =?us-ascii?Q?M0jrl/49X2foZcUIlltC9qRSLa7ZCiumlr3reHvTuGthV7cxAj1Y8ZFdiGvu?=
 =?us-ascii?Q?30Urbv30qn6C5m62VTaKn+z1JQQGRElZ6tavtSRShqLh2wnuxs8Csh1h/Ck9?=
 =?us-ascii?Q?PahzI0jqC8+M0S2EpI571pAkHkSOmfrw1LGWuaLAXW8AyaOjwIq0Gj8mNUuA?=
 =?us-ascii?Q?FT2BPwEB8ewLCROs9OtB1rym8e+3vDUd0SevL2HU22AT4Ryq3xTi9vp79yi/?=
 =?us-ascii?Q?A2nUsSlfHRGxzrvTLhfoy5YfLfgQDJg8BOZ/iUyNC1rA8q+QWsL5Ah7oDsom?=
 =?us-ascii?Q?Wu3QGKfK5fPhwHST/2f4I7gdWsAs0JlB6n2wVffXu0QxE5sRi+HCtJhXvnya?=
 =?us-ascii?Q?Mg1d2bf8bBtU720awFDoVjRYSL+t83d8IwrAsSKs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a43d95c-af51-4019-2aed-08de33cba3ff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:58:05.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+MDcHgXfgPjMU8qNdJoc+Nl84mjxbI10ZPOdZkpgNCY3rux718GfxdE/Ip0hzm3PmlzSOFCl8iBhgadvRUkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

Introduce Kconfig and Makefile entries to integrate the nxpwifi driver
into the kernel build system. This allows the driver to be configured
and compiled as part of the kernel tree.

Changes include:
- Adding WLAN_VENDOR_NXP entry under drivers/net/wireless
- Defining NXPWIFI and NXPWIFI_SDIO config options
- Creating Makefiles for nxp/ and nxpwifi/ directories
- Registering nxpwifi and nxpwifi_sdio as build targets

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 39 +++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..4d7b81182925 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/nxp/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..0c6b3cc719db 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_NXP) += nxp/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/nxp/Kconfig b/drivers/net/wireless/nxp/Kconfig
new file mode 100644
index 000000000000..68b32d4536e5
--- /dev/null
+++ b/drivers/net/wireless/nxp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_NXP
+	bool "NXP devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_NXP
+
+source "drivers/net/wireless/nxp/nxpwifi/Kconfig"
+
+endif # WLAN_VENDOR_NXP
diff --git a/drivers/net/wireless/nxp/Makefile b/drivers/net/wireless/nxp/Makefile
new file mode 100644
index 000000000000..27b41a0afdd2
--- /dev/null
+++ b/drivers/net/wireless/nxp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_NXPWIFI)	+= nxpwifi/
diff --git a/drivers/net/wireless/nxp/nxpwifi/Kconfig b/drivers/net/wireless/nxp/nxpwifi/Kconfig
new file mode 100644
index 000000000000..3637068574b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NXPWIFI
+	tristate "NXP WiFi Driver"
+	depends on CFG80211
+	help
+	  This adds support for wireless adapters based on NXP
+	  802.11n/ac chipsets.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi.
+
+config NXPWIFI_SDIO
+	tristate "NXP WiFi Driver for IW61x"
+	depends on NXPWIFI && MMC
+	select FW_LOADER
+	select WANT_DEV_COREDUMP
+	help
+	  This adds support for wireless adapters based on NXP
+	  IW61x interface.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi_sdio.
diff --git a/drivers/net/wireless/nxp/nxpwifi/Makefile b/drivers/net/wireless/nxp/nxpwifi/Makefile
new file mode 100644
index 000000000000..8f581429f28d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2011-2020 NXP
+#
+
+
+nxpwifi-y += main.o
+nxpwifi-y += init.o
+nxpwifi-y += cfp.o
+nxpwifi-y += cmdevt.o
+nxpwifi-y += util.o
+nxpwifi-y += txrx.o
+nxpwifi-y += wmm.o
+nxpwifi-y += 11n.o
+nxpwifi-y += 11ac.o
+nxpwifi-y += 11ax.o
+nxpwifi-y += 11n_aggr.o
+nxpwifi-y += 11n_rxreorder.o
+nxpwifi-y += scan.o
+nxpwifi-y += join.o
+nxpwifi-y += sta_cfg.o
+nxpwifi-y += sta_cmd.o
+nxpwifi-y += uap_cmd.o
+nxpwifi-y += ie.o
+nxpwifi-y += sta_event.o
+nxpwifi-y += uap_event.o
+nxpwifi-y += sta_tx.o
+nxpwifi-y += sta_rx.o
+nxpwifi-y += uap_txrx.o
+nxpwifi-y += cfg80211.o
+nxpwifi-y += ethtool.o
+nxpwifi-y += 11h.o
+nxpwifi-$(CONFIG_DEBUG_FS) += debugfs.o
+obj-$(CONFIG_NXPWIFI) += nxpwifi.o
+
+nxpwifi_sdio-y += sdio.o
+obj-$(CONFIG_NXPWIFI_SDIO) += nxpwifi_sdio.o
+
+ccflags-y += -D__CHECK_ENDIAN
-- 
2.34.1


