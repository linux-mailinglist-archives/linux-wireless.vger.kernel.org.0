Return-Path: <linux-wireless+bounces-12533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20F96DD43
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1C91C2244C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8C539FC5;
	Thu,  5 Sep 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vRTFRtqy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E62F870;
	Thu,  5 Sep 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548698; cv=none; b=K8f9YV6WvcQtss4ACQp6wjSNt0Fe1OOnh4o1wgw+xZSpPBiUOhoC4yZounxLJd7hUDSPh+x77BioDlhOV9lzKPYVwpZ7LICNXJvKehQFptiijp1VATLzGt0Pb4K8o89wlN17JgoqAMGxVvTU8vygKIfaQ0+GOf2buNCcJ+6M2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548698; c=relaxed/simple;
	bh=vruifMt9jJV41i0HP2Eom4MO7+B2BqcVmvMVRs8z1rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ri8JmBH3RE64/XCUejPDIen5Auf3J1c4AkQDx8Nsn8d9OYX9XoMq4sr/zlptAfgkqFrZlqgPEWJ07wxYpdeypRwL2fiEnELRlhu4TrunWC1FaRiwW9h/9bIub+SYlqYHZ1MKVfrWM1aukAELm8LVekNxHdxJQSilq+uT9ZaKINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vRTFRtqy; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id CDFCB616B4;
	Thu,  5 Sep 2024 18:04:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-42.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4749:0:640:7137:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id D2B72608EC;
	Thu,  5 Sep 2024 18:04:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id g4fVLnGMoeA0-s7lnmQ6c;
	Thu, 05 Sep 2024 18:04:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725548682; bh=BRAkwj4fTjxySbhtRhCHYyGmhowE49Q+BsiYDKJ038E=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=vRTFRtqy/YpKJ9h4hL/hN3PnssvFkz382LJM3s+6FW1MyI2KlPeNlRtByh6Tx2Tnk
	 nG/k/8ah6diAKXN7LUl/pfuS+jS7SZxQpTee9cB5AD+YbaRPqn40sXRAE2hJ0qUWxH
	 lV7GPyvVzBaCJGJzUY7HeiT+CdvfrdVHLnQFF+ng=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
Date: Thu,  5 Sep 2024 18:04:00 +0300
Message-ID: <20240905150400.126386-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking at https://syzkaller.appspot.com/bug?extid=1a3986bbd3169c307819
and running reproducer with CONFIG_UBSAN_BOUNDS, I've noticed the
following:

[ T4985] UBSAN: array-index-out-of-bounds in net/wireless/scan.c:3479:25
[ T4985] index 164 is out of range for type 'struct ieee80211_channel *[]'
<...skipped...>
[ T4985] Call Trace:
[ T4985]  <TASK>
[ T4985]  dump_stack_lvl+0x1c2/0x2a0
[ T4985]  ? __pfx_dump_stack_lvl+0x10/0x10
[ T4985]  ? __pfx__printk+0x10/0x10
[ T4985]  __ubsan_handle_out_of_bounds+0x127/0x150
[ T4985]  cfg80211_wext_siwscan+0x11a4/0x1260
<...the rest is not too useful...>

Even if we do 'creq->n_channels = n_channels' before 'creq->ssids =
(void *)&creq->channels[n_channels]', UBSAN treats the latter as
off-by-one error. Fix this by using pointer arithmetic rather than
an expression with explicit array indexing and use convenient
'struct_size()' to simplify the math here and in 'kzalloc()' above.

Fixes: 5ba63533bbf6 ("cfg80211: fix alignment problem in scan request")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 64eeed82d43d..d747d5f63278 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3467,8 +3467,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 		n_channels = ieee80211_get_num_supported_channels(wiphy);
 	}
 
-	creq = kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
-		       n_channels * sizeof(void *),
+	creq = kzalloc(struct_size(creq, channels, n_channels)
+		       + sizeof(struct cfg80211_ssid),
 		       GFP_ATOMIC);
 	if (!creq)
 		return -ENOMEM;
@@ -3476,7 +3476,7 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	creq->wiphy = wiphy;
 	creq->wdev = dev->ieee80211_ptr;
 	/* SSIDs come after channels */
-	creq->ssids = (void *)&creq->channels[n_channels];
+	creq->ssids = (void *)creq + struct_size(creq, channels, n_channels);
 	creq->n_channels = n_channels;
 	creq->n_ssids = 1;
 	creq->scan_start = jiffies;
-- 
2.46.0


