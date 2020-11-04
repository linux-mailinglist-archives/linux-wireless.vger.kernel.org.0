Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3D2A657B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgKDNrA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 08:47:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:10870 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbgKDNrA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 08:47:00 -0500
IronPort-SDR: XW/p97S3jNYKJWwz3l5Ex8jyJNSMTaX7eknVBGRH9+hCU9xO/mCp51F6z+ddywl9X5qyIQzbEm
 jmlVrMbX1EJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="165709704"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="165709704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 05:46:59 -0800
IronPort-SDR: DRoDJbKs4u2ZBuiXKdz1Tw45P4Q37iYXQH2x72/f+B6Nb2KbYEIdCi1EhGFLZm1uMbcd8YcwOV
 s0PHB1eqXW8Q==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="538927130"
Received: from deivensi-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.ger.corp.intel.com) ([10.255.194.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 05:46:56 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, ayala.beker@intel.com,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] rfkill: add a reason to the HW rfkill state
Date:   Wed,  4 Nov 2020 15:46:41 +0200
Message-Id: <20201104134641.28816-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WLAN device may exist yet not be usable. This can happen
when the WLAN device is controllable by both the host and
some platform internal component.
We need some arbritration that is vendor specific, but when
the device is not available for the host, we need to reflect
this state towards the user space.

Add a reason field to the rfkill object (and event) so that
userspace can know why the device is in rfkill: because some
other platform component currently owns the device, or
because the actual hw rfkill signal is asserted.

Capable userspace can now determine the reason for the rfkill
and possibly do some negotiation on a side band channel using
a proprietary protocol to gain ownership on the device in case
the device is owned by some other component. When the host
gains ownership on the device, the kernel can remove the
RFKILL_HARD_BLOCK_NOT_OWNER reason and the hw rfkill state
will be off. Then, the userspace can bring the device up and
start normal operation.

The rfkill_event structure is enlarged to include the additional
byte, it is now 9 bytes long. Old user space will ask to read
only 8 bytes so that the kernel can know not to feed them with
more data. When the user space writes 8 bytes, new kernels will
just read what is present in the file descriptor. This new byte
is read only from the userspace standpoint anyway.

If a new user space uses an old kernel, it'll ask to read 9 bytes
but will get only 8, and it'll know that it didn't get the new
state. When it'll write 9 bytes, the kernel will again ignore
this new byte which is read only from the userspace standpoint.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 include/linux/rfkill.h      | 24 +++++++++++++++++++++-
 include/uapi/linux/rfkill.h | 16 ++++++++++++++-
 net/rfkill/core.c           | 41 ++++++++++++++++++++++++++++++-------
 3 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
index 8ad2487a86d5..231e06b74b50 100644
--- a/include/linux/rfkill.h
+++ b/include/linux/rfkill.h
@@ -137,6 +137,17 @@ void rfkill_unregister(struct rfkill *rfkill);
  */
 void rfkill_destroy(struct rfkill *rfkill);
 
+/**
+ * rfkill_set_hw_state_reason - Set the internal rfkill hardware block state
+ *	with a reason
+ * @rfkill: pointer to the rfkill class to modify.
+ * @blocked: the current hardware block state to set
+ * @reason: one of &enum rfkill_hard_block_reasons
+ *
+ * Prefer to use rfkill_set_hw_state if you don't need any special reason.
+ */
+bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
+				bool blocked, unsigned long reason);
 /**
  * rfkill_set_hw_state - Set the internal rfkill hardware block state
  * @rfkill: pointer to the rfkill class to modify.
@@ -156,7 +167,11 @@ void rfkill_destroy(struct rfkill *rfkill);
  * should be blocked) so that drivers need not keep track of the soft
  * block state -- which they might not be able to.
  */
-bool rfkill_set_hw_state(struct rfkill *rfkill, bool blocked);
+static inline bool rfkill_set_hw_state(struct rfkill *rfkill, bool blocked)
+{
+	return rfkill_set_hw_state_reason(rfkill, blocked,
+					  RFKILL_HARD_BLOCK_SIGNAL);
+}
 
 /**
  * rfkill_set_sw_state - Set the internal rfkill software block state
@@ -256,6 +271,13 @@ static inline void rfkill_destroy(struct rfkill *rfkill)
 {
 }
 
+static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
+					      bool blocked,
+					      unsigned long reason)
+{
+	return blocked;
+}
+
 static inline bool rfkill_set_hw_state(struct rfkill *rfkill, bool blocked)
 {
 	return blocked;
diff --git a/include/uapi/linux/rfkill.h b/include/uapi/linux/rfkill.h
index 2e00dcebebd0..03e8af87b364 100644
--- a/include/uapi/linux/rfkill.h
+++ b/include/uapi/linux/rfkill.h
@@ -69,6 +69,16 @@ enum rfkill_operation {
 	RFKILL_OP_CHANGE_ALL,
 };
 
+/**
+ * enum rfkill_hard_block_reasons - hard block reasons
+ * @RFKILL_HARD_BLOCK_SIGNAL: the hardware rfkill signal is active
+ * @RFKILL_HARD_BLOCK_NOT_OWNER: the NIC is not owned by the host
+ */
+enum rfkill_hard_block_reasons {
+	RFKILL_HARD_BLOCK_SIGNAL	= 1 << 0,
+	RFKILL_HARD_BLOCK_NOT_OWNER	= 1 << 1,
+};
+
 /**
  * struct rfkill_event - events for userspace on /dev/rfkill
  * @idx: index of dev rfkill
@@ -76,6 +86,8 @@ enum rfkill_operation {
  * @op: operation code
  * @hard: hard state (0/1)
  * @soft: soft state (0/1)
+ * @hard_block_reasons: valid if hard is set. One or several reasons from
+ *	&enum rfkill_hard_block_reasons.
  *
  * Structure used for userspace communication on /dev/rfkill,
  * used for events from the kernel and control to the kernel.
@@ -84,7 +96,9 @@ struct rfkill_event {
 	__u32 idx;
 	__u8  type;
 	__u8  op;
-	__u8  soft, hard;
+	__u8  soft;
+	__u8  hard;
+	__u8  hard_block_reasons;
 } __attribute__((packed));
 
 /*
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 971c73c7d34c..10c72d7d5db7 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -40,6 +40,7 @@ struct rfkill {
 	enum rfkill_type	type;
 
 	unsigned long		state;
+	unsigned long		hard_block_reasons;
 
 	u32			idx;
 
@@ -265,6 +266,7 @@ static void rfkill_fill_event(struct rfkill_event *ev, struct rfkill *rfkill,
 	ev->hard = !!(rfkill->state & RFKILL_BLOCK_HW);
 	ev->soft = !!(rfkill->state & (RFKILL_BLOCK_SW |
 					RFKILL_BLOCK_SW_PREV));
+	ev->hard_block_reasons = rfkill->hard_block_reasons;
 	spin_unlock_irqrestore(&rfkill->lock, flags);
 }
 
@@ -522,19 +524,29 @@ bool rfkill_get_global_sw_state(const enum rfkill_type type)
 }
 #endif
 
-bool rfkill_set_hw_state(struct rfkill *rfkill, bool blocked)
+bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
+				bool blocked, unsigned long reason)
 {
 	unsigned long flags;
 	bool ret, prev;
 
 	BUG_ON(!rfkill);
 
+	if (WARN(reason &
+	    ~(RFKILL_HARD_BLOCK_SIGNAL | RFKILL_HARD_BLOCK_NOT_OWNER),
+	    "hw_state reason not supported: 0x%lx", reason))
+		return blocked;
+
 	spin_lock_irqsave(&rfkill->lock, flags);
-	prev = !!(rfkill->state & RFKILL_BLOCK_HW);
-	if (blocked)
+	prev = !!(rfkill->hard_block_reasons & reason);
+	if (blocked) {
 		rfkill->state |= RFKILL_BLOCK_HW;
-	else
-		rfkill->state &= ~RFKILL_BLOCK_HW;
+		rfkill->hard_block_reasons |= reason;
+	} else {
+		rfkill->hard_block_reasons &= ~reason;
+		if (!rfkill->hard_block_reasons)
+			rfkill->state &= ~RFKILL_BLOCK_HW;
+	}
 	ret = !!(rfkill->state & RFKILL_BLOCK_ANY);
 	spin_unlock_irqrestore(&rfkill->lock, flags);
 
@@ -546,7 +558,7 @@ bool rfkill_set_hw_state(struct rfkill *rfkill, bool blocked)
 
 	return ret;
 }
-EXPORT_SYMBOL(rfkill_set_hw_state);
+EXPORT_SYMBOL(rfkill_set_hw_state_reason);
 
 static void __rfkill_set_sw_state(struct rfkill *rfkill, bool blocked)
 {
@@ -744,6 +756,16 @@ static ssize_t soft_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(soft);
 
+static ssize_t hard_block_reasons_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct rfkill *rfkill = to_rfkill(dev);
+
+	return sprintf(buf, "0x%lx\n", rfkill->hard_block_reasons);
+}
+static DEVICE_ATTR_RO(hard_block_reasons);
+
 static u8 user_state_from_blocked(unsigned long state)
 {
 	if (state & RFKILL_BLOCK_HW)
@@ -796,6 +818,7 @@ static struct attribute *rfkill_dev_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_soft.attr,
 	&dev_attr_hard.attr,
+	&dev_attr_hard_block_reasons.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(rfkill_dev);
@@ -811,6 +834,7 @@ static int rfkill_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 	unsigned long flags;
+	unsigned long reasons;
 	u32 state;
 	int error;
 
@@ -823,10 +847,13 @@ static int rfkill_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 		return error;
 	spin_lock_irqsave(&rfkill->lock, flags);
 	state = rfkill->state;
+	reasons = rfkill->hard_block_reasons;
 	spin_unlock_irqrestore(&rfkill->lock, flags);
 	error = add_uevent_var(env, "RFKILL_STATE=%d",
 			       user_state_from_blocked(state));
-	return error;
+	if (error)
+		return error;
+	return add_uevent_var(env, "RFKILL_HW_BLOCK_REASON=0x%lx", reasons);
 }
 
 void rfkill_pause_polling(struct rfkill *rfkill)
-- 
2.17.1

