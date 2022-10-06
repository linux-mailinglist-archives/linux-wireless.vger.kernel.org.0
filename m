Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F15F6552
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJFLnN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJFLnL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:43:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA45A870A2
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B501B82064
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 11:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328F7C433D6;
        Thu,  6 Oct 2022 11:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665056588;
        bh=0p8V/u4CyiAo00Ox13Oi30WQsMEUz2y6gtN5d5sLQ+E=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=DxzbAAWZ8Yqk60E9/u0ubIiKYhzcptOEJ6t7463dBFyYLsRPrWH1MkScy7D2ATK7e
         Nth4LIlAGw8FOtBon8M05YfojLUtmc80Ole3hFEYZk2PdukmIQZwaCq6wdTbf6kjT9
         6eByiGrJu+7U4UupFRgIe84sNSx2fm8GLBj2EOSOW6UXHb002PjJWC8JLKNwuUkYAK
         Ub3e7LCgPVlkWxIa5kuOmKj+BgsIObW3JgB59oAYyfaeP4uQXn5sQXHWxQUXtzgVEG
         n77U4Yg3hZLZpS9K+S2MwZb3jnI9okPogzU9DILXlKetW89m3K4wUBDW/bczk7Xtwq
         Uf2+ppEMn57qw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0287A64ECAA; Thu,  6 Oct 2022 13:43:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
In-Reply-To: <74c6841dbc1edf3e965ea51a438542c2c497a15b.camel@sipsolutions.net>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
 <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
 <875ygyihhm.fsf@toke.dk>
 <bf6f9d8707021dc6017c7cb17805d63edea63333.camel@sipsolutions.net>
 <87r0zmgwli.fsf@toke.dk>
 <74c6841dbc1edf3e965ea51a438542c2c497a15b.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 06 Oct 2022 13:43:05 +0200
Message-ID: <8735c1fa9i.fsf@toke.dk>
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

> On Wed, 2022-10-05 at 16:43 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > >=20
>> > > This logic has implications for putting "urgent" frames (like PS(?))=
 on
>> > > TXQs as well, of course, but that needs to be handled somehow anyway=
...
>> >=20
>> > But that probably then anyway needs to be handled in next_txq()?
>>=20
>> Yeah, just meant that comment as an "for future reference", it doesn't
>> impact this patch series (I think?)
>>=20
>
> Right now, no, but with the promised patch to make powersave use TXQs it
> would, I think :)

Yup, hence why I wanted to give this "head's up" in advance so everyone
is aware :)

-Toke
