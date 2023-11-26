Return-Path: <linux-wireless+bounces-83-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FC57F9523
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Nov 2023 20:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8536B20995
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Nov 2023 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7812B91;
	Sun, 26 Nov 2023 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="fpUYTo3S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F910101
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 11:54:03 -0800 (PST)
Received: (wp-smtpd smtp.wp.pl 33874 invoked from network); 26 Nov 2023 20:53:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1701028439; bh=fIw6JBfGJ9D5jHE9lajyY1rU5jBFF2lCoAqnAfgMKRc=;
          h=From:To:Subject;
          b=fpUYTo3SHk6fJO34OesHPy8eHRjENQHbKRIWa9fWrPXzoPgU0oQzUn0xQbhn8NZya
           SX54UAzcZTjocePhwNTzyHVdq2yrSah6jUeU5wfi/EgU4/mMHo5xhbWSmkrq57g6dt
           KnadqtQcjUK4RotcNkdqD/5gDtHIq9fEdnMS9pSw=
Received: from 89-64-13-169.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.169])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-wireless@vger.kernel.org>; 26 Nov 2023 20:53:59 +0100
From: stf_xl@wp.pl
To: linux-wireless@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] wifi: rt2x00: make watchdog param per device
Date: Sun, 26 Nov 2023 20:53:58 +0100
Message-Id: <20231126195358.500259-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: d7c4fa389bb79fa560c20e13cf665e13
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [cXNE]                               

From: Stanislaw Gruszka <stf_xl@wp.pl>

We can run PCI/MMIO devices together with USB devices in the system.
Make watchdog parameter per device to avoid situation when plugin
USB device change modparam_watchdog for PCI/MMIO device.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
Shiji, could you please test it on your setup and give Tested-by: tag ?

 drivers/net/wireless/ralink/rt2x00/rt2800lib.c  | 11 +++++------
 drivers/net/wireless/ralink/rt2x00/rt2x00.h     |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 44127a036ac1..f93c7844dd42 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1353,10 +1353,10 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 	if (test_bit(DEVICE_STATE_SCANNING, &rt2x00dev->flags))
 		return;
 
-	if (modparam_watchdog & RT2800_WATCHDOG_DMA_BUSY)
+	if (rt2x00dev->link.watchdog & RT2800_WATCHDOG_DMA_BUSY)
 		reset = rt2800_watchdog_dma_busy(rt2x00dev);
 
-	if (modparam_watchdog & RT2800_WATCHDOG_HANG)
+	if (rt2x00dev->link.watchdog & RT2800_WATCHDOG_HANG)
 		reset = rt2800_watchdog_hung(rt2x00dev) || reset;
 
 	if (reset)
@@ -12058,14 +12058,13 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev)
 		__set_bit(REQUIRE_TASKLET_CONTEXT, &rt2x00dev->cap_flags);
 	}
 
+	rt2x00dev->link.watchdog = modparam_watchdog;
 	/* USB NICs don't support DMA watchdog as INT_SOURCE_CSR is invalid */
 	if (rt2x00_is_usb(rt2x00dev))
-		modparam_watchdog &= ~RT2800_WATCHDOG_DMA_BUSY;
-	if (modparam_watchdog) {
+		rt2x00dev->link.watchdog &= ~RT2800_WATCHDOG_DMA_BUSY;
+	if (rt2x00dev->link.watchdog) {
 		__set_bit(CAPABILITY_RESTART_HW, &rt2x00dev->cap_flags);
 		rt2x00dev->link.watchdog_interval = msecs_to_jiffies(100);
-	} else {
-		rt2x00dev->link.watchdog_disabled = true;
 	}
 
 	/*
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 62fed38f41c0..82af01448a0a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -334,7 +334,7 @@ struct link {
 	 */
 	struct delayed_work watchdog_work;
 	unsigned int watchdog_interval;
-	bool watchdog_disabled;
+	unsigned int watchdog;
 
 	/*
 	 * Work structure for scheduling periodic AGC adjustments.
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
index 6cf7e7c997c2..fb23d409fba8 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
@@ -384,7 +384,7 @@ void rt2x00link_start_watchdog(struct rt2x00_dev *rt2x00dev)
 	struct link *link = &rt2x00dev->link;
 
 	if (test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags) &&
-	    rt2x00dev->ops->lib->watchdog && !link->watchdog_disabled)
+	    rt2x00dev->ops->lib->watchdog && link->watchdog)
 		ieee80211_queue_delayed_work(rt2x00dev->hw,
 					     &link->watchdog_work,
 					     link->watchdog_interval);
-- 
2.42.0


