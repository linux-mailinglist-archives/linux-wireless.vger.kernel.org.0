Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547F4756C4B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 20:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGQSj5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGQSjy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 14:39:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278E6E5
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 11:39:51 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3465bd756afso31284065ab.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jul 2023 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malmoset.com; s=google; t=1689619190; x=1692211190;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+eVEGdokKQ4lR7Af2rfhLpiKn6z9rGJ2bDBGVVtIwA=;
        b=1tz4Bft6VUQ7K79SgiOt+VJIrvRK3Ef7VfZfD9F+NaYB4AyKcLu/N3y3s7I1T0VX1m
         XQ0q16373ayE/w/60NjZM405kNsE8kp2f5zNHU/sg8SRtwfK6kyS/Zo8B+6CiA9ajli4
         sE6wTXsT/Hg2O8NzrbcFzAnpQ9+2oN5MeQCdXcDpmphdmgFvOVbORjaoucF5KHntC0Ow
         ZczKxLb1r86gprNzLHmfSmGhVLxM2CS2dscBs7rpp2MXpLVesY4vsSdP9cip7TwapQvs
         jfwcTs0Q2Olxhe0tisscmdzPXWxGQkvk8W8mcE27pc8gBuLIdNI9nrPlBuA6TEeK5Sax
         LWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619190; x=1692211190;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+eVEGdokKQ4lR7Af2rfhLpiKn6z9rGJ2bDBGVVtIwA=;
        b=LdewTQjzWFjAxTpBlTeeTGN+Hh7tE0DrqjpuWPC/bTvcQ3MwLW+vXT5pvStYLS/eA3
         ItH6klgyFlI/MmVofJ/ACWqLjCJbkq4YGw+bW9dPfQpsviU6OwXNwtONnG3uJYdy/WcW
         m8FdrvBRLwIr15oFCciC1vv23q1ZrwTcq2XWZ223QookuIUJGY4r59KV7V6rCJzqSVU6
         lL6G7uYIUEXIbhYMO8nnCQjC8zJwINGKGsYxa5IypR2PyE9NTDHOKqAeiJ/CjaYV4rGR
         FCjWFkn3rPZLkUQEyQ9tsHkohqKwcrnd2wAz2jylhc6lq1Mj+PSHPa9S6n4G3kaaINLI
         v0Ew==
X-Gm-Message-State: ABy/qLYp4xrFK90h0tCYqM7swva/0OWTRUJMV5j/XT3AxRjioJW2G5lz
        8mjcmx8Sz2N3WdVXICAvPi+ijOEld9ZALXXXa52FPQ==
X-Google-Smtp-Source: APBJJlF/MxgGrH9lsWKVILCaF99L2RN+swJ8tfLS3lT8etPT+OTNLrSO7jW8bVxpqN8qxmxgNPM+MQ==
X-Received: by 2002:a05:6e02:12e4:b0:348:8146:ef2a with SMTP id l4-20020a056e0212e400b003488146ef2amr708206iln.0.1689619190515;
        Mon, 17 Jul 2023 11:39:50 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:ac77:5802:dd29:b5d9:1cd3:3ab8])
        by smtp.gmail.com with ESMTPSA id p2-20020a056e0206c200b003339733e374sm108232ils.86.2023.07.17.11.39.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2023 11:39:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [RFC] RTW88 firmware download issues - improvement, but not
 perfect
From:   Sean Mollet <sean@malmoset.com>
In-Reply-To: <8d629c6ac46444d6b5920566ae2c7e52@realtek.com>
Date:   Mon, 17 Jul 2023 13:39:39 -0500
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADEE3321-9472-4035-B86F-A9817438C493@malmoset.com>
References: <feadf58594b14c67bcf981dde6a60077@realtek.com>
 <ACAD9039-DD62-477E-BBCF-B8053822E042@malmoset.com>
 <8d629c6ac46444d6b5920566ae2c7e52@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I added a check of those two registers and rebooted 20 units 10 times. =
Failure rate was consistent and the traces were all like this:

[   30.227933] rtx_88 failed in download_firmware_validate
               Support information:
[   30.228392] rtx_88 0/50 0x1C4: 0, 0x10FC: 0
[   30.244149] rtx_88 1/50 0x1C4: fe000000, 0x10FC: 800350a6
[   30.251142] rtx_88 2/50 0x1C4: fe000000, 0x10FC: 800350a6
[   30.258269] rtx_88 3/50 0x1C4: fe000000, 0x10FC: 800350f5
[   30.244149] rtx_88 1/50 0x1C4: fe000000, 0x10FC: 800350a6
[   30.251142] rtx_88 2/50 0x1C4: fe000000, 0x10FC: 800350a6
[   30.258269] rtx_88 3/50 0x1C4: fe000000, 0x10FC: 800350f5
[   30.265399] rtx_88 4/50 0x1C4: fe000000, 0x10FC: 800350a6
[   30.272388] rtx_88 5/50 0x1C4: fe000000, 0x10FC: 800350a5
[   30.279387] rtx_88 6/50 0x1C4: fe000000, 0x10FC: 800350a5
[   30.286387] rtx_88 7/50 0x1C4: fe000000, 0x10FC: 800350a5
[   30.293392] rtx_88 8/50 0x1C4: fe000000, 0x10FC: 800350f5
[   30.300386] rtx_88 9/50 0x1C4: fe000000, 0x10FC: 800350a5
[   30.307387] rtx_88 10/50 0x1C4: fe000000, 0x10FC: 800350a5
[   30.314518] rtx_88 11/50 0x1C4: fe000000, 0x10FC: 800350a5
[   30.321654] rtx_88 12/50 0x1C4: fe000000, 0x10FC: 800350a6
[   30.329913] rtx_88 13/50 0x1C4: fe000000, 0x10FC: 800350f6
[   30.338722] rtx_88 14/50 0x1C4: fe000000, 0x10FC: 800350a6

The pattern and addresses continue and are the same on any device that =
fails. Going on your statement that 0x10FC is a PC like register, it =
looks like it=E2=80=99s caught in an infinite loop.


Sean


> On Jul 17, 2023, at 3:52 AM, Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Sean Mollet <sean@malmoset.com>
>> Sent: Monday, July 17, 2023 10:24 AM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Larry Finger <Larry.Finger@lwfinger.net>; =
linux-wireless@vger.kernel.org
>> Subject: [RFC] RTW88 firmware download issues - improvement, but not =
perfect
>>=20
>> On Jul 16, 2023, at 9:05 PM, Ping-Ke Shih <pkshih@realtek.com> wrote:
>>>=20
>>>=20
>>>=20
>>>>> @@ -794,15 +794,15 @@ static int __rtw_download_firmware(struct =
rtw_dev *rtwdev,
>>>>>=20
>>>>>        wlan_cpu_enable(rtwdev, true);
>>>>>=20
>>>>> -       if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
>>>>> -               ret =3D -EBUSY;
>>>>> -               goto dlfw_fail;
>>>>> -       }
>>>>> -
>>>>>        ret =3D download_firmware_validate(rtwdev);
>>>>>        if (ret)
>>>>>                goto dlfw_fail;
>>>>>=20
>>>>> +       if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
>>>>> +               ret =3D -EBUSY;
>>>>> +               goto dlfw_fail;
>>>>> +       }
>>>>> +
>>>=20
>>> This looks reason to restore 0x38 after validating firmware. Do you =
have a result
>>> how this change can improve?
>>>=20
>>=20
>> Using a Pi 4 CM as host, this reduces failures from 1 in 5 to 1 in =
20.
>>=20
>> I don=E2=80=99t know why, but it makes a measurable difference.
>=20
> I will check this with my colleague to see if we can apply this =
change.=20
>=20
>>=20
>>>>>        /* reset desc and index */
>>>>>        rtw_hci_setup(rtwdev);
>>>>>=20
>>>>> diff --git a/util.c b/util.c
>>>>> index ff3c269..fbd6599 100644
>>>>> --- a/util.c
>>>>> +++ b/util.c
>>>>> @@ -10,11 +10,11 @@ bool check_hw_ready(struct rtw_dev *rtwdev, =
u32 addr, u32 mask, u32 target)
>>>>> {
>>>>>        u32 cnt;
>>>>>=20
>>>>> -       for (cnt =3D 0; cnt < 1000; cnt++) {
>>>>> +       for (cnt =3D 0; cnt < 5000; cnt++) {
>>>>>                if (rtw_read32_mask(rtwdev, addr, mask) =3D=3D =
target)
>>>>>                        return true;
>>>>>=20
>>>>> -               udelay(10);
>>>>> +               udelay(50);
>>>=20
>>> I look into the latest vendor driver, it shows that cnt becomes =
10,000 and delay
>>> is 50us as your change.
>> Interesting. Is it possible that the real problem is simply not =
waiting long enough?
>>=20
>> Can you share some details of what the chip is doing and how long it =
should take?
>>=20
>=20
> It seems like I misread the code, the latest version is 5,000 as you =
mentioned.=20
>=20
> If failed to polling ready, please read and print out 0x1C4 and 0x10fc =
20 times
> with 1ms or more delay. These store firmware PC-like address, so we =
can check
> if firmware is running or getting stuck.=20
>=20
> Ping-Ke
>=20

