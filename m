Return-Path: <linux-wireless+bounces-9974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F0E926E13
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 05:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD9B21289
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 03:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB518B04;
	Thu,  4 Jul 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="niDzVGs8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FF1CABF;
	Thu,  4 Jul 2024 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720063845; cv=fail; b=SKD6l5OwavPyhzYtqCkiSLvXjnBh+COgVUpfqhAW4EVDpd/LJWkD0nNE7tO+IBcNFjqG1YjZZ3sBJVMIbQnsu+WS3VgtPSXXQc7kYz/T1U1kj+lKQJh3y/7rwMc54gbuFnOdvXvi1yMjjW9ioy/CW5//WqlibRzvD5aJOY4zaTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720063845; c=relaxed/simple;
	bh=KFb8ouL6/CUcT7GLIq2z3iZpjC+4m6StHi+XX3jKiek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9oFcA1wL/Xcf7/KTn+bC8PUGk/sLwNjc/qbdoVhXRZo2hCdvueFu1SCiL/SP323wiLDDsXxW0OFKRZgXj3DIyYh/tzUmp2IU5jzJ3QP5Mp5FyZSrlqgtOTBnDNHccqz5iEXE2l3kAz8fq+pHWhd1AZT1CSlGlr2rp+n+hVtQMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=niDzVGs8; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpW5xMKG5z7pOQVHPppHNKowalzr5QCGgjMRNlvf8DuEn9SqLcoBCnaJREV7kbBSMZUwRaKEE6avmJsOJ1UNIOgk7ufvZePcrQqOtidoMl7kzGeDqfMN39gPokVWzipe88xuRzt4GHYvJmnzaPnZ0hC/9UqXUJ6/gtkpbxWftlObJhFvFacvZuF69mbtv7iPaJRIEVojCqFIvf4QL0KdGTD3Tw/SQ7HfmvLRSUZB+Rf6nF4nAB2Bw3qfmsNY0TRfCwXlSirQlrljsgpPs69QvRbZegDfnAukN9y1IXfEjLjvwXMw6S2qdXv4aPaIXygeafzwfhU1F4EFj+M4yEcyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJM3PvJ2glBr3SkmzydWU0SaXocPLJ4S/x2S0O+JULU=;
 b=iauKst+IozpUAqUaaFQkMl91rQ7WS7RC3ALCcYGLv193bfO7WdVrmcE+wJdygT/4bHuOS6w4voMkApq9pM2Av0lgIqyUTjZX522JOls7cwyVlhCckJpFqyEkcqrZ/2Er8/hVhQxaP9H3DdK9a9Oz9rt5IbO8YW7dajYS1xrymFclRBtuY95vjjk/JdRfKZ6V0WLlq3nCkviyVb93mv+BR9gZ6GU2pTgzkEcqth+5CYQT5ZEFbDE7NPAj7mRoLwnSBlDMF5FUvVOpfj+6rjxaVu1QDfPMpHUXodehjiRDQc1CM16y/ebI2R5KtbpI012ojIcBUXbgzczKVPFVLZue2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJM3PvJ2glBr3SkmzydWU0SaXocPLJ4S/x2S0O+JULU=;
 b=niDzVGs8+H+BuyqOLQriAo5rdAasXIR/+UcVHrGrJW/FBWA8sfOqT7bDUjq0xiDipU8ql/EI17RJeotPL/uGW6T7jyQejQ3rxSe6u3HJ3xm5jUzDJAqmVS5mVpaa7bVXkIDBuYG6EHUYd7OyU5VbdK8EpM35IzbAVBx4JZJzJnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 4 Jul
 2024 03:30:38 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7719.036; Thu, 4 Jul 2024
 03:30:38 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v11 2/2] wifi: mwifiex: add host mlme for AP mode
Date: Thu,  4 Jul 2024 11:30:01 +0800
Message-Id: <20240704033001.603419-3-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704033001.603419-1-yu-hao.lin@nxp.com>
References: <20240704033001.603419-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DB8PR04MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5a3bba-c4bd-446b-ddba-08dc9bd9ac56
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?zdNZErm2EQMD5uOfCCnpa6GVdozepl2UZfWxYYE1IQ6abjmMauDLHNWvsOYq?=
 =?us-ascii?Q?faZjfZGb+MjMqsvti+7ODahgPDF30mQLA04yoOAEvYyOjcqcIpmV3beh6wbk?=
 =?us-ascii?Q?U5aNDXKa93Fvol0cgqncwi8KUI/S6iyvvrK57JnI6n334WKYI44a/iuoIC2p?=
 =?us-ascii?Q?CFIvbn5tUscjAC3Tgo0+5STtRf3P6LBb1LpzeB+hTH98N+BzWriZ6RrJUIj3?=
 =?us-ascii?Q?RCTgFwb/JANG49RlouWLjd7KzUHS3SVtr0ApF/JN4UFaAwT4jDrw9btnRT2R?=
 =?us-ascii?Q?iIwwXek8dlgw8tDhCmPGMQnEBBRd2epxJryAEvCM+rsZt0MKpKJFTPyG0CDV?=
 =?us-ascii?Q?XPXXzVqRIvHGEqW0GPPFlhGjWvpUhgWLNO9xPb7qfvqQE0fr2ZwETlFSFibj?=
 =?us-ascii?Q?RMmgNL4uBGE0o+MNvDy5gisMD6hDo0CiBqFg5/vHue3IKi1mgYuZVsfBj8hH?=
 =?us-ascii?Q?56PyjgWRCsVCd6/B48p1aUL6a3QnwYomq14+EFEEa0RLo0l74vFMj1aXIYdi?=
 =?us-ascii?Q?omKM/AvYaDMNM7XGQlKqIfYOFwBwYrt00vj9ua0ucKYHTO4W93/o9WYzdXT3?=
 =?us-ascii?Q?N0KML5u9IrKnh0ivZAW0fPXBsAVcFV6RSOb1upvGgPj9VEs9vVr3ntH+Cm/z?=
 =?us-ascii?Q?2HUkoUO4PGrihqMM9EGhVHDqQBhr/tEQPeOIzMSHPpRHplydC7Di0vYDbDR8?=
 =?us-ascii?Q?Aaispkib7hWI7BPXlfz2x/Xb7rjokQ9XebDW3hYdEtr5MHHds5v/gSCxRGNw?=
 =?us-ascii?Q?DnnhHMm45SoDwiWt4sxn2e1VCIFDdGB7yJWkot+lMx8jJGO/2m0+zeVLK014?=
 =?us-ascii?Q?tBFLuQWcfO6SXYhaNo6WQgyD2IYZviBDdDa0psltue1geVjH6A4BpT60Zank?=
 =?us-ascii?Q?84pfbCbZAfdCpeHGBU1gY0ywSI5SswfSHR95xC+H3efbfNbCrTv5Ej4YEgD2?=
 =?us-ascii?Q?SFHVZoyrDAnhpGiJO2gFiK7cCU45bEqkAhb6JqwJ4aavaAVX8IDMUZ3lPZIy?=
 =?us-ascii?Q?7VKZgfiklU/ITRJxw4c9YXEq8mWa3VE9+45vQTMllizKVefM7FfKrG30eLPR?=
 =?us-ascii?Q?mF/UCUbNRpoIQNFp7g1T39i3mwX0cmtK4xFiLSSLQhvCS+pIp5DvBlOypOqY?=
 =?us-ascii?Q?SJTB6C3r4YaABE1pzA3N70Pz5iS2ncZgO/tt05vlYZI/lEqBJ70SHjQsS8Sh?=
 =?us-ascii?Q?aSGpi5F87Tl/f0UHkvcOsuYim/tWSgeQTu7EgcmEBakudjQcH+FFpiMlmR7D?=
 =?us-ascii?Q?Pi35vHvaWm1dSUc+8HFRjp4L7uCKD3C/wl+06PkHSx7T4cMXznbI4zNbjPK5?=
 =?us-ascii?Q?+QisBMk56mkQj2BeQCz4Qixz0KS71RlwnODLBCgAgmRmRlE5FuGQjIl50Vns?=
 =?us-ascii?Q?dE2EsSkRnIWVvv41NnZSU71OHUdr8mE3mXoS2eZwgHPq4QQNtQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?2dweLYuJ8Mut4Xa8BWu7V8wIF9VL7QSJK9TvfNVIQLc3BxpqjcFp13guFaBU?=
 =?us-ascii?Q?aHO3IrydzRw6iytKKWr6Ag9vTt2CX6VStxBXraNnhOM5enjCxmeYQ1wsGoZX?=
 =?us-ascii?Q?PQZYkXhUOdjqI8VvFI1GBqo9IZNA0dfbfjrv/B6R5JTeEOfW2Hh9C3Dgazkj?=
 =?us-ascii?Q?+a5I32JQFNs6qjd+MBZ0kHL+DWlzEqBUoC0a+oj/G/VFJzQPyzjXMhJMmNRW?=
 =?us-ascii?Q?vD1r2xFTM91nnC+DMXYVETUlfokgIllngpGHY/yVavpNfQqX8S1Lfj/3zkMH?=
 =?us-ascii?Q?wsms3ijjGiDzlre0GnmR2h4SukTZZLaEZ/eAAzhRUxWg+7KAcrqNFdDv9ygQ?=
 =?us-ascii?Q?SSinqJcbjowePZsh6i34po3uf8co2Iv5ysk+g/bc6Y0emgCZtap3QSI1Amus?=
 =?us-ascii?Q?P0r2f11nhgCNsg4BGU9y2EU5n3ItrznZS2X9OtVuqA4nzel9FOijbHFUZdX9?=
 =?us-ascii?Q?44XQ2fmMz5/QsnNZMSfGUhmsb93dzifzmZDrMI22h57WCGzrQWChp4T7k/9p?=
 =?us-ascii?Q?M1KzJ8d2hV8QPdLpwhMtOnwwGPDYLDisN4AojdqJHq2CJghN1CLMmZFrsUVS?=
 =?us-ascii?Q?6BYMV/Gkxq6jGiYLJXP2kcA5ypNtkbJqJ9xSGV5fzbGTVos49qKlPY46ocKT?=
 =?us-ascii?Q?3HATw699i34GmC6CM2QC/THTPfsNHWayw7YcHLjCJtNol1UY8NKvwU8hcAaz?=
 =?us-ascii?Q?VLE5cemBjErk1of7j524lIoYrKqm3+JT983+pdRMJUWCXqQaBeIMulJ4VfID?=
 =?us-ascii?Q?CHhjTkbGHqRfelPBxgcjAA2tS22q1lNAbiBu16mO8zQLSqy3re4/nzfJMyr7?=
 =?us-ascii?Q?lJ0o4TXF9K1n4/zYT3BIzCAmgpdC4aa7XecFkI4w/OQmu31z7VFobrbFFhwb?=
 =?us-ascii?Q?M49hvF2/Pa3yJ98myQFSfUqpDkaGcAYQbKnYpOfAPPfO5B6sPTmgFAzXD6bJ?=
 =?us-ascii?Q?eYgjZxp/ZMZMu9cCYtbaKRkFCSoRGgOOTVhTwbfZ3Ab9DHs4Uhoq5gKmKJk3?=
 =?us-ascii?Q?uF3Ev7zp+5PwWWjPeLa/qPHY9qjMU7mgvuRdqjLfofvNpjDiaI7TvYq/E8WV?=
 =?us-ascii?Q?8RmrJ8Z7Ai1+3PDyo2hQKTNZDdqZK+7Ee5tIgu+Vm2azVRn5ORt3qamObK/W?=
 =?us-ascii?Q?+oJpeoWrabPzg1RUa4NRo1DrjfuZbdQTi1q6uPMv6amN1LFDXLlWznHAauXp?=
 =?us-ascii?Q?D/22Q2Fa9bv519JhfUK3vkxedPv6IWCogR4bknMQr+Ek724yI8F99QZlGHVM?=
 =?us-ascii?Q?yDDkJqUXDqUpF31if4jgPvbXIcWOaqWtLU7/UXkJLZLzXEj9UOoe6PilW4qC?=
 =?us-ascii?Q?ENxDyzVMwiG+cK/FFRGbxvaOt+/l7VmL30Na6otPEl+kxLDfmBgffZrFpVC5?=
 =?us-ascii?Q?ynrwTzvnAvb13pjSNHRXNSvCF1RcAYx192Gl1AJPrI2S4ZEXboILHBblF91A?=
 =?us-ascii?Q?I5JegvgLdzqsjtvsfPQLTPm2d3W4RVZ2rHN5omQhOiTlF0UR1b07lrhyy0/A?=
 =?us-ascii?Q?Csj4cnvcIh13gaWjSd8NO8XPHB9xUHoq4kyUylczKi1bzx/j4CI8t6sAGlit?=
 =?us-ascii?Q?rYRW3+Nkg/r1DUW/8KRe4B0StCGgvOi7ehTIZEY+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5a3bba-c4bd-446b-ddba-08dc9bd9ac56
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 03:30:38.3089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfnMSUmZu2uiMczmHXcf0g7bT5c1ZykJPO4MYTA/wX13vkJlTcBAFhma3v4N3t0gLn/iBKb1ku7gO6gnNkpm/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7082

Add host based MLME to enable WPA3 functionalities in AP mode.
This feature required a firmware with the corresponding V2 Key API
support. The feature (WPA3) is currently enabled and verified only
on IW416. Also, verified no regression with change when host MLME
is disabled.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Brian Norris <briannorris@chromium.org>
---

v11:
   - modify 'mwifiex_mgmt_stypes' to allow multi-adapters with different
     setting of host_mlme_enbaled.

v10:
   - none

v9:
   - remove unnecessary goto target.

v8:
   - first full and complete patch to support host based MLME for AP
     mode.

---
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  86 ++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |   2 +
 drivers/net/wireless/marvell/mwifiex/fw.h     |  21 +++
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
 drivers/net/wireless/marvell/mwifiex/main.h   |   1 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   |  24 +++
 8 files changed, 309 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d3f7de13832d..77fabdeb5ab4 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -221,6 +221,26 @@ mwifiex_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		return 0;
 	}
 
+	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
+		if (ieee80211_is_auth(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: send auth to %pM\n", mgmt->da);
+		if (ieee80211_is_deauth(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: send deauth to %pM\n", mgmt->da);
+		if (ieee80211_is_disassoc(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send disassoc to %pM\n", mgmt->da);
+		if (ieee80211_is_assoc_resp(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send assoc resp to %pM\n",
+				    mgmt->da);
+		if (ieee80211_is_reassoc_resp(mgmt->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: send reassoc resp to %pM\n",
+				    mgmt->da);
+	}
+
 	pkt_len = len + ETH_ALEN;
 	skb = dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
 			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +
@@ -505,6 +525,9 @@ mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wiphy,
 
 	wiphy_dbg(wiphy, "set default mgmt key, key index=%d\n", key_index);
 
+	if (priv->adapter->host_mlme_enabled)
+		return 0;
+
 	memset(&encrypt_key, 0, sizeof(struct mwifiex_ds_encrypt_key));
 	encrypt_key.key_len = WLAN_KEY_LEN_CCMP;
 	encrypt_key.key_index = key_index;
@@ -3953,12 +3976,43 @@ mwifiex_cfg80211_tdls_cancel_chan_switch(struct wiphy *wiphy,
 	}
 }
 
+static int
+mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv, const u8 *mac,
+				 struct station_parameters *params)
+{
+	struct mwifiex_sta_info add_sta;
+	int ret;
+
+	memcpy(add_sta.peer_mac, mac, ETH_ALEN);
+	add_sta.params = params;
+
+	ret = mwifiex_send_cmd(priv, HostCmd_CMD_ADD_NEW_STATION,
+			       HostCmd_ACT_ADD_STA, 0, (void *)&add_sta, true);
+
+	if (!ret) {
+		struct station_info *sinfo;
+
+		sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+		if (!sinfo)
+			return -ENOMEM;
+
+		cfg80211_new_sta(priv->netdev, mac, sinfo, GFP_KERNEL);
+		kfree(sinfo);
+	}
+
+	return ret;
+}
+
 static int
 mwifiex_cfg80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 			     const u8 *mac, struct station_parameters *params)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
+		return mwifiex_cfg80211_uap_add_station(priv, mac, params);
+
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
 
@@ -4196,6 +4250,10 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
 	int ret;
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
+		return 0;
+
 	/* we support change_station handler only for TDLS peers*/
 	if (!(params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)))
 		return -EOPNOTSUPP;
@@ -4668,7 +4726,25 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
-	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
+	if (adapter->host_mlme_enabled) {
+		memcpy(adapter->mwifiex_mgmt_stypes,
+		       mwifiex_mgmt_stypes,
+		       NUM_NL80211_IFTYPES *
+		       sizeof(struct ieee80211_txrx_stypes));
+
+		adapter->mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].tx = 0xffff;
+		adapter->mwifiex_mgmt_stypes[NL80211_IFTYPE_AP].rx =
+			BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+			BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+			BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4) |
+			BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+			BIT(IEEE80211_STYPE_ACTION >> 4);
+		wiphy->mgmt_stypes = adapter->mwifiex_mgmt_stypes;
+	} else {
+		wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
+	}
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
@@ -4710,14 +4786,18 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 
 	ether_addr_copy(wiphy->perm_addr, adapter->perm_addr);
 	wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
-	wiphy->flags |= WIPHY_FLAG_HAVE_AP_SME |
-			WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD |
+	wiphy->flags |= WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD |
 			WIPHY_FLAG_AP_UAPSD |
 			WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 			WIPHY_FLAG_HAS_CHANNEL_SWITCH |
 			WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT;
 
+	if (adapter->host_mlme_enabled)
+		wiphy->flags |= WIPHY_FLAG_REPORTS_OBSS;
+	else
+		wiphy->flags |= WIPHY_FLAG_HAVE_AP_SME;
+
 	if (ISSUPP_TDLS_ENABLED(adapter->fw_cap_info))
 		wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 				WIPHY_FLAG_TDLS_EXTERNAL_SETUP;
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index da983e27023c..ea6ebc9c23ef 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -635,6 +635,8 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
 		case HostCmd_CMD_UAP_STA_DEAUTH:
 		case HOST_CMD_APCMD_SYS_RESET:
 		case HOST_CMD_APCMD_STA_LIST:
+		case HostCmd_CMD_CHAN_REPORT_REQUEST:
+		case HostCmd_CMD_ADD_NEW_STATION:
 			ret = mwifiex_uap_prepare_cmd(priv, cmd_no, cmd_action,
 						      cmd_oid, data_buf,
 						      cmd_ptr);
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 0f89b86aa527..65799ae3bc72 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -211,6 +211,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
 #define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_UAP_STA_FLAGS      (PROPRIETARY_TLV_BASE_ID + 313)
 #define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
 
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
@@ -407,6 +408,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define HostCmd_CMD_STA_CONFIGURE		      0x023f
 #define HostCmd_CMD_CHAN_REGION_CFG		      0x0242
 #define HostCmd_CMD_PACKET_AGGR_CTRL		      0x0251
+#define HostCmd_CMD_ADD_NEW_STATION		      0x025f
 
 #define PROTOCOL_NO_SECURITY        0x01
 #define PROTOCOL_STATIC_WEP         0x02
@@ -417,6 +419,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define KEY_MGMT_NONE               0x04
 #define KEY_MGMT_PSK                0x02
 #define KEY_MGMT_EAP                0x01
+#define KEY_MGMT_SAE                0x400
 #define CIPHER_TKIP                 0x04
 #define CIPHER_AES_CCMP             0x08
 #define VALID_CIPHER_BITMAP         0x0c
@@ -502,6 +505,9 @@ enum mwifiex_channel_flags {
 #define HostCmd_ACT_GET_TX              0x0008
 #define HostCmd_ACT_GET_BOTH            0x000c
 
+#define HostCmd_ACT_REMOVE_STA          0x0
+#define HostCmd_ACT_ADD_STA             0x1
+
 #define RF_ANTENNA_AUTO                 0xFFFF
 
 #define HostCmd_SET_SEQ_NO_BSS_INFO(seq, num, type) \
@@ -2331,6 +2337,20 @@ struct host_cmd_ds_sta_configure {
 	u8 tlv_buffer[];
 } __packed;
 
+struct mwifiex_ie_types_sta_flag {
+	struct mwifiex_ie_types_header header;
+	__le32 sta_flags;
+} __packed;
+
+struct host_cmd_ds_add_station {
+	__le16 action;
+	__le16 aid;
+	u8 peer_mac[ETH_ALEN];
+	__le32 listen_interval;
+	__le16 cap_info;
+	u8 tlv[];
+} __packed;
+
 struct host_cmd_ds_command {
 	__le16 command;
 	__le16 size;
@@ -2409,6 +2429,7 @@ struct host_cmd_ds_command {
 		struct host_cmd_ds_chan_region_cfg reg_cfg;
 		struct host_cmd_ds_pkt_aggr_ctrl pkt_aggr_ctrl;
 		struct host_cmd_ds_sta_configure sta_cfg;
+		struct host_cmd_ds_add_station sta_info;
 	} params;
 } __packed;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index e8825f302de8..516159b721d3 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -158,6 +158,11 @@ struct mwifiex_bss_info {
 	u8 bssid[ETH_ALEN];
 };
 
+struct mwifiex_sta_info {
+	u8 peer_mac[ETH_ALEN];
+	struct station_parameters *params;
+};
+
 #define MAX_NUM_TID     8
 
 #define MAX_RX_WINSIZE  64
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index a0fdabc43fff..9b700bd010ca 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1008,6 +1008,7 @@ struct mwifiex_adapter {
 
 	bool ext_scan;
 	bool host_mlme_enabled;
+	struct ieee80211_txrx_stypes mwifiex_mgmt_stypes[NUM_NL80211_IFTYPES];
 	u8 fw_api_ver;
 	u8 key_api_major_ver, key_api_minor_ver;
 	u8 max_p2p_conn, max_sta_conn;
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 7b69d27e0c0e..9c53825f222d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -1398,6 +1398,8 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_private *priv, u16 cmdresp_no,
 		break;
 	case HostCmd_CMD_UAP_STA_DEAUTH:
 		break;
+	case HostCmd_CMD_ADD_NEW_STATION:
+		break;
 	case HOST_CMD_APCMD_SYS_RESET:
 		break;
 	case HostCmd_CMD_MEF_CFG:
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 491e36611909..073c665183b3 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
 				bss_config->key_mgmt = KEY_MGMT_PSK;
 			}
 			break;
+		case WLAN_AKM_SUITE_SAE:
+			bss_config->protocol = PROTOCOL_WPA2;
+			bss_config->key_mgmt = KEY_MGMT_SAE;
+			break;
 		default:
 			break;
 		}
@@ -751,6 +755,28 @@ mwifiex_cmd_uap_sys_config(struct host_cmd_ds_command *cmd, u16 cmd_action,
 	return 0;
 }
 
+/* This function prepares AP start up command with or without host MLME
+ */
+static void mwifiex_cmd_uap_bss_start(struct mwifiex_private *priv,
+				     struct host_cmd_ds_command *cmd)
+{
+	struct mwifiex_ie_types_host_mlme *tlv;
+	int size;
+
+	cmd->command = cpu_to_le16(HostCmd_CMD_UAP_BSS_START);
+	size = S_DS_GEN;
+
+	if (priv->adapter->host_mlme_enabled) {
+		tlv = (struct mwifiex_ie_types_host_mlme *)((u8 *)cmd + size);
+		tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+		tlv->header.len = cpu_to_le16(sizeof(tlv->host_mlme));
+		tlv->host_mlme = 1;
+		size += sizeof(struct mwifiex_ie_types_host_mlme);
+	}
+
+	cmd->size = cpu_to_le16(size);
+}
+
 /* This function prepares AP specific deauth command with mac supplied in
  * function parameter.
  */
@@ -768,6 +794,144 @@ static int mwifiex_cmd_uap_sta_deauth(struct mwifiex_private *priv,
 	return 0;
 }
 
+/* This function prepares AP specific add station command.
+ */
+static int mwifiex_cmd_uap_add_station(struct mwifiex_private *priv,
+				       struct host_cmd_ds_command *cmd,
+				       u16 cmd_action, void *data_buf)
+{
+	struct host_cmd_ds_add_station *new_sta = &cmd->params.sta_info;
+	struct mwifiex_sta_info *add_sta = (struct mwifiex_sta_info *)data_buf;
+	struct station_parameters *params = add_sta->params;
+	struct mwifiex_sta_node *sta_ptr;
+	u8 *pos;
+	u8 qos_capa;
+	u16 header_len = sizeof(struct mwifiex_ie_types_header);
+	u16 tlv_len;
+	int size;
+	struct mwifiex_ie_types_data *tlv;
+	struct mwifiex_ie_types_sta_flag *sta_flag;
+	int i;
+
+	cmd->command = cpu_to_le16(HostCmd_CMD_ADD_NEW_STATION);
+	new_sta->action = cpu_to_le16(cmd_action);
+	size = sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
+
+	if (cmd_action == HostCmd_ACT_ADD_STA)
+		sta_ptr = mwifiex_add_sta_entry(priv, add_sta->peer_mac);
+	else
+		sta_ptr = mwifiex_get_sta_entry(priv, add_sta->peer_mac);
+
+	if (!sta_ptr)
+		return -1;
+
+	memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
+
+	if (cmd_action == HostCmd_ACT_REMOVE_STA) {
+		cmd->size = cpu_to_le16(size);
+		return 0;
+	}
+
+	new_sta->aid = cpu_to_le16(params->aid);
+	new_sta->listen_interval = cpu_to_le32(params->listen_interval);
+	new_sta->cap_info = cpu_to_le16(params->capability);
+
+	pos = new_sta->tlv;
+
+	if (params->sta_flags_set & NL80211_STA_FLAG_WME)
+		sta_ptr->is_wmm_enabled = 1;
+	sta_flag = (struct mwifiex_ie_types_sta_flag *)pos;
+	sta_flag->header.type = cpu_to_le16(TLV_TYPE_UAP_STA_FLAGS);
+	sta_flag->header.len = cpu_to_le16(sizeof(__le32));
+	sta_flag->sta_flags = cpu_to_le32(params->sta_flags_set);
+	pos += sizeof(struct mwifiex_ie_types_sta_flag);
+	size += sizeof(struct mwifiex_ie_types_sta_flag);
+
+	if (params->ext_capab_len) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_EXT_CAPABILITY);
+		tlv_len = params->ext_capab_len;
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->ext_capab, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	if (params->link_sta_params.supported_rates_len) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_SUPP_RATES);
+		tlv_len = params->link_sta_params.supported_rates_len;
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data,
+		       params->link_sta_params.supported_rates, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	if (params->uapsd_queues || params->max_sp) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_QOS_CAPA);
+		tlv_len = sizeof(qos_capa);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		qos_capa = params->uapsd_queues | (params->max_sp << 5);
+		memcpy(tlv->data, &qos_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_wmm_enabled = 1;
+	}
+
+	if (params->link_sta_params.ht_capa) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_HT_CAPABILITY);
+		tlv_len = sizeof(struct ieee80211_ht_cap);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.ht_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_11n_enabled = 1;
+		sta_ptr->max_amsdu =
+			le16_to_cpu(params->link_sta_params.ht_capa->cap_info) &
+			IEEE80211_HT_CAP_MAX_AMSDU ?
+			MWIFIEX_TX_DATA_BUF_SIZE_8K :
+			MWIFIEX_TX_DATA_BUF_SIZE_4K;
+	}
+
+	if (params->link_sta_params.vht_capa) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_VHT_CAPABILITY);
+		tlv_len = sizeof(struct ieee80211_vht_cap);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, params->link_sta_params.vht_capa, tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+		sta_ptr->is_11ac_enabled = 1;
+	}
+
+	if (params->link_sta_params.opmode_notif_used) {
+		tlv = (struct mwifiex_ie_types_data *)pos;
+		tlv->header.type = cpu_to_le16(WLAN_EID_OPMODE_NOTIF);
+		tlv_len = sizeof(u8);
+		tlv->header.len = cpu_to_le16(tlv_len);
+		memcpy(tlv->data, &params->link_sta_params.opmode_notif,
+		       tlv_len);
+		pos += (header_len + tlv_len);
+		size += (header_len + tlv_len);
+	}
+
+	for (i = 0; i < MAX_NUM_TID; i++) {
+		if (sta_ptr->is_11n_enabled)
+			sta_ptr->ampdu_sta[i] =
+				      priv->aggr_prio_tbl[i].ampdu_user;
+		else
+			sta_ptr->ampdu_sta[i] = BA_STREAM_NOT_ALLOWED;
+	}
+
+	memset(sta_ptr->rx_seq, 0xff, sizeof(sta_ptr->rx_seq));
+	cmd->size = cpu_to_le16(size);
+
+	return 0;
+}
+
 /* This function prepares the AP specific commands before sending them
  * to the firmware.
  * This is a generic function which calls specific command preparation
@@ -785,6 +949,8 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *priv, u16 cmd_no,
 			return -1;
 		break;
 	case HostCmd_CMD_UAP_BSS_START:
+		mwifiex_cmd_uap_bss_start(priv, cmd);
+		break;
 	case HostCmd_CMD_UAP_BSS_STOP:
 	case HOST_CMD_APCMD_SYS_RESET:
 	case HOST_CMD_APCMD_STA_LIST:
@@ -800,6 +966,11 @@ int mwifiex_uap_prepare_cmd(struct mwifiex_private *priv, u16 cmd_no,
 							  data_buf))
 			return -1;
 		break;
+	case HostCmd_CMD_ADD_NEW_STATION:
+		if (mwifiex_cmd_uap_add_station(priv, cmd, cmd_action,
+						data_buf))
+			return -1;
+		break;
 	default:
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "PREP_CMD: unknown cmd %#x\n", cmd_no);
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 3817c08a1507..42c04bf858da 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -497,6 +497,30 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
 	}
 
+	if (priv->adapter->host_mlme_enabled &&
+	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP)) {
+		if (ieee80211_is_auth(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive auth from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_deauth(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive deauth from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_disassoc(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive disassoc from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_assoc_req(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive assoc req from %pM\n",
+				    ieee_hdr->addr2);
+		if (ieee80211_is_reassoc_req(ieee_hdr->frame_control))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "assoc: receive reassoc req from %pM\n",
+				    ieee_hdr->addr2);
+	}
+
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
 			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
 			 0);
-- 
2.34.1


