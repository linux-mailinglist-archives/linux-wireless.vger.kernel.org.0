Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B53B6E9798
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjDTOud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjDTOub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 10:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF90B423C
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 07:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D9A64A1D
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 14:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A66EC433D2;
        Thu, 20 Apr 2023 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682002228;
        bh=QLpioOM2xDs7Nu16FxqjLQDOOiW2aRAaJmsjZVLMpGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AzyqctDpReLH6470Ah25ySoYWd+ybvb0eSRvoAdZVbzAF0xjg53feLcRT8vk3+WDL
         gbTbIa69yj5JYhKdig2JZ+xz9ZjPx61dJTdLiz92z3/BtfFKHKU0Fc1rnAL/ZOiR2Y
         YVMyumSdhPfQv0Zdrm93c0GDVFIk84DE1HsuCX/nWuyZgC3z9aXaIYauqembFDd8do
         NqNyOpuQmk+hX04RkKrc2nu77rp8vvrQo1TnhSOqYR/hwjFy93JAbEwwqalo5TWmr4
         ohLle9MOwB9p1TE2CmXnpiX+OLJ1VgygNy8HaTS5PrZeXM2K8RV0S/ctYDCL+GuB4J
         OQmDjC7/Q9pFQ==
Date:   Thu, 20 Apr 2023 07:50:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-wireless@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] wifi: ath9k: Don't mark channelmap stack variable
 read-only in ath9k_mci_update_wlan_channels()
Message-ID: <20230420075027.6852197a@kernel.org>
In-Reply-To: <87edoetyve.fsf@toke.dk>
References: <20230413214118.153781-1-toke@toke.dk>
        <87v8hysrzx.fsf@kernel.org>
        <87bkjqzrdm.fsf@toke.dk>
        <87edom7i6i.fsf@kernel.org>
        <877cu9wl7r.fsf@toke.dk>
        <87zg74v5cy.fsf@kernel.org>
        <f4939cb3-bc01-c9e1-aac9-2adb554bc3c4@leemhuis.info>
        <87edoetyve.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 20 Apr 2023 16:24:53 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> But it is always a question of time :) To save
> >> time I usually try to send two wireless tree pull requests per cycle,
> >> one early in the cycle and the second around the middle. =20
> >
> > Why not ask Linus to pull this directly from the list then?

Out of curiosity, Thorsten, do you have stats on "how long does it take
fixes to reach Linus" per tree? Stats get people to act much quicker
than pleas, just sayin' ;)

> > He doesn't
> > mind doing that for an occasional regression fix. And then he can decide
> > himself if the change is worth the risk -- and obviously can take into
> > account if he'll release and rc8 or not. =20
>=20
> I'm OK with doing it that way; I'll do so later tonight unless Kalle or
> Jakub complains before then...

Ah, just after our last(?) 6.3 PR was submitted :(
No objections to you posting this directly to Linus...

That said it is a 6.2 regression AFAICT so it's not exactly in the
"must be fixed in 6.3" category. Assuming Kalle doesn't want a PR -
should we take it into net and have it reach Linus either next Tue
(assuming no -rc8) or Thu (if -rc8)?
