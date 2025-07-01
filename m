Return-Path: <linux-wireless+bounces-24730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3BAAEFC47
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB0516AB39
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8B134A8;
	Tue,  1 Jul 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD+BtCUd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7037275110;
	Tue,  1 Jul 2025 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380011; cv=none; b=TfJvyewQXbnfGQjeuHxyO8KGwoJa9BUl2n6LugSbMkx7JGje4G/rZEtDwKNDMzMnrvTnbPT6mADJkLf5tuMXZzoc31OBwXHAiVJlRdupgUMCN8rG8CUBZCKizw25K9WvaSaZnRIdyd/IuOsBeXHm2Zc+IUY4s3l21/b74RNDexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380011; c=relaxed/simple;
	bh=VKqbpDnp5YJWvYSLSzCjGnGFYy7lHAIC4MNQGUWCoOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tp+HKBzxhF4dVcOOC5Cgwkd2QkYUfpzBv4xB2XtbD24L9TIOeYmKZ3PDOwMH74aa9/9mAZ0bV2g1Sca9Rrla9lCCvvJNbBlbeTQmsVnHvWV0750qXO55UQd1j7YgeqiyaozsBn+yYn++RtzsDVqUX+TYo2mf4SU2JZ0MakRyG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD+BtCUd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so40540635e9.1;
        Tue, 01 Jul 2025 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751380008; x=1751984808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5C6WmevjDKaDna/31sfLEs3MsnwkVO9XcEaPYksnvI=;
        b=hD+BtCUdi872p7AjaKgK02q1IaWKDNpumXa7GWBWNdQS29z95qTeNzIGIkcIfB5JzJ
         Czwiw9bGmMlqZCkkY1E047zNe1gIq8xtluZREyDO38JXRXevgUf9QfklgKupRjU8geDa
         HT+5U3jJgJ3WckhtqR1GXQbqlg9rKxul10NgqVgd+krL+yw/CiTsfDc7Yr+m4b/uQv8X
         +INzL+t2Y357azOUGDxgQ9JcJ7KrYMIElMLC7AKRxOPTJWMEqbDqYXoR0t05+yoK6WqQ
         1c/dVtgzH0k2ddF+NOmgeK+A8UJLlxaRLpIQE7IHrneKCty9SqCSOtXTCRoBk4ComRG5
         r6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751380008; x=1751984808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5C6WmevjDKaDna/31sfLEs3MsnwkVO9XcEaPYksnvI=;
        b=U+h0Pfx1fuk54ZTACng3LYHkiDQItGUAkDj7aGo3QWxXypWbKphykYZ1x9hMm8fd6N
         Vk3AyWglQ9iRUMZSsJhbuf4Rt48Z3e8DrlwLKHicMNtKQS0rEXkXtiatpADwc0Ie2Dhx
         UbXEUKJ/CJwTHWc5jLhEdzwsECOUGHDgbG0sfIGw6okmmVWMZJOcu+2M+OewKTWmORjP
         2gnxZoIDle+C4md1aRuqCtUixcoFGOnswdU9HLS50sxjv7gARdAn23fEBXcp+dT6pMMh
         q+KQF9BJdMm3GsqCwORS6fHCujsxlUrSodUVX7SBRNpmzOoe30E9nllw/kJfSOwA1r5i
         5FWA==
X-Forwarded-Encrypted: i=1; AJvYcCUpm3nRIFBoPycTqtQ75SW3Oec72HSyFsp8RZK3/z3ImSjlK0+H/hN2jTElkMB+zD1ri4WWys3O@vger.kernel.org, AJvYcCWyuy2M8wdVTn9K5lXZgD6ZdU3CRt+OGJt7owqsf9muJJOUUDs+v4EpteVkOyk7IKyaSleb9FHGXRyP2ZY=@vger.kernel.org, AJvYcCXFR6H24WEYma5Mf4utoTStDB3+FRG1tuwQ/P9340dlREV4ooU2G6BvzhrwUH5mHTYAHFvbpNK95UtH7SM/q74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTM0zkQgBnq4TBxiVMDk0b0IIc9xZKj9pxBvYwNUPzMxJnO7pV
	2hWWG4jKLgHx+T8oDMF9O097QB7okue+QL/ZtQIysw1e5oWmE4GXPSF6+szaGA==
X-Gm-Gg: ASbGncvUjttwAZyMZ1uEpb29XTn1j8o/ldKL4PLteW7z3hDTi7EgxilVxVdSF6zB8pp
	TRuZQfyYZnKxFg4Fu+oDcOfAauIugEs70pIlSyhgtoDVprqhZKF7pGf7GX/4H1IgZCUh0o2mSQt
	iEgJO07/N9Z07zdiSzTuA++4uP7DwNSOICT8FilMWPcsmYGCk8K+eiN/IvpiGc5SrGCsAmR7bzQ
	/scGvocGaeJSdP6TKkWZh9wReAxaBRf0mf37nNprgWxsv+nTdRgB+i+gOd7rIGbGwtNhzR+z+Fk
	b3knPB0+3Co+axCWPVl3wXm5sYsyZl4uMBW8toOMNnXfuJibzlKGdEJ+uiVP43zLV3awkWfgZjE
	guz2oyFAGtPuGCg==
X-Google-Smtp-Source: AGHT+IHLYhRpmrOeQjexDpy6zXKzSJNFPKeQh79s40oGD2wiJVnkYFi5mmgQTeBcRR+8+ZYfSwIpNg==
X-Received: by 2002:a05:600c:45d0:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-45422f306b3mr29199855e9.3.1751380007710;
        Tue, 01 Jul 2025 07:26:47 -0700 (PDT)
Received: from vitor-nb.. (bl21-87-120.dsl.telepac.pt. [2.82.87.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad20bsm197980195e9.20.2025.07.01.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:26:47 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>,
	ivitro@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH wireless v1] wifi: mwifiex: discard erroneous disassoc frames on STA interface
Date: Tue,  1 Jul 2025 15:26:43 +0100
Message-Id: <20250701142643.658990-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

When operating in concurrent STA/AP mode with host MLME enabled,
the firmware incorrectly sends disassociation frames to the STA
interface when clients disconnect from the AP interface.
This causes kernel warnings as the STA interface processes
disconnect events that don't apply to it:

[ 1303.240540] WARNING: CPU: 0 PID: 513 at net/wireless/mlme.c:141 cfg80211_process_disassoc+0x78/0xec [cfg80211]
[ 1303.250861] Modules linked in: 8021q garp stp mrp llc rfcomm bnep btnxpuart nls_iso8859_1 nls_cp437 onboard_us
[ 1303.327651] CPU: 0 UID: 0 PID: 513 Comm: kworker/u9:2 Not tainted 6.16.0-rc1+ #3 PREEMPT
[ 1303.335937] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
[ 1303.343588] Workqueue: MWIFIEX_RX_WORK_QUEUE mwifiex_rx_work_queue [mwifiex]
[ 1303.350856] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1303.357904] pc : cfg80211_process_disassoc+0x78/0xec [cfg80211]
[ 1303.364065] lr : cfg80211_process_disassoc+0x70/0xec [cfg80211]
[ 1303.370221] sp : ffff800083053be0
[ 1303.373590] x29: ffff800083053be0 x28: 0000000000000000 x27: 0000000000000000
[ 1303.380855] x26: 0000000000000000 x25: 00000000ffffffff x24: ffff000002c5b8ae
[ 1303.388120] x23: ffff000002c5b884 x22: 0000000000000001 x21: 0000000000000008
[ 1303.395382] x20: ffff000002c5b8ae x19: ffff0000064dd408 x18: 0000000000000006
[ 1303.402646] x17: 3a36333a61623a30 x16: 32206d6f72662063 x15: ffff800080bfe048
[ 1303.409910] x14: ffff000003625300 x13: 0000000000000001 x12: 0000000000000000
[ 1303.417173] x11: 0000000000000002 x10: ffff000003958600 x9 : ffff000003625300
[ 1303.424434] x8 : ffff00003fd9ef40 x7 : ffff0000039fc280 x6 : 0000000000000002
[ 1303.431695] x5 : ffff0000038976d4 x4 : 0000000000000000 x3 : 0000000000003186
[ 1303.438956] x2 : 000000004836ba20 x1 : 0000000000006986 x0 : 00000000d00479de
[ 1303.446221] Call trace:
[ 1303.448722]  cfg80211_process_disassoc+0x78/0xec [cfg80211] (P)
[ 1303.454894]  cfg80211_rx_mlme_mgmt+0x64/0xf8 [cfg80211]
[ 1303.460362]  mwifiex_process_mgmt_packet+0x1ec/0x460 [mwifiex]
[ 1303.466380]  mwifiex_process_sta_rx_packet+0x1bc/0x2a0 [mwifiex]
[ 1303.472573]  mwifiex_handle_rx_packet+0xb4/0x13c [mwifiex]
[ 1303.478243]  mwifiex_rx_work_queue+0x158/0x198 [mwifiex]
[ 1303.483734]  process_one_work+0x14c/0x28c
[ 1303.487845]  worker_thread+0x2cc/0x3d4
[ 1303.491680]  kthread+0x12c/0x208
[ 1303.495014]  ret_from_fork+0x10/0x20

Add validation in the STA receive path to verify that disassoc/deauth
frames originate from the connected AP. Frames that fail this check
are discarded early, preventing them from reaching the MLME layer and
triggering WARN_ON().

This filtering logic is similar with that used in the
ieee80211_rx_mgmt_disassoc() function in mac80211, which drops
disassoc frames that don't match the current BSSID
(!ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)), ensuring
only relevant frames are processed.

Tested on:
- 8997 with FW 16.68.1.p197

Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/net/wireless/marvell/mwifiex/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 4c5b1de0e936..6882e90e90b2 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -459,7 +459,9 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 				    "auth: receive authentication from %pM\n",
 				    ieee_hdr->addr3);
 		} else {
-			if (!priv->wdev.connected)
+			if (!priv->wdev.connected ||
+			    !ether_addr_equal(ieee_hdr->addr3,
+					      priv->curr_bss_params.bss_descriptor.mac_address))
 				return 0;
 
 			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
-- 
2.34.1


