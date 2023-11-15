Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C097EBE2B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 08:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjKOHfH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 02:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHfG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 02:35:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688C1E1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 23:35:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2865C433C9;
        Wed, 15 Nov 2023 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700033702;
        bh=GT0hEbHcdnhV9E8kQMfoo+S3PpKbshnIluX+ZHX2Jx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUBxUm0pK97Aj7nnaMJh/hTbtCEvoT8dVr5yM1ias4rduvE8PGNJREA+9Vrt+dgOW
         +kKH5gNLjTAAayCteZD/XkSSxTngPbxMOWEaEsipDJhJ2REOUjUVFKEGsOmyrIYF77
         ri2qNbfMtoXZaQR2OmxcyS+agb4+kbSpfGK7uCCVNGBqUWN0Fe4R6zdrXFGg+h2gsA
         OCvZxvuUps9ZVLrZLhGxNEs6sXTyE9KkuueRl4Cyx2xYnFka2b2Tu26DEy1Me/y8dz
         Kvqt1wb6GBseqkan97QMwT4og26+hJ2qUMEAk+UL7+rBl9qPUbsDE3tCij+aP7rUIt
         F4nQxLZ8zEhhg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3AQN-0000H1-0L;
        Wed, 15 Nov 2023 08:34:59 +0100
Date:   Wed, 15 Nov 2023 08:34:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: wifi: mac80211: lockdep splat with 6.7-rc1
Message-ID: <ZVR0o7Jvp6-zCS7R@hovoldconsulting.com>
References: <ZVOXX6qg4vXEx8dX@hovoldconsulting.com>
 <02159e92fd1d9a6fd993ae9f913c7ed756b6d3ac.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02159e92fd1d9a6fd993ae9f913c7ed756b6d3ac.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 14, 2023 at 06:02:33PM +0100, Johannes Berg wrote:
> On Tue, 2023-11-14 at 16:50 +0100, Johan Hovold wrote:

> > Naively adding locking around the call in ieee80211_get_tx_power()
> > (e.g. similar to 6b348f6e34ce ("wifi: mac80211: ethtool: always hold
> > wiphy mutex")) does not work as there are other paths that call this
> > function with the lock held, specifically via ieee80211_register_hw().
> 
> The latter we can just take the lock I guess?

ieee80211_register_hw() is specifically already taking the lock. 
 
> > [    7.127780]  ieee80211_get_tx_power+0x19c/0x1c0 [mac80211]
> > [    7.127859]  nl80211_send_iface+0x208/0x6a4 [cfg80211]
> > [    7.127946]  nl80211_dump_interface+0x120/0x254 [cfg80211]
> 
> And here maybe we should just take the mutex at the nl80211 level.

Yeah, it looks like you can possibly add it to nl80211_dump_interface().

nl80211_send_iface() is already called in paths like:

    ieee80211_get_tx_power+0x28/0x1c0 [mac80211]
    nl80211_send_iface+0x208/0x6a4 [cfg80211]
    nl80211_notify_iface+0x58/0xcc [cfg80211]
    cfg80211_register_wdev+0xa0/0x12c [cfg80211]
    cfg80211_register_netdevice+0x7c/0x108 [cfg80211]
    ieee80211_if_add+0x4b0/0x5cc [mac80211]
    ieee80211_register_hw+0xbec/0xc2c [mac80211]

> That's the nice thing now, it's shared between the layers :)
> 
> I can't do it right now, but I'll take a look tomorrow.

Sounds good, thanks.

Johan
