Return-Path: <linux-wireless+bounces-37442-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HAEcOMz4ImrCfwEAu9opvQ
	(envelope-from <linux-wireless+bounces-37442-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:26:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E528649C17
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 18:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=EpSBYeF8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37442-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37442-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5111B30D868A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3B940862D;
	Fri,  5 Jun 2026 16:15:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC23ECBD9;
	Fri,  5 Jun 2026 16:14:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676102; cv=fail; b=QI1PfEZbzNdd6E2LzcJY5NeGABm20vAUPomGc5jaMsFiU3+cNCpBOco8yWxvNihQSc1VO/lzekSwLtRjOd6DZsKz9ZmZE/ZObmXRGk/SbqlQrvquv0acUDEO3jZpex7ouyaTLLu9V0HTI9dqaHGHzHgRUpV6I6BD0XOeATjB2Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676102; c=relaxed/simple;
	bh=iEGo4Pf9ki2bGzrcEJr6U4acP2vmESWaC+Rse88SJok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwHdGYzvmPEwoL8KVoySvOQv7mJq9iWsTOdArRjVqUwSVssOz99CVbCj/tA49jMKE/7RCDAPzdHexqqjiWaaJKRMvgva9EIw/fm7Hb/PVDoayR+gR+pQsxeD61HQOCiptAGHHM77JFA0kW6fYD7LcmQy/ennfZA/K1C/Vb8ckOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EpSBYeF8; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmUV9jycjDK1DN0tryk90tYwjY+0nbIaaj8GwSsn8ykkf+U6QeLDBwIi4GSzDNnWXH9GdrffGDJPMC90O3ei4oGYkrbrhT48+uR1CqkpettGymH177GLSkGr7e2lFYGoTh7agCA1mtrZzr7p0zE5sW0VtUIDde1YplYe0VoiR51+iHfHn5dBnlLYzDMLR3CSn2fTB74/08jNYg1gjTJ2c1g5mZ/irqyEstDwKi1oC23PbMv/SV1lkjJABpjLsRX0LZueshKbHc5LsD88KbfHFyqQRD0J1S+MRsClTQfCLvwxQfAk9OkvGUC12nmScf98g7mJaL/Qjdkl9xkByQE+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd1Rq3URiKqz1rU2RZ6YhtdboF1mCrIDOlMcl1eBlVg=;
 b=YxyWdkOfLXJvekOoY+VgwjrC0amECfAihsYXIaGo3wyUID2W7oO0SUxo279hhy1TveATTTWXdtHCG+Aq664kAgTDN9XrdT4mZK4oB4G5G+wBi839N0VZUixfYZ1bUAfpv9iWa+4/hSPzGl7D4zIn2BjJBrHyWx1Y2nMwGZFz4pGP3ym8Mkmkgr4WJIR0iiKGV0V5ZEFECYQpDFeL9FcC1sCq6kW9EMo8y+izFUCNre5EIHobry+g7liMRb0XZLh67UCwWY9tyLhsBN1ULcuUMGB+7+Aqbn6xVrti8rMw9gEAR+IWr4pLD6UlQnXYwNFq3v8a9svQg1bU3kODSEnWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd1Rq3URiKqz1rU2RZ6YhtdboF1mCrIDOlMcl1eBlVg=;
 b=EpSBYeF8f0PqArKXHFKBvKL/lmHFiABqdb6QQ2dfqJBAAfT2gcdRLhua06BknvPkXq2qLJ6l0HOVPLQUzeF15oCNPgors0l2bfeC6P/u/yJeAaEetocTx0nQvntpwMSoNGJ+xQIOHOE6mSNezwStPcuq90nOSkV7nfIP8mfG8tYHifkyVnoeXc7D2m9hPIfKM7NT64o+tj38OjmOxkDWuVXezuXfNRE3e3WaEVQ43djpR/vz9T/Es96STN7V3bacde5eSPGASENESHH9j05NzMjr/8rkV+FQQvx/k7L2mkiQbJss7M3F7D/RN450UukAOFvYJbddH2XmHOh98s648A==
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com (2603:10a6:20b:7::12)
 by DU0PR04MB9225.eurprd04.prod.outlook.com (2603:10a6:10:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:14:49 +0000
Received: from AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e]) by AM6PR04MB5239.eurprd04.prod.outlook.com
 ([fe80::fa76:ead:9e21:f84e%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:14:48 +0000
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
Subject: [PATCH v12 21/22] wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver
Date: Sat,  6 Jun 2026 00:13:34 +0800
Message-Id: <20260605161335.2415583-22-jeff.chen_1@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5239:EE_|DU0PR04MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: f4707a43-7a19-48a4-73ea-08dec31d90a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jgHfd2mPODFy+HG++GUXiGPN5QzGZMDnK9OKTB5KNKfTz8M+Ymyw3+7SR2+0LovzZmoVx+9MLiFB7YCiyAYqjNQZfKN9SHq+vlY4cuED+Ps3NBT0M7AZi3lngBixQAp1nr4by15t7oOBHhJcqPJMHzW0a1t+hK4IH7w0sKJMYprdI1OXzSBuaE9ridXPxAoRGa2YppmEoZVH/QM7qnOODSmHhdB8EfvLkKQHBOUfNp55YvvHzTrgHTf3NVHpvXo3oIJydeiKUCjEhJydFzq0mr54hW+wmAQVpYuf+A4WR7g2JngAuipeIJJ9mcGRLErgKTr+EqcG/XkakA/EIC59junBvcAAGZcxE+seTOFXGaPxEOlN3GFvm/Wg8OA2MwrfHGaerM3DIh9IUV0N9qJPQ9h/C4mATIX8Y/c7Cd5mEcGsu6To5zj+7wx60kAs2/4KLpZGBcEGRUrAi+JstVuzbOIbrSg6rYYNaqU8Ei2+9GbODBTLkdLzi0So5b/G3b+o7DnQfURlEfcZ1P4sTA8X7GkHquHTQTeIwaBF/lZtOux+d0BEhNbxcygxBEJ7jjI+3yxzSlwH9SJC/pPmqqd+s76cE9MVEyBIC1uEmoe6nykL+Uuc8GIgnLFCeqvWRi8EnF53t3unS5OipVGhJfsyirgC0pUC61gHAjYO4RgScMf/O95MeQGiE0pEQwJzTk/K2mctrd8/mGHybwnvK4LQc7/lZ/qiwn0GIya1cuztSsWtpS21PS4ttZGtu5YDB9bD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5239.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7UzuXvjPIr6Zj71r8wQqMRK8xhukSKTKtzL8WlzTArmOSoYJwYPuoSZHa3V?=
 =?us-ascii?Q?OxjY8YV6bvjT17Hx12dTG6+LQGekWokGXTm26OrffrHVvB1FHQKQ2/z77gz2?=
 =?us-ascii?Q?9YLsagW2VjBxdoIn2ZRrw6cUmFbEgqEkCMUxu90gyOYm/LSgicPNGrXvZu2/?=
 =?us-ascii?Q?uQ8COGhcA0NHLGK0yFSH+jHrA9FmZE52aq7m3+o1ErgKyGCfKbiIH862OvUF?=
 =?us-ascii?Q?N7eDvh/l6epqnq6kLqGz0mG1npI0a1P4ABod6yPgy152y1jhUgkhC1LVUj8o?=
 =?us-ascii?Q?WimpqGBK3pB3e++VGBYlCClsJ/18VW08/w74N60Kq2RdvoEtLlUlyFxB7PRF?=
 =?us-ascii?Q?4GGw1DLGfn9NW9V69lmyLHt6ivgiajoBiqxWHFZmuQDn7in8z1ehPRr4P46N?=
 =?us-ascii?Q?TXqJVqUmE8NT4BcOHGvg2FXPFeZOi13lPQ64kVJCStPh8qakAfAR090IIXmp?=
 =?us-ascii?Q?ZyS0dmCYCLAu1buMkIUEWCHyq6zGAzIj9fVVq1th3ifEGdBINQ0IuF2AiOWy?=
 =?us-ascii?Q?QXFnZlOIhzefOyKPv/TNm7XuF30NWdsIdTSUGmTjFJRPACjl5EtkzzeIOOtB?=
 =?us-ascii?Q?Qn1bzAkLWBhxFx4ruUYznCiY7xADcx//yXVYUB93SYn9T0if4+HHdkRCju0o?=
 =?us-ascii?Q?vFRhT+bvuAOXHe7aY/8yiKxceC7zWDzQ+BAsZc9BsR9/2hnbKFmwzxC5sUAE?=
 =?us-ascii?Q?372nI7yDHfdFd8EK7Bv7U2sn7w6+w6LVe+i5qlU8KLXZxjjKJpQWTAO9MhLZ?=
 =?us-ascii?Q?dEJbQ6YE24D+AGr0U/LZqnfbmA/A9zr/0EihLEGh1gEO1NHzjjPu/iPMNnzK?=
 =?us-ascii?Q?JX+kJufSvOWuO9oMJbCHYa/OYTtn1XY1KUcVdS8vnk32JxJxjiG1SmLQU90A?=
 =?us-ascii?Q?67+/4gCt+4DPbpFX6L6DaDvX4QGcXJUoTCe00jhkCKJc2Ie2zZxFhLGgHdrA?=
 =?us-ascii?Q?7+DGEG2sc/Kw7NQtnAAKOLyKNQmpkzOXL7dBFmFEGh8SLRDgXkhUuCa1Mis9?=
 =?us-ascii?Q?My1b1aVIf8kkWl1UOAmfy5MEJIO2jijaYaJevnBP3Fo/afDgfPYd9y+OyxUX?=
 =?us-ascii?Q?HbDlAQZqJ7F/+JvmX4bE6yWG8P+g+HxTmhkb8V7V+WXLKsp3KC1pzXPwNfQn?=
 =?us-ascii?Q?RJh0zi4cf68ETaITLP+XKI6pKARJS+N004SKsMTI64xhAImnDeyA3DwX685p?=
 =?us-ascii?Q?n+BGgvsUDTuwhuYjFXGaKLAAqzKgNbf+EGw6j/Ku/NeHYXYQp2xMy1EU5D70?=
 =?us-ascii?Q?n0iVijyXC/pmziTw2CVCJG1zWpxdm6BvqkwOSs/f2JG/1ZP1Yh+SJgojjPuz?=
 =?us-ascii?Q?Uct6q4cibbf/7BMY7wjyGxuNNGxmrK7/mw69L94YVUZAkLXjc19azsDpUPyD?=
 =?us-ascii?Q?xpXTe7Xl7ade4W78NamDtfiGfspQvQf3P6Zs2VUybCnvoJ6EC1Efj84CEVti?=
 =?us-ascii?Q?EWeqbWCs6d7kR5vForfMeyYESESHA0F+yp6EsZKKh62+t6+h1rckKJDm05hX?=
 =?us-ascii?Q?NnStaVB9pWSwmWIlp9NH/bt/kM4XVfpZjdL8qK7RAZ6i3fV7ee4QI379Fq8K?=
 =?us-ascii?Q?vBvWmXZbm8ySbH+DJbF5lOwlBqhZ02ZaEXXl8E6dtvIrDFN1kstW58gma0Bu?=
 =?us-ascii?Q?zCqL0yKn9oZJQlyd/LMg83TsgxFURnLa4l9kPMmnrk9hlmj5NrSexJ+2+HrA?=
 =?us-ascii?Q?XE2D0KVB6Ankk6uDluGwdNesMOLNNpWb14EqLY+au588ny0v5w6IWGKAkmG6?=
 =?us-ascii?Q?xpECFEr8jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4707a43-7a19-48a4-73ea-08dec31d90a2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5239.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:14:48.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n3neX30xOTsKSGQlufPiPpHOxN4ndMNMlUHojmkprgcLWGfoU885BM63s0zDeAhMyw8Oi+2BxRqfrTJfCHeHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9225
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
	TAGGED_FROM(0.00)[bounces-37442-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,dolcini.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E528649C17

Add a new section to the MAINTAINERS file for the nxpwifi driver,
including primary maintainer, reviewers, mailing list, and file path
patterns. This ensures proper tracking, patch routing, and community
visibility for the NXP Wi-Fi SDIO driver.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 142a91386338..55be8e5ce3cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19329,6 +19329,13 @@ S:	Maintained
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


