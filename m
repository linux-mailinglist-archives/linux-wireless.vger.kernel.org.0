Return-Path: <linux-wireless+bounces-9950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE74926A94
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACF6283368
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB3191F83;
	Wed,  3 Jul 2024 21:43:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B7190694
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042993; cv=none; b=V70bGsHJCC7yLUVFoPcA5gqvq2MeP5kA35MIeY/r7KxPsq/ssarpXh6qIua6xqSmIIQhbOSlqW7blaFyEQqEjjYmWKKf8VVwm+9E4hH5A9zrvxAsDrFmsAoYeL12+5pnfqojTBaLGz1xWXQ74m//U8QXgNnxo1ZrTMuAVN5uD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042993; c=relaxed/simple;
	bh=IfrV4OM0MCVyEdNdRpfkefs0ffPMKX+cMF1K0Qi3ILc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtnWNakuBUCu/fEx0lMsDPn30t6B+kttf7k7J8l5nxdZe/hKLIm61AyZU57tgcO9BxmwbiMKCNbOJnmc4Dj+IhYfswWqxVI9ZzCVB83saE4QUZEzgoQ6xRAuUSuFyZiDKDBflWSYo9sVhrQ9YLkezY++lmY91G1B677nnHlPVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-700cd6afa3eso204795a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042991; x=1720647791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjjV9MoW6/GqqLbyBVNCqJec5vStgsiVvPCH52PPCaU=;
        b=uFFVZRKHNXE7gp1vVCPTHTuGCqI+xzzyrNdbx9MrbvBXqVWVpFT05y8+uTHW2WiHwd
         4TfMVuTr0oLE+q8RjQcBa42IBpyrUokIxl1fOWCZUo0X+cw+XmBhHRq08rNqdATym1pg
         OJJlkiah2zhtIDA9n4JPXIdW94aV5s1XfDoRC7Mqm5r2J80pTzPOTU9STlfjttQiQOQK
         pEXN4yxc/KpA3YZKjV5U3E1v+0XJ9I6m5yVKCL00t7RiuHmyctG52QZLiYpumRFp31ud
         wpLVmlZXrTut61gC8I3zQ+SFQAixQ5+zRi4ntKI41SVArJXfay8WatJ5CsJSENXaX7os
         SxKw==
X-Forwarded-Encrypted: i=1; AJvYcCUVJSNfTu537qY49PkH31oWqN0Ar9Y9h21r1rU+BkzGdLxfx4SM4ZlvLWdfcdrgtmW9gZwn8LR0hgJgmbq7q+Ppomfagh/dAcxL0RZzGGk=
X-Gm-Message-State: AOJu0Yy/YlsfsMOALomC/sX7m8gKA3s7PB++KUbjZEsUdzW2IZjMzIy0
	bhUaJgdKk7WsXEUarVvnQ2AEO7wi2v2zgRe7ymwrEe7KEVPZegbO3FA86+aZ
X-Google-Smtp-Source: AGHT+IHzTUePuwQCPzYY/JacfKT/2WyEXRpG6nm5RKejU7QJGziRTmVQSCSVqAKa2hnz66ETj0H/8A==
X-Received: by 2002:a9d:5c89:0:b0:701:f366:71d7 with SMTP id 46e09a7af769-7020767ab30mr12877677a34.1.1720042991623;
        Wed, 03 Jul 2024 14:43:11 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:10 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 10/29] wifi: mt76: mt7925: add link handling in mt7925_mac_sta_remove
Date: Wed,  3 Jul 2024 14:42:15 -0700
Message-Id: <84e2ec56c995fdf562b1d3146dd1456ec5cd05af.1720042294.git.sean.wang@kernel.org>
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
index 82d16208764f..5360f8a71655 100644
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


