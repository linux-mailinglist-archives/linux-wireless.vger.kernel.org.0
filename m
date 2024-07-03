Return-Path: <linux-wireless+bounces-9965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75C926AA6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B742857EB
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB2019415E;
	Wed,  3 Jul 2024 21:43:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA2195807
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043021; cv=none; b=WyOjM/fUAqZrj/ychVpa5t7Vl/7z0E6XDKvKd6xgnS1ks12sx52BYt3PBBrgkrDutsNlQ2wSANoy+HdEQDwJ1JrrIQay0/5zkOzPTZntcYRaLvNO3ZGjULdVD5ZrRSFdl48TqSu2ylmV0LDHt0N0UYZHivyv2K94GUh46EggP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043021; c=relaxed/simple;
	bh=ioAFecPopJl88mFoOHfpl3wgFVC3td8PCpgcMoFQv7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZ6LsqisA5EIhgKarc7gYC+y0rMiTygAOOp8/9VKK0WWzPWBodwcg6lJkTicY6jbLctil/JIGgZZ3xZzpV6U2oZ/VTduAEohTJQP6xpbb7d7x+mjb8kZsnUpXhdm9YEd6gUMPaFYx7sRrpsfL3euYbDEnJ6oKX1RgljlIIqPBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-700cd6afa3eso204803a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043019; x=1720647819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwqorZoTFFCKliGP8pRCTs9efMb53TYnGt4MRvbI/og=;
        b=ZAX3jE0y08Nhib4DPi8J5nIqE/XLv0zgzLIWFzF04uLhR7AzAqL0h0LfPXj8vPMfG1
         RpcaECP2f1aTqz2++8xgi+G0Q7Wb8fA11EvfM1+dHE6hGQwZLCAgt18y16GdFZHwchUH
         Gb9u51pHi8lgpznljzInvNuGnYBhFdKIB2MJIn+acrjC4RldMmHy+U67T+jK30B+ZO8N
         kFpIxxGo4dYNwV3rMSQqMv/T3j8j6SQOmfSkRdzibGycRTpK7cIjH0thOHg8yZf9DTpb
         8PREp2Flq2/66OIRAfSITG6OkSGmryQlM+iLkdaPc1AvZ2WwP9mtkA3+h1cVx99u+3AH
         ny0g==
X-Forwarded-Encrypted: i=1; AJvYcCUFmwzpK8aqdocr30Jga3xRY1LKR5euhLF61H4EmV55xtsMfjkkwyfP9wNiOlq+OxF27Koodziu3Tznb8YNyqc0om1mPnDnf/K3zfeXI1w=
X-Gm-Message-State: AOJu0YwDYN+Q78oz9+ttxs/ovQhaX7khFYye6AZGkr35Ss7Kwd8XuFhX
	xD2Xb15aSzyuJpAySv9nS1kf+PgS7612i1/vmOsGR+JIGR0SDxmb
X-Google-Smtp-Source: AGHT+IHo1AAWxD+r1FVufqOGwJZIiBIJ5Fr19n7yL5Sc8XkDMXkfUza+KBsv5oIqzuNNAzCLC0jxKg==
X-Received: by 2002:a9d:6b12:0:b0:701:f9f0:73d8 with SMTP id 46e09a7af769-7020772bb17mr13165401a34.2.1720043018979;
        Wed, 03 Jul 2024 14:43:38 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:37 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 25/29] wifi: mt76: mt7925: update mt7925_mcu_add_bss_info for MLO
Date: Wed,  3 Jul 2024 14:42:30 -0700
Message-Id: <efa7e5623bd8adbf6d3bab293fcc292f11a2b8c2.1720042294.git.sean.wang@kernel.org>
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

Update mt7925_mcu_bss_mld_tlv for the MLO-enabled firmware

The change remains compatible with the non-MLO mode and the
older firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8e36fb211dcc..218efe543dbb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2525,7 +2525,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
-	mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
+	if (enable)
+		mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
-- 
2.25.1


