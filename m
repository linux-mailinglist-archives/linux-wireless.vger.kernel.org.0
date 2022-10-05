Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0593F5F5102
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 10:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJEIjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJEIi5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 04:38:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B75E75CF7
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 01:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35088615C8
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 08:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C191EC433D6;
        Wed,  5 Oct 2022 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664959118;
        bh=JjB7QjPVEON71kJgMWNMrM5Vp4XIPTPQ3UHo6C64Ifw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cy2Wt8W+wbZcyadtHHWp3IDfaxRNYNWY46CaduuEDoZRqsrWRKdnDzgdD8FZQyest
         N+eqJcO7zzkyU0Svg2lWV7sIlJobymEGkbIcKKkBlDqmhoJWDAOLIOtJ7RMP0jx8ZV
         XjrmzIl3EWMeObWUo2nZkgMbWmzFR7xyaLiGMkLvmGpXTL54dr0Kovu9EzvkZIulth
         XNNTwrc9hIeKIz5agt6pK8hU1yMzOmwBjIsM2gdB3Hkg8ZfRDU/VPfp2T6UaNVlDdy
         R0YoDo1cPxG7pR5W7e8Y5QArdRNCKW5KFtVrSV6Sr6soIMLMqVyIcJA/ZS232D1R4c
         uLmnAKWA+GzIA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Wireless workshop at Netdevconf 0x16, Lisbon 2022
References: <8735c3r8wt.fsf@kernel.org> <871qrnk6sy.fsf@toke.dk>
Date:   Wed, 05 Oct 2022 11:38:34 +0300
In-Reply-To: <871qrnk6sy.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Tue, 04 Oct 2022 16:22:05 +0200")
Message-ID: <87tu4ipsvp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> We're going to hold a Wireless workshop during Netdevconf 0x16 in
>> Lisbon, Portugal:
>>
>> https://netdevconf.info/0x16/session.html?Wireless-Workshop
>>
>> The schedule is not published yet but we have requested it to be on
>> Tuesday October 25th, though the date will be confirmed once the
>> schedule is publically available.
>>
>> As usual we have set up a wiki page for the event:
>>
>> https://wireless.wiki.kernel.org/en/developers/summits/lisbon-2022
>>
>> Everyone are welcome to join, but a registration to the conference is
>> required. We ask people to add their name to the wiki if you are
>> planning to come. Feel free to add any topics you want to discuss,
>> presentations are also very welcome.
>>
>> We hope to see you there,
>
> Will it be possible to participate remotely (seeing as it's billed as a
> hybrid conference this year)? :)

I don't actually know :) We were focusing on meeting live so never
investigated if it's possible to join remotely or not.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
