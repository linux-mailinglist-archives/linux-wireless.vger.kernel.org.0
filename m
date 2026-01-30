Return-Path: <linux-wireless+bounces-31358-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFdTOJ9vfGk/MgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31358-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 09:45:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 382AFB8988
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 09:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2587B301014B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE933335579;
	Fri, 30 Jan 2026 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="aIvtVqc9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798233F39B;
	Fri, 30 Jan 2026 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762708; cv=none; b=ZXYt8ehX/ADMEObzhlY7bPvHVNZjmHEp2ukawVjNZgBgHt/HgD/lXwV09bvY8A87sI61rESZXqAAH+wzXrfpPFVniLjseR8LueMfoIwRRCiK1fAsjwOAP5XHYOAZunmuiEczBdyUaIR+LEu8QbmVS8EOUJ+sUbNnnXcyNrRqIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762708; c=relaxed/simple;
	bh=3zgKGSGCsn984ZfTtUB4BRYqvA+yp49eMfhJ1vpwyRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UWfkB4QFaYWFBwwrGnlw3+M5SKS4WX4X39p/Ssbp7acmehVfw9MqWWW/UGa9L48pwkHM307utrQJ0G8zIYdSsnP/CVn8qCy5t17TlO6eGJpMc6WwwZE+El3B0EUfErGP/Z/ctj63jlG1ofigsW1IzAIesC/8OJux7STRtUAz3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=aIvtVqc9; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 328b8ae14;
	Fri, 30 Jan 2026 16:44:54 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org,
	baochen.qiang@oss.qualcomm.com,
	jianhao.xu@seu.edu.cn,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v3] wifi: ath11k: fix memory leaks in beacon template setup
Date: Fri, 30 Jan 2026 08:44:51 +0000
Message-Id: <20260130084451.110768-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0e13a3a003a1kunm4e2d4f0f14cedb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTksaVh4dS0sYTkNMGR9LTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=aIvtVqc9Ky8KdJSoVNHyPpBCzBCBoRE9xvk79lXeNMs3OHO3u0YQsA/utT2H8NOkT+NcPJcr44INSjTkB4gczTQCG0DkMw8QbbuFrEtAZLUZ/AgOXp567RVH/snhPsasqspE1yp7U0quuxHc8hS15WU/YTB+tyFMePTRRjv2qyQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=8NrH7IJo/8+ZqcBtk4ukR127UMxGs74cURPlgAcvspA=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31358-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 382AFB8988
X-Rspamd-Action: no action

The functions ath11k_mac_setup_bcn_tmpl_ema() and
ath11k_mac_setup_bcn_tmpl_mbssid() allocate memory for beacon templates
but fail to free it when parameter setup returns an error.

Since beacon templates must be released during normal execution, they
must also be released in the error handling paths to prevent memory
leaks.

Fix this by using unified exit paths with proper cleanup in the respective
error paths.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
Fixes: 335a92765d30 ("wifi: ath11k: MBSSID beacon support")
Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v3:
- Add goto path for the beacons->cnt check for strict logical consistency.

Changes in v2:
- Use unified exit paths for cleanup.

 drivers/net/wireless/ath/ath11k/mac.c | 28 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4dfd08b58416..e872f416ea97 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1557,12 +1557,15 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
 	if (!beacons || !beacons->cnt) {
 		ath11k_warn(arvif->ar->ab,
 			    "failed to get ema beacon templates from mac80211\n");
-		return -EPERM;
+		ret = -EPERM;
+		goto free;
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
@@ -1589,11 +1592,11 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
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
 
@@ -1622,19 +1625,22 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
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


