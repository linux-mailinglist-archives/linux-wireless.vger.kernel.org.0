Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27921239DBE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgHCDLU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgHCDLT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0354C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so12987440wmj.5
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9KmogYdjeDiArvHcPSK2BD1IBaC6ai9UQ+vtopjnEI=;
        b=YSnZELLiIpi4yphEV/LAs0Pr6WBG1CQBwIPnYh0gs1vqPCb0EkmXaCKqDS3ZCidx7C
         TwPjFCi8ts0mYmld8V+IHdpj29ab9RFXjt4sU8/AkjjXlE4O2ib3Sfg5gEkwTsj9uSsi
         Bfsb7P1EDcexR25z3Nka8o70Pp+1K2HHmU1nIfDQ7rvySz/mSBiydk4f93Wbd1xwjPVz
         +gIWPGC9tENEYFyrv8aXdAPBV9JpOA2Z9/43qSZaPLFyeSDNwb16KPVExmS0oc7X8czS
         Df6/sMx+ds6wgSdGW5xxgI/YqBlPe6e8IxD675T5r5oxXbOJZyTQe/k9F8imFum0j/xN
         WaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9KmogYdjeDiArvHcPSK2BD1IBaC6ai9UQ+vtopjnEI=;
        b=btcdkPV/e1Qu0lOqBEQFwBnfhf3j3f1YHMCxCR1DGr+HtKAorA19ahADb8A28N3pVc
         UNWK1yqe/BBrOokj5FzGA8/3LCUqF5njQcJhx+qcbunQ3AQC01qtZs/B8nIk/aGJrpic
         KzwsPoOUYl/IEk2eKGL9cSWWx2GxFbZyrp/RhQlbTpggde/IVBg4s8aPQsPCmeIEVHEu
         mOpaC0rZHMmwoIvQvOWQ8p7DsVpk2yhOF+TA/lH21ahdb1P82NBh6fH+viPmFHjshjbX
         QyEC7zcDUYfqdzuNUN8mNwC8YmP6QUt9Wo5MTmDWa10Mp+vMbu5SgxujQ1cEfHyoAu5s
         LQIw==
X-Gm-Message-State: AOAM532VgQsWu3RjYMAfJSM01nfGozZzeMs3aIi8JO+DOENN5WVXR5YB
        ZSi59BQw2whhCHSCNOTGSag8YdZw3xo=
X-Google-Smtp-Source: ABdhPJwJElN97xbrbgOGoLELYz8lJH1IsMWRUdU8RuGPyD7U+SCpdOBvX/+GW/ixyxwjksja+g244A==
X-Received: by 2002:a1c:7e12:: with SMTP id z18mr2703516wmc.188.1596424277597;
        Sun, 02 Aug 2020 20:11:17 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:17 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 29/36] wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
Date:   Mon,  3 Aug 2020 04:11:25 +0100
Message-Id: <20200803031132.1427063-30-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adds HW_VALUE_CHANNEL(hw_value) an access macro that will be used to
extract the channel number from struct ieee80211_channel->hw_value in
preparation for also storing PHY settings for 802.11ac in the upper bits of
hw_value.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 18ccc6c31a38..ae8bda76d573 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -83,7 +83,9 @@ enum wcn36xx_ampdu_state {
 	WCN36XX_AMPDU_OPERATIONAL,
 };
 
-#define WCN36XX_HW_CHANNEL(__wcn) (__wcn->hw->conf.chandef.chan->hw_value)
+#define HW_VALUE_CHANNEL(hw_value) ((hw_value) & 0xFF)
+#define WCN36XX_HW_CHANNEL(__wcn)\
+	HW_VALUE_CHANNEL(__wcn->hw->conf.chandef.chan->hw_value)
 #define WCN36XX_BAND(__wcn) (__wcn->hw->conf.chandef.chan->band)
 #define WCN36XX_CENTER_FREQ(__wcn) (__wcn->hw->conf.chandef.chan->center_freq)
 #define WCN36XX_LISTEN_INTERVAL(__wcn) (__wcn->hw->conf.listen_interval)
-- 
2.27.0

