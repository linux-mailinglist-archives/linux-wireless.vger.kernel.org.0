Return-Path: <linux-wireless+bounces-30330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8BCF17EB
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D36D930550E3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A71F5617;
	Mon,  5 Jan 2026 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrKDTdW8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E31DD9AD
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572821; cv=none; b=DsskpJX8xplo+j1xiESdcIfe/Ea7whf3HyfT6k4LCf3dKaw6dgFlEcCkJ1Sl8VcocTQZ1e5TQ1ej2mcppETDS5WYF1o47xcckuPbISmFpGTK955CncsxdsZXAikJVjGbiZRkUODAxPWfe/F2P218ii4Mfrc5ocasfhVufICuXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572821; c=relaxed/simple;
	bh=9wMw4Xb04PSrFVmyO0HNqMXeSWHTRirn2UmUmWfZAjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEhuxtIT2GrMAoM3D1dmryhbdz1qL1gvRrRIYjTNhZFHFQIbNGmn+CDllvK93kURMD4Se1Vvp1R5jtNzjjxztCJB/c/30LCocld8gFM+ZYNAFPlWxizrJs/7E4+Knjz/6jIWQvZMUKdxVuv7VD4HjJisCTaqKTvG0UFt691/WP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrKDTdW8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d5c365ceso179934975ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572819; x=1768177619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDFNq4JsZcxs1GGsQxpxUqJ7LLS5xEhchca1DSQB1FY=;
        b=JrKDTdW87ouCu11jxBsHZrm8ZJ8/xwwuK5sVYPxty10TmbLMh1x9LfWqPUCWjQHS7R
         vlF9hN3myb8o9Olt6kkVDPOPjhnQKQifnbmnYt0+6GGiNUF6xCWjCwT4cNsNxv6AaS0c
         TqDKKISmRbMafyRULdI916iwJVTkP+FW8b7DF4UFqhgtjfO7+EdmBArGCohnZYee/Sqm
         rmqvRm8+y0ZG6bmb+A+PlCOsw1BF//XOhd7/SdbYkX0FOBHYss3ZnbrOgp77hLvmLgiB
         dhplydhGK36tmoxg40Yc2wqbdqTo3BmvnVojqJjQ/m89NPxeXqpml00YuI8WS4+KzzH7
         Thow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572819; x=1768177619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDFNq4JsZcxs1GGsQxpxUqJ7LLS5xEhchca1DSQB1FY=;
        b=kyfA5nImwJGApX1GLA42LZECdPJkKrsxAzlXVRBXjNDAaIBEtO0LHuDUOUzgFINzrf
         pYou3R2XWsU3A76/NiV7gusHgAuX9hq6iu2GQKiBN/WdDJgY5TcNxKGRkZysDEni6jVC
         YOY2yFG8vm085FFgnLZNSpP3hhcC6qRD3G6R3y1gkp2faRN5eXvjZC0VyfIpv0zcu8bQ
         Jv12xchQ1Hx7TLlBdlMRyaGeiqjeLGXTMuwNamBm7EmE897Vk6z+Dz0tOtN58CJhBONr
         MqtLAM1ZrDlo4CBZ7xD3uD4aIJpfen4WjvGmcX1AriJ+RmJp21Q1/7R6Gofjogl09JmA
         rtgg==
X-Forwarded-Encrypted: i=1; AJvYcCW9IZVy51hkAaKttDErbPf8PdlAZXYCzWvNgHWmAaiQFxFs5nAbJMeyCsKOGOdLDUw1Revz/I067CbLEleLEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI05+uzLQs3OtpddmAvkJbbSoqeH5WiV/HGb8bM13l7D2EsVyM
	oCs9o3eZe97pYHnuVYaGCWowzvDBAlQkXdS58k+gtWO32bTG2phsWuYg
X-Gm-Gg: AY/fxX4+W9d8gbgmSBEIci6rJ4eYfbbeJ8dMiYxI0raPPu1TQ7eBRrz2U943B53dXW8
	UxakBOnmF31yjDhLWkmLsgLwePg9nDPeco3LJ1MuKvSL7uKcRq9P01uyHCuKXGUZbtIpk9VmTZO
	6zJR7AIAF96svGj8t4xk5XIOJWD6CB2CqE+nFAi/tJUX/PC2NBQYv6hTbkoM4OwjRMUao81HbAP
	MrD3pM99WL2uf9LpeuidNuMOkqg5ayrvDax04eTbID0nIPNdzvgJ5IkiFgLwyttzdEcw9KPqiBP
	drR97pTN3yQhsar5fniXq4JURL+3IADe0jyoCiRi6d4vnII1wW7OV04+xYzC9JhU2HImcLgp561
	owGYMzuA6oBUFOxijpWqLCCnfzRkq39vYHJpOjS0TFg9PmwRTC4MbqiwM8nL5LUDpQp57n2J96d
	M/t2nGudLOaqMJHoYBoZUaWHjIEgno5T7Tz+FXIrJehcUUoMKqeZ8+KyMBnCZyIw0/FAPN/aX+0
	A==
X-Google-Smtp-Source: AGHT+IGeeKmkZlgIpVZni90ulNKu2CTVrD//QHX+vZIPY7voqHaSNcphqKMalZRbGAYUw9J3u9/Low==
X-Received: by 2002:a05:7022:eac1:b0:11d:c91e:3b58 with SMTP id a92af1059eb24-121722e9e26mr38779723c88.39.1767572819190;
        Sun, 04 Jan 2026 16:26:59 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:58 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH 08/17] wifi: mt76: mt7925: add error handling for BSS info in key setup
Date: Sun,  4 Jan 2026 16:26:29 -0800
Message-ID: <20260105002638.668723-9-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check return value of mt7925_mcu_add_bss_info() in mt7925_set_link_key()
when setting up cipher for the first time and propagate errors.

The BSS info update with cipher information must succeed before key
programming can proceed. If this MCU command fails, continuing with
key setup would program keys into the firmware for a BSS that does not
have the correct cipher configuration.

SECURITY NOTE: Silent failure here is particularly dangerous because
the user would believe encryption is active when the firmware may not
have the cipher properly configured, potentially resulting in
unencrypted or incorrectly encrypted traffic. This ensures the error
is propagated up the stack rather than silently ignored.

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
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


