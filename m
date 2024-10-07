Return-Path: <linux-wireless+bounces-13660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DEE993B40
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 01:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB0F282283
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 23:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909D17279E;
	Mon,  7 Oct 2024 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+zZYHJM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC1EEBA
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344107; cv=none; b=ddJmYxdNIqM4OS5N1TX6TvwYEa8gK5O82sBL7cR6I9H1euHh9NaaHQ8ToSkio/eceJtYnSu0dgrGpzDszOO0hrkoG+sUSd1cio97cfa/cSMX6IrHb2MzyguwrU1Kea5Rys/psHGuGKDguFbQ66Zpq4Of5+U6eDxhwcpIf4Y7a4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344107; c=relaxed/simple;
	bh=WSYIvXk0UNy5J98Dom8lQW2PIlcbbtKXcssn1rlOdjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZaAcPUSYfoL/C612IpUY4Etsg1QueQFTmaNpcc770z7nM//60SI+1fiDBqRraPcndKWU/o6wO4NWvY8FFeiX7ezsKVKle9PrI/TJyiKCRslia15ujzo7n9G6neFeVzXzqkN8vFSxg3kFtZU2z3gyFgG4N+f63uUKuossBwykM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+zZYHJM; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7a9ad8a7c63so500309585a.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728344105; x=1728948905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZJs5LgH19bZqKLp3YYHgBwHdrmt2cmJoLoGioynQiw=;
        b=Y+zZYHJM5tupY5htyzJeSpKgxodl8vZWuGazS0PGESon/emJsE/LqJwyX+6IqDl/Sy
         yw8ECAbQHotat/gBWxtGDz+ooMZhZhpatNusQgnHBHFNV6nw0PM5ECjvWfXzk+tPTCMh
         jhnS6m2a1jIkQTUGcEi5/hWRSoX2k3/74yAR4oDxuBVXwR60N+5llOPyXbNRDZytPRKr
         KeFsLW6ycZWp6rZNh+tXZE/F3SXEWyuW6/v/taKV5CqAgKss62xNGhARsdpR/HXHCltm
         WMS1NiKBLzPDnnCO/3XVazJtakm0qPhpYdIC1MeaLpqjmgFKnY8N1sEjhY2DOkDtjabl
         37GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728344105; x=1728948905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZJs5LgH19bZqKLp3YYHgBwHdrmt2cmJoLoGioynQiw=;
        b=m5YYj4IrznDsvsfMtlGiAq0NTWBC97bXxZMyYsHpTMaAHbeycPqskdwMUHuPpkKfAW
         rObVSRhmPra+c05xPvuYK4M1H/NFjMYDB+VSC5jO6RvCx/sWQrsMXuvuAT18Wbi6hfXs
         3RJvjGcMYeL1goBzrtKKPpuNNuS2mI6yOK3cnsu38r3QPoK1xWA4JtZGiUXoF4KS24h7
         tlf+kqQ7ljaOw70Z0Wtb6isEXUJNkyAJPiDSA/IXkMU0RfXqsu78pVpb1xf9LGzsP2r/
         L1fVVEPyOUwn5krZq4QGwVE3qkxxmZzhR+NtHnxJHyXUkzS4eNSkAwwCjQjtlP3FgPLC
         Gj/Q==
X-Gm-Message-State: AOJu0YyIZ93X0IGs55s+PwCpPCpf7lyzbsd8k48s7+6UPgXT3lNi4XzF
	3lCwlygZill4Ut36I7RiUi0MMXEocIdgnVa/N7ixhhf0wEmr/w9YwCN/Qm7bU7uHRA==
X-Google-Smtp-Source: AGHT+IGmGfIMy8TYdgSBKpKyWik9Ym2iqoAVO/AxtLyOskaNQP7pFqpPhILQqK9APJ7pUJRBYoJ4TA==
X-Received: by 2002:a05:620a:1985:b0:7ac:b2d6:9ccb with SMTP id af79cd13be357-7ae6f43759emr2008332485a.17.1728344105232;
        Mon, 07 Oct 2024 16:35:05 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7562e1dbsm303032185a.48.2024.10.07.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 16:35:04 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johannes.berg@intel.com,
	quic_adisi@quicinc.com,
	deren.wu@mediatek.com,
	chui-hao.chiu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	howard-yh.hsu@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	allen.ye@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	Bo.Jiao@mediatek.com,
	evelyn.tsai@mediatek.com,
	meichia.chiu@mediatek.com,
	krzk@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH v6] wifi: mt76: Fix NULL Dereference caused by mt76_connac_get_he_phy_cap()
Date: Mon,  7 Oct 2024 18:35:01 -0500
Message-Id: <20241007233501.11773-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

mt76_connac_get_he_phy_cap() may return a NULL pointer,
leading to NULL Pointer Dereference.
Add a NULL check for the returned pointer.

Fixes: a5c372f77aa7 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS")
Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy utilities")
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
---
v5: Add version tag.
v6: Adjust NULL check position for readability.
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 87d0dd040001..4d53f819c5f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -551,6 +551,8 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	if (!cap)
+		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
 
@@ -1140,6 +1142,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
 	const struct ieee80211_sta_he_cap *vc =
 		mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	if (!vc)
+		return;
+
 	const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
 	u16 mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
 	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 748ea6adbc6b..55e4cda2f20f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2508,6 +2508,8 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
+	if (!cap)
+		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 6c445a9dbc03..55bb2d0e67e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -798,6 +798,8 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	if (!cap)
+		return;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
-- 
2.25.1


