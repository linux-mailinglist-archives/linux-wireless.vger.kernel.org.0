Return-Path: <linux-wireless+bounces-9949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD649926A93
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D101C21472
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C779C1849FF;
	Wed,  3 Jul 2024 21:43:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8671946D4
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042991; cv=none; b=m9LjlpsS/kBCbooM1l6lqc5yBI8336QRaFqPC9Si0iqT7HuzVyKB//g90ms2l48oJwww2V2FuyzirQ+tDVl3D+zKdFPaTr/amtC3Feo4D8Ow4w2wijRtABUMd8TCtoFjG5AZzVD+a1I+gZ3hBuH9pWdCz8vMdgXrw3rhRcH5IFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042991; c=relaxed/simple;
	bh=hgDH89PcHMEjqnzilmIyMF8vwg/OzKEt/d2R79A2ZqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y16QxlihtVYJGuoT+ZpTYG2xo+E/I89bmx3Lt15eOo0nSiTHunKJ+CThtAccSAYFb2BAh2Zs2Hu5uRXcymVmXSU2Sxk51C97WkWCvNEtUP2RWGWIqaFEQ1U9PdRMOPBQuOzZ55ZTmeS+gIhwV34k1BTXhe3wTDMi/agd5o6fwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-700cd6afa3eso204793a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042989; x=1720647789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5jt3ki0dxujpF+hrHkEF4OlQEJHlnIToDmNgU6Pwh8=;
        b=UCfTAGQyNqK2qfmK1sOGJ2cT2XewuP/z4suvzJNDtslE6IKXOVrT5i3KtNPyg7YStV
         VbEyk0ZjpfG7+Km64Uvgh04oi3H48leeBZCcNG6ljLTWs134xYP+ylpQt3wRqYXr3jcq
         K1PmY1Hp/CMRZcx4idTSO3b3KcGkPolfMoAeb17DsQcN5+IMXC+bbdl9yAEur9mg6t1d
         /+VL0m0ZLr3ZD/5XlUA+L2h0vYLO1IkfuFHceLBxSK7WNSXsRPRqig+GCNv8G+IPYPUy
         I5KSuD9ZL0wea+QkWnnjt7ar0IP6iiC/2v6NKqsLjdW0rC/SUsLGXqH8DZXItEOR03c+
         9Kfw==
X-Forwarded-Encrypted: i=1; AJvYcCVkDY+iCnNvWpOjQ7qehvD1v/f5fCS1kaLiS00V8OzXW1q7jq/oalSVWH0y8IJklaBhYqgWLkHfss9CpfBP/UGN1PFnV/42DiVIGEzk+dE=
X-Gm-Message-State: AOJu0Yww9s7kyvZq2V5JRd9Vjfc2x+mqROR9I7Iw1fM0ZmcrEH/Z2rjn
	TSwEXE8wPR4kxsIkmJryiKL6OAYZkawU0x3ZP5zfdvau87hlrvzU
X-Google-Smtp-Source: AGHT+IH+yhvRJNPDLOf155UX4LN+InGILwsLbUzzyWl2sYHJHsM69Z5/iy6EGQ/+WKVapU70TMpjBw==
X-Received: by 2002:a05:6830:4623:b0:700:ce5f:968c with SMTP id 46e09a7af769-702077496d6mr11310220a34.3.1720042989603;
        Wed, 03 Jul 2024 14:43:09 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:07 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 09/29] wifi: mt76: mt7925: add link handling in mt7925_mac_sta_add
Date: Wed,  3 Jul 2024 14:42:14 -0700
Message-Id: <e2e45fa0d66e86fb5fe07b085998a384c53b429e.1720042294.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720042294.git.sean.wang@kernel.org>
References: <cover.1720042294.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Added link handling to mt7925_mac_sta_add to support MLD devices.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 0e554b21692e..82d16208764f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -887,15 +887,25 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	int err;
 
 	msta->vif = mvif;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		mvif->wep_sta = msta;
 
-	return mt7925_mac_link_sta_add(mdev, vif, &sta->deflink);
+	if (ieee80211_vif_is_mld(vif)) {
+		msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+
+		err = mt7925_mac_sta_add_links(dev, vif, sta, sta->valid_links);
+	} else {
+		err = mt7925_mac_link_sta_add(mdev, vif, &sta->deflink);
+	}
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
 
-- 
2.25.1


