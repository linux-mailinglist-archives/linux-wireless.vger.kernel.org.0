Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED72648CD
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 17:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgIJPeF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbgIJPc6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:32:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698A6C06138E
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so7051878wrl.12
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5diBaU99ZzEtxgfl2/ibFWOVYJcTwWqWMX3zMcPrdo=;
        b=ze5qO8hJLhHNe+X4ZuFBjhGZ1pcTZED7UWmT2AWqnTuG5InvGf3caLh8kErPsxTEVO
         z4cHuzeZalcBTzBsIjpCJhxfCcMby9SR/WBjrV69blfqZg4AjLpHS0cmjvI+4s68bUCG
         BkCD40hqXX6iK+bh//UXCNVnM2vye43/13H2Bl16akFsw/NfJKyeQ9n5aVziV66k1d3K
         kgJn5Bb1uCxQu5SI1Z8Hs7wpilGeGq+rfDzc5Q2066mEgKe2Mk+rTVyCKx+mWAQM8Ha+
         xYFp5JCFDrsc191C14nF3dQ26I73qegB1X7/Q/zUE0k7Uvg0l2nxewniDxVY/hO3IZut
         s6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5diBaU99ZzEtxgfl2/ibFWOVYJcTwWqWMX3zMcPrdo=;
        b=RgA5R8qo8tR190llERmBYfDWq4WT7Gs6a42iOoZ7ExL1HunfSHMtDRWkzvnIQVYJ9x
         pDhiRRJ0KDScxddQo6XDUB4y42lNqIklNjQj/k0acfdNx+1YK+pgyzgUdl6s2FCtpgrJ
         QDmZZYMeGHIwfX3Zn0seFtjX27WI7isxPw5m0l8AWC+wULfYGuuYllQdwoPfSnY0+rmD
         3FJlPZgHoOmGRuuSFBjQLWk8kBvF26WxOeyI266AIn0IGAA/NIBUOA86Ozt0UaSmRRhy
         Nuft13AnVsw7SIjL6jBVxiOfxTzXf2hfDDfp/FhJxkH8p+xFLpmbeDljiFdF7rVvnkBg
         1I6Q==
X-Gm-Message-State: AOAM5304WLpC5o2dZuaChs4Kavi6LceVm/1bh/1okx4CZ+xpgreS71eH
        TP311Ri77Lo5+H6BmzzSnYK0Vw==
X-Google-Smtp-Source: ABdhPJyAI9pZqed9joZmAPMpe5t/s0yQohHaI1jL1X1hCi1ZsTIlXBWyHKxP+vHmMMBIEJ8HdCxQWw==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr9110264wrm.320.1599750454123;
        Thu, 10 Sep 2020 08:07:34 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o128sm3895678wmo.39.2020.09.10.08.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:33 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 0/4] wcn36xx: Enable VHT when supported
Date:   Thu, 10 Sep 2020 16:08:18 +0100
Message-Id: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is six in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

These two commits have been moved later in the set of commits so that the
patches to enable advertisement of VHT capabilities happen after all of the
supporting code has been comitted.

V5:
- No change to V4 but need to send the set again so that
  prerequisite-patch-id makes sense to the build robot here.

V4:
- Missed inclusion of these two patches in V3 versus V2.
  wcn36xx: Convert to VHT parameter structure on wcn3680
  wcn36xx: Define INIT_HAL_MSG_V1()

- Generated set using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908183331.2871016-1-bryan.odonoghue@linaro.org/T/#t

V3/RESEND:
- Messed up my .git/config resending from my @linaro.org address

Changes from V2:

- Rename "wcn36xx: Add ieee802.11 VHT flags" to "wcn36xx: Advertise
  ieee802.11 VHT flags"

https://lore.kernel.org/linux-wireless/20200829033908.2167689-5-bryan.odonoghue@linaro.org/T/#u
https://lore.kernel.org/linux-wireless/20200829033846.2167619-4-bryan.odonoghue@linaro.org/T/#u

Bryan O'Donoghue (4):
  wcn36xx: Define INIT_HAL_MSG_V1()
  wcn36xx: Convert to VHT parameter structure on wcn3680
  wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
  wcn36xx: Advertise ieee802.11 VHT flags

 drivers/net/wireless/ath/wcn36xx/main.c | 40 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 26 ++++++++++++----
 2 files changed, 60 insertions(+), 6 deletions(-)


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
prerequisite-patch-id: 559b6f9af6b26f860896dea4c7eb385ba9bdf0d5
prerequisite-patch-id: 94c091c0c78b754d4c842a097a6db126bf6e770f
prerequisite-patch-id: f2e549349c09f4675775b40bf9bb9b1f2bec6db8
prerequisite-patch-id: c3a6aa788141f5b8782d28dac264470c8081bb97
-- 
2.27.0

