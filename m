Return-Path: <linux-wireless+bounces-35533-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jpscDbQO8WmrcQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35533-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:47:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3DE48B516
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E737530BA407
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A623B95FF;
	Tue, 28 Apr 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jlwSbb16"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCB3B19D5;
	Tue, 28 Apr 2026 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405356; cv=fail; b=G/heuo91kbSMRCpuyZWr0AnyEgvJ05BDzHyqvKDDoPImMtgz2FuHJLvDw5jpdzTsjOYij9xMp2ZpdpkIpyOKsO9yVlDNXxj+62bk14Si0g9j2GpbTlk/a4kZmKV2dLVfd2ppzhYgRgx70tqo9FyBl+GAblXFAjap0//o4sdHCac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405356; c=relaxed/simple;
	bh=oAC0Y1Vcw6jY5NVV2LTCAi/5UKiNxceyr4q1NW9XEM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHY8rirx1IFAMr6JCaJQiJVvEbtXMGZD75oRL8tb7EOVm3JELs0Fk70A1z1WdfbUWGau4DuMzRmJ9lcsaIIKIzC0+BFnIwEGcofyKRZX+yJQz1gyghE9KuQCAJSlN+WDrioGBGqENjFqArjqMqbc7Pk6Zyj7Z6vr6BrHyugTgvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jlwSbb16; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkJqZebp/WIPUDboIIHeiPdrjrCg54YPQRA8CuSQTjgMXQfDeZgA1/KYgI1Fhu0ByvtT7c9gtY5X9y7PbRB0CM1UA+m/TfIwOtaNGOGUl8GMwkinM30wehKw27pUgH/DkeG1T7Yf9Eq/NW1HLGEI6dvf8oPvYb9N0QO9lGFjknMGhiTaiTtQQkYKkjuMMFbLShXw5K3gZ4mTILNJ5n88MS2KWwo5JzNeyuCW/Ymk8l7PisYwLii8PeddF+McJsN3jVpldhpJMWp8s81IuZMklZDkkdBS0TNssXqfTKaIe7d0cGEaNmzJjUUGQOvxteKzGlDcW87zbKJ+9L+rdEwLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4F3+24SqD4Os9Ablxf+os+lU7pInNeJp93RKath79M=;
 b=BclLuqii7T1tMoi8PYE0U1ZFM5tWbLaeDKJNwu58MyGJ76/twoSU12BxIwWNoqXrDg46WQrt0RxIJUHgd0bTQxn0/5hYMSMXvkYfWXiIarUxZ46zxsjnzLs3KDlldN19t0MLVPe7xf9BpWGE9RIj1UpBoBVXgby4xRW4kOnpNvHbi6R+GD3fAkRNld9qpcxT0BOTSzM7V73g6/8bLG+auyTJrgqPzmd7R4SDhjgV73hRqdrlron8HBKDmjmjTRgzqCi18XAagC38IGC+jOAoh5zqZYMiXmcy0eMpCzOiFBGL+l3nqZmMiKDbniSFZuV+lkFVPp0zX/laWAVpm/B47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4F3+24SqD4Os9Ablxf+os+lU7pInNeJp93RKath79M=;
 b=jlwSbb16McjaG5MWCEu3l+PsWXU85mTsoR/0pq8HEEi6U89N9F7feK6oOkSEu3XlxcksLLtwTzHnHjNmB1V7/o2RUA9cH9yUcvghY12GV5VCQeE1Hf56uaYMaGWSPKnvRLmfbSUBb8rPZ/xuoZZhkC2AaeuDVU82hsD9rdHPX/9Rt8D+nz5cCmdm5y7gOwXoa++SGbrf3pXhciYT5qcPLwvJDQ4nPl4iUhgXrmM9MbMZfHorep+QBGvIeHK+qiDCLTCE18bYhuR69YavSACBXtTn1SrPy+7GdCgtyu9z3stUjEJdUuAcFMuZln9akQAqsc+fHtnE/j/icYrQjUPDXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 19:42:19 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:42:19 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 21/22] wifi: nxpwifi: add Kconfig and Makefile for kernel integration
Date: Wed, 29 Apr 2026 03:40:20 +0800
Message-Id: <20260428194021.785252-22-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428194021.785252-1-jeff.chen_1@nxp.com>
References: <20260428194021.785252-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::33) To AM6PR04MB5239.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::12)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|AM0PR04MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 964da46c-1d03-428f-55fb-08dea55e42a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9dzhPW5Et2CUZfI9JEcFEQQ/kzmvMncJDlQjYYqJwyZObvnuN2kAmPdX2kp0eaIO4G80JZV21mLAr+bNXbB19FNj/k3qIOhUCpuT1RmWfBRBuO4KlRt2Gw6P88nROPH5er+JwLNxMXUWBTCx/AwkwxP/kDCr3s44Tf8H4QJKKNH6PwqNuFAZIlr8g+QR++h0WIyYZ4CpzmlnKPL0YUb5D1OUqXO2eqrVC/ljmMlxGr6q0pmkj7K8OMlQ5xFgvG9lmNHulDh2r8f94YH+/e81hxcCfgP+qL2GignsxaKRfdgQuifHt7JGZogwIRz8qZmLrKaod1yVWU+6yLiOe5YJ6MiP41oTH1wS36drkhB7eAnj94etRT5AtzbBVa4z1XYk8YCnNJ7cq2CSrhAPsSHSftC278jh2Nf2VsPb1F7e6B6d/Fs/RhSCWwKtRnTRMBK8hbAA7byMDdbRW7yid45uqpLeb/BEcbeySY/CmHdQvGlKc8P49y8j+SArktpK8oEGhCSggDfDDdAvTOEUqfISmLIowxahSzrHR1Ja//yZTbNoNQL18gIsbO91g1LV9JkYTBQgcVKzinughqqMK/ZsJR7lxb59o7IpmejyOSyCQfYbxg/SYqQWWTFWAEbcqQjVhA3XQ06B7Yf2hIkCp6cz3QQ2q4W99Z2y0fk4h5T3LBOgZgwFOBtTc5Y2vT/+YC6kh2YrdAFO/LMtCMaN4kHO8P4I37JtykaiwF+MyHGG8EoglWaUlr59SH27dojrNDKZs0pP/2i28I7lGnTWyCc6rCNoSGOVB6ZzbWthSaI9QZg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0/uHgkWD/pI0QMmDboMKtDyK6Jfo/mVEJ28c/bcZciDrjnQ5FElNDRk3C8M?=
 =?us-ascii?Q?4HilV317jzyC8RL4UexkVuduDr3g7clXv1qVEZWj8W9FCjPrLzcWFHNzHIO4?=
 =?us-ascii?Q?DoVUJyqfdK8vUWgf6xFQhrmUZHyjmnfQRTaTAePtjvRgb3glbUasGyKHQ0Ms?=
 =?us-ascii?Q?4G8DSrVkHhIIeTU4EIafFwdKYLMqMbZoZgB+iubr0WHxuTcRi32+pMgxGIFW?=
 =?us-ascii?Q?41A0Lvm5iu5gMKPcc2m4Apsn/ohJ0IoKpIgDjHWeLQL/CE411sztuVuDIK51?=
 =?us-ascii?Q?O/u72C+UqpW1Sfy0BE6VBpY3YhbCmQPc6qleOLcZTWoZLwWapXjyYqccKgL2?=
 =?us-ascii?Q?2XIO3ehSDVmn+2QrasvXRSMUVpiyY+6AS/VK/bzxKBToGy21H46HOlAd4xWv?=
 =?us-ascii?Q?yxpGSYjZiI49mJX8vCxG37it2w0HyjzoEg9NJaAE1jG9CBHBu1bxZiXMH3A+?=
 =?us-ascii?Q?S3c0qj9fnZdfxGC4j81TLS8w0ORJq6XQiEuKYMx+ZlfM0KznWHnfqUPQ7hda?=
 =?us-ascii?Q?JNxe7+tOj76Y6Xu1+R/uCsg1x+kHy5tz+0CJveWVZ2iuPjh2dy2M9338g3el?=
 =?us-ascii?Q?PLA/rvv2FWSSqcqHzNR7Ya1TpDDRz2OykA50qsoZlbitziG3/TS1jI6Ydnyu?=
 =?us-ascii?Q?2TL+wpsmuc91u+t1YIGUtQYLf98A2aD18PrvrZQN5thCF7w0hDrueA0xfM8V?=
 =?us-ascii?Q?87g5dmb/Wnyg+8Zfl/IK1Erq7JGUfNFOmIkmNph2Sl6TYdu0f8Y8kZM0PJex?=
 =?us-ascii?Q?+7Aq5ZvUs75EX+ux9eiIbi8OFhZxuBl7ic9JQVx6cGHfxjV+k+nG/AZbZ3sN?=
 =?us-ascii?Q?xEQBRIjImKcpwc59BfO81VabYfzamos6iOfq6qUllzLnAEz/Ox8d+EaEBsgH?=
 =?us-ascii?Q?nckT5Lx5u8SDL+iY6pE0lwzAT9AJ8lsf2yTUyljbNIC3ryjwFRQ+MkxnguAL?=
 =?us-ascii?Q?/X6lVfJpoN8cBeVpmvKMnmIuRr6jn2QAjh1iCPrtaKbGffFPOHpaMEM4MkVs?=
 =?us-ascii?Q?LAyRmNHPy3Rmb1knQblI3SvFbdD7KKeGXG1ZBcD37cIfJo/kRoDnno0ARl5K?=
 =?us-ascii?Q?gF9dwmdENStm2Ub/jwa3khOLPb+VMXm6bM0WGa5iKUZnqnfpSgtd1LXvTUkM?=
 =?us-ascii?Q?xYCqIWGRhxlNNwuInMKt6FomYESFPOYvtNV2NKYQr1i1Z4tuN7yxaWWMixdm?=
 =?us-ascii?Q?h7olBSFVG48BMNAsAIvSDUSNaoHaAyNcW7uexV0xCRW4+qpNqZlPTAp3QI32?=
 =?us-ascii?Q?rar9/g/lcnZXSBSvjMBDitiwN9utBu4wt+oMa1ymNEr8v+8FbJ6jQV6Dqzia?=
 =?us-ascii?Q?eOunoJfbrIQ0RhQ7S6mLKIQsGJ2P40zJLE2wpRkZ/gBXSlaY5baVsnw7XrIN?=
 =?us-ascii?Q?MVqq8MMaQINoXG9iBKpdafll0WFN1jm0BtJA7S98sb6NO0TjpVRvKtFAOLdj?=
 =?us-ascii?Q?3er0tR2g7IqrLab+1S+243sXRBZqGa0DM2JwDN7hjREWTs4pbQPyiU4XcBPY?=
 =?us-ascii?Q?+4OVhD1rSnvjutq9gQ5g4xzUlzB1YJo6Pqw8YgZX53yWfN5h4PC4nEw/ElOH?=
 =?us-ascii?Q?4HYjh0lSY0YQaAp65/U4tQ+B/L4Hx7Cy2HV0tVLpxXWzn9c5QKHbqlvI4f77?=
 =?us-ascii?Q?KpEKJAPwigg4ENXRhSCWfJVdJo5OE+61V4wsoOcuSPef+wE968EPjNSR8r+t?=
 =?us-ascii?Q?RYjYD5NFdc3RqgODhiD01n+cE/+D0l56gUSFzlPDlrVyfgZ3T0UN+GNadUQC?=
 =?us-ascii?Q?3Dui+/l2WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964da46c-1d03-428f-55fb-08dea55e42a5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:42:19.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laUvVkIp/Pjxbps29dpHh43Ko1E4dlbj0WfvOo23BpfZsxUvG+5nFc+R5NXjjK+peuRL3ZRRSkq8GDvv08aNOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
X-Rspamd-Queue-Id: BA3DE48B516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35533-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add Kconfig and Makefile entries to integrate the nxpwifi driver into the
kernel build system. Enable selection of the driver under the
WLAN_VENDOR_NXP menu and support building the SDIO transport backend.

Add WLAN_VENDOR_NXP to drivers/net/wireless, define the NXPWIFI and
NXPWIFI_SDIO configuration options, and create Makefiles for the nxp/ and
nxpwifi/ directories. Register the nxpwifi core and nxpwifi_sdio transport
modules as build targets.

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


