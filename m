Return-Path: <linux-wireless+bounces-13618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89E0993448
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF6F284806
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E3F1DCB39;
	Mon,  7 Oct 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/QoooBT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503EA1DCB28
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320381; cv=none; b=S22vto1QXOrw7IdYnWW6CWwk5Kfl/qAtzs/5F2iobx1rWM8Kh4pI0QS6pwO6cMqcm17Zip4T7cwBdOesXE3mJfues2A4e3ED6cGnO0aJcbyOUQiQw58NYrZgyYV/bTnZZy+D2ogReUUYaxaWKNL1V+8eKgFBEHFM41vH1KjIhhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320381; c=relaxed/simple;
	bh=jPJ/21LqA9O61yqJ1UBZq2g0LOb8JB8UNOMYpSsGj98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GjoDSzkflMvZ0RL78fhQJXfi57UkN0gi9z0tWtQXJfR5ojRtr5qq+QPMQK2L8iY4wZWMhh9xjq6BWst1vg/0oc/tIHlT9iYVTidaxKmhk0Jfbjww3WFaahN2naBZIUnpFXdyC37AbcqpRX5V9hfsT46R6O9SRJhpvEGrqey4Uuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/QoooBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99315C4CEC6;
	Mon,  7 Oct 2024 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728320381;
	bh=jPJ/21LqA9O61yqJ1UBZq2g0LOb8JB8UNOMYpSsGj98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/QoooBTq+DESIh4UgBrnfClQ6OQ0zmZGp3aN+lGFW1BSoiQgVpCioKcrLGgTO12G
	 kJCFhvbrHSHpsNL80MtfzBKY3szfevj4L73NWPyAgxUjz5RPDDGIM3kAJPqttTNCHx
	 ydWFbL38YSZ4Gw2rpJoIcGxwB4ksWd68f1oPz39NzkRWE1+V8gVzCn7v2bQw3ZsTyJ
	 sRlqOpTdrU4feMNoa0tR62pLhT3ZZplQZSrfopIbGSmgISkrkobJHSGRIsmZF3etuh
	 DBn19igDAwh20wOYHyRe09YEOnaDu27qpBEsKkFhHeGsAp7ewiitcOS2YQfySp097b
	 JzER2qzXlp8FQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v4 6/6] wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk cancellation
Date: Mon,  7 Oct 2024 19:59:32 +0300
Message-Id: <20241007165932.78081-7-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007165932.78081-1-kvalo@kernel.org>
References: <20241007165932.78081-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Now that we have switched to using wiphy_lock() there's no need to have
update_wk cancel call separately, for consistency move it to the rest of code
handling IEEE80211_STA_NONE state.

No functional changes.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0c0b87a6e9fa..d4b438e4b7bf 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4569,11 +4569,6 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 	struct ath12k_peer *peer;
 	int ret = 0;
 
-	/* cancel must be done outside the mutex to avoid deadlock */
-	if ((old_state == IEEE80211_STA_NONE &&
-	     new_state == IEEE80211_STA_NOTEXIST))
-		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
-
 	ar = ath12k_get_ar_by_vif(hw, vif);
 	if (!ar) {
 		WARN_ON_ONCE(1);
@@ -4594,6 +4589,8 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
 				    sta->addr, arvif->vdev_id);
 	} else if ((old_state == IEEE80211_STA_NONE &&
 		    new_state == IEEE80211_STA_NOTEXIST)) {
+		wiphy_work_cancel(hw->wiphy, &arsta->update_wk);
+
 		if (arvif->vdev_type == WMI_VDEV_TYPE_STA) {
 			ath12k_bss_disassoc(ar, arvif);
 			ret = ath12k_mac_vdev_stop(arvif);
-- 
2.39.5


