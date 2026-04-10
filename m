Return-Path: <linux-wireless+bounces-34635-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Oe4AOlL2WkMoQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34635-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:13:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 505343DBCCA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B5D301981B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD48346A10;
	Fri, 10 Apr 2026 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="RBABfDCm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4221D3D2
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847844; cv=none; b=JpZgoaApMZU99Xm7TgdR3+J3NGwmWircnpyBvBgcD8KOd2+BnamfyE2+64VcxGuK20lafgu8Qz12EAkk2/rIRfddUGZAOXmtI0htpR65A789DOskpZZn8FyT8atCssPgJtpU6+1T39w+6apLj0Vu4w5lsnIISRQPC3BKGOJDuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847844; c=relaxed/simple;
	bh=Qo+trgUjNE6IFWsBlynCcIz/wvBEWGwdRwHYV/0nCow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6YT2K1ctxc2U75eTW+BcXp+ZgH654gxagaQULf3dl2OTx2WsX3lz1QZfWAnXnx8d765o5uK7Wc6PlZdsx0kvyWT4opGIpF8DHs3k/aQDUXudYgg0Txj+F1BZsgwsUCX9iiCJgC/8ZpuHFQCWEhLN02OwKstEOw0yIFTI6nnpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=RBABfDCm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a041eae5so17095155e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775847841; x=1776452641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+pshmFJ6CTlLQd5Fr8Lh64RLOT5KAvW5xjdfQvtP+4=;
        b=RBABfDCmOL2zsztT5ixaoPTTvDZu4tyLTuqbz7EH7bgAg2X4tdOYfvv3WUfPfCkuBG
         U3skx+xV+pQ6CxGgLySGqS7Fot1euwWtZ0k+8Snz8K/9ypPrpT3HiMnqCgI/PUrm0AY+
         cbWTAbPqHFsfUZZaceQ2wpm3zaZLXdyxU/EBf3OOzEEtf9/x569fPltTcTFlco4SkDoq
         ifmfVw0AFV1TF9kQgklWukQJYCnX2UQE7jVw0Lo6LC8vy/M9aAfvEbOod85u1FyoP+Jp
         9HNkxTm5QNaZEmhQ4jaXQXGXTXbCAKs0MCVOevbqhEp0cmkIlgtjjRCQUA6hY0OniA3u
         VW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847841; x=1776452641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+pshmFJ6CTlLQd5Fr8Lh64RLOT5KAvW5xjdfQvtP+4=;
        b=bIYEJjxn9jg7/C2hhy4MSHxQIek0ekoJQ2SzFOS7ZJPZvYcseD4sBO/j7XjhKQB/iK
         JqJ3ZcwIRxzalXNzNOSOrQxqmGatuUiaqfuwxPPK+I0dawlKRHtAXvkUztPmD292hMcf
         4Q2qvLsEypmzGG64kGNZWsv4Z4JKuO/yDiYMLC2AUOWtXsp2rpNOmJO698q8Z8nKqyh9
         s2v/o89KcbVJbmfROOaDnFlmlcDhf4hrwYFiwtWL3bHXlLhBqpbgmHfucSWTZUuThTVZ
         CKIu9OMH/GBSwlqM24ejtM4MclP28d6QbU8+ODnyRInr4J14CcKg865rO5HXkKfjCMgH
         zzPA==
X-Gm-Message-State: AOJu0YzaO/PDbOIdV72vhmOOi1kP/rG9ZlKdefkaYVU51ZOrGK9BrERz
	qNEfuJZ2nv1W0e7IDd6PBdy0GGKT8aoHb+VLntPNyVi7EyJl2Yfm4VPhUI0nSUnB5vI=
X-Gm-Gg: AeBDievW5B3y9KF5nry8ncWc89VJXekvinqCvvHYCkEEMr4qNTWzgS2TNuglzcwrHJC
	prIIizP/2bmEyhka6dTXWUd24rz4lAnyncb+LmDrBq3UyMtuQF1iSAxKg/Ov35ktpq4/d87mWp0
	yqhceG2WVWJ30gAy6VE3x0ybbZHbu0b6aAFbd+GUvTO8Nj42RlqyoMSWKJH8jfpuBjSolkXfbez
	ZVGgMbL6vVR10TdPc0mWp41wKQSVQS+jYCg1t6NP6YK+ggO2hIB+KJ5jc8oZfKRm61A+V9Jtme5
	AyeeuOhlImrMPElDq91nnfBoU3DOvyaSJvyl2oioQDl/4s4vtRTkc5LRq/KCbxHfKUu0fL5esqY
	Oe4/tKFOJUeVbFjpXprom1OQui9dEvY/qHcRMz1lwItMIEp52AJ+hPCwl3F2Zxy0+5gRQ9U/uSK
	j3xaFBgdD13G6Rhenao0/fthwcDuJ9CNCT9+5nS6xyjEUbd5r8t398VTU70QFa/KMW0CLWilp46
	slxpgW9wwQj
X-Received: by 2002:a05:600c:3f0e:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-488d67e6973mr56942655e9.11.1775847840963;
        Fri, 10 Apr 2026 12:04:00 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm38909125e9.1.2026.04.10.12.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:04:00 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [RFC PATCH 4/7] wifi: do not read band-dependent reserved bits
Date: Fri, 10 Apr 2026 21:03:51 +0200
Message-ID: <20260410190354.394742-5-pmartin-gomez@freebox.fr>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34635-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox.fr:email,freebox.fr:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox-fr.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 505343DBCCA
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
 net/mac80211/debugfs_sta.c |  7 +++--
 net/mac80211/he.c          | 64 ++++++++++++++++++++------------------
 net/mac80211/mlme.c        |  5 +--
 net/mac80211/vht.c         |  2 +-
 4 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index ef75255d47d5..ea792660fe25 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1003,13 +1003,14 @@ static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
 	PRINT_NSS_SUPP(rx_mcs_80, "RX-MCS-80");
 	PRINT_NSS_SUPP(tx_mcs_80, "TX-MCS-80");
 
-	if (cap[0] & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G) {
+	if (band != NL80211_BAND_2GHZ &&
+	    cap[0] & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G) {
 		PRINT_NSS_SUPP(rx_mcs_160, "RX-MCS-160");
 		PRINT_NSS_SUPP(tx_mcs_160, "TX-MCS-160");
 	}
 
-	if (cap[0] &
-	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
+	if (band != NL80211_BAND_2GHZ &&
+	    cap[0] & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
 		PRINT_NSS_SUPP(rx_mcs_80p80, "RX-MCS-80P80");
 		PRINT_NSS_SUPP(tx_mcs_80p80, "TX-MCS-80P80");
 	}
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 4f3bafceb243..95ec76eda951 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -168,38 +168,40 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				      &own_he_cap.he_mcs_nss_supp.tx_mcs_80,
 				      &he_cap->he_mcs_nss_supp.tx_mcs_80);
 
-	own_160 = own_he_cap.he_cap_elem.phy_cap_info[0] &
-		  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
-	peer_160 = he_cap->he_cap_elem.phy_cap_info[0] &
-		   IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
-
-	if (peer_160 && own_160) {
-		ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_160,
-					      &he_cap->he_mcs_nss_supp.rx_mcs_160,
-					      &own_he_cap.he_mcs_nss_supp.tx_mcs_160,
-					      &he_cap->he_mcs_nss_supp.tx_mcs_160);
-	} else if (peer_160 && !own_160) {
-		ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.rx_mcs_160);
-		ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.tx_mcs_160);
-		he_cap->he_cap_elem.phy_cap_info[0] &=
-			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
-	}
+	if (band != NL80211_BAND_2GHZ) {
+		own_160 = own_he_cap.he_cap_elem.phy_cap_info[0] &
+			  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+		peer_160 = he_cap->he_cap_elem.phy_cap_info[0] &
+			   IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+		if (peer_160 && own_160) {
+			ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_160,
+						      &he_cap->he_mcs_nss_supp.rx_mcs_160,
+						      &own_he_cap.he_mcs_nss_supp.tx_mcs_160,
+						      &he_cap->he_mcs_nss_supp.tx_mcs_160);
+		} else if (peer_160 && !own_160) {
+			ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.rx_mcs_160);
+			ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.tx_mcs_160);
+			he_cap->he_cap_elem.phy_cap_info[0] &=
+				~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+		}
 
-	own_80p80 = own_he_cap.he_cap_elem.phy_cap_info[0] &
-		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
-	peer_80p80 = he_cap->he_cap_elem.phy_cap_info[0] &
-		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
-
-	if (peer_80p80 && own_80p80) {
-		ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80p80,
-					      &he_cap->he_mcs_nss_supp.rx_mcs_80p80,
-					      &own_he_cap.he_mcs_nss_supp.tx_mcs_80p80,
-					      &he_cap->he_mcs_nss_supp.tx_mcs_80p80);
-	} else if (peer_80p80 && !own_80p80) {
-		ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.rx_mcs_80p80);
-		ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.tx_mcs_80p80);
-		he_cap->he_cap_elem.phy_cap_info[0] &=
-			~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+		own_80p80 = own_he_cap.he_cap_elem.phy_cap_info[0] &
+			    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+		peer_80p80 = he_cap->he_cap_elem.phy_cap_info[0] &
+			     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+
+		if (peer_80p80 && own_80p80) {
+			ieee80211_he_mcs_intersection(&own_he_cap.he_mcs_nss_supp.rx_mcs_80p80,
+						      &he_cap->he_mcs_nss_supp.rx_mcs_80p80,
+						      &own_he_cap.he_mcs_nss_supp.tx_mcs_80p80,
+						      &he_cap->he_mcs_nss_supp.tx_mcs_80p80);
+		} else if (peer_80p80 && !own_80p80) {
+			ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.rx_mcs_80p80);
+			ieee80211_he_mcs_disable(&he_cap->he_mcs_nss_supp.tx_mcs_80p80);
+			he_cap->he_cap_elem.phy_cap_info[0] &=
+				~IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+		}
 	}
 }
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4c1e5259837e..d840177fcd62 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -716,13 +716,14 @@ ieee80211_get_eht_cap_mcs_nss(const struct ieee80211_sta_he_cap *sta_he_cap,
 	case 0:
 		return sta_eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_max_nss[idx];
 	case 1:
-		if (!(he_phy_cap0 &
+		if (band == NL80211_BAND_2GHZ || !(he_phy_cap0 &
 		      (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
 		       IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)))
 			return 0xff; /* pass check */
 		return sta_eht_cap->eht_mcs_nss_supp.bw._160.rx_tx_max_nss[idx];
 	case 2:
-		if (!(eht_phy_cap0 & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ))
+		if (band != NL80211_BAND_6GHZ ||
+		    !(eht_phy_cap0 & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ))
 			return 0xff; /* pass check */
 		return sta_eht_cap->eht_mcs_nss_supp.bw._320.rx_tx_max_nss[idx];
 	}
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index a6570781740a..8b1e4bf43475 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -595,7 +595,7 @@ void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
 			}
 		}
 
-		support_160 = he_cap->he_cap_elem.phy_cap_info[0] &
+		support_160 = band != NL80211_BAND_2GHZ && he_cap->he_cap_elem.phy_cap_info[0] &
 			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
 
 		if (support_160)
-- 
2.43.0


