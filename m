Return-Path: <linux-wireless+bounces-17657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B7A155B4
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 18:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D40C164A27
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467851A239E;
	Fri, 17 Jan 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndWjPSzC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4A166F29
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134904; cv=none; b=IuVLitr7N5dHS2ZwaCm7ukOZ1BucqASeX9DvWB7+xuVV/qarC5FWnAoLeVZ/4yN2x33B+QIP+MF33fUvRk46hXZGswvxtrHkGvMJhiizaeNCGxAcGmcropibUR1zvdDfUQ35yXB7oG3XFwTMOmmp3vYe9KBp8S915Z7M5nXyJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134904; c=relaxed/simple;
	bh=e9OCVc75MoYGuJSLn+XNfpXtrMP9X39O0WbWMZ+VrDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sU8AqTzjeINGvdRu9wVO2FblEWXdKhWKH9/7Gu9fglHhmB1Kos2/r+FqnebIf+HAcKvd0ZEocYn+rTvU6adOHft1Hn3qrxC91VPbhlw61MkZfljC61LBmonYoRKRigP7uu0blZLPDzjq1e2kF3VOwNgshgrdQ+S8VO+oLG3DVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndWjPSzC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43626213fffso21569915e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 09:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737134901; x=1737739701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLN3gOcLDJS36tJv//bMowXpxsTR9Nhq+LKenQnzMwM=;
        b=ndWjPSzCEE2DXbfSfDsI35k9MFhHjyaTmZq0ZdVLi4E3sqZ/jw89PlXGcKGl/L/ehW
         hxtuMTuH3YKX3LESWH3nPBzFK1BcLCU8QHwPrpvVbcmpRevtoXUVqQ3eHBrEzBx/Y7wh
         bLU5QFVWvdvRe3pAc4Efq3NSh4bBYRCJpKdLiK5uMnjnmK4FhPgmA3NJLlOdj/wuPcQj
         plTqBOd4F/LPpVVN84Tiu/sPgXNvRfQH4pDBu8OLOuRDSst4bMYCLsVlv20r1Q4bzHxz
         yqcAOg9hUHQPoM3KMHu1QknJaONlRr1YT5VqSKo4yzqb2CVvkTJpB5pf3XamAuzDBX+e
         i2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134901; x=1737739701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLN3gOcLDJS36tJv//bMowXpxsTR9Nhq+LKenQnzMwM=;
        b=qLIaQie04BBi0FrcLmcTeXSK9u6NCxHAe9E/J7thGeSYMQlwfPYm2KeTnhBgohNILm
         Kae+q3AAs/thvDikaMZR2HcR7oA5wijatoi1hpEly7z1zCs+sheRw0PzN5e87W6+nnl8
         8FXKi+qjS8ctQTFFyvFoCFWpx0ijDSMjJDPwGnVAr+gke55kCBx++sgucC3bACM0Wj8u
         2D/W7C5GebV6ONxtku3759jBqE9mtNdfBVQf/SSAV3/Pf7q5Y7Q3BRlZz+cblVyNrXEl
         g5HTxX0cXc6MfrAy3KGSdzBPgGs4FlIUszAf3+pw8UtFvmBRti6NLqzFmb5/m7BTtnwN
         jy7A==
X-Gm-Message-State: AOJu0YzM2mWG0ig137mMPD9yULWQYdd8AihQYm3/AU72+YbMX40Os7cX
	GJt5+isMnYXHtFFoTgg+D3ho5YPrO8jiUAqlfZhlDoee88GyGA91L8sXnw==
X-Gm-Gg: ASbGncsPvJRmGH6mgf4JylGwCahqkQMBZwMP4xqlkFlLYYvtPqIjvfKe821DfQAYp8w
	e33nquTYI9crMyxfmJ8vamqfiMe42aQbzYfEXs0dyosYsrWnyQIlvMg898rPwfTaN4H+qKCJovt
	68ssnbj2hcBBMAM/HU5e0xAMqw7y5MKUZv/VrtT8/GLeQddunxJC4uibpTk8oQ/yNut8Pxdbkwq
	EB4AQ1co8aEsmA9IYi7KcI6WUdvEdNCBEiVCreWVn4lb5ndDYFU5y9i3ewWSFexFrd70ICgSImG
	ZJEDZPnSuV6a1Q==
X-Google-Smtp-Source: AGHT+IEWE12BcgR5C6nhlkhA8r092LE4py8JIqeiQuML0tzebpzWr5c0O4QRGGHiyGRxQjTxGW7+PA==
X-Received: by 2002:a5d:648c:0:b0:385:f892:c8be with SMTP id ffacd0b85a97d-38bec54290dmr9388114f8f.23.1737134900453;
        Fri, 17 Jan 2025 09:28:20 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275562sm3074631f8f.66.2025.01.17.09.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:28:19 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: add support of station average signal strength
Date: Fri, 17 Jan 2025 18:28:19 +0100
Message-ID: <20250117172819.3357534-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.48.0
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
 drivers/net/wireless/ath/ath12k/core.h   | 5 +++++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
 drivers/net/wireless/ath/ath12k/mac.c    | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ee595794a7aee..9408d8a528580 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1,3 +1,4 @@
+
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
@@ -15,6 +16,7 @@
 #include <linux/ctype.h>
 #include <linux/firmware.h>
 #include <linux/panic_notifier.h>
+#include <linux/average.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -477,6 +479,8 @@ struct ath12k_wbm_tx_stats {
 	u64 wbm_tx_comp_stats[HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX];
 };
 
+DECLARE_EWMA(avg_rssi, 10, 8)
+
 struct ath12k_link_sta {
 	struct ath12k_link_vif *arvif;
 	struct ath12k_sta *ahsta;
@@ -496,6 +500,7 @@ struct ath12k_link_sta {
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
2.48.0


