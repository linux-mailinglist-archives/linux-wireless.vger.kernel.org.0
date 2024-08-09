Return-Path: <linux-wireless+bounces-11219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159194CDE9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 12:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EC21C2259A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC01A00F1;
	Fri,  9 Aug 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="db7weDwy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C419FA90;
	Fri,  9 Aug 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196897; cv=fail; b=j4lGunpK7923yg/JC63Wqjmze1nA8L1AY4NwkUiV8Q5QFTMsf/agf8FPuzzEQN87HwfJUSk7xJHFg93kmHb0cnNSfCjW2tKRHV9t37oQNHFdZFbQS0zfApE+wc0NWZACouvejvBJeSGl5jsXaxv4I7kVVMmyWJzAPUdnjd4khPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196897; c=relaxed/simple;
	bh=p5QNdxKjCzze8oseGgqjKq6i5bte1ayavw215JXhUlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjinRpd3W+bW/aQWmdWWzjAokau3KQkbh33BPeOPuLseHwFBp36UshVCggaI+P6EPolRKn65Gr3MoQ3J8oWKoHahjFeSt1nPfEVZaOCliw+L3XcSOCKeyYGX69GDzA4xv7Eoau30uKQh9NdWxOPfI5it1K/sNFnir5Nu/pK3sPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=db7weDwy; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY6tAVFcBPpw/Wtv81+FN9QtGHY7ptbH2RTt6D+qfjDqxfeRFEUKECtY/heh0rF8yz5lxKFlt/Xp3RHkuwXHnfMMCWWPwOKoF3tXmAPxWNdcO+9yLYRwqgfGRWh2ubZD7Id+9fySSfiIhgtWcZFcZ4BqGanYZKdckPqjfAj/0kLmV4TzT6DF9Hcn8W0JtOo16nW2Zoi03yc9cvnP/w4oACiqg/78vSMvunfb/IIjTYNlGIAnKbFScztBql+O+qYzdUPOwEMy6F7cvF7Q4ov1UFzVppaaYvfrDJclmiDmBVIxedzwhf46SeVh43yrRFv8FuOfhhCJM9byRApqYNl4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34canxyc8wauY9Vz4GDFQmmBBJyG2eNXVG74r/71FfU=;
 b=f7m99EhoWK28S3RydKTbe2fE/sZCbp4XE3Aq4iPcaxeNFfJtgkX7veWjQi9CIwEyO0OePo+JY1tuoT8KDAGQYbGMEpkq6eDx9ViU1wE0wAQFvUyWhPijr3b5JaCAwlwEaIbpyYJeudoAa4ylK9KuzmkIQh8+2enKmqVf08bqeamHMPrRa5lyWpe78j+WF/tvd+/uBMzjEtBVwDLXELNPZRbAhc8nYV+VOq2gLWclIBUg9rXG6JfHCc5rXZ1pfCfCKaCBAULtxCFIvI/Aq9JtSvj1be5xCA1b3J5HZy5wXPF8lp+nhtWVZehkb15R0i+35jB6/NBjKgBcGw+l4fPDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34canxyc8wauY9Vz4GDFQmmBBJyG2eNXVG74r/71FfU=;
 b=db7weDwyxP3gljdsy5xflg6fia2to709rGWG9BGV5Rsc8rc2i8RCTCc/yG310Oujn2gedHPCIsj8gBSi69OwFemutanyoXlOeRft2VW225d7K0o6k27RD7ZbRm7RfbaBvN/rVU/SOsxjGJaXuPhRpwVzxq+fEhWYfwBgpxXuX16aWUeSKdEgPxTqEY21p2BIud27vmUErgY9HBv1q58YXXbvjlIEBiXPBojbfCwdJzYZ4SO1uSKbtmVmTIsEKLi87OOetPpI3MD5xT3jPf6wUBlureTS0TqS27+ICVghVjGCiq1DPnslrhOfPtIEjHsvBAnlAsDP+9cFyZ4VpnfsNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:48:09 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:48:09 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 42/43] wifi: nxpwifi: add Makefile and Kconfig files for nxpwifi compilation
Date: Fri,  9 Aug 2024 17:45:32 +0800
Message-Id: <20240809094533.1660-43-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809094533.1660-1-yu-hao.lin@nxp.com>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5587c8-360e-4751-f469-08dcb8586047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VgzfmkZE9nIx/bO19yEzvTbBIu5Z8Y1m/1HdEFnswl3YNvLaOz8vaL9LHFXl?=
 =?us-ascii?Q?eyyi7fmzaZYp0p0jRmZdDLfRVYQviToXgjQpFcHGdwPq1Xs6F2hL2+ygw7rE?=
 =?us-ascii?Q?LTu2p135BgmiuoAw3nHfAO1+mVgPUr9cmp+oCcsKpSvpv3Ov4o9U5KA19oZb?=
 =?us-ascii?Q?EYOCYgN2N9cVQeyhQGEvnqcEUyKEk2+FNclNH1SgaqG8y0e1MqcNyxG8pYPZ?=
 =?us-ascii?Q?Lo3Ifqn3YzTDKYTXJ9ECvmVDpvbdLbXikX/n5mN3qsb9PtcpwcmOZsBIsxzP?=
 =?us-ascii?Q?yEUBtNVyK7lwGB9SkU/lsGf5CkXvn/zCziXfu72ocFLtUB2mgTkEXX4kN9ap?=
 =?us-ascii?Q?xf3d+lxzHSyfHTf3jZEHRQOUpajsm43FqtBPsGnw/pCRz4KEZLLGetk98Tf4?=
 =?us-ascii?Q?TRsE49FOJL80mXrMFJYJjkOMcDbEdrbWlZeWA5yllUS6stUH9v20baEff7WL?=
 =?us-ascii?Q?ursAelzsv+j4j3W0V1cNUEbAxLIhPCzQmx2VSKOI9Ca0EzZx63noXFxG+bIZ?=
 =?us-ascii?Q?E1bp3LCVEwe3I/34gEoAHnNgmA+wkptLyFAaPV09IAZxXVi31hAlebUKKwOp?=
 =?us-ascii?Q?7IFJH2JFv1S92hPu+oBrYGse7tT5e8yx/r5TjyTlYbr019QvPDOvjx4OJ2qp?=
 =?us-ascii?Q?DU25x3hhwCIC2v1Dp25kLetZ56CepT5ouvGZKipIYPwqpcYGNe3S4aDtYJ3h?=
 =?us-ascii?Q?0K6o0xhYFLvXqNmXMdCUF2hr/kyD0vZdc8lO7rUBLHLMdEC1dTq3ue+/ORN+?=
 =?us-ascii?Q?CNWCCmXThfRg5ZSAO5qnjiFcYFrqeI1zDxDN41LeCV9EOGJa3p9kILZs3SxF?=
 =?us-ascii?Q?btEBNPabVdN7dLe/P4Y2fnt1tfthB/lQRAt5WnqOq7bFYFomlBtUkqMpgkvm?=
 =?us-ascii?Q?s1Dy+xVPC+Hngysvq3M3sTsMGe0bUvoN7cnZc9y7lm1XOVZWDRJLGUaYEJzP?=
 =?us-ascii?Q?YmJYqfdodLGhkn0s6C0zDkKtOJc2olGNEtUlvj/9oWnKRD1UNxOc9whUj0R6?=
 =?us-ascii?Q?ywLfSPnuIFkZ+5eOWbpEsE4NO6b7Q7p/uMj1qKyKSaTUSjNnx4hvkPd5n13G?=
 =?us-ascii?Q?4zSPGP+FJ2RFNdCAc9jT2ZDo0JU959ZSJSXipuVVliaTtAp+2AV15qRMv4Ns?=
 =?us-ascii?Q?pKthLNNT1JhjxLXquVROvfRkTLR86zhTLoWMEp08Cyng5XMkNQV8cV8hNGO2?=
 =?us-ascii?Q?JMkZFJ3sW9ewZYSt1DLmZC90QikFfX7gxBND4f2Ymy2K7gpS2nnYskCVJ4Fz?=
 =?us-ascii?Q?VoWk66DYGTlaqTpMzl3xvTj+RLJZ1idhS0N3juSrV8zcpdlhrj93jDUc16sV?=
 =?us-ascii?Q?n4iwu32UJl7iKQzqpwP95DjShS9fZ27PqWtFqFW5RUEoNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?20E4Du2ohOspi8bfeGpp63L2N8TjmIgnhDoVhKZfiSN/f7KyRIgTHZNM2KCI?=
 =?us-ascii?Q?By/bjtrxIr+LOYej+KXKJWmPxMo4QHk3B/B+wQl2OxZzPEOIMavOxJu7e43b?=
 =?us-ascii?Q?S1/wtqF/qMh3tCo9/NDE26ocbIbDtjxXAKm4pXmr2aF4S+3ERLxqLbHGfMQA?=
 =?us-ascii?Q?rm15qe9IzXqxskXiUd4ROSLnFziMB6GnCPPN1VMmAvVdF2hKvQQbhLGio/88?=
 =?us-ascii?Q?o3ad8NiVPRUj8PDp5h5VKdvQXKFB06ilDm9JHaMmlxbBcArKTgQlBYwwwJ+c?=
 =?us-ascii?Q?BP7SEgJxqj1OBcNhT3Nb5opa6+HdGfDc1LtARyfuDrbjnP4PrmrIyfa6Qw4E?=
 =?us-ascii?Q?QcQ8uhw51Xbb5+h4PgXPz0jTs/KQNP1U2Yg1/SuxeFZ53JtJ39hm/5SgQ5lB?=
 =?us-ascii?Q?1zGuQAUrq2gSG0ouKkp7ZvcH97FOIfx5mFhDF+nc4KSixF8Mzj+ZQCBHrOBg?=
 =?us-ascii?Q?txiFNbF6w47q7leCsOEw1HG6pvLH4int4W3yvsEMoBh0alvrxemi4FkqM48O?=
 =?us-ascii?Q?cmYgFQ9mOSppzx8kNXCiUlBQoJcvywWeug4St7h+0DQJoQrVVQcb3R/Lv5ls?=
 =?us-ascii?Q?lq6SMdJEyzCpFN1O+V1TKacZQYnCR+yMgonMeMgnpPxXXZIfSXIYWzmFKqBD?=
 =?us-ascii?Q?hRJZg/RZ8mUQgw2fxM8wHPyNshIhp2NDqN6S8SiieQz9FnSAneEMWlou4hE4?=
 =?us-ascii?Q?bUR4JUfLwtmR1gSRrurIxVfju2BXiXyzPSio7xuyFYSJsXdKzMxYhagIIqGj?=
 =?us-ascii?Q?T8XhC8S9fB/6glQFZotDrGoWJMNM8VQKvUZ5E1bqFg6zenfYQ1MUXZroQEM2?=
 =?us-ascii?Q?jQiBFQKv6sN+HJDdGM1EILMTpChOMTS4VMCTGxFIh3SRb7st5cy6gUPjvYN3?=
 =?us-ascii?Q?gwK7obgWDSxla+3D/DR51/+ROI616sde5g95zrp2jzUdaXNYsjEOGGVy+wu8?=
 =?us-ascii?Q?9yZtetAnlWxj87L+hxIf3qWEJePCjtacwegcJKYglnGxsVLWLohn61o1+9T6?=
 =?us-ascii?Q?eWIwxd4vfrx3A9x3LzBwWnaIk1U7lA5hudhsFBK4eS+OqNgNFX5RzDlf6Uh7?=
 =?us-ascii?Q?0BSBh5Z9Okmf/1tOnW/bYO0fF4UcwEU0XVHLslIK7ZaeGcXzp8zw9qGXLCc3?=
 =?us-ascii?Q?9Hdwt7GhsT60rOOayfwRkZ+C7ZbAL+vOKcTlMb/z8/q0G7B9QqizeWTbL5+R?=
 =?us-ascii?Q?uUOtiSmd+1l3KAtbCJdIkaSAl5rG8GfuM1MFLj3ZhfOx86j8rkTb/A1EBEH3?=
 =?us-ascii?Q?xZmQ1Pj0Eu267/WQz8tjg4nugH3oXrJWcQZo7pbBCeQwA/SuHRkJl1pgOsXt?=
 =?us-ascii?Q?h17RwAm11UolsrXXoEveaCHnFjgVGQ3XrbbvGEBpETvV+viv427q9VEn/D4U?=
 =?us-ascii?Q?R690zmR6K26GEJsXrKpxSErLVncraW0eX5RknDlXwfGJWf5oT0Q3LhUyIrDl?=
 =?us-ascii?Q?Xzpi4EPk5oNmSHqqqcrP+xMrgWXtmyA8MSwtWm9MaHQxiHUUQKhmz6H3pQqy?=
 =?us-ascii?Q?oKkfg36fpxbONU4XEwojtjcIbApJ97lQKN7puEA2Xn4bsl6Qig0dj4BEvKRC?=
 =?us-ascii?Q?x5vgi7XefckgOM0So60//E9Xg659OvX8b+4zp4mzJjWKvAgtkTkDo8r+mD2A?=
 =?us-ascii?Q?DYrPXwKXaddGBkSCMFm/35o2jCXaLLitLK4juyHlERZ1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5587c8-360e-4751-f469-08dcb8586047
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:48:09.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDClxZqxq5zyCs0XjwhpfX8q1DtDbYaf4bc8ON4dIe0aev8q6REXXcNBAlQziX9g6hRXAp0jp8wQ7Qbbjjwehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 38 +++++++++++++++++++++++
 6 files changed, 82 insertions(+)
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
index 000000000000..6456d11a5ca2
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,38 @@
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


