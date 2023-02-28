Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0AE6A52FB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 07:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjB1G3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 01:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjB1G3d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 01:29:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F71DBA4
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 22:29:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D30AFB80DF1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 06:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FECC433D2;
        Tue, 28 Feb 2023 06:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677565768;
        bh=XNfiNRnZLrr/LFiCRYOmIrI7xVaZWSlgf3YXafvV4ME=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dWvnUwynQfzDFMWIPpS2VqjmOKv0kK836cxBNlXeIz2CN0lPdn+rq4B7cBaCxUv6a
         E+eWm6tMswg+HjTdjVMIVCsL6hJSYRdigwcOt0u8bqrF1A3qYjtUKtVBbqkCFjoWEC
         mBk+Bxs3e0/C2enZsvgVXkkDuzaV4d6b43C8fbifESAcCOL187y/6XThO7YwRouKDs
         K3wEiolFCwgjQKqSdO4QbFFIgZTbxHfojD845cIkeayN6GLh7tcQ9YTso04wPGZMf2
         ZIlzRrMImbRhMGhxdJIow7LVlPK3CEptP1+X60QpxEPX+EJN+/63y4nj5G1aTOmRmo
         pKmM6rwKQO4pw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Williams <dcbw@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy directory
References: <20230227121732.8967-1-kvalo@kernel.org>
        <20230227121732.8967-3-kvalo@kernel.org>
        <cc905b745580b0300d10f1f88d714305c7544f67.camel@redhat.com>
        <87ilfmrkil.fsf@kernel.org>
        <c3f831e111e056c32f1822dde602e48eb764ea4f.camel@redhat.com>
Date:   Tue, 28 Feb 2023 08:29:22 +0200
In-Reply-To: <c3f831e111e056c32f1822dde602e48eb764ea4f.camel@redhat.com> (Dan
        Williams's message of "Mon, 27 Feb 2023 15:01:03 -0600")
Message-ID: <87cz5u1ewt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Williams <dcbw@redhat.com> writes:

> On Mon, 2023-02-27 at 21:11 +0200, Kalle Valo wrote:
>> Dan Williams <dcbw@redhat.com> writes:
>> 
>> > On Mon, 2023-02-27 at 14:17 +0200, Kalle Valo wrote:
>> > > To clean up drivers/net/wireless move the old drivers drivers
>> > > left in
>> > > the
>> > > directory to a new "legacy" directory. I did consider adding
>> > > CONFIG_WLAN_VENDOR_LEGACY like other vendors have but then
>> > > dropped
>> > > the idea as
>> > > these are really old drivers and hopefully we get to remove them
>> > > soon.
>> > 
>> > Why is rndis_wlan legacy? It supports devices that are way newer
>> > than
>> > ray_cs or wl3501... like this Linksys WUSB54GSC from late 2007:
>> > 
>> > [1086339.589565] rndis_wlan 1-3:1.0 wlan0: register 'rndis_wlan' at
>> > usb-0000:00:14.0-3, Wireless RNDIS device, BCM4320b based,
>> > 00:1d:7e:9e:2f:bb
>> > [1086339.589961] usbcore: registered new interface driver
>> > rndis_wlan
>> 
>> So you have this device? Does it work? I think I should make a table
>> somewhere for these old drivers with last success reports :)
>
> Yep, I have it, it works. Needless to say, I don't *use* it.

Yeah, I guessed that part :) But thanks for testing, good to know it
works.

>> > Dunno, just seems a completely different class of devices than old
>> > 802.11b-only PCMCIA ones...
>> 
>> I was about to say that all drivers using Wireless Extensions are
>> legacy, but to my surprise rndis_wlan actually uses cfg80211 :)
>> 
>> I put this to "legacy" as I didn't find any better location and
>> adding a
>> new vendor driver just for rndis_wlan felt like overkill. The
>> directory
>> name "legacy" is just a name, it has no real meaning and users won't
>> see
>> it either. It could be "misc", "old" or something else as well.
>
> Is the goal just to get all the .c individual drivers out of
> net/wireless? 

Yes, exactly. The extra files in drivers/net/wireless annoy me everytime
when I'm checking something in the tree.

> Also isn't Greg KH out to kill RNDIS too? I don't recall that being a
> settled question yet, but I lost track.

I haven't heard anything about that recently, I hope we don't have to
remove rndis_wlan from the tree. But wext drivers are another thing, we
really should get rid of them (or convert to cfg80211).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
