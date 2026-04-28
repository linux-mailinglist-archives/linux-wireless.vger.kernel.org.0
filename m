Return-Path: <linux-wireless+bounces-35535-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBuiBdQO8WmrcQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35535-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:47:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F46148B538
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A71C730C282D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB9477E21;
	Tue, 28 Apr 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lqdag1yG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580BB3B961D;
	Tue, 28 Apr 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405358; cv=fail; b=Dzr+sGBRHQAUGsV4gfb9Hz9scDktLkZUARkkl4Grg37v+NpFRi/76Q9jD+C/JDsdbydEC7ovyBCOI0cm97azQWBH3Rc51E6mO9C8tCjUjk4S5cwywuUPddoqYYOSb667PJPdZTYidRuJ+DjPVb2AHXVjq54m7TtRHdXsPe0McZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405358; c=relaxed/simple;
	bh=u8uRjDk3eXofL5Rc/B0/5jdHx5poeuvldzuW4IvdYDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEADQ8kwlFSBBsjQoi3FFdhuHI0i+fdgPrzdpmcpKF923tb2gx+N2Y30jKYqfVhLW65Mr86GxMSK2Jm9NX/eRfAkphI2nyhlWOQPMO3HVzMDG3bsRQTfDqq/BVKBzZqPwJuUa/FRw6VDKxoXNvHa6pFAHv3VntSFr18yaP5WBFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lqdag1yG; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC9tRxND7MVXFIfOIFeqJJo/FjadyZH65EYAhyV8E6XqgmvNoNhFndjpG04z0b1g6ZJqkQ9YRoX324nMouBZuQ0fBXq4Z/0dl3B6ptWUV+98NcoKY+rSfEXOk3HSVczrZAkx/7Y9s5bjSf+PyNxb7maWjGMU/gVL1bVJzWbSKoRzTQmr2OMwkF7pCjsuXAVceaiSs4VfICQW+3En3UqVP0ufB/GewC9BlmcKLZsYolfFd0p7DhFEOmZwSvuuWDILKxKuwNWpHC5C0FQxVWmZz6ZYf9OyF8eHxSkmkGW9+AiK2bZNPI17Ynm8Eip/pw+VjRyJa3SPgoesh6UJme+1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4MvbK2l1ngtQntptqZkVI4pKyJ2cXjOiuZnvnrw68A=;
 b=dwf3eRHZ002LHYORFz3lQMhoM59nL0MXBiIJ7l8/3RA/CLaA0JFxivWgXtQzJii17APuHzdikdZzg5VvXk0Y0a2ip6rz1IbPDOwWhrenXYFFxadzERmMUq8wC2q4prTE2ln+FR3UnrruBeV3qIEYE0ICM2rvt58tNo3I0taD00NxLbQJb2K9cIWwnHd9KuWwkWf49svFKLAJK+Edc3LwiTg3o5JUDrHMpgc/tlUMq8a1sItAgE6IpBoh0flEh9N/qZsFzXDThcQjEqwyDLUfp2NOq4VUioO0uAF8KBFCfHopTqK6G5tiU9RjzXSuBUiRNu5v3xGbnE7xcixpMsv0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4MvbK2l1ngtQntptqZkVI4pKyJ2cXjOiuZnvnrw68A=;
 b=lqdag1yGP/2YR8tZlkTc+cSNML+BuQeUiYWw/qUXrsCWXY+C6w/pTLcx7I7rAKgTIjkvAU7wXkwvK4aAO0sRFKxf3xZKBHkztBPUPF+wsSKdVV5blnNoPd5fLB0dJxC2R+oAgdBKPiJuUylZVBqSPex7slPQ4wTLrPoiS5CUtCce1eOOE+qXXoNtKGkoNEvcKB7247JG6Aa+Yra4kWXNtmuJKW8ZYFJTadEvr1VpEJtFmPCiubMykDcwhEfb2O21zX67izEktmZYflwtXgprUPCTEI2x9EePnE63reWDQXUCJjYjc1w1SmE6vqj7DYEn0eowjnI7lKU2diqaOZCQJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 19:42:22 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:42:22 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v11 22/22] wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver
Date: Wed, 29 Apr 2026 03:40:21 +0800
Message-Id: <20260428194021.785252-23-jeff.chen_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11639a9b-282b-43f6-6361-08dea55e4448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	48OEtMKUNdDPrTofXMj7vScNDNFPRXNGs33z3nMpsTv9eZTDU70KOPiop/g0yVdc5PQpwcoCBQn6M3LxrPOMWVXu1kJPZacqDKlocuJaaP42Cn4OpXHWpu7J5IfBYXGF4Z+VwAt1tGF+kNkSpn6sH+JooudQuoegBq0YnsZnNXxRISl7DOXNDr6KW7FabkizFqleeOEv27wabAtQZ/73G4k7XguiJlQceMNeIpkWqqoBqfQ3yARt1kbg7i1izLDudxVfAQjLOe0UF7NcrS6MB52zwT4cS5f60GhxNe5UwgR/JP8k4BGON2ua8oSTTBp76C2so+4Ag8IF8zsasD8eCnJVJRlyTNcmC+8pLdXhjA3RZNCKhYTOp+/vs+S09+1xAXUjjIl9eMGaFXoyi3wELahScBRtMYVAjRsPyngsjjpjd+/eRVQUk0RAkoQTTPh8OkhYTRMeWo9PI7HR0nvcxtpNBruJBo8cMowR1eJTet+j4aEzROiCZQQFHYFhhq0Wnygj0/0NzA5/Ae++72G3AL5KaJumXolJhPxrwsgrid043oysMYqDqcWvvsTetkyB+1wk1ZxJngEzmYqhalQcnu68lzKEhErA3t52Zu3u5VAdAQKIZS3MdyHcCAlGjfbXqnMaFaESL+aaqmu2dVhWFP0ptYHZVXJLUxVUhNDP79mNPKAmwZLmS1Sf2iAfQuPZMxBnB6MleIbS/qS7B3Sp645UnCkPuYEQDcIqwGxwACN8QQ5AhRcB/XbvTR92E3pVOEoOdbhkwC3mk+vTWagJjD7IM27bO/zx5COZcFfIxVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxyILlS4TX3j2Xm5fECgWaNUqW6/nPVyzXevp6L0eoi/aLMBGUBHus80g0Qp?=
 =?us-ascii?Q?oUH9im/gLUM6xfGuU/glz8NrBcLzNkLnfkytsAntRxbJtlzscCZK4dF73Nwq?=
 =?us-ascii?Q?16+HDNJ3qXxNvFOEImBmBLvkFDWboJkNMn43shnuSg2g3jnjEXdEPCY9V8bs?=
 =?us-ascii?Q?CAhcHKE58JiLku7RmWFnhmgo55WjuVga+ssL9RW7ii3ZH0YYoLl4VSdwaLad?=
 =?us-ascii?Q?VCttm9hw+ovnje3+zap8o7krA4hQUjiQC71cYUh+ck7+fN7bAFHzxGu/9Edy?=
 =?us-ascii?Q?UhKCHiG04rjcWihZpqC6B5pt6TJ9HTSuvMAzVqsyPVbpeKsagOimyYG47H1L?=
 =?us-ascii?Q?CNgMyWDNzmqznZ9+yIHDQ41JelB8TmAMHg8WjGujz4JmGvuLY2j9t4gPykzx?=
 =?us-ascii?Q?n8KAHos1F+75fzUk8zoUek9OugVVjb58HJ1IIPM3Ude1WaA9j3RRgckY45nj?=
 =?us-ascii?Q?m9SpTDQRcvOzyz6OF7n2yBtOYfqHLK3J7OwjotwTacvlSwbx3l5VNcko/dpa?=
 =?us-ascii?Q?kJTiwxP3b3wgcJtqn6o/UXu2HguC2u128u1VO20BWx07otZpv8hqn2mXYMsY?=
 =?us-ascii?Q?vFq9w47VQ5wRwlYuP3aADpEwi3pPCofazsyaz1WgE/D209i9IOQ5XSdV6Yrv?=
 =?us-ascii?Q?2zg47LDYLCdVNeS/BaT0BUlxHPI00o2+b+hx6XRRa0vIEHoLfbBTl/B6rWOS?=
 =?us-ascii?Q?1c9A4WC/JYTdBKW+21YxeG1EPiklN92vnbq+RtdhMA7qw+SHKV/qRQeYCHNG?=
 =?us-ascii?Q?5UL2LbFq3GZoiMbdF1M750z8vXwF8uYC89jvM8gAb3ru/w6DhGwoBqejHwZT?=
 =?us-ascii?Q?R36uKIBs6k14yiZH/1HIgup4IT/OYvKbpgNlrAee/wbT+poZitvUwBjT8wRz?=
 =?us-ascii?Q?J7UOylLoSSHqk2l7uH23ptnAAowQV6MibCO7/Wukpes2BQ8jOb1/+/m4D6LV?=
 =?us-ascii?Q?RnaIc3i8BBcFqww+go8GbwiwLw3mngurTJC90+nAgLsHk7AebJwCO7zZXMGW?=
 =?us-ascii?Q?01jDQdUnkISLeCNZK+TA8uavC3IyE11Pra+GNDdwuNmDjvSbI8ZsYLheu8de?=
 =?us-ascii?Q?5BZMk6WlOPQ3P2VILJP/RCxqSR8Zeo+nLojQglRzacX4jXJu9nRGu2aFu168?=
 =?us-ascii?Q?G8uYl9UFBv9Qg04WFcti+trdbtihnoC4DcMQILEywWgUUwbH9OZQKQ9EyyVd?=
 =?us-ascii?Q?MClmts5eW2rPQavjZBH4uFi/ro6/DjieD6ltvhJWQHm6uM3T70gpjqpQ4OoB?=
 =?us-ascii?Q?D59YjpbDxPEm/4xcS//ZJ+oT/lTtpx4peeo/ANmIeeQ67M5c/m2nuD+Khu+s?=
 =?us-ascii?Q?pqM8xiNLvSxaCTNvjGXY63HMSZoYcFc2RfMkm4pBgYZL5bv1MjXtWiO56Nqg?=
 =?us-ascii?Q?ytm8AnFM3r54kutX2LuexEKRAftSwGw/pOCcLzbUkmjBV6LQQ9CJE7Zgu76r?=
 =?us-ascii?Q?XPjrrzFk+LTU6QD5mWqxmomCZd49b1+gHyYCIpWAKmxS7xGdqgDYXyMIokNu?=
 =?us-ascii?Q?eakQY+KG3rk2jt13ra5NqrSMMk+vKNts6WUoQMgn32jBFxN7oFr48iOrueNA?=
 =?us-ascii?Q?pvBenzQRN8LBXxLFv7euiqGFX0OClBIcG1L/K9dm7tyDKGkcblt/+XhZk6iM?=
 =?us-ascii?Q?ASqIUSpMATEjLXfC+EIEV6CHWPhMPYfrvqGNycBzqseub10um9L2l00madNT?=
 =?us-ascii?Q?t3WNbTkUffDFc/JRXmoWBy0EkNU7m8i2QvCaw8IY4WXzemsQ4RRhdl9lbqCH?=
 =?us-ascii?Q?SViLplxBnw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11639a9b-282b-43f6-6361-08dea55e4448
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:42:22.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKEiI6z2LQTQmZV2yrrp3ykeiKUB7OIeSwX5L0JI4RIOF5JUOcXzstNPDTGqHZre/J8Wbn7YVQ+T5EJXdrDUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
X-Rspamd-Queue-Id: 8F46148B538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35535-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

Add a new section to the MAINTAINERS file for the nxpwifi driver,
including primary maintainer, reviewers, mailing list, and file path
patterns. This ensures proper tracking, patch routing, and community
visibility for the NXP Wi-Fi SDIO driver.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..c0a47b120d86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19260,6 +19260,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 F:	drivers/ptp/ptp_netc.c
 
+NXP NXPWIFI WIRELESS DRIVER
+M:	Jeff Chen <jeff.chen_1@nxp.com>
+R:	Francesco Dolcini <francesco@dolcini.it>
+L:	linux-wireless@vger.kernel.org
+S:	Maintained
+F:	drivers/net/wireless/nxp/nxpwifi
+
 NXP PF5300/PF5301/PF5302 PMIC REGULATOR DEVICE DRIVER
 M:	Woodrow Douglass <wdouglass@carnegierobotics.com>
 S:	Maintained
-- 
2.34.1


