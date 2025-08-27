Return-Path: <linux-wireless+bounces-26703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A3B38553
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25BE7C0C3C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741611B4224;
	Wed, 27 Aug 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlSfuiwD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786F21C16A;
	Wed, 27 Aug 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305941; cv=none; b=FF3I3akm8L/ceeXafZ9lSdz+bb0hpk4hcu+agRP0eJTluq8b30o+AkzKNBybN2tNgpquEWe3Aex8x8c+f6c88SeEY7KXfhyLQt5FKLg7sHhncvYZbQ2m4Go0sjWGMmGQOZlNCv1WnuE98GElpkgo2pF02oqpPQG5A3iF2h77664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305941; c=relaxed/simple;
	bh=2fc+CeWMb52QC2P9N2MN4jA6tAwD2+LiKdNqWrJ8Ha8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bflx9RvNLOm6TYm7JierKT1iVOySYUmIqGv7cv15jCeYOZ4eK4JHY8IDgYdGYPGdZks5J7SprC4g/nYsGlQSWyyZI6vsL15MDvQ5RLcLFgH1XWXbePgMksJhthC5gAiqKTryP4GU/HaneO4gNIwDf9saDJHI7lPM10OAaVcAH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlSfuiwD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-771f3f89952so889995b3a.0;
        Wed, 27 Aug 2025 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756305939; x=1756910739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RH34VGXdU115jG2W9dmDFfXiy30TmSIHuSiiLtyS1Q=;
        b=LlSfuiwDt2ZkS+kpv8KD0oBDEo9Fzfcx8reQL2DEVC/6tC8YWe0xH+4aYJRAZAVnvY
         ImKP1/6C8+wrqfc6ni2QiY1EMnv3qemea8hwMBHU0t4/JQ2p1tsOF25+lzokgwu9gyIg
         yysBzT5R25K7mm7Jlh60l15vDfSJzMi2ew9xCSsk/A0kTIzyG7whIzoFxRgp6HPyrHMt
         b3KLIVA4aCGRThdTwcPy1+dZJtPKl03R2EmruD5+FiLgXUiVngZ8z3ouX6vHWiLkLxKz
         QfN1Q1vVp/8uvA9i/nOvD2h7R5W5jodkMHl5ILfumHX5QKeMipOpRNZ9mqnseqjEeDsy
         w1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305939; x=1756910739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RH34VGXdU115jG2W9dmDFfXiy30TmSIHuSiiLtyS1Q=;
        b=QKkok7DrlDl4T5sNeIbo4leQno5hIukUSe1siSTSx6cAwytPZ4Bw9KkQdEiaf3RwCI
         E2nsHGaco4QvqLkVjlTOjzJtd3nOJ5FUOkSNo0ioFKRNnhq3pqHF+o5UPWihvsFAxmOY
         CkKqlAfJV4Xxf189nymhyZb5Xz4ybVt2RfEhkOyNilwyCAvWp+LC99LuXPfX0GekS4Aq
         KgHrfwL2QRA+ok22C4/Hsh5XP+lUsD/L1OH3U7XxmhYUEKKfqIvcujeelm/4pBewYI2N
         hoYW1qr63V50672HGGacqSVSE/uuvkKcOzdd8mUOcp7GssrCGhWAS3nm4DcD4ZaZHdjs
         RU7w==
X-Forwarded-Encrypted: i=1; AJvYcCX5qlFVnli6E0mVoXae71pNXh1A0SNPVPErsvBQ1OH7z5YzYkhunmyHyPvYkhfdCsVQtEAsoQDQnV3CoJ+WQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WU0Ma+/Tz/YpnRxgF2Aw4eU7/hxbapKR/z6tfll+emOJ+exb
	UB0iObm3jPluIaDQV1pXH4tUVXmHKGSzcnXUQMBctWIv8d8vIsm0yAK9ty2C73fOzQ2Xnw==
X-Gm-Gg: ASbGnctgaJtS1z+t1L6LCaLxDvccikB73my8blzDkIPnhjKC6Ezd5RfWfVGv5XKesbC
	zJJaKJ1b2JA9wZ1OVSTricyFZZ8a4KjTpeNA+L/zEyTUv1TtmJAMjLtPUK/+DkAV5XN807N8CDX
	vsGqThd8P+T9KXhhnerhhtJJHhdIUPhu6fxs2r89MIcUrpfjcO3r2GzAvWrFMdwSKHWzOt1RyvE
	B9C+mlcg+/Ap9bVtNu90jym57DaitICMFBSuNc9wOoBTI1cLJrn+VpBpHzuva4jFNwh7q9j/uuz
	3+Ahw5sXS69DVDNJdoPGQhPxOvoMDUXTXDDY+JPHibG0xQQu/ewNmHkJ46HsFBOLJe3XvR62dvx
	nb44jeybu920Cf+FoggnlW8RyNNuM/L/Fr6zJEieH
X-Google-Smtp-Source: AGHT+IHEhIAAk5p/pFSBziDI0r9fSzNIQiDENmSphi60QByoM5ehPK4/lk3XHtQYeUwiOFBCQFq5ng==
X-Received: by 2002:aa7:9908:0:b0:76e:7ab9:a237 with SMTP id d2e1a72fcca58-771fc2942edmr4689280b3a.14.1756305938564;
        Wed, 27 Aug 2025 07:45:38 -0700 (PDT)
Received: from localhost.localdomain ([154.16.27.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f9f289c3sm4789794b3a.19.2025.08.27.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:45:38 -0700 (PDT)
From: Alexander Wetzel <lifangxu22@gmail.com>
X-Google-Original-From: Alexander Wetzel <Alexander@wetzel-home.de>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	lifangxu@kylinos.cn,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.4.y] wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()
Date: Wed, 27 Aug 2025 22:45:02 +0800
Message-ID: <20250827144502.1401-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 2c5dee15239f3f3e31aa5c8808f18996c039e2c1 ]

Callers of wdev_chandef() must hold the wiphy mutex.

But the worker cfg80211_propagate_cac_done_wk() never takes the lock.
Which triggers the warning below with the mesh_peer_connected_dfs
test from hostapd and not (yet) released mac80211 code changes:

WARNING: CPU: 0 PID: 495 at net/wireless/chan.c:1552 wdev_chandef+0x60/0x165
Modules linked in:
CPU: 0 UID: 0 PID: 495 Comm: kworker/u4:2 Not tainted 6.14.0-rc5-wt-g03960e6f9d47 #33 13c287eeabfe1efea01c0bcc863723ab082e17cf
Workqueue: cfg80211 cfg80211_propagate_cac_done_wk
Stack:
 00000000 00000001 ffffff00 6093267c
 00000000 6002ec30 6d577c50 60037608
 00000000 67e8d108 6063717b 00000000
Call Trace:
 [<6002ec30>] ? _printk+0x0/0x98
 [<6003c2b3>] show_stack+0x10e/0x11a
 [<6002ec30>] ? _printk+0x0/0x98
 [<60037608>] dump_stack_lvl+0x71/0xb8
 [<6063717b>] ? wdev_chandef+0x60/0x165
 [<6003766d>] dump_stack+0x1e/0x20
 [<6005d1b7>] __warn+0x101/0x20f
 [<6005d3a8>] warn_slowpath_fmt+0xe3/0x15d
 [<600b0c5c>] ? mark_lock.part.0+0x0/0x4ec
 [<60751191>] ? __this_cpu_preempt_check+0x0/0x16
 [<600b11a2>] ? mark_held_locks+0x5a/0x6e
 [<6005d2c5>] ? warn_slowpath_fmt+0x0/0x15d
 [<60052e53>] ? unblock_signals+0x3a/0xe7
 [<60052f2d>] ? um_set_signals+0x2d/0x43
 [<60751191>] ? __this_cpu_preempt_check+0x0/0x16
 [<607508b2>] ? lock_is_held_type+0x207/0x21f
 [<6063717b>] wdev_chandef+0x60/0x165
 [<605f89b4>] regulatory_propagate_dfs_state+0x247/0x43f
 [<60052f00>] ? um_set_signals+0x0/0x43
 [<605e6bfd>] cfg80211_propagate_cac_done_wk+0x3a/0x4a
 [<6007e460>] process_scheduled_works+0x3bc/0x60e
 [<6007d0ec>] ? move_linked_works+0x4d/0x81
 [<6007d120>] ? assign_work+0x0/0xaa
 [<6007f81f>] worker_thread+0x220/0x2dc
 [<600786ef>] ? set_pf_worker+0x0/0x57
 [<60087c96>] ? to_kthread+0x0/0x43
 [<6008ab3c>] kthread+0x2d3/0x2e2
 [<6007f5ff>] ? worker_thread+0x0/0x2dc
 [<6006c05b>] ? calculate_sigpending+0x0/0x56
 [<6003b37d>] new_thread_handler+0x4a/0x64
irq event stamp: 614611
hardirqs last  enabled at (614621): [<00000000600bc96b>] __up_console_sem+0x82/0xaf
hardirqs last disabled at (614630): [<00000000600bc92c>] __up_console_sem+0x43/0xaf
softirqs last  enabled at (614268): [<00000000606c55c6>] __ieee80211_wake_queue+0x933/0x985
softirqs last disabled at (614266): [<00000000606c52d6>] __ieee80211_wake_queue+0x643/0x985

Fixes: 26ec17a1dc5e ("cfg80211: Fix radar event during another phy CAC")
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
Link: https://patch.msgid.link/20250717162547.94582-1-Alexander@wetzel-home.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Conflicts:
	net/wireless/reg.c
Signed-off-by: lifangxu <lifangxu@kylinos.cn>
---
 net/wireless/reg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 213655aa6e48..950bf146227e 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3906,6 +3906,9 @@ EXPORT_SYMBOL(regulatory_pre_cac_allowed);
 static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 {
 	struct wireless_dev *wdev;
+
+	wdev_lock(wdev);
+
 	/* If we finished CAC or received radar, we should end any
 	 * CAC running on the same channels.
 	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
@@ -3920,6 +3923,7 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 		    !cfg80211_chandef_dfs_usable(&rdev->wiphy, &wdev->chandef))
 			rdev_end_cac(rdev, wdev->netdev);
 	}
+	wdev_unlock(wdev);
 }
 
 void regulatory_propagate_dfs_state(struct wiphy *wiphy,
-- 
2.43.0


