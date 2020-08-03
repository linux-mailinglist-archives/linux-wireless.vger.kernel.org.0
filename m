Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD44A239DA1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgHCDKt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHCDKt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0CC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so2916277wmd.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqr4WPc/7BrgTWw+OnpOygYehvuyz4nwHTynHJhPEa8=;
        b=CJ5oCIsNq10lgGn6PSm+ZvV7pZaampK3J/0kpSZssZb1DCbubZT79UKSf0dsX3DJki
         hEDH+Felv5ooYCSVxF+q94gbTRL4zJROdZCWeCfK5bgAjSMaoGSpkGCNdLCBgZhtGqcZ
         AGA1bPac3TM9nX/GXGsZmS1tYaBt87e2IhPt3duRoZiRGpp47safRDOms/CgCkUX0oq5
         2j2/26eq219quWhtT3u3RBeP5fLRioConNzuWwZu92ibjwickhsV3Wu8O9DQhwVbxVX7
         apZ+3cW8MGyllmfG0N74ppGPws/i0dr8BXu/rCkI2tvFUyjVZApfSNMFL+jN/7NGMj4q
         crVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqr4WPc/7BrgTWw+OnpOygYehvuyz4nwHTynHJhPEa8=;
        b=AUQuqOEycLBCFvNn5VvKTho73rCHX6QB4y8fxS9Kz+rZmDg8r7MoCj8TZTSuEjgT8E
         cmfSysusbHRU+ZWWAoh3wtVtaRTVdFpw4Rn3BxxBWRbJPpieg2KweRg5A0uo13+w6vRJ
         DvIAvzJgFc1QCRPd1YNgrV8zC9HdfCuksQJv9IjC8Edl9lOgdEW9F7eyDnDl6VS/ogSE
         EGpkVOAkhix7aW4EiD+SvCRP4v+RmVAlgmc9gpVbmZKMQkVAdydgXh6cEkmfBpjCgXHX
         g5uBSScVz7d74Q4Wu9QF1nAfav/NPXZ6Y63ctknK+GnjwAbkC3vMZ6vrcRncO1U5PLWt
         XSYA==
X-Gm-Message-State: AOAM530ssh4d0a//fSEGXyZ6FPqYVB7fmzWSq1m6aBcTbSAQgzY5MQ7C
        K1qUCEn8EjvJguLrO3Xbz008lw==
X-Google-Smtp-Source: ABdhPJx32D5PoZWFXAF5aVUqWuVNbYbC1dZWvCkjthSMVfGtZM4/UhnaUo5L9ex6wRvRVzhsPws6Vg==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr13508894wme.0.1596424247087;
        Sun, 02 Aug 2020 20:10:47 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:46 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 00/36] wcn36xx: Add support for WCN3680 802.11ac
Date:   Mon,  3 Aug 2020 04:10:56 +0100
Message-Id: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for the 802.11ac data-rates available on the WCN3680.

WCN3680:
- Has one spatial stream
- MCS9 80Mhz 400ns guard interval
- 433.3 Mbps
- RX STBC
- LDPC (host dependant)
- MU-MIMO (host dependant)
- Tx beamformee (host dependant)

Declared data-rates are around 200 Mbps
https://preview.tinyurl.com/y2w3jb2b

iw wlan0 link
Connected to 04:d4:c4:3a:fd:f4 (on wlan0)
        SSID: linaro-test_5G
        freq: 5300
        RX: 761467 bytes (4302 packets)
        TX: 2492 bytes (28 packets)
        signal: -29 dBm
        rx bitrate: 433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1
        tx bitrate: 6.0 MBit/s

        bss flags:      short-slot-time
        dtim period:    3
        beacon int:     100

Test Hardware:
20MHz channels
[ ID] Interval            Bitrate
[  5]   0.00-60.00  sec   51.6 Mbits/sec 
[  5]   0.00-60.16  sec   51.4 Mbits/sec 

40MHz channels
[  5]   0.00-60.00  sec   109 Mbits/sec
[  5]   0.00-60.15  sec   109 Mbits/sec

80MHz channels
[  5]   0.00-60.00  sec   141 Mbits/sec
[  5]   0.00-60.01  sec   141 Mbits/sec

db410c:
[ ID] Interval            Bitrate
[  5]   0.00-60.00  sec   47.9 Mbits/sec
[  5]   0.00-60.02  sec   47.7 Mbits/sec

Sony M4 Aqua - believed to contain a 3680 with 3.10 downstream prima:
20MHz channels
[ ID] Interval            Bitrate
[  5]   0.00-60.00  sec   25.5 Mbits/sec 
[  5]   0.00-60.16  sec   25.5 Mbits/sec 

40MHz channels
[  5]   0.00-60.00  sec   50 Mbits/sec
[  5]   0.00-60.15  sec   50 Mbits/sec

80MHz channels
[  5]   0.00-60.00  sec   67.8 Mbits/sec
[  5]   0.00-60.01  sec   67.8 Mbits/sec


The wcn3680 uses the same parameter passing mechanism as earlier versions
3620 and 3660 however it also supports extended VHT parameters for STA and
BSS setup.

I've taken the downstream firmware config almost as-is in terms of
parameters send over the SMD bus to the target with the caveat of switching
off power-save offload.

I do have some housekeeping patches in the middle of this series where I
functionally decompose some of the existing code, which in my opinion
needed some attention before adding any more code to it.

Lastly, I've tested on wcn3680 and wcn3620, since the extended VHT
parameters only apply to wcn3680 the code-paths for wcn3620 should be the
same for wcn3660.

Bryan O'Donoghue (36):
  wcn36xx: Add ability to identify WCN3680
  wcn36xx: Add ieee802.11 VHT flags
  wcn36xx: Add 802.11ac MCS rates
  wcn36xx: Specify ieee80211_rx_status.nss
  wcn36xx: Add 802.11ac HAL param bitfields
  wcn36xx: Add Supported rates V1 structure
  wcn36xx: Use existing pointers in wcn36xx_smd_config_bss_v1
  wcn36xx: Set feature DOT11AC for wcn3680
  wcn36xx: Add VHT fields to parameter data structures
  wcn36xx: Use V1 data structure to store supported rates
  wcn36xx: Add wcn36xx_set_default_rates_v1
  wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
  wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
  wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
  wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
  wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
  wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
  wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()
  wcn36xx: Define INIT_HAL_MSG_V1()
  wcn36xx: Convert to VHT parameter structure on wcn3680
  wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
  wcn36xx: Move wcn36xx_smd_set_sta_params() inside
    wcn36xx_smd_config_bss()
  wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
  wcn36xx: Add wcn36xx_smd_config_bss_v0
  wcn36xx: Update wcn36xx_smd_config_bss_v1() to operate internally
  wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
  wcn36xx: Remove dead code in wcn36xx_smd_config_bss()
  wcn36xx: Latch VHT specific BSS parameters to firmware
  wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
  wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
  wcn36xx: Add accessor macro HW_VALUE_PHY for PHY settings
  wcn36xx: Encode PHY mode for 80MHz channel in hw_value
  wcn36xx: Set PHY into correct mode for 80MHz channel width
  wcn36xx: Extend HAL param config list
  wcn36xx: Define wcn3680 specific firmware parameters
  wcn36xx: Add ability to download wcn3680 specific firmware parameters

 drivers/net/wireless/ath/wcn36xx/hal.h     | 214 ++++++-
 drivers/net/wireless/ath/wcn36xx/main.c    |  99 ++-
 drivers/net/wireless/ath/wcn36xx/smd.c     | 678 ++++++++++++++-------
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 110 +++-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  10 +-
 5 files changed, 861 insertions(+), 250 deletions(-)

-- 
2.27.0

