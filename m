Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445B3397618
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhFAPKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhFAPKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81762C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso1808938wmi.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6v5hmPFXF8wngdyeo/8RlTMCO4mQ4VNEz1ekaLeEfvQ=;
        b=dqIHnhYCO5nHLzg6IhLqg8quw0n/N256SwY+eGbsvn3lGsjVUdqAJlt5nkiP+aHLAC
         +2VD4DmjiSyoMih/lkfzsfeTzbmWmBM/cha7a0IapY2gzDE2K6qnUr2XJw635aNxffUF
         NONp0ke2I3ZWz6z5rW1XxDMuwB8dT2QxOel5DUXwCGiZ/Qyj88cnvCzlX0a6Tw8zeGoZ
         yKR+D/znq3IGw4B+AZxDFxx7JuIEYoawnpUpN6Ll1xxUTvTI903eJpTxs7xszBrAqM5g
         OIWxsN/fgJD2POcgGboMoiKO1PtXWtLxv1qa3SPI01bhi/holJNXwwAjJIx5BPjtkhEg
         DAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6v5hmPFXF8wngdyeo/8RlTMCO4mQ4VNEz1ekaLeEfvQ=;
        b=DshBGNIOQs52TgacIgoYLdjZHUC50lDpgWkJ6m774dArNJD1F+jzva2OXcXs0KRBKj
         REWNQ1bw9Ilk9wMAUAlWrtL6HVy/8Xn5nHdu1gzeDbO2UuAQ4mJnAhvgl1xxt0b6xOOq
         nZMbr1Q2MbjyfjEDFv7V8uxQV6MwVGtEc32OmZs41Wk/bpQPBNXxM4TAbAUhajZsRO8Y
         SNS5Z8MLTrTaX2lVzmDMqlR9sOGFFuryTcAChVDSmu2rvEr6omtjz2Pa4wp0nZd/9E10
         sD+ctim2Z4qbNjd7rzM7isW/oooGpEANr8zX68UFW5s3OeWzeKbp+bBPOHlIrqWlPI1Q
         PypA==
X-Gm-Message-State: AOAM5332GFFZ5BzRpHbO3358MW8ENQoKRLqAjq+dQDDnboqrHTj+T9ND
        7OCxt7tdDKiQAwmKRyFyF4AU7EvxYqA8qKZ/
X-Google-Smtp-Source: ABdhPJzUKSuyA5DcltJQEm7ThRMivx7bs1UfMYGNz4+sHKpk0wJ9IARMASCxIa1rXpSioedG23L8rQ==
X-Received: by 2002:a7b:c114:: with SMTP id w20mr382635wmi.45.1622560098120;
        Tue, 01 Jun 2021 08:08:18 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:17 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 00/12] wcn36xx: Enable downstream consistent Wake on Lan
Date:   Tue,  1 Jun 2021 16:09:49 +0100
Message-Id: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V5:
- Fixes a git rebase/squash error. A mutex_unlock for patch #2 was contained in
  patch #3 - Loic

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

