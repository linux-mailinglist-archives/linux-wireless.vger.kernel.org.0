Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE56D6EA8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjDDVGb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjDDVGY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 17:06:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69274499;
        Tue,  4 Apr 2023 14:06:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fi11so12476662edb.10;
        Tue, 04 Apr 2023 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680642376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Arcx44/rPklJ1qmh7rA9Vdi3+RywvGhpDpphg6EORnM=;
        b=Ccab2NpeS8C0+MeeUtmKMI/cuZNkQkSrbAFtokffBE3dnDI5Ksc5eWKAzq22i9Q8bV
         HNyZw96y40IpwjJYmI+zFtEIHn+PsPDE9KM9Slofq/DSGEgBeZjC9tTYS9MVOOvzMrNc
         wNkjsk122taFS3rLDDeUnuCWuDe9p8ycazN4ecpoDCE2nhXrembzSS6FAy/J5QAbJjIZ
         /dHbqid1FhtRQuePalzNKCnTZ6B+OTf5TP2O9jFzuxOQbRuS4mSSNiyhYtFZXJhKFFnk
         jCZ6+i8BWQ7hw6gf8EfJ66YCEPSpTMfAuMh+RHeGQ/51ahfS0i0FuHPmQde8Y7fbt0va
         7VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Arcx44/rPklJ1qmh7rA9Vdi3+RywvGhpDpphg6EORnM=;
        b=M5imcX1NiKeMJHeor+7DXru08yyNvGRZvhyEvFt22djRWLhInDRcZyDld7pgr7OBMX
         f/CdgrC9NHACoTxa1hOAKOgkTxMWOetorXNjT6G8W4dNWUAJMT2Zz/yPJZfroSK9AN/F
         5nZCkTei8y6/WQR3DA9XAwZh8N2TDa00+ZS5pk1O+FzlH1o4Akq3gTrEJeEvTJSA+sOD
         vvvQsk64XI5+NSxvaMLtmTXnmtQQ3Ltv7Kne5cKzB4j6cVZJqatUF32K0JzlQC893lh8
         Hxx1uSV6SBD5XqtayIJOVrbNr5zR5LPs/pyNUvsVG2sO0Ib4XhJnhSnG6p0eKv9eYqcM
         +iEA==
X-Gm-Message-State: AAQBX9eHSNORUYybBYNfFsJmTNbdckm7L7YuixiufjNEA7HylgrUVTc4
        SqDDnPmcKKgulvFhjoW7CSucT6rFLrjPHLa7bfg=
X-Google-Smtp-Source: AKy350ZL6yADJcNyt/Y3jhM47kWbMutlYKzJdrUWg4OjIkGTWlwLXJLSOuhPhwYlWtiL4lQew208rajvwfiUnAqyZf8=
X-Received: by 2002:a05:6402:27cd:b0:502:3e65:44f7 with SMTP id
 c13-20020a05640227cd00b005023e6544f7mr423242ede.3.1680642375917; Tue, 04 Apr
 2023 14:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr> <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
 <EEE9FD80-C106-4A9B-AA8D-5C151E540CFD@hewittfamily.org.uk> <0bb1e3b3-6823-ddb5-001b-72ee1b63779c@free.fr>
In-Reply-To: <0bb1e3b3-6823-ddb5-001b-72ee1b63779c@free.fr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 4 Apr 2023 23:06:04 +0200
Message-ID: <CAFBinCA+JOxCGzML-Mohryawrn6Vghd8Ns22=2ZfvWov43aeEg@mail.gmail.com>
Subject: Re: [Performance regression] BCM4359/9 on S905X2
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Christian Hewitt <christian@hewittfamily.org.uk>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pierre-Hugues Husson <phh@phh.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marc,

On Tue, Apr 4, 2023 at 6:09=E2=80=AFPM Marc Gonzalez <marc.w.gonzalez@free.=
fr> wrote:
[...]
> For vendor, common/arch/arm64/boot/dts/amlogic/mesong12a_sei.dtsi
>
>                 bus-width =3D <4>;
>                 cap-sd-highspeed;
>                 cap-mmc-highspeed;
>                 max-frequency =3D <100000000>;
I would start by comparing the bus mode. You can get it from
/sys/kernel/debug/mmc2/ios
On the vendor kernel it should be in /sys/kernel/debug/sdio/ios (or
similar, I'm typing this from the top of my head).
It will give you insights on the clock and timing that has been
negotiated between the host and card.

From this information you can get the maximum bus speed, e.g. from [0]
Please note that any card will add overhead for communication, so bus
speed will not be equal to wifi throughput.

> vendor DTS has the following child node:
>
>                 sdio {
>                         pinname =3D "sdio";
>                         ocr_avail =3D <0x200080>; /**VDD voltage 3.3 ~ 3.=
4 */
>                         /* max_req_size =3D <0x20000>; */ /**128KB*/
>                         max_req_size =3D <0x400>;
>                         card_type =3D <3>;
>                         /* 3:sdio device(ie:sdio-wifi),
>                          * 4:SD combo (IO+mem) card
>                          */
>                         dmode =3D "pio";
>                 };
>
> Maybe the vendor kernel uses the above information to "boost"
> the performance of the SDIO-based WiFi adapter?
PIO is also what we support upstream with the
amlogic,dram-access-quirk; (which is enabled for &sd_emmc_a).
This suggests that the pinctrl trick that Neil mentioned is not used here.

I assume that the wifi driver on the vendor kernel is the brcmdhd (out
of tree) driver, while mainline uses brcmfmac.
One idea that comes to my mind is to enable the
amlogic,dram-access-quirk; (and use pio mode on the vendor kernel) for
eMMC or SD card and then compare read/write speeds. If they are
similar-ish then the wifi performance difference is likely caused by
the wifi driver (or in the opposite case: if read/write speeds on
mainline with amlogic,dram-access-quirk; perform worse than the vendor
kernel with pio mode then it's likely that it's a meson-gx-mmc driver
limitation).

From my work on the rtw88 SDIO wifi driver I can say that the
meson-gx-mmc driver can push (TX direction) at least 120Mbit/s.
I understand that this is half of what you get with the vendor kernel
- and that this is the wrong direction (you're testing RX while I'm
testing TX).
The point that I want to get across is: I think nobody has the one
answer why wifi performance is lower (personally I'm happy with having
it work at all, performance is second).
So it'll be a process to find the reason, and I think it requires
being creative due to the large amounts of different code (MMC driver,
wifi driver, additional patches...) between mainline and the vendor
kernel.


Best regards,
Martin


[0] https://en.wikipedia.org/wiki/SD_card#Power_consumption
