Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B3B56B8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfIQULh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 16:11:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45102 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfIQULg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 16:11:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so2769523pfb.12
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PXpiNS4jjMNOlNr96UmlOM7e+IlCRwBQJjxXkdEJG+g=;
        b=WlRz9//9e+9spraySYghDmktiOpEerBsgrNW7HpH1LlYNZ5ZgI93cokW8YhY4lX1LO
         oJrYvm7ZWr1ro05HstUkL1ezb3JPfUYZivmVY0GErw34hDMlK0j1pB/5qFKiCpFf3tMg
         Jux5YwS1KO+OA/VrFLWCSGR1BH876zwVvuqF/B5Lm+TUeh3sro7gNaNjEeL7yo9nnJZY
         J4C1eCuHMd5cqloZCOy/O+PW0uwDtllgW2CPZ8cHFrdImOIyRtkx3oKl3Yz9ykFZqQGT
         hXOyTmSoxnEQ2mMSWA9VH/RvVZU5tmTd+vPC16n5YxWJNKNH3FpYWTTihmbQ1ko2QjtR
         Xx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXpiNS4jjMNOlNr96UmlOM7e+IlCRwBQJjxXkdEJG+g=;
        b=NN3pwQySSzrHinchcUns9XufVAGYkPQo0ZRAL49jidEg3XXz82gTuNjs3tL9GKhF02
         52ot7OE7vtymwS/7myjdq9znk7zRS8fIGJw1ABcm4RZ5DI8xs4/Nfy0Tg94sYN5Xgcbc
         un3PJCM+h0QNogOCy6pNSuFMXmBAbutAUrWeW/DXUq34S1oOx505ozhH0s6u+JZ0jYcp
         kpzvnYXXHJjgLCSHgyVkzNmoWlB1EkmVgn3vuaCQXaCLK6xfO1WISRGEDi50czLNRXsY
         s+LICVnuakznbXqfDATr72/XH7hlkU1l8K9IMDdPaJY6/zrhDVws1v1ZH+OhhSYNmULJ
         XXUQ==
X-Gm-Message-State: APjAAAW0vnPu691Maq0wKysFreDB9XypA7Dmiqt2GP7scivIGDaWOQZV
        vBFhnAy0wPjX04P0vXMTcwQ=
X-Google-Smtp-Source: APXvYqzcNmq6fcMPBPVPUgrbMh2/tb2J87TLS9Yj4CEWkqtXgslFYeJrDbTLt3H5VGe8A9Y05PIjIw==
X-Received: by 2002:a17:90a:a47:: with SMTP id o65mr6827827pjo.90.1568751096010;
        Tue, 17 Sep 2019 13:11:36 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id p66sm9863419pfg.127.2019.09.17.13.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 13:11:34 -0700 (PDT)
Message-ID: <0937f6e2435976756db362889e4b828cc1b46f83.camel@gmail.com>
Subject: Re: [PATCH 1/2] nl80211: Add LIVE_ADDR_CHANGE feature
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Tue, 17 Sep 2019 13:09:30 -0700
In-Reply-To: <b43f737c06a392957e6f651d59282a3f36fd05e5.camel@gmail.com>
References: <20190913195908.7871-1-prestwoj@gmail.com>
         (sfid-20190913_220113_419728_36032050) <6c85d9b108825939afb84ebc8a708a211f7e2b98.camel@sipsolutions.net>
         <38c222129dd182de4c55e536a89eada7f58a1bf1.camel@gmail.com>
         (sfid-20190913_225826_111097_E5ED9AB1) <47aaaccf7d8fb58587f0cfbe38acd18e1420dc9a.camel@sipsolutions.net>
         <b43f737c06a392957e6f651d59282a3f36fd05e5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes,

On Fri, 2019-09-13 at 14:14 -0700, James Prestwood wrote:
> On Fri, 2019-09-13 at 23:01 +0200, Johannes Berg wrote:
> > On Fri, 2019-09-13 at 13:56 -0700, James Prestwood wrote:
> > > Hi,
> > > 
> > > On Fri, 2019-09-13 at 22:48 +0200, Johannes Berg wrote:
> > > > On Fri, 2019-09-13 at 12:59 -0700, James Prestwood wrote:
> > > > > Add a new feature bit signifying that the wireless hardware
> > > > > supports
> > > > > changing the mac address while the underlying net_device is
> > > > > UP.  Note
> > > > > that this is slightly different from IFF_LIVE_ADDR_CHANGE as
> > > > > additional
> > > > > restrictions might be imposed by the hardware.  Typical
> > > > > restrictions
> > > > > are:
> > > > > 	- No connection is active on this interface, e.g.
> > > > > carrier is
> > > > > off
> > > > > 	- No scan is in progress
> > > > > 	- No offchannel operation is in progress
> > > > 
> > > > Hmm, what do you need this patch for?
> > > > 
> > > > IFF_LIVE_ADDR_CHANGE should be sufficient to discover it?
> > > 
> > > Because userspace needs to know if this is supported?
> > > IFF_LIVE_ADDR_CHANGE is a private flag... AFAIK userspace has no
> > > way of
> > > obtaining this.
> > 
> > Oh, annoying.
> > 
> > But that doesn't really mean that nl80211 is an appropriate place
> > to
> > advertise it, IMHO?
> 
> The intention of the flag was not soley related to
> CMD_CONNECT/CMD_AUTHENTICATE. Its an indication that the
> hardware/driver supports a live address change. If you don't want it
> here could you suggest a better location for it?

Could we continue this discussion? Is there some other way you can
think of to let userspace know that this feature is supported rather
than an ext feature?

Thanks,
James
> 
> > 
> > And in nl80211 you'd need the flag for if you actually have the
> > "change
> > MAC address during connect" attribute.
> > 
> > johannes
> > 
> 
> 

