Return-Path: <linux-wireless+bounces-13393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361AC98C9B7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 01:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D121C2265D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 23:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630E1CF5D7;
	Tue,  1 Oct 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIfI3nL3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27C1BFDFE;
	Tue,  1 Oct 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727827178; cv=none; b=htXOvv9D33Ka0r3omxLZWlQlB9+o4E/0+iOL48ZyUorApO5ZgQJiNfWnnthgMo83ER/lx2GipO+c3oP0WgXH8YbuCsCYPdlum96pxH06MTUwlcGkQ9jp7sInWvFUyeUQXUDTtF2CUSydzy/FQzrPUUFELVjpzByZp3LDIHqb39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727827178; c=relaxed/simple;
	bh=aU/DSpJSbZpqdEffBjFrNS5hGBdv/lZCHpo07LS88Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TfdO+ZawjJs0kwjEl+v55sLFO2XYhFABhmsLzqR5w+OwaHITD5RGKO0hCvcuSu2Y+Hyb07DhmHnOrxiTHMl59MvQuaFsDsb7WwzualGUUoAx3N/hKHdvkQoSiaE9qI5vR0bxfg9OJUKrf/Cq0a+9R0REj5HDMj9qQDLynZXjaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIfI3nL3; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-6cb7f5f9fb7so6031666d6.1;
        Tue, 01 Oct 2024 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727827175; x=1728431975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIMVYLwIXxHJcv25n73ufbkJ6K09NM55kcrxLf+k2D0=;
        b=XIfI3nL3/+sW0n2sWHXFNobMpYywlz1KV3Dbwcu69lVnB5WTnkNr3UHk96agUCY+LJ
         xJgKIR20915smfCaY0LHachfSQWs+4X3gdSmNHFrWycfhcFC38eD3L+cTZzUPdelAtVI
         ieqSSa/OPYxpOGaE0SkWEq7XDViaVSDl0fio1y2tm5XEwL2ldV8YKru34JIww4sS7pvZ
         yY43c5AeCsuTUpgfK62dHXuB0FAfRQkzs3UqxpXoW3khW6eLYksmJgcpCnZzVhB2dO3g
         KVh2ogouleYq0rSWDenxe7enzvdHRodnZUUOUol/j+5UzwmU+MAgUwMfmkYMr6JLKVAy
         aoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727827175; x=1728431975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIMVYLwIXxHJcv25n73ufbkJ6K09NM55kcrxLf+k2D0=;
        b=ZL1j/DQl4CfUw3o0chi2JEYxIEbRYEy7rwyRFVIPTNksV1QS9LBrrsnnqgX6W8TgHA
         liaDxec6gAvnbrxNTWdTatM0+Hp9arIF9aBQAOGbKt/rHbTKr+0apUXhpDriLZw6CouC
         oo69uW7GYzkEO6vh44eWVQT9OJYkbTFc3vjaPFPHHCpE9ldSVSzQa7/QeQcxNhfXhjQ3
         vZq5alNaXVx3+duW+Knk9SdkH+/PIAaQMNYWwt0hBvtmKAJxWLt31MGyc3q4BlfvYtA4
         gykWIyh9HyDzoMoMHi805rKk910+CfYRAYTpf4TOyAy+gsiNblXgU5qRZg3QxKsGTji1
         KhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtA87wE0wTuMxYLMkRbXphauCTspyZSx0r0fCk7QDEOe2Ell5vB7JMKbOfcVgwvmpWhxn2GZOSgINwRNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgfv749yHA7E2myaTGRT8C4r6lIdxWXx3m6iBgxycSUPzd3P5j
	OnUxmQZnnQobcx0bw2VtjDvfIJUgaEXCm3DUDeOr3Crv+/I7bnL/
X-Google-Smtp-Source: AGHT+IFRGDetIIOogdXr7hM3QGLlkwxkKdUDQzBEOwXFyl/7/DUQTfRZKup3mPRitlBLh6GpQHzd2Q==
X-Received: by 2002:a05:6214:3a83:b0:6c7:c668:17fd with SMTP id 6a1803df08f44-6cb819dcd4cmr17609316d6.1.1727827175399;
        Tue, 01 Oct 2024 16:59:35 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b66d0d5sm55104956d6.81.2024.10.01.16.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:59:34 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johannes.berg@intel.com,
	quic_adisi@quicinc.com,
	deren.wu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	allen.ye@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	Bo.Jiao@mediatek.com,
	evelyn.tsai@mediatek.com,
	meichia.chiu@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	zzjas98@gmail.com,
	chenyuan0y@gmail.com,
	Gax-c <zichenxie0106@gmail.com>
Subject: [PATCH] wifi: mt76: Fix NULL Dereference caused by mt76_connac_get_he_phy_cap()
Date: Tue,  1 Oct 2024 18:59:08 -0500
Message-Id: <20241001235908.19431-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt76_connac_get_he_phy_cap() may return a NULL pointer,
leading to NULL Pointer Dereference.
Add a NULL check for the returned pointer.

Fixes: a5c372f77aa7 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS")
Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy utilities")
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Reported-by: Zichen Xie <zichenxie0106@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 87d0dd040001..762be3a37228 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -551,6 +551,8 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	if (!cap)
+		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
 
@@ -1145,6 +1147,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
 	u8 snd_dim, sts;
 
+	if (!vc)
+		return;
+
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
 
 	mt7915_mcu_sta_sounding_rate(bf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 748ea6adbc6b..55e4cda2f20f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2508,6 +2508,8 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
+	if (!cap)
+		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 6c445a9dbc03..55bb2d0e67e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -798,6 +798,8 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	if (!cap)
+		return;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
-- 
2.25.1


