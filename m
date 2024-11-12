Return-Path: <linux-wireless+bounces-15203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A39C5A4A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 15:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411A21F2673E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632571FCC6E;
	Tue, 12 Nov 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5VUMWCJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB01FCC58
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421462; cv=none; b=hTMJV2rJK1ixCn8KvmbpQzRtvsvwytHiTwGl2TbrYCpajGpqbeQt3Go4wOfIPzhOzCKGXtFAj7J/h+kIhiOJ7RKI9b6mN7N5h7InByyGT6aqWhL0jnipXQHqBnOuId9K5FCAYyy3VNJ5qPUuAPy1hTJSBC/c6bpS87Npv712At0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421462; c=relaxed/simple;
	bh=IHLP6yd+FbhJQsArnHXgBfk3eCoKYNUQRmCYiFedb3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rUIvDJXG7X1GGc212ZChtbe5sxmQU5GvxVTxx95dWNB/UBDYlRZlYPkzUf9lMt06fYi5U9GGmXO3CbEbZOmL71DHrY/qHULgHWPO+4MYNbegfxQphca7W7dJ1PKCElfkMZEGEM1g+M1IEdwYmb9nYmKpCGZ9w1uaRjFm9nfqrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5VUMWCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4065C4CECD;
	Tue, 12 Nov 2024 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421461;
	bh=IHLP6yd+FbhJQsArnHXgBfk3eCoKYNUQRmCYiFedb3w=;
	h=From:To:Cc:Subject:Date:From;
	b=G5VUMWCJAMgHp25y+dyQ54Htz1ThIoOCA4CgelVq3ggFtScFNimGUBFWAKUntWS5R
	 ksznmIzGdjm0N2XK9ipcwfPX/+IuvkmyijoiDlCuEArPMhjVwiilbRYIpQXMP3i4Gp
	 c+h6c+jmGr7TokAaVVSZ52JenkVWTksxK10K0oS6tMlaDleuM0IWeNDP/67SaYj955
	 9A5C6qi2bk+MXMYMiw8uMKGt6xDAsf5cM9/Fcc9QifklFbJE/2yw5PHCu3mEKzMuvN
	 /w6BYqoOz1OSv/dsyhAVn1b6sLVsqeUkePR8epghVxTIZmp0dzKEG+psFArq7l2/pr
	 BzViNf5k6n48Q==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: Alf Marius <post@alfmarius.net>,
	Andrii Batyiev <batyiev@gmail.com>
Subject: [PATCH] Revert "wifi: iwlegacy: do not skip frames with bad FCS"
Date: Tue, 12 Nov 2024 16:24:19 +0200
Message-Id: <20241112142419.1023743-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 02b682d54598f61cbb7dbb14d98ec1801112b878.

Alf reports that this commit causes the connection to eventually die on
iwl4965. The reason is that rx_status.flag is zeroed after
RX_FLAG_FAILED_FCS_CRC is set and mac80211 doesn't know the received frame is
corrupted.

Fixes: 02b682d54598 ("wifi: iwlegacy: do not skip frames with bad FCS")
Reported-by: Alf Marius <post@alfmarius.net>
Closes: https://lore.kernel.org/r/60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com/
Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/3945.c     | 2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945.c b/drivers/net/wireless/intel/iwlegacy/3945.c
index 14d2331ee6cb..b0656b143f77 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945.c
@@ -566,7 +566,7 @@ il3945_hdl_rx(struct il_priv *il, struct il_rx_buf *rxb)
 	if (!(rx_end->status & RX_RES_STATUS_NO_CRC32_ERROR) ||
 	    !(rx_end->status & RX_RES_STATUS_NO_RXE_OVERFLOW)) {
 		D_RX("Bad CRC or FIFO: 0x%08X.\n", rx_end->status);
-		rx_status.flag |= RX_FLAG_FAILED_FCS_CRC;
+		return;
 	}
 
 	/* Convert 3945's rssi indicator to dBm */
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index fcccde7bb659..05c4af41bdb9 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -664,7 +664,7 @@ il4965_hdl_rx(struct il_priv *il, struct il_rx_buf *rxb)
 	if (!(rx_pkt_status & RX_RES_STATUS_NO_CRC32_ERROR) ||
 	    !(rx_pkt_status & RX_RES_STATUS_NO_RXE_OVERFLOW)) {
 		D_RX("Bad CRC or FIFO: 0x%08X.\n", le32_to_cpu(rx_pkt_status));
-		rx_status.flag |= RX_FLAG_FAILED_FCS_CRC;
+		return;
 	}
 
 	/* This will be used in several places later */

base-commit: f2aadc721274a4b27d3dfe8244e73fbdc8c17715
-- 
2.39.5


