Return-Path: <linux-wireless+bounces-30864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1ACD29837
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2639630EDC13
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3B314D37;
	Fri, 16 Jan 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQq7DeYZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA3314D08
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525540; cv=none; b=BLJOFjN6CRMkLDe/OJvj5ktsmsQ8jeJht4cV3ZhBbRsJ/WVnbzrQxVM4Z0vKuHh24nBJe4BESuASaSQYhEnGbgfPBAsYFGvTlYfc5iQnIJWqsFXfYK/vNfIzzAAdRaD93hZAB10PMI6njtxP+qIWYjZe1nWthz5tHlxCsRpaH5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525540; c=relaxed/simple;
	bh=sxn8m2wfjaMr0Go0RxIOhMpMUABI6p8vpxtI2DFz5oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p62JZ09jyFQaIuyV+EMchlAfFw3WtsQwtg/sow3PjL2wEha8iZudTnXt7tzpvERDyCpn4kZcEiIiXlfeZ3VEdac7OZ1tJJ3qCCBd2R10Ao69xNy8alG8iHTKmb8H5lEWIbAK3D8w03gXB13zSYYfFD1bZG8AOnO0U2bRweDlq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQq7DeYZ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso1838489eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525534; x=1769130334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmo1wCmkMZsP9rEEVr9OwRQ+MJCKwHnawZH5r7i9q+E=;
        b=HQq7DeYZf8cJXVfj8I4nAb5/iATtVop0q+PjL1/Cvu8QC7S3DVa+pVXiAVczoGHN/H
         XAC8PnxtYVWAl4fHtGTdC5S3rHvNkGMdI+a/dpYMLXPVxKnK1aIyqBBVqMQQV4zdxLhD
         1Iv8TPPDnphWMzq+dSXh5SBzaAD5jM7Pwf3burrNFqTRVlKNhGOzJoUSTnv2SPVdf3sN
         z7FpzUczp2HJ11LG+5lmPx5eo6SLwvA7uxQ+MIEN9KWPzd0ZcPYmHhfpJ/laugk/iDol
         6mPQRJROtGrYrS2sFq6Udwh5ziT+tdyzJ7Wy/5DPHuA3wxWGYYzK8kJzTr3u/WL3ygy2
         uxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525534; x=1769130334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmo1wCmkMZsP9rEEVr9OwRQ+MJCKwHnawZH5r7i9q+E=;
        b=T/w6BUTo7OGpYrs8qznonrJEECJiOoMiPaoMNs0nqs1esonobJx1drVe0YHM4fmS5V
         tANLLJZxo5BI6pZx7ioSrn8NyToSSiC4MIKiDhqZ0DgBqZIqoa3RMca0ccuvHondRQVw
         G3cbZM8wZ8VQlvdiylbmhc6CBzGFJhome26+ct3aQnDNPQSYbU10I9kOTiVaNFAx6ReI
         ND3pcGI1x/8wzCkMNIdRBqQTesX4P0K+CA++n0/reyDPAC8CvaMhe/UGcHoyW8rukUZA
         kdM6mb9E6Cj2Gmj0Ku+3avwN5F5c2JQiSzAZKnIHBx8HpGGxTaW8H1FOC/klZmWB3xqr
         okBA==
X-Forwarded-Encrypted: i=1; AJvYcCVYmzFPWBT/1BEz+DV80KzjYZX/AB7xCtgcH/7wXHPHqYZvpLf+wTOVR2iclTgGeosTtLgPKqxOcN+DsEM6zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2jM1FP20U/maYjnzs+KkgZsCnQj3lv6Le1Ba3viC5lTHtwsVw
	hlcaNi5FrEuAOAMFxvmv7Kp0mlJUScl4yv/Mb68EtCdqFUc/g/L+/RXe
X-Gm-Gg: AY/fxX4LsjtBWWjBAFMZBtYqnPS4spacmoTt6CL+Tq4nmqxp6hKmrksGiZ0uyUEC/S6
	ttXrs+uDaVJ0siSVwUpxnVivOvvHCktGQuM9hgxd+7i+rIcaelOIgvOg9/ceHDBTsw2vzBzcIZH
	/PTyjQS/JdtgfL0o0B9Q+RNOdKVMuhePxtcZAv1JwnakeuKQrzdUhx+uUhn+U69AJDCQrlYU+GZ
	nqZxCUp8mHtYO9n4gRQ00B6LG48GTE2VJqWapSNxPN/cRLrLCAMSiftavlDxxOTw5hoCmzpJnxG
	JnVd2BleRt2bVoE1zCA8f+kbNC6EPQD6V9eukXD2gxTzBEs4/b28gyaYahMPP8pBt+1QqwyUd0k
	xhHH1IOfR0pHWa6QOZfQy6W8F7XcZUtMo/tU6gP2iTq7Reibsn+5KEg/Hly7krBwuPyVMu/3r+C
	dT6LrT47T1FnALHWQL3p6ik5ybXvvsP+0bqd/i4vXNZHdwnGJn1xtx2CCnYl8diw==
X-Received: by 2002:a05:7300:2d06:b0:2a4:61d1:f433 with SMTP id 5a478bee46e88-2b6b3f2a8ccmr1281770eec.16.1768525533543;
        Thu, 15 Jan 2026 17:05:33 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:33 -0800 (PST)
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
Subject: [PATCH v4 07/21] wifi: mt76: mt7925: add error handling for BSS info MCU command in sta_add
Date: Thu, 15 Jan 2026 17:05:05 -0800
Message-ID: <20260116010519.37001-8-zac@zacbowling.com>
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

Check return value of mt7925_mcu_add_bss_info() in mt7925_mac_link_sta_add()
and propagate errors to the caller.

BSS info must be set up before adding a station record. If this MCU
command fails, continuing with station add would leave the firmware in
an inconsistent state with a station but no BSS configuration.

This can cause undefined behavior in the firmware, particularly during
MLO link setup where multiple BSS configurations are being programmed.

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d966e5ab50..a7e1e673c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -899,11 +899,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
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
-- 
2.52.0


