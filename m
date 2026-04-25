Return-Path: <linux-wireless+bounces-35301-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEwEKyAb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35301-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B94678F5
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48C83300D702
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD9303C83;
	Sat, 25 Apr 2026 19:50:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7A303A0D
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146652; cv=none; b=oDuXXXr0koHGAhj5l+tH42A6np7QyQv5qb85CTWI3jB+hH+M1xCy+p7hb8qNWHZWrYcYXnVOc1qbu59spWTXxczqa6BCDbL+4vjIpYO46E4LKBhPOo9iv996RVeaU9o2/Uf9mCFIbZCrY2TruNThhqlz1CzrYagKx+WINRf8WOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146652; c=relaxed/simple;
	bh=K0OIUszuQgUsrQ5HyXT1n6dV6uBXP1gTaeGpcIJQpFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ed1TQikVE+bfaViqv11TV2h4ZiVddhB5ZsGN6in31oSDwwpUN3z4g1T/PhvwqfYR1oT08Mth/DPWSP/viDDMcN+xj8IJMu3SfMUWwkmhlW74iXDDBU6JmlguMTlWq8HKr1YHHfSTfmtS64tJ8Sy1G0uJMy0U9retIxEUgiW8ghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so8111990a34.2
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146650; x=1777751450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VnXr/jzwqEDsGXW+QC8Pss1CT+aHwUpMjIqrf83mbHw=;
        b=Tldr5BIGEBedJ1sWH3X0/phpMCHG3iWvx9AJDow0SUxtBsrRSq8Z2VzuE6RP2NKgj0
         SD0iYWesz48rUzHYqy3gd1yCMHBApqq8WEVgNnmx76bvsOxBpfCTIrzwY/HvN4JHfqIF
         ddkptGct5qv/pp2EotzltFLC6JbgmZ5rUWb52nKO7L2uH2hJMY48wXwKVWvrI6CoCEOa
         /VQHBvmAZ7grYM0cR/hLN0YQpMeelFxwGA22L22P3OZwHSOn3DSfZ29tNMeaBQ+Uj4RP
         4J8k2YdmP9/B111cbuJfjxtFRf2zPDuyD9VMADYGb/3Q9I9KbxZ/XiWfmw1+5JuxLPxd
         gP+g==
X-Gm-Message-State: AOJu0Yxhd9lWlXXcbOHsteSRrEmnt2BEQSBfiW4rkynSGA2UDPHPyEgY
	9C69N8M9DT4S2xb4RX+0R7/a4gYeSeOh97/TH8Afy27kIRQN8dVVRxBL
X-Gm-Gg: AeBDies+vRC+M2fSABhoeiBz0P1XboTbDGGPgkdNuLyhVDUI6Y2Nx7eiM+mTCXqPJV1
	mZKlUwjpUZcsHqlVGrdeZg1ZBgxpRL0MzSjIN3NBp0sDa+m7LlcQaUIqv1tMqyrXsPjgxgpQDkD
	Uo+p3yztomNUUqNz4AcixvSWn5dpkUJO4y9763e0vd0d7+ARwSzwE564Qdmlz0gCX74m5vpsVX4
	ibQUQl30Y6T6r5aBh4L4ndB/UWytYyqeO/QTSCtW04iAxnz4Jc7Nq4AGhy5b+lGm4P3C+Gpief8
	N7K1WBzUN3hXHV85p/VdcxfaIvaoLDpbEfleT9eOt485wkdKg3u2YG9YuhU4cXoId2pmMS71Aef
	xoP1tiq+XY9XBTaOmEHvl2e7mP+ShfAPeZ+r3v7vE5ci3C5iYyCJrvtYG3tnf40cvY2oyexNdTO
	81d/i9r8uE1EqTausmF0us5pQ0V9tCbWhUKptjKym25CLmHdl7wxJSRVlbyiRFWrXDBZi3py+To
	A==
X-Received: by 2002:a05:6830:411a:b0:7d7:570b:6800 with SMTP id 46e09a7af769-7dc951fc052mr23530525a34.23.1777146650499;
        Sat, 25 Apr 2026 12:50:50 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:50:49 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Javier Tia <floss@jetm.me>,
	Marcin FM <marcin@lgic.pl>,
	Cristian-Florin Radoi <radoi.chris@gmail.com>,
	George Salukvadze <giosal90@gmail.com>,
	Evgeny Kapusta <3193631@gmail.com>,
	Samu Toljamo <samu.toljamo@gmail.com>,
	Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
	Chapuis Dario <chapuisdario4@gmail.com>,
	=?UTF-8?q?Thibaut=20Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
	=?UTF-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 04/21] wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
Date: Sat, 25 Apr 2026 14:49:54 -0500
Message-ID: <20260425195011.790265-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E8B94678F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,jetm.me,lgic.pl,gmail.com,humeurlibre.fr,mediatek.com];
	TAGGED_FROM(0.00)[bounces-35301-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

From: Javier Tia <floss@jetm.me>

The sta_rec_eht structure has a mcs_map_bw320 field, and the channel
width mapping includes NL80211_CHAN_WIDTH_320, but the 320MHz MCS/NSS
map was never copied from the station's EHT capabilities to the MCU TLV.
This prevents negotiation of 320MHz channel width even when both the
hardware and firmware advertise support for it.

Add the missing memcpy for the 320MHz MCS map, matching the existing
pattern for BW20, BW80, and BW160.

Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 016c534f748c..f403d9d925e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1667,6 +1667,7 @@ mt7925_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz, sizeof(eht->mcs_map_bw20));
 	memcpy(eht->mcs_map_bw80, &mcs_map->bw._80, sizeof(eht->mcs_map_bw80));
 	memcpy(eht->mcs_map_bw160, &mcs_map->bw._160, sizeof(eht->mcs_map_bw160));
+	memcpy(eht->mcs_map_bw320, &mcs_map->bw._320, sizeof(eht->mcs_map_bw320));
 }
 
 static void
-- 
2.43.0


