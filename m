Return-Path: <linux-wireless+bounces-30500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F37CCFE5B9
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB1E3086248
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EF9344044;
	Wed,  7 Jan 2026 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aETNiLbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE334405C
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795852; cv=none; b=hBRZJI18vTS8IJrtSQTF1xaKmM0srQ51MngUpdPEX3zdMmonUYCnXKWrc7lMmUreS/APjeyhVUdHDU8R4FVvMwK9imURWaJ57iyYubnxBvRXvvifEjPoCo2DtFFH9I18xjrr5GdklOdKhrjklJfHpBlS/c1RT3QFQ9FpmpI6QoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795852; c=relaxed/simple;
	bh=VymgVUxlPlxyHHmgb1VZpw4CfopWjDSoVz+dQT2Y5mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0e9HeNAKMwkyvf5MKziatfHnFmFkp9YnOJ0VQXH4tcjETCFvmIPqmYxKkRnugabo8CA4ajpB0g/m4h7cEixJig/JkNAirgSvL+ONT1tgRnisfyH/3w/rZP/rfh9NaAGhkeGDafRHeK4xbsDu9pAAHVKti7dc8HseF/6umNbSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aETNiLbM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L+urc99IOaSAKz8072//RI4gYo3CZvkROhdS6cQYxa8=;
	t=1767795850; x=1769005450; b=aETNiLbMkEfMEOV2CldHneQEu+GaaGJ/tGaraekvCqZWdho
	RUuqUO+bbF3kcp9y6V3G+GhXqiXnvScKLXarCUmMihJo1fidAzYPH807c+Je6lH0DPM/jPMR4++Sw
	08A0ONXwuvTGQBetqgFFfQtns/HXOy4SbdBz8iMgCnVldvtLZQ8ywglaA21OBQbLn9ts15gWuW5U+
	W/RHBvNaHYCpMlnkoMIy29wVjHims6aJDUYVOZi5aElVq9cPojwfHCDgrCBMIgHBimbfhlYDyhz1f
	qdrIhKUUDezt5WBq9sJcQ5pzc/aPyGMWsSEjxM19m0N8LVs+CHbZidDYkrLwlyJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSF-00000005agF-3BCn;
	Wed, 07 Jan 2026 15:24:07 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 38/46] wifi: mac80211_hwsim: add NAN_DATA interface limits
Date: Wed,  7 Jan 2026 15:22:37 +0100
Message-ID: <20260107152325.7a0cd3923cca.I261b782e5c198726b9465815d59ce037f094784d@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Increase interface limits for NAN_DATA interface.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_i.h    | 4 ++--
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index a42f94dd6d6a..9df5aec7e7a4 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  */
 
 #ifndef __MAC80211_HWSIM_I_H
@@ -39,7 +39,7 @@ struct mac80211_hwsim_data {
 	struct ieee80211_channel channels_s1g[HWSIM_NUM_S1G_CHANNELS_US];
 	struct ieee80211_rate rates[HWSIM_NUM_RATES];
 	struct ieee80211_iface_combination if_combination;
-	struct ieee80211_iface_limit if_limits[4];
+	struct ieee80211_iface_limit if_limits[5];
 	int n_if_limits;
 	/* Storage space for channels, etc. */
 	struct mac80211_hwsim_phy_data *phy_data;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index abed66633279..75bdb46785dc 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2025 Intel Corporation
+ * Copyright (C) 2018 - 2026 Intel Corporation
  */
 
 /*
@@ -5291,6 +5291,12 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		spin_lock_init(&data->nan.state_lock);
 	}
 
+	if (param->iftypes & BIT(NL80211_IFTYPE_NAN_DATA)) {
+		data->if_limits[n_limits].max = 2;
+		data->if_limits[n_limits].types = BIT(NL80211_IFTYPE_NAN_DATA);
+		n_limits++;
+	}
+
 	data->if_combination.radar_detect_widths =
 				BIT(NL80211_CHAN_WIDTH_5) |
 				BIT(NL80211_CHAN_WIDTH_10) |
-- 
2.52.0


