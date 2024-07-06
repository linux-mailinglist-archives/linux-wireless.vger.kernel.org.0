Return-Path: <linux-wireless+bounces-10043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EA9291E8
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BF61C20A45
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375A11C69D;
	Sat,  6 Jul 2024 08:29:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0807406F
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254545; cv=none; b=fnGqk7ySB3ukMTU3IVJbRI3XUhmGtAy+pbjmm3bf9WggMKS3yY/DRy5XUJBr9jFVQf8av1baH6Zjr4j1La2w4QaPFRzGfO5EuNIg449b1UyWEF67aeJ5n/RUdcKb5B75/1xhvD9JayBb7hldZ4jJSMmW6QwublSG0HqmK0TGGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254545; c=relaxed/simple;
	bh=3aRti+uABG0NrQx2wC7TUSQyOFtp5zJS4wRP1cpu9aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFjcT6I6SpmlYf07IAW8fj1ytu2O2pIwYjzVjtHZ1mFxksb9YqNTbFZVfJTvCBB0GG254r+k2fQuQlgvckArNyw/hX72kLlWDknTuPsSmEhlEy+EeMfkErrVjXVY8S9STytup5Z0KSfP+us4nzUSaoIMAsLg5kBcjbtONJxNb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c41370121bso62997eaf.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254543; x=1720859343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNbrfo87WUKSPAzqY+ihQ88l4268XCP8og2J9dUfydM=;
        b=JXKFWfeGA+/e0fgApuK5XCMQ/2Yhg3/MACW1at7EBWlGknQgUpQyndTgOzkd37EIUH
         c0GlZBocywnE+jky/0Ck8Hj/f2WHsDyJlovAOZc+bGSslFQOMFqr0FutJXNKcNQ5ClWS
         i6bQ64fgQ2Fyt6Jf7hnuB+tOAD7hR41pqSYe/zHOImFS3+DLioYeMv0Zl1gYlf6o4pec
         ZDd1k4oKuuUxyehP54waHoNvXsSpXi4jUDhwLJWfH5gl5Z0Q/cQgMRsy6RLJJ8rpx2Rg
         2yikLiTbSCtzrpC6I7rlRMTfWuO/nlDGB6EKyDYdXzLFkIjAr9n0V9C1uzpWDNVwapS/
         KahA==
X-Forwarded-Encrypted: i=1; AJvYcCXcY2yBq5bY6GoOzS/jDBYaHrreo4rmMGX5089vFT2F+UouJgZUAi60eT09H3HTWVdDtpZRg0/qATbrScsYCuFAoEXHY66uAX26aeNCrpg=
X-Gm-Message-State: AOJu0Yyp3n0UxBuXJrCmgYxyUFiX+dwn7r9km5t9tis/RnbBiNiEoCMN
	yZXfTJ/OEDT/jERWujp6KyNdjXkFCAkCLIY2qznW4kjfPwieiif3
X-Google-Smtp-Source: AGHT+IE4D1UPCBu4Iu6dQf7UbTChRc3rtaYw8RQe/rJ50IyYMe1udypfb6btw6+/ex9AYP2IIke5wQ==
X-Received: by 2002:a05:6871:7988:b0:254:a7df:721b with SMTP id 586e51a60fabf-25e2c06c433mr6843442fac.5.1720254542869;
        Sat, 06 Jul 2024 01:29:02 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:01 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 24/37] wifi: mt76: add def_wcid to struct mt76_wcid
Date: Sat,  6 Jul 2024 01:28:04 -0700
Message-Id: <d5188ca633666eaad7e90a8061d1a0585487e128.1720248331.git.sean.wang@kernel.org>
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

add def_wcid to struct mt76_wcid to allow per-link wcid to retrieve the
struct ieee80211_sta structure.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e1d30326f5af..5f8773364d51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -368,6 +368,8 @@ struct mt76_wcid {
 	struct mt76_sta_stats stats;
 
 	struct list_head poll_list;
+
+	struct mt76_wcid *def_wcid;
 };
 
 struct mt76_txq {
@@ -1258,6 +1260,9 @@ wcid_to_sta(struct mt76_wcid *wcid)
 	if (!wcid || !wcid->sta)
 		return NULL;
 
+	if (wcid->def_wcid)
+		ptr = wcid->def_wcid;
+
 	return container_of(ptr, struct ieee80211_sta, drv_priv);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 1a6a0b56a23e..dabfb8eca686 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -892,6 +892,7 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		rcu_assign_pointer(msta->link[link_id], mlink);
 		mlink->sta = msta;
 		mlink->pri_link = &sta->deflink;
+		mlink->wcid.def_wcid = &msta->deflink.wcid;
 
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 		mt7925_mac_link_sta_add(&dev->mt76, vif, link_sta);
@@ -1900,6 +1901,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mconf->vif = mvif;
 		mlink->wcid.link_id = link_id;
 		mlink->wcid.link_valid = !!vif->valid_links;
+		mlink->wcid.def_wcid = &mvif->sta.deflink.wcid;
 	}
 
 	if (hweight16(mvif->valid_links) == 0)
-- 
2.25.1


