Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F3D25EC69
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Sep 2020 06:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIFEEj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Sep 2020 00:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgIFEEh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Sep 2020 00:04:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641FC061575
        for <linux-wireless@vger.kernel.org>; Sat,  5 Sep 2020 21:04:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so933844pgl.10
        for <linux-wireless@vger.kernel.org>; Sat, 05 Sep 2020 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5cgAJ/M47tJob1MrGll46hQWP0P/4Ncz8b1EuDVEqMg=;
        b=bj+wXQLQkSfx5qaJUAyTW3bRLz3iQqXmy3cYLXVKdxG8QJYJ6QKh02deys+Ye3Slre
         4xzMzbJgI9p1DVyuhhqzQYBZhjHIa+2dvy1t3eyhbZTqRVOXHU0i3RCT4YRuds+Ply7K
         nA9OJ88MD56Z5EUOiq27pYAZnT8U04bbUqFEPTA2kCMaOrdWz9F1919NlDERN8V2zX1/
         +kksNtk6dQUQmgKFQW6ZHnc6gq9kpTvYwJC9VM8NZLB93vn4OpveGkbwZ0wZI7Ds0Lan
         ECyH14w1qYaCrglb+gL6hYS/ia93c2Ek905iXsiVccbex1cYqbywPQVOt+deCadyLPZI
         ueNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5cgAJ/M47tJob1MrGll46hQWP0P/4Ncz8b1EuDVEqMg=;
        b=d/yb6Q2RN/bKoe0uwKSSx4JdIxXqM2bpIFrs77mP6mdBPLF+uQ8TKDz3jmtYSCOAbp
         x3lADrwTCUyBzBaWRURnl/QeNMNPgoLKtPZG1cyOj2XC3mMmpp5XAgbSX9p6Cn7RF+Mm
         S/gzuoEni5le2MjmBO0KSryecanyzaMYcEfhqGGFbXzLepMoI3LNofi1tQJfC0UkcPDm
         K3woSaK+ZMg+38Bomthpnu261UTRYijr8DmPzaAGDHZjTW+vZsJt7Jg1lS5wTCZEt43s
         mpcKWcac+jRnmhPD8kieEcYiZmoCPZ7qMdwYfZaQheSpDW2Jfs7oX89RzdUn84TO21Rn
         m/2Q==
X-Gm-Message-State: AOAM531+7AZzIxIxg9RD7ASvkU0XbZNd/e6MZ7mt3Z1fbMd5zeeSogHg
        q9Sj1oSIHKV0/O9TeaH/UER1kg==
X-Google-Smtp-Source: ABdhPJySDsaeopqr8sa0QuCqwxs/O+aUhy9KjYsBarbIvUV2b9xJ/7bF1Lp+4IFW7AMflqhOnH2yrQ==
X-Received: by 2002:a62:4e8a:0:b029:13c:1611:653b with SMTP id c132-20020a624e8a0000b029013c1611653bmr12803945pfb.13.1599365075335;
        Sat, 05 Sep 2020 21:04:35 -0700 (PDT)
Received: from localhost.localdomain (111-243-26-127.dynamic-ip.hinet.net. [111.243.26.127])
        by smtp.gmail.com with ESMTPSA id l7sm2347096pjz.56.2020.09.05.21.04.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2020 21:04:34 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] rtl8xxxu: prevent potential memory leak
Date:   Sun,  6 Sep 2020 12:04:24 +0800
Message-Id: <20200906040424.22022-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Free the skb if usb_submit_urb fails on rx_urb. And free the urb
no matter usb_submit_urb succeeds or not in rtl8xxxu_submit_int_urb.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 19efae462a24..5cd7ef3625c5 100644
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
2.20.1

