Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C421275597B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 04:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGQCYk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jul 2023 22:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQCYj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jul 2023 22:24:39 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048081A7
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 19:24:37 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3463de183b0so24334515ab.2
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 19:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malmoset.com; s=google; t=1689560677; x=1692152677;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qslcQzeesPB9u81JzSVOnTyjd17bWt9VQWbycL8pWk=;
        b=DewCGJhGe/FcZNvdufdh5l1LVoo+8eV2o+3cXoYg9sF4wm7hUSlpFfagGmJ9rUeUkC
         LQ/E4MvYNhr9HniOWgGFTuEVdy2PvUkWrmekE3+CxgNOTO7T+9ftA6nfL7g7hZ8tWD27
         tpsnBWYHVDp0pQrHJW8bzrgq+JGys4C933fK5P9cNWzf9iol1REL8WONSgEch/g3GX4v
         oar5+uMTePnL9q/gKkDv+ydZY+WqKiI9hkPLZdqeXgs8GuJ3u6Efi6sjvvIqEKvceHRC
         flOvhjjdim2GsAY5F9qiEtVZwmncuKqUH3ZoueRMeXaQOZ/4Hz015LK57dmEcfM9M0m6
         EQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689560677; x=1692152677;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qslcQzeesPB9u81JzSVOnTyjd17bWt9VQWbycL8pWk=;
        b=YxmjZ+jD2ZuwbonV0EZWd0QUG4uK7Kd6LzKBntW84MVUajL4kWA41xmbOfqL+CIFW1
         jJ/hAIKfIXsnBHZpoV6ahDTw4FGQo5pIg04P5MqdA6yas3rsmcp6gSCaRMLg8WnRmXhS
         l6VQ34UXhezBVXOWGe2GaEpMjPatb0raVVKPB1D/xKQC158amQW+kZMF34iscsdJno5S
         6CT6y3vsDekEEdWCBwkuPkf9k7NboIzTN0VIb4ml3l6VHSzxzQY4qprrpQRG+2NLL05+
         vJQZN+ehJPRBrNroVoj4AuWoh0/5iqUyX989Z8afQ5X+hYvOWX249iixzw8ihWMw5M41
         ClgA==
X-Gm-Message-State: ABy/qLaavRebq3QhCasL38bWK2CogM9rIewPYG41ncyvEypd9+yfx6b4
        ZO+JjRhx6K2N1PSdz3GjPfViMvHzkA4qN7098Xi3zg==
X-Google-Smtp-Source: APBJJlGj9HL4WS6bhLJ7m9aVTuOADjR3xEr/U1bQtmXfFq7rZT0QR5AoBYt4AhyuYhTRxsAU7TqP/A==
X-Received: by 2002:a05:6e02:78c:b0:346:11d8:b862 with SMTP id q12-20020a056e02078c00b0034611d8b862mr10983551ils.9.1689560676906;
        Sun, 16 Jul 2023 19:24:36 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:ac4f:9900:5d50:c8a6:21a4:f38a])
        by smtp.gmail.com with ESMTPSA id y14-20020a02a38e000000b0042b6a760c31sm4318233jak.28.2023.07.16.19.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 19:24:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Sean Mollet <sean@malmoset.com>
Mime-Version: 1.0 (1.0)
Subject: [RFC] RTW88 firmware download issues - improvement, but not perfect
Date:   Sun, 16 Jul 2023 21:24:25 -0500
Message-Id: <ACAD9039-DD62-477E-BBCF-B8053822E042@malmoset.com>
References: <feadf58594b14c67bcf981dde6a60077@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
In-Reply-To: <feadf58594b14c67bcf981dde6a60077@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: iPhone Mail (20D47)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Jul 16, 2023, at 9:05 PM, Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
> =EF=BB=BF
>=20
>> -----Original Message-----
>> From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
>> Sent: Monday, July 17, 2023 2:02 AM
>> To: Sean Mollet <sean@malmoset.com>; linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH] RTW88 firmware download issues - improvement, but no=
t perfect
>>=20
>>=20
>> Patches for the rtlwifi, rtw88, and rtw89 drivers should be addressed to P=
ing-Ke
>> Shih <pkshih@realtek.com>. Any patch for a driver in drivers/net/wireless=
/...
>> should be sent to Kalle Valo <kvalo@kernel.org>. Cc linux-wireless.
>=20
> I subscribe this mailing list and treat rtlwifi/rtw88/rtw89 with special f=
ilter, so
> I think I don't miss this mail. :-)
>=20
>>=20
>> The subject line should be "wifi: rtw88: ......"
>=20
> I think this should be "RFC" instead of "PATCH" as subject.=20

Done.

>>> @@ -794,15 +794,15 @@ static int __rtw_download_firmware(struct rtw_dev *=
rtwdev,
>>>=20
>>>         wlan_cpu_enable(rtwdev, true);
>>>=20
>>> -       if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
>>> -               ret =3D -EBUSY;
>>> -               goto dlfw_fail;
>>> -       }
>>> -
>>>         ret =3D download_firmware_validate(rtwdev);
>>>         if (ret)
>>>                 goto dlfw_fail;
>>>=20
>>> +       if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
>>> +               ret =3D -EBUSY;
>>> +               goto dlfw_fail;
>>> +       }
>>> +
>=20
> This looks reason to restore 0x38 after validating firmware. Do you have a=
 result=20
> how this change can improve?=20
>=20

Using a Pi 4 CM as host, this reduces failures from 1 in 5 to 1 in 20.

I don=E2=80=99t know why, but it makes a measurable difference.

>>>         /* reset desc and index */
>>>         rtw_hci_setup(rtwdev);
>>>=20
>>> diff --git a/util.c b/util.c
>>> index ff3c269..fbd6599 100644
>>> --- a/util.c
>>> +++ b/util.c
>>> @@ -10,11 +10,11 @@ bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr=
, u32 mask, u32 target)
>>>  {
>>>         u32 cnt;
>>>=20
>>> -       for (cnt =3D 0; cnt < 1000; cnt++) {
>>> +       for (cnt =3D 0; cnt < 5000; cnt++) {
>>>                 if (rtw_read32_mask(rtwdev, addr, mask) =3D=3D target)
>>>                         return true;
>>>=20
>>> -               udelay(10);
>>> +               udelay(50);
>=20
> I look into the latest vendor driver, it shows that cnt becomes 10,000 and=
 delay
> is 50us as your change.=20
Interesting. Is it possible that the real problem is simply not waiting long=
 enough?

Can you share some details of what the chip is doing and how long it should t=
ake?


>=20
>>=20
>> You have increased the maximum stall time from 10 msec to 250 msec. Do yo=
u
>> really need to lock up a CPU for that long? This is a place where you sho=
uld
>> document how long it actually takes, if it really is more than 10 msec. O=
n my
>> rtw8821ce card, the longest it took was 6.25 msec. The USB device will li=
kely
>> take longer, but I would be interested in your worst case.
>=20
> Maybe, we can set cnt/udelay according to 'rtwdev->hci.type', and change u=
delay()
> to fsleep() if all callers are running on thread context.=20
I like this. If we fsleep all the time, there=E2=80=99s no real cost to havi=
ng a large ucnt.=20

>=20
> Another note is that check_hw_ready() is also used by many other places.
>=20
Yes. Nearly all of those calls return right away though (I added prints to c=
heck for this.)

>> FYI, I changed
>> check_hw_ready() to read
>>=20
>>                 for (cnt =3D 0; cnt < 5000; cnt++) {
>>                         if (rtw_read32_mask(rtwdev, addr, mask) =3D=3D ta=
rget) {
>>                                 if (cnt > 50)
>>                                         pr_info("hw_ready at count %d\n",=
 cnt);
>>                         return true;
>>                 }
>>=20
>>                 udelay(50);
>=20
> This looks weird. If udelay() isn't in loop, PCIE device can run quickly a=
nd get
> a result "not ready". But, for slow IO USB/SDIO, this might be fine.=20
>=20

My average when firmware load succeeds is less than 10. I=E2=80=99ll try inc=
reasing ucnt to 10,000 tomorrow and see if perhaps some complete at more tha=
n 5000.

> Ping-Ke

Sean

>=20
