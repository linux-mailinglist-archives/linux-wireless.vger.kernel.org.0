Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A973EDA32
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 08:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKDH4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 02:56:00 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:34889 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfKDH4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 02:56:00 -0500
Received: by mail-yb1-f181.google.com with SMTP id i12so1423607ybg.2
        for <linux-wireless@vger.kernel.org>; Sun, 03 Nov 2019 23:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bm4agCPWgxQGKhNnWU3vNR0xaVwijXRTvggPRvZbsdw=;
        b=ZPKcjdK/r1v01Ye+2kvwzROCIz5EGyScri29a6U7v+trnBd/F60J4vt0J53UZ2ss3n
         XJvcn4VgBrqMW8ehlQO1z7hBzdWt8InO6aB7dA6ebe5v4M04ZybLW0/J2ADf5lzcg/7W
         zFCQF590JRZ1IjPnfdTfH+iOQnO/u4v8I9p5SpCl5U3osGFlEYFTCJEtqMcJeI4oT4bU
         anJZKcLOgcc3IqwMOWhcK69ZipxFBawsOon8gV64Q/ALQg6hvsbCF/HGlwukKKT3Uilm
         dKi0HKhRN/75kYTS9ocCFozDUtTbhA406cO8RtCLoZI50EuH2iBD6vxK3C5HKnwUrtNv
         dS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bm4agCPWgxQGKhNnWU3vNR0xaVwijXRTvggPRvZbsdw=;
        b=pbRbpEdh41MH6UZUf1RUL9VO6TMIk7I9Pmv4wj0dss3sW/40Xt2lTBrAZgYu+zWKVt
         8UXzGJl4ou9OtRjRa0YuQ2WefCjExsVXigx/b0cuyl8iLdzA+gs4+C/YfxQS9YbSX5Yv
         3sYH4ybiiChIpDVzrnojnOjwrbKRAyrPRUCmrc12+0F6ChqqxWHbSMESVHos9m+TVQg7
         ifuV17hmqGg+bCRvN/htm3QPBL2ScibhJ2kTHFrIrCs37QtnR0Nd9tdSaHFzzqYg9YOA
         cH3Kfqaa+Nlud3Wa/5LLuB2TinSw8JhsHaOMvyUrlLtoy6JZI7LwCf3pE+2HXcuVoW5H
         XOLw==
X-Gm-Message-State: APjAAAVkBYPBS3ndpHiYQ1AprSHWnPriC0uppA9rH+Iz/VdQiLyDW4bv
        mONifQbMoozNV20rS+Lcvs2LDiJPbTVWaaNSEuJ2EFaFa5I=
X-Google-Smtp-Source: APXvYqyMa1N+5hcGPRw45x4hRdm4ZdFXpwGLQ7ZGAoVw7OzX7Z0dztbBpBraTwZEPwQQKRLa9KG/EZ7cDNibn9uSYV4=
X-Received: by 2002:a25:ac19:: with SMTP id w25mr20816933ybi.400.1572854158592;
 Sun, 03 Nov 2019 23:55:58 -0800 (PST)
MIME-Version: 1.0
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 4 Nov 2019 13:25:47 +0530
Message-ID: <CABPxzY+tA23zrYue_VV5H749x9w1qgsw29OjQxtCVLbLjo3U4g@mail.gmail.com>
Subject: ath10_pci firmware crash in 5.4.0-rc1
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

When using the latest wireless-drivers-next, facing the below crash
often even after module re-insertion or reboot. I have also installed
the latest linux-firmware.git.
[  +3.746016] ath10k_pci 0000:03:00.0: pci irq msi oper_irq_mode 2
irq_mode 0 reset_mode 0
[  +0.271699] ath10k_pci 0000:03:00.0: qca6174 hw3.2 target 0x05030000
chip_id 0x00340aff sub 1028:0310
[  +0.000005] ath10k_pci 0000:03:00.0: kconfig debug 0 debugfs 1
tracing 1 dfs 0 testmode 1
[  +0.001449] ath10k_pci 0000:03:00.0: firmware ver
RM.4.4.1.c2-00057-QCARMSWP-1 api 6 features
wowlan,ignore-otp,no-4addr-pad,raw-mode crc32 e061250a
[  +0.064756] ath10k_pci 0000:03:00.0: board_file api 2 bmi_id N/A
crc32 20d869c3
[  +0.068893] ath10k_pci 0000:03:00.0: unsupported HTC service id: 1536
[  +0.019223] ath10k_pci 0000:03:00.0: htt-ver 3.56 wmi-op 4 htt-op 3
cal otp max-sta 32 raw 0 hwcrypto 1
[  +0.080089] ath: EEPROM regdomain: 0x6c
[  +0.000003] ath: EEPROM indicates we should expect a direct regpair map
[  +0.000003] ath: Country alpha2 being used: 00
[  +0.000002] ath: Regpair used: 0x6c
[  +0.011095] ath10k_pci 0000:03:00.0 wlp3s0: renamed from wlan2
[  +0.238960] ath10k_pci 0000:03:00.0: unsupported HTC service id: 1536
[  +3.176573] wlp3s0: authenticate with 08:02:8e:8c:9c:40
[  +0.056253] wlp3s0: send auth to 08:02:8e:8c:9c:40 (try 1/3)
[  +0.012854] wlp3s0: authenticated
[  +0.004642] wlp3s0: associate with 08:02:8e:8c:9c:40 (try 1/3)
[  +0.004570] wlp3s0: RX AssocResp from 08:02:8e:8c:9c:40 (capab=0x411
status=0 aid=2)
[  +0.003451] ath10k_pci 0000:03:00.0: firmware crashed! (guid
95eb5eb1-3589-419e-b7b9-7d556debc646)
[  +0.000022] ath10k_pci 0000:03:00.0: qca6174 hw3.2 target 0x05030000
chip_id 0x00340aff sub 1028:0310
[  +0.000007] ath10k_pci 0000:03:00.0: kconfig debug 0 debugfs 1
tracing 1 dfs 0 testmode 1
[  +0.001647] ath10k_pci 0000:03:00.0: firmware ver
RM.4.4.1.c2-00057-QCARMSWP-1 api 6 features
wowlan,ignore-otp,no-4addr-pad,raw-mode crc32 e061250a
[  +0.001230] ath10k_pci 0000:03:00.0: board_file api 2 bmi_id N/A
crc32 20d869c3
[  +0.000005] ath10k_pci 0000:03:00.0: htt-ver 3.56 wmi-op 4 htt-op 3
cal otp max-sta 32 raw 0 hwcrypto 1
[  +0.000133] ath10k_pci 0000:03:00.0: firmware register dump:
[  +0.000007] ath10k_pci 0000:03:00.0: [00]: 0x05030000 0x00000000
0x8098F1D2 0x0000004C
[  +0.000005] ath10k_pci 0000:03:00.0: [04]: 0x8098F1D2 0x0040E828
0x00455014 0x00000000
[  +0.000004] ath10k_pci 0000:03:00.0: [08]: 0x00000001 0x00000000
0x00000000 0x004126C8
[  +0.000005] ath10k_pci 0000:03:00.0: [12]: 0xDEADC0DE 0x0040E808
0x00000000 0x00000001
[  +0.000004] ath10k_pci 0000:03:00.0: [16]: 0x009EDE58 0x00000020
0x0040A054 0x0000000D
[  +0.000004] ath10k_pci 0000:03:00.0: [20]: 0x00412064 0x0040E7E8
0x00001058 0x00000000
[  +0.000005] ath10k_pci 0000:03:00.0: [24]: 0x00931000 0x00000020
0x00000001 0x00000010
[  +0.000004] ath10k_pci 0000:03:00.0: [28]: 0x80990B2E 0x0040E848
0x0044D078 0x0044E2D0
[  +0.000004] ath10k_pci 0000:03:00.0: [32]: 0x0044E306 0x00421508
0x00400000 0x00498540
[  +0.000004] ath10k_pci 0000:03:00.0: [36]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000004] ath10k_pci 0000:03:00.0: [40]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000003] ath10k_pci 0000:03:00.0: [44]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000004] ath10k_pci 0000:03:00.0: [48]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000004] ath10k_pci 0000:03:00.0: [52]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000004] ath10k_pci 0000:03:00.0: [56]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000004] ath10k_pci 0000:03:00.0: Copy Engine register dump:
[  +0.000013] ath10k_pci 0000:03:00.0: [00]: 0x00034400  11  11   3   3
[  +0.000012] ath10k_pci 0000:03:00.0: [01]: 0x00034800  30  30 107 108
[  +0.000012] ath10k_pci 0000:03:00.0: [02]: 0x00034c00   7   7  70  71
[  +0.000012] ath10k_pci 0000:03:00.0: [03]: 0x00035000  30  30  31  30
[  +0.000012] ath10k_pci 0000:03:00.0: [04]: 0x00035400   7   7  69   5
[  +0.000012] ath10k_pci 0000:03:00.0: [05]: 0x00035800   0   0  64   0
[  +0.000011] ath10k_pci 0000:03:00.0: [06]: 0x00035c00   3   3   3   3
[  +0.000012] ath10k_pci 0000:03:00.0: [07]: 0x00036000   1   1   1   1
[  +0.036834] ath10k_pci 0000:03:00.0: failed to poke peer
08:02:8e:8c:9c:40 param for ps workaround on vdev 0: -108
[  +0.050110] ath10k_pci 0000:03:00.0: device has crashed during init
[  +0.027913] ath10k_pci 0000:03:00.0: device has crashed during init
[  +0.000005] ath10k_pci 0000:03:00.0: failed to wait for target init: -70
[  +0.002371] ieee80211 phy3: Hardware restart was requested
[  +0.000046] wlp3s0: associated
[  +0.000210] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes ready
[  +0.204620] ath10k_pci 0000:03:00.0: unsupported HTC service id: 1536
[  +0.122987] ath10k_pci 0000:03:00.0: firmware crashed! (guid
0c0784c4-2b86-4453-a54f-52a51c9b70d6)
[  +0.000016] ath10k_pci 0000:03:00.0: qca6174 hw3.2 target 0x05030000
chip_id 0x00340aff sub 1028:0310
[  +0.000005] ath10k_pci 0000:03:00.0: kconfig debug 0 debugfs 1
tracing 1 dfs 0 testmode 1
[  +0.001884] ath10k_pci 0000:03:00.0: firmware ver
RM.4.4.1.c2-00057-QCARMSWP-1 api 6 features
wowlan,ignore-otp,no-4addr-pad,raw-mode crc32 e061250a
[  +0.001431] ath10k_pci 0000:03:00.0: board_file api 2 bmi_id N/A
crc32 20d869c3
[  +0.000008] ath10k_pci 0000:03:00.0: htt-ver 3.56 wmi-op 4 htt-op 3
cal otp max-sta 32 raw 0 hwcrypto 1
[  +0.000247] ath10k_pci 0000:03:00.0: firmware register dump:
[  +0.000011] ath10k_pci 0000:03:00.0: [00]: 0x05030000 0x00000000
0x8098F1D2 0x0000004C
[  +0.000024] ath10k_pci 0000:03:00.0: [04]: 0x8098F1D2 0x0040E828
0x00455014 0x00000000
[  +0.000021] ath10k_pci 0000:03:00.0: [08]: 0x00000001 0x00000000
0x00000000 0x004126C8
[  +0.000017] ath10k_pci 0000:03:00.0: [12]: 0xDEADC0DE 0x0040E808
0x00000000 0x00000001
[  +0.000012] ath10k_pci 0000:03:00.0: [16]: 0x009EDE58 0x00000020
0x0040A054 0x0000000D
[  +0.000008] ath10k_pci 0000:03:00.0: [20]: 0x00412064 0x0040E7E8
0x00001058 0x00000000
[  +0.000007] ath10k_pci 0000:03:00.0: [24]: 0x00931000 0x00000020
0x00000001 0x00000010
[  +0.000008] ath10k_pci 0000:03:00.0: [28]: 0x80990B2E 0x0040E848
0x0044D078 0x0044E2D0
[  +0.000008] ath10k_pci 0000:03:00.0: [32]: 0x0044E306 0x00421508
0x00400000 0x00498540
[  +0.000008] ath10k_pci 0000:03:00.0: [36]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000008] ath10k_pci 0000:03:00.0: [40]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000012] ath10k_pci 0000:03:00.0: [44]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000008] ath10k_pci 0000:03:00.0: [48]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000006] ath10k_pci 0000:03:00.0: [52]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000008] ath10k_pci 0000:03:00.0: [56]: 0x00000000 0x00000000
0x00000000 0x00000000
[  +0.000007] ath10k_pci 0000:03:00.0: Copy Engine register dump:
[  +0.000018] ath10k_pci 0000:03:00.0: [00]: 0x00034400  11  11   3   3
[  +0.000019] ath10k_pci 0000:03:00.0: [01]: 0x00034800  28  28  73  74
[  +0.000028] ath10k_pci 0000:03:00.0: [02]: 0x00034c00   6   6   5   6
[  +0.000028] ath10k_pci 0000:03:00.0: [03]: 0x00035000  14  14  14  14
[  +0.000016] ath10k_pci 0000:03:00.0: [04]: 0x00035400   3   3  67   3
[  +0.000016] ath10k_pci 0000:03:00.0: [05]: 0x00035800   0   0  64   0
[  +0.000017] ath10k_pci 0000:03:00.0: [06]: 0x00035c00   3   3   3   3
[  +0.000016] ath10k_pci 0000:03:00.0: [07]: 0x00036000   1   1   1   1
[  +0.000190] ath10k_pci 0000:03:00.0: failed to set 2g txpower 20: -108
[  +0.000007] ath10k_pci 0000:03:00.0: failed to setup tx power 20: -108
[  +0.000006] ath10k_pci 0000:03:00.0: failed to recalc tx power: -108
[  +0.014655] ath: EEPROM regdomain: 0x8164
[  +0.000004] ath: EEPROM indicates we should expect a country code
[  +0.000003] ath: doing EEPROM country->regdmn map search
[  +0.000002] ath: country maps to regdmn code: 0x5b
[  +0.000003] ath: Country alpha2 being used: IN
[  +0.000002] ath: Regpair used: 0x5b
[  +0.000004] ath: regdomain 0x8164 dynamically updated by country element
[  +9.986625] wlp3s0: deauthenticating from 08:02:8e:8c:9c:40 by local
choice (Reason: 3=DEAUTH_LEAVING)
[  +0.000244] ath10k_warn: 11 callbacks suppressed
[  +0.000008] ath10k_pci 0000:03:00.0: failed to delete peer
08:02:8e:8c:9c:40 for vdev 0: -108
[  +0.000223] ath10k_pci 0000:03:00.0: failed to recalculate rts/cts
prot for vdev 0: -108
[  +0.000008] ath10k_pci 0000:03:00.0: failed to set cts protection
for vdev 0: -108
[  +0.000008] ath10k_pci 0000:03:00.0: failed to set erp slot for vdev 0: -108
[  +0.000006] ath10k_pci 0000:03:00.0: failed to set preamble for vdev 0: -108
[  +0.000007] ath10k_pci 0000:03:00.0: failed to down vdev 0: -108
[  +0.000007] ath10k_pci 0000:03:00.0: failed to submit vdev param
txbf 0x0: -108
[  +0.000005] ath10k_pci 0000:03:00.0: failed to recalc txbf for vdev 0: -108
[  +0.000011] ath10k_pci 0000:03:00.0: failed to set vdev wmm params
on vdev 0: -108
[  +0.000005] ath10k_pci 0000:03:00.0: failed to set vdev wmm params
on vdev 0: -108
[  +5.103322] ath10k_warn: 9 callbacks suppressed
[  +0.000009] ath10k_pci 0000:03:00.0: failed to start hw scan: -108




-- 
Thanks,
Regards,
Chaitanya T K.
