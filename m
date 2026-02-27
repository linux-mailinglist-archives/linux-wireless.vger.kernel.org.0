Return-Path: <linux-wireless+bounces-32265-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJjHC80coWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32265-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:25:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F81B2AC6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9032231DEA7F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEED346769;
	Fri, 27 Feb 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="MTxJwAwn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820C346E4F
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165674; cv=none; b=mop0tozSIheTv/GUDYFD9KKBSSuhsBL1u3wxg82M5KjGQib0KKkCd+1l345PZ0Sqg0GkZJfn31CaaUnbNeTHcBzZOqQyhuiXoabZRUzcCUQkcewBNgTRX5pd6muVfEKGBQESSCOZUYaoyf2q9vs9o1FandSyaTEBRWFleUaq9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165674; c=relaxed/simple;
	bh=yOsJSh3Vhhg/GT1f+DCZKiJ38CSdkXKz2GEpWLI6yg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REEgRaGu61fJcp5IuFUYBhge+QOA94jijY2mcjPvHTnrVBznFj02OAzZ7N3CvaRzfh87DHAdwn7T4QCvkSOII5ig9hTjlfGUXAZ9RtLNnbrIl//QY0C1VkneVFJR94icagmsTfNTUnG2Ky6Q6gxPfBQwgEt/DVPM2seGVNyOPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=MTxJwAwn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ada721eda1so7177935ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165672; x=1772770472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFNRnA0KgClJPtRTQz4TsvIk5gMX62pgM6fRpQ1YF1M=;
        b=MTxJwAwn8f4dYeILar651O7ORnQV9BedVMvMTQVAyUSkJYFCBGvHl1e34QqxgY5/l/
         tsrIaV9yV15bHSewkjSr2ja1nxi0R7pEjsuZeQjhcBrkiSn3denHDSAcykMFXzEZwYdI
         KCPgfQhVvTgv0TyNRHYsUL5acxCfLifnjK/n5X8BH3IXe3hZoXQXF2u9FcsSBWvCMcly
         q8y0+j8hGlnGV8GTmTe21nu6RAqpQZalFdarvs2E4fy7VwUEhb/I8zmE8TPZIWfDvepw
         S1bhKDKBo0+/ETgup2OgZOPgDOgrI2rW9VIbWzWRu0E54vqEaQ+/8cnSEHNtFoBkPXZS
         fEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165672; x=1772770472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFNRnA0KgClJPtRTQz4TsvIk5gMX62pgM6fRpQ1YF1M=;
        b=AGqNNdcxhPOTU4OeNAML/B3Q5dJCr8/gkb4Ks9MzuIXwSRXXFp8vbRJy3W9pVPPcFt
         FW+t/Ioifp4GnY7S63GsNi1osIJGFOb00P3GTVJbrFlIQovdNeEtso1sIrIddRf3oHIv
         D7pGsUHNQmgdKDbxSOtLVwwMIQty56G4wQZSkaQfDXz0s5u70Jw0LJB4ztNsMBHngW74
         BzNmGiI5drY7UehjNOb1gU9ZvlH3LlbvN3cAd/broIj51gxsUnc++P8sDd3fM5MuRUNH
         miDBYwdemS9bEckJRLfj/L42WHyhN8rMeU2C+4p3UR3moVAl2I3uhyayQ8yptUw4V0j0
         loWw==
X-Forwarded-Encrypted: i=1; AJvYcCXQWHmgYQLSiyEQiPeExu1TxOcdlua5ZRZqgfry8yxEtqAKnAnr2huK5sWywvfVdcau3hIvNcWV+1T635E16w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnB05kMV+euvKUOc5NHrquCZv8SFWw0W0E2LFFzHdPcbj14cd
	coXgcA/WIGFElCGBwG7Zp37/gCVq4iRBBwuLGElJQiMjGCRAnS8XTdai2MuTZzILySIUN/JOs2j
	M+ov6
X-Gm-Gg: ATEYQzwhofzm2gEKlvwkapB4vKzmOi3c+D8F3wAn8HvWqUKhjkCpVoIuA24oK4xfBzs
	qmt0sbd3OWQzcQsqvHLFUwoJgi+0HREtRbjYPCy1lUu8bdcyU0ncySp+iTqMDZOiydogdfekYgX
	8q3eScM5na2ij8CWZHTVBHDLWrDXTaquW4RseotwnJOWJgX4ph3gXO5E58bk33KayGWx95MgY48
	OGv6G+aA3U/uTFARZ+gfkjZmtAfbBe6RF3Mvzqq0voCsjTXZCL7JN2G4AmDZrK433NQ11Lgj7E7
	P82Z8anfXkftsTGJtAu8lW5z+dJX2ZGfN5XedS1c/25B5Kq+LGCKrIeEq7rZsUf23qTDgaJCzwD
	IVnCgqkuvRfrRB50H6tkTux6pvPF7Ye1WjyYAG2tugMtAaVCFMAZ7fyVPFOZuGfU0/o84uDij60
	b5Oui1Ex6SJm6C/BY91PmUqR787cpufqBQuOBN8zGZ3mETAZSLd+2pe3FvWtyMfZp2LjKgEU24K
	vrhSsUqycPuZ0J9gJIeGWiLexfIODo=
X-Received: by 2002:a17:903:1aad:b0:2aa:ecec:a43d with SMTP id d9443c01a7336-2ae2e401f52mr11923785ad.21.1772165671586;
        Thu, 26 Feb 2026 20:14:31 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:31 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 26/35] wifi: mm81x: add usb.c
Date: Fri, 27 Feb 2026 15:10:36 +1100
Message-ID: <20260227041108.66508-27-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32265-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 991F81B2AC6
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/usb.c | 971 ++++++++++++++++++++
 1 file changed, 971 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/usb.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/usb.c b/drivers/net/wireless/morsemicro/mm81x/usb.c
new file mode 100644
index 000000000000..1a08a2eceadf
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/usb.c
@@ -0,0 +1,971 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "hif.h"
+#include "bus.h"
+#include "debug.h"
+#include "mac.h"
+#include "core.h"
+
+/*
+ * URB timeout in milliseconds. If an URB does not complete within this
+ * time, it will be killed. This timeout needs to account for USB suspendand
+ * resume occurring before the URB can be transferred, and it also needs to
+ * account for transferring USB_MAX_TRANSFER_SIZE bytes over a potentially
+ * slow, congested USB Full Speed link.
+ */
+#define URB_TIMEOUT_MS 250
+
+/* High speed USB 2^(4-1) * 125usec = 1msec */
+#define MM81X_USB_INTERRUPT_INTERVAL 4
+
+/* Max bytes per USB read/write */
+#define USB_MAX_TRANSFER_SIZE (16 * 1024)
+
+/* INT EP buffer size */
+#define MM81X_EP_INT_BUFFER_SIZE 8
+
+/* Morse vendor IDs*/
+#define MM81X_VENDOR_ID 0x325b
+#define MM81X_MM810X_PRODUCT_ID 0x8100
+
+/* Power management runtime auto-suspend delay value in milliseconds */
+#define PM_RUNTIME_AUTOSUSPEND_DELAY_MS 100
+
+enum mm81x_usb_endpoints {
+	MM81X_EP_CMD = 0,
+	MM81X_EP_INT,
+	MM81X_EP_MEM_RD,
+	MM81X_EP_MEM_WR,
+	MM81X_EP_REG_RD,
+	MM81X_EP_REG_WR,
+	MM81X_EP_EP_MAX,
+};
+
+struct mm81x_usb_endpoint {
+	unsigned char *buffer;
+	struct urb *urb;
+	__u8 addr;
+	int size;
+};
+
+enum mm81x_usb_flags { MM81X_USB_FLAG_ATTACHED, MM81X_USB_FLAG_SUSPENDED };
+
+struct mm81x_usb {
+	struct usb_device *udev;
+	struct usb_interface *interface;
+	struct mm81x_usb_endpoint endpoints[MM81X_EP_EP_MAX];
+	int errors;
+
+	/* serialise USB device struct */
+	struct mutex lock;
+
+	/* serialise USB bus access */
+	struct mutex bus_lock;
+
+	bool ongoing_cmd;
+	bool ongoing_rw;
+	wait_queue_head_t rw_in_wait;
+	unsigned long flags;
+};
+
+enum mm81x_usb_command_direction {
+	MM81X_USB_WRITE = 0x00,
+	MM81X_USB_READ = 0x80,
+	MM81X_USB_RESET = 0x02,
+};
+
+struct mm81x_usb_command {
+	__le32 dir; /* Next BULK direction */
+	__le32 address; /* Next BULK address */
+	__le32 length; /* Next BULK size */
+};
+
+static const struct usb_device_id mm81x_usb_table[] = {
+	{ USB_DEVICE(MM81X_VENDOR_ID, MM81X_MM810X_PRODUCT_ID) },
+	{} /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, mm81x_usb_table);
+
+static void mm81x_usb_irq_work(struct work_struct *work)
+{
+	struct mm81x *mm = container_of(work, struct mm81x, usb_irq_work);
+
+	mm81x_claim_bus(mm);
+	mm81x_hw_irq_handle(mm);
+	mm81x_release_bus(mm);
+}
+
+/*
+ * See https://www.kernel.org/doc/html/v5.15/driver-api/usb/error-codes.html
+ * Error codes returned by in urb->status which indicate disconnect.
+ */
+static bool mm81x_usb_urb_status_is_disconnect(const struct urb *urb)
+{
+	return ((urb->status == -EPROTO) || (urb->status == -EILSEQ) ||
+		(urb->status == -ETIME) || (urb->status == -EPIPE));
+}
+
+static void mm81x_usb_int_handler(struct urb *urb)
+{
+	int ret;
+	struct mm81x *mm = urb->context;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return;
+
+	if (urb->status) {
+		if (mm81x_usb_urb_status_is_disconnect(urb)) {
+			clear_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags);
+			set_bit(MM81X_STATE_CHIP_UNRESPONSIVE,
+				&mm->state_flags);
+			mm81x_dbg(mm, MM81X_DBG_USB,
+				  "USB sudden disconnect detected in %s",
+				  __func__);
+			return;
+		}
+
+		if (!(urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		      urb->status == -ESHUTDOWN))
+			mm81x_err(mm, "- nonzero read status received: %d",
+				  urb->status);
+	}
+
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+
+	/* usb_kill_urb has been called */
+	if (ret == -EPERM)
+		return;
+	else if (ret)
+		mm81x_err(mm, "error: resubmit urb %p err code %d", urb, ret);
+
+	queue_work(mm->chip_wq, &mm->usb_irq_work);
+}
+
+static int mm81x_usb_int_enable(struct mm81x *mm)
+{
+	int ret = 0;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	struct urb *urb;
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	musb->endpoints[MM81X_EP_INT].urb = urb;
+
+	musb->endpoints[MM81X_EP_INT].buffer =
+		usb_alloc_coherent(musb->udev, MM81X_EP_INT_BUFFER_SIZE,
+				   GFP_KERNEL, &urb->transfer_dma);
+	if (!musb->endpoints[MM81X_EP_INT].buffer) {
+		mm81x_err(mm, "couldn't allocate transfer_buffer");
+		ret = -ENOMEM;
+		goto error_set_urb_null;
+	}
+
+	usb_fill_int_urb(
+		musb->endpoints[MM81X_EP_INT].urb, musb->udev,
+		usb_rcvintpipe(musb->udev, musb->endpoints[MM81X_EP_INT].addr),
+		musb->endpoints[MM81X_EP_INT].buffer, MM81X_EP_INT_BUFFER_SIZE,
+		mm81x_usb_int_handler, mm, MM81X_USB_INTERRUPT_INTERVAL);
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	ret = usb_submit_urb(urb, GFP_KERNEL);
+	if (ret) {
+		mm81x_err(mm, "Couldn't submit urb. Error number %d", ret);
+		goto error;
+	}
+
+	return 0;
+
+error:
+	usb_free_coherent(musb->udev, MM81X_EP_INT_BUFFER_SIZE,
+			  musb->endpoints[MM81X_EP_INT].buffer,
+			  urb->transfer_dma);
+error_set_urb_null:
+	musb->endpoints[MM81X_EP_INT].urb = NULL;
+	usb_free_urb(urb);
+out:
+	return ret;
+}
+
+static void mm81x_usb_int_stop(struct mm81x *mm)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	usb_kill_urb(musb->endpoints[MM81X_EP_INT].urb);
+	cancel_work_sync(&mm->usb_irq_work);
+}
+
+static void mm81x_usb_cmd_callback(struct urb *urb)
+{
+	struct mm81x *mm = urb->context;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	/* sync/async unlink faults aren't errors */
+	if (urb->status) {
+		if (!(urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		      urb->status == -ESHUTDOWN))
+			mm81x_err(mm, "nonzero write bulk status received: %d",
+				  urb->status);
+
+		musb->errors = urb->status;
+	}
+
+	musb->ongoing_cmd = false;
+	wake_up(&musb->rw_in_wait);
+}
+
+static int mm81x_usb_cmd(struct mm81x_usb *musb,
+			 const struct mm81x_usb_command *cmd)
+{
+	int retval = 0;
+	struct mm81x *mm = usb_get_intfdata(musb->interface);
+	struct mm81x_usb_endpoint *ep = &musb->endpoints[MM81X_EP_CMD];
+	size_t writesize = sizeof(*cmd);
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	memcpy(ep->buffer, cmd, writesize);
+
+	usb_fill_bulk_urb(ep->urb, musb->udev,
+			  usb_sndbulkpipe(musb->udev, ep->addr), ep->buffer,
+			  writesize, mm81x_usb_cmd_callback, mm);
+	ep->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	musb->ongoing_cmd = true;
+
+	retval = usb_submit_urb(ep->urb, GFP_KERNEL);
+	if (retval) {
+		mm81x_err(mm, "- failed submitting write urb, error %d",
+			  retval);
+
+		goto error;
+	}
+
+	retval = wait_event_interruptible_timeout(
+		musb->rw_in_wait, (!musb->ongoing_cmd),
+		msecs_to_jiffies(URB_TIMEOUT_MS));
+	if (retval < 0) {
+		mm81x_err(mm, "error waiting for urb %d", retval);
+		goto error;
+	} else if (retval == 0) {
+		mm81x_err(mm, "timed out waiting for urb");
+		usb_kill_urb(ep->urb);
+		retval = -ETIMEDOUT;
+		goto error;
+	}
+
+	musb->ongoing_cmd = false;
+	return writesize;
+
+error:
+	musb->ongoing_cmd = false;
+	return retval;
+}
+
+/* Non-destructive USB reset */
+int mm81x_usb_ndr_reset(struct mm81x *mm)
+{
+	int ret;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	struct mm81x_usb_command cmd;
+
+	mutex_lock(&musb->lock);
+
+	musb->ongoing_rw = true;
+	musb->errors = 0;
+
+	cmd.dir = cpu_to_le32(MM81X_USB_RESET);
+	cmd.address = cpu_to_le32(0);
+	cmd.length = cpu_to_le32(0);
+
+	ret = mm81x_usb_cmd(musb, &cmd);
+	if (ret < 0)
+		mm81x_err(mm, "mm81x_usb_cmd (MM81X_USB_RESET) error %d\n",
+			  ret);
+	else
+		ret = 0;
+
+	musb->ongoing_rw = false;
+	mutex_unlock(&musb->lock);
+	return ret;
+}
+
+static void mm81x_usb_mem_rw_callback(struct urb *urb)
+{
+	struct mm81x *mm = urb->context;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	/* sync/async unlink faults aren't errors */
+	if (urb->status) {
+		if (!(urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		      urb->status == -ESHUTDOWN))
+			mm81x_err(mm, "nonzero write bulk status received: %d",
+				  urb->status);
+
+		musb->errors = urb->status;
+	}
+
+	musb->ongoing_rw = false;
+	wake_up(&musb->rw_in_wait);
+}
+
+static int mm81x_usb_mem_read(struct mm81x_usb *musb, u32 address, u8 *data,
+			      ssize_t size)
+{
+	int ret;
+	struct mm81x_usb_command cmd;
+	struct mm81x *mm = usb_get_intfdata(musb->interface);
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	mutex_lock(&musb->lock);
+
+	musb->ongoing_rw = true;
+	musb->errors = 0;
+
+	/* Send command ahead to prepare for Tokens */
+	cmd.dir = cpu_to_le32(MM81X_USB_READ);
+	cmd.address = cpu_to_le32(address);
+	cmd.length = cpu_to_le32(size);
+
+	ret = mm81x_usb_cmd(musb, &cmd);
+	if (ret < 0) {
+		mm81x_err(mm, "mm81x_usb_cmd error %d", ret);
+		goto error;
+	}
+
+	/* Let's be fast push the next URB, don't wait until command is done */
+	usb_fill_bulk_urb(
+		musb->endpoints[MM81X_EP_MEM_RD].urb, musb->udev,
+		usb_rcvbulkpipe(musb->udev,
+				musb->endpoints[MM81X_EP_MEM_RD].addr),
+		musb->endpoints[MM81X_EP_MEM_RD].buffer, size,
+		mm81x_usb_mem_rw_callback, mm);
+
+	ret = usb_submit_urb(musb->endpoints[MM81X_EP_MEM_RD].urb, GFP_ATOMIC);
+	if (ret < 0) {
+		mm81x_err(mm, "failed submitting read urb, error %d", ret);
+		ret = (ret == -ENOMEM) ? ret : -EIO;
+		goto error;
+	}
+
+	ret = wait_event_interruptible_timeout(
+		musb->rw_in_wait, (!musb->ongoing_rw),
+		msecs_to_jiffies(URB_TIMEOUT_MS));
+	if (ret < 0) {
+		mm81x_err(mm, "wait_event_interruptible: error %d", ret);
+		goto error;
+	} else if (ret == 0) {
+		/* Timed out. */
+		usb_kill_urb(musb->endpoints[MM81X_EP_MEM_RD].urb);
+	}
+
+	if (musb->errors) {
+		ret = musb->errors;
+		mm81x_err(mm, "mem read error %d", ret);
+		goto error;
+	}
+
+	memcpy(data, musb->endpoints[MM81X_EP_MEM_RD].buffer, size);
+	ret = size;
+
+error:
+	musb->ongoing_rw = false;
+	mutex_unlock(&musb->lock);
+
+	return ret;
+}
+
+static int mm81x_usb_mem_write(struct mm81x_usb *musb, u32 address, u8 *data,
+			       ssize_t size)
+{
+	int ret;
+	struct mm81x_usb_command cmd;
+	struct mm81x *mm = usb_get_intfdata(musb->interface);
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	mutex_lock(&musb->lock);
+
+	musb->ongoing_rw = true;
+	musb->errors = 0;
+
+	/* Send command ahead to prepare for Tokens */
+	cmd.dir = cpu_to_le32(MM81X_USB_WRITE);
+	cmd.address = cpu_to_le32(address);
+	cmd.length = cpu_to_le32(size);
+	ret = mm81x_usb_cmd(musb, &cmd);
+	if (ret < 0) {
+		mm81x_err(mm, "mm81x_usb_mem_read error %d", ret);
+		goto error;
+	}
+
+	memcpy(musb->endpoints[MM81X_EP_MEM_WR].buffer, data, size);
+
+	/* prepare a read */
+	usb_fill_bulk_urb(
+		musb->endpoints[MM81X_EP_MEM_WR].urb, musb->udev,
+		usb_sndbulkpipe(musb->udev,
+				musb->endpoints[MM81X_EP_MEM_WR].addr),
+		musb->endpoints[MM81X_EP_MEM_WR].buffer, size,
+		mm81x_usb_mem_rw_callback, mm);
+
+	ret = usb_submit_urb(musb->endpoints[MM81X_EP_MEM_WR].urb, GFP_ATOMIC);
+	if (ret < 0) {
+		mm81x_err(mm, "- failed submitting write urb, error %d", ret);
+		ret = (ret == -ENOMEM) ? ret : -EIO;
+		goto error;
+	}
+
+	ret = wait_event_interruptible_timeout(
+		musb->rw_in_wait, (!musb->ongoing_rw),
+		msecs_to_jiffies(URB_TIMEOUT_MS));
+	if (ret < 0) {
+		mm81x_err(mm, "error %d", ret);
+		goto error;
+	} else if (ret == 0) {
+		/* Timed out. */
+		usb_kill_urb(musb->endpoints[MM81X_EP_MEM_WR].urb);
+	}
+
+	if (musb->errors) {
+		ret = musb->errors;
+		mm81x_err(mm, "error %d", ret);
+		goto error;
+	}
+
+	ret = size;
+
+error:
+	musb->ongoing_rw = false;
+	mutex_unlock(&musb->lock);
+	return ret;
+}
+
+static int mm81x_usb_dm_read(struct mm81x *mm, u32 address, u8 *data, int len)
+{
+	ssize_t offset = 0;
+	int ret;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	if (WARN_ON(len < 0))
+		return -EINVAL;
+
+	while (offset < len) {
+		ret = mm81x_usb_mem_read(musb, address + offset,
+					 (u8 *)(data + offset),
+					 min((ssize_t)(len - offset),
+					     (ssize_t)USB_MAX_TRANSFER_SIZE));
+		if (ret < 0) {
+			mm81x_err(mm, "%s failed (errno=%d)", __func__, ret);
+			return ret;
+		}
+
+		offset += ret;
+	}
+
+	return 0;
+}
+
+static int mm81x_usb_dm_write(struct mm81x *mm, u32 address, const u8 *data,
+			      int len)
+{
+	ssize_t offset = 0;
+	int ret;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	if (WARN_ON(len < 0))
+		return -EINVAL;
+
+	while (offset < len) {
+		ret = mm81x_usb_mem_write(musb, address + offset,
+					  (u8 *)(data + offset),
+					  min((ssize_t)(len - offset),
+					      (ssize_t)USB_MAX_TRANSFER_SIZE));
+		if (ret < 0) {
+			mm81x_err(mm, "%s failed (errno=%d)", __func__, ret);
+			return ret;
+		}
+
+		offset += ret;
+	}
+
+	return 0;
+}
+
+static int mm81x_usb_reg32_read(struct mm81x *mm, u32 address, u32 *val)
+{
+	int ret = 0;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	ret = mm81x_usb_mem_read(musb, address, (u8 *)val, sizeof(*val));
+	if (ret == sizeof(*val)) {
+		*val = le32_to_cpup((__le32 *)val);
+		return 0;
+	}
+
+	mm81x_err(mm, "usb reg32 read failed %d", ret);
+	return ret;
+}
+
+static int mm81x_usb_reg32_write(struct mm81x *mm, u32 address, u32 val)
+{
+	int ret = 0;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	__le32 val_le = cpu_to_le32(val);
+
+	ret = mm81x_usb_mem_write(musb, address, (u8 *)&val_le, sizeof(val_le));
+	if (ret == sizeof(val_le))
+		return 0;
+
+	mm81x_err(mm, "usb reg32 write failed %d", ret);
+	return ret;
+}
+
+static void mm81x_usb_bus_enable(struct mm81x *mm, bool enable)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	if (enable)
+		usb_autopm_get_interface(musb->interface);
+	else
+		usb_autopm_put_interface(musb->interface);
+}
+
+static void mm81x_usb_claim_bus(struct mm81x *mm)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	mutex_lock(&musb->bus_lock);
+}
+
+static void mm81x_usb_release_bus(struct mm81x *mm)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+
+	mutex_unlock(&musb->bus_lock);
+}
+
+static void mm81x_usb_set_irq(struct mm81x *mm, bool enable)
+{
+}
+
+static const struct mm81x_bus_ops mm81x_usb_ops = {
+	.dm_read = mm81x_usb_dm_read,
+	.dm_write = mm81x_usb_dm_write,
+	.reg32_read = mm81x_usb_reg32_read,
+	.reg32_write = mm81x_usb_reg32_write,
+	.set_bus_enable = mm81x_usb_bus_enable,
+	.claim = mm81x_usb_claim_bus,
+	.release = mm81x_usb_release_bus,
+	.set_irq = mm81x_usb_set_irq,
+	.bulk_alignment = MM81X_BUS_DEFAULT_BULK_ALIGNMENT,
+};
+
+static int mm81x_usb_detect_endpoints(struct mm81x *mm,
+				      const struct usb_interface *intf)
+{
+	int ret;
+	unsigned int i;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	struct usb_endpoint_descriptor *ep_desc;
+	struct usb_host_interface *intf_desc = intf->cur_altsetting;
+
+	for (i = 0; i < intf_desc->desc.bNumEndpoints; i++) {
+		ep_desc = &intf_desc->endpoint[i].desc;
+
+		if (usb_endpoint_is_bulk_in(ep_desc)) {
+			if (!musb->endpoints[MM81X_EP_MEM_RD].addr) {
+				musb->endpoints[MM81X_EP_MEM_RD].addr =
+					usb_endpoint_num(ep_desc);
+				musb->endpoints[MM81X_EP_MEM_RD].size =
+					usb_endpoint_maxp(ep_desc);
+			} else if (!musb->endpoints[MM81X_EP_REG_RD].addr) {
+				musb->endpoints[MM81X_EP_REG_RD].addr =
+					usb_endpoint_num(ep_desc);
+				musb->endpoints[MM81X_EP_REG_RD].size =
+					usb_endpoint_maxp(ep_desc);
+			}
+		} else if (usb_endpoint_is_bulk_out(ep_desc)) {
+			if (!musb->endpoints[MM81X_EP_MEM_WR].addr) {
+				musb->endpoints[MM81X_EP_MEM_WR].addr =
+					usb_endpoint_num(ep_desc);
+				musb->endpoints[MM81X_EP_MEM_WR].size =
+					usb_endpoint_maxp(ep_desc);
+			} else if (!musb->endpoints[MM81X_EP_REG_WR].addr) {
+				musb->endpoints[MM81X_EP_REG_WR].addr =
+					usb_endpoint_num(ep_desc);
+				musb->endpoints[MM81X_EP_REG_WR].size =
+					usb_endpoint_maxp(ep_desc);
+			}
+		} else if (usb_endpoint_is_int_in(ep_desc)) {
+			musb->endpoints[MM81X_EP_INT].addr =
+				usb_endpoint_num(ep_desc);
+			musb->endpoints[MM81X_EP_INT].size =
+				usb_endpoint_maxp(ep_desc);
+		}
+	}
+
+	mm81x_dbg(mm, MM81X_DBG_USB,
+		  "\tMemory Endpoint IN %s detected: %u size %u",
+		  musb->endpoints[MM81X_EP_MEM_RD].addr ? "" : "not",
+		  musb->endpoints[MM81X_EP_MEM_RD].addr,
+		  musb->endpoints[MM81X_EP_MEM_RD].size);
+	mm81x_dbg(mm, MM81X_DBG_USB,
+		  "\tMemory Endpoint OUT %s detected: %u size %u",
+		  musb->endpoints[MM81X_EP_MEM_WR].addr ? "" : "not",
+		  musb->endpoints[MM81X_EP_MEM_WR].addr,
+		  musb->endpoints[MM81X_EP_MEM_WR].size);
+	mm81x_dbg(mm, MM81X_DBG_USB, "\tRegister Endpoint IN %s detected: %u",
+		  musb->endpoints[MM81X_EP_REG_RD].addr ? "" : "not",
+		  musb->endpoints[MM81X_EP_REG_RD].addr);
+	mm81x_dbg(mm, MM81X_DBG_USB, "\tRegister Endpoint OUT %s detected: %u",
+		  musb->endpoints[MM81X_EP_REG_WR].addr ? "" : "not",
+		  musb->endpoints[MM81X_EP_REG_WR].addr);
+	mm81x_dbg(mm, MM81X_DBG_USB, "\tStats IN endpoint %s detected: %u",
+		  musb->endpoints[MM81X_EP_INT].addr ? "" : "not",
+		  musb->endpoints[MM81X_EP_INT].addr);
+
+	/* Verify we have an IN and OUT */
+	if (!(musb->endpoints[MM81X_EP_MEM_RD].addr &&
+	      musb->endpoints[MM81X_EP_MEM_WR].addr))
+		return -ENODEV;
+
+	/* Verify the stats MM81X_EP_INT is detected */
+	if (!musb->endpoints[MM81X_EP_INT].addr)
+		return -ENODEV;
+
+	/* Verify minimum interrupt status read */
+	if (musb->endpoints[MM81X_EP_INT].size < 8)
+		return -ENODEV;
+
+	musb->endpoints[MM81X_EP_CMD].urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!musb->endpoints[MM81X_EP_CMD].urb) {
+		ret = -ENOMEM;
+		goto err_ep;
+	}
+
+	musb->endpoints[MM81X_EP_MEM_RD].urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!musb->endpoints[MM81X_EP_MEM_RD].urb) {
+		ret = -ENOMEM;
+		goto err_ep;
+	}
+
+	musb->endpoints[MM81X_EP_MEM_WR].urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!musb->endpoints[MM81X_EP_MEM_WR].urb) {
+		ret = -ENOMEM;
+		goto err_ep;
+	}
+
+	musb->endpoints[MM81X_EP_MEM_RD].buffer =
+		kmalloc(USB_MAX_TRANSFER_SIZE, GFP_KERNEL);
+	if (!musb->endpoints[MM81X_EP_MEM_RD].buffer) {
+		ret = -ENOMEM;
+		goto err_ep;
+	}
+
+	musb->endpoints[MM81X_EP_MEM_WR].buffer =
+		kmalloc(USB_MAX_TRANSFER_SIZE, GFP_KERNEL);
+	if (!musb->endpoints[MM81X_EP_MEM_WR].buffer) {
+		ret = -ENOMEM;
+		goto err_ep;
+	}
+
+	musb->endpoints[MM81X_EP_CMD].buffer = usb_alloc_coherent(
+		musb->udev, sizeof(struct mm81x_usb_command), GFP_KERNEL,
+		&musb->endpoints[MM81X_EP_CMD].urb->transfer_dma);
+
+	if (!musb->endpoints[MM81X_EP_CMD].buffer) {
+		ret = -ENOMEM;
+		goto err_ep;
+	}
+
+	/* Assign command to memory out end point */
+	musb->endpoints[MM81X_EP_CMD].addr =
+		musb->endpoints[MM81X_EP_MEM_WR].addr;
+	musb->endpoints[MM81X_EP_CMD].size =
+		musb->endpoints[MM81X_EP_MEM_WR].size;
+
+	return 0;
+
+err_ep:
+	if (musb->endpoints[MM81X_EP_CMD].urb &&
+	    musb->endpoints[MM81X_EP_CMD].buffer)
+		usb_free_coherent(
+			musb->udev, sizeof(struct mm81x_usb_command),
+			musb->endpoints[MM81X_EP_CMD].buffer,
+			musb->endpoints[MM81X_EP_CMD].urb->transfer_dma);
+	usb_free_urb(musb->endpoints[MM81X_EP_MEM_RD].urb);
+	usb_free_urb(musb->endpoints[MM81X_EP_CMD].urb);
+	usb_free_urb(musb->endpoints[MM81X_EP_MEM_WR].urb);
+	kfree(musb->endpoints[MM81X_EP_MEM_RD].buffer);
+	kfree(musb->endpoints[MM81X_EP_MEM_WR].buffer);
+
+	return ret;
+}
+
+static void mm81x_urb_cleanup(struct mm81x *mm)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	struct mm81x_usb_endpoint *int_ep = &musb->endpoints[MM81X_EP_INT];
+	struct mm81x_usb_endpoint *rd_ep = &musb->endpoints[MM81X_EP_MEM_RD];
+	struct mm81x_usb_endpoint *wr_ep = &musb->endpoints[MM81X_EP_MEM_WR];
+	struct mm81x_usb_endpoint *cmd_ep = &musb->endpoints[MM81X_EP_CMD];
+
+	usb_kill_urb(rd_ep->urb);
+	usb_kill_urb(wr_ep->urb);
+	usb_kill_urb(cmd_ep->urb);
+
+	if (int_ep->urb)
+		usb_free_coherent(musb->udev, MM81X_EP_INT_BUFFER_SIZE,
+				  int_ep->buffer, int_ep->urb->transfer_dma);
+
+	if (cmd_ep->urb)
+		usb_free_coherent(musb->udev, sizeof(struct mm81x_usb_command),
+				  cmd_ep->buffer, cmd_ep->urb->transfer_dma);
+
+	kfree(wr_ep->buffer);
+	kfree(rd_ep->buffer);
+
+	usb_free_urb(int_ep->urb);
+	usb_free_urb(wr_ep->urb);
+	usb_free_urb(rd_ep->urb);
+	usb_free_urb(cmd_ep->urb);
+}
+
+static int mm81x_usb_probe(struct usb_interface *interface,
+			   const struct usb_device_id *id)
+{
+	int ret;
+	struct mm81x *mm;
+	struct mm81x_usb *musb;
+
+	mm = mm81x_mac_create(sizeof(*musb), &interface->dev);
+	if (!mm) {
+		dev_err(&interface->dev, "mm81x_mac_create failed\n");
+		return -ENOMEM;
+	}
+
+	mm->bus_ops = &mm81x_usb_ops;
+	mm->bus_type = MM81X_BUS_TYPE_USB;
+
+	musb = (struct mm81x_usb *)mm->drv_priv;
+	musb->udev = usb_get_dev(interface_to_usbdev(interface));
+	musb->interface = usb_get_intf(interface);
+
+	mutex_init(&musb->lock);
+	mutex_init(&musb->bus_lock);
+	init_waitqueue_head(&musb->rw_in_wait);
+	usb_set_intfdata(interface, mm);
+
+	ret = mm81x_usb_detect_endpoints(mm, interface);
+	if (ret < 0) {
+		mm81x_err(mm, "mm81x_usb_detect_endpoints failed (%d)\n", ret);
+		goto err_destroy_mac;
+	}
+
+	set_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags);
+
+	ret = mm81x_core_attach_regs(mm);
+	if (ret < 0) {
+		mm81x_err(mm, "mm81x_core_attach_regs failed: %d", ret);
+		goto err_destroy_mac;
+	}
+
+	mm->ps.gpios_supported = false;
+
+	mm81x_dbg(mm, MM81X_DBG_USB, "CHIP ID 0x%08x:0x%04x",
+		  MM81X_REG_CHIP_ID(mm), mm->chip_id);
+
+	mm81x_core_init_mac_addr(mm);
+
+	ret = mm81x_core_create(mm);
+	if (ret)
+		goto err_destroy_mac;
+
+	INIT_WORK(&mm->usb_irq_work, mm81x_usb_irq_work);
+	mm81x_usb_int_enable(mm);
+
+	ret = mm81x_mac_register(mm);
+	if (ret) {
+		mm81x_err(mm, "mm81x_mac_register failed: %d", ret);
+		goto err_core_destroy;
+	}
+
+	/* USB requires remote wakeup functionality for suspend */
+	clear_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags);
+	musb->interface->needs_remote_wakeup = 1;
+	usb_enable_autosuspend(musb->udev);
+	pm_runtime_set_autosuspend_delay(&musb->udev->dev,
+					 PM_RUNTIME_AUTOSUSPEND_DELAY_MS);
+
+	usb_autopm_get_interface(interface);
+	return 0;
+
+err_core_destroy:
+	mm81x_usb_int_stop(mm);
+	mm81x_core_destroy(mm);
+err_destroy_mac:
+	mm81x_mac_destroy(mm);
+	return ret;
+}
+
+static void mm81x_usb_disconnect(struct usb_interface *interface)
+{
+	struct mm81x *mm = usb_get_intfdata(interface);
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	int minor = interface->minor;
+	struct usb_device *udev = interface_to_usbdev(interface);
+
+	if (udev->state == USB_STATE_NOTATTACHED) {
+		clear_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags);
+		set_bit(MM81X_STATE_CHIP_UNRESPONSIVE, &mm->state_flags);
+		mm81x_dbg(mm, MM81X_DBG_USB, "USB suddenly unplugged");
+	}
+
+	usb_disable_autosuspend(usb_get_dev(udev));
+
+	if (test_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags)) {
+		mm81x_dbg(mm, MM81X_DBG_USB,
+			  "USB was suspended: release locks");
+		mm81x_usb_release_bus(mm);
+		mutex_unlock(&musb->lock);
+	}
+
+	clear_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags);
+
+	mm81x_mac_unregister(mm);
+	mm81x_usb_int_stop(mm);
+	mm81x_core_destroy(mm);
+	mm81x_urb_cleanup(mm);
+	mm81x_mac_destroy(mm);
+
+	usb_autopm_put_interface(interface);
+	usb_set_intfdata(interface, NULL);
+	dev_info(&interface->dev, "USB Morse #%d now disconnected", minor);
+	usb_put_dev(udev);
+}
+
+static int mm81x_usb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct mm81x *mm = usb_get_intfdata(intf);
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	struct mm81x_usb_endpoint *int_ep = &musb->endpoints[MM81X_EP_INT];
+	struct mm81x_usb_endpoint *rd_ep = &musb->endpoints[MM81X_EP_MEM_RD];
+	struct mm81x_usb_endpoint *wr_ep = &musb->endpoints[MM81X_EP_MEM_WR];
+	struct mm81x_usb_endpoint *cmd_ep = &musb->endpoints[MM81X_EP_CMD];
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	usb_kill_urb(int_ep->urb);
+	usb_kill_urb(rd_ep->urb);
+	usb_kill_urb(wr_ep->urb);
+	usb_kill_urb(cmd_ep->urb);
+
+	/* Locking the bus. No USB communication after this point */
+	mm81x_usb_claim_bus(mm);
+	mutex_lock(&musb->lock);
+
+	set_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags);
+	return 0;
+}
+
+static int mm81x_usb_resume(struct usb_interface *intf)
+{
+	struct mm81x *mm = usb_get_intfdata(intf);
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	int ret;
+	struct mm81x_usb_endpoint *int_ep = &musb->endpoints[MM81X_EP_INT];
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	ret = usb_submit_urb(int_ep->urb, GFP_KERNEL);
+	if (ret)
+		mm81x_err(mm, "Couldn't submit urb. Error number %d", ret);
+
+	mm81x_usb_release_bus(mm);
+	mutex_unlock(&musb->lock);
+
+	clear_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags);
+	return 0;
+}
+
+static int mm81x_usb_reset_resume(struct usb_interface *intf)
+{
+	struct mm81x *mm = usb_get_intfdata(intf);
+	struct mm81x_usb *musb = (struct mm81x_usb *)mm->drv_priv;
+	int ret;
+	struct mm81x_usb_endpoint *int_ep = &musb->endpoints[MM81X_EP_INT];
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	ret = usb_submit_urb(int_ep->urb, GFP_KERNEL);
+	if (ret)
+		mm81x_err(mm, "Couldn't submit urb. Error number %d", ret);
+
+	mm81x_usb_release_bus(mm);
+	mutex_unlock(&musb->lock);
+
+	clear_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags);
+
+	return 0;
+}
+
+static int mm81x_usb_pre_reset(struct usb_interface *intf)
+{
+	return 0;
+}
+
+static int mm81x_usb_post_reset(struct usb_interface *intf)
+{
+	return 0;
+}
+
+static struct usb_driver mm81x_usb_driver = {
+	.name = "mm81x_usb",
+	.probe = mm81x_usb_probe,
+	.disconnect = mm81x_usb_disconnect,
+	.suspend = mm81x_usb_suspend,
+	.resume = mm81x_usb_resume,
+	.reset_resume = mm81x_usb_reset_resume,
+	.pre_reset = mm81x_usb_pre_reset,
+	.post_reset = mm81x_usb_post_reset,
+	.id_table = mm81x_usb_table,
+	.supports_autosuspend = 1,
+	.soft_unbind = 1,
+};
+
+int __init mm81x_usb_init(void)
+{
+	int ret;
+
+	ret = usb_register(&mm81x_usb_driver);
+	if (ret)
+		pr_err("failed to register mm81x usb driver: %d\n", ret);
+
+	return ret;
+}
+
+void __exit mm81x_usb_exit(void)
+{
+	usb_deregister(&mm81x_usb_driver);
+}
-- 
2.43.0


