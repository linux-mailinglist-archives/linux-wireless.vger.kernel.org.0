Return-Path: <linux-wireless+bounces-18260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F30A9A24BD9
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Feb 2025 22:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697D516327B
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Feb 2025 21:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4A1C5D68;
	Sat,  1 Feb 2025 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoY7OF2e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0571C3BF2
	for <linux-wireless@vger.kernel.org>; Sat,  1 Feb 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738444386; cv=none; b=X1iNMPrdakcqek/JVry77f8KlqUegWbL6UMxveT44FdlJFidp6dwwdPRjUKvE2DWk29kbs+Feg1E9iopGTfp9F36K6JmRZEzJwA6K56IzLdyXMEAvF1dcRiWn0iUZWPqXkQ2m1UTPSrgXCiI+UG9e0CPV9Y+UIb+sf42E5bUjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738444386; c=relaxed/simple;
	bh=6vyg2ycPhUZmR/9VksEfLHa96a58QsmASoYETYSNJS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFFZNma6qYj96DzyJcfMiHe8MqY45A2ptD+TgVsLM8tt/eatA6ktWbEvYoKFX/4zSvnprjpAmSXf+xonesYuJH03Q8Ah8QX+ej4d5ujx7VPeQptop0lE3vbdBJT9tq1Nzcaid69CZpl36SRaaIK3j/s48vgpeCHER0xq3mpFsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoY7OF2e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436281c8a38so22639625e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 01 Feb 2025 13:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738444383; x=1739049183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAXOnX62cZ6i8kI2tncb0QO6ket58w+Pb9EoHU06fZ0=;
        b=RoY7OF2eSSECa29WHTNs7Www1bNA1N3qctVE0NxBsWHM5l8Pz6zGd6Asmtd0BXN0mG
         82mlRoSKmen1ZLF57dLRrGwjXyjUyyih9RGG52BBmGClYvkrLQXWRw5s2BbQfVHiGbPs
         7W8pWtCmCbf37r7P5VG1vJlPtj+5GNEABYgHzjQXUhKPshfxWLasi9oEFyHLQb0aRh2G
         WgcsHl9TlXEzK4rjeOrVh0qNaShuoN+69odjEdnEoTK3zutOB2jVSWsElhet4oMEGH1X
         sdOONh8OzTEhvyonPcUPgSzPSLnpuAOj9p4zoGo5cQtqnxHtXOM1uQcrBJbDDawcLD1/
         FKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738444383; x=1739049183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAXOnX62cZ6i8kI2tncb0QO6ket58w+Pb9EoHU06fZ0=;
        b=N00NvOBPYJvZwJwYgPlnddrNjZyzhhPoThyeflcW3Uq4MWU+VfADWVYEEiKbCuhFVe
         uDd6ZnIJKI20pLPj2et1RbfufE/t/EsSBS8CLhYTpsOdlpbG/yGdAf74PqkSRl6AUDiv
         iTZuU19+8mRK2WamcBHtqVZQuLizigWKEcdc9CDr24ZP7cZ79VZrLbhgmqbYVFNjeBix
         S298TqHiJMgvds+csi18ongH/GNHdi2r0hs/NthnHiLN83/gCWE0SxILqLPb1L2Wjki5
         4zqT0RWGp9Ida7TBinnPXMrQO8PmSGZr3rUvFQyvfNqKQVWm97t7dpp0yNs7AU4Ew3ec
         SqGg==
X-Gm-Message-State: AOJu0YyosngnvFSWpVkLg2/8h1nd0Eb9ki6n0A6E0VDmrjOkmSZBLh/0
	0fSEESPTgmcTe5lC/AHJk08fZlWOu4vBhBaH1cscUzl7aieRUZsvAwhJhQ==
X-Gm-Gg: ASbGncvFbxllpPcrtJjrVU8yo/hnnIz/q9O1byd4al2JnOtla64tU6pw7UqBjMuKpsg
	n6+9mVlCbesxmZ1O1I57doJwDAfttvvf3QCekYLeawRADtXYkFa7B+TNfQrv+/7ZxV3g0KM/oB4
	gUc+XaXb9oP3qt0L3VWfEaOffRZlRtUUSZ8YbuHb799MkPHREAKS+D2EgPsxcCdg+PKsGlCLHfD
	RlwLjpDAGTf4MMGC0T8M//Dz/5zgpivcO2hVf6ccidwLf1tPKH5zdYqIeLuiGmhwUTeEkMpfzNn
	5TBvKjQc53cn/4ssb8XD+WLNCylEUgNrOQqijf5msvB3DHTc
X-Google-Smtp-Source: AGHT+IGJVRa/bkKZeoR0SoJZrw3nAzxaFe6fY+cQyOj44g9IOuf6m6TluWguF2EWZf8oAfQEl2oWbQ==
X-Received: by 2002:a05:600c:5486:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-438dc3a40d3mr160996275e9.5.1738444382813;
        Sat, 01 Feb 2025 13:13:02 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ecd6sm100349485e9.28.2025.02.01.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 13:13:02 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3] wifi: ath12k: add support of station average signal strength
Date: Sat,  1 Feb 2025 22:13:01 +0100
Message-ID: <20250201211301.357985-1-nico.escande@gmail.com>
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
v3:
  - rebased on ToT
  - now also handles db2dbm

v2: https://lore.kernel.org/ath12k/20250121093834.25132-1-nico.escande@gmail.com/
  - removed spurious exta new line at the beggining of core.h

v1: https://lore.kernel.org/ath12k/20250117172819.3357534-1-nico.escande@gmail.com/
  - initial version
---
 drivers/net/wireless/ath/ath12k/core.h   | 4 ++++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
 drivers/net/wireless/ath/ath12k/mac.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 28db100cfac0..2a53712bd606 100644
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
@@ -480,6 +481,8 @@ struct ath12k_wbm_tx_stats {
 	u64 wbm_tx_comp_stats[HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX];
 };
 
+DECLARE_EWMA(avg_rssi, 10, 8)
+
 struct ath12k_link_sta {
 	struct ath12k_link_vif *arvif;
 	struct ath12k_sta *ahsta;
@@ -499,6 +502,7 @@ struct ath12k_link_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	struct ewma_avg_rssi avg_rssi;
 	u8 link_id;
 	struct ath12k_rx_peer_stats *rx_stats;
 	struct ath12k_wbm_tx_stats *wbm_tx_stats;
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 4e9a60181c06..d529229f2d0f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2002,6 +2002,7 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
 		return;
 
 	arsta->rssi_comb = ppdu_info->rssi_comb;
+	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
 
 	num_msdu = ppdu_info->tcp_msdu_count + ppdu_info->tcp_ack_msdu_count +
 		   ppdu_info->udp_msdu_count + ppdu_info->other_msdu_count;
@@ -2174,6 +2175,7 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 		return;
 
 	arsta->rssi_comb = ppdu_info->rssi_comb;
+	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
 
 	num_msdu = user_stats->tcp_msdu_count + user_stats->tcp_ack_msdu_count +
 		   user_stats->udp_msdu_count + user_stats->other_msdu_count;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index e9663c6ac72c..807638d30e7b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5484,6 +5484,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 		}
 	}
 
+	ewma_avg_rssi_init(&arsta->avg_rssi);
 	return 0;
 
 free_peer:
@@ -10200,6 +10201,13 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->signal = db2dbm ? signal : signal + ATH12K_DEFAULT_NOISE_FLOOR;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	}
+
+	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi);
+
+	if (!db2dbm)
+		sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
+
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 }
 
 static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
-- 
2.48.1


