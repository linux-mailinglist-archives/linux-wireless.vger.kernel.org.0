Return-Path: <linux-wireless+bounces-14495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 505479AF940
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 07:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01DDB210C0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 05:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703313C9B3;
	Fri, 25 Oct 2024 05:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="MKWW9tjL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B3433CE
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835182; cv=none; b=KCJHBEWCYk6WHQSac0/SyDteYbycwTaQBmvSvzZHaZPdrE5LIJVpZanz2wzuQ/IMMskwJDE3rPa9B2oIkSgTUZUTsVZMjvTWo5hNRz8Td5wwx+tlfQy+uS8IXTKAQwRcTe85G7Ud94JNxSkipEPuMPh8bNvDMS2x3iPbOonIaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835182; c=relaxed/simple;
	bh=KGBi/3N22zXOpf+f37ooWSaqrhiCoM5X+Si7xLNwVAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wo7ScNCo5zYWd23jjJWZxdUyOFB5FOvlEOHnXRjtiJxOfeh6hc46Lbxr5+w7sLqUumgJZxFdumCha3pMcEcXu2moPqpHi7eUIoXWut0mllzIELSsgsLj5cPDd3EslEEG1Q2kTLJS7IRd9Bk2B6k9lFai5NLZdN/nghLwGAC3zFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=MKWW9tjL; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id C93C065567
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:40:35 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:201e:0:640:6eff:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id AEDE260ACA;
	Fri, 25 Oct 2024 08:40:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NeN4Iw4gBW20-wc8alyQz;
	Fri, 25 Oct 2024 08:40:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729834826; bh=6A79k2A/zcb72RqIvFJcx9WrxngNVHD4mD/XMa5TPuI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=MKWW9tjLgi7LOt3Pdmu4QtTpZO4lDj5eNZQBUag5liwWH1PE21yma2TyRucLqQp1s
	 8V5oESJ4+TjL/oiAmIF5hKWy4NqqFI81nqhxDsUTKUFaZCuXs3F/IjDrF8qyFcCtP1
	 Y+zhYacmSuXV4NRG0PbT6XhFdU3gX6TrUjNbxrAE=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Subject: [PATCH v2] wifi: ath9k: fix out-of-bounds endpoint index in htc_issue_send()
Date: Fri, 25 Oct 2024 08:40:20 +0300
Message-ID: <20241025054020.207044-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following UBSAN splat:

UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:35
index 255 is out of range for type 'struct htc_endpoint[22]'
...
Call Trace:
 ...
 __ubsan_handle_out_of_bounds+0x115/0x140
 htc_send_epid+0x1e0/0x2d0
 ath9k_wmi_cmd+0x31f/0x590
 ath9k_regread+0xdc/0x140
 ? __pfx_ath9k_regread+0x10/0x10
 ? _raw_spin_unlock_irqrestore+0xae/0x110
 ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
 ? __pfx_ath9k_regread+0x10/0x10
 ath9k_hw_init+0x4b0/0x2230
 ? init_timer_key+0x171/0x2d0
 ath9k_htc_probe_device+0xa66/0x1fe0
 ? __pfx_ath9k_htc_probe_device+0x10/0x10
 ? usb_hcd_submit_urb+0x345/0x1ae0
 ? usb_free_urb+0x9d/0x120
 ? ath9k_hif_usb_alloc_urbs+0x1077/0x1150
 ath9k_htc_hw_init+0x32/0x70
 ath9k_hif_usb_firmware_cb+0x240/0x4c0
 ? __pfx_ath9k_hif_usb_firmware_cb+0x10/0x10
 request_firmware_work_func+0x106/0x1c0
 ...

IIUC https://syzkaller.appspot.com/text?tag=ReproC&x=1734b9f1180000 makes
an attempt to emulate ath9k USB device in somewhat weird and obscure way
so I'm not sure whether this may happen on a real hardware. OTOH whether
ending with ENDPOINT_UNUSED in 'htc_connect_service()' may indicate the
malfunctioned real device, it may be better to reject such a device with
-ENODEV.

Reported-by: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=93cbd5fbb85814306ba1
Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: avoid conditional expression (Kalle) and return
    -ENODEV without touching *conn_rsp_epid (Toke)
---
 drivers/net/wireless/ath/ath9k/htc_hst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..a5bc0a5dfe7c 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -294,6 +294,9 @@ int htc_connect_service(struct htc_target *target,
 		return -ETIMEDOUT;
 	}
 
+	if (unlikely(target->conn_rsp_epid == ENDPOINT_UNUSED))
+		return -ENODEV;
+
 	*conn_rsp_epid = target->conn_rsp_epid;
 	return 0;
 err:
-- 
2.47.0


