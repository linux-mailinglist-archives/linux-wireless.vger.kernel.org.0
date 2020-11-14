Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020B12B2B9E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Nov 2020 06:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKNFpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Nov 2020 00:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgKNFpn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Nov 2020 00:45:43 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED02C0613D1;
        Fri, 13 Nov 2020 21:45:43 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id gv24so1332556pjb.3;
        Fri, 13 Nov 2020 21:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LdGvglCTmaNDIGyYyBhu/82E6IHJ6gBqV+2H+IQ+RCA=;
        b=NKRrOyiSleL34PNpKA1WvUXeHK+ohT64FGNEYDiMdI3FRtlSOz6KhEieYEBjhCSfsl
         35UvdwXsvjpp6v1NH7QJJ26hn7DwgvvJOzaI6uS5VE4fYbh2YhuanOvojONd5KG0vXgQ
         M8KPuLRG0xtpuO8oaqvOwYGHfFBpQI6buvys+LYho1YO6e8f65tUVpub67YkOirrHHNa
         HxLJMEoAbwkgXxGypx4JyrV33xtXcnOaAO+yCzafrG6QvGQzBHAMF5Shp3cJB1Zcqhsa
         SVF1sselucFFwTbNPgE5jTX27YzxaXg11r0X+nREAqTzxqZRt2UEfRaDInALmN4HcJnZ
         tM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LdGvglCTmaNDIGyYyBhu/82E6IHJ6gBqV+2H+IQ+RCA=;
        b=DHGO9p+LGunmiFztGvWE18LP081BmvAaJYD5W71QpqOgqpxgNWvp+3Xcw+EnJXl+t6
         CWM7nTuNbdzaNejW70chTvhvNGKlN9asAZoblEycAqZHiKhpYQfE660k1/JwvFodJSPD
         wIOeSrqtU9XnkW0gRgstST4lDAEKqs8rD6ZaRBqvWIsHSKrJJeZ3L/JchjuB/EYhvOQL
         GgRS1uc8kKtdbJO83kd9e+6gJSi754j5arHI2oYjNpgduFvYqUKAg7Oe+izcTTD9A2ca
         6rYsgshX2paAMJjTHsYSw3PRleVPMsbiVaeda89xkJOR5UFd3Ka9bN65p6MIcznA5wqJ
         Irsw==
X-Gm-Message-State: AOAM533yKOCcgWyKBKqU0No2k4xOUXuEbuTqb14eH3u3PmCoE6Owi/u8
        +Es6ioCFp560ME2L8UY38w==
X-Google-Smtp-Source: ABdhPJz+IXimVuxDk+tY73xHKRedOBH9AGI9Lit7/3V6N9/WF8JFofrQ1mKRwJr763po6qLWIvD8sg==
X-Received: by 2002:a17:90a:680e:: with SMTP id p14mr7012400pjj.34.1605332741953;
        Fri, 13 Nov 2020 21:45:41 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id j1sm4486008pji.22.2020.11.13.21.45.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 21:45:41 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     pkshih@realtek.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] rtlwifi: rtl8192de: remove the useless value assignment
Date:   Sat, 14 Nov 2020 13:45:35 +0800
Message-Id: <1605332735-9648-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The variable u4tmp is overwritten by the following call and the assignment
is useless, so remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index e34d33e73e52..68ec009ea157 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -2566,7 +2566,7 @@ static void _rtl92d_phy_lc_calibrate_sw(struct ieee80211_hw *hw, bool is2t)
 		}
 		RTPRINT(rtlpriv, FINIT, INIT_IQK,
 			"PHY_LCK finish delay for %d ms=2\n", timecount);
-		u4tmp = rtl_get_rfreg(hw, index, RF_SYN_G4, RFREG_OFFSET_MASK);
+		rtl_get_rfreg(hw, index, RF_SYN_G4, RFREG_OFFSET_MASK);
 		if (index == 0 && rtlhal->interfaceindex == 0) {
 			RTPRINT(rtlpriv, FINIT, INIT_IQK,
 				"path-A / 5G LCK\n");
-- 
2.20.0

