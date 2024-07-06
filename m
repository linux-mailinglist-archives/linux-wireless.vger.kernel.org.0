Return-Path: <linux-wireless+bounces-10052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D69291F1
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A57F283DA2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB13755896;
	Sat,  6 Jul 2024 08:29:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8078C60
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254560; cv=none; b=M6f/AbM3T1exYB7x2xjnH6WcLbGKKqxqHYDhGY5v9JfptdDxgdqo/R0Zg5ml3FmiL2D4nA+g+sD1S/ZisNGlwrB+M+ek9wBRC+Z8wq4Ze/VeltH/zYU9+bzaRxW0iQfM7abOsyFxzDEz/KU5CqiU9osm73z0MBcdmdXX9kTHl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254560; c=relaxed/simple;
	bh=cYCNwHIYPBD/sZjNOeTrkR5KuTx4lMdiunsUj4kW9Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQbMGcmikEWkBpvTOsQp/iA4RoeQZThGrN7ovaG7Jt9x3FA+OWVXvKXg3dq3IlRIctjrxVghOQ1+tNvgkTQ6U4NPQgVefsPr/AwLMFmmAk21h5RV/4JsoBMwWpGOFHoVZrQ9Noxs7EQ/g1JRXF8epnRV306NJ+kByHgShyZ7BeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c5ec50da1so284902fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254559; x=1720859359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdHDwIbk/nKAta5fWk+n0tgyiwD0vWEsim4rkaQNjjk=;
        b=vpi18N5HGjvlU8EJWz6s4GXbklKXXGDicZF6ms418jUyq/KNbg90ilaG0R718M7Q7x
         N2J6AwwknfqHeQ/K35dajOu+QLcDz0J/AINXH9E2lNRhO5G8RLt+Xdg9+vbtfoiIElwL
         iv2KZ9kPOYdmvJkMn1J5mI6fBdj2QLqqpKLmwxU+ur51ABIXElSp4+SxlPdEsGRDTfHT
         /H6QnMxSgWk6U5tG5tHyTB4sk0YRPxx6/uQ5x3LphLfgpAsKP2WgwrCn4yMRTUj0dnZ/
         hL6YBwdusgIP21Sp6UWgjDnTLwvJ2FtDPeg9w23Pj49MOq94xJwCVViy83q6dB5hF1VZ
         pn5A==
X-Forwarded-Encrypted: i=1; AJvYcCU9bfxRQukboC3NyabH1n196bsb0laDqpa9Linc4Igrap79QWsOX9+6O7eLJdBdtoQ+breCxaGxgkfy464erwikP20Tho1CQwTDojstRVQ=
X-Gm-Message-State: AOJu0YzVTFYkqSUhBzErrwkNrYmvttJeUeOdqLftecz8veBhgb9rdbQU
	bC6t8bhfBtQyWgODWYkde7ALuFFMT+EnSnwa9Ef7lSw2duGs7BFE
X-Google-Smtp-Source: AGHT+IH4oEdW8ND3MNXtHA0L4tW09xYHvChs0d6GbdEk6QyLI/uUTcRxtoJox7Z8cYwfB0tBpGQNXg==
X-Received: by 2002:a05:6870:b250:b0:25e:180:9183 with SMTP id 586e51a60fabf-25e2bf95bc9mr5863911fac.4.1720254558671;
        Sat, 06 Jul 2024 01:29:18 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:17 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 33/37] wifi: mt76: mt7925: update mt7925_mcu_set_timing for MLO
Date: Sat,  6 Jul 2024 01:28:13 -0700
Message-Id: <dde970c748586d03fbecbccb10cb9903284719aa.1720248331.git.sean.wang@kernel.org>
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

Set the BSS index from the per-linked BSS for the firmware to identify
which link the command is operating on.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index b005b5b8968c..908aed2eec11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2606,11 +2606,11 @@ mt7925_mcu_bss_ifs_tlv(struct sk_buff *skb,
 int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 			  struct ieee80211_bss_conf *link_conf)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct mt792x_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
-	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->bss_conf.mt76,
+	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
-- 
2.25.1


