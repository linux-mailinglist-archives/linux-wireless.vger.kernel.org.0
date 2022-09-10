Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D095B46D1
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Sep 2022 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIJOei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Sep 2022 10:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIJOeP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Sep 2022 10:34:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC752DEE
        for <linux-wireless@vger.kernel.org>; Sat, 10 Sep 2022 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yIUtt9DtQzamFmV3UNKESYszcnwOY+XRpFwUQuEzgeM=;
        t=1662820437; x=1664030037; b=J7UJp6L9I0SeO8cjke6mdCv1I94+mjN1OXF7AWgDtbJxoPQ
        o6ic+un2sy0tIDm5psjXn0SLy2fYA2igtHa0GL8vWDS43MJHsMXb+C7XGR2jHGeuhnpxRqEnLnB6m
        hHrnVtUzbnlcZjn/r8ngArydwTrn/mSRF+8gc/CRZVD4sWDBcq2asczVRAIT0i86mrdVv5/N3N7yR
        5JnZ2pLOeadvHidBJqn3FEkkKmxNfuvUQOL1QbI/rKCp2p0bH1wZ25rV/BnxpJmp7BjohLgGwibf+
        zeoB2KX2IHjAvgBjCa2LjLuHkLljZx4Bz80PHMJvBDKdIV8KuZo8O0lzoeBVrcIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oX1YL-00D1g4-0W;
        Sat, 10 Sep 2022 16:33:49 +0200
Message-ID: <5d5e40bc5c6075c8fbc5e836f42f7a6398dcbf1a.camel@sipsolutions.net>
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory
 rules for Brazil (BR)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>,
        Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Sat, 10 Sep 2022 16:33:48 +0200
In-Reply-To: <e55819d3-cc2f-23ac-4b40-bdd1fd8e6b68@cesarb.eti.br>
References: <20220901232734.5488-1-cesarb@cesarb.eti.br>
         <b8674e67fee2393d4c5fe9d9842028545c6adcfa.camel@sipsolutions.net>
         <6b577581-9daf-ff11-1aaa-ff1243eb9c03@cesarb.eti.br>
         <YxiwFLWhsOtJJhrq@do-x1extreme>
         <7c7135cb-ee5d-e7f3-45ca-8b7206312512@cesarb.eti.br>
         <Yxs9pmL7Efl+EPxe@do-x1extreme>
         <e55819d3-cc2f-23ac-4b40-bdd1fd8e6b68@cesarb.eti.br>
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

On Fri, 2022-09-09 at 19:29 -0300, Cesar Eduardo Barros wrote:
>=20
>  From my quick look, it seems that it would set a NO-160MHZ flag in the=
=20
> rule, which would then propagate to each 20MHz sub-channel, and probably=
=20
> would lead to it rejecting the use of the whole as a 160MHz channel; but=
=20
> there's also the 80+80 mode, which would still be allowed (and I vaguely=
=20
> recall seeing somewhere that adjacent 80+80 was prefered over 160 for=20
> some reason).

Much hardware doesn't support it though. I guess it might be easier to
do separate CCA in that case? Dunno.

Anyway.

> Unfortunately, I don't have any hardware which can use 160MHz channels;=
=20
> it's only last month that I upgraded my AP to one which can use 80MHz=20
> channels (which is what led me to looking into all this stuff).
>=20

Really what I wanted to say is that you should be able to compile a
kernel with e.g. ARCH=3Dum per the instructions at

https://w1.fi/cgit/hostap/tree/tests/hwsim/vm/README

and then test it all in "userspace" with hwsim in the userspace kernel.

johannes
