Return-Path: <linux-wireless+bounces-30878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CFD2989C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 398823122198
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7FE329C7C;
	Fri, 16 Jan 2026 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6uFt4MI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC09320CB8
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525558; cv=none; b=OQct2omzkyssXPbJ2NR+fmJTueFeJWUPSpxgKFoWNH5VHlAGaSNC5Z2dUXIjulJeNVi2PhIcYTxSgQBtLPuGt+X0R8f3P4gkpb9T9k1vwNrP6nsXwHuSyf4slj+ehrTmmOjKOz6KVAKEt/LerpmmFy/pUmcEht+r4/s+20EmB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525558; c=relaxed/simple;
	bh=ncrRr8O6tigVgbV546c9oteIZcBP9anuVJ5asckXJHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk8C6omVIszo4JFO8vSPPcedsMvLekYmCKyTVZ7W8MkBY+3ML0Fl9FzvoTqmLyJGlNNd8w1KuhiVkBFlcvUM/3S0JyG9lsecB+kKlEK1fSw3QkM82K6zLLAhGzVm6xIhtlpCs5FLfY0NWD2vc72mKf/dtCxUgIBGnFl4vBlUbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6uFt4MI; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6b65c79aeso586608eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525553; x=1769130353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewdMOqZu09vzVANg46kFx4cCu4Abbaa2QyPG4SOmwEs=;
        b=R6uFt4MIpXQzjITdhe4T8i7pgnRrnXPLdhehQ2ROl4lJgM8hKzgyudsIRzsFhg/Wnr
         G0p5Ip99dE1W7+vpHuXy5ojEO3FtyEucpSFE7udlOhj1y4zsBHKjmfqtQBmhF8APmY4K
         l9pNhF5NbNYx9NmInZj5G+5fFVwP+rErPhJgTYYOCttoATd42qgJ1GtAKQGRs2euq7HA
         1uUTOo9gw95XufRdMxidzoP4kev7lhX+ybvvKmjnqTE0SKVlRDPYJ2uU5gg8/ZPOeyfU
         gSgEewsgFzzetUFbwhjMHAFD45EuzPaEXTN0THLdUNJoMxokjMip7oEcSZ0ytzTZyV8/
         UsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525553; x=1769130353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewdMOqZu09vzVANg46kFx4cCu4Abbaa2QyPG4SOmwEs=;
        b=Jlm3MMkGtC+IcuDvPMl2zif3d130P1Rx+Nugr6+vbVZk6PkV2EpZ8uVs/gzP1QMfC7
         CuIV2E5WF/LJzQ9QycFo/HtAspXKdousHHEloT5yD29xL4ZURNpwPBL81bhwhTRYeC17
         E5z81ysS2lE+NVcmRYfCfvcE7nxPyAQtdZlFtPV2QikT/DLIYLpKFgVrdAJkNqtm78+P
         pur5x5wFrehnT5n1oWnr5f5Z6dWKVfWiyvsmyqLqi5ZbHCtNMND5heNbzJqsOG1uky5F
         6sn7L2nhmlT+4F8ZHyp+1obvLs5JRP3RzyMUG4RU1kLc6YgYgvwjJDu6LdgorNXDEFvx
         +TEw==
X-Forwarded-Encrypted: i=1; AJvYcCXuWFXOsYpy+4AmJyIWnYambcN08gu+qmECBpl/lQBqWw2refAkA6QbRzQDAAZDbgk/3WJpZDDH9BTgDfmxPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSw4m2jlli6AGQrBb0dsQlMO441YDGSLwDyodTAJlYK7mcKL48
	AiP7t0X0XSHkEaNtJp/cIur86W539aBaZNw6CRTX5k5lCvTcyU4YwK93
X-Gm-Gg: AY/fxX6TNRuAp/V8JwL++wxFFWEPtVliX5mRHiLQftN4xnBjnnT43WSEehlfatoh9oo
	TEqscOgsK5yy5EImyNecuJ5Rymcov+YleRhDqbldzVYqmfQkp/a6RxGxF16NTiXamRit+0Zc/1f
	C/nxNO5cGyvUHfRIQDW5vlRMgQTGcldzBnsZIBNxM6IDlj3lT06bL95La3aICgsYF8Cijf+jaTV
	Gc3PgMmmey2b2Y9cC8iYr9h+AMwHLrWUz4QDh+M3wp2o9YcgrgsvunDdk+VxxtM0W0wIVIeytqm
	yrdLujpw4q1jAFP9F3GXIp+6EDB/dvuNm0sMGA4I/RvFD31ODWIjoYZ7t24TlHtUK+LkartOO+D
	xBCpTTrdUrp0jXeyyYcXp1ON9bLn9kYEJ7vcrtRsI8CaVqwuJyBmP5ivENQ3od1p6YJ/XGKQ63F
	hmaQ2NPxH+CdAUaNHqVe3deYQI3xj6WF3joZ2koir2X5M307LPwiROVr3nfr7PDclsDEOg7nPS
X-Received: by 2002:a05:7301:1e90:b0:2ae:5020:afe1 with SMTP id 5a478bee46e88-2b6b402c47amr1281429eec.14.1768525552939;
        Thu, 15 Jan 2026 17:05:52 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:52 -0800 (PST)
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
	Zac <zac@zacbowling.com>,
	Zac Bowling <zbowling@gmail.com>
Subject: [PATCH v4 20/21] wifi: mt76: fix list corruption in mt76_wcid_cleanup
Date: Thu, 15 Jan 2026 17:05:18 -0800
Message-ID: <20260116010519.37001-21-zac@zacbowling.com>
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

mt76_wcid_cleanup() was not removing wcid entries from sta_poll_list
before mt76_reset_device() reinitializes the master list. This leaves
stale pointers in wcid->poll_list, causing list corruption when
mt76_wcid_add_poll() later checks list_empty() and tries to add the
entry back.

The fix adds proper cleanup of poll_list in mt76_wcid_cleanup(),
matching how tx_list is already handled. This is similar to what
mt7996_mac_sta_deinit_link() already does correctly.

Fixes list corruption warnings like:
  list_add corruption. prev->next should be next (ffffffff...)

Signed-off-by: Zac Bowling <zbowling@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f4..d0c522909e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1716,6 +1716,16 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 
 	idr_destroy(&wcid->pktid);
 
+	/* Remove from sta_poll_list to prevent list corruption after reset.
+	 * Without this, mt76_reset_device() reinitializes sta_poll_list but
+	 * leaves wcid->poll_list with stale pointers, causing list corruption
+	 * when mt76_wcid_add_poll() checks list_empty().
+	 */
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&wcid->poll_list))
+		list_del_init(&wcid->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
 	spin_lock_bh(&phy->tx_lock);
 
 	if (!list_empty(&wcid->tx_list))
-- 
2.52.0


