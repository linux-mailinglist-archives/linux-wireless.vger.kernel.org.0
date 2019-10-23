Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B87E106E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 05:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfJWDPQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 23:15:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36916 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfJWDPQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 23:15:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so11242797pgi.4
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 20:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QuirnkTCcFH4w3lbJlbd6iKwszCNsOJXs5wJFeG4v04=;
        b=W5QKXLuczaMsTr3ZrB7hoeFHZI9nAwgvsZrwZobElh8ZmvFv2z8LJHZD3fG8bOZE46
         DLMtMkKllocG8vkZq/JhcUAO1ZYvhd1GlHX+Wei/cFfG/mZkEPBS2hzyKxEOv9rRdJGk
         qNzY1fZaH/qHwZxaJug2l4BnMOoobvvqtOE4eXF8+Ylz/G2h1wOakYhuAcu6gBOXCs4Q
         8zNEExWZUDE5ULDGNFxEApWphtvt7OK/T/8xXtj3ORADv8qP/oNueT5lvOXI6yic0HRh
         +yr7zeJlJcgpZAdIhbMVPyuhTM257vR8TZygFqBBlKfdWPrRDWLCI9vpYA5cOQ5SPKjU
         IByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QuirnkTCcFH4w3lbJlbd6iKwszCNsOJXs5wJFeG4v04=;
        b=aTtRRioGCa8tWAZUr3N0rWTHyl8yKnoUnVukbRZ+vyT3PLd69kfzHnBYM/2Sjj8c/v
         jyaVptDnI9z5OM1w2W6I3djJlSuYY2QBQASLqXkEcoWhk52M5+k7DEcbrUZ8hF7FX8fr
         umQkLD/+GlQ/IjcIA2HLBaZ8/DKcBhzD+1vzlmleQ5Z3h3+qk/mcgkegvaUY8F6uCBCX
         OSYvEfPhoKpugkuU50ke6Hwrgsv6BTQTj7taLeCURPsR7Rb/pZgHjD+fiv8KuJcTKFWA
         4k7u4iP1pV4fb19zQolmNr0kQx7hCuMfsNBs5EUKmrWbDeih3rAwFC1/ev/wU2q5zjJn
         r3cA==
X-Gm-Message-State: APjAAAVedytQLz4A2s7+gBldbqSA8o67AOMyET+3S/lXhl45SOWKjSet
        Y/W+FPnpPFvVsMRWF+hi/Tu1qw==
X-Google-Smtp-Source: APXvYqy2EHclR+O9EGXak4MYGHd+L7uyA6i4BvAiT+WRm3SHwVKULThfVNQxeueos/MDQGdK+TTthw==
X-Received: by 2002:a63:4624:: with SMTP id t36mr5063547pga.376.1571800515358;
        Tue, 22 Oct 2019 20:15:15 -0700 (PDT)
Received: from [100.102.9.154] ([101.10.96.153])
        by smtp.gmail.com with ESMTPSA id p68sm26681385pfp.9.2019.10.22.20.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 20:15:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 4/5] rtw88: add set_bitrate_mask support
From:   Chris Chiu <chiu@endlessm.com>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1906A22@RTITMBSVM04.realtek.com.tw>
Date:   Wed, 23 Oct 2019 11:15:13 +0800
Cc:     Pkshih <pkshih@realtek.com>, Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <183D4FCE-9BE9-4D11-8D3F-E338823E3ADE@endlessm.com>
References: <20191022100420.25116-1-yhchuang@realtek.com> <20191022100420.25116-5-yhchuang@realtek.com> <CAB4CAwcBUHMR3btH9LGd=GzqU1mRmfmL0o4EOY4E8H1OxfpvMg@mail.gmail.com> <5B2DA6FDDF928F4E855344EE0A5C39D1D5C88DA8@RTITMBSVM04.realtek.com.tw> <F7CD281DE3E379468C6D07993EA72F84D1906A22@RTITMBSVM04.realtek.com.tw>
To:     Tony Chuang <yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Tony Chuang <yhchuang@realtek.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=8823=E6=97=
=A5 =E4=B8=8A=E5=8D=8810:37 =E5=AF=AB=E9=81=93=EF=BC=9A

>> [mailto:linux-wireless-owner@vger.kernel.org] On Behalf
>>> Of Chris Chiu
>>> Sent: Tuesday, October 22, 2019 8:49 PM
>>> To: Tony Chuang
>>> Cc: Kalle Valo; linux-wireless; Brian Norris
>>> Subject: Re: [PATCH v3 4/5] rtw88: add set_bitrate_mask support
>>>=20
>>>> On Tue, Oct 22, 2019 at 6:04 PM <yhchuang@realtek.com> wrote:
>>>>=20
>>>> From: Tzu-En Huang <tehuang@realtek.com>
>>>>=20
>>>> Support setting bit rate from upper layer.
>>>> After configuring the original rate control result in the driver, the
>>>> result is then masked by the bit rate mask received from the ops
>>>> set_bitrate_mask. Lastly, the masked result will be sent to firmware.
>>>>=20
>>>> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
>>>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Reviewed-by: Chris Chiu <chiu@endlessm.com>

>>>> ---
>>>>=20
>>>> v1 -> v2
>>>>  * No change
>>>>=20
>>>> v2 -> v3
>>>>  * use u64_encode_bits
>>>>=20
>>>> +static u64 rtw_update_rate_mask(struct rtw_dev *rtwdev,
>>>> +                               struct rtw_sta_info *si,
>>>> +                               u64 ra_mask, bool is_vht_enable,
>>>> +                               u8 wireless_set)
>>>> +{
>>>> +       struct rtw_hal *hal =3D &rtwdev->hal;
>>>> +       const struct cfg80211_bitrate_mask *mask =3D si->mask;
>>>> +       u64 cfg_mask =3D GENMASK(63, 0);
>>>> +       u8 rssi_level, band;
>>>> +
>>>> +       if (wireless_set !=3D WIRELESS_CCK) {
>>>> +               rssi_level =3D si->rssi_level;
>>>> +               if (rssi_level =3D=3D 0)
>>>> +                       ra_mask &=3D 0xffffffffffffffffULL;
>>>> +               else if (rssi_level =3D=3D 1)
>>>> +                       ra_mask &=3D 0xfffffffffffffff0ULL;
>>>> +               else if (rssi_level =3D=3D 2)
>>>> +                       ra_mask &=3D 0xffffffffffffefe0ULL;
>>>> +               else if (rssi_level =3D=3D 3)
>>>> +                       ra_mask &=3D 0xffffffffffffcfc0ULL;
>>>> +               else if (rssi_level =3D=3D 4)
>>>> +                       ra_mask &=3D 0xffffffffffff8f80ULL;
>>>> +               else if (rssi_level >=3D 5)
>>>> +                       ra_mask &=3D 0xffffffffffff0f00ULL;
>>>> +       }
>>>=20
>>> Would be better to enumerate rssi_level instead of 0 to 5. Does level
>>> 0 means bad rssi or good?
>>>=20
>=20
> I think 0 is the lowest level. And I think we don't need to add an enum fo=
r
> this kind of levels, as the number just presents the meaning of it.
>=20
> Yan-Hsuan

OK. I think it also makes sense to me.

Chris=
