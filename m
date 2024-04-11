Return-Path: <linux-wireless+bounces-6195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F18A1D45
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 20:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC1284F21
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1EE47F7F;
	Thu, 11 Apr 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzrAUti7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380944D112
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854608; cv=none; b=BHngthIylS2XoxHQNMzrqBWcpG89chAHg/Kx7sxQ7pccZTlW4fvbkKX0/TAJeIFFnEl+elZ6VJtvCk8uV22DDIOjWJIExqsegtlHUpss0+W5v97z57sf0Isqcfrzq7UT2umhSh2KoKR6OmNeM9loE8wIV8k78nna/Oy+tYWQ/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854608; c=relaxed/simple;
	bh=G3zPg14bSk43X5LOlcPxEHGSWhzhgoUV/wAnydN/2hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H34kdV0dZSC27KaBx/X52tCAHtz3js82ZC1vds5v7nK1Y8hS6OdlkY8PDh9suRCWZgPG1SgvTwu/0EC/3ygErYxoZhX8NjXEpmdhYPXvtpXFf3ZmhMTifCLV65+oAjnMIO7BzOppFrclNWDu/EF2dd2Pu+hsflSLggDl8JVBs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzrAUti7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2652FC072AA;
	Thu, 11 Apr 2024 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854607;
	bh=G3zPg14bSk43X5LOlcPxEHGSWhzhgoUV/wAnydN/2hc=;
	h=From:To:Cc:Subject:Date:From;
	b=fzrAUti7gREBqTUX+oPajqdRUKdSdH+x01P8ndHlm7ecDBysWDYcrvy1crkOUAXqm
	 MSagXJS0VYw3NuWs4fcug2ikuLCABcH4ihI/3R55o0BSCyplx9LgXPEB1F0AzGaGbD
	 EY2DvsHY4S68nl18+NtvNqz434XioU1iYOKKW0zx+vP446u0AVXLm1f2uP2tmpI2dG
	 PQbtLUWKTCWFnH71mLmymoetXfu4q7drvbU5q0LfoSZzAlqSKhXC1AawgW2eYVkqvK
	 llDqZNdEq1GQJFaowCdAHP/pcF0PeEXz6KWD857IGsjdmFTTTWlVpTBQq4TV1dblul
	 mzo7YOyeCHxeA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
Date: Thu, 11 Apr 2024 19:56:45 +0300
Message-Id: <20240411165645.4071238-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

ath12k will support Multi-Link Operation (MLO) in the future but not yet. A
major change with MLO is that cfg80211 will disable Wireless Extension (WEXT)
user space interface. To avoid having inconsistent user experience, first
supporting WEXT and later not, disable WEXT already now.

Now ath12k claims that WEXT is not supported:

$ iwconfig wlan0
wlan0     no wireless extensions.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f15dcd75157d..e989628d7d72 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8556,6 +8556,12 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
+	/* MLO is not yet supported so disable Wireless Extensions for now
+	 * to make sure ath12k users don't use it. This flag can be removed
+	 * once WIPHY_FLAG_SUPPORTS_MLO is enabled.
+	 */
+	wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
+
 	hw->queues = ATH12K_HW_MAX_QUEUES;
 	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
 	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;

base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
-- 
2.39.2


