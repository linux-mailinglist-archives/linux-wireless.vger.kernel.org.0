Return-Path: <linux-wireless+bounces-20185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18462A5CC90
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBA93B7FD9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E011EDA39;
	Tue, 11 Mar 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/BSaTEm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38741EBA1E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715130; cv=none; b=cXQod87CbSNJtN4VINb3ts5uR8yoWYIN8a4gwcc15reHxEfPLTveZmQQ70UZOHFvGUKDtWeMRW8Bz38nRUqOQSldX2CIVqaVSARu7CAjMMoi9SvYMUXUjXo+RZ8lp7F1+0wugY03NN+gAE3h/5wcUMIt8YpkZK7CrimuP8recq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715130; c=relaxed/simple;
	bh=mazpjGa8VjPIR8E7D94wthNV7G/W5waliDEdO1oOjQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jWGXy7bdJ4QdDAPPezOpoEfGq7YTvTNizqzqkI6Tcaj8u4UuEkR5UokcQmhNjNnKNMNc1ZZAU2LSc1WEOZvOAbcwRn33FbyOq1lW5wW13pxv5BivCNLxw3jM7qWUaGkFv5aefCXNS7R4o6kTEy2RvI/064l/ClMIhn/vjKc92Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/BSaTEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F7DC4CEEA;
	Tue, 11 Mar 2025 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715129;
	bh=mazpjGa8VjPIR8E7D94wthNV7G/W5waliDEdO1oOjQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D/BSaTEmQYR1+6DRannWuJr6Qm+K84XJ48t1+z6dgIq7QEXx/v/Clgz5NFct26FdN
	 YwvAJufwbqR7B7zhtWeDBefrAzRp5+ts/c8tDKEd8bmwEyEUhMzM2quTGNU8nZEQdq
	 Zj9uEz/XsHfSJQVJmna/SEhfZCGr1hGqMOty9j7yvXvqB5ftg4LbEOJRy9kK4CVzTJ
	 asr1QIaiaJqVXC92JHFpTpL2CgC8tTTzB7ILH764SgUBCMEs61lPqnfmXvmWJcwjd8
	 0gRugKBdX8+drp2sReYfdnef2MHdp3clwKdZojAsbYD55Hla6F9+ctFfrjUX2e3i3D
	 cCYlG8ytEcXkg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:04 +0100
Subject: [PATCH v2 05/13] wifi: mt76: mt7996: Add link_info_changed
 callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-5-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Convert bss_info_changed mac80211 callback in link_info_changed one.
This is a preliminary patch to enable MLO support in MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 59a1e5e52450accc5b01fbe0c3af7e84bcc87df6..81a13662db24ec268fdd7a9b3d6b1d829a91430f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -712,10 +712,9 @@ mt7996_vif_cfg_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_bss_conf *info,
-				    u64 changed)
+static void
+mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *info, u64 changed)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt76_vif_link *mvif;
@@ -1719,8 +1718,8 @@ const struct ieee80211_ops mt7996_ops = {
 	.config = mt7996_config,
 	.conf_tx = mt7996_conf_tx,
 	.configure_filter = mt7996_configure_filter,
-	.bss_info_changed = mt7996_bss_info_changed,
 	.vif_cfg_changed = mt7996_vif_cfg_changed,
+	.link_info_changed = mt7996_link_info_changed,
 	.sta_state = mt76_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.link_sta_rc_update = mt7996_sta_rc_update,

-- 
2.48.1


