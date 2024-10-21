Return-Path: <linux-wireless+bounces-14247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A958A9A5F0B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D93A1F2268A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 08:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931851E105F;
	Mon, 21 Oct 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jHaejYpt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0F1E2849
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500462; cv=none; b=VdiCDyQKO6gW4V7jUfbw9cPL4dqa0T58CTGpI6PN9S9n12VmJkVB8+k2E6nskVHBMZB5XzrZx+7qXX3EatziBKHPDrdKl4mA3C1t+Xkum8aI8H7tMUT+nNtx5ug5a/lx5C2PedtT/kIBwk/xRHQ/A/GaFwi21F8M4FXf3oyfsx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500462; c=relaxed/simple;
	bh=SUf1Ur1fw4q0WgA9kIqzDXofD7mbJsLrjgxMrnWyrZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbfUwiRGBC6ANWVDkr5GpVbwHEvVsOp3bo3R2DglaB8+RoUsihyCrZ5Tqep9GwpOsqLC9b+kbvGYeSRbrAUzBkoliqwEaHu4if5qsiBu0NwNk+VOkcT/Jd5Y5mhLk7fakC1hFKSmLpwAWvQ+d0YE6bD4qdlF4PNLtIy1SITmkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jHaejYpt; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:df8e:0:640:17d3:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id DEAF360AAC;
	Mon, 21 Oct 2024 11:47:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UlMg8SPFbOs0-K8OtArae;
	Mon, 21 Oct 2024 11:47:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729500455; bh=pq0bPGnjNQD3Kv2DLqE00qTXOzZff9nh3JXhC9nflzI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=jHaejYpt4IBiPsD9FCokBWMkqN4gItpEz0sgPwCd22OXn1fEVXpYIqrU4ysCkyV8a
	 VHxCA/U3VKCEiDAmnQW4aoNX9WIjXCylNBaWwq03VzhtcCZDHZFMurX/jeLl4AFz3c
	 aRpT0tqJQUD6tPbuHWSIkDvEB0xSoue13gelWuc4=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Subject: [PATCH] wifi: ath9k: fix out-of-bounds endpoint index in htc_issue_send()
Date: Mon, 21 Oct 2024 11:47:17 +0300
Message-ID: <20241021084717.480413-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

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
 drivers/net/wireless/ath/ath9k/htc_hst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..4288ef5b8df5 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -295,7 +295,7 @@ int htc_connect_service(struct htc_target *target,
 	}
 
 	*conn_rsp_epid = target->conn_rsp_epid;
-	return 0;
+	return target->conn_rsp_epid == ENDPOINT_UNUSED ? -ENODEV : 0;
 err:
 	kfree_skb(skb);
 	return ret;
-- 
2.47.0


