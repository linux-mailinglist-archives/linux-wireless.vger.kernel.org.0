Return-Path: <linux-wireless+bounces-32672-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMUJA5liq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32672-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70814228A88
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736B730E1CE1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0544A35F8D1;
	Fri,  6 Mar 2026 23:23:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FC2ECE91
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839414; cv=none; b=liSxGNxqeb0/FtyxCPj/8uLiuJtYgNfUHFPjbqec/M+AiOg8Ge2ckXQ00kToe9/zI6o/w10Oc83NPNASTPWo8uinZlHkcg3q8H+9x1UfP3s5RYE4cAOf1FocsvjF7uJRzZXGGJ1n7fNNFkj+A2WNmGpWM2jFIR/6NFIRZ2+PX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839414; c=relaxed/simple;
	bh=zV5pqifcLhduxttsuBJkr0CrZizZjcyeYfCqnBBLw78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b31MYlW5PdTnVHOsvJCgWFSO2XOMOUt9nhccbkSXBISTbgIYFZA5YOIRk80X8a1qXygnewGqOsiuJBYgZ4tKsPttC51gLpJJ4QQriwuSJpFbJykZH26Yn5bR6INRoMbGc9U9gysxzSeIb1P7hYmiWIxbccTSD0pannrQWCGH7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40423dbe98bso2303875fac.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839413; x=1773444213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9odMuMDX1nM70rzmWxmpu+kqigeVOy1ZywVNBsLqWA=;
        b=GIwS6C6dgnjVGBCLWHfFr11isuEWmGtuipjlVyEAUaq/m7WblwmuAp0X0/AWHsuDBM
         qn1XYOazaPm+96RqsqtJqSUlsCJ2NdAjeQb3sBRDZNkmKZCJPqedn1WDIAXuEgt8x6Ye
         tgMLZoyT4FRHFH5rEr0469xPdIyagIT4WWoIYHxoMEq5109zqU/SE30OJi01mBhOnHw0
         aBjcvw4FZovfzpkY/vemFlr79wFictO13Br4vovvA4K4s0yFWQapUXHx3uaS7RfGAq9u
         6TCTsyGlsVxYHbusllgmz6/xQjJY0HAAs8ukyqQkyh4N5QjtAM7EQ3b1QFVEPM2cmMGz
         0dCw==
X-Gm-Message-State: AOJu0Yyy2SwRDvUHl5xG5Kf4p3I4P6VRmORxzLVKejIAbS51I7JOlLN8
	phxro00YjGjfR95/7UWr5l6GYtpFajkl9XoqsQAG0N9vycqzYnC00+F3
X-Gm-Gg: ATEYQzx1Yim6JIjWIfbFJUmF+WBrzBC+9w6noTfkR6Bh+G9DgoDXaSrCZ7x59lNUmah
	C2xKwh+AMfyqbqpC9QPyUy1L1ZKts9Ip6i1CpMxrQZ7lH40T2kR3r/i66pdcYbfjRGDg89j0vir
	pWbOStv5+MqQSsC8hXx/C1npnFFoStjr1/SWRp5W8aq5mNg6zqnLk6VqE90xsowooEspT3OjpfD
	WoScNpioN3WajBPecvJ7kwJJD+xMh6GX2Uz7d98DAgJQ1hKCtUv1Q6/UDjJox0abvcl1lZLuNAt
	JQ2APXCUvmjEIulGojx0MhM/I9vBg0DWcXONijdBODDBi7xOAriCt8C0xI/HfiFk4PrzGsxTi0f
	z+WO17Lq1CEXmKLCfTX7DP8FNWFN7/IRchnIyUyeegiRKLzueEPeublUDed60z5YGJn3f85g6u+
	W4kM70f1dtju1dISqa2MohSl6hoQnWOqqylBGo/5L42YE3JdQ=
X-Received: by 2002:a05:6870:c232:b0:3e7:eee7:9466 with SMTP id 586e51a60fabf-416e43c76ccmr2373476fac.39.1772839412785;
        Fri, 06 Mar 2026 15:23:32 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:32 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 07/19] wifi: mt76: mt7925: pass mlink to sta_hdr_trans_tlv()
Date: Fri,  6 Mar 2026 17:22:26 -0600
Message-ID: <20260306232238.2039675-8-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306232238.2039675-1-sean.wang@kernel.org>
References: <20260306232238.2039675-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70814228A88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32672-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.392];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Drop the mt792x_sta_to_link() lookup in mt7925_mcu_sta_hdr_trans_tlv()
and pass the resolved mlink from the caller instead. The link is
already known at the call site, making the lookup redundant.

This keeps the helper lookup-free and makes WCID selection explicit.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index fa4915b65fcc..c474dd358650 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1066,9 +1066,9 @@ EXPORT_SYMBOL_GPL(mt7925_run_firmware);
 static void
 mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
-			     struct ieee80211_link_sta *link_sta)
+			     struct ieee80211_link_sta *link_sta,
+			     struct mt792x_link_sta *mlink)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct sta_rec_hdr_trans *hdr_trans;
 	struct mt76_wcid *wcid;
 	struct tlv *tlv;
@@ -1082,15 +1082,7 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 	else
 		hdr_trans->from_ds = true;
 
-	if (link_sta) {
-		struct mt792x_sta *msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-		struct mt792x_link_sta *mlink;
-
-		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
-		wcid = &mlink->wcid;
-	} else {
-		wcid = &mvif->sta.deflink.wcid;
-	}
+	wcid = &mlink->wcid;
 
 	if (!wcid)
 		return;
@@ -1127,7 +1119,10 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 		return PTR_ERR(skb);
 
 	/* starec hdr trans */
-	mt7925_mcu_sta_hdr_trans_tlv(skb, vif, link_sta);
+	if (!link_sta)
+		mlink = &mvif->sta.deflink;
+
+	mt7925_mcu_sta_hdr_trans_tlv(skb, vif, link_sta, mlink);
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
@@ -2028,7 +2023,10 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt76_connac_mcu_add_tlv(skb, STA_REC_MLD_OFF,
 					sizeof(struct tlv));
 	} else {
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
+		if (!info->link_sta)
+			mlink = &mvif->sta.deflink;
+
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta, mlink);
 	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
-- 
2.43.0


