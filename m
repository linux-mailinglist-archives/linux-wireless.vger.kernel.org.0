Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F5110740A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVO1T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 09:27:19 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34205 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVO1T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 09:27:19 -0500
Received: by mail-pj1-f66.google.com with SMTP id bo14so3125697pjb.1
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 06:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KykVfamE1nBiFxriBu8p+Bbq3sL3up0WHQW26O7SCFc=;
        b=lA7hS+sq8b5U/yn4U2uiI/Y6q0nlTm4N6kpVRKTWLYWIWJIIzM0jucq345Com7XCRy
         qJXg3C942IMV/1ksFkgSCLjuc+Qgh5rRRi1I7wFKHIHP84vFSZhC1vY65+4TeArAeFtV
         Axrd4DU9qtPgPzITmscHvkcRQMWE7NGXCgxa+Lx5LoFRPBL6SWjpxJq/n16/tN3xwzPR
         5AZ5R2Ctrf8gSDDBTPrwALwZ700+kH6zO86AazQ3ZS/4hfn7KzGIoglAkpzqlxoSUN4Q
         MQ33Vh9PzaKRp/bOzCSwJv3g6tbfEYegz1CwaZSvxl7bdBuodrWjdY3xyCKQ8a2ZKFOH
         +ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KykVfamE1nBiFxriBu8p+Bbq3sL3up0WHQW26O7SCFc=;
        b=sjEDqXxZRkHBR2htLYGGNb5j+sAM8eXB4kKC07si78CoKVL2B7XLU+3zk/TCfi7ss4
         1zq296o2okfpjjwzhdYhWyYrpmrbfex5pYwPA1ErzOzOEjQ9/QbYAIga1sJQUCuopg43
         e4Nt3pcQdVmLUlICbVCYa9cZDHWJP1DzDH93lYoifhXKfp7OJJaAA6J26jNg9pkaX/av
         hl88Es+IQsXYgdWrlXjbEvJMHzgRkNXCRo3lJtQ+nEHZVvM8P7i9KPmX7s/Qpcs5sixy
         AdmWLGsJwdwF1cZxoLDA97qQRZlH2GZhEUl+CFZkOSQ8v8aKpCBkap/NBEaJ/srPJ4nS
         WGWg==
X-Gm-Message-State: APjAAAVGvBN3HmtUl8d3VyWRSxkcLLPht3I2SCC+jCLx4nbYx0C1GAwu
        xOeM4qrzx2e0wkQ7dLjKM3A=
X-Google-Smtp-Source: APXvYqwwYUtEB+inYC7bBzJwT7JUjYo8jISffBHc9CxeWoa28P/8zsXkixAEIAlCVeigzus3REcUnQ==
X-Received: by 2002:a17:90a:4fe6:: with SMTP id q93mr19227052pjh.88.1574432838367;
        Fri, 22 Nov 2019 06:27:18 -0800 (PST)
Received: from [127.0.0.1] (187.220.92.34.bc.googleusercontent.com. [34.92.220.187])
        by smtp.gmail.com with ESMTPSA id p123sm7718613pfg.30.2019.11.22.06.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 06:27:17 -0800 (PST)
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [EXT] Re: [PATCH] mwifiex: Fix heap overflow in
 mmwifiex_process_tdls_action_frame()
From:   qize wang <wangqize888888888@gmail.com>
In-Reply-To: <20191122123739.GJ617@kadam>
Date:   Fri, 22 Nov 2019 22:27:13 +0800
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
Message-Id: <1ED930FE-1360-4E0F-B770-244D02778411@gmail.com>
References: <E40E893E-D9B4-4C63-8139-1DD5E1C2CECB@gmail.com>
 <20191122111339.GH617@kadam>
 <MN2PR18MB26373BC0C0D63A7C3CE09FC4A0490@MN2PR18MB2637.namprd18.prod.outlook.com>
 <20191122123739.GJ617@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, dan

I forget to explain  the reason of changing "pos" to "pos + 2=A1=B1 in =
the commit message.
Thank you for your suggestion.
IE is TLV struct, but ht_cap and  ht_oper aren=A1=AFt TLV struct,the =
origin marvell driver code is wrong.=20
we fix the bug by changing pos(the address of IE) to  pos+2 ( the =
address of IE=A1=AFs value ).

regards,
qize wang

> =D4=DA 2019=C4=EA11=D4=C222=C8=D5=A3=AC=CF=C2=CE=E78:37=A3=ACDan =
Carpenter <dan.carpenter@oracle.com> =D0=B4=B5=C0=A3=BA
>=20
> On Fri, Nov 22, 2019 at 11:40:40AM +0000, Ganapathi Bhat wrote:
>> Hi Dan,
>>=20
>>>> +			/* copy the ie's value into ht_capb*/
>>>> +			memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos + =
2,
>>>                                                                 =
^^^^^^^
>>>=20
>>> I don't understand why we changed "pos" to "pos + 2".  Presumably =
there is
>>> a reason, but it needs to explained in the commit message.
>>=20
>> I think, we were doing wrong in the original code. We are supposed to =
use 'pos + 2' itself, instead of just 'pos'. This is because, 'pos' is =
pointing to 'ieee_types_header', followed by the actual data and the =
destination do not start with (i.e. it do not contain) =
'ieee_types_header'(ex: 'sta_ptr->tdls_cap.ht_oper').
>>=20
>> Also, there are few places were the destination starts with =
'ieee_types_header'(ex: 'sta_ptr->tdls_cap.extcap'), which need just =
'pos'.
>=20
> I assumed it was something like this but it needs to be explained in
> the commit message.
>=20
> regards,
> dan carpenter
>=20

