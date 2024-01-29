Return-Path: <linux-wireless+bounces-2686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0318412A6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35990B24FF6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F38515A480;
	Mon, 29 Jan 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mAtCiNvx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE03E159576
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553685; cv=none; b=dxc91w1XBb7owBiw6Fn6LSHhapc8A/idLq+Wq2KZTUxirPmr3Wub1gTzMqh0pLP5GUZw88WdTkS+hW6fHcDxKkRW1FSW22HxtTGiUXSvF5xOBQgV8mIDF3raXYPoVcFWo+G3SZZsHRxiwsV2xwxuXwrYyVBe+9MFVOmappyCcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553685; c=relaxed/simple;
	bh=5/bomvJ9EQtYk0rcQo2BG09UzsYsrmQTlHvsluZjqVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C28EuDzHTKksiyUruM9uF0alaHKhGhSKrKaI3bqPDb+nHzdHmLd2+6k6OhZIdJxecMCXn2+F5Dc9v0PUjkOwM4HP8jOBP2AaPFoUTaT64PXfY3jeZMN5yD7vuKhWbn7aTxUzOug1AcUS2ohr/ue+KPB/nqGwaD0pyATJTBjllXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mAtCiNvx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZLy2LnMoX4fyGybdH5A6/Eee87FXiJYJWeR4yXsBztU=;
	t=1706553682; x=1707763282; b=mAtCiNvxB94ktRVAmdEM9sRMrQZA3e+kA1sT1h0TrpQq2HV
	275wA+FdZxccbmh7ziAFBThUIIYBney3M52hQBo+PP28OnbLmbk4gYSoCxVbpPPdOdGoIzwsdmySc
	AOQmuCTM/LjSk3wa7GjZQMAvzIVY1VS2vD7c7u3eU+K9vvsba9H5R8N6MaSYb5AwzQMbgBz8saPV6
	mmZhxUR1iv0MiL1zHkgEawiMeT2fxBK+Appllo6FuRwLaYBExjTkH8Fsk49cQCvBS7bPDZ7Sh+0rz
	F+ZepcXR7D/DxH+BD6auW7HNatW2Z5FHdjd0c0XV37cF+tv52qY1iZEzj4wkWpKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZM-00000004z9N-0vP6;
	Mon, 29 Jan 2024 19:41:20 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: mac80211: refactor puncturing bitmap extraction
Date: Mon, 29 Jan 2024 19:34:45 +0100
Message-ID: <20240129194108.d9f50dcec8d0.I8b08cbc2490a734fafcce0fa0fc328211ba6f10b@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a new inline helper function to ieee80211.h to
extract the disabled subchannels bitmap from an EHT
operation element, and use that in mac80211 where
we do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 16 +++++++++++++
 net/mac80211/mlme.c       | 50 +++++++++++++--------------------------
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a70388ae3a7b..d9d2c1253157 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3189,6 +3189,22 @@ ieee80211_eht_oper_size_ok(const u8 *data, u8 len)
 	return len >= needed;
 }
 
+/* must validate ieee80211_eht_oper_size_ok() first */
+static inline u16
+ieee80211_eht_oper_dis_subchan_bitmap(const struct ieee80211_eht_operation *eht_oper)
+{
+	const struct ieee80211_eht_operation_info *info =
+		(const void *)eht_oper->optional;
+
+	if (!(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT))
+		return 0;
+
+	if (!(eht_oper->params & IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
+		return 0;
+
+	return get_unaligned_le16(info->optional);
+}
+
 #define IEEE80211_BW_IND_DIS_SUBCH_PRESENT	BIT(1)
 
 struct ieee80211_bandwidth_indication {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ffa0909597cc..03919bb36e2d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -813,36 +813,27 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (conn->mode >= IEEE80211_CONN_MODE_EHT) {
-		const struct ieee80211_eht_operation *eht_oper;
+		u16 bitmap;
 
-		eht_oper = elems->eht_operation;
-
-		if (WARN_ON_ONCE(!eht_oper)) {
+		if (WARN_ON_ONCE(!elems->eht_operation)) {
 			ret = -EINVAL;
 			goto free;
 		}
 
-		if (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT &&
-		    eht_oper->params & IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT) {
-			const struct ieee80211_eht_operation_info *info =
-				(void *)eht_oper->optional;
-			const u8 *disable_subchannel_bitmap = info->optional;
-			u16 bitmap;
+		bitmap = ieee80211_eht_oper_dis_subchan_bitmap(elems->eht_operation);
 
-			bitmap = get_unaligned_le16(disable_subchannel_bitmap);
-			if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
-								      &ap_chandef) ||
-			    (bitmap &&
-			     ieee80211_hw_check(&local->hw, DISALLOW_PUNCTURING))) {
-				conn->mode = IEEE80211_CONN_MODE_HE;
-				conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
-						       conn->bw_limit,
-						       IEEE80211_CONN_BW_LIMIT_160);
-				sdata_info(sdata,
-					   "AP has invalid/unsupported puncturing, disabling EHT\n");
-			}
-			/* FIXME: store puncturing bitmap */
+		if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
+							      &ap_chandef) ||
+		    (bitmap &&
+		     ieee80211_hw_check(&local->hw, DISALLOW_PUNCTURING))) {
+			conn->mode = IEEE80211_CONN_MODE_HE;
+			conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+					       conn->bw_limit,
+					       IEEE80211_CONN_BW_LIMIT_160);
+			sdata_info(sdata,
+				   "AP has invalid/unsupported puncturing, disabling EHT\n");
 		}
+		/* FIXME: store puncturing bitmap */
 	}
 
 	/* the mode can only decrease, so this must terminate */
@@ -5881,18 +5872,9 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
 					u64 *changed)
 {
 	struct ieee80211_local *local = link->sdata->local;
-	u16 bitmap = 0, extracted;
-
-	if ((eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
-	    (eht_oper->params &
-	     IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT)) {
-		const struct ieee80211_eht_operation_info *info =
-			(void *)eht_oper->optional;
-		const u8 *disable_subchannel_bitmap = info->optional;
-
-		bitmap = get_unaligned_le16(disable_subchannel_bitmap);
-	}
+	u16 bitmap, extracted;
 
+	bitmap = ieee80211_eht_oper_dis_subchan_bitmap(eht_oper);
 	extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
 						     &link->conf->chanreq.oper,
 						     bitmap);
-- 
2.43.0


