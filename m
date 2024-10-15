Return-Path: <linux-wireless+bounces-13976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84799F3C7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FCC1F21989
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064C71FAF18;
	Tue, 15 Oct 2024 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWGjloBB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36021FAF13
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012468; cv=none; b=R14BwtyRBClloigK8O8jca7rmMDZYaJn1jrlBnSHSWzqrKDRraCjJD9+5DZqZ/YNkRsgVhX987q4HD9By9Az18wNhiXKs3XO8HPmoC5cQ4+MnWyepQL5L7GazexCmSY+DmZv/0U0dINo+G1QAs/K0uCFVRiP/9XZBZkzB4i3SYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012468; c=relaxed/simple;
	bh=BHtY7wCSHiNlcx+39qfdNwbOfBdEgUSezAm+ogDOqJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXnJKRCvsqgJLWrR/IArvjdUs09WbkUWxmSp93NfzHFsPdIus1pbuTq7ccJZITJeOe4Y4X/tjYfmxp7VN/GM7HVqGELjte1pjbvcMO+EDnPIKnoq1HmIc8QxXA6DedpJ/c9wHcS6dPgGc2cGdo7v5u2Yd/ND+Ym/RSugzytKXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWGjloBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C0C4CEC6;
	Tue, 15 Oct 2024 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012466;
	bh=BHtY7wCSHiNlcx+39qfdNwbOfBdEgUSezAm+ogDOqJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWGjloBBkeA0sO1Y2RDSnXai63n+fbyYsEbdORkxGyV3cwtEVFrc+cxOz7hTl78F8
	 ZxulDvGRDYAUJwaOhWTzu4Q1PHcY5sgiafk6G+gA60cP1DKRVPFnWFy6M63qM1Q69T
	 Xz3nsly3nw11Nt5ZQaC4/lJquWsc053ojqnFC+R8PF6eD5nERSH5pchtXEJE2oItUJ
	 keS25FcH7MX9qPT13sahjpaBmpNtmAxiSeqitcCytB1/CFdu2r/itZiwHloFN3lGD+
	 G/BvrxwEWQLb+zJoo84u06sew/stKcnGCgiHzYV4qLvYS9GFzkYV54+PufPvgN0M0N
	 1PfA5XOuRyDZQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 06/11] wifi: ath12k: modify ath12k_get_arvif_iter() for MLO
Date: Tue, 15 Oct 2024 20:14:11 +0300
Message-Id: <20241015171416.518022-7-kvalo@kernel.org>
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

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Currently ath12k_get_arvif_iter() takes input ahvif's deflink to check if it
matches with given radio (ar) but in case MLO there could be multiple links
affiliated with ahvif, hence iterate through the links of the ahvif and find
the right arvif that belongs to the given radio.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a0869ed1cb57..fb4b800435f8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -547,11 +547,22 @@ static void ath12k_get_arvif_iter(void *data, u8 *mac,
 {
 	struct ath12k_vif_iter *arvif_iter = data;
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
-	struct ath12k_link_vif *arvif = &ahvif->deflink;
+	unsigned long links_map = ahvif->links_map;
+	struct ath12k_link_vif *arvif;
+	u8 link_id;
 
-	if (arvif->vdev_id == arvif_iter->vdev_id &&
-	    arvif->ar == arvif_iter->ar)
-		arvif_iter->arvif = arvif;
+	for_each_set_bit(link_id, &links_map, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = rcu_dereference(ahvif->link[link_id]);
+
+		if (WARN_ON(!arvif))
+			continue;
+
+		if (arvif->vdev_id == arvif_iter->vdev_id &&
+		    arvif->ar == arvif_iter->ar) {
+			arvif_iter->arvif = arvif;
+			break;
+		}
+	}
 }
 
 struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
-- 
2.39.5


