Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D233B22D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhCOMIe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhCOMIJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28847C061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so5556636wrc.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grbLhZl5fjGC1I2VTNr9uHIcmthzqhsxA/dSO7dpyj8=;
        b=uMThcTZFes7j6/e6yLj3RXvlG7iolote8KNqe6kbc0xV+4lDko9JWq+EZPrI57pbZD
         rwXX+vkHo81P/ZigpXS5Tql7dc7xhqNr40LsbLFy793twdDAC4iK8enARz8dwTFs92DX
         4DunlAbfOM7owafPbS5UgjXIaQHtbnHVE3wuNugZ6AzHEQvMovqKCJ0zb6aFv11ClKXp
         jXKLV1BZvh2wCQ9AL0qbztQuUjhiUQsBYjwiL3M7IFrTuTIAU4XbM9KMEPwzCDl5v034
         JgayXWMnwdtGlpLH3GWYfzeQJqkl2OU9urbyAvHc8PYUTO29FpsRfU+t23qLklQ078KY
         IuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grbLhZl5fjGC1I2VTNr9uHIcmthzqhsxA/dSO7dpyj8=;
        b=cIuAipzsQxWVI6DP/da0V8oTHhknK2Vo/e3W2U1CCTKHD97baZ8h1v/eQqetR2IdMQ
         iCjK0FS8I7IdszYB5OICLeLuZr86zJXUleaUWqrjD/zDIsB+VwjivAp0VMXmsGroYivN
         6QB97FT2MoWiIpLqcFFEOCWHds+HQjPOqOlpZWpSSN47SEwv2NmEGIS91hVGjSeB1ClJ
         7Y9rjjwKb2AX8VjCzL5vhlV6BUBX50WHPnYfefg6Idx1Jkn3E+6YZdS0YoJjWfAx9UOa
         EpjaTMLaCb6AwyVwvZrWFGFxT9Y5EaL+t/G/dilJUHVBaUbtCBlORxSkQrBU9ZdeptEO
         3nbQ==
X-Gm-Message-State: AOAM531swIA3+C6YzB/6ZMKe16SQS61OvF4TMmy3c5WYAk/TOfqNblmq
        5KiXbXzeDMbDurHSCH9pqVckXw==
X-Google-Smtp-Source: ABdhPJxkg9cehFZpvTUYMvtgAWnFx0fZkbuADjFRqUr5GWWXUeULcjnNZ9/I8A48XsPMcJi+2DdyEA==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr26846974wrq.60.1615810087894;
        Mon, 15 Mar 2021 05:08:07 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 00/12] wcn36xx: Enable downstream consistent Wake on Lan
Date:   Mon, 15 Mar 2021 12:09:25 +0000
Message-Id: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V2:
- Drops work-around for scan in progress
  This is not required on a tip of tree kernel - Kalle
- Churn out "this patch" form commit logs - Kalle
- Adds comment about packing structures to commit log patch #8 - Kalle
- Moves enablement of magic-packet and GTK rekey to last patch
  This means that the functionality is only switched on when the full
  series has been applied - Kalle

https://www.spinics.net/lists/linux-wireless/msg206927.html

V1:
This series enables Wake on WLAN for the wcn36xx. Downstream implements two
competing methods for WoWLAN, only one of which is used in practice.

1. The downstream prima driver and firmware have a dedicated wowlan SMD
   command set, however for whatever reason, the downstream driver doesn't
   actually use that code path for suspend/resume.
   Similarly the downstream kernel will mask out the SMD interrupt when
   entering into suspend, so its clear the firmware assisted wowlan command
   is not used at all.
   In short, the code is implemented but not used.

2. The alternative version of wake on wlan implemented downstream does
   A. An RXP filter
   B. Frimware ipv4 ARP offload
   C. Frimware ipv6 namesapece offload
   D. GTK replay counter save/update on suspend/resume

This patchset replicates method #2 since it is the only method that
actually works. When replicating the functionality from downstream to
upsteam I found the RXP filter step to be redundant, so I skipped that.

Verified on Android/4.19 with qcom out-of-tree low-power patch on wcn3680.
Verified on Debian/kvalo/master on wcn3680 and wcn3620.

The Debian/upstream test doesn't include the low-power patches from qcom so
the time it takes the system to wake up when pinged is longer.

Test method:

1. Enable magic packet wakeup on target
   iw phy0 wowlan enable magic-packet
   iw phy0 wowlan show

2. Flush arp tables on host
   sudo ip -s -s neigh flush all
   sudo ip -6 -s -s neigh flush all

3. Suspend device
   echo 1 > /sys/kernel/debug/clk/debug_suspend
   echo mem > /sys/power/state ; cat /sys/kernel/debug/rpm_stats
   echo 0 > /sys/module/wcn36xx/parameters/debug_mask
   dmesg

4. Ping either ipv4 or ipv6
   ping 192.168.0.85
   ping -6 fe80::6455:44ff:fe33:2211%wlo1

In both cases using Wireshark we see the target system receive an ARP or
NS6 lookup and respond, followed by the host sending a ping or ping6 and
the target system coming out of suspend.

Similarly watching GTK keying on the AP when the device is in suspend, we
see the firmware successfully rekey and when we resume, the host picking up
the rekey material with persistence of the WiFi link during suspend/resume.

commit: 5336fad96e8f ("wcn36xx: Enable firmware offloaded keepalive")
ensures that the link is kept alive in suspend, this additional set gives
the ability to 

- Resolve ARP/NS6 lookups without waking the system
- Rekeying in suspend
- Suspending and resuming based on received datagram

https://git.linaro.org/people/bryan.odonoghue/kernel.git/log/?h=ath.master-wcn36xx-fw-offload-suspend-resume

Bryan O'Donoghue (12):
  wcn36xx: Return result of set_power_params in suspend
  wcn36xx: Run suspend for the first ieee80211_vif
  wcn36xx: Add ipv4 ARP offload support in suspend
  wcn36xx: Do not flush indication queue on suspend/resume
  wcn36xx: Add ipv6 address tracking
  wcn36xx: Add ipv6 namespace offload in suspend
  wcn36xx: Add set_rekey_data callback
  wcn36xx: Add GTK offload to WoWLAN path
  wcn36xx: Add GTK offload info to WoWLAN resume
  wcn36xx: Add Host suspend indication support
  wcn36xx: Add host resume request support
  wcn36xx: Enable WOWLAN flags

 drivers/net/wireless/ath/wcn36xx/hal.h     |  20 +-
 drivers/net/wireless/ath/wcn36xx/main.c    | 118 +++++++++-
 drivers/net/wireless/ath/wcn36xx/smd.c     | 257 +++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h     |  17 ++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  14 ++
 5 files changed, 412 insertions(+), 14 deletions(-)

-- 
2.30.1

