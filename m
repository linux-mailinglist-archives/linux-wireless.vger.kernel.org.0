Return-Path: <linux-wireless+bounces-10031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6816D9291DC
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997B41C210B2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE6A41A94;
	Sat,  6 Jul 2024 08:28:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C495535BF
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254524; cv=none; b=K0AaNjQGRbvTdfGTASXMs5E9VcBaHUGg8talP8Fih7U5Fba5ZfWkSeXP2uakXnhAjuPxUfJ5IWncq86BN2zMR9SjX6U6X22DNXR4GIQs9HqulOiLzH44SdcSrNdiVr/0SmWft76oWpxf6Ce2YFfYY+StcJSjfMPZFpfleLbShP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254524; c=relaxed/simple;
	bh=m6FB2O+fAyJ/Bum3dlfF9NbtJfrS1JU5/iQRJsHV2Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Azfy0TU/+EeYCkuqjoEBhcWb0C8AeH6UEczQQDIblGIu9bp/HUjxkV7RCy3hKGFz8Btl11PmoFvy18d4Y8Ki700sV7rxAy6AQA9oct8OJqQCLWFJYgDl3NZDelL3BDxhCqIDEbxl55+BJI0FPm0Q136ivO/npcbQCVWbAt2EKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25dff23459cso167395fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254522; x=1720859322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHXCbEjzxJHt6d9yCUkSCCwiOq2AKkZ8WtSCeFmtnbg=;
        b=Pzo2Yyk7QqZ9xfKab72HNALDK3MOhFAEWDUBCK4Q73JdQtgr3dICB0tTe6mQjZXYog
         uMPj9brGqGRQy5W649NutE8aqGCU3Nvs4SxPVIZ0crQ8ji1LVOgkMOrw99sPxXazYOuS
         qir8uNXfVd8Igx93xJNkajknW7X9oDDCCeZZKV9mRxrZQh4y1+P5OgjPNmky/18e4B6R
         wfE6neeSGA0nUDwL+gRvK1sCZyQ0XVbBzYwXgub+gi6y4Uk0KvO70FgdM5ke7dgBoFKd
         d4H6Gu8E0SXLLfJpRnmaoAYku+fODIReJit3PYwz8jZGJex2yMjo2wYhiy68qbNxn7QM
         xt9A==
X-Forwarded-Encrypted: i=1; AJvYcCX+SKg+R9P/G7iS2oks4Ei6cDsTECRyXrej5jKENlW/jOCeD7cu+QLUEFh6fO0NjF1zehgJL+R+naLbNKD5B6/82bR5QdpvJr+lGz1J1Mo=
X-Gm-Message-State: AOJu0Yw2O/9E+2sWPJdP1/5cqWdjhywNXG5OFXz9F/0R2JpDw1ox13GW
	ULEANaKit3HUWpmj/FB1MySI6DuBJi+WI8kb5X5lnwETrbF03q3l
X-Google-Smtp-Source: AGHT+IG62pAdB+ysm+HXJY9D5Yk5oLHWN7dIsI7MbULc7deb19Ww0URCw72J1juBmJHNDg5OQtX0Lw==
X-Received: by 2002:a05:6871:24d9:b0:258:4ae8:4aec with SMTP id 586e51a60fabf-25e2bf90e00mr6558049fac.3.1720254522586;
        Sat, 06 Jul 2024 01:28:42 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:41 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 12/37] wifi: mt76: mt7925: add link handling in mt7925_set_key
Date: Sat,  6 Jul 2024 01:27:52 -0700
Message-Id: <164608d96ce10a40e673bc6f252189c94bc48da7.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

add link handling in mt7925_set_key to support MLO-enabled
firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 79b43101237c..a2cf05fdfc3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -610,6 +610,9 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_key_conf *key)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
+				  &mvif->sta;
 	int err;
 
 	/* The hardware does not support per-STA RX GTK, fallback
@@ -624,7 +627,20 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mt792x_mutex_acquire(dev);
 
-	err = mt7925_set_link_key(hw, cmd, vif, sta, key, vif->bss_conf.link_id);
+	if (ieee80211_vif_is_mld(vif)) {
+		unsigned int link_id;
+		unsigned long add;
+
+		add = key->link_id != -1 ? BIT(key->link_id) : msta->valid_links;
+
+		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+			err = mt7925_set_link_key(hw, cmd, vif, sta, key, link_id);
+			if (err < 0)
+				break;
+		}
+	} else {
+		err = mt7925_set_link_key(hw, cmd, vif, sta, key, vif->bss_conf.link_id);
+	}
 
 	mt792x_mutex_release(dev);
 
-- 
2.25.1


