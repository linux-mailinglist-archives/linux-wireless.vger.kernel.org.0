Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80048F360
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 01:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiAOAOi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 19:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiAOAOi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 19:14:38 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF206C06161C
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 16:14:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so8500885wme.4
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 16:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dd6Xa7c8yt0VNmEXTcfRMxXsoAp7hK9Q6Ap/0uxazQU=;
        b=iiwfpH9lZQMo8Y8149tzeDAXssVwRntN6Xoj2nkcCSBt7t7pmKONmnK6tgXIv9UoHN
         rTU5IUoP7RA3Zb9QUsvOffncrq3GXf8tHdb9QeTfknvZvlYfSsBIVl6+fwXJhDKfktit
         Fbjr878cFYs80u/9RtYTRcqdONuhorN3K/Ky+4bVXU7AU9vgiteNw6fwUn7FTur8Tz/1
         pZfQ3Z5nCnDchcupd0R5OJcTBAO6lw3FvB2hv4CkgAIefrqjDNX2ztGqcpyoqOvxmE2N
         F+vcMeWT2p2rbw2c8wlk8h4N0knx+iia9QcdabTnNBcDlLUTMAgc67nk9rGXP5Wk29yM
         ++oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dd6Xa7c8yt0VNmEXTcfRMxXsoAp7hK9Q6Ap/0uxazQU=;
        b=Dq+TQPqx8J0laQ1m1goBBm+v/NmCnSUu7Aau5xz+FURZcuezqD1U5qiv0b7JMlHOD3
         Wom8R025Iz/mRzlFqdehwvazXUr9VbJr4cFeNQwz0P4Zcxkz01sb11X7RuM+b2ChzS42
         ssrP5LGAv4Nql+eeVo2x7wg+kNmmhQx2Ootngu5Bqb0+z2Mhd/dwq9Mt30MLGcOLNPd1
         01zxs9KyoN9JcecyC6bEX3PjRTAS+KdR+9X2M9NZ2kWiKZexClYQb1Zc7Nof43i6zPWR
         cLCqQWH/Rpb2PpPiL0pPB98GmnRs90Ag8M+JNF3hdtAyKp6rlvcAQzD9z56brlGZAdYt
         bleg==
X-Gm-Message-State: AOAM5318Ra34oDKNVxi7NDNyZLGO7NJL8VaGFvYX8kqIwlHx7EC2Fj5D
        OIBI+XQQ5gtfEbdIBtnswlhn4A==
X-Google-Smtp-Source: ABdhPJwaUtnavwWtjHS2Yxd/Dt3UybOwo5kWOWX3g2wRMGPwxknDT4jq39oeTRQi6/k8oqG5L1l7eA==
X-Received: by 2002:a7b:cbda:: with SMTP id n26mr17636584wmi.93.1642205676317;
        Fri, 14 Jan 2022 16:14:36 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15sm7379494wmq.6.2022.01.14.16.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:14:35 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 0/4] wcn36xx: Add spectrum survey reporting
Date:   Sat, 15 Jan 2022 00:16:42 +0000
Message-Id: <20220115001646.3981501-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V3:
- Fixes an indexing bug in get_survey()

  We use an array to track snr and rssi. This array is organised so that
  the index value passed in get_survey() references the array directly.

  We also want to know the index into the frequency band tables which are
  divided into two parts for 2 GHz and 5 GHz.

  The previous patch modified the index to dereference the band instead of
  taking a copy of the index and modifying the copy to reference the band
  table.

  In other words the same index couldn't be used for both the array and the
  band index.

  Fixes by way of separating the two indices into idx and band_idx.

V2:
- Fixes typo "ret -= ENOMEM" => "ret = -ENOMEM" - kernel test bot
- Makes get_survey() static - kernel test bot
- Ignores riscv warnings since none apply to code in this patch - bod

V1:
This series enables get_survey() on wcn36xx. Tested with wcn3620 and
wcn3680b.

wcn36xx reports RSSI and SNR in the buffer descriptor of each delivered
frame wcn36xx -> host. Thus far we have only extracted RSSI but, extracting
the SNR lets us also report the noise-floor.

Adding in some background tracking of the current tuned channel lets us
flag which channel is currently in use when running "iw wlan0 survey dump"

For both wcn3620 and wcn3680b I have verified both the STA and AP's view of
RSSI and noise.

Example wcn3620:
  AP Asus RT-AX88U
    SSID: "linaro-test"
    noise: -78 dBm	Channel: 8
    BSSID: 04:D4:C4:AA:BB:CC

    MAC               RSSI
    02:00:16:qq:xx:yy -35dBm

  STA
    root@linaro-developer:~# iw wlan0 link
    Connected to 04:d4:c4:aa:bb:cc (on wlan0)
          SSID: linaro-test
          freq: 2447
          RX: 768377 bytes (4250 packets)
          TX: 8136 bytes (97 packets)
          signal: -37 dBm

    root@linaro-developer:~# iw wlan0 survey dump
    Survey data from wlan0
            frequency:                      2412 MHz
    Survey data from wlan0
            frequency:                      2417 MHz
            noise:                          -12 dBm
    Survey data from wlan0
            frequency:                      2422 MHz
            noise:                          -82 dBm
    Survey data from wlan0
            frequency:                      2427 MHz
            noise:                          -76 dBm
    Survey data from wlan0
            frequency:                      2432 MHz
            noise:                          -78 dBm
    Survey data from wlan0
            frequency:                      2437 MHz
            noise:                          -100 dBm
    Survey data from wlan0
            frequency:                      2442 MHz
            noise:                          -41 dBm
    Survey data from wlan0
            frequency:                      2447 MHz [in use]
            noise:                          -75 dBm

Example wcn3680b:
  AP Asus RT-AX88U:
    SSID: "linaro-test"
    noise: -80 dBm	Channel: 60/160
    BSSID: 04:D4:C4:DD:EE:FF	

    MAC               RSSI
    E2:C0:10:YY:XX:QQ -31dBm

  STA:
    root@linaro-developer:~# iw wlan0 link
    Connected to 04:d4:c4:dd:ee:ff (on wlan0)
            SSID: linaro-test
            freq: 5300
            RX: 5999294 bytes (32764 packets)
            TX: 35443 bytes (493 packets)
            signal: -27 dBm
            rx bitrate: 433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1
            tx bitrate: 6.0 MBit/s

            bss flags:      short-slot-time
            dtim period:    3
            beacon int:     100

    root@linaro-developer:~# iw wlan0 survey dump
    Survey data from wlan0
            frequency:                      2412 MHz
            noise:                          -63 dBm
    Survey data from wlan0
            frequency:                      2417 MHz
            noise:                          -57 dBm
    Survey data from wlan0
            frequency:                      2422 MHz
            noise:                          -74 dBm
    Survey data from wlan0
            frequency:                      2427 MHz
            noise:                          -90 dBm
    Survey data from wlan0
            frequency:                      2432 MHz
            noise:                          -72 dBm
    Survey data from wlan0
            frequency:                      2437 MHz
            noise:                          -33 dBm
    Survey data from wlan0
            frequency:                      2442 MHz
            noise:                          -72 dBm
    Survey data from wlan0
            frequency:                      2447 MHz
            noise:                          -68 dBm
    Survey data from wlan0
            frequency:                      2452 MHz
            noise:                          -33 dBm
    Survey data from wlan0
            frequency:                      2457 MHz
            noise:                          -33 dBm
    Survey data from wlan0
            frequency:                      2462 MHz
            noise:                          -36 dBm
    Survey data from wlan0
            frequency:                      2467 MHz
            noise:                          -68 dBm
    Survey data from wlan0
            frequency:                      2472 MHz
            noise:                          -34 dBm
    Survey data from wlan0
            frequency:                      5180 MHz
            noise:                          -63 dBm
    Survey data from wlan0
            frequency:                      5200 MHz
            noise:                          -57 dBm
    Survey data from wlan0
            frequency:                      5220 MHz
            noise:                          -74 dBm
    Survey data from wlan0
            frequency:                      5240 MHz
            noise:                          -90 dBm
    Survey data from wlan0
            frequency:                      5260 MHz
            noise:                          -72 dBm
    Survey data from wlan0
            frequency:                      5280 MHz
            noise:                          -33 dBm
    Survey data from wlan0
            frequency:                      5300 MHz [in use]
            noise:                          -72 dBm

Bryan O'Donoghue (4):
  wcn36xx: Implement get_snr()
  wcn36xx: Track the band and channel we are tuned to
  wcn36xx: Track SNR and RSSI for each RX frame
  wcn36xx: Add SNR reporting via get_survey()

 drivers/net/wireless/ath/wcn36xx/main.c    | 83 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 36 ++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 13 ++++
 3 files changed, 132 insertions(+)

-- 
2.33.0

