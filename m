Return-Path: <linux-wireless+bounces-31028-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJzZNpHrb2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31028-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:54:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D4C4BCDE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08DB738DC23
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D603A9613;
	Tue, 20 Jan 2026 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGIdEgcj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB73A7DEB
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939859; cv=none; b=MCoNhvOAHz+fwdhokJQIuGXvQibv7QPIdzPnOYC2PzMGXv+z11Jyg6krbcsB/I8v2SapSAj3iwKEZrmdKw4Zl3cxXoKScS5D7sHkxlLNM0HRozCvhl6XkM+KSOT58RKW/XG/vuRBFl2qhDxx0bFMuCcACzsAUxD775rsgl+ciBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939859; c=relaxed/simple;
	bh=U3Nyq3NqiqDHDQqkseFznMKgRIxsJy24U5IKOEvZynU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8cckuHkH3Ez20sTxigWb36D4SrFmUmn413HkiHi9NGPan6gfEX2H2zN0nUUNfQz0D9/iYm/i94pSD8T+zyt/TnDfb3OeSyJdoewgay8PFw7XySoZTEL9KcjfKQMENvvxD+GVZqiMmlcfg2ZVVGX/A2W25XxPobP2uIO1JiGcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGIdEgcj; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-121a0bcd376so2066636c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939855; x=1769544655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR+w7fOhhpyJjkq0X/V8TVo4iOOXXnMSK4qWX/dQNIE=;
        b=TGIdEgcjYWHiic5nbcfIBEEh4OMpNTKAujKInhS7zYWu9qF0hWdvbwdGqO+M4NXM3Y
         P+gJ+PzBycnhVe64Ub3oS8bwGH9HLVgWii8e0hpm3uhZsb8VZvpnNWjpnPR1Eh+gFFzm
         c/WvBjICd+zZLdIcnENRnPJ7+1dLaYcV2UhAFRt2EwL5Nzz3Jerx/Bo8SL5XGch4U+AD
         vHBLIwbXC+ML3yhi3jwo/74Czvivy99tdLX1CYx5GE7D7Vi8zLSi0rzpbMOliywbzeMQ
         fG6PJW03L4hOnbCUd+/pw4yfyFRcTX8QIns1ekfp3DlrRhv7Ha1Yleg2zT8CrbFDHHrx
         joMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939855; x=1769544655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QR+w7fOhhpyJjkq0X/V8TVo4iOOXXnMSK4qWX/dQNIE=;
        b=XTo5l0w0XNMh/0zPoiLYy/wXF8AFkKAkOutH5ZvAS3cwNyHEZLi2g1ys5bAEq/Nu8U
         c+XO3Aa46Cz9yECkHkFfsrNjWYoNFcEaA3NGhMjUOKaTXtJowUIzJdRWAB5JmaoeIa9D
         6qGV6ZBKqjO4Z6ys57TguL/w/XqDi3Q1QyXY5GCMfPklA5jZu21jB9NaI4pvkuJra67r
         z0JB3Bj6yU+8v8eCpgdWN4fMuHFoLHetMtxRU8rQhFBJYylBnXZr6QtHsewy2pp5hCju
         n/7xNfR1Th9Sj+f+Re66BwgAtXmNTn+9BKx0VD21mGFrWKNDfHdguh4BSpP5+JZcY72t
         pShw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4PGkATJGLMsGSCcSSIQkgVjmSrNrsqu0sV3/mPLytpxsFtLubDv4DUn3lPrXgNFeDatsPrNNIVyj7L3pSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGjf9mfvxOiTQcDRd0lSebOqpdBvRSDu9aevsOMGC4mc9uzBg
	W24W5IAJ/0s1yHxT+v4WZC7PglyAgn8u9lJ1757uVTZi16hJVXuviTRhIWf/2u1K
X-Gm-Gg: AY/fxX52nLLwdnzdIgY0tzv364pmDEWlgLnjruyLcNEAH5IU7tcIWiDsIfsMbNy+7CC
	rb+/Z3IZN5j5XqypXFa6aCiFLBp3vzWPFNtNxo3vABYiBOfc0FKnoTdtP6VS4HhkBnQm/0QHGT7
	4xAiTFj7ru6N980NdJcXsw0WzJ0kbm1Peh5roF2OAEVX8elS+D7IaRbdRsiDVBlIOWeZllBQBYr
	5VKd7qyRvldYwbltf2a98nVo8F/WeJvXrfWqMqa51/D9+yGDKpEoibIPrKYuo/XkKhF0GwVeH8y
	4huVylIB+DpU3tzXnnIFHGiu+3o1ZCnyir76sFXY/oCINYIMjwd6959AfMWf9XpxTMIoGcDs9+q
	gcFz51rwQMB0FmziCNoV5fXrjvmL26p454rYv9G5A6OVCIkhDb5oyAIUKc57Lj6Ia4wvUQ/4wZi
	ZnUITjhoBCsVRVpwmUxQop4NaiRi27hvqJiAyl5cwYS9wLjld27JQCrpMlPRxlsKvxmrGz7dCX
X-Received: by 2002:a05:7022:458c:b0:11b:88a7:e1ac with SMTP id a92af1059eb24-1246aa8951emr2200437c88.19.1768939854707;
        Tue, 20 Jan 2026 12:10:54 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:10:53 -0800 (PST)
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
Subject: [PATCH 03/13] wifi: mt76: mt792x: fix NULL pointer and firmware reload issues
Date: Tue, 20 Jan 2026 12:10:33 -0800
Message-ID: <20260120201043.38225-4-zac@zacbowling.com>
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
	TAGGED_FROM(0.00)[bounces-31028-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:email,zacbowling.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 89D4C4BCDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

This patch combines two fixes for the shared mt792x code used by both
MT7921 and MT7925 drivers:

1. Fix NULL pointer dereference in TX path:

Add NULL pointer checks in mt792x_tx() to prevent kernel crashes when
transmitting packets during MLO link removal.

The function calls mt792x_sta_to_link() which can return NULL if the
link is being removed, but the return value was dereferenced without
checking. Similarly, the RCU-protected link_conf and link_sta pointers
were used without NULL validation.

This race can occur when:
- A packet is queued for transmission
- Concurrently, the link is being removed (mt7925_mac_link_sta_remove)
- mt792x_sta_to_link() returns NULL for the removed link
- Kernel crashes on wcid = &mlink->wcid dereference

Fix by checking mlink, conf, and link_sta before use, freeing the SKB
and returning early if any pointer is NULL.

2. Fix firmware reload failure after previous load crash:

If the firmware loading process crashes or is interrupted after
acquiring the patch semaphore but before releasing it, subsequent
firmware load attempts will fail with 'Failed to get patch semaphore'.

Apply the same fix from MT7915 (commit 79dd14f): release the patch
semaphore before starting firmware load and restart MCU firmware to
ensure clean state.

Fixes: c74df1c067f2 ("wifi: mt76: mt792x: introduce mt792x-lib module")
Fixes: 583204ae70f9 ("wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module")
Link: https://github.com/openwrt/mt76/commit/79dd14f2e8161b656341b6653261779199aedbe4
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f2ed16feb6c1..05598202b488 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -95,6 +95,8 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 				       IEEE80211_TX_CTRL_MLO_LINK);
 		sta = (struct mt792x_sta *)control->sta->drv_priv;
 		mlink = mt792x_sta_to_link(sta, link_id);
+		if (!mlink)
+			goto free_skb;
 		wcid = &mlink->wcid;
 	}
 
@@ -113,9 +115,12 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		link_id = wcid->link_id;
 		rcu_read_lock();
 		conf = rcu_dereference(vif->link_conf[link_id]);
-		memcpy(hdr->addr2, conf->addr, ETH_ALEN);
-
 		link_sta = rcu_dereference(control->sta->link[link_id]);
+		if (!conf || !link_sta) {
+			rcu_read_unlock();
+			goto free_skb;
+		}
+		memcpy(hdr->addr2, conf->addr, ETH_ALEN);
 		memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
 
 		if (vif->type == NL80211_IFTYPE_STATION)
@@ -136,6 +141,10 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	}
 
 	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
+	return;
+
+free_skb:
+	ieee80211_free_txskb(hw, skb);
 }
 EXPORT_SYMBOL_GPL(mt792x_tx);
 
@@ -927,6 +936,20 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
 {
 	int ret;
 
+	/* Release semaphore if taken by previous failed load attempt.
+	 * This prevents "Failed to get patch semaphore" errors when
+	 * recovering from firmware crashes or suspend/resume failures.
+	 */
+	ret = mt76_connac_mcu_patch_sem_ctrl(&dev->mt76, false);
+	if (ret < 0)
+		dev_dbg(dev->mt76.dev, "Semaphore release returned %d (may be expected)\n", ret);
+
+	/* Always restart MCU to ensure clean state before loading firmware */
+	mt76_connac_mcu_restart(&dev->mt76);
+
+	/* Wait for MCU to be ready after restart */
+	msleep(100);
+
 	ret = mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev));
 	if (ret)
 		return ret;
-- 
2.52.0


