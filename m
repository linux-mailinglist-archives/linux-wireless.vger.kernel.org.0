Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BD5B0783
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIGOwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIGOwK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 10:52:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6090A8CF7
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 07:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52667B81D78
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 14:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD88C433D6;
        Wed,  7 Sep 2022 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662562326;
        bh=hNX6u9VQGjSjzDeyqbMU5QyTbDfWFhE3B+VMFKnQlo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5rHwJHLKY3iLk32Yj7U8ZjrkNRf7e9vDEEwmcwl8XwiMvQt/25jB4wnQ9d1PtFeC
         WFUK1U0o6cqBIPpmUYRwavImE2l0296tfpFNQJmRoHNJZF2YX/oJGIKOfC6e6Isnks
         c1awQX1kkws4+ae6TH9iAU05WIvxTO6KanCB2Hg8lNGriqjyMcpINF7kyx/X6RfgAS
         XW+8WQEaHtZyK9IEIsHpU9qcVajsHnEB645MuFnkOUxZqwm7QuHqpWKLFAw1qfjKms
         tEMw9SPuLfFeUBH3Wrsr3PiROd+DbjZdJHiSEcKl3kL3hCMS+mdc/FqPwl3JANC9PC
         OtHsDWftdAHfA==
Date:   Wed, 7 Sep 2022 09:52:04 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Brazil (BR)
Message-ID: <YxiwFLWhsOtJJhrq@do-x1extreme>
References: <20220901232734.5488-1-cesarb@cesarb.eti.br>
 <b8674e67fee2393d4c5fe9d9842028545c6adcfa.camel@sipsolutions.net>
 <6b577581-9daf-ff11-1aaa-ff1243eb9c03@cesarb.eti.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b577581-9daf-ff11-1aaa-ff1243eb9c03@cesarb.eti.br>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Sep 02, 2022 at 07:21:50PM -0300, Cesar Eduardo Barros wrote:
> Em 02/09/2022 11:53, Johannes Berg escreveu:
> > On Thu, 2022-09-01 at 20:27 -0300, Cesar Eduardo Barros wrote:
> > > 
> > > +	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
> > > +	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
> > > +	# requirements, we can extend the range by 5 MHz to make the kernel
> > > +	# happy and be able to use channel 144.
> > > +	(5470 - 5730 @ 160), (27), DFS
> > > +	(5730 - 5850 @ 80), (30)
> > > 
> > 
> > If you do the latter as 160 as well, and add AUTO-BW, couldn't you split
> > them at 5725 correctly? But I guess it doesn't matter anyway.
> 
> This was copied from the US rules (including the four-line comment), which
> have an identical split. If AUTO-BW worked here, I'd expect the US rules to
> use it.

AUTO-BW would work, and we have countries using it for this case. Iirc
for some countries we move the split to 5730 because even though
5725-5730 is at a lower power limit the rules allow channel 144 to be
used at the power limit for 5710-5725. For the US though I think it's
just historical -- it was done that way initially, and it isn't
important enough that anyone has cared to change it.

But we do generally try to keep the rules matching the official
documents as much as possible, so for new rules we should split at 5725
and use AUTO-BW as Johannes suggested. Could you send a v2 with that
change?

Thanks,
Seth
