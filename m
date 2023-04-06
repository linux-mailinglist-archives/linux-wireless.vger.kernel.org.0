Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118FB6D9E26
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjDFRHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDFRHe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 13:07:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33F483F2;
        Thu,  6 Apr 2023 10:07:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so25905877wmq.4;
        Thu, 06 Apr 2023 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680800851; x=1683392851;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGeuGlUCg8A4GX9uIqjn0QK99ued/9iNIGJVLTOLXYg=;
        b=PcgsW3XPAXxCrpJeNcvGX3kM75Gqaoqu+Wcv7sOcTruxtjro0Vu3fRSi82R03okcVu
         djtIQDxBUNOpPwjPpPyT8qY9x1CqWjQqgeqznyoHa2Ay4UTA72U4P6D3MAXbjkMf/MXr
         pzxmaceESPvD7Cw56CT3T1feTbmYoVKJPqQE9CUQP3pvTjMZ608WsH9RHFF4yxfv5TSe
         us9ZMHQZ3jSytXPCA4fcL2XrWYCUrdFb/U/zBiN9ymgaYBc5F/r84CpBds508WyFr5rl
         UazUinD0UXt6KAtpO5XIRQa177lTT0kdWKmlbsxNcTy+P626+wV40oG4MN9L3RY/0SRX
         REMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800851; x=1683392851;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGeuGlUCg8A4GX9uIqjn0QK99ued/9iNIGJVLTOLXYg=;
        b=IqrVkZEbtM/63n8ayDJKp9r/eQlzNiYDnutRlHZRCVBC4d0wfORNznDxjS8P7iKsOo
         hQB35nxgf1PKhQJdIwBF8aJrsD3NlZ2/HGjBLK56S4qBForMDZgjK5AXB8mvbmhlHRt5
         5+2woArF1cyOk3F7lVEWpYTVve3t5dab4QXCwezhR2eJvg3T2ZOAzS1rZ0bR0mVDcSXj
         ax48mSVBUsurYZdEG5tthuXXNp3CTl4+4VLQrucrTrcmCZlhA7tSGtmbearWShoZZSIP
         npGe7j4Ghv7BA6wenPJF74dQruP6JP3QwWIX6ja5tmMuEqGFjeecWq3sg4+l8FwRkj2/
         egGQ==
X-Gm-Message-State: AAQBX9cCGDpAsrM8xPmxKULikweVNrUvPLoI9/pWaldvLeDA9LlJdV3R
        dIW0ZjA5paNa8S9CKHlOt34=
X-Google-Smtp-Source: AKy350Z/aet2WFA2Is4knhLhtKbgvC0+KGSp4aPTXFvxi9KIWMm6EHy7U0P4peyqobpetXabAXj/6g==
X-Received: by 2002:a7b:c8d7:0:b0:3ee:6161:7d98 with SMTP id f23-20020a7bc8d7000000b003ee61617d98mr5180244wml.16.1680800851128;
        Thu, 06 Apr 2023 10:07:31 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600c1d1100b003ef6988e54csm5841384wms.15.2023.04.06.10.07.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:07:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [Performance regression] BCM4359/9 on S905X2
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <74feca6f-4177-5645-6614-bc5f3dbf0be1@free.fr>
Date:   Thu, 6 Apr 2023 21:07:26 +0400
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pierre-Hugues Husson <phh@phh.me>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F47757EE-02FA-4A0E-B3EF-54B59E7CD51C@gmail.com>
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
 <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
 <EEE9FD80-C106-4A9B-AA8D-5C151E540CFD@hewittfamily.org.uk>
 <0bb1e3b3-6823-ddb5-001b-72ee1b63779c@free.fr>
 <CAFBinCA+JOxCGzML-Mohryawrn6Vghd8Ns22=2ZfvWov43aeEg@mail.gmail.com>
 <74feca6f-4177-5645-6614-bc5f3dbf0be1@free.fr>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> On 6 Apr 2023, at 8:35 pm, Marc Gonzalez <marc.w.gonzalez@free.fr> =
wrote:
>=20
> On 04/04/2023 23:06, Martin Blumenstingl wrote:
>=20
>> Hi Marc,
>=20
> Hello Martin :)
>=20
>> On Tue, Apr 4, 2023 at 6:09=E2=80=AFPM Marc Gonzalez wrote:
>>=20
>>>                bus-width =3D <4>;
>>>                cap-sd-highspeed;
>>>                cap-mmc-highspeed;
>>>                max-frequency =3D <100000000>;
>>=20
>> I would start by comparing the bus mode. You can get it from
>> /sys/kernel/debug/mmc2/ios
>> On the vendor kernel it should be in /sys/kernel/debug/sdio/ios (or
>> similar, I'm typing this from the top of my head).
>> It will give you insights on the clock and timing that has been
>> negotiated between the host and card.
>>=20
>> =46rom this information you can get the maximum bus speed, e.g. from =
[0]
>> Please note that any card will add overhead for communication, so bus
>> speed will not be equal to wifi throughput.
>=20
> For the vendor kernel:
>=20
> /sys/kernel/debug/sdio/sdio:0001/state:0x00000001
> /sys/kernel/debug/sdio/clock:200000000
> /sys/kernel/debug/sdio/ios:clock:               200000000 Hz
> /sys/kernel/debug/sdio/ios:actual clock:        199999997 Hz
> /sys/kernel/debug/sdio/ios:vdd:         21 (3.3 ~ 3.4 V)
> /sys/kernel/debug/sdio/ios:bus mode:    2 (push-pull)
> /sys/kernel/debug/sdio/ios:chip select: 0 (don't care)
> /sys/kernel/debug/sdio/ios:power mode:  1 (up)
> /sys/kernel/debug/sdio/ios:bus width:   2 (4 bits)
> /sys/kernel/debug/sdio/ios:timing spec: 6 (sd uhs SDR104)
> /sys/kernel/debug/sdio/ios:signal voltage:      1 (1.80 V)
> /sys/kernel/debug/sdio/ios:driver type: 0 (driver type B)
>=20
>=20
> For mainline:
>=20
> /sys/kernel/debug/mmc2/mmc2:0001/state:0x00000001
> /sys/kernel/debug/mmc2/err_stats:# Command Timeout Occurred:     0
> /sys/kernel/debug/mmc2/err_stats:# Command CRC Errors Occurred:  0
> /sys/kernel/debug/mmc2/err_stats:# Data Timeout Occurred:        0
> /sys/kernel/debug/mmc2/err_stats:# Data CRC Errors Occurred:     0
> /sys/kernel/debug/mmc2/err_stats:# Auto-Cmd Error Occurred:      0
> /sys/kernel/debug/mmc2/err_stats:# ADMA Error Occurred:  0
> /sys/kernel/debug/mmc2/err_stats:# Tuning Error Occurred:        0
> /sys/kernel/debug/mmc2/err_stats:# CMDQ RED Errors:      0
> /sys/kernel/debug/mmc2/err_stats:# CMDQ GCE Errors:      0
> /sys/kernel/debug/mmc2/err_stats:# CMDQ ICCE Errors:     0
> /sys/kernel/debug/mmc2/err_stats:# Request Timedout:     0
> /sys/kernel/debug/mmc2/err_stats:# CMDQ Request Timedout:        0
> /sys/kernel/debug/mmc2/err_stats:# ICE Config Errors:    0
> /sys/kernel/debug/mmc2/err_stats:# Controller Timedout errors:   0
> /sys/kernel/debug/mmc2/err_stats:# Unexpected IRQ errors:        0
> /sys/kernel/debug/mmc2/err_state:0
> /sys/kernel/debug/mmc2/clock:100000000
> /sys/kernel/debug/mmc2/caps2:0x00040000
> /sys/kernel/debug/mmc2/caps:0x40040105
> /sys/kernel/debug/mmc2/ios:clock:               100000000 Hz
> /sys/kernel/debug/mmc2/ios:actual clock:        99999999 Hz
> /sys/kernel/debug/mmc2/ios:vdd:         21 (3.3 ~ 3.4 V)
> /sys/kernel/debug/mmc2/ios:bus mode:    2 (push-pull)
> /sys/kernel/debug/mmc2/ios:chip select: 0 (don't care)
> /sys/kernel/debug/mmc2/ios:power mode:  2 (on)
> /sys/kernel/debug/mmc2/ios:bus width:   2 (4 bits)
> /sys/kernel/debug/mmc2/ios:timing spec: 5 (sd uhs SDR50)
> /sys/kernel/debug/mmc2/ios:signal voltage:      1 (1.80 V)
> /sys/kernel/debug/mmc2/ios:driver type: 0 (driver type B)
>=20
>=20
> The clock is indeed running twice as fast on the vendor system.
> And in SDR104 vs SDR50 mode.
>=20
> Adjusting mainline device tree...
>=20
>=20
> /sys/kernel/debug/mmc2/mmc2:0001/state:0x00000001
> /sys/kernel/debug/mmc2/err_stats:# Command Timeout Occurred:     0
> /sys/kernel/debug/mmc2/err_stats:# Command CRC Errors Occurred:  0
> /sys/kernel/debug/mmc2/err_stats:# Data Timeout Occurred:        0
> /sys/kernel/debug/mmc2/err_stats:# Data CRC Errors Occurred:     0
> /sys/kernel/debug/mmc2/err_stats:# Auto-Cmd Error Occurred:      0
> /sys/kernel/debug/mmc2/err_stats:# ADMA Error Occurred:  0
> /sys/kernel/debug/mmc2/err_stats:# Tuning Error Occurred:        0
> /sys/kernel/debug/mmc2/err_stats:# CMDQ RED Errors:      0
> /sys/kernel/debug/mmc2/err_stats:# CMDQ GCE Errors:      0
> /sys/kernel/debug/mmc2/err_stats:# CMDQ ICCE Errors:     0
> /sys/kernel/debug/mmc2/err_stats:# Request Timedout:     0
> /sys/kernel/debug/mmc2/err_stats:# CMDQ Request Timedout:        0
> /sys/kernel/debug/mmc2/err_stats:# ICE Config Errors:    0
> /sys/kernel/debug/mmc2/err_stats:# Controller Timedout errors:   0
> /sys/kernel/debug/mmc2/err_stats:# Unexpected IRQ errors:        0
> /sys/kernel/debug/mmc2/err_state:0
> /sys/kernel/debug/mmc2/clock:200000000
> /sys/kernel/debug/mmc2/caps2:0x00040000
> /sys/kernel/debug/mmc2/caps:0x40080105
> /sys/kernel/debug/mmc2/ios:clock:               200000000 Hz
> /sys/kernel/debug/mmc2/ios:actual clock:        199999997 Hz
> /sys/kernel/debug/mmc2/ios:vdd:         21 (3.3 ~ 3.4 V)
> /sys/kernel/debug/mmc2/ios:bus mode:    2 (push-pull)
> /sys/kernel/debug/mmc2/ios:chip select: 0 (don't care)
> /sys/kernel/debug/mmc2/ios:power mode:  2 (on)
> /sys/kernel/debug/mmc2/ios:bus width:   2 (4 bits)
> /sys/kernel/debug/mmc2/ios:timing spec: 6 (sd uhs SDR104)
> /sys/kernel/debug/mmc2/ios:signal voltage:      1 (1.80 V)
> /sys/kernel/debug/mmc2/ios:driver type: 0 (driver type B)
>=20
>=20
> # curl -o /dev/null http://192.168.1.254:8095/fixed/1G
>  % Total    % Received % Xferd  Average Speed   Time    Time     Time  =
Current
>                                 Dload  Upload   Total   Spent    Left  =
Speed
> 100 1024M  100 1024M    0     0  9747k      0  0:01:47  0:01:47 =
--:--:-- 9544k
>=20
> With this new setting, WiFi throughput increases 20%
> (from 60 Mbps to 75 Mbps).
>=20
> (Uggg, I've been using 10^9 for the amount transferred,
> but it looks to be 2^30 actually. Absolute speeds are
> actually 7% higher, but doesn't change the conclusion)
>=20
> I also noticed that I reported 11 MB/s (88 Mbps) at the beginning
> of this thread. This would point to a performance regression caused
> by my defconfig & device tree changes :(
>=20
>=20
>>> vendor DTS has the following child node:
>>>=20
>>>                sdio {
>>>                        pinname =3D "sdio";
>>>                        ocr_avail =3D <0x200080>; /**VDD voltage 3.3 =
~ 3.4 */
>>>                        /* max_req_size =3D <0x20000>; */ /**128KB*/
>>>                        max_req_size =3D <0x400>;
>>>                        card_type =3D <3>;
>>>                        /* 3:sdio device(ie:sdio-wifi),
>>>                         * 4:SD combo (IO+mem) card
>>>                         */
>>>                        dmode =3D "pio";
>>>                };
>>>=20
>>> Maybe the vendor kernel uses the above information to "boost"
>>> the performance of the SDIO-based WiFi adapter?
>>=20
>> PIO is also what we support upstream with the
>> amlogic,dram-access-quirk; (which is enabled for &sd_emmc_a).
>> This suggests that the pinctrl trick that Neil mentioned is not used =
here.
>>=20
>> I assume that the wifi driver on the vendor kernel is the brcmdhd =
(out
>> of tree) driver, while mainline uses brcmfmac.
>=20
> Correct.
> hardware/wifi/broadcom/drivers/ap6xxx/bcmdhd.100.10.545.x
> vs
> drivers/net/wireless/broadcom/brcm80211/brcmfmac
>=20
>> One idea that comes to my mind is to enable the
>> amlogic,dram-access-quirk; (and use pio mode on the vendor kernel) =
for
>> eMMC or SD card and then compare read/write speeds. If they are
>> similar-ish then the wifi performance difference is likely caused by
>> the wifi driver (or in the opposite case: if read/write speeds on
>> mainline with amlogic,dram-access-quirk; perform worse than the =
vendor
>> kernel with pio mode then it's likely that it's a meson-gx-mmc driver
>> limitation).
>=20
> Thanks for the suggestion.
>=20
> Are you aware whether someone has tried running the bcmdhd driver
> on mainline?

=
https://gitlab.baylibre.com/baylibre/amlogic/atv/linux/-/commits/narmstron=
g/v5.1/aml/integ-5.1-bcmdhd

IIRC not long after this ^ support for BCM4359 was added to brcmfmac so
using bcmdhd wasn=E2=80=99t pursued. Neil?

Christian

> Thanks for the test suggestion.
>=20
>> =46rom my work on the rtw88 SDIO wifi driver I can say that the
>> meson-gx-mmc driver can push (TX direction) at least 120Mbit/s.
>> I understand that this is half of what you get with the vendor kernel
>> - and that this is the wrong direction (you're testing RX while I'm
>> testing TX).
>> The point that I want to get across is: I think nobody has the one
>> answer why wifi performance is lower (personally I'm happy with =
having
>> it work at all, performance is second).
>> So it'll be a process to find the reason, and I think it requires
>> being creative due to the large amounts of different code (MMC =
driver,
>> wifi driver, additional patches...) between mainline and the vendor
>> kernel.
>=20
> I really appreciate you sharing this insight.
>=20
> Regards.
>=20

