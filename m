Return-Path: <linux-wireless+bounces-2716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F030841333
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FB4288985
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5F7602E;
	Mon, 29 Jan 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cKeYiBpH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6796F09F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556054; cv=none; b=tLY6wPvQnvVC65H7QMzHM5kTllZJh0ndeOYmpYi2o+BcU35QVTZ9AnMxC53IwCvjvHWJoMLKOSL98JRD0Zuzx5hcY6w+zniMrYjvB143ysRLvzlMS+wdWBTPzFpz3lIZYq6ERf7QTkDZDARXkVk2V/0BQXNHqHLACtPnL9EnHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556054; c=relaxed/simple;
	bh=DdccU4LloNE8+ScQATyMTytjSAQAHFzzw7zsaQkJO9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlVZdHgzPaIAah4YRaFcA4KsA2ni8a6ZsvxyuoHiqegaEtoohmb2TDdku8XPqv4f2BfEFT1+ouLMK7Jv8kYFj/tDx1EZq2sooqfsuGSyMP3ZpV11F0LFiFnkFVK8cLoEwMjt3ZOzdxCEcImOe+c0mA5TG1StFnWaYfKxo2MrOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cKeYiBpH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XJF9ZfKa0m7eSMrrIOWsG9whT+kdvwjhGEhT9Pl8nOE=;
	t=1706556052; x=1707765652; b=cKeYiBpHh/15Jp7W/VlpuVUa7UQYvnPWImp4wlB3b41URen
	WB2rNXYzDeoEeQjK0D9+YJIkAzwmNwCEjh1lCxjWEfB1HMm+XsAh9vXlr+Y6m663KIQWSbxST1Mms
	eVb5wvcp8wY/K27wzR9x31ff2Pwf+GEX1HngDy/tV4GcfuiMFxuPZmFfnBbBwf5Qx/9fiVBI3dV0b
	Lv4u3eEZS1hGacXqMyt7MG3Mmk2mlSPfLK7+WuKONH0adAd/emTw0cgZ9+cpwnELlEimvrREmDdTF
	85fPQ+QWku8QgpTyUWrt+ewA5h2BO2n/+Wnwzk89aIRfkJNYSIxEfQme0hID0ZHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBV-000000050Z6-3Wxx;
	Mon, 29 Jan 2024 20:20:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/10] wifi: mac80211: limit HE RU capabilities when limiting bandwidth
Date: Mon, 29 Jan 2024 20:19:29 +0100
Message-ID: <20240129202041.34be99efca25.I02a695961bc6aadd37768b17c50fcdec4427d460@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129192041.58481-12-johannes@sipsolutions.net>
References: <20240129192041.58481-12-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When limiting a station's supported bandwidth while connecting,
also limit various other HE capabilities according to the bandwidth
needed for them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 5224c22b1afc..c2fe9aece00d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3300,17 +3300,48 @@ ieee80211_get_adjusted_he_cap(const struct ieee80211_conn_settings *conn,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      struct ieee80211_he_cap_elem *elem)
 {
+	u8 ru_limit, max_ru;
+
 	*elem = he_cap->he_cap_elem;
 
-	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_40)
+	switch (conn->bw_limit) {
+	case IEEE80211_CONN_BW_LIMIT_20:
+		ru_limit = IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_242;
+		break;
+	case IEEE80211_CONN_BW_LIMIT_40:
+		ru_limit = IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_484;
+		break;
+	case IEEE80211_CONN_BW_LIMIT_80:
+		ru_limit = IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_996;
+		break;
+	default:
+		ru_limit = IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_2x996;
+		break;
+	}
+
+	max_ru = elem->phy_cap_info[8] & IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_MASK;
+	max_ru = min(max_ru, ru_limit);
+	elem->phy_cap_info[8] &= ~IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_MASK;
+	elem->phy_cap_info[8] |= max_ru;
+
+	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_40) {
 		elem->phy_cap_info[0] &=
 			~(IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G);
+		elem->phy_cap_info[9] &=
+			~IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM;
+	}
 
-	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_160)
+	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_160) {
 		elem->phy_cap_info[0] &=
 			~(IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
 			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G);
+		elem->phy_cap_info[5] &=
+			~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
+		elem->phy_cap_info[7] &=
+			~(IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
+			  IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ);
+	}
 }
 
 u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
-- 
2.43.0


