Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D37E0E4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 12:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfD2Kyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 06:54:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbfD2Kyf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 06:54:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0072C3092669;
        Mon, 29 Apr 2019 10:54:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7049D5D71B;
        Mon, 29 Apr 2019 10:54:34 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [RFC/RFT 1/7] rt2x00: allow to specify watchdog interval
Date:   Mon, 29 Apr 2019 12:54:24 +0200
Message-Id: <1556535270-3551-2-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
References: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Apr 2019 10:54:35 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow subdriver to change watchdog interval by intialize
link->watchdog_interval value before rt2x00link_register().

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00.h     |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 4b1744e9fb78..a241efa0a4f5 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -336,6 +336,7 @@ struct link {
 	 * to bring the device/driver back into the desired state.
 	 */
 	struct delayed_work watchdog_work;
+	unsigned int watchdog_interval;
 
 	/*
 	 * Work structure for scheduling periodic AGC adjustments.
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
index 2010a7715f21..fcc59553918f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
@@ -398,7 +398,7 @@ void rt2x00link_start_watchdog(struct rt2x00_dev *rt2x00dev)
 	    rt2x00dev->ops->lib->watchdog)
 		ieee80211_queue_delayed_work(rt2x00dev->hw,
 					     &link->watchdog_work,
-					     WATCHDOG_INTERVAL);
+					     link->watchdog_interval);
 }
 
 void rt2x00link_stop_watchdog(struct rt2x00_dev *rt2x00dev)
@@ -424,11 +424,16 @@ static void rt2x00link_watchdog(struct work_struct *work)
 	if (test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags))
 		ieee80211_queue_delayed_work(rt2x00dev->hw,
 					     &link->watchdog_work,
-					     WATCHDOG_INTERVAL);
+					     link->watchdog_interval);
 }
 
 void rt2x00link_register(struct rt2x00_dev *rt2x00dev)
 {
-	INIT_DELAYED_WORK(&rt2x00dev->link.watchdog_work, rt2x00link_watchdog);
-	INIT_DELAYED_WORK(&rt2x00dev->link.work, rt2x00link_tuner);
+	struct link *link = &rt2x00dev->link;
+
+	INIT_DELAYED_WORK(&link->work, rt2x00link_tuner);
+	INIT_DELAYED_WORK(&link->watchdog_work, rt2x00link_watchdog);
+
+	if (link->watchdog_interval == 0)
+		link->watchdog_interval = WATCHDOG_INTERVAL;
 }
-- 
2.7.5

