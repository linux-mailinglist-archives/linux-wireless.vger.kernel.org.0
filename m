Return-Path: <linux-wireless+bounces-30859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF6D297FB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BF6A3088DF6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C12F261C;
	Fri, 16 Jan 2026 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3TsmA62"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F817314A6F
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525528; cv=none; b=nkcL2whG7JjDy33mzXxuT0xwCoyXVbttj1sHISkVJ0K7m7up+GGxouEcQcLi26oP7Sj3wksfHJ73UdqCivDDiQfdtzBceCmqG33gTf5PcUp8+xwafc4/lN8PGBH+1cfvKWA+59hFWhZ0u8M+XS7aLWwSGUJaWjffKw3yQK7w6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525528; c=relaxed/simple;
	bh=Q0dojqi+j0KMnPt+naVmvNKSZbEfuyxt4g9ZjMcJ0QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/efPW9UQOAk7yHABU3s+bv3RRHBb/tBpkF9R5TYrfoTkJ/Wuu1ccj/h57bjuTnU9LiFSRHlXyWgIM4DjIe1Y5fENzTeiFP4+wbo4ffxKa5+U2IPp3PDPEmsyIcp5MC0KS/3d7St9lFq7u8DWcnU2+ZmYJubphug2yWH98XgCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3TsmA62; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b6bb644e8eso30911eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525526; x=1769130326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmitJgGTb482NSa9dbipMswu0tysB2njmnlh/lsqfgI=;
        b=E3TsmA62RJXbh3Ybm/HlL66PcLssoMhjToThy602s0pnC8SHiuX1LIqDxgsoL7WRtj
         qOJ98WVlJtR04i/YWeOShxDZfW6rfcVsp9bBgOmq9hWcb+bnEPFfZMkJBn1yPyd2HxzC
         uaHbhcXjf3DAaaW8ph2LUBhdkoh2CE1A2uL7/4MQj24GOcX95U0bwKYAm0l5P6PsfjVp
         mc431/U6v8Z7IGJBwlyB5sPvdQujJD7DG8eehPkC7u/s2/AEftRw8FBiGbOT1wPWs7uJ
         r5k51JLb/1EU/erxv5gyao38bxgxDCGlYQ5Cg5SWToVIJIRbxwnwr0ozSHX/uH2D8O2+
         tk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525526; x=1769130326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmitJgGTb482NSa9dbipMswu0tysB2njmnlh/lsqfgI=;
        b=smzNlwawlnmsWpUD7uIIU+gdrszPgC7r2/1oZ20NFix83CWL5mpmU8J/1fVxi129EM
         vb6VJZxHf8rTN1xDF3rLzxK1/n0fX6SEbWXRb6bzA3nvrz90gsc/M7FSnvvIilVNWEax
         PH62PkWJwDNmJhY4ezw2Khb7vXurSGEonQA8vciu0pis91k8aYuLCZ8ZAcZul11Vj0KW
         +5/qti3xuWsqpKR4WforBa3Go2BzjhJVUNaIiztCTN64ef1n2PSNYwt9+m7x7IeZX62g
         iqrY/bikL4k4C0qbUDe9pzITWBScEpdWe9OBClBjppQFJiBr6zZnga9tuZsCI8MNCYCd
         C5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUE18J72Do+c+87TbEnQHFZjJd5UYs7MmdCXL7ijeN21I+3/vgDWwr58y6tIPTqe6rQTN9TJJB1HtC13jN17w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMFu1aBhS7paYaffBz9T1Vb82EKzGdmiclqSXqQknrwFLrxLT
	m0i3H2+IyilaERXBn6djQuAQOkhjAii8hQXT6rGJGhqw4sDRQ3UJjaMy
X-Gm-Gg: AY/fxX7bSlN8u7Kw2yGFMo2/A73mtJtBEsAKfjsm6dVMUaEctosGCdc829OtAibmwEn
	yqZvGjcddYAg5auDtwFl1lv8FXhZyikxTNpF74zCt3fHF6nXtbUy/0cY1+G1S5b+PJoxPLfAl0b
	X+ow59JyfLl7OiAw5OXgcI3r09cHacYe1qyrLObILr5OZ8eg13vpvKqOOe2znqUV1CLGhhbOqP0
	iw4HZXThhoRKRiFkSnCZ/k/NLMItLkgvtt++puf+ic5CjVyPLlud55S4Pgb30zvyRolr79YRWBR
	HPeWz+mvwuv53dN/sbG/XENSplXqkd6+vwn4y/FmNtwBr9B59u7RuRo/NDM1gxRCnplJn/CapRt
	7yatZBfh0/nt1aYWLKsw4ONfVFZGBeolQPVpUdHyOgz1Se8wK+9oARALgE9qj97D6mbcnEjbPdF
	6y9899OxBAzEqPWGu6UdDwykhVT7gyL0onZlm4yZcAmpKCv2kUiAowZ6TnjsCntg==
X-Received: by 2002:a05:7301:1286:b0:2b0:59f9:aed6 with SMTP id 5a478bee46e88-2b6b3f182cemr1704175eec.9.1768525524645;
        Thu, 15 Jan 2026 17:05:24 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:24 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 01/21] wifi: mt76: mt7925: fix NULL pointer dereference in vif iteration
Date: Thu, 15 Jan 2026 17:04:59 -0800
Message-ID: <20260116010519.37001-2-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zbowling@gmail.com>

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
index 871b671019..184efe8afa 100644
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
index 2d358a9664..3001a62a8b 100644
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
2.52.0


