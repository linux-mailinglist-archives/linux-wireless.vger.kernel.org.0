Return-Path: <linux-wireless+bounces-31416-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N9fO3d8fWltSQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31416-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 04:52:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7F8C0969
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 04:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE56A3011855
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 03:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8362DEA9E;
	Sat, 31 Jan 2026 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="g/JnKIQQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3B4A01
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769831536; cv=none; b=k7TVkqbL7nRVnysrW6N/rc/HNE303HhSt4PaHZh3/1agForZGgLi3c9ehOU3F+I/tI4vx9LgvRH2si9B7gbBj5qdmF/asNi73M+Wn4G0cj1a8tIZ37MnL/GoKVyRfDgAmNfGlYMR1yJtLYJtziZMD303kVDDm9KZ0kXjOqjogOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769831536; c=relaxed/simple;
	bh=GuQRayMdtq0K4ZAP4rpnMcjmlMbRz1yFN4dBUoBskrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S37Efua5YmCSUCMFSc2LGppCE8aelc8e/7PiiuSsSSoDO+Zysv+WgAwdQiwz51tOVwxo0PWykvWQ5lzT/DY2NhUZg4aVqeTn+bmgfnwndDaFT+hvoORFUdeJ2RqKgu/tnp5bWEcAoK29bIC7CYBa/6Y0ycIbdO6JtBaLD1D2E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=g/JnKIQQ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d18d02af68so1772289a34.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 19:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769831533; x=1770436333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+tuxKzfIwGph4KGmy/W4D3saam1yAaOrHAbmg45lyE=;
        b=g/JnKIQQOukUFU79+0k2rBNNRCaoHdkURyi3lS5n0WDnawOpb8NYiY66Dp4J/m4fqN
         3Hm3I1tmFgsbyOA65hLTqeM4CFb41rTyJ3ZaqfnBGgkwtFrTQqAYP2QP38o0Y8sHStw3
         cpjGTNb0ErT6yuZXWgT91HVZdh41KYz4+enKEQIuE/GNdnNuF5qEYpHBCC1DaFAnuERG
         fUQnJkv5cs+7D9HWiUXHg5UZOcm9JJo5RsSJcKcOBCjHCkpQ69dT8/t+Pi2ewkARnR+z
         /hftBtNnUs2z/0djVxjz26j3SJXTtmw8GWvAhUxzINDVocSio+5/Us5S7rODaJr4XIZB
         eKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769831533; x=1770436333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+tuxKzfIwGph4KGmy/W4D3saam1yAaOrHAbmg45lyE=;
        b=iCWBWsLI/cizBOoGR6n58wzJZWBOryuWLcdghbILeuXCs3aecEeFLXg2GVPGGXsN/S
         Ig/j6IRf9hV3hCHh6yrbJ632kgqxrJCkxTPmqfusak9nh13nHF7L1AFYU68GAqZkksR+
         CAPP0lFqA2kuaPBmloRues+2xH/GZY63jA6AeQ9c5XdSnzr5SwREfKGvinxTZ0hMEOhG
         GEuWj8CZtiJ8zFzXNZTixv9rLhXEgc3EalQlkwgLvckblpaDixYVyOkfHeC3cwIU67mm
         zT9LMJSF8w51AYZw8v4Hc+poadbLR7Dy5xaqtLhDjhEh3kobeYcKCwBfm8umJPSH5ApW
         g0EA==
X-Forwarded-Encrypted: i=1; AJvYcCVOGwId/GHIj5/vP0h5YmMuV8gqt7omwk7Itj4KvHRrTKRGpw3rkwWOZAatUO0a5mbnGoPqtTjrB12WrErs4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21aCC6ZP0UNHw7AP21/mF3qEf6iCtqxTUcNbKcoWxT/rIdSkC
	fvZ67q+zI37gyc5MK/8VV0vZNr7338YGm1QvQ42J7uvIaO8CXehycNZ4IbXxtrU1XQM=
X-Gm-Gg: AZuq6aIiKv9v2boCMZhm8yW6JKK8BISHzgTywnPjo9xO2KzpM9GyqO3oEy2kfJHa+nn
	yrPMK22gNBEbuTSHK+ASvYkD708Yz81YtU4uTMi72BUrp63eMEZcJC83+Y++LbAqhjt9lFROPcG
	FyBRC30kskZTXDfkVYBJknptgNIekK2fsAjpCe7YceUNOJSf2D1DikVbwsUCbc68U5Nwzj+zQDc
	l7xiFaEHkGIO4qHvajljGW2HRPngJ+KCrkh0jRQtUq083QTx4asHlJYBnOJsXD/jhp+PLj7kV57
	iyMsHDj3M23kK771DGGp11Az/41453ByFRSFRR8PddpYZyGo8AT0lC2z55cqN3h5SVovYgX7M54
	ensvLW/x3fp62xRPSvf2/15oiu8b9wc2xmlMKQgy/3etXt7ZP17fLPjkf17Ct3Ni84ZvzJLY2m4
	RPev8A0WcGLNsbjyr679lA971bTs58sPlyX1nqf5c9gbn3nhjmYl2wdR/+nNGHB7mud3D3qiuU5
	ssyVAppiuy2gr45E/Sl7I7FB7dKXtg=
X-Received: by 2002:a05:6830:6738:b0:7cf:d96d:7882 with SMTP id 46e09a7af769-7d1a5250f74mr3189657a34.3.1769831533374;
        Fri, 30 Jan 2026 19:52:13 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c69ac16sm6727975a34.7.2026.01.30.19.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 19:52:12 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH v2] wifi: mt76: add missing lock protection in mt76_sta_state for sta_event callback
Date: Sat, 31 Jan 2026 03:52:10 +0000
Message-Id: <20260131035210.2198259-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31416-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,u.northwestern.edu];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[u-northwestern-edu.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,northwestern.edu:email,u.northwestern.edu:mid]
X-Rspamd-Queue-Id: 4E7F8C0969
X-Rspamd-Action: no action

mt76_sta_state() calls the sta_event callback without holding dev->mutex.
However, mt7915_mac_sta_event() (MT7915 implementation of this callback)
calls mt7915_mac_twt_teardown_flow() which has
lockdep_assert_held(&dev->mt76.mutex) indicating that callers must
hold this lock.

The locking pattern in mt76_sta_state() is inconsistent:
- mt76_sta_add() acquires dev->mutex before calling dev->drv->sta_add
- mt76_sta_remove() acquires dev->mutex before calling __mt76_sta_remove
- But sta_event callback is called without acquiring the lock

Add mutex_lock()/mutex_unlock() around the mt7915_mac_twt_teardown_flow
invocation to fix the missing lock protection and maintain consistency
with the existing locking pattern.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
v2:
 - Move the locking to MT7915 driver to avoid deadlock in other drivers

 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 90d5e79fbf74..e212e964fda0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -851,8 +851,10 @@ int mt7915_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		return mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_PORT_SECURE, false);
 
 	case MT76_STA_EVENT_DISASSOC:
+		mutex_lock(&dev->mt76.mutex);
 		for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
 			mt7915_mac_twt_teardown_flow(dev, msta, i);
+		mutex_unlock(&dev->mt76.mutex);
 
 		mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, false);
 		msta->wcid.sta_disabled = 1;
-- 
2.34.1


