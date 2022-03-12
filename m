Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A174D6DB6
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Mar 2022 10:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiCLJK4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Mar 2022 04:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiCLJKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Mar 2022 04:10:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED3193FA
        for <linux-wireless@vger.kernel.org>; Sat, 12 Mar 2022 01:09:48 -0800 (PST)
X-UUID: 140ee9ecec9449718c395902849fe2c6-20220312
X-UUID: 140ee9ecec9449718c395902849fe2c6-20220312
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1682957057; Sat, 12 Mar 2022 17:09:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 12 Mar 2022 17:09:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Mar 2022 17:09:42 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] iw: support 160MHz frequency command for 6GHz band
Date:   Sat, 12 Mar 2022 17:09:04 +0800
Message-ID: <4366b069d41f469c36554c8dcfc857b5aedf3e1d.1647075278.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Add support to configure 160MHz in 6G band by direct
channel/frequency command.

Example:
iw dev <interface> set freq 6195 160MHz

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 util.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/util.c b/util.c
index ceb0dc0..1bddf0f 100644
--- a/util.c
+++ b/util.c
@@ -1305,7 +1305,8 @@ int get_cf1(const struct chanmode *chanmode, unsigned long freq)
 				5955, 6035, 6115, 6195, 6275, 6355,
 				6435, 6515, 6595, 6675, 6755, 6835,
 				6195, 6995 };
-	unsigned int vht160[] = { 5180, 5500 };
+	unsigned int bw160[] = { 5180, 5500, 5955, 6115, 6275, 6435,
+				  6595, 6755, 6915 };
 
 	switch (chanmode->width) {
 	case NL80211_CHAN_WIDTH_80:
@@ -1322,15 +1323,15 @@ int get_cf1(const struct chanmode *chanmode, unsigned long freq)
 		break;
 	case NL80211_CHAN_WIDTH_160:
 		/* setup center_freq1 */
-		for (j = 0; j < ARRAY_SIZE(vht160); j++) {
-			if (freq >= vht160[j] && freq < vht160[j] + 160)
+		for (j = 0; j < ARRAY_SIZE(bw160); j++) {
+			if (freq >= bw160[j] && freq < bw160[j] + 160)
 				break;
 		}
 
-		if (j == ARRAY_SIZE(vht160))
+		if (j == ARRAY_SIZE(bw160))
 			break;
 
-		cf1 = vht160[j] + 70;
+		cf1 = bw160[j] + 70;
 		break;
 	default:
 		cf1 = freq + chanmode->freq1_diff;
-- 
2.25.1

