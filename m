Return-Path: <linux-wireless+bounces-6562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D00568AA9B4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F551F229F2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BEB4087F;
	Fri, 19 Apr 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="niHti/pR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53E321D
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513868; cv=none; b=ObalEt3UJwjRJFx4JGrkPquLQ45agtq2NPK0Wtl1tnJZUvWSDRau4/sNeL5rQKRaw5wgRG7LF8jxgwqqGty0mxEmu16cHKB66qETpISyRn+3REKZdzfodpXbz0DSXyYI7NneTCSw5cNZnvAf92OybNWsJMGJLxlU3M23ubVtaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513868; c=relaxed/simple;
	bh=pwQoLMNiYnqPoLkIgFsB+LxJ+7PZoxXl6sDTXYI2CKo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l79CJl3aU+WuaWtlK0KOptv8REXuPgyW0lQahssyI5SH+rYF0XdIV0I1D5kHKrVhCZiqMaovIxo04WdmCy1Lngq1U8qOVGrSDprkBmDs2oWEyS6gKHsmPOKU29JnOdsUDHfMg0EvvfGHn7jJVJY+1Xo8LPjt7RVo5SF2BfT3dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=niHti/pR; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6RHQwN/XmyMZaCybuD5NUpBm9SsKHXN9amEraIrLL88=; b=niHti/pRU48Cr8plpOSOjGPLsO
	/gfNoNpDADDNw8QptPo8yK9NEDhle7bvVEHl/Y8UWCSwIrX11oOP9+4bj7agqyKNQn8MeIMxg+3IF
	CYZNcE7SFj2GVcO5D7EC7fJUCXf0xsKtMetKp6AQ1mPA1RKithpFXsdsfOK/Y4Pcpgkg=;
Received: from [2a01:599:123:e10b:9920:bcd0:407c:1305] (helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rxjEP-003Y2w-0A
	for linux-wireless@vger.kernel.org;
	Fri, 19 Apr 2024 10:04:25 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: make const arrays in functions static
Date: Fri, 19 Apr 2024 10:04:18 +0200
Message-ID: <20240419080418.12980-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduces size by avoiding duplicates

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5650f1bb8742..18ba20cf4bd0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1193,7 +1193,7 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
-	const u8 matrix[4][4] = {
+	static const u8 matrix[4][4] = {
 		{0, 0, 0, 0},
 		{1, 1, 0, 0},	/* 2x1, 2x2, 2x3, 2x4 */
 		{2, 4, 4, 0},	/* 3x1, 3x2, 3x3, 3x4 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8b4ce32a2cd1..6a3a448db75a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1100,12 +1100,12 @@ int mt7921_mcu_config_sniffer(struct mt792x_vif *vif,
 {
 	struct cfg80211_chan_def *chandef = &ctx->def;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
-	const u8 ch_band[] = {
+	static const u8 ch_band[] = {
 		[NL80211_BAND_2GHZ] = 1,
 		[NL80211_BAND_5GHZ] = 2,
 		[NL80211_BAND_6GHZ] = 3,
 	};
-	const u8 ch_width[] = {
+	static const u8 ch_width[] = {
 		[NL80211_CHAN_WIDTH_20_NOHT] = 0,
 		[NL80211_CHAN_WIDTH_20] = 0,
 		[NL80211_CHAN_WIDTH_40] = 0,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index bd37cb8d734b..652a9accc43c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1768,12 +1768,12 @@ int mt7925_mcu_config_sniffer(struct mt792x_vif *vif,
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &mphy->chandef;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
 
-	const u8 ch_band[] = {
+	static const u8 ch_band[] = {
 		[NL80211_BAND_2GHZ] = 1,
 		[NL80211_BAND_5GHZ] = 2,
 		[NL80211_BAND_6GHZ] = 3,
 	};
-	const u8 ch_width[] = {
+	static const u8 ch_width[] = {
 		[NL80211_CHAN_WIDTH_20_NOHT] = 0,
 		[NL80211_CHAN_WIDTH_20] = 0,
 		[NL80211_CHAN_WIDTH_40] = 0,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 338ff10b121d..21373bd2a813 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -450,7 +450,7 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	const u8 mq_to_aci[] = {
+	static const u8 mq_to_aci[] = {
 		[IEEE80211_AC_VO] = 3,
 		[IEEE80211_AC_VI] = 2,
 		[IEEE80211_AC_BE] = 0,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 4f8e656b2cae..4bd74e182973 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1656,7 +1656,7 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
-	const u8 matrix[4][4] = {
+	static const u8 matrix[4][4] = {
 		{0, 0, 0, 0},
 		{1, 1, 0, 0},	/* 2x1, 2x2, 2x3, 2x4 */
 		{2, 4, 4, 0},	/* 3x1, 3x2, 3x3, 3x4 */
-- 
2.44.0


