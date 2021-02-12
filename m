Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63872319840
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 03:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhBLCOi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 21:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBLCOe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 21:14:34 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC039C061793
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 18:13:15 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z18so6959160ile.9
        for <linux-wireless@vger.kernel.org>; Thu, 11 Feb 2021 18:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qveShMPbHGycDxVnezPtmezGFQ5w3ZTyOuDm3wEWy/E=;
        b=BgsaW5E7Kw179DCPLiLzHyN/ro+XOZBcGO3kdMekpOhC0bu+wxZwr3WSDw08Ysyl/n
         MIwsUB7tOx3lKnOuNp9F7pvmH0qJYoW/ox7xlor9urol+/RO5HhEYKuMLUS2+x7zkQxy
         9wWznb1ZZ/vP0IWWDJE+qqZAi5vwSPt9/D76U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qveShMPbHGycDxVnezPtmezGFQ5w3ZTyOuDm3wEWy/E=;
        b=INXuEbDSrtJGrx5RNYcYacfzOTCVS0HA6d4alIzqFQVCesZje1XF/c7f1xNsvXYeO9
         7L3vzs+buD6rEHHoDSmd2qfcSPOTPIQTZptR1uHJpnNRq8h4FCkuLCNt3bTORIxiriBe
         L5cIQ5CRTDg4J7xdSWEyPlSR16NuECLSg+6MLjv7JY0QwvhfBhmaRLDLN7KCi72LsBxV
         6oBr618ly8qYmxU7gNG8MiPWMt45g8RkEZ16WdeRdcxfiizor6RwQ4Ng/D2qCNKw4W3T
         Pl0rw2RDelMrb0b5df+O26zh/Cvd9Op8gu0FFyMPfsh1uEP4wBUQ7zGz9xhjYvoejzAW
         C+xg==
X-Gm-Message-State: AOAM532BqPtD1HoKy5APYPslNYGT8c8OvgCQUAnG34ZjmRdlBE1Tra3Z
        m5IFQb8aONh8YlLa8oRNMFlLWw==
X-Google-Smtp-Source: ABdhPJyhvcl4RxwVh/698ob0IjP+vOrAdjty3JRXeczY0MhpBo6e7qMZZCbCiAsJp/eRHkxwJtuw0Q==
X-Received: by 2002:a92:b510:: with SMTP id f16mr755085ile.22.1613095995313;
        Thu, 11 Feb 2021 18:13:15 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c2sm3480594ilk.32.2021.02.11.18.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 18:13:14 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     tony0620emma@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtw88: hold RCU lock when calling ieee80211_find_sta_by_ifaddr()
Date:   Thu, 11 Feb 2021 19:13:07 -0700
Message-Id: <20210212021312.40486-2-skhan@linuxfoundation.org>
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

Fix rtw_rx_addr_match_iter() to hold RCU read lock before it calls
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

 drivers/net/wireless/realtek/rtw88/rx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 7087e385a9b3..4ab3d3e2bfab 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -111,6 +111,9 @@ static void rtw_rx_addr_match_iter(void *data, u8 *mac,
 		return;
 
 	rtw_rx_phy_stat(rtwdev, pkt_stat, hdr);
+
+	rcu_read_lock();
+
 	sta = ieee80211_find_sta_by_ifaddr(rtwdev->hw, hdr->addr2,
 					   vif->addr);
 	if (!sta)
@@ -118,6 +121,9 @@ static void rtw_rx_addr_match_iter(void *data, u8 *mac,
 
 	si = (struct rtw_sta_info *)sta->drv_priv;
 	ewma_rssi_add(&si->avg_rssi, pkt_stat->rssi);
+
+exit:
+	rcu_read_unlock();
 }
 
 static void rtw_rx_addr_match(struct rtw_dev *rtwdev,
-- 
2.27.0

