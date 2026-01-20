Return-Path: <linux-wireless+bounces-31001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC1D3BF42
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B70E387987
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB2387372;
	Tue, 20 Jan 2026 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHdzzFO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898838A2BE
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890552; cv=none; b=n645+FEcHFRdvC/TbDqWiaUcIREzaFhEqT+ShoxXtlWqu8TZXJXZKrnKcuN9v0vbW9Y4+Ulq/Ox2+utXjpfKPeiIXJj/v2Hbs21WB4vKqO1pmzvEQ72k0e7O5/3w0+23fAyv45wywcFr7hO2cXF/fcG4BILKEyHpkf67/icUkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890552; c=relaxed/simple;
	bh=dRjFX1OxFoMErBW1Lic/dK0shEoukUCq8IytKXd5DYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nn5EGPV9+tRqA5fRs9598w2caBHgQI2L8sPithdS37mq/JPSviY2FUodsVwPEijylILvfRVaq7REOnLP0hy65gLbRtKvYr585YspGZd0mdhJ01jtYt3DYDBca5YRyX7/OVM9D01Lh9xQM41SGzWENjKuByxdDuk8BNL0qejgCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHdzzFO9; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ae38f81be1so5614249eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890549; x=1769495349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PemvynWJoEEr+vQfljTmIKiSnjimqG0bkRw68R0p5Rk=;
        b=kHdzzFO9h53qM9g7OK1vcSJPsRgw62MNHNEvolRc2mzPawGJmjeGwtVZX87r3ZrTW9
         QW+qOh1MdJr7iRjJ9FjgYR+XOm+LBMG+yhjT97QjGBzCz+py7md/iIkyXdk1HMJOrX+4
         cPKulZeWScSOEitdViakDIJ5nEI0iVJUMBvqHCeL8SXCKSazNlk6suT7SNUo4oJwNZwh
         NtAoUd40FZX3fLXXfJ40t4YquCxEP5RkBRwSAEuP++bAnsJ9o2BzCEtNYQPZkAQXDhY0
         jg64vH8WdF3yeXNi2XmcuUsZxQ0Zxq1qVWW999Ro9RktAaTIPuhIfrZ+FqevFmhxrhUn
         uBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890549; x=1769495349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PemvynWJoEEr+vQfljTmIKiSnjimqG0bkRw68R0p5Rk=;
        b=bnMqxnw6K1XbGqa6ZAjVfr4I7v27sJJ3Xgw25O7AWRuE2oXXO8exT5vsKqB1uExqJp
         o+a7FzFpDh4WPbaypZp74OHxP2oD7etW0986/h3TM3UoGeEoLsyq+sNKmjH8HIeOm+ay
         82uQuiVonhdIJdydWBCjfKpcpwN2glLyBHZjXIb88QHGlcbIC4F3Tpx63SgjBous0OqP
         oDVfPF8uQ5yCTO6VJd9SsX3GQIFXpaoVi2cyULREhhx9tzLKAhBQY+hxxQuEeMAS0ivF
         XiDqRB+YEa9hbPUcxU11LMfx6VG/xrW9j7Yi3QVARF9b6kHNlrJryUhMTg2E3Tbaa9mT
         t8oA==
X-Forwarded-Encrypted: i=1; AJvYcCXRFyVYmD2171H45YZPPV+vs7N8kLMNHdPZ5o7A8yqs/jFdZyrPDbzu8IOZbJMOMPOXu3TSvvEW2cfocHauPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx10Dt7MpENrHYLBa0KvlTIu+hykhg7jYZ6XZUnfLPaIhwmmVM
	KmVszYewF7YvAgfUHH24xbhF8vU7MvVVnIprSGFWOFgVqhe7gz1Mk1lV
X-Gm-Gg: AZuq6aIL+n76hyzNFfZ8bAmAIRsPxXLcFtiyEZx9G7yofQ3ZcgCp/JmShsubo3rOPUy
	rOm2sks0DcPxw0JjDPY0h12TuPkBjQdM/yyvpU0MCR14bJnvicbDPufBXaaHmIyAPsZF1QOCUCi
	F46jewLmRkmu1vSRNKg0FF4Q8DeEgpl0/b6Z+NtcL9ZjjlMGbzOlZdbsxc0DwPqqLumjvB9Lp+u
	aPw55k4Zhem2+VMpw8gABYOYKHTgIjDvHxXFKUM6ePcSpTw+yiURJiaGN708xcUIynuc+g6RIOB
	j8PleyMhz4v7U8MnLiv6TDKeDTp2/at2WtnYE/La6UypPsDcOoqSRAvUcyqnG4N7WPmkxtf1X7T
	27ivBlMIS+FosQxsPFEKap4k8jhm3+VWPA7z0YEjkDtps8VR7oOoH7MmBoRbu2l0skiczakEFVc
	W3b8VNG05nUMRuqrxxyDM4kn8iexA/DDzZ89oMqCq10AOgUliTe3QhEWjbuy4H
X-Received: by 2002:a05:693c:4096:b0:2b7:108:40a4 with SMTP id 5a478bee46e88-2b701084a6bmr223705eec.14.1768890549004;
        Mon, 19 Jan 2026 22:29:09 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:08 -0800 (PST)
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
Subject: [PATCH 09/11] wifi: mt76: mt7925: fix MLO roaming and ROC setup issues
Date: Mon, 19 Jan 2026 22:28:52 -0800
Message-ID: <20260120062854.126501-10-zac@zacbowling.com>
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

Fix two issues related to MLO roaming and remain-on-channel operations:

1. Key removal failure during MLO roaming:

During MLO roaming, key removal can fail because the WCID (wireless client
ID) is already cleaned up before the key removal operation completes.

When roaming between APs in an MLO setup:
- mac80211 triggers sta_state changes
- mt7925_mac_link_sta_remove() is called for the old link
- WCID is cleared via mt76_wcid_cleanup()
- Later, key removal MCU command uses the now-invalid WCID

Fix by checking if the WCID is still valid before sending key removal
commands to firmware. If the WCID has already been cleaned up, skip
the MCU command since the firmware has already removed the keys.

2. Kernel warning in MLO ROC setup:

When starting a remain-on-channel operation in MLO mode, the driver
passes incorrect parameters to mt7925_mcu_set_roc(), causing a kernel
warning about invalid chanctx usage.

Fix by checking for valid chanctx and link configuration before
setting up ROC, and use the correct link_id from the vif when
available.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  9 ++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 20 +++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 5f8a28d5ff72..81373e479abd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -605,8 +605,15 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
 
-	if (!link_conf || !mconf || !mlink)
+	if (!link_conf || !mconf || !mlink) {
+		/* During MLO roaming, link state may be torn down before
+		 * mac80211 requests key removal. If removing a key and
+		 * the link is already gone, consider it successfully removed.
+		 */
+		if (cmd != SET_KEY)
+			return 0;
 		return -EINVAL;
+	}
 
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1c58b0be2be4..6f7fc1b9a440 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1342,15 +1342,23 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 	for (i = 0; i < ARRAY_SIZE(links); i++) {
 		links[i].id = i ? __ffs(~BIT(mconf->link_id) & sel_links) :
 				 mconf->link_id;
+
 		link_conf = mt792x_vif_to_bss_conf(vif, links[i].id);
-		if (WARN_ON_ONCE(!link_conf))
-			return -EPERM;
+		if (!link_conf)
+			return -ENOLINK;
 
 		links[i].chan = link_conf->chanreq.oper.chan;
-		if (WARN_ON_ONCE(!links[i].chan))
-			return -EPERM;
+		if (!links[i].chan)
+			/* Channel not configured yet - this can happen during
+			 * MLO AP setup when links are being added sequentially.
+			 * Return -ENOLINK to indicate link not ready.
+			 */
+			return -ENOLINK;
 
 		links[i].mconf = mt792x_vif_to_link(mvif, links[i].id);
+		if (!links[i].mconf)
+			return -ENOLINK;
+
 		links[i].tag = links[i].id == mconf->link_id ?
 			       UNI_ROC_ACQUIRE : UNI_ROC_SUB_LINK;
 
@@ -1364,8 +1372,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 		type = MT7925_ROC_REQ_JOIN;
 
 	for (i = 0; i < ARRAY_SIZE(links) && i < hweight16(vif->active_links); i++) {
-		if (WARN_ON_ONCE(!links[i].mconf || !links[i].chan))
-			continue;
+		if (!links[i].mconf || !links[i].chan)
+			return -ENOLINK;
 
 		chan = links[i].chan;
 		center_ch = ieee80211_frequency_to_channel(chan->center_freq);
-- 
2.52.0


