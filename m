Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751059A83F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbfHWHJ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 03:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388050AbfHWHJ7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 03:09:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 117AA102700F;
        Fri, 23 Aug 2019 07:09:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADC2C5D6B2;
        Fri, 23 Aug 2019 07:09:58 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>
Subject: [PATCH] rt2x00: do not set IEEE80211_TX_STAT_AMPDU_NO_BACK on tx status
Date:   Fri, 23 Aug 2019 09:09:56 +0200
Message-Id: <1566544196-20371-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 23 Aug 2019 07:09:59 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to documentation IEEE80211_TX_STAT_AMPDU_NO_BACK is suppose
to be used when we do not recive BA (BlockAck). However on rt2x00 we
use it when remote station fail to decode one or more subframes within
AMPDU (some bits are not set in BlockAck bitmap). Setting the flag result
in sent of BAR (BlockAck Request) frame and this might result of abuse
of BA session, since remote station can sent BA with incorrect
sequence numbers after receiving BAR. This problem is visible especially
when connecting two rt2800 devices.

Previously I observed some performance benefits when using the flag
when connecting with iwlwifi devices. But currently possibly due
to reacent changes in rt2x00 removing the flag has no effect on
those test cases.

So remove the IEEE80211_TX_STAT_AMPDU_NO_BACK.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 9d158237ac67..c3eab767bc21 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -371,9 +371,6 @@ static void rt2x00lib_fill_tx_status(struct rt2x00_dev *rt2x00dev,
 				  IEEE80211_TX_CTL_AMPDU;
 		tx_info->status.ampdu_len = 1;
 		tx_info->status.ampdu_ack_len = success ? 1 : 0;
-
-		if (!success)
-			tx_info->flags |= IEEE80211_TX_STAT_AMPDU_NO_BACK;
 	}
 
 	if (rate_flags & IEEE80211_TX_RC_USE_RTS_CTS) {
-- 
1.9.3

