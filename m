Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486535F56A2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 16:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJEOnP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJEOnM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 10:43:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4E43E75
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 07:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE9F9B81BEF
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 14:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D8EC433D6;
        Wed,  5 Oct 2022 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664980988;
        bh=uNYOS61UeVYMrvBJs0a+xTZI0Fl+GYnMeB2GN2fKF+g=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=YqRHpwF3hTavnO9qIAt4OnsWBIuNbs0slpUCf8QNwp6hN/N7d4d0JsGBY8utN/s4W
         nsoqT4npMk0Uq5trd8SO2LYRD4YpiQMkLijn+09Ey7SujQcD/u8/diJwHQJeAHZyj8
         zJQvq7aiFRRvKyHt3hA4aC3orFvGl0DIH/s2/08gqFvmNemKigajZagq+syv8xI0Ls
         UVK/Llw0YNqKnxpLF4fHqoiMXlRXJgqEPZQBqcxAPRA+PTj46ARrgNEGI+u3sZHpDW
         50BIsqp9L3mtzAnPpLnsr5suGefHCe2Ifzg9JO2nCJw2BuVPSDo2UqAwfg596cX+xB
         OxL++ZD1H3BiQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F0C1F64EBC2; Wed,  5 Oct 2022 16:43:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
In-Reply-To: <bf6f9d8707021dc6017c7cb17805d63edea63333.camel@sipsolutions.net>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
 <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
 <875ygyihhm.fsf@toke.dk>
 <bf6f9d8707021dc6017c7cb17805d63edea63333.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Oct 2022 16:43:05 +0200
Message-ID: <87r0zmgwli.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2022-10-05 at 14:26 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> > void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
>> > 				    struct ieee80211_txq *txq)
>> > {
>> > 	... *local =3D from_hw(hw);
>> > 	... *sdata =3D from_vif(txq->vif);
>> >=20
>> > 	wake_tx_push_queue(local, sdata, txq);
>> > }
>> >=20
>> > Actually ... I wonder why you'd here - in waking a single TXQ - use
>> > ieee80211_next_txq() at all, Toke, what do you think?
>>=20
>> Well, this patch does almost exactly the same as the ath9k driver does,
>> for instance. Really, the wake_tx_queue() is a signal to the driver to
>> start transmitting on the *hardware* queue that the txq points to. For
>> some drivers (like Intel, right?) that's a 1-to-1 mapping, for others
>> there are multiple TXQs being scheduled on the same HW-TXQ. So I think
>> it's probably the right thing to do to just call next_txq(); if there's
>> only a single TXQ scheduled it should be pretty cheap to do so.
>
> Oh OK. So then the logic Alexander had makes sense.

Yup, I think so :)

>>=20
>> This logic has implications for putting "urgent" frames (like PS(?)) on
>> TXQs as well, of course, but that needs to be handled somehow anyway...
>
> But that probably then anyway needs to be handled in next_txq()?

Yeah, just meant that comment as an "for future reference", it doesn't
impact this patch series (I think?)

-Toke
