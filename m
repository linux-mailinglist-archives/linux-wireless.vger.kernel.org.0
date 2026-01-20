Return-Path: <linux-wireless+bounces-31031-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBUvIn3wb2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31031-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:15:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 333CB4C139
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 22:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D227962DC33
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951B3AA183;
	Tue, 20 Jan 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD+hpThh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31923A900C
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939867; cv=none; b=hrkFC+Z1vycjhPsrEhayLzGETxweGYhkVjc8C4YcY91OG50TnyjwqsZGwdPm9lJ/3i2pIeDYJHP7uZDauESE3Cd+OCkbrLsnsA44GpYin0h+iWhjHs54oaxu8cIgEsMT5ObvgSIBw4z2CIkgbBTc+kCP93LetELGWYJBN0BJ+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939867; c=relaxed/simple;
	bh=/IefA+8JdDclRON4a/9CGbkJdy6uMN9aANZxEW2BTdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkmNHSyA+L1oqskcJPQRDwUCk+P4c4h/3Hyk8bGL2hUvPuEv5joMZHPxPHZAbu/hHyyCanhaKwea1x2dgY282KLeBWzF4be+d+N3GXqkXGvhT2mfF4zRF/c9V+zcbd/z5vPFVxKRUb4JC4SIjKheBg9+81rTDV27R+BY4S6WN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD+hpThh; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233702afd3so7451039c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939861; x=1769544661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT0PDrEpagMr6lAPteYD4f8kUJ9U66WD57A1dqEsIkg=;
        b=dD+hpThh5RR7Y7+sPlJ9ZqunZpyWUcAdH6zJcrkAATKoMhcbQV4yZXcz2ALuOWdDMG
         IW66PUo8MqXmJia/w6M7wUn3Ck72oP1rjevhj80rcluhO9NubWjpKdCmfXAPSLys9Ad+
         s+z8LyAsfiaSjJdPCzM/vKfACAuZXqFNZsJ8Y/Xi6HeVuUBMxGbWG8mBPuD6hAtK4SAL
         TyzBZaOa4Y1A9eZPqFOgk1paDmgbvicDItQPTWsvcgrER5denAqvawjduArfWI0Qm+hF
         6Z3wV9VztaMP/4WWptmzkJmk+0UxiQPdTgDa81ntSbssvSwhu7oor8+sY0yb+8zM4x0T
         2GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939861; x=1769544661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT0PDrEpagMr6lAPteYD4f8kUJ9U66WD57A1dqEsIkg=;
        b=ZTpNg2KVUES/8EBBEPq0kCX0uc2CoQJ2erzR9yMuTtpxRcQ38+02/ft2UDu7+l9exC
         IGbNDdDhx39zM8nqnzGZY3U6Bba/Pb/s+OXDbPpDzb8jZDfpsJb+yEwcCrCnHDA6zuOW
         JmkGWqpzAlnuX50O6s9s0t8ptkodFnIlwL7+m7StR8l/ywMjQEmgMZ3MpwYFwnFaAjTH
         h8Y+mB429E9Yl3XW86/ggDuDhxOaasfxfEqOAQd+DLL5IblW95ArwH9FEVfx+KefuC5E
         vEuN7RV4S9pa6DSqqNdVoDPasJws7yhjlA1V7xGYUrFoD3CHKtiAuWq/QyyFco0UmB+h
         8Xxw==
X-Forwarded-Encrypted: i=1; AJvYcCV4tLk5Y0ZdUgEup2X4tzToNH5x4kAJ80Od4juAoyO+qicQ8X1CEXPZWyad7QHqvLkb6iqMHQao03rTV7aq0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpN0GRLCvxiZDjSfdz/tSTBIlUKuobrB+pLKvXebQbLQicked
	R6pIGVaUCVK0Q146kLKl/t5EmbH425vZ6f2aTj2RQlsEv4WAxk5iNY7H
X-Gm-Gg: AY/fxX75cGXBXiQk4L5MUjifeH9wJCduHHOkUmI1Q3GzfDqsoq2pCqSO9nsfXiNEYsa
	xZIZzNJuN5TRaiKeZE11oO+DnFvonrl0cUHJ8HZzZSJDtugSt2eDkjhOd0ni88qP0kuMX2HqwRS
	buehiRwmY+/PzwA50I5BImZGlgkuOyxRhfzp5OVSG7iBdFpRXaGdT4pZ0k/WMgaN/Du8DnMnu/8
	Dnek3OOpvrspfCGtuJllkLV4+JG5e4GctOr3BNXHTEDKak+rPLCRK1NfajZdAeCjNzQtfes3P0I
	rddjfmzu0AveYiE28oIipQOxzDS/wiJSnQTgFqgx84gD4n8HK1ATrhztto/n17f0YLrNlk1IsQr
	pciThPEyv4cIg7WT7Ymqy3L5PWH5tp0K+ByMc0tGJ57Ipi9QV72bV5I8+IMWneqaHAPTugCJyU7
	KPNt3XzLOBPwZ+ZO1uuoSKBVzqFywhisuyBXaPtSl/dRXXeEgZjlTpSAsO7IHr1IH0+hI/SuVq
X-Received: by 2002:a05:7022:1e03:b0:11b:9386:a387 with SMTP id a92af1059eb24-1246aacae80mr2182611c88.42.1768939860981;
        Tue, 20 Jan 2026 12:11:00 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:10:59 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH 06/13] wifi: mt76: mt7925: add comprehensive NULL pointer protection for MLO
Date: Tue, 20 Jan 2026 12:10:36 -0800
Message-ID: <20260120201043.38225-7-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120201043.38225-1-zac@zacbowling.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31031-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,zacbowling.com:email,zacbowling.com:mid]
X-Rspamd-Queue-Id: 333CB4C139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

Add NULL pointer checks for functions that return pointers to link-related
structures throughout the mt7925 driver. During MLO state transitions,
these functions can return NULL when link configuration is not synchronized.

Functions protected:
- mt792x_vif_to_bss_conf(): Returns link BSS configuration
- mt792x_vif_to_link(): Returns driver link state
- mt792x_sta_to_link(): Returns station link state

Files updated:

1. mac.c:
   - mt7925_vif_connect_iter(): Check bss_conf before use
   - mt7925_mac_sta_assoc(): Check bss_conf before use

2. main.c:
   - mt7925_set_key(): Check link_conf and mlink
   - mt7925_mac_link_sta_add(): Check link_conf and mlink
   - mt7925_mac_link_sta_assoc(): Check bss_conf and mlink
   - mt7925_mac_link_sta_remove(): Check bss_conf and mlink
   - mt7925_change_vif_links(): Check conf before use
   - mt7925_assign_vif_chanctx(): Check mconf and mlink
   - mt7925_unassign_vif_chanctx(): Check mconf and mlink
   - mt7925_mgd_prepare_tx(): Check link_conf

3. mcu.c:
   - mt7925_mcu_sta_phy_tlv(): Check link_sta
   - mt7925_mcu_sta_amsdu_tlv(): Check link_sta
   - mt7925_mcu_sta_mld_tlv(): Check link_sta
   - mt7925_mcu_sta_cmd(): Check mlink
   - mt7925_mcu_add_bss_info(): Check link_conf
   - mt7925_mcu_set_chctx(): Check link_conf and mlink

Prevents crashes during:
- BSSID roaming transitions
- MLO setup and teardown
- Hardware reset operations
- Runtime power management

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  6 ++
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 82 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 22 ++++-
 3 files changed, 97 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 871b67101976..184efe8afa10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1271,6 +1271,12 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
 		mconf = mt792x_vif_to_link(mvif, i);
 
+		/* Skip links that don't have bss_conf set up yet in mac80211.
+		 * This can happen during HW reset when link state is inconsistent.
+		 */
+		if (!bss_conf)
+			continue;
+
 		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mconf->mt76,
 					    &mvif->sta.deflink.wcid, true);
 		mt7925_mcu_set_tx(dev, bss_conf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 05990455ee7d..74a48742e234 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -608,6 +608,10 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
+
+	if (!link_conf || !mconf || !mlink)
+		return -EINVAL;
+
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
 
@@ -860,12 +864,17 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return -EINVAL;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
 	mconf = mt792x_vif_to_link(mvif, link_id);
+	if (!mconf)
+		return -EINVAL;
+
 	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
@@ -891,6 +900,8 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	if (!link_conf)
+		return -EINVAL;
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
@@ -997,18 +1008,29 @@ mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct ieee80211_bss_conf *link_conf =
-		mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
-	struct cfg80211_chan_def *chandef = &link_conf->chanreq.oper;
-	enum nl80211_band band = chandef->chan->band, secondary_band;
+	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_chan_def *chandef;
+	enum nl80211_band band, secondary_band;
+	u16 sel_links;
+	u8 secondary_link_id;
 
-	u16 sel_links = mt76_select_links(vif, 2);
-	u8 secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
+	link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+	if (!link_conf)
+		return;
+
+	chandef = &link_conf->chanreq.oper;
+	band = chandef->chan->band;
+
+	sel_links = mt76_select_links(vif, 2);
+	secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
 
 	if (!ieee80211_vif_is_mld(vif) || hweight16(sel_links) < 2)
 		return;
 
 	link_conf = mt792x_vif_to_bss_conf(vif, secondary_link_id);
+	if (!link_conf)
+		return;
+
 	secondary_band = link_conf->chanreq.oper.chan->band;
 
 	if (band == NL80211_BAND_2GHZ ||
@@ -1036,6 +1058,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -1045,12 +1069,13 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 		link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-					link_conf, link_sta, true);
+		if (mconf)
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, true);
 	}
 
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
@@ -1097,6 +1122,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return;
 
 	mt7925_roc_abort_sync(dev);
 
@@ -1110,10 +1137,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
+		if (!mconf)
+			goto out;
 
 		if (ieee80211_vif_is_mld(vif))
 			mt792x_mac_link_bss_remove(dev, mconf, mlink);
@@ -1121,6 +1150,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
 						link_sta, false);
 	}
+out:
 
 	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&mlink->wcid.poll_list))
@@ -1308,6 +1338,8 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	mt792x_mutex_acquire(dev);
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		if (!bss_conf)
+			continue;
 		mt7925_mcu_uni_bss_ps(dev, bss_conf);
 	}
 	mt792x_mutex_release(dev);
@@ -1634,6 +1666,8 @@ static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
 
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		if (!bss_conf)
+			continue;
 		__mt7925_ipv6_addr_change(hw, bss_conf, idev);
 	}
 }
@@ -1695,6 +1729,9 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    [IEEE80211_AC_BK] = 1,
 	};
 
+	if (!mconf)
+		return -EINVAL;
+
 	/* firmware uses access class index */
 	mconf->queue_params[mq_to_aci[queue]] = *params;
 
@@ -1865,6 +1902,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			if (!bss_conf)
+				continue;
 			mt7925_mcu_update_arp_filter(&dev->mt76, bss_conf);
 		}
 	}
@@ -1880,6 +1919,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 			} else if (mvif->mlo_pm_state == MT792x_MLO_CHANGED_PS) {
 				for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 					bss_conf = mt792x_vif_to_bss_conf(vif, i);
+					if (!bss_conf)
+						continue;
 					mt7925_mcu_uni_bss_ps(dev, bss_conf);
 				}
 			}
@@ -1901,7 +1942,12 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	struct ieee80211_bss_conf *link_conf;
 
 	mconf = mt792x_vif_to_link(mvif, info->link_id);
+	if (!mconf)
+		return;
+
 	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
+	if (!link_conf)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -2025,6 +2071,11 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mlink = mlinks[link_id];
 		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
+		if (!link_conf) {
+			err = -EINVAL;
+			goto free;
+		}
+
 		rcu_assign_pointer(mvif->link_conf[link_id], mconf);
 		rcu_assign_pointer(mvif->sta.link[link_id], mlink);
 
@@ -2105,9 +2156,14 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (ieee80211_vif_is_mld(vif)) {
 		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		if (!mconf) {
+			mutex_unlock(&dev->mt76.mutex);
+			return -EINVAL;
+		}
+
 		pri_link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
 
-		if (vif->type == NL80211_IFTYPE_STATION &&
+		if (pri_link_conf && vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
 			mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link_conf,
 						NULL, true);
@@ -2136,6 +2192,10 @@ static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (ieee80211_vif_is_mld(vif)) {
 		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		if (!mconf) {
+			mutex_unlock(&dev->mt76.mutex);
+			return;
+		}
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..94ec62a4538a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1087,6 +1087,8 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 		struct mt792x_link_sta *mlink;
 
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+		if (!mlink)
+			return;
 		wcid = &mlink->wcid;
 	} else {
 		wcid = &mvif->sta.deflink.wcid;
@@ -1120,6 +1122,9 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 	mconf = mt792x_vif_to_link(mvif, link_id);
 
+	if (!mlink || !mconf)
+		return -EINVAL;
+
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mconf->mt76,
 					      &mlink->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
@@ -1741,6 +1746,8 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 	amsdu->amsdu_en = true;
 
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 	mlink->wcid.amsdu = true;
 
 	switch (link_sta->agg.max_amsdu_len) {
@@ -1773,6 +1780,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 
@@ -1851,6 +1862,10 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 	band = chandef->chan->band;
@@ -1935,6 +1950,9 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 
 		mconf = mt792x_vif_to_link(mvif, i);
 		mlink = mt792x_sta_to_link(msta, i);
+		if (!mconf || !mlink)
+			continue;
+
 		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
 		mld->link[cnt++].bss_idx = mconf->mt76.idx;
 
@@ -2027,13 +2045,13 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		.rcpi = to_rcpi(rssi),
 	};
 	struct mt792x_sta *msta;
-	struct mt792x_link_sta *mlink;
+	struct mt792x_link_sta *mlink = NULL;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
-	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.wcid = (link_sta && mlink) ? &mlink->wcid : &mvif->sta.deflink.wcid;
 	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
-- 
2.52.0


