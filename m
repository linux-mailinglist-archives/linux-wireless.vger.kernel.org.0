Return-Path: <linux-wireless+bounces-16108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D69E9E7C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA2718829AE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60439198A07;
	Mon,  9 Dec 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjc8vorl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C725198A06
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770469; cv=none; b=h+RYdaC8/d6LP9tPWWdQPkOgA5vTIM7rft2f2x9/9UXl2jGavLnool9VUj+WF7ycCndPtg5t0YRc+HGS4RnSjtfZJyqJMxqWrEHmfYcS5z3vWwwFNecBFyBU+4B0BITO/d76w8WCkdv867VNaf0fhlmDTozZaVGaY+kuZC0Wxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770469; c=relaxed/simple;
	bh=R3x4fB3fgIOZ4yHe2Exvv4Idzn8sQ2bxalc4Ocqijx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqEtXeZi8/09pphXOQdAyxKZP2EEEF81YnOrWQSwHoC2L/e26WnvwbC9wtF1Yvx/Wi11PnBQS+hW9p9+/BQzK5+9LnI+MwlS25Sy+NcB0OUNP7mUJlMj9cwe5Af6Y66GcoejIvfB/FjEX/tFUKNxywJxaJy7Mw3DAqh+1l5/px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjc8vorl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAD7C4CEDF;
	Mon,  9 Dec 2024 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770468;
	bh=R3x4fB3fgIOZ4yHe2Exvv4Idzn8sQ2bxalc4Ocqijx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rjc8vorlViuTUrCiYrny0uCTRqsH0FlwkwjMsHhHlDZelDEY5vzsE4tmQIq6LctIk
	 XU1OCsUR3KzgmJ3YHaYt/bH7cxRXEVotCKFpNilpUbuPTxcieTTB9ivNSlL0e29cZk
	 MhwnMjHo3h12r9LnkF+B87BmaGL6qVwn7XVcTg12hTkBA5GnhXrRWbsXZ1A6mRfAp8
	 P3DeJ+1j6HmfDFodod3tG35ssWK9+PYToKA3z/C6VbDZ4Rq8OxKtRe+dbJHE7E02QR
	 y+H0TRcwDYLnSwQBxWnEKonzLR+j3eFhlGHB+NUzlZtxxDKy1QoZaHQ96moGV7MRQv
	 GXLwjjV2yuM4A==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 5/9] wifi: ath12k: Refactor radio frequency information
Date: Mon,  9 Dec 2024 20:54:17 +0200
Message-Id: <20241209185421.376381-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209185421.376381-1-kvalo@kernel.org>
References: <20241209185421.376381-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, radio stores the low frequency and high frequency information as
separate variables. However, cfg80211 already provides a suitable data
structure struct wiphy_radio_freq_range to store this information efficiently.
Additionally, for multi radio per wiphy infrastructure, this frequency range
information is essential. In future patches using struct wiphy_radio_freq_range
makes the code simpler.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 3 +--
 drivers/net/wireless/ath/ath12k/mac.c  | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d7caa58bb262..d09ebcdde94f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -711,8 +711,7 @@ struct ath12k {
 	bool monitor_started;
 	int monitor_vdev_id;
 
-	u32 freq_low;
-	u32 freq_high;
+	struct wiphy_radio_freq_range freq_range;
 
 	bool nlo_enabled;
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index dc61fe761090..1bf89be1cccc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -708,8 +708,8 @@ static struct ath12k *ath12k_mac_get_ar_by_chan(struct ieee80211_hw *hw,
 		return ar;
 
 	for_each_ar(ah, ar, i) {
-		if (channel->center_freq >= ar->freq_low &&
-		    channel->center_freq <= ar->freq_high)
+		if (channel->center_freq >= KHZ_TO_MHZ(ar->freq_range.start_freq) &&
+		    channel->center_freq <= KHZ_TO_MHZ(ar->freq_range.end_freq))
 			return ar;
 	}
 	return NULL;
@@ -10203,8 +10203,8 @@ static void ath12k_mac_update_ch_list(struct ath12k *ar,
 			band->channels[i].flags |= IEEE80211_CHAN_DISABLED;
 	}
 
-	ar->freq_low = freq_low;
-	ar->freq_high = freq_high;
+	ar->freq_range.start_freq = MHZ_TO_KHZ(freq_low);
+	ar->freq_range.end_freq = MHZ_TO_KHZ(freq_high);
 }
 
 static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
-- 
2.39.5


