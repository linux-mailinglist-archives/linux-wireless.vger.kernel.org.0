Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A916FAB2F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 08:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfKMHqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 02:46:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36299 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMHqp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 02:46:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so1081982pfd.3
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 23:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B5UaMl8b4UFCWhCr451ZpAWkPQoBej5IKxFSCate++4=;
        b=D2hwmaqLY4aU+GURmRbWzY07JcsDByj4w85U4ZNJVqJRFl0mghgW1AKlR5J+qcQA2y
         L2aPEl7Ry+oUBObPOjNWDG3Otu9e2yBwFhFMDcKyYGcWQTT01O69GzrAdYgn+ezqCZi4
         D7ZDnMjkd50a1XSdLDnkAlgxT/74GqaOGGom1dcUAcV022NKPDbuCxhBexWnCrzowaXz
         Aw0Vc0SKqQGOuKAyOdZS8ZkXnutjL7/3yj49YHVgWqmrPH/mNB+KURzy+1qeCVenm+b4
         2qFJMsnvpOc46nqXZ/X4MRWfnCZ2TPJ5I74MOENJGWI9AKQ2tcGoMWulfNdWkitoRVyN
         q6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B5UaMl8b4UFCWhCr451ZpAWkPQoBej5IKxFSCate++4=;
        b=Ia4zrCpxCAvKV3kaWqc9SMUCC+LznRWpkyVRRvYw5V3ZW0jOA79cafJd0XcliXGtfV
         ixFEkF96clzNxUMEgBlp7VdQTgKamKHT4lCgKGQzXnXPvRsgSXEOS9wc41f8plrW+HJf
         hgxiSaT4WVd/9Fvf4l7dRIxTr+ugwb4ABQggEF/idqmq8QUdaWmmejqTq17Me8jXE7g5
         gIMhugVVXBAv/9qMeiqbASU+mR5WijIpBUanVfafuLtTeIHMie9HSG+ldERwSfock2WP
         B1e2LDppjX14jGoih9b0wiwEe4Sd/Vf+FVD76nvdYH2WUPnjkYMMK6YAYKQZ33KV/4QG
         EaNA==
X-Gm-Message-State: APjAAAXaWOcYELCyQTk643dBNA/C6rjXTMMotdomlMUjlEN/jV2PflbP
        g1rpfXIJReTTLYOWFfjOa3dV/Q==
X-Google-Smtp-Source: APXvYqxhlnqX5tSD2kPewGDqmlAsyOeOS6Up7XatpmettnnP4lpikxssTRmeFcoDGe40MkCYGVgfIw==
X-Received: by 2002:aa7:8d8b:: with SMTP id i11mr2686390pfr.45.1573631204022;
        Tue, 12 Nov 2019 23:46:44 -0800 (PST)
Received: from [10.158.21.189] ([101.9.161.91])
        by smtp.gmail.com with ESMTPSA id n72sm1417301pjc.4.2019.11.12.23.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 23:46:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/4] rtw88: pci: enable CLKREQ function if host supports it
From:   Chris Chiu <chiu@endlessm.com>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1927EEB@RTITMBSVM04.realtek.com.tw>
Date:   Wed, 13 Nov 2019 15:46:41 +0800
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A25CD5DF-9227-46DB-BBFF-0153F37723E9@endlessm.com>
References: <20191107111603.12317-1-yhchuang@realtek.com> <20191107111603.12317-4-yhchuang@realtek.com> <CAB4CAwd6MDSyPTVGr-3T6nNTpJiJy1jEfNWtyriqoMJyV83jdw@mail.gmail.com> <F7CD281DE3E379468C6D07993EA72F84D1927EEB@RTITMBSVM04.realtek.com.tw>
To:     Tony Chuang <yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Tony Chuang <yhchuang@realtek.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=8813=E6=97=
=A5 =E4=B8=8B=E5=8D=883:16 =E5=AF=AB=E9=81=93=EF=BC=9A

>>> On Thu, Nov 7, 2019 at 7:16 PM <yhchuang@realtek.com> wrote:
>>>=20
>>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>>=20
>>> By Realtek's design, there are two HW modules associated for CLKREQ,
>>> one is responsible to follow the PCIE host settings, and another
>>> is to actually working on it. But the module that is actually working
>>> on it is default disabled, and driver should enable that module if
>>> host and device have successfully sync'ed with each other.
>>>=20
>>> The module is default disabled because sometimes the host does not
>>> support it, and if there is any incorrect settings (ex. CLKREQ# is
>>> not Bi-Direction), device can be lost and disconnected to the host.
>>>=20
>>> So driver should first check after host and device are sync'ed, and
>>> the host does support the function and set it in configuration
>>> space, then driver can turn on the HW module to working on it.
>>>=20
>>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>> ---
>>> drivers/net/wireless/realtek/rtw88/pci.c | 83
>> ++++++++++++++++++++++++
>>> drivers/net/wireless/realtek/rtw88/pci.h |  5 ++
>>> 2 files changed, 88 insertions(+)
>>>=20
>>> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c
>> b/drivers/net/wireless/realtek/rtw88/pci.c
>>> index 6d1aa6f41e84..4fcef8a6fc42 100644
>>> --- a/drivers/net/wireless/realtek/rtw88/pci.c
>>> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
>>> @@ -1081,6 +1081,33 @@ static void rtw_dbi_write8(struct rtw_dev
>> *rtwdev, u16 addr, u8 data)
>>>        WARN(flag, "failed to write to DBI register, addr=3D0x%04x\n",
>> addr);
>>> }
>>>=20
>>> +static int rtw_dbi_read8(struct rtw_dev *rtwdev, u16 addr, u8 *value)
>>> +{
>>> +       u16 read_addr =3D addr & BITS_DBI_ADDR_MASK;
>>> +       u8 flag;
>>> +       u8 cnt;
>>> +
>>> +       rtw_write16(rtwdev, REG_DBI_FLAG_V1, read_addr);
>>> +       rtw_write8(rtwdev, REG_DBI_FLAG_V1 + 2, BIT_DBI_RFLAG >>
>> 16);
>>> +
>>> +       for (cnt =3D 0; cnt < RTW_PCI_WR_RETRY_CNT; cnt++) {
>>> +               flag =3D rtw_read8(rtwdev, REG_DBI_FLAG_V1 + 2);
>>> +               if (flag =3D=3D 0)
>>> +                       break;
>> Why not just doing ' rtw_read8(rtwdev, read_addr);' and return here?
>> Then you don't need to check the flag !=3D 0 at the following. It would
>> make the code cleaner and same expressive.
>=20
> Maybe it would look cleaner, but you need to add statements when
> 'if (flag =3D=3D 0)', then the indents will be deeper.
> Also you will need to return 0 at the end if 'flag =3D=3D 0'.
>=20

Yup. And I believe it=E2=80=99s still under 80 characters so I think I=E2=80=
=99m cool with it.

> So you still think it's cleaner to write it that way? If so, I can try to s=
end
> v2 for it.
>>=20
>>> +
>>> +               udelay(10);
>>> +       }
>>> +
>>> +       if (flag !=3D 0) {
>>> +               WARN(1, "failed to read DBI register, addr=3D0x%04x\n",
>> addr);
>>> +               return -EIO;
>>> +       }
>>> +
>>> +       read_addr =3D REG_DBI_RDATA_V1 + (addr & 3);
>>> +       *value =3D rtw_read8(rtwdev, read_addr);
>>> +       return 0;
>>> +}
>>> +
>>> --
>>> 2.17.1
>>>=20
>>=20
>=20
> Yan-Hsuan
