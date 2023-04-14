Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D306E2375
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDNMiZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNMiY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BCB44E
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 232D164775
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3973C433D2;
        Fri, 14 Apr 2023 12:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475896;
        bh=DARFHnfZmORnVHa7Sd+DCQb5C8x73tjXRCBPDL3nwIo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WVe8QUfjIFzdvWejmpI/AxVf2z+gjzyIBh8/0gDnDbTsJ8uXLtXyen8L68S5KvA6y
         CSE5g24Vtjqr7L3Rn9LRY0UDkPScr6S0RRi50FaJc2cUy5jJUcd5dk/yLP1+Ao+aQi
         MQUrXEb8oE7Fcjjm/84ObMKc4Ab3tJhtXckcCek5kljwvYTKp8eCRdlLZifoCbtYgW
         d+FHFqYa+2wWcFBl85QtR+Tdqxa6ZuEWllFZ1hXtFcbviytfma9mZMgKhp2vQyijj6
         nqkTsUuj0LnM9zi8ND1+QdVJHgcrb8MQT6tVn2SMAwpzok+7mimWKNHS+R0td7i4ZL
         fvHsigzLAnWLQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: Don't mark channelmap stack variable read-only in ath9k_mci_update_wlan_channels()
References: <20230413214118.153781-1-toke@toke.dk> <87v8hysrzx.fsf@kernel.org>
        <87bkjqzrdm.fsf@toke.dk>
Date:   Fri, 14 Apr 2023 15:38:13 +0300
In-Reply-To: <87bkjqzrdm.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Fri, 14 Apr 2023 12:32:05 +0200")
Message-ID: <87edom7i6i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(dropping stable from cc)

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>>
>>> This partially reverts commit e161d4b60ae3a5356e07202e0bfedb5fad82c6aa.
>>>
>>> Turns out the channelmap variable is not actually read-only, it's modif=
ied
>>> through the MCI_GPM_CLR_CHANNEL_BIT() macro further down in the functio=
n,
>>> so making it read-only causes page faults when that code is hit.
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217183
>>> Fixes: e161d4b60ae3 ("wifi: ath9k: Make arrays prof_prio and
>>> channelmap static const")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>
>> I guess the casting in MCI_GPM_CLR_CHANNEL_BIT() hide this and made it
>> impossible for the compiler to detect it? A perfect example why I hate
>> casting :)
>
> Yup, exactly. I was also assuming the compiler would catch it, but yay, C=
! :/

We have so many static checkers that I wonder if those would be able to
catch these kind of buggy casts? We had a similar bug in rtw89 something
like a year ago.

> Anyway, cf the bugzilla this was a pretty bad regression for 6.2, so
> would be good to move this along reasonably quickly (although I guess we
> just missed the -net PR for rc7)...

I'm not planning to send anymore stuff to v6.3 so my plan is to take
this to -next. The merge window is very close anyway so this shouldn't
cause too much delay.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
