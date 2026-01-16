Return-Path: <linux-wireless+bounces-30871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 223A1D29801
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A6AC3027E4E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED613233EE;
	Fri, 16 Jan 2026 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcEu1HNb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A074315D33
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525550; cv=none; b=dt7ag2oISvLNtGpk04s9TQNekBQWv1XwfIO31uAYJkeSY3+2QQcnLCXJKx8sO/afF5pOklFEQ9I27XmmLb1cc2/Iyuh7U0pXoyo9ZNlQX92PUE7jS3/MiuLpflyjdBjZfPQfNhq4RMpHblQ8DyiZytYCBJyMUJKps8h1j83U2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525550; c=relaxed/simple;
	bh=w6QN5tnbV21n88GBqrBPSA7O7w2Y8eDZmrW+Y9oHKq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6nNMbrBE4+tdMXnE8LnVUkIrcR+p0nJ6gYFq1lv7Wz2N/z7SDEe7N/DSSTmIvrnTwR7d19PtJZxx+vh0bv+X2RdgckMwYKl3dJyhUwBvd2xGT5spfCdi79yDRJwFapZ5rj4uluu1CurmOrzZhyPe8iJ56OeERF1KKU0P0O3aqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcEu1HNb; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b1981ca515so1731936eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525540; x=1769130340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZFGFJGnMesEgV/ggwEQUIQPbrKFKaXQBFGLJsUOfUw=;
        b=GcEu1HNbDTvEB0srfk5NFk/8KFEM53CARuYsm4d6RsxWJpS5WXL4fgx9W1wkU8d4nG
         STP/73G9JBVEJ1WgSk0C3zFVNY5iGW2zmatQI2REfI2Tb9RnYxO4mRqluJJxNUxSo1BT
         VmK6DvViFm4RjipIb21OtPpO77IlKM9jfUaKHuqSfpwAl5zRh+1gVlx8/Jsq8gywfamN
         oqXQfEcC5w0hjP2k7bvuirQYuyNDwT1qZCWX52i0sbq2PZ9AaydqBW7FbTC7G1aTlmfY
         W9LloFQSrQVPMFQ9pAGkk6yvoukiMRhFflhnB37iVM9bqCML0CLXHc/uLDm1OzLpa0qG
         BWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525540; x=1769130340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZFGFJGnMesEgV/ggwEQUIQPbrKFKaXQBFGLJsUOfUw=;
        b=i0rJLsjsqyNhplp/uoEmV9wn0Zw+TUxcgP5ygrvCVVdddarCRXEbN+0Efdpwj7dr2y
         wtI8Yr3+LCduiwdLxzJng1fWhmbdh6+3KZAV6wW5GVsAIVT7XuLC3mL2Gt14EOeZNUaE
         AKtbfYv/HLHtbFTmXgufKO6Fz+BdFp93YSoclA0eKOYboqN8SNMbH2DdmH//Jpt5WLrw
         k6vuOtOlyJKHKDJiHXnsb5v9aWwvEubQ9Ag4K95LNe96xQ+V1U0tDz3ggqM7Ia9ycHzj
         9AwJ8oHAL4GvcPV1aPXl/0XXzl3+JU6GmbQPsQsgGmEh48uXrh4SDv7W/sgiyM+REZ64
         oe+g==
X-Forwarded-Encrypted: i=1; AJvYcCXobh4pqgAjhgyyFwwe4O3zRuVtkEALoNtw2PSJwswq2BDtmes9dqd+ucxhHsSHPzUow03z/IHfVR/cGeb/8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjL+GgHbSbz3zpgPo7tXXMf9nu1zkPNWEFK17VDU1GYeiQlLI3
	dFY0y2NrgP02qnFJb5CdnO6WoGw0kzwKgz1Zl57DbTAXtTYiVXrFe4L0
X-Gm-Gg: AY/fxX6mRvHsW7GoJ3du9RX1z/+bYnd4M6G2EMF+19trAL7j+s5ftq4eVo9IPNcSgGC
	gZ6W9keABee+GRCt4OkE+NgxB+wRY3X/uscNTNb/epXiWBGG7lURMde5KCfWIA0dXNuVzDziYuR
	NXajjm+qDimgQ+sj8bYi7ZeikF16k13mSsESvBeLy1kks21e2ub0KMedAV/Og1kfpAxmWmQ2ppK
	9w3so4b+iExqRvUZSlHtaZiNEW1zVWERrl/U5LDi47WRpyacOjUz63HDhFfaGW7W+jgenGDosMN
	vDpUo38mgoR6EBg3AlyM24O9URzijJS1BtXwHNLOXczd3xp0Gk/toQ34R38sVTHSOs/nSxXvkIc
	EIbOOAtVgMstdMzuxZ6gJZ+48VqwuqjAlFS6nJ2AUxbPErFjrppdp3QyZf0mohGh6vifetM6UBW
	UR+wDnQd5pMSiZ/I8WgtSuoVhbsT1cpPpyzgphMoASXDOPkHS9TA9aU6F6H2X1xg==
X-Received: by 2002:a05:7300:cc0a:b0:2b0:56fd:4b67 with SMTP id 5a478bee46e88-2b6b3f074e7mr1271641eec.12.1768525539493;
        Thu, 15 Jan 2026 17:05:39 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:38 -0800 (PST)
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
Subject: [PATCH v4 11/21] wifi: mt76: mt7925: add lockdep assertions for mutex verification
Date: Thu, 15 Jan 2026 17:05:09 -0800
Message-ID: <20260116010519.37001-12-zac@zacbowling.com>
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
index d61a7fbda7..958ff9da9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1527,6 +1527,8 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 		},
 	};
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
@@ -2037,6 +2039,8 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
@@ -2843,6 +2847,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.52.0


