Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E9D5B2E3B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 07:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIIFms (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 01:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiIIFmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 01:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B754915F1
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 22:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB65A61E9E
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 05:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13883C433C1;
        Fri,  9 Sep 2022 05:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662702165;
        bh=VdNu1mgCwksv34VhvYZ/KHtQMK2h+IkfWYxYpue5Eo8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IZXY+IRmMmW5mtkCmMN1JyMsbNTWeAS0+6k1n84yWyHZNssdC8ysjw9wTcnIyoQZI
         ewX5iq/qsjvZjuKEY1pxDaRQ9Uf7Z7FtVRaUY01EX1ilKNwdKzAWy1d/upGRLxdCOw
         X7610pb4vnOWNqk/7SarQ7CMM+MUkYQUOskiB8QRlAh9VaOh2VCcPO7bapZWgVHLQo
         SAOgxkYMQ5VXzFLGtnFRvv0abJ5EqAffW4Z0WWXtO24/fhaD4kNy94ObbdEgpNGObj
         qhf8fmp8w9gFM6tLp4jEVLjSu4zJngekyhpCxAL4j4+/13wESCqm5JmbfDJo7bns1c
         gagXo7EzzFWqw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>,
        linux-wireless@vger.kernel.org,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgen?= =?utf-8?Q?sen?= 
        <toke@redhat.com>
Subject: Re: [PATCH] iwlwifi: Mark IWLMEI as broken
References: <20220907134450.1183045-1-toke@toke.dk>
Date:   Fri, 09 Sep 2022 08:42:38 +0300
In-Reply-To: <20220907134450.1183045-1-toke@toke.dk> ("Toke
        \=\?utf-8\?Q\?H\=C3\=B8iland-J\=C3\=B8rgensen\=22's\?\= message of "Wed, 7 Sep 2022
 15:44:50 +0200")
Message-ID: <87k06daysx.fsf@kernel.org>
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

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> The iwlmei driver breaks iwlwifi when returning from suspend; the bug
> report[0] has been open for four months now, and now fix seems to be

s/now/no/? I can fix that.

> forthcoming. Since just disabling the iwlmei driver works as a workaround,
> let's mark the config option as broken until it can be fixed properly.
>
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D215937

So does the bug only happen with iwd? Should I mention that in the
commit log? It would be good to describe the conditions when the bug
happens.

> Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation w=
ith CSME")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

I assigned the patch to me on patchwork and will queue for v6.0.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
