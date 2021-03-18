Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4B3403E0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 11:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCRKvN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 06:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCRKun (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 06:50:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7967C06174A;
        Thu, 18 Mar 2021 03:50:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMqEg-0007xe-EQ; Thu, 18 Mar 2021 11:50:38 +0100
Message-ID: <c196f9cb7ba2487fb5aceceedf860cc24c6843f2.camel@sipsolutions.net>
Subject: Re: systemd-rfkill regression on 5.11 and later kernels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 18 Mar 2021 11:50:37 +0100
In-Reply-To: <s5ho8fgixl9.wl-tiwai@suse.de>
References: <s5ha6r0kgt5.wl-tiwai@suse.de>
         <54859a03b8789a2800596067e06c8adb49a107f5.camel@sipsolutions.net>
         <s5ho8fgixl9.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> OK, I took a deeper look again, and actually there are two issues in
> systemd-rfkill code:
> 
> * It expects 8 bytes returned from read while it reads a struct
>   rfkill_event record.  If the code is rebuilt with the latest kernel
>   headers, it breaks due to the change of rfkill_event.  That's the
>   error openSUSE bug report points to.

Right. It hardcoded the size check but not the size it reads.

> * When systemd-rfkill is built with the latest kernel headers but runs
>   on the old kernel code, the write size check fails as you mentioned
>   in the above.  That's another part of the github issue.

Yes. And it's all confusing, because they only later added the "this is
on 5.10" bits, and on pure 5.11 the second thing made no sense.

Same confusion bit the developer of the systemd fix, but nonetheless the
fix seems OK.

> So, with a kernel devs hat on, I share your feeling, that's an
> application bug.  OTOH, the extension of the rfkill_event is, well,
> not really safe as expected.

Evidently.

> IMO, if systemd-rfkill is the only one that hits such a problem, we
> may let the systemd code fixed, as it's obviously buggy.  But who
> knows...

We hit it in at least one other places, but that was just dev/test code,
I think.

> Is the extension of rfkill_event mandatory?  Can the new entry
> provided in a different way such as another sysfs record?

Yes, it is mandatory - it needs to be provided as an event. Well, I
guess in theory it's all software, but ... getting an event and then
having to poke a sysfs file is also a nightmare.

> IOW, if we revert the change, would it break anything else new?

It would break the necessary notification for the feature :)


That said, we can "fix" this like this, and hope we'll not get this
again? And if we do get it again ... well, we keep renaming the structs
and add "struct rfkill_event_v3" next time?



diff --git a/include/uapi/linux/rfkill.h b/include/uapi/linux/rfkill.h
index 03e8af87b364..9b77cfc42efa 100644
--- a/include/uapi/linux/rfkill.h
+++ b/include/uapi/linux/rfkill.h
@@ -86,34 +86,90 @@ enum rfkill_hard_block_reasons {
  * @op: operation code
  * @hard: hard state (0/1)
  * @soft: soft state (0/1)
+ *
+ * Structure used for userspace communication on /dev/rfkill,
+ * used for events from the kernel and control to the kernel.
+ */
+struct rfkill_event {
+	__u32 idx;
+	__u8  type;
+	__u8  op;
+	__u8  soft;
+	__u8  hard;
+} __attribute__((packed));
+
+/**
+ * struct rfkill_event_ext - events for userspace on /dev/rfkill
+ * @idx: index of dev rfkill
+ * @type: type of the rfkill struct
+ * @op: operation code
+ * @hard: hard state (0/1)
+ * @soft: soft state (0/1)
  * @hard_block_reasons: valid if hard is set. One or several reasons from
  *	&enum rfkill_hard_block_reasons.
  *
  * Structure used for userspace communication on /dev/rfkill,
  * used for events from the kernel and control to the kernel.
+ *
+ * See the extensibility docs below.
  */
-struct rfkill_event {
+struct rfkill_event_ext {
 	__u32 idx;
 	__u8  type;
 	__u8  op;
 	__u8  soft;
 	__u8  hard;
+
+	/*
+	 * older kernels will accept/send only up to this point,
+	 * and if extended further up to any chunk marked below
+	 */
+
 	__u8  hard_block_reasons;
 } __attribute__((packed));
 
-/*
- * We are planning to be backward and forward compatible with changes
- * to the event struct, by adding new, optional, members at the end.
- * When reading an event (whether the kernel from userspace or vice
- * versa) we need to accept anything that's at least as large as the
- * version 1 event size, but might be able to accept other sizes in
- * the future.
+/**
+ * DOC: Extensibility
+ *
+ * Originally, we had planned to allow backward and forward compatible
+ * changes by just adding fields at the end of the structure that are
+ * then not reported on older kernels on read(), and not written to by
+ * older kernels on write(), with the kernel reporting the size it did
+ * accept as the result.
+ *
+ * This would have allowed userspace to detect on read() and write()
+ * which kernel structure version it was dealing with, and if was just
+ * recompiled it would have gotten the new fields, but obviously not
+ * accessed them, but things should've continued to work.
+ *
+ * Unfortunately, while actually exercising this mechanism to add the
+ * hard block reasons field, we found that userspace (notably systemd)
+ * did all kinds of fun things not in line with this scheme:
+ *
+ * 1. treat the (expected) short writes as an error;
+ * 2. ask to read sizeof(struct rfkill_event) but then compare the
+ *    actual return value to RFKILL_EVENT_SIZE_V1 and treat any
+ *    mismatch as an error.
+ *
+ * As a consequence, just recompiling with a new struct version caused
+ * things to no longer work correctly on old and new kernels.
+ *
+ * Hence, we've rolled back &struct rfkill_event to the original version
+ * and added &struct rfkill_event_ext. This effectively reverts to the
+ * old behaviour for all userspace, unless it explicitly opts in to the
+ * rules outlined here by using the new &struct rfkill_event_ext.
+ *
+ * Userspace using &struct rfkill_event_ext must adhere to the following
+ * rules
  *
- * One exception is the kernel -- we already have two event sizes in
- * that we've made the 'hard' member optional since our only option
- * is to ignore it anyway.
+ * 1. accept short writes, optionally using them to detect that it's
+ *    running on an older kernel;
+ * 2. accept short reads, knowing that this means it's running on an
+ *    older kernel;
+ * 3. treat reads that are as long as requested as acceptable, not
+ *    checking against RFKILL_EVENT_SIZE_V1 or such.
  */
-#define RFKILL_EVENT_SIZE_V1	8
+#define RFKILL_EVENT_SIZE_V1	sizeof(struct rfkill_event)
 
 /* ioctl for turning off rfkill-input (if present) */
 #define RFKILL_IOC_MAGIC	'R'
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 68d6ef9e59fc..ac15a944573f 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -69,7 +69,7 @@ struct rfkill {
 
 struct rfkill_int_event {
 	struct list_head	list;
-	struct rfkill_event	ev;
+	struct rfkill_event_ext	ev;
 };
 
 struct rfkill_data {
@@ -253,7 +253,8 @@ static void rfkill_global_led_trigger_unregister(void)
 }
 #endif /* CONFIG_RFKILL_LEDS */
 
-static void rfkill_fill_event(struct rfkill_event *ev, struct rfkill *rfkill,
+static void rfkill_fill_event(struct rfkill_event_ext *ev,
+			      struct rfkill *rfkill,
 			      enum rfkill_operation op)
 {
 	unsigned long flags;
@@ -1237,7 +1238,7 @@ static ssize_t rfkill_fop_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *pos)
 {
 	struct rfkill *rfkill;
-	struct rfkill_event ev;
+	struct rfkill_event_ext ev;
 	int ret;
 
 	/* we don't need the 'hard' variable but accept it */



johannes

