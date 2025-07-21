Return-Path: <linux-wireless+bounces-25738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9506DB0BCBB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7941C7ADB8B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7B28A1CC;
	Mon, 21 Jul 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eTbCQaMU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136E289E0C;
	Mon, 21 Jul 2025 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079553; cv=fail; b=i+LBvKcW9Tw/sulApJECsxmXBBN+cqUBk2v0zzg1caLEfftwBxsK6UH4ufZLaVGsh/xYE7WfEHAxxEjgEMwCeqsm8YVbx2cPm+RhJ29AhAFO3RXzcixHtfqY+CO5RCJjUENi/cAKDdRzeBVdDCDtf45Eqkx74pFmQ0zAYIj4PRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079553; c=relaxed/simple;
	bh=E+ERBeY7+KvMAFTOldDO9wLTSYcyF9E3b5E0NCrddP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhxI5pH668532PstRd+pa7nIUczxzCsb5fC3MM1c/fgt1DnmevSUFtqRDjazPpAZkFZHaqp7UNlg9qtHLIaTuz3E+oI34n/8QSeZxNoAL1DO5WOsw55+Q0U6ugnUZxhYmSzDnRHQvOYsGanyMuVLjPJEkS7LFWuftRXVHTct7vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eTbCQaMU; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEIQPYzo8mDE++SMhGePhYaFmjnfMmmZ7pOB3S9f9rgKNmdykE0BfstCzo7dDBKsISunaRKNcA2rzpO5MkDzL5o6m8vOMS77kTIXc4L1Cop6e5tEAe0llu7sOLJ2TZ/2QL2ge5K1D5oaNY/4d5fI7NA0UBwCcHJccBwzb7uAO4kKa8ilveXTc2Q8tmxadJl0M1ENGz6d7btqsPxscd7Xyw9Ye3n0vtX3g7gCqQJ+yDQb0MetWA5ERIUKcHPbzLYWfr4yuaRaknllltYew65TkUDFzp+sB8A4V174zNe/x8S5B2jD9wHm+xtrbIt8W3awnOw6LbNAf4cjnC8bd98rYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY7N7xxDBlg6QDv8pZpjpqoEwY5BGDKvRreOn8NNzW0=;
 b=y8hk+//FjmWd5UyuW4+BBYQerCKPrT8ya8fXk1UMUcDs4f/HWonTIWIn023n4mFIDNOjkBAhZ1JLcw/W7YkVfWX+Fszz9KgxKYP6Eq0sC/Ts/NthPhNNXnl4Xahv/iewKzoDk6uQnQ13lMRjqlgbWdjV6KHwQiL+bOq22Lkrbmp3da/hX58QCtxbewMcYNZT6jzsRnNe+tkdIn7Rb+ekNLGp2Lg81pAyojnq3qVV7kg9DaHMPcFjwbFnC3dXFmlqKKHjoT/s65bNRr4jb4ISR6Ho06Nv4D1EsfpuOyGwAALmy7Qcx8DDDG5qjj5rcrlGmKSHTx6MJKqVu6oDcQqP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY7N7xxDBlg6QDv8pZpjpqoEwY5BGDKvRreOn8NNzW0=;
 b=eTbCQaMUQ1o4mhmVVTMg1TxTHTkTEO2msg26W/7bGwcydceXpc74Pl8IGsEqTKBsBu9EGWJ9qsW+KmNqC4vsbM5dpuVDeqRodfRBAB+X6DVEOnPw/+olEhHD3brE6LNeFCMC6vq/K+gZuorN9I3MgZ1/LosT6wK06ilB6K2cfLr9Q/7k4FnbQzihrw+cW1eoXEKFbCZ1BXtsiQVKijkjrkaiAYcty7IF7hR+0dtMzTqh295I5Izw+rr4xWfcaPSlBffofbRIm1vtS5y7IWV+/IYNh8HPhDPi3RMwvaGZS68JslOkS9BqrB2Tp/BNTwHuN1uAoi4vLfl6fNxXiAkLSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:32:19 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:32:19 +0000
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
Subject: [PATCH v4 22/22] wifi: nxpwifi: modify MAINTAINERS file
Date: Mon, 21 Jul 2025 14:26:41 +0800
Message-Id: <20250721062641.2001796-23-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e36430f4-454e-4403-6c7b-08ddc82057ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/pWVaZKYMKRhzZSjfbTcWNTGANrYgDJbpVUYcbKJpmiAhZY7sg2/U63SmZsp?=
 =?us-ascii?Q?C6inKRhbMPRhdvifkSB5n//WR/nTN3G5YAFmThsTJ29YJ6H2oJo8hW7p4bk8?=
 =?us-ascii?Q?Jabyep5WZcE8vo/yuZOVZE1jbzh5OEqDzrPKQZZbXQIwjrMe1RSNArjMcsGK?=
 =?us-ascii?Q?SR+3buf8/qqYr+3JyOEt2dB+FbBdgEBAuaQQOyJEp8FeTu0fdu6LEjHUypjj?=
 =?us-ascii?Q?eB/S0Hm+HzuMCVWUd2tsmwz36QiKZR9M7xgXwOkaWnQyEyheA0IdraaR+qP0?=
 =?us-ascii?Q?m5e+U1ZPGwkIiiEk0lVLFLf64zHUNLLp6G0/LUxIxTUnpKYQbbL7fxbXuyqJ?=
 =?us-ascii?Q?bw56i9IoflRNiP7Lt9d/jhfhzNV/sMjda+d/OmaALQMLzsTKyJIOu6cbATSo?=
 =?us-ascii?Q?RgItKwyxwazpYvWZbZFB6IQiyNtdKfSdz+TtRBeX/LbC5abNHB/e845lXobE?=
 =?us-ascii?Q?OnAJFBcQAG3zEtUI+vMdx3zG+NRR+VeFpjTR0asTkk6eyugjFeFxZBFuO6VD?=
 =?us-ascii?Q?Z2b5JRvPSnHvJ5Dzg0rnA1F6bIEZ4IxDqxhpZfv2CEzPy4lRfvHQfqLINfB2?=
 =?us-ascii?Q?iwQyny5X2+1gK071YhvsGoBXstIdqrf9RkeLzGd/N4xY16wtQ8G2SHrbPJId?=
 =?us-ascii?Q?Zn2dYtK51OtzWcNVqSoXDmHLVKjQUdNml/OYja0ci2mMEQvV+Tcxfjgkxt+1?=
 =?us-ascii?Q?MmEt9h4qsjRUIdbDLOieFcCd2S01Lff0HA0pcoCF8FacTqWSzfZXltTSKbcW?=
 =?us-ascii?Q?lwMEZth8lDZn4OlNkJYwdm5qWAKWauol9L95pXEJZI30idue8dP7+QGhW1Xf?=
 =?us-ascii?Q?k5f9btK1ihC6lI97s9jfLGYyCvBX96wOVfjr0r+8+juTiWn6NkToy86/zsAo?=
 =?us-ascii?Q?UXOKCP3Emy1YJKo7fUz9IEpwKu7I16/DBHlx6WGtZY0jV2nF+pqphINETsug?=
 =?us-ascii?Q?nAp1WU87t1zxH4zB5MWlX9B/hcfMKuvxExd7XDck15gbEQaNaR1xw2YaYCTn?=
 =?us-ascii?Q?aS47w5vQH4n8rsezlsryRmdc/+utkztO/LMsB0tbCsdTlV9oDBIutcn1Th9W?=
 =?us-ascii?Q?CnX33kL4lauahet/B43saSh6lTrTSZfeOj7YgD8sYNJCiTIePqg5A1T9ONHy?=
 =?us-ascii?Q?joCW8PWDqueitg1M1NIVeDN/wo3u4rz6+U13DBtOYTTf7tCanscl+gs/rRQ7?=
 =?us-ascii?Q?pQV4dKPRFeuimfb/TzdS943QTZ51CzbazrRIy8y9/twMKcRb8AkTm4gDfeR+?=
 =?us-ascii?Q?PQhzROs434A/+Ed5uvGe723IkAOpZqDFWqvigtRWeN7N6ZE4IunHElATxH82?=
 =?us-ascii?Q?mMXS4jRQhaxmD/wg4LIpdQxwfXRKnXUDi3k/8aDSPd01z2h7j5P8RkHI2f8s?=
 =?us-ascii?Q?bMwFaLZnTs1EGmClDk6JbT5Y2d7tBU1iUm6Ad0zBUGpoI9lIfkk5qh8qNF1m?=
 =?us-ascii?Q?e0RZXBFyQ1YQtSds79YSNa7nxSGqqkzOL9ozELmCsWdolpqOcLRCJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U53XHkvsrt2KzoT6Bt75uZZ7sUXj5TQLgafENcxzGeS9ytzMuS9K3Pr8yxZN?=
 =?us-ascii?Q?eWSh1k3ChHF4UKMk5oN7/fIAopfZQCQST7jhndoMHRsgJSifvxupnCcNF7hI?=
 =?us-ascii?Q?qA+yX32JhkIKhHNbQiL8ZOos5l2FZM5iqPcNophxtnr1eun15B6Mo3k5O6fi?=
 =?us-ascii?Q?lumsd5ISEJ7MzykRy0ciXlHiul7fajrjG6oVNmCOG4+3VD6FUfovHiN6rK7e?=
 =?us-ascii?Q?RFRgjP+/+hv6UbOJQGAdMPl7UGNjUhM1KGm/eE9stb2Row1G3FzvnzoiHUfO?=
 =?us-ascii?Q?uaQZixQm9RBXZ555ioBXWZsDSb8lHrS/txgvVCvTurgAOOFm0xjMg4aBHA87?=
 =?us-ascii?Q?uwrlOp/ncShtJ/vmcwLrVX8LEWINdkq4JGr2/MxIFI6Aw4tusNFbPneXU2IE?=
 =?us-ascii?Q?zIIxXKQquWirNiwv3jlOX49ZRmc8+c+gqhP6JfFne9ifYm0g0ZjP44DhaUB8?=
 =?us-ascii?Q?uTfCyhKEz5pPI82cVlx108yWsGw29elyh0x4pvSDW+XaLP3psvIKUGym47Wx?=
 =?us-ascii?Q?ZJbOSa50IZA3sR7lEob0MfiQUYxvMLy+sOyQckPv6dbXAz9soj4vhbXcsZVF?=
 =?us-ascii?Q?Ovd74xdwx2IbkFGetWvnXBLFDqUpXNU6K9YeWehA/lOr2QbpsyfJY+nmXgok?=
 =?us-ascii?Q?2Owr3cABC1AqMt7OujX+PskrLn7bQUEQVnI1Ttt/3mwkhwzKNTLSg1FHt+rj?=
 =?us-ascii?Q?X0dP4/d04bDYwmGzLXXGuwHiME47fLMgQ6+dGxIYkVan1Z6vmv92AIjtsAsa?=
 =?us-ascii?Q?7c/D4LGL5+U3CShRkiJWmgPoAhBrz6ayp5AmvhriuMg1Fq1dzzEv1GpfX4Et?=
 =?us-ascii?Q?aDh1AgUC1xTo6BcCTGucRZwcSrr5+18DpraiF5b7DAZf8EnSw+SGKI7t/K95?=
 =?us-ascii?Q?xtk4xbD1ONvfGWMyiZrgJwESZYrAaPJtIClHZtTXyMeLpxLK3NG2m03T+Hy9?=
 =?us-ascii?Q?FhsCnb7ulX8GmQH7ZSQmPH4sn061S/rwooHgdzuguIirlXvNkpohld6AVF/r?=
 =?us-ascii?Q?/0htTxFOsbYNXw9o+d0kUtQPQIOcs5OEo6BI8ktI0ba9GPyCALio+MbkGUdB?=
 =?us-ascii?Q?9NlsmHSrEwn3SmwAtdRx78hBsk6I1kuMUvccQPKEKpv3QfnbPVrZCcMUtysa?=
 =?us-ascii?Q?DxIyMxGSLA0lSrw1j42XmKpeMTIfLv+MeSpV9k7jeSZ8gmWrIYLp676fQ3ux?=
 =?us-ascii?Q?eVl+LQsCyNYGsZXWK9+EPpAOTMOG0YtGNUb4s2skgWcVhAJSt/i2M6qP1/CF?=
 =?us-ascii?Q?6FNVwQ1CyYaulbD4zsDpBqNT37P6y9ck4j38un/obrJcFy0GeF+d0oT5UbjB?=
 =?us-ascii?Q?lYeFpkChSIxWFUj9SBSW8yvqPBvg3Y9zHOkfB1BAbO5t/ucZTNtBMmAnw1jn?=
 =?us-ascii?Q?XOjxkBOt2Yk8HaUx+Ty8DT27yhKeAHKMIJpWpTYp8mVWG+39L5qbXBTcn5r1?=
 =?us-ascii?Q?fwy0X6NkvwzKb3rGtNZT/m4RdEG+hfGOHdbnh+Qov8zdpiErsNn/IHoEhj7+?=
 =?us-ascii?Q?5AP/Pd0JqE9Tfx0bY6bWk8YFAn+Udjd5lIX6o/zxIZguE1nUo+/hdIgyPFx2?=
 =?us-ascii?Q?0gcbyYq50dpXH9OeOt7eULguibthCtnrt8YwIudW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36430f4-454e-4403-6c7b-08ddc82057ad
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:32:19.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q83MupiOudOScVRXqCJQ9zR2RvNFR1eqF8gqD+fE8+xLmVIh5LAn3ZJ8ChP1uZWzb9UyfGMXNPwhfMfjmjaCxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780

Add nxpwifi related information to MAINTAINERS file.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3887d5906786..2d48de6aa7dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18017,6 +18017,15 @@ F:	Documentation/devicetree/bindings/clock/imx*
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


