Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B32630B0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgIIPiI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgIIPgb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89716C061360
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so2829776wme.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IHx0+NLyzYUk9ph+s8nLW/OIGwymL67/C9uCLaWptg=;
        b=UnEC3f/WTaqgalWdFb427NJYrLmEJl5I5GQX3fVdmHt4/0AfRzDfuHNJxmBsQkQ+Vp
         aw6LMALgp0OAi/2unLLRtKjAynWoQ9EthMAETG8LuFxCBc25BDZmukkh1gw/jtDKg/iF
         RxrxXzGozejp0ll2/HP3ZQJtJ2wPTzKYBPkbTTeleca8yccCmcwtohjX/yUKpAw6kJLT
         owN1bpg/XysEEOExeHSizuiS3dR2L1r6y3Yaq1TqHnVd4qoWaLMo7aaPfuIER0nQca4O
         ndhEXaYSzFjNqAl3BlciznflnVM1x3nVIAqAZxpj9cjteKzXZwFMiMD4w//fLnXGCCdW
         k9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IHx0+NLyzYUk9ph+s8nLW/OIGwymL67/C9uCLaWptg=;
        b=aXv7qI8dThcmgBHWy3GRVFf9W+dlaHKtDI6XxS5EiMqE8ez7JOjdEmI0hoj7bP3MH4
         6vAcUmboSsh0fuuendSwAwHJvTLaqHt+8Vbup3E2Dq6KBOLldEBvupT6VnL6QZW2QuTU
         A65xbQAlits5wUxnlLbwxWraEF7jgYucfVxp9Q1Aj9lCR+Yi7o+h64HkjtV8ak8g6MQq
         DJQeV/K5NR7u20WZcsARUVni9jKaGjRt1aslnYzoKXCQ8CvyKDKa1lHuSPecfimSrcru
         VKV2ASE7tUTlpFDAYBka7RJRz5Kylz0/+mtQQni8lQjucB65fE3i3AwXoO1hQ0YZf5sT
         +jWg==
X-Gm-Message-State: AOAM53311oXd7fy/P5DYiCQsMrGc+LtheDNA1IDDoYK9GZonOmr2URRZ
        oxfxA8/8q/H8KZ663/5fnIHWrw==
X-Google-Smtp-Source: ABdhPJyvQvTacu/Bd54Tu9hjemw2GnCeMiRKDjzLIogPK+X/6lrajWIVyOJeagziikfly4MazMVkfg==
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr4175904wmd.95.1599665789242;
        Wed, 09 Sep 2020 08:36:29 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m185sm4605220wmf.5.2020.09.09.08.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:28 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 0/4] wcn36xx: Update firmware config to support wcn3680
Date:   Wed,  9 Sep 2020 16:37:13 +0100
Message-Id: <20200909153717.2905037-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is five in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

This series is about providing a parameters to firmware to get us up onto
802.11ac data-rates finally.

Once the firmware config is provided to the chip and VHT parameters are
populated we are good to go in terms of the higher data-rate for the
wcn3680.

I get typical data-rates of:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-320.00 sec  4.93 GBytes   132 Mbits/sec  445     sender
[  5]   0.00-320.14 sec  4.93 GBytes   132 Mbits/sec          receiver

Downstream 3.10 prima is getting I'm told 180-200 Mbits/sec on the same
hardware so with time and effort there's certainly some performance gain to
be squeezed out of this silicon yet.

However as a first pass, I believe this is good enough and useful enough to
others to submit for upstream inclusion.

An interesting project and a medium term goal would be to have a unified
configuration for all three supported chipsets.

For now suggesting a separate firmware configuration to make sure the
existing lower-speed 802.11n and higher-speed 802.11ac chips don't step on
each other's toes vis-a-vis firmware parameters.

V4:
- No functional change.
  Sending out full set again using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908182529.2870478-1-bryan.odonoghue@linaro.org/T/#t

V3:
No difference between V3 and V2 below
https://lore.kernel.org/linux-wireless/20200829034002.2167878-1-bryan.odonoghue@linaro.org/T/#t

V2:
- Sets the default data-rate for wcn3680 to MCS8
- Zapps a few firmware settings for power-saving
  Powersave configuration as a specific wcn3680 topic is WIP on my end
  and I think therefore better left out of an intiial submission.

V1:
https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t

Bryan O'Donoghue (4):
  wcn36xx: Extend HAL param config list
  wcn36xx: Define wcn3680 specific firmware parameters
  wcn36xx: Add ability to download wcn3680 specific firmware parameters
  wcn36xx: Latch VHT specific BSS parameters to firmware

 drivers/net/wireless/ath/wcn36xx/hal.h | 124 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/wcn36xx/smd.c | 114 ++++++++++++++++++++++-
 2 files changed, 234 insertions(+), 4 deletions(-)


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
-- 
2.27.0

