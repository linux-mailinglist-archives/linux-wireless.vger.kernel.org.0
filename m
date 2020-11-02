Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902512A2938
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgKBLY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgKBLYz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:55 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BEC0617A6
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:55 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x7so14162237wrl.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phz21+N6URi4CcT/YO1+niu4iFcUjLLHLqxB18E2o5Y=;
        b=QfadVdOy9Fl9zbkh80hfIPvPz3gNyuDG3E8PgTyr3iJ6FgsbshhFOmkBOLkPJRM+cS
         EbKUFWAfKl+jS9COFsJZ8VEzm3Ljt/H3BTbFUiAEX8SpXLdLujSUmWNlOOaR996bjO5X
         ZpwGzWoAYJQNQF4ErEXvUD0iJGRGMHnvrO7wF6dkvOHyfE7kMjCF4zK+LHNuOkOZxpep
         pPxsA2NYaA/RjVWsM1+QVNNr25GTO1iv0QHGgOO31mXvatibCudIkTu4BBuclSsU5BKh
         oncw3u9nBbEhDE2UaEnT5Z4Da0r6mOP0590VFKMAGPFGegyvCA0O5p0uOGggx6X0A8k4
         BN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phz21+N6URi4CcT/YO1+niu4iFcUjLLHLqxB18E2o5Y=;
        b=mYvrr2J1yiY2janNJFslgdPIjqRc3eIuAEosC+g34SWfiRCAyOWOrrp+pctrQREO50
         09aAZGzs9zJqjj6MSLHre1gREq+3IlNia4rs6SFGC7u7bEqWCKoXExvxc8UskxexKPM2
         EOiojtczrA6bkN9zLyzz973gU7zl5+h81gbZ1GMM4eHCiT1324oMME12wPnPnWi+095r
         A/OsgxwLzAtvOI92mdHzWUo/0Zpp3/UdmookeyygacHxyO3iaxYW1PjpHAycJLjZyQi9
         diH42pnZgQTf8288+OVcipbbUVJm1VU2eqHfhLWV+3SH/L1Ce+2BTwVh2D1yGFC7wuR5
         Cszw==
X-Gm-Message-State: AOAM531unNdAOeKOHL30LQNTYr6TrttWO6VlTa/9Pb7RbMiAE1Tbv2v8
        1M0ftlFKiuRv+sonjdfsSgyf6A==
X-Google-Smtp-Source: ABdhPJzNF5spMxVcMYFSeCHg8D9zRR3jAaylmqt+JUIJZ1DX9Vnz69yq3266Tb3tLFRcshxVfdp2yg==
X-Received: by 2002:adf:9361:: with SMTP id 88mr18815974wro.37.1604316293800;
        Mon, 02 Nov 2020 03:24:53 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 26/41] rtlwifi: phy: Remove set but unused variable 'bbvalue'
Date:   Mon,  2 Nov 2020 11:23:55 +0000
Message-Id: <20201102112410.1049272-27-lee.jones@linaro.org>
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

 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c: In function ‘_rtl8723e_phy_iq_calibrate’:
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c:1150:6: warning: variable ‘bbvalue’ set but not used [-Wunused-but-set-variable]

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
index fa0eed434d4f6..fe9b407dc2aff 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -1147,10 +1147,8 @@ static void _rtl8723e_phy_iq_calibrate(struct ieee80211_hw *hw,
 
 	const u32 retrycount = 2;
 
-	u32 bbvalue;
-
 	if (t == 0) {
-		bbvalue = rtl_get_bbreg(hw, 0x800, MASKDWORD);
+		rtl_get_bbreg(hw, 0x800, MASKDWORD);
 
 		rtl8723_save_adda_registers(hw, adda_reg,
 					    rtlphy->adda_backup, 16);
-- 
2.25.1

