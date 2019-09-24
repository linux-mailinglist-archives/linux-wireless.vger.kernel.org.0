Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8DBC161
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 07:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405014AbfIXF1k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 01:27:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35912 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393010AbfIXF1k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 01:27:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A91B960256; Tue, 24 Sep 2019 05:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569302858;
        bh=iqreBXqW1z+PvVPcT2A+y7vEG6T1jEfF1BdCXbZUI9Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cWNo/Z1yt6exvdlf1zwZ43aVajPzWOEEWpEkf1eDwjJBKpeS86Qs1F0hG+KDb8n56
         VM+l99LIUWT17Dvjo4O1XWyZSZeMSfV7/WIWCAfQKtPZkKJiJhlZcIB/FglEe8mkoK
         CmbRsJTBYFgYH7qr1ZXrdDilw1IBMaH9wscMWwpc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA3CF60240;
        Tue, 24 Sep 2019 05:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569302858;
        bh=iqreBXqW1z+PvVPcT2A+y7vEG6T1jEfF1BdCXbZUI9Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cWNo/Z1yt6exvdlf1zwZ43aVajPzWOEEWpEkf1eDwjJBKpeS86Qs1F0hG+KDb8n56
         VM+l99LIUWT17Dvjo4O1XWyZSZeMSfV7/WIWCAfQKtPZkKJiJhlZcIB/FglEe8mkoK
         CmbRsJTBYFgYH7qr1ZXrdDilw1IBMaH9wscMWwpc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA3CF60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
        <1568639388-27291-2-git-send-email-yiboz@codeaurora.org>
        <87pnjyiq7o.fsf@toke.dk>
        <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org>
        <87sgothmpy.fsf@toke.dk>
        <8cdece5c030fd95817fb099021c38613@codeaurora.org>
        <87tv98fu6l.fsf@toke.dk>
        <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org>
        <8736gre3bm.fsf@toke.dk>
        <198124204167325252fcfcd65e3f2733@codeaurora.org>
        <87ftkp7uuz.fsf@toke.dk>
        <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org>
        <877e617qg2.fsf@toke.dk>
        <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org>
        <874l157nrt.fsf@toke.dk>
        <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org>
        <87lfuf5ly2.fsf@toke.dk> <87r2476xy5.fsf@codeaurora.org>
        <875zlj55mh.fsf@toke.dk>
Date:   Tue, 24 Sep 2019 08:27:34 +0300
In-Reply-To: <875zlj55mh.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Mon, 23 Sep 2019 18:39:34 +0200")
Message-ID: <87h8525kmx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>
>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>
>>>> On 2019-09-21 22:00, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>=20
>>>>>> On 2019-09-21 21:02, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>=20
>>>>>>>> On 2019-09-21 19:27, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>=20
>>>>>>>>>> On 2019-09-20 17:15, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>=20
>>>>>>>>>>>> On 2019-09-19 18:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> On 2019-09-18 19:23, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>>> On 2019-09-18 05:10, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>>>>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>
>> Guys, PLEASE please consider us poor maintainers drowning in email and
>> edit your quotes :) This style of discussion makes patchwork unusable:
>>
>> https://patchwork.kernel.org/patch/11147019/
>
> Heh, oops, didn't realise you were following the discussion from
> patchwork; sorry, will be sure to cut things in the future.

To be honest, I'm not sure how much Johannes uses patchwork. But I check
everything from patchwork 95% of the time and try to keep my email boxes
clean.

> The quote marks do make a very nice (reverse) christmas tree, though ;)

It did! I had to include that to my rant :)

--=20
Kalle Valo
