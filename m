Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD52D5B91DA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 02:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIOAla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Sep 2022 20:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIOAl1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Sep 2022 20:41:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9267387090
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 17:41:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso3461783wms.5
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 17:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FA6FZ814jhwKtiNB3fDGO6OHKlGHF/CZ20X5ABmDnJY=;
        b=e3EotmICuvn2jp0ftJmC1IKHs7ce/fHQ2Avstne5EoNlNQyyVnMfGkA+gN60FhDh0d
         MNje9y3OV4JEHlKk6apbNF6rfnJLYDjIPT0tSyespgTtA8nv5vQgHHgntAJbQN/A5NlX
         YOXqmwG3QlVFk2mv2BbBN5zq38V8ZGmrLFalY3onUu1H/1B31RN9zz9NVMCDeK+zNi42
         vi1HjXEHXo+hQy650d8GAsQ2XxcC48ny1B/kRr4aJ3oJSzioR7T9yO1WY/5SeDGAONXH
         i6JnlheMJ/8QQKrKppgQ1oJnrqpea5hX1XRQSeh9dwO+cjh0HuId6MCFS3WptMUTMbJo
         E4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FA6FZ814jhwKtiNB3fDGO6OHKlGHF/CZ20X5ABmDnJY=;
        b=o4tSUO+bt4q4kikueRk7iqZriHdbcgKcpSotdy+aI9XKc8IL6Op0P84KcjHyNfrntr
         XO9nyrIRtbiFM3hSR+nhIL5IRwJi0ifuVPwGK31QhImVIx8LNWUOvuQtOlTfWFg/Ibnn
         GnjYefpO7TzMY3KAceTQEaXK1tjMhuGwKBN3T/Vu+zEjmPgAZWFlFPfLj/FxLmUshNt+
         UenLwjGoPot4N+Xo4kF5dTo5S/CbCISxKp6YBqv1+LqoHsQvtX8W69d0T8QiPDnQbmGp
         lClDthe86dDqWGdXRfrV3Tok+tNhS1WBKTjLw0aNUH784l9QjqDGvOQ/C0IonLXY7JSw
         PqxA==
X-Gm-Message-State: ACgBeo1cSxpuKQOmOAleZnuaneGXcqs6oJ1ZAFyskfmJAjW6vL/C2Pm3
        u04jftthmUlMP/B5I5FQ/EgAPQ==
X-Google-Smtp-Source: AA6agR7q6zVRLTmce+4BE3c7kuhYUQ63KrypCmfOKBdCEaNKyZaaCnos7nHE34rDGTlkVtMOvKgqsA==
X-Received: by 2002:a05:600c:3acd:b0:3b4:88ba:a75f with SMTP id d13-20020a05600c3acd00b003b488baa75fmr4783088wms.140.1663202485144;
        Wed, 14 Sep 2022 17:41:25 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b002250c35826dsm645476wro.104.2022.09.14.17.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:41:24 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     loic.poulain@linaro.org, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, bryan.odonoghue@linaro.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 1/1] wcn36xx: Add RX frame SNR as a source of system entropy
Date:   Thu, 15 Sep 2022 01:41:17 +0100
Message-Id: <20220915004117.1562703-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915004117.1562703-1-bryan.odonoghue@linaro.org>
References: <20220915004117.1562703-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The signal-to-noise-ratio SNR is returned by the wcn36xx firmware for each
received frame. SNR represents all of the unwanted interference signal
after filtering out the fundamental frequency and harmonics of the
frequency.

Noise can come from various electromagnetic sources, from temperature
affecting the performance hardware components or quantization effects
converting from analog to digital domains.

The SNR value returned by the WiFi firmware then is a good source of
entropy.

Other WiFi drivers offer up the noise component of the FFT as an entropy
source for the random pool e.g.

commit 2aa56cca3571 ("ath9k: Mix the received FFT bins to the random pool")

I attended Jason's talk on sources of randomness at Plumbers and it
occurred to me that SNR is a reasonable candidate to add.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index 8da3955995b6e..0802ed7288249 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/random.h>
 #include "txrx.h"
 
 static inline int get_rssi0(struct wcn36xx_rx_bd *bd)
@@ -278,6 +279,7 @@ static void wcn36xx_update_survey(struct wcn36xx *wcn, int rssi, int snr,
 	struct ieee80211_supported_band *sband;
 	int idx;
 	int i;
+	u8 snr_sample = snr & 0xff;
 
 	idx = 0;
 	if (band == NL80211_BAND_5GHZ)
@@ -297,6 +299,8 @@ static void wcn36xx_update_survey(struct wcn36xx *wcn, int rssi, int snr,
 	wcn->chan_survey[idx].rssi = rssi;
 	wcn->chan_survey[idx].snr = snr;
 	spin_unlock(&wcn->survey_lock);
+
+	add_device_randomness(&snr_sample, sizeof(snr_sample));
 }
 
 int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
-- 
2.37.3

