Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323E1396B8C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhFACtU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFACtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD8C061574
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z17so12600856wrq.7
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+HS7tUeKRCOuApaK6WCy3HoJTamuAgVD3+QpJW63e8=;
        b=gBa3JVfnC5h0SrqsQ/KSVrgJzlCirzK+vXA8T1Iu8zVhw2zy2YdSi1/mBT43IkSaIA
         xYwatRLPqYVjQs3GfK1XKKpy59tjGS2lnZ1AgxcJ4V752fWn9wKE04hpMNPW1udCO0hT
         t75X5M2XiWMhDvH6wOXaVa8UVJqJEyoAccsJWvfnYPTKw0SFEVfoi2FL4Vg+jn2E24pz
         olyT6O0P+1XuxsuKOdT3r3tml06YwQdE43/gZ0iqjDZioPdwFU0qRCAGMDOJQUIW4ysC
         ZfCNtQIMzC/H0z72wschD2ppMS8AR0MaSWYmMuiheNyUc7r+S6Y1nKw1xJlZ9Zo0hvV2
         LA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+HS7tUeKRCOuApaK6WCy3HoJTamuAgVD3+QpJW63e8=;
        b=dQa8NiEGSP2tGGnhjIth9nQPAMuEErPkJ182cEmjJIUHTi1vftLhbdAhHvfhgGvOr1
         z3aSlyd9p4i2VCEnpB+zXcPjdjMMvoAAxJojxWxQxkInozjZN21wkRaPDIFFPltW2HV/
         +vSpqLhgc6hAmnHup0+SEiwm/iKr+JdGwEOZ8qI4qv18H1niYvm1XBdXaCzqhR6e2M4D
         /B92CMuqMseTYyHWaM0D0wjVPGPOcPQmerZxYnDebMaAOZ6sMFwVPYa0aO0Ef89E9tK6
         aueYb2KSwfZU8f66BGwEewm5wVbi8b+PwEiJ5549BIahR1GkaCtcn9zVFpduV6FOUcSp
         9TLA==
X-Gm-Message-State: AOAM53272a7vV55aVpGrXJ4KGGef9SDKLlbhPQOjo9tv4LOjoeYuxXk5
        bz57KyVgR3uLVesC7ww71VNkdA==
X-Google-Smtp-Source: ABdhPJw8dxzIALOT4E0GX1wRHYOKFg8GSgcJ0WL/OKh4LeT6Wuws8+MiUae/Kg5yj5wrmK9LtVioZA==
X-Received: by 2002:a05:6000:144b:: with SMTP id v11mr24929658wrx.295.1622515657240;
        Mon, 31 May 2021 19:47:37 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:36 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 00/12] wcn36xx: Enable downstream consistent Wake on Lan
Date:   Tue,  1 Jun 2021 03:49:08 +0100
Message-Id: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V4:

A few functions need to be declared static which were only flagged by the
test robot when the V3 patches hit pending

- get_first_vif - Kernel test robot 
  Patch #2
  https://www.mail-archive.com/ath10k@lists.infradead.org/msg13558.html

- wcn36xx_ipv6_addr_change - Kernel test robot 
  https://www.mail-archive.com/ath10k@lists.infradead.org/msg13571.html
  Patch #5

- wcn36xx_set_rekey_data - Kernel test robot 
  Patch #7
  https://www.mail-archive.com/ath10k@lists.infradead.org/msg13559.html

Missed making this IPV6 only in the previous round

- Fixed an IPV6 optional compliation missed in V3 - Kernel test robot 
  https://www.mail-archive.com/ath10k@lists.infradead.org/msg13563.html
  Patch #6

Feedback from Ben and Loic

- Streamlines the finding of the first associated VIF - Loic Poulain
  Patch #2
  https://www.spinics.net/lists/linux-wireless/msg209208.html

- Adds Tested-by: Benjamin Li as indicated
  Patch *

I've verified this on Debian with 5.13.x and Android with 4.19.x where
4.19.x contains an appropriate out-of-tree LPM patch, to verify
suspend/resume with offloaded ARP in suspend for ipv4 and ipv6 still works.

V3:
- Ifdefs an IPV6 specific function which will not compile unless CONFIG_IPV6
  is switched on - Kernel test robot

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

commit 5336fad96e8f ("wcn36xx: Enable firmware offloaded keepalive")
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
 drivers/net/wireless/ath/wcn36xx/main.c    | 110 ++++++++-
 drivers/net/wireless/ath/wcn36xx/smd.c     | 265 +++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h     |  17 ++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  14 ++
 5 files changed, 412 insertions(+), 14 deletions(-)

-- 
2.30.1

