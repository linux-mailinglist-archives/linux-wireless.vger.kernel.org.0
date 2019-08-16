Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1BB900D9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfHPLi0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 07:38:26 -0400
Received: from ocelot.miegl.cz ([195.201.216.236]:60792 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfHPLiZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 07:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=miegl.cz; s=dkim;
        t=1565955502; bh=E2bH3p8EBEYKHPMbTeyOV0lb/hYa7v9PsVY1ivTZ9mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=McrjrGKd3WjrxSg5c10ccaWaqYRWaYgcnlMLQxG0Ac/CnTxD8WAmsjuCTgDsdc5Dn
         QkCZJaCyF7jFXs0vJmMzvvigTzLeAGGxBH5SAk137Xt8uw2B+nTI4TAJM3MCK8GHEY
         Bmd3n2lE1pRkudAaImuYcOTOxS3VrvdCFZi/cfElD3rvraaYIez5eVqt/QrKOeaf/E
         yr5qnOP9nEH1bb5faKOD/rF8teKiwcOfC6r8NmK8CAboi6BbC0mOBlZOownkEYdT+y
         gHs+pLT5sXoRSsPcKefI82QLez+M3cFbZMoshnLcKXz8rImW2HN+BeBXy+mFgBYkCH
         XJ0PGHeGgNgUA==
Date:   Fri, 16 Aug 2019 13:38:18 +0200
From:   Josef Miegl <josef@miegl.cz>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Implementing Mikrotik IE
Message-ID: <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
 <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
 <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
 <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 16, 2019 at 01:15:30PM +0200, Sebastian Gottschall wrote:
> in station mode you are right. you need to modify mac80211.
Even if I don't need to capture the IE back? All I want is to include
extra vendor IE in client assoc/reassoc frames. If this is something the
current wireless stack cannot do, perhaps it should be implemented.

> i have a mod for mikrotik ie for ap and station implemented in mac80211.
> i can send you a drop of my mac80211 tree which is not compatible with
> upstream. but it will allow you to take off whatever you need to patch it
> since such a
> 
> patch will never be accepted upstream. it adds a new field to the station
> table which shows the radioname and broadcasts the radioname on ap side.
> this has been tested
> with ath9k and ath10k so far an works as expected. i modified also the iw
> tool to show the informations
Your mac80211 tree drop would be greatly appreciated.

Thanks
