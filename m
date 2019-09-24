Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295E6BC27B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409261AbfIXHXk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 03:23:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55331 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388209AbfIXHXk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 03:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569309817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0G4JZaYvwCxjnxKsq32f8WqDp3EglcnSucMrr0/3h5s=;
        b=VKQoNCrr5Wf8nK5VxF2CIbld6ugCEK4toz6Ca8SmTt0TekUfXt6a9NuDVoqhi5kE4BMjba
        Unq72lDFUUQvWg6UmBLafbOBXOINdbpZ+RTAFzkZfMhAeHbF+w5e0M13FlNCVUamIxTgrf
        qd+GkEG4B/MY3TieXVPtbYCemPJf7h4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-G6l1awceNgu_K5RXs5HoIg-1; Tue, 24 Sep 2019 03:23:36 -0400
Received: by mail-lj1-f198.google.com with SMTP id p14so154082ljh.22
        for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2019 00:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eNy0OsfgUovPrgaczSkGKc/qoZ1UwMaFnAS8E3+Ys5A=;
        b=aw/5ZPvzNbL8WZ/Tt8MUr/zI9Cym9vgiOfmYfRk89iuAu7tdHpbL2adQywOocDpSoJ
         cD8s8xHyfLzIytlkvFT3Zag3Pwz2ZiS9KrDYpOueIPkW8hw8dXWMEnAnMR8OXTOUnwRt
         8hGFgYUIHKoCD5hk2QqnfEMLsc82qQVGzg+0Us1ZnrQqEThqSaJqGmr4XmM9E2mcxBS7
         0S3ScVZ1R/fzjLhhvD7G80cg76hGP8jMd93F1LbV9o6YbXeGnmKE0NqujPcaPwTO/Fj4
         FLPYMdzNMpa2JZcUXcFh8OUdntIOsaIdf8kLgsmPwuGWFKBcDJLs+fDM8A5ezszQCP10
         4N2Q==
X-Gm-Message-State: APjAAAWmWfGlq15mPx0D7axnqbFwwL0NNJQbPkktHujxl23o89Ys/jbU
        9feSFTAsamDoqVFIHrcIIuxUH2+92hCVINzC8MxsEyCGvQwMS/oD7PTSTa+1SeW/KbijA1MuuAn
        yXaS/oPHzz9mFmJuK3wCusAVGcOU=
X-Received: by 2002:a2e:3004:: with SMTP id w4mr1003716ljw.21.1569309814650;
        Tue, 24 Sep 2019 00:23:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz7H5q3IT0g+d+H6LD07mIHz30Z7SyPa4apmHxLcO9AyhV335O5RMeH1RxVc/aOkY1Vs+x2DA==
X-Received: by 2002:a2e:3004:: with SMTP id w4mr1003704ljw.21.1569309814471;
        Tue, 24 Sep 2019 00:23:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 126sm273533lfh.45.2019.09.24.00.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 00:23:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BE5DA18063F; Tue, 24 Sep 2019 09:23:32 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <87h8525kmx.fsf@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-2-git-send-email-yiboz@codeaurora.org> <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org> <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org> <87tv98fu6l.fsf@toke.dk> <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org> <8736gre3bm.fsf@toke.dk> <198124204167325252fcfcd65e3f2733@codeaurora.org> <87ftkp7uuz.fsf@toke.dk> <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org> <877e617qg2.fsf@toke.dk> <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org> <874l157nrt.fsf@toke.dk> <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org> <87lfuf5ly2.fsf@toke.dk> <87r2476xy5.fsf@codeaurora.org> <875zlj55mh.fsf@toke.dk> <87h8525kmx.fsf@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 24 Sep 2019 09:23:32 +0200
Message-ID: <87tv9240p7.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: G6l1awceNgu_K5RXs5HoIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>> Kalle Valo <kvalo@codeaurora.org> writes:
>>
>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>>
>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>
>>>>> On 2019-09-21 22:00, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>=20
>>>>>>> On 2019-09-21 21:02, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>=20
>>>>>>>>> On 2019-09-21 19:27, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>=20
>>>>>>>>>>> On 2019-09-20 17:15, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>=20
>>>>>>>>>>>>> On 2019-09-19 18:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> On 2019-09-18 19:23, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>>>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>>> On 2019-09-18 05:10, Toke H=C3=B8iland-J=C3=B8rgensen wro=
te:
>>>>>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>
>>> Guys, PLEASE please consider us poor maintainers drowning in email and
>>> edit your quotes :) This style of discussion makes patchwork unusable:
>>>
>>> https://patchwork.kernel.org/patch/11147019/
>>
>> Heh, oops, didn't realise you were following the discussion from
>> patchwork; sorry, will be sure to cut things in the future.
>
> To be honest, I'm not sure how much Johannes uses patchwork. But I
> check everything from patchwork 95% of the time and try to keep my
> email boxes clean.

Noted. I'll try to be nice to patchwork, then :)

>> The quote marks do make a very nice (reverse) christmas tree, though ;)
>
> It did! I had to include that to my rant :)

:D

-Toke

