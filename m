Return-Path: <linux-wireless+bounces-34637-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJp+BBhK2WmkoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34637-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:06:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C223DBC69
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFE3130416A9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB83446A7;
	Fri, 10 Apr 2026 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="jWM1C6pK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650633D4FB
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847846; cv=none; b=UbLOYwVKnvZ8ySFzwalQXXuWod5NWCCcJt3P0XTIz3fu2vsV+Emtc8W5bgvj/sRKSSecPTN7DoKYaZzeoipR2XS4Ff3hDKcxOFqIOwOjmQ5ag5iBlCZA2/AWfpPFGN/OJKNdEnw+e2m95yj0hxVvDXDr646gLyHfn6qEMdScx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847846; c=relaxed/simple;
	bh=5e+Lz+an9gIS+iAdb3O8pPciMq1Mh/fIBPEyBlOaMYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6ijPy+dMQ61YEJSzqLqSp6N7ce7M4n9pN+aQ1a2cy7SAZc+aLNpw8A2Roye1ZxhPU9NogQwCwLDklufdrOxn7CooXomLUnBEh8eaCT8ohCZsEhqSMmuBYXk4PqeMZk4yJiwGWpXiC7gtEmaCMsVLvCpAUvFNuU72SsbEFj67E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=jWM1C6pK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso23407405e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775847843; x=1776452643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nBQXlx+6S9xekUTTMSL/MT8AytbOBUSnm6kE+hqJWI=;
        b=jWM1C6pKG+Q5eO7dFrohCslz5M/bpvvc5pomXJA84Ma/i53WzsYuobSMboe5+vlQ+U
         MVDSbLwA4ELNZ0nInZQmxU/TYzQ3zAbEz09qdfXPZm1a2IjPfXilWSQfOWnBNn7RWMnG
         NXgZJa8IytlfVb4rxwwabcxs24CaAzJUUN1GGyljp0pAopP9nPqhDY3z/7U0liL5BRZu
         uIKCQu8TNkBNURVXQAVuNUUGhx5FaS5BGaJa3saj8WKlwxrfsAeUtCs9HhvaP3JxsvNf
         rInJGtZsYFVXCLfEIOjDWhvFG5g0/uVCf4GMiDOHUAIKYrAJFBJiwY2ZCsZxVZm7HSk7
         qysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847843; x=1776452643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5nBQXlx+6S9xekUTTMSL/MT8AytbOBUSnm6kE+hqJWI=;
        b=BrGU1jqEVCk8QNSch+7CGwTRWKjYYnzd4ItQizh7Y0avOaxnbR34zzM9ZHPcCIZUIG
         haY0zkHCQXOIG+aXwM29gIk6k25o/AqabemT0hfbxOLXH1GEASakd5fNhKNhA421NMwF
         Aqf6YHskuOskWaloqVrOpSWC6A3jOWLzz7/PmdOgAXDgjJR2/rTXI5FA/AiJJvGYdj1q
         XjRPwIg8GRa899EOBD9mCSV06PRfSuarAoibhXjUbaSQ/yPP7+rqaiED7MEhhhla02Gv
         emp2OhzfBc9FUiiqV2pHGqAio+eC9w4gssIE10rr8V5HPF/sAgw6Slc/xsDMpJSztQt+
         uWyg==
X-Gm-Message-State: AOJu0YwBfaz7a0jaHrS9Pdtf5l2YJ4vwnqyJ9S7rB46dJzqDuPc8AmYB
	vz3BL4PW2hAH2l0bRMyJ93UUSZMR6/Aj2NL//YOXrQ7EAZxoEYDH7uI/ivhcTWZpIO0=
X-Gm-Gg: AeBDietIo0giMKrJCCsPxLll5tGuQYHIYspmaajHLXeIEFIXaw4aLZN9VKKiFUf9nNn
	HcDBW4d7ZPFO3hTvUVHAEpYgmpEZYQDVyX+U0nYk/mxvYDszEctasE6BfpA8ijYzFJWheoBGehF
	C7mRSs57bHXyaciVBmJclEcPo1GBpuIgbq+SQF9CDyNZHJzUoVlQVVwXCQSipp+PMoXz3qWX/eQ
	vvVHzA5Ef6FGua8E6ctu0MsAdTcU2+V4nuigS+lJ5XpkHY3cVotJ4Yfs3tZgFJAvcB3ue2fH3wx
	VRwo9opDv154jahl53TU+oK91cczDFfPX7e75KK5Q2APAd17nihDe6ZKlRotWroCidBoLTHJBOR
	OMxcw+mysniumiWgRJpXfriWc7jFgIfgVxLIwV8qhvDISkU5fBSLODDJGBJZQjI0sP35/U0hrHD
	T4NjMc/gLKMotCnlhqyfxjWQOrBRz2LM52Px7KPyTvP1Trr7eDYLrD9ZVdrWqWtE5X/++ne/vWy
	wiurRHlhHes
X-Received: by 2002:a05:600d:d:b0:488:9e43:9690 with SMTP id 5b1f17b1804b1-488d67dbf4amr46733045e9.10.1775847843134;
        Fri, 10 Apr 2026 12:04:03 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm38909125e9.1.2026.04.10.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:04:02 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [RFC PATCH 6/7] wifi: ath12k: do not read band-dependent reserved bits
Date: Fri, 10 Apr 2026 21:03:53 +0200
Message-ID: <20260410190354.394742-7-pmartin-gomez@freebox.fr>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34637-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox.fr:email,freebox.fr:mid]
X-Rspamd-Queue-Id: 78C223DBC69
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
 drivers/net/wireless/ath/ath12k/mac.c | 32 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6e4cfbb0e5bd..51b5a9ceff75 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4,6 +4,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/nl80211.h>
 #include <net/mac80211.h>
 #include <net/cfg80211.h>
 #include <linux/etherdevice.h>
@@ -8703,28 +8704,32 @@ static void
 ath12k_mac_copy_eht_mcs_nss(struct ath12k_band_cap *band_cap,
 			    struct ieee80211_eht_mcs_nss_supp *mcs_nss,
 			    const struct ieee80211_he_cap_elem *he_cap,
-			    const struct ieee80211_eht_cap_elem_fixed *eht_cap)
+			    const struct ieee80211_eht_cap_elem_fixed *eht_cap,
+			    enum nl80211_band band)
 {
-	if ((he_cap->phy_cap_info[0] &
-	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+	if ((band == NL80211_BAND_2GHZ && (he_cap->phy_cap_info[0] &
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G) == 0) ||
+	    (band != NL80211_BAND_2GHZ && (he_cap->phy_cap_info[0] &
+	     (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
-	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0)
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) == 0))
 		memcpy(&mcs_nss->only_20mhz, &band_cap->eht_mcs_20_only,
 		       sizeof(struct ieee80211_eht_mcs_nss_supp_20mhz_only));
 
-	if (he_cap->phy_cap_info[0] &
-	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
+	if ((band == NL80211_BAND_2GHZ && (he_cap->phy_cap_info[0] &
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)) ||
+	    (band != NL80211_BAND_2GHZ && (he_cap->phy_cap_info[0] &
+	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)))
 		memcpy(&mcs_nss->bw._80, &band_cap->eht_mcs_80,
 		       sizeof(struct ieee80211_eht_mcs_nss_supp_bw));
 
-	if (he_cap->phy_cap_info[0] &
+	if (band != NL80211_BAND_2GHZ && he_cap->phy_cap_info[0] &
 	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
 		memcpy(&mcs_nss->bw._160, &band_cap->eht_mcs_160,
 		       sizeof(struct ieee80211_eht_mcs_nss_supp_bw));
 
-	if (eht_cap->phy_cap_info[0] & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+	if (band == NL80211_BAND_6GHZ &&
+	    eht_cap->phy_cap_info[0] & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
 		memcpy(&mcs_nss->bw._320, &band_cap->eht_mcs_320,
 		       sizeof(struct ieee80211_eht_mcs_nss_supp_bw));
 }
@@ -8809,7 +8814,8 @@ static void ath12k_mac_copy_eht_cap(struct ath12k *ar,
 				    struct ath12k_band_cap *band_cap,
 				    struct ieee80211_he_cap_elem *he_cap_elem,
 				    int iftype,
-				    struct ieee80211_sta_eht_cap *eht_cap)
+				    struct ieee80211_sta_eht_cap *eht_cap,
+				    enum nl80211_band band)
 {
 	struct ieee80211_eht_cap_elem_fixed *eht_cap_elem = &eht_cap->eht_cap_elem;
 
@@ -8852,7 +8858,7 @@ static void ath12k_mac_copy_eht_cap(struct ath12k *ar,
 	}
 
 	ath12k_mac_copy_eht_mcs_nss(band_cap, &eht_cap->eht_mcs_nss_supp,
-				    he_cap_elem, eht_cap_elem);
+				    he_cap_elem, eht_cap_elem, band);
 
 	if (eht_cap_elem->phy_cap_info[5] &
 	    IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT)
@@ -8888,7 +8894,7 @@ static int ath12k_mac_copy_sband_iftype_data(struct ath12k *ar,
 				ath12k_mac_setup_he_6ghz_cap(cap, band_cap);
 		}
 		ath12k_mac_copy_eht_cap(ar, band_cap, &he_cap->he_cap_elem, i,
-					&data[idx].eht_cap);
+					&data[idx].eht_cap, band);
 		idx++;
 	}
 
-- 
2.43.0


