Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813B990087
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 13:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfHPLKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 07:10:53 -0400
Received: from ocelot.miegl.cz ([195.201.216.236]:60790 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfHPLKx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 07:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=miegl.cz; s=dkim;
        t=1565953850; bh=U5QNjjmSjPR1Tc6nSH7JQtKMSInXcthJGV6j8RUwDmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RjrCsyyIM+9ZZakaR/vbJPL5lllezaSQfyDHcNwkuKVEWWdi0d/jpzOV2gQKSRstR
         qaQT0FZ1cWvvxY1VEgPDqUXuyWZictnOFi5LOIYy7LzvV4erG6efYbrz0x9bgmvmvM
         WFqitFGAJn9b5m30OOvmG3IRAroi3clds8D/hJoekggUrDTguCFcMjdMd83O6+uAZf
         /ODliYJGVFU3QeP1hW8J/kPq3/cVkGf/o03f7KOp7QHs2QT8qt71hsZLEGrI3h+aoK
         iyS/yOHfll/lvY7WWXbmKvJOBzjun6g+NVQx+r84FmRzDrgNO2IkTb/N6M+ZK5IKOV
         Cg2wO63css7qA==
Date:   Fri, 16 Aug 2019 13:10:44 +0200
From:   Josef Miegl <josef@miegl.cz>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Implementing Mikrotik IE
Message-ID: <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
 <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
setting vendor elements in hostapd works great - but I need to add these
custom elements to assoc/reassoc management frames in station mode.
Given that the vendor elements option in hostapd works great would it be
possible to patch wpa_supplicant for it to work in station mode too?

Does nl80211 allow setting NL80211_ATTR_IE for station mode management
frames?

Also what are the 'evil hacks' you are talking about?

On Fri, Aug 16, 2019 at 06:07:02AM +0200, Sebastian Gottschall wrote:
> Hello
> 
> Since i already have done this for dd-wrt for mac80211 i can tell you, its
> not easy but possible. the most easy way for broadcasting a custom IE
> is just adding a custom IE with its properties to the hostapd configuration.
> it does allow to set such properties
> so you dont need to change anything in mac80211 which requires some evil
> hacks
> 
> Am 15.08.2019 um 17:28 schrieb Josef Miegl:
> > I've been trying to implement Mikrotik IE. It is a vendor IE that
> > carries stuff like radio name. Even though it is Mikrotik specific, UBNT
> > has a patch for madwifi:
> > https://github.com/jhairtt/ubnt-hal-0.7.379/blob/master/patches/madwifi-dfs-r3319-20080201/074-mtik-ie.patch
> > 
> > The IE is sent in beacon and assoc/reassoc frames. I think the correct
> > place for this is mac80211, but I'm not sure how should I expose a
> > switch to this functionality. Is there something like ioctl, or do I have
> > to implement a switch in nl80211, then in cfg80211 and then finally in
> > mac80211?
> > 
> > Any advice is greatly appreciated.
> > 
