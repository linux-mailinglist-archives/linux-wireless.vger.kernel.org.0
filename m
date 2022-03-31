Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FBE4ED5B9
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 10:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiCaIhM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiCaIhG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 04:37:06 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1B1E7449
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 01:35:19 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1648715717; bh=LtmDdzx8NPYjXbjlqxCMp7zwoLsi90EsaoQ8ra0IDmI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MvDWw9lA/1qab0BFpsfIg2LXYJ/pRUkyEAz7hlzydmnAkPi/nFMThr6egvlFt9L0N
         7eeOPSQy+GogwdonmzBNIwVWzuUZm49X0e7tIxNMcb29TVqiwIzSQfFwe6x9sRXpAt
         GlfK9P8nywcgnIMJyTHixBHqgz/RD0lA4n9Yor/1HwaO354Eq7f0GTQfsiBjRmnwRU
         HcLlG3sujKqrlEkTAsyFO1KOchskcPb9bQLb+SK3rprxSgX268fPHxTXChApUlzEsj
         ye0+YKK1zuQ+fEYO7QEhCLMLYuXxezJclduIB83Ix8T2U0myxvLrptBHc/JmOWDaTp
         jUWoof+E9ma8Q==
To:     Kalle Valo <kvalo@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before
 reporting to mac80211
In-Reply-To: <87fsmyvg22.fsf@tynnyri.adurom.net>
References: <20220330164409.16645-1-toke@toke.dk>
 <8ad2754c-c5bb-7b07-6b3f-5701d0434eee@gmail.com>
 <87fsmyvg22.fsf@tynnyri.adurom.net>
Date:   Thu, 31 Mar 2022 10:35:17 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pmm2h64a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>
>> On 30/03/22 23.44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> The ath9k driver was not properly clearing the status area in the
>>> ieee80211_tx_info struct before reporting TX status to mac80211. Instea=
d,
>>> it was manually filling in fields, which meant that fields introduced l=
ater
>>> were left as-is.
>>>
>>> Conveniently, mac80211 actually provides a helper to zero out the status
>>> area, so use that to make sure we zero everything.
>>>
>>> The last commit touching the driver function writing the status informa=
tion
>>> seems to have actually been fixing an issue that was also caused by the
>>> area being uninitialised; but it only added clearing of a single field
>>> instead of the whole struct. That is now redundant, though, so revert t=
hat
>>> commit and use it as a convenient Fixes tag.
>>>
>>> Fixes: cc591d77aba1 ("ath9k: Make sure to zero status.tx_time before re=
porting TX status")
>>> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>
>> No regressions and UBSAN warning [1] reported on dmesg.
>>
>> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>
>> However, there is something missing. I don't see Cc: stable@vger.kernel.=
org
>> trailer in this patch. I think it should, because I reported that this i=
ssue
>> first occurred on v5.17, then still appeared on v5.17.1.
>
> I can add that during commit.

Thanks! And sorry about that, I have gotten so used to the netdev policy
of not including an explicit stable Cc that I totally forgot that this
doesn't apply to the wireless tree.

In any case I think the stable tree autoselection bit should pick it up
from the Fixes tag, though...

-Toke
