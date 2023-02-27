Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298636A4A9E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 20:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjB0TLg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 14:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjB0TLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 14:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468BE252AE
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 11:11:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E301260F10
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 19:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7F3C433EF;
        Mon, 27 Feb 2023 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677525093;
        bh=snse9Hh4M+t2+hwCHCzJjsa8eWwJKzEd2ObSikJNQn8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rmBQ2UFivF2P0lcu66iM1bbgEmsfGHuYuM5wocX4cvIdmvk2tDLI8hXrGiH1RcvK8
         2PlCMocsoPG7erHAeofge2Q8dSKqBsDHse+O1QkmpKchcwMNDfFO+ehsRzC/FDRl7x
         RyY6CRqJTrESBJYxPjQjZr1MNOo3TV1ZKiFKqzaHrSy91A710fBnhg31EwpdXW8Giw
         9wO13auE014ug3xJl/S5k+Ts2vbfemKZKn9/1QcBXzbWovSPt+/7BxQc8f9FmZ95e7
         PHSve+6TLy+tnv14nJHe2BqbdCo5VxuJhsvDR3BzPQ9pyY2fXoPhEQ/F6gjoD4+/Q4
         33uk7yRBBXt1g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Williams <dcbw@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: move raycs, wl3501 and rndis_wlan to legacy directory
References: <20230227121732.8967-1-kvalo@kernel.org>
        <20230227121732.8967-3-kvalo@kernel.org>
        <cc905b745580b0300d10f1f88d714305c7544f67.camel@redhat.com>
Date:   Mon, 27 Feb 2023 21:11:30 +0200
In-Reply-To: <cc905b745580b0300d10f1f88d714305c7544f67.camel@redhat.com> (Dan
        Williams's message of "Mon, 27 Feb 2023 12:09:06 -0600")
Message-ID: <87ilfmrkil.fsf@kernel.org>
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

> On Mon, 2023-02-27 at 14:17 +0200, Kalle Valo wrote:
>> To clean up drivers/net/wireless move the old drivers drivers left in
>> the
>> directory to a new "legacy" directory. I did consider adding
>> CONFIG_WLAN_VENDOR_LEGACY like other vendors have but then dropped
>> the idea as
>> these are really old drivers and hopefully we get to remove them
>> soon.
>
> Why is rndis_wlan legacy? It supports devices that are way newer than
> ray_cs or wl3501... like this Linksys WUSB54GSC from late 2007:
>
> [1086339.589565] rndis_wlan 1-3:1.0 wlan0: register 'rndis_wlan' at
> usb-0000:00:14.0-3, Wireless RNDIS device, BCM4320b based,
> 00:1d:7e:9e:2f:bb
> [1086339.589961] usbcore: registered new interface driver rndis_wlan

So you have this device? Does it work? I think I should make a table
somewhere for these old drivers with last success reports :)

> Dunno, just seems a completely different class of devices than old
> 802.11b-only PCMCIA ones...

I was about to say that all drivers using Wireless Extensions are
legacy, but to my surprise rndis_wlan actually uses cfg80211 :)

I put this to "legacy" as I didn't find any better location and adding a
new vendor driver just for rndis_wlan felt like overkill. The directory
name "legacy" is just a name, it has no real meaning and users won't see
it either. It could be "misc", "old" or something else as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
