Return-Path: <linux-wireless+bounces-30865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC396D2983A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F286430F06FA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCFB315D32;
	Fri, 16 Jan 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD2l/Qpj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE33195E3
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525541; cv=none; b=rA0wotX6m5gbs7hi6dHaIivcPKNrhIFphBKsUhkS7WrLJn1sCoMuzkjGdJJte3JmsZ4WzxLBoqa9j0Zeg2C0/d1D0ErV51aSD2tj6UErmcAYq6cucxYELDivO4FDOr4pj+UL57F2s75jATkaNalHN5XGaEHcBpUQZell5nISoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525541; c=relaxed/simple;
	bh=y94WeVxba42kdyHkNRz0nzHnFxtZWYsnVp0GS8SE25U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBSS7c9qOf2gkLyxIknOA0FPIshz+q2HCy975b2k280FshK4Wc0oCpS4ZasEnxZA+eNez/39O+MpoKHdSytm0FhgAagh29OpKUrwgW8zc/bkDdSeCMZWnIIaWbwxmqjInRChnDHkJjzBzB6L8ZbSLpxbaQAUYcy7j7pRiVZroO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD2l/Qpj; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b1981ca515so1731885eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525535; x=1769130335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWTGhizPE0uX/1Ee6qZDpLjHp14QecuWlmzggUKYyNs=;
        b=HD2l/Qpj2cq/wxU2LKd1NUDgMmUB1c5MPoCU0ZaANi01FPx0GecyWlMbW0GukoS4Oo
         28pIwFhMdzSdOSOrYSl+RldzmTm/NHrD+5jDUKaYSCLVsAvqrDX6/uuMp2K6CA6yyxZn
         MU0HhAqF17KSL4LzvLQvXQUgXLe4Q9QKZg6lzMqY0E+hVeyIAp2ye9YFnC+Z3lwnnS7d
         BRXb4f//0PsypwDpqkuYRVRJcDv++NIojE9pWoJb8/3eJf/+Nqd6s+/5CvAgaKfwRpJ6
         CvChyD0ruEWVaGS0bPfx2MLVvwMbj+kZXDtpsvIU/qDnVJPzOhULdBqCtgLQn1f5+EB9
         0EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525535; x=1769130335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWTGhizPE0uX/1Ee6qZDpLjHp14QecuWlmzggUKYyNs=;
        b=B7TZ4W1yzxKP45pVEjrVXj4/s590PvKPqvq2woSbz0KkpGvRvQNnCpxtWuCMsYCQvu
         5lpmxbAVHo3ghzjUW9ifTlrBwWt2LyqEAviZAzAYp899u2n6f3H1RTUOsSoRbXWhVIHf
         twPBQP4TfM0m5gTUahQqI8enzefBCLG7cLHdfVVSzL+XSJLXBgWQhYZcgh3K4li++iKW
         ApQO3dm00iW+cG+m49RU5Mcdj/OQSyzxNIOBC+8AWAsGIytDVjU8uX3duo7tAnAdnVyx
         lggQx/Nx42WVR+kqDqqfbN65LbkTGujPdzqVqvO8U0DxEwqufM8wp/GTOdl4df5C7olW
         tkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhiYczCLjIoghnO1EYZHqIVJUIEfC7rImOKaYqJSKnf1tIsrAjGuZLt9qBnXXrVDkhiNSKnLyXXXFfTFgmsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwicS656j9jfK2zPvc3kZt62tEcH0rlYEbiwaIAsWvO9z0gS12s
	08DAAiJyh7xe30ZybvwkauLZ68wb97RCBpCBAIdRy/b/74Yqon3Yzb3z
X-Gm-Gg: AY/fxX6amu5gxbYI146gJaeyoavuMRJ1d8X9A335s0AZMRk7IVmisJYNN5fFSuZzAUy
	nkiajuV5vOu8DrnFtrqbfNg/6V2um8VGg1zhSdzmgxP4IpHPBmgK3oaNcdUW04lIKJM3frnLfdj
	Q56WVkxW83BIwiQOiMNcIkhleTpHD1hOxJLDgWcfRKjGftbccK8jwVnDs4oRHq8rKcjoMHdYn28
	zV8dbIvCqBaNGX2pgenbBa6tqSNiVIGnAUP0xIuUbdZvIsnQqNcO0p9CtLVFCOnjie2aNs4dbs3
	FIwyaMYSIRxsxAexOK3SbZlOTHK6vEEvEdXjk3eFFBIfAGY/cAqOPDF1rZp3NUFkp77MbkfxqjX
	2aN0cg1mz6bOs7eFAeY3GDYcJEWd7oTaKZIHYGi1ugzG5Zk3wjWxtc6UVhKFPZZSfgMveQTGvSi
	Apii7+MDuCfpSpNxD41kkT2joH/qInKQHfWExIH8GIKr/x9OEOohMcwvTzetwjew==
X-Received: by 2002:a05:7300:748a:b0:2b6:adb4:8a18 with SMTP id 5a478bee46e88-2b6b40c8cf0mr1480744eec.22.1768525534956;
        Thu, 15 Jan 2026 17:05:34 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:34 -0800 (PST)
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
Subject: [PATCH v4 08/21] wifi: mt76: mt7925: add error handling for BSS info in key setup
Date: Thu, 15 Jan 2026 17:05:06 -0800
Message-ID: <20260116010519.37001-9-zac@zacbowling.com>
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
index a7e1e673c4..058394b2e0 100644
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
2.52.0


