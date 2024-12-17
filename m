Return-Path: <linux-wireless+bounces-16505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E619F57B0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 21:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86EF016F35E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A461F9EAD;
	Tue, 17 Dec 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRLlI3z+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203C1F9EC1
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467183; cv=none; b=IwJxQiLGNI1GtdPvFjW2nPNR13pYInc+1tobubV3Yme8juHgXzq1jeGcbtvRXrhNV5ZdQLlC62l61qD4smTivQyG0+X6Tb1N23p+j0WRqnIuIZ7eQH7tPlJrW7PaPzHdetJeDHiYNxV2d5DsP6CQm/+A51Prr4B6tiOKrgE0x+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467183; c=relaxed/simple;
	bh=VQm3hiNA3kQgkmtCDPPom8HziQB3vh3sJutG7be7roQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RyqsEPFbNdmPO4mRL0XGlgcbX0IQfKgdv5TZpJyus7ZQ3byBwNONgfa7oyj4hR0WIjBEghutdNO+94u4zKDYd9OOvjR+LJFDk9glH3w0nrT8HnD5kcr6217L58BF/XUry2e33s4YtKGhsPelWigaPZaNzBP0+YKJrzMmDmQKFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRLlI3z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7144C4CED3;
	Tue, 17 Dec 2024 20:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467182;
	bh=VQm3hiNA3kQgkmtCDPPom8HziQB3vh3sJutG7be7roQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRLlI3z+9qlYlrUL2d4MkKeCsOIhiJ6Ddd4O0qbRt6zBNNp+/S3HfKooLgMCADkeu
	 p4Y5Kbb+CQja4CQoecFwAY6ZMnQFWcRQOXHPH2YPTU2nw5+LWcbbMtjdtsheL39qSi
	 Dl11sU6ZSZQUJAJN2lK/Tm7BI6aQ7R/1IvphNxOS57lqgaB/oO5iTyf+lVuAuy/Iu5
	 MmgDlFki8RHbRawIkd092HvzMmDRZzy2+Ats5zGNZnRnTf7v5BvtsaHlY6yFKetbwT
	 1HlLyZ2f1ryAVc3HC/sEtEaCAea1bV3KV4p9uXGNO41Jd+G4EjewQNOjv2yCSKD1L7
	 X5mt0HYPs5qbg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] wifi: ath12k: Decrease ath12k_bss_assoc() stack usage
Date: Tue, 17 Dec 2024 22:26:16 +0200
Message-Id: <20241217202618.1329312-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217202618.1329312-1-kvalo@kernel.org>
References: <20241217202618.1329312-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Currently when building ath12k with gcc-14.2.0 the following warning
is observed:

drivers/net/wireless/ath/ath12k/mac.c: In function 'ath12k_bss_assoc':
drivers/net/wireless/ath/ath12k/mac.c:3080:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

A major contributor to the stack usage in this function is:

	struct ath12k_wmi_peer_assoc_arg peer_arg;

Avoid the excess stack usage by dynamically allocating peer_arg
instead of declaring it on the stack.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 05d2c75e5df2..2a30a11903c5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3133,7 +3133,6 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	struct ieee80211_vif *vif = ath12k_ahvif_to_vif(ahvif);
 	struct ath12k_wmi_vdev_up_params params = {};
-	struct ath12k_wmi_peer_assoc_arg peer_arg = {};
 	struct ieee80211_link_sta *link_sta;
 	u8 link_id = bss_conf->link_id;
 	struct ath12k_link_sta *arsta;
@@ -3145,6 +3144,11 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
+	struct ath12k_wmi_peer_assoc_arg *peer_arg __free(kfree) =
+					kzalloc(sizeof(*peer_arg), GFP_KERNEL);
+	if (!peer_arg)
+		return;
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "mac vdev %i link id %u assoc bssid %pM aid %d\n",
 		   arvif->vdev_id, link_id, arvif->bssid, ahvif->aid);
@@ -3177,11 +3181,11 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 		return;
 	}
 
-	ath12k_peer_assoc_prepare(ar, arvif, arsta, &peer_arg, false);
+	ath12k_peer_assoc_prepare(ar, arvif, arsta, peer_arg, false);
 
 	rcu_read_unlock();
 
-	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
+	ret = ath12k_wmi_send_peer_assoc_cmd(ar, peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
 			    bss_conf->bssid, arvif->vdev_id, ret);
-- 
2.39.5


