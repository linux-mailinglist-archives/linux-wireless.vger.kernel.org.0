Return-Path: <linux-wireless+bounces-30966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B4D3AFF5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 17:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7C1230471AE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7928751B;
	Mon, 19 Jan 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="dH+S3Pf6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C82741C0;
	Mon, 19 Jan 2026 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838746; cv=none; b=nIVKnRPHaprIdPWOjdPCBUcm7uQIGZrUKHq2Jzl7KthEFKGCRY0W2KJ3cZuqYv0OuqQaUOrF4HuoBNkqRXtChsUNI7Fc2fEKTSf1FZDYC3XJzN+Xle4rvT3lxz9OVOI3V2HeMUpT6VPMT+G6MdV6m2us/vmjsryL1S0PqEY6xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838746; c=relaxed/simple;
	bh=wICGQtDh+GJbFR9R77oVU+5UKFGVOevfh+sAyoFQhBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SYlG4sth5uVXrtFXARnqm6JgHRnNrUDNXMyF8jR7VFaUnyRaEVC82ErxG7xygoVMsBrGM1JCZ40ySz81Oq+mAwC5lmVA8rJZdXVHdKG0Z2LS+xHCYoIUDxL1WbQdEijkjsZhFpiLkswUQV22akKOpkiNABbVDnn8XIxsetQ6iNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=dH+S3Pf6; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 312e1bd95;
	Tue, 20 Jan 2026 00:05:39 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] wifi: ath11k: fix memory leaks in beacon template setup
Date: Mon, 19 Jan 2026 16:05:35 +0000
Message-Id: <20260119160535.1874628-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd701313303a1kunm9c9edabf1c1830
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUwaVkxPSUIfTxhJSExIT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dH+S3Pf6sKuXArTTtv9klJcxVxwQ1rlL9S21y1vTYJl5J8GlaBhtYjPPOqFPa86QA5Nv39qMKVEga5Px1Xwu/hhI7ERna9jaImuajK3ZH7TjYI4wNsbmXP/lQ9fjaqfoZb6itSrLjyTsj+Q8mtzVY4Yj8jY9D/4qUVUjyvgqOAQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ukCZIDe90pweupxmfBDddRCcGudFsX1bV9Oymu5CYL8=;
	h=date:mime-version:subject:message-id:from;

The functions ath11k_mac_setup_bcn_tmpl_ema() and
ath11k_mac_setup_bcn_tmpl_mbssid() allocate memory for beacon templates
but fail to free it when parameter setup returns an error.

Since beacon templates must be released during normal execution, they
must also be released in the error handling paths to prevent memory
leaks.

Fix this by adding the missing deallocation calls in the respective
error paths.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
Fixes: 335a92765d30 ("wifi: ath11k: MBSSID beacon support")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/wireless/ath/ath11k/mac.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4dfd08b58416..005cc81a3244 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1561,8 +1561,10 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
 	}
 
 	if (tx_arvif == arvif) {
-		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb))
+		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb)) {
+			ieee80211_beacon_free_ema_list(beacons);
 			return -EINVAL;
+		}
 	} else {
 		arvif->wpaie_present = tx_arvif->wpaie_present;
 	}
@@ -1623,9 +1625,9 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
 
 	if (tx_arvif == arvif) {
 		if (ath11k_mac_set_vif_params(tx_arvif, bcn))
-			return -EINVAL;
+			goto err;
 	} else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn)) {
-		return -EINVAL;
+		goto err;
 	}
 
 	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, 0);
@@ -1636,6 +1638,10 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
 			    ret);
 
 	return ret;
+
+err:
+	kfree_skb(bcn);
+	return -EINVAL;
 }
 
 static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
-- 
2.34.1


