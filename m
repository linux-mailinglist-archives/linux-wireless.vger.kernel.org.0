Return-Path: <linux-wireless+bounces-37424-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dy/rGmP3ImpxfwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37424-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:20:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C15E649B4D
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:20:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=fruAmrwd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37424-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37424-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FE5B3076F23
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191AA406285;
	Fri,  5 Jun 2026 16:13:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BC3F39E3;
	Fri,  5 Jun 2026 16:13:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676038; cv=fail; b=ideKm6nEodKhh8xgdXtQJnEsYXs2swRCzobVtIT4jSKwRaQZpXlLXBiexjw4iswUrG1+f0IxTN1KpAy1DKOJA120X+bwZ1QFf218IuaTqBBYpXeR//iTdvFXd/f9Qzc99HbJao7f9x/cJLBPrn8qNP/0K9dzYcPY1g0T5gmloHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676038; c=relaxed/simple;
	bh=60MqhPRuzB9CiHYYSDg4ssMiD1wT19GxCWy1XKa/NjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIyQOeXSH2NygPcY0gK8aOTkveb8WYhn60UWHXhyzcbIB/6nJd0hwy9sv9I8KABI9BcnPT7j3qfzWZc3B6MSFZzVsYM3tpq/h56cA9wVd3LFHEG6Xnd2kZq2kSkoDuykaYzoxLn8Yf4OaSSp4D9eYPled3ostnmTmmR9auDEhho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fruAmrwd; arc=fail smtp.client-ip=52.101.66.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtjX2tZrbXjR4aibhyRvj1CyUmW4wmeUei3WLgKrsBtl3yXcgpMQ/N2YrMGz33KF+V5csIZywzR6RggjcfeTOg6hEqUu9cb2boJ47I3/MTG9FCDWRwhPjkrVSLL2AdxSblbRp1pwRlgfrJhsszXpY/SAbs5LdldtxMYNaO13bpyJD269u7f+xpqeAlLaxfCYrFNuv8wdrEQJSPv2HtH4EaMp1vqvoLTK66l1AQlew5cbXip2OdyJ45O63jZ2AgAJub5XkWNSzjp2duUmeO9pWLR+hsDwkKX9DVCsEbK/VjaepjVnp/ncDOd5k6AhfRE5pZC2wW07V09Q7FiJKHmbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfxj13TPePDgcxIWEXBSHhxACDRRIan6tPWyoe7S1KY=;
 b=FcX6/rrhrFz9Gynh9lH3tWqtbIk8A/DlrcKyDdrYtchTlDkuHw7pR62rl6IFuFCYDCNjWPvM7BOQkk2tED68cV1URpOawF5w/JyzpQqvw0lUUpsyGaAN/FWdm+WNE93GJBOrKPWtBFI1onetOgSm1k3y8SBaNEFBUBx6/iEJ16Tu7W+oZPsUkMrvTn8efekv4koCaqMg48t+qVqKzk6RjRfPNxCJfZHZa4JjqOfmoiVM+V5sSjRqsFEZaHWoyAx00vOJ9uuAXbQyk8NApT/fbSVZet51qsuDohxEKICsmaYnV++GixTiVvvtqLk5V07ZzTG3I/lQRYPmMqZzKuuPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfxj13TPePDgcxIWEXBSHhxACDRRIan6tPWyoe7S1KY=;
 b=fruAmrwdihl2b7Zc9cX+2/t28VMypmyz/eei/q+2LAmAoXcXZy12atsfChWJmzvHLJJ5kpYi6U5zP8rFhhnESSQR8vllxRSXLktxVKck6THtVgrBE/PLXbyFcMcG2LCdZNMQqkRbSXiPqs2MCFUquqeHYgZUs7E3MQC6HIWHXO1/eca4zynAwRClk91DqYhyp3FZKgEcsZRQFAGWgKvm6Y7cku+LNIf+N0y3RLvxnMxv1QSQb91VhlFeifbgvHPv8WdFYjns4PoCbHpUUtTaxyHVHKF4aXuksT5Q6ypHUtDcCcIyKWpERHP8IMn/JPFbmc0SVDf0e9HRmSQj86zEHQ==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:13:52 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:13:52 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	ulf.hansson@linaro.org,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v12 03/22] wifi: nxpwifi: add initial 802.11ax support for STA and AP modes
Date: Sat,  6 Jun 2026 00:13:16 +0800
Message-Id: <20260605161335.2415583-4-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 2533ccb4-e42e-41f0-cea3-08dec31d6f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003|3023799007|38350700014;
X-Microsoft-Antispam-Message-Info:
	ntsofLNE2NjY6uhIy8ccNrhnLu4WyT7WSlTWBySS2yXYZwirxKB8ZdNknW+nqUnLFneLTJdeJcdmrf+IDqifHPJxEksZB2/FJNwAQUiXDkxR+Iu/iklJAVhw5NUYkcAaohBtx5L2mevn3O82VFXcgLEWAuZZDoPI6KTBZScMIhT8CFbdBtEWg44W8bYhNx2qObFmsJShFJpGhpCXXNg8PZLZbcOZPVTnYOXPN+l+b3nufnCPhtQIXGjrrRF54JUIp4JnEnFzjlJINgsQCu6gL8wzTIakOWpX8/shTo2YASGyxzFoIREK97tkFkDTHc5bBKNeTyHy05KKGTd/WC+ThH7WoqAZBxZEUb9w6nVezdfVdB6fKMzMcYdgqIAnF579+FrU6MWx1IGdMgx9q/L9RjchEdZMgEhFu6kbl7oPtUbkUiat7xtjogMHyjUJDVNy34aHuBZTPdSsJTiGwD57jIcb961KNzsrkDLKNo257FtoMeOuWYH5gP0berOv77bxxUPw2NmaplnX23YrkZiquP8sS9TwQwAXIOctUW3XLLYLR2nP+1XGUs2De9VIqv2NUJ6whfwlV3eJk/7Y7XglDLMU4MKyI5yg7BSJnF7uKod9pTv3JdpnP5+hze6mAeiTZx1KZMh12bWqOeEi4eETm2+50r1YSJ2pqh+eE+cuK+GqVwKrkOQ+IjiLZlz9tMVXCox8PsTOdD5MWyN6XSChIj/OFf/uNSqyYbtX9ibH6NG9+LKTb4BdV03S3RzsCx1C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/VxRTFV2yO+xBss/Oz4Fq2QTgBBNmPpiIkd6JNIxTU3OX/qrxgFYj9LADzue?=
 =?us-ascii?Q?wMpBNIoESzEY1pf4ASWrx+VCRNYHG1MXgZtF524wHhjv2UjzPND9UkJ9HzsQ?=
 =?us-ascii?Q?/pkIkpf90hQVVvzW7OZ62xEvwr/i0vGV5H4Ug9BarWFeDUGyDfApaUViZZIM?=
 =?us-ascii?Q?htIXJVPNqGj5hTCXQfresw2o4HvAeVy1QzXYuk9giL2m4Dp6eBTiu7zNx3l1?=
 =?us-ascii?Q?U0tNQwrswywJSjDXELR5IOHJjOKuSq6fnmLtDtntWCdWPObGjKjLZqYP12vG?=
 =?us-ascii?Q?Atl52Wz/aamugEx2oW+qSEkFQM7q2oTWTjMRWt72++mnbSKHQb/8ldv17V4l?=
 =?us-ascii?Q?susaL2GSRBmRtvgXRtYvGZMkKcWYuThZ20CVh0/1KcLjvhcky9NDhMshHKsz?=
 =?us-ascii?Q?UAPlzSmtuY54f/bgJDCfiB8RkHuBQgeBTLhZg6gL5gnmgUXt4quUf1sgF5Yd?=
 =?us-ascii?Q?EtU2DPiLnmtoLCXBjyqY6ayFSrtQSUqMraPn3dEJkKONHYJY30Ml+wPugY7E?=
 =?us-ascii?Q?EbdSue1T2DNjOUbJkvy/iAqiEsSzt87bevx5iTW/jnWjE5jATbH4riqEcwfC?=
 =?us-ascii?Q?vbzLmOWICSJeU7r4XlIFx2M76LIgckLRzCYFuxYDDiYsR6fiEXbZb2r5ZFKu?=
 =?us-ascii?Q?+tsqnVqAa4iE01tBuXIdqSanFPZ7aUMfrspYFzZkJzinzZIdIAhuzmZM0z0i?=
 =?us-ascii?Q?u7WmnoFeXJrsb2xOCamgq+8G0H9ErQ6A0OD17z3F0ax3Ga4L2z0O2QYrk3At?=
 =?us-ascii?Q?WEY3mJx1GoqIEW0q607tLSVTwcSMISUZZRnGBJQVH63Y47W2CM5ByZ4UbaBZ?=
 =?us-ascii?Q?vMhg2qLEctapgvpSnDM5Sf72W4WwEBVst134mhe1GuxjiUxZmvdry6otkwFr?=
 =?us-ascii?Q?kx6AKt1qA6c5B/NDqha7ndhR6LCWXUL9zTnIkECkWF9v62JSDMoW/kRIWa5f?=
 =?us-ascii?Q?ystER7dPFZJN4k171O8HccI6v5RGYcNr4PqTLNb4SYx9ICKoN4OW4QTV0yBr?=
 =?us-ascii?Q?86hRXtoojLwSvR66Y4F32ykXXprXgbB5TiwF5/S3i1+s8vqBV5ZLscfBY1+u?=
 =?us-ascii?Q?OlwyUvYaEbTKeskW68/oRn9XiZD1I0v4/aRUoXEpnUINnvTrhSJi8luCJ+Ia?=
 =?us-ascii?Q?YJzFKn03opBUOzVE4fFU/h90vwEJdL29dFpqqTFkesgiJCKOqqOdbqwLun19?=
 =?us-ascii?Q?BIZNcaMcYsTA7CSpDE3CYHY5W3XrawSYOZQ2Mu0RAwO1ti53pkBxvlc8DBgW?=
 =?us-ascii?Q?hv6YB33wL/YgzQE1Q3RbqT8qezGDfQPljfDBo8Q4c9HsYTKfya8cjxONhALk?=
 =?us-ascii?Q?eqh3B5JW6wWA9vpZiHkQJGmgEppXNOaWvKXoQdIhAlDkYKr2cvRF8XbsAyv5?=
 =?us-ascii?Q?pMWIXnlnRVTMoeJdVGbCLVUlUyNQff7CJl1P0uzOaeNp3IhEQVVhDOv+hnD4?=
 =?us-ascii?Q?n/gS+5ZkOGAXOFOlSGJqoKf/3+WOgg0ShVKh3cLkZFjekFqTv+Oss2jHGx0Q?=
 =?us-ascii?Q?DX82Ypv6TZkiMrR82prXJcHkC8esRGXsv6KTCM2QtDBtXUMXkn4/YHBL6lsd?=
 =?us-ascii?Q?/lAUem2XjvnN1pVv4WuXCq9yaoqYfIYXWO5DYB0MpxqqitVJ87i5ciMjIPBp?=
 =?us-ascii?Q?ZIILUEngV/4EWk/09YmwF/QlJIuoHhmAKcQDjT6E/aBZ8xtq56qE3j2YWP/+?=
 =?us-ascii?Q?3boLUQhZaKMpV8oK0zcH51Bll0RkMRxfsOlyjeiiKX7/Id+jE5pijUCusP0w?=
 =?us-ascii?Q?B2QZy6/FBg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2533ccb4-e42e-41f0-cea3-08dec31d6f64
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:13:52.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEQYhP7q1lrS389ZlwiOuEiN0aktebweBiyseNnoKoV1emlX6bzEByZbFEjvqreAEHzAh/ug5Rc2tfRQOVz2Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37424-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:johannes@sipsolutions.net,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,m:jeff.chen_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C15E649B4D

Add initial 802.11ax support for both station and AP roles, enabling HE
capability negotiation and configuration through firmware assisted
commands.

Convert HE elements from cfg80211 into firmware TLVs and append them to
HOST_CMD_802_11_ASSOCIATE when operating as a station. For AP mode,
convert HE elements into parameters for HOST_CMD_11AX_CFG and provide
them to the firmware for configuration.

Handle HE MAC/PHY capabilities, MCS maps, and Target Wake Time (TWT)
negotiation. Add support for additional 11ax-specific firmware commands,
including OBSS PD, beamforming, TXOMI, and broadcast TWT.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 594 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h |  73 +++
 2 files changed, 667 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
new file mode 100644
index 000000000000..cc47c435eb70
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* nxpwifi: 802.11ax (HE) support
+ * Copyright (C) 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ax.h"
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *user_he_cap = NULL;
+	u8 header_len = sizeof(struct nxpwifi_ie_types_header);
+	u16 data_len = le16_to_cpu(hw_he_cap->header.len);
+	bool he_cap_2g = false;
+	int i;
+
+	if ((data_len + header_len) > sizeof(adapter->hw_he_cap)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "hw_he_cap too big, len=%d\n",
+			    data_len);
+		return;
+	}
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)hw_he_cap;
+
+	if (he_cap->he_phy_cap[0] &
+	    (AX_2G_40MHZ_SUPPORT | AX_2G_20MHZ_SUPPORT)) {
+		adapter->hw_2g_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_2g_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_2g_he_cap_len);
+		adapter->fw_bands |= BAND_GAX;
+		he_cap_2g = true;
+		nxpwifi_dbg_dump(adapter, CMD_D, "2.4G HE capability element ",
+				 adapter->hw_2g_he_cap,
+				 adapter->hw_2g_he_cap_len);
+	} else {
+		adapter->hw_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_he_cap_len);
+		adapter->fw_bands |= BAND_AAX;
+		nxpwifi_dbg_dump(adapter, CMD_D, "5G HE capability element ",
+				 adapter->hw_he_cap,
+				 adapter->hw_he_cap_len);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		if (he_cap_2g) {
+			priv->user_2g_he_cap_len = adapter->hw_2g_he_cap_len;
+			memcpy(priv->user_2g_he_cap, adapter->hw_2g_he_cap,
+			       sizeof(adapter->hw_2g_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_2g_he_cap;
+		} else {
+			priv->user_he_cap_len = adapter->hw_he_cap_len;
+			memcpy(priv->user_he_cap, adapter->hw_he_cap,
+			       sizeof(adapter->hw_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_he_cap;
+		}
+
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+			user_he_cap->he_mac_cap[0] &=
+				~HE_MAC_CAP_TWT_RESP_SUPPORT;
+		else
+			user_he_cap->he_mac_cap[0] &=
+				~HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	adapter->is_hw_11ax_capable = true;
+}
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc)
+{
+	u16 bss_band = bss_desc->bss_band;
+
+	if (bss_desc->disable_11n)
+		return false;
+
+	if (bss_band & BAND_G)
+		return (priv->config_bands & BAND_GAX);
+	else if (bss_band & BAND_A)
+		return (priv->config_bands & BAND_AAX);
+
+	return false;
+}
+
+int nxpwifi_fill_he_cap_tlv(struct nxpwifi_private *priv,
+			    struct nxpwifi_ie_types_he_cap *he_cap,
+			    u16 bands)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap = NULL;
+	u16 rx_nss, tx_nss;
+	u8 nss;
+	u16 cfg_value;
+	u16 hw_value;
+	int ret_len;
+
+	if (bands & BAND_A) {
+		memcpy(he_cap, priv->user_he_cap, priv->user_he_cap_len);
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)adapter->hw_he_cap;
+		ret_len = priv->user_he_cap_len;
+	} else {
+		memcpy(he_cap, priv->user_2g_he_cap, priv->user_2g_he_cap_len);
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)adapter->hw_2g_he_cap;
+		ret_len = priv->user_2g_he_cap_len;
+	}
+
+	if (bands & BAND_A) {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream >> 8);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream >> 8) & 0x0f;
+	} else {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream) & 0x0f;
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->rx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->rx_mcs_80, nss);
+		if (rx_nss != 0 && nss > rx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT || cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->tx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->tx_mcs_80, nss);
+		if (tx_nss != 0 && nss > tx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT || cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	int ret_len;
+
+	if (!bss_desc->bcn_he_cap)
+		return -EOPNOTSUPP;
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)*buffer;
+	ret_len = nxpwifi_fill_he_cap_tlv(priv, he_cap, bss_desc->bss_band);
+	*buffer += ret_len;
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &cmd->params.ax_cfg;
+	u16 cmd_size;
+	struct nxpwifi_ie_types_header *header;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CFG);
+	cmd_size = sizeof(struct host_cmd_11ax_cfg) + S_DS_GEN;
+
+	he_cfg->action = cpu_to_le16(cmd_action);
+	he_cfg->band_config = ax_cfg->band;
+
+	if (ax_cfg->he_cap_cfg.len &&
+	    ax_cfg->he_cap_cfg.ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+		header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+		header->type = cpu_to_le16(ax_cfg->he_cap_cfg.id);
+		header->len = cpu_to_le16(ax_cfg->he_cap_cfg.len);
+		memcpy(he_cfg->tlv + sizeof(*header),
+		       &ax_cfg->he_cap_cfg.ext_id,
+		       ax_cfg->he_cap_cfg.len);
+		cmd_size += (sizeof(*header) + ax_cfg->he_cap_cfg.len);
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &resp->params.ax_cfg;
+	struct nxpwifi_ie_types_header *header;
+	u16 left_len, tlv_type, tlv_len;
+	u8 ext_id;
+	struct nxpwifi_11ax_he_cap_cfg *he_cap = &ax_cfg->he_cap_cfg;
+
+	left_len = le16_to_cpu(resp->size) - sizeof(*he_cfg) - S_DS_GEN;
+	header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+
+	while (left_len > sizeof(*header)) {
+		tlv_type = le16_to_cpu(header->type);
+		tlv_len = le16_to_cpu(header->len);
+
+		if (tlv_type == TLV_TYPE_EXTENSION_ID) {
+			ext_id = *((u8 *)header + sizeof(*header) + 1);
+			if (ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+				he_cap->id = tlv_type;
+				he_cap->len = tlv_len;
+				memcpy((u8 *)&he_cap->ext_id,
+				       (u8 *)header + sizeof(*header) + 1,
+				       tlv_len);
+				if (he_cfg->band_config & BIT(1)) {
+					memcpy(priv->user_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_he_cap_len =
+						sizeof(*header) + tlv_len;
+				} else {
+					memcpy(priv->user_2g_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_2g_he_cap_len =
+						sizeof(*header) + tlv_len;
+				}
+			}
+		}
+
+		left_len -= (sizeof(*header) + tlv_len);
+		header = (struct nxpwifi_ie_types_header *)((u8 *)header +
+							    sizeof(*header) +
+							    tlv_len);
+	}
+
+	return 0;
+}
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &cmd->params.ax_cmd;
+	u16 cmd_size;
+	struct nxpwifi_11ax_sr_cmd *sr_cmd;
+	struct nxpwifi_ie_types_data *tlv;
+	struct nxpwifi_11ax_beam_cmd *beam_cmd;
+	struct nxpwifi_11ax_htc_cmd *htc_cmd;
+	struct nxpwifi_11ax_txomi_cmd *txmoi_cmd;
+	struct nxpwifi_11ax_toltime_cmd *toltime_cmd;
+	struct nxpwifi_11ax_txop_cmd *txop_cmd;
+	struct nxpwifi_11ax_set_bsrp_cmd *set_bsrp_cmd;
+	struct nxpwifi_11ax_llde_cmd *llde_cmd;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CMD);
+	cmd_size = sizeof(struct host_cmd_11ax_cmd) + S_DS_GEN;
+
+	he_cmd->action = cpu_to_le16(cmd_action);
+	he_cmd->sub_id = cpu_to_le16(ax_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		sr_cmd = (struct nxpwifi_11ax_sr_cmd *)&ax_cmd->param;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		tlv->header.type = cpu_to_le16(sr_cmd->type);
+		tlv->header.len = cpu_to_le16(sr_cmd->len);
+		memcpy(tlv->data, sr_cmd->param.obss_pd_offset.offset,
+		       sr_cmd->len);
+		cmd_size += (sizeof(tlv->header) + sr_cmd->len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		beam_cmd = (struct nxpwifi_11ax_beam_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = beam_cmd->value;
+		cmd_size += sizeof(*beam_cmd);
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		htc_cmd = (struct nxpwifi_11ax_htc_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = htc_cmd->value;
+		cmd_size += sizeof(*htc_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		txmoi_cmd =	(struct nxpwifi_11ax_txomi_cmd *)&ax_cmd->param;
+
+		memcpy((void *)he_cmd->val, txmoi_cmd, sizeof(*txmoi_cmd));
+		cmd_size += sizeof(*txmoi_cmd);
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		toltime_cmd = (struct nxpwifi_11ax_toltime_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &toltime_cmd->tol_time,
+		       sizeof(toltime_cmd->tol_time));
+		cmd_size += sizeof(*toltime_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		txop_cmd = (struct nxpwifi_11ax_txop_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txop_cmd->rts_thres,
+		       sizeof(txop_cmd->rts_thres));
+		cmd_size += sizeof(*txop_cmd);
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		set_bsrp_cmd = (struct nxpwifi_11ax_set_bsrp_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = set_bsrp_cmd->value;
+		cmd_size += sizeof(*set_bsrp_cmd);
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		llde_cmd = (struct nxpwifi_11ax_llde_cmd *)&ax_cmd->param;
+
+		memcpy((void *)he_cmd->val, llde_cmd, sizeof(*llde_cmd));
+		cmd_size += sizeof(*llde_cmd);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &resp->params.ax_cmd;
+	struct nxpwifi_ie_types_data *tlv;
+
+	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		memcpy(ax_cmd->param.sr_cfg.param.obss_pd_offset.offset,
+		       tlv->data,
+		       ax_cmd->param.sr_cfg.len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		ax_cmd->param.beam_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		ax_cmd->param.htc_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		memcpy(&ax_cmd->param.txomi_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.txomi_cfg));
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		memcpy(&ax_cmd->param.toltime_cfg.tol_time,
+		       he_cmd->val, sizeof(ax_cmd->param.toltime_cfg));
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		memcpy(&ax_cmd->param.txop_cfg.rts_thres,
+		       he_cmd->val, sizeof(ax_cmd->param.txop_cfg));
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		ax_cmd->param.setbsrp_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		memcpy(&ax_cmd->param.llde_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.llde_cfg));
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u8 nxpwifi_is_ap_11ax_twt_supported(struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct element *ext_cap;
+
+	if (!bss_desc->bcn_he_cap)
+		return false;
+	if (!(bss_desc->bcn_he_cap->mac_cap_info[0] & HE_MAC_CAP_TWT_RESP_SUPPORT))
+		return false;
+	if (!bss_desc->bcn_ext_cap)
+		return false;
+	ext_cap = (struct element *)bss_desc->bcn_ext_cap;
+
+	if (!(ext_cap->data[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
+		return false;
+	return true;
+}
+
+bool nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				   struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap;
+
+	if (bss_desc && (!nxpwifi_is_ap_11ax_twt_supported(bss_desc))) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "AP don't support twt feature\n");
+		return false;
+	}
+
+	if (bss_desc->bss_band & BAND_A) {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_he_cap;
+	} else {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_2g_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_2g_he_cap;
+	}
+
+	if (!(hw_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "FW don't support TWT\n");
+		return false;
+	}
+
+	if (!(user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "USER HE_MAC_CAP don't support TWT\n");
+		return false;
+	}
+
+	return true;
+}
+
+u8 nxpwifi_is_sta_11ax_twt_req_supported(struct nxpwifi_private *priv)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	u8 ret = 0;
+
+	if (ISSUPP_11AXENABLED(priv->adapter->fw_cap_ext) &&
+	    (priv->config_bands & BAND_GAX || priv->config_bands & BAND_AAX)) {
+		if (priv->config_bands & BAND_AAX)
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)priv->user_he_cap;
+		else
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)priv->user_2g_he_cap;
+		ret = user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	return ret;
+}
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &cmd->params.twt_cfg;
+	struct nxpwifi_twt_setup *twt_setup;
+	struct nxpwifi_twt_teardown *twt_teardown;
+	struct nxpwifi_twt_report *twt_report;
+	struct nxpwifi_twt_information *twt_information;
+	struct nxpwifi_btwt_ap_config *btwt_ap_config;
+	u8 i;
+	u16 cmd_size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_TWT_CFG);
+	cmd_size = sizeof(struct host_cmd_twt_cfg) + S_DS_GEN;
+
+	twt_cfg_cmd->action = cpu_to_le16(cmd_action);
+	twt_cfg_cmd->sub_id = cpu_to_le16(twt_cfg->sub_id);
+
+	switch (twt_cfg->sub_id) {
+	case NXPWIFI_11AX_TWT_SETUP_SUBID:
+		twt_setup = (struct nxpwifi_twt_setup *)
+			twt_cfg_cmd->val;
+
+		memset(twt_setup, 0x00, sizeof(struct nxpwifi_twt_setup));
+		twt_setup->implicit = twt_cfg->param.twt_setup.implicit;
+		twt_setup->announced = twt_cfg->param.twt_setup.announced;
+		twt_setup->trigger_enabled = twt_cfg->param.twt_setup.trigger_enabled;
+		twt_setup->twt_info_disabled = twt_cfg->param.twt_setup.twt_info_disabled;
+		twt_setup->negotiation_type = twt_cfg->param.twt_setup.negotiation_type;
+		twt_setup->twt_wakeup_duration =
+			twt_cfg->param.twt_setup.twt_wakeup_duration;
+		twt_setup->flow_identifier = twt_cfg->param.twt_setup.flow_identifier;
+		twt_setup->hard_constraint = twt_cfg->param.twt_setup.hard_constraint;
+		twt_setup->twt_exponent = twt_cfg->param.twt_setup.twt_exponent;
+		twt_setup->twt_mantissa = twt_cfg->param.twt_setup.twt_mantissa;
+		twt_setup->twt_request = twt_cfg->param.twt_setup.twt_request;
+		twt_setup->bcn_miss_threshold = twt_cfg->param.twt_setup.bcn_miss_threshold;
+		cmd_size += sizeof(struct nxpwifi_twt_setup);
+		break;
+	case NXPWIFI_11AX_TWT_TEARDOWN_SUBID:
+		twt_teardown = (struct nxpwifi_twt_teardown *)
+			twt_cfg_cmd->val;
+		memset(twt_teardown, 0x00,
+		       sizeof(struct nxpwifi_twt_teardown));
+		twt_teardown->flow_identifier =
+			twt_cfg->param.twt_teardown.flow_identifier;
+		twt_teardown->negotiation_type =
+			twt_cfg->param.twt_teardown.negotiation_type;
+		twt_teardown->teardown_all_twt =
+			twt_cfg->param.twt_teardown.teardown_all_twt;
+		cmd_size += sizeof(struct nxpwifi_twt_teardown);
+		break;
+	case NXPWIFI_11AX_TWT_REPORT_SUBID:
+		twt_report = (struct nxpwifi_twt_report *)
+			twt_cfg_cmd->val;
+		memset(twt_report, 0x00, sizeof(struct nxpwifi_twt_report));
+		twt_report->type = twt_cfg->param.twt_report.type;
+		cmd_size += sizeof(struct nxpwifi_twt_report);
+		break;
+	case NXPWIFI_11AX_TWT_INFORMATION_SUBID:
+		twt_information = (struct nxpwifi_twt_information *)
+			twt_cfg_cmd->val;
+		memset(twt_information, 0x00,
+		       sizeof(struct nxpwifi_twt_information));
+		twt_information->flow_identifier =
+			twt_cfg->param.twt_information.flow_identifier;
+		twt_information->suspend_duration =
+			twt_cfg->param.twt_information.suspend_duration;
+		cmd_size += sizeof(struct nxpwifi_twt_information);
+		break;
+	case NXPWIFI_11AX_BTWT_AP_CONFIG_SUBID:
+		btwt_ap_config = (struct nxpwifi_btwt_ap_config *)
+				 twt_cfg_cmd->val;
+		memset(btwt_ap_config, 0x00,
+		       sizeof(struct nxpwifi_btwt_ap_config));
+		btwt_ap_config->ap_bcast_bet_sta_wait =
+			twt_cfg->param.btwt_ap_config.ap_bcast_bet_sta_wait;
+		btwt_ap_config->ap_bcast_offset =
+			twt_cfg->param.btwt_ap_config.ap_bcast_offset;
+		btwt_ap_config->bcast_twtli =
+			twt_cfg->param.btwt_ap_config.bcast_twtli;
+		btwt_ap_config->count =
+			twt_cfg->param.btwt_ap_config.count;
+		for (i = 0; i < BTWT_AGREEMENT_MAX; i++) {
+			btwt_ap_config->btwt_sets[i].btwt_id =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].btwt_id;
+			btwt_ap_config->btwt_sets[i].ap_bcast_mantissa =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_mantissa;
+			btwt_ap_config->btwt_sets[i].ap_bcast_exponent =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_exponent;
+			btwt_ap_config->btwt_sets[i].nominalwake =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].nominalwake;
+		}
+
+		cmd_size += sizeof(struct nxpwifi_btwt_ap_config);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "Unknown sub id: %d\n", twt_cfg->sub_id);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &resp->params.twt_cfg;
+	u16 action;
+
+	action = le16_to_cpu(twt_cfg_cmd->action);
+	twt_cfg->sub_id = le16_to_cpu(twt_cfg_cmd->sub_id);
+
+	if (action == HOST_ACT_GEN_GET &&
+	    twt_cfg->sub_id == NXPWIFI_11AX_TWT_REPORT_SUBID) {
+		struct nxpwifi_twt_report *twt_report =
+			(struct nxpwifi_twt_report *)twt_cfg_cmd->val;
+
+		memcpy(&twt_cfg->param.twt_report, twt_report, sizeof(struct nxpwifi_twt_report));
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.h b/drivers/net/wireless/nxp/nxpwifi/11ax.h
new file mode 100644
index 000000000000..2eda69f19763
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: 802.11ax support
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AX_H_
+#define _NXPWIFI_11AX_H_
+
+/* device support 2.4G 40MHZ */
+#define AX_2G_40MHZ_SUPPORT BIT(1)
+/* device support 2.4G 242 tone RUs */
+#define AX_2G_20MHZ_SUPPORT BIT(5)
+
+/* Get HE MCS map code for n spatial streams (0..3). */
+static inline u16
+nxpwifi_get_he_nss_mcs(__le16 mcs_map_set, int nss) {
+	return ((le16_to_cpu(mcs_map_set) >> (2 * (nss - 1))) & 0x3);
+}
+
+static inline void
+nxpwifi_set_he_nss_mcs(__le16 *mcs_map_set, int nss, int value) {
+	u16 temp;
+
+	temp = le16_to_cpu(*mcs_map_set);
+	temp |= ((value & 0x3) << (2 * (nss - 1)));
+	*mcs_map_set = cpu_to_le16(temp);
+}
+
+bool nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				   struct  nxpwifi_bssdescriptor *bss_desc);
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap);
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc);
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+
+int nxpwifi_fill_he_cap_tlv(struct nxpwifi_private *priv,
+			    struct nxpwifi_ie_types_he_cap *he_cap,
+			    u16 bands);
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+u8 nxpwifi_is_sta_11ax_twt_req_supported(struct nxpwifi_private *priv);
+
+#endif /* _NXPWIFI_11AX_H_ */
-- 
2.34.1


