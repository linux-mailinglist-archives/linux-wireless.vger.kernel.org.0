Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EF8D0344
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 00:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfJHWP7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 18:15:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46700 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 18:15:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so9601plr.13
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 15:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lT7q6Z4nn0a+mDA6l257fP8CWvqqcrjOaGrVwoUYlUU=;
        b=PWAav7pxBhlSTRlQmKmPvYYk8j0jbDDC4zr2P2Yh7yVNIOMZIVGnMpFioqyhHChvAF
         3jpf3lWgE4KxFz886D1K0JsdozTAVUc+AB1Ls1piLl8Umjv1uyO7JYmmL48o1Myfltgj
         rSEsi93dYkVVgOhTu4mPkd+Sf3aBRgbTd205fdTSBxdB5mEasxc5cTUKxT+nzOKeAIxL
         Zc4wI3EEf2kQIg2jlqQwKwKtl7MQ3DSPXuWkRRQtaogCv7hyOvVQw2Sv24Pk1E81+lty
         qhux7TvLu8oK4cpMKitlx3hjX7SD/+bS28qGuffr5Aoszijqp7Zf81pBtctFnxWwp/d3
         pOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lT7q6Z4nn0a+mDA6l257fP8CWvqqcrjOaGrVwoUYlUU=;
        b=tHbuHpRKCcr55jRARUexZTyKrwiNyOoU/OgADDi8PLcDPtEzBVXgZ3kA3ThPzrHXIE
         H9T9KJV2Mzb+/M1DAfe6siaoxMro+TY3dC8x+eiJXN7I9P3WR95Fxy+F+g2We3KlrxeU
         LTLshnRnpEcuu7h6Cb8gWGSVssPl3goytOlojdMshZSwjy8B4eVjODx/+SXRhKYs8j02
         MHfwU5KlkmYdm8sSeFcSW41NlxG4hUhscFE81t1fgHGvzZgDNpcyGGw96rUaCkb9mqOv
         1aAC7FDOFWjDYVca1h9iNWVZGfuSM9LMZjYi5JBj5AQWz6Yh/hu2ZL0yuYLQ0XVJ1203
         cwfA==
X-Gm-Message-State: APjAAAVl9/nEMDhHb52zJ0vNuTzz00liDATbwUWJDwpsLOgN3e7C046m
        +KL06A8wMetMC9+ArNvTrnpgukRV
X-Google-Smtp-Source: APXvYqx//PhQV1+cXg5GPVC9DrC8NGqDC3jxWKU/5ig21LB1VpwyOyakp/u+vtJfITsAfZ5dkhM87A==
X-Received: by 2002:a17:902:b109:: with SMTP id q9mr37229598plr.306.1570572957283;
        Tue, 08 Oct 2019 15:15:57 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id 4sm166688pja.29.2019.10.08.15.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 15:15:55 -0700 (PDT)
Message-ID: <cedf5016a59f313c073e1549961317b8fcf0ceab.camel@gmail.com>
Subject: Re: [PATCH 1/2] nl80211: Add LIVE_ADDR_CHANGE feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Tue, 08 Oct 2019 15:13:30 -0700
In-Reply-To: <83bde7f521e636903b6b386faaa31b73479add8b.camel@sipsolutions.net>
References: <20190913195908.7871-1-prestwoj@gmail.com>
         (sfid-20190913_220113_419728_36032050) <6c85d9b108825939afb84ebc8a708a211f7e2b98.camel@sipsolutions.net>
         <38c222129dd182de4c55e536a89eada7f58a1bf1.camel@gmail.com>
         (sfid-20190913_225826_111097_E5ED9AB1) <47aaaccf7d8fb58587f0cfbe38acd18e1420dc9a.camel@sipsolutions.net>
         <b43f737c06a392957e6f651d59282a3f36fd05e5.camel@gmail.com>
         (sfid-20190913_231625_014352_843A9715) <83bde7f521e636903b6b386faaa31b73479add8b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Tue, 2019-10-01 at 11:14 +0200, Johannes Berg wrote:
> Hi,
> 
> > > > Because userspace needs to know if this is supported?
> > > > IFF_LIVE_ADDR_CHANGE is a private flag... AFAIK userspace has
> > > > no
> > > > way of
> > > > obtaining this.
> > > 
> > > Oh, annoying.
> > > 
> > > But that doesn't really mean that nl80211 is an appropriate place
> > > to
> > > advertise it, IMHO?
> > 
> > The intention of the flag was not soley related to
> > CMD_CONNECT/CMD_AUTHENTICATE. Its an indication that the
> > hardware/driver supports a live address change. If you don't want
> > it
> > here could you suggest a better location for it?
> 
> I guess RTNL would be the right place? This can hardly be specific to
> wireless, the flag comes from elsewhere.

I do see where your coming from, and maybe the answer is both RTNL and
NL80211?

In this context a NL80211 flag would mean something different than only
putting a flag into RTNL.

The NL80211 flag means this device supports changing the MAC while
running and not offchannel/scanning. Which is what -EBUSY would mean in
this context. Managing the offchannel/scanning work is only possible
with a NL80211 application.

An RTNL only application has no idea about scanning/offchannel work, so
it has no way of knowing what -EBUSY means in the wireless device
context, or a way to prevent this from happening (stopping scanning or
offchannel before changing the MAC).

Now, another example would be an RTNL application that only cares about
non-wireless devices (like ethernet), and in this case it could benefit
from some type of RTNL specific flag and not care about a NL80211 flag.

Since there is no such application that cares about this RTNL flag
(since it doesn't exist) I would say that adding NL80211 flag is the
way to go. If someone wants to add an RTNL flag I would say that is
appropriate too. But in terms of this feature, a NL80211 flag is really
what fits best since the changes are wireless specific.

Thanks,
James

> 
> johannes
> 

