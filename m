Return-Path: <linux-wireless+bounces-5008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC69881748
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39181F232AD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBC16CDDA;
	Wed, 20 Mar 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO/g+7rY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845A6CDB2
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959095; cv=none; b=pBdj31/0yV+L3xnUYjWBChkQMivwO/rW90od1DvcxD6SkcQn1avRYgg1Zhm4tf6n4gG+Nn8AJnybVoI3/t5i8gZ37aAigWnHU1kZchs0VN+CpKhJ5CnlDdOFPM3M59vky1zEDwa7vwZcuDJzIFSb5l7161zO4TfY0g8VmLJ/4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959095; c=relaxed/simple;
	bh=KUkEF0Cuq4xY9j/WK0ZfSwkXNMWtQ9vbE5h+ntRtvnE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsmHWvjhJLCTI/yM6K3LU7Yb4o6tWhRvIiFxrIbMhSjbc7lnovwCjqqnhce2vwSOTrthq0xQt/00sAhZT7Kpyyp1txlAsdiIvSJyplFNO/mrym04A6QlddQDge+0myitiUnfTav+m+nsP6t0ciDC7LEjhi/qyLYhFFr2UR+cLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO/g+7rY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4AAC433C7
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710959095;
	bh=KUkEF0Cuq4xY9j/WK0ZfSwkXNMWtQ9vbE5h+ntRtvnE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sO/g+7rYvDiHpNeUZ38UZKdiEIu8YF3v520InHDMpyUET+SIYIwB0wRN/WCekTqIZ
	 v+cvbF67FmDD0JxRjwjM/c3aycuJJiRwR/W2qjqNwnejq+foaoy29gRv/ln3Jlfpm0
	 +QhZZ0HvIzCvjO4wAS1xeuzs0qXV3NoHjuzfwQWTccxnIbRF2oWBhtu00oPAKh7RKQ
	 //kzszhYEsQg1D5tswIKWTO29OBDqc5Kbdspn3V2AxMzNFnREc2QKsgGtMvReqejqi
	 cgHlwFdJtOnNVDUTaF9VwF3cW22o7+LjvjVfiYqhsZ+LQu3jVb6koGgPxTxRRO/GM+
	 uDudECHjfUXTQ==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] wifi: wcn36xx: main: fix sparse warnings
Date: Wed, 20 Mar 2024 20:24:48 +0200
Message-Id: <20240320182449.3757215-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320182449.3757215-1-kvalo@kernel.org>
References: <20240320182449.3757215-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Sparse warns:

drivers/net/wireless/ath/wcn36xx/main.c:758:58: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/wcn36xx/main.c:758:58:    expected unsigned short [usertype] vht_rx_mcs_map
drivers/net/wireless/ath/wcn36xx/main.c:758:58:    got restricted __le16 [usertype] rx_mcs_map
drivers/net/wireless/ath/wcn36xx/main.c:760:58: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/wcn36xx/main.c:760:58:    expected unsigned short [usertype] vht_tx_mcs_map
drivers/net/wireless/ath/wcn36xx/main.c:760:58:    got restricted __le16 [usertype] tx_mcs_map

le16_to_cpu() was just missing. Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index bfbd3c7a70b3..e760d8002e09 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -756,9 +756,9 @@ static void wcn36xx_update_allowed_rates(struct ieee80211_sta *sta,
 	if (sta->deflink.vht_cap.vht_supported) {
 		sta_priv->supported_rates.op_rate_mode = STA_11ac;
 		sta_priv->supported_rates.vht_rx_mcs_map =
-				sta->deflink.vht_cap.vht_mcs.rx_mcs_map;
+			le16_to_cpu(sta->deflink.vht_cap.vht_mcs.rx_mcs_map);
 		sta_priv->supported_rates.vht_tx_mcs_map =
-				sta->deflink.vht_cap.vht_mcs.tx_mcs_map;
+			le16_to_cpu(sta->deflink.vht_cap.vht_mcs.tx_mcs_map);
 	}
 }
 
-- 
2.39.2


