Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9F4DAEC5
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352712AbiCPLS6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 07:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345088AbiCPLS5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 07:18:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA081654B0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=M+3Y0JPtnvP2hWqjzHAKlqzfja3K2mqPrHcDJzbm/AU=; t=1647429464; x=1648639064; 
        b=wAPxhZNdOLu4/IFj0812zPV5loDpbCi6LFLIKul2QW7SxOdpNJ0bPkI/hPezT8PMRwmB94ONU/U
        dQ5nZRA97syDovmMLEp33c9RCbBk2PDVPmnvo2N7onNesZWB/Qb+58JrOzGTZvWpEWxl/LbARaoPN
        m3zNql5nxL32VzrUnjv359VA5VpCS4iRMP/UbvyBtQP9O11FnZCK372xVzg5r0kxaY/CezKl8WHrP
        FvQMs77CjeGLHLWwgYqHoMwehecElxEXEtcjLeBI/1IhXqOkhyKwFtpvfPCZ1kwsCGOmzjvhmkPQ8
        ixJ6HWabD7ThAIqNSajUyPrYMOnOIpGTms0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nUReu-00DwaS-Ew;
        Wed, 16 Mar 2022 12:17:40 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] rfkill: make new event layout opt-in
Date:   Wed, 16 Mar 2022 12:17:32 +0100
Message-Id: <20220316121731.7f8c8ab05bdd.Ifcb1950998330a596f29a2a162e00b7546a1d6d0@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Again new complaints surfaced that we had broken the ABI here,
although previously all the userspace tools had agreed that it
was their mistake and fixed it. Yet now there are cases (e.g.
RHEL) that want to run old userspace with newer kernels, and
thus are broken.

Since this is a bit of a whack-a-mole thing, change the whole
extensibility scheme of rfkill to no longer just rely on the
message lengths, but instead require userspace to opt in via a
new ioctl to a given maximum event size that it is willing to
understand.

By default, set that to RFKILL_EVENT_SIZE_V1 (8), so that the
behaviour for userspace not calling the ioctl will look as if
it's just running on an older kernel.

Fixes: 14486c82612a ("rfkill: add a reason to the HW rfkill state")
Cc: stable@vger.kernel.org # 5.11+
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/rfkill.h | 14 +++++++++--
 net/rfkill/core.c           | 47 ++++++++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/rfkill.h b/include/uapi/linux/rfkill.h
index 9b77cfc42efa..283c5a7b3f2c 100644
--- a/include/uapi/linux/rfkill.h
+++ b/include/uapi/linux/rfkill.h
@@ -159,8 +159,16 @@ struct rfkill_event_ext {
  * old behaviour for all userspace, unless it explicitly opts in to the
  * rules outlined here by using the new &struct rfkill_event_ext.
  *
- * Userspace using &struct rfkill_event_ext must adhere to the following
- * rules
+ * Additionally, some other userspace (bluez, g-s-d) was reading with a
+ * large size but as streaming reads rather than message-based, or with
+ * too strict checks for the returned size. So eventually, we completely
+ * reverted this, and extended messages need to be opted in to by using
+ * an ioctl:
+ *
+ *  ioctl(fd, RFKILL_IOCTL_MAX_SIZE, sizeof(struct rfkill_event_ext));
+ *
+ * Userspace using &struct rfkill_event_ext and the ioctl must adhere to
+ * the following rules:
  *
  * 1. accept short writes, optionally using them to detect that it's
  *    running on an older kernel;
@@ -175,6 +183,8 @@ struct rfkill_event_ext {
 #define RFKILL_IOC_MAGIC	'R'
 #define RFKILL_IOC_NOINPUT	1
 #define RFKILL_IOCTL_NOINPUT	_IO(RFKILL_IOC_MAGIC, RFKILL_IOC_NOINPUT)
+#define RFKILL_IOC_MAX_SIZE	2
+#define RFKILL_IOCTL_MAX_SIZE	_IOW(RFKILL_IOC_MAGIC, RFKILL_IOC_EXT_SIZE, __u32)
 
 /* and that's all userspace gets */
 
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 5b1927d66f0d..7b6edeb38c1e 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -78,6 +78,7 @@ struct rfkill_data {
 	struct mutex		mtx;
 	wait_queue_head_t	read_wait;
 	bool			input_handler;
+	u8			max_size;
 };
 
 
@@ -1153,6 +1154,8 @@ static int rfkill_fop_open(struct inode *inode, struct file *file)
 	if (!data)
 		return -ENOMEM;
 
+	data->max_size = RFKILL_EVENT_SIZE_V1;
+
 	INIT_LIST_HEAD(&data->events);
 	mutex_init(&data->mtx);
 	init_waitqueue_head(&data->read_wait);
@@ -1235,6 +1238,7 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 				list);
 
 	sz = min_t(unsigned long, sizeof(ev->ev), count);
+	sz = min_t(unsigned long, sz, data->max_size);
 	ret = sz;
 	if (copy_to_user(buf, &ev->ev, sz))
 		ret = -EFAULT;
@@ -1249,6 +1253,7 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 static ssize_t rfkill_fop_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *pos)
 {
+	struct rfkill_data *data = file->private_data;
 	struct rfkill *rfkill;
 	struct rfkill_event_ext ev;
 	int ret;
@@ -1263,6 +1268,7 @@ static ssize_t rfkill_fop_write(struct file *file, const char __user *buf,
 	 * our API version even in a write() call, if it cares.
 	 */
 	count = min(count, sizeof(ev));
+	count = min_t(size_t, count, data->max_size);
 	if (copy_from_user(&ev, buf, count))
 		return -EFAULT;
 
@@ -1322,31 +1328,46 @@ static int rfkill_fop_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-#ifdef CONFIG_RFKILL_INPUT
 static long rfkill_fop_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct rfkill_data *data = file->private_data;
+	int ret = -ENOSYS;
+	u32 size;
 
 	if (_IOC_TYPE(cmd) != RFKILL_IOC_MAGIC)
 		return -ENOSYS;
 
-	if (_IOC_NR(cmd) != RFKILL_IOC_NOINPUT)
-		return -ENOSYS;
-
 	mutex_lock(&data->mtx);
-
-	if (!data->input_handler) {
-		if (atomic_inc_return(&rfkill_input_disabled) == 1)
-			printk(KERN_DEBUG "rfkill: input handler disabled\n");
-		data->input_handler = true;
+	switch (_IOC_NR(cmd)) {
+#ifdef CONFIG_RFKILL_INPUT
+	case RFKILL_IOC_NOINPUT:
+		if (!data->input_handler) {
+			if (atomic_inc_return(&rfkill_input_disabled) == 1)
+				printk(KERN_DEBUG "rfkill: input handler disabled\n");
+			data->input_handler = true;
+		}
+		ret = 0;
+		break;
+#endif
+	case RFKILL_IOC_MAX_SIZE:
+		if (get_user(size, (__u32 __user *)arg)) {
+			ret = -EFAULT;
+			break;
+		}
+		if (size < RFKILL_EVENT_SIZE_V1 || size > U8_MAX) {
+			ret = -EINVAL;
+			break;
+		}
+		data->max_size = size;
+		break;
+	default:
+		break;
 	}
-
 	mutex_unlock(&data->mtx);
 
-	return 0;
+	return ret;
 }
-#endif
 
 static const struct file_operations rfkill_fops = {
 	.owner		= THIS_MODULE,
@@ -1355,10 +1376,8 @@ static const struct file_operations rfkill_fops = {
 	.write		= rfkill_fop_write,
 	.poll		= rfkill_fop_poll,
 	.release	= rfkill_fop_release,
-#ifdef CONFIG_RFKILL_INPUT
 	.unlocked_ioctl	= rfkill_fop_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
-#endif
 	.llseek		= no_llseek,
 };
 
-- 
2.35.1

