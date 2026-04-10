Return-Path: <linux-wireless+bounces-34636-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLeRFPhL2WkMoQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34636-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:14:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDD23DBCD3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C473230048E0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC82D3EC1;
	Fri, 10 Apr 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="WFE9Ocza"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CA344DAE
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847845; cv=none; b=CCfoSG6YQ3rDUPGEYBFgF2A0ibUErpDZLTIYALEJ9Q0FJYauQRZDzh82ryt5dGHmPJvzhLyfIBJvZZtNz0P0ZSBqyJP14E3SoUplLz5MBgIncMVoikpJNRR9bBMmzdDmkd3ujQy3nSX41beXpDrvmyrVyhdGZMRC0sSk3vjGGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847845; c=relaxed/simple;
	bh=VVretd6NIYdYD7LBdovVwjBf0LhDinlQGKm+Zj1TK6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ4ltr8hcI2EY2iEmhK+ioqhs3icrynuII0FSBGxRG4iHDPQ9deFgif35Ys8+yuFTMv3wW2qkWRLfzFWSwPr9YAreiyDJsA43gwg8FsjDMqwjcbe+TVecLQCxPS76TfNGahW60Xl1gz5t2DKFhoR5AlWrJgRzG4bj3sAMi52QWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=WFE9Ocza; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso28562785e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775847842; x=1776452642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nl5vKGelj6wqbIZKUJ2xFWGiK2/2/6FveNLNKf27LA=;
        b=WFE9Ocza+1HVR0+l9Me19RbRQwHJK6odR7sqfr4SrF0tswPK2cvrMzTQiNhkOTD5U8
         NdIcLv/GbTNftaXLLY4NY8O4HdUIkDZvr3JuViX696/QCnn+PslDYDJnHvuA3DE8Kp/R
         0Ex6cJxOJWmig0ruMM1akx4WvPuvF66ybzvkIORnMeXUFvJL/YUIBAK3H2Jcq99AOB/n
         mNWBwd5eHTVDSMYZ9XuIr0s/R0WhcRP4pxVl5xkUO4OJQOwurQdkY5z2GEEK07btDZ4o
         iY5ZN4Eagi7D/QKtDthjrLHNgOpWQ228h8D1ZTiqSZIfH583bS1aDiiUEq4Yigfl1hSq
         7C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847842; x=1776452642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8nl5vKGelj6wqbIZKUJ2xFWGiK2/2/6FveNLNKf27LA=;
        b=Uslolfu7414O6LUUq6uIiGAAL213HzyrLe/mVasc7OeYDDAWW7iyAkRL/Z220F9RRO
         bILYxuReIxkBvyComK2tYRrPWzofe58PAhnznZ9wX4gxxjLddzJoEmRNdj4KycfA6iKa
         gpsgr1iJvm4C8icIJgxRvSjYX0ilx8LoDRyKeIPx8Uqoyoi8t7B1pdJSHPAsjwFMyP8B
         EqViBOuivUwgJpn6F7+aRelpFqDssq9HCQ04ZgpUyisrcRcL0W/bdT6dlQfPMzZ9Gq9q
         ZIAVEuyPypywTLFLJdVKqpU0qnj03BgfWr49rO7mRpLMK+Z8fBgenpm7NRj4cSPL0Nb1
         mBXw==
X-Gm-Message-State: AOJu0Yyy6gAsJ8kZmuswjy9+Q0+7sflpyCf0r1PJ/OeVB+XPRMZNxM4q
	ji1X7j+nAf/9RdGYzi/fZyQwPeLbr8MWKejfHLVeWzRUhQ00RMQOepv6Iv5trHkJEkep/wSRJQS
	xT/fP
X-Gm-Gg: AeBDievO5DElr46X/X5+iq3j6/4DB5Yr0XxTiBy8g1dO8JSGRfnyaknCI93tKwxGsn0
	ReyRkrdl555BBB1EYEYZpxbOFw1MCV44z/zSR4GtvK6an47wJiMi8Up+8vls0Va5+LwSMwoSPuH
	E02hSrocc6QQGCRshGWBh7YLOZ/6GWX+2bGolAhItd8/dRW7RhIFCWLygay0UlVNClN9c42Bx3n
	sV31uqzN7dwPz1Jhy+vL9EwOQbRI27pCnxPtH9al23iNUPO21ZtWaQwJ/+FA7ZB5pp5HL/jrSa0
	WAPPO3JJlS54KecYTbEIzJU2ht1mLau/JzAP9vtg5RD+CHEsQrUs5ykzw8DvqzjCYNRgjD0O6Vj
	qbw0ZtVonQUaDLEd/oLVc9KML0v3LfThKDgOqgjHZZRBD7b29+h/tpfZhY4dUmxHqZRZP7eB6gT
	4eG4ldtdzVACoh27KgsFEIELj0ZfP/8JUGGMXg2Da5T6joGtum85fAmuDkDOV9ZJm5ODqtsVZDD
	fABvoUYtt+N
X-Received: by 2002:a05:600c:609a:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-488d68ae78amr57301335e9.9.1775847842051;
        Fri, 10 Apr 2026 12:04:02 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm38909125e9.1.2026.04.10.12.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:04:01 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [RFC PATCH 5/7] wifi: ath11k: do not read band-dependent reserved bits
Date: Fri, 10 Apr 2026 21:03:52 +0200
Message-ID: <20260410190354.394742-6-pmartin-gomez@freebox.fr>
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
	TAGGED_FROM(0.00)[bounces-34636-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 9EDD23DBCD3
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
 drivers/net/wireless/ath/ath11k/mac.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a48b6bf1f29a..eb3dc5770077 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2383,7 +2383,7 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		return;
 
 	arg->he_flag = true;
-	support_160 = !!(he_cap->he_cap_elem.phy_cap_info[0] &
+	support_160 = band != NL80211_BAND_2GHZ && !!(he_cap->he_cap_elem.phy_cap_info[0] &
 		  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G);
 
 	/* Supported HE-MCS and NSS Set of peer he_cap is intersection with self he_cp */
@@ -8683,13 +8683,14 @@ ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
 }
 
 static __le16
-ath11k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap)
+ath11k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap,
+			  enum nl80211_band band)
 {
-	if (he_cap->he_cap_elem.phy_cap_info[0] &
+	if (band != NL80211_BAND_2GHZ && he_cap->he_cap_elem.phy_cap_info[0] &
 	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
 		return he_cap->he_mcs_nss_supp.tx_mcs_80p80;
 
-	if (he_cap->he_cap_elem.phy_cap_info[0] &
+	if (band != NL80211_BAND_2GHZ && he_cap->he_cap_elem.phy_cap_info[0] &
 	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 		return he_cap->he_mcs_nss_supp.tx_mcs_160;
 
@@ -8740,7 +8741,7 @@ ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
 	if (!he_cap)
 		return false;
 
-	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(he_cap));
+	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(he_cap, sband->band));
 
 	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_mcs); i++) {
 		if (mask->control[band].he_mcs[i] == 0)
-- 
2.43.0


