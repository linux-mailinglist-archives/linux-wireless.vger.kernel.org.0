Return-Path: <linux-wireless+bounces-8102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF28D0396
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A531F2496B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6636B17BB10;
	Mon, 27 May 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2Vcm7nK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEEF17BB0B;
	Mon, 27 May 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819305; cv=none; b=lKzKhUdrNodPoFe5rO2kShACHfQUKA9+9sQ4Y5BGBVkrhZp2M4micJQid95ynCSQoyrcmZ8CDJd0XyiLFnY0VZzDNwiBUnbboBEkz3oqsk3YFoNowUjT2hKS9o9kigfm4RDuAmamJVT/PCLqofmTv0ywymY4mjV5fWpPr0OSHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819305; c=relaxed/simple;
	bh=LCTo4W6Sd0YOU46uvur/qnfKTRHtLNeR0VCT8BV92P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYPbWB4r3+vtuykjO5g6FydT2wCH3PCE8nKnQvh463Rv8JPzge76I82G8vyS3lABhIn94DOS6g5Xsj335cNu+AlLkVYb+OUg6cDWS42p8DuOqAzKPMOpPb2dUiyOcJdKBo61DVYvYXPq2Y/sDsMN4nFZjT/tbTnaYNBRD33vSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2Vcm7nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E40C32781;
	Mon, 27 May 2024 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819304;
	bh=LCTo4W6Sd0YOU46uvur/qnfKTRHtLNeR0VCT8BV92P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2Vcm7nKlV4eCccWXvC6m7Uki5xrcOWoA522kj443ohXbFIpbfHP1VuZJXj+MjTn+
	 YZbuh7EmoQd3byLnEkt0l6mk92TBK6GoWQw2w/RfAS9G7M7RS/o54QH7a42YzRjMdW
	 3rzVLiLjwxujbxvjjISF5lXPupXJ7Dt2ItLMwFJl708Bca9kJtJWLYCD1vYg6T7XeW
	 9Hltezbd3yXC8ky7RAWlN9hmoOzDEYJvtlVLHlo8CPhT/xHpdYpUcd4aYXbwyeSV3z
	 xDh5VHVwonRNgz1BxLId0bwLZ+5fzaK2soQgbcYG3QbPyhX/ITvCkl9t8Mhg/CTzMv
	 zoLT2Nn1XbSkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lingbo Kong <quic_lingbok@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 22/30] wifi: ath12k: fix the problem that down grade phy mode operation
Date: Mon, 27 May 2024 10:13:31 -0400
Message-ID: <20240527141406.3852821-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141406.3852821-1-sashal@kernel.org>
References: <20240527141406.3852821-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Lingbo Kong <quic_lingbok@quicinc.com>

[ Upstream commit bf76b144fe53c7f0de9e294947d903fc7724776f ]

Currently, when using WCN7850 or QCN9274 as AP, ath12k always performs down
grade phy mode operation regardless of whether the firmware supports EHT
capability or not and then vdev will start in HE mode. When stations that
support EHT capability try to connect to the AP, the AP will set phy mode
to EHT after receiving the association request packet, and then send
WMI_PEER_ASSOC_CMDID command to firmware, AP’s firmware will crash.

This is because when the ath12k_mac_copy_sband_iftype_data() function
handles EHT capability, it does not copy the EHT capability into the
iftype[band][type] array according to the interface type. So, interface
type should not be used as an index to get eht_cap in
ath12k_mac_check_down_grade_phy_mode() function.

To address this issue, use types_mask to select the eht_cap in
ath12k_mac_check_down_grade_phy_mode() function.

This patch affects QCN9274 and WCN7850 because they have the same issue.

Hostapd log:
wlo1: STA 02:03:7f:37:12:34 IEEE 802.11: Could not set STA to kernel driver

Kernel log:
[270894.816076] ath12k_pci 0000:03:00.0: failed to send WMI_PEER_SET_PARAM cmd
[270894.816111] ath12k_pci 0000:03:00.0: failed to setup peer SMPS for vdev 0: -108
[270894.816122] ath12k_pci 0000:03:00.0: Failed to associate station: 02:03:7f:37:12:34
[270894.843389] ieee80211 phy5: Hardware restart was requested
[270894.843517] ath12k_pci 0000:03:00.0: failed to lookup peer 02:03:7f:37:12:34 on vdev 0
[270894.843616] ath12k_pci 0000:03:00.0: failed to send WMI_PEER_DELETE cmd
[270894.843650] ath12k_pci 0000:03:00.0: failed to delete peer vdev_id 0 addr 02:03:7f:37:12:34 ret -108
[270894.843663] ath12k_pci 0000:03:00.0: Failed to delete peer: 02:03:7f:37:12:34 for VDEV: 0

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240425083837.5340-1-quic_lingbok@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b965fc46ad89a..d67ee0312c1d9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5911,14 +5911,24 @@ ath12k_mac_check_down_grade_phy_mode(struct ath12k *ar,
 				     enum nl80211_band band,
 				     enum nl80211_iftype type)
 {
-	struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_sta_eht_cap *eht_cap = NULL;
 	enum wmi_phy_mode down_mode;
+	int n = ar->mac.sbands[band].n_iftype_data;
+	int i;
+	struct ieee80211_sband_iftype_data *data;
 
 	if (mode < MODE_11BE_EHT20)
 		return mode;
 
-	eht_cap = &ar->mac.iftype[band][type].eht_cap;
-	if (eht_cap->has_eht)
+	data = ar->mac.iftype[band];
+	for (i = 0; i < n; i++) {
+		if (data[i].types_mask & BIT(type)) {
+			eht_cap = &data[i].eht_cap;
+			break;
+		}
+	}
+
+	if (eht_cap && eht_cap->has_eht)
 		return mode;
 
 	switch (mode) {
-- 
2.43.0


