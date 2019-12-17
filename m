Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94F122E3B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfLQOM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 09:12:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40718 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfLQOM4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 09:12:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so11464635wrn.7
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IEBfeiXWdSeAPu3kBBy1VziKqf2hShqp/AAgg9MEEg=;
        b=uhbkVDF1WLNp6mi572XKAcmSWTT8EOCf1JSIjSDXGo+kOAoNzYhvAXZHSNzU1GCRBC
         DZD1k9NV3AnfZ1USp2CU1RDGm5YhNRIYJnk60kLPZjUbj2EWHflIYuqlPryp2H6XAl2F
         2oqXD3FJq8cVW7t3NvfQKO6iD1CG2CYMV94UByBBc3LDw500321NWbl/spkN3SbzbEV0
         XarK4FtHQGysIFsTXLtvGlgYwq0/Ain2SJdIxaHt4stbYUZ4KISiqSlzmq+0iCNUiPDk
         Wou72za3hFZSTW2e60lFKMKCb5DpwU2nJ9rVJFtpjUeyFshssL0sdTaxPWXfcuYJrjMJ
         9OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IEBfeiXWdSeAPu3kBBy1VziKqf2hShqp/AAgg9MEEg=;
        b=mbzSguRhEAofukvKMtyKsRE/0eoV0bDeFfFgMfZGr5lV4pc8HsdboyIhk2b/5aaIWE
         6ZHinDkHg8Sl7Sm6snoJVJ5DuFA5IG0Vg0NGjHbIHZQuKzfjJk+2B0+cDa6LK+i5nPkF
         WDk1x39yrKWJpnl+Lz7MaqknHuncur9zifDx7N4S8TDdrHZan2I8iuTiVucXrZAPyRpD
         +5v5CkrYcqQCMitKBXdF13rGqpvFu4P/55xTEiIh+WAWkEPoUfN5wVGCc9ShU/e7/Ej7
         4Yieoug0EgSMMo40P+B8BxJSN0b8Komhmhl0NXoOYVwb9q+ZZmhKlpp4crpNdJcpPSqt
         Xykw==
X-Gm-Message-State: APjAAAW/raiIsZorlKmw8/K93v9LC4Anp2VDQRlYvn9rxbo240k8xYGa
        VYihby/IAKXbH+nascLG+sS+sO5n
X-Google-Smtp-Source: APXvYqws4A5aPc013BltYGN7FQTg3PdMCtevd6Q1iD8LtbGnUeJ+Dd7Evr+MVyu4BtMf376vHzAvwg==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr38701062wrx.288.1576591973447;
        Tue, 17 Dec 2019 06:12:53 -0800 (PST)
Received: from localhost.localdomain ([193.27.220.66])
        by smtp.gmail.com with ESMTPSA id b15sm3078922wmj.13.2019.12.17.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:12:52 -0800 (PST)
From:   Eduardo Abinader <eduardoabinader@gmail.com>
To:     linux-wireless@vger.kernel.org, wcn36xx@lists.infradead.org,
        kvalo@codeaurora.org
Subject: [PATCH] wcn36xx: disable HW_CONNECTION_MONITOR
Date:   Tue, 17 Dec 2019 15:12:47 +0100
Message-Id: <20191217141247.14387-1-eduardoabinader@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Whenever the signal stregth decays smoothly and physical connnection
is already gone and no deauth has arrived, the qcom soc is not
able to indicate neither WCN36XX_HAL_MISSED_BEACON_IND nor
WCN36XX_HAL_MISSED_BEACON_IND. It was noticed that such situation gets
even more reproducible, when the driver fails to enter bmps mode - which is
highly likely to occur. Thus, in order to provide proper disconnection
of the connected STA, let mac80211 handle it, instead of wcn3xx driver.

Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c30fdd0cbf1e..e49c306e0eef 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1169,7 +1169,6 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 
 	ieee80211_hw_set(wcn->hw, TIMING_BEACON_ONLY);
 	ieee80211_hw_set(wcn->hw, AMPDU_AGGREGATION);
-	ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);
 	ieee80211_hw_set(wcn->hw, SUPPORTS_PS);
 	ieee80211_hw_set(wcn->hw, SIGNAL_DBM);
 	ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
-- 
2.20.1

