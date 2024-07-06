Return-Path: <linux-wireless+bounces-10028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73449291D9
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C561C21180
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B11C69D;
	Sat,  6 Jul 2024 08:28:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D814D8CF
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254519; cv=none; b=PWnznlTT2wZ7NnmCnzCdCwM5K6V07+gmdKXhjoHuLvUdFSni5X+zazmY08P+P2P9K2cftx7zUrS4eXnJvMi7Ji6o1IKn0x5tXDRFwRn87CqZmZXhaUH49iJwqgaqlMmbyAlecUMI8O6aOmUXt7tKGIMSGuLLMD+sMP9SD5zHIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254519; c=relaxed/simple;
	bh=RvpOb+EM0T0ebmrBIncwhhecHAoQhRsU2N5UTT2Lgh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsR9CnGOBKUDxmYna/Qg3nLdeUyovKba/+ew1VX40WDd3zdoXMTW+CDRi5woVhx8HJf5XWaeSqqJ5V2YULTRjiVosoXgLUhZm/Kw+VxVop7tcffS0VQvguqKSP7KT12Ft7RzZpqn2nBBcRrf6j5i1s7YGqYO3UzrhkMNYxuMCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e23e0492dso341268fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254517; x=1720859317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUKy5cLCtr2agTep0UNplkIZGNAtrmGpQ52zbOdfdDw=;
        b=NlhnSfBASL4PxwgQywe2dyJ1gk87ujoo/xBF1WUyYRDmRz17QfDlwHC0noQssRt39h
         +tpk+xv9qbc/YY6UkYwFxpqRG0iiSvXID6cSz5RNV1HgedoIBwlPQzn8KPsyZkIfoOIe
         lEsLoq/rlHwSaRXwBZS0aOPkHZzjloO8bEjgGWm2WSMZErz9W3QhT+zzko/mdpd1d6Yo
         dsKQnRFNEU5IDERsixz0rm1bJzA9BI+BClKPqrYdfByOwalt+jUMRPnmnaszGOPEQM9T
         jueHGsr5wBKBnzZFB1aAbJELe91rhla4QwWqMb1gAWIpv5OxRy6wDQm4zJ4C1wqpqqUX
         QLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyu1f5SSJZOBNLqkmeR8eR3F2qveyFIel0GYEusOFRHf4NRjd36b2qUd8nAPxm5WW+ajOp2pD26NPXwqq4cLO6OYVns0hvfroQksbRAAY=
X-Gm-Message-State: AOJu0YzNCvI9xHwR5aGq+VhgGtkPEVUVJAHQAzKxg0vu1/9Mg03qHLRX
	GmoZuvdT/LnSrubomPqAuOksheYdrRS4Pmm7lXritl24GGY02LPP
X-Google-Smtp-Source: AGHT+IH+qa3dsDD4Mgin9v93sY0n2Sl8CBjgDZghzcyc5VZ/TSITDy7VrSRro0EJ1uJdtQEiTNmmgQ==
X-Received: by 2002:a05:6871:24d9:b0:254:affe:5a08 with SMTP id 586e51a60fabf-25e2ba1b287mr6406811fac.2.1720254517608;
        Sat, 06 Jul 2024 01:28:37 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:36 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 09/37] wifi: mt76: mt7925: add link handling in mt7925_mac_sta_add
Date: Sat,  6 Jul 2024 01:27:49 -0700
Message-Id: <632faefe8c82cd5609c2af00aabee15ccc9616ed.1720248331.git.sean.wang@kernel.org>
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
index afb58a9206b0..042c9fe5a2d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -885,15 +885,25 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
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


