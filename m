Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48C24ED6FF
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiCaJd4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 05:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiCaJdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 05:33:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A021BD9A3
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 02:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10C87B82002
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 09:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3316C340EE;
        Thu, 31 Mar 2022 09:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648719124;
        bh=eYJII5ytCDYaWyZcVwI8mgWtrC6QAz+Q3DV12ELAvaI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Sy1BOOl6OpagxMkfI7RhyEOlyKU2w854zBgibQDsU6yZb8IKXPqME86igiRdGT9rD
         YtmA/ezWganwMSzlumqCxcM1ihuKXZUJDSp87ls2AWOjaiCbjt2yerla9+hCcEgUHA
         XT/ITLNz/N8Z9QE9nJXN1ZxeurdG7U2Pt2e1KZbdoOAx2ensqbBpURpGC3O7txJOEH
         XkdXQItGl3HUFiQfc3KUb8/Bnm5W2ZErE1duYQmef2Ar+L7nJPvNQQBEbIV0gQZ+6U
         MDz8KI2yFGsJcsc1Tzco+14NPefKuHNwLsXzpsshRbdqEZi4xW5hQIvtO+0j1W5OOf
         KilSyAopqf3NA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before reporting to mac80211
References: <20220330164409.16645-1-toke@toke.dk>
        <8ad2754c-c5bb-7b07-6b3f-5701d0434eee@gmail.com>
        <87fsmyvg22.fsf@tynnyri.adurom.net> <87pmm2h64a.fsf@toke.dk>
Date:   Thu, 31 Mar 2022 12:31:58 +0300
In-Reply-To: <87pmm2h64a.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Thu, 31 Mar 2022 10:35:17 +0200")
Message-ID: <87bkxmv569.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>>
>>> On 30/03/22 23.44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> The ath9k driver was not properly clearing the status area in the
>>>> ieee80211_tx_info struct before reporting TX status to mac80211. Inste=
ad,
>>>> it was manually filling in fields, which meant that fields introduced =
later
>>>> were left as-is.
>>>>
>>>> Conveniently, mac80211 actually provides a helper to zero out the stat=
us
>>>> area, so use that to make sure we zero everything.
>>>>
>>>> The last commit touching the driver function writing the status inform=
ation
>>>> seems to have actually been fixing an issue that was also caused by the
>>>> area being uninitialised; but it only added clearing of a single field
>>>> instead of the whole struct. That is now redundant, though, so revert =
that
>>>> commit and use it as a convenient Fixes tag.
>>>>
>>>> Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before r=
eporting TX status")
>>>> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>>
>>> No regressions and UBSAN warning [1] reported on dmesg.
>>>
>>> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>>
>>> However, there is something missing. I don't see Cc: stable@vger.kernel=
.org
>>> trailer in this patch. I think it should, because I reported that this =
issue
>>> first occurred on v5.17, then still appeared on v5.17.1.
>>
>> I can add that during commit.
>
> Thanks! And sorry about that, I have gotten so used to the netdev policy
> of not including an explicit stable Cc that I totally forgot that this
> doesn't apply to the wireless tree.

No worries!

> In any case I think the stable tree autoselection bit should pick it up
> from the Fixes tag, though...

Yeah, I agree. I also only add the Fixes tag to my patches, and let the
stable team to choose if they want the commit or not. But if people ask
to add cc stable I'll do that, it's easy enough as I have the edit
command in my patchwork script :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
