Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C67E0FDA
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Nov 2023 15:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjKDONk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Nov 2023 10:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjKDONj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Nov 2023 10:13:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B84191
        for <linux-wireless@vger.kernel.org>; Sat,  4 Nov 2023 07:13:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d267605ceeso440079166b.2
        for <linux-wireless@vger.kernel.org>; Sat, 04 Nov 2023 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699107215; x=1699712015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5hP1q2MBV6dkt+KbwYUAFqTOnmM3x+XBgSEx9c7uP0=;
        b=MLp21cDdlYXV3jFFPp1akrMni1m/PWnTCyZToRNtb3lU0uXZsJ/WvrqVP2f+zxhhuC
         b+TVTrlb6mjPjR/l2fSY16OK4F4LaVs6x1conPMzD+EaEigPQi+dI2HVFxyv2OEOHcuD
         us2x6VAcxIqQqZC7Orh8+PoUiAjKGjbYkxi5a2bEGhX1+mt3SIN7HKo8Rfj2OgmPVKgY
         bOLXdDHQg4LFy3ScbLkEdiXLgAoZE1/q7VhMXrCqB/HVAKuITiiUsQHuHxacOlvt2KDJ
         sNUewy9U01WD0OTCZJXdkU8XICyqciH1GYjwoVgn9rRlHD+CrIqWvfjkNhX/RSkbCFha
         ZHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699107215; x=1699712015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5hP1q2MBV6dkt+KbwYUAFqTOnmM3x+XBgSEx9c7uP0=;
        b=ihcBZDw/1a3nI/ogmLPzlNQch4Y6bOu/Mxx7hiSlVXH9NYGePakNyb4vmR9uo3w0Ja
         EDqc4NJQ7XJhsNfSZRjPiLq1AxHzTpgGb9a9xjD1s4S9Q+wjBzNRaG8s8cyBL8LTndHu
         KAbS5yiSkE/hzZM9aet3IqVwaxTMZyVn3V2RMi96DGHlhjH/hndnFBoMCPVa41RZVbKZ
         hWc1zb1BENKy91yjC9s2upukPwG/6uPIS5laO5AmiR7hmp23L4iRsyB3Iw8xtC3jvW3h
         voI/x56lqYLy1X0sIiWY1dJSYG0HUgo3wbH0pbdHAZqUIlCZIJIIIUXn0a1Nj5XsdF0G
         hHTw==
X-Gm-Message-State: AOJu0YxAWQFe9Pr826wsRpoUbDxAxOGbJIM0Cq+eA/tlfEePAyeX4Nm0
        kS5qjoN0vBMdPxX9AMFrZQafDt73O94heg==
X-Google-Smtp-Source: AGHT+IHFTveroqhstmSp1xyxTgG1XauMwYmrpbQghcSmKMBBbc4Yea1djQl4fU4uOghxBXx1sDoAPA==
X-Received: by 2002:a17:906:fe09:b0:9ae:673a:88c8 with SMTP id wy9-20020a170906fe0900b009ae673a88c8mr8748450ejb.21.1699107214555;
        Sat, 04 Nov 2023 07:13:34 -0700 (PDT)
Received: from dev-Ubuntu-20.mshome.net (smtp.home.oldium.net. [77.48.26.242])
        by smtp.googlemail.com with ESMTPSA id ov13-20020a170906fc0d00b009944e955e19sm1999496ejb.30.2023.11.04.07.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 07:13:34 -0700 (PDT)
From:   =?UTF-8?q?Old=C5=99ich=20Jedli=C4=8Dka?= <oldium.pro@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Old=C5=99ich=20Jedli=C4=8Dka?= <oldium.pro@gmail.com>
Subject: [PATCH] wifi: mac80211: do not pass AP_VLAN vif pointer to drivers during flush
Date:   Sat,  4 Nov 2023 15:13:33 +0100
Message-Id: <20231104141333.3710-1-oldium.pro@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes WARN_ONs when using AP_VLANs after station removal. The flush
call passed AP_VLAN vif to driver, but because these vifs are virtual and
not registered with drivers, we need to translate to the correct AP vif
first.

Closes: https://github.com/openwrt/openwrt/issues/12420
Link: https://github.com/openwrt/openwrt/pull/13620
Fixes: 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
Fixes: d00800a289c9 ("wifi: mac80211: add flush_sta method")
Tested-by: Konstantin Demin <rockdrilla@gmail.com>
Tested-by: Koen Vandeputte <koen.vandeputte@citymesh.com>
Signed-off-by: Oldřich Jedlička <oldium.pro@gmail.com>
---
 net/mac80211/driver-ops.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 568633b38c47..f690c385a345 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -23,7 +23,7 @@
 static inline struct ieee80211_sub_if_data *
 get_bss_sdata(struct ieee80211_sub_if_data *sdata)
 {
-	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+	if (sdata && sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss, struct ieee80211_sub_if_data,
 				     u.ap);
 
@@ -695,11 +695,14 @@ static inline void drv_flush(struct ieee80211_local *local,
 			     struct ieee80211_sub_if_data *sdata,
 			     u32 queues, bool drop)
 {
-	struct ieee80211_vif *vif = sdata ? &sdata->vif : NULL;
+	struct ieee80211_vif *vif;
 
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	sdata = get_bss_sdata(sdata);
+	vif = sdata ? &sdata->vif : NULL;
+
 	if (sdata && !check_sdata_in_driver(sdata))
 		return;
 
@@ -716,6 +719,8 @@ static inline void drv_flush_sta(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	sdata = get_bss_sdata(sdata);
+
 	if (sdata && !check_sdata_in_driver(sdata))
 		return;
 
-- 
2.25.1

