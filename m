Return-Path: <linux-wireless+bounces-31000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615CD3BF5D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 431994F727F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7438A9D9;
	Tue, 20 Jan 2026 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giqAmU8x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA1387372
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890550; cv=none; b=rl+Mx/yWLSOaFqxjWDUOjENPANBcRWRV2gt9O6zVr6moxl4u6xWhkGfMgZXd4ra/ya8ajSs3FgTi73QJFBnjCF/JKezRpkU6jZgOnqhDV02oIhQMK5SoaE22LI4qRzER5SKm3XsuUe9c03g+KSefhoM+MTKceQots/Tdxje+FJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890550; c=relaxed/simple;
	bh=cJcXyjEZSUQDGUOvvl04ViXnS4Gd51j6mnYPp5zBgFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJvgKgDAbAFaja57+6dLHypoTiYZWbqk6a7l7hdZoskk8HF1e8j1Ls9rfMYOrvFf0TaZbGHyEruIOXdjvTgTyr1md9zQV1MbQLCeQ4+B1hj8m+dV9mGjnLUUcNy/k6Ory0OsCQCqrawzkDMKY4JogjuoBW2Zl8xyEKELmTBSWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giqAmU8x; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b6bf6adc65so4982913eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890548; x=1769495348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt1mPPXw8aFoKYpC5Tia09ZY3lzzrV+SydYHdLpjRKk=;
        b=giqAmU8xx9py7oVzsuNrxu3G+ede94Itd42sMGeY5FRQJe/y0gza5szqSxyZNIaeq6
         Zn8Q6INsmYnS4lr0ZD0UM/XtZHnthQurpa+XMncZPuuCINA2XfNvhyw0g1yqJ6k7MOW9
         gB+xCKuVqBk2p9ExMNx9fsLw9TL+stbmOKAfZhFmI2QanKzowPbnBOIZSProq1aeMYhg
         ha1qaclIZJDhsl6RTabzm/tgCqqgd3NuqtTHnQEEdENK5YlXJSvCkb8bevcVE5riDtS5
         bVuCoT24nkploeWbDcXjc3T7pqOLw7ScZ0ufPla3FmeeYV+E9i7WMVGVIYEt9OfYUdO/
         lmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890548; x=1769495348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt1mPPXw8aFoKYpC5Tia09ZY3lzzrV+SydYHdLpjRKk=;
        b=D0SRo1PbDVa0y81KI+7BiEk5fVgykKlf1UB2VE6QjCgYC5oeb0hdtFhMG6VxcQ8p77
         dARwwtaHyJ7woM6+rHzGym/U3fdR4HkK0ahoW/w8n57/csujhhZQdFRM5sghpbzaMPFA
         SQcU+JKy+8DK3GT2jUyVrddjJH66ZRcqOhzPTr+sN5YBv+5OnlKgyHUdNGUvUbEWZ8+W
         xoeoGbK1y+tfeF35MlsSI7fbCGlwZOj7iJGnEoTNBnvQRPlmoUoPVIIx6X7OYhL533Lt
         fZz8Ne7RrrVvym7+8iwEWerkTvdleLmhsv5XllIk9IwRH4xWrsnPaF/wWbqA9GJasz0H
         tFCw==
X-Forwarded-Encrypted: i=1; AJvYcCVEKvZ+koUDu2EcKtKpg7F9mCYepkjD5ZBhggRMfT0zzz9uQ1RQXS7qLu+mWch08e96QsjGnfMEo83KnVGRrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1fc5z2Qw0qGE0sZwHZzzA/4Jfr+XLVNs4d718co1lto+TMe1
	ciHnyqkV71nwlzz4/10KHtZjqmK0FwXC1WzAUZ0fsFgKDGO8MisiJ6XX
X-Gm-Gg: AZuq6aLWnelVgtFRvJijOHoncgs9wtYsUZCC79wgdtPdr5s2HiMoXuAQ2lcrYIPzasF
	ylJPBnwdkVYoCBd4FhPrEWD2cKqLX4eAf1rShVv8WUsjCbgOi5n7x+GFR8iKi9VHsykZXm4HIal
	Imsz9EcAEWdxWFe3OwP0cRYiHsnq4bErn9/6WLa5RGuy8izuVYy7xXGL8XqviTec74f5EHtEhMQ
	CHWjpu/Z7dUPPHRq34dx1wePYevRG69rp+wgZDHUMxySE+YTvmHQCs+wvfjpsG/yddBoJJ5HdMS
	25goL2JAgv20Krf5Ihpfi0U1y+UV2pqYxuAdG6wddLPJx3I4lQSZ9q0VmyU8QK1EsrgDWMQR3V5
	ifiAGMAXOM9ihyjTZyiUs0gUoW5Y9RIKlcvXEFTMDlG38naRDxqlatvYMPJdqwsF0PY4AcdimuR
	15CA7Bgh36yOn2IHH+eRotplYLqCulUgvr9hEpJTrqKLYBeEyYjKjZEFaq28X/
X-Received: by 2002:a05:7300:54d:b0:2a4:3593:ddd9 with SMTP id 5a478bee46e88-2b6b46c69ebmr9563555eec.6.1768890547673;
        Mon, 19 Jan 2026 22:29:07 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:07 -0800 (PST)
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
Subject: [PATCH 08/11] wifi: mt76: mt7925: add lockdep assertions for mutex verification
Date: Mon, 19 Jan 2026 22:28:51 -0800
Message-ID: <20260120062854.126501-9-zac@zacbowling.com>
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

Add lockdep_assert_held() calls to critical MCU functions to help catch
mutex violations during development and debugging. This follows the
pattern used in other mt76 drivers (mt7996, mt7915, mt7615).

Functions with new assertions:
- mt7925_mcu_add_bss_info(): Core BSS configuration MCU command
- mt7925_mcu_sta_update(): Station record update MCU command
- mt7925_mcu_uni_bss_ps(): Power save state MCU command

These functions modify firmware state and must be called with the
device mutex held to prevent race conditions. The lockdep assertions
will trigger warnings at runtime if code paths exist that call these
functions without proper mutex protection.

This aids in detecting the class of bugs fixed by patches in this series.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 94ec62a4538a..1c58b0be2be4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1532,6 +1532,8 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 		},
 	};
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
@@ -2047,6 +2049,8 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink = NULL;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
@@ -2853,6 +2857,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.52.0


