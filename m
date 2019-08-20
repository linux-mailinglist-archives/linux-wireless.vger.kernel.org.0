Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362C3969D1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 21:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHTTxv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 15:53:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45276 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbfHTTxs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 15:53:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so3994964pfq.12
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=tNC4FzTGFxO3xaX7hqooEqsSiSbjVM8S8v0TCC8pPNg=;
        b=Jolfcvv28dPA3O3hVidmkECBKmYDKPxZaESjrit6PJcMtxGdOvkTg6wyh3BGVkFCg8
         ZnkdMdjDt/6Fid1lZtYiHwXkamu9glmAzh62jwysxYex77C8xFpA2N48Yf7GibXdIDK+
         tY3KacN3U9MwhiafHab223BJ/uNWYLOBViMAXhWcdw2ObDR+pwNY1/MCWovNmp732Gzb
         59hi0P+p/x3DPvGlhmalJ5Pw46CVhDs3pINphqsw3jLI0mSWqGHq+eTwy7TJ5bRAvU0Z
         eqDr+5ua6F+YExk6XnPZ9T8uUuu+AkkBvTnEmqWguXZsxxhvh7ddzSUGw2ubLO1u0KXn
         6zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tNC4FzTGFxO3xaX7hqooEqsSiSbjVM8S8v0TCC8pPNg=;
        b=tqKO838TifirDjI/jAqh0MzV4cKXsGxiy7vMDEQi1oMz4usnt72L3TmqzmtJaojlZy
         hDosBSzUgiA3z3JcMJ1HVbFd33jGou/BvEg3xCGpbqQ1m7YUQ01Eyfay/tedbXsPwkS+
         BFI70z6L0IrF/aTHg5JpJLoJHuwIRjPRhdgNhsUdiuyydlmaYfznN/SLEfLwkV0grjBI
         vS9/0eO1l1pwuodzpAhbnOpvVkjPbkcs4Zqo84SKosCL5bQQSueZidbHrbSjG+x3mWTk
         P1s6hy6wZZc6FKhouVI3tEDRILKO0OxJ1/F8e8zruWAZorwoVPZ2jwN9ziguSGNL9wzp
         zkvA==
X-Gm-Message-State: APjAAAV1vnytXYTzeOSoFJd4CIyGK4IzWm87TZ0eaVSIIv8RP47oPjsH
        8W7eIzHGlgu4xNdBRp8j79ICUlxqxpBHWA==
X-Google-Smtp-Source: APXvYqwQExr+cuflkXhe6+3cTSLvKHqUFKQDl2CTeRR8EGbqjGD+V0sQQCAngbmsMHnroCZLKU2mxQ==
X-Received: by 2002:a62:1a45:: with SMTP id a66mr32603031pfa.142.1566330827749;
        Tue, 20 Aug 2019 12:53:47 -0700 (PDT)
Received: from nozdemir-mobl.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.139.73])
        by smtp.gmail.com with ESMTPSA id dw7sm718629pjb.21.2019.08.20.12.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 12:53:46 -0700 (PDT)
Message-ID: <661903fa345563615cb781a6d9608607a3db963d.camel@gmail.com>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Tue, 20 Aug 2019 15:53:35 -0400
In-Reply-To: <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
References: <20190815185702.30937-1-prestwoj@gmail.com>
         (sfid-20190815_205833_978900_86B1E73D) <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         (sfid-20190819_175627_344053_E33FB9B0) <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
         (sfid-20190819_231529_805133_AD4E6DEE) <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 08:59 +0200, Johannes Berg wrote:
> Hi James,
> 
> Thanks for staying on topic.
> 
> > > I don't, short of
> > > 
> > > 1) don't do that then
> > > 2) extend the network stack to have
> > > IFF_LIVE_BUT_NO_CARRIER_ADDR_CHANGE
> > >    or something like that
> > 
> > So you mean 2 is my only option... ;) I am fine with this.
> 
> :-)
> 
> I thought so, but I had another thought later. It might be possible
> to
> set LIVE_ADDR_CHANGE, but then block it in mac80211 when the
> interface
> is already connected (or beaconing, or whatever, using the MAC
> address
> in some way - even while scanning, remain-on-channel is active, etc.)

Yeah that makes sense.

> 
> I still think you'd have to bake it into the mac80211<->driver API
> somehow, because we normally "add_interface()" with the MAC address,
> and
> nothing says that the driver cannot ignore the MAC address from that
> point on. The fact that iwlwifi just copies it into every new
> MAC_CTXT
> command and the firmware actually accepts the update seems rather
> accidental and therefore fragile to rely on.

I havent looked into the actual drivers WRT add_interface so I'll take
a look. But I think I see the separation now and why it may not work
for all drivers/firmwares the way I did it.

So are you thinking we need another driver method:
"change_mac/set_mac"?

> 
> > The iwlwifi change was just an example. It ultimately would be up
> > to
> > the maintainers of each driver to support this or not. 
> 
> Sure. I was just trying to say what I wrote one paragraph up.
> 
> > > You've also not really explained what exactly is troubling you
> > > with
> > > changing the MAC address, you just mentioned some sort of "race
> > > condition"?
> > 
> > In order to change the MAC on a per-AP/SSID is to: ifdown, change
> > MAC,
> > ifup via RTNL. The problem is that ifdown generates an RTNL link
> > down
> > event and there is no way of knowing how this event was generated
> > (by
> > you, hot-unplug, or some other issue in kernel?). Handling this
> > without
> > a race is simply not possible. You sort of just have to pray none
> > of
> > this happens (and its unlikely but it *could* happen).
> 
> I see, at least sort of. I'm having a hard time seeing how this
> really
> is a problem in practice, but I suppose that's because I haven't
> tried
> implementing a fully event-driven stack.
> 
> > The connect path is just what we (IWD) use for almost all types of
> > connections that support it (apart from things like SAE/OWE/FT).
> > Not
> > sure what you mean for "usually not taken for iwlwifi"? If you have
> > an
> > iwlwifi card and you issue CMD_CONNECT thats the path it takes...
> 
> Interesting. I didn't think you'd do that, since it gives you far
> less
> control over things, and you need the other paths anyway for the
> features you mention, and the implementation in cfg80211 is far less
> complete than a typical firmware implementation would be.

There was talk about ditching CMD_CONNECT at one point, but for the
most part it does everything we need for the majority of connections.

But ultimately yes I think we do want this feature for
CMD_AUTHENTICATE/ASSOCIATE, and those details may be a bit more
involved. CMD_CONNECT was just an easier way to get my foot in the door
:)

Thanks,
James
> 
> johannes
> 

