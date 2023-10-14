Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC37C9310
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJNGz0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Oct 2023 02:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNGzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Oct 2023 02:55:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2109.outbound.protection.outlook.com [40.92.99.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B083
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 23:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8gIc5Rnv5k6PLrQLh6++rTFE3h6TiJDNLAhOojqeu35pQqlpuZi40SE9HkriGU+C6MRh7rDNd2SwGlbp2Yc3CpGxaf9z85GPxj5p6rb78gS1b3TADlW0pLzwKckRucJ2Nd09Es3x0GtyOCkGAgnXiLPrxZomNEAcOoqHkKL9cLJIlVadmiX6SIbDuwOyIL9Hfprxljr7VqASEDdGx+E3XSxg10wl1c2I3FGZjepORwJZcDEj7+bdqdaC4hxtJ0ni9CvU9DNx6bHVNBAgwgx3FDq+eWpXXWG+KTTgEq9B1XEo++jm3XaDJAV5m4u3TxcJZUpmaP16iu67mDFSakFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHkyyeYZYw8yrsNEZp3pB9iIQFv1UETmRjviTZ461oU=;
 b=MsAwrljtQal3Rzq0siNvjnXV+d6MxdaZ2mn3W4p2hd/vEgU9A7GBVcHe047fmFOh0N0AhQaE1pFqFZiyNUqV4EpwZ/x2f371LpqkE9taOJZU36WHkZY12P8uh5+6F8B+FJoqEUT2wBFHL6Ghpdn0PAJxXgWiTDGP+VOshfResApp4SlkPTeebim9G0NYN/DKrw1tdqO7hYMW1kL8d+p0xceXMRoI0up7MVVoh5ua3rti5eekJw+fJGN8rvhuajJzj6lbOiFeKm1PBALZH0YBiePosZuVQDPZF4E6h6N3LJADyMe6qrCG36lswxPqCL6oGFrofiIVC0CappyY0cmqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHkyyeYZYw8yrsNEZp3pB9iIQFv1UETmRjviTZ461oU=;
 b=d4Ok4/YT9VcUMi5KgtwcXpbqOCT5/ad8Mio9h7R+qvk+gWaZDJ9DCjNw5FKXsgkC6FDIu3jjUIEzoL1glrCCamc23VX6G16uqXbYykEXTNKeqkbApytZnLQ9aRsW7nba1s2UBp83qXw+7qvfv1NyZqleyvZ34dEqVvoC8t7Zp+Pr1cWUitb06pXj9B6ECBxfjOmsDEOyJui1f6K+lAxud1TohOJCD/8K++FfkCULl3qKyxBh4fZcFAeoA8vKvCGnObkccJmBN5rb+/LWwmWVrQy6fuIxzXF9rUv+7vYoFRiqJES8DmYeZEK67a9dL7cNCeE6l8Olb5n8/C8nJcbNbw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by OSZP286MB2332.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29; Sat, 14 Oct
 2023 06:55:20 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bbb1:a301:f7b6:744a%4]) with mapi id 15.20.6886.030; Sat, 14 Oct 2023
 06:55:20 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] wifi: rt2x00: fix rt2800 watchdog function
Date:   Sat, 14 Oct 2023 14:55:01 +0800
Message-ID: <TYAP286MB0315BC1D83D31154924F0D39BCD1A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ZcRznt3HgiZxV1aXQK0xnDrTWtoPqk9TbFczE7bnSSs=]
X-ClientProxiedBy: TYCP286CA0328.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::17) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231014065502.2841-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|OSZP286MB2332:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c5a1c7-f8ad-488c-6882-08dbcc82879b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX3FKwoXrgZeft6oQlGrtYi3K3ldmYK8odU2dm9tu+QzqEnlqgN1lI8T7geijsPWqg7EGWET4+/WSGegWEGPfWz9OQQsUebcw9JAUatXpW8Rsetja1M2kNrznAxHIf6AnR67uV0yOWjpGEV2A/yLyfySmIteh6ET6bYAe9N3zVbXzYRSSj1x3q/DQamO3anIFOq7N7Ic0rMdzeQGY1vpDtE7OeOktzGKfjcisy2qR4LBhpS4RgbkGtS1u+Muv7wzbv+0+K/28Sa+v2+MpVQg+VBctoRZ6wdC7mI5U0MjNZvQml4Bzu6hmkCsQX8wGYAlcXLamhlYcbOk1O/QnDZONvvCnMAbwWvRH/99HsB10SmUF5E65CnaCOiNithtvBswovZuHfDtoMLexX9MFg9PHHMKXVUz2GFodVfhBb4yPwGMj2W8lZ606QFSplxx8t0JUChP3j6zF8zgi1YE4hddbIEDDD3Lnjh49Mztg/7Nrm5w+CV0HGgEn+g454bFQdI4yvPsPW49IUhFoawVoAXIKQul2OQv8SVa3XP6NeTig9UKyx0FJ/XNziJ8vu2u6Wo6RxpSlKcviNLHrnar9Xcw61WN1c3E3e7kFp22r7rXZOQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJgy4Z+RvAfEtbjaEZrhqQaE7j8154BejNobzK/qXwNQPMk6RKuT2lpqUngS?=
 =?us-ascii?Q?vYUheyC+Im1yqT7z2AEokrmMcjIrxukDfou28e2pDx+BaovHAV2lyRASn9JE?=
 =?us-ascii?Q?NZWmfi6nIk6icd331tN95d4IVZl1zuOCIek47j8ZrrI6pYA+9Tmyj2ltx3hU?=
 =?us-ascii?Q?7uy5qFdE0Qz9A2ZlCjv0sXPQeubvVcoi50YOBesFqTNqd2/QBvUWJjMjij7u?=
 =?us-ascii?Q?3h/0zRCWTcI5uA35lS4wTmUxRh2x/ogXnPF+hpy/DSE0negnSz2CUjkXcjEf?=
 =?us-ascii?Q?32M2bpOClUctLbT/W+74OxK+MEY70G8WHf3+k7dJ/4Eu6oelBxoKrawbe1UX?=
 =?us-ascii?Q?HxSc6h36LPv37NSy/O+CKI2Z2nfcq35DwR4Kddf3N7HUAYQdRwwY+v/CTJq2?=
 =?us-ascii?Q?1S0xWGStbe4XeWzPKsdXi6TJSDqToccJISmiihUiOtDkDG1AWh7BnjwJnrux?=
 =?us-ascii?Q?1tjoWxw933jNEUDlwB1yTMHtrTFyEQsiyzgHsqEpOTPkR9jDl2NJ3nFVmqJs?=
 =?us-ascii?Q?lEiGjbkNG98FiefY/ZUZ8GAtJ7BNxozZDPKhZ9t7ZtcbpmvmBaR4WZKbWQAC?=
 =?us-ascii?Q?NbQqeCZ+ZiZO2KgC9EZbKxrOGm0jvwSVM6Vgh98+4IHmA+G6w7ZMxJ7d3fls?=
 =?us-ascii?Q?lChZ88BCDAiowIx4nw66xKGe9vHV6jomv2pNRvqbE8XroIc3e97cjW/trTwW?=
 =?us-ascii?Q?S15z5BH5jEBP+PPmJ8CGhtPlaQrBekOKMr5zLPcnLwvwr2ATxezYl8QPyxnG?=
 =?us-ascii?Q?gtjDm2dbmxOfA7zuEeNsF1qeXk4uYnse38pwzLK5HA0ZtoFzYXtH1AFCGavy?=
 =?us-ascii?Q?kxjfvkq9tjUlf/g/tV5jzsERfTS+oPnqmkVFB/bg/McSQ22rFI0R0LprAb5i?=
 =?us-ascii?Q?QN9jcYH3SiuKKMtJQJR4TY0+23/dxgiLLdkL4qFy8fJXejpXXWs2KO36K8LO?=
 =?us-ascii?Q?ibVDqumLI7/SrErHW2Q0dXGbR3xemqe9RQNa6iR0aRj9afhCr7XNCwmgQ+Q9?=
 =?us-ascii?Q?f4lKoMnxWIpZfMe2ma0hTT4DVUsypwi1rTHD47M0eJOpQoMKMDHWuqmzaFNX?=
 =?us-ascii?Q?SxORKcmmDEVjN4AuFBj7hSVZIl6fHYPjgmhkG+5RR/igwitTY58aL6LZgfxe?=
 =?us-ascii?Q?El0mnWOaIWcDy3fDusKUxKIfTURyBkfu7Cl5Nyu63DWd3ClOPLWx0A4Rw/mL?=
 =?us-ascii?Q?Rw3A4i2RRm1tAHVxEjRrff9OqaZwCH2GHhSCcFw3cgAgRs0WhXJmOmJjW44?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c5a1c7-f8ad-488c-6882-08dbcc82879b
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 06:55:20.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2332
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The watchdog function is broken on rt2800 series SoCs. This patch
fixes the incorrect watchdog logic to make it work again.

1. Update current wdt queue index if it's not equal to the previous
   index. Watchdog compares the current and previous queue index to
   judge if the queue hung.
2. Make sure hung_{rx,tx} 'true' status won't be override by the
   normal queue. Any queue hangs should trigger a reset action.
3. Clear the watchdog counter of all queues before resetting the
   hardware. This change may help to avoid the reset loop.
4. Change hang check function return type to bool as we only need
   to return two status, yes or no.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index e65cc00fa..d39d87827 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1236,13 +1236,14 @@ void rt2800_txdone_nostatus(struct rt2x00_dev *rt2x00dev)
 }
 EXPORT_SYMBOL_GPL(rt2800_txdone_nostatus);
 
-static int rt2800_check_hung(struct data_queue *queue)
+static bool rt2800_check_hung(struct data_queue *queue)
 {
 	unsigned int cur_idx = rt2800_drv_get_dma_done(queue);
 
-	if (queue->wd_idx != cur_idx)
+	if (queue->wd_idx != cur_idx) {
+		queue->wd_idx = cur_idx;
 		queue->wd_count = 0;
-	else
+	} else
 		queue->wd_count++;
 
 	return queue->wd_count > 16;
@@ -1279,7 +1280,7 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 		case QID_MGMT:
 			if (rt2x00queue_empty(queue))
 				continue;
-			hung_tx = rt2800_check_hung(queue);
+			hung_tx = hung_tx || rt2800_check_hung(queue);
 			break;
 		case QID_RX:
 			/* For station mode we should reactive at least
@@ -1288,7 +1289,7 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 			 */
 			if (rt2x00dev->intf_sta_count == 0)
 				continue;
-			hung_rx = rt2800_check_hung(queue);
+			hung_rx = hung_rx || rt2800_check_hung(queue);
 			break;
 		default:
 			break;
@@ -1301,8 +1302,12 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 	if (hung_rx)
 		rt2x00_warn(rt2x00dev, "Watchdog RX hung detected\n");
 
-	if (hung_tx || hung_rx)
+	if (hung_tx || hung_rx) {
+		queue_for_each(rt2x00dev, queue)
+			queue->wd_count = 0;
+
 		ieee80211_restart_hw(rt2x00dev->hw);
+	}
 }
 EXPORT_SYMBOL_GPL(rt2800_watchdog);
 
-- 
2.39.2

