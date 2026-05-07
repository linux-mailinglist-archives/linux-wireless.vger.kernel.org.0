Return-Path: <linux-wireless+bounces-36050-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPT6LL3w+2lfJAAAu9opvQ
	(envelope-from <linux-wireless+bounces-36050-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 03:54:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B24E21E0
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 03:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AA533001FE7
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 01:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F118C332;
	Thu,  7 May 2026 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSXnyQQ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08911175A86
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118843; cv=none; b=ZJYBgYieERcL/EE8yAGRt3BEi/LR/dYhVJ7lmiPj3keyItsimdumxdih/nQQs7+0Eb+UJRVh2lj3t/eqY3sgO+xX7cRxgsYunOAd+I8ypvGO7botjKKVI8mX8I5vJvKElLRYES2giyJWDfvrVHBLZf0h2SaK1jHtNkwkiRocSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118843; c=relaxed/simple;
	bh=iq5fnJ+HOg6MFBgiYIyJchfdy8io4wsdSfzLklKWctg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YsENprG8x9gLVFzpA1k2CGAq/A4CN3RwduxOQIWL8NiH3W/FYSJ0/CAqOvuMTS3xnC2RmMnN7iNVQe/aCy7joYVouD9kMCA9KhcQjuTugmILalw86J6kB08KslfyE7B59C6pauTm8+aLwNfFQLLgA8ADzW0dFUwm8vbDe6pi9J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSXnyQQ5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8025aecc40so128387a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778118841; x=1778723641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBhSoKKWUqXo8+LRVDmtBG4+Ndb/qncanTXygRC1tEs=;
        b=HSXnyQQ5Eo3MTY9MdNtUTMKMp6OTMeLmu18mA2b2pMW8JeisHofgzte33TA+87M+s4
         dBvTbfm6nUZOOJxU/MYztEWNk2//jWRu6oa5gNxLHMIVwkai3V6SzfvvTuMtnSgCmkgY
         zadral5f7SEUponwSEa5UgKeO3kUlwB6eTZEMkWQ92qxi3SO/Q/JFtRHLZbJOWcmghoU
         A2uyRb7Xh+hYinnMI3vCg/wxV/PGUVgzDC9Qm+CpI/4Qen4SE5IS4CqOTuof164lLhMc
         UPQNjO4fVI5opeEjvAyc/SaPPxTVbLZBIp1nfLIboT69/l4o8Ri0MHyxqQUBbkdfV0XC
         WYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778118841; x=1778723641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBhSoKKWUqXo8+LRVDmtBG4+Ndb/qncanTXygRC1tEs=;
        b=Dw1HvMetN/McPGTKQ8pVawp1wAMLcSvE0k+IGfTCgegaTE3q9R+Lr7fRrOGAVaiGFD
         MSv9r5WNgvlQd7svtMRzcbRkriDgUzMXJc+10tIdP1nuJphDWk2jd49TpNSOKkkmLFyy
         6ETAkAp2QDQtEvL4wTDbjrofhLMWqRzvfLyTo1WOzfJeJLZL3XvbosSWdyKDZO+ZsKih
         uitLirVWUUg1ZbsOGQ//5ZEzuvZXcgeQqkA+Q3+NWQ/S9CeppK+s3VdcRwHLe2iQ57jN
         RN+g8jnIWIdRuKFRg8TZAa1sw6dpmQeg9mZ16DEGk0YpituEmUWwXTs4QeFEa7OEe/g0
         1oRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ehq3XYFRYPV6l+CQSl/TRpmGZjxDbVqKDXjmshYPY6faEq5F3ReDLmROR2XsC/rZa4u+T9pE8kkpw8g8LMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60g6z/SDXR8BvHIKmcBfie3a9cNbHJo8YT30FTXTKkJiYfbUo
	aQw/wX78BMrTjn0H8Rwk2JQqlhOkABcfngDzjidTw5IxQ7Dl13p244YcUYnrsA==
X-Gm-Gg: AeBDieshZX6qEg6FA2CnMriSXbHM4TwCSGZL62ThI/zXyoL++G1h3D5Dbpdss2pcl3J
	T6ZPWIOmbazLK/ZvMfKAGY7HYlzW2Y9C9Fo6qzw64yxo326aA3qJOfw8XdvTcKpKu63MOMi9cUU
	ERBQci3TIM4bIhha4YTqmmgWihbq2Z3S1zW7Bdi3C98S7YxVHI3MUNRcCtoThaO6QXguR3AfigE
	l+tZX7OIfNBElOlzqcpIlzr9IgHn1gQjJbVURq25wRxn++V3lMB+kpQLu+sW8kI3zt9rBGXfkhm
	Ba3aNXsmVehIey7PuYwJc4DgWzEpLClc9uIx/u3zY3DyH3vbXO1Zu3Mhy7GtwXprpjx0h0pr/au
	qPMz+tTsWMOZajExJgjbppmYCn38N5G+z5RlbmXmZuakTb/uqgWY496ugWm7SeFHU1mMbUQjQz9
	RVT9ZTCHCaEae9vldyaBXVc4n7P1hcvmD/nnnd
X-Received: by 2002:a05:6a20:12cf:b0:39c:2d2a:632e with SMTP id adf61e73a8af0-3aa8bebfecdmr916136637.11.1778118841282;
        Wed, 06 May 2026 18:54:01 -0700 (PDT)
Received: from kwan-H610MHP.. ([180.75.11.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82537949c1sm426455a12.12.2026.05.06.18.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 18:54:00 -0700 (PDT)
From: kwan1996 <laicheehou9@gmail.com>
To: ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Cc: Kwan Lai Chee Hou <laicheehou9@gmail.com>
Subject: [PATCH v3] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode
Date: Thu,  7 May 2026 09:53:35 +0800
Message-Id: <20260507015336.14636-1-laicheehou9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E1B24E21E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36050-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laicheehou9@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Kwan Lai Chee Hou <laicheehou9@gmail.com>

In monitor mode, the driver incorrectly assigns the legacy rate
to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
frames, ignoring the actual MCS value parsed from the hardware.

This causes packet analyzers (like Wireshark) to display incorrect
MCS values (e.g., legacy base rates instead of the true MCS).

Fix this by assigning ppdu_info->mcs as the default rate_mcs
in ath12k_dp_mon_fill_rx_rate(), and remove rate_idx assignments in 
ath12k_dp_mon_update_radiotap() to preserve
the previously calculated MCS values (including the HT NSS offset).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220864

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ

Signed-off-by: Kwan Lai Chee Hou <laicheehou9@gmail.com>

---
v3: 
 - Simplify rate_mcs assignment logic in ath12k_dp_mon_fill_rx_rate.
 - remove rate_idx assignments in ath12k_dp_mon_update_radiotap to avoid overwriting the HT (802.11n) MCS calculated earlier.
 
v2: Fix indentation and formatting issues in v1.
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 39d1967..79347c3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1910,13 +1910,14 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 	bool is_cck;
 
 	pkt_type = ppdu_info->preamble_type;
-	rate_mcs = ppdu_info->rate;
+	rate_mcs = ppdu_info->mcs;
 	nss = ppdu_info->nss;
 	sgi = ppdu_info->gi;
 
 	switch (pkt_type) {
 	case RX_MSDU_START_PKT_TYPE_11A:
 	case RX_MSDU_START_PKT_TYPE_11B:
+		rate_mcs = ppdu_info->rate;
 		is_cck = (pkt_type == RX_MSDU_START_PKT_TYPE_11B);
 		if (rx_status->band < NUM_NL80211_BANDS) {
 			sband = &ar->mac.sbands[rx_status->band];
@@ -2259,13 +2260,10 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 		rxs->encoding = RX_ENC_HE;
 		ptr = skb_push(mon_skb, sizeof(struct ieee80211_radiotap_he));
 		ath12k_dp_mon_rx_update_radiotap_he(ppduinfo, ptr);
-		rxs->rate_idx = ppduinfo->rate;
 	} else if (ppduinfo->vht_flags) {
 		rxs->encoding = RX_ENC_VHT;
-		rxs->rate_idx = ppduinfo->rate;
 	} else if (ppduinfo->ht_flags) {
 		rxs->encoding = RX_ENC_HT;
-		rxs->rate_idx = ppduinfo->rate;
 	} else {
 		rxs->encoding = RX_ENC_LEGACY;
 		sband = &ar->mac.sbands[rxs->band];
-- 
2.34.1


