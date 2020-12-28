Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62BE2E67B0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633509AbgL1Q2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgL1Q2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76EC0613D6
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 190so10721910wmz.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gECcxq2qw+zXmYQFUDiMPYjiAGwU+p9TRbbMFSRba1E=;
        b=vtxSLFXeaHiF+QAOu2TK/wOA3w6ZBJiMrCLOkYIheNFvQvUWhdpzJdN+dkJycymzvm
         11suo+VXOmEqxJn8UiSf6Fzx3KdZjwCZ/wpmaNwdi89y2WhXt7TESZAc2dVckRL1cLuN
         iQVnfwp9p00L7q1n6qSmYkD0WzxAmRLhsREzJD/cPgx7839UAw4qSuEmPTog0p5Pe4a7
         t/eC4wz4syf3NvX3sKPWjhvIHgxRvZXRO3eoYCbyggp+RbFXeRZ9NhKC2m11tjO1V1ox
         /D+j3uLPRnziFl6T3CRaSajtSuoO7jbaASy60h0kVRlDJ08/Kf3AtJXOTpnBSShZ07z8
         0DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gECcxq2qw+zXmYQFUDiMPYjiAGwU+p9TRbbMFSRba1E=;
        b=nXqDIr13jCaKhb7bVhjmB+nESpt/izulTpwM/SVKDX4kl8WtVtuL1bY1dBFYEPo43l
         VKO5YX5bTUTPS1DAZeETW9N9kMOlFMfQ9jKSSPHks9YM2BSMJQUN88g8HFEk/KOPh/Go
         l0FkPIeyfrPSF954fWmq5tyvD6qc67kC4MC9wWvdB58/MlCPdaBzluGGUZZqcqQFGl2Z
         J4RLVb1GuE6dkgj/cbpDuECPq3DlkQuEUr1F3wZM3tPg43W46caIgkt5+ZvWBznkqFB/
         /9vK63vos2ayNYO+kg49OdJvQ8fit2NOv9Dus/J/HgeV8GNhaVvajZNMi6Vr5Bgnv8GS
         GWMA==
X-Gm-Message-State: AOAM531cuWQrhkxUA8bgIoBijOBbclfzkuvZm+ZFKtq2PxW4kM4Ovu/p
        bPkPGYuMjqJ7HoSIuYLpSG91fA==
X-Google-Smtp-Source: ABdhPJxTIfo26rgnWPxAwDEm6OGfKK1lvq6VEPqI9wzL7VBRzTKNgpNdETe0KvxeeOH8rmQVOh0EmA==
X-Received: by 2002:a1c:3d55:: with SMTP id k82mr20770616wma.57.1609172849971;
        Mon, 28 Dec 2020 08:27:29 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:29 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 00/13] wcn36xx: Enable downstream consistent Wake on Lan
Date:   Mon, 28 Dec 2020 16:28:26 +0000
Message-Id: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

Bryan O'Donoghue (13):
  wcn36xx: Return result of set_power_params in suspend
  wcn36xx: Run suspend for the first ieee80211_vif
  wcn36xx: Add ipv4 ARP offload support in suspend
  wcn36xx: Do not flush indication queue on suspend/resume
  wcn36xx: Add ipv6 address tracking
  wcn36xx: Add ipv6 namespace offload in suspend
  wcn36xx: Flag WIPHY_WOWLAN_MAGIC_PKT
  wcn36xx: Add set_rekey_data callback
  wcn36xx: Add GTK offload to WoWLAN path
  wcn36xx: Add GTK offload info to WoWLAN resume
  wcn36xx: Do not suspend if scan in progress
  wcn36xx: Add Host suspend indication support
  wcn36xx: Add host resume request support

 drivers/net/wireless/ath/wcn36xx/hal.h     |  20 +-
 drivers/net/wireless/ath/wcn36xx/main.c    | 123 +++++++++-
 drivers/net/wireless/ath/wcn36xx/smd.c     | 271 +++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h     |  19 ++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  15 ++
 5 files changed, 434 insertions(+), 14 deletions(-)

-- 
2.29.2

