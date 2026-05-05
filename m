Return-Path: <linux-wireless+bounces-35888-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OQcxA6tt+Wlf8gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35888-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 06:10:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 592EE4C6509
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 06:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2E973013B6B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CD156C6A;
	Tue,  5 May 2026 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV39UG8I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7D3A3E6D
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954214; cv=none; b=hiEOz9IQmh7bGxM02aKsMa3b8iVmLFaPltcUcy6Dftwq0IE7F4434a00smbpa2fQAEwF0BejM8oVBcLvE/nEUyozTRsL+C1MwMAVnLXkhCvZWRzWYP6eoJ0xFr9eAIOYhjPHIkr1QmZFPJo6EMvsdrc20YgbkhFRshZvFNzMzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954214; c=relaxed/simple;
	bh=oQDoICRuvcbfMYeGXO2OIkje60SBczyK2YeG28M9Wvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJ8qUpaPhFWOQyZiMihqIz0mIeZhpQPUw4KrhRmnfMI7weYbfCT7BKhjXCcZL5QSpSCFphJeX2LLeGlVyrs2rS0OcO8pxvVQlOzqfrSpTttYUR/57PzYv7QZeV6TGYhsd6TTjVA9+DANNsnqyOUlK7T5EqqxwRR+ZG5RXdUWfVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rV39UG8I; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3239349a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 21:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777954212; x=1778559012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FEKvwvtC9Ho//T6jaZrPqgMRsDZPXlaiGIh7vpUvlmo=;
        b=rV39UG8IO61wNgbCy+suOFv/gAcDzrzctRSQWvF+xeuUcQmcf9N42SYEnU3q8B4aHM
         BDiNkYSxLkvUipx+9HLyL5i9OyfGboBIqi3f6RJ+6OYhPirsFuE8s8C/ud075J8lLn9C
         2uhD3tQ/f2hiMAHasXvMxWkkTgSPr+P/F0wKfwMn5VAh16utiBe1klmzS3t6hgd7dtdK
         5gsyZ/lQOQZE0kDehSahb5gdj/D9Wvf5DMBYNtEbTbd4o38MqD2J8dCPilYICf/qPnnZ
         lulXLmWBcf/ItAXmh9hViGrmp3Nc3dCFBdNNokLff6BzsRJyv896tK2U4+MMGWsoXDIF
         BTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777954212; x=1778559012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEKvwvtC9Ho//T6jaZrPqgMRsDZPXlaiGIh7vpUvlmo=;
        b=cemRqAi0utIUlse0YSetD8VFUUowJVKdN8zmhC8uifU8Xm0x7lu5zYmkxhCBJfazWS
         kxKd7TW04SibDCzlTn64QPLPyVzwjyA7Qnzs6Qpj1RRd0JVjRhAhYxZJljHIxVtOegSe
         4W7pAtyrYHoNlw6S4ljUG4OfcCTXWgFMhod6fQ7sNO2xFnFUPe7yUvmxL/D8kOSvRGKj
         Gg88FgHOCnaQ3yzMIt5yO6TVeTAbgRbTFZNetfO5xN8IL8cnRK0PgO+/xWNbSRH2g4Wv
         StbZ8GOegI/QP0ikqMwkav5zTu6Rl2t84ZCwF3VV9hxJt1hmHPBDNjD2o9UDg6DtR04V
         Meww==
X-Gm-Message-State: AOJu0YzmQ/II9l/arF65Z07w7QtVCUQDbC1aAoh2sOpVisF9gs2cn/9g
	hYPz45znhUNClsW6Jy+6eLGA5dZdtG7M027n5kcKMIMMtyX4yXLA3xe06aezWw==
X-Gm-Gg: AeBDieuD9FqdN9NVn9RgQOuvJDbeqtPx5nvBx98EQGlE7bUHKZlfKkr8y2TubV7w0A+
	F8MC4Od3HiYgeoiOZqjRaavxRPYw3T2cu4QfP+x309q9QKxHMg3xTUwnM12rYNkJU5azk6n1tcs
	B4GhDLVXXIZQ3IS6kiArmrvkVk1JVrw589MmfKOvgnj1qxrjdda6pAUV30Fuf6ie2h2mNTXO29w
	jVlFU0QrozkZIssqUUTbZ0JazY2D2PkRjbrZg+uoBPly24AYiz4BcZxSM3rfdJs2bjNpjckh6QS
	Tp69UJ9gP0O36hElgrl89WuF3/MY07UFBgzn08UJxdqE4SaZRwPq9fX4kB8HdbkLm145nM8P9oU
	2XEkVUtxvvyGFKycUL+n+o/b34/3wDsodpv1eRCAjFmGD5LTstDrS/XjEKr30XIbrpFyuMtYTzH
	NHAETJAiVIjSfLNNLLOme5BP1lE0RSi3gTsZ6L
X-Received: by 2002:a17:90b:548d:b0:35b:97ba:acee with SMTP id 98e67ed59e1d1-3650ce4b8abmr11212846a91.17.1777954212150;
        Mon, 04 May 2026 21:10:12 -0700 (PDT)
Received: from kwan-H610MHP.. ([180.75.11.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec737fsm13093866a91.4.2026.05.04.21.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:10:11 -0700 (PDT)
From: kwan1996 <laicheehou9@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kwan1996 <laicheehou9@gmail.com>
Subject: [PATCH v2] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode
Date: Tue,  5 May 2026 12:09:20 +0800
Message-Id: <20260505040920.57521-1-laicheehou9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 592EE4C6509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35888-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laicheehou9@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

In monitor mode, the driver incorrectly assigns the legacy rate
to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
frames, ignoring the actual MCS value parsed from the hardware.

This causes packet analyzers (like Wireshark) to display incorrect
MCS values (e.g., legacy base rates instead of the true MCS).

Fix this by assigning ppdu_info->mcs instead of ppdu_info->rate
for HT/VHT/HE/EHT frame types in ath12k_dp_mon_fill_rx_rate()
and ath12k_dp_mon_update_radiotap().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220864

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ

Signed-off-by: kwan1996 <laicheehou9@gmail.com>

---

v2: Fix indentation and formatting issues in v1.

---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 39d1967..4119bb8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1925,6 +1925,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 		}
 		break;
 	case RX_MSDU_START_PKT_TYPE_11N:
+		rate_mcs = ppdu_info->mcs;
 		rx_status->encoding = RX_ENC_HT;
 		if (rate_mcs > ATH12K_HT_MCS_MAX) {
 			ath12k_warn(ar->ab,
@@ -1937,6 +1938,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AC:
+		rate_mcs = ppdu_info->mcs;
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_VHT_MCS_MAX) {
@@ -1949,6 +1951,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AX:
+		rate_mcs = ppdu_info->mcs;
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_HE_MCS_MAX) {
 			ath12k_warn(ar->ab,
@@ -1960,6 +1963,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
 		break;
 	case RX_MSDU_START_PKT_TYPE_11BE:
+		rate_mcs = ppdu_info->mcs;
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_EHT_MCS_MAX) {
 			ath12k_warn(ar->ab,
@@ -2259,13 +2263,13 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 		rxs->encoding = RX_ENC_HE;
 		ptr = skb_push(mon_skb, sizeof(struct ieee80211_radiotap_he));
 		ath12k_dp_mon_rx_update_radiotap_he(ppduinfo, ptr);
-		rxs->rate_idx = ppduinfo->rate;
+		rxs->rate_idx = ppduinfo->mcs;
 	} else if (ppduinfo->vht_flags) {
 		rxs->encoding = RX_ENC_VHT;
-		rxs->rate_idx = ppduinfo->rate;
+		rxs->rate_idx = ppduinfo->mcs;
 	} else if (ppduinfo->ht_flags) {
 		rxs->encoding = RX_ENC_HT;
-		rxs->rate_idx = ppduinfo->rate;
+		rxs->rate_idx = ppduinfo->mcs;
 	} else {
 		rxs->encoding = RX_ENC_LEGACY;
 		sband = &ar->mac.sbands[rxs->band];
-- 
2.34.1


