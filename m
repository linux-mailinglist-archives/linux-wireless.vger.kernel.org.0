Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E29A2633A9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgIIRIE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgIIPhH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:37:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F9DC06134E
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:37:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so2730731wmi.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UruioKL38jOmfQ13ewwmmsoNsGsLW14m3QU9FXm2S/I=;
        b=K7ZaE0IWEIg8t8la7fc0xIteFmINBIRhiCQhz0ioSarZ0n0GZKhPnBSHn7QpmnRl2n
         UhoqiPtHlvOp0zFLw46bQDQatGLdNkmcpdfYboUl7ZLUIlcSsPs5O/6EQzkzKsSd7U/R
         y7Zb35t0sQ1D5Ko2GSIv+lDShZGWpsiS2i28tnIatA6EnxdJ5djdSZjULA4h/oB+Ehk2
         GsyXKqIe54sM6E8QIktIPtuEh5CmCnpPl6jLKfFL6/7lV+FgjYa6Z5ClbcNw7HD/1PIh
         AzPYnrYLV0pljvAdchHxA5mWnJw72RJ/IJzf3aIU5hoCQAVvyKFr6hA2kmpxdIZMusOf
         UEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UruioKL38jOmfQ13ewwmmsoNsGsLW14m3QU9FXm2S/I=;
        b=eA46cmuVRuTxnqbPF26GAt4Crg5KxrMjAxUPGcZUzgeyv4/y0Mbo6BQC2q6Io+Pvf8
         0KZqscCovL1glowGOHp2UIYhLuAIMqpqQgNqJjc9IPSweJjT/mfoToXNqXMijBg0YrBF
         UZF9hfxRn7WwCAH2WoBt/cuSq1DcoTp+2civhfFA4jGbFqgjKGwdXIHcbiVBu4+ENq3w
         D+smDezLOu692W7Gh8FmxJSSftIsjjippLy7VmajeQ5i2Qt/Yh7XUgjy4Vk6ZeyLvIyw
         KE8M3wXjE4VZKimWTfXOrKpPXApgRiPKguT524Hl2noULUW9hvkyESN0dvpz1XCcIW1t
         UrBg==
X-Gm-Message-State: AOAM533WKJ8LnohaN9ODAJr+bnXRwaRdLoRwo0gohMtnQc3hoKUWxLuz
        znxyRHW+54lcIMWATdnA/kN+bg==
X-Google-Smtp-Source: ABdhPJzd94q2Q2lNaHiZwBrnXpK8RNoa28SPFDUgG4gOep8zLPjBm5x1Ce1jtA6upOsXEmSAaCH5sg==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr4034774wme.0.1599665824965;
        Wed, 09 Sep 2020 08:37:04 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a83sm4424122wmh.48.2020.09.09.08.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:37:04 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 0/2] wcn36xx: Miscellaneous updates
Date:   Wed,  9 Sep 2020 16:37:51 +0100
Message-Id: <20200909153753.2905176-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is seven in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

This set marks functions previously declared non-static as static. In order
to facilitate granular standalone commits and avoid single patch
code-bombs. A series of functions were previously declared non-static.
Antecedent changes have made use of those functions so we can now mark them
static.

In a similar theme of cleanup, I've added on a fix for some whitespace
damage in main.c and smd.c which while not strictly related to wcn3680 I've
opted to throw into the bucket under a "miscellaneous update" title.

Hope that's OK.

V4:
- No functional change.
  Sending out full set again using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908183424.2871101-1-bryan.odonoghue@linaro.org/T/#t

V3/RESEND:
- Messed up my .git/config resending from my @linaro.org address

Bryan O'Donoghue (2):
  wcn36xx: Mark internal smd functions static
  wcn36xx: Ensure spaces between functions

 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 38 ++++++++++++++-----------
 2 files changed, 23 insertions(+), 16 deletions(-)


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
prerequisite-patch-id: 47145acae6e24e8e6580fca1dbddfbec24f7b50b
prerequisite-patch-id: 8c66bccb923be821cf109a3a0d3a1a028edb4930
prerequisite-patch-id: f078e5fdfe8c18936469bfb118a964db13ea729f
prerequisite-patch-id: 746f63cf58fa3bf62736435c81dba2558aba8e81
prerequisite-patch-id: 36a94e202cbdaee8e06f9a108b1c894bd1159e62
prerequisite-patch-id: 8a598e22a08b0ec233d0ec56eeb53673eb1b8feb
prerequisite-patch-id: b0eba574ddc35ecec2d0e39c0d3351d1b260420e
prerequisite-patch-id: 143a1019813b7e4974a67e9eea1f1d599c0fdfdf
prerequisite-patch-id: f66d9fe9eb731272b825c9430c15dca89d6c6129
prerequisite-patch-id: c8c2d2dd1452c357f73fc4c92e5b564d59a05562
prerequisite-patch-id: 273c13464a69354d32790ed7509472d9c2b11231
prerequisite-patch-id: adbde1c98b85a16a6500b4210d4f055b9493418c
prerequisite-patch-id: 559b6f9af6b26f860896dea4c7eb385ba9bdf0d5
prerequisite-patch-id: 94c091c0c78b754d4c842a097a6db126bf6e770f
prerequisite-patch-id: f2e549349c09f4675775b40bf9bb9b1f2bec6db8
prerequisite-patch-id: c3a6aa788141f5b8782d28dac264470c8081bb97
prerequisite-patch-id: 452450f26295dc4fc48dec07ba85538d78bae4b4
prerequisite-patch-id: 8e7850077db9ec00df9be4fe3e0e4a4e8b06fbba
prerequisite-patch-id: 233db8337812d9d34f99b41ccebd8758a6ada6d9
prerequisite-patch-id: 0bbaaf402d2dd50a50aaa6505e5d10e743cf03e5
-- 
2.27.0

