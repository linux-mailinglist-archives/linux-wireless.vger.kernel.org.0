Return-Path: <linux-wireless+bounces-30999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612ED3BF3F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8362C386E78
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84E638A9BD;
	Tue, 20 Jan 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPJv5e58"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65F387367
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890550; cv=none; b=h0XR7VaxHRaLOC5j00aBoOacy09FzqRlUNwBCxEDeG8Z1It0kkTyNM5VfebLKjyjQDuzURGFx2RdZyhOAhALNkTFZEfaGyctgHHyNNNBqL36S5hdWJ12GTsVYu1jtNPIhOy7niVocyhZHJzy1ezNvYm3N1Xvyp61WzpeFjhvedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890550; c=relaxed/simple;
	bh=56oCFiJ1Fh61sRezmynDWOGrNpWTbudvtUqxK0WIYv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuUzEno1ubz5qH/tN7ppn4nlYn5nCHbzua+k8MMq3ujiPbkSAxCvMCp9y0O+SKqhu1ojmSGDVFh8g6QQtBFwJT2wQQFa/lNuimmdWDe+FZy7UNVvTgckXz/rZhsdAcvimxdr05uDD92DLiLlVoSY883OpCeQ2NtIN8nfUdC7k5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPJv5e58; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso5272122eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890547; x=1769495347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGov7+UsnnkD8BK1HtQcfIxHNxhYSq3s1xKOOfEdd3U=;
        b=CPJv5e58By9ox8KUwU+eCWb5ka9LmnEqfyDiXnMnSv5mUqSldNXxYMt1VxMJX9HpWu
         rl9w3oQ5/40PpPCg9GzjtwSwDS+YNHUkAmFkJz4Dr4t5nWzzcWrS07NW5XZrmrBhnssj
         4xAwPE3x+JDSOaKURfqVROY9mCQFEe9lbAvuwWhdcMNx98Y4MZ6x+heQUgJINwagv1wj
         GyStPgW2HKSJJYhKS6kT1UV7ZHwCZB3JMxOmDhHO33hoV268/jdxC4I5SlIgPl9hT/ka
         D0qJbgNyedvgwHVBRFPjmnHRDxDm0MGwdSkwLoY1+i2Tc+JTnWDHz58S/MKgrawnQL+Z
         A1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890547; x=1769495347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGov7+UsnnkD8BK1HtQcfIxHNxhYSq3s1xKOOfEdd3U=;
        b=SHJQ5ho3NFLIxOwvRt1YdSFOrv/lyrxQcOeEWvKgCMxC+xwbmam8X64HZDFQiYWW21
         IRjwKKFCD+GUB8MGlsBTWY2nWYGo4JtGLv5j5RW5Xemb3buB4tXnmvtJJBNbtQwAlYid
         7zS0iTjzpRWkWcqRIO5nYAApPtnV+9xdH9G8oTenobB3yvuuyBm/BsJVKfamoL2WAGvX
         KI8T2YNGIrxX5nSNOaiGuBCQivDUFt4OcB4baf3QLHd9mWG8KsDWLfZDjV8qf+ArsxNh
         kZrXLA4muQXNPGAB1EFT3RHXkpYxwQ1416ijtG9MLo1KOMxyIoElIhmGc9qeAIAhRsdt
         +Wyw==
X-Forwarded-Encrypted: i=1; AJvYcCWOGtxhfzGjPLYPpZxE4BkCDlpy05SV4hcvBgUpxgnf2zbtb/ad5q6P/5EptqrXd+qTQk8FSTJoCjd1V6H2Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuO/6IBAwFvxRaON8acYoixcAFUbmtlT3rJVZgw95MV/iUhmhV
	rz4CNocG5IHXw7A+quJd/DZoh5sADzByZxUz9dQtYmHbkak8ZB6H2FR7
X-Gm-Gg: AZuq6aLQH8EyEMLvSHnYoKpI+r54qU2OXMmb74mNS5IJgcGo2VzTLOyquNH9rjsYMv/
	ajrk+tjLFMk+WWS96bdt2EZycHDJQ/u8IEKdOvmLo5sOUJSmSlEN+aCtQyY8tlIVQekqJTtY21q
	QqToyIJvkDu/KGVb+2HOJHjpv2KCmT62gC7zVeE3UTjGMaHYJhxIELzDpJZ8ik1AjRd6YY3G9fR
	rBttVvLQMk0f+ZmZn7MpoVB2h/xUd372hDH2QGj+hApWsYomDpC5J1JKJf+b/ZwRb3pSt5uFF0f
	eZUn5m3wHOHLn7uu0tVISrGQDMKi05MzeMlKNEuxxFOog1Z8ZKx+yhm+/yj46ylFBRoL47VVUSm
	QEqcIgKAAZdlE7XtPsHQPchES5bk/mm22j46mVqvnF+/G0BKWEz0Q1pDBcEb6g264N2aKpIDexE
	8L4eq4ZbUnmrS3tk9YiR0CRf3UaxLiXyPn1lzweL1xXW9sY9prI92BhSrS9suf5uK7mwZ8Klc=
X-Received: by 2002:a05:7300:6420:b0:2ac:1c5a:9950 with SMTP id 5a478bee46e88-2b6b4e98df3mr12535539eec.34.1768890546301;
        Mon, 19 Jan 2026 22:29:06 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:05 -0800 (PST)
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
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH 07/11] wifi: mt76: mt7925: add MCU command error handling
Date: Mon, 19 Jan 2026 22:28:50 -0800
Message-ID: <20260120062854.126501-8-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120062854.126501-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 80ca5181150b..5f8a28d5ff72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -637,8 +637,10 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
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
@@ -904,11 +906,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
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
@@ -1287,22 +1292,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
@@ -1311,8 +1316,9 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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


