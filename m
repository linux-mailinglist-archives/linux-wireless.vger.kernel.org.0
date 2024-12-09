Return-Path: <linux-wireless+bounces-16111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370BF9E9E80
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 19:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E09188045B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8F21990C9;
	Mon,  9 Dec 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNJsd//d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A51990C1
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770472; cv=none; b=B65aoypPyqbibUp+V91tA3tg5dP5dR/g67DCDTFRvZCcRe1Litg5n9oV3dKhSqP0p8eHSzvoojplWhADmiP9+po1JJW2t8QylVXkN2Z1l/2cwW5ViDq+fC3u87iTMfIFIBT01ZMsQBOJmT9JuUMb5X4SF+TDrRqQhJtD8nTjzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770472; c=relaxed/simple;
	bh=4E1QB2EFTtWLeGwo1mXErVSr4iZbacaVng2KYZeRma4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVq8/YSL0/p8jNk+EU/oZvFzYOtblY7JkS9WfIgSZMRr0KdWAb4UkgOsIBmOXDvma4Kw/jNT0kQdpUUcY8x99Nl5XbECajOdJTG13Zsmn/y7O1WP/7yK4evDM+Kvm7sdQ5KStx6xsO8tEWF4lju8PyXspjdWeLJjJrdBN75Jk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNJsd//d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647B0C4CEE0;
	Mon,  9 Dec 2024 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770472;
	bh=4E1QB2EFTtWLeGwo1mXErVSr4iZbacaVng2KYZeRma4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNJsd//dXY0ytx1sdAfyrfhz/CvC0k2fYzc7INkX+vN3InB0E2E2aEGcJMViglZuu
	 O2f7+mKy9QPjXARha5nPZoesgWoVr2Sx0B3CuGLzTD8FA8/zDAYmU/azMebpOj1/Wf
	 Ku7etrxvXViqgiV391oeJtFXNG4zpcDn97g3riN+RL97783YoFPjwusJKYU33p0bYe
	 kRl5U6+OA3o7oMhWN1NT7auTQVkjknRmNavazHUCgPV8uN4KIAJGZijtZH1kk4gCw1
	 Nb5KzidPMvA6FY6/g0hlNhS2/HVUSBdeZGBPhAw/+Ex9SKjr1+wcbPC6Cm80WXiDPh
	 AI+krDYEd2K1g==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 8/9] wifi: ath12k: fix ar->supports_6ghz usage during hw register
Date: Mon,  9 Dec 2024 20:54:20 +0200
Message-Id: <20241209185421.376381-9-kvalo@kernel.org>
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

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

In the ath12k_mac_hw_register() function's context, ar is an iterator
variable, and there is no assurance that the last ar will be the one with
6 GHz enabled. Therefore, checking directly ar->supports_6ghz outside the
loop is not appropriate.

Additionally, 6 GHz lacks HT capabilities. To obtain the super set of
HT capabilities across all grouped radios, 6 GHz should be excluded.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index de2f55f4ea03..6f4a34c91038 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10723,7 +10723,10 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		if (ret)
 			goto err_cleanup_unregister;
 
-		ht_cap &= ht_cap_info;
+		/* 6 GHz does not support HT Cap, hence do not consider it */
+		if (!ar->supports_6ghz)
+			ht_cap &= ht_cap_info;
+
 		wiphy->max_ap_assoc_sta += ar->max_num_stations;
 
 		/* Advertise the max antenna support of all radios, driver can handle
@@ -10787,7 +10790,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(hw, REPORTS_LOW_ACK);
 
-	if ((ht_cap & WMI_HT_CAP_ENABLED) || ar->supports_6ghz) {
+	if ((ht_cap & WMI_HT_CAP_ENABLED) || is_6ghz) {
 		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
 		ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
@@ -10803,7 +10806,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	 * handle it when the ht capability different for each band.
 	 */
 	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS ||
-	    (ar->supports_6ghz && ab->hw_params->supports_dynamic_smps_6ghz))
+	    (is_6ghz && ab->hw_params->supports_dynamic_smps_6ghz))
 		wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
 
 	wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;
-- 
2.39.5


