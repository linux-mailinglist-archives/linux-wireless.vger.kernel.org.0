Return-Path: <linux-wireless+bounces-30262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5FECECD82
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A78553002BA8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9D222584;
	Thu,  1 Jan 2026 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWppzZjI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C56221542
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248732; cv=none; b=OCDv4rKu6rYVypHUvbohkqRSc5iUTQt01Otgp1zw7Q03JLLEwUyTAtvMEBVNdrmszb3QhTspOMvOrytFXLc7i1y+JPl0lcyIOkuym26iTQ6n9hyC7jjTEPnBXRnBoqyAHBSotB/OyB7RzPp7FjUZIsNS6xkUO0rbbVXiBmJZVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248732; c=relaxed/simple;
	bh=pQc/vzHBPofjPQzffq9tp4UYlSjbwrE9yDJCnGfjw0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9/Tpp2NCJL6oIdTQr4sptAROWBJB0+uL/vh4BDIsKlZTn4/n6a/kdBabFW3jTNLSGBFU32VesdSwepySPN0rodCbqTYw+p5QuTJl01XJvKaec6xBkywCy5/95OHMlfcejWEF/+VKdG8L4IDo9bGByvpPxyk1YNa7AcvAnc/F70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWppzZjI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c3e921afad1so455899a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248729; x=1767853529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgbiI2XInQRR+Vqs16mnpbyaWQyjL6O2oXRYN+hsObo=;
        b=QWppzZjIIkWUMr1USq9RuBkgumytNPzxesg9SOzbA+nWgt4pRkviMh9f4h8bnMYN65
         WShznzgHSnPX2BH8KqJrwUjyAoQ4z0xsWSeOdd5SyJpTogp7q4eEGMNTNJj7q5EB8/NS
         ky8mQyDMcgn+tCf64jRNElqiFI4jxCtjWavkA99EnnibvPmANEZ7pq8OFtRnm6As8tm+
         XpJ97pahlj4TRKW2TG039YG+mPQIi49bRmQo5xnn3kJqAmjqMxiJQumfGoeXmgXEgRUY
         F7dJZ+0xWIMlIYjJBo2YwfMkI8Q7BqUjlH2AMe4tlHn8k7jBgUVTxMrHE0dLCx8LAitJ
         RP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248729; x=1767853529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kgbiI2XInQRR+Vqs16mnpbyaWQyjL6O2oXRYN+hsObo=;
        b=vsR79PBEcZk9OwEjdzUdMUHN/KUs3eG6NV27ReOV7yAC9rw6l2/BDNuVu4zCqzPfOY
         CLsfxlITPZIRFcNhryNjJMcMOulQXDxCzk6HCRwppo3c5jAuCgo7S1xhNr3xMjurRW7R
         YtYOlNDNQLZgm7bo6R44jZYo+qm/TxVY7l+CAeenBQmzUbiB2CGrxg2BErDsy5kY/0dF
         v8bUAcNPyPVmS+QmVLYcXQ2f9spaEApGXfHUMLclGg3RgRjECok6URGuRGBuHAEzrviT
         wepG9SoV0rMmtlUlzEksFPf0Jv8WjKwsjMlsSkWnz6uKHqas7iXIQllh9m+6veg6KTYD
         cQuw==
X-Gm-Message-State: AOJu0Ywjz8Y1FinaOI81t1+dGZm6wKdiBOxiYBks5ivb4HjkyIFVLOyz
	HYZbw/99mqIqTO5PgAp8pxdn9A2+C4GqtD0r/NpeIAp7xPEnVDmmfcnS/14mDzfT
X-Gm-Gg: AY/fxX6Q19lVkcnsCfUyrC213NM8CzmHYYN+FkEc5RvG9eblYj7eDs25trOjRXFsV7l
	T2O+TVvmz0/EJRY5wQiwRql+/akdHf+OfmWZg+0gpBuORIxG7DAO3aE+CRrZDK/4B0fIF8Qt/us
	8DA6rcOATTWqrdO4uNc7cISYQxRc3nj11vU3epY9GN9e8rt7Qwki6aR/DC0zxMYKnGqpx3hvf3r
	mXN2GtaGXQiQBVsZ9kOWji+wk012jUkbOBmLjKxaYuxQQ0KrkwraaPZZvAQhR0M/G8JsMujRutO
	Qq1LBeS0E5xszOKM27E7UY7T5TM6Lg5XBsteeNz7IzdZlzl8/J9WDPXr3kiSe+eeBGigJU6Q4KF
	Tm+2jHSxL9kavpncT6v5NizQp5kAmr9lQNb/CUD17Iqc33Y3RirWemMH8Q5025kg8+kkjgENUQS
	4h5LijfBVxXnZf7UMpvsvygWa1pDjx+BJrgRaUX21LIzewM8iSTQbkUDSKmdbQBbF+GVXHCt7u
X-Google-Smtp-Source: AGHT+IF0EsKgw/v3geh0bknpZ5PAnHW8mZQz21B6hYvNqEgoKWU6U4GCafgpBsInjUAAOIATUbBYTA==
X-Received: by 2002:a05:7022:2214:b0:11a:23fb:16e2 with SMTP id a92af1059eb24-121721aab8fmr37787196c88.9.1767248729358;
        Wed, 31 Dec 2025 22:25:29 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm144361662c88.4.2025.12.31.22.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:25:28 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: add error handling for BSS info in key setup
Date: Wed, 31 Dec 2025 22:25:25 -0800
Message-ID: <20260101062525.186192-3-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260101062525.186192-1-zbowling@gmail.com>
References: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
 <20260101062525.186192-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Check return value of mt7925_mcu_add_bss_info() in mt7925_set_key_link()
when setting up cipher for the first time and propagate errors.

The BSS info update with cipher information must succeed before key
programming can proceed. If this MCU command fails, continuing with
key setup would program keys into the firmware for a BSS that doesn't
have the correct cipher configuration.

Reported-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a7e1e673c4bc..058394b2e067 100644
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
-- 
2.51.0


