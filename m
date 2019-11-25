Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59A10918A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfKYQEn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:04:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37034 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfKYQEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:04:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id b10so7407702pgd.4
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ouU88PYd6GBEo6vRmHEuUgTDzYQPsR28YqpJcc0+1+Q=;
        b=K/OSZwCziBT4Ni+fLc2EMn5fjfa+9DxfLA+bbLfg9HlUnn6aftQ+LxxAKaSdeuXj6i
         CdMLDkkirCZyCCcfbnV0ct55qowyvyEEhqtkRhH1957JPK1T/0qVdjcS088lRzLCFGrt
         0fXIYjhQ1rUHty579EU77XaI/CSa0DO7SiufPFA8f6JrzLWDgIKNUCTfeqYfz2F0ouA+
         FJfaejcaD2sysIDlnXluAsKyhmD0yHmNihf/ntI9NywTE44IUIspnh0Oc5cpjzL2N2du
         NdPuATcWKgNqK5NH5WqmA617240h5atETOox665eANYmFs2E31xOcUXXptR3dQgU91dR
         rW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ouU88PYd6GBEo6vRmHEuUgTDzYQPsR28YqpJcc0+1+Q=;
        b=AgP19yDAVhGP5+BdLXgQowi5mIF4MRxw84BvYi33wlVm6ODLQ7DNLXc+2H49iK+l46
         iAkd0IqOkz06RG4BBVMbrefSbWJsWjd9h5Asndw0kEkadW44SYJz+NS/o1zuLuPD2P7w
         3jhjq3PXeZKMwzoVsPRCp/oZCk17lt/VI6gFauCHQdKJ79T6RS1Ms+JRdK0IroI/bswI
         2eX/yUNOwoaJullKAUjXIvv155rRz+9PTcResONDa+5194lL6b1A8DirsqNPgkc5+3RX
         eImwb+ALm/sslCAGargIV8cBnqbkLROLElMZ+w7g0DBWKjT86RufDuE8LnuVgIptowy4
         7FPw==
X-Gm-Message-State: APjAAAUG1SCk27RKZbe3hdSs+tdOi/s5e4CN4eJn3si5gsusW+i5NKWp
        VyR4uGDIoctlxl6+LS8FG2o=
X-Google-Smtp-Source: APXvYqxnBB2Jl1d4savpZUfhW1a2zf/FKEbzG5TZ/A3zG7zmA5ySn5Fg4Y5iaQpHiKTYq0ed0ypY1A==
X-Received: by 2002:a65:4345:: with SMTP id k5mr33392012pgq.252.1574697882325;
        Mon, 25 Nov 2019 08:04:42 -0800 (PST)
Received: from [127.0.0.1] (187.220.92.34.bc.googleusercontent.com. [34.92.220.187])
        by smtp.gmail.com with ESMTPSA id d139sm9745963pfd.162.2019.11.25.08.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:04:41 -0800 (PST)
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [EXT] [PATCH] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
From:   qize wang <wangqize888888888@gmail.com>
In-Reply-To: <1ED930FE-1360-4E0F-B770-244D02778411@gmail.com>
Date:   Tue, 26 Nov 2019 00:04:32 +0800
Cc:     Ganapathi Bhat <gbhat@marvell.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        amitkarwar <amitkarwar@gmail.com>,
        nishants <nishants@marvell.com>,
        huxinming820 <huxinming820@gmail.com>,
        kvalo <kvalo@codeaurora.org>, Greg KH <greg@kroah.com>,
        security <security@kernel.org>,
        linux-distros <linux-distros@vs.openwall.org>,
        Solar Designer <solar@openwall.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C693FCA-3AFF-47C1-97CD-563C9219F4D0@gmail.com>
References: <E40E893E-D9B4-4C63-8139-1DD5E1C2CECB@gmail.com>
 <20191122111339.GH617@kadam>
 <MN2PR18MB26373BC0C0D63A7C3CE09FC4A0490@MN2PR18MB2637.namprd18.prod.outlook.com>
 <20191122123739.GJ617@kadam> <1ED930FE-1360-4E0F-B770-244D02778411@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fix addresses CVE-2019-14901

> =D4=DA 2019=C4=EA11=D4=C222=C8=D5=A3=AC=CF=C2=CE=E710:27=A3=ACqize =
wang <wangqize888888888@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> Hi, dan
>=20
> I forget to explain  the reason of changing "pos" to "pos + 2=A1=B1 in =
the commit message.
> Thank you for your suggestion.
> IE is TLV struct, but ht_cap and  ht_oper aren=A1=AFt TLV struct,the =
origin marvell driver code is wrong.=20
> we fix the bug by changing pos(the address of IE) to  pos+2 ( the =
address of IE=A1=AFs value ).
>=20
> regards,
> qize wang
>=20
>> =D4=DA 2019=C4=EA11=D4=C222=C8=D5=A3=AC=CF=C2=CE=E78:37=A3=ACDan =
Carpenter <dan.carpenter@oracle.com> =D0=B4=B5=C0=A3=BA
>>=20
>> On Fri, Nov 22, 2019 at 11:40:40AM +0000, Ganapathi Bhat wrote:
>>> Hi Dan,
>>>=20
>>>>> +			/* copy the ie's value into ht_capb*/
>>>>> +			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos + =
2,
>>>>                                                                =
^^^^^^^
>>>>=20
>>>> I don't understand why we changed "pos" to "pos + 2".  Presumably =
there is
>>>> a reason, but it needs to explained in the commit message.
>>>=20
>>> I think, we were doing wrong in the original code. We are supposed =
to use 'pos + 2' itself, instead of just 'pos'. This is because, 'pos' =
is pointing to 'ieee_types_header', followed by the actual data and the =
destination do not start with (i.e. it do not contain) =
'ieee_types_header'(ex: 'sta_ptr->tdls_cap.ht_oper').
>>>=20
>>> Also, there are few places were the destination starts with =
'ieee_types_header'(ex: 'sta_ptr->tdls_cap.extcap'), which need just =
'pos'.
>>=20
>> I assumed it was something like this but it needs to be explained in
>> the commit message.
>>=20
>> regards,
>> dan carpenter
>>=20
>=20

