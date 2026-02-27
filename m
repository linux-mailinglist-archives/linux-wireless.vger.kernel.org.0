Return-Path: <linux-wireless+bounces-32281-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENP6FzhsoWmxswQAu9opvQ
	(envelope-from <linux-wireless+bounces-32281-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:04:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC401B5B9E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEA9730EC556
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053832E7635;
	Fri, 27 Feb 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYVrcOug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064821770A
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186335; cv=pass; b=EcZO5stFZ5DENCUZXI5EkAnd060s73BKvxPlIzNPUYorA2MzN3a8oxMqqhUdLgPjNLDfYTuZ8CExxZeSl2iZHdAcsKURYi7usUAai1S8U/XdcFryfnJLxoMmrN223RocXTsosw3FMYml9yGRGCZma9kTVC/0xXxo4piqJSLrI0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186335; c=relaxed/simple;
	bh=SWUb9HFumGU2sbiZdXfbURlV3b2aEVDiIuITaHq7zNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9qy0lX/1o7b6sKsezU+7S7I7upy9yF+sOj0r+77+cdyO3SZ2t3t1K77psct1diFCIbpRpclvxklLZ8paApYs+8vH/s5Hb0yjyNTS0sP89+QY1syXU7jmcjXUwJS5mbhVOc9KKtHKOvi5PyoiuKKUkCtWPLuCzeNdFBiPr0xKHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYVrcOug; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8fd976e90cso245531566b.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 01:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772186332; cv=none;
        d=google.com; s=arc-20240605;
        b=eLbGJELGeq5qE6cOyiV+qCzPCfrKC3PUQwBuFfBOe/Kmd0FrQHyBmDw75JHGhmhkC7
         o23KmKFy4MHG1fjX+u/5JpZ6EZCa1IygxQeud/aY8EC+am4e5tqO/bRNOsY2wiFMdMCA
         zqy06cTzb0roZaqe61v4v92g/8jUND7HborVBa9v738u8IoYps82Kvx6mMYvD3LvbZyZ
         pw5Cyd8CWh1Xosz/Oi/VeTvVc5cpK7EirM2H8h/KSV3B93t0Iy3Y3dNutVF0olWIhv3S
         aq2T+Iy6qaY+i/lzJrFesvQD2RPxbgtqyfMv/5+bKjMpS6+C3CQcDEi13ZflQlnFUkBS
         C8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6am3jbJYtklcc+EC92qBaefw71exDZH2AOQzrPpsbgQ=;
        fh=ru6fWO4GBlegjsSZkL+At6gjWpeY460Z+ACiiSEQTtA=;
        b=XZTBHLc1lcYd6K/dyZiBWwh1N3of+LVQ8qcGD362fedV8N9qZD5srzlia2jHXPlQAA
         F/tk1cSGsABYr1am1pmF4+NrzLVI8wIPpDEcPyUu110ZLWti8JuA3kuCgOFdjUwIrIKk
         uYAEyl9kqSLJwUPsMlDpNUjOxEkxF1x6vfzG73UkDoSoM4JUPgL34wtYKXffEnK/h0D6
         OXXdyS7CR4B7Rr4+VThxofk20/4wh//sS8tJN7UG4+gmKzn616D0YmnI3WU58bN5G3MO
         3qEepZSm0y795k4lHTjMmEsiyluQZXgBAz54n3vNLMq759iZxJi2+kVXY5rWLJ9kj3nM
         nO4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772186332; x=1772791132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6am3jbJYtklcc+EC92qBaefw71exDZH2AOQzrPpsbgQ=;
        b=QYVrcOugqD8RwB3WFRCMaHc4Owh92eyRz/Z/mslg4w7cyI+UqSDuWOlumDmVwKKCNY
         15Z6qscBBWll8i9TQk/eIZYJPyAS2w41EREMUhWMMdS87Xtp4dxqsvyobr0gQvQGSELT
         JvY0DqrblBUzfoMlrGt0oTaQbFDH3QaJQ4CZ7iHE4smHz6M6sGBmZ2ISJdHxnaRdwpra
         UQHVGkT+9R5Lxoh9hN6+t/sLxbtvfwmUjA2ikCcZ+rAD2qi21KoQSsbDNRry8k6P/+yl
         OnEbgGXuqrTGQKc5Dzb/CW1R8v0UKazk4zGV/UmG2NurMYZjzzd5ivd+JcGs4Qpzs6Gm
         NkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772186332; x=1772791132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6am3jbJYtklcc+EC92qBaefw71exDZH2AOQzrPpsbgQ=;
        b=Fx0vQmD/qVUUdJm6tZxEgRSYN+WrhJ2A/B2oRH+ueM1KxTxscZZs5gCD8/A1F+zyG2
         U3u9pGQqL/HN/abSa2DvHu18pGw8KsWL3HT/HLcO+qOLhqx69JQ04rhWW/K21duvDUy1
         aFBEkYjnr7TnZ9KIodxoq0VaoTxIVpMc8GiWH8fcdI1CIDz2LdKjRX895HKXEEtIayhC
         zDkrFc3arZRV1PANvj24exnuIlW1Q2nsyizbITjxRBBxVMIYPjZXftAZnBeJZCrCha52
         RxjGLZSbbD6oRMUN447nyMDo7s7awm2rdxL1caFOb2E2kMOU4Sa8h0pLl3RE14rmJ3Vp
         Z6pA==
X-Gm-Message-State: AOJu0YyDgDNUKQE4KcpW8x9gyHLPg1pVvEFww0S5Egck06bzTiBIkLwG
	D/jfgV0XMcBamxMF4wx2XvpChBKvuZNcA5TcCHNSTkSqjTF8LF9Jh9BdXRA5hVQvS+vB0ojgRjK
	lbdmAgQ9jxgXrnY/4vQ6lQdlGSENcFuCdiUyInUY=
X-Gm-Gg: ATEYQzw94+i8x/I7TFU5aVN9SKHvTsFLx0tYD57DKhRLuoAURfuuwyrl9j1bZkZ+UBZ
	YdOrPc97TyWyiUdsGFqQfnWZdC3MnvRseNURpZ2P58DxIPohwVI9iKR3ItgkE6wXo5x2+ed/wH1
	3FzJd8C5SI1rpxsr7/Eg3YfN2oOIBT0AzKGnZLgbzIBPqUWqyLMkppxDtzT3EPsPrJhaAMAu0he
	E2rAbspcRFt7LOn8icPsx0QjR/qLpgmAqCAz7xHO7zZ89rF1qgIsIZ6Ortk/zNh1ygluivSLkp9
	38Jlrw==
X-Received: by 2002:a17:907:2d94:b0:b90:e20b:acb9 with SMTP id
 a640c23a62f3a-b93761804c5mr147901066b.0.1772186332183; Fri, 27 Feb 2026
 01:58:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
In-Reply-To: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Fri, 27 Feb 2026 04:58:40 -0500
X-Gm-Features: AaiRm50Xhaf2UeeWSPwr5dfDfiTzkySNPW-n3HczCjfyL47LzuVukwcVCcl8dF0
Message-ID: <CANAPQzi_eC2n_mfxrcZ46tpCDB1_RkkbpnVd2Y=P=Ua4iPU2gQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32281-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BAC401B5B9E
X-Rspamd-Action: no action

[PATCH 2/2] mt76: mt7921u: add USB reset on SEFI chip recovery
From 86976b5908219204f7719d947fd6c5f1c5e11c7f Mon Sep 17 00:00:00 2001
From: bryam <bryamestebanvargas@gmail.com>
Date: Fri, 27 Feb 2026 04:30:01 -0500
Subject: [PATCH 2/2] mt76: mt7921u: add USB reset on SEFI chip recovery

The MT7921U chip is susceptible to Single Event Functional Interrupts
(SEFIs) caused by cosmic radiation, particularly at high altitudes.
When a SEFI occurs, the chip becomes unresponsive and requires a USB
reset to recover.

Add usb_queue_reset_device() calls in the SEFI detection path to
trigger automatic recovery instead of leaving the interface hung.

Tested-on: Minisforum NAB9 (MT7921U USB adapter) at 2400m altitude,
           Bogot=C3=A1, Colombia. Cosmic radiation causes periodic SEFI
           events; USB reset restores connectivity without intervention.

Signed-off-by: Bryam Vargas <bryamestebanvargas@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 12 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 100bdba..8c8c78f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -86,6 +86,7 @@ static int mt7921u_mcu_init(struct mt792x_dev *dev)

 static int mt7921u_mac_reset(struct mt792x_dev *dev)
 {
+    struct usb_interface *intf =3D to_usb_interface(dev->mt76.dev);
     int err;

     mt76_txq_schedule_all(&dev->mphy);
@@ -100,6 +101,17 @@ static int mt7921u_mac_reset(struct mt792x_dev *dev)
     mt76u_stop_rx(&dev->mt76);
     mt76u_stop_tx(&dev->mt76);

+    /* When the chip enters a latched state (SEFI - Single Event
+     * Functional Interrupt, e.g. from cosmic radiation at altitude),
+     * all register writes over USB become silent no-ops.
+     * usb_queue_reset_device() electrically resets the chip via the
+     * USB hub regardless of internal state -- identical to probe().
+     * Async variant required to avoid deadlock in workqueue context.
+     */
+    dev_warn(dev->mt76.dev,
+         "mt7921u: scheduling USB reset for chip recovery\n");
+    usb_queue_reset_device(intf);
+
     mt792xu_wfsys_reset(dev);

     clear_bit(MT76_MCU_RESET, &dev->mphy.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 76272a0..cfd385e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -269,6 +269,8 @@ EXPORT_SYMBOL_GPL(mt792xu_wfsys_reset);

 int mt792xu_init_reset(struct mt792x_dev *dev)
 {
+    struct usb_interface *intf =3D to_usb_interface(dev->mt76.dev);
+
     set_bit(MT76_RESET, &dev->mphy.state);

     wake_up(&dev->mt76.mcu.wait);
@@ -277,6 +279,14 @@ int mt792xu_init_reset(struct mt792x_dev *dev)
     mt76u_stop_rx(&dev->mt76);
     mt76u_stop_tx(&dev->mt76);

+    /* Same rationale as mt7921u_mac_reset(): if the chip is in a
+     * latched state (SEFI), register writes over USB are no-ops.
+     * Schedule a USB port reset before software reset sequence.
+     */
+    dev_warn(dev->mt76.dev,
+         "mt7921u: scheduling USB device reset (init_reset path)\n");
+    usb_queue_reset_device(intf);
+
     mt792xu_wfsys_reset(dev);

     clear_bit(MT76_RESET, &dev->mphy.state);
--
2.43.0

