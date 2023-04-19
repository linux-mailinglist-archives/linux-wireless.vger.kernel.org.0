Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F96E7275
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 06:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjDSEzD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 00:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDSEzB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 00:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE64C19
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 21:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439DA63AFB
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 04:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE69C433EF;
        Wed, 19 Apr 2023 04:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681880099;
        bh=3PJZxcUeqzMFI3HlAU9c6Mj3IIrzD158uYoR+2ALI4g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sFaJ2JWfdrJuREJSGrvFsLwOM7VtIQSGz+UFc4LEZ4lZCN4CPFYjEhh0G11N+Y6RN
         IDCaftOu1pT9t3XtlTZMoIPeZdTcheQ6FTD/epsQP+yEzYYI9ye1o2Fstedd/4CqOv
         Ep8nUJawzp39f7pejsjziYW20sDaGRhdo9rh4KsiJ9POMNGD0ZyJV2hyvaF+gB3MC5
         dF+f/hXNgawcb8oP3iJfm69rRXwyBlU37PoOMFRgwU0Fs6ddL7Z805T6Vo2zVbIcnj
         fCTyGQNzSwzJZcowfBn6T/NrLNSF5Yij1j72qW93Xwj+7ATxmcUg9+NMOsjSUjjTGa
         /chIdU7whxMFw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: Don't mark channelmap stack variable read-only in ath9k_mci_update_wlan_channels()
References: <20230413214118.153781-1-toke@toke.dk> <87v8hysrzx.fsf@kernel.org>
        <87bkjqzrdm.fsf@toke.dk> <87edom7i6i.fsf@kernel.org>
        <877cu9wl7r.fsf@toke.dk>
Date:   Wed, 19 Apr 2023 07:54:53 +0300
In-Reply-To: <877cu9wl7r.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Tue, 18 Apr 2023 12:14:48 +0200")
Message-ID: <87zg74v5cy.fsf@kernel.org>
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

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

>>> Anyway, cf the bugzilla this was a pretty bad regression for 6.2, so
>>> would be good to move this along reasonably quickly (although I guess we
>>> just missed the -net PR for rc7)...
>>
>> I'm not planning to send anymore stuff to v6.3 so my plan is to take
>> this to -next. The merge window is very close anyway so this shouldn't
>> cause too much delay.
>
> Hmm, okay, a bit unfortunate that we'll ship 6.3 with the same bug

Yeah, it is unfortunate. But it is always a question of time :) To save
time I usually try to send two wireless tree pull requests per cycle,
one early in the cycle and the second around the middle.

> but if it goes in during the merge window, I guess we'll get the fix
> into 6.3.1 (or something close to that) via stable? I can live with
> that...

Yeah, that's what I'm hoping as well. The patch has cc stable so I
assume it should go quickly to stable releases.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
