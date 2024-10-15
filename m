Return-Path: <linux-wireless+bounces-13978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A5999F3CB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFAA28301C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194A1FC7C2;
	Tue, 15 Oct 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CExyeYA7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987361FC7E6
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012470; cv=none; b=k8tJEKLqBc2TwwE2Sjj3OcAPuJNpvlO9E2wX2VCVJOgDJfguMViy+L2t8rfN+T3Npk6QlwVmZY8hLK4d0SgUkooh+CO+LfgNeUaif6l2QAXdkW1MO1UYC8K0JAjrls3hN/rwSICNKuZi5z7P0IMTigr1K/CW5TrrLBr806ETLtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012470; c=relaxed/simple;
	bh=0y6W5ldb2qg8kudHzb+ivwrZLPv0XWaWXc2me3HQcP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHfPih9/jpZy8WDVG726MVIzxYSH1wdlm1WyBZPNE0ayo1QhKOM8xm93irEezC653zuMUMID7WQcNmd7oZuT9v3XnG8MrAv/0Rr+ECs+awnFgVxLFrhKHT1RquDAqJY0I6Wg2q1c2YeaWbTIk3ivYvXDurkay4yaghr1xFW7jFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CExyeYA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEACC4CEC6;
	Tue, 15 Oct 2024 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012470;
	bh=0y6W5ldb2qg8kudHzb+ivwrZLPv0XWaWXc2me3HQcP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CExyeYA7xXT16UJ7Zj94SOBnT07A65dYGRLpohJQxjI8ghlFQrZcvnaaJ7Z4r6d82
	 LWAeQWTq4DRYaBuNAp3uIKjac8WdYS2da8kKyfBtczzA+8k2b1LorN3cFa5nOb/6I2
	 c1U44VKEGlPtiRZCME36hgOgWUnyfG3ihBcJMAMqqyOEKhd9vPScvUjhwuI4p6Cptb
	 eroFrc2GdFtVU/dFh1I9cTBuPZb3dCND9yCRVxqNBlL2yFR7NRfbcrMEKXsZ3Z+zdw
	 g0aN3aQ0pudIF0pAlcOVP6DA4B99CxcPFrJDpTVJSjkKk1cbpYutXpOm8D77s5DZ9P
	 Nj+Y6coMbT39Q==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 10/11] wifi: ath12k: update ath12k_mac_op_update_vif_offload() for MLO
Date: Tue, 15 Oct 2024 20:14:15 +0300
Message-Id: <20241015171416.518022-11-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015171416.518022-1-kvalo@kernel.org>
References: <20241015171416.518022-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Currently ath12k_mac_op_update_vif_offload() updates for vif encapsulation and
decapsulation offload configurations for intended vif's deflink.

But for an ML vif encapapsulation and decapsulation offloads are an MLD level
configuration so apply the same configuration for all affiliated links of the
ML vif.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8771d9738ffb..ba633dad4c47 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6683,9 +6683,25 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif)
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+	struct ath12k_link_vif *arvif;
+	unsigned long links;
+	int link_id;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	if (vif->valid_links) {
+		links = vif->valid_links;
+		for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+			arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+			if (!(arvif && arvif->ar))
+				continue;
+
+			ath12k_mac_update_vif_offload(arvif);
+		}
+
+		return;
+	}
+
 	ath12k_mac_update_vif_offload(&ahvif->deflink);
 }
 
-- 
2.39.5


