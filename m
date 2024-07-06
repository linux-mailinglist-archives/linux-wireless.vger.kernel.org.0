Return-Path: <linux-wireless+bounces-10045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9F9291EA
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2527EB2273F
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666250269;
	Sat,  6 Jul 2024 08:29:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E54C3D0
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254548; cv=none; b=PL1LjtaJAxax8g7dJQ890w7dMmRPzCkkBIthuT23Epx1bTPTRV/Wjub8H6SIrHrwBWT+iOnoKeHE35BXiqoaHyp07cGcjDOMQzaAfusBias0xiN/OUfFsMMdwdk4LLN9LxmF94fan5SYAi/NHO+vvO8KW/smjyBbKxGLd19M1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254548; c=relaxed/simple;
	bh=vmCaKfsywC6qKisLbLeg4TQTPhazCSB01hMUMzCA4AY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xt7pxjw4Wa5CvWT8kPzCpNXguOYN1/BoCCPG0pMyEOPNYN8iLsQUPEFRWTHtSKJ4ZpzQ+1qRZsaFAuP3YSgusEuP+80OQyEHoRXeuiAdV/zl5bQPfcylrMOLZROaWCDXENoKd6Vhf0ZKDdVSkwRQn+Vbcz34v7e/tlJQ+VTi7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-254925e6472so364191fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254546; x=1720859346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhnUBU60MyvNT6yMvKJrua9PvBBIIll209q9635BY68=;
        b=lQCKb59l7TnNSPR1FH7jW9LTCcAejsq3fHDIupNz0mIa1Gi8DrXbsXhQjaiRKmoYAD
         kjMlTYP2RX+Hl36Um0ZgFCU5ycuLGTdb93l0OuAxopy7ZRg1G75nfXf78XGRBpfRu2vg
         cN4zTiQ9WK7WJAB6sXepEgVFjj/XItKVjQPWMFogAF9gM83bwbXk5hc3tLob6VJtLsEF
         OQaU/c8a6wgcOLJk4Hd07PW1c8KJsuUVcJxiHg9YpskN1+SAAAFQaVA9X0fI06uT9fgT
         461olE82OWIFbPany/X3ln+cQ9l0ND4iwtZVx1iGlYgsV6cFlEa0ZoXnI95iUA8dJjUA
         aNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh9uMfxXcXJ23mZXoP7fhcOR13l6DUtHoI106GHSe/zB1LwjkK0gWXzpubPmM66KLWlZpYQm48LSa5p+7hanktepfulTeTpb7gEoAUYPc=
X-Gm-Message-State: AOJu0YyrNbe/lF3RviElwU1CTA1loE0kOZJzQPrg/EYqpyhR/RoyCKeE
	lsM1z1OxmesqRhw/7IcPGv+zBt7vLVHtojfQlEaky5efLr+7rF6d
X-Google-Smtp-Source: AGHT+IEyOyEgiWCFYHlQ8tMVIY3cVVU0h6WFWzQMhDKRCO3slBlIGxIzEP3u1EdVxFniuPB4ilWljg==
X-Received: by 2002:a05:6871:798e:b0:25e:15e1:35c6 with SMTP id 586e51a60fabf-25e2b5af44dmr6351944fac.0.1720254546253;
        Sat, 06 Jul 2024 01:29:06 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:05 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 26/37] wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO
Date: Sat,  6 Jul 2024 01:28:06 -0700
Message-Id: <25ea3ffd3875083577ab440ec63f3dcd9dc233f4.1720248331.git.sean.wang@kernel.org>
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

Update mt7925_mcu_sta_mld_tlv for the MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 5979e47ec142..38e2ac5efb6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1742,19 +1742,34 @@ static void
 mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	unsigned long valid = mvif->valid_links;
+	struct mt792x_bss_conf *mconf;
+	struct mt792x_link_sta *mlink;
 	struct sta_rec_mld *mld;
 	struct tlv *tlv;
+	int i, cnt = 0;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_MLD, sizeof(*mld));
 	mld = (struct sta_rec_mld *)tlv;
-	memcpy(mld->mac_addr, vif->addr, ETH_ALEN);
-	mld->primary_id = cpu_to_le16(wcid->idx);
-	mld->wlan_id = cpu_to_le16(wcid->idx);
+	memcpy(mld->mac_addr, sta->addr, ETH_ALEN);
+	mld->primary_id = cpu_to_le16(msta->deflink.wcid.idx);
+	mld->wlan_id = cpu_to_le16(msta->deflink.wcid.idx);
+	mld->link_num = min_t(u8, hweight16(mvif->valid_links), 2);
+
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		if (cnt == mld->link_num)
+			break;
 
-	/* TODO: 0 means deflink only, add secondary link(1) later */
-	mld->link_num = !!(hweight8(vif->active_links) > 1);
-	WARN_ON_ONCE(mld->link_num);
+		mconf = mt792x_vif_to_link(mvif, i);
+		mlink = mt792x_sta_to_link(msta, i);
+		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
+		mld->link[cnt++].bss_idx = cpu_to_le16(mconf->mt76.idx);
+
+		if (mlink != &msta->deflink)
+			mld->secondary_id = cpu_to_le16(mlink->wcid.idx);
+	}
 }
 
 static int
-- 
2.25.1


