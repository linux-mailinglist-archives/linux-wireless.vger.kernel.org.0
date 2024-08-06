Return-Path: <linux-wireless+bounces-10982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C885C9486AC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 02:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C02B23203
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2723AEBE;
	Tue,  6 Aug 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="owaiRq5m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228C8F62
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904892; cv=none; b=ZZunXIvjW5nSFt8j/qr3dSGHu50s1Yse8hUYNDIQItgHa1EKuH3wTEkL44WwFK2sBU0vjRxNrG6C2C1+5d5Jq0cebKIeomC3v5AbDw79s0khmpIBjLv+SpM9dtWKb57jrmH86m+Tb0WS8wnvW7jkyKFru0vXjtv1PC5/MF8igNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904892; c=relaxed/simple;
	bh=iqlEX4A0QrpNFkzwsk4HphEl3DI0MhY7Zg8ZeXn4HiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/dM3lxPhEIg+0vL0vyNuElcAnLdnh2isC+n3745yXGMaSGuhP2tF/9alQb1131zZFce0kNQ+hgWsjukw69hdLxjBOBk0xcrV2x7EhTq+a4DUimJQyT18q5f7ewkAtxOaJuxFnzQrDc9YOWm4ze2nPEwFKm0Yp8SCHp+Obzb0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=owaiRq5m; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 00C862A3949
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 00:41:23 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7BA401000D9;
	Tue,  6 Aug 2024 00:41:15 +0000 (UTC)
Received: from carkeek.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E7A9813C2B3;
	Mon,  5 Aug 2024 17:41:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E7A9813C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1722904875;
	bh=iqlEX4A0QrpNFkzwsk4HphEl3DI0MhY7Zg8ZeXn4HiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owaiRq5mGhtU5WsC/SK7w/jJtv/SRoQ3NrdtFdR9wAqnvjn8A7f96dR3cv0qaTfud
	 k5/TZQxgiyxij3GXuSsaXGzd3lFxyd0Gigy3fJ2F+PLDHH7daPUPfcLZYKS8nSpchT
	 YhpOTTLsHweToht39TfdRe/CvK4KOqPu2uweZhVA=
From: Rory Little <rory@candelatech.com>
To: kvalo@kernel.org,
	johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH 2/2] wifi: ath10k: Removed atomic iteration in bitrate mask clear.
Date: Mon,  5 Aug 2024 17:40:24 -0700
Message-Id: <20240806004024.2014080-3-rory@candelatech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806004024.2014080-1-rory@candelatech.com>
References: <20240806004024.2014080-1-rory@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1722904876-yqWhOzTSY8xC
X-MDID-O:
 us5;ut7;1722904876;yqWhOzTSY8xC;<rory@candelatech.com>;9989741adba0574bb335b9e9d00002fb

This operation requires some blocking calls, which causes issues when
attempting to guard this iteration's critical section with an RCU lock.
Instead, we will take advantage of the held wiphy mutex to protect this
operation.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 7579a1cd7d15..a1a13b9ad465 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -9502,9 +9502,9 @@ static int ath10k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			     ar->normal_mode_fw.fw_file.fw_features);
 	if (allow_pfr) {
 		mutex_lock(&ar->conf_mutex);
-		ieee80211_iterate_stations_atomic(ar->hw,
-						  ath10k_mac_clr_bitrate_mask_iter,
-						  arvif);
+		ieee80211_iterate_stations_mtx(ar->hw,
+					       ath10k_mac_clr_bitrate_mask_iter,
+					       arvif);
 		mutex_unlock(&ar->conf_mutex);
 	}
 
-- 
2.34.1


