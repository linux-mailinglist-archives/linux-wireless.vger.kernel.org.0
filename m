Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3D6D9F02
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjDFRmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDFRmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 13:42:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A0C10D7
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 10:41:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so40292129wrr.12
        for <linux-wireless@vger.kernel.org>; Thu, 06 Apr 2023 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680802917; x=1683394917;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Q302BlsReDDKcYXqInkiLYYq06DX+nVmdsntftMZE=;
        b=FmlX0BwxsZ0iOyOGlIWSrEA3OI5HsMhGDqdBw66vhx02ctUC2Q11FRjjR0b7VkqVjT
         7TSXqGZFua3xqdGMVAqZgVToUKXwpjxnlf31qJmkZ/+/iI3ffLAOdW0cOf5sban+KjZp
         FBIFbq+7dUL5SCyp2r5RY3OPpdjkQkhsyReepddKHCs0wFM5i1L8BghstQ19h3JGet2Q
         tnK47P/5Vbu26swFXY+izFKdhOxXJnbNnaT8Q5xrGTglZCQwD3nKJNwNhmNV+2xq8tcG
         vcIdkHCoipqYsQfWixHeZpelg3YosjBnQ4ZNEj6hyky4jOmyeZWWzFmvX6sEU7lAu67j
         Qotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802917; x=1683394917;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+Q302BlsReDDKcYXqInkiLYYq06DX+nVmdsntftMZE=;
        b=rjEUsPTTYsGw9kPXVOSVMjIaxL1IgTjE67UW25EfvTPS5RFOax7KmQ9wYeF0NR/UCl
         NYtmwEdSfHTAFSfqvQOaGHwaenhuwHbLJvMp5oqG1XBke+buKEmgJS7Bnuvj2b5Pkko7
         mA9dXnkpmx0ltf8EiWEyaWtN9cbEx/vZ+M9Xdst5ACKDNTOnRwG6K+NMEGm/iCdcEGja
         VaDrt3zePr0T3srfoUp9/PLffcoAcHMfJW0+t1E4r+B0jQtxFoTD23QXCH5ncr2g6BUF
         Wjzz8l16Kv0okr3p6YXEkVlGn1umTdM2t5jy4usieRN67XPK0GdUbNnsWP8xRNyMSmmK
         5Mig==
X-Gm-Message-State: AAQBX9fFdE/q1cyHNx7NE0wRvlLE2q3ooGrAUdDWwpO4bdV+laIf5LMo
        DGcRScJUgnUzTmwUWFIc6yvmfw==
X-Google-Smtp-Source: AKy350YCOU2x3lgiB5R6LwXHb6y9ocqLkbTM9KKBxwjxpPC9bafbuTtheAF9HhCdulsYQfedETYgeQ==
X-Received: by 2002:adf:df8b:0:b0:2c9:d91b:a6ff with SMTP id z11-20020adfdf8b000000b002c9d91ba6ffmr7222897wrl.21.1680802917189;
        Thu, 06 Apr 2023 10:41:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8569:a62a:11bd:c344? ([2a01:e0a:982:cbb0:8569:a62a:11bd:c344])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d5487000000b002e707102a02sm2255938wrv.101.2023.04.06.10.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:41:56 -0700 (PDT)
Message-ID: <b1751d90-8918-7af1-d66a-17365af808df@linaro.org>
Date:   Thu, 6 Apr 2023 19:41:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [Performance regression] BCM4359/9 on S905X2
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pierre-Hugues Husson <phh@phh.me>
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
 <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
 <EEE9FD80-C106-4A9B-AA8D-5C151E540CFD@hewittfamily.org.uk>
 <0bb1e3b3-6823-ddb5-001b-72ee1b63779c@free.fr>
 <CAFBinCA+JOxCGzML-Mohryawrn6Vghd8Ns22=2ZfvWov43aeEg@mail.gmail.com>
 <74feca6f-4177-5645-6614-bc5f3dbf0be1@free.fr>
 <F47757EE-02FA-4A0E-B3EF-54B59E7CD51C@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <F47757EE-02FA-4A0E-B3EF-54B59E7CD51C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 06/04/2023 19:07, Christian Hewitt wrote:
>> On 6 Apr 2023, at 8:35 pm, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>>
>> On 04/04/2023 23:06, Martin Blumenstingl wrote:
>>
>>> Hi Marc,
>>
>> Hello Martin :)
>>
>>> On Tue, Apr 4, 2023 at 6:09 PM Marc Gonzalez wrote:
>>>
>>>>                 bus-width = <4>;
>>>>                 cap-sd-highspeed;
>>>>                 cap-mmc-highspeed;
>>>>                 max-frequency = <100000000>;
>>>
>>> I would start by comparing the bus mode. You can get it from
>>> /sys/kernel/debug/mmc2/ios
>>> On the vendor kernel it should be in /sys/kernel/debug/sdio/ios (or
>>> similar, I'm typing this from the top of my head).
>>> It will give you insights on the clock and timing that has been
>>> negotiated between the host and card.
>>>
>>>  From this information you can get the maximum bus speed, e.g. from [0]
>>> Please note that any card will add overhead for communication, so bus
>>> speed will not be equal to wifi throughput.
>>
>> For the vendor kernel:
>>
>> /sys/kernel/debug/sdio/sdio:0001/state:0x00000001
>> /sys/kernel/debug/sdio/clock:200000000
>> /sys/kernel/debug/sdio/ios:clock:               200000000 Hz
>> /sys/kernel/debug/sdio/ios:actual clock:        199999997 Hz
>> /sys/kernel/debug/sdio/ios:vdd:         21 (3.3 ~ 3.4 V)
>> /sys/kernel/debug/sdio/ios:bus mode:    2 (push-pull)
>> /sys/kernel/debug/sdio/ios:chip select: 0 (don't care)
>> /sys/kernel/debug/sdio/ios:power mode:  1 (up)
>> /sys/kernel/debug/sdio/ios:bus width:   2 (4 bits)
>> /sys/kernel/debug/sdio/ios:timing spec: 6 (sd uhs SDR104)
>> /sys/kernel/debug/sdio/ios:signal voltage:      1 (1.80 V)
>> /sys/kernel/debug/sdio/ios:driver type: 0 (driver type B)
>>
>>
>> For mainline:
>>
>> /sys/kernel/debug/mmc2/mmc2:0001/state:0x00000001
>> /sys/kernel/debug/mmc2/err_stats:# Command Timeout Occurred:     0
>> /sys/kernel/debug/mmc2/err_stats:# Command CRC Errors Occurred:  0
>> /sys/kernel/debug/mmc2/err_stats:# Data Timeout Occurred:        0
>> /sys/kernel/debug/mmc2/err_stats:# Data CRC Errors Occurred:     0
>> /sys/kernel/debug/mmc2/err_stats:# Auto-Cmd Error Occurred:      0
>> /sys/kernel/debug/mmc2/err_stats:# ADMA Error Occurred:  0
>> /sys/kernel/debug/mmc2/err_stats:# Tuning Error Occurred:        0
>> /sys/kernel/debug/mmc2/err_stats:# CMDQ RED Errors:      0
>> /sys/kernel/debug/mmc2/err_stats:# CMDQ GCE Errors:      0
>> /sys/kernel/debug/mmc2/err_stats:# CMDQ ICCE Errors:     0
>> /sys/kernel/debug/mmc2/err_stats:# Request Timedout:     0
>> /sys/kernel/debug/mmc2/err_stats:# CMDQ Request Timedout:        0
>> /sys/kernel/debug/mmc2/err_stats:# ICE Config Errors:    0
>> /sys/kernel/debug/mmc2/err_stats:# Controller Timedout errors:   0
>> /sys/kernel/debug/mmc2/err_stats:# Unexpected IRQ errors:        0
>> /sys/kernel/debug/mmc2/err_state:0
>> /sys/kernel/debug/mmc2/clock:100000000
>> /sys/kernel/debug/mmc2/caps2:0x00040000
>> /sys/kernel/debug/mmc2/caps:0x40040105
>> /sys/kernel/debug/mmc2/ios:clock:               100000000 Hz
>> /sys/kernel/debug/mmc2/ios:actual clock:        99999999 Hz
>> /sys/kernel/debug/mmc2/ios:vdd:         21 (3.3 ~ 3.4 V)
>> /sys/kernel/debug/mmc2/ios:bus mode:    2 (push-pull)
>> /sys/kernel/debug/mmc2/ios:chip select: 0 (don't care)
>> /sys/kernel/debug/mmc2/ios:power mode:  2 (on)
>> /sys/kernel/debug/mmc2/ios:bus width:   2 (4 bits)
>> /sys/kernel/debug/mmc2/ios:timing spec: 5 (sd uhs SDR50)
>> /sys/kernel/debug/mmc2/ios:signal voltage:      1 (1.80 V)
>> /sys/kernel/debug/mmc2/ios:driver type: 0 (driver type B)
>>
>>
>> The clock is indeed running twice as fast on the vendor system.
>> And in SDR104 vs SDR50 mode.
>>
>> Adjusting mainline device tree...
>>
>>
>> /sys/kernel/debug/mmc2/mmc2:0001/state:0x00000001
>> /sys/kernel/debug/mmc2/err_stats:# Command Timeout Occurred:     0
>> /sys/kernel/debug/mmc2/err_stats:# Command CRC Errors Occurred:  0
>> /sys/kernel/debug/mmc2/err_stats:# Data Timeout Occurred:        0
>> /sys/kernel/debug/mmc2/err_stats:# Data CRC Errors Occurred:     0
>> /sys/kernel/debug/mmc2/err_stats:# Auto-Cmd Error Occurred:      0
>> /sys/kernel/debug/mmc2/err_stats:# ADMA Error Occurred:  0
>> /sys/kernel/debug/mmc2/err_stats:# Tuning Error Occurred:        0
>> /sys/kernel/debug/mmc2/err_stats:# CMDQ RED Errors:      0
>> /sys/kernel/debug/mmc2/err_stats:# CMDQ GCE Errors:      0
>> /sys/kernel/debug/mmc2/err_stats:# CMDQ ICCE Errors:     0
>> /sys/kernel/debug/mmc2/err_stats:# Request Timedout:     0
>> /sys/kernel/debug/mmc2/err_stats:# CMDQ Request Timedout:        0
>> /sys/kernel/debug/mmc2/err_stats:# ICE Config Errors:    0
>> /sys/kernel/debug/mmc2/err_stats:# Controller Timedout errors:   0
>> /sys/kernel/debug/mmc2/err_stats:# Unexpected IRQ errors:        0
>> /sys/kernel/debug/mmc2/err_state:0
>> /sys/kernel/debug/mmc2/clock:200000000
>> /sys/kernel/debug/mmc2/caps2:0x00040000
>> /sys/kernel/debug/mmc2/caps:0x40080105
>> /sys/kernel/debug/mmc2/ios:clock:               200000000 Hz
>> /sys/kernel/debug/mmc2/ios:actual clock:        199999997 Hz
>> /sys/kernel/debug/mmc2/ios:vdd:         21 (3.3 ~ 3.4 V)
>> /sys/kernel/debug/mmc2/ios:bus mode:    2 (push-pull)
>> /sys/kernel/debug/mmc2/ios:chip select: 0 (don't care)
>> /sys/kernel/debug/mmc2/ios:power mode:  2 (on)
>> /sys/kernel/debug/mmc2/ios:bus width:   2 (4 bits)
>> /sys/kernel/debug/mmc2/ios:timing spec: 6 (sd uhs SDR104)
>> /sys/kernel/debug/mmc2/ios:signal voltage:      1 (1.80 V)
>> /sys/kernel/debug/mmc2/ios:driver type: 0 (driver type B)
>>
>>
>> # curl -o /dev/null http://192.168.1.254:8095/fixed/1G
>>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>>                                  Dload  Upload   Total   Spent    Left  Speed
>> 100 1024M  100 1024M    0     0  9747k      0  0:01:47  0:01:47 --:--:-- 9544k
>>
>> With this new setting, WiFi throughput increases 20%
>> (from 60 Mbps to 75 Mbps).
>>
>> (Uggg, I've been using 10^9 for the amount transferred,
>> but it looks to be 2^30 actually. Absolute speeds are
>> actually 7% higher, but doesn't change the conclusion)
>>
>> I also noticed that I reported 11 MB/s (88 Mbps) at the beginning
>> of this thread. This would point to a performance regression caused
>> by my defconfig & device tree changes :(
>>
>>
>>>> vendor DTS has the following child node:
>>>>
>>>>                 sdio {
>>>>                         pinname = "sdio";
>>>>                         ocr_avail = <0x200080>; /**VDD voltage 3.3 ~ 3.4 */
>>>>                         /* max_req_size = <0x20000>; */ /**128KB*/
>>>>                         max_req_size = <0x400>;
>>>>                         card_type = <3>;
>>>>                         /* 3:sdio device(ie:sdio-wifi),
>>>>                          * 4:SD combo (IO+mem) card
>>>>                          */
>>>>                         dmode = "pio";
>>>>                 };
>>>>
>>>> Maybe the vendor kernel uses the above information to "boost"
>>>> the performance of the SDIO-based WiFi adapter?
>>>
>>> PIO is also what we support upstream with the
>>> amlogic,dram-access-quirk; (which is enabled for &sd_emmc_a).
>>> This suggests that the pinctrl trick that Neil mentioned is not used here.
>>>
>>> I assume that the wifi driver on the vendor kernel is the brcmdhd (out
>>> of tree) driver, while mainline uses brcmfmac.
>>
>> Correct.
>> hardware/wifi/broadcom/drivers/ap6xxx/bcmdhd.100.10.545.x
>> vs
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac
>>
>>> One idea that comes to my mind is to enable the
>>> amlogic,dram-access-quirk; (and use pio mode on the vendor kernel) for
>>> eMMC or SD card and then compare read/write speeds. If they are
>>> similar-ish then the wifi performance difference is likely caused by
>>> the wifi driver (or in the opposite case: if read/write speeds on
>>> mainline with amlogic,dram-access-quirk; perform worse than the vendor
>>> kernel with pio mode then it's likely that it's a meson-gx-mmc driver
>>> limitation).
>>
>> Thanks for the suggestion.
>>
>> Are you aware whether someone has tried running the bcmdhd driver
>> on mainline?
> 
> https://gitlab.baylibre.com/baylibre/amlogic/atv/linux/-/commits/narmstrong/v5.1/aml/integ-5.1-bcmdhd
> 
> IIRC not long after this ^ support for BCM4359 was added to brcmfmac so
> using bcmdhd wasn’t pursued. Neil?

BCMDHD is used in the Yukawa Android kernel, e.g in 6.1:
https://android.googlesource.com/kernel/hikey-linaro/+log/refs/heads/android-amlogic-bmeson-6.1/drivers/net/wireless/bcmdhd

and FWs:
https://android.googlesource.com/device/amlogic/yukawa/+/refs/heads/master/binaries/bt-wifi-firmware/

Neil
> 
> Christian
> 
>> Thanks for the test suggestion.
>>
>>>  From my work on the rtw88 SDIO wifi driver I can say that the
>>> meson-gx-mmc driver can push (TX direction) at least 120Mbit/s.
>>> I understand that this is half of what you get with the vendor kernel
>>> - and that this is the wrong direction (you're testing RX while I'm
>>> testing TX).
>>> The point that I want to get across is: I think nobody has the one
>>> answer why wifi performance is lower (personally I'm happy with having
>>> it work at all, performance is second).
>>> So it'll be a process to find the reason, and I think it requires
>>> being creative due to the large amounts of different code (MMC driver,
>>> wifi driver, additional patches...) between mainline and the vendor
>>> kernel.
>>
>> I really appreciate you sharing this insight.
>>
>> Regards.
>>
> 

