Return-Path: <linux-wireless+bounces-22481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A18AAA033
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6159A17A08F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14D28F53E;
	Mon,  5 May 2025 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFita2pJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DBB28EA74;
	Mon,  5 May 2025 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483413; cv=none; b=jEAr8khPTJNau71pjvaHMW5V4wQ9aKWG/79MQ3eD1F2mE1cjLLn84YsaldjtgPNYxGmXYJbULc7NyhvlMyoOkSzru+E7AMUCiYIIwPIE/uU8yIBnBW2YL7YZSNnzFY/qyYLdJgmEBKYf/G7pg83ktX0+vcq/KWFgNvjl7DvY6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483413; c=relaxed/simple;
	bh=vhBSOQqn4WDnjy878rsFzTsVTFtg8A4FUAsaohGjjtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jO0XBZD5Ch/bjA4XtbBX68nLiG1g7J3hq5LOWSSIpkLXBQwzwO6RZQCVPTigzzVMFLa4P2wj5vMXMvAMGtHsCIIY1zHiK7Wxv3nHcmdUKmeS3wwnscWxEd2XsMWUJUyFzMzgkPaBgDC0YKEJbsIUX4WP3wZTxF9yYK43ONOi2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFita2pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0032C4CEF1;
	Mon,  5 May 2025 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483413;
	bh=vhBSOQqn4WDnjy878rsFzTsVTFtg8A4FUAsaohGjjtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFita2pJ8EItYQ/AmlzcZa5EdUpGPBGl7weskS7WAqgG/08CDSFlURcM6qwiWCyBx
	 7VCh58gS8+rMkIFiFYan0wJNVEN8k0PMQZAFiz1ducBrw6ISIgujzd7WaD+MQiATqz
	 QwjFxWxFvwM2dBt5ZxPzfWD/Yqszm/o2QtA1HpY3fcNPj+ZarTVplkjzmL37zmHe3H
	 2FbDsmKYjJL/dBoMf/exa5urLTIJmBaOa6YoHTErFViYkbu7UxhPPuAeTeXwzhkDS6
	 avdjdYfweXPN3uIrrDv+CchNV5ICNw43VqjYooqGrm85niq9QF1VjpjZyp+FG3zi6j
	 UMXAbep+H0UgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 073/642] wifi: mt76: scan: fix setting tx_info fields
Date: Mon,  5 May 2025 18:04:49 -0400
Message-Id: <20250505221419.2672473-73-sashal@kernel.org>
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

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 5b5f1ca9ce73ab6c35e5cd3348f8432ba190d7f4 ]

ieee80211_tx_prepare_skb initializes the skb cb, so fields need to be set
afterwards.

Link: https://patch.msgid.link/20250311103646.43346-8-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/scan.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 1c4f9deaaada5..9b20ccbeb8cf1 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -52,11 +52,6 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 		ether_addr_copy(hdr->addr3, req->bssid);
 	}
 
-	info = IEEE80211_SKB_CB(skb);
-	if (req->no_cck)
-		info->flags |= IEEE80211_TX_CTL_NO_CCK_RATE;
-	info->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
-
 	if (req->ie_len)
 		skb_put_data(skb, req->ie, req->ie_len);
 
@@ -64,10 +59,20 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
 
 	rcu_read_lock();
-	if (ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL))
-		mt76_tx(phy, NULL, mvif->wcid, skb);
-	else
+
+	if (!ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL)) {
 		ieee80211_free_txskb(phy->hw, skb);
+		goto out;
+	}
+
+	info = IEEE80211_SKB_CB(skb);
+	if (req->no_cck)
+		info->flags |= IEEE80211_TX_CTL_NO_CCK_RATE;
+	info->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
+
+	mt76_tx(phy, NULL, mvif->wcid, skb);
+
+out:
 	rcu_read_unlock();
 }
 
-- 
2.39.5


