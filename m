Return-Path: <linux-wireless+bounces-25737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F113EB0BCB5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928D41886A42
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E0D289E02;
	Mon, 21 Jul 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bHN0ndOh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16B28981C;
	Mon, 21 Jul 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079550; cv=fail; b=A9oXndMX0Fl8ElskuX6jmZ7i5JedSO05jmSXhTnfbebZQiQDlRrrjDt4l316CNfICAK4wCqaB8KX5KumC1r5HQVDqKa5Fg55+pFkJ89L28zA4NBPjBJHiSQyL08vEgTy3xlZrheV4LVDGMiWGFLYEgiMpUynVveXVPJAeFWZIVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079550; c=relaxed/simple;
	bh=LShs/VFzcKl3tNGMojKWvNRRaiSG6bjnbDtqYevjj6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIwiIQHEXwX23dIPQDgIdLOA2zxVk4PlMTsIO7Fjy7/IRcUj4ts9X/AyqvFAEi8sfYNyLxFrcQ8acyjTUq7yXFu9GEa2TmFZNCpOE9PWEX5ILr6OIKVwwp+Y9aFxkyCZ7rrS4006iuambDxoeugM6+GxBJLu8FPCmbpKmlUzTsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bHN0ndOh; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOU69lym4upZrvUEKiZkPsuLSXxbIeV+onYQzSxv0zDFyEW2b6I9yYUTJhNs12EK2qxu9iR1UTsVIze5z0BWtI8fFAtv5eqCDhhsyJDluEh6oBHdl/rJ+OZekkntlRcc/RZrXkG/m6xYmMsk+xmhrBBnHCeigt7K46r3dxuwLnwYrTXnEyVsVzEr4fTmKn5vmY1xWeM7L32z8SXCCKpA/+ZBNqq2CkX3qB/OQUHYJ9a1hV9zsZUdu5t3nRUzNzSfyXcGabc8Inf0+BRL1tW0GTatSGBVQRmp9/mIa8CVu3k/1lUVQlwzf8m6I5M8SGR6RV28TyKi7FlvbkADDEZdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPOD0LYSwgSlny31QKnVE7wnJgqCHlzSufPzsDwzPio=;
 b=HhrIkUpRes5sRHu/0fJbTLcAZHS+URutotUVadJgJ7b0QIscfzMr6jSW+QCUudJ1w1Uhn0/Sth2+q5YJf3X49DKjRWtowTglHlNiXPi4HIMEFBKrVX3fy2yxUR6Y53N2R80RfQ5qfuFtp9AOr3udgRMYcfUSLiud8mnD/tDJNuOlIIhQJKC4VZcN1vu5ImR091TlHFVVwtbg/0BXYi9LivKT4p5HeQAGMUbTQjCnuy4C4Pvh0vTG43bvs0D92H5aUpgr8ZNgDYQXcdJSjSpS0hoXQFx9oeC7o0pazUD8FCfpgHvGuCYYQT9nFe7760uVulLUpLk/AcKT6SZbuBBWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPOD0LYSwgSlny31QKnVE7wnJgqCHlzSufPzsDwzPio=;
 b=bHN0ndOhQW9DmFw871Zc/r+8uXdQgv0xBu0OFiMf4Bld9WCeGXIQt2Am4RmpHbFzt+fV3O9jM7n53N5668LBWjqSkNZHO3BsT/N8SUF3AJA10CgVRlccekh9VH/FPFCMgN9i+aABXQG0yP7zuaYToFZyWubBlnnEC+RXvuWaQjIEuOrdpVaIeshQP2GbCm7jZVyo5J+g/W4pCGDy+P2h6CAfuuqCjBTd6JPWKFANQ+kiTnBjr+8RjpF71pMkKVVHmUBxkFoMna2VPMEHqtX2cybGGJdQr9u56u60SfbSX5gAxkK5vOfsNf47fGv86+i0ksMBUQHM12F6kPXO/U6YVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:32:16 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:32:16 +0000
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
Subject: [PATCH v4 21/22] wifi: nxpwifi: add makefile and kconfig files
Date: Mon, 21 Jul 2025 14:26:40 +0800
Message-Id: <20250721062641.2001796-22-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|AM8PR04MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a24265a-0c7e-4bb3-fb4f-08ddc82055a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pgadV6IpuiVJwA3xKW3O0wGkPT4frO5y1Aw8OuqIjWHjtyEtcSBT1Nc76w7w?=
 =?us-ascii?Q?w2cCfHS4RcflHeuyjgcKhD76cVamdrleuw4ve3PGPN1sfa48RWqhbmubBx2h?=
 =?us-ascii?Q?quWs6znLFXg12hkJXQZKLz9Ju3+Vi2zH1/SixouoleKQAQGJIF8bsSQKu1V7?=
 =?us-ascii?Q?GWh30lP4SZMITQMNVF/O8ubtloMBmcd63u85JYq4z47IzusH0nSwsxea4RJ9?=
 =?us-ascii?Q?EUvNHTRCBbQjFtyPLYZ08lhqrs4ua6z2tJp3H2NbYquZ0B4SmvN2rKQBfWqH?=
 =?us-ascii?Q?lL71QfVBcAM97+qqeWRCceuOogQiDJ9ACd5RZMD5j1H4qBGzHlJm786SyyCZ?=
 =?us-ascii?Q?uhGsQgcvXbEj8WrpJNrpDmEtSMUTWFRTCvl8XYyd+sqffgIgXgYPAelHwBv4?=
 =?us-ascii?Q?OnpsHZNTUtbQaZGki/i3rykWq5V5FHB4UvbenPp7iolvTkjSPy0FatlfzIBf?=
 =?us-ascii?Q?uIEwFaLwUn68UHRBQpmoXmnEDwiKf8x7PsmINbY65kp05j5Vf19YDypPfHQQ?=
 =?us-ascii?Q?r0fJC47NH1oZSyq2ePh3T1yGomDPsOuXZHvQFDmiBxe24J4GhKfex/PG7rl5?=
 =?us-ascii?Q?4cFZpmSZE3mBWjJoZ45JqE8gydqaMmCe+DaxW5HC5Hg3JiFl6i4OC6ilVBPq?=
 =?us-ascii?Q?XI8A7i7vUUH8Md14IZaoPQG8+qLcG4EzW9dR66XfSB+1Ii6Dr71+BrmppoKQ?=
 =?us-ascii?Q?jHZ+ahQRkVeHfcnXoxToQOg4z86PnbbOSQXkyZoxJREPr6a7pNs0KvptfUVd?=
 =?us-ascii?Q?MQ7tgwRvu/t1rroMD7IxlVNsE0OJeU+X0ayvoHnYiDlITh3g03tpwZ8UaQ77?=
 =?us-ascii?Q?LIoY0Vif662bHMdt/b8Qk2ZGfxTubbFsEhzYNNGlhx/aqgj8ha2ggSjtoqt+?=
 =?us-ascii?Q?Mc96GZ7g0epXLN9QrVbwyzn0Bx7tdIyBoDgWKTh+bjYXw0oY3DPxkCerTh0I?=
 =?us-ascii?Q?L6e2Yww8FpW512Bz9uuxruRX5bI+JIY+94+1ng9FMaV9mXHOGSaHOpag4JFJ?=
 =?us-ascii?Q?JAd1+9tfnKf4vxcdL9P1jZImPiz/QCEiZa1R7cjv4GnJlWcsViALESiPqIpY?=
 =?us-ascii?Q?3HXC8uuLCXZFPyT+X/ye6cKDA0iKI1iwELCNvSzKi1FoK3xj7Hz2z27KlFNq?=
 =?us-ascii?Q?R6eRMDCEHvbD4cYkPnrmb17/9u8qA2aZwM+dS2OvosYf3fBrmX8qU5zqaq67?=
 =?us-ascii?Q?0lzdfZ8SOdcR7FLKt43Yq2WB/4bjuxhP5qKFIl2T1UqhpPCvsvpalb3k2zXg?=
 =?us-ascii?Q?9fjaRGOBy3XUVpzna0LpsI7SDOG40/F+3H04fbbRXMN0l2D2kJ/eLJZ/9ORA?=
 =?us-ascii?Q?HwGFwol4JVmPp4P8hL9lzWn3u0s3RL98L5EgfeTStGOMF7lgzmNhSQIup2yo?=
 =?us-ascii?Q?GizQUqD3urhrAaQDpr4z6VX2OXvxSekoWyHCE3GFXIsM8oUX2TaQX0T+b1RX?=
 =?us-ascii?Q?5OAKGN1GVzLT3SwCeOwWb2v6LuuqhouY9RpMlTMfSed0d+xiyfvXlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YAAA20JUvlYXqOss44k4+Ax3PYjM8HpDMIG/stgAQPf2u2/outQoGxL+x8xz?=
 =?us-ascii?Q?DCOpWf+9YmJzHeZQ987XU+chwFyThvir+jPYFkEFLrarY/IiqpdtmD1ejWKb?=
 =?us-ascii?Q?wxwKp29cecVyOJ5K5LdXWVMZM7nTEfwKrxg0q//n++IV3u1PcKX94CmXDfFz?=
 =?us-ascii?Q?90NdQxIWUxGd/Fg5OusBvnubZTceGsce4MHQZcdZQqIz8rEjIs2KsklSAxfD?=
 =?us-ascii?Q?HC4gvN7q5X8prsEObtFSOeIrKJ11Sc8HRLcyuHTneyBQpb1mTPQ7Fh7pPOnM?=
 =?us-ascii?Q?q13pWwMnn9wJADejix47//+svKVpOtT2R5IILypsE426YCYKiXXh8A0hZPVc?=
 =?us-ascii?Q?+oGNfCB3pCFrV+12i6h3YQc7gmqLO8hEK4jRHXjCNo81ZvqeSgCN3KSpSzg+?=
 =?us-ascii?Q?zZ4uP1DrofhG//9zfr/xinPpX11kSGRxSVnUHnbnlAVyQA9+ntr+WnVW0DYa?=
 =?us-ascii?Q?buPep89WxbhzYI/RwpVkwIkxXlauDc2YvzNob4iuPHM40h+Du/RB75DBrnsU?=
 =?us-ascii?Q?5/QeDXMoSkvFRaH8cSCnHzQbOmis+U8DnCEX+5mrayptQjZ6Qawty1dn8CrL?=
 =?us-ascii?Q?tZrvVkTkoJAqDHTddjB5V/cTETJS2x+iJFJx3nkILKInDiQZoIfalXUg4Qr/?=
 =?us-ascii?Q?EkxrFBoRu4ojwnUcRfK+aMbIm1sKlaChELQIrdIBlUZepwCJUKbqQ0teZ+qy?=
 =?us-ascii?Q?Ht7MVxgpyqhFWimZQ/5DA7+F6P7Hce4/4ScVIfFzYKwZq7TjHCBpwGURoA1D?=
 =?us-ascii?Q?KKItSm5AYletTwg8Mauwlv+Pc+88dmEZJvYklpftKJYPItb8k5+j2eEnyCtV?=
 =?us-ascii?Q?2cCVkTfcPuQbY0QE7QarqA/WUMD/fvty4oIEHwnaYPsUbnfeGb/38at/bWNU?=
 =?us-ascii?Q?0TDRgk6miGXkzu/cbCHWoHbEOd3zAXwrDqiNSk8+/IA3OQzEtNR6jRqwcfBK?=
 =?us-ascii?Q?RcZRgdKuxtp9b7Ltm8whjDMyUwVyxY+8Uyw9Im9u3HDPUa+kOzmwI18ARGEc?=
 =?us-ascii?Q?Gsh4vV/Cd/N32+Cjn0Nu9qvuV2T5oKUyVN2ph3YuG7jqJfCORm73QwMCWdez?=
 =?us-ascii?Q?I5C0wjQZVWWVrZfkuTvHq7DmulNJTqVOuPz1CY/DbbhjXIotWKyTstz3o5Bk?=
 =?us-ascii?Q?gx3MFkXHnLGruygUpIbLA8ZtrpwjwJ51RYS3DmTqU6c2d8rflWhNrsFX19GJ?=
 =?us-ascii?Q?4u4BXKCiK/JRy6ZVd3HDB3OaAn9XKlNOT6BIWoSk2XuLaVBvVXp2JkmMUYLh?=
 =?us-ascii?Q?agucciViEUdAa9WYBRnREHS3FJbzFP58MA1M3apN735F6Z5J2FEjlliRnoi6?=
 =?us-ascii?Q?yzcN4NrUtsb6Yk7lSEMaSwP1f3Hs9VPWO2XZ0BYcxnzBUedE8Hnj5NYQwdRI?=
 =?us-ascii?Q?k5dQprzBa8em6kPYPc+7YkGp/tq2b1pUkynlniOdPJ3qOU8Qd/+/uUaFmhDa?=
 =?us-ascii?Q?lZ+83KDJKso4SaQ7giPouA7Bk3OXL7D3fr4LPglDM4FziGBe2ot3/teq+16F?=
 =?us-ascii?Q?zTe/OFtIKosC5o9uo4LAtqyK+mrw4EqIVllRmyuQv7S5KEDzomO2amb0Bu/b?=
 =?us-ascii?Q?zmzQgpGglW5znYqt4kUhISRDaysr27UmsTtbmQBN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a24265a-0c7e-4bb3-fb4f-08ddc82055a2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:32:16.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th/UtiifhsOxdOlFLyDj+awnkqQ9DMVRoSZjeGmq3jTtBu6Cr/wBaHPWYKNb6RXoxpLcnNT4NPPe+h5Eo2EvAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780

Let nxpwifi can be configured and compiled under
kernel source tree.

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


