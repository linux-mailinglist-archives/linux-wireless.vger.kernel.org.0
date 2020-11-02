Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA72A292E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgKBL0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgKBLZD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:03 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74800C0617A6
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:25:03 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g12so14113853wrp.10
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V56hUx4Ik29TQLj2+CSFLe9SRW9C8bcqnq7xkJaiUmI=;
        b=LbLnLJ7sYZ0Y4ts2ejFZSO6VFjct/fqvAsi66WGbmbjiWxrlKP23awk5AoxWovYtQq
         ANyWpgdkbExKHSc4LRTxA3Wm0sLoiUn/xeYK7K8YxzBckH70djdbeTaZ7sVmCcyxLH/7
         LbV8udT93qwScqZSTKAcQ+sj80osPAff/t4/43FDsEHUxBY+thIUAqd6YjLvT4roAwnx
         vL8mI2Vq5xzw5DESN0m3QKTKHsOBwDfAYAo/1nGEjKG7vuM02DvSM6IJXUhqFCgPi6i+
         QBZHISS14SQLp1xJ1BSdY058i5GfkClF7p6g1xsGJbL7YxzUX2H7j+aKltf7vdTzROyX
         vZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V56hUx4Ik29TQLj2+CSFLe9SRW9C8bcqnq7xkJaiUmI=;
        b=UNND0L01ioB0MXWbQPOU/A6WDFhTdbbffJpwJ4oYrZB2wUSCGPgNlcKkvIL0ufPTv+
         H5SHGzDkFONOfye0Z6l5ue3kIeLSsJwilkjERyRA+iiMkTjWW6OUUf3+ScjJdEsMctP2
         bios9dLzacSGNqx0Mf0+eeQ59+l/YxQVkvBfmkKxa0hTi//L0m6No5bOQjPf1K/xkqyJ
         tnvmdBYVMc+AczRfDuJvmiThBdzcfPa4adNntVRuHm8CzQBbSm9AOBpUK9rQp/mDhvpw
         CTaqmIlTfO9FlIBA5ZSfifNPikkShkzHO/7pseC3rHz3c2HQ9xwxxF/RifjnuV0lw0V+
         VMFw==
X-Gm-Message-State: AOAM533bhYtjDY4VtHS/hWeCYlncxPQ0HgCUctjkzzGzp5tSGvJRJjac
        Jiq2fXWrkbGwh9iUzw6mS9PttA==
X-Google-Smtp-Source: ABdhPJzTyFAeigdIzuKUqE+E8GyCEp2hfljOIkpyNn8sJbCdvxcGFGLf34+xtIbYZk3zUTIk7raa1Q==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr19559451wrn.362.1604316302226;
        Mon, 02 Nov 2020 03:25:02 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:25:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 33/41] rtlwifi: rtl8821ae: phy: Remove a couple of unused variables
Date:   Mon,  2 Nov 2020 11:24:02 +0000
Message-Id: <20201102112410.1049272-34-lee.jones@linaro.org>
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

 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c: In function ‘rtl8821ae_phy_switch_wirelessband’:
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:597:14: warning: variable ‘rxpath’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:597:6: warning: variable ‘txpath’ set but not used [-Wunused-but-set-variable]

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index f41a7643b9c42..72ee0700a5497 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -594,11 +594,10 @@ void rtl8821ae_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_dm *rtldm = rtl_dm(rtlpriv);
 	u8 current_band = rtlhal->current_bandtype;
-	u32 txpath, rxpath;
 	s8 bb_diff_between_band;
 
-	txpath = rtl8821ae_phy_query_bb_reg(hw, RTXPATH, 0xf0);
-	rxpath = rtl8821ae_phy_query_bb_reg(hw, RCCK_RX, 0x0f000000);
+	rtl8821ae_phy_query_bb_reg(hw, RTXPATH, 0xf0);
+	rtl8821ae_phy_query_bb_reg(hw, RCCK_RX, 0x0f000000);
 	rtlhal->current_bandtype = (enum band_type) band;
 	/* reconfig BB/RF according to wireless mode */
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-- 
2.25.1

