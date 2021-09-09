Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF037405A32
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhIIPaH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhIIPaH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 11:30:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30DCC061574
        for <linux-wireless@vger.kernel.org>; Thu,  9 Sep 2021 08:28:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x7so2066974pfa.8
        for <linux-wireless@vger.kernel.org>; Thu, 09 Sep 2021 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bF0U+bI13rUtDY4/Stus0J0Hb1iLz5vZY9CKKh1Kj5U=;
        b=X8RvLYbkI/+LmpSbLcHoE2xS9JaapFsQupbFofOrkx5UWQLGZWJYh6NcL6tJT1bKKG
         dEpm6Jl0HbRGncdXf+AWkXD221vGA8DM/rIcfG3EYvJcTtEXJgGFzQYKU95kV5bbrGkH
         XOZexRr59glv7yhGmHr0NIsUTvJQO2cGuMYAq4PhDnHD0/XnWR1l8fDxTeTSaFIw7tMD
         g0Mchqgzmll1uaiCST33r0AbIyeEfdTAklX2Gj0tuDgPFAUboiZX4L5TYVQDiY1o2j2w
         yqhK3o0osxvoWvdkFypvYmxIq0PMJGkNds8BACQniiCb6FpV6WEN+tHn7zwZNKrG6lob
         4xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bF0U+bI13rUtDY4/Stus0J0Hb1iLz5vZY9CKKh1Kj5U=;
        b=q2uHr9gRdoFxxfuRxm5qsxSyG2dyoqyWE5lrctsNxPzxGwKCPQQwR7C7eRgA2zqxYn
         RY12rYXbz4GJYMuw3tmi+RBcZrx6vGTTAKLuM2jIfIDfSh/RUbSWDjgFE9VMBHlPbvoI
         5J9QAvRRIz2p9aFOnmoMTS/3aoBMbkRT/aa1LoT54n3TE3falFBaRQU2w7ZoZ+AmxGDQ
         6k+oO7Dmtc1tIoRBXdBUA6KMkNehnza8OAerwgV/stasbxHWLFVn3J/WGmgUQ2TtRm+R
         hLmn/87ZYcvybSkSd3FL8D5xSSqoT4rULvmiPatViOawsYUaeau9D2PanjC+hPBr54qU
         Hbfw==
X-Gm-Message-State: AOAM530zix5HRxE7lYYb7McWCz5Lx34H1aIQ3eqapoe5jhaT+1QUUAEY
        BZh0SA6PXP6/0XwOmoxaOaK1jh0oqcwvNnuyytxEFg==
X-Google-Smtp-Source: ABdhPJyeeb2UL55nz+qvr32zj3zf0BpE09JIRIqBkCvz8lvYssDr55tI8EPyZRpgiOQJQx6LVBgWfz2CqvOpASNYDrs=
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr3192046pgb.431.1631201337209;
 Thu, 09 Sep 2021 08:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210909144428.2564650-1-bryan.odonoghue@linaro.org> <20210909144428.2564650-2-bryan.odonoghue@linaro.org>
In-Reply-To: <20210909144428.2564650-2-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 9 Sep 2021 17:39:16 +0200
Message-ID: <CAMZdPi9EQNp5GqOKnfZr-05Fp7CuuzM2u4vvx_2AS_0M_Fm6qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] wcn36xx: Fix Antenna Diversity Switching
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, Benjamin Li <benl@squareup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 9 Sept 2021 at 16:42, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> We have been tracking a strange bug with Antenna Diversity Switching (ADS)
> on wcn3680b for a while.
>
> ADS is configured like this:
>    A. Via a firmware configuration table baked into the NV area.
>        1. Defines if ADS is enabled.
>        2. Defines which GPIOs are connected to which antenna enable pin.
>        3. Defines which antenna/GPIO is primary and which is secondary.
>
>    B. WCN36XX_CFG_VAL(ANTENNA_DIVERSITY, N)
>       N is a bitmask of available antenna.
>
>       Setting N to 3 indicates a bitmask of enabled antenna (1 | 2).
>
>       Obviously then we can set N to 1 or N to 2 to fix to a particular
>       antenna and disable antenna diversity.
>
>    C. WCN36XX_CFG_VAL(ASD_PROBE_INTERVAL, XX)
>       XX is the number of beacons between each antenna RSSI check.
>       Setting this value to 50 means, every 50 received beacons, run the
>       ADS algorithm.
>
>    D. WCN36XX_CFG_VAL(ASD_TRIGGER_THRESHOLD, YY)
>       YY is a two's complement integer which specifies the RSSI decibel
>       threshold below which ADS will run.
>       We default to -60db here, meaning a measured RSSI <= -60db will
>       trigger an ADS probe.
>
>    E. WCN36XX_CFG_VAL(ASD_RTT_RSSI_HYST_THRESHOLD, Z)
>       Z is a hysteresis value, indicating a delta which the RSSI must
>       exceed for the antenna switch to be valid.
>
>       For example if HYST_THRESHOLD == 3 AntennaId1-RSSI == -60db and
>       AntennaId-2-RSSI == -58db then firmware will not switch antenna.
>       The threshold needs to be -57db or better to satisfy the criteria.
>
>    F. A firmware feature bit also exists ANTENNA_DIVERSITY_SELECTION.
>       This feature bit is used by the firmware to report if
>       ANTENNA_DIVERSITY_SELECTION is supported. The host is not required to
>       toggle this bit to enable or disable ADS.
>
> ADS works like this:
>
>     A. Every XX beacons the firmware switches to or remains on the primary
>        antenna.
>
>     B. The firmware then sends a Request-To-Send (RTS) packet to the AP.
>
>     C. The firmware waits for a Clear-To-Send (CTS) response from the AP.
>
>     D. The firmware then notes the received RSSI on the CTS packet.
>
>     E. The firmware then repeats steps A-D on the secondary antenna.
>
>     F. Subsequently if the RSSI on the measured antenna is better than
>        ASD_TRIGGER_THRESHOLD + the active antenna's RSSI then the
>        measured antenna becomes the active antenna.
>
>     G. If RSSI rises past ASD_TRIGGER_THRESHOLD then ADS doesn't run at
>        all even if there is a substantially better RSSI on the alternative
>        antenna.
>
> What we have been observing is that the RTS packet is being sent but the
> MAC address is a byte-swapped version of the target MAC. The ADS/RTS MAC is
> corrupted only when the link is encrypted, if the AP is open the RTS MAC is
> correct. Similarly if we configure the firmware to an RTS/CTS sequence for
> regular data - the transmitted RTS MAC is correctly formatted.
>
> Internally the wcn36xx firmware uses the indexes in the SMD commands to
> populate and extract data from specific entries in an STA lookup table. The
> AP's MAC appears a number of times in different indexes within this lookup
> table, so the MAC address extracted for the data-transmit RTS and the MAC
> address extracted for the ADS/RTS packet are not the same STA table index.
>
> Our analysis indicates the relevant firmware STA table index is
> "bssSelfStaIdx".
>
> There is an STA populate function responsible for formatting the MAC
> address of the bssSelfStaIdx including byte-swapping the MAC address.
>
> Its clear then that the required STA populate command did not run for
> bssSelfStaIdx.
>
> So taking a look at the sequence of SMD commands sent to the firmware we
> see the following downstream when moving from an unencrypted to encrypted
> BSS setup.
>
> - WLAN_HAL_CONFIG_BSS_REQ
> - WLAN_HAL_CONFIG_STA_REQ
> - WLAN_HAL_SET_STAKEY_REQ
>
> Upstream in wcn36xx we have
>
> - WLAN_HAL_CONFIG_BSS_REQ
> - WLAN_HAL_SET_STAKEY_REQ
>
> The solution then is to add the missing WLAN_HAL_CONFIG_STA_REQ between
> WLAN_HAL_CONFIG_BSS_REQ and WLAN_HAL_SET_STAKEY_REQ.
>
> No surprise WLAN_HAL_CONFIG_STA_REQ is the routine responsible for
> populating the STA lookup table in the firmware and once done the MAC sent
> by the ADS routine is in the correct byte-order.
>
> This bug is apparent with ADS but it is also the case that any other
> firmware routine that depends on the "bssSelfStaIdx" would retrieve
> malformed data on an encrypted link.
>
> Fixes: 3e977c5c523d ("wcn36xx: Define wcn3680 specific firmware parameters")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Benjamin Li <benl@squareup.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
