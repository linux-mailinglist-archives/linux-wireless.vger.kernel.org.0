Return-Path: <linux-wireless+bounces-30872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A62D29822
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD60C30256B9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA203242D6;
	Fri, 16 Jan 2026 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzacuJVg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC363176E1
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525551; cv=none; b=MlFYW0DY0DGnX9rtw3pt9hFHHY33CYOFW7sUUHbdJclsUi6AAULESz4gCdYVxcjD1V8R3/XOxIW7Om0LleiSfX7xAwFziQxoLvwAcynLuyWSBZSVT13lU1JDgqhFUBUHyaSvYf16zGRHw2Rf3RAOljIjWobDzDyiXk//pS1772M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525551; c=relaxed/simple;
	bh=93CxdtjSiYHRsD65xDT9SzpnY1y8alstttWaEJIdBpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI8xeIFcdV2fqFdJ5U4dYxjrE5KhkY4P5q5NzyXrqxtVKsRcFcFAnerTCwrjTtInwwj4nZBLevzwuASIv+vvCqj2NqmAsE7XF3qVhNwogS/Qk2GSsUqLpB8D7QzuBz97D5EtFVKmCiFTpBJuO6jdMpAk6xykaHfQ1sQfHrk+30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzacuJVg; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso1765171eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525544; x=1769130344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMsIT9b64DfDkZ2RydlT2hQ2iAnc8d0gWqzQNuaiPqA=;
        b=YzacuJVgs7UAXDh6gczbID/66j0H1npLMyz7q5Qn3lq+IFoDJ74gTH7fT6p/vWjuhp
         OMaLqijOKUvxEv4LbOHrVvCMTr49Vsc4bwaZL9qcyhQgFD1PYTiNVQ5tyPfvWYCxdkaE
         ZvV656ETPlJozqEATaKwaXpsXNZkuUyl3eQ04DGueXa6WCIDI/e9CQWlp/Qp5TSZVqBk
         xygHgZYgy0ryyM+cm559U2aN4krF5DUYru/umPZW/6WXPw1kPCMROkLBRicD+vAW59YB
         JipYeHCslun5qyBQn65ZnzjenhQzCUCcrDwS4ATcyB9hoBImgwgrHOS4oIJdarEY31Ah
         cdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525544; x=1769130344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMsIT9b64DfDkZ2RydlT2hQ2iAnc8d0gWqzQNuaiPqA=;
        b=eWLLmd4VrE7PC0kTgtDiaTqBD4z3HaSa1EuGNfiWdZbQaE6QVlWxAhCKJ/dsGd0trm
         rJzzp3Z709gGXFcI7KeR2WZv4t75BJr4O09H1BJDBlRO+c0gZJ+bZaYWRsrfyufux09w
         BvF3XZxLrD/7FOA8W6DJr0Gefg1fCeHWT1runjx5Lo0OtDVGiAyxR3q6/WbnKjNwHCrR
         fnqJtNmdUcnJg46zy4+rLchQ2vHp8trlf8qHaejZOTClup70GK1Zww5NgFT0vfGUfaIf
         OWSVgB0yCeCABbOpUhPYo5KBVfbgjcq25E8qgkuhyLCYeGvYZtHS3t4lriUdhffc2KSZ
         WE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9xXzVYPFFJFe4FdEfl2CUt8zTRw7tYp33UVrLgNqMPQokI5ftYd1WB1XUiGdMDzpFIDHS3XGL2S/ANYFFQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaLmw8g2bTiI3fNtYbzPKfPo9h6oj5/4Em51FIw6UL6W3XQlJj
	WjxLvHiqBj+V2DoCb5cJ0ueXPUt3qjkbFfxPuKG3fCSKrq9xlWIDzepS
X-Gm-Gg: AY/fxX6VNRZ2cXrIIz4jJrKKyfVdy7AlvtV8cp9cLwm5ta8d59Ea48OJR4kldJEtIsO
	Wgg+ShNSeMoLbxD4RXnm0Is+TUO1xAhd8wfjdFcRojRdoQJ23iMJR830uNKCZK4CLSlcUfa8t6P
	ad2bpRr92CUYmePQygQB7lyz2MuS1K/H9Uf6o+fxtEn2w60LxzBl8eH7YDIX0L2zMhrwIjqYQCT
	Y9dtv3XofFlY8HpHJAl1rRdhUsAvAsPy79JRhU+gYmhHtGpx0DJUwlVYnIbnavv8q58+o8VtSIU
	W4vMzvTbAqa2V6y+9GPnNHfUEx7m5KnczEpHDFbpiysCU7TN1i8omZpl0dxnlLKAP5DSZsM3YF/
	V8C+/D0hg5CNwz2tAUnOFy7S2H9LERHBrKCzwFTFh88tW4tdSRDRKm0H8kfFPBPRGefPLQ+u9uu
	bwlSfGOFuaGvoC1tUYXxPth/hWgS6BXQluf/KAQ8/DmLAcTU2Xr4C+tF1+xBTXxQ==
X-Received: by 2002:a05:7300:6c27:b0:2b0:507d:c2e4 with SMTP id 5a478bee46e88-2b6b4eb3688mr1326559eec.39.1768525544113;
        Thu, 15 Jan 2026 17:05:44 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:43 -0800 (PST)
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
Subject: [PATCH v4 14/21] wifi: mt76: mt7925: add NULL checks for MLO link pointers in MCU functions
Date: Thu, 15 Jan 2026 17:05:12 -0800
Message-ID: <20260116010519.37001-15-zac@zacbowling.com>
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

Several MCU functions dereference pointers returned by mt792x_sta_to_link()
and mt792x_vif_to_link() without checking for NULL. During MLO state
transitions, these functions can return NULL when link state is being
set up or torn down, causing kernel NULL pointer dereferences.

Add NULL checks in the following functions:

- mt7925_mcu_sta_hdr_trans_tlv(): Check mlink before dereferencing wcid
- mt7925_mcu_wtbl_update_hdr_trans(): Check mlink and mconf before use
- mt7925_mcu_sta_amsdu_tlv(): Check mlink before setting amsdu flag
- mt7925_mcu_sta_mld_tlv(): Check mconf and mlink in link iteration loop
- mt7925_mcu_sta_update(): Initialize mlink to NULL and check both
  link_sta and mlink in the ternary condition

These race conditions can occur during:
- MLO link setup/teardown
- Station add/remove operations
- Firmware command generation during state transitions

Found through static analysis (clang-tidy) and pattern matching similar
to fixes in mt7996 and ath12k drivers for MLO link state handling.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8080fea30d..6f7fc1b9a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1087,6 +1087,8 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 		struct mt792x_link_sta *mlink;
 
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+		if (!mlink)
+			return;
 		wcid = &mlink->wcid;
 	} else {
 		wcid = &mvif->sta.deflink.wcid;
@@ -1120,6 +1122,9 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 	mconf = mt792x_vif_to_link(mvif, link_id);
 
+	if (!mlink || !mconf)
+		return -EINVAL;
+
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mconf->mt76,
 					      &mlink->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
@@ -1751,6 +1756,8 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 	amsdu->amsdu_en = true;
 
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 	mlink->wcid.amsdu = true;
 
 	switch (link_sta->agg.max_amsdu_len) {
@@ -1953,6 +1960,9 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 
 		mconf = mt792x_vif_to_link(mvif, i);
 		mlink = mt792x_sta_to_link(msta, i);
+		if (!mconf || !mlink)
+			continue;
+
 		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
 		mld->link[cnt++].bss_idx = mconf->mt76.idx;
 
@@ -2045,7 +2055,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		.rcpi = to_rcpi(rssi),
 	};
 	struct mt792x_sta *msta;
-	struct mt792x_link_sta *mlink;
+	struct mt792x_link_sta *mlink = NULL;
 
 	lockdep_assert_held(&dev->mt76.mutex);
 
@@ -2053,7 +2063,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
-	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.wcid = (link_sta && mlink) ? &mlink->wcid : &mvif->sta.deflink.wcid;
 	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
-- 
2.52.0


