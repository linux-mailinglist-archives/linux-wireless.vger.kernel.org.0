Return-Path: <linux-wireless+bounces-9943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD659926A8D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE781F236D4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070F19067C;
	Wed,  3 Jul 2024 21:42:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419619415F
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042975; cv=none; b=nzl11A5Mb7eTjTSDHt184v2Y0ZRPbH+kTXFH4TjTBLtWISepDkUuR8y4SJE6yEm8kydEkfGT5aKxtAO7nVkDVzBKzPs2Sgob7CAd84H8cb44yQmgINtOc1zYVYssEa9QceGibzDcrepjCuMP1NrdfM48OA6oV7F3dJGdy6LsggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042975; c=relaxed/simple;
	bh=V/PhR96m9Pu3ULpoAZcLDyCZ21NroV/1pXyOGrrAVh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpHieD+QIkUxWisL6I9soDBNRbOdoulmy2CKhO5oWtwI7jnI2mTPoAp5+MK04Y6HaDNvDtiV3qE/efFTGX/5tnK/iqKyiHJljzS6vQlT6LBoP4BmzV7PbzgBSvXANh6Vs7xuHwlN5ShnVwI3M8W/8sfD6UFnPzhHS1ZuegHJAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-254925e6472so7773fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042973; x=1720647773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K/G1mFnUqG5/XVm+Bjq0BOwIjr9NKGtmLZt5vb8yyo=;
        b=Ggu3w8vwKItjPFi8x3WMkR2UWLGKWfWhNZTIf96ef/S5qXnM1ZryXWb4Wl3AkYyC9f
         SnbM786vBmYr67SDqSiwr82zOIlpUIV6EhtehinAEu+8In4j14tckkBIKjPpoFd9xshx
         VY8e5I0lI1WIcm5HJJgNz8wmNqsPGm6vALwJHrX3PW77GGZ0hCeaasnErVk+xxkDaMlP
         hDqK0jtMpnwFn8flJ/wVrGdIagrVrjBL4wO6cUqa2GlAdZoIa7T1cbRM6oGkKEandEAw
         KlppYAYJw8unttd3ts7Lek7g9vaMeGyt3uwSLMq2lPT62Ch+S/XuULabuNzoIbnUCaA8
         tSjg==
X-Forwarded-Encrypted: i=1; AJvYcCWqosoB8sO8WTObuSsKCDcysQGFY0YmHWrOLBo5fo9r2HTzfanhOL0NpY7Iv8Y+OsHD+QZoIS6WlJ5WiEi6/jQI9oAoI2GCI+NZz9Gqvyk=
X-Gm-Message-State: AOJu0YyW7b2VWrR9W6wZO9F8ghGBkdlTg24yYx7i5JF0DGc/xMYhaM1m
	4Sy2dVGoI9FGiYuJ9DjvxI+lT5+lAWb6i2l0/8bBncapGwerZMT+
X-Google-Smtp-Source: AGHT+IEneCCcR7ZDKxvEJ7/VqWpNOTdFJy5jMTeENZKYzVaf+ecNU+xe/U5qPtR6pGZa7/YqfGtU4g==
X-Received: by 2002:a9d:7e8a:0:b0:700:e0e8:5e2 with SMTP id 46e09a7af769-70207560e89mr12823875a34.0.1720042973070;
        Wed, 03 Jul 2024 14:42:53 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:42:51 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 03/29] wifi: mt76: mt7925: set Tx queue parameters according to link id
Date: Wed,  3 Jul 2024 14:42:08 -0700
Message-Id: <b40df22b45353a59cc463d3e3fd1d4e8313f238a.1720042294.git.sean.wang@kernel.org>
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

Configure TX queue parameters according to link id.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 1c8a44789e51..4e5868cd2a97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1306,6 +1306,7 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, link_id);
 	static const u8 mq_to_aci[] = {
 		    [IEEE80211_AC_VO] = 3,
 		    [IEEE80211_AC_VI] = 2,
@@ -1314,7 +1315,7 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	};
 
 	/* firmware uses access class index */
-	mvif->bss_conf.queue_params[mq_to_aci[queue]] = *params;
+	mconf->queue_params[mq_to_aci[queue]] = *params;
 
 	return 0;
 }
-- 
2.25.1


