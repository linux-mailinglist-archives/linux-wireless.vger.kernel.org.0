Return-Path: <linux-wireless+bounces-3330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1C084DF4D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 12:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4668B27575
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB57762F9;
	Thu,  8 Feb 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbBX3W1y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D86F097
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390121; cv=none; b=el6hZam6fGT8MmtR6pQcbO7DgZuFob6H9qeLGY3PK0NoL4mqD6Ni/rA6f2P3llajDuTw7uMUYZR30ZKHlNJiQn6OEaGUO6+8cQaI0sNnp1wer2XPEudRQstNUrg7MJaXPvwdo8zFnTHsWFEWb7RNUH+D/gDub7h61EJM09IzJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390121; c=relaxed/simple;
	bh=dItiFEyA2KueSNhG56f3Chh7xB70o07OSUkqS9fGMtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSz3Uc9hS90tEjoNR4ziC3ddnCJp22cQG6rX+XoqkBx7MFcfhsRtBpN1d6v2orirpYMG5ca1hL1k2eBI25HxuSnWZqG3YqBT/xXOgJP2egoHGQ1UJfdT6mDvJ8kjhvBuWleBozuR14M+v1OOLaGAJh2ONaU1NXTpS1ZgzE6vtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbBX3W1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF297C43330;
	Thu,  8 Feb 2024 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707390121;
	bh=dItiFEyA2KueSNhG56f3Chh7xB70o07OSUkqS9fGMtM=;
	h=From:To:Cc:Subject:Date:From;
	b=PbBX3W1yDcAjPLgkxDF9uaB0Mgsr5KZ43QsSes8aAbE2RwUN/c/FTDf89G3inawqa
	 J4w4aL03fZbBFIWVenSLc7dTq2vA8pEltqoYHWGBiE2wu+tCWCuPEKUYFEG/hRsOSY
	 5QAbrV6WDrxXChsToh3I5Hx/Qb8TLDNd79Ly2npTv3+H6sw7KJxhKbGL08pZPgq0Gi
	 8rlGtNK2zaaPX/3dN8hxOUOwVWa5RDkGUCJIOXZVcyaGLvSx1j2PNGTBMEoMx8wevC
	 8xF32JT05zUhA/EfD1d8dnkJLQYX/fT186ZoE98Vdbuh0aYTJh2weYJnQkxf0UOHF9
	 YGP2O3uT/QM3w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: dan.carpenter@linaro.org,
	ath11k@lists.infradead.org,
	johannes@sipsolutions.net,
	lorenzo.bianconi@redhat.com,
	kvalo@kernel.org
Subject: [PATCH wireless] wifi: mac80211: remove gfp parameter from ieee80211_obss_color_collision_notify signature
Date: Thu,  8 Feb 2024 12:01:43 +0100
Message-ID: <f91e1c78896408ac556586ba8c99e4e389aeba02.1707389901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of gfp parameter from ieee80211_obss_color_collision_notify
signature since it is no longer used.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 3 +--
 include/net/mac80211.h                | 3 +--
 net/mac80211/cfg.c                    | 2 +-
 net/mac80211/rx.c                     | 3 +--
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8a65fa04b48d..ad22f8d775db 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3956,8 +3956,7 @@ ath11k_wmi_obss_color_collision_event(struct ath11k_base *ab, struct sk_buff *sk
 
 	switch (ev->evt_type) {
 	case WMI_BSS_COLOR_COLLISION_DETECTION:
-		ieee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap,
-						      GFP_KERNEL);
+		ieee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap);
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "OBSS color collision detected vdev:%d, event:%d, bitmap:%08llx\n",
 			   ev->vdev_id, ev->evt_type, ev->obss_color_bitmap);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d400fe2e8668..9cae95a0c300 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7416,11 +7416,10 @@ ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
  * @color_bitmap: a 64 bit bitmap representing the colors that the local BSS is
  *	aware of.
- * @gfp: allocation flags
  */
 void
 ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
-				      u64 color_bitmap, gfp_t gfp);
+				      u64 color_bitmap);
 
 /**
  * ieee80211_is_tx_data - check if frame is a data frame
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 327682995c92..382b4208cc6a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4749,7 +4749,7 @@ EXPORT_SYMBOL_GPL(ieee80211_color_change_finish);
 
 void
 ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
-				       u64 color_bitmap, gfp_t gfp)
+				      u64 color_bitmap)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_link_data *link = &sdata->deflink;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0bf72928ccfc..73717875e3f6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3369,8 +3369,7 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
 		if (color == bss_conf->he_bss_color.color)
 			ieee80211_obss_color_collision_notify(&rx->sdata->vif,
-							      BIT_ULL(color),
-							      GFP_ATOMIC);
+							      BIT_ULL(color));
 	}
 }
 
-- 
2.43.0


