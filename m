Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B34884D2
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 18:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiAHRIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 12:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiAHRIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 12:08:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C223C061401
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 09:08:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h10so7490322wrb.1
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jan 2022 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JHBX507AUoJu4v3MDP9bEanjo6mkJkh7c+Gy5zgVn4o=;
        b=dLAXZ1crAwAICq09KTmjl31jpd25gsdibtEqejj8+DksvpG+fv6WZLaHIhGOxMjs0W
         FgsLm1fUkUl8VCsanLxTuCP/qe3o2pylAkEzjP/5I9blHk9i+nZBeL1J2pw97fmJZKZ/
         P73u4kRRDXl0qDUO+OuZOnIblrHWuklY8BKMki1U2Q7SccqpN7jJnj6Y//YzTFnyYdnl
         p1zG+IdDYoVbeD2TjVgeyJlTelVbtXWFiHXlLsAu1Pv06U3LMWjqP5RgZMpgyEOSGPTc
         4TDvLqyYw+VS8KrKA3lmyzWsYIKi1duQWDg5Nh94sGdCThCJedbNLYAVyRTjmfX78O2Y
         ZAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JHBX507AUoJu4v3MDP9bEanjo6mkJkh7c+Gy5zgVn4o=;
        b=u1hLzkQbQXopS4TsoPHQulE6uKenBm1FpWkBGl68XB8oAGdmKjp/7/P2O1MqW2Kgje
         iIfv2xs1w/rPxc+tpdm0tj88ABn3xKhZjql/XseOhT2DpesqjeGvM4LxWUTlxlJbSGkA
         J//TvxtFpymDzw31/U/XUJAmuQ/q5ep8f2rpp0zFcG6CvYTn/ZsZkIlAWB15CeJRdiye
         Cd6ohBeqhKSgTjLhiOqutQlYIgb0nCtFvJu4ieWI1qcEdHLxdeHL6XnD3nKzoJOa+/ZV
         7pGXlFKvHWn11f7yT7IE7p+rwJF70nZIqMHtGpugSFA+RfWrSKBTjq3uaRERdR59Tr+m
         23pA==
X-Gm-Message-State: AOAM532rkt9bPyEzOwyOt1SyT6gQBYu0QUuO8Sr+F+P1DsCEWbYCnhrC
        owhRMwHyk36eBZLW7L32DR1O8g==
X-Google-Smtp-Source: ABdhPJxI96to6VPRbB9lxQvQkyyV7u6jymDzoOmSyyPRSYxGao+MYLbaWKhT1mjSr6W4K/pX7yHvWA==
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr58203074wrz.60.1641661730736;
        Sat, 08 Jan 2022 09:08:50 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d22sm2154727wrb.83.2022.01.08.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:08:50 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/4] wcn36xx: Add spectrum survey reporting
Date:   Sat,  8 Jan 2022 17:10:53 +0000
Message-Id: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

 drivers/net/wireless/ath/wcn36xx/main.c    | 81 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 36 ++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 13 ++++
 3 files changed, 130 insertions(+)

-- 
2.33.0

