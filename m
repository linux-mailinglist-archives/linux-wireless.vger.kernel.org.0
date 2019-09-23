Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E70ACBB9C6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 18:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbfIWQjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 12:39:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389238AbfIWQjk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 12:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569256779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cG6g8FWFhJNU2pFuuSQ3wDeFo55uwqFpwiewpVNDDMk=;
        b=TaeRm61JNa7jJXAkRLUGQFFl7R4T4mJUPAr++og7npbEpqt9OQNE7BLYewCK0rN/G6XtlZ
        uzpkCSxPgeYG79bggKKSS1rnb0OkS1TxqthefpPZb89Fu0+cnSdF8yqY31Y2ureSTZKsol
        /U/NChhdvVG0v68FyAA4c0RJ0N1Pvm8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-QYms7sYfOg-LxTikIs6pIg-1; Mon, 23 Sep 2019 12:39:38 -0400
Received: by mail-ed1-f71.google.com with SMTP id 34so9821366edf.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 09:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HyuhdIWnvw+MB2y5Xe1fi//iQfAWHI+rX11knAQoHQo=;
        b=cx6eNsmTfyvJ3tR1CzbC1JVpQUMi0H5c1FSvuISurGjJYhnQtvbp6URpBDBfVCR8hm
         9qb+BkP/qG5L6KyJvlOMU8o6Z5uxluDOxMkmRW1A0eZthxfqnuyXYnCu4bLT36NiHr4l
         c3Qeqa/+xUHRB/zceLHejZE35TYNs/GJQPKXdAzQrxjFY7j1iho+yPTwFMQUHDQs4opu
         41YuazqFQHT8uzmbHuerduy3zI9UdXsBHxrc30Wr+lZCQ4fN9keD2UBYCJNyFO1eit4a
         TYTUOMBg2gO0udeCVc21C+ZpZrDF3IOgh6nND/vxtCWNyqrMLkEgcHgViGGrJBeubvdt
         8kbg==
X-Gm-Message-State: APjAAAXZrEbYJm8LdbAvUZonr89zVMTOOTWIjGfe6dNNw9QyKniB1iTo
        bHAJMUP6mZPAbWp4cP3Jkj55g3UsQIJU+MgDIKPraKwRT74Khzk0ygLhEeBXRsSCfJNksNVfFTK
        P/F5cQZ2xcy0aWCFYWvjq5IQbnwU=
X-Received: by 2002:a17:906:b84c:: with SMTP id ga12mr758541ejb.0.1569256776598;
        Mon, 23 Sep 2019 09:39:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIK4BocAnGRpl4BZk23ytDqoFV+OFHOviTCmWt7eKGp8IoKRipaFYqBPbK+ZPr5H8Lyg3wGg==
X-Received: by 2002:a17:906:b84c:: with SMTP id ga12mr758524ejb.0.1569256776382;
        Mon, 23 Sep 2019 09:39:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id h3sm1193119ejp.77.2019.09.23.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 09:39:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E52251804C8; Mon, 23 Sep 2019 18:39:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <87r2476xy5.fsf@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-2-git-send-email-yiboz@codeaurora.org> <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org> <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org> <87tv98fu6l.fsf@toke.dk> <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org> <8736gre3bm.fsf@toke.dk> <198124204167325252fcfcd65e3f2733@codeaurora.org> <87ftkp7uuz.fsf@toke.dk> <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org> <877e617qg2.fsf@toke.dk> <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org> <874l157nrt.fsf@toke.dk> <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org> <87lfuf5ly2.fsf@toke.dk> <87r2476xy5.fsf@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Sep 2019 18:39:34 +0200
Message-ID: <875zlj55mh.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: QYms7sYfOg-LxTikIs6pIg-1
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
>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>
>>> On 2019-09-21 22:00, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>=20
>>>>> On 2019-09-21 21:02, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>=20
>>>>>>> On 2019-09-21 19:27, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>=20
>>>>>>>>> On 2019-09-20 17:15, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>=20
>>>>>>>>>>> On 2019-09-19 18:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>=20
>>>>>>>>>>>>> On 2019-09-18 19:23, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>> On 2019-09-18 05:10, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>>>>>>>>>>>>>>>> Yibo Zhao <yiboz@codeaurora.org> writes:
>
> Guys, PLEASE please consider us poor maintainers drowning in email and
> edit your quotes :) This style of discussion makes patchwork unusable:
>
> https://patchwork.kernel.org/patch/11147019/

Heh, oops, didn't realise you were following the discussion from
patchwork; sorry, will be sure to cut things in the future.

The quote marks do make a very nice (reverse) christmas tree, though ;)

-Toke

