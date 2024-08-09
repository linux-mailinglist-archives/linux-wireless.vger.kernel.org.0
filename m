Return-Path: <linux-wireless+bounces-11209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121694CDC4
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33021F22708
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A919ADA8;
	Fri,  9 Aug 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L1BQuN8L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312519AA58;
	Fri,  9 Aug 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196865; cv=fail; b=TgOEr4mW3jowo/BNZ7zuja5U3fxxILj3UsrWpKblk4WKei2fW4Ph/ie8shRv6evFDeA5QCTi7ww00mZQfE9jWPtwg0XpEFsFLkxb8auRxgDLAuetVmB4+x3uuSj5Urnsk6I8p0EveygkqNh4S9Pw65Wumx1Or+XfGIbdgKeGr44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196865; c=relaxed/simple;
	bh=ZjDal+MPnFNL/z0sJX/OgwVeAyQ1K/UPEsksaa34CdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NTWhBDpCUgXx9WBa0GAiYrAe9zikXnP73nsnPqwf5qGfPg50nFq6C5DQIfFDi9FFaahWRJhGaK1xYG/ogQpQ6IoZ45qSRhFoZYDywsOv1yscniXNzY6nxlT0uMXsgGUQqPT/jzA97Eem8DMsr9P4klgUbG9nva4EqpMtzmh0qao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L1BQuN8L; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K13Nq1tfCmWHSh9UBw2DYDn8gZ8IZ283Lpw6OTh/Ifqx+QKja8VP/QdCRvpcIRhSL/DuAhcWCYzFlRK3famk4+cbMnptQj3Zu2KFze614GzyaSfNxfRZvD7NwOUdyt9nAc+BwZ0V2jwaHeu+JxC0NxkCAcI5xugFFs4D3yRmGq5qCw1j5oexuB2CgLYXbKr3f040wWrZMbO5ZsPHDa273AdKp1IlslfhkiAxd5M0iRQBEnJGt6X0BKEr5VV6moUifMpgeYSdVB4J8UWApCMkd9RP285TKMrc6SCQhq9n+T2N420eFZMajT9/zLSqBb5m/X/nz7PMCdxNmY7RIgktqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysjBqJy3xkCGEqnSDU1KLslufZowZuRkFYV0QmhyZb8=;
 b=J3Lw6DMbPYJKLi2vQLL7SnCX3PtZa9F7qLlUD0bQ11+XrSHXchXARuZ1tqJGiTu67Q/hWr9TeSYTcMF6PWJBr/wjCX+w4R5H0k/+ScImj35zo11efZvL1xw39dWofO8dWD5QtF8VMGO/p155SIY1GWI9Waw2kTZ7L9d+oRjAhdc+v2YiiOQ960bJ98OaziGCdi3rMW5ei6sztjqQiKbS5cRFajroCfbkmmtG9quuUXzIQZ32/ea56TNvsuBKDm0UMZU75TtzWYh8HUnmQvvHhncFGtoQr7WCRv6G67XhUsNUGiom1JXn4kE6PmvrVY3/cjA6z1j3juRulATRFQaWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysjBqJy3xkCGEqnSDU1KLslufZowZuRkFYV0QmhyZb8=;
 b=L1BQuN8LesO/tbx2O1TlVVjnDFVf3qZaDGTGK/nUI5iAwx4S0rHPFq4iRXeIIr+ALDqVEQzGbWrfy+w9wFDM33sJdOiL4HUQInwTTWs6f9cwXIbMIu8Y14cjTYGJFX2jn8KL+8qF92svNG5/cXZGzTmo41YCyIQvtxgOZDFSfOs7H7Jo7Jvse6YrApcnBtkWhFnc9JRlA7XRl0GC3j0HjrUOkcR1HiBNI6xZ778rU8B+48sBcT9u8fGDahs5bgvgsxgFX0YXninhKRr05I+bVOvAbRDl8Xgtv/9GNLOUuGk4TIj9abxIho9jmSzwZQwOCUbQXX0vRux9Ab1h/4PglA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:47:33 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:47:33 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 31/43] wifi: nxpwifi: add sta_rx.c
Date: Fri,  9 Aug 2024 17:45:21 +0800
Message-Id: <20240809094533.1660-32-yu-hao.lin@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 885472ce-9459-411c-8d1b-08dcb8584ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HXfpLFdr6Iwy2w9mgl8AunJlEYZ4MNdF7fynRpZY8z1JSSCg7s3WFjDQlqVX?=
 =?us-ascii?Q?qJmWyGv5AZTR/K11DeSeCwxBBNEGA3NuKMynV+ukYKVzykg97Gn1PwqlOxCe?=
 =?us-ascii?Q?0GMiRBYverIyS6K9gG1oI5CfN3zFMJYFvVQN3X0ktpKADrY7qTGPn+Y+lEim?=
 =?us-ascii?Q?Q3lu9r7G3A36/kjaYydLWCChpnYeAG73+EoEiRJ2hbfzVSQSIpF6lkSZzrfj?=
 =?us-ascii?Q?rIgdGOBucKNw+njEmuzDo3puP5+uvVieAAysCZ8Ppxl1L4LTSAjNtaQIIFNR?=
 =?us-ascii?Q?RLnRkBjCisKj5LiFgJbL2eL2AaiYlCGVKVR+sGHL9Kov/MeNfqt8kNBgwQi2?=
 =?us-ascii?Q?2q8O/PQ9wN5cLkXaKKx/tHAn9ulVH208FC4Ylvqsaew189ZmE3shIjg0ccoC?=
 =?us-ascii?Q?vY2NRDy6et5U1TWpFLThdsSd2U9c5ZHK3mvJ/CfXZId9eXOVyLSL+Eel4IjN?=
 =?us-ascii?Q?C4oRKEzOLsasycueiHB7w1BTW8JhQIZeoss3lrxRsWg7NHWoZ775BTTIfom5?=
 =?us-ascii?Q?v4n/VgbyDNmPOkKI95sthYWO4FjgaDhPEGdLHzMErwMVJqMWhy3xfdjwr3Kr?=
 =?us-ascii?Q?Ylxxy12A0iK1C4tQtL8psNBKuoWPy76N5gHNJ9DtMMOmCW7UjBr+fRgRZ2jP?=
 =?us-ascii?Q?amX6vTzjFN4cr2ZWUQ2j7vZOgw0hcspMV+zPvAR/HKAmojZ1MsAWq+a5w4Y6?=
 =?us-ascii?Q?nc4YmUaI/MTGESxOP0MdHHnz6jMXlf9OQ3UqXRwtI5lpgFuNCjt08Ax/NEid?=
 =?us-ascii?Q?A4auks8pP+yafopCulHqZh3OKHEJs1uMm+YgxCPh5lrHkf9A/sji503kx1tY?=
 =?us-ascii?Q?lmX/gT+igE4avTSSqvz0FahJiRpPN3UU+gtXpo+Ko8kPdIDHcsHfR98UiBR3?=
 =?us-ascii?Q?z1gO1lr6T8kKXLeyYNWkR3UDnEkcJRurZVtt2Aq9ibkRrO1plKn5x8NKiw7r?=
 =?us-ascii?Q?X1zHUEc2J8jIjz+aLsZ1PelUK67rM76tj4cnN9OUXCsG4gXA2mN4bUIK0GXx?=
 =?us-ascii?Q?3GkW95/XPIqfOnxwMchT5Lwoi3PPFwWOeArcT9i8ENddDgBLaoPVRVEPu2p2?=
 =?us-ascii?Q?ZAMLrotlQkPmC8ELLg5XoO13r3Yu8W/hv+YK7RNsODGWiIvuqufWLwB+CAEb?=
 =?us-ascii?Q?+BUvok2FtNqhAb8m/YyK1RGfEng36pl6VXOULUBOwPCgZ+y6DlH8PT/LYgft?=
 =?us-ascii?Q?lI+CeUUZnucXux4c9kHswCktqBi75ddqXyXUkBY5P7XxZ5wXtzZ1Sa/6CypF?=
 =?us-ascii?Q?1aeW/S+ZhONJHTTXLRVvGnedr/QXloL5SG/lLVo18rTbAKPo24Br6OyHpwPm?=
 =?us-ascii?Q?pWGpgtVMmu7kx90f7CgKdViF+p0E6eGW++pKKRNm7Km+Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kQApdAsLnagX8PJGx3B7PhFVkfBa0X7vwwRT6hOLNhpdvIZS/mBr01CMI9Q?=
 =?us-ascii?Q?4obnk6VenLEllzIa1HdnlirquqtV44dzDh3anZ+gNibUIZ7cS6OSebKQJif6?=
 =?us-ascii?Q?JPcaxYkfTveHvBmPceUioORmfqzQS/SxXpw8osJluVHmq947eq9hvtFu817Y?=
 =?us-ascii?Q?J2852BLeOz/y2nt6NZDB6EMMDfG/kM1H3pj1IwpFgHphBxUAieDIWqiOV6Ju?=
 =?us-ascii?Q?JVzkOunq0woXUFIzwnE2+7AxmywK/tWcAJKxqpX21ZnlAfKa7LxMI8PE0aLJ?=
 =?us-ascii?Q?75M0AXV4v4ABy9J2MzMCZOwR507LO5g+Xg8dfqfh889X/JUTNCHTpD64t6uh?=
 =?us-ascii?Q?aHDLGSrzdo6+4BFnc+oocDhdB4VlQJZtIw+v3/LWONLVejkONOHo6/TlQfcB?=
 =?us-ascii?Q?yafY7ePDBMA0SEYR6a/eigUM9yUw/JfbREQqozLB+jS1zlckl2UDAh2pbJPn?=
 =?us-ascii?Q?SXmqHizkx65smqyP8OJewORUS6ayOHQbbxAoOXUZ7b49IZUlK7B4FOSKSkWx?=
 =?us-ascii?Q?0AiebKWMJtrPkatSVhUOZyeKSKU6tBpeaLJVKGmtf9z0SwMVLO9JteH+cpdA?=
 =?us-ascii?Q?22fTrGd1FmRCk1is8rVOEf0+dz233qt4YqVxIt3PwURBzxDsewwkKFQu6xss?=
 =?us-ascii?Q?XUqc5Wvs42G5B1lfVe9YDd3H5MPMiqd5dQa8QaEj/Lu8cVAf8Ari3FdCUk3B?=
 =?us-ascii?Q?ksJdOq2d2LWjqobjhgCDgEwJC+lNMjX9yZbHwzA0jWoajIgQKk7Hxe8mwEPU?=
 =?us-ascii?Q?2jmZG1LGGUWFFr81vvIaY1SZ1QCcXBO0Ng244H15FfexJk+XrLVYJ+F9qSCy?=
 =?us-ascii?Q?3gWuvr3Byru7JzQLMV6mc9sUp9aXzY/TS8F0ha8UgWkutMa5jffjdxP/ZG6m?=
 =?us-ascii?Q?qXODNJALlQe6hIhyYx55NbK78uOnbcVk0XS+2KK4WuvZUFwBRg3OJLfDF90u?=
 =?us-ascii?Q?6BYo5j7458zG1sy1xOsU788Mn+KBsgwUH/47LEoBCsPTaxVB4eo9G6DOFJMS?=
 =?us-ascii?Q?7Rqw94F7QT9IaYm4LA0JlCQRieAB+5uRqIpCV+KlyKF0zyIxeOYTao0cZRAH?=
 =?us-ascii?Q?BarqPF3QSIzRplKXG9n/2R+xCxxKMaWfWwJBkUUYYmZ5s0mNXNsU7cx/Or9H?=
 =?us-ascii?Q?5xAyRHlomdc5FKeKPrysAHQPKt+LfaqUPk6aJ7otVogXjp2tf79Lv6KK7nNg?=
 =?us-ascii?Q?HXGorbJVrgJqnw/1txQcy2CtXep7T1kRBFT5S3m/utY875giLc64DFxG5UEi?=
 =?us-ascii?Q?rHGHKJyH+hkBDdl8awgy8WEpxMSSPW9R8ljsZxViNwUoLDK3fJKbDVVNYmTe?=
 =?us-ascii?Q?y6ZRvRV1Dl2xXEX1dcF8lPNxHVuuSnFvlDziJqoRPufqix1nePuDojxJKF/O?=
 =?us-ascii?Q?zQ/Eoj/MjBPUwiLbRXHroSlulE7t+okRnjmFfGxrBq/ei6dYF/2I/p7F5keN?=
 =?us-ascii?Q?Ii+rP2O7yUoBNQ46FXUEWM9qmx9hmAAfTY+i39ogz4oHB7bFXcC+urfeP9gT?=
 =?us-ascii?Q?Ca0RZ6TviGyqsXBlB3vPfIKtuuWl3NMV+Uvckhh9jhQui8lRf6PGIwf+vQwY?=
 =?us-ascii?Q?nQ5NAzxlfavgCyFBXJ45Z+vWqf7A4Zb6fRYdwP9kpZV1jIYUIG8tm4rxLD+s?=
 =?us-ascii?Q?rG18zPM+jJr4zxHJ1vzwjlPIVstai35mQY7PBFqPNN3n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885472ce-9459-411c-8d1b-08dcb8584ace
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:47:33.2866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WqAK42TPiKG0hwNKmlrDwyWdUmPir8lN5dWUWwkdFYAiP/x9/OSCWHuwsZGnIyRhlRwUoZW8n/3qr+wUHrv5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

---
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c | 244 ++++++++++++++++++++++
 1 file changed, 244 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c

diff --git a/drivers/net/wireless/nxp/nxpwifi/sta_rx.c b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
new file mode 100644
index 000000000000..e1608299a841
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/sta_rx.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: station RX data handling
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include <uapi/linux/ipv6.h>
+#include <net/ndisc.h>
+#include "decl.h"
+#include "cfg.h"
+#include "util.h"
+#include "fw.h"
+#include "main.h"
+#include "11n_aggr.h"
+#include "11n_rxreorder.h"
+
+/* This function checks if a frame is IPv4 ARP or IPv6 Neighbour advertisement
+ * frame. If frame has both source and destination mac address as same, this
+ * function drops such gratuitous frames.
+ */
+static bool
+nxpwifi_discard_gratuitous_arp(struct nxpwifi_private *priv,
+			       struct sk_buff *skb)
+{
+	const struct nxpwifi_arp_eth_header *arp;
+	struct ethhdr *eth;
+	struct ipv6hdr *ipv6;
+	struct icmp6hdr *icmpv6;
+
+	eth = (struct ethhdr *)skb->data;
+	switch (ntohs(eth->h_proto)) {
+	case ETH_P_ARP:
+		arp = (void *)(skb->data + sizeof(struct ethhdr));
+		if (arp->hdr.ar_op == htons(ARPOP_REPLY) ||
+		    arp->hdr.ar_op == htons(ARPOP_REQUEST)) {
+			if (!memcmp(arp->ar_sip, arp->ar_tip, 4))
+				return true;
+		}
+		break;
+	case ETH_P_IPV6:
+		ipv6 = (void *)(skb->data + sizeof(struct ethhdr));
+		icmpv6 = (void *)(skb->data + sizeof(struct ethhdr) +
+				  sizeof(struct ipv6hdr));
+		if (icmpv6->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
+			if (!memcmp(&ipv6->saddr, &ipv6->daddr,
+				    sizeof(struct in6_addr)))
+				return true;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/* This function processes the received packet and forwards it
+ * to kernel/upper layer.
+ *
+ * This function parses through the received packet and determines
+ * if it is a debug packet or normal packet.
+ *
+ * For non-debug packets, the function chops off unnecessary leading
+ * header bytes, reconstructs the packet as an ethernet frame or
+ * 802.2/llc/snap frame as required, and sends it to kernel/upper layer.
+ *
+ * The completion callback is called after processing in complete.
+ */
+int nxpwifi_process_rx_packet(struct nxpwifi_private *priv,
+			      struct sk_buff *skb)
+{
+	int ret;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	struct rxpd *local_rx_pd;
+	int hdr_chop;
+	struct ethhdr *eth;
+	u16 rx_pkt_off;
+	u8 adj_rx_rate = 0;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+
+	rx_pkt_off = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
+
+	if (sizeof(rx_pkt_hdr->eth803_hdr) + sizeof(rfc1042_header) +
+	    rx_pkt_off > skb->len) {
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return -EINVAL;
+	}
+
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
+	    ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
+		      sizeof(bridge_tunnel_header))) ||
+	     (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
+		      sizeof(rfc1042_header)) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_AARP) &&
+	      rx_pkt_hdr->rfc1042_hdr.snap_type != htons(ETH_P_IPX)))) {
+		/*  Replace the 803 header and rfc1042 header (llc/snap) with an
+		 *    EthernetII header, keep the src/dst and snap_type
+		 *    (ethertype).
+		 *  The firmware only passes up SNAP frames converting
+		 *    all RX Data from 802.11 to 802.2/LLC/SNAP frames.
+		 *  To create the Ethernet II, just move the src, dst address
+		 *    right before the snap_type.
+		 */
+		eth = (struct ethhdr *)
+			((u8 *)&rx_pkt_hdr->eth803_hdr
+			 + sizeof(rx_pkt_hdr->eth803_hdr) +
+			 sizeof(rx_pkt_hdr->rfc1042_hdr)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_dest)
+			 - sizeof(rx_pkt_hdr->eth803_hdr.h_source)
+			 - sizeof(rx_pkt_hdr->rfc1042_hdr.snap_type));
+
+		memcpy(eth->h_source, rx_pkt_hdr->eth803_hdr.h_source,
+		       sizeof(eth->h_source));
+		memcpy(eth->h_dest, rx_pkt_hdr->eth803_hdr.h_dest,
+		       sizeof(eth->h_dest));
+
+		/* Chop off the rxpd + the excess memory from the 802.2/llc/snap
+		 * header that was removed.
+		 */
+		hdr_chop = (u8 *)eth - (u8 *)local_rx_pd;
+	} else {
+		/* Chop off the rxpd */
+		hdr_chop = (u8 *)&rx_pkt_hdr->eth803_hdr - (u8 *)local_rx_pd;
+	}
+
+	/* Chop off the leading header bytes so the it points to the start of
+	 * either the reconstructed EthII frame or the 802.2/llc/snap frame
+	 */
+	skb_pull(skb, hdr_chop);
+
+	if (priv->hs2_enabled &&
+	    nxpwifi_discard_gratuitous_arp(priv, skb)) {
+		nxpwifi_dbg(priv->adapter, INFO, "Bypassed Gratuitous ARP\n");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	/* Only stash RX bitrate for unicast packets. */
+	if (likely(!is_multicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest))) {
+		priv->rxpd_rate = local_rx_pd->rx_rate;
+		priv->rxpd_htinfo = local_rx_pd->ht_info;
+	}
+
+	if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA ||
+	    GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_UAP) {
+		adj_rx_rate = nxpwifi_adjust_data_rate(priv,
+						       local_rx_pd->rx_rate,
+						       local_rx_pd->ht_info);
+		nxpwifi_hist_data_add(priv, adj_rx_rate, local_rx_pd->snr,
+				      local_rx_pd->nf);
+	}
+
+	ret = nxpwifi_recv_packet(priv, skb);
+	if (ret)
+		nxpwifi_dbg(priv->adapter, ERROR,
+			    "recv packet failed\n");
+
+	return ret;
+}
+
+/* This function processes the received buffer.
+ *
+ * The function looks into the RxPD and performs sanity tests on the
+ * received buffer to ensure its a valid packet, before processing it
+ * further. If the packet is determined to be aggregated, it is
+ * de-aggregated accordingly. Non-unicast packets are sent directly to
+ * the kernel/upper layers. Unicast packets are handed over to the
+ * Rx reordering routine if 11n is enabled.
+ *
+ * The completion callback is called after processing in complete.
+ */
+int nxpwifi_process_sta_rx_packet(struct nxpwifi_private *priv,
+				  struct sk_buff *skb)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	int ret = 0;
+	struct rxpd *local_rx_pd;
+	struct rx_packet_hdr *rx_pkt_hdr;
+	u8 ta[ETH_ALEN];
+	u16 rx_pkt_type, rx_pkt_offset, rx_pkt_length, seq_num;
+
+	local_rx_pd = (struct rxpd *)(skb->data);
+	rx_pkt_type = le16_to_cpu(local_rx_pd->rx_pkt_type);
+	rx_pkt_offset = le16_to_cpu(local_rx_pd->rx_pkt_offset);
+	rx_pkt_length = le16_to_cpu(local_rx_pd->rx_pkt_length);
+	seq_num = le16_to_cpu(local_rx_pd->seq_num);
+
+	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
+
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
+			    skb->len, rx_pkt_offset, rx_pkt_length);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	if (rx_pkt_type == PKT_TYPE_MGMT) {
+		ret = nxpwifi_process_mgmt_packet(priv, skb);
+		if (ret && (ret != -EINPROGRESS))
+			nxpwifi_dbg(adapter, DATA, "Rx of mgmt packet failed");
+		if (ret != -EINPROGRESS)
+			dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	/* If the packet is not an unicast packet then send the packet
+	 * directly to os. Don't pass thru rx reordering
+	 */
+	if (!IS_11N_ENABLED(priv) ||
+	    !ether_addr_equal_unaligned(priv->curr_addr,
+					rx_pkt_hdr->eth803_hdr.h_dest)) {
+		nxpwifi_process_rx_packet(priv, skb);
+		return ret;
+	}
+
+	if (nxpwifi_queuing_ra_based(priv)) {
+		memcpy(ta, rx_pkt_hdr->eth803_hdr.h_source, ETH_ALEN);
+	} else {
+		if (rx_pkt_type != PKT_TYPE_BAR &&
+		    local_rx_pd->priority < MAX_NUM_TID)
+			priv->rx_seq[local_rx_pd->priority] = seq_num;
+		memcpy(ta, priv->curr_bss_params.bss_descriptor.mac_address,
+		       ETH_ALEN);
+	}
+
+	/* Reorder and send to OS */
+	ret = nxpwifi_11n_rx_reorder_pkt(priv, seq_num, local_rx_pd->priority,
+					 ta, (u8)rx_pkt_type, skb);
+
+	if (ret || rx_pkt_type == PKT_TYPE_BAR)
+		dev_kfree_skb_any(skb);
+
+	if (ret)
+		priv->stats.rx_dropped++;
+
+	return ret;
+}
-- 
2.34.1


