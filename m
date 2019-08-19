Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42629493B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfHSP40 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 11:56:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37811 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfHSP4Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 11:56:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so1460210pgp.4
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ETknhA89ZTB2b5rKcUZ5prTFLDDlAikTGBogsbMBvTc=;
        b=mTxqpG4VgkNnRjnE1+s7uWynEETfejkJLBBf9FwaTDT2VDPIn9jIaaBJMjaa6MDzE1
         8P7OF/qJAdm2kHl9VSIMcR271T8uMqqW9BB450clnAyzlFNtCD1QTm/iRZTjB0QfOaUT
         xSTi/ZPH8k5lyWAauCmEXUOPsgjoWq25ySErYQXRRhsY19sBV3uhzNFyIeS8NZCYPVAb
         tfARLUSuxU6VI5juiMLu6SuspPn87JY1/7ruzic2C2SMp+UP1Q+39CXH3WiZfjJRcRGE
         EvSG4vb6+qeD9mn1+oKgksd8XAgDFkEbo1rie0grPlWBLQghkxFALIrFecjIieEH3FS8
         Y/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETknhA89ZTB2b5rKcUZ5prTFLDDlAikTGBogsbMBvTc=;
        b=AjYYYoI7MJCHlCZUZb5OEN58pl5x776dg3a7YXI/8453s830bSzgoH4L8v/cz36+fQ
         jGpkJkAB6VtpVlC1D4VlMaAnirEja5lEcuFPTki2STi2h3F9trt7LZzYOoh3RGFzctmi
         FqElWdO/SeTMXkGoTh/GbV6nLnKjT+gx5fB2v7WW7OjSpmdCkEmQYRrBJZUCVLBAavpC
         8/Toe7RyNs7/NGb9lI/7CU1QweWxF36/OuYP+bkMMjMYUqWyMYKQgC/LpDXlVPKzHQmg
         kgYBPXX4Gv/86HQUI3dE027YJc16d2n3QpfaFotqMGYoRoI0SKVNmqX6duWrI9bVqGTJ
         dRHg==
X-Gm-Message-State: APjAAAXPJ7l8AzV4+qm+YyQmLnQ0nPJNurwDsDr+YrnUzw0JGHmYr+lF
        2RJwKs5PTQ2WqxZEhUEXBZuZfHVv9sA=
X-Google-Smtp-Source: APXvYqx2DaxNqvbOJhupIMOD/gFIqemkpd06VrLbk5uwdxfFGaZyff/lA4Z6uBxw/hhAREhmwVTJuw==
X-Received: by 2002:a17:90a:a105:: with SMTP id s5mr21176579pjp.51.1566230184889;
        Mon, 19 Aug 2019 08:56:24 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id b126sm20609204pfa.177.2019.08.19.08.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 08:56:24 -0700 (PDT)
Message-ID: <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 08:55:00 -0700
In-Reply-To: <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
References: <20190815185702.30937-1-prestwoj@gmail.com>
         (sfid-20190815_205833_978900_86B1E73D) <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-19 at 12:14 +0200, Johannes Berg wrote:
> On Thu, 2019-08-15 at 11:57 -0700, James Prestwood wrote:
> > This is an example of how a devices MAC address could be changed
> > while
> > the interface is up. Currently RTNL and mac80211 both require the
> > interface be down before changing the MAC.
> > 
> > After poking around a bit I found that some drivers can actually
> > change the MAC while the iface is up. Allowing user space to do
> > this
> > while the iface is up would elminate a few potential race
> > conditions
> > that arise when changing the MAC from user space.
> > 
> > This commit does a few things:
> >  - Adds an EXT_FEATURE that user space can check to see if the
> > driver
> >    allows this MAC changing.
> >  - Adds a new NL80211_ATTR for including a "random mac" to     
> >    CMD_CONNECT. This MAC is passed down the stack and gets set to 
> >    the net_device's address.
> >  - Set this wiphy extended feature in iwlwifi (just as an example)
> >  - Relax checks in mac80211 which check if the interface is running
> >  - Set IFF_LIVE_ADDR_CHANGE on net_device. Note: I know setting
> > this
> >    where I did is likely not the right way to do it, but for this
> >    proof-of-concept it works. With guidance I can move this around
> >    to a proper place.
> 
> 
> It actually seems wrong to set IFF_LIVE_ADDR_CHANGE at all, because
> you
> don't actually support that - you only support setting it while not
> connected?

You are right, we only care about setting the MAC while not connected.
But, the eth_ API's that set the MAC are contingent on
IFF_LIVE_ADDR_CHANGE when the interface is running. If you follow down
'dev_set_mac_address':

dev_set_mac_address ->
   ndo_set_mac_address (ieee80211_change_mac) ->
      eth_mac_addr ->
         eth_prepare_mac_addr_change:

You see the check for:

!(dev->priv_flags & IFF_LIVE_ADDR_CHANGE) && netif_running(dev)

Like I said in my commit message, I did not think setting
IFF_LIVE_ADDR_CHANGE where I did was the correct way to do it, but
unless this eth code is changed its looking like it does need to be set
somewhere to change the MAC while 'running'.

Maybe this is a historical thing but the comment about
IFF_LIVE_ADDR_CHANGE says "device supports hardware address change when
it's running". Isn't a wireless adapter 'running' when not connected?
Or does 'running' indicate some different state than up/down?

If you have any suggestions on how I could do this without setting
IFF_LIVE_ADDR_CHANGE I am all ears.

Thanks,
James

> 
> johannes
> 

