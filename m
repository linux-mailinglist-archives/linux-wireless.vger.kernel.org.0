Return-Path: <linux-wireless+bounces-34638-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFx3A/lL2WkMoQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34638-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:14:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE433DBCDA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BA73025712
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65533A6F2;
	Fri, 10 Apr 2026 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="kQDEMb+o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5C21D3D2
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847846; cv=none; b=HOwpxtbygvqyeGuRWXU00WlMOKTA2T9I0eQBxdI44a3I7ZXuCGVbkeVSHi4Vv1zzuznJtIWzxRz14Z5piN/u5hdmPRuE/vlk1eWLwviWJd289Qrs/FyVRFtzWrIYzt7AHbd0xux7ZILvJw9kQ6zjpn20s+7x8i1XlqmUrs6HkMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847846; c=relaxed/simple;
	bh=2QCRV588jDMMonpLCftMY/Xj5Yw4gIIZW8PqUmXbsRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+ldG7eTc2q1cd6JoyC6/7i7PSyuHLyJLuL34gx28qU6eYkVuqc/icds+ExPBzVnVRyFtnmQq18eS6gKmR1SWQgp+GWhchj1gY3TbJ/TtQdLN02SIU3bfHo4G4clarNzUSX1SHvcaAwpYCQSBOIUhFqZkx1yZTCwH6K+M3kFOm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=kQDEMb+o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a041eae5so17095305e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775847844; x=1776452644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1c5L3f+R9TKNjcEhn8OvWT+RyHCClkpSqE0jbeSQZs=;
        b=kQDEMb+o24WFRSrw+usRachmc1zcDMBJnWrCp2nD0JAo3Q47Pf1DCQJ5rAic7ycFF0
         SkxHyt1QxZ0voO0pDeZbOLbRHELS/Zf8MQjdGsHrddhR1aD2koaXhWK0iZhMU9xOZaIT
         HwA4T3E9vF7PHywn4CHjZjg4G1uKd2nax9/ccvVvSIsN6PFpEjmz77f6IqAfK3TOPb2d
         N9l0UNenh+nx1O2gWpdVY4KJldwOuWiiYVtdjER6HjP6etX2ojX9cWcMj/i93OYQVxY6
         DppUpO+cHT1pExnBPt2U/SZNOoNG8JoO+n09MARqZ/vEZnlBHvdvmsHn5NfJMIwmEd1J
         7VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847844; x=1776452644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1c5L3f+R9TKNjcEhn8OvWT+RyHCClkpSqE0jbeSQZs=;
        b=JlxNHSYJduUlhGOc/l786YZ8ZoFd3xBI/VozJ/um+U0m+exRGFy3wdTFKA3yu+jOZv
         OiG+drgWHJOdtlp5Ucr1A3WF5+oUVti8/FTJlCUVB6VBufrk/ir9g7JCdck4ludWFm1r
         lJYH3fbQBbeTQ2uoevSx+cgt9YxvSh1aAv3JKyZOf6l5plVSN67QkE+eW62eqGrYFStH
         VghuINMviUEoO9hDyAN0t/8lKiriGI+TbLOtNGMfOujENWJ9FwHz416tY9weRT9zM5nS
         yuy6hWYUfO9Wna2h6s0ExKptMYf7EaP6HOrrbsFbVPM2hf4JPPq5oOpC4zACTsUHOnQ6
         p4XA==
X-Gm-Message-State: AOJu0Yw31JgfgCSQFJdJLOVgZFuk0Me+2ylmPxpHrnwboF0xwIizwVwi
	DhRgpWg5LsWqTM79wiL7OCLIFaIEtr5QeRTlb7m/OpZMtTyn3EnrbkCOVn2Abq2qb36BlMEVs6j
	n0L3M
X-Gm-Gg: AeBDietWEIfwMUl7KnPdl4SmRfecAKB0Hdr/U5vMq/ZrEjDI6hfUGXgQxPieAp/wD24
	shBHOmNe4fLhHEkR1DqLFWOY/pqHFlYBvCnHj8JfKVsW12v+qqiVXZM004Cuo6GqZ6RVL2ChmdB
	MU8B2v196SHOW9NR5tZSl7KCdwYN0VuMm31eQx7zVzCYkAzJ/hUKngLr1gOfZUDgxv0Gicr48Ew
	cQv/ZSGAI1x/k5wid+HypeoR84Ah8+qZaI+tiH+gxGKNOptIM+ackjMAB5Q/beoaxzP7JguJg/V
	utnkykMtyD9Gy5c1u9H05KLmzybtXUjcrQ/BljnIE0omLxY6BBgdBfrQJXunLTLdJGjBk3PijY1
	goPlV0aFME6tH4qy3QY1bFOfOFJu5xPJkZ0pYjJW/E5OryCm8j5xOmQZrVMpUF1ajoHXLW2SWMt
	hlIqaJ5uv6oQur9jSJOCkBvYNTkeCrgC0vsBja5kxltvvsjfdXRy0d+U/GZmF3FCJeNep7AdGJ/
	TN2ro5+jogK
X-Received: by 2002:a05:600c:8b6b:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488d67ce792mr59067515e9.8.1775847843706;
        Fri, 10 Apr 2026 12:04:03 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm38909125e9.1.2026.04.10.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:04:03 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [RFC PATCH 7/7] wifi: mt76: do not read band-dependent reserved bits
Date: Fri, 10 Apr 2026 21:03:54 +0200
Message-ID: <20260410190354.394742-8-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
References: <20260410190354.394742-1-pmartin-gomez@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34638-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox.fr:email,freebox.fr:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: AAE433DBCDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bits in Supported Channel Width Set subfield of the HE PHY
Capabilities Information field and Support For 320 MHz in 6 GHz
of the EHT PHY Capabilities Information field are reserved depending on
the current band.

Check the current band to make sure the bits that are being read are not
reserved.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 16420375112d..3b58fe86e1fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1544,7 +1544,8 @@ mt7996_mcu_sta_he_6g_tlv(struct sk_buff *skb,
 
 static void
 mt7996_mcu_sta_eht_tlv(struct sk_buff *skb,
-		       struct ieee80211_link_sta *link_sta)
+		       struct ieee80211_link_sta *link_sta,
+		       enum nl80211_band band)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)link_sta->sta->drv_priv;
 	struct ieee80211_vif *vif = container_of((void *)msta->vif,
@@ -1569,11 +1570,12 @@ mt7996_mcu_sta_eht_tlv(struct sk_buff *skb,
 	eht->phy_cap_ext = cpu_to_le64(elem->phy_cap_info[8]);
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
-	    (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
-	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
-	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
-	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0) {
+		((band == NL80211_BAND_2GHZ && (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
+		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G) == 0) ||
+		    (band != NL80211_BAND_2GHZ && (link_sta->he_cap.he_cap_elem.phy_cap_info[0] &
+		     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0))) {
 		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz,
 		       sizeof(eht->mcs_map_bw20));
 		return;
@@ -2773,7 +2775,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev,
 		/* starec he 6g*/
 		mt7996_mcu_sta_he_6g_tlv(skb, link_sta);
 		/* starec eht */
-		mt7996_mcu_sta_eht_tlv(skb, link_sta);
+		mt7996_mcu_sta_eht_tlv(skb, link_sta, link_conf->chanreq.oper.chan->band);
 		/* starec muru */
 		mt7996_mcu_sta_muru_tlv(dev, skb, link_conf, link_sta);
 
-- 
2.43.0


