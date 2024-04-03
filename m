Return-Path: <linux-wireless+bounces-5801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FEC896D4F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D161C2745A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259413A3ED;
	Wed,  3 Apr 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Wr5Wh651"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7780136989
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141581; cv=none; b=uWLs1dh30NfCkgL05prruMaWSZrp8lM+ZhNgtdl2QS6SF0ohn9hbelY+OEM9OcyvrpMMzMiU0Hflq3JvQVMvjA+bmXWYsw/v/l9Ulflm3V2ROlGQfOn3s2Z9gDz6KVhZioGi48Mb2L8MTKfexdeiGgPkw1wi7J4e47ApLc9K1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141581; c=relaxed/simple;
	bh=YDKRSRISc0kpls4zpkAzwhxh20G3/n0mq3GMx7wO59c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXQZzOafrjV5LscKS7B384Etmfjc0+m/XKJpvk7p3Ay+tktvqVtGWXYJWMJ0zo6SDGKcqRuZevwtwrFvMNhnHu22vLPm2kXku0+ndX39XR2R3BvLJDlWRGt3mff38k49tNcEMP8knN+/o9TKY143LjA9ffQZB6B6eXqFm8WudT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Wr5Wh651; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=avYmju3+CMFfshpROmOz5IWxIKBPVzthBow2+avgqb0=; b=Wr5Wh65152r7T8ky9+MNoA1Cwb
	aYEHLstfG1t7dMdApR6e5N/bxfV/J2/MQFafjhLhZqleuaiyBiqxW+M9PR0m3T47J8KUNKrO5/GL0
	3N73h4SR/1migmPT8B4I0PGwScJx1xFOkdbJ03V1ChXtC1vD2IwwHaYUZkg/cegD+ZXQ=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rrxt3-00CgfA-0W
	for linux-wireless@vger.kernel.org; Wed, 03 Apr 2024 12:30:33 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 02/13] wifi: mt76: replace skb_put with skb_put_zero
Date: Wed,  3 Apr 2024 12:30:21 +0200
Message-ID: <20240403103032.54823-2-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403103032.54823-1-nbd@nbd.name>
References: <20240403103032.54823-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid potentially reusing uninitialized data

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index af0c2b2aacb0..b8927714d7e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -257,7 +257,7 @@ mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
 	};
 	u16 ntlv;
 
-	ptlv = skb_put(skb, len);
+	ptlv = skb_put_zero(skb, len);
 	memcpy(ptlv, &tlv, sizeof(tlv));
 
 	ntlv = le16_to_cpu(ntlv_hdr->tlv_num);
@@ -1670,7 +1670,7 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	set_bit(MT76_HW_SCANNING, &phy->state);
 	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
 
-	req = (struct mt76_connac_hw_scan_req *)skb_put(skb, sizeof(*req));
+	req = (struct mt76_connac_hw_scan_req *)skb_put_zero(skb, sizeof(*req));
 
 	req->seq_num = mvif->scan_seq_num | mvif->band_idx << 7;
 	req->bss_idx = mvif->idx;
@@ -1798,7 +1798,7 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 
 	mvif->scan_seq_num = (mvif->scan_seq_num + 1) & 0x7f;
 
-	req = (struct mt76_connac_sched_scan_req *)skb_put(skb, sizeof(*req));
+	req = (struct mt76_connac_sched_scan_req *)skb_put_zero(skb, sizeof(*req));
 	req->version = 1;
 	req->seq_num = mvif->scan_seq_num | mvif->band_idx << 7;
 
@@ -2321,7 +2321,7 @@ int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 		return -ENOMEM;
 
 	skb_put_data(skb, &hdr, sizeof(hdr));
-	gtk_tlv = (struct mt76_connac_gtk_rekey_tlv *)skb_put(skb,
+	gtk_tlv = (struct mt76_connac_gtk_rekey_tlv *)skb_put_zero(skb,
 							 sizeof(*gtk_tlv));
 	gtk_tlv->tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_GTK_REKEY);
 	gtk_tlv->len = cpu_to_le16(sizeof(*gtk_tlv));
@@ -2446,7 +2446,7 @@ mt76_connac_mcu_set_wow_pattern(struct mt76_dev *dev,
 		return -ENOMEM;
 
 	skb_put_data(skb, &hdr, sizeof(hdr));
-	ptlv = (struct mt76_connac_wow_pattern_tlv *)skb_put(skb, sizeof(*ptlv));
+	ptlv = (struct mt76_connac_wow_pattern_tlv *)skb_put_zero(skb, sizeof(*ptlv));
 	ptlv->tag = cpu_to_le16(UNI_SUSPEND_WOW_PATTERN);
 	ptlv->len = cpu_to_le16(sizeof(*ptlv));
 	ptlv->data_len = pattern->pattern_len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index d90f98c50039..b7157bdb3103 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -424,7 +424,7 @@ mt7915_mcu_add_nested_subtlv(struct sk_buff *skb, int sub_tag, int sub_len,
 		.len = cpu_to_le16(sub_len),
 	};
 
-	ptlv = skb_put(skb, sub_len);
+	ptlv = skb_put_zero(skb, sub_len);
 	memcpy(ptlv, &tlv, sizeof(tlv));
 
 	le16_add_cpu(sub_ntlv, 1);
-- 
2.43.0


