Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF5C4D98B3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 11:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiCOK2D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiCOK2B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 06:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3B3046154
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647340008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ALPj10b6PIXURNLcBHdsa5ADOQx31RG0i9g5xTk8F/g=;
        b=YG6/dB2sKEMM1bXh7bdShh0V9TmQbs4TY8c6VJ9YJR0I2DMEHGFqJUP/3mlm6EhiO3zDGy
        0Gmy6U2vEeyAh6FXB0fT8mj0RU4NMrwQ0Ck4PDz7PJVqmoQb1UGp4/3FutmATiyoCJZZTY
        LRkmI4C6f4cWSjbIToovp2bXId7VXRA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-dzuw5pmnNt6eRSAK8rCZsQ-1; Tue, 15 Mar 2022 06:26:47 -0400
X-MC-Unique: dzuw5pmnNt6eRSAK8rCZsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A4302999B44;
        Tue, 15 Mar 2022 10:26:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63F6F145B961;
        Tue, 15 Mar 2022 10:26:46 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH] rfkill: keep rfkill event compatibility with old userspace applications
Date:   Tue, 15 Mar 2022 11:26:41 +0100
Message-Id: <20220315102641.233703-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

