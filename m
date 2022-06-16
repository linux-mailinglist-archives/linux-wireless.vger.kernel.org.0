Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9C54E9B4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jun 2022 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377642AbiFPS6N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jun 2022 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiFPS6N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jun 2022 14:58:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B830D1D0CC
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 11:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D3D1B82579
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jun 2022 18:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDF4C34114;
        Thu, 16 Jun 2022 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655405889;
        bh=+33FWUswMZscBh+jqBDYywCE5EEwigUEJN3lzcTaQP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iMNwklE4d1/OJsJ14nWiP9dvfrpXeFB1b6JjxYF/Wt8MKVgnfwOFyKcoeoQIkPkBA
         6/vb0cYHLPsNkqu7gDJGTEYkGghkmpSprBZ1UUJQOINzwWKVJTAw86MrkR3Fc1EpYz
         fTLq9+CpEfHG1I5eVQnJJuBO0SGXK8bOMItLriOA2RmefkrIgBa1dSYEn8Hef24WzC
         0gCm6ADEa7vFKy5lfW1ys3SUXiEB4yrrKnEzf5Stiw4ntBF5r6SVDZ5EHldgcO2top
         gdfxAdxedvHTzu3AMeGuU5OBIFU+G0DMOWHsLiKF7ebnfuhtAZioGo/JV4chChWXbh
         KTr5bFwaQHwXw==
Date:   Thu, 16 Jun 2022 11:58:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     golan.ben.ami@intel.com, Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Udo Steinberg <udo@hypervisor.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Bug 215635 - iwlwifi: Firmware crash with firmware
 36.ca7b901d.0 (8265-36.ucode)
Message-ID: <20220616115808.141dec76@kernel.org>
In-Reply-To: <915d6d66-4e42-8cbf-76bc-0f2f72d5e7d6@leemhuis.info>
References: <915d6d66-4e42-8cbf-76bc-0f2f72d5e7d6@leemhuis.info>
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

On Mon, 14 Mar 2022 12:51:38 +0100 Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics isn't
> properly handled, that's why I decided to forward it to the lists and a
> few relevant people to the CC. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=215635 :
> 
> > Seeing the following firmware crash frequently with
> > firmware-version: 36.ca7b901d.0 8265-36.ucode
> > 
> > [...]
> > 
> > Afterwards iwlwifi is entirely unusable, i.e. the hardware does not recover.  
> 
> > I have not been able to observe the problem with 5.15.x so far.
> > 
> > The problem manifests either by Wi-Fi becoming entirely unresponsive (not even ping to gateway works anymore) or by producing a firmware crash.
> > 
> > In response to #3, the problem was most recently observed as a firmware crash on Linux 5.16.13. HW is Intel Corporation Wireless 8265 / 8275 (rev 78) (Windstorm Peak) and firmware version 36.ca7b901d.0 8265-36.ucode.
> > 
> > I'm attaching the dmesg output from 5.16.13 (with the TWT patch mentioned above applied) which includes a firmware crash.  
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?

Any progress / outputs on this one? Folks are reporting it's still
happening on Fedora 36 w/ 5.17.13.
