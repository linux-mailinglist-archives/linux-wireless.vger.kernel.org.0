Return-Path: <linux-wireless+bounces-17782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B2CA17A53
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBBC1882E7A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFEA1BE251;
	Tue, 21 Jan 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmuKZcVL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1A1B0422
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452319; cv=none; b=sX0x14aFHR90QflT5sxmrcbJnlUk6c40pukmkKYlLYUA6LzqLP9VfldG7pKFerMUMAcB6TIaD3FDU6VPvydSwWmdps7YMjfsT61AmUGD5G/NPIWAbLi/ZoxMJfqcmEZ4WObajkoS7y7V0YLG3YCN5HrwRj71gksLMZo72LoVqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452319; c=relaxed/simple;
	bh=RL3kKElF6nFODZWuDdlz+JuQWkXZK1hUVs2vl2N8I/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koogF9mFQtBRV2AbL1tF0imLrYa/QBNvtwl1k4chxXRqeO5AsgY5BA9EM4Fr0I1VAW4qCmmTeSrsm+dwSUYTofh1FsZtBN8vYG6uW/+BQQXzM8XqKfL689tZAl1cMjUYsffVJRnwPmV1FYv+fZGw6Ky9yDSZ3ixeskUMqRykcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmuKZcVL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so2740360f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 01:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737452315; x=1738057115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8aWBFwCxuTMNSEwJNIJNMuustMzcc59od6w7veOripo=;
        b=PmuKZcVLRSf4DK3qo36h4M5nDbUbZOAHN+6aNwfQwUXT66YfvPcU/zdTYns0WiC+Vu
         hpnhnew1Thg7j7OHSeDhugdofaupkMsxPEzNwmnSyRaP1S+Cou/wl0dEcCKNwqv7Vl2G
         xlhxaBmwq2bEL2IG9inWZVLhHEdpwVRVAkq2IVy75EOfRDPtwRPTvua+C9vQBOyv/7H6
         BQilIHJ+fvJejKPQD7OJHw0KqxDiM898vYIGvRw6UjMYDVdYJbhFYwUdbDcz/lYFw4pv
         ELE622aGSIvFnXdSwg5hF+1fbdNV4MzrI5vZufWgNnae9JWPdLc4TKGTQf3wN8oM6GD1
         lLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452315; x=1738057115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aWBFwCxuTMNSEwJNIJNMuustMzcc59od6w7veOripo=;
        b=GnomEKodZlc/IK1/wV5TQ183xqpHSVKyfL+h0wGasojphX1vkvjbY+DxVcA8Xm5wYE
         nOHAbzT3KefUDgHZgqnWnn/ABRMCM3taZu5jVb1M+ngRfvQaqp/iidyP09eIiuRXH07k
         RqeE0sdojtqGG/ytGBMrBI1qSttBztOT58w/nxadLWnFYFfYGi0DsnXokX3VYGCdfvIb
         Qip4v0ORC0xKSB8DEZ75AQVYLdQO3jYCeWuL7gBRM64gcYMU55k8k73YZiaTI6j+ldf9
         btWwugK8X5rXcXwLNxCrGXtQdfz3C3alYNkAB4yVtMYc64MhzfaFSvDXiNlMQ47CSUxu
         //2w==
X-Gm-Message-State: AOJu0YypAhnO2lVpfOMO5AXK+7t+QV7P3sF8kis9oBVCaEkar9WBpbec
	nSwusEoDox8GsIbX8jDavJA0myFCue/iktIN7o0lhknjzjd9NQjzFwPEEA==
X-Gm-Gg: ASbGncuxhLmxipZlbnCM8B2Qo7iA8G22nJPK7njXaljdr3mKPVWKbiXoAvih/6dn+6Y
	rqyX9QL606be6J2aAJtjQJGW1z4t4C0hIrgEagg9Pa/XqT/aXixHcm+Ar86l2Xind+ovdXIlOUF
	ycR9fLxSjCQpMe3Ap5bwWxr5VaB9mWsabNtY6g8eY+6F0UrF3mLCcALO2KmwCRMXYwxNxMgWogS
	mMNfJEomdWc6cHfwAmgeu2aNo0JhZsCi7s12BIzFyJh3xHJE6P2phRS5rCQnVjEVGOAOvmczVUM
	/zfOdjqm27jZAigddNGM9R5Id4o=
X-Google-Smtp-Source: AGHT+IGe6ZZbfjEVfRn72Mek0BAT7AU+yqft+pgybUOtamCDVmNeN3NqhM9C/Xq7qne6eBPntBylHA==
X-Received: by 2002:a05:6000:2a9:b0:38a:86fe:52b5 with SMTP id ffacd0b85a97d-38bf566274amr16918094f8f.14.1737452315428;
        Tue, 21 Jan 2025 01:38:35 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32221a8sm12993488f8f.37.2025.01.21.01.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 01:38:35 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath12k: add support of station average signal strength
Date: Tue, 21 Jan 2025 10:38:34 +0100
Message-ID: <20250121093834.25132-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for reporting to the kernel the average rssi. This is
done the same way as it was done in ath11k. A simple ewma (with the same
parameters) is updated with each rssi update.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
v2:
  - removed spurious exta new line at the beggining of core.h

v1: https://lore.kernel.org/ath12k/20250117172819.3357534-1-nico.escande@gmail.com/
  - initial version
---
 drivers/net/wireless/ath/ath12k/core.h   | 4 ++++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
 drivers/net/wireless/ath/ath12k/mac.c    | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ee595794a7aee..83af4381b79ff 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/firmware.h>
 #include <linux/panic_notifier.h>
+#include <linux/average.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -477,6 +478,8 @@ struct ath12k_wbm_tx_stats {
 	u64 wbm_tx_comp_stats[HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX];
 };
 
+DECLARE_EWMA(avg_rssi, 10, 8)
+
 struct ath12k_link_sta {
 	struct ath12k_link_vif *arvif;
 	struct ath12k_sta *ahsta;
@@ -496,6 +499,7 @@ struct ath12k_link_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	struct ewma_avg_rssi avg_rssi;
 	u8 link_id;
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 5a21961cfd465..e53d5674b4368 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2157,6 +2157,7 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
 		return;
 
 	arsta->rssi_comb = ppdu_info->rssi_comb;
+	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
 
 	num_msdu = ppdu_info->tcp_msdu_count + ppdu_info->tcp_ack_msdu_count +
 		   ppdu_info->udp_msdu_count + ppdu_info->other_msdu_count;
@@ -2329,6 +2330,7 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 		return;
 
 	arsta->rssi_comb = ppdu_info->rssi_comb;
+	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
 
 	num_msdu = user_stats->tcp_msdu_count + user_stats->tcp_ack_msdu_count +
 		   user_stats->udp_msdu_count + user_stats->other_msdu_count;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2d062b5904a8e..5be8cf0e41279 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5403,6 +5403,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 		}
 	}
 
+	ewma_avg_rssi_init(&arsta->avg_rssi);
 	return 0;
 
 free_peer:
@@ -10054,6 +10055,10 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	/* TODO: Use real NF instead of default one. */
 	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+
+	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi) +
+		ATH12K_DEFAULT_NOISE_FLOOR;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 }
 
 static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
-- 
2.48.1


