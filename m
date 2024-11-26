Return-Path: <linux-wireless+bounces-15723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAD79D9C31
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC7DB276E7
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF21DC182;
	Tue, 26 Nov 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyRa2fDz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F31DC04B
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641106; cv=none; b=Ick5GsZqJgd41bxGv4viVw/lgQEkfF6yhEbn2ZJm4yIPRXr5ECmQxwF+o2VKBQAkfwdd7+9Mh8ZxcPOlHOf0Djj4+j7pB1rYVPpxlskKlc4te/RqQGQNKWO3aGLXE0mkwjfM4l/zNKN5bx7paEQpNHxaaE5O0L2aXlYrXUZAmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641106; c=relaxed/simple;
	bh=fLIf5yldob4kP1I/+Xg/0aAFAjapHLuzwrm1v8slJfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqAIq4+9uVJk8prFbJVS6f+BK5nB5mo8YbFfsz4DT401UZyL+Sguy13p6c0C64FUV2Vk+b+idmS6wUP26D+Asp6sITIt61r5LBN7PjzbkMjK8wYpIwVflAGFabpco20oeuhjI11kD4IL8GDLy6u73vTY/q2kUvoTO7uhTtvWruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyRa2fDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019D0C4CECF;
	Tue, 26 Nov 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641105;
	bh=fLIf5yldob4kP1I/+Xg/0aAFAjapHLuzwrm1v8slJfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyRa2fDz10SGugi77JL7HOOa9EkJLj9UrJVChCkGSeaXc3AIpncyjSrqBO89chCG6
	 /3C08367vCc+ODxs+mtcJm0LdLj41eW/jNvXhONCDlmV5tABKedVvmjRrvl14r5DX6
	 +4iqkJ/39S9meLAFIpytUX68LLsv/KgqxIr9gTq78VlJP716aTaIjb7px5uA7tSQSx
	 2LKny7DpYuebsbBBGR7fcgugyxrlUk/rp0D1y8wuAjSYQ6r9jdAsivV6LJAvvDxxWl
	 q2s9Zz7rcChHpjOZVSlpwyxBL6aEuAqiq2mBDd2j2nrHgVRJIUJfVUc906Mz8PYsaj
	 fpW7KNZRRWDdQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 03/10] wifi: ath12k: ath12k_mac_op_flush(): MLO support
Date: Tue, 26 Nov 2024 19:11:32 +0200
Message-Id: <20241126171139.2350704-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126171139.2350704-1-kvalo@kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Currently when tx flush is requested for an vif only packets corresponding to
deflink are flushed, with MLO multiple link arvif could be affiliated to the ML
vif and packets corresponding to all of them should be flushed.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 97a5f26cc577..d1c94eb8145a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9287,7 +9287,11 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 				u32 queues, bool drop)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ath12k_link_vif *arvif;
+	struct ath12k_vif *ahvif;
+	unsigned long links;
 	struct ath12k *ar;
+	u8 link_id;
 	int i;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -9302,12 +9306,18 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 		return;
 	}
 
-	ar = ath12k_get_ar_by_vif(hw, vif);
+	for_each_ar(ah, ar, i)
+		wiphy_work_flush(hw->wiphy, &ar->wmi_mgmt_tx_work);
 
-	if (!ar)
-		return;
+	ahvif = ath12k_vif_to_ahvif(vif);
+	links = ahvif->links_map;
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
+		if (!(arvif && arvif->ar))
+			continue;
 
-	ath12k_mac_flush(ar);
+		ath12k_mac_flush(arvif->ar);
+	}
 }
 
 static int
-- 
2.39.5


