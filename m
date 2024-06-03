Return-Path: <linux-wireless+bounces-8413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D748D7E48
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 11:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C4728138D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCEB824B9;
	Mon,  3 Jun 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="H5gTBkN3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5327E578
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406153; cv=none; b=ua8ahbzCRCmxMPz6duQvw6OKDO+SoF280gsgk1GnWbvr07ap9vL9W7FmH4BdNixl5vbiusNTAtU6RvmggHXxmENxw3HoiXSYDJPSMS5B4omdTOS+t5+kKDhRede7Ng98nf9HD8Q9Wx61Bi9F0/+2TjQWijhnmBQgLK/DtlKyZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406153; c=relaxed/simple;
	bh=zqhSOx9TEsK+ntdJ3WpSkCqHwe22qFXbYtLRZFiNxlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQtsjKzzg6kaAFNab72Weu12lliVyOGBpbP2lvxWkCqJ8lX+9tLWpyqsywRToTWArs+5vQjFasU3+RkTWPpXe9fzh5aJlT1w2Q01Ieg6ARtNoiKgqIO5CJ4PeEM0X8HgCXdsPpchZs0rPMLCh4BfZg4FYBpNUCo3v1NCpbd2A0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=H5gTBkN3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=CdJ6gRXs+1B22Jl+/VUs3m4FLJ6sLe4o/fPCvArtSI0=; b=H5gTBk
	N3AuM5oQ1fxOx4oqj1HgM/wZEvUkmqF+OTSqLBsMFDZkX7vd+ZOCL5sGkSsmfyML
	G1NZWTNQxa8GfY8sBgh/xma7jryPqVu0dO80B168RvqgYpnJX8YJLqo3jTtsMH0Y
	L14SxeIuzB5nzwg5h+fJ3WFJuBSmXn7RuWxBaJHlR1TAA7GTFZ+kCoXLuHq/3CtK
	SzRhqLWIriJkXy0ZhVoS3B0Bv4NWQt4pCYqrKF5kQu/oYvWM5v6JciND1GiFqQ68
	UcgC8B1dmTgEg3th0sjs+h18MisPp5PQLt4piO/d/JvlVK1lx0cBtAZQda9QfkPt
	lp9jEGT4IKtbOLYQ==
Received: (qmail 1899341 invoked from network); 3 Jun 2024 11:15:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 11:15:47 +0200
X-UD-Smtp-Session: l3s3148p1@861Xx/gZEoYgAwDPXzLGAH1eNELjOc3g
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] wifi: mac80211: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon,  3 Jun 2024 11:15:36 +0200
Message-ID: <20240603091541.8367-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/wireless/marvell/mwl8k.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index d3d07bb26335..241a02a0accd 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2211,7 +2211,7 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, struct mwl8k_cmd_pkt_hdr *cmd
 	dma_addr_t dma_addr;
 	unsigned int dma_size;
 	int rc;
-	unsigned long timeout = 0;
+	unsigned long time_left = 0;
 	u8 buf[32];
 	u32 bitmap = 0;
 
@@ -2258,8 +2258,8 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, struct mwl8k_cmd_pkt_hdr *cmd
 	iowrite32(MWL8K_H2A_INT_DUMMY,
 		regs + MWL8K_HIU_H2A_INTERRUPT_EVENTS);
 
-	timeout = wait_for_completion_timeout(&cmd_wait,
-				msecs_to_jiffies(MWL8K_CMD_TIMEOUT_MS));
+	time_left = wait_for_completion_timeout(&cmd_wait,
+						msecs_to_jiffies(MWL8K_CMD_TIMEOUT_MS));
 
 	priv->hostcmd_wait = NULL;
 
@@ -2267,7 +2267,7 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, struct mwl8k_cmd_pkt_hdr *cmd
 	dma_unmap_single(&priv->pdev->dev, dma_addr, dma_size,
 			 DMA_BIDIRECTIONAL);
 
-	if (!timeout) {
+	if (!time_left) {
 		wiphy_err(hw->wiphy, "Command %s timeout after %u ms\n",
 			  mwl8k_cmd_name(cmd->code, buf, sizeof(buf)),
 			  MWL8K_CMD_TIMEOUT_MS);
@@ -2275,7 +2275,7 @@ static int mwl8k_post_cmd(struct ieee80211_hw *hw, struct mwl8k_cmd_pkt_hdr *cmd
 	} else {
 		int ms;
 
-		ms = MWL8K_CMD_TIMEOUT_MS - jiffies_to_msecs(timeout);
+		ms = MWL8K_CMD_TIMEOUT_MS - jiffies_to_msecs(time_left);
 
 		rc = cmd->result ? -EINVAL : 0;
 		if (rc)
-- 
2.43.0


