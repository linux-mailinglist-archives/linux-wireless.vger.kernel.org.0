Return-Path: <linux-wireless+bounces-32999-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPNRIvLXsWnVFgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32999-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 22:00:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF126A3BF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 22:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B23A300C59B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 20:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D078324B2D;
	Wed, 11 Mar 2026 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhW54RxC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EC30E0DC
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262720; cv=pass; b=D3ycUmdes4mVGgpXciJc7kB3O3LQmMoQPuDMNN4Xr6PypBfj2u4vEJLw34EGOWBOW2QpbBck7IxW8DYrckYn3nkzX1j5XbaLXFoi9Gs5g17ZEHwrHAa+ERPFZoQikqJO8EZPsa2iGwOg1hrjgdCBq0Q1m5yV1q7ZUJkIJStPmqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262720; c=relaxed/simple;
	bh=J/kUKeNTENfSzP5xHVfPjLS5YjAeGuuwqJmZnN0faYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm4lZlnREEm17O3SAbP4BASrysg9C+RNElfsEIyXY8hBvGML6+Udn/0q/I3anVucfXghFjsXS0Q27y6bnSnmPQqgQ3ngNtZdCLZMEYOIE0Jn95rzk1EvA9nBXrb+K47NlP2sItLu1dt+wlhbkq1erwpZx9eSjEFmKjldyZfMaOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhW54RxC; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-662a1855af2so400578a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 13:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773262717; cv=none;
        d=google.com; s=arc-20240605;
        b=AAwt7vyfCzt5wu545ztZtp+RDIKQBaZJ8CjkwYz4Rh5UQJkwRU0h/HB9jTHxV68njd
         zflAH8ehAjzccAahVsYykcmjcqggywPn3RRHr0QJaGGOCIeNOr022mUB5Fwwh87P1mpo
         wClnEgFQXX9vSVMSyiC1RMmUOzisz9m1cr7QilAxf9nbuDOsTN3bWJkyzS9rWwlxbRnG
         VRZ28Y2SP9IskvYYijGbq42aKJIIt4DECo05QfK/vHugaMCUDtXhiRRM26X1EHkMXosX
         n0fYIWSzMZRsuHRS6UFftFhj8/Q9BrjQyAGzIcNKOXy64ZRBT0BdUB473dp59Ue9Tvhz
         aNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZFSrsAzKQ3Nc+Aho7d7gG2Ra3wQyS/1tLF/F02PD+Zo=;
        fh=MXkW9Xo5Ym/gIF9EG8Fk1lbc8jJJ90IIrm4Se6meZo4=;
        b=G+eBOYAQ8cBtARguzIWhyLtOo5t/6T7lS1GZfJ41yMm5kGZ9l5j0j47dtTl0jvlPPh
         +9jDPBGcpbwuiRuFEhfBprS7L3ruothA6Zpide60V1NzOOUnYLqvufomGjGwMDsyMFEY
         U1yxsn0IQBRBkjeDxh2PLWmDxgwAZShnGjukTY6MEmHNI1iI5BFO/FC4pqiSPaot0EmX
         BHFkqYbN9M5FZZdgY/pcZmJ+aq7eFiP07gEXtx2qz3L9udlKw1PoRdhf5m+9YqTx/vWF
         HkExRDoMNS398ftbsE6Mvr/QTlmMGsEf1MJeTm4+vG+rSuA+8rpJ4ZqzsPfryI8pshUW
         NG1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773262717; x=1773867517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFSrsAzKQ3Nc+Aho7d7gG2Ra3wQyS/1tLF/F02PD+Zo=;
        b=DhW54RxC4MSBGKgSTVNCQx5Zmo7i9Ixo1qwctXlqdQhJ5hW/yPE97rITmvy4QQN7cm
         0Lz+kNpBobAGloL4Y0KnfKHYFPtXLXQC2c7NWFIX5QKgTjvy59XySJDLWPSvwmzZRoHY
         g2LYoK2XIBoCZE2HAYKJ83zOHzVI8GtltE7cPXhFFSNWTG6O8EAKODWzJ1Q6I/ZQEZON
         o16FNDRgWgCOOVULa4nBYtaRatAX+kyTDfOUq/DVzMphsRq8SPCZ2j5+Xg9xbIc+ON+M
         o3cC1pNpODSlYWq7WFGnRjLLg0wGwItB+5GV9lFafFeYOhNzAKKb5/uSKssWsVMKFP0L
         KmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773262717; x=1773867517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFSrsAzKQ3Nc+Aho7d7gG2Ra3wQyS/1tLF/F02PD+Zo=;
        b=LunyY8pW8iDDaC5VAwLkBmeb4w5wpaagXVKyROYjAwRQmWx2UMh+VRCREodfXzej5X
         qf/R0NrgHd/xeDPOg9KeBadDYuhG7mX3RhDJa5kpOu8dOTVEv0c7upySZhaN1z1FDfwm
         NmO6OLmMVRU13FS3M3L5/yUog2okP/5SYc75KolU++XW0juzKvBV9sAplxGIp+x+4/39
         L9KXe8bYPW2yY8Kyvr0bZcxHY6sJZ5KwSIPAzHnf7K8DSNio0vxF1EjWtV1zqlfoAmO+
         PtXNBXdxTT0HEBl/D4Cf8vH1dHg320Bi2KS78lC3f1MzFEHlvOZMEZP/GmikxNQOR7an
         AJ3A==
X-Gm-Message-State: AOJu0YwbDmkVOirnaQdxxHL5A0x6W4XgKfaCSJ7AYc2Kv2Dkd7WmQZNI
	Y3lvDgTkFWrQxxK3TAVzfaQRBI40pc+04FH0Bq2eAxXxvq5Y9wkpC5tO5zhHM/WIH4LJVGSpbbn
	Titjc8GmZFZYZK6yGH6/h9DglsUGDTZM=
X-Gm-Gg: ATEYQzyU3D9g6tNhSE4fjPKFiYLoNpoTTjeqf8Bv3QXCVSfIMvdGng1uI6ZYF2JuHgW
	oMkwSdHgDc0agj9n6IvgQg2/GtXjKAeBtncK26hqMDOTrpsz7v7jr65nhdacIqDD9toZscHy3jA
	lU5REojs6yD1b1ndw2ByqXe6VscMzLz8mZZMsfKdX7L4frc25uyCg81KEMkoDacsOxsmyZI4tGH
	kHV06p2zXPiJZv6kS0yHcdAXc0FBUqTFzdDzwWsBBcZnYmghotparMTY613iksagqhG0TYzOQb1
	x3pyDg==
X-Received: by 2002:a17:907:72cb:b0:b8f:a323:bda7 with SMTP id
 a640c23a62f3a-b972e52dc74mr220526566b.46.1773262716821; Wed, 11 Mar 2026
 13:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
 <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com>
 <CANAPQzgiE1rMP3F=5NJg3hp2uBXtq44+vTRBdkHwdfHyXJ8MQQ@mail.gmail.com> <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
In-Reply-To: <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Wed, 11 Mar 2026 15:58:25 -0500
X-Gm-Features: AaiRm51mj2z7E16-DLghbuJqU-OBnWUBTx9_-Sl-BUmLGVcviCRtpbSjAbPv6jM
Message-ID: <CANAPQzgXN2UOjuwV1fRofN2syxG933kSaB9S7DyFAykHHMRzew@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32999-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2FF126A3BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 9fabc33e722f321b4048ada6d4667ddacbb1495a Mon Sep 17 00:00:00 2001
From: bryam <bryamestebanvargas@gmail.com>
Date: Mon, 9 Mar 2026 12:25:37 -0500
Subject: [PATCH v2 2/2] mt76: mt7921u: trigger USB reset only on wfsys timeout

Instead of unconditionally scheduling a USB device reset at the start
of the reset sequence, trigger it only when mt792xu_wfsys_reset()
returns -ETIMEDOUT, which indicates the chip is in a latched state
(SEFI - Single Event Functional Interrupt) where register writes over
USB become silent no-ops.

This avoids the race condition where usb_queue_reset_device() was
scheduled asynchronously while the driver continued normal reset
operations on the same device.

Tested-on: Minisforum NAB9 (MT7921U USB adapter) at 2400m altitude,
           Bogota, Colombia. Cosmic radiation causes periodic SEFI
           events; USB reset restores connectivity without intervention.

Signed-off-by: Bryam Vargas <bryamestebanvargas@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 32 +++++++++----------
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 16 ++++------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 8c8c78f..44c7437 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -86,33 +86,33 @@ static int mt7921u_mcu_init(struct mt792x_dev *dev)

 static int mt7921u_mac_reset(struct mt792x_dev *dev)
 {
-    struct usb_interface *intf = to_usb_interface(dev->mt76.dev);
     int err;

     mt76_txq_schedule_all(&dev->mphy);
     mt76_worker_disable(&dev->mt76.tx_worker);
-
     set_bit(MT76_RESET, &dev->mphy.state);
     set_bit(MT76_MCU_RESET, &dev->mphy.state);
-
     wake_up(&dev->mt76.mcu.wait);
     skb_queue_purge(&dev->mt76.mcu.res_q);
-
     mt76u_stop_rx(&dev->mt76);
     mt76u_stop_tx(&dev->mt76);

-    /* When the chip enters a latched state (SEFI - Single Event
-     * Functional Interrupt, e.g. from cosmic radiation at altitude),
-     * all register writes over USB become silent no-ops.
-     * usb_queue_reset_device() electrically resets the chip via the
-     * USB hub regardless of internal state -- identical to probe().
-     * Async variant required to avoid deadlock in workqueue context.
-     */
-    dev_warn(dev->mt76.dev,
-         "mt7921u: scheduling USB reset for chip recovery\n");
-    usb_queue_reset_device(intf);
-
-    mt792xu_wfsys_reset(dev);
+    err = mt792xu_wfsys_reset(dev);
+    if (err == -ETIMEDOUT) {
+        /* Chip is in a latched state (SEFI - Single Event Functional
+         * Interrupt, e.g. from cosmic radiation at altitude).
+         * Register writes over USB become silent no-ops; schedule an
+         * electrical USB reset via the hub as last resort.
+         * usb_queue_reset_device() is async to avoid deadlock in
+         * workqueue context.
+         */
+        struct usb_interface *intf = to_usb_interface(dev->mt76.dev);
+
+        dev_warn(dev->mt76.dev,
+             "mt7921u: wfsys reset timed out, scheduling USB reset\n");
+        usb_queue_reset_device(intf);
+        goto out;
+    }

     clear_bit(MT76_MCU_RESET, &dev->mphy.state);
     err = mt76u_resume_rx(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index cfd385e..4737384 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -269,7 +269,6 @@ EXPORT_SYMBOL_GPL(mt792xu_wfsys_reset);

 int mt792xu_init_reset(struct mt792x_dev *dev)
 {
-    struct usb_interface *intf = to_usb_interface(dev->mt76.dev);

     set_bit(MT76_RESET, &dev->mphy.state);

@@ -279,15 +278,14 @@ int mt792xu_init_reset(struct mt792x_dev *dev)
     mt76u_stop_rx(&dev->mt76);
     mt76u_stop_tx(&dev->mt76);

-    /* Same rationale as mt7921u_mac_reset(): if the chip is in a
-     * latched state (SEFI), register writes over USB are no-ops.
-     * Schedule a USB port reset before software reset sequence.
-     */
-    dev_warn(dev->mt76.dev,
-         "mt7921u: scheduling USB device reset (init_reset path)\n");
-    usb_queue_reset_device(intf);
+    if (mt792xu_wfsys_reset(dev) == -ETIMEDOUT) {
+        struct usb_interface *intf = to_usb_interface(dev->mt76.dev);
+
+        dev_warn(dev->mt76.dev,
+             "mt792xu: wfsys reset timed out, scheduling USB reset\n");
+        usb_queue_reset_device(intf);
+    }

-    mt792xu_wfsys_reset(dev);

     clear_bit(MT76_RESET, &dev->mphy.state);

--
2.43.0

