Return-Path: <linux-wireless+bounces-22506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6ACAAA43A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F96A1884DA6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 23:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4527E1AB;
	Mon,  5 May 2025 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoHagcy8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEAF2FCA9B;
	Mon,  5 May 2025 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483960; cv=none; b=rkY/gMJUOYvXKv0zydRHyhTzkdZbH1pc1Rk5s8DNqCq9oYKAwewyt9FolbXc7I5lG1OBsUJEj0fwPg0yuafOmWti3+pDl+Xss1NqC8rAkF0kTWY0f1T2roElSaL/tvpUaiRQxCOzaCZdu5j/XIkXtS5SZIhrBvI05oVc6p/8U9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483960; c=relaxed/simple;
	bh=JfQQYIUu517awFWeygbO+llhgDES4MfHAR7evtgUobM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZIZnDUn/WX3v6YxXDn/LULGuwe5tD0jLBTCYDjzSEzWy6ksSq/C26SK2b9y8rOkt7aYolmuP78/9tZhE+hqtbp073/jjsohFYjYOCUpXuagnB4rPyScv3n4v+jnFttOc175HR1a+wcG0vQEL74Or+JDodk2o2WYwlBf8RWn3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoHagcy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F996C4CEEF;
	Mon,  5 May 2025 22:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483960;
	bh=JfQQYIUu517awFWeygbO+llhgDES4MfHAR7evtgUobM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uoHagcy8QckWKLAeFhLNzd2amN3C/iwnf2+O8DSkgJA9VDXbztzTGaAfpXYFzR9NY
	 BgJowhdD6JPuQW8/cJTFRAuFpnRSH4JB9pUpBON7HQet20Poq6+45Z5xCpebpioyd1
	 BdcUVMaD2rLrzvFduJG54MBfF5zMErwtcTF6P8ZG2vaqz7wSihWThgUTyNDLKiIkaq
	 LWDHQOfdLdzmVxhnICInZxs/fn+ZOAwzoL0ld1ee9DTHLm3pldi+8EDaTcJVv6u5mA
	 8Nrt2C+tMjY51UPJ5uPW5FGXPY4krKf4SDl3NUWn3OHvpcrbsCAVhB2MisnKugvEXP
	 KdDNPw71nXXfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinith Kumar R <quic_vinithku@quicinc.com>,
	Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 292/642] wifi: ath12k: Report proper tx completion status to mac80211
Date: Mon,  5 May 2025 18:08:28 -0400
Message-Id: <20250505221419.2672473-292-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Vinith Kumar R <quic_vinithku@quicinc.com>

[ Upstream commit d2d9c9b8de725e1006d3aa3d18678a732f5d3584 ]

Currently Tx completion for few exception packets are received from
firmware and the tx status updated to mac80211. The tx status values of
HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP and HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL
are considered as tx failure and reported as tx failure to mac80211.
But these failure status is due to internal firmware tx drop and these
packets were not tried to transmit in the air.
In case of mesh this invalid tx status report might trigger mpath broken
issue due to increase in mpath fail average.
So do not report these tx status as tx failure instead free the skb
by calling ieee80211_free_txskb(), and that will be accounted as dropped
frame.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Vinith Kumar R <quic_vinithku@quicinc.com>
Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://patch.msgid.link/20241122173432.2064858-1-quic_tamizhr@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 1fffabaca527a..75608ae027afe 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -560,13 +560,13 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 
 	switch (wbm_status) {
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_OK:
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
-	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
 		ts.acked = (wbm_status == HAL_WBM_REL_HTT_TX_COMP_STATUS_OK);
 		ts.ack_rssi = le32_get_bits(status_desc->info2,
 					    HTT_TX_WBM_COMP_INFO2_ACK_RSSI);
 		ath12k_dp_tx_htt_tx_complete_buf(ab, msdu, tx_ring, &ts);
 		break;
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
+	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
 		ath12k_dp_tx_free_txbuf(ab, msdu, mac_id, tx_ring);
-- 
2.39.5


