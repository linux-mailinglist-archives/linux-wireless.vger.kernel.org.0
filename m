Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF1349AB0
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Mar 2021 20:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCYTxN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 15:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCYTwo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 15:52:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFD4C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 25 Mar 2021 12:52:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 32so2898354pgm.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Mar 2021 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HvmoeJBjyDmv73oJsqnu9gkG0lQ8ycm9acsOUF73cfk=;
        b=Pe+Rh8LFDcUWnYs7NkvflukD8jxTJmbpMTPCEfxo7JxP9DV6XNxXdOVxxTnjyshw5N
         JTEa5j5bukGNnsJO+CHV7GYKEVkZj7crKxFmao5ytvTfvI9MwoH9cH/Yo6OqcdgoT67e
         jkl1kRX2no2hErDSv0/o4f46RRwSF542v7Ag8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HvmoeJBjyDmv73oJsqnu9gkG0lQ8ycm9acsOUF73cfk=;
        b=WCyHpHjiUuyEQPUkQr50vPCjg9+Im11GEP2OjIgy0jJrJPYF9wAwtQGwgwwuAs5iJU
         XljoiUNv3dH2cRsG0hWk/GwdbTe5GxAEWNNuLX8IUMQVRoFIOGXzOitQZrh90OHvGO9i
         eMBkdn4bx+cgwl4y/fU71NuGD7XYDa+TCuYkvD5owPisgKJqe3zOggupWqlbmmB7BXuZ
         L2CZ1aNPjEPPbttufTDA2hlJG8VK/lhGX8Wd7PqtYL7CivgyAfccEF4E/QxAglES1Ywx
         m5dPXDpq4fQYEFyX6YF/aOJ5AwhbtV5iEQiChXI5o8nZr3AuPijBW+C0plhV5B/gkl/f
         qcLQ==
X-Gm-Message-State: AOAM5311yQp9Qmc6DRN64ttL7rm6IQHF2YpwbTMdtGxoOOaMDjdqlqWs
        9T06azfnVG9Oqeb3p2lSXFqxfw==
X-Google-Smtp-Source: ABdhPJx3HNLqHfB+vMVkU1KvGgcAZ2eKKS3kwG962VyskW9/OSmbCHPV9j+0BmMfMmBb5aj6LbHDag==
X-Received: by 2002:a17:902:9b8a:b029:e6:17bb:eff0 with SMTP id y10-20020a1709029b8ab02900e617bbeff0mr11795918plp.54.1616701964157;
        Thu, 25 Mar 2021 12:52:44 -0700 (PDT)
Received: from benl-m5lvdt.local ([2600:1700:87d0:94f:2588:1ab:8279:401e])
        by smtp.gmail.com with ESMTPSA id f19sm7122595pgl.49.2021.03.25.12.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 12:52:43 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] wcn36xx: Enable downstream consistent Wake on
 Lan
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     shawn.guo@linaro.org, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
From:   Benjamin Li <benl@squareup.com>
Message-ID: <3f28186b-d6d3-590f-2dad-b0e00faf2872@squareup.com>
Date:   Thu, 25 Mar 2021 12:52:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 3/19/21 9:15 AM, Bryan O'Donoghue wrote:
> V3:
> - Ifdefs an IPV6 specific function which will not compile unless CONFIG_IPV6
>   is swithced on - Kernel test robot
> 
> V2:
> - Drops work-around for scan in progress
>   This is not required on a tip of tree kernel - Kalle
> - Churn out "this patch" form commit logs - Kalle
> - Adds comment about packing structures to commit log patch #8 - Kalle
> - Moves enablement of magic-packet and GTK rekey to last patch
>   This means that the functionality is only switched on when the full
>   series has been applied - Kalle
> 
> https://www.spinics.net/lists/linux-wireless/msg206927.html
> 
> V1:
> This series enables Wake on WLAN for the wcn36xx. Downstream implements two
> competing methods for WoWLAN, only one of which is used in practice.
> 
> 1. The downstream prima driver and firmware have a dedicated wowlan SMD
>    command set, however for whatever reason, the downstream driver doesn't
>    actually use that code path for suspend/resume.
>    Similarly the downstream kernel will mask out the SMD interrupt when
>    entering into suspend, so its clear the firmware assisted wowlan command
>    is not used at all.
>    In short, the code is implemented but not used.
> 
> 2. The alternative version of wake on wlan implemented downstream does
>    A. An RXP filter
>    B. Frimware ipv4 ARP offload
>    C. Frimware ipv6 namesapece offload
>    D. GTK replay counter save/update on suspend/resume
> 
> This patchset replicates method #2 since it is the only method that
> actually works. When replicating the functionality from downstream to
> upsteam I found the RXP filter step to be redundant, so I skipped that.
> 
> Verified on Android/4.19 with qcom out-of-tree low-power patch on wcn3680.
> Verified on Debian/kvalo/master on wcn3680 and wcn3620.
> 
> The Debian/upstream test doesn't include the low-power patches from qcom so
> the time it takes the system to wake up when pinged is longer.
> 
> Test method:
> 
> 1. Enable magic packet wakeup on target
>    iw phy0 wowlan enable magic-packet
>    iw phy0 wowlan show
> 
> 2. Flush arp tables on host
>    sudo ip -s -s neigh flush all
>    sudo ip -6 -s -s neigh flush all
> 
> 3. Suspend device
>    echo 1 > /sys/kernel/debug/clk/debug_suspend
>    echo mem > /sys/power/state ; cat /sys/kernel/debug/rpm_stats
>    echo 0 > /sys/module/wcn36xx/parameters/debug_mask
>    dmesg
> 
> 4. Ping either ipv4 or ipv6
>    ping 192.168.0.85
>    ping -6 fe80::6455:44ff:fe33:2211%wlo1

Tested-by: Benjamin Li <benl@squareup.com>

Independently re-tested on Square Terminal with WCN3680B using these steps
on a recently rebased tree (last month).

Used the Linaro DB410c Debian image as userspace & called nmcli to enable
WoWLAN instead of iw directly.

sudo nmcli dev wifi connect <SSID> password "<password>"
sudo nmcli connection modify <SSID> connection.autoconnect yes
# (^ need to set MAC address in device tree for autoconnect at boot)
sudo nmcli connection modify <SSID> wifi.wake-on-wlan magic
sudo service network-manager restart

- arping returns the WLAN MAC address without waking up the device from
  suspend.
- ping wakes up the device from suspend (it does take ~8-16s without
  LPM patches).
- Device stayed connected after leaving device in suspend for longer than
  my network's GTK rekeying interval (1hr) and then waking from suspend.

> 
> In both cases using Wireshark we see the target system receive an ARP or
> NS6 lookup and respond, followed by the host sending a ping or ping6 and
> the target system coming out of suspend.
> 
> Similarly watching GTK keying on the AP when the device is in suspend, we
> see the firmware successfully rekey and when we resume, the host picking up
> the rekey material with persistence of the WiFi link during suspend/resume.
> 
> commit: 5336fad96e8f ("wcn36xx: Enable firmware offloaded keepalive")
> ensures that the link is kept alive in suspend, this additional set gives
> the ability to 
> 
> - Resolve ARP/NS6 lookups without waking the system
> - Rekeying in suspend
> - Suspending and resuming based on received datagram
> 
> https://git.linaro.org/people/bryan.odonoghue/kernel.git/log/?h=ath.master-wcn36xx-fw-offload-suspend-resume
> 
> Bryan O'Donoghue (12):
>   wcn36xx: Return result of set_power_params in suspend
>   wcn36xx: Run suspend for the first ieee80211_vif
>   wcn36xx: Add ipv4 ARP offload support in suspend
>   wcn36xx: Do not flush indication queue on suspend/resume
>   wcn36xx: Add ipv6 address tracking
>   wcn36xx: Add ipv6 namespace offload in suspend
>   wcn36xx: Add set_rekey_data callback
>   wcn36xx: Add GTK offload to WoWLAN path
>   wcn36xx: Add GTK offload info to WoWLAN resume
>   wcn36xx: Add Host suspend indication support
>   wcn36xx: Add host resume request support
>   wcn36xx: Enable WOWLAN flags
> 
>  drivers/net/wireless/ath/wcn36xx/hal.h     |  20 +-
>  drivers/net/wireless/ath/wcn36xx/main.c    | 118 ++++++++-
>  drivers/net/wireless/ath/wcn36xx/smd.c     | 265 +++++++++++++++++++++
>  drivers/net/wireless/ath/wcn36xx/smd.h     |  17 ++
>  drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  14 ++
>  5 files changed, 420 insertions(+), 14 deletions(-)
> 
