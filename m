Return-Path: <linux-wireless+bounces-35887-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PncUGyZp+Wnh8QIAu9opvQ
	(envelope-from <linux-wireless+bounces-35887-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 05:51:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9DD4C64AB
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 05:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9017301E593
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 03:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074922989B5;
	Tue,  5 May 2026 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdJ079de"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41C21D3E2
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777953058; cv=none; b=ZeINTlfERCDRD7qhu2iKE7bz/VE9oHXlSv4ij4osAlWb4kfsOQg5p4Z9yjpu5QivRbUezvrq87EQdKfG7GKaeLJ9n21sz20CvmELO37+MjkIysSYgs9QKxhbUx/ijvyPJOblGMbF8YcaW7/YwKCMH45K2XX68lbnHssN5OlD9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777953058; c=relaxed/simple;
	bh=lLi/3K+k8r/ygxRpdB4DzHOUzG4DcTOrG2Abfva9ab4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UJdUmYjU/gcVXm7jh2r0TJf6fWFjdKkFe+RF1XACYaXwpj5Y7u8gdTa/76z/raG6dcKTM6HImfsimk+yl2/RmAAkjPxfT+Lb/66DBXHMiPyQX48tSRMv1DF5+FLA/RmwLHELHrfGuFXSbgZpuxqlSPDs3ed/FEivEOIe5cNcE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdJ079de; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82735a41920so1709615b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 20:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777953057; x=1778557857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULgjh7gRzncQqfUkXQITrX2NaPFkwBvkv8KtXTgFj4c=;
        b=fdJ079deMzMsZzQ8+pVsFXOsMoc8LbwvkuQcFAZc0W3KecLCcFw+WUPQMqM5hT6ZYr
         vdJHdcXtF0INuKpVECwJYlnS4WpAf8I1Sb/Z112LDStGk9lv2Fw4ObLspNjSFUfccmSi
         ApsJ60jCrLNg5LzjaOsGXV20hpT/J2JB3waHNGBqGI8zd0z66bUXV9M+/QdLJT8HW4Zq
         zw7I/tlGpdDLv+DwiVtsQPR8D8TxtSdrFxrM0htOT9eDX2wEyG3/a7o3ATLCq4S7erRp
         GCHDldora0rZfHPJRRtabXVQEj2fpGiS3Hg0mlsrtImbe3fWzMdEZkqnAxD0lpw0jX1o
         e3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777953057; x=1778557857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULgjh7gRzncQqfUkXQITrX2NaPFkwBvkv8KtXTgFj4c=;
        b=sWYVMyeArbGJrFn/UhZhmfedf3AYNDB5HLQP+ZIFptMpwICx8fUaiR1mC/qtE/w5IY
         vXlb2zzgs6aomOdFi5xZdVvPWq+dr+Zai324HkdnGwMYJFlYNrFC7CzVmfPLO+XMDk3I
         lB1xhA8QpzaNuJVWwFkcHLjOJqkgG1YoziNK9b1LuuYyWpAkqMp+KRRP1zzEj342O8fN
         JGMPfUbZc/2QzW0bD5bOEMwzLzm2jx1y48r5mNdBwvzWUtRPnktXQUGJBlZ1lVVJuMZL
         wI1zeH0BhNqkQ+n4l0zvLY+LR5fxbAlZPuPuEhBO+ccYMNjN3Qw5f87L97bpMfjjZI9V
         niSQ==
X-Gm-Message-State: AOJu0YyhNAY/BqpKrFnlMfKFQOxLQu+MMl135Mv4+LzSnB7N9f3OxvsG
	0CpQK8HaCwWOFNIXZ4e6uxw9F0pqHwR04564kOXgJPXZ2WTqn8e07S9Y
X-Gm-Gg: AeBDietYoXjJikfIo4r+BeX3Z/77TY5MnnCMp5LoeZVh5j3wH7unUguQeDjCOMhtFVd
	IGdOet0ZpglOTUYYCVQ/fkqKfG58faDbo2ICRz8ImyEf/9EJ6qB5O46FB0BRJn/T55pu3fhNm/6
	qsouSSUU3DrgmZafF5LurQ+TH+HzyxfvA6b8hcc/LJZLP+dawpN1O72djvAYg8nNjJ3TEB/DGng
	spzg9Sfuld5v3xYyfW09CLlOPrJy90zLSgiLjIPm3G3vCd1Rw9O9y5inwuOv9YIcegl6i71A077
	p5nj2lfR8Y9Nn0rIWOuGbYmrlZ7Kdn3jkN+ro9ABNT0Pd4Z/x2s0V6+g8/ol05A6Rk1rcSVNiwG
	o1TI4L2twhh0Q/hwt6zq2SWl9AATSDD2Ext2Nx8gpWLQBJml8n4f07anvwxYWe0a9CMRcGU6r2A
	T6lvYXQPoeT72BZfw5kCuC7p2UCqnb8m0WQEkzc8EsAck0pvU=
X-Received: by 2002:a05:6a00:a87:b0:837:8b75:a5a7 with SMTP id d2e1a72fcca58-8378b75afc4mr6382375b3a.48.1777953056954;
        Mon, 04 May 2026 20:50:56 -0700 (PDT)
Received: from kwan-H610MHP.. ([180.75.11.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c86b3sm513508b3a.28.2026.05.04.20.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 20:50:56 -0700 (PDT)
From: kwan1996 <laicheehou9@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kwan1996 <laicheehou9@gmail.com>
Subject: [PATCH] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS reporting in monitor mode
Date: Tue,  5 May 2026 11:50:00 +0800
Message-Id: <20260505035000.55379-1-laicheehou9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F9DD4C64AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35887-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
 drivers/net/wireless/ath/ath12k/dp_mon.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 39d1967..729b390 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1925,6 +1925,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 		}
 		break;
 	case RX_MSDU_START_PKT_TYPE_11N:
+	  rate_mcs = ppdu_info->mcs;
 		rx_status->encoding = RX_ENC_HT;
 		if (rate_mcs > ATH12K_HT_MCS_MAX) {
 			ath12k_warn(ar->ab,
@@ -1937,6 +1938,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AC:
+	  rate_mcs = ppdu_info->mcs;
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_VHT_MCS_MAX) {
@@ -1949,6 +1951,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AX:
+	  rate_mcs = ppdu_info->mcs;
 		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_HE_MCS_MAX) {
 			ath12k_warn(ar->ab,
@@ -1960,6 +1963,7 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
 		break;
 	case RX_MSDU_START_PKT_TYPE_11BE:
+	  rate_mcs = ppdu_info->mcs;
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


