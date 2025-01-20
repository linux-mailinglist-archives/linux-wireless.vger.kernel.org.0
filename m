Return-Path: <linux-wireless+bounces-17738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08150A169CF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27227163821
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593671B0F0B;
	Mon, 20 Jan 2025 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vj+7Pt//"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220419AD8D
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366427; cv=none; b=JBXS8JLVeGjd/Piqn3LA1OaLURXHDMR2iGJ0Uo1jW5pvqn/C5obGlyIk9jQYbTgykIi6bt7bMQmCh1rgBgaJQZa2H7aavL1V9s/JDuU6tbemcGBNhIFTo2yI4Fvcr/0xTLFkSQXxl2wKnAw+UwrNH1i/tA+8FZTW6xqhNsUu8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366427; c=relaxed/simple;
	bh=CLtH6u90O+N7mDiNWKKTvhQAJx7W2UlPQbyMWSmfrks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JWuKCI0ns7ApH9hmFo9eLfueWN2AVUdMC2VY5JcR1bs/8c5a3Ra1gyHs9QaEgcZeqHXGsQggKdLHsmFkUSkpX4UeWqvh2+g0tp0uQVMj8aeJupHjXBZtO7H/0fieUB1aD5aJapzjaKshk0eGMWuv3mt4/sjkdwdCKR4cB2+UwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vj+7Pt//; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38632b8ae71so3405560f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 01:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737366422; x=1737971222; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VM6sOkfE8iqC95N0AKyRjkMPid32wJ87nN4QCxrUuqo=;
        b=Vj+7Pt//YpE+KQ+Lotti2s+qxJrq1UCy5MJJE5uWS+uMWfI8m3+6MQFjQ69NOfn4B0
         dE7xluF2BumlkbvdrDn7+jQx+TgJ/2HjqyLrnbd+eKza9YE19sEWugxN87R2O5Yt32mC
         UFGw4IhwhNB8V4OcE7Ghzc1yfw8XfOZVrbO+v/sfGA4KWCNlWa7RWUEc5P8xFuh6TGv4
         T7nGFraeYOcBF25iF53O7fbLtzsins72xHMZm725iflIknKUfzjYHqs7vjzUMId6saZ6
         uyVPM+A5bC8ORXdA1WxAXj5ls6GguCsdzbESF0hKiZMItXRWGvLnORQbJpwBMT5rMzLq
         5FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737366422; x=1737971222;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VM6sOkfE8iqC95N0AKyRjkMPid32wJ87nN4QCxrUuqo=;
        b=d3igP39wXNoctQPNNx3lv4kQt9WE1uAQ/8vkuT/IlBDtYXo0XBwhiNd/gG4Dfzavd4
         WXinpY66dZ0cCPssfAmfSn3+ohL2aX05HLSyEKC3q4KnXrLqc7XGFHFixkC9P3GsNSKG
         0/JsIHGXVQWzMpuKVxFXjFyhAxRVJV49kpc6ASM5Xg4X7H1tWUDyZJX7ZO23IMLsqHY4
         /LMyekzJgJEW0uvUgqZj9EpGq2bBDXBsNgmjGbeYrh1NYWbLK3ZCqUfM7vRY1z0zVMO5
         lze41974QWOuWa01Nsdx1r8wMcdDncL+9Mwe7D3jUpNne0BBwFuhjgDlQDNmv1xKhOd2
         VOTA==
X-Forwarded-Encrypted: i=1; AJvYcCVApo22GhQHwqapaHjbTupSAtCr1LAIO/FSyA66HDNd0kv63gy/2lecDvkIUZNNu2p12Dwr0pT45OUoCuUARw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiWS+hl0fIgo3DvO67JPShY0P1JuAB+3Ok713B/ad9XbdRe3O
	xuYdHfyL2vqNXRA99a2XjDR/bQ4p5fPknGhQ5elQyRfYvaV2zcr8/7riP2aoxY4=
X-Gm-Gg: ASbGnctfx5EhrW2/qEKd1dkD9nSRe9APvIcz0MbKX6JzQtGBSimm6swo2wFLjKzMQsR
	hUcOUB5y3mtacWgiJabNGzyala+eg6K9jl3or0abaIl/JCIGG8rOumSVLWaE4COMXU3l/I4BeOB
	37/2Jx6vwZYrFkGiP+ZJCpKG4pfK/O2L4yfGdKb4BAjiy/UTS0HfnN+VCxPAYjV2U6Fz3lyeG4k
	lKyLprMQKxZNCDUIqh2N3MGL7HgdcTveoArFJ/S3mvdNgs/AVvY7TWa1m066Eir4Ppt6K2Z98A=
X-Google-Smtp-Source: AGHT+IGPG329V2074yOYSMY1ziObuL2UZ+m5lYehxxQsiJfOBHTxj4D3R6O9lmeqMjiIW6U9yiBaRw==
X-Received: by 2002:adf:9bca:0:b0:386:3356:f3ac with SMTP id ffacd0b85a97d-38bf57937a7mr7522401f8f.26.1737366422340;
        Mon, 20 Jan 2025 01:47:02 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32758dbsm10018595f8f.64.2025.01.20.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:47:01 -0800 (PST)
Date: Mon, 20 Jan 2025 12:46:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Deren Wu <deren.wu@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: mt76: mt7925: fix error checking in
 mt7925_mcu_uni_rx/tx_ba()
Message-ID: <063aafdf-3234-42ac-a4ea-3ff98e2835b6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "ret" variable in mt7925_mcu_uni_[rx/tx]_ba() needs to be signed for
the if (ret < 0) condition to be true.

Also the mt7925_mcu_sta_ba() function returns positive values on success.
The code currently returns whatever non-negative value was returned on
the last iteration.  It would be better to return zero on success.  This
function is called from mt7925_ampdu_action() which does not check the
return value so the return value doesn't affect runtime.  However, it
still makes sense to return zero even though nothing is affected in the
current code.

Fixes: eb2a9a12c609 ("wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 15815ad84713..b3a00964e802 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -617,7 +617,8 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 	struct mt792x_bss_conf *mconf;
 	unsigned long usable_links = ieee80211_vif_usable_links(vif);
 	struct mt76_wcid *wcid;
-	u8 link_id, ret;
+	u8 link_id;
+	int ret;
 
 	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		mconf = mt792x_vif_to_link(mvif, link_id);
@@ -630,10 +631,10 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
 					enable, true);
 		if (ret < 0)
-			break;
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
@@ -647,7 +648,8 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 	struct mt792x_bss_conf *mconf;
 	unsigned long usable_links = ieee80211_vif_usable_links(vif);
 	struct mt76_wcid *wcid;
-	u8 link_id, ret;
+	u8 link_id;
+	int ret;
 
 	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		mconf = mt792x_vif_to_link(mvif, link_id);
@@ -657,10 +659,10 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
 					enable, false);
 		if (ret < 0)
-			break;
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
-- 
2.45.2


