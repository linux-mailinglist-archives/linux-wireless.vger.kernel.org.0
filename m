Return-Path: <linux-wireless+bounces-5007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8DF881747
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E7A1F23400
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B16BFCD;
	Wed, 20 Mar 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AK6VPbC1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E006CDB2
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959094; cv=none; b=Ewm1St5VIIdQbmlAJlFNEQ8t4kvXxQrGxzmiss9XnuPa9lR2mo33zq29bK8oxwraaCtgWB4yCYngC1R80r0KroPt/JEoAc70MFM4yNA5LFC8bQFD4R5Kd7RzLDah/VlSA91yGedk69mcEp+ZmGB45rszXAT+r7Spuf8Mu+l0dTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959094; c=relaxed/simple;
	bh=EdsIChZtlt3+f2B8MK1ZkqevOlxjM8SzjWHSpkXMwxs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtazeRVCZMpBqNYNT76JcC6kPD8u62w+w8DM1B72JxvVxy4d3x6qnRM5e7KV3iztbtkeQpKcCZfC31HmQiz04xgNbLO1su4dXoXTS/UVFuID7PG/R0COtci9HumK5hsGpSsEvKdmuMQ0obNv7SpG3DhW0oUF67PB4/EGlwNeKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AK6VPbC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E94C43390
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710959094;
	bh=EdsIChZtlt3+f2B8MK1ZkqevOlxjM8SzjWHSpkXMwxs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AK6VPbC1mPm8WxVf3GwN8VwE44Pow6lwHel/AkEc7HidMNwBhWCO7l6t0mSl4VVTp
	 KZ4+wWs3MgEX5gtS99WtTd81pjjkuJXFnq4X67EQZ9PmPm5Td6PraEv7SV3je9xQnY
	 ePygyfj90cB3wj8gzODNWV66YAWGS8VODG/jaPax00PrMxQP/B/SoFO5zLSAR/A0Ch
	 ZSxpTbRFTLZSFv22Hv5mS2I8iMmEa9MmFC2H9sRJckhvq6pdH8h8fsQ5rTAf7YOcbW
	 JRBc3uWbA7d4P/dXfr5OGFggj9sQNMUNwfadt6c9o8sFI69VGwoPkwyolLXkCMKQ4l
	 NFDktBGvyhb7g==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] wifi: wcn36xx: buff_to_be(): fix sparse warnings
Date: Wed, 20 Mar 2024 20:24:47 +0200
Message-Id: <20240320182449.3757215-3-kvalo@kernel.org>
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

drivers/net/wireless/ath/wcn36xx/txrx.c: note: in included file (through drivers/net/wireless/ath/wcn36xx/txrx.h):
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24:    expected unsigned int [usertype]
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24:    got restricted __be32 [usertype]
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24:    expected unsigned int [usertype]
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24:    got restricted __be32 [usertype]

Use void pointers and two separate variables to workaround the warning. Also
now the callers don't need any casting. There's actually cpu_to_be32_array()
available but decided to do minimal changes instead.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 4 ++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index 0802ed728824..8826998797d6 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -318,7 +318,7 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 	memset(&status, 0, sizeof(status));
 
 	bd = (struct wcn36xx_rx_bd *)skb->data;
-	buff_to_be((u32 *)bd, sizeof(*bd)/sizeof(u32));
+	buff_to_be(bd, sizeof(*bd)/sizeof(u32));
 	wcn36xx_dbg_dump(WCN36XX_DBG_RX_DUMP,
 			 "BD   <<< ", (char *)bd,
 			 sizeof(struct wcn36xx_rx_bd));
@@ -692,7 +692,7 @@ int wcn36xx_start_tx(struct wcn36xx *wcn,
 		/* MGMT and CTRL frames are handeld here*/
 		wcn36xx_set_tx_mgmt(&bd, wcn, &vif_priv, skb, bcast);
 
-	buff_to_be((u32 *)&bd, sizeof(bd)/sizeof(u32));
+	buff_to_be(&bd, sizeof(bd)/sizeof(u32));
 	bd.tx_bd_sign = 0xbdbdbdbd;
 
 	ret = wcn36xx_dxe_tx_frame(wcn, vif_priv, &bd, skb, is_low);
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index ff4a8e5d7209..bccc27de848d 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -100,11 +100,14 @@ enum wcn36xx_ampdu_state {
 #define RF_IRIS_WCN3660	0x3660
 #define RF_IRIS_WCN3680	0x3680
 
-static inline void buff_to_be(u32 *buf, size_t len)
+static inline void buff_to_be(void *buf, size_t len)
 {
+	__be32 *to = buf;
+	u32 *from = buf;
 	int i;
+
 	for (i = 0; i < len; i++)
-		buf[i] = cpu_to_be32(buf[i]);
+		to[i] = cpu_to_be32(from[i]);
 }
 
 struct nv_data {
-- 
2.39.2


