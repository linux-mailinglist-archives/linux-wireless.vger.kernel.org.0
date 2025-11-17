Return-Path: <linux-wireless+bounces-29046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E077BC63BB4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 12:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81143B68EF
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A11B32ABC0;
	Mon, 17 Nov 2025 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CaMp2KjE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432243314CB;
	Mon, 17 Nov 2025 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377385; cv=fail; b=rppAA9m4r+4rq7nilcezrfQ1Z8yQ5SoCHJJdRkubVi6BWe+0friZ5svmFB17Ev/ti/xhvuCpqhxO79I6O+HUiw6VFBWO0jHjT4LqCzcOBzwH+SuZvNDcMpEQ4PMFSlKt6cJdlnSgYuqJOZkZbl7vrbExCLUBBkazMSnfTJUwRHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377385; c=relaxed/simple;
	bh=g2XE+wxxFZRvu6myM1ZvWxxuh3JpvLdkadd1iR7yLWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6tFEgtuJpZR4cAECcYl28BPK+8/Dg2ZjqL0xJ/Yg40L7CdPxNENXX1aLIxgzVgUR+nsfqBh15r5ZgZG7U3R7NEAIElSomTpRnoAqOH7BWp6De2oebdfE08SCCBCBVKgUz6B7J7IC1Q+ty/5gbPyCDEwsdtqRb4LF2VQJ6qXv+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CaMp2KjE; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0FAGik3eO7eA44S6ZGeMX8W62XyAj56m3g9TGPSy3KQ/eadO/jsbFmoRWWpJJ7lYWX+JAxbGI6XGqeS3oAsLuPxs+PCnCnw93/Yd6Oeyjb3nbT3XNI1zobvCj1XLrihvHemFgQjk5UHJBQ1sork5lonxydOiCx3GJhiA5GmNbICW/bFMTgX2tbNWKLolvbk9teEMa6wlqQaAuNBIanD5hsV6QZAQfqfq7MKYM12XC6nIeCk/6fXb5QYw46xaXjL4iuH2H8+1+rLAs/+IU5r+y0uvh7FRmjGl8EA9ehoKvO7L6K0dD8iqt65KD1540XogLSzE4awuuXwGrhwLJ62Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhBdHnQWbDx1WlVXBOlK29NHAnMSemNwQ+bUXyKtB2U=;
 b=O4tw2LpJneDXzsuady7rbJ2tBgFw1o1lHdR7eJEIGzyb8g0/JnNEQxCKpp9yUTME6XsP5C7xSnLMPs0HmvGlo5DPFKMeVXRu/ocpIHVhpsP4GOZwyRQT6ToNGW8KaE9ICrLjRjm5wDT7ngTGOpePwwvQnC2WUeUGT+JU/8CMAqLwnrJwgA+PYCLGEhyrYfdUn/zfur/6kRNwC0HmJW49TRZ5HudOx/kwm/S5MEQQ4BkXLvNr/5UTR6vZwNghqddQBk1Vu086VjPsKNq0M1NOgVBg3P8lMdK6IOKSeR1IKx5D/yYb9f6k6CoaMFLiZwzu2D+yGuJjMPEpvjzgaZVuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhBdHnQWbDx1WlVXBOlK29NHAnMSemNwQ+bUXyKtB2U=;
 b=CaMp2KjEzSWmNaEoTM08FuYp5bGR99MBqAFyIvcQDQpw4IqtieUGgga4SSpL4Jdix7nM/ZO9FyThSqEFNMHddlM6IvLUIPNVP/tdH9F13hOMIMegDfZb/Q7h8K8dwZUot8HprZyWGGgQG5EJvIPca0tkuQaKPjWL0ebfzuZg1UqE3iJLpx6qr+M6DGIl4uwymYJOKSpwmpwsIvij28al9cwCbtC21PUd877Jk0B5DrQZD4ORxCEqVUKEf3s4MZ4CwvEZfmT85Krh17lUPKn8RTePPBENWujWJNw0e8HQH6hEyxmKRpz2w2YeYWAYY5Rh2/yOGvTuP1jW/vSuDkDwwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by GV4PR04MB11852.eurprd04.prod.outlook.com (2603:10a6:150:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:03:00 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 11:03:00 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v7 22/22] wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver
Date: Mon, 17 Nov 2025 19:00:46 +0800
Message-Id: <20251117110046.2810811-23-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
References: <20251117110046.2810811-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::8) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|GV4PR04MB11852:EE_
X-MS-Office365-Filtering-Correlation-Id: 05515202-bfc6-4606-83f3-08de25c8df42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWXBlEfDNZThsqgp/GXkG1hQJ0DE+i4wxrgar/ryRm3ukTvxyR2Q5BiAMhPQ?=
 =?us-ascii?Q?Vb/liwhvPnT8bPyv5rXQm8AU1dUV0dggzuQw3tTLHldA8nFGI6wnIMhYzqC+?=
 =?us-ascii?Q?TuxSbbLnClTuRj1Y+KLhHbcCG0l4on0z4LT9Ul1yMHy3Dvx3VlDjDQRgG785?=
 =?us-ascii?Q?rLNOP6QEzfnaIpdPSRAovxUB/c1KJmNV5hmHBxvVT+ZB5EXbWOI9h4Kpb2nz?=
 =?us-ascii?Q?+SYO6nSaFvyFOkjl1yJBrT065HSSnKqPhQdpCf9+Uj+XQn/ZnYNBcB4I/pAf?=
 =?us-ascii?Q?oE1tzcKRtzbrTWx6rBVtWsMpZM5i4bEEeIjnDdhaH7UXMGu+dEljQq3/CoDY?=
 =?us-ascii?Q?3bvAh6zOg8HTMx6AxFNltcJ3fGZA/1/3akKwz/mHtFRwVz5Ljkj1Gnf4xBrO?=
 =?us-ascii?Q?MoKny1/MtnVsCooEoI2nfZGsaEfnrdtonicEPBlImGP4Ls+IqEgJmb7o+OFo?=
 =?us-ascii?Q?88WMR8gdjDHtSzqGITnEDP+47jqX+gKEcUtHOUudxwhBg5rirMAVeI5Y5YDJ?=
 =?us-ascii?Q?QiL/LCHcwdzOgY9Ah2pXOWAkaGiWUEkQ9PJ+w2OZxtVJxdzA2ZO7JalIC7sC?=
 =?us-ascii?Q?OxXP59U6VybpEwGetrcV86QBuq6zP+9FzlbRUg+UUKZ+O4IrJVJZDyYSk++8?=
 =?us-ascii?Q?RoP4Or+ZJpIrThstFIXZRMg7ZlJatWhaHPaRwdJU+qqCetudqDngeRmx0WKg?=
 =?us-ascii?Q?AXROEmFCyenOAhq4GVnvUI413GMVsgQKHapADfC8NBFSZHXAP0PhTn3b38WH?=
 =?us-ascii?Q?YHMB/SunbztcZy1Iwj+Te6j790kRj3SiG0m6ET/fq2Nt7tPXaxI7wxkfRVzd?=
 =?us-ascii?Q?bwgrHkuO2R7WnZcUBkHiWpSesWKJKHJUfRi1ZHY5mc1QpyhY8fbZ/hNY6lmI?=
 =?us-ascii?Q?mYanR536b8JK1uwyS5juXCsLhANkf0JWPCZPAwuAW6ShtnCspMdVRnbmCbGl?=
 =?us-ascii?Q?tO5mrudi3TqZvzLHPP5gBL/9wE+MVwwVA47NY8G+Bjs3npeFSMBwPICPGeLc?=
 =?us-ascii?Q?3frerwd00qijU41U9DIEcu7rz37zyNHtfT7/TOkB0LqR7qStQPPxsTgxtCex?=
 =?us-ascii?Q?eoQb6BYmd1rQ2AGVak5xtBDfE52GRMm/B2DRgbbVs4eOLUE4iYRbKgHfKd6C?=
 =?us-ascii?Q?DT80Sg+0yg2TvhYqMVNEamwwUZCvAfOLrqeotTrKjAZa+zXQIjMJ1ZO7wZyH?=
 =?us-ascii?Q?dbu9BnIW+Mdy2D86LTbGeTLTonc2Qi5fIjld23W7ELh1zYnx9bkiC9Ldmtqv?=
 =?us-ascii?Q?3sDpxaEZa0rkVOhHr7a1mBxP+Wi6D59+zaha3TM7WF9aXdE1pUydX2H+QIpR?=
 =?us-ascii?Q?Qfq14Q0XkR3I+3LCx1s51aEmx6KtGu3tYJZbajzig17rPAG4ODikt12AHI/0?=
 =?us-ascii?Q?GYY29l8XodUglvbi1z18NBMpJD5H5pm7VU29RNUWul6mIBDNC8SXitXPSW9Q?=
 =?us-ascii?Q?HNPcDF+9+xHYP9kaoJdxqPBnhkz10bjhsxnS95/hMxqQhHlU2hXUvjCahicK?=
 =?us-ascii?Q?uk9EWPbofW96yXtzhq50xrhQEw04eRUO0GM2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3hcaYsoTiqDgyclOAM3SFVBhe/MoVSExFqrtRliZaG0d+jpF9SwTZGxuB/Vo?=
 =?us-ascii?Q?6cyikz+CYk11kLlWrc3hYinC50+mkR9GvuKsXax8xBnkWwPFv7QA1ZoTrQGH?=
 =?us-ascii?Q?Pd/Sbjn6z283s3MfU3FVTqnGiTkaOzu2e925nN20+WnWSiuDO3WvdwENLIhe?=
 =?us-ascii?Q?uUUN5j7uYjGJ0meXYOkGCkimJ0SeQSgxN8k5t5wkn4wfa0E9gOeYE7Ey8P2v?=
 =?us-ascii?Q?jznBUVjwNgPHIaBKTl8IZ8PPkJX+2UvcH2lC7kbSkuxkNvSlqMIj61mZTsOd?=
 =?us-ascii?Q?6htR8m3bZNlclvvQ+x8y5680zascFgKuVuko3tHtp3Ai5ZiggA1Tgm+hGJps?=
 =?us-ascii?Q?l5IHyVOYLr0s1TrNtKBIK+hwmVjc+DmSbHcf1Ift1b+MywsEe0AEpzOzfPq8?=
 =?us-ascii?Q?RYExBgAUHl7veMkhkSijYMHXK0QKeBsXulQZ2ribuxXM0Js8n2uOXxLd/UBY?=
 =?us-ascii?Q?iWcWuzq6TNnvcMRLMMzfSOiwQ97iiVfdMXxTgZ33TV/bBlertSZA57bGP3u1?=
 =?us-ascii?Q?gQ6UNBt89EjZjZqBf2VVXQwVNmD7wxOqdC+BRuYLtxLVkxC7VFl6jZPRUImL?=
 =?us-ascii?Q?+MvE3/o9/NPSlre89Aoj4jcfM/BOxCIPRIjk2WKIuA/Y/vTs7gxxohHCas/x?=
 =?us-ascii?Q?BFNCTShnxOFrNRDfXpHyHOE0Kae36s88Bu353XrsVTH/isHAGpTwfgzO0geZ?=
 =?us-ascii?Q?BnnH/owfuoXL9ZkGMIwdUQcg+Hb1fu42oOC4rUpJ3TN96ejDXgZKZmtyl6SK?=
 =?us-ascii?Q?s9re2R6X8MVLcHi36WayC/HHJZg7op3n53/oP2Pvap2EyBgatd3n76jCtSBA?=
 =?us-ascii?Q?OjWa0TAdSKhX7GNray1Ml2FQDYCerYTKF3JDnaqHVYTRLbnlygOS1Of7lctu?=
 =?us-ascii?Q?plxanvcCH5g0AI2h7drtI6cGZDIQSVw26blVtqdSb8VoeBcr91IQHCtNgeaw?=
 =?us-ascii?Q?o7/dLSSHAOEOKsr3ZyoOQhBwfahuBB/Z3rQuNVqTGHfoigCOgoRivOWAKYQl?=
 =?us-ascii?Q?zj0mSCp6zfSVPC+sLxIXP4muBBugGIAn35Mz036XmP4C3nf41t8EHq+BD+9Z?=
 =?us-ascii?Q?pal2dQULdA5JIIcczkA91Y65P4qb6Szny4Ylyx0pCSUmozsRTIOWVFWQ8fcR?=
 =?us-ascii?Q?FtiLPYmemQJ+vTlnc5wkFA+mYjdA0oKa92H1eLdffxS9YAo0+RAd1FPmL7Bd?=
 =?us-ascii?Q?iCSZE0dMhxHrvOH2EDtUe67/c3tik9cHk//yHIT4G6SdKoiJO3dAVOU0GkF+?=
 =?us-ascii?Q?E/+cQ0TUjGM+/8eLhw/y9u5Gl2i3LYeIChDBQ4dADwFnIVdR/wvRxNzee6y9?=
 =?us-ascii?Q?90G/Y95bRbPDH/Kfx2EFVrjs5cwXdt5bSBB7g5CVx/KqRmCvJVuq9XEuiJYm?=
 =?us-ascii?Q?oAB/IM/YFKvZHwsfKuBt1QvHCEr3eA0c57u5bGmv5jyni9vtbdvIcZZMiQh+?=
 =?us-ascii?Q?5hURUnoBdF7RBAu1xlJ5vE65sIt8FIarYDUa2Ts4rtgzCrjA732xXT7pW6hs?=
 =?us-ascii?Q?xX+trhfy3kPKvQiQA7yqHgF4rNjo9G2aEE+bGFjPUXCS6CBONrgKo8ZkjD/w?=
 =?us-ascii?Q?r/uViITZPhnX+vS49STzJcfMsiCTRfsKagwz5a47?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05515202-bfc6-4606-83f3-08de25c8df42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:03:00.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emeyA06aXIdcI/Io6wkE5MsKk/K1AXQtMzJCeJamOoYYK0snZ7DrmeKogWsXtOMzMiO3f/kcUqgC33FyS8s7yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11852

Add a new section to the MAINTAINERS file for the nxpwifi driver,
including primary maintainer, reviewers, mailing list, and file path
patterns. This ensures proper tracking, patch routing, and community
visibility for the NXP Wi-Fi SDIO driver.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37f4278db851..9a88b54ce04a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18654,6 +18654,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
 F:	drivers/regulator/pf530x-regulator.c
 
+NXP NXPWIFI WIRELESS DRIVER
+M:     Jeff Chen <jeff.chen_1@nxp.com>
+R:     Francesco Dolcini <francesco@dolcini.it>
+R:     Pete Hsieh <tsung-hsien.hsieh@nxp.com>
+L:     linux-wireless@vger.kernel.org
+S:     Maintained
+F:     drivers/net/wireless/nxp/nxpwifi
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


