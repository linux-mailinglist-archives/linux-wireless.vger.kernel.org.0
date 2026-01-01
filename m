Return-Path: <linux-wireless+bounces-30259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B85CECD8E
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49D2D3014BEA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF59242D9B;
	Thu,  1 Jan 2026 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuVwJM3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC5227563
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248720; cv=none; b=bDhcf/gmWXMPWJolJ95RYTEL/KKoibIFigMMiT0as9g/iD7WXSeOxt40RefFeAznA2NWwWg396qYb1ToVYfLs1l7lsaJs0LBnkwquUngMtHnd8X0fRCf1RelY9JEsuemuSCRa3dSo4q3Rel/6MpSMcykZFQ1jNoY+Jv2UzaRmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248720; c=relaxed/simple;
	bh=+w3JX7lEDErZykW5Xgcb1KQEhARVp1UUlw4uWeWGW3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGSXiTevCQRLgBR9En1iJRqZ51bNWYxyZXi8zyHrWHKRTnSYl8ZjXX+lMp01tL7Mrr+1ihPeQduS4xUrSOpDeoy0wh8NczYxuhL8Llyq8Lq/vrs2q8F8HQhCR4ytLcH7GHvHVHvPA/C+qN+8mGwvqhHcdflruDDHD5/iCvTn8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuVwJM3D; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c2dc870e194so3970779a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248718; x=1767853518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMNrli8fWuq22Lopa9PXMOKtBCB18Eukz20h2BFPXfY=;
        b=FuVwJM3D4AIU4QEFrYijtpIUTuy7xfF7OgYppg2RZOp8JZItkk4PuTJZSgsQc0PhM6
         G9b3v+bjzEI4Lc6Az+Q6KibbElJ0rRKYtY8GTdDMDkFv66zkCFxzYuZ2GJM8nlwC7qb1
         gD45/SQwa9ABpDl+90wbtfhk/eqeZ3pbSEg/gJCtBtTJbqx1I5J4hZ17i6pORv1x9AqC
         yBsa5omJlAIg1JYm8UyF6fL7PyW8FLv+s85zCIEcI/XdMEybUQBNFL1cpSZMraOZygfx
         +hqEeDeY1Wul46feQqjQog4d84fj7FU+yFhEDcMDw15NVSWguaAuINU3/JWeL3C/Pr+r
         phew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248718; x=1767853518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LMNrli8fWuq22Lopa9PXMOKtBCB18Eukz20h2BFPXfY=;
        b=iSk5m81+u+wGwoLjtLh0h5K45BQp6OZa8W8cB/rRNzywS5N9uMZUperZfcjYxjySEC
         T8b6IdIpWQQu8VShpdSQntwpcpGDm18RRI1szgh2VKZ48PDB70hPqR26kG+I/6Dy8m4P
         Moqzo9KpWq7/GR0285hmVKJGjmsnHgjsel2S/62CRQ2YKMtHXiIYViDtGM5O5kgpbner
         Dz0JIZef92eMwHbykHHv5pz05GmKL+gU25m/WYl8Px8yCQ+CBX869SNY+EmTF0Auy1QB
         zqUZpIiLNaODDUkr8nHbIolofxPSe9YsyPf7v5YrXBVI89LpCr+eBP+0o1gOpTLeMn1W
         FPjw==
X-Gm-Message-State: AOJu0YydGdWaSqx5M8LIAvvEu0CDTEwHRUIQesp6vlohagnEszFy97Ql
	xqiecqA54iB1sxeBh7opvLiq5SEeZ6KdgQ7lT2F8+KvH7x0x1oNkyYSRz4i8K2CV
X-Gm-Gg: AY/fxX5OH7cdhk4D9XEMQHxQMRyJenB6DuyuBFumBMlLJj3dj3sFXszfyzGw6n/6OLy
	27f4QTWkSgEfGbdHGuVNkGL5VQdWCwUmTNvKRW7oUepzu9SIJztSgHSApqoUouVJTT54oWr5OmJ
	PsAODukdfp7qKTGdvorcmCpxevg/Vz/FteV4fHvdXxojYCqqQmWkZEZgEwOYMjFTzfQWp64Ahrm
	X4Ai+0RnFLOFJpw99F34wTVI+jiB/vWEoHJYPYjEcxV71se1Wr2RlhXPqALeeBbNJ5kBBtXLd5r
	k4yCmctS2yet/mOBciYZmwGfheA/23sJCOqx9P5yPL907j+AyA35nowLFkWNpHS2puzxCVGyP9W
	SNAsg8OkjWASH+eQMaXwyi6l5OYALIBTjDjHM0GaNItetCZoG3XsnGPe8HfWEK7l0pKwzW7TCh0
	luuOY3Qq3xXICgt5wPTGl+GsWT0rmYLPTlV4MKz/tpP2FJmWBSLgsPJZykIUkxIg==
X-Google-Smtp-Source: AGHT+IF8c3kpymCYxXLtXHPXPOh7mPJtKHA7XR9XpNIl8rN7FB8iVPcgOKK7KP9TRQAMuRn8Gghr5A==
X-Received: by 2002:a05:7022:238f:b0:11f:3483:bbb2 with SMTP id a92af1059eb24-121722aae15mr34466776c88.12.1767248718059;
        Wed, 31 Dec 2025 22:25:18 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm147035158c88.17.2025.12.31.22.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:25:17 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: add NULL checks in MLO link and chanctx functions
Date: Wed, 31 Dec 2025 22:25:14 -0800
Message-ID: <20260101062514.186040-3-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260101062514.186040-1-zbowling@gmail.com>
References: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
 <20260101062514.186040-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Add NULL pointer checks for mconf and link_conf in several functions
that were missing validation after calling mt792x_vif_to_link() and
mt792x_vif_to_bss_conf().

Functions fixed:
- mt7925_mac_set_links(): Check both primary and secondary link_conf
  before dereferencing chanreq.oper for band selection
- mt7925_link_info_changed(): Check mconf before using it to get
  link_conf, prevents NULL dereference chain
- mt7925_assign_vif_chanctx(): Check mconf before use, return -EINVAL
  if NULL; check pri_link_conf before passing to MCU function
- mt7925_unassign_vif_chanctx(): Check mconf before dereferencing,
  return early if NULL during MLO cleanup

These functions handle MLO (Multi-Link Operation) scenarios where link
configurations may not be fully set up when called, particularly during
rapid link state transitions or error recovery paths.

Reported-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 39 +++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 058394b2e067..852cf8ff842f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1006,18 +1006,29 @@ mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
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
+
+	link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+	if (!link_conf)
+		return;
 
-	u16 sel_links = mt76_select_links(vif, 2);
-	u8 secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
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
@@ -1927,7 +1938,12 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	struct ieee80211_bss_conf *link_conf;
 
 	mconf = mt792x_vif_to_link(mvif, info->link_id);
+	if (!mconf)
+		return;
+
 	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
+	if (!link_conf)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -2136,9 +2152,14 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 
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
@@ -2167,6 +2188,10 @@ static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (ieee80211_vif_is_mld(vif)) {
 		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		if (!mconf) {
+			mutex_unlock(&dev->mt76.mutex);
+			return;
+		}
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
-- 
2.51.0


