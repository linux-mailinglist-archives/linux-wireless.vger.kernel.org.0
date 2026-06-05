Return-Path: <linux-wireless+bounces-37420-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gxDXKvHtImpsfQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37420-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 17:40:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3B649646
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 17:40:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hGmpHWq/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37420-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37420-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D51C307C6E7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09B37F73C;
	Fri,  5 Jun 2026 15:32:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5973B8950
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 15:32:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673556; cv=none; b=DeiDyHV/OQMM2kgkYu8K6jprRPGzB2ryFYZh3HQ0CcV0+BKc9aCTurnU/kuv/fJcFXzHEdDR+29H6tzPQlFCudFCreDqekUjInBGbTY5dZAjeKTmapM84Niu7xuQQSxHzteKiZFNgmQnh8Pw5nxIySFAGrJb6oFeLqq+F0Ni6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673556; c=relaxed/simple;
	bh=ZO7DJ7Q2TV4680BwGuSuTa3KdjZPbRsVMqoCigQf3oM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bv7FrL5nziJ9dFzjV6tyi6DRETWxoxzB4shGSECelIrkjnfhWQV0NbxmGKQyDLumB9fB/0cFjJ0ivymW7/+3D1PvktEMk24DcsAXdIq3dlc9eVS9WJr4VUlFIYbdWTPJx6Pcff9RL0HQ4kV06cdQ9kvBtBIMdLW9HDvrcS89aSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGmpHWq/; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-307263ad0cbso2591953eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 Jun 2026 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673550; x=1781278350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4t1HT0gmdAX/Od4iwq0hPUAZwXn8xg5Ne+EioTpL46U=;
        b=hGmpHWq/kg9NltI2Jp4iky04Mo71s+8R5b/+UpZuQ395SLWV8XguOdsxf+UL2XNV4T
         4oIZPWpx8Pu6ilwgo2EOFTOyqHXTdAqFQhhdimQWeer4LbP67zwMHNMPEiTUw9eXQK+4
         BJ1qn9WDgTPek85X5tOeagafgi4po3o82acQPm3NwqrUp5erjDBUW877n53oaCqYwDV3
         YF5K3qKPmnAa3Nvfa/WrLCHP53/ytuwv3lrkqhVkqAL/OpzyNZx/hPhOokMcvKwiUxd9
         1W4MuEOUWmNdHmYicl8WF9HU19aHHL7rlD6XL0b+b2inPSo7hklVVgX2Z1/Vpx1obycp
         z1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673550; x=1781278350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t1HT0gmdAX/Od4iwq0hPUAZwXn8xg5Ne+EioTpL46U=;
        b=YMSluUXprYh7oFCl+6VbdgbBKe4PBvK9D47/LJ42cAcOZUYVR+WZgAPvu4rCSe0yeH
         k3dwfkYlNPlJeb12KIxxDccL8uJiaCi3cmhg7I2/E/Rge4D385u5pf0EGd5r3RH+Yfe9
         rh5Yi8FY0aQAoO5dNnXIeh3xTsKLhx8jUnohaGMfzq4gJvhYohYxnhtGJV6QxSrCOO/m
         N7kQcq8GJjL3nuNo9UA5QRo5xD6TLZqv+q9YVjOlWkbbNWEA2M2kZ2R3kMR79gYPIjL+
         IVbFqN97JCNoQwTaY3AEyQahhJk24tcbayRCEViSZlmxfSgCVs3oYum/90WyIJb0vWh3
         C8jQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mZOUvZtoTp9Xgc7H6B+33BXW8Z7QHkb0R03IroMfliC2jqc/0WooqxatLjY//KljfccrIvvO0SHvFKPlyiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkyMNAmTudH6Y+VPDs22fNm4Sz5lxspvw67ziWuIUBAnkZoAE
	HKJ0OZ0Fo8XHSUCirc0TTDNwDZEM1UlCRV+rwa5DbIyjlgxYwRzw3s+NbGaMyL1hjFg=
X-Gm-Gg: Acq92OGQ54JPc+dkp+O42GkS63V+2tqG0Doctf6QdcVXh77e2TFk6o49FzQTyIa0GE4
	jQpk/6hV267A/Z+CZALy98LVEZmPcsnu8tnxmP6o+4G8HUulgQewz3+3oxhCCCogil1JYrx7eTz
	QcJgJKtpVmZpXkGK+e7vb2oK6z/cUjUZwMrB2qfypkkDXLe+bvzFIB7kMHpd6IBy6Z0YqfbrTiG
	TBasaNiAKGXu78XYeZC1lwhBVoIRh+MnkjYhFdvYJtmu93KeODlygOpdVH3gqBu8dRGCH1O1uwq
	MguQfFI6CuRuCzxiXKtd3CdrzPVSKlFuKi0mw8g6uaoCWERnch08k17QFPI3b9llyNWMFQ21JEY
	pnVIy6qec5sFVFk1CH+8yhanKpcJSMuxisZFSTWurhWMQD+pu2VsmsyVHECOzQEMZogWBg3ep+o
	ZDcZXg97BKvO9f+kRhYbCDnMwnOiAzkx4sIl5iR0+56pDtdb0gos5CBgwFxEn+/CGViGKXnjSQ
X-Received: by 2002:a05:7300:ec15:b0:2ed:e14:7f5c with SMTP id 5a478bee46e88-3077b2d99efmr2017679eec.32.1780673549840;
        Fri, 05 Jun 2026 08:32:29 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm8127092eec.2.2026.06.05.08.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:32:29 -0700 (PDT)
From: xiaoblac <teel4res@gmail.com>
X-Google-Original-From: xiaoblac <1020691186@qq.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>
Cc: Oleksij Rempel <linux@rempel-privat.de>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Cheng Yongkang <teel4res@gmail.com>,
	syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com
Subject: [PATCH] wifi: ath9k: hif_usb: don't dereference hif_dev after re-arming firmware request
Date: Fri,  5 Jun 2026 08:32:10 -0700
Message-Id: <20260605153210.20471-1-1020691186@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[rempel-privat.de,vger.kernel.org,googlegroups.com,gmail.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37420-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:kvalo@kernel.org,m:linux@rempel-privat.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:teel4res@gmail.com,m:syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[teel4res@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[teel4res@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,50122cbc2874b1eb25b0];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,qq.com:mid,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45D3B649646

From: Cheng Yongkang <teel4res@gmail.com>

ath9k_hif_request_firmware() re-arms an asynchronous firmware load via
request_firmware_nowait(), passing hif_dev as the completion context, and
then still dereferences hif_dev:

	dev_info(&hif_dev->udev->dev, "ath9k_htc: Firmware %s requested\n",
		 hif_dev->fw_name);

The re-armed callback ath9k_hif_usb_firmware_cb() runs on the "events"
workqueue and, when the firmware is missing, walks the retry chain into
ath9k_hif_usb_firmware_fail() -> complete_all(&hif_dev->fw_done). That
releases the wait_for_completion(&hif_dev->fw_done) in a concurrent
ath9k_hif_usb_disconnect(), which then kfree()s hif_dev. The trailing
dev_info() in the frame that re-armed the request can therefore read freed
memory (hif_dev->udev, the first field of struct hif_device_usb):

  BUG: KASAN: slab-use-after-free in ath9k_hif_request_firmware
  Read of size 8 ... by task kworker/...
   ath9k_hif_request_firmware
   ath9k_hif_usb_firmware_cb           drivers/net/wireless/ath/ath9k/hif_usb.c:1247
   request_firmware_work_func
  Allocated by ...:
   ath9k_hif_usb_probe                 drivers/net/wireless/ath/ath9k/hif_usb.c
  Freed by ...:
   ath9k_hif_usb_disconnect -> kfree   drivers/net/wireless/ath/ath9k/hif_usb.c

The fw_done barrier only makes disconnect wait for the firmware chain to
*terminate*; it does not protect the outer ath9k_hif_request_firmware()
frame that re-armed the request and keeps touching hif_dev afterwards.

Drop the post-request dev_info(): it is the only use of hif_dev after the
async request is armed, and it is purely informational (the dev_err() on the
failure path runs only when request_firmware_nowait() did not arm a callback,
so hif_dev is still alive there).

This was first reported by syzbot as a single, non-reproduced crash that was
later auto-obsoleted, and was independently rediscovered by the reFuzz fuzzer,
which produced a C reproducer (USB-gadget connect/disconnect of an ath9k_htc
device whose firmware download fails). The vulnerable code is unchanged and
still present in v7.1-rc6, where the slab-use-after-free reproduces under KASAN
once the (sub-microsecond) race window is widened.

Fixes: e904cf6fe230 ("ath9k_htc: introduce support for different fw versions")
Reported-by: syzbot+50122cbc2874b1eb25b0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=50122cbc2874b1eb25b0
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1225,15 +1225,10 @@ static int ath9k_hif_request_firmware(struct hif_device_usb *hif_dev,
 	ret = request_firmware_nowait(THIS_MODULE, true, hif_dev->fw_name,
 				      &hif_dev->udev->dev, GFP_KERNEL,
 				      hif_dev, ath9k_hif_usb_firmware_cb);
-	if (ret) {
+	if (ret)
 		dev_err(&hif_dev->udev->dev,
 			"ath9k_htc: Async request for firmware %s failed\n",
 			hif_dev->fw_name);
-		return ret;
-	}
-
-	dev_info(&hif_dev->udev->dev, "ath9k_htc: Firmware %s requested\n",
-		 hif_dev->fw_name);

 	return ret;
 }

