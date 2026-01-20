Return-Path: <linux-wireless+bounces-31033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAkdEwfwb2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:13:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A92674C0ED
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CE19A6E7AC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF33ACA5D;
	Tue, 20 Jan 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRHDFooC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1AF3AA1AD
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939872; cv=none; b=LXFb+HfOxZ4whmBYoq5MEdPYsW99s62VfLkAb4mP7pLN6+qXpOm+jCnoMtKUX3z2xhVpwodfXux+qy7QBnkhz2kpapJw/KRlu6lL3Lr5dmUrVJRBv/EFMucfuJ8KeWqsoJrqf0JuMiTFYRRa7S6wVMzVnhPIhRLdIGhPlVKosrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939872; c=relaxed/simple;
	bh=dw+v98bzs7AEOBOdIaouQqk8BtpEtp3Mz4XYoc0A9n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzqjPZGD5Vg5KFIUofddnJ7tvwmqST9Lbnf1t0na5gvWb+IBghP7iUTyGTaRpNUF5a4fvw8ezBavX15T466ig1zzUUhPBsA2pw8mQwLYfKQaV/cJMOGH2luvOO0w1EMb0CtiwH5wMA6u1ldZL463rCB5HC26by9+mY6WNRGrQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRHDFooC; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so12153030c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939866; x=1769544666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiWhrqDfLoUsbF9Zs7wDHxbtT3qNnG6/I07ERDX6sCI=;
        b=TRHDFooCNPfb9zVI/xjHaP/Uyp0P/dWhtxVX8TsybXzug3wMxdMVwnT2QI2f3tYjQQ
         ZmUGuvmUpX09BgmUXnikaCJT8jS/lu1fMN5vPy0/4p9lPIxcdPdjTkgEWFsnbinv1bNe
         dxWg1ePpubUqLoqFFhyicGrKS2C1sAv7kIEYW8axbePsZh66DWlbbraexyMzF7f5b247
         jTTjrlba1kdmApDTZPBB65o00NFy5xRsUdQZPDQcX+E8P9pV5Cx3wzalFhTAE9mDPlND
         UgRYb1TdJyik8unhZbI7/vZp624bKYo10gRlxaxCOO6kD29FDmwUxS5GLg9ElT4Cw4sP
         sjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939866; x=1769544666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiWhrqDfLoUsbF9Zs7wDHxbtT3qNnG6/I07ERDX6sCI=;
        b=AfVUAvCIQ8RhqYKvLgg+YOIeanwrBU7/AkVbwvY93n23ZVDM4rWOMueGo0RakKsWBq
         6MiZ/D/wn/8BdbhqwjfbB93lXJCaMnWY8bmDi0PSvbD2AS8O95m6/SH2qfi4ODIHvlbM
         32kPjFzC9D72nTp+l5o3djHMakHWMSdimVJQ5oROgVAZKjauYjQklx2Jfmo6YwSHn4Ug
         lzFxF4BYnJmRMkROJczBh3I02YdZQ2pHFD1ZdQg4dp1KfgSRmLTmrWlFUiTThdYolKJr
         uIpZiWIhaXMzbaxiP1iCZWwOGL9A3ydRIP+E7fhxjbH8+OSnYWQHXtAjKuTRed+Qkw1w
         Z/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7ChlLZTVQdKLqC78NvYG9TtoRhQZAmnrd0CNMkyw8EdqJtXtWipaFRm9/zqZVSe5pK8u0UqTTWFQdA5UHVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhE3eocfY3b0RYG5X23wR1OHx+V6h5+MF/vPWVVRL8WWVzEQSh
	DhMtyZCkhl5vZE1F9k9bPF3MD1sw18BcpH3lMOir6+vRBzJD5vAqEjjV
X-Gm-Gg: AY/fxX5GSnKFj02/+sVckBnrTyN49AupgRezS7B2MeBJA1v5TzNpWJe+n9JKzaUCKrg
	lNpGmTAiZMBuE+wTrk2Nz264AhS/pM1ZKbuuh13Hw7FrzMrcF2DYIcHsJfMNkQq9t6PqjrGy/Ef
	yTrrtmbeb45MVXcJsLOyJfhNMEW+gj73/dRsERW5aANGQFz2zlAvFMxyeZr2NlofIhlkebz/ksX
	F9jZLN0fesugiruzLdB505ORx2su23QqE0E7vCht/pYCuxAv/x8YZsLbSsn0VdxAqGM0uFcgS/m
	8avUVOrkcn4hknoJ5br9e+ypAnt58+qQcH8lz0AUOlIdjnYbKH4QCgBen+lcbjy23VUP9n+Ixly
	oeUmRl5BQmxQcSApqOyRomIT0slLX8iMzvSUDiMWW1XKTTeW9Nu+OE+6r6L/pU33/zu4Fk4IRw0
	X26tdolBDXSYlYGPMJOObF5giKJP1OQ4tj2DwQLx56WGRLJwZOt2QK7ppn+tVnDVihrmEDcMOP
X-Received: by 2002:a05:7022:2514:b0:122:2f4:b247 with SMTP id a92af1059eb24-1244a75ea33mr10938645c88.28.1768939866099;
        Tue, 20 Jan 2026 12:11:06 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:11:04 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH 08/13] wifi: mt76: mt7925: add MCU command error handling
Date: Tue, 20 Jan 2026 12:10:38 -0800
Message-ID: <20260120201043.38225-9-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120201043.38225-1-zac@zacbowling.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31033-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:email,zacbowling.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A92674C0ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

Add proper error handling for MCU command return values that were
previously being ignored. Without proper error handling, failures in
MCU communication can leave the driver in an inconsistent state.

Functions updated:

1. main.c: mt7925_ampdu_action() - BA session setup
   - Check mt7925_mcu_uni_tx_ba() return value
   - Check mt7925_mcu_uni_rx_ba() return value
   - Return error to mac80211 on failure

2. main.c: mt7925_mac_link_sta_add() - Station addition
   - Check mt7925_mcu_add_bss_info() return value
   - Propagate errors during station setup

3. main.c: mt7925_set_key() - Key installation
   - Check mt7925_mcu_add_bss_info() return value when setting
     BSS info before key installation
   - Prevent key setup on communication failure

These changes ensure that MCU communication failures are properly
detected and reported to mac80211, allowing proper error recovery
instead of leaving the driver in an undefined state.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f1884944f77d..59a5b22a6ed6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -641,8 +641,10 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
 		mconf->mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
-		mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, link_conf,
-					link_sta, true);
+		err = mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, link_conf,
+					      link_sta, true);
+		if (err)
+			goto out;
 	}
 
 	if (cmd == SET_KEY)
@@ -908,11 +910,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		if (ieee80211_vif_is_mld(vif))
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, link_sta != mlink->pri_link);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta,
+						      link_sta != mlink->pri_link);
 		else
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, false);
+			ret = mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						      link_conf, link_sta, false);
+		if (ret)
+			return ret;
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
@@ -1291,22 +1296,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, params, true);
+		ret = mt7925_mcu_uni_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, params, false);
+		ret = mt7925_mcu_uni_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, params, true);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1315,8 +1320,9 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
-		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		ret = mt7925_mcu_uni_tx_ba(dev, params, false);
+		if (!ret)
+			ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
 	mt792x_mutex_release(dev);
-- 
2.52.0


