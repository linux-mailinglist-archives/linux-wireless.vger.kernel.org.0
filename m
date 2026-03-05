Return-Path: <linux-wireless+bounces-32541-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MIeM82ZqWm7AgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32541-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:57:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF0F213F77
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C7793082A77
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2DC3AA1B9;
	Thu,  5 Mar 2026 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WSPOoFw2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348773BA236;
	Thu,  5 Mar 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721775; cv=fail; b=E8MNAG5VDBSKQZJ+3tmbkEWruPCZJeRd9G0Q1CZ972Jq5zreD9PygjIHpfHUNjI5vc9qHDShG6SBSbzLyscowZjnVSnPuYWW/mHPvznQvgFTdxKIeCOl55aYjKeKqGsHsLO568AQyHbooTvcMTq54RPVT9YU4NExo0vpc6XZRcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721775; c=relaxed/simple;
	bh=oAC0Y1Vcw6jY5NVV2LTCAi/5UKiNxceyr4q1NW9XEM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHhNcyzz84lh0FBqOeeTL4UNRzPD5eOjmzFvYWkhgnS1v3A/z52k8pdoEOUAO8sfBUvv7IdlXlkCba/TcGMcHqe5efGRtxsf8awjmCuX/MO3BIAXbyxZZz4BWX61iNVcb62eI9474zDt9B0tP3h2iZHf1U4tNjKEq5h9Fr5i8jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WSPOoFw2; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEk4OQ2vdL39zK95v7vibfn+se6FhSSDw7FkZ+cDqjha4YV91jjWVZDX3K41+WV8hubeoj+25KAdDtV8GM0ZqzBzfuTM80JKnHfcfLlxzysBHoLQrbFjHA23blffgzBIjJI2kIe1iQd66LgD8DFrrmJUCkfXDgoO8qIu6o4IaH/+DOBHidBOLxugMDMGs0jLyVChJgzPW/UJtE4DK6tZJ8T9Gw1RCKy1nHdvQbTnH0mP6w52+OcQRFPAadQzQ4Tg06Tmy/gxyAJTCCox8sTqMUzXkCWId8rA4g15pYiQ22cWDZGdYihzaXjaf97Xoud1XDRIcUUFmrsWocqb3+qRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4F3+24SqD4Os9Ablxf+os+lU7pInNeJp93RKath79M=;
 b=xi+oU+XZ/pgL4WRK50/ZvVucduQQvhYxnca3OWJi25dkIu/xJrhaoWbIivucuNQzIsEfkb0SWbWeThcYJJ7GEK0ZZBnNUqHjH6F1bHaCDTjouaJmUUOk7QXAutqYmJKI30HPiGwygxX2QG+qAb/qxbTn8UoCqRiEe36wq3I0FWoH8+e5YNnaZH/bGJMtoNNgmFL4MAHNoXntl5KZeslsSBhyXxoigS8WP1aFk6EK0JJtjcHrM3CQA8truQWe6X70QS2i05lcS/7NsE6BsX3LgYTfxhHAlsWJ89a3g+qTfsH+08pGsqsRoUiN+3zX74W8ihe3bCZSB0McQEXFq1WEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4F3+24SqD4Os9Ablxf+os+lU7pInNeJp93RKath79M=;
 b=WSPOoFw2y5Kp+KOO1zuzbnt0nURw97kzgT3FxZsLnHoM62Bu0gh7xV8V8Fdv8/kLrErafri29kio4weARv0UAoxTMn8aFHqe/ZbMV3Mx9Mi3TjSNSlyydDeTjPlCVo7ff31N/fRsVXQlJbMGVpPk28qwIAKRm/aqDKQGhlJD3W6PbQVsowUcOGPu6y5/x+MyBiQ3ahBux/38YAQ9nERQkwGoCR0e2wQKxlxHyN4jFJMh/ttLxqER9yXULVyiVEeleszC+se+sXOUUOMxfknvUoem3uYcfP6ylYL7LvaMj9plx9QFvF89nxZx0SHO/TsBCf4P5W80j6HjQ+yPegqZKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PAXPR04MB9679.eurprd04.prod.outlook.com (2603:10a6:102:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:42:41 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:42:41 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 20/21] wifi: nxpwifi: add Kconfig and Makefile entries
Date: Thu,  5 Mar 2026 22:39:38 +0800
Message-Id: <20260305143939.3724868-21-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PAXPR04MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: e37f83e6-5937-46d6-ff27-08de7ac57469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	E1VDyO9YE9+S4j3R/GBY4DzMJ4lK1cqQQOBQ5pQhMdNKKV9KxRhJ0gB8Fq4IeIhIX5wscLOnM77rSK0S+rvtBoqwddnElam2Fn8uAH1t/BvVXX1ec5KKARV3oDE3nQzypsDiarDp/eQQTYDMmgGS9/98T/ME+z8EJfXOgY+T4KTxE1sqKdLUU9zvcAnSokhAR4GBEH54I9/uqz33RvQ5DxDsfxpi4ht3G2akOvl0NaNL0uUj6E+NGXYgSr9XerGOLvj68T87jOaBi97RUvwnpHYPRNOuztpLyu/wOT4JbbAWt7F5nwtdukJO+e4bRSx2TVTgdDlmMTZ/jbGPDSIcNqGgNx6vUBTGXv+jlmdKC3AT6yDoJzngh765tvmtylykwe2NyTtnOLmf7jTVEdHSpbpD57RnVnwOresNtdCEHcTNc/VVmpgBrt6EwX5J2SM8WH/cWQ9Scxm6IMYwqVGxcExa/cKxyfKvNKone+nTHcAtObIgj5jGLGrdIIba8XLEFoDK1hA3I1nCDXl5nwsCK8LmxEcdBCWSd2YQ7mmrpGDgDAIsrfsIRNqDvZ4IrL9Xm6mFBDN1t6wjebmTqvWbpbo7flMphR7UKViUM5OWr2zLTgrObN5asaBFTOmWT5yy3XrdSLhYIeyBC3puLmNVynyYTl/YizrD46rfU0T1htq8VWLUR/oESe1A/anEFArs7yU3yPH+HkiQ/xSRefmv7+bUMJ1/OhEhqncajWfzf6ZTlVaczFYM2E6OS1h4mOnvKlO/4fqCmvV1+pRLZDO+eXbK63fmM2EICunSrvNy4SU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXVNIga2/UVclIgEhcc5yDLduxPqUUEuscRVNnFCUenOe+9Sc7j2KIo06MZx?=
 =?us-ascii?Q?HHlhpWhFHd+uz/nCCIC1ZXy48Rt2TqLmIEbqZzXa0vYG9/9THXUmN3BK3bEZ?=
 =?us-ascii?Q?DyuT9XtjpM26qKxxWct7Dn4Lta2ZVcZnKTsNNmzGSaUNgc/jf2BL4EqW3RHp?=
 =?us-ascii?Q?ySgcCE+VIuNEmcymvoLuCx2Lz+2tju6py7pD/DLeNqieSAXMQLL959J5ZDG7?=
 =?us-ascii?Q?L9dVjzz2sfy4WOxdntSE8+zHoACUpy23gzvq5f9fmAJ359DHqageTdwCJ57q?=
 =?us-ascii?Q?2JckeZqOfpg1+jDj/lzKSpIb4nE8mcImxhK66qz06DvilrVbsbvo87+4Msnb?=
 =?us-ascii?Q?SU1E1io95kPAmf2BV/zZq5ZldVo4VcP7RZTc/O6AYLp9IFaiwda8dD0pQflO?=
 =?us-ascii?Q?07bQW+WVAJgw+c7WdmZ9zi3sFPhWOFcGlviCz6j3gYczVyM99nQdZ3KHrYra?=
 =?us-ascii?Q?EttsXwG3NDk+7j0zMF+1q6s/9SKEjV6Yvb06YY8kbJGu5rwDcJ666es3C1qQ?=
 =?us-ascii?Q?XKGhshQoT6xt5a3J7N2IKi/FQyVkBfoWAeLZitmZARdOaNmsEuARq3exd0AH?=
 =?us-ascii?Q?HgYcxiBVV1fpoKG/tg8FCiktSkbkCYVouhw/V9p0BayDJJ32Z4tTafarf3+C?=
 =?us-ascii?Q?0bTvqplPlwyaXHM6IjbN8fQONaT14g4qfB70nis0CBCu6GAzOGxE2Jpl8NDS?=
 =?us-ascii?Q?JuGWFjW6+GiQQvDQ8rfjeeFBbeGxYEkmR+XVtD4ten63CVuRcPd5odNxq4hg?=
 =?us-ascii?Q?rIxG80vTt3vcmxk3WLynR97bsDJvA4rO8UGvg8/Oe0t/gw6maiTzGwN2qKRF?=
 =?us-ascii?Q?IZXZvND4RQfepDeFYWCZjbt7wE+z12JCF3EivZFHauDPlCGga9OjI7pZ/7wN?=
 =?us-ascii?Q?A1lo9XRuVOpURRdETaVrT0GM7YrTdRk556pnfPZxZPDHOGLKlfIJzVr697kF?=
 =?us-ascii?Q?jFyaFYaHV+91ECHca/9WSPu2y+KNgWCnLxTt2YAVu4Rbz4Zj3A9fYv5Bpau7?=
 =?us-ascii?Q?rxf7Uuf0l7hJo7R6bHfkX5LNADd6e2V9A1yMCZI0fv8hCUJyiFkuudWDC1cf?=
 =?us-ascii?Q?9HoTznQ7/l9ZnC4g/mD6uksREXlqTiEol4Q1PK2vrKOfUrolTLiOdebQ1SAg?=
 =?us-ascii?Q?tqU8kiScfCkyBGOyf90Z9BxOF5aLy1KNiM9PB0Y/D6CTpoZ7n9ofVGtgKNmN?=
 =?us-ascii?Q?7A/64uUteEqj5SwDkC1MCn7filBQoxOXg7tvzZlvpHfGZ1vKVsm/uISUT4OF?=
 =?us-ascii?Q?RcARHj7ZswrhRpMrrcSPsFzq4KDGZX4yb7izasE/EOSDkUjk/OQrVFWjUrAT?=
 =?us-ascii?Q?wJiNheyPLnsZqmUh3IbqMUGQbhHlLjSJmYI7E0HKA+JpJAqL2tPW7JUHTJgs?=
 =?us-ascii?Q?jnaqQzvWWCXlUWlr+/khU0we989qPrCP8YoehvJM4X6hPndKTs2INecVJ1B/?=
 =?us-ascii?Q?gW3/kCyEHAKFCk2NT6yu4H0f2NiFU+m59vNfiGVXwkAYdN20rZpJnRjbEcbl?=
 =?us-ascii?Q?BydDLwN4llTNHXtTxQK2fqoOmBy6zfPQs3ZL5pWEPoQQjRgNvD8xxXy8wJ99?=
 =?us-ascii?Q?JFZagWxvSQ0IXdtGbVhbL2FD7LLaj+nOUG/AGVcnH40evU2OPzv1VsEyis2c?=
 =?us-ascii?Q?eSfa4t0hGVsi5nW6fked4UDMI3LkvT2F4DlA4bZDRQP3CMRQc7dTEhR4xmn7?=
 =?us-ascii?Q?lLDNKc/ce1KK0krhXXPN1lQBW3jT1uBNfPjYg5I7f1/e2Psc+42HsyVlTrs5?=
 =?us-ascii?Q?tn+QOgmxxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37f83e6-5937-46d6-ff27-08de7ac57469
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:42:41.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SF7jKJ3yzJcdvnyGIxKpaNM4RdPcI5kuphhB6M0khFuRaKFjWG9okz49uLk8VRtiebgBr9ixfgH4FBEcVwv/hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9679
X-Rspamd-Queue-Id: CEF0F213F77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32541-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

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


