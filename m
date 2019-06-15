Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3798946F5C
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 12:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfFOKBD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 06:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOKBD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 06:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34A9C30821F9;
        Sat, 15 Jun 2019 10:01:03 +0000 (UTC)
Received: from localhost (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C638C5DD7A;
        Sat, 15 Jun 2019 10:01:02 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH v2 1/7] rt2x00: allow to specify watchdog interval
Date:   Sat, 15 Jun 2019 12:00:54 +0200
Message-Id: <20190615100100.29800-2-sgruszka@redhat.com>
In-Reply-To: <20190615100100.29800-1-sgruszka@redhat.com>
References: <20190615100100.29800-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 15 Jun 2019 10:01:03 +0000 (UTC)
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
index 64a792a8fb2c..2b551dbe9844 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -325,6 +325,7 @@ struct link {
 	 * to bring the device/driver back into the desired state.
 	 */
 	struct delayed_work watchdog_work;
+	unsigned int watchdog_interval;
 
 	/*
 	 * Work structure for scheduling periodic AGC adjustments.
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
index 939cfa5141c6..15ebebf88e72 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
@@ -387,7 +387,7 @@ void rt2x00link_start_watchdog(struct rt2x00_dev *rt2x00dev)
 	    rt2x00dev->ops->lib->watchdog)
 		ieee80211_queue_delayed_work(rt2x00dev->hw,
 					     &link->watchdog_work,
-					     WATCHDOG_INTERVAL);
+					     link->watchdog_interval);
 }
 
 void rt2x00link_stop_watchdog(struct rt2x00_dev *rt2x00dev)
@@ -413,11 +413,16 @@ static void rt2x00link_watchdog(struct work_struct *work)
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
2.20.1

