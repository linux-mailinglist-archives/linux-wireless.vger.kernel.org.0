Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BB15B46E1
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Sep 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIJOkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Sep 2022 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJOkK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Sep 2022 10:40:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF81B79D
        for <linux-wireless@vger.kernel.org>; Sat, 10 Sep 2022 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=uxXHo+57vGn5rNy0DagodXOkNHFgNyWJIScqOhho82Q=;
        t=1662820809; x=1664030409; b=SKKgLI6dawaH/kEZQ/AgL4NOKFLHSOWAoEyZjrJyvAOUXIg
        wm7oqQViDsWlnIwiRXuhAjYc41l8rCiD/f18p4UBrsNLGaHsh2Fj5ZqGiNM60DgE31N9YQisdugui
        vQdhSSOObjaFy+HVJqem5dtAvXHL4rQItqTJQ9w2Mbd5ORUr5ns7wrYzNEQdIJL8v+KCHDc6eyDX7
        DPxbKngeLwkhEOLlpLuSQr8HxrS6qzLJUdszCuTjuAVJNHvsT2CfvfAjyodHy4IAvawEDEDtIwZbz
        8hZmFQj8fiY8cqc4NLZmKc5PciKvYtawI+KRndvQYFhFj+NrdupyyZtwfprcsQoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oX1eR-00D1nH-2S;
        Sat, 10 Sep 2022 16:40:07 +0200
Message-ID: <eb45389d863594e04e06147f67f451491164f0ef.camel@sipsolutions.net>
Subject: Re: [PATCH 07/12] wifi: mwifiex: fix array of flexible structures
 warnings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 10 Sep 2022 16:40:06 +0200
In-Reply-To: <Yxul5PfKtIL6tHVA@google.com>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
         <20220904212910.2c885310ebee.If7177ea588b56c405eee6e6df595e9efccdfb99a@changeid>
         <YxfHwxuwEP1rQoAU@google.com>
         <b6f5ad5b9a50fd26838c019921f3ace1e739f9b8.camel@sipsolutions.net>
         <Yxul5PfKtIL6tHVA@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-09-09 at 13:45 -0700, Brian Norris wrote:

> > I think gcc also has one with W=3D1 now?
> >=20
> > But yes, it's similar to that one. I was looking at Jakub's netdev test
> > builds here:
> >=20
> > https://patchwork.hopto.org/static/nipa/673828/12964988/build_32bit/std=
err
> >=20
> > ../drivers/net/wireless/marvell/mwifiex/fw.h:2107:46: warning: array of=
 flexible structures
> > ../drivers/net/wireless/marvell/mwifiex/fw.h:2257:47: warning: array of=
 flexible structures
>=20
> I think you're actually looking at a sparse warning:
>=20
> https://lore.kernel.org/linux-sparse/20200930231828.66751-12-luc.vanooste=
nryck@gmail.com/
>=20
> I can convince clang to enable the warning I mentioned, but it's not on
> by default, even with W=3D1. When enabled, it complains similarly, as wel=
l
> as about a ton of other code too.

Hm. I _think_ I saw it locally with just W=3D1, not C=3D1, but then that
would've been with gcc, probably 12.2 from Fedora. But I didn't try
again now, don't have much time.

> I suppose this warning makes sense when you're truly treating these as
> arrays (of size more than 1). And in this case (mwifiex_cmd_mef_cfg()
> and mwifiex_cmd_append_rpn_expression()), the code to (mostly?) properly
> handle the flexible array is pretty ugly anyway, and doesn't really use
> the type safety much (lots of casting through u8* and similar). So this
> isn't really the best example to try to retain.

Heh, fair point.

> (mwifiex_cmd_coalesce_cfg() has some similarly ugly casting and math.)

Yeah it kind of has to though, given that it's a variable-sized buffer
with variable-sized entries...

> But if the "array" is just an optional extension to a struct, and we
> expect at most a single element, then I don't think the construct is
> fundamentally wrong. It might still be hard to get correct in all cases
> (e.g., ensuring the right buffer size), but it still feels like a decent
> way to describe things.

Fair enough. It's like 0 or 1, maybe, but of course there's no way to
describe that to the compiler and say "I promise to never access [1] (or
higher)" :)

I guess the only real alternative would be to leave it as a _single_
entry, and then fix up all the sizeof() of the containing struct, if
any, to be offsetof(..., first_entry).

But that sort of describes a single entry should be present, which it
might not be.

> After a little more look, I'm fine with this patch. I'd probably
> appreciate it better if there was a comment of some kind in the struct
> definition, and perhaps mention sparse's -Wflexible-array-array.
>=20

Sure, I guess it makes sense to also figure out more precisely where the
warning appeared.

I'm running off for a trip for two weeks now-ish, so not going to send
it in the short term. If you wanted to do it instead, no objections, or
if Kalle wants to just add a comment while applying, or whatever.

In any case there are so many warnings in the drivers that still ought
to _have_ a maintainer (and I'm squinting at you for ath too, Kalle)
that it's pretty much irrelevant to fix this one quickly ;-)

johannes
