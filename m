Return-Path: <linux-wireless+bounces-13112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55198420E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 11:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5498C1F23B99
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9F917ADF1;
	Tue, 24 Sep 2024 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7n/UDmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1E15E5D3
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169924; cv=none; b=REX87DHhesCKdEJq5xyZQnP065Z5KHw/5E1QIfnP0nbsMFhfh3EZNrsZ0h7JyxUHjVejY5TxhZsa8e6Ub0vo/KZ5WhwGf031MLKSa4uBcoZRO/yYllVYHJRAvJL9AAorTla1Kb0QYrvC9jiGwAhL87tYhh2/wqhQb0WgSMY4coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169924; c=relaxed/simple;
	bh=rYtGyWpC26I/ebghKbl9rCOAPkWyD+5nJWTsF72QZ2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfB3OIy/9tQFL4se/m10vk9uzY1n79G5sazzPSRHFn14kQ5yOsbosatt3e02TP0o1CLejj1zh2D0afIsRKJVrNLhdDCOxeF7Y2Z2JEQdofWNNzB8vM8QTcJDrFdN3aiz+gZSSEnYVc+5jbOEtqTCcPHpS+4+A0eZGHueempblQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7n/UDmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08C2C4CEC4;
	Tue, 24 Sep 2024 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169924;
	bh=rYtGyWpC26I/ebghKbl9rCOAPkWyD+5nJWTsF72QZ2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7n/UDmZRNw/R/2/XhcaByslW874ctCeStr/Pn4+4z8eknji/dhPeo5I/FJGXm40U
	 fbE61PgpJtqrUYGFJra4NtOyUgZELuxRnyeyotxRNFp4vzc8L1vmoNx8F1Uns3GUua
	 B21pxf5a8HYGjWnun+nPhTtS5lNtpKZxE7HZW/doGSIvQIxem9t4txSHX9QI+SpC1t
	 h+bF4Vdfv5csdaFGnDES0WNYUJmLzaCS2DLPIwfVammlUh2yfuZLi4k6TlXMExz2tB
	 t1lLGKIMQldcL1lQc89uJYq9ZyjTS68kVYUq7NePIfLWCd0yTt5sWXlRt0VTLG5guJ
	 aNqiii4RMwlxA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH RFC v3 6/6] wifi: ath12k: ath12k_mac_op_sta_state(): clean up update_wk cancellation
Date: Tue, 24 Sep 2024 12:25:15 +0300
Message-Id: <20240924092515.1049885-7-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924092515.1049885-1-kvalo@kernel.org>
References: <20240924092515.1049885-1-kvalo@kernel.org>
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
index c41740734fc8..dfd02b0c6bfc 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4566,11 +4566,6 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
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
@@ -4591,6 +4586,8 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
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


