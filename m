Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751626E5E68
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 12:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjDRKPB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 06:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDRKO4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 06:14:56 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D8F468E
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 03:14:51 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1681812889; bh=6f+hmqC9dhEE6aVNnqEaCZHVEGrLH0O+/xJyQheH7mg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j8O1FTu1TOJaUbWvS8EiUOQsYE0cR8MupiKU+gdUELTL2i6mxfjBuBUqz7OzPojYN
         Iib98FB3JgsbW+nMmivfhLXGj+3p9c2szvdi6OG/gsHt0zZqnwH3mSITEYMiAlh8YH
         3Zk2DJXLTi3r0dJ2pjAACLHuL85E0P0KI6QtFDNwOFPoL1Zq5yTuhqMuzkx3iOgpcp
         70Lmi01gAN2EFuJWq7V8fwBXAqjr9l37OvG4X6nJbf7KrRQS26PbQsOyTbAfo6AOb9
         zMZhtW4mkrh5LNJuu4aLS1N96enq6Cfqk4B3kgvDrrgF1Xyjr6XTu8y+T7mQE/uCkT
         ndYU6lMeGEUSg==
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: Don't mark channelmap stack variable
 read-only in ath9k_mci_update_wlan_channels()
In-Reply-To: <87edom7i6i.fsf@kernel.org>
References: <20230413214118.153781-1-toke@toke.dk>
 <87v8hysrzx.fsf@kernel.org> <87bkjqzrdm.fsf@toke.dk>
 <87edom7i6i.fsf@kernel.org>
Date:   Tue, 18 Apr 2023 12:14:48 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877cu9wl7r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> (dropping stable from cc)
>
> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>
>> Kalle Valo <kvalo@kernel.org> writes:
>>
>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>>>
>>>> This partially reverts commit e161d4b60ae3a5356e07202e0bfedb5fad82c6aa.
>>>>
>>>> Turns out the channelmap variable is not actually read-only, it's modi=
fied
>>>> through the MCI_GPM_CLR_CHANNEL_BIT() macro further down in the functi=
on,
>>>> so making it read-only causes page faults when that code is hit.
>>>>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217183
>>>> Fixes: e161d4b60ae3 ("wifi: ath9k: Make arrays prof_prio and
>>>> channelmap static const")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>>
>>> I guess the casting in MCI_GPM_CLR_CHANNEL_BIT() hide this and made it
>>> impossible for the compiler to detect it? A perfect example why I hate
>>> casting :)
>>
>> Yup, exactly. I was also assuming the compiler would catch it, but yay, =
C! :/
>
> We have so many static checkers that I wonder if those would be able to
> catch these kind of buggy casts? We had a similar bug in rtw89 something
> like a year ago.

No idea. Would be nice, yeah... :)

>> Anyway, cf the bugzilla this was a pretty bad regression for 6.2, so
>> would be good to move this along reasonably quickly (although I guess we
>> just missed the -net PR for rc7)...
>
> I'm not planning to send anymore stuff to v6.3 so my plan is to take
> this to -next. The merge window is very close anyway so this shouldn't
> cause too much delay.

Hmm, okay, a bit unfortunate that we'll ship 6.3 with the same bug, but
if it goes in during the merge window, I guess we'll get the fix into
6.3.1 (or something close to that) via stable? I can live with that...

-Toke
