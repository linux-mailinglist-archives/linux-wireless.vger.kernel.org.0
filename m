Return-Path: <linux-wireless+bounces-30323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA7CF17B2
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25E83012DDC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F678F29;
	Mon,  5 Jan 2026 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUoeFAnt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC4199D8
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572813; cv=none; b=hOmH/Xs8XqW6+xuh2JlUolZOp1Unil3NWcR7dVZrmDcBfscuLRsLtKpBfB61HbfgBYywhBTmTplA5tuoPqRK7aC9SnU77F4refNg+XXyH16euhyuWreBzJ7qnw/2Tf3ywCypJpYpM9nSoUxoVwWALVYOcNvwRr8rgm6S3rvRH/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572813; c=relaxed/simple;
	bh=/6QfKpPidHpDqvGcmuwJUfCyH+4jBNFqQ0+6iItk0sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvVvqrDFLLzg+ForB18iUyCNGU37sUuthG7lNyf6uPV86AFF+Ql6gvhGUw8AeC35aSrWK1bJR97eWaEl2qxLpBDS9jPe+r9ft8vogqS7jmGQhLFFW/AoSCwuLPBMe3Dwn20rw1dnJbDa/rSyL26vURaA4Q3JhKnrdcEbjJKZWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUoeFAnt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7baf61be569so13946030b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572811; x=1768177611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx+S5z3h6030ObTHHh0B/SCcYrL7BGZ5wBUiVpgW8C8=;
        b=kUoeFAntXDurCwykSojKmZQ4/wBezsSCCDlgyTHC0p+TZmUCiBcoJnMTWmzcakDHiO
         tN3PiZOu4yQ9BhWi2LvRFE2I2/mKu/a8lqRXkhYiqlf5RJlb9qY3MHjfpbfcqF5I0gq+
         oDgPTHaSnEFlijDgz8lrLmKxrObI3blyyk2/Wj0rkkjJI8qrGIAV2TNWSbFqQTt3kN4T
         1/bhVnHVfBWhemgBX0r8k/Dx4To06DVTuIZCBmt7ccSNvYyWFC4jG8clPCBruSUnYMD2
         NkYdb/wllI1jERgvn9v9izFckcCTQXISObPM7AOX3HyllRkqKIpTVfv9aAsRpaWHNTuH
         Je+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572811; x=1768177611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nx+S5z3h6030ObTHHh0B/SCcYrL7BGZ5wBUiVpgW8C8=;
        b=P3wb4lTdB2PU92XCAKs7mzPXGltVu3g9BYunU8+e54YgcYKYblaiya4EK3stLsDsCb
         SrTnb9eDiaIp3MZujjAxDEWx2jbJ87VGVNjz+OUuz3fByEndDzlzBc+e2cQY9QXAM8wR
         E9iR20YakHYtFjHqizGLS+Q2t6RRUgO3IMASIZAFDPjY11LeJOmN8Kpp8c1C2gRIE8NY
         KH0o3XUEMCXiu71k9TR7tKolVKPODgHY9SD5RUJc8D59xLT5moGRnul1VD+zUN23HqUt
         J6eTpPXwoNt7EBMc0KsYL5gPoEaGsJ479GR6kgEcu5fGGaH9wNowHizkrgTTWuPTntMd
         NX0g==
X-Forwarded-Encrypted: i=1; AJvYcCVM+iZ1ZFwd/SasdStaGpJMQTdN8998Y8zH84SSCKcqo5hOkoUKzmR1DI+bhMX8kjjiCqZxRbjd5jSvjxftPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLdR7PnOfamrOPutYZVrArXURP9XhwKogABJTJZJsfYtP/o2l
	nhIX7zOQ4ayHQgfbVbwne/Gu2tqGC0ZqP1vcKab9eh3XKSzIeDeXgGcG
X-Gm-Gg: AY/fxX6/0c7CrWmOz9O7XZXoXItqBnyMYgJVH+DY+agT0aowqHVRC4pc5vse5JnKIBr
	0HNvdrUpLOVtsB1PywUJBMvp4jWpLaOS3gZyNwsgmg/KI4N44dICB1XiIUgljrhzauvCr7XH59B
	ewqHC8uKIcWlTe/QiiX1YO5Ayu1ZqjAyLjWjOAngFcWdQwdMWz8LIvc0V8UFtLSRtfrErpEU8HQ
	bsc/S8XsyH6sSXhHgQkciYQ2lJLxupNLXnMwgNU4DLrA53kOQ85VpxH2l9kVPoTRubfveR5WFFs
	t9kdaO8GJKzuEtYoeRQaOY8gmM67zNOnt6lRx14HQNODlnNrmYO1mdu9vZD9LB5bfFifraIEkaP
	8nZy4YVqNWzjoTOLPDt2JOqBbyDN6G2r5ArzTngpcRZSYkLzMHCy2NFmX+TrFzhRPsmt6wTNveT
	vg2t8lli229Hrp2HBF5DxroV5R7BJO4mCUD939opYhHtI8533XCis1CzCLx2jzC1E=
X-Google-Smtp-Source: AGHT+IG07f4+BWjJlbqJDdFUMO7Ft/315N9xOwOmVA0qQn17sAgscoR34CTnkVLXsA8WiWEJB7CjHQ==
X-Received: by 2002:a05:7023:883:b0:11d:f890:6751 with SMTP id a92af1059eb24-121721acc21mr46191919c88.10.1767572811084;
        Sun, 04 Jan 2026 16:26:51 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:50 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH 01/17] wifi: mt76: mt7925: fix NULL pointer dereference in vif iteration
Date: Sun,  4 Jan 2026 16:26:22 -0800
Message-ID: <20260105002638.668723-2-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt792x_vif_to_bss_conf() can return NULL when iterating over valid_links
during HW reset or other state transitions, because the link configuration
in mac80211 may not be set up yet even though the driver's valid_links
bitmap has the link marked as valid.

This causes a NULL pointer dereference in mt76_connac_mcu_uni_add_dev()
when it tries to access bss_conf->vif->type, and similar crashes in other
functions that use bss_conf without checking.

This crash was observed on Framework Desktop (AMD Ryzen AI Max 300) with
MT7925 (RZ717) running kernel 6.17. The panic occurs during BSSID roaming
when the adapter attempts to switch to a better access point:

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  CPU: 1 UID: 0 PID: 8362 Comm: kworker/u128:10 Tainted: G           OE
  Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
  RIP: 0010:mt76_connac_mcu_uni_add_dev+0x9c/0x780 [mt76_connac_lib]
  Call Trace:
   mt7925_vif_connect_iter+0xcb/0x240 [mt7925_common]
   __iterate_interfaces+0x92/0x130 [mac80211]
   ieee80211_iterate_interfaces+0x3d/0x60 [mac80211]
   mt7925_mac_reset_work+0x105/0x190 [mt7925_common]
   process_one_work+0x18b/0x370
   worker_thread+0x317/0x450

The issue manifests approximately every 5 minutes when the adapter tries
to hop to a better BSSID, causing system-wide hangs where network commands
(ip, ifconfig, etc.) hang indefinitely.

Add NULL checks for bss_conf before using it in:
- mt7925_vif_connect_iter()
- mt7925_change_vif_links()
- mt7925_mac_sta_assoc()
- mt7925_mac_sta_remove_links()

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Link: https://community.frame.work/t/kernel-panic-from-wifi-mediatek-mt7925-nullptr-dereference/79301
Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 871b67101976..184efe8afa10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1271,6 +1271,12 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
 		mconf = mt792x_vif_to_link(mvif, i);
 
+		/* Skip links that don't have bss_conf set up yet in mac80211.
+		 * This can happen during HW reset when link state is inconsistent.
+		 */
+		if (!bss_conf)
+			continue;
+
 		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mconf->mt76,
 					    &mvif->sta.deflink.wcid, true);
 		mt7925_mcu_set_tx(dev, bss_conf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2d358a96640c..3001a62a8b67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1304,6 +1304,8 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	mt792x_mutex_acquire(dev);
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		if (!bss_conf)
+			continue;
 		mt7925_mcu_uni_bss_ps(dev, bss_conf);
 	}
 	mt792x_mutex_release(dev);
@@ -1630,6 +1632,8 @@ static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
 
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		if (!bss_conf)
+			continue;
 		__mt7925_ipv6_addr_change(hw, bss_conf, idev);
 	}
 }
@@ -1861,6 +1865,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			if (!bss_conf)
+				continue;
 			mt7925_mcu_update_arp_filter(&dev->mt76, bss_conf);
 		}
 	}
@@ -1876,6 +1882,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 			} else if (mvif->mlo_pm_state == MT792x_MLO_CHANGED_PS) {
 				for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 					bss_conf = mt792x_vif_to_bss_conf(vif, i);
+					if (!bss_conf)
+						continue;
 					mt7925_mcu_uni_bss_ps(dev, bss_conf);
 				}
 			}
-- 
2.51.0


