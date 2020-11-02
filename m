Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1502A2939
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgKBLY7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgKBLY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C417C0617A6
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k10so12798905wrw.13
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhSrR79FyygS4wEvpIyMBNaB75El+5Mndl0QUlH0AUM=;
        b=NJb6VXLpkWuPnTQ4+UycYj+B1c+ONbaWFp74UgM0CB0WqOvAzldj0/guywBSKWXoKS
         8me2HxL6mUzrYQiGl/xyEp0x8t/ycDUXWYncoInbxuFr+xmnHcVy7eKqth48j2ETPqM1
         SQxmEOfh4Q0VBgdaMHzacM1TWPK8uuQpSksG+7rH2y2erLPiTyVHKjgYjBYzbt0oE2+X
         TQb9OS6ELzWRNky7i9m8FJuKL09ncRfVZh5vV63cBnKPR4YWgXDi4Xq5I3a7iphcBCyi
         vB29oD3JaePhFjCjMYy2lWvrM/T1gEy3FooLkjHoeIdQ00itbqU2tgzk0qPB511t/ArA
         ifyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhSrR79FyygS4wEvpIyMBNaB75El+5Mndl0QUlH0AUM=;
        b=Be6XhUkroPPAwaZRKgp5nWLKP+4fpsYYbvunlmv2Y4dWSGTFcq9QHQF4BgJojSANPD
         iQ/EbTPSOkF6/Ujm3to2fkODrl0AwAP/b7FBQXM/lVBf4SrHx9EIiwjVbhVB+uSQ5+W0
         r3uyHPu5hY4DfXQtZuFk6lP+nsxOE5GV1guz7Z5ZzfCOExDNTAE8cOgrbbqlQ1pSSZps
         yqTIP9uxU2r1Ng7+VnJdv3KbaludbRlogDJ1oBn+pvA1zMrShIdvMY6hGXG9sUbn8ODu
         eoHXbGM7zntT2EvrPCVuyj0dmzgVRo06omzKqahMQYilH5ueagLwjVVNKfStQvqLDL9f
         gIXQ==
X-Gm-Message-State: AOAM531CZhn9jjEMZ2j85NMohKn7f8hBtSWVpcnLQ52TemN9r+vLx0NY
        L9zGqOdMlUd45W/tT1DixTS2eA==
X-Google-Smtp-Source: ABdhPJzy27H0hX4X1t1prlT213CF+H+Qry0kng3PzoW9ZHnDDqjdTPpo+3Yetpoe6XTqKo6+1Cgrzw==
X-Received: by 2002:adf:f1c1:: with SMTP id z1mr19888340wro.331.1604316294901;
        Mon, 02 Nov 2020 03:24:54 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 27/41] rtlwifi: halbtc8821a1ant: Remove set but unused variable 'wifi_rssi_state'
Date:   Mon,  2 Nov 2020 11:23:56 +0000
Message-Id: <20201102112410.1049272-28-lee.jones@linaro.org>
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

 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c: In function ‘btc8821a1ant_run_coexist_mechanism’:
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c:1904:5: warning: variable ‘wifi_rssi_state’ set but not used [-Wunused-but-set-variable]

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c  | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c
index 9f5e85be97645..a18dffc8753a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c
@@ -1901,7 +1901,6 @@ static void btc8821a1ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	bool increase_scan_dev_num = false;
 	bool bt_ctrl_agg_buf_size = false;
 	u8 agg_buf_size = 5;
-	u8 wifi_rssi_state = BTC_RSSI_STATE_HIGH;
 	u32 wifi_link_status = 0;
 	u32 num_of_wifi_link = 0;
 	bool wifi_under_5g = false;
@@ -1962,8 +1961,7 @@ static void btc8821a1ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 		btc8821a1ant_limited_tx(btcoexist, NORMAL_EXEC, 0, 0, 0, 0);
 	} else {
 		if (wifi_connected) {
-			wifi_rssi_state =
-				btc8821a1ant_wifi_rssi_state(btcoexist, 1, 2,
+			btc8821a1ant_wifi_rssi_state(btcoexist, 1, 2,
 							     30, 0);
 			btc8821a1ant_limited_tx(btcoexist,
 						NORMAL_EXEC, 1, 1,
-- 
2.25.1

