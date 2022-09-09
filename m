Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B075B38C4
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiIINUm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 09:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiIINUl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 09:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB45B1B98
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 06:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D2D61FC9
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 13:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190ADC433D6;
        Fri,  9 Sep 2022 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662729639;
        bh=rPg45ScDO/0JrxGIumyfY8UpIl3IIAlxLjA4fGREPHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qF2pjK8kkZ8baZvNyPPHFIJUnBT0Ld2SJXYXhN+tNll8zzRCSL/i00/p/eZ92zzcx
         5t8K3XRNSW9SeX5YwORP/vrL4TjqEhkdXQ2XiRzuQ4V6fejdGuwtoCDKnUmk1v3GdE
         vlgVtypI7yCHpRs866orrazQINLzW9yL7u7tNFJ+H9/0mnKaaijM5nfxKss3GjTSFG
         LbFpagZiKrIPvjGgEeNKB19MH+OU4pqpRNcA+49pBTnlNTaty1rqGa/NOHB/l5lp92
         rdjuG8HKORG7hyoj925PQ1hjnp9NinamFtk/WB58X4HmFlsIy9xkrUKevlH9FbbxNp
         EyNbfJchP7GXA==
Date:   Fri, 9 Sep 2022 08:20:38 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Brazil (BR)
Message-ID: <Yxs9pmL7Efl+EPxe@do-x1extreme>
References: <20220901232734.5488-1-cesarb@cesarb.eti.br>
 <b8674e67fee2393d4c5fe9d9842028545c6adcfa.camel@sipsolutions.net>
 <6b577581-9daf-ff11-1aaa-ff1243eb9c03@cesarb.eti.br>
 <YxiwFLWhsOtJJhrq@do-x1extreme>
 <7c7135cb-ee5d-e7f3-45ca-8b7206312512@cesarb.eti.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c7135cb-ee5d-e7f3-45ca-8b7206312512@cesarb.eti.br>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 07, 2022 at 05:02:01PM -0300, Cesar Eduardo Barros wrote:
> Em 07/09/2022 11:52, Seth Forshee escreveu:
> > On Fri, Sep 02, 2022 at 07:21:50PM -0300, Cesar Eduardo Barros wrote:
> > > Em 02/09/2022 11:53, Johannes Berg escreveu:
> > > > On Thu, 2022-09-01 at 20:27 -0300, Cesar Eduardo Barros wrote:
> > > > > 
> > > > > +	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
> > > > > +	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
> > > > > +	# requirements, we can extend the range by 5 MHz to make the kernel
> > > > > +	# happy and be able to use channel 144.
> > > > > +	(5470 - 5730 @ 160), (27), DFS
> > > > > +	(5730 - 5850 @ 80), (30)
> > > > > 
> > > > 
> > > > If you do the latter as 160 as well, and add AUTO-BW, couldn't you split
> > > > them at 5725 correctly? But I guess it doesn't matter anyway.
> > > 
> > > This was copied from the US rules (including the four-line comment), which
> > > have an identical split. If AUTO-BW worked here, I'd expect the US rules to
> > > use it.
> > 
> > AUTO-BW would work, and we have countries using it for this case. Iirc
> > for some countries we move the split to 5730 because even though
> > 5725-5730 is at a lower power limit the rules allow channel 144 to be
> > used at the power limit for 5710-5725. For the US though I think it's
> > just historical -- it was done that way initially, and it isn't
> > important enough that anyone has cared to change it.
> 
> The only country I found in the database that does it that way is IL, and it
> has the power limits in the opposite direction (its 5470 - 5725 range has a
> higher power limit than its 5725 - 5875 range, while for BR and US it's the
> former range which has a lower power limit); looking at other countries, AU
> does the manual adjustment with a comment like US, while TW has a 5 MHz
> overlap on its ranges. So the precedent is not enough for me to be confident
> that using the official split together with AUTO-BW would allow using
> channel 144 (and the 40 MHz and 80 MHz channels it's part of).

You're right that IL seems to be the only one using it accross channel
144. I'd thought there were others, but apparently not.

> And the single one which does it using AUTO-BW (IL) doesn't change the
> bandwidth of its 5725 - 5875 to 160; is it really necessary to do that
> change to the bandwidth (considering also that channel 144 is not part of a
> pure 160 MHz channel, it could be used only for 80+80)? What about the 5150
> - 5250 and 5250 - 5350 ranges, do they need also to be changed to 160 so
> that the combined 5170 - 5330 160 MHz channel can be used, or does AUTO-BW
> allow it even though both ranges are declared as allowing just 80 MHz
> channels? What about 80+80 channels?

You cannot change the bandwidth for 5725 - 5875 to 160; the kernel will
reject the rule since a 160 MHz channel doesn't fit in the range. The
kernel might still allow a 160 MHz channel though. I haven't looked at
this code in quite some time and it's pretty convoluted, but some of the
code does calculate a max bandwidth based on what will fit when dealing
with AUTO-BW rules.

> > But we do generally try to keep the rules matching the official
> > documents as much as possible, so for new rules we should split at 5725
> > and use AUTO-BW as Johannes suggested. Could you send a v2 with that
> > change?
> 
> Well, it's not exactly a new rule (the current database already has a 5490 -
> 5730 @ 160 rule), but we could treat it that way since we're mostly
> rewriting them all (and the original didn't say where that came from).
> 
> Since I'm not certain that AUTO-BW will be interpreted as expected, before
> doing that change, I'll try to see if I can test it first on my laptop (by
> sheer luck, I happen to be using the 5650 - 5730 80 MHz channel right now,
> so I'd just have to see if it still connects at 80 MHz, assuming I can
> somehow convince the kernel to load a modified file). Or would you prefer me
> to send the patch first (with or without a change in the channel
> bandwidths)?

I'd be interested in your results, especially if there's any way you
could test at 160 MHz bandwidth since the AUTO-BW code in the kernel is
hard to follow. Getting the kernel to trust the file is the tricky part.
It would probably be easier to convince CRDA to do it if you want to go
that route. Or if you contact me off-list I can provide a signed file
that the kernel will trust -- I'm okay with doing that in this case
since we wouldn't be trying anything which would be in violation of the
regulations.

Thanks,
Seth
