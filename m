Return-Path: <linux-wireless+bounces-10040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ABC9291E5
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5525B282F0A
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCD4E1C8;
	Sat,  6 Jul 2024 08:29:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B471B52
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254540; cv=none; b=ilbwDucmMhEXwUyJ2eKNCe2ttmIRtKXV7vA819tQ/F642HrRrhxrQb2+b6z9AnRzmtFpRtr89R2f6EVBpOijJZck23bRLCFBjhn48ox+orZ8lrEracLeB14l9/VKt9QpWBLK6doQqm0ZMuJFeDmryD5cmVglF3aF9spbAPU+nwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254540; c=relaxed/simple;
	bh=vNZ/Cc06vcSYgmIEMKnuGI1UTPbHYkqKOEETYsLoJ+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vwg50r/pu+9FvFRnknDNxcHRjBrOFxYewbPan8EGMDuAV2FbZCR3yLCHZT3HKmZITGpQ7Z1kE7bx96TGcPN6ML4YN6Np9/sSj74Vm1epB69eDLl6rPPUwN/lVzjR3Z8oCGYgRcahE/0mY7yWd392TTgE1dLIBpXU0T1oSxQaqsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d92563bea4so14975b6e.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254537; x=1720859337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmZqqZxko2JYQVXtVLRpulxVIyqXof1xyUbUxDuvHpQ=;
        b=v5zpwZ/n/Zj3J3DC+UkBEHUQUAkRg76fJZJO4C0GO+MUOKreAopJdNLuqf1Mn+QkV6
         PwhVAcRlLLQQz0et6olKLOmUUkreEoWAAhaQkce/a6z1x76sgAwasrLU+fMHJmc3HUHH
         09M42ryecOiNWrx/NWLSvTEzTApqH2wnFOuE7N6RtZ8HQbbT/iPLTwSbVEH/FbTzkYZJ
         lnXvWcfHV5Jvnjj97pByiA25quVGv8molhODTI4IHkSYF6XEez19uWv0Uh0mEsl8icWg
         jazgeGkPUlkTy2YtqAZ5Ng8rpkrjKktgqGMobDbN/OuZ/iP0QDK4MGnv9v9sYi3EFlHL
         lQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCWRYdoQ4MAmY1Mv+y7/dikvOMeu7gI+a+ANw7C2IqYaBFnf8VtoU0bRh4e67q2+8ZM8ws487P1AMFRQQ8vruzaG18DpgFqfSGc8xkMRJkk=
X-Gm-Message-State: AOJu0YxDa6F9rTx3rZzB8cAEGehN3Q46imXlt7yoLu/zlgNiXdX9BCnq
	j/wiUD9Hq5sKPavLHcbE68x9NCtZpOMLAy6HN80Wc59TpOGnI/O/
X-Google-Smtp-Source: AGHT+IFwOST0MVMtQVt8L7b27qxOca8D10UEvbV6G/pxUhHNqHvSniuXGuirugc0in75BVkca56RgA==
X-Received: by 2002:a05:6871:24d7:b0:24f:e599:9168 with SMTP id 586e51a60fabf-25e2b8d0139mr7038261fac.1.1720254537630;
        Sat, 06 Jul 2024 01:28:57 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:56 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 21/37] wifi: mt76: mt7925: add link handling in the mt7925_ipv6_addr_change
Date: Sat,  6 Jul 2024 01:28:01 -0700
Message-Id: <ed429b1896cc10c8db25dc2ade3e59bec78d7131.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

add link handling in the mt7925_ipv6_addr_change

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 8acce16d88d6..54479c2fc167 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1490,12 +1490,12 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct inet6_dev *idev)
+static void __mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
+				      struct ieee80211_bss_conf *link_conf,
+				      struct inet6_dev *idev)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mvif->phy->dev;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct inet6_ifaddr *ifa;
 	struct sk_buff *skb;
 	u8 idx = 0;
@@ -1509,7 +1509,7 @@ static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
 		struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	} req_hdr = {
 		.hdr = {
-			.bss_idx = mvif->bss_conf.mt76.idx,
+			.bss_idx = mconf->mt76.idx,
 		},
 		.arpns = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
@@ -1544,6 +1544,23 @@ static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
 
 	ieee80211_queue_work(dev->mt76.hw, &dev->ipv6_ns_work);
 }
+
+static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif,
+				    struct inet6_dev *idev)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	unsigned long valid = ieee80211_vif_is_mld(vif) ?
+			      mvif->valid_links : BIT(0);
+	struct ieee80211_bss_conf *bss_conf;
+	int i;
+
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		__mt7925_ipv6_addr_change(hw, bss_conf, idev);
+	}
+}
+
 #endif
 
 int mt7925_set_tx_sar_pwr(struct ieee80211_hw *hw,
-- 
2.25.1


