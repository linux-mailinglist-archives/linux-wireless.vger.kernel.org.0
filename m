Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400432633B9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgIIRJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbgIIPgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E222AC0612F3
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so2728876wme.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OW3OE0n8UmsNmm14ps/mNaK009oeWo9VSNVPySBtug=;
        b=UnClN4JTf+DCzY7QJnxF/ctP81kbS/rW7iXwz65EMLlKyXeY4WPNvpuy+QOugOkJvA
         xzk8Nxqq5kHiSArGY1QRG9UxrcIjx/nzrkDiYMfwi/4fCNIt+oOibiqz8x3LVLRzhmPE
         jBUk4HXMn5VSkS8qmsEYb2sDXXrEOWRJ7geExAeqe+Xfgi8H/bdMkS9Y3BXOZK2zLYmx
         Kp09eEuyX8rdClw1YFZf4uxhVBID8E9ihB9wd4nIDU3O+Ffq4zuRgtm5eAetp1VAKD1Z
         rNqhXq7/Hx6duTIAs8Pr+D2CROhnFwdAe8yDVITWK4tnI/VourxlG4wvd8NeyS2z1YFp
         teWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OW3OE0n8UmsNmm14ps/mNaK009oeWo9VSNVPySBtug=;
        b=Hde7mi/bbPSLuBoKnp7gAJhao2Q+lCVsHbBxnVFX6V3qCICPRkMxRNQnYt/XhK/1Od
         dLYENW36K1CcPotLO/NS3spKMXl3n+jwh2lm4UsRv1CruHhklBbtCxYgxTF21CM3DUNW
         sM29/htbtDBF/IL6bbliMtRd1KPbiIhVI+umETIFTNQopIT5dLhVGPhINHMrYEtqNKPI
         v1XIl2kUza6ftNMqKJe7Xq2aKj9u7tGJIYEmjbAHAOFHoF8AzJesy2v/b5opkpDe2WBB
         BIstC0MwvH127hKh/umQ7GLq6PIIYgUqGNYqZYuqwdO8CVQPr6XV1Pn9bBwZk1FgczCt
         NCdw==
X-Gm-Message-State: AOAM533S5g3Rxif1qOu1XTol+pn0NW7RHn1XdE+AFb1QwX41S1GMSb38
        oiaMG89ZZSbvNVORsSWiNeeiUw==
X-Google-Smtp-Source: ABdhPJz0b+3g7LzTWGCgAQJcKfin0Q5zap9k7il33BFWVu7vIMmqfaC7lzmoKqyvVE6oyXm+pNXstA==
X-Received: by 2002:a1c:40f:: with SMTP id 15mr4299334wme.175.1599665739621;
        Wed, 09 Sep 2020 08:35:39 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm4924871wrx.63.2020.09.09.08.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:39 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 0/7] wcn36xx: Tidy up BSS/STA config
Date:   Wed,  9 Sep 2020 16:36:21 +0100
Message-Id: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is three in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

Both the BSS and STA config paths have redundant/duplicate code. Before
adding more code to either it makes sense to reduce/reuse and functionally
decompose as much as possible.

While not strictly necessary to get the wcn3680/80211.ac functioning in
this driver, it seems like a missed opportunity to leave the code as is.

Lets reduce down before adding more.

V4:
- No functional change.
  Sending out full set again using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908182455.2870345-1-bryan.odonoghue@linaro.org/T/#t

V3:
- No functional difference to V2
  https://lore.kernel.org/linux-wireless/CAMZdPi___9yry0icuZVdnyiO7ZT0w=Xt8f8Pn7wkxRejxhXyYw@mail.gmail.com/T/#t
- Adds Loic's Reviewed-by as indicated
  https://lore.kernel.org/linux-wireless/CAMZdPi___9yry0icuZVdnyiO7ZT0w=Xt8f8Pn7wkxRejxhXyYw@mail.gmail.com/T/#m2256137b97859c8eac26a2836f96db5e82475d3f

V2:
- Adds a memset to wcn36xx_smd_config_bss_v1()
  Since we are doing one less kzalloc() we need to make sure we clear
  out the bss config.

V1:
https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t

Bryan O'Donoghue (7):
  wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
  wcn36xx: Move wcn36xx_smd_set_sta_params() inside
    wcn36xx_smd_config_bss()
  wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
  wcn36xx: Update wcn36xx_smd_config_bss_v1() to operate internally
  wcn36xx: Add wcn36xx_smd_config_bss_v0
  wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
  wcn36xx: Remove dead code in wcn36xx_smd_config_bss()

 drivers/net/wireless/ath/wcn36xx/smd.c | 416 ++++++++++++++-----------
 1 file changed, 228 insertions(+), 188 deletions(-)


base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
prerequisite-patch-id: 9a4ac7faca179f6594c9b3a115ee69a2da540a69
prerequisite-patch-id: 183286f9c22d1aaa12f356651224e6b337ef1938
prerequisite-patch-id: af468d413daaf8d2aad195fcb43c6e66390d8468
prerequisite-patch-id: 1a7fb93ee5874d2d011409eaed0b4fd764666b9c
prerequisite-patch-id: 77cc008b21a650fa7a33c4acad2fb632b09634fd
prerequisite-patch-id: 988ae4802971d6895b03b2752122b2be42baf188
prerequisite-patch-id: a3ba2a1963e03e23e86c937cd4cfb649e1b819b2
prerequisite-patch-id: 8a1fe4f63bc80e9a8035aa52356da8c46eab8665
prerequisite-patch-id: d75c1a60d1ede373c1f3eb684bb15c853c88eedc
-- 
2.27.0

