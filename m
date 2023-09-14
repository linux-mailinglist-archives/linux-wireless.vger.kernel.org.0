Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F54F7A0659
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbjINNq1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbjINNqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 09:46:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA06A7F
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=SewlRH4BqfyY6DtRr5maopqw1DFzhsDYOp+ZdKr9Dl8=; t=1694698569; x=1695908169; 
        b=EfSkfUga0wpk4LMGAsmjSfnIkR431hC4yeXTU/SQyDJz8ZWjJIjbRQ7PreXqCoBy9tfdeWEA8tL
        D5HTWWyW3g0XqLVrBsjP2rTWqEswvDhEZAUYRIrcrCHu3CP2NlcUbn+ohysHNZs12woyvk3YYEaU1
        yyZx7jWDLrviUK2mA+GLTpHzBNxL4xUPD1VzXjwClrv/TEjrehbi79Zu+/v0N1rYY2OCga8ejhHfC
        TSuBp7IHkyknKYgeE/Not9IFOUYHqj9ACIa1TVpU4bA4U/BFLWvyeK3Wu5aJ7GlC/KDIR+iGwwp5A
        gfFoeCYJhzhnWKLUqNjswkJyRx5QmBtgK7Qw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgmVr-00H5B8-1Y;
        Thu, 14 Sep 2023 15:36:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] rfkill: sync before userspace visibility/changes
Date:   Thu, 14 Sep 2023 15:36:05 +0200
Message-ID: <20230914153604.9d1ce0f43ac8.If977317d8f6a0f557090defcd6aef67628f62ff7@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If userspace quickly opens /dev/rfkill after a new
instance was created, it might see the old state of
the instance from before the sync work runs and may
even _change_ the state, only to have the sync work
change it again.

Fix this by doing the sync inline where needed, not
just for /dev/rfkill but also for sysfs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 v2: add lockdep assert
---
 net/rfkill/core.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 01fca7a10b4b..2768decb6cda 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -48,6 +48,7 @@ struct rfkill {
 	bool			persistent;
 	bool			polling_paused;
 	bool			suspended;
+	bool			need_sync;
 
 	const struct rfkill_ops	*ops;
 	void			*data;
@@ -730,6 +731,10 @@ static ssize_t soft_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
+	mutex_lock(&rfkill_global_mutex);
+	rfkill_sync(rfkill);
+	mutex_unlock(&rfkill_global_mutex);
+
 	return sysfs_emit(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_SW) ? 1 : 0);
 }
 
@@ -751,6 +756,7 @@ static ssize_t soft_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&rfkill_global_mutex);
+	rfkill_sync(rfkill);
 	rfkill_set_block(rfkill, state);
 	mutex_unlock(&rfkill_global_mutex);
 
@@ -783,6 +789,10 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
+	mutex_lock(&rfkill_global_mutex);
+	rfkill_sync(rfkill);
+	mutex_unlock(&rfkill_global_mutex);
+
 	return sysfs_emit(buf, "%d\n", user_state_from_blocked(rfkill->state));
 }
 
@@ -805,6 +815,7 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&rfkill_global_mutex);
+	rfkill_sync(rfkill);
 	rfkill_set_block(rfkill, state == RFKILL_USER_STATE_SOFT_BLOCKED);
 	mutex_unlock(&rfkill_global_mutex);
 
@@ -1030,16 +1041,23 @@ static void rfkill_uevent_work(struct work_struct *work)
 	mutex_unlock(&rfkill_global_mutex);
 }
 
+static void rfkill_sync(struct rfkill *rfkill)
+{
+	lockdep_assert_held(&rfkill_global_mutex);
+
+	if (!rfkill->need_sync)
+		return;
+
+	rfkill_set_block(rfkill, rfkill_global_states[rfkill->type].cur);
+	rfkill->need_sync = false;
+}
+
 static void rfkill_sync_work(struct work_struct *work)
 {
-	struct rfkill *rfkill;
-	bool cur;
-
-	rfkill = container_of(work, struct rfkill, sync_work);
+	struct rfkill *rfkill = container_of(work, struct rfkill, sync_work);
 
 	mutex_lock(&rfkill_global_mutex);
-	cur = rfkill_global_states[rfkill->type].cur;
-	rfkill_set_block(rfkill, cur);
+	rfkill_sync(rfkill);
 	mutex_unlock(&rfkill_global_mutex);
 }
 
@@ -1087,6 +1105,7 @@ int __must_check rfkill_register(struct rfkill *rfkill)
 			round_jiffies_relative(POLL_INTERVAL));
 
 	if (!rfkill->persistent || rfkill_epo_lock_active) {
+		rfkill->need_sync = true;
 		schedule_work(&rfkill->sync_work);
 	} else {
 #ifdef CONFIG_RFKILL_INPUT
@@ -1171,6 +1190,7 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 		ev = kzalloc(sizeof(*ev), GFP_KERNEL);
 		if (!ev)
 			goto free;
+		rfkill_sync(rfkill);
 		rfkill_fill_event(&ev->ev, rfkill, RFKILL_OP_ADD);
 		list_add_tail(&ev->list, &data->events);
 	}
-- 
2.41.0

