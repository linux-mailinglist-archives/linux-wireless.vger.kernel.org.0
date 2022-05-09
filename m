Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0174F52027F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiEIQhc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiEIQh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 12:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F46028E4F1
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 09:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FD7610A7
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 16:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430D9C385AC;
        Mon,  9 May 2022 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652114014;
        bh=B1chrPx7TF49pqHNpGklvH2y5CKzJcobsy88wu1g4P4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bxt1eWUSI3/94y7DIDR6owK/VIY4z2F6Ydqzhj5KOrmQHBdNuVGAz10gd3DBzQc+i
         uf6qb8hlgzMvV2kOaFJ/ymy61sfIQ3womGif3wQltTRPbMjrl2nRS1Iyb42L9Z+hgZ
         w9zNG8wfTASPKYdxnGSBobJlo2MFCxyra08Tfsp9pDuwHIc6OtG6L7Vq+aFYwlaSDO
         E9FtArq67KAMOXLJXTtxvWi1khjmvHJmkJvHpuz92PjnjQVARZ/QWRBMV9Svqm/a2H
         Lw6Vi5KDhgloWv9AmHe8eM11TZCfpCmzS3Zpf+krvsKmf+hknDfcFOEaRHeCMyci0o
         +ObQXN9cRuUwQ==
Date:   Mon, 9 May 2022 09:33:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] wifi: netif_napi_add() conversions
Message-ID: <20220509093333.2c913702@kernel.org>
In-Reply-To: <87pmkn7ybp.fsf@kernel.org>
References: <20220504163316.549648-1-kuba@kernel.org>
        <87a6bwzjvk.fsf@kernel.org>
        <20220505085418.5384f6c9@kernel.org>
        <87pmkn7ybp.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 09 May 2022 14:14:02 +0300 Kalle Valo wrote:
> > 1) When I send PRs to Linus I always wonder how much he can 
> > make out of the shortlog. And if people throw "net:" into the mix
> > whether it's still clear when something is "just" a driver bug vs
> > a core bug affecting everyone. So I started using "eth: " for ethernet
> > drivers, and "wifi: " for wireless drivers in the text of the PRs.
> >
> > 2) For people doing backporting the driver names may not be meaningful,
> > but if I'm doing backports for a datacenter kernel I know to pay
> > attention to "eth:" while "wifi:" I can safely skip.  
> 
> Is there a specific reason why you use "wifi:" and not "wireless:"? I
> admit the term wireless is not great for our 802.11 subsystem but that
> has been used as long as I know.

Right, I take the liberty of using wifi in PR texts since it seems most
appropriate as none of the low range or WWAN drivers go via the
wireless tree.

> > 3) The case of this set - I have conversions for the entire tree queued
> > up on a branch, it's quite useful for me to use a common area-specific
> > prefix to see what goes were.
> >
> > Anyway, that's just me rambling. I hope you don't mind if I send things
> > with a wifi prefix from time to time given it's a convenient way for me
> > to mark the queued patches.  
> 
> I don't mind if you submit with "wifi:", it's easy to edit patches with
> my patchwork script during commit :) And if there's a strong need I
> think we can change our title scheme in wireless patches. This has come
> before but I have always resisted due to extra work involved. To me most
> important is consistency within wireless subsystem, if different
> wireless drivers (and stack) use a different scheme when the logs will
> become hard to read. So I would hope everyone can agree to the new
> scheme.

No need to change the scheme overall. What you use now is the most
prevalent in the tree so I'm probably overthinking.
