Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFD264B76
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgIJRjH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgIJRhg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB0C061383
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so363622wmj.5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i7FikWtwgz+IgoiYK3wy07v6fSyv51tBJwn8AQvuDiw=;
        b=TW1HR7I2zKpdA/zc3vuRTjMTGJaySVrCahiGFLMJuIDYaUL6tRkJX4bqDrBeS94hbR
         yAzrdkVNIM0M+519IX20fHFQXcO3qCgf+yYHBYFUNbyvVzgQ7GUHo4EnmgZ47Tx6kMwh
         w+AjVPs61NB/P5Fgh3eOZGRssiBZiz9vUqgAtSH9PjYWBOvGKxKe8rWA9WgEafJHks6P
         oYRoPtpCijmAHwE5FXoh9N/KRVIB3/61uzKlG2mImnlL/zTaGzNrSiqujDC2zkGfO6wf
         Bm5u6N//xmsXREgm5DYI4+bdC48EsWy1XocPUmZ4z4w+LbwzWKZ0ZyKncCh49FlMr7qb
         MwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i7FikWtwgz+IgoiYK3wy07v6fSyv51tBJwn8AQvuDiw=;
        b=pYpGDKG67aGbal/bkmEzsxjmaf5adECj8+KqeoWuPaMBY70S9rxWgiDFWyZVQbGCce
         uC441noXpg+b+3KjApiCmfcV4XLFFyjm3mHmKIK6Y7UD42dpNoRV7QCeVIbRCGcrg2Hm
         2ynSTRKS4qAega2FA1rPTlafhJSo7FzB4n5qTCTsryulGsCh8tdOCB9qiDi8jRQ2RRr7
         jM+zdx1ZGQP+2QPBAT9NlNbFt2+9v+locF4fkYI/o6R8IhIVgsEz+m7j6dItRkbviF2h
         6RJHtrRbbgs9nxY9lCr5zpcz/2Er/fE0IqQJimf0zrgTvKpQMfFN89qf64XrrsJDaQho
         OFXg==
X-Gm-Message-State: AOAM533j/GQnWbQ/57JzEMkFNRPpXI2jDRFmmk0GxhlDn2AWWYRVQQhu
        vaFhn/Z7rFZvqWw4EtMVt1ZxfAjA2e/Svw==
X-Google-Smtp-Source: ABdhPJx/ZsPXv8MRXn40SNomYx/tnVm5l/bzkYa3k2AYy207RNG1T77VXLJco9BoU7iYdH/MqpmOZQ==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr414599wmb.57.1599750420189;
        Thu, 10 Sep 2020 08:07:00 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m3sm7597315wrs.83.2020.09.10.08.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:06:59 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 0/4] wcn36xx: Update firmware config to support wcn3680
Date:   Thu, 10 Sep 2020 16:07:43 +0100
Message-Id: <20200910150747.2179122-1-bryan.odonoghue@linaro.org>
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

V5:
- No change to V4 but need to send the set again so that
  prerequisite-patch-id makes sense to the build robot here.

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
prerequisite-patch-id: 08122a9557904ce5358f52dd08cc33270fa202c1
prerequisite-patch-id: 82e0b7c5b2e9fa80baca001cce12577d98e306a9
prerequisite-patch-id: 8ee7f5bd6cb5b7b7d713947b554ad93bb90d8230
prerequisite-patch-id: d05c2253e4523b05b2e43491aa13ceeef68fd2f0
prerequisite-patch-id: 8be29513d3efa64df15297bcf81ec3db55088ee1
prerequisite-patch-id: d267dcd834afad75a69bcd2adcccfdad6566a7ba
prerequisite-patch-id: 47145acae6e24e8e6580fca1dbddfbec24f7b50b
prerequisite-patch-id: 8c66bccb923be821cf109a3a0d3a1a028edb4930
prerequisite-patch-id: d0f5f3769b2963208fd2348840726fa1d3501b63
prerequisite-patch-id: 746f63cf58fa3bf62736435c81dba2558aba8e81
prerequisite-patch-id: 375bb7847ae74c63d2eacdbd0d73371aef1546fe
prerequisite-patch-id: 8a598e22a08b0ec233d0ec56eeb53673eb1b8feb
prerequisite-patch-id: b0eba574ddc35ecec2d0e39c0d3351d1b260420e
prerequisite-patch-id: 143a1019813b7e4974a67e9eea1f1d599c0fdfdf
prerequisite-patch-id: f66d9fe9eb731272b825c9430c15dca89d6c6129
prerequisite-patch-id: c8c2d2dd1452c357f73fc4c92e5b564d59a05562
prerequisite-patch-id: 273c13464a69354d32790ed7509472d9c2b11231
prerequisite-patch-id: adbde1c98b85a16a6500b4210d4f055b9493418c
-- 
2.27.0

