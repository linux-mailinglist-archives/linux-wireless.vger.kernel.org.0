Return-Path: <linux-wireless+bounces-33805-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLm0Ew1mw2nLqgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33805-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:35:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D631FB22
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 824A73041BFF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 04:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EDA2F9985;
	Wed, 25 Mar 2026 04:33:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354426A0C7
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774413215; cv=none; b=WYQD+i36c+6S/O8cfb8iMm9PYbbBBm8FiJU6xDnTAW8+xxP4Jvrrag+sWs+nZK1xGeAFBmEAnnJpIBDu7i5ecQjxUCivKq/ptI8El4m2t9jqfiQFO9f4GPQlI/i2jMk7btcPckgaefBW+lUKfdJG2ExXndmkn2uLe43x1Tr025U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774413215; c=relaxed/simple;
	bh=yHvC8IeWJQT/tcSiEcB7uXkcaYO5COCS6xoG3cqQUN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpn25xqFKJqVAsru7641ixPB0dvSnvn1y88woCP94Sph9bUxU+Fgq1CdQ92+7IZzOu9DTZCrrNYoqNYtgn5/CVJSj+lNIDs1bKLUhLHoPZnLuDRdTnldsYKzYH2AuuGam/CMbyDvoRB8er8rufkq80MWXmCUOHgFEatDBUF5A6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79ab3e26cceso20102157b3.3
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 21:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774413213; x=1775018013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ika1/FjTxLuXkdWOoIqmABi9uDJ406BAjclKCV4m4/4=;
        b=fKiDiBXS3VnGe8EHQjuRkZyM7/I+OCrAJe3oPj+PysBF69UJ2HbSKPC5XwlY8qPReQ
         nGjhZFeuoUKlKS3EUlylsl+rsMVpfFRo8odvGVgRRBq82/vZGC96bIsmW+XGpUMsu3Kk
         3BCcsLigMT9yU31Fp07er7/wGaK+pXbB1vFjs5soUoVBR8FebHGr5LRBLzSWF2RZLwoD
         yD3Y/Wc9O3P7XBjM9m54xSxzLdXnANrdjAhtlLKQeXBuIC1WnprgQk1EfDyYiUbHnCJL
         MLl7KuVV17CHZy8xuh0gI8g/wq3M/y81TNfYuMdPqa9WS+GAL++pxB6vXp8cIP4O2HB8
         oKsg==
X-Gm-Message-State: AOJu0YzQHXZlpVMG1+oVNSpYOxiw8aupQh9znytJYdiwbOTy7qyOSeGj
	kyJiBszLrsz2Jv4rNrlh8vzjbLGXXMfDOw2Xw+G21gtI2RMRsh1Emevayfl2ew==
X-Gm-Gg: ATEYQzyFuKlWy9eLQe7b/XluILcA5c0P8rbKdVT8nyJAkMQCOOyEP6YRmnCDYlrnmO1
	Q5eF98PdaFDVPHtn6jERnFlGeFZLkWdGSpBYVfbQ+4pN6Q9aAJyDMrHYnyBNcklvhggKcTfLyQE
	oxwWrAGaQuo8JU/IHKKDJdGcB0taZdy98UIh9HEnHnfTB2gK502K0qs2AwC2kL6/ORdLcqcTc3P
	06UEoA+Qc91npIr/FVMZoWFm3DiDocLl47gZFtdO1ABrRuesVminueofZWCnJQ2S4L8UHD+v/EA
	Q5rc17tq/asOvWJwZTXT9R8tzXYbd/Qfxtr7d/WaOfWAxTgoVoEUxuEUiEw2tR5k2ThtHL8q2Bv
	sxV04x9EvqwAmOek1FU/Zjfa/EZHAYgU/IbCKkc9v6f6PoxS72YBPCu+iWsHvA4sLCISjg+jcn8
	P4d2Su9o8I3cyGelvHlTRNd8CbONcIsvXc+mt8fqCQFPJu4/iBkGSfloZ7MEaEfkI=
X-Received: by 2002:a05:690c:17:b0:79a:c98d:2ba8 with SMTP id 00721157ae682-79acf77aadbmr23290287b3.62.1774413213013;
        Tue, 24 Mar 2026 21:33:33 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:3916:ec63:baa5:b5f0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903e0b8csm82707977b3.12.2026.03.24.21.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 21:33:32 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt792x: report txpower for the requested vif link
Date: Tue, 24 Mar 2026 23:33:18 -0500
Message-ID: <20260325043318.13298-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325043318.13298-1-sean.wang@kernel.org>
References: <20260325043318.13298-1-sean.wang@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33805-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF7D631FB22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Wang <sean.wang@mediatek.com>

mt792x currently reports txpower from the generic PHY cached state,
which may not match the requested vif/link context.

Resolve the requested link channel and derive txpower from that channel
instead, with fallback to the current PHY chandef if no valid chanctx is
available.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
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


