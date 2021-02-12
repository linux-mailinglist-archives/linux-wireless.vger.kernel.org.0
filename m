Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A752319844
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 03:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhBLCOt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 21:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhBLCOj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 21:14:39 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA649C06178A
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 18:13:14 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e133so7833313iof.8
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 18:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQ4hezKs/564pdp9qVVgnPCiXwargfZBqBE6eVRsn+Q=;
        b=O2A+7SU0HlH0ayRNJlNnkiPnkN3FroFezBXYoKB5Hkc7SZ/9cCozwuf/rgAhxxotDc
         jZZ2SfEmVz0popr3/CwyFZoXjjINoGa0PZ/UYHtzqna/btPfYNB21tgjnDSs8Hic/yAl
         fWSshxDMpyC3mNRSsKIYBWO/HGqK1T8Fre38o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQ4hezKs/564pdp9qVVgnPCiXwargfZBqBE6eVRsn+Q=;
        b=WhVT9zLPkHr8SnHjMhjfWoWA1H/XnkuAi9vFPBISoIbZjlP3lcU/ubBKkn/NFcaWBx
         uazpyrt+82otLwVrNbHdqm097bCfLNamm8Klyzo2qb2xvUm3jTZQ2yFC0aOoQkxVYw0c
         /QO4XJPHqdq/mYujhOS3Ddiow8hWKBqq3jHhvbPRiKtI3P6B8z+SncyHRALKhYaWmP9p
         UsOtxECysTXEHq5CJB19JX3QKSqnuohFCIjoMlENaabIhRw7zxgzYJtBEL8ch15xkm2f
         pxJLPmG2iDTTtiBnsnrBFNpWLWxKbtKqyHpyARO7N5MG5LOicB+XOrqPtRNEkfXG+uOl
         w+kA==
X-Gm-Message-State: AOAM531f2WMiYQ+GD/lcwAm/iTajz8fLHMC+qWa1Lsjvycbxy9G1XRmA
        RAq5PkXISpUtNZFbP0RRBWYGWw==
X-Google-Smtp-Source: ABdhPJwkz20+sR+9d0DlpiYpRe67c8FB0IhGdSj7e4dPSnKAx4BE5wv47oFR2uoK7lzyje/0pFkzrg==
X-Received: by 2002:a6b:5002:: with SMTP id e2mr528669iob.152.1613095994176;
        Thu, 11 Feb 2021 18:13:14 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c2sm3480594ilk.32.2021.02.11.18.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 18:13:13 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        matthias.bgg@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mt76: hold RCU lock when calling ieee80211_find_sta_by_ifaddr()
Date:   Thu, 11 Feb 2021 19:13:06 -0700
Message-Id: <20210212021312.40486-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <1cfa036227cfa9fdd04316c01e1d754f13a70d9e.1613090339.git.skhan@linuxfoundation.org>
References: <cover.1613090339.git.skhan@linuxfoundation.org>
 <1cfa036227cfa9fdd04316c01e1d754f13a70d9e.1613090339.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_find_sta_by_ifaddr() must be called under the RCU lock and
the resulting pointer is only valid under RCU lock as well.

Fix mt76_check_sta() to hold RCU read lock before it calls
ieee80211_find_sta_by_ifaddr() and release it when the resulting
pointer is no longer needed.

This problem was found while reviewing code to debug RCU warn from
ath10k_wmi_tlv_parse_peer_stats_info() and a subsequent manual audit
of other callers of ieee80211_find_sta_by_ifaddr() that don't hold
RCU read lock.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
- Note: This patch is compile tested. I don't have access to
  hardware.

 drivers/net/wireless/mediatek/mt76/mac80211.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index a840396f2c74..3c732da2a53f 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -867,6 +867,9 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	bool ps;
 
 	hw = mt76_phy_hw(dev, status->ext_phy);
+
+	rcu_read_lock();
+
 	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid) {
 		sta = ieee80211_find_sta_by_ifaddr(hw, hdr->addr2, NULL);
 		if (sta)
@@ -876,7 +879,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	mt76_airtime_check(dev, skb);
 
 	if (!wcid || !wcid->sta)
-		return;
+		goto exit;
 
 	sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
 
@@ -886,17 +889,17 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	wcid->inactive_count = 0;
 
 	if (!test_bit(MT_WCID_FLAG_CHECK_PS, &wcid->flags))
-		return;
+		goto exit;
 
 	if (ieee80211_is_pspoll(hdr->frame_control)) {
 		ieee80211_sta_pspoll(sta);
-		return;
+		goto exit;
 	}
 
 	if (ieee80211_has_morefrags(hdr->frame_control) ||
 	    !(ieee80211_is_mgmt(hdr->frame_control) ||
 	      ieee80211_is_data(hdr->frame_control)))
-		return;
+		goto exit;
 
 	ps = ieee80211_has_pm(hdr->frame_control);
 
@@ -905,7 +908,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 		ieee80211_sta_uapsd_trigger(sta, status->tid);
 
 	if (!!test_bit(MT_WCID_FLAG_PS, &wcid->flags) == ps)
-		return;
+		goto exit;
 
 	if (ps)
 		set_bit(MT_WCID_FLAG_PS, &wcid->flags);
@@ -914,6 +917,9 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 
 	dev->drv->sta_ps(dev, sta, ps);
 	ieee80211_sta_ps_transition(sta, ps);
+
+exit:
+	rcu_read_unlock();
 }
 
 void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
-- 
2.27.0

