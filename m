Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA84879B4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348093AbiAGPbR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 10:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbiAGPbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 10:31:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A80C061574
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jan 2022 07:31:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v6so11691767wra.8
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jan 2022 07:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srBKN6U6abX1l47mQ44+riWb72BXlTuarf8xHA7wZ/A=;
        b=LaqISNMLXI01YF8w8G6tReFWWrXEAnY1w73hdo6pwQzfpIGg+IGi4RaJ0BjN4bLlex
         6jeQmRAWTXnk6D7mKyWr7skugScDelp59+kLmEu57aD39pyC0+kBT30M9cPvvC0PVXIq
         XZdzTNsr9kYGOUayfgiMwp78RfkSLIChvdBOix7pdUSrPLpFis/uFIDs7htSAleo3nXy
         yRcwkWKhm8Fo7SPTaYj2W9RcY14Br4xD0at06jLieseD0MFtpsykS6cWAGpo9WB1Qsr2
         6URr9CH3yBYD60aZmuvCOejvmsNo+5NpJeh9U7gQDi2EuPuXDXJb/hwWuiEmS6gDAWYG
         vg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srBKN6U6abX1l47mQ44+riWb72BXlTuarf8xHA7wZ/A=;
        b=VhSwCkHeOU4f3C0oJNHOuEhc27sjBb3w7RagbfDzBQJc1EU5AiW6eEfkp71HtPIKDo
         T8jX06gSHt1rSvwRyzG2kpC7K+99T4pD3dINk50yPwP1e8zS1nlSkEk5WmedqHWaFWdN
         GbaBvtmhHsO8UeKIvkFMi2yvpmRFozhZMumi4kcujIczi9Dl2LOZBZ7LlnlPXtpbBsAT
         j4bFiP7hfkoLA5ukZy4a73ePMCocmHoLyKM8XvG65sTB1ro4qdBumGYoYwFNhSDFNC9G
         uOEmxyAUG/pU5VakukcQxKybzgbC8Et/Su5beOQRjZLvc27rqTbMJMqcYCT6/qy/LXOz
         zzpQ==
X-Gm-Message-State: AOAM531mnZsOgFMNaOTfRR3i4F4Yu8E3eGRIb9VmjT7Xj+PGLETgI76p
        QeB7kFBJvU4nEzzBOUdOb83Idg==
X-Google-Smtp-Source: ABdhPJyPI4IJixQOFItnl8iDx2nDfixS8x6yVG8BNu9wqD8GNyNgWOC+P9yBJGxoevDn8dYViWNeug==
X-Received: by 2002:adf:dc12:: with SMTP id t18mr56557748wri.566.1641569474428;
        Fri, 07 Jan 2022 07:31:14 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m6sm997242wrx.36.2022.01.07.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 07:31:14 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH 0/4] wcn36xx: Add spectrum survey reporting
Date:   Fri,  7 Jan 2022 15:33:19 +0000
Message-Id: <20220107153323.1807905-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

 drivers/net/wireless/ath/wcn36xx/main.c    | 81 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 37 ++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 13 ++++
 3 files changed, 131 insertions(+)

-- 
2.33.0

