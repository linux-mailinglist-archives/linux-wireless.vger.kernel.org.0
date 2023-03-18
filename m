Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF436BF6D6
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Mar 2023 01:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCRARE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 20:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCRARD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 20:17:03 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE3D0E7D
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 17:17:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e194so7481013ybf.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 17:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112; t=1679098621;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uuLVqOIvOircjEHShlF7uVz70OZoTuzBg7oUs/lQOJA=;
        b=dMFsTW19VlPVOlMWbiMVcg5HsOty9u/tecsqOcHPgoK8Q0pbvFmKuvQTKa/LCZQuZn
         vsivywwhCANEv1FUxipP1Z2OXajIR/PElUFW9EDMsVzb9a2RC71NzCM6jgNqmvjflWBP
         TYiQfQB/Swo2Rc/U2b0ahT41+eVWT7Bf/Q0ew4FlxFMYDLndQnVKQ8Ywhzs1X1sfhK2/
         A878/UAbZJbxL09IwTYPDP7CmsjhKyg1ZlvWxeaWzKGSJd6osTNnCt6JTKM+mx7AHgSg
         mY/wu0YrjXptFWl6GfhxDUkqraKXq3d5bZdesuSW+G6y7bw5oMJhgnvomunce5OYewve
         /uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679098621;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuLVqOIvOircjEHShlF7uVz70OZoTuzBg7oUs/lQOJA=;
        b=NGzBPN6cp1cWFe5fLc+FUNSX96cpQoAAhYLtX4uLBwxI49JubDeguIqSRYrURjgoPG
         tr3T3mlI4Cler7S/BnTjFs/Fqe7j645yT5dOr3M9HI4Lu5FaIPWodOPzZYFCUGxqB8ou
         PC0KLc5JuQALylKHqRPwhoVDI13eshoRkTpQ/K6ugR7kRkWYsDHn1BMowPAy5EJ9trQl
         zITMYZTOLhT/lywmArJ92EXyZ58Dei4M9uiBaKUKqjagkbFnUqdoBsEqgB8v3HghSr0y
         pW1EiffglX+quZ9wWuqSEy0j6baBBme/OV3+3mzhnco5RdJZJxMbJC/p+PjqRNRRkXlW
         2OuA==
X-Gm-Message-State: AO0yUKX2epc+/5iQIG+KCao5/aleE5egpVNeWjvq6flc1vfhiu33dIYl
        YO9ulDiEidrCN8K1DUbk6wqLaWoeWyBaDXqePHI2eouwxCinbgAZ+NA=
X-Google-Smtp-Source: AK7set/exqLo4J5LFqjFRPpDfMOa+W1lXNFz1B+Twc9nrWSn7t33CrfRTjskbpGEZCnqO5qHIiFcuKQBFEuUY81noDw=
X-Received: by 2002:a05:6902:1896:b0:b17:294f:fb30 with SMTP id
 cj22-20020a056902189600b00b17294ffb30mr282492ybb.2.1679098621176; Fri, 17 Mar
 2023 17:17:01 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 17 Mar 2023 17:16:50 -0700
Message-ID: <CAJ+vNU0TuNA26F+hFwTRGc2pVvW34-7Sc7oQ9EW8V+2cVFgcag@mail.gmail.com>
Subject: ath9k legacy vs MSI interrupt issue on imx8mm soc
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     rhu@qti.qualcomm.com, ryanhsu@qti.qualcomm.com,
        rwchang@qti.qualcomm.com, aeolus@qti.qualcomm.com,
        "Valo, Kalle" <kvalo@qca.qualcomm.com>,
        ath9k-devel <ath9k-devel@qca.qualcomm.com>, linux@endlessm.com,
        rafael.j.wysocki@intel.com, andy@infradead.org,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greetings,

I'm running into an issue regarding ath9k interrupts on imx8mm SoC's.
I'm using the latest kernel source (master) but have recreated this
all the way back to 5.15.

I find on boards with an IMX8MM (ie imx8mm-venice-gw320x-0x
device-tree) ath9k will not trigger any legacy interrupts.
# dmesg | grep ath
[    2.468657] ath9k 0000:04:00.0: enabling device (0000 -> 0002)
[    2.474702] ath: phy0: WB335 2-ANT card detected
[    2.479341] ath: phy0: Set BT/WLAN RX diversity capability
[    2.493720] ath: phy0: Enable LNA combining
[    2.499099] ath: EEPROM regdomain: 0x6a
[    2.499106] ath: EEPROM indicates we should expect a direct regpair map
[    2.499114] ath: Country alpha2 being used: 00
[    2.499119] ath: Regpair used: 0x6a
[    8.167876] ath9k 0000:04:00.0 wlp4s0: renamed from wlan0
# wpa_supplicant -i wlp4s0 -c wpa_supplicant.conf -B
Successfully initialized wpa_supplicant
# [  143.368897] wlp4s0: authenticate with 04:f0:21:59:3c:f8
[  143.374230] wlp4s0: 80 MHz not supported, disabling VHT
[  143.391982] wlp4s0: send auth to 04:f0:21:59:3c:f8 (try 1/3)
[  144.831653] wlp4s0: send auth to 04:f0:21:59:3c:f8 (try 2/3)
[  145.823657] wlp4s0: send auth to 04:f0:21:59:3c:f8 (try 3/3)
[  146.815655] wlp4s0: authentication with 04:f0:21:59:3c:f8 timed out
[  147.896946] wlp4s0: authenticate with 04:f0:21:59:3c:f8
[  147.902290] wlp4s0: 80 MHz not supported, disabling VHT
....
# grep ath /proc/interrupts
205:          0          0          0          0     GICv3 157 Level     ath9k
^^^ no interrupts

I've read that some SoC miniPCIe controllers don't support legacy
interrupts so I try again adding 'ath9k.use_msi=1' to bootargs:
root@jammy-venice:~# dmesg | grep ath
[    4.314829] systemd[1]: Reached target Path Units.
[    7.707747] usbcore: registered new interface driver ath3k
[    7.792173] ath9k 0000:03:00.0: enabling device (0000 -> 0002)
[    7.792471] ath9k 0000:03:00.0: Using MSI
[    7.796661] ath: phy0: WB335 2-ANT card detected
[    7.796674] ath: phy0: Set BT/WLAN RX diversity capability
[    7.804722] ath: phy0: Enable LNA combining
[    7.805995] ath: EEPROM regdomain: 0x6a
[    7.806008] ath: EEPROM indicates we should expect a direct regpair map
[    7.806015] ath: Country alpha2 being used: 00
[    7.806019] ath: Regpair used: 0x6a
[    8.493786] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg = 0x6A0C9C8
[    8.501691] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg = 0x6A0C9C8
[    8.515139] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg = 0x6A0C9C8
[    8.632850] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg = 0x6A0C9C8
[    8.646438] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg = 0x6A0C9C8
[    8.716020] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg = 0xEA0C9C8
[    8.787447] ath: phy0: __ath9k_hw_enable_interrupts: _msi_reg = 0xEA0C9C8
...
root@jammy-venice:~# grep ath /proc/interrupts
239:          0          0          0          0   PCI-MSI 1572864
Edge      ath9k
^^^ now the driver is having trouble with MSI interrupts and the
device doesn't work

Strangely when I use the same radio and kernel on an IMX6Q board (ie
imx6q-gw54xx) (which has the same PCI MAC but different PHY than the
IMX8MM) I find that I 'must' use legacy interrupts and trying to use
MSI interrupts results in the above behavior.

Note that the boards I'm using have a PCI switch and I'm wondering if
that is causing the issue.

Additionally I can say that ath10k cards work fine on the same imx8mm
board with MSI interrupts.

It seems that Daniel may have been running into something similar back
when commit 7368160f0ab0 ("ath9k: add MSI support") was merged
[1][2][3]

Does anyone have any advice here about what can be going on?

Best Regards,

Tim
[1] https://patchwork.kernel.org/project/linux-wireless/patch/20171011101806.6295-1-rhu@qti.qualcomm.com/
[2] https://marc.info/?l=linux-pci&m=150238260826803&w=2
[3] https://marc.info/?l=linux-pci&m=150831581725596&w=2
