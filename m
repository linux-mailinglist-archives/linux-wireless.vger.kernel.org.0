Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DBC256460
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgH2DiG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH2DiF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D076DC061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v4so119516wmj.5
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBFEccoWJMwFRewe1rUlUJLQ7mOx8bAogiBhvxdQoNQ=;
        b=ruMb+4bHiJF1PBQAEA0MrMbbBMXKPfyPjzwcWKrWx+XZ7/+/x6qXVHBApfnHiI1HLg
         UUzgVLoctqD9VqlJ5fkq4rW4pPhT4h2MJougC2HB21Xp8o3AFZTX0FWEH9oatr1AtXeM
         rHlmbjN/iNd4QY6JIJTPd5D6Rmdbduex0/3a43tdxCmS2Gccap1SyteO7a4TXRjdzdV7
         CbLQOHxW54dZIznRI2fbdjm7C2W9qSOzHlOMMHY1bqLELm6fDuOm9qyr3UGv4j476bsu
         j5nQAKsYEOy6T+GwalLHD4z5ezgMx+6Uyhm2ZBpYEqvksGO5HOVPyY3jhrsbA3mQsnPG
         DFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBFEccoWJMwFRewe1rUlUJLQ7mOx8bAogiBhvxdQoNQ=;
        b=XaImUjHgqSiEw0dwZl1wviiLS77JcZrSP88+uB+PA7mAsAjrskslua0nKCEL2btP03
         FFG2m5FjJnWAWzGd0asrh8yP3twtn8tbebth04Ftp2mlOXg3a38GC068xapbV9qV+1zD
         5cvB0Mf/yKJIMUEerqWjLBFO98F+jMoefH/F94CXPI5Ys5i3SZtpI28gwax7zcgI4oES
         u8dnFb9v38DPFliQsNEjHPTExRnYzELWUmz49KwB+phSfjHocx1ZwgagSbBzBahXrjuI
         G5lPurwpQXmoxsNViNpMKthjsaYoKAPDAcA7gmovOVQMBRE6UAc5J4p5S6gDd8dkML6b
         MOWQ==
X-Gm-Message-State: AOAM5323CFifetPVI9nIoFER0jo6L9BqNI5IKzdHGPqGhGRCKpSSiPkw
        VSmDiAC+/NTcdOaznn+QSziuFA==
X-Google-Smtp-Source: ABdhPJyD+gPdqFaN1JF+Bco+xswNtW9XE3sWCdbPNvERoXToVkWo2bQ2ennRoBCVRh4OIEMCsWoCSw==
X-Received: by 2002:a1c:4b12:: with SMTP id y18mr1491188wma.0.1598672283420;
        Fri, 28 Aug 2020 20:38:03 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 00/10] wcn36xx: Add basic support for wcn3680 up to MCS7/40MHz
Date:   Sat, 29 Aug 2020 04:38:36 +0100
Message-Id: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is one of a set of five to add support for wcn3680 at 802.11ac
data-rates.

This series adds the simple case of the wcn3680 chip with some associated
VHT parameters and data-rate parsing fixes associated with 5GHz.

Given this is only 1/5 of a set the STA and AP will not negotiate any of
the 802.11ac data-rates.

At the end of this series we can identify a wcn3680, place the firmware
into DOT11AC mode and achieve the same data-rates as a wcn3660, i.e MCS7 @
40MHz.

Subsequent patches in separate series will enable MCS8/MCS9 @ 80MHz.

V2:

Changes from V1
- Rebased on top of ath/pending
- Included a patch from Loic I have in my tree that
  "wcn36xx: Specify ieee80211_rx_status.nss" relies on
- Added IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE

V1:
https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t

Bryan O'Donoghue (9):
  wcn36xx: Add a chip identifier for WCN3680
  wcn36xx: Hook and identify RF_IRIS_WCN3680
  wcn36xx: Add ieee802.11 VHT flags
  wcn36xx: Add 802.11ac MCS rates
  wcn36xx: Specify ieee80211_rx_status.nss
  wcn36xx: Add 802.11ac HAL param bitfields
  wcn36xx: Add Supported rates V1 structure
  wcn36xx: Use existing pointers in wcn36xx_smd_config_bss_v1
  wcn36xx: Set feature DOT11AC for wcn3680

Loic Poulain (1):
  wcn36xx: Fix warning due to bad rate_idx

 drivers/net/wireless/ath/wcn36xx/hal.h     |  76 ++++++++++++-
 drivers/net/wireless/ath/wcn36xx/main.c    |  34 ++++++
 drivers/net/wireless/ath/wcn36xx/smd.c     | 112 +++++++++----------
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 119 ++++++++++++++++++++-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   1 +
 5 files changed, 277 insertions(+), 65 deletions(-)

-- 
2.27.0

