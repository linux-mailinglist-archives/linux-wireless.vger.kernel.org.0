Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0098A261A61
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgIHSfO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731449AbgIHSc3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AADDC0617A0
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so204523wrm.9
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXRT8WPZIszbUjKzavBItUfnyzFeyxdJUeheAT4v54k=;
        b=i/I97V2nHsKWo8C1wBzOSpKIZYSl1zoklkERJrnbyYgUd0gSyQrMflUhq3g/p36ohg
         RDoY82DNAs8+63aMllKIPUrBSGLWTYM0PgiXMsQkh0hoRvI5m8rFQDXpirkQGTqEap9E
         rhrxg55s68/NWf6pPLYbVgh99QNGkvB//2ceySG75VyggGvdd3My4zynJr8ShCKu9jH+
         AT768JPbt8nfVWdcJFbUxm7uRumwvr5OuVtWVPuu0yQfOPhM+myR3FoH9YSDaLBX67XJ
         ndDwq1w8/b1ao4JKUKwR2oj1o8PzLPIOBbJdnEFzwVIueQbBRibYIixUCT/M0wvqvdC1
         oBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FXRT8WPZIszbUjKzavBItUfnyzFeyxdJUeheAT4v54k=;
        b=PVFgHC51C+yU4yfElB3OpyJw3VXaAXAPnVj+WaHhwv+yHdzj1QicfDmyAL79sq16Ov
         sKwzbSzi+NvYAS5Txinb+IdwpIbQLZXdPyNqRrJj7dAtzWSskr8kDshhUjmjOh9k6x4E
         mZs/rivwiDRsedkpqD/0ZsdDyDuSBmjZx1doKolH0aDK1vRnXfPWaJ8cWpkND7pBFAq4
         INlu4mojbS4Y3+W6UowukVKrLRb8s2B3jtFrMXocGVYFKM5h2F+GQIEvJqcO4FsEZyWT
         1P8ISP16HYrqjW4TvXuB9PGrtH/zmd+dfKidkyifC3BaLd0upNRlveiMCMxgaETWeveE
         FrSQ==
X-Gm-Message-State: AOAM5319Q2KUPiAvSUaRCJ+BPSa1cUXQsyRiIvj/Co/UQAEByWuFu//5
        YTm8wf9esIBXj17bAkPJUJW38w==
X-Google-Smtp-Source: ABdhPJyqEWDtHAup+oN/h2QtPVXdHwIrfcZYKUqJnD9SXPW9KpNsW/5hprXw/PRaHjEbI97keEiXug==
X-Received: by 2002:a5d:44cc:: with SMTP id z12mr922331wrr.189.1599589448324;
        Tue, 08 Sep 2020 11:24:08 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 189sm330439wmb.3.2020.09.08.11.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 0/7] wcn36xx: Tidy up BSS/STA config
Date:   Tue,  8 Sep 2020 19:24:48 +0100
Message-Id: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
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

-- 
2.27.0

