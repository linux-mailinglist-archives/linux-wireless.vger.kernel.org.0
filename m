Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA73E0EB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfD2Kyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 06:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbfD2Kyo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 06:54:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9858130833C5;
        Mon, 29 Apr 2019 10:54:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E24769317;
        Mon, 29 Apr 2019 10:54:43 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [RFC/RFT 7/7] rt2800: do not enable watchdog by default
Date:   Mon, 29 Apr 2019 12:54:30 +0200
Message-Id: <1556535270-3551-8-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
References: <1556535270-3551-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Apr 2019 10:54:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make watchdog disabled by default and add module parameter to enable it.

User will have to create file in /etc/modprobe.d/ with

options rt2800lib watchdog=1

to enable the watchdog or load "rt2800lib watchdog=1" module manually
before loading rt2800{soc,pci,usb} module.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c  | 12 ++++++++++--
 drivers/net/wireless/ralink/rt2x00/rt2x00.h     |  1 +
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 7d488fa8ef05..0de7d9b509bc 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -41,6 +41,10 @@
 #include "rt2800lib.h"
 #include "rt2800.h"
 
+static bool modparam_watchdog;
+module_param_named(watchdog, modparam_watchdog, bool, S_IRUGO);
+MODULE_PARM_DESC(watchdog, "Enable watchdog.");
+
 /*
  * Register access.
  * All access to the CSR registers will go through the methods
@@ -10289,8 +10293,12 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev)
 		__set_bit(REQUIRE_TASKLET_CONTEXT, &rt2x00dev->cap_flags);
 	}
 
-	__set_bit(CAPABILITY_RESTART_HW, &rt2x00dev->cap_flags);
-	rt2x00dev->link.watchdog_interval = msecs_to_jiffies(100);
+	if (modparam_watchdog) {
+		__set_bit(CAPABILITY_RESTART_HW, &rt2x00dev->cap_flags);
+		rt2x00dev->link.watchdog_interval = msecs_to_jiffies(100);
+	} else {
+		rt2x00dev->link.watchdog_disabled = true;
+	}
 
 	/*
 	 * Set the rssi offset.
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 1d7eaa9ecffb..c76d41272b03 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -337,6 +337,7 @@ struct link {
 	 */
 	struct delayed_work watchdog_work;
 	unsigned int watchdog_interval;
+	bool watchdog_disabled;
 
 	/*
 	 * Work structure for scheduling periodic AGC adjustments.
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
index fcc59553918f..db4b164ac848 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
@@ -395,7 +395,7 @@ void rt2x00link_start_watchdog(struct rt2x00_dev *rt2x00dev)
 	struct link *link = &rt2x00dev->link;
 
 	if (test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags) &&
-	    rt2x00dev->ops->lib->watchdog)
+	    rt2x00dev->ops->lib->watchdog && !link->watchdog_disabled)
 		ieee80211_queue_delayed_work(rt2x00dev->hw,
 					     &link->watchdog_work,
 					     link->watchdog_interval);
-- 
2.7.5

