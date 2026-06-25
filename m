Return-Path: <linux-wireless+bounces-38067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nyZWMDR0PGq/oAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:20:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D46C1F67
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:20:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38067-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38067-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD5A8300BD46
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 00:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12612757EA;
	Thu, 25 Jun 2026 00:19:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA49256D
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 00:19:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346799; cv=none; b=ukERtdVKMonPLavNfjmzJDsmIstLE24zmpFdqTZdC5peuiAkpvZEBWnc2hJi+ic2BGmBHR8BoKgzaxZEwV2UuByyExtoKbT4eR6eIgZTU0gBZgt11KXxLvjT+GLIDQgih3bFM+EU98v7R8jKLCVUyd0khKMgx9TzwrH6G6fN4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346799; c=relaxed/simple;
	bh=0o1VI/aP1YHftIUnvibYZMm8OemnsDauyEeNmRDqXWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blpKpALLcxd73SuH8nmzoJkSjhSi5Dktmb7HvJwqXOWi7rP9SMPCI+gRs3q8ND8fSHrYFi8Oss44c0NpV5r5vF9sFM3pTHkD1+6dDUux7POpIAzEskgT6eO9mLYRGwmwASCtxhdore3BHi3SWDhMoEU8YwHrQ688AOHX+VmOa88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c892a0ef503so915907a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 17:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346797; x=1782951597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sVfDZKme2Ls4NvcZIFifaI+/XMY/L4bFWt9qeHwZTb4=;
        b=aZcx3krPMmjzBT9ULke58bF/sJuph3XN589EmGCf9fcoRls7nXOQEv76vLeREemJO6
         yf1dj4ynQFLlYAjkCZidL34umQ2H4GduAReSNbtN+doMMqLejmALVd2Z54DdbKhB0jWW
         37gwiuqD0QFvdYUhiDbRdVCBZydsZi4+HnmK0yFqAiZv6bmATHXmKvzkZzUrTDTnqtqF
         QBhANjLHxpFM9ArnR5EIlAoNcamrcUO1PvC/KyxLKImKXy05qu7x1D9mNJQBXFgmsZ8+
         a9tJyD1fiakNkiZtC7G7UcpeNEqZpPyg3Abj/a+GGePEddKltyL/vQpZ6Grsw/xLzjsQ
         zXYw==
X-Forwarded-Encrypted: i=1; AFNElJ+8E570mZn9Dv6KNLhoOeTj7LvvrcL+Oa0rj15lvaeQ7p9BGsa6QueqlcdFs8VH8wrbBUpCiEtUH5j0uFpcCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+g0Ea3/xlmvZsOGvZlfxH3ecJXAA03H3OVyV0FyNP5bNBYMP
	rRf50ZxN+3I7S9VrZV0oGT42hpkXbwcAr+d2CirT22oOaAW0ImH0agSy
X-Gm-Gg: AfdE7clSwD7rBmczzFd9axNYuq4R+Bk20hfIVj1PzJuOxsq99YNHHP72u/YmJR/IFqt
	YVjL/CADTZgKXIbtILRpdVieYDNYgFU/ByEC9oEb6lHUBveb3u5CfgFvSxzNVQncOJ8UqS4NZWZ
	ijmuF6kItn76Lx4k/7DimiNzmudnSj0jtbdeTU/+ENqcfCy/etcZpPWkrmV97tKEkjsBhEA2H70
	WPTT5NtEEk1Wv+f2sfBM163YVF6bLD4qOYCQm5VxNTbb59jgLtlzeFiv7/dM1218qCuTBP4eyzg
	93Be85AV8z+JV1XXMDTLPIt2saLAev/ZM9LLxmh7zwO39PH1wT5oRktNRij618adAg3JPY8mBo8
	4AE9Aqx0vyLKvFTx0ROsYgL8IjzdX/p6Z/CbGtAnMTt9pnf8RzYu4u3OLhB/HHWzUz9oPCGC4Yo
	Em/LdMrOsbgZBAwt2NHmULb2jJevjQXUoY7kCqspB0j0T0uv5Rxk50oVeFSoG2+/qmVzRQ9efnl
	WBrhRjrA88VreVtSLwIQV8PmN9KS8lkAV4rW8s3
X-Received: by 2002:a05:6a20:6a1b:b0:3b4:b30e:1b4d with SMTP id adf61e73a8af0-3bd4afb8cdamr262712637.40.1782346796989;
        Wed, 24 Jun 2026 17:19:56 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0d10sm586839a12.21.2026.06.24.17.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:19:56 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: chengwei.yu@mediatek.com,
	yu-ching.liu@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 8/9] wifi: mt76: mt792x: build iface combinations dynamically
Date: Wed, 24 Jun 2026 19:18:33 -0500
Message-ID: <20260625001834.475094-9-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625001834.475094-1-sean.wang@kernel.org>
References: <20260625001834.475094-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38067-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:chengwei.yu@mediatek.com,m:yu-ching.liu@mediatek.com,m:jenhao.yang@mediatek.com,m:posh.sun@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B33D46C1F67

From: Sean Wang <sean.wang@mediatek.com>

Move mt792x interface combination selection into a helper and store the
selected table in mt792x device state.

This keeps the existing non-CNM and CNM combinations unchanged while
making later firmware-gated extensions add combinations without touching
the common wiphy setup path.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Co-developed-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 36 ++++++++++++++-----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 9d5a2adc81f6..73f2333c2970 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -324,6 +324,8 @@ struct mt792x_dev {
 	struct ieee80211_chanctx_conf *new_ctx;
 
 	struct ieee80211_vif *nan_vif;
+	const struct ieee80211_iface_combination *iface_combinations;
+	int n_iface_combinations;
 };
 
 static inline struct mt792x_bss_conf *
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index a0db815c27bc..ffe0bcdf1df6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -60,7 +60,7 @@ static const struct ieee80211_iface_limit if_limits_chanctx_scc[] = {
 	}
 };
 
-static const struct ieee80211_iface_combination if_comb_chanctx[] = {
+static const struct ieee80211_iface_combination if_comb_chanctx_base[] = {
 	{
 		.limits = if_limits_chanctx_mcc,
 		.n_limits = ARRAY_SIZE(if_limits_chanctx_mcc),
@@ -77,6 +77,22 @@ static const struct ieee80211_iface_combination if_comb_chanctx[] = {
 	}
 };
 
+static int mt792x_setup_iface_combinations(struct mt792x_dev *dev)
+{
+	const bool cnm = !!(dev->fw_features & MT792x_FW_CAP_CNM);
+
+	if (!cnm) {
+		dev->iface_combinations = if_comb;
+		dev->n_iface_combinations = ARRAY_SIZE(if_comb);
+		return 0;
+	}
+
+	dev->iface_combinations = if_comb_chanctx_base;
+	dev->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx_base);
+
+	return 0;
+}
+
 void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	       struct sk_buff *skb)
 {
@@ -663,6 +679,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
+	int err;
 
 	hw->queues = 4;
 	if (dev->has_eht) {
@@ -683,15 +700,17 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	hw->vif_data_size = sizeof(struct mt792x_vif);
 	hw->chanctx_data_size = sizeof(struct mt792x_chanctx);
 
-	if (dev->fw_features & MT792x_FW_CAP_CNM) {
+	if (dev->fw_features & MT792x_FW_CAP_CNM)
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-		wiphy->iface_combinations = if_comb_chanctx;
-		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx);
-	} else {
+	else
 		wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-		wiphy->iface_combinations = if_comb;
-		wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
-	}
+
+	err = mt792x_setup_iface_combinations(dev);
+	if (err)
+		return err;
+
+	wiphy->iface_combinations = dev->iface_combinations;
+	wiphy->n_iface_combinations = dev->n_iface_combinations;
 	wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
 			  WIPHY_FLAG_4ADDR_STATION);
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
@@ -699,6 +718,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				 BIT(NL80211_IFTYPE_P2P_GO) |
 				 BIT(NL80211_IFTYPE_P2P_DEVICE);
+
 	wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
 	wiphy->max_scan_ssids = 4;
 	wiphy->max_sched_scan_plan_interval =
-- 
2.43.0


