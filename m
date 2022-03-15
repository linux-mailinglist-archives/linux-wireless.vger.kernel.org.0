Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3010C4D9B8D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 13:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348470AbiCOMtj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiCOMtg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 08:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA55C4AE03
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647348497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qdjFfW4Egu5wJC/60VRjB5Q+2B1Nizx/lGSgqpzqJ78=;
        b=AHA6LdzEaHiPR0vzNOwM59xIHVB5s6lIvMyz4boW4kl95roegBJ2nkNj7D920HnV4D4OM+
        sm52az0fxqxDh8JPEdLRTCDYwj91SLTRF5akSl2M+KfFSKRrhL8pKt75rKmM81OTbRF9Us
        wQhSqkxciQUtrUIDs2uaZFy5S5CvaeA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-2DtNzB51OGyoMHkyBrvnXQ-1; Tue, 15 Mar 2022 08:48:16 -0400
X-MC-Unique: 2DtNzB51OGyoMHkyBrvnXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C45518E5346;
        Tue, 15 Mar 2022 12:48:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26408141ADA5;
        Tue, 15 Mar 2022 12:48:14 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH] rfkill: keep rfkill event compatibility with old userspace applications
Date:   Tue, 15 Mar 2022 13:48:11 +0100
Message-Id: <20220315124811.237037-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Old userspace applications (for example bluez version before c939747f543a),
that still use the original format for rfkill events (with 8 bytes size /
RFKILL_EVENT_SIZE_V1) and are not requesting any specific size but a large
one, are broken because they are checking the received size.

The reason is the new extended rfkill event format that is used by kernel, if
requested size is big enough.
Detailed operation of commented bluez versions, by means of strace output:
read(11, "\0\0\0\0\2\2\1\0\0", 32)      = 9
That is, as the new rfkill event size is 9, it will be rejected by commented
bluez versions (expected size 8).

In order to avoid this compatibility issue, we can try to adapt by checking
specific unusual requested sizes:
- bluez: 32
- gnome-settings-daemon: 1024
If this is the case, we will consider that we have to use the original size
(RFKILL_EVENT_SIZE_V1) and old applications will be able to work as ever.
For other values, we will follow the new behavior with extended events.
No other applications have been identified that behave in this way, so
reserved event sizes are defined.

Fixes: 71826654ce40 ("rfkill: revert back to old userspace API by default")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 include/uapi/linux/rfkill.h | 6 ++++++
 net/rfkill/core.c           | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rfkill.h b/include/uapi/linux/rfkill.h
index 9b77cfc42efa..821e304a1d8e 100644
--- a/include/uapi/linux/rfkill.h
+++ b/include/uapi/linux/rfkill.h
@@ -168,8 +168,14 @@ struct rfkill_event_ext {
  *    older kernel;
  * 3. treat reads that are as long as requested as acceptable, not
  *    checking against RFKILL_EVENT_SIZE_V1 or such.
+ * 4. in order to avoid compatibilities issues with older application
+ *    versions specifying unusual event size requests, those unusual
+ *    request event sizes will be considered reserved. If requested size
+ *    is reserved, the event size will be RFKILL_EVENT_SIZE_V1.
  */
 #define RFKILL_EVENT_SIZE_V1	sizeof(struct rfkill_event)
+#define RESERVED_RFKILL_EVENT_SIZE_1	32
+#define RESERVED_RFKILL_EVENT_SIZE_2	1024
 
 /* ioctl for turning off rfkill-input (if present) */
 #define RFKILL_IOC_MAGIC	'R'
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index b73a741a7923..494335d4f5f7 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1231,7 +1231,13 @@ static ssize_t rfkill_fop_read(struct file *file, char __user *buf,
 	ev = list_first_entry(&data->events, struct rfkill_int_event,
 				list);
 
-	sz = min_t(unsigned long, sizeof(ev->ev), count);
+	BUILD_BUG_ON(sizeof(ev->ev) == RESERVED_RFKILL_EVENT_SIZE_1 ||
+		sizeof(ev->ev) == RESERVED_RFKILL_EVENT_SIZE_2);
+	if (count == RESERVED_RFKILL_EVENT_SIZE_1 ||
+		count == RESERVED_RFKILL_EVENT_SIZE_2)
+		sz = RFKILL_EVENT_SIZE_V1;
+	else
+		sz = min_t(unsigned long, sizeof(ev->ev), count);
 	ret = sz;
 	if (copy_to_user(buf, &ev->ev, sz))
 		ret = -EFAULT;
-- 
2.27.0

My answer:

> On Tue, Mar 15, 2022 at 11:49 AM Johannes Berg <johannes@sipsolutions.net> wrote:

>    On Tue, 2022-03-15 at 11:26 +0100, Jose Ignacio Tornos Martinez wrote:
>    > Old userspace applications (for example bluez version before c939747f543a),
>    > that still use the original format for rfkill events (with 8 bytes size /
>    > RFKILL_EVENT_SIZE_V1) and are not requesting any specific size but a large
>    > one, are broken because they are checking the received size.
>
>    ... because they're *not* checking the received size.

 
I really wanted to say "because they're checking the received size", that is,
because older bluez is expecting 8, and as bluez bluez is receiving 9, it was
rejecting the event, and therefore it is broken.
 

>    g-s-d by the way is even more broken before the fixes, because it
>    assumes that this thing is a stream protocol, rather than individual
>    messages. This was never OK, it just happened to work anyway.

 
I tested g-s-d without their fixes and it keeps on working fine because
although the message was buffered, it took 8 byte event size and when it read
immediately again, it got another message with 1 byte that was rejected (8
bytes expected size) and this way exit from the loop.
At the end it is the same, if we receive only one message that is totally valid
and it exits because there is none immediately after this.
Although of course, it is more clean.
 

>    > In order to avoid this compatibility issue, we can try to adapt by checking
>    > specific unusual requested sizes:
>    > - bluez: 32
>    > - gnome-settings-daemon: 1024
>    > If this is the case, we will consider that we have to use the original size
>    > (RFKILL_EVENT_SIZE_V1) and old applications will be able to work as ever.
>    > For other values, we will follow the new behavior with extended events.
>
>    Now, however, applications that do use 32 or 1024 as the buffer size,
>    the latter of which, btw, is just the default glib size, not related to
>    g-s-d, will never be able to get the new data. They don't really need it
>    for now, but if we add anything else and keep this workaround,
>    applications will have to work around the kernel *again* and change
>    their read buffer size - which in the case of g-s-d, as I said above,
>    isn't even a conscious choice but comes from glib. 


Yes, I checked that because of glib, g-s-d was requesting 1024 bytes although
g-s-d itself was requesting only the event size. And this was fixed with the
related g-s-d commits to only request the information that is really requested.
And I think that only g-s-d is requesting rfkill events.
Anyway, as I commented g-s-d is working in the same practical way after and 
before, that is, it is able to switch on/off the bluetooth from gnome.
The real problem was with old versions of bluez. If you prefer to keep 1024 out
of scope, we could focus in bluez setting (only 32).
 

>    > No other applications have been identified that behave in this way, so
>    > reserved event sizes are defined.

>    I'm going to assume that you're doing this for RHEL, in which case I'm
>    not sure this even addresses your requirements - if there's an
>    application with read size 64 that you don't know about, it would still
>    possibly be broken?

 
Yes I am doing this for the RHEL, but perhaps others have found the same issue.
Although I have not found any other application accessing rfkill events in a
wrong way, no other problem has been detected, only with bluetooth.
If another similar problem is detected, we could easily add other exception.


>    I tend to think if you need a stable guarantee here you should probably
>    just revert the kernel patch instead.


>    I know there's no good choice here. This thing was intended to be
>    forward and backward compatible, but implementations got it wrong. We
>    therefore had a regression, but it was noticed fairly late after being
>    introduced, and so it was a bit difficult to revert. Also, there was
>    really no good other choice - perhaps we could have added /dev/rfkill2,
>    but ...

>    Ultimately, all the userspace folks basically said "oh yeah we got this
>    wrong" and fixed it pretty much immediately.

>    johannes


Yes I agree with you, it would be enough and easy to always send the 8 bytes
events from the kernel as before (at least for RHEL).
But, I am just trying to do it in a more compatible way, because as you said
we do not know the behavior of all applications using the rfkill.
That is, it is better to be backward compatible, trying to not break anything
that we do not know.
And on the other hand, wanting to be backwards compatible does not mean that we
are not open to improvements and I would not like to close this aspect. Drivers
and applications must be able to be updated and use the extended rfkiill event
feature.
So, since I don't think the rfkill event size will increase much we could open
a door to application compatibility without extra fixes (at least for the
bluez).
What do you think?

Thanks you very much for considering this

Best regards
José Ignacio

