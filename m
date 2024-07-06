Return-Path: <linux-wireless+bounces-10029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030289291DA
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B8C1F21E01
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48271CAB3;
	Sat,  6 Jul 2024 08:28:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA5524D6
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254521; cv=none; b=SjGG2hND/fbnPxdRB3y5sQb0Ajo1I54jFsoHUvNrsmTjIoZaRyRedVJh1iC0aM9ZeeRGWvGlyfL5DNQ3qTXGY8e2N0tOOVd3cWgLELNqUTON5OUg3hxniknONAancqlp9QX46uN4GtvBwXiVAa+1buORHF7C5qzuZZPhH96SRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254521; c=relaxed/simple;
	bh=DFw7AFxAHqNXHh+LYmlv02l6zTYZDTgE9osjr3tPzkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqpras4K19h6yZ9aE36D0re2n2EB5fYUHohnhIBGQXg+H0mIxJ3GBQNt7C4z8e5CXmL3qJKRdw1OMjdE7/gvKOwqOFmq4mpm2i/3aX7DvdWy+lGGWp3wYD+QO3mUuylpISg7i6pNeoGHUDSB1TB2PQpXztbK/bR00A5zjT7oRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e14bf05e5so95390fac.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254519; x=1720859319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAjVZTnUhu0dIEUEUzrUR6KmfLF6doPnT97CAweb4kU=;
        b=tvFRh+pcO1UXB+2D8/E6KB0Xo7wbYQ1ydXTJlnIfFkX2DmSOro3VS3v6AFttt+EoxI
         0UjSeARIMOfbgJ1/i7JTYRa/MgtwgPdtkSitZKmE3CSWDxPvQeWKAGicZA0SFb5W+2As
         J4JiB2z5//pKV1L4no97jqSqG+/S8UIjhrg2pvOHceeyu+EB8P/IciHjr7lAV2UxAuNJ
         14i1UTGVjEJUBmxx0oQrlIdNXxyRQpHsbxUmtv8EiuscycsuYDHR0I6LZHtgjZEby2rD
         ecv6ZreTvvFdz/RuXqKllHyEdgclyjECs0Xp95KnMO0shcBrNNqVMGDExy0GGp/UKNAI
         kQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFMBco6eqQxk/rMSSyoJO+AvijVMCO7g5w56wi/1Zu7egK/8V0iLmvV/dtD2AJ9hB5ldCq7q4qgpgHOwI/2aNihhoR+HAKu5JZky38J48=
X-Gm-Message-State: AOJu0YzZVuqIwaf7tYMiZ+xoIJC30/y6JDHIxkHgZ77nixeVZcWflDKR
	qOG3h/1GiHK2kDuZiDXts0Y+k41K5dtz4Q3BHcBTEDi04BCVTbi9
X-Google-Smtp-Source: AGHT+IHCvWG8tRPJXCVddAO6FRMJQFPuKQrMHuZK7N8spyF4+hiGS/P8jKzoibHFGJWs2r6oJ9WKOA==
X-Received: by 2002:a05:6871:588c:b0:25e:2624:eb5f with SMTP id 586e51a60fabf-25e2b8cf269mr6539703fac.1.1720254519351;
        Sat, 06 Jul 2024 01:28:39 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:38 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 10/37] wifi: mt76: mt7925: add link handling in mt7925_mac_sta_remove
Date: Sat,  6 Jul 2024 01:27:50 -0700
Message-Id: <20d53511fe1f64984d893f4d3ec87cb9f87d3070.1720248331.git.sean.wang@kernel.org>
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

Added link handling to mt7925_mac_sta_remove, supporting the MLO-enabled
firmware. The change remains comptabile with the non-MLO mode.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 042c9fe5a2d9..79b43101237c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1033,7 +1033,13 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
-	mt7925_mac_link_sta_remove(mdev, vif, &sta->deflink);
+	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	unsigned long rem;
+
+	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
+
+	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-- 
2.25.1


