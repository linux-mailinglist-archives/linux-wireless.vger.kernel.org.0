Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E651C436
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfENHyX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 03:54:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39330 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfENHyX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 03:54:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so7842191plm.6
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 00:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoeIZiUsBu0HvFVG0nWmxsVv7tok+Gu9s0PWKDjGTL8=;
        b=s4KMCd86WufV+k7UDIr/QKsO148PB6wIc3uYyEVv6SDyDHmvRTCPmJKIZBRxVqDXcy
         ZH2JbLOoNQgge7AKwnEQdDZF1dKsvoANpRDTYnAALjbiIUNtRWoGIA+k2PCrcCYOG5Ok
         hv547UaPAabneOQbwHg1vIiWksGYnLVRpcfwxAvWKaFHkPIxGV9Dc1KKn4LEwiJKWt43
         kHKmzE1iQr7+swUfd6S0gR8unSrLPERwgFn1b+M30to+YxlZZPzBrMYRhWZS/gnuWRVR
         ya+wj51lkAb+ecpu+qswGe8nS257h6hoFjLxwH6tWTTtfJ1CMqXbUfx2iW1Ue1UAtsPx
         mDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoeIZiUsBu0HvFVG0nWmxsVv7tok+Gu9s0PWKDjGTL8=;
        b=pFwAXp1M94XpHfYpHDXTb+pb+uazNnDRxOue3CedcBm0vUvrUCo47yc9MuRX45pvOG
         0JVHBkstyc/EPhp9ByJ4SjzrGORxSr0pzamQyQafLVSda4Ek8IDFtVQ/0GpOD0bumA9K
         Uy1UvBmrYYLps053OMYBppTh3UV/cxQYyKKYzrSAPt4OnKHSeQIm5KQu/pqP9WsXUWyS
         Qx6tENNOmW4vsHtPlnuh2KbZAr4AvJJSLtDeeFslqtZ9xbrNYi5YIPUFy9z+w5a2m463
         i2b9g5nf0iCbO7CyOln03wTer5RbtDNzMyTyocYkZezLTJusSsXg65AhZL84VbzQgWls
         hiCQ==
X-Gm-Message-State: APjAAAVyXkiw6FJ/pN0ZheKjOzu9TYK5DsD2G2bArjwUKB4VvDUhMisr
        M4dcl0xSmCfKDFKXvrWSREXvUGU8KRGang1GVw==
X-Google-Smtp-Source: APXvYqxzCpJlbS2gf7oRgqJrlgW6DWqa1l37iAL8q5yN7y+08uJ8dLqSWCNQvJ9cNhzfaQgZnyRc6UJB5H77mfBfdTI=
X-Received: by 2002:a17:902:322:: with SMTP id 31mr23797534pld.204.1557820462418;
 Tue, 14 May 2019 00:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGJ1o_KskiCKQ8V-6U0nxWGgXXa4NWHV0EEwo41bMPSj1bbdg@mail.gmail.com>
 <CAPGJ1o9qDYPQF882cw65uysjCmUYi6kJCmL2EUa0AXbwHj59Mg@mail.gmail.com>
 <a236cf47-556d-c515-0093-82dce6e8ad8e@candelatech.com> <CAPGJ1o96QSfoFzFpSPbh_4TwSgAU-1FGhX6P5MVCmfZv_bugHw@mail.gmail.com>
 <79695018-5ac9-d7c8-a386-c6dd3f9ed474@candelatech.com> <CAPGJ1o8k4WoK1cwBBYMge8m6n-Mm5nC7G=ku29iMRrSsJ1AMQw@mail.gmail.com>
 <CAPGJ1o-i8Gy8baAf+MHcuWoF6oHuSiRYwyADCZDkYS8fmeOy8A@mail.gmail.com>
 <3ed8dd0c-47e0-16a0-082d-c60f1dabdce7@candelatech.com> <CAPGJ1o8NUXw2G8hxHkHHwVhqqOGN8atHeaWFZjm-Vhw6ZM8bBw@mail.gmail.com>
In-Reply-To: <CAPGJ1o8NUXw2G8hxHkHHwVhqqOGN8atHeaWFZjm-Vhw6ZM8bBw@mail.gmail.com>
From:   Sam Samy <to.swami1@gmail.com>
Date:   Tue, 14 May 2019 00:54:10 -0700
Message-ID: <CAPGJ1o8gomgA5JKQg818kdsACRsJOSC5SuOcyxRdJxo-80EfXg@mail.gmail.com>
Subject: Re: ath10k 5Ghz RSSI low
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

hi Ben:

  Looks like ./sys/kernel/debug/ieee80211/phy2/ath10k/cal_data is junk
for both the 5Ghz radios even though the
pre-cal-pci-0000:01:00.0.bin/pre-cal-ahb-a800000.wifi.bin is correct.

The 2Ghz cal_data seem to be correct and match the pre-cal-ahb-a000000.wifi.bin.

Openwrt seem to do the right thing in setting the countrycode.

I am clueless. Any pointers would help.

Thanks


On Mon, May 13, 2019 at 1:14 PM Sam Samy <to.swami1@gmail.com> wrote:
>
> >I think you should write to the openwrt mailing list and/or its bug tracker
> >and see if they can help.
>
> Ok. Thanks Ben. will do. Just curious. I am not able to get the reg.
> domain codes in TPC by googling. Do you know where I can get those?
> What is the reg. domains 0x20 and 0x58 value points to?
>
> Thanks
>
> On Mon, May 13, 2019 at 11:17 AM Ben Greear <greearb@candelatech.com> wrote:
> >
> > On 5/13/19 11:10 AM, Sam Samy wrote:
> > > hi Ben,
> > >
> > >    I also looked at the TPC on the stock firmware on the AP. There is a
> > > difference.
> >
> > I think you should write to the openwrt mailing list and/or its bug tracker
> > and see if they can help.
> >
> > Thanks,
> > Ben
> >
> > >
> > > Here is the snippet from stock firmware:
> > >
> > > TPC Config for channel 5765 mode 10
> > > **************************************************
> > > CTL           = 0x10   Reg. Domain           = 20
> > > Antenna Gain  =  0     Reg. Max Antenna Gain = 12
> > > Power Limit   = 63     Reg. Max Power        = 60
> > > Num tx chains =  2    Num  Supported Rates  = 109
> > > **************************************************
> > > **************** CDD  POWER TABLE ****************
> > > **************************************************
> > >
> > > Where as in openwrt it is:
> > >
> > > *************************************
> > > TPC config for channel 5765 mode 10
> > > *************************************
> > > CTL        =  0x10 Reg. Domain        = 58
> > > Antenna Gain    =  0 Reg. Max Antenna Gain    =   0
> > > Power Limit    = 60 Reg. Max Power        = 30
> > > Num tx chains    =  2 Num supported rates    = 109
> > > ********************************
> > >
> > >
> > > So looks like reg ,domain is different even though both are US.
> > > (Although I didnt set anything on stock firmware. The countrycode from
> > > iwpriv get_countrycode says its 841.)
> > >
> > > Also, the antenna gain seems different between stock and openwrt firmware..
> > >
> > >
> > > How to change the reg. domain like in stock firmware in openwrt
> > > although I set to US in the uci.
> > >
> > > root@OpenWrt:/sys# uci show | grep country
> > > uhttpd.defaults.country='ZZ'
> > > wireless.radio0.country='US'
> > > wireless.radio1.country='US'
> > > wireless.radio2.country='US'
> > > root@OpenWrt:/sys#
> > >
> > > Thanks
> > >
> > >
> > > On Mon, May 13, 2019 at 10:36 AM Sam Samy <to.swami1@gmail.com> wrote:
> > >>
> > >>> Probably it is a board-file and/or calibration data issue then.
> > >>>
> > >>> The debugfs 'ath10k/tpc_stats' file may show very low values?
> > >>
> > >> I am not sure if the values are right. Here is one of the 5Ghz radio stats:
> > >>
> > >> root@OpenWrt:/sys# cat ./kernel/debug/ieee80211/phy0/ath10k/tpc_stats
> > >>
> > >> *************************************
> > >> TPC config for channel 5320 mode 10
> > >> *************************************
> > >> CTL        =  0x10 Reg. Domain        = 58
> > >> Antenna Gain    =  0 Reg. Max Antenna Gain    =   0
> > >> Power Limit    = 46 Reg. Max Power        = 46
> > >> Num tx chains    =  2 Num supported rates    = 129
> > >> ********************************
> > >> ******************* CDD POWER TABLE ****************
> > >> ********************************
> > >> No.  Preamble Rate_code tpc_value0 tpc_value1 tpc_value2 tpc_value3
> > >>         0 CCK 0x40        0        0
> > >>         1 CCK 0x41        0        0
> > >>         2 CCK 0x42        0        0
> > >>         3 CCK 0x43        0        0
> > >>         4 OFDM 0x 0       36       34
> > >>         5 OFDM 0x 1       38       34
> > >>         6 OFDM 0x 2       38       34
> > >>         7 OFDM 0x 3       38       34
> > >>         8 OFDM 0x 4       34       34
> > >>         9 OFDM 0x 5       38       34
> > >>        10 OFDM 0x 6       38       34
> > >>        11 OFDM 0x 7       38       34
> > >>        12 HT20 0x80       38       34
> > >>        13 HT20 0x81       38       34
> > >>        14 HT20 0x82       38       34
> > >>        15 HT20 0x83       38       34
> > >>        16 HT20 0x84       38       34
> > >>        17 HT20 0x85       36       34
> > >>        18 HT20 0x86       34       34
> > >>        19 HT20 0x87       32       32
> > >>        20 HT20 0x90       38       38
> > >>        21 HT20 0x91       38       38
> > >>        22 HT20 0x92       38       38
> > >>        23 HT20 0x93       38       38
> > >>        24 HT20 0x94       38       38
> > >>        25 HT20 0x95       36       36
> > >>        26 HT20 0x96       34       34
> > >>        27 HT20 0x97       32       32
> > >>        28 HT40 0x80       37       34
> > >>        29 HT40 0x81       37       34
> > >>        30 HT40 0x82       37       34
> > >>        31 HT40 0x83       37       34
> > >>        32 HT40 0x84       37       34
> > >>        33 HT40 0x85       35       34
> > >>        34 HT40 0x86       33       33
> > >>        35 HT40 0x87       31       31
> > >>        36 HT40 0x90       37       37
> > >>        37 HT40 0x91       37       37
> > >>        38 HT40 0x92       37       37
> > >>        39 HT40 0x93       37       37
> > >>        40 HT40 0x94       37       37
> > >>        41 HT40 0x95       35       35
> > >>        42 HT40 0x96       33       33
> > >>        43 HT40 0x97       31       31
> > >>        44 VHT20 0xc0       38       34
> > >>        45 VHT20 0xc1       38       34
> > >>        46 VHT20 0xc2       38       34
> > >>        47 VHT20 0xc3       38       34
> > >>        48 VHT20 0xc4       38       34
> > >>        49 VHT20 0xc5       36       34
> > >>        50 VHT20 0xc6       34       34
> > >>        51 VHT20 0xc7       32       32
> > >>        52 VHT20 0xc8       31       31
> > >>        53 VHT20 0xc9       30       30
> > >>        54 VHT20 0xd0       38       38
> > >>        55 VHT20 0xd1       38       38
> > >>        56 VHT20 0xd2       38       38
> > >>        57 VHT20 0xd3       38       38
> > >>        58 VHT20 0xd4       38       38
> > >>        59 VHT20 0xd5       36       36
> > >>        60 VHT20 0xd6       34       34
> > >>        61 VHT20 0xd7       32       32
> > >>        62 VHT20 0xd8       31       31
> > >>        63 VHT20 0xd9       30       30
> > >>        64 VHT40 0xc0       37       34
> > >>        65 VHT40 0xc1       37       34
> > >>        66 VHT40 0xc2       37       34
> > >>        67 VHT40 0xc3       37       34
> > >>        68 VHT40 0xc4       37       34
> > >>        69 VHT40 0xc5       35       34
> > >>        70 VHT40 0xc6       33       33
> > >>        71 VHT40 0xc7       31       31
> > >>        72 VHT40 0xc8       30       30
> > >>        73 VHT40 0xc9       29       29
> > >>        74 VHT40 0xd0       37       37
> > >>        75 VHT40 0xd1       37       37
> > >>        76 VHT40 0xd2       37       37
> > >>        77 VHT40 0xd3       37       37
> > >>        78 VHT40 0xd4       37       37
> > >>        79 VHT40 0xd5       35       35
> > >>        80 VHT40 0xd6       33       33
> > >>        81 VHT40 0xd7       31       31
> > >>        82 VHT40 0xd8       30       30
> > >>        83 VHT40 0xd9       29       29
> > >>        84 VHT80 0xc0       36       34
> > >>        85 VHT80 0xc1       36       34
> > >>        86 VHT80 0xc2       36       34
> > >>        87 VHT80 0xc3       36       34
> > >>        88 VHT80 0xc4       36       34
> > >>        89 VHT80 0xc5       34       34
> > >>        90 VHT80 0xc6       32       32
> > >>        91 VHT80 0xc7       30       30
> > >>        92 VHT80 0xc8       29       29
> > >>        93 VHT80 0xc9       28       28
> > >>        94 VHT80 0xd0       36       36
> > >>        95 VHT80 0xd1       36       36
> > >>        96 VHT80 0xd2       36       36
> > >>        97 VHT80 0xd3       36       36
> > >>        98 VHT80 0xd4       36       36
> > >>        99 VHT80 0xd5       34       34
> > >>       100 VHT80 0xd6       32       32
> > >>       101 VHT80 0xd7       30       30
> > >>       102 VHT80 0xd8       29       29
> > >>       103 VHT80 0xd9       28       28
> > >>       104 HTCUP 0x40       36       36
> > >>       105 HTCUP 0x 0       36       34
> > >>       106 HTCUP 0x40       36       36
> > >>       107 HTCUP 0x 0       36       34
> > >>       108 HTCUP 0x 0       36       34
> > >>       109 HTCUP 0x7a       34       34
> > >>       110 HTCUP 0x8a       32       32
> > >>       111 HTCUP 0x a       30       30
> > >>       112 HTCUP 0xee       27       27
> > >>       113 HTCUP 0xa6       26       26
> > >>       114 HTCUP 0x90       36       36
> > >>       115 HTCUP 0x1d       36       36
> > >>       116 HTCUP 0x80       36       34
> > >>       117 HTCUP 0x41       36       36
> > >>       118 HTCUP 0xd9       36       36
> > >>       119 HTCUP 0x64       34       34
> > >>       120 HTCUP 0xf9       32       32
> > >>       121 HTCUP 0x 0       30       30
> > >>       122 HTCUP 0x 0       27       27
> > >>       123 HTCUP 0x 0       26       26
> > >>       124 HTCUP 0x64        0        0
> > >>       125 HTCUP 0x 0       37       34
> > >>       126 HTCUP 0x31        0        0
> > >>       127 HTCUP 0x 4       37       34
> > >>       128 HTCUP 0x 0       38       34
> > >> ***********************************
> > >> ********************************
> > >> ******************* STBC POWER TABLE ****************
> > >> ********************************
> > >> No.  Preamble Rate_code tpc_value0 tpc_value1 tpc_value2 tpc_value3
> > >>         0 CCK 0x40        0        0
> > >>         1 CCK 0x41        0        0
> > >>         2 CCK 0x42        0        0
> > >>         3 CCK 0x43        0        0
> > >>         4 OFDM 0x 0       36       36
> > >>         5 OFDM 0x 1       38       38
> > >>         6 OFDM 0x 2       38       38
> > >>         7 OFDM 0x 3       38       38
> > >>         8 OFDM 0x 4       34       34
> > >>         9 OFDM 0x 5       38       38
> > >>        10 OFDM 0x 6       38       38
> > >>        11 OFDM 0x 7       38       38
> > >>        12 HT20 0x80       38       38
> > >>        13 HT20 0x81       38       38
> > >>        14 HT20 0x82       38       38
> > >>        15 HT20 0x83       38       38
> > >>        16 HT20 0x84       38       38
> > >>        17 HT20 0x85       36       36
> > >>        18 HT20 0x86       34       34
> > >>        19 HT20 0x87       32       32
> > >>        20 HT20 0x90       38       38
> > >>        21 HT20 0x91       38       38
> > >>        22 HT20 0x92       38       38
> > >>        23 HT20 0x93       38       38
> > >>        24 HT20 0x94       38       38
> > >>        25 HT20 0x95       36       36
> > >>        26 HT20 0x96       34       34
> > >>        27 HT20 0x97       32       32
> > >>        28 HT40 0x80       37       37
> > >>        29 HT40 0x81       37       37
> > >>        30 HT40 0x82       37       37
> > >>        31 HT40 0x83       37       37
> > >>        32 HT40 0x84       37       37
> > >>        33 HT40 0x85       35       35
> > >>        34 HT40 0x86       33       33
> > >>        35 HT40 0x87       31       31
> > >>        36 HT40 0x90       37       37
> > >>        37 HT40 0x91       37       37
> > >>        38 HT40 0x92       37       37
> > >>        39 HT40 0x93       37       37
> > >>        40 HT40 0x94       37       37
> > >>        41 HT40 0x95       35       35
> > >>        42 HT40 0x96       33       33
> > >>        43 HT40 0x97       31       31
> > >>        44 VHT20 0xc0       38       38
> > >>        45 VHT20 0xc1       38       38
> > >>        46 VHT20 0xc2       38       38
> > >>        47 VHT20 0xc3       38       38
> > >>        48 VHT20 0xc4       38       38
> > >>        49 VHT20 0xc5       36       36
> > >>        50 VHT20 0xc6       34       34
> > >>        51 VHT20 0xc7       32       32
> > >>        52 VHT20 0xc8       31       31
> > >>        53 VHT20 0xc9       30       30
> > >>        54 VHT20 0xd0       38       38
> > >>        55 VHT20 0xd1       38       38
> > >>        56 VHT20 0xd2       38       38
> > >>        57 VHT20 0xd3       38       38
> > >>        58 VHT20 0xd4       38       38
> > >>        59 VHT20 0xd5       36       36
> > >>        60 VHT20 0xd6       34       34
> > >>        61 VHT20 0xd7       32       32
> > >>        62 VHT20 0xd8       31       31
> > >>        63 VHT20 0xd9       30       30
> > >>        64 VHT40 0xc0       37       37
> > >>        65 VHT40 0xc1       37       37
> > >>        66 VHT40 0xc2       37       37
> > >>        67 VHT40 0xc3       37       37
> > >>        68 VHT40 0xc4       37       37
> > >>        69 VHT40 0xc5       35       35
> > >>        70 VHT40 0xc6       33       33
> > >>        71 VHT40 0xc7       31       31
> > >>        72 VHT40 0xc8       30       30
> > >>        73 VHT40 0xc9       29       29
> > >>        74 VHT40 0xd0       37       37
> > >>        75 VHT40 0xd1       37       37
> > >>        76 VHT40 0xd2       37       37
> > >>        77 VHT40 0xd3       37       37
> > >>        78 VHT40 0xd4       37       37
> > >>        79 VHT40 0xd5       35       35
> > >>        80 VHT40 0xd6       33       33
> > >>        81 VHT40 0xd7       31       31
> > >>        82 VHT40 0xd8       30       30
> > >>        83 VHT40 0xd9       29       29
> > >>        84 VHT80 0xc0       36       36
> > >>        85 VHT80 0xc1       36       36
> > >>        86 VHT80 0xc2       36       36
> > >>        87 VHT80 0xc3       36       36
> > >>        88 VHT80 0xc4       36       36
> > >>        89 VHT80 0xc5       34       34
> > >>        90 VHT80 0xc6       32       32
> > >>        91 VHT80 0xc7       30       30
> > >>        92 VHT80 0xc8       29       29
> > >>        93 VHT80 0xc9       28       28
> > >>        94 VHT80 0xd0       36       36
> > >>        95 VHT80 0xd1       36       36
> > >>        96 VHT80 0xd2       36       36
> > >>        97 VHT80 0xd3       36       36
> > >>        98 VHT80 0xd4       36       36
> > >>        99 VHT80 0xd5       34       34
> > >>       100 VHT80 0xd6       32       32
> > >>       101 VHT80 0xd7       30       30
> > >>       102 VHT80 0xd8       29       29
> > >>       103 VHT80 0xd9       28       28
> > >>       104 HTCUP 0x40       36       36
> > >>       105 HTCUP 0x 0       36       36
> > >>       106 HTCUP 0x40       36       36
> > >>       107 HTCUP 0x 0       36       36
> > >>       108 HTCUP 0x 0       36       36
> > >>       109 HTCUP 0x7a       34       34
> > >>       110 HTCUP 0x8a       32       32
> > >>       111 HTCUP 0x a       30       30
> > >>       112 HTCUP 0xee       27       27
> > >>       113 HTCUP 0xa6       26       26
> > >>       114 HTCUP 0x90       36       36
> > >>       115 HTCUP 0x1d       36       36
> > >>       116 HTCUP 0x80       36       36
> > >>       117 HTCUP 0x41       36       36
> > >>       118 HTCUP 0xd9       36       36
> > >>       119 HTCUP 0x64       34       34
> > >>       120 HTCUP 0xf9       32       32
> > >>       121 HTCUP 0x 0       30       30
> > >>       122 HTCUP 0x 0       27       27
> > >>       123 HTCUP 0x 0       26       26
> > >>       124 HTCUP 0x64        0        0
> > >>       125 HTCUP 0x 0       37       37
> > >>       126 HTCUP 0x31        0        0
> > >>       127 HTCUP 0x 4       37       37
> > >>       128 HTCUP 0x 0       38       38
> > >> ***********************************
> > >> TXBF not supported
> > >> ***************************
> > >> root@OpenWrt:/sys#
> > >>
> > >>
> > >> Thanks
> > >>
> > >> On Mon, May 13, 2019 at 10:27 AM Ben Greear <greearb@candelatech.com> wrote:
> > >>>
> > >>> On 5/13/19 10:26 AM, Sam Samy wrote:
> > >>>> hi Ben,
> > >>>>
> > >>>>> Hello, what firmware are you using (ath10k-ct, or QCA?)  If using -ct firmware,
> > >>>>> please try QCA firmware and let me know if that fixes the problem.
> > >>>>>
> > >>>>     I tried both. Both have the same problem. I tried various versions
> > >>>> of the both(-ct and QCA) firmware as well. All have the same problem.
> > >>>
> > >>> Probably it is a board-file and/or calibration data issue then.
> > >>>
> > >>> The debugfs 'ath10k/tpc_stats' file may show very low values?
> > >>>
> > >>> Thanks,
> > >>> Ben
> > >>>
> > >>>>
> > >>>> Thanks
> > >>>>
> > >>>> On Mon, May 13, 2019 at 10:00 AM Ben Greear <greearb@candelatech.com> wrote:
> > >>>>>
> > >>>>> On 5/13/19 9:56 AM, Sam Samy wrote:
> > >>>>>>     Hi,
> > >>>>>>     I installed master branch openwrt onto Asus MAP-AC2200 AP. It has tri
> > >>>>>> band. Its based on IPQ4019 DK04 QCA reference platform. 2 radios
> > >>>>>> (2Ghz/5Ghz) on AHB bus and one 5GHZ on PCIe bus. Its generally working
> > >>>>>> fine except one problem in 5Ghz. On both the 5Ghz radios the RSSI is
> > >>>>>> pretty low on any channel I put it in.  In one feet range I see -60dB
> > >>>>>> RSSI, where as the stock firmware that came with the AP gives an RSSI
> > >>>>>> of -36dB at one foot distance.The downstream transmit rates are MCS8/9
> > >>>>>> for most part. The 2Ghz is working fine. Its using the cal data from
> > >>>>>> the flash that came with the AP.
> > >>>>>>
> > >>>>>>     Can you please suggest anyway to debug this or improve the RSSI?
> > >>>>>>
> > >>>>>>     Thanks you!
> > >>>>>>
> > >>>>>
> > >>>>> Hello, what firmware are you using (ath10k-ct, or QCA?)  If using -ct firmware,
> > >>>>> please try QCA firmware and let me know if that fixes the problem.
> > >>>>>
> > >>>>> Thanks,
> > >>>>> Ben
> > >>>>>
> > >>>>> --
> > >>>>> Ben Greear <greearb@candelatech.com>
> > >>>>> Candela Technologies Inc  http://www.candelatech.com
> > >>>>>
> > >>>>
> > >>>
> > >>>
> > >>> --
> > >>> Ben Greear <greearb@candelatech.com>
> > >>> Candela Technologies Inc  http://www.candelatech.com
> > >>>
> > >
> >
> >
> > --
> > Ben Greear <greearb@candelatech.com>
> > Candela Technologies Inc  http://www.candelatech.com
> >
