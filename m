Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69C396B98
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhFACtd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFACtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E53C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c3so12565100wrp.8
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAnhL/rLVHOlPObR2Xdk1DvWetZIgbSOpJEsqp74oTI=;
        b=OA4gCqTbsLsEhcNO2pZR8L33MzGKjL2SwFaNq0vX/cqVDr+/OBPjmYEctfBgnZ+OA8
         DZYJOLlF0Do8ORsMYvT9sVktR+SsV328n1nZeajNtvF1+vluI0BHz7qm6W9Cygw96Fmu
         vZffYz7a4Qta79uwB82EihYFs58ARqmsnM05vlQ1d2PbYhFAXF6IJlBtuOptUln1ftvG
         jKmfjgHSJl0pAoQn5f/gukCgb49CgiNpDcifKDIHsGheCLcaTvuddOGoycxED49pIoa7
         TYbLdgY/q3E38Hw+560ZZYqm3UBzLkZPXj4KhA1msA/tJuMXV0epiXH1OQ3XRnYjtogP
         KlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAnhL/rLVHOlPObR2Xdk1DvWetZIgbSOpJEsqp74oTI=;
        b=SHMcc9xc9H6lEYmd9YJgjh86LOeitBkwCBvrD4Umc+rTq05mivDYpPL1iaNgLYtr/7
         grXZRdopbAfjqu4J6Jk/ZU4dWNfJNCUMJ+dNbhzfDctDTk0Vj4wuX/rla6Ipcp9iSoqu
         cNPzX/xNGVZ522rbeY5IgFLd9VUZ0FxYNqYoMzF7gpYGWh2OqFMXeBaiK/NWN2UkBJk6
         uP2FpqPfqfxEQnce+ij3LGhGmrTJdh0yMkdRx02YQLEBk/0Gey87gaPUTX00pjbqWK7T
         q4Fex6tbtk++sOSzbUXJ2a4gR4NN3odsOHoxCavVeHnT4vBFe9MJdUN+lTzDA/VxR7Ud
         LLqg==
X-Gm-Message-State: AOAM531ddzMzxSYKI7qMsFIxJdYbnqr5/ogU7PfLfzn2NMf3O5WFQpDv
        yeNCphFRQTQEWvOM9XmI0346mA==
X-Google-Smtp-Source: ABdhPJzoqDBhSQeVvO/S9RLLUIiLnsnqx7setPoiCnGqYGXOTZkShVx9bRJLmODOARwgaSBoocGc5g==
X-Received: by 2002:adf:f805:: with SMTP id s5mr6707222wrp.231.1622515669309;
        Mon, 31 May 2021 19:47:49 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:48 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 12/12] wcn36xx: Enable WOWLAN flags
Date:   Tue,  1 Jun 2021 03:49:20 +0100
Message-Id: <20210601024920.1424144-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable flags for

- Magic packet
- GTK rekey

Previous patches implemented the necessary code to switch these two on.
Standalone magic packet absent GTK rekey is pretty useless, so it makes
sense to flag both at once.

Once done it is possible for wcn36xx firmware to

1. Respond to ipv4 and ipv6 ARP/NS lookup requests
2. Bring the system out of suspend when a magic packet is received.
   Magic in our case is a simple ipv4 or ipv6 unicast.
3. GTK rekey whilst in suspend
   Once we wake from suspend the GTK will be updated as necessary

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c697b9f3633a..3a4e383b3a6c 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -173,7 +173,9 @@ static struct ieee80211_supported_band wcn_band_5ghz = {
 #ifdef CONFIG_PM
 
 static const struct wiphy_wowlan_support wowlan_support = {
-	.flags = WIPHY_WOWLAN_ANY
+	.flags = WIPHY_WOWLAN_ANY	|
+		 WIPHY_WOWLAN_MAGIC_PKT	|
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY
 };
 
 #endif
-- 
2.30.1

