Return-Path: <linux-wireless+bounces-31303-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IvwOk4Ye2lCBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31303-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:20:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50046AD6E2
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CB3130490CB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105A37C0E3;
	Thu, 29 Jan 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbOrnyCQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E4378D8C
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674734; cv=none; b=kYKuS3J4m77vSErof+Uo/aVZvI+BNzYSNP1PBWwI9fRAD2/fodIabsBwc4aAfMjgMMPSAENU2exsluKNmLRuhMdT7ptUD2bkPBI7IB//CAsNcGiol4ZBTY+vg6ItjzcUzoP17QgWaXAb9TehE9M2Y7oLhaw/7kofHvRUzk4ln74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674734; c=relaxed/simple;
	bh=zLCOroas8zXs/FEWrMgLQ0DEsN6MpeN96pQBLNH+XAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPr2B2c5t1lD1/Oe5gg4GY7QUxUEXyG1SLZH1+ze46oLU2OYEc4yc7694WQzmu+Cak/BKzukZazRPdH5S3ty981213Xhph0wlXrP0vpJj2xoPh3toU2c/B2wOXgvZTiZNA+IKVpDFvpKc0zkf+gnA7EpwFHPX3MoMoeX1rmYvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbOrnyCQ; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233c155a42so1054020c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 00:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769674732; x=1770279532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv2sCi1LhoxanCq/pgAsKlL6gjjvT4vp60gwfpl3NMU=;
        b=XbOrnyCQ1qaMsObaBNZE92bk0HdIORm4ZnIxtSUrQKZy83NntCu6NAkA83bV1UXOqW
         Dep2BUGPKAJKSLVmMZ6713nycnCKUrJf9RZe8wBhAzZNfqc641+xqhD23N9x/mg+YpVy
         igVqRCF3oL6rBg2iGOVqn6F4m86jDyAQGiJo1cbeJx+aUU0l3SAMcQPDo4vXyuTBO738
         74m0/y3v1eFpUSk5HDv2FyBjIEK81rhqov2l7leA2SE26mw+k8Uexc4Owu0bOtnmlZKt
         oLduvCS8rGPl93mlPwxeoeEZVrxGoNK9EDBsO6Rx4H6PeCKh6KRtceeZ434oSwLuYmMc
         uWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674732; x=1770279532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sv2sCi1LhoxanCq/pgAsKlL6gjjvT4vp60gwfpl3NMU=;
        b=aIzb17WFh2UpJ2obXO0W2j3mEMIv2Ixcx/1CPyy/LJoaXFjBmOXV2vaUwRYh4nvfXN
         bicI2bF3ravQ7U2CDAs2WnUdyW+3s1OVg78RNgjBhp4cO6u1AfSXwSrwgMnPa6CdhBff
         z3s34xMk9Tf/n8lQNBjUmrVnoT+Uq0vp8+9kS7GRGakrQoN3o9ouY3oD5Nw71z4SaHdF
         dFBVMQdsGKZtIHD8rAQGysAMpjkLSZwr+OoW3TiuIo2DcmXneJAmm7hUyBmtd4nsd1y8
         20t9WQQTaeDDrzmydQWcnPZ+/SYnWjK4/PnkB8342urQ9iclDl+DgiPEmD19PCP1k7br
         snNg==
X-Forwarded-Encrypted: i=1; AJvYcCWka5krfR2N6z4ZCMgcBVGmWEEPrxv07/lA2xK4ZASRLMI2S+FGclhWykz1zCH769OKSqiLCgDWt4f4uWRhvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc26YoyC5EWNdpnfk7lcmP+Z+KUyIqy6bQ9+XUP+Cx+yG0fNjw
	2N2KKCueAAjnSO+kOr07ZiC8zm40zeCWD/t8W2N0ubiEniBb6HkukJ0b
X-Gm-Gg: AZuq6aLqinkNYdA8JA5xjoliRAGMQFp8TAMGhdIqGQgx+72w/x7C7jR2fUtqTibIQ8V
	ydUc2rUzyE3FTqhTbRIUI4d1STFF416VPqWw5ZM05W9jjAbVMsdEDlP2a/dT+pEPakcusAh0l//
	/Hkuw5do+kH06lAo8HwBiuOD8wZsHteTVeN/R1Zy0r7m/8zE+LWMNYLZ9U7LRaJaqjttzmqVhMA
	+oKfJGgwHPbMwi5cFligYVOzGijFansN/YUCZNnl1+q3flWZMwg6Ax73NqKt8zwIHKkWCxD/5cT
	0mubG0Xp8NcLpPo7bydnPQhjQzXzUC+1ypc5UTA0nC7zcPMDDFAVZ4AjfXwaeIlD5sgcdLfTlqM
	uByT42xef0g74VYdBU6gj7OUm5fjVF38jy5zRkwsa87S18Xzwe1jnCCf6+fAoVAB1aqC4vDSPV8
	5BSyaQT3CUiEgUlLfbdwOwbJH63OcyNwWTKTyxS+X6JpqghmJ1TGuIiFvxaKswX2gVV/AJql0=
X-Received: by 2002:a05:7022:6a0:b0:11b:9386:826c with SMTP id a92af1059eb24-124a00d64dbmr5188230c88.41.1769674731965;
        Thu, 29 Jan 2026 00:18:51 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm5483508c88.16.2026.01.29.00.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:18:51 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: nbd@nbd.name
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH v7 4/6] wifi: mt76: mt7925: add MCU command error handling in ampdu_action
Date: Thu, 29 Jan 2026 00:18:37 -0800
Message-ID: <20260129081839.179709-5-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129081839.179709-1-zac@zacbowling.com>
References: <c9b81e89-cd29-44f2-b4e8-0179b2049c21@nbd.name>
 <20260129081839.179709-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31303-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,zacbowling.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zacbowling.com:mid,zacbowling.com:email]
X-Rspamd-Queue-Id: 50046AD6E2
X-Rspamd-Action: no action

Add proper error handling for MCU command return values that were
previously being ignored. Without proper error handling, failures in
MCU communication can leave the driver in an inconsistent state.

Changes:
- Check mt7925_mcu_uni_tx_ba() return value
- Check mt7925_mcu_uni_rx_ba() return value
- Return error to mac80211 on failure

Special case for IEEE80211_AMPDU_TX_STOP_CONT:
The ieee80211_stop_tx_ba_cb_irqsafe() callback is kept unconditional
because during beacon loss, the MCU command may fail but mac80211
MUST be notified to complete the BA session teardown. Otherwise the
state machine gets stuck and triggers WARN in
__ieee80211_stop_tx_ba_session(). This matches the behavior of mt7921
and mt7996 drivers.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 82de6f30ec27..8236edb1fb48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1300,22 +1300,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
@@ -1324,6 +1324,11 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
+		/* MCU command may fail during beacon loss, but callback must
+		 * always be called to complete the BA session teardown in
+		 * mac80211. Otherwise the state machine gets stuck and triggers
+		 * WARN in __ieee80211_stop_tx_ba_session().
+		 */
 		mt7925_mcu_uni_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
-- 
2.52.0


