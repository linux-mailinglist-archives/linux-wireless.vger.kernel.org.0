Return-Path: <linux-wireless+bounces-9973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A5926E11
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 05:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B6F1F228F5
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 03:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856418049;
	Thu,  4 Jul 2024 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cPvuLf62"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7E1DA32D;
	Thu,  4 Jul 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720063837; cv=fail; b=kJoWD0HgE0pJQ7O9LgsRg4436fcrtRRORlQ3zw3zy0qQYhp2QGM/UwTrID2TroR2YbFQRik2QIVWwDXJaPTou7e6mIsKUqnysbiRaZDfi0yHEp8GzRzRrfEvGgjUB9qayLRrskX3tO7YsyrfBi7+brhySFU4DXQCNFUQxAtT6hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720063837; c=relaxed/simple;
	bh=Cm1Q17yCqaFiwUH+/WYKdHoNs7l8vzBf90dHJjsPmPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XSl1leBjJuQEq0wUpjhVX8lh76TcVsqeIMR3f8Gq5oP2div0oMsGdGS5mnU68UXF0Sfpjc1lbQxcALPitaR5Nf3RSlwtpm2oG/Q6c8enpOEPuDmDgRY0fJ5H3pRw7Cf/Gjc3CpdvhqOILb7Vekz/N421/1Z0OyFE1FkrSjYHtUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cPvuLf62; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UowcIh/vVV5cIpQSGAgCS7XlG9cZoWHEpIy3RXsj2WlK6/yL2Bx3kpQ4ACgDgm7EF8smyIzswpPWc0Qr320zCsrUcyTYzPQPdHKlWWjISXOsP4KgmgGZolr5PQ3tWsO9cp+MHgKTIEeqqU5wKBAcM+ynQkz2N1YuJJErEDZLNGLbvkdWcdYet4uiTUc8kTUhRIeQc/tAp69EI9R9qvk0KXAleia9+Bc6CQ74XDS5kQHoouKny0oax5zMpqOx08MJOpUIpCeSG3IOS5SzXHs4B9Ip1CDc0ZbTO9FW4aB+Ed3omkYxCGWSRxPMmLrqt5avX1c9u2yjgzrlZq9xoQcHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfuDDTIdZV2fiQ3T57g7zrjwgtNl/xNJTUGjc0SCs4Y=;
 b=Tl5Nmq7YPM2oiKGYgLCGSQVvxzP6ZX4oT9HWEvn1b6Bt0QgjIZZnUCY85WtZXg6UwXXEgYOtuSMPEeG9jZWCUuEXZfXYe4aah2d6SiU5rqzalpa/KnGcYOlXNllO3p3elqYsqdT0lUzku/pmGsiYM7XnnlNQkMx5eqEMF6HYhk6iUT/jKq68ql3w5yIQDfVyQ6Bhc1x9oxwGVdj3C64sbtKZBLUru0UQmvdqw5LhA+mzImv7h5E6duQUtGhs0Io/kRJ6y30OHVIC18p7VwFzuF2ua6KMZnqzZh+fyaOt2Au1wGN4RjpjoD7RTGGbMT8VDv3PhJfIy/3XZN9D7gQcdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfuDDTIdZV2fiQ3T57g7zrjwgtNl/xNJTUGjc0SCs4Y=;
 b=cPvuLf62r/C7iHuwJuUisBrg9twH3HqMKaXwPqOITbK165W919pjh4OJnb8cvB1YTPXh1HPukoM5dq6mN8tL89HZefVG/U3XixLt/5K6vYBMni45qvgNa6kVRVJJ2225+aL1GOLUJHCFqf/vgIaW99d8nXC8/ihyg7qqdD3mTKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 4 Jul
 2024 03:30:30 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7719.036; Thu, 4 Jul 2024
 03:30:30 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v11 1/2] wifi: mwifiex: add host mlme for client mode
Date: Thu,  4 Jul 2024 11:30:00 +0800
Message-Id: <20240704033001.603419-2-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f1f08fc-3a1b-4cef-aa82-08dc9bd9a781
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?7Cc5wptXqRuyAoEVkMY15lOPqbNKwYafarYs2qwTsUL/BoKQne/5WObZfy/J?=
 =?us-ascii?Q?w9GniSQsw1g9188X9R6pceQg9/tGzrk+Y8Yhdplwxn+7dPBmWiL2h52/prMM?=
 =?us-ascii?Q?oMRVpimWGgN0dCT/cyGKjPwGxu+SbiEUYxLycabgfhbHUMOQujzRDpPX5Mjx?=
 =?us-ascii?Q?xAjSCZyRVZ4+FPK9IR0D7X0QFHicO3IQH6ACpro7A8yquOY1kOz4KAvHZThD?=
 =?us-ascii?Q?E7JUe5jwLIwRQd1SVKKaSLda0ipcK+nXeOA3WTBiPSNH8Ed5hGgQm/q72NM9?=
 =?us-ascii?Q?eMhFmylFMfHeNrH0klb/jUwrZzmbocLGLhd7qZmPsJtOs3AWDGRCfdMv3BPM?=
 =?us-ascii?Q?NLQ+YqllB1uwvpUxnL0b0JSJ906EKGt7j9Xw4sXvhZoh7l8G5Vj4FMLHi11z?=
 =?us-ascii?Q?G+StjuCTKojqbmBqSGCPj7+J/Gtxa/+bJxJbZT8hZGZ078CrpSffWdREdZzP?=
 =?us-ascii?Q?PIwcGvRTLK3zNfBrvWz3Duw7kJNgrSlOd1mN0hr0MhTbKeq9L/tZ39IJicaF?=
 =?us-ascii?Q?Jzx+GcYirSTCvCDdKROkopjPSpzt3rdfGorihUcu226srIU/CaYag2yGBcZw?=
 =?us-ascii?Q?UajHabtOcNYat1FZ91qhhWwbhRq+doYujQAHDFjznRPkYms50nDgJBq9H/aw?=
 =?us-ascii?Q?GuUVPZonDhHUAegWaacF93fLGESZ3/G9Mryh9/qf3BrHbDyFE6HtgYSrtJzA?=
 =?us-ascii?Q?OaKRbky0tTl8/v7grUYOqQVs7e7KlWJqetk2PwixFwVy8C+pBqqSLza4dEhT?=
 =?us-ascii?Q?by99lC2DJFwm7xqTQRAO+2uwyUXqB/fcl9TMo3SEtfwSoikuI/wDb9HSZyGP?=
 =?us-ascii?Q?5lzhtC7hwnlxa/rAlAwSgM8F7fDB9F9vjOnV+G6IYDLucOPLBBfB0KFj0oaz?=
 =?us-ascii?Q?+WIJS8WPGbjAV+tEkcSpkxPoynYwmzAiKTnCyqd85W+ArkC5CvCwgYbMw/uf?=
 =?us-ascii?Q?P5FLjAuD8xEwyeQdj6Hpt9dif2jbXbqFpxh3dPKzEzhsL+u3BAQPcPXvPhHN?=
 =?us-ascii?Q?GNrdPSiYZbRgE5iUVbv/Gd09dbmbt1+laXhm637NIZj+QfqpbF2gAJ0NMtzp?=
 =?us-ascii?Q?k1RzetRD9chqt6GCt1skllCYJeKhbLGCID+pMpexzo7po5i5UNcBP/p64vlI?=
 =?us-ascii?Q?aYa/ThmRy1In2UovY3HrMM1MU0HQfAJYRNCFBl3Hz37UFHiacBMAe8gAPq8Y?=
 =?us-ascii?Q?onp2GYfq2KmPZXP92Czx1KcLvtrp+s5xTBq3XrN03tieeRzijOpPZAZZ7rvh?=
 =?us-ascii?Q?oWw5t1kKOAiDaTsWNkxwyn0iIYbelgGfK3X757EXYb4aGdwJbTV9xFuOtabs?=
 =?us-ascii?Q?dyQLVDzvXpLATk6yKKq+sBF5vjXe1EPGJF2ZTtNZtrrk94MhvcszRJDqgwwy?=
 =?us-ascii?Q?fsahbm68UsQfVBgSHBdq3EppdgOS1wuxFOC0WjlnlwDHXStQbg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?4AMn72iYTihgqUK8oF5BP6+7FMhTFkuksowtaeOqaCIvoJOZIzg9mm+ofVzy?=
 =?us-ascii?Q?aOkhdh0JTtVVm9Nd9g/0Bj3I3DSdBXpLFAVmst4H88jdgkB5Un7E+2HPXJRo?=
 =?us-ascii?Q?CL9U53NlCJ/k7U3APzEEDwu7lG2ekwAVtgaKzv/L59LVxLpeIDJa0ovtWXQB?=
 =?us-ascii?Q?ZhwuPeMRHtInq4302AaR9xT7hZPhP94y/Ph3WQf2TSOCXSQkj+x6tFW4bWMG?=
 =?us-ascii?Q?ReTjZhuxJMJYvpWehBsS1999EZjrUeTih6YppwvZEKdqUDHVVlQaRagTbYz+?=
 =?us-ascii?Q?2lhvfTd0LhjOQN7CVSvOwWBBKN1a43OCG2weImHRpz7gtNCrN5lQq/4V/9ub?=
 =?us-ascii?Q?9E0czwn4ErQXbLim80MiWrvFIaw5/aYJWbUry5ejG2ariRXrYrphdIcaEHVq?=
 =?us-ascii?Q?3MM+sSXDcmOrugEuwlHJ+RSwr2iisNnDo/OqAjdBzjzopxis9xg04w/78eDN?=
 =?us-ascii?Q?o5FEzpt0ik7DCZoWA1S5hPfBdEFKYnJyXT+YRNRwhnblaYCAmlpGZ9ocZrnW?=
 =?us-ascii?Q?if7zgXJK7azjpvwNfR8Mv9ppRyapf92CG+Zjs/kQwkJFiN3F+T801F/8Bo7K?=
 =?us-ascii?Q?xxTnIccfohWU5vTQilkuRNmcWCQeC9Xii+rhAVfv76arBuA7wJWhNAszF4AM?=
 =?us-ascii?Q?mq0Ny4AygTmIqse6s6Ydx/RGiOT4Wxq6nQKsVZSiomM4+UV0HlwhGWxp7nK5?=
 =?us-ascii?Q?A+IOiB6ocB7Q0qmH/li0NO7sRYj7Ozhne+wS3iDmRGt5w3WVJyyW2lQtROqK?=
 =?us-ascii?Q?D3cfbV5pFLJmLN+Slrnr+et5S6vt/truQNElYmBjSrpUd+uDkHWeKGAzMDYK?=
 =?us-ascii?Q?CuRqqPhtXi5MVSU7y/FM4Ed66xJOHlEIiFgfVzYJ1K5kaPNMDkLpZoIfpkSm?=
 =?us-ascii?Q?6ThYk5wsplr0cJTEiG79WfZO7FZcAJOzemWJPbPSiz9FHAFchBPjoNdHduRE?=
 =?us-ascii?Q?qEntEZMRe7nmowiWDWRyZ+Ye1wr8zstOUH02JMMqJHcDZKHOLAJZQAsb5vNE?=
 =?us-ascii?Q?7ux0jIgu4FtKJ4kgucsrJsinzYhz9gnp9LyVhjhe6xF4JBRK5WZHR21ltYcG?=
 =?us-ascii?Q?x2acUjX3f9xx2piBucGnHQ9BHYwKurZ57BI1Ia537b1jtN9hOZxIP2bwEe7o?=
 =?us-ascii?Q?AkRlnAzerjhqpSaDLCLwubZkYciEIcP2zCl6Y85fZuMMV31ml+kNoErKIAIZ?=
 =?us-ascii?Q?WtxRr0Ko/TgdawQG8HEpxD1eEaGqGjTnzRJ4v0AE1zR+ohRAC9jooxBsgJzQ?=
 =?us-ascii?Q?l79O4dos3a14E4qnew2feUOg2OHAeS8Ss+ZORFzgM9+yy2AEjWcX1OAlDMpF?=
 =?us-ascii?Q?jfP73QgvbJLxdLCSeWxDe8+Sy37vIeSfM+qrb44jUcQUXYA48tJwre3gL9BC?=
 =?us-ascii?Q?5FFd/Os1FT5rw14XTbtgEqYds44RefMW4CdimyrCxkd2nbXa9Gt9lID41aVu?=
 =?us-ascii?Q?CWxPjP0vtULwUPZU5YtNOhCCu0YJ1DKVO4clI3VyjhXUF46F60ykSnsIlssg?=
 =?us-ascii?Q?pvNiwNGZ/SzGnA8P2kKCdvvaGMvmF61ZvaPXLUNTaC3j0BhikBq1ibzXoXtw?=
 =?us-ascii?Q?9z9p87zpEZkMY3q89cAiC4FWBM87L/bS30PuQVZP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1f08fc-3a1b-4cef-aa82-08dc9bd9a781
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 03:30:30.3216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeLsJQXDLulQ966XOJVhIgRAUp9Pz5AjYoW1PCe45Ybrn9iXV3EFrTdQYX6b+1PEq8f8v07lISWs6FlsbSMy0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7082

Add host based MLME to enable WPA3 functionalities in client mode.
This feature required a firmware with the corresponding V2 Key API
support. The feature (WPA3) is currently enabled and verified only
on IW416. Also, verified no regression with change when host MLME
is disabled.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Brian Norris <briannorris@chromium.org>
---

v11:
   - add proper and useful comment for mwifiex_cfg80211_probe_client().

v10:
   - use eth_broadcast_addr() to set the broadcast address.
   - add comment for constant used for the length of FW special 4 address
     management header.
   - check host_mlme_enabled to decide if creating host_mlme_workqueue
     or not.
   - use cpu_to_le16 instead of casting via (__force __le16).
   - change the abbreviation "disasso" to "disassoc" of the printout message.

v9:
   - remove redundent code.

v8:
   - first full and complete patch to support host based MLME for client
     mode.

---
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 318 ++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  25 ++
 drivers/net/wireless/marvell/mwifiex/decl.h   |  23 ++
 drivers/net/wireless/marvell/mwifiex/fw.h     |  33 ++
 drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  66 +++-
 drivers/net/wireless/marvell/mwifiex/main.c   |  62 ++++
 drivers/net/wireless/marvell/mwifiex/main.h   |  16 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   2 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
 drivers/net/wireless/marvell/mwifiex/util.c   |  80 +++++
 15 files changed, 683 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 155eb0fab12a..d3f7de13832d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -268,6 +268,8 @@ mwifiex_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
 
 	if (mask != priv->mgmt_frame_mask) {
 		priv->mgmt_frame_mask = mask;
+		if (priv->host_mlme_reg)
+			priv->mgmt_frame_mask |= HOST_MLME_MGMT_MASK;
 		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 				 HostCmd_ACT_GEN_SET, 0,
 				 &priv->mgmt_frame_mask, false);
@@ -848,6 +850,7 @@ static int mwifiex_deinit_priv_params(struct mwifiex_private *priv)
 	struct mwifiex_adapter *adapter = priv->adapter;
 	unsigned long flags;
 
+	priv->host_mlme_reg = false;
 	priv->mgmt_frame_mask = 0;
 	if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
 			     HostCmd_ACT_GEN_SET, 0,
@@ -3633,6 +3636,9 @@ static int mwifiex_set_rekey_data(struct wiphy *wiphy, struct net_device *dev,
 	if (!ISSUPP_FIRMWARE_SUPPLICANT(priv->adapter->fw_cap_info))
 		return -EOPNOTSUPP;
 
+	if (priv->adapter->host_mlme_enabled)
+		return 0;
+
 	return mwifiex_send_cmd(priv, HostCmd_CMD_GTK_REKEY_OFFLOAD_CFG,
 				HostCmd_ACT_GEN_SET, 0, data, true);
 }
@@ -4206,6 +4212,305 @@ mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
+static int
+mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
+			      struct net_device *dev,
+			      struct cfg80211_auth_request *req)
+{
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter = priv->adapter;
+	struct sk_buff *skb;
+	u16 pkt_len, auth_alg;
+	int ret;
+	struct mwifiex_ieee80211_mgmt *mgmt;
+	struct mwifiex_txinfo *tx_info;
+	u32 tx_control = 0, pkt_type = PKT_TYPE_MGMT;
+	u8 trans = 1, status_code = 0;
+	u8 *varptr;
+
+	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
+		mwifiex_dbg(priv->adapter, ERROR, "Interface role is AP\n");
+		return -EFAULT;
+	}
+
+	if (priv->wdev.iftype != NL80211_IFTYPE_STATION) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "Interface type is not correct (type %d)\n",
+			    priv->wdev.iftype);
+		return -EINVAL;
+	}
+
+	if (priv->auth_alg != WLAN_AUTH_SAE &&
+	    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
+		mwifiex_dbg(priv->adapter, ERROR, "Pending auth on going\n");
+		return -EBUSY;
+	}
+
+	if (!priv->host_mlme_reg) {
+		priv->host_mlme_reg = true;
+		priv->mgmt_frame_mask |= HOST_MLME_MGMT_MASK;
+		mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
+				 HostCmd_ACT_GEN_SET, 0,
+				 &priv->mgmt_frame_mask, false);
+	}
+
+	switch (req->auth_type) {
+	case NL80211_AUTHTYPE_OPEN_SYSTEM:
+		auth_alg = WLAN_AUTH_OPEN;
+		break;
+	case NL80211_AUTHTYPE_SHARED_KEY:
+		auth_alg = WLAN_AUTH_SHARED_KEY;
+		break;
+	case NL80211_AUTHTYPE_FT:
+		auth_alg = WLAN_AUTH_FT;
+		break;
+	case NL80211_AUTHTYPE_NETWORK_EAP:
+		auth_alg = WLAN_AUTH_LEAP;
+		break;
+	case NL80211_AUTHTYPE_SAE:
+		auth_alg = WLAN_AUTH_SAE;
+		break;
+	default:
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "unsupported auth type=%d\n", req->auth_type);
+		return -EOPNOTSUPP;
+	}
+
+	if (!priv->auth_flag) {
+		ret = mwifiex_remain_on_chan_cfg(priv, HostCmd_ACT_GEN_SET,
+						 req->bss->channel,
+						 AUTH_TX_DEFAULT_WAIT_TIME);
+
+		if (!ret) {
+			priv->roc_cfg.cookie = get_random_u32() | 1;
+			priv->roc_cfg.chan = *req->bss->channel;
+		} else {
+			return -EFAULT;
+		}
+	}
+
+	priv->sec_info.authentication_mode = auth_alg;
+
+	mwifiex_cancel_scan(adapter);
+
+	pkt_len = (u16)req->ie_len + req->auth_data_len +
+		MWIFIEX_MGMT_HEADER_LEN + MWIFIEX_AUTH_BODY_LEN;
+	if (req->auth_data_len >= 4)
+		pkt_len -= 4;
+
+	skb = dev_alloc_skb(MWIFIEX_MIN_DATA_HEADER_LEN +
+			    MWIFIEX_MGMT_FRAME_HEADER_SIZE +
+			    pkt_len + sizeof(pkt_len));
+	if (!skb) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "allocate skb failed for management frame\n");
+		return -ENOMEM;
+	}
+
+	tx_info = MWIFIEX_SKB_TXCB(skb);
+	memset(tx_info, 0, sizeof(*tx_info));
+	tx_info->bss_num = priv->bss_num;
+	tx_info->bss_type = priv->bss_type;
+	tx_info->pkt_len = pkt_len;
+
+	skb_reserve(skb, MWIFIEX_MIN_DATA_HEADER_LEN +
+		    MWIFIEX_MGMT_FRAME_HEADER_SIZE + sizeof(pkt_len));
+	memcpy(skb_push(skb, sizeof(pkt_len)), &pkt_len, sizeof(pkt_len));
+	memcpy(skb_push(skb, sizeof(tx_control)),
+	       &tx_control, sizeof(tx_control));
+	memcpy(skb_push(skb, sizeof(pkt_type)), &pkt_type, sizeof(pkt_type));
+
+	mgmt = (struct mwifiex_ieee80211_mgmt *)skb_put(skb, pkt_len);
+	memset(mgmt, 0, pkt_len);
+	mgmt->frame_control =
+		cpu_to_le16(IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_AUTH);
+	memcpy(mgmt->da, req->bss->bssid, ETH_ALEN);
+	memcpy(mgmt->sa, priv->curr_addr, ETH_ALEN);
+	memcpy(mgmt->bssid, req->bss->bssid, ETH_ALEN);
+	eth_broadcast_addr(mgmt->addr4);
+
+	if (req->auth_data_len >= 4) {
+		if (req->auth_type == NL80211_AUTHTYPE_SAE) {
+			__le16 *pos = (__le16 *)req->auth_data;
+
+			trans = le16_to_cpu(pos[0]);
+			status_code = le16_to_cpu(pos[1]);
+		}
+		memcpy((u8 *)(&mgmt->auth.variable), req->auth_data + 4,
+		       req->auth_data_len - 4);
+		varptr = (u8 *)&mgmt->auth.variable +
+			 (req->auth_data_len - 4);
+	}
+
+	mgmt->auth.auth_alg = cpu_to_le16(auth_alg);
+	mgmt->auth.auth_transaction = cpu_to_le16(trans);
+	mgmt->auth.status_code = cpu_to_le16(status_code);
+
+	if (req->ie && req->ie_len) {
+		if (!varptr)
+			varptr = (u8 *)&mgmt->auth.variable;
+		memcpy((u8 *)varptr, req->ie, req->ie_len);
+	}
+
+	priv->auth_flag = HOST_MLME_AUTH_PENDING;
+	priv->auth_alg = auth_alg;
+
+	skb->priority = WMM_HIGHEST_PRIORITY;
+	__net_timestamp(skb);
+
+	mwifiex_dbg(priv->adapter, MSG,
+		    "auth: send authentication to %pM\n", req->bss->bssid);
+
+	mwifiex_queue_tx_pkt(priv, skb);
+
+	return 0;
+}
+
+static int
+mwifiex_cfg80211_associate(struct wiphy *wiphy, struct net_device *dev,
+			   struct cfg80211_assoc_request *req)
+{
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_adapter *adapter = priv->adapter;
+	int ret;
+	struct cfg80211_ssid req_ssid;
+	const u8 *ssid_ie;
+
+	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_STA) {
+		mwifiex_dbg(adapter, ERROR,
+			    "%s: reject infra assoc request in non-STA role\n",
+			    dev->name);
+		return -EINVAL;
+	}
+
+	if (test_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags) ||
+	    test_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "%s: Ignore association.\t"
+			    "Card removed or FW in bad state\n",
+			    dev->name);
+		return -EFAULT;
+	}
+
+	if (priv->auth_alg == WLAN_AUTH_SAE)
+		priv->auth_flag = HOST_MLME_AUTH_DONE;
+
+	if (priv->auth_flag && !(priv->auth_flag & HOST_MLME_AUTH_DONE))
+		return -EBUSY;
+
+	if (priv->roc_cfg.cookie) {
+		ret = mwifiex_remain_on_chan_cfg(priv, HostCmd_ACT_GEN_REMOVE,
+						 &priv->roc_cfg.chan, 0);
+		if (!ret)
+			memset(&priv->roc_cfg, 0,
+			       sizeof(struct mwifiex_roc_cfg));
+		else
+			return -EFAULT;
+	}
+
+	if (!mwifiex_stop_bg_scan(priv))
+		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
+
+	memset(&req_ssid, 0, sizeof(struct cfg80211_ssid));
+	rcu_read_lock();
+	ssid_ie = ieee80211_bss_get_ie(req->bss, WLAN_EID_SSID);
+
+	if (!ssid_ie)
+		goto ssid_err;
+
+	req_ssid.ssid_len = ssid_ie[1];
+	if (req_ssid.ssid_len > IEEE80211_MAX_SSID_LEN) {
+		mwifiex_dbg(adapter, ERROR, "invalid SSID - aborting\n");
+		goto ssid_err;
+	}
+
+	memcpy(req_ssid.ssid, ssid_ie + 2, req_ssid.ssid_len);
+	if (!req_ssid.ssid_len || req_ssid.ssid[0] < 0x20) {
+		mwifiex_dbg(adapter, ERROR, "invalid SSID - aborting\n");
+		goto ssid_err;
+	}
+	rcu_read_unlock();
+
+	/* As this is new association, clear locally stored
+	 * keys and security related flags
+	 */
+	priv->sec_info.wpa_enabled = false;
+	priv->sec_info.wpa2_enabled = false;
+	priv->wep_key_curr_index = 0;
+	priv->sec_info.encryption_mode = 0;
+	priv->sec_info.is_authtype_auto = 0;
+	if (mwifiex_set_encode(priv, NULL, NULL, 0, 0, NULL, 1)) {
+		mwifiex_dbg(priv->adapter, ERROR, "deleting the crypto keys\n");
+		return -EFAULT;
+	}
+
+	if (req->crypto.n_ciphers_pairwise)
+		priv->sec_info.encryption_mode =
+			req->crypto.ciphers_pairwise[0];
+
+	if (req->crypto.cipher_group)
+		priv->sec_info.encryption_mode = req->crypto.cipher_group;
+
+	if (req->ie)
+		mwifiex_set_gen_ie(priv, req->ie, req->ie_len);
+
+	memcpy(priv->cfg_bssid, req->bss->bssid, ETH_ALEN);
+
+	mwifiex_dbg(adapter, MSG,
+		    "assoc: send association to %pM\n", req->bss->bssid);
+
+	cfg80211_ref_bss(adapter->wiphy, req->bss);
+	ret = mwifiex_bss_start(priv, req->bss, &req_ssid);
+	if (ret) {
+		priv->auth_flag = 0;
+		priv->auth_alg = WLAN_AUTH_NONE;
+		eth_zero_addr(priv->cfg_bssid);
+	}
+
+	if (priv->assoc_rsp_size) {
+		priv->req_bss = req->bss;
+		adapter->assoc_resp_received = true;
+		queue_work(adapter->host_mlme_workqueue,
+			   &adapter->host_mlme_work);
+	}
+
+	cfg80211_put_bss(priv->adapter->wiphy, req->bss);
+
+	return 0;
+
+ssid_err:
+	rcu_read_unlock();
+	return -EFAULT;
+}
+
+static int
+mwifiex_cfg80211_deauthenticate(struct wiphy *wiphy,
+				struct net_device *dev,
+				struct cfg80211_deauth_request *req)
+{
+	return mwifiex_cfg80211_disconnect(wiphy, dev, req->reason_code);
+}
+
+static int
+mwifiex_cfg80211_disassociate(struct wiphy *wiphy,
+			      struct net_device *dev,
+			      struct cfg80211_disassoc_request *req)
+{
+	return mwifiex_cfg80211_disconnect(wiphy, dev, req->reason_code);
+}
+
+static int
+mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
+			      struct net_device *dev, const u8 *peer,
+			      u64 *cookie)
+{
+	/* hostapd looks for NL80211_CMD_PROBE_CLIENT support; otherwise,
+	 * it requires monitor-mode support (which mwifiex doesn't support).
+	 * Provide fake probe_client support to work around this.
+	 */
+	return -EOPNOTSUPP;
+}
+
 /* station cfg80211 operations */
 static struct cfg80211_ops mwifiex_cfg80211_ops = {
 	.add_virtual_intf = mwifiex_add_virtual_intf,
@@ -4351,6 +4656,16 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			    "%s: creating new wiphy\n", __func__);
 		return -ENOMEM;
 	}
+	if (adapter->host_mlme_enabled) {
+		mwifiex_cfg80211_ops.auth = mwifiex_cfg80211_authenticate;
+		mwifiex_cfg80211_ops.assoc = mwifiex_cfg80211_associate;
+		mwifiex_cfg80211_ops.deauth = mwifiex_cfg80211_deauthenticate;
+		mwifiex_cfg80211_ops.disassoc = mwifiex_cfg80211_disassociate;
+		mwifiex_cfg80211_ops.disconnect = NULL;
+		mwifiex_cfg80211_ops.connect = NULL;
+		mwifiex_cfg80211_ops.probe_client =
+			mwifiex_cfg80211_probe_client;
+	}
 	wiphy->max_scan_ssids = MWIFIEX_MAX_SSID_LIST_LENGTH;
 	wiphy->max_scan_ie_len = MWIFIEX_MAX_VSIE_LEN;
 	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
@@ -4432,6 +4747,9 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
 			   NL80211_FEATURE_NEED_OBSS_SCAN;
 
+	if (adapter->host_mlme_enabled)
+		wiphy->features |= NL80211_FEATURE_SAE;
+
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->features |= NL80211_FEATURE_HT_IBSS;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 9eff29a25544..da983e27023c 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -924,6 +924,24 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 	return ret;
 }
 
+void mwifiex_process_assoc_resp(struct mwifiex_adapter *adapter)
+{
+	struct cfg80211_rx_assoc_resp_data assoc_resp = {
+		.uapsd_queues = -1,
+	};
+	struct mwifiex_private *priv =
+		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA);
+
+	if (priv->assoc_rsp_size) {
+		assoc_resp.links[0].bss = priv->req_bss;
+		assoc_resp.buf = priv->assoc_rsp_buf;
+		assoc_resp.len = priv->assoc_rsp_size;
+		cfg80211_rx_assoc_resp(priv->netdev,
+				       &assoc_resp);
+		priv->assoc_rsp_size = 0;
+	}
+}
+
 /*
  * This function handles the timeout of command sending.
  *
@@ -1672,6 +1690,13 @@ int mwifiex_ret_get_hw_spec(struct mwifiex_private *priv,
 	if (adapter->fw_api_ver == MWIFIEX_FW_V15)
 		adapter->scan_chan_gap_enabled = true;
 
+	if (adapter->key_api_major_ver != KEY_API_VER_MAJOR_V2)
+		adapter->host_mlme_enabled = false;
+
+	mwifiex_dbg(adapter, MSG, "host_mlme: %s, key_api: %d\n",
+		    adapter->host_mlme_enabled ? "enable" : "disable",
+		    adapter->key_api_major_ver);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index 326ffb05d791..84603f1e7f6e 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -31,6 +31,29 @@
 						 *   + sizeof(tx_control)
 						 */
 
+#define FRMCTL_LEN                2
+#define DURATION_LEN              2
+#define SEQCTL_LEN                2
+/* special FW 4 address management header */
+#define MWIFIEX_MGMT_HEADER_LEN   (FRMCTL_LEN + DURATION_LEN + ETH_ALEN + \
+				   ETH_ALEN + ETH_ALEN + SEQCTL_LEN + ETH_ALEN)
+
+#define AUTH_ALG_LEN              2
+#define AUTH_TRANSACTION_LEN      2
+#define AUTH_STATUS_LEN           2
+#define MWIFIEX_AUTH_BODY_LEN     (AUTH_ALG_LEN + AUTH_TRANSACTION_LEN + \
+				   AUTH_STATUS_LEN)
+
+#define HOST_MLME_AUTH_PENDING    BIT(0)
+#define HOST_MLME_AUTH_DONE       BIT(1)
+
+#define HOST_MLME_MGMT_MASK       (BIT(IEEE80211_STYPE_AUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DEAUTH >> 4) | \
+				   BIT(IEEE80211_STYPE_DISASSOC >> 4))
+#define AUTH_TX_DEFAULT_WAIT_TIME 2400
+
+#define WLAN_AUTH_NONE            0xFFFF
+
 #define MWIFIEX_MAX_TX_BASTREAM_SUPPORTED	2
 #define MWIFIEX_MAX_RX_BASTREAM_SUPPORTED	16
 #define MWIFIEX_MAX_TDLS_PEER_SUPPORTED 8
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 3adc447b715f..0f89b86aa527 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -210,6 +210,8 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_RANDOM_MAC         (PROPRIETARY_TLV_BASE_ID + 236)
 #define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
 #define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
+#define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
 
 #define MWIFIEX_TX_DATA_BUF_SIZE_2K        2048
 
@@ -744,6 +746,25 @@ struct uap_rxpd {
 	u8 flags;
 } __packed;
 
+struct mwifiex_auth {
+	__le16 auth_alg;
+	__le16 auth_transaction;
+	__le16 status_code;
+	/* possibly followed by Challenge text */
+	u8 variable[];
+} __packed;
+
+struct mwifiex_ieee80211_mgmt {
+	__le16 frame_control;
+	__le16 duration;
+	u8 da[ETH_ALEN];
+	u8 sa[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	struct mwifiex_auth auth;
+} __packed;
+
 struct mwifiex_fw_chan_stats {
 	u8 chan_num;
 	u8 bandcfg;
@@ -803,6 +824,11 @@ struct mwifiex_ie_types_ssid_param_set {
 	u8 ssid[];
 } __packed;
 
+struct mwifiex_ie_types_host_mlme {
+	struct mwifiex_ie_types_header header;
+	u8 host_mlme;
+} __packed;
+
 struct mwifiex_ie_types_num_probes {
 	struct mwifiex_ie_types_header header;
 	__le16 num_probes;
@@ -906,6 +932,13 @@ struct mwifiex_ie_types_tdls_idle_timeout {
 	__le16 value;
 } __packed;
 
+#define MWIFIEX_AUTHTYPE_SAE 6
+
+struct mwifiex_ie_types_sae_pwe_mode {
+	struct mwifiex_ie_types_header header;
+	u8 pwe[];
+} __packed;
+
 struct mwifiex_ie_types_rsn_param_set {
 	struct mwifiex_ie_types_header header;
 	u8 rsn_ie[];
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index c9c58419c37b..a336d45b9677 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -81,6 +81,9 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
 	priv->bcn_avg_factor = DEFAULT_BCN_AVG_FACTOR;
 	priv->data_avg_factor = DEFAULT_DATA_AVG_FACTOR;
 
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+
 	priv->sec_info.wep_enabled = 0;
 	priv->sec_info.authentication_mode = NL80211_AUTHTYPE_OPEN_SYSTEM;
 	priv->sec_info.encryption_mode = 0;
@@ -220,6 +223,9 @@ static void mwifiex_init_adapter(struct mwifiex_adapter *adapter)
 	adapter->cmd_resp_received = false;
 	adapter->event_received = false;
 	adapter->data_received = false;
+	adapter->assoc_resp_received = false;
+	adapter->priv_link_lost = NULL;
+	adapter->host_mlme_link_lost = false;
 
 	clear_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index 9d98a1908dd6..249210fb2e75 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -382,7 +382,9 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 	struct mwifiex_ie_types_ss_param_set *ss_tlv;
 	struct mwifiex_ie_types_rates_param_set *rates_tlv;
 	struct mwifiex_ie_types_auth_type *auth_tlv;
+	struct mwifiex_ie_types_sae_pwe_mode *sae_pwe_tlv;
 	struct mwifiex_ie_types_chan_list_param_set *chan_tlv;
+	struct mwifiex_ie_types_host_mlme *host_mlme_tlv;
 	u8 rates[MWIFIEX_SUPPORTED_RATES];
 	u32 rates_size;
 	u16 tmp_cap;
@@ -460,6 +462,24 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 
 	pos += sizeof(auth_tlv->header) + le16_to_cpu(auth_tlv->header.len);
 
+	if (priv->sec_info.authentication_mode == WLAN_AUTH_SAE) {
+		auth_tlv->auth_type = cpu_to_le16(MWIFIEX_AUTHTYPE_SAE);
+		if (bss_desc->bcn_rsnx_ie &&
+		    bss_desc->bcn_rsnx_ie->ieee_hdr.len &&
+		    (bss_desc->bcn_rsnx_ie->data[0] &
+		    WLAN_RSNX_CAPA_SAE_H2E)) {
+			sae_pwe_tlv =
+				(struct mwifiex_ie_types_sae_pwe_mode *)pos;
+			sae_pwe_tlv->header.type =
+				cpu_to_le16(TLV_TYPE_SAE_PWE_MODE);
+			sae_pwe_tlv->header.len =
+				cpu_to_le16(sizeof(sae_pwe_tlv->pwe[0]));
+			sae_pwe_tlv->pwe[0] = bss_desc->bcn_rsnx_ie->data[0];
+			pos += sizeof(sae_pwe_tlv->header) +
+				sizeof(sae_pwe_tlv->pwe[0]);
+		}
+	}
+
 	if (IS_SUPPORT_MULTI_BANDS(priv->adapter) &&
 	    !(ISSUPP_11NENABLED(priv->adapter->fw_cap_info) &&
 	    (!bss_desc->disable_11n) &&
@@ -491,6 +511,16 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 			sizeof(struct mwifiex_chan_scan_param_set);
 	}
 
+	if (priv->adapter->host_mlme_enabled) {
+		host_mlme_tlv = (struct mwifiex_ie_types_host_mlme *)pos;
+		host_mlme_tlv->header.type = cpu_to_le16(TLV_TYPE_HOST_MLME);
+		host_mlme_tlv->header.len =
+			cpu_to_le16(sizeof(host_mlme_tlv->host_mlme));
+		host_mlme_tlv->host_mlme = 1;
+		pos += sizeof(host_mlme_tlv->header) +
+			sizeof(host_mlme_tlv->host_mlme);
+	}
+
 	if (!priv->wps.session_enable) {
 		if (priv->sec_info.wpa_enabled || priv->sec_info.wpa2_enabled)
 			rsn_ie_len = mwifiex_append_rsn_ie_wpa_wpa2(priv, &pos);
@@ -641,7 +671,21 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 		goto done;
 	}
 
-	assoc_rsp = (struct ieee_types_assoc_rsp *) &resp->params;
+	if (adapter->host_mlme_enabled) {
+		struct ieee80211_mgmt *hdr;
+
+		hdr = (struct ieee80211_mgmt *)&resp->params;
+		if (!memcmp(hdr->bssid,
+			    priv->attempted_bss_desc->mac_address,
+			    ETH_ALEN))
+			assoc_rsp = (struct ieee_types_assoc_rsp *)
+				&hdr->u.assoc_resp;
+		else
+			assoc_rsp =
+				(struct ieee_types_assoc_rsp *)&resp->params;
+	} else {
+		assoc_rsp = (struct ieee_types_assoc_rsp *)&resp->params;
+	}
 
 	cap_info = le16_to_cpu(assoc_rsp->cap_info_bitmap);
 	status_code = le16_to_cpu(assoc_rsp->status_code);
@@ -680,6 +724,9 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 				mwifiex_dbg(priv->adapter, ERROR,
 					    "ASSOC_RESP: UNSPECIFIED failure\n");
 			}
+
+			if (priv->adapter->host_mlme_enabled)
+				priv->assoc_rsp_size = 0;
 		} else {
 			ret = status_code;
 		}
@@ -778,7 +825,8 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 
 	priv->adapter->dbg.num_cmd_assoc_success++;
 
-	mwifiex_dbg(priv->adapter, INFO, "info: ASSOC_RESP: associated\n");
+	mwifiex_dbg(priv->adapter, MSG, "assoc: associated with %pM\n",
+		    priv->attempted_bss_desc->mac_address);
 
 	/* Add the ra_list here for infra mode as there will be only 1 ra
 	   always */
@@ -1491,6 +1539,20 @@ int mwifiex_deauthenticate(struct mwifiex_private *priv, u8 *mac)
 	if (!priv->media_connected)
 		return 0;
 
+	if (priv->adapter->host_mlme_enabled) {
+		priv->auth_flag = 0;
+		priv->auth_alg = WLAN_AUTH_NONE;
+		priv->host_mlme_reg = false;
+		priv->mgmt_frame_mask = 0;
+		if (mwifiex_send_cmd(priv, HostCmd_CMD_MGMT_FRAME_REG,
+				     HostCmd_ACT_GEN_SET, 0,
+				     &priv->mgmt_frame_mask, false)) {
+			mwifiex_dbg(priv->adapter, ERROR,
+				    "could not unregister mgmt frame rx\n");
+			return -1;
+		}
+	}
+
 	switch (priv->bss_mode) {
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index d99127dc466e..88cd2d6a1dcb 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -530,6 +530,11 @@ static void mwifiex_terminate_workqueue(struct mwifiex_adapter *adapter)
 		destroy_workqueue(adapter->rx_workqueue);
 		adapter->rx_workqueue = NULL;
 	}
+
+	if (adapter->host_mlme_workqueue) {
+		destroy_workqueue(adapter->host_mlme_workqueue);
+		adapter->host_mlme_workqueue = NULL;
+	}
 }
 
 /*
@@ -802,6 +807,10 @@ mwifiex_bypass_tx_queue(struct mwifiex_private *priv,
 			    "bypass txqueue; eth type %#x, mgmt %d\n",
 			     ntohs(eth_hdr->h_proto),
 			     mwifiex_is_skb_mgmt_frame(skb));
+		if (eth_hdr->h_proto == htons(ETH_P_PAE))
+			mwifiex_dbg(priv->adapter, MSG,
+				    "key: send EAPOL to %pM\n",
+				    eth_hdr->h_dest);
 		return true;
 	}
 
@@ -1384,6 +1393,35 @@ int is_command_pending(struct mwifiex_adapter *adapter)
 	return !is_cmd_pend_q_empty;
 }
 
+/* This is the host mlme work queue function.
+ * It handles the host mlme operations.
+ */
+static void mwifiex_host_mlme_work_queue(struct work_struct *work)
+{
+	struct mwifiex_adapter *adapter =
+		container_of(work, struct mwifiex_adapter, host_mlme_work);
+
+	if (test_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags))
+		return;
+
+	/* Check for host mlme disconnection */
+	if (adapter->host_mlme_link_lost) {
+		if (adapter->priv_link_lost) {
+			mwifiex_reset_connect_state(adapter->priv_link_lost,
+						    WLAN_REASON_DEAUTH_LEAVING,
+						    true);
+			adapter->priv_link_lost = NULL;
+		}
+		adapter->host_mlme_link_lost = false;
+	}
+
+	/* Check for host mlme Assoc Resp */
+	if (adapter->assoc_resp_received) {
+		mwifiex_process_assoc_resp(adapter);
+		adapter->assoc_resp_received = false;
+	}
+}
+
 /*
  * This is the RX work queue function.
  *
@@ -1558,6 +1596,18 @@ mwifiex_reinit_sw(struct mwifiex_adapter *adapter)
 		INIT_WORK(&adapter->rx_work, mwifiex_rx_work_queue);
 	}
 
+	if (adapter->host_mlme_enabled) {
+		adapter->host_mlme_workqueue =
+			alloc_workqueue("MWIFIEX_HOST_MLME_WORK_QUEUE",
+					WQ_HIGHPRI |
+					WQ_MEM_RECLAIM |
+					WQ_UNBOUND, 0);
+		if (!adapter->host_mlme_workqueue)
+			goto err_kmalloc;
+		INIT_WORK(&adapter->host_mlme_work,
+			  mwifiex_host_mlme_work_queue);
+	}
+
 	/* Register the device. Fill up the private data structure with
 	 * relevant information from the card. Some code extracted from
 	 * mwifiex_register_dev()
@@ -1721,6 +1771,18 @@ mwifiex_add_card(void *card, struct completion *fw_done,
 		goto err_registerdev;
 	}
 
+	if (adapter->host_mlme_enabled) {
+		adapter->host_mlme_workqueue =
+			alloc_workqueue("MWIFIEX_HOST_MLME_WORK_QUEUE",
+					WQ_HIGHPRI |
+					WQ_MEM_RECLAIM |
+					WQ_UNBOUND, 0);
+		if (!adapter->host_mlme_workqueue)
+			goto err_kmalloc;
+		INIT_WORK(&adapter->host_mlme_work,
+			  mwifiex_host_mlme_work_queue);
+	}
+
 	if (mwifiex_init_hw_fw(adapter, true)) {
 		pr_err("%s: firmware init failed\n", __func__);
 		goto err_init_fw;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 175882485a19..a0fdabc43fff 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -424,6 +424,8 @@ struct mwifiex_bssdescriptor {
 	u16 wpa_offset;
 	struct ieee_types_generic *bcn_rsn_ie;
 	u16 rsn_offset;
+	struct ieee_types_generic *bcn_rsnx_ie;
+	u16 rsnx_offset;
 	struct ieee_types_generic *bcn_wapi_ie;
 	u16 wapi_offset;
 	u8 *beacon_buf;
@@ -525,6 +527,8 @@ struct mwifiex_private {
 	u8 bss_priority;
 	u8 bss_num;
 	u8 bss_started;
+	u8 auth_flag;
+	u16 auth_alg;
 	u8 frame_type;
 	u8 curr_addr[ETH_ALEN];
 	u8 media_connected;
@@ -608,6 +612,7 @@ struct mwifiex_private {
 #define MWIFIEX_ASSOC_RSP_BUF_SIZE  500
 	u8 assoc_rsp_buf[MWIFIEX_ASSOC_RSP_BUF_SIZE];
 	u32 assoc_rsp_size;
+	struct cfg80211_bss *req_bss;
 
 #define MWIFIEX_GENIE_BUF_SIZE      256
 	u8 gen_ie_buf[MWIFIEX_GENIE_BUF_SIZE];
@@ -647,6 +652,7 @@ struct mwifiex_private {
 	u16 gen_idx;
 	u8 ap_11n_enabled;
 	u8 ap_11ac_enabled;
+	bool host_mlme_reg;
 	u32 mgmt_frame_mask;
 	struct mwifiex_roc_cfg roc_cfg;
 	bool scan_aborting;
@@ -876,6 +882,8 @@ struct mwifiex_adapter {
 	struct work_struct main_work;
 	struct workqueue_struct *rx_workqueue;
 	struct work_struct rx_work;
+	struct workqueue_struct *host_mlme_workqueue;
+	struct work_struct host_mlme_work;
 	bool rx_work_enabled;
 	bool rx_processing;
 	bool delay_main_work;
@@ -907,6 +915,9 @@ struct mwifiex_adapter {
 	u8 cmd_resp_received;
 	u8 event_received;
 	u8 data_received;
+	u8 assoc_resp_received;
+	struct mwifiex_private *priv_link_lost;
+	u8 host_mlme_link_lost;
 	u16 seq_num;
 	struct cmd_ctrl_node *cmd_pool;
 	struct cmd_ctrl_node *curr_cmd;
@@ -996,6 +1007,7 @@ struct mwifiex_adapter {
 	bool is_up;
 
 	bool ext_scan;
+	bool host_mlme_enabled;
 	u8 fw_api_ver;
 	u8 key_api_major_ver, key_api_minor_ver;
 	u8 max_p2p_conn, max_sta_conn;
@@ -1061,6 +1073,9 @@ int mwifiex_recv_packet(struct mwifiex_private *priv, struct sk_buff *skb);
 int mwifiex_uap_recv_packet(struct mwifiex_private *priv,
 			    struct sk_buff *skb);
 
+void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
+				  u16 reason_code, u8 *sa);
+
 int mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 				struct sk_buff *skb);
 
@@ -1092,6 +1107,7 @@ void mwifiex_insert_cmd_to_pending_q(struct mwifiex_adapter *adapter,
 
 int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter);
 int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter);
+void mwifiex_process_assoc_resp(struct mwifiex_adapter *adapter);
 int mwifiex_handle_rx_packet(struct mwifiex_adapter *adapter,
 			     struct sk_buff *skb);
 int mwifiex_process_tx(struct mwifiex_private *priv, struct sk_buff *skb,
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 0326b121747c..e782d652cb93 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1371,6 +1371,12 @@ int mwifiex_update_bss_desc_with_ie(struct mwifiex_adapter *adapter,
 			bss_entry->rsn_offset = (u16) (current_ptr -
 							bss_entry->beacon_buf);
 			break;
+		case WLAN_EID_RSNX:
+			bss_entry->bcn_rsnx_ie =
+				(struct ieee_types_generic *)current_ptr;
+			bss_entry->rsnx_offset =
+				(u16)(current_ptr - bss_entry->beacon_buf);
+			break;
 		case WLAN_EID_BSS_AC_ACCESS_DELAY:
 			bss_entry->bcn_wapi_ie =
 				(struct ieee_types_generic *) current_ptr;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index bda9b2b8a1f3..490ffd981164 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -332,6 +332,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = false,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
@@ -348,6 +349,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
@@ -364,6 +366,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
@@ -380,6 +383,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
@@ -397,6 +401,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
@@ -414,6 +419,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = true,
+	.host_mlme = true,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
@@ -432,6 +438,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
@@ -448,6 +455,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
@@ -465,6 +473,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
@@ -481,6 +490,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
 	.fw_ready_extra_delay = false,
+	.host_mlme = false,
 };
 
 static struct memory_type_mapping generic_mem_type_map[] = {
@@ -574,6 +584,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
 		card->can_auto_tdls = data->can_auto_tdls;
 		card->can_ext_scan = data->can_ext_scan;
 		card->fw_ready_extra_delay = data->fw_ready_extra_delay;
+		card->host_mlme = data->host_mlme;
 		INIT_WORK(&card->work, mwifiex_sdio_work);
 	}
 
@@ -2511,6 +2522,8 @@ static int mwifiex_register_dev(struct mwifiex_adapter *adapter)
 		adapter->num_mem_types = ARRAY_SIZE(mem_type_mapping_tbl);
 	}
 
+	adapter->host_mlme_enabled = card->host_mlme;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index cb63ad55d675..65d142286c46 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -256,6 +256,7 @@ struct sdio_mmc_card {
 	bool can_auto_tdls;
 	bool can_ext_scan;
 	bool fw_ready_extra_delay;
+	bool host_mlme;
 
 	struct mwifiex_sdio_mpa_tx mpa_tx;
 	struct mwifiex_sdio_mpa_rx mpa_rx;
@@ -280,6 +281,7 @@ struct mwifiex_sdio_device {
 	bool can_auto_tdls;
 	bool can_ext_scan;
 	bool fw_ready_extra_delay;
+	bool host_mlme;
 };
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index df9cdd10a494..b5f3821a6a8f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -135,6 +135,9 @@ void mwifiex_reset_connect_state(struct mwifiex_private *priv, u16 reason_code,
 
 	priv->media_connected = false;
 
+	priv->auth_flag = 0;
+	priv->auth_alg = WLAN_AUTH_NONE;
+
 	priv->scan_block = false;
 	priv->port_open = false;
 
@@ -222,8 +225,12 @@ void mwifiex_reset_connect_state(struct mwifiex_private *priv, u16 reason_code,
 		    priv->cfg_bssid, reason_code);
 	if (priv->bss_mode == NL80211_IFTYPE_STATION ||
 	    priv->bss_mode == NL80211_IFTYPE_P2P_CLIENT) {
-		cfg80211_disconnected(priv->netdev, reason_code, NULL, 0,
-				      !from_ap, GFP_KERNEL);
+		if (adapter->host_mlme_enabled && adapter->host_mlme_link_lost)
+			mwifiex_host_mlme_disconnect(adapter->priv_link_lost,
+						     reason_code, NULL);
+		else
+			cfg80211_disconnected(priv->netdev, reason_code, NULL,
+					      0, !from_ap, GFP_KERNEL);
 	}
 	eth_zero_addr(priv->cfg_bssid);
 
@@ -746,7 +753,15 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 		if (priv->media_connected) {
 			reason_code =
 				get_unaligned_le16(adapter->event_body);
-			mwifiex_reset_connect_state(priv, reason_code, true);
+			if (adapter->host_mlme_enabled) {
+				adapter->priv_link_lost = priv;
+				adapter->host_mlme_link_lost = true;
+				queue_work(adapter->host_mlme_workqueue,
+					   &adapter->host_mlme_work);
+			} else {
+				mwifiex_reset_connect_state(priv, reason_code,
+							    true);
+			}
 		}
 		break;
 
@@ -999,10 +1014,17 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 	case EVENT_REMAIN_ON_CHAN_EXPIRED:
 		mwifiex_dbg(adapter, EVENT,
 			    "event: Remain on channel expired\n");
-		cfg80211_remain_on_channel_expired(&priv->wdev,
-						   priv->roc_cfg.cookie,
-						   &priv->roc_cfg.chan,
-						   GFP_ATOMIC);
+
+		if (adapter->host_mlme_enabled &&
+		    (priv->auth_flag & HOST_MLME_AUTH_PENDING)) {
+			priv->auth_flag = 0;
+			priv->auth_alg = WLAN_AUTH_NONE;
+		} else {
+			cfg80211_remain_on_channel_expired(&priv->wdev,
+							   priv->roc_cfg.cookie,
+							   &priv->roc_cfg.chan,
+							   GFP_ATOMIC);
+		}
 
 		memset(&priv->roc_cfg, 0x00, sizeof(struct mwifiex_roc_cfg));
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index 32a27fad7b79..a94659988a4c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -339,7 +339,7 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 			ret = mwifiex_associate(priv, bss_desc);
 		}
 
-		if (bss)
+		if (bss && !priv->adapter->host_mlme_enabled)
 			cfg80211_put_bss(priv->adapter->wiphy, bss);
 	} else {
 		/* Adhoc mode */
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index 70c2790b8e35..9d0ef04ebe02 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -36,7 +36,7 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	struct txpd *local_tx_pd;
 	struct mwifiex_txinfo *tx_info = MWIFIEX_SKB_TXCB(skb);
 	unsigned int pad;
-	u16 pkt_type, pkt_offset;
+	u16 pkt_type, pkt_length, pkt_offset;
 	int hroom = adapter->intf_hdr_len;
 
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
@@ -49,9 +49,10 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	memset(local_tx_pd, 0, sizeof(struct txpd));
 	local_tx_pd->bss_num = priv->bss_num;
 	local_tx_pd->bss_type = priv->bss_type;
-	local_tx_pd->tx_pkt_length = cpu_to_le16((u16)(skb->len -
-						       (sizeof(struct txpd) +
-							pad)));
+	pkt_length = (u16)(skb->len - (sizeof(struct txpd) + pad));
+	if (pkt_type == PKT_TYPE_MGMT)
+		pkt_length -= MWIFIEX_MGMT_FRAME_HEADER_SIZE;
+	local_tx_pd->tx_pkt_length = cpu_to_le16(pkt_length);
 
 	local_tx_pd->priority = (u8) skb->priority;
 	local_tx_pd->pkt_delay_2ms =
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 745b1d925b21..3817c08a1507 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -370,6 +370,45 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 
 	return 0;
 }
+
+/* This function sends deauth packet to the kernel. */
+void mwifiex_host_mlme_disconnect(struct mwifiex_private *priv,
+				  u16 reason_code, u8 *sa)
+{
+	u8 frame_buf[100];
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)frame_buf;
+
+	memset(frame_buf, 0, sizeof(frame_buf));
+	mgmt->frame_control = cpu_to_le16(IEEE80211_STYPE_DEAUTH);
+	mgmt->duration = 0;
+	mgmt->seq_ctrl = 0;
+	mgmt->u.deauth.reason_code = cpu_to_le16(reason_code);
+
+	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA) {
+		eth_broadcast_addr(mgmt->da);
+		memcpy(mgmt->sa,
+		       priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+		memcpy(mgmt->bssid, priv->cfg_bssid, ETH_ALEN);
+		priv->auth_flag = 0;
+		priv->auth_alg = WLAN_AUTH_NONE;
+	} else {
+		memcpy(mgmt->da, priv->curr_addr, ETH_ALEN);
+		memcpy(mgmt->sa, sa, ETH_ALEN);
+		memcpy(mgmt->bssid, priv->curr_addr, ETH_ALEN);
+	}
+
+	if (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP) {
+		wiphy_lock(priv->wdev.wiphy);
+		cfg80211_rx_mlme_mgmt(priv->netdev, frame_buf, 26);
+		wiphy_unlock(priv->wdev.wiphy);
+	} else {
+		cfg80211_rx_mgmt(&priv->wdev,
+				 priv->bss_chandef.chan->center_freq,
+				 0, frame_buf, 26, 0);
+	}
+}
+
 /*
  * This function processes the received management packet and send it
  * to the kernel.
@@ -417,6 +456,47 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 	pkt_len -= ETH_ALEN;
 	rx_pd->rx_pkt_length = cpu_to_le16(pkt_len);
 
+	if (priv->host_mlme_reg &&
+	    (GET_BSS_ROLE(priv) != MWIFIEX_BSS_ROLE_UAP) &&
+	    (ieee80211_is_auth(ieee_hdr->frame_control) ||
+	     ieee80211_is_deauth(ieee_hdr->frame_control) ||
+	     ieee80211_is_disassoc(ieee_hdr->frame_control))) {
+		if (ieee80211_is_auth(ieee_hdr->frame_control)) {
+			if (priv->auth_flag & HOST_MLME_AUTH_PENDING) {
+				if (priv->auth_alg != WLAN_AUTH_SAE) {
+					priv->auth_flag &=
+						~HOST_MLME_AUTH_PENDING;
+					priv->auth_flag |=
+						HOST_MLME_AUTH_DONE;
+				}
+			} else {
+				return 0;
+			}
+
+			mwifiex_dbg(priv->adapter, MSG,
+				    "auth: receive authentication from %pM\n",
+				    ieee_hdr->addr3);
+		} else {
+			if (!priv->wdev.connected)
+				return 0;
+
+			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
+				mwifiex_dbg(priv->adapter, MSG,
+					    "auth: receive deauth from %pM\n",
+					    ieee_hdr->addr3);
+				priv->auth_flag = 0;
+				priv->auth_alg = WLAN_AUTH_NONE;
+			} else {
+				mwifiex_dbg
+				(priv->adapter, MSG,
+				 "assoc: receive disassoc from %pM\n",
+				 ieee_hdr->addr3);
+			}
+		}
+
+		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
+	}
+
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
 			 CAL_RSSI(rx_pd->snr, rx_pd->nf), skb->data, pkt_len,
 			 0);
-- 
2.34.1


