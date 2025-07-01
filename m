Return-Path: <linux-wireless+bounces-24707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E843AEF03B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FFC3A800B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4A2153E1;
	Tue,  1 Jul 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="0QSRVBze"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476F1EDA2C
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356569; cv=none; b=nIgN0QXJZYfpX+mM0zJfkOulqlnF14is3zJdm+gFFbUv+iskLlKJzUzxEtNFgTCeFVAAJWjxl8rvLwgbv9+to81FkOxSecAF3r9JjJoVh6ZdD+iUR52Z4VVEQhTgCwGyHRtBIpil0vw0DfQsCtsBJROQHuHcGiNXOBn80r4V95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356569; c=relaxed/simple;
	bh=bY30+dpbsb62QWHkSj024afU2V3GPfpY4Y+3mePJysk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBDiP750pPOKgioQK2dsDl8HjHiTGB+sY9YgPFmJNDB0iRpchxUvJiamHTyyoCNZ7BqTw7OzrtlAOQuiQFTm9n53YACXP568goqvmYkG1lucsOheqt/XM9TmCAoTR43pM3bLjhEKoUO4IOkBZ1yIFa3MH9igXZ/7C5XopxYO90I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=0QSRVBze; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so5164044a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 00:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1751356566; x=1751961366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bCEuc0YRMzKBQuz6gwErk9ZkGfh+M3H/2hCNgUcVu54=;
        b=0QSRVBze8jCVfjiMDZqoDkzlHJ0NsaSBmpGkHuui9RqRTXPgjJZTZqd7unB6sJJcrz
         yNCkrmbZBNRT1E3lbn2e9RPv71lxbOdvFj95lA2alrAX3D+n6H0Sc6/ghzTuXsa3Q9dr
         rd2D9tX4CpC37PzYcmJ9I63aQ8np3eNrlXWQx/TMXGXN8sAv7vC9qXax3GNHcQtWkJtp
         5juzeRymc+qkmsZAHXB/FHKPRQx2fnhFTfA8GBUySAgwqLpnJQOtkEf4bXWYC1cfL0vr
         ZYT2FqxotbmM7fqsvn4ti9V6rA1sE9ELrIRZmvcie5Y+jyGE0GYf71aH54C56PqeHCxG
         wFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356566; x=1751961366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCEuc0YRMzKBQuz6gwErk9ZkGfh+M3H/2hCNgUcVu54=;
        b=nsHA340AF1rB78O3ogSFbVrDEpN3q61pyLDSkGZY/G+cn1IZ961F3jX+qZ1J4TwJzG
         NoRkOCKF8ekNqRhwGlFOjtgTbSz4uQK4+Cw4Y8kH77IZFyySJ8dvWdNXSjTlOGoqOLCi
         Ao2WfXvjnxB8/YZdPFF4LSeVMRb9dUmE0AwevRLk+mbEWFuCsMTh0Kar26Mu6K1rINGC
         edU8fsLqfxzXttfGIfqF9gIXKJk2w4ZMPCrnTF0SVMKFUQaNM1jFzzqB87y/HH+nu3II
         4LbxFkoiNjt23pe4drkfEWcOz2gh1EvrVU8vweyCZ4S61ybT4W3zYkAkzjCspYnpmd8V
         M+Ag==
X-Gm-Message-State: AOJu0YxiJyVFeh0C6v0a2vvzqOxANhZM8P35scoc9PKkmp5DIohcxsTV
	9QEw1XYdggqg8f9878BBYukQdVhNvcIKyHPUe7gTdzGFFg+bGbFB66+4g1MHXx5qQHwhctaGw3S
	4/qvD
X-Gm-Gg: ASbGncvjkG3oOTfPlQ6cDZ5cPuVQUozQ4Dq9NSzjCqt6kkfOwKJyYc7PMgGib7bkUwS
	UxShC2vLG/8wm/Y+keBCE4TdCi3lsrjd3v61AZDQ8c7iwbRViiTccwk8fCJwkx5+GSH24kQVzYl
	g7YuUQhyU7TjorDnfQULjoYRcH//hMF4Nu4tVCyR//3olW0iFMfOGtw9swUIkohAeVHYnHl9nWO
	TSOx3qZjMmXZy45zBlclC8u01vi/Yzn5eubi4QaCAZjZuKVQee5wwqTvw1n8TzP1NVcg+JDvfTP
	i4VTcr4on60wmeNOGSCEZXTxk4+GD7Keway601ziEgo3tsKxzXuKCS8zFf988nndjZx2tjGOQ6s
	SSfU=
X-Google-Smtp-Source: AGHT+IG61pwxDG4hFWlMQC9puOfo4jVTcSlE0Qb22tOSaQLrYwAJ42ccQGik81BNNClPcPnYBGwxSw==
X-Received: by 2002:a17:90b:2ecd:b0:313:db0b:75db with SMTP id 98e67ed59e1d1-318c93252f0mr24927759a91.33.1751356566167;
        Tue, 01 Jul 2025 00:56:06 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c1502b9bsm11183439a91.42.2025.07.01.00.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:56:05 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Simon Wadsworth <simon@morsemicro.com>
Subject: [PATCH wireless] wifi: mac80211: correctly identify S1G short beacon
Date: Tue,  1 Jul 2025 17:55:41 +1000
Message-ID: <20250701075541.162619-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mac80211 identifies a short beacon by the presence of the next
TBTT field, however the standard actually doesn't explicitly state that
the next TBTT can't be in a long beacon or even that it is required in
a short beacon - and as a result this validation does not work for all
vendor implementations.

The standard explicitly states that an S1G long beacon shall contain
the S1G beacon compatibility element as the first element in a beacon
transmitted at a TBTT that is not a TSBTT (Target Short Beacon
Transmission Time) as per IEEE80211-2024 11.1.3.10.1. This is validated
by 9.3.4.3 Table 9-76 which states that the S1G beacon compatibility
element is only allowed in the full set and is not allowed in the
minimum set of elements permitted for use within short beacons.

Correctly identify short beacons by the lack of an S1G beacon
compatibility element as the first element in an S1G beacon frame.

Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
Signed-off-by: Simon Wadsworth <simon@morsemicro.com>
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
The patch referenced in the fixes line was targetted towards cfg80211,
but as previous patches removed the other code paths the only remaining
one is in mac80211 so we target mac80211 let me know if you would
like it done in another way.
---
 include/linux/ieee80211.h | 45 ++++++++++++++++++++++++++++-----------
 net/mac80211/mlme.c       |  7 ++++--
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 22f39e5e2ff1..996be3c2cff0 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -662,18 +662,6 @@ static inline bool ieee80211_s1g_has_cssid(__le16 fc)
 		(fc & cpu_to_le16(IEEE80211_S1G_BCN_CSSID));
 }
 
-/**
- * ieee80211_is_s1g_short_beacon - check if frame is an S1G short beacon
- * @fc: frame control bytes in little-endian byteorder
- * Return: whether or not the frame is an S1G short beacon,
- *	i.e. it is an S1G beacon with 'next TBTT' flag set
- */
-static inline bool ieee80211_is_s1g_short_beacon(__le16 fc)
-{
-	return ieee80211_is_s1g_beacon(fc) &&
-		(fc & cpu_to_le16(IEEE80211_S1G_BCN_NEXT_TBTT));
-}
-
 /**
  * ieee80211_is_atim - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_ATIM
  * @fc: frame control bytes in little-endian byteorder
@@ -4901,6 +4889,39 @@ static inline bool ieee80211_is_ftm(struct sk_buff *skb)
 	return false;
 }
 
+/**
+ * ieee80211_is_s1g_short_beacon - check if frame is an S1G short beacon
+ * @fc: frame control bytes in little-endian byteorder
+ * @variable: pointer to the beacon frame elements
+ * @variable_len: length of the frame elements
+ * Return: whether or not the frame is an S1G short beacon. As per
+ *	IEEE80211-2024 11.1.3.10.1, The S1G beacon compatibility element shall
+ *	always be present as the first element in beacon frames generated at a
+ *	TBTT (Target Beacon Transmission Time), so any frame not containing
+ *	this element must have been generated at a TSBTT (Target Short Beacon
+ *	Transmission Time) that is not a TBTT. Additionally, short beacons are
+ *	prohibited from containing the S1G beacon compatibility element as per
+ *	IEEE80211-2024 9.3.4.3 Table 9-76, so if we have an S1G beacon with
+ *	either no elements or the first element is not the beacon compatibility
+ *	element, we have a short beacon.
+ */
+static inline bool ieee80211_is_s1g_short_beacon(__le16 fc, const u8 *variable,
+						 size_t variable_len)
+{
+	if (!ieee80211_is_s1g_beacon(fc))
+		return false;
+
+	/*
+	 * If the frame does not contain at least 1 element (this is perfectly
+	 * valid in a short beacon) and is an S1G beacon, we have a short
+	 * beacon.
+	 */
+	if (variable_len < 2)
+		return true;
+
+	return variable[0] != WLAN_EID_S1G_BCN_COMPAT;
+}
+
 struct element {
 	u8 id;
 	u8 datalen;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2d46d4af60d7..7ddb8e77b4c7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7195,6 +7195,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	struct ieee80211_mgmt *mgmt = (void *) hdr;
+	struct ieee80211_ext *ext = NULL;
 	size_t baselen;
 	struct ieee802_11_elems *elems;
 	struct ieee80211_local *local = sdata->local;
@@ -7220,7 +7221,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	/* Process beacon from the current BSS */
 	bssid = ieee80211_get_bssid(hdr, len, sdata->vif.type);
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
-		struct ieee80211_ext *ext = (void *) mgmt;
+		ext = (void *)mgmt;
 		variable = ext->u.s1g_beacon.variable +
 			   ieee80211_s1g_optional_len(ext->frame_control);
 	}
@@ -7407,7 +7408,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	}
 
 	if ((ncrc == link->u.mgd.beacon_crc && link->u.mgd.beacon_crc_valid) ||
-	    ieee80211_is_s1g_short_beacon(mgmt->frame_control))
+	    (ext && ieee80211_is_s1g_short_beacon(ext->frame_control,
+						  parse_params.start,
+						  parse_params.len)))
 		goto free;
 	link->u.mgd.beacon_crc = ncrc;
 	link->u.mgd.beacon_crc_valid = true;
-- 
2.43.0


