Return-Path: <linux-wireless+bounces-31004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A97D3BF64
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15E814F655B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2F328B56;
	Tue, 20 Jan 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="XTeyhX80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68A2EB85E;
	Tue, 20 Jan 2026 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891061; cv=none; b=IWZFKBybcFyqsnDBWA9SdwiBdJkZaHEAauLPhE/efWadQyJvo/8wOISgkhZkB+zsO8B2zDOrFIzAzX3JUWSmHQz1iTtTxBMk6SPg06R/PzWunxHorcMcI7CtOkkVIH4ZlGi4NWrrftq0Q8Apf3/VhG30jQjVYyRc5cny9jSPfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891061; c=relaxed/simple;
	bh=z/XC+nsnk6+IKPDr1voiVT4RhivEZva3lTH46PV7QXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qLkjGjq5A8MfXp6yy4fwOhpQ9kr6Jjqykr3iHVGtIXgVmMjL/uL2b6nQqwBpbRyydBgY1qjEL5RE8o8lq0aOiNmCn/wYu3qyv9lasu5jnXc6gRJY91baaxUSYhGIcFWwYCYTHBd34unErCDUZh415NJSXFY82R5g+JZS8Z8MV5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=XTeyhX80; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3142e9bc2;
	Tue, 20 Jan 2026 14:37:33 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] wifi: ath11k: fix memory leaks in beacon template setup
Date: Tue, 20 Jan 2026 06:37:31 +0000
Message-Id: <20260120063731.2383695-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bda1f76b503a1kunm397afc672020ab
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTk0aVkgaTENITkxMGh9ISFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XTeyhX80RUqjgcEmRlTWq/TzbQcIDl+LPLyjT4qYuIbeIU1TWYAFomlJzoqh7Jc9TJNPpBsz9pWZit5fYezE21363pluZ2ccKqW0+fiNcCquvnjZUIxQgWqoSCWUA+pr0ooyKXS8H9MADXJVkCY6vZwmu5Nzntpj6HKLVFe9VT4=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=544/TIMDJCitrXRz3cchjCp+Op8D6J6tsN+HJoq6ZEM=;
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
Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Use unified exit paths for cleanup.

 drivers/net/wireless/ath/ath11k/mac.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4dfd08b58416..42edcc5e9e49 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1561,8 +1561,10 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
 	}
 
 	if (tx_arvif == arvif) {
-		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb))
-			return -EINVAL;
+		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb)) {
+			ret = -EINVAL;
+			goto free;
+		}
 	} else {
 		arvif->wpaie_present = tx_arvif->wpaie_present;
 	}
@@ -1589,11 +1591,11 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
 		}
 	}
 
-	ieee80211_beacon_free_ema_list(beacons);
-
 	if (tx_arvif != arvif && !nontx_vif_params_set)
-		return -EINVAL; /* Profile not found in the beacons */
+		ret = -EINVAL; /* Profile not found in the beacons */
 
+free:
+	ieee80211_beacon_free_ema_list(beacons);
 	return ret;
 }
 
@@ -1622,19 +1624,22 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
 	}
 
 	if (tx_arvif == arvif) {
-		if (ath11k_mac_set_vif_params(tx_arvif, bcn))
-			return -EINVAL;
+		if (ath11k_mac_set_vif_params(tx_arvif, bcn)) {
+			ret = -EINVAL;
+			goto free;
+		}
 	} else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn)) {
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free;
 	}
 
 	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, 0);
-	kfree_skb(bcn);
-
 	if (ret)
 		ath11k_warn(ab, "failed to submit beacon template command: %d\n",
 			    ret);
 
+free:
+	kfree_skb(bcn);
 	return ret;
 }
 
-- 
2.34.1


