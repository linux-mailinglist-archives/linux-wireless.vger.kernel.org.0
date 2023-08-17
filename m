Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23377F34B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349649AbjHQJaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349622AbjHQJ3r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 05:29:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158432724
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 02:29:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so70378715e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1692264582; x=1692869382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqFTb7bjaxSxxbV34DaYmzS3F1LQba4HnHTfmT7YMxs=;
        b=b2ymlfv86YgJssmBOR3NXsAECAlZI8cEPPp6UP18R52kftCyu9sOk0wSBSKGHqhpFz
         lh7wZcTR/Zds2hEvZ6c4celbtzqiN9efXPE5sxvrH6Jw1hZFDu3ymp1mZnNJ8UzrZZfJ
         6xvRuumaWXVyU8Mve4VcDlXpkIRDLajSX8o1DJGoCvdg14f9wZZ8y8Q8QsJ+/9qSG9Fp
         TQjgOhfFgq7Jaz2x0oyF7k3venwkyB2WflitHOM96iFmlbhmQbw9xWx4zb3Ivif3SFsx
         3/sHb74Vmkx3Ojt0z4qUo7XbYa8rMm4Zhhs470Da+DkDf3RnfogbdrKNydYlTXy+EgSV
         G0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264582; x=1692869382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqFTb7bjaxSxxbV34DaYmzS3F1LQba4HnHTfmT7YMxs=;
        b=bH28r4O/UTexiu7vY3NSE6DeNi11ohA5Xqaz1nvVIG2Q+nE/DQuwu2/YhD6CwGqCF+
         X0UMVeCK/gtixAdP6KQEX+QebZJv6gsrqf9GHkw+Ckumt+Kzd33xWY4A13MJCskx0X3w
         ErZLjREkxONrhgWYukukrHDjVfi/QyOuzr+N1xGsu/uYgMN6AKc1HL7ZHF9mKu18I7EU
         k4LAsaWI3isjY56s2MP8Cc3+/uU2iEVtZmRjQgJu5CB2EPUv9J1/Oo8wWIoPCztNFo/Q
         sjYq/2wDH1yQQUjdlnkp6is4OHmgLZdf8A10gjH0K/EFchLlT3lA5svlzS6ZF6wSwI0D
         elwg==
X-Gm-Message-State: AOJu0YwedGTX2B6I/QrckL+QNJ8XSW5vj7LXG5X4HeZGP6BbvRZ6m+wc
        Y2466mZ7LBfTNzcoWVeTijsvtA==
X-Google-Smtp-Source: AGHT+IFyHq5Qa53CbVGOPJpj/iFzAxwqr6i90GP+5YeVYhNsAKvkTriebitw0VKy0brjP0GiYox9JA==
X-Received: by 2002:a05:600c:20c4:b0:3fc:a5:2c3a with SMTP id y4-20020a05600c20c400b003fc00a52c3amr3495163wmm.41.1692264582429;
        Thu, 17 Aug 2023 02:29:42 -0700 (PDT)
Received: from hyang-ThinkStation-P620.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003fe2f3a89d4sm2343042wmj.7.2023.08.17.02.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:29:42 -0700 (PDT)
From:   Hancheng Yang <hyang@freebox.fr>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, Hancheng Yang <hyang@freebox.fr>
Subject: [PATCH] ath9k: reset survey of current channel after a scan started
Date:   Thu, 17 Aug 2023 11:29:01 +0200
Message-Id: <20230817092900.361270-1-hyang@freebox.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the `ath_set_channel()` function, we only reset surveys that are not from the current channel.
This leads to the accumulation of survey data for the current channel indefinitely.
Log of hostapd:
[2023-08-17 11:21:51] ACS: Survey analysis for channel 1 (2412 MHz)
[2023-08-17 11:21:51] ACS: 1: min_nf=-90 interference_factor=0.569833 nf=-89 time=36194 busy=20908 rx=16200
[2023-08-17 11:21:51] ACS: 2: min_nf=-90 interference_factor=0.572018 nf=-89 time=36539 busy=21183 rx=16425
[2023-08-17 11:21:51] ACS: 3: min_nf=-90 interference_factor=0.574311 nf=-90 time=36885 busy=21464 rx=16659
[2023-08-17 11:21:51] ACS: 4: min_nf=-90 interference_factor=0.5773 nf=-89 time=37231 busy=21772 rx=16924
[2023-08-17 11:21:51] ACS: 5: min_nf=-90 interference_factor=0.580108 nf=-89 time=37578 busy=22076 rx=17189


This may not be the most optimal approach, as we want the ACS to rely on the most recent survey.
So, reset the survey data for the current channel at the start of each scan.

Or there's better approach?

Signed-off-by: Hancheng Yang <hyang@freebox.fr>
---
 drivers/net/wireless/ath/ath9k/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index fa5a87f021e2..3e4a711c96bb 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2382,7 +2382,22 @@ static void ath9k_sw_scan_start(struct ieee80211_hw *hw,
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
+	struct cfg80211_chan_def *chandef = &sc->cur_chan->chandef;
+	struct ieee80211_channel *chan = chandef->chan;
+	int pos = chan->hw_value;
 	set_bit(ATH_OP_SCANNING, &common->op_flags);
+
+	/* Reset current survey */
+	if (!sc->cur_chan->offchannel) {
+		if (sc->cur_survey != &sc->survey[pos]) {
+			if (sc->cur_survey)
+				sc->cur_survey->filled &= ~SURVEY_INFO_IN_USE;
+			sc->cur_survey = &sc->survey[pos];
+		}
+
+		memset(sc->cur_survey, 0, sizeof(struct survey_info));
+		sc->cur_survey->filled |= SURVEY_INFO_IN_USE;
+	}
 }
 
 static void ath9k_sw_scan_complete(struct ieee80211_hw *hw,
-- 
2.34.1

