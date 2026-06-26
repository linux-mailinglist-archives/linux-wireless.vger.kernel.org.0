Return-Path: <linux-wireless+bounces-38138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zsEJDdcePmpAAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:40:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3C6CAB42
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:40:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=SPnZ9jlT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38138-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38138-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AC5E30D4B08
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627733DB324;
	Fri, 26 Jun 2026 06:33:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D913DB335
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:33:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455598; cv=none; b=kP0jUY09zcMZXHMmtzudYDluSORVN0OIQPH+H9BvysQkBGIGvFwQAgjZH6pYKyJK6NLEZNeaNPhux9hL4oM9PouVtKWGLPsZpt3cDVo4eLB/RHMxoL6XAGjW5LJkn82AvUvKXAMBA3aXZHnUffcajXt+gGn8nAj2qbsTaqHTQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455598; c=relaxed/simple;
	bh=PiI6Eg/5By3ZBreUmMDh8AKLy7pOgGYyR0YDT7CMDCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUxaFb3+CjHyP+cIX7+jZgtjnb4rm37flxI5Zfw9IFzquGo2zbiHXEWqA5XB5/7XL0AoQrcMxEx5jVcJakRY6nScSajVgEJb7llL6Acc0BV2Spijlv4jqR3wbAqj6NGc4qD7/Qstdxsm/yJmbO2GKkod5uQ4JJpb0UZ5n0JpHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=SPnZ9jlT; arc=none smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1397e093f90so2156151c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455595; x=1783060395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeO7fi0jSzLe5Y8AZkrNFJYJvwMjujDlC0KhEpuU+Es=;
        b=SPnZ9jlT9HVMw8CIr2F/qa+pyIP2qWYBt0FDI/VrwtDKISEVHx6j+OTQ34jJ/YPFXS
         OpUAzlunOXVDmN8bKdvX+bxcIkMWSrTRDpQV68Y57wxblpeqybTrBjAprOHHH1j+Htc4
         d87yj7Gf3uNCXoxUC7zhG72s+ikS+VSSVisD6n3U6pkJiCn/rbw8tNWCapaeReHX3BUb
         LOTM3Sl8NP3LRb+pDK1dH+53P/VzuTLMyS7Mgx6N5HKDhhbuTUvzO9KuAopQKajeVIaw
         qnPh/foUikLqOEps4FtaRJtfgbWxesmArLmPTbBjdfFlTnMwqwIFaxI4rcnpQhrJFsmr
         WkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455595; x=1783060395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YeO7fi0jSzLe5Y8AZkrNFJYJvwMjujDlC0KhEpuU+Es=;
        b=cU+AFGYozKs8ByRHXau/0qZBhcGjJqb47qKQgucw0wcW1A694VfYSKOnsCHL6LGVo1
         x3OV4gcauheh1YBhZgfaewN7fne/8n/LyG7oG51Zq+E3h+PwcWx7K08sxWD7WbpqPgi0
         kt3Rmsu487yGw0Engz9tE0oCuTqcQnGlP4Ma7IZ4vza4H9wZroC1ngHMzo2txwiUa8ic
         XY3d0KxyEBOjtz/19DNxHUeszu6c/GZbg/MTUXXpZoTlTNiOtn/W8Yu2Tbhb27YHcD9K
         AvnHLNvkoguu9tohJc2sbwIkSAegiE1CoDx+BPl998gE2dOcgXkgCmxbXuMJBk9CcANJ
         QxOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ipvyp9JhYxmumIPMwyDiBumSmkvQETq0g6N6lLfhaO7mydalj+YOlSKHSQiUreiIkdihhOeNzcbW3oo0JQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7tT3a1FTw+MZ6cm/0TXzm/OTJcDL/C8i11qqLY2Mohghpc2Md
	U1RnqGXRldbspllaMZWsiGHFf+Tak+ThHlJxb5xX/hLk10VUCOW5ifeQRwcQz1gyvXc=
X-Gm-Gg: AfdE7cn+VUzAhPq+l/zxD5xN55Jn5cjbOhyf+8flbSJbkm9Y34QWCYsfDSKUHpWMJMJ
	TRTBP4JfllAEcOY3sSj/U9WZCXTGsM5+WGiGKWPf0+mgMvKKCqj4MmOQdtAK9L7JdmzPM1+lCYi
	o4LsKXcWuM4SPbDRjFdKHtTp3eoU0GbiAhJiaS+Blwh7dOk/onv2u786Iaov7tpyQSVDCxg5dA5
	DgjRF9p/tFff3LkVfp9EX8+i4pFYCyp5jNA/fgFUntEVlsWflTZUktsznAKcmdm2kObanhXkh/3
	9szCra9eeGujDbqrpjdIdzaU6nDMLPgI29jGqa8pPma8mN4AurVnCjle+6ErFGuocglDnrJQgSD
	vvH+LfhXjKvJouzi3y5Cn+u//8AZJFyLNFu/gh3G3/5HouZQKxKyraaJlw9EhQdSgAlHoNXFbhv
	LaZ/jG2RRyHcuEmJFERtrhThqhyv5XsPdnUQ8UMyoBpNYlyCkSjWnTrHCFVvB0H5agLm1azIbSF
	8bysm6xo0+yuaLoa44w
X-Received: by 2002:a05:7022:1e03:b0:137:ed87:8194 with SMTP id a92af1059eb24-139db9edd2cmr4540460c88.4.1782455594928;
        Thu, 25 Jun 2026 23:33:14 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:33:14 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 27/33] wifi: mm81x: add usb.c
Date: Fri, 26 Jun 2026 16:29:23 +1000
Message-ID: <20260626063014.1275235-28-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38138-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93C3C6CAB42

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/usb.c | 943 ++++++++++++++++++++
 1 file changed, 943 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/usb.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/usb.c b/drivers/net/wireless/morsemicro/mm81x/usb.c
new file mode 100644
index 000000000000..ec94936b157b
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/usb.c
@@ -0,0 +1,943 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+#include "hif.h"
+#include "bus.h"
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
+	struct mm81x *mors = container_of(work, struct mm81x, usb_irq_work);
+
+	mm81x_claim_bus(mors);
+	mm81x_hw_irq_handle(mors);
+	mm81x_release_bus(mors);
+}
+
+static bool mm81x_usb_urb_status_is_disconnect(const struct urb *urb)
+{
+	return ((urb->status == -EPROTO) || (urb->status == -EILSEQ) ||
+		(urb->status == -ETIME) || (urb->status == -EPIPE));
+}
+
+static void mm81x_usb_int_handler(struct urb *urb)
+{
+	int ret;
+	struct mm81x *mors = urb->context;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return;
+
+	if (urb->status) {
+		if (mm81x_usb_urb_status_is_disconnect(urb)) {
+			clear_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags);
+			set_bit(MM81X_STATE_CHIP_UNRESPONSIVE,
+				&mors->state_flags);
+			dev_dbg(mors->dev,
+				"USB sudden disconnect detected in %s",
+				__func__);
+			return;
+		}
+
+		if (!(urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		      urb->status == -ESHUTDOWN))
+			dev_err(mors->dev, "- nonzero read status received: %d",
+				urb->status);
+	}
+
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+
+	/* usb_kill_urb has been called */
+	if (ret == -EPERM)
+		return;
+	else if (ret)
+		dev_err(mors->dev, "error: resubmit urb %p err code %d", urb,
+			ret);
+
+	queue_work(mors->chip_wq, &mors->usb_irq_work);
+}
+
+static int mm81x_usb_int_enable(struct mm81x *mors)
+{
+	int ret = 0;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
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
+		dev_err(mors->dev, "couldn't allocate transfer_buffer");
+		ret = -ENOMEM;
+		goto error_set_urb_null;
+	}
+
+	usb_fill_int_urb(
+		musb->endpoints[MM81X_EP_INT].urb, musb->udev,
+		usb_rcvintpipe(musb->udev, musb->endpoints[MM81X_EP_INT].addr),
+		musb->endpoints[MM81X_EP_INT].buffer, MM81X_EP_INT_BUFFER_SIZE,
+		mm81x_usb_int_handler, mors, MM81X_USB_INTERRUPT_INTERVAL);
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	ret = usb_submit_urb(urb, GFP_KERNEL);
+	if (ret) {
+		dev_err(mors->dev, "Couldn't submit urb. Error number %d", ret);
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
+static void mm81x_usb_int_stop(struct mm81x *mors)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	usb_kill_urb(musb->endpoints[MM81X_EP_INT].urb);
+	cancel_work_sync(&mors->usb_irq_work);
+}
+
+static void mm81x_usb_cmd_callback(struct urb *urb)
+{
+	struct mm81x *mors = urb->context;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	/* sync/async unlink faults aren't errors */
+	if (urb->status) {
+		if (!(urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		      urb->status == -ESHUTDOWN))
+			dev_err(mors->dev,
+				"nonzero write bulk status received: %d",
+				urb->status);
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
+	struct mm81x *mors = usb_get_intfdata(musb->interface);
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
+			  writesize, mm81x_usb_cmd_callback, mors);
+	ep->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	musb->ongoing_cmd = true;
+
+	retval = usb_submit_urb(ep->urb, GFP_KERNEL);
+	if (retval) {
+		dev_err(mors->dev, "- failed submitting write urb, error %d",
+			retval);
+
+		goto error;
+	}
+
+	retval = wait_event_interruptible_timeout(
+		musb->rw_in_wait, (!musb->ongoing_cmd),
+		msecs_to_jiffies(URB_TIMEOUT_MS));
+	if (retval < 0) {
+		dev_err(mors->dev, "error waiting for urb %d", retval);
+		goto error;
+	} else if (retval == 0) {
+		dev_err(mors->dev, "timed out waiting for urb");
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
+static int mm81x_usb_ndr_reset(struct mm81x *mors)
+{
+	int ret;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
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
+		dev_err(mors->dev, "mm81x_usb_cmd (MM81X_USB_RESET) error %d\n",
+			ret);
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
+	struct mm81x *mors = urb->context;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	/* sync/async unlink faults aren't errors */
+	if (urb->status) {
+		if (!(urb->status == -ENOENT || urb->status == -ECONNRESET ||
+		      urb->status == -ESHUTDOWN))
+			dev_err(mors->dev,
+				"nonzero write bulk status received: %d",
+				urb->status);
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
+	struct mm81x *mors = usb_get_intfdata(musb->interface);
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
+		dev_err(mors->dev, "mm81x_usb_cmd error %d", ret);
+		goto error;
+	}
+
+	/* Let's be fast push the next URB, don't wait until command is done */
+	usb_fill_bulk_urb(
+		musb->endpoints[MM81X_EP_MEM_RD].urb, musb->udev,
+		usb_rcvbulkpipe(musb->udev,
+				musb->endpoints[MM81X_EP_MEM_RD].addr),
+		musb->endpoints[MM81X_EP_MEM_RD].buffer, size,
+		mm81x_usb_mem_rw_callback, mors);
+
+	ret = usb_submit_urb(musb->endpoints[MM81X_EP_MEM_RD].urb, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_err(mors->dev, "failed submitting read urb, error %d", ret);
+		ret = (ret == -ENOMEM) ? ret : -EIO;
+		goto error;
+	}
+
+	ret = wait_event_interruptible_timeout(
+		musb->rw_in_wait, (!musb->ongoing_rw),
+		msecs_to_jiffies(URB_TIMEOUT_MS));
+	if (ret < 0) {
+		dev_err(mors->dev, "wait_event_interruptible: error %d", ret);
+		goto error;
+	} else if (ret == 0) {
+		/* Timed out. */
+		usb_kill_urb(musb->endpoints[MM81X_EP_MEM_RD].urb);
+	}
+
+	if (musb->errors) {
+		ret = musb->errors;
+		dev_err(mors->dev, "mem read error %d", ret);
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
+	struct mm81x *mors = usb_get_intfdata(musb->interface);
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
+		dev_err(mors->dev, "mm81x_usb_mem_read error %d", ret);
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
+		mm81x_usb_mem_rw_callback, mors);
+
+	ret = usb_submit_urb(musb->endpoints[MM81X_EP_MEM_WR].urb, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_err(mors->dev, "- failed submitting write urb, error %d",
+			ret);
+		ret = (ret == -ENOMEM) ? ret : -EIO;
+		goto error;
+	}
+
+	ret = wait_event_interruptible_timeout(
+		musb->rw_in_wait, (!musb->ongoing_rw),
+		msecs_to_jiffies(URB_TIMEOUT_MS));
+	if (ret < 0) {
+		dev_err(mors->dev, "error %d", ret);
+		goto error;
+	} else if (ret == 0) {
+		/* Timed out. */
+		usb_kill_urb(musb->endpoints[MM81X_EP_MEM_WR].urb);
+	}
+
+	if (musb->errors) {
+		ret = musb->errors;
+		dev_err(mors->dev, "error %d", ret);
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
+static int mm81x_usb_dm_read(struct mm81x *mors, u32 address, u8 *data, int len)
+{
+	ssize_t offset = 0;
+	int ret;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	while (offset < len) {
+		ret = mm81x_usb_mem_read(musb, address + offset,
+					 (u8 *)(data + offset),
+					 min((ssize_t)(len - offset),
+					     (ssize_t)USB_MAX_TRANSFER_SIZE));
+		if (ret < 0) {
+			dev_err(mors->dev, "%s failed (errno=%d)", __func__,
+				ret);
+			return ret;
+		}
+
+		offset += ret;
+	}
+
+	return 0;
+}
+
+static int mm81x_usb_dm_write(struct mm81x *mors, u32 address, const u8 *data,
+			      int len)
+{
+	ssize_t offset = 0;
+	int ret;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	while (offset < len) {
+		ret = mm81x_usb_mem_write(musb, address + offset,
+					  (u8 *)(data + offset),
+					  min((ssize_t)(len - offset),
+					      (ssize_t)USB_MAX_TRANSFER_SIZE));
+		if (ret < 0) {
+			dev_err(mors->dev, "%s failed (errno=%d)", __func__,
+				ret);
+			return ret;
+		}
+
+		offset += ret;
+	}
+
+	return 0;
+}
+
+static int mm81x_usb_reg32_read(struct mm81x *mors, u32 address, u32 *val)
+{
+	int ret = 0;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	ret = mm81x_usb_mem_read(musb, address, (u8 *)val, sizeof(*val));
+	if (ret == sizeof(*val)) {
+		*val = le32_to_cpup((__le32 *)val);
+		return 0;
+	}
+
+	dev_err(mors->dev, "usb reg32 read failed %d", ret);
+	return ret;
+}
+
+static int mm81x_usb_reg32_write(struct mm81x *mors, u32 address, u32 val)
+{
+	int ret = 0;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+	__le32 val_le = cpu_to_le32(val);
+
+	ret = mm81x_usb_mem_write(musb, address, (u8 *)&val_le, sizeof(val_le));
+	if (ret == sizeof(val_le))
+		return 0;
+
+	dev_err(mors->dev, "usb reg32 write failed %d", ret);
+	return ret;
+}
+
+static void mm81x_usb_bus_enable(struct mm81x *mors, bool enable)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	if (enable)
+		usb_autopm_get_interface(musb->interface);
+	else
+		usb_autopm_put_interface(musb->interface);
+}
+
+static void mm81x_usb_claim_bus(struct mm81x *mors)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	mutex_lock(&musb->bus_lock);
+}
+
+static void mm81x_usb_release_bus(struct mm81x *mors)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+
+	mutex_unlock(&musb->bus_lock);
+}
+
+static void mm81x_usb_set_irq(struct mm81x *mors, bool enable)
+{
+}
+
+static const struct mm81x_bus_ops mm81x_usb_ops = {
+	.dm_read = mm81x_usb_dm_read,
+	.dm_write = mm81x_usb_dm_write,
+	.reg32_read = mm81x_usb_reg32_read,
+	.reg32_write = mm81x_usb_reg32_write,
+	.digital_reset = mm81x_usb_ndr_reset,
+	.set_bus_enable = mm81x_usb_bus_enable,
+	.claim = mm81x_usb_claim_bus,
+	.release = mm81x_usb_release_bus,
+	.set_irq = mm81x_usb_set_irq,
+	.bulk_alignment = MM81X_BUS_DEFAULT_BULK_ALIGNMENT,
+};
+
+static int mm81x_usb_detect_endpoints(struct mm81x *mors,
+				      const struct usb_interface *intf)
+{
+	int ret;
+	unsigned int i;
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
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
+	dev_dbg(mors->dev, "\tMemory Endpoint IN %s detected: %u size %u",
+		musb->endpoints[MM81X_EP_MEM_RD].addr ? "" : "not",
+		musb->endpoints[MM81X_EP_MEM_RD].addr,
+		musb->endpoints[MM81X_EP_MEM_RD].size);
+	dev_dbg(mors->dev, "\tMemory Endpoint OUT %s detected: %u size %u",
+		musb->endpoints[MM81X_EP_MEM_WR].addr ? "" : "not",
+		musb->endpoints[MM81X_EP_MEM_WR].addr,
+		musb->endpoints[MM81X_EP_MEM_WR].size);
+	dev_dbg(mors->dev, "\tRegister Endpoint IN %s detected: %u",
+		musb->endpoints[MM81X_EP_REG_RD].addr ? "" : "not",
+		musb->endpoints[MM81X_EP_REG_RD].addr);
+	dev_dbg(mors->dev, "\tRegister Endpoint OUT %s detected: %u",
+		musb->endpoints[MM81X_EP_REG_WR].addr ? "" : "not",
+		musb->endpoints[MM81X_EP_REG_WR].addr);
+	dev_dbg(mors->dev, "\tStats IN endpoint %s detected: %u",
+		musb->endpoints[MM81X_EP_INT].addr ? "" : "not",
+		musb->endpoints[MM81X_EP_INT].addr);
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
+static void mm81x_urb_cleanup(struct mm81x *mors)
+{
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
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
+	struct mm81x *mors;
+	struct mm81x_usb *musb;
+
+	mors = mm81x_core_alloc(sizeof(*musb), &interface->dev);
+	if (!mors)
+		return -ENOMEM;
+
+	mors->bus_ops = &mm81x_usb_ops;
+	mors->bus_type = MM81X_BUS_TYPE_USB;
+
+	musb = (struct mm81x_usb *)mors->drv_priv;
+	musb->udev = usb_get_dev(interface_to_usbdev(interface));
+	musb->interface = usb_get_intf(interface);
+
+	mutex_init(&musb->lock);
+	mutex_init(&musb->bus_lock);
+	init_waitqueue_head(&musb->rw_in_wait);
+	usb_set_intfdata(interface, mors);
+
+	ret = mm81x_usb_detect_endpoints(mors, interface);
+	if (ret < 0)
+		goto err_core_free;
+
+	set_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags);
+
+	ret = mm81x_core_init(mors);
+	if (ret)
+		goto err_urb_cleanup;
+
+	INIT_WORK(&mors->usb_irq_work, mm81x_usb_irq_work);
+
+	ret = mm81x_usb_int_enable(mors);
+	if (ret)
+		goto err_core_deinit;
+
+	ret = mm81x_core_register(mors);
+	if (ret)
+		goto err_usb_int_stop;
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
+err_usb_int_stop:
+	mm81x_usb_int_stop(mors);
+err_core_deinit:
+	mm81x_core_deinit(mors);
+err_urb_cleanup:
+	mm81x_urb_cleanup(mors);
+err_core_free:
+	mm81x_core_free(mors);
+	usb_put_intf(interface);
+	usb_put_dev(interface_to_usbdev(interface));
+	return ret;
+}
+
+static void mm81x_usb_disconnect(struct usb_interface *interface)
+{
+	struct mm81x *mors = usb_get_intfdata(interface);
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+	int minor = interface->minor;
+	struct usb_device *udev = interface_to_usbdev(interface);
+
+	if (udev->state == USB_STATE_NOTATTACHED) {
+		clear_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags);
+		set_bit(MM81X_STATE_CHIP_UNRESPONSIVE, &mors->state_flags);
+		dev_dbg(mors->dev, "USB suddenly unplugged");
+	}
+
+	usb_disable_autosuspend(udev);
+
+	if (test_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags)) {
+		dev_dbg(mors->dev, "USB was suspended: release locks");
+		mm81x_usb_release_bus(mors);
+		mutex_unlock(&musb->lock);
+	}
+
+	clear_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags);
+
+	mm81x_core_unregister(mors);
+	mm81x_usb_int_stop(mors);
+	mm81x_core_deinit(mors);
+	mm81x_urb_cleanup(mors);
+	mm81x_core_free(mors);
+
+	usb_autopm_put_interface(interface);
+	usb_set_intfdata(interface, NULL);
+	dev_info(&interface->dev, "USB Morse #%d now disconnected", minor);
+	usb_put_intf(interface);
+	usb_put_dev(udev);
+}
+
+static int mm81x_usb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct mm81x *mors = usb_get_intfdata(intf);
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
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
+	mm81x_usb_claim_bus(mors);
+	mutex_lock(&musb->lock);
+
+	set_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags);
+	return 0;
+}
+
+static int mm81x_usb_resume(struct usb_interface *intf)
+{
+	struct mm81x *mors = usb_get_intfdata(intf);
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+	int ret;
+	struct mm81x_usb_endpoint *int_ep = &musb->endpoints[MM81X_EP_INT];
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	ret = usb_submit_urb(int_ep->urb, GFP_KERNEL);
+	if (ret)
+		dev_err(mors->dev, "Couldn't submit urb. Error number %d", ret);
+
+	mm81x_usb_release_bus(mors);
+	mutex_unlock(&musb->lock);
+
+	clear_bit(MM81X_USB_FLAG_SUSPENDED, &musb->flags);
+	return 0;
+}
+
+static int mm81x_usb_reset_resume(struct usb_interface *intf)
+{
+	struct mm81x *mors = usb_get_intfdata(intf);
+	struct mm81x_usb *musb = (struct mm81x_usb *)mors->drv_priv;
+	int ret;
+	struct mm81x_usb_endpoint *int_ep = &musb->endpoints[MM81X_EP_INT];
+
+	if (!test_bit(MM81X_USB_FLAG_ATTACHED, &musb->flags))
+		return -ENODEV;
+
+	ret = usb_submit_urb(int_ep->urb, GFP_KERNEL);
+	if (ret)
+		dev_err(mors->dev, "Couldn't submit urb. Error number %d", ret);
+
+	mm81x_usb_release_bus(mors);
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
+module_usb_driver(mm81x_usb_driver);
+
+MODULE_AUTHOR("Morse Micro");
+MODULE_DESCRIPTION("Driver support for Morse Micro MM81X USB devices");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.43.0


