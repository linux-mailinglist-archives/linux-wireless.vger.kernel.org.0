Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F003F3669
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 00:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhHTW1y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 18:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233332AbhHTW1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 18:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629498435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGYQeQqftZBb6vuQouNOrnEYSVHneBFtO+FwlQpf0dY=;
        b=Iv++ENnn1bP9L2fsX34khSm/RU+c5XwKvijTy/drudZwkdEXnm/k7LUPPpxfp6OGvdPxU6
        /Ko7/dpX6I7U9qRLKoztmNjyvF761oD7RyrB/zCwhgZyr0THEu6rT9WP50dN/LOJcQM0yJ
        9twGACPC9P8jLmrkzdTrSFBR/q2wX64=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-99SIbXwPOT2-qFFIOrPELQ-1; Fri, 20 Aug 2021 18:27:14 -0400
X-MC-Unique: 99SIbXwPOT2-qFFIOrPELQ-1
Received: by mail-ed1-f71.google.com with SMTP id k13-20020aa7c04d000000b003bf04c03fc4so5305507edo.22
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 15:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uGYQeQqftZBb6vuQouNOrnEYSVHneBFtO+FwlQpf0dY=;
        b=UHj4QmMwCC6vWrbqFn455k2g0qBUeXhKa0nOcr/aEPjDZWdrecM5vKkOP4Tw3K1ky3
         g1ZfvzHDRxLWRbZ3B9fULwy0sxV+4zRDGjLE/ziYwJLJWAinUKKLg8m5adD7gIwWZ5h1
         bBW0F//U5LZeo56Iv+jqU98vOou8WqGE9QxdGIn4olp+s3iQZCADy/a1FXkKZ0zDwWJo
         afxKarJIHqv6exErA6q5kZMRCbGhLCvLDS7LlaEm9oWQnfA/ymBY0V2loHDD1FjJG0Y2
         UxBjZG7XGOllhpSMKO385Af/BuWbSzUWV04SJKZ/2/nmbtxe/fa1W3axWQ7U6cQhsTtf
         c15A==
X-Gm-Message-State: AOAM533hk3+alOOqc6AoGb+1G+/dpz0tZw0MzZhP1Ty3W8Ev+h5WNaez
        NVwvnDFf2XSinEC2TymCbgreVtaEtHTz/hqF0AAX7ySiPRIk0WdH4/Y6vRTG01VnuGRfo6+HWos
        tra8gegrhFoLpzBKWHq1YCyOdi0w=
X-Received: by 2002:a17:906:138f:: with SMTP id f15mr23808119ejc.233.1629498432900;
        Fri, 20 Aug 2021 15:27:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwujiDFAAgX76UxFgFl/4ULniAm2N2JElHcMPC4D7BvnMFo+hYZb8pcm3rmlz4JnFho/wr/nQ==
X-Received: by 2002:a17:906:138f:: with SMTP id f15mr23808112ejc.233.1629498432689;
        Fri, 20 Aug 2021 15:27:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id da1sm4301682edb.26.2021.08.20.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:27:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 08D00180061; Sat, 21 Aug 2021 00:27:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sasha Levin <sashal@kernel.org>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: Backporting CVE-2020-3702 ath9k patches to stable
In-Reply-To: <YSAdPJFhmTztd+0Z@sashalap>
References: <20210818084859.vcs4vs3yd6zetmyt@pali>
 <YRzMt53Ca/5irXc0@kroah.com> <20210818091027.2mhqrhg5pcq2bagt@pali>
 <YRzQZZIp/LfMy/xG@kroah.com> <20210820113505.dgcsurognowp6xqp@pali>
 <YSAdPJFhmTztd+0Z@sashalap>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 21 Aug 2021 00:27:10 +0200
Message-ID: <87y28vycox.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> On Fri, Aug 20, 2021 at 01:35:05PM +0200, Pali Roh=C3=A1r wrote:
>>On Wednesday 18 August 2021 11:18:29 Greg KH wrote:
>>> On Wed, Aug 18, 2021 at 11:10:27AM +0200, Pali Roh=C3=A1r wrote:
>>> > On Wednesday 18 August 2021 11:02:47 Greg KH wrote:
>>> > > On Wed, Aug 18, 2021 at 10:48:59AM +0200, Pali Roh=C3=A1r wrote:
>>> > > > Hello! I would like to request for backporting following ath9k co=
mmits
>>> > > > which are fixing CVE-2020-3702 issue.
>>> > > >
>>> > > > 56c5485c9e44 ("ath: Use safer key clearing with key cache entries=
")
>>> > > > 73488cb2fa3b ("ath9k: Clear key cache explicitly on disabling har=
dware")
>>> > > > d2d3e36498dd ("ath: Export ath_hw_keysetmac()")
>>> > > > 144cd24dbc36 ("ath: Modify ath_key_delete() to not need full key =
entry")
>>> > > > ca2848022c12 ("ath9k: Postpone key cache entry deletion for TXQ f=
rames reference it")
>>> > > >
>>> > > > See also:
>>> > > > https://lore.kernel.org/linux-wireless/87o8hvlx5g.fsf@codeaurora.=
org/
>>> > > >
>>> > > > This CVE-2020-3702 issue affects ath9k driver in stable kernel ve=
rsions.
>>> > > > And due to this issue Qualcomm suggests to not use open source at=
h9k
>>> > > > driver and instead to use their proprietary driver which do not h=
ave
>>> > > > this issue.
>>> > > >
>>> > > > Details about CVE-2020-3702 are described on the ESET blog post:
>>> > > > https://www.welivesecurity.com/2020/08/06/beyond-kr00k-even-more-=
wifi-chips-vulnerable-eavesdropping/
>>> > > >
>>> > > > Two months ago ESET tested above mentioned commits applied on top=
 of
>>> > > > 4.14 stable tree and confirmed that issue cannot be reproduced an=
ymore
>>> > > > with those patches. Commits were applied cleanly on top of 4.14 s=
table
>>> > > > tree without need to do any modification.
>>> > >
>>> > > What stable tree(s) do you want to see these go into?
>>> >
>>> > Commits were introduced in 5.12, so it should go to all stable trees =
<< 5.12
>>> >
>>> > > And what order are the above commits to be applied in, top-to-botto=
m or
>>> > > bottom-to-top?
>>> >
>>> > Same order in which were applied in 5.12. So first commit to apply is
>>> > 56c5485c9e44, then 73488cb2fa3b and so on... (from top of the email to
>>> > the bottom of email).
>>>
>>> Great, all now queued up.  Sad that qcom didn't want to do this
>>> themselves :(
>>>
>>> greg k-h
>>
>>It is sad, but Qualcomm support said that they have fixed it in their
>>proprietary driver in July 2020 (so more than year ago) and that open
>>source drivers like ath9k are unsupported and customers should not use
>>them :( And similar answer is from vendors who put these chips into
>>their cards / products.
>
> Is there a public statement that says that? Right now the MAINTAINERS
> file says it's "supported" and if it's not the case we should at least
> fix that and consider deprecating it if it's really orphaned.

FWIW there's still quite a few OpenWrt devices that are using ath9k and
ticking away happily. And we are some that do still care about ath9k,
even if QCA doesn't... As the email that started this thread also shows,
I suppose?

-Toke

