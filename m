Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFFF2919C6
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Oct 2020 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgJRTTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Oct 2020 15:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbgJRTTq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Oct 2020 15:19:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A5722365;
        Sun, 18 Oct 2020 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048785;
        bh=9Sx0IAu1/0/VuI3DDafXQrRZCdENDRmfs4yGwY71IbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ixSI0YNcxb/oxzJOv61F9P9Y3ZfhlX9A55Riy/V0B7tQdD+58WV6JZR2uJ6iJhVi
         AQAP1Gs4dMH1ZrdqTkaMTi6GgO7RZUHEqe+UWW+9vlLJhMj1c4AFTIX2+1XNzrHK0G
         Q1NKq+G+EqgMEW8NT2bMddN1CiZX8vXxKQ35kRt4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Chiu <chiu@endlessm.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 081/111] rtl8xxxu: prevent potential memory leak
Date:   Sun, 18 Oct 2020 15:17:37 -0400
Message-Id: <20201018191807.4052726-81-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018191807.4052726-1-sashal@kernel.org>
References: <20201018191807.4052726-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

[ Upstream commit 86279456a4d47782398d3cb8193f78f672e36cac ]

Free the skb if usb_submit_urb fails on rx_urb. And free the urb
no matter usb_submit_urb succeeds or not in rtl8xxxu_submit_int_urb.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200906040424.22022-1-chiu@endlessm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 19efae462a242..5cd7ef3625c5e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5795,7 +5795,6 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
 	ret = usb_submit_urb(urb, GFP_KERNEL);
 	if (ret) {
 		usb_unanchor_urb(urb);
-		usb_free_urb(urb);
 		goto error;
 	}
 
@@ -5804,6 +5803,7 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
 	rtl8xxxu_write32(priv, REG_USB_HIMR, val32);
 
 error:
+	usb_free_urb(urb);
 	return ret;
 }
 
@@ -6318,6 +6318,7 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct rtl8xxxu_rx_urb *rx_urb;
 	struct rtl8xxxu_tx_urb *tx_urb;
+	struct sk_buff *skb;
 	unsigned long flags;
 	int ret, i;
 
@@ -6368,6 +6369,13 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
 		rx_urb->hw = hw;
 
 		ret = rtl8xxxu_submit_rx_urb(priv, rx_urb);
+		if (ret) {
+			if (ret != -ENOMEM) {
+				skb = (struct sk_buff *)rx_urb->urb.context;
+				dev_kfree_skb(skb);
+			}
+			rtl8xxxu_queue_rx_urb(priv, rx_urb);
+		}
 	}
 
 	schedule_delayed_work(&priv->ra_watchdog, 2 * HZ);
-- 
2.25.1

