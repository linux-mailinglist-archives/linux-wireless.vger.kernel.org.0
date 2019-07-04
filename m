Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249075F701
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfGDLHC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jul 2019 07:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfGDLHC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jul 2019 07:07:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A98703E2B7;
        Thu,  4 Jul 2019 11:06:58 +0000 (UTC)
Received: from localhost (ovpn-204-157.brq.redhat.com [10.40.204.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2310E4DA30;
        Thu,  4 Jul 2019 11:06:57 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [RFC/RFT] rt2x00: do not set IEEE80211_TX_STAT_AMPDU_NO_BACK on tx status
Date:   Thu,  4 Jul 2019 13:06:52 +0200
Message-Id: <20190704110652.3955-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 04 Jul 2019 11:07:02 +0000 (UTC)
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

Perhaps we should send BAR exlicitly on BA session start/stop
and when remote STA went to PowerSave mode (for AP) like mt76 does.
But I do not understand for what this is needed.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index a6c374c483c2..c547bec044a8 100644
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
2.20.1

