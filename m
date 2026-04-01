Return-Path: <linux-wireless+bounces-34284-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH3lBetjzWkHdAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34284-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 20:28:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C237F44F
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 20:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F215301DCC7
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E802E0B58;
	Wed,  1 Apr 2026 18:23:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC633A9CF
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067823; cv=none; b=ndJk05zWDuj5RhltFGCZdlckh/3rlf4CG5wF6cIw9zL6aJMNlWuKY55/6ftGAZbAZM/zhKn0HVmJ1a5v95ai42fyvhg7jykazTBO8CsqpX8TIpPhsKNG3Tk3bbbCi8IZJhG+ey1HU/F/YebKi2WT+VqF6okIJmofNdrWkQuyyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067823; c=relaxed/simple;
	bh=zY9d1jd0STEyvIps2ic0MFxCDArLjIShdxxSXHa19Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKXYRiD8F83tJnO+E58B9wD4jx73cR0N1olBQx/LO43ScwJNf0IXuf5HpHxLmKf7JeQFYMvlTjLUlTet1gc5PyP1kVrsPH528O37Ze2JCBC+iU6izsHkgRL09cp460egOvkFIrrTwvX08jpnVvKv4UV/uc9rQHSNpQG6zmTmG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4043b27ddeaso48878fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 11:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775067821; x=1775672621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3xYD9hif0mmKJi5KnGGefNn1V5fwiod+4YYIl9xrIk=;
        b=DNiR/aGMURB/NoFeJWrYx1g3gHOPkT//k6gsEQS612HhtggPzcm+D3FL+zsMsy4f91
         o5tYGfqRnyc0yEZ+T+MRn+Pt4WMUxT8Xl204J3j6wsCU8kS9XKW0G78DMwImJ8d2Fns7
         7mb/y3dc6gVoYxJZlhtaZAB8BVmOPCXpKNccxGdT22Jza574rVZ595ViMRH1OtdrXqvD
         XGJuyEXkQh0IsbwV8uFZWVGf0L2lrgnLlb2HpnIosgaMVVR0GHXHRevI/G5+UUbjO7jq
         D7EG4ZoBJZrCm919BJjihgM48lHFlv2yIYPhB7NApZEHUdyXf9nrblpBpd+nX2THkDOg
         kufA==
X-Gm-Message-State: AOJu0YxRnL6G9ciMy1rPVeQq7npDWb44aiT+Qi5pGbSi9ROaJ97iabhc
	VdU8nPvyGmqLc3Aur0uCHCfE9jR6Ucd8DOJ/Qc8aX72/LijfBqQlWC19
X-Gm-Gg: ATEYQzwcgfya4sIspNIxRfy3UXFj19G1o07FrN6wA23TjhAo1wxcp94GLV0Rc5hZvN0
	LHwGeoIXGMEilhARvBqUrsUZvx/ueYOXgrJdEx6zKyi61mtg0pQ9phgTYxwCLnSttwoprYN851Z
	zeJCDSYFzqS0A4RYZVsUZ+0Mwh4PcRJb4MUYcuct7oLDaiNQgqIT/VkWgt7Fk1j2BUzTo3N4/H5
	XaXt54q/hOHQS5NxRfxse5aMe23B9fboiRO8MqDYsOm8gfo7AbB/nB+jl/pNNfZ6VMSbqHUsprA
	GmAaPaAXTIMEpLkUj3N0QpTUsUn3hMmdMgS2oyf424LV9vzyRRfADZezXrpNKewyxY61aHASbSR
	Jz+85nxkHMDvukcfTxbRhdvfsw9ELf5QOTnFv1YHVIbCkxDWYsGr0zW4wMQ6KEb0JrTadYtnOok
	/2BeqhsM9IPnN5HnzAkEPvn3bxydOgihL0/HdmoQ4B3pe/WI8=
X-Received: by 2002:a05:6870:d29c:b0:417:c695:869c with SMTP id 586e51a60fabf-422cfeaeb79mr2545688fac.27.1775067820280;
        Wed, 01 Apr 2026 11:23:40 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c9e06sm386778fac.15.2026.04.01.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:23:39 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Devin Wittmayer <lucid_duck@justthetip.ca>,
	Satadru Pramanik <satadru@gmail.com>
Subject: [PATCH v2 3/3] wifi: mt76: mt792x: report txpower for the requested vif link
Date: Wed,  1 Apr 2026 13:23:22 -0500
Message-ID: <20260401182322.64355-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401182322.64355-1-sean.wang@kernel.org>
References: <20260401182322.64355-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mediatek.com,justthetip.ca,gmail.com];
	TAGGED_FROM(0.00)[bounces-34284-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.671];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 692C237F44F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

mt792x currently reports txpower from the generic PHY cached state,
which may not match the requested vif/link context.

Resolve the requested link channel and derive txpower from that channel
instead, with fallback to the current PHY chandef if no valid chanctx is
available.

Reported-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Closes: https://lore.kernel.org/linux-wireless/20260130215839.53270-1-lucid_duck@justthetip.ca/
Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Tested-by: Satadru Pramanik <satadru@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
- Rebased onto the latest mt76 tree
- Added Reported-by, Tested-by, Co-developed-by and Signed-off-by tags
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 41 +++++++++++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3d74fabe7408..2e7cdf8edc12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1552,7 +1552,7 @@ const struct ieee80211_ops mt7921_ops = {
 	.wake_tx_queue = mt76_wake_tx_queue,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.channel_switch_beacon = mt7921_channel_switch_beacon,
-	.get_txpower = mt76_get_txpower,
+	.get_txpower = mt792x_get_txpower,
 	.get_stats = mt792x_get_stats,
 	.get_et_sset_count = mt792x_get_et_sset_count,
 	.get_et_strings = mt792x_get_et_strings,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 73d3722739d0..53e1a93c6976 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2433,7 +2433,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.wake_tx_queue = mt76_wake_tx_queue,
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.channel_switch_beacon = mt7925_channel_switch_beacon,
-	.get_txpower = mt76_get_txpower,
+	.get_txpower = mt792x_get_txpower,
 	.get_stats = mt792x_get_stats,
 	.get_et_sset_count = mt792x_get_et_sset_count,
 	.get_et_strings = mt792x_get_et_strings,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 4ff93f2cd624..65eba18bc3a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -397,6 +397,8 @@ void mt792x_roc_timer(struct timer_list *timer);
 void mt792x_csa_timer(struct timer_list *timer);
 void mt792x_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  u32 queues, bool drop);
+int mt792x_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       unsigned int link_id, int *dbm);
 int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *link_conf,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 152cfcca2f90..3fd1be7db1f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -329,6 +329,47 @@ void mt792x_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt792x_flush);
 
+int mt792x_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       unsigned int link_id, int *dbm)
+{
+	struct mt76_power_limits limits = {};
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_channel *chan;
+	struct mt792x_bss_conf *mconf;
+	struct mt792x_vif *mvif;
+	struct mt76_phy *phy;
+	s8 max_power;
+
+	if (!vif)
+		return mt76_get_txpower(hw, vif, link_id, dbm);
+
+	mvif = (struct mt792x_vif *)vif->drv_priv;
+	phy = mvif->phy->mt76;
+
+	mt792x_mutex_acquire(mvif->phy->dev);
+
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	mconf = link_conf ? mt792x_link_conf_to_mconf(link_conf) : NULL;
+	if (mconf && mconf->mt76.ctx && mconf->mt76.ctx->def.chan)
+		chan = mconf->mt76.ctx->def.chan;
+	else
+		/* Fall back to the current PHY chandef if the requested link
+		 * does not have a valid channel context.
+		 */
+		chan = phy->chandef.chan;
+
+	mt792x_mutex_release(mvif->phy->dev);
+
+	if (!chan)
+		return -EINVAL;
+
+	max_power = mt76_connac_get_rate_power_limit(phy, chan, &limits);
+	*dbm = DIV_ROUND_UP(max_power, 2);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_get_txpower);
+
 int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *link_conf,
-- 
2.43.0


