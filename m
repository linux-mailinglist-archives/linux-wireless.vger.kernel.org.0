Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9F2A293E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgKBL0r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgKBLY7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:59 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E3DC061A04
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:58 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b3so8231136wrx.11
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=efbZKXhAztTr+3vbDGqT9spp9eWuy2ZoYZmE2LB/QTg=;
        b=HJXTGyXMt19r1ikj2+zTbCPdaXfc23shxZu/1Ox1YkwM2RWLkvtyRguUmH9IicwOGN
         1OUih7cZ7KDkf6s94C4Slvq0K9T85t+WZeZ7HXjI/4fWE9OJETg9WnFp7svfmdB6fdWd
         cHg3uDTE+1JaRthad5XzyKorSGn8czDs4Vt+WHlfX+u6wiXzOxDQAYwp8dVMJtwpKbkV
         qmDaUdZp2sv+yylhVSe+7i8QpFkD/K6j/W6TdsIfaDxgPd9NCX7IF5EyXaMBJJvd2vfQ
         xxgmBlYon1+fDBknu7jMEgR4mnHluW3hiDK7EsfqE7PpA+65kMrzSkgtfrYRxGMgkO+m
         Lgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efbZKXhAztTr+3vbDGqT9spp9eWuy2ZoYZmE2LB/QTg=;
        b=Xd2qsJ0rJUVeh2x9zGiIUuwbeAqgRFp6yp2uepVJFe0u0t/KIENZucpuF18iOvgkvx
         dLCVkpVFaa2kGCIA5Ug4FOBCo0NfGxHyWdR9XtsF3PcdYYAJzjdUe5a+phx61PhpcjHQ
         AYv57ZQKtxBIMaliFrHKRySEuYOL6lL5E7sEc0ksuyjrm38NiVfnd01EvU/q1iiuYLzJ
         Q+jJZZz8hHtq9DpknFSqRxzt/aAgGRRMd6ib9bUue7bah6YG+/sWHZQSI7OzZXkBnw0/
         C3qJAxAOTbrrjUlYPMgs7duzEB4sY2WmtQ6ZXTmbHL9ENRQP8Lzcjx1dIQIj5tnx9Rdc
         4NVA==
X-Gm-Message-State: AOAM531iDZRZRKYCIowWgMyS4GAueF/tWI9pqjaeGFIFM+dZSiBE4MV3
        n00paAH9Pz39GTD1SsIoNac/kw==
X-Google-Smtp-Source: ABdhPJzoHFkR/mFt/vl1mK/9qPAQpnXQw+3L1GCgw/NDoLHm4ShmEPmKR3zhhINrevs5J3q/jHyvUw==
X-Received: by 2002:adf:fc07:: with SMTP id i7mr14507764wrr.223.1604316297481;
        Mon, 02 Nov 2020 03:24:57 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 29/41] rtl8188ee: phy: Remove set but unused variable 'reg_ea4'
Date:   Mon,  2 Nov 2020 11:23:58 +0000
Message-Id: <20201102112410.1049272-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c: In function ‘_rtl88e_phy_path_a_iqk’:
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c:1351:33: warning: variable ‘reg_ea4’ set but not used [-Wunused-but-set-variable]

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 9be032e8ec95b..12d0b3a87af7c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -1348,7 +1348,7 @@ static bool _rtl88e_phy_set_sw_chnl_cmdarray(struct swchnlcmd *cmdtable,
 
 static u8 _rtl88e_phy_path_a_iqk(struct ieee80211_hw *hw, bool config_pathb)
 {
-	u32 reg_eac, reg_e94, reg_e9c, reg_ea4;
+	u32 reg_eac, reg_e94, reg_e9c;
 	u8 result = 0x00;
 
 	rtl_set_bbreg(hw, 0xe30, MASKDWORD, 0x10008c1c);
@@ -1365,7 +1365,7 @@ static u8 _rtl88e_phy_path_a_iqk(struct ieee80211_hw *hw, bool config_pathb)
 	reg_eac = rtl_get_bbreg(hw, 0xeac, MASKDWORD);
 	reg_e94 = rtl_get_bbreg(hw, 0xe94, MASKDWORD);
 	reg_e9c = rtl_get_bbreg(hw, 0xe9c, MASKDWORD);
-	reg_ea4 = rtl_get_bbreg(hw, 0xea4, MASKDWORD);
+	rtl_get_bbreg(hw, 0xea4, MASKDWORD);
 
 	if (!(reg_eac & BIT(28)) &&
 	    (((reg_e94 & 0x03FF0000) >> 16) != 0x142) &&
-- 
2.25.1

