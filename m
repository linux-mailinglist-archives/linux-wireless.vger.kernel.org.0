Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951D7264BAB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgIJRnf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgIJRmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 13:42:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18147C061756
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so381282wmm.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMf9EB5Mu6K6rHazidoIudnwtwroJlrj/VId80zyrmk=;
        b=D1kkdqvXNUWmZQoz/Tv5BUmeYeMtRaIo+M938Ay8vpnfIJgq2K/RqlgLAyzLVqYClL
         +gqXzScSK5mWPX/2kbQzHvmpz9dnn/Skee4yjF3pAUVp9KwOY8Nv/fBHrHr26+JLoJrq
         zd8XT0qKI6k/Xtwsn6rlJwwrXCMfLGM+AlM7pQebQhMOTRreztNFxZNHsIg1wHN8WrPY
         sSU4W5uXYvsJkj12VG09weGiit+fmzVZIl04uyKSDsbeyoqIpEXvCMD3q5CS0uOux4R9
         liqaefSo/puMDjcDWYIatXlne0c2EUcI/+myo6Iqay6O+EXe+PnVcu9eBPUsOG0pm5NZ
         ACwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMf9EB5Mu6K6rHazidoIudnwtwroJlrj/VId80zyrmk=;
        b=kJBa7O1WnoGUYG2i5wSyNTqxuwU3qOxjpxK1qDHeWOKhcCMSUNRdK/gcQHHF4H/dlv
         D2HIefyYfpfM390RGhDhWjqFyoIXAGVuplM11fBG9Migi1TQQGDsEmmW3KnLmmHeBxb6
         DlURZ5kNJfsnjFMzm7QLcnRb39waNMXSITaU8N49k1hcvVEufG9zy5BrWn0drNAnoX8i
         xotQo7VzlxxVC03cUVxJMqjw/v4ty5MzPNMX5kMlnNykgQTWokQ940hQD1hYecS0kNpv
         BMnsTFaZQd2SYQQysQzgsSr27N3FHxZxOWY85Tn6gvvaF+8U2X3nqrbjJqMXGAogTofo
         Wzow==
X-Gm-Message-State: AOAM533yDqWHjJSX3VcXIz8cvm25RSuVLRINxjEj7Pz/D6wpiD5fE0YV
        ufEnHUYs+nBiqj3tbo0PGPy2Rw==
X-Google-Smtp-Source: ABdhPJyGW3SkE1ZtfYqZbpjfLaBNVfvNokPvZl6lI1DTeRwiTQKYcWDtGY68WhFcOSNN7hBuo4GaaA==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr477428wma.18.1599750343684;
        Thu, 10 Sep 2020 08:05:43 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k24sm3857005wmj.19.2020.09.10.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:43 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 0/7] wcn36xx: Tidy up BSS/STA config
Date:   Thu, 10 Sep 2020 16:06:24 +0100
Message-Id: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
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

V5:
- Fixes -W=1 warning caught in this set by kernel build robot
  I'm still declaring some functions standalone for the purposes of
  granularity and bisectability, a later patch makes relevant functions
  static.

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

 drivers/net/wireless/ath/wcn36xx/smd.c | 422 ++++++++++++++-----------
 1 file changed, 234 insertions(+), 188 deletions(-)


base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
prerequisite-patch-id: 9a4ac7faca179f6594c9b3a115ee69a2da540a69
prerequisite-patch-id: 183286f9c22d1aaa12f356651224e6b337ef1938
prerequisite-patch-id: af468d413daaf8d2aad195fcb43c6e66390d8468
prerequisite-patch-id: 08122a9557904ce5358f52dd08cc33270fa202c1
prerequisite-patch-id: 82e0b7c5b2e9fa80baca001cce12577d98e306a9
prerequisite-patch-id: 8ee7f5bd6cb5b7b7d713947b554ad93bb90d8230
prerequisite-patch-id: d05c2253e4523b05b2e43491aa13ceeef68fd2f0
prerequisite-patch-id: 8be29513d3efa64df15297bcf81ec3db55088ee1
prerequisite-patch-id: d267dcd834afad75a69bcd2adcccfdad6566a7ba
-- 
2.27.0

