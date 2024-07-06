Return-Path: <linux-wireless+bounces-10051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC3B9291F0
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4CC1F21E20
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12118B1A;
	Sat,  6 Jul 2024 08:29:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23EC811E0
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254559; cv=none; b=EsClKq2+b89mMhe5mLFf7CLD8/cSoIz5NkMtCYwHYTRTd1yEItFaJE3yBVMDA/ZgOL9HMHvphW3SCkikHMiNSiXMbltOSLshA0pzUgnPwbUMZ5sqokPuATzO28CdH4ugdG76Gs2Eo4iLrsgfYdd6R9SMzjN6BPPDx3HyrGopsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254559; c=relaxed/simple;
	bh=3zjWxMQJaRFPWh7YWmshJTa6ZEedaky6aWBMNcilHBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lw2ARqHDcf/QCGDRIQx8kKdFg+sH5LyNBVzIJE2sVl+zP2FZMbWGuZDeHALXq6jevQ3kk3bbsP75O3y61cd4IMDLkX0aki0iXo9oTFFqDRtukOTrAPDwX73jz8BGX895SgRUjG55gsuAcqy0lGOvMP0XihcRmt4xajq81Przib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c411d037b3so49379eaf.2
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254557; x=1720859357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlF2JywEe1cvvGSvZJRgqPG6ZVZ0CbkrViYHici5z68=;
        b=RQ97Z2/IKensVQPuthz/Ya4/VNiVH4tpjR/1BCttjehs3Zxm2oHSBnBVOnwPJ6icud
         C5n08FOdiULJp07DMKKhWtBNGPXLd2DPOZcY5p6TjCG2/4sY8YB/WG7VWGfuBDZnKzK5
         P2xvpaa99q+jPqHJFL2MTvh1X65gj0him5Xu5KVQZtO/2ZAklmNbOgcItuY+LWscXRnT
         SRfGiuJcb6lRX8FnioKijN2clUbXj/7v74EWNArCbCSOV27OPSbWPo1xbmvFypVU4Muy
         fdve9yp47vrc9xSzeTvrVY1x7JMOudG8wC200q7UyxSC91EOvshhR8++gLOH4zdXNoub
         yH2A==
X-Forwarded-Encrypted: i=1; AJvYcCUb7E4xZBzNj8KleFHCHe5Cr8U92w9F8sksbzz8zDE/AuI8M5VjLbqicQQAZRx7cnfWf81//HM0hL4XPu2m8aEcN3bg0n9+AGJPFV27hgg=
X-Gm-Message-State: AOJu0YyWhlMQjf/EfJm4zWa4bel9rSCqXoDRPQe/pL8iOTJ8vUgtVCAI
	XNt1BVcSinP1nPOU2XlPb6eEjXdvHR/6lNMAiTYzj2XLSzX8KbeT
X-Google-Smtp-Source: AGHT+IEKaHR/MtADbJuaDJwOKkXRGJJxNlaYQ4FMc5RcMDq6t1884qf4ZfSK3ZmX34TiS+gD3C2FXQ==
X-Received: by 2002:a05:6871:24c1:b0:25e:44b9:b2ee with SMTP id 586e51a60fabf-25e44b9d073mr3715643fac.2.1720254556954;
        Sat, 06 Jul 2024 01:29:16 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:15 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 32/37] wifi: mt76: mt7925: update mt7925_mcu_sta_phy_tlv for MLO
Date: Sat,  6 Jul 2024 01:28:12 -0700
Message-Id: <6620e00fbeef686fb2041556deba346411eab0f1.1720248331.git.sean.wang@kernel.org>
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

when we serve MLO during the multiple-linked connection, the chanctx may
be not available in the internal driver, we should get the proper the
band information from link_conf for the MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8fc75f9002d1..b005b5b8968c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1647,7 +1647,8 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
-	chandef = &mconf->mt76.ctx->def;
+	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
+				    &link_conf->chanreq.oper;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
 	phy = (struct sta_rec_phy *)tlv;
-- 
2.25.1


