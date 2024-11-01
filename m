Return-Path: <linux-wireless+bounces-14824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6712D9B942D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B334282F1B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04C1C82F0;
	Fri,  1 Nov 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqbQVclJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CCA1C876B
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474235; cv=none; b=nfDO31RIuIflqx50AyNTjU7868ja0cRMSCU1ViO1zBz0fS0NmlgV3P4zzqnZ6lkW/RNzkrXHeBIsjANZou1ZKl0s5VAYdyVjyyX26vumdprOSR/vjfyoZhD09BblDxpUAtUY3jMNxjIxwYIlSIRuExp38ZeynnBANmciLjsyMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474235; c=relaxed/simple;
	bh=GcHF9smJ63ZYYJcEtK76RykifUHXRqnHH0oKt4J7VQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZOmrjcBXlWPw7bC1hDPGdwHc1EaC8qe+3ksnMDG5svO8/iDBdz69WO0PLo5tdcZR19H9pZnSFsU+BCesovpOOnQ1zRtVOii4FrMPX1QgDkXNnhd9ellnq9DATMHXvzxDeT3G6huaQmgo1JauehDwHsIdQOfoidBSMKA82cCRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqbQVclJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7136EC4CED1;
	Fri,  1 Nov 2024 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474235;
	bh=GcHF9smJ63ZYYJcEtK76RykifUHXRqnHH0oKt4J7VQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqbQVclJiqokSduUgTA0ZkRr6S7E0OP/Pu5GjFWXYkt9vlfgnMdG6aI89BWgWSCzP
	 btHyL9xik2yMl3fABwljiRPsGk72aUbl6xr8+LFAuYwedfha/FgqBvwfMLMgU+VoVZ
	 usd4iCmXlOdc91f4P+gzfHN7UXzYby5c/kbjZP3uKaFQTlOcOs9PbesR0xJGHpoCZt
	 rqRqtZEfpWmxt9H0aiwbWGRrqRmRmtnGd5WbNQkichMB00Yz9bHPg6x9RmyE8qaCZC
	 vlm+go/+J57NlS+6NhnKpdj7pXYPdIRALjca9wYHTqBBVa+8IAULdKXEq8qb2d59YN
	 EF05xgloLW+Kg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 7/8] wifi: ath12k: add helper to find multi-link station
Date: Fri,  1 Nov 2024 17:17:04 +0200
Message-Id: <20241101151705.165987-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101151705.165987-1-kvalo@kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

Multi-link stations are identified in driver using the multi-link
peer id and they have ATH12K_PEER_ML_ID_VALID bit set in the id. Add a helper
to find multi-link station using the multi-link peer id.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/peer.c | 17 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/peer.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 2ad19baf0664..0e86847edd6e 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -79,6 +79,20 @@ struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
 	return NULL;
 }
 
+static struct ath12k_peer *ath12k_peer_find_by_ml_id(struct ath12k_base *ab,
+						     int ml_peer_id)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list)
+		if (ml_peer_id == peer->ml_id)
+			return peer;
+
+	return NULL;
+}
+
 struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
 					   int peer_id)
 {
@@ -86,6 +100,9 @@ struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
 
 	lockdep_assert_held(&ab->base_lock);
 
+	if (peer_id & ATH12K_PEER_ML_ID_VALID)
+		return ath12k_peer_find_by_ml_id(ab, peer_id);
+
 	list_for_each_entry(peer, &ab->peers, list)
 		if (peer_id == peer->peer_id)
 			return peer;
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 085246ca938d..c28aca5d88a0 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -19,6 +19,8 @@ struct ppdu_user_delayba {
 	u32 resp_rate_flags;
 };
 
+#define ATH12K_PEER_ML_ID_VALID         BIT(13)
+
 struct ath12k_peer {
 	struct list_head list;
 	struct ieee80211_sta *sta;
@@ -47,6 +49,8 @@ struct ath12k_peer {
 
 	/* protected by ab->data_lock */
 	bool dp_setup_done;
+
+	u16 ml_id;
 };
 
 struct ath12k_ml_peer {
-- 
2.39.5


