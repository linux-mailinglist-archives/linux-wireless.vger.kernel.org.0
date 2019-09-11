Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C19B00A6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfIKP4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 11:56:13 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46767 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfIKP4N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 11:56:13 -0400
Received: by mail-pl1-f180.google.com with SMTP id t1so10315517plq.13
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sNK+Cb8tdBOxiR4UxSW7axXQ0ov/nJcmmFfpj/R5eJA=;
        b=HdK1O0w1CsJzcEj+PRbZLEAzfonXZCLXwFo1Dii6tYXhgZTTwwz0jVFPwvooj32WS2
         gZIBSIAnysErkHAgNS5xQ6d/SD19QWmd8Tob8LejeCRewhwkYpH8QlvoE9zwqGcZ0cSa
         X+UKBvkybsxdVg0Zk/g4GLuK/BEnme8bdTiV2KF8VoE2zbr9X8GOugYpkPf5Wl1WcSD4
         W7lVtrpf12dRKl/EPIKjkFIVuXqydKXxf4Z5dIdp/gtb1bigrzzwNHel+89cHj+kMC4P
         rNvsZA2jgk3XpIyzmavWgqYf8O+5QjaNlpm+T4PAPmTmxpvYM2g9yVNeYOSY/4KLBpJB
         s3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNK+Cb8tdBOxiR4UxSW7axXQ0ov/nJcmmFfpj/R5eJA=;
        b=HXi4jDQUZJxT/GhZ8ntBTO8YD8raz4Q48MjCtF32bfk0opr1xxpe6/1zMoodpK9wqC
         Ja5MyMZQ/nmJamrsqQCgQjg2Bc8KorZx2kLSbZKAhldkJD0q6aFO2cGfKOYrzNUlTfVL
         sqNmNP7qNqmn2ZLIfBuNrIqMIU7KiYuF5fpXa0LkitjPsU4uF0OCHYPhUwlgGUzMj/rQ
         CQ0Sr1Dm2fef3Cp/kvYWpyx1ARqLVcyInA+aiYFWJjYi0Gk5bqDWdrMNKKNx5bUF0QQW
         pkJKu7GO9BYYKoLd5zsr4YXbM2B+j9QQcle7yUHDnpRDMxggWfZygG0JWmUUt2SRhyR+
         3ghQ==
X-Gm-Message-State: APjAAAVOj0wYaoQCnLs5pFoy8TPqg6Fy1O/arZj76QQOyndLW2DPEdoZ
        tl9Xm0ys7CC4hlgWVb+Yck0=
X-Google-Smtp-Source: APXvYqzUYO7Qct7txhnuIEBJ7VVkjZj/2BLAzHfVw+74Qwv3vFldYjwCVn0xTK0KHbBTBmeM8tmj3Q==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6mr38562939plb.79.1568217371002;
        Wed, 11 Sep 2019 08:56:11 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id i3sm16503777pgb.55.2019.09.11.08.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 08:56:10 -0700 (PDT)
Message-ID: <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
Subject: Re: [RFC 0/4] Allow live MAC address change
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 08:54:19 -0700
In-Reply-To: <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
References: <20190904191155.28056-1-prestwoj@gmail.com>
         (sfid-20190904_221357_305070_478BF6CA) <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-11 at 11:09 +0200, Johannes Berg wrote:
> Hi James,
> 
> TBH, I'm still not really convinced.
> 
> > I have taken some timings for all 3 ways of changing the MAC.
> > Powered
> > change via RTNL, non powered via RTNL, and changing through
> > CMD_CONNECT. All times were taken in microseconds and tested on an
> > Intel 7260 PCI wireless adapter:
> 
> From where to where did you measure? I mean, clearly you cannot have
> counted all the way to the connection?

I could have made this a bit more clear. I initially did measure the
time to a full connection, including EAPoL, but the more I timed the
more chance there was for scheduling delays that really threw off the
results. Not that these results weren't valid, I just would have needed
to time many many more runs to get a decent averaged time. The method
of timings I took just isolated things a bit better.

For the three methods below I measured the time from the connection
initiation (either powering down via RTNL, changing MAC via RTNL, or
sending CMD_CONNECT) until we got a success callback from CMD_CONNECT,
including changing the MAC via RTNL in those cases.

> 
> > Powered via RTNL:
> > 
> > Average: 294508.9
> > Min: 284523
> > Max: 300345
> > 
> > ==================================
> > Non-Powered via RTNL:
> > 
> > Average: 14824.7
> > Min: 11037
> > Max: 17812
> > 
> > Speedup from powered change: 19.87x (average)
> 
> I'm assuming that this version is the IFF_LIVE_ADDR_CHANGE + setting
> the
> MAC address via RTNL?
> 
> If so, yeah, obviously not powering off the firmware will be much
> faster
> than powering it off. That's an easy win really.

Yep exactly.

> 
> > ==================================
> > via CMD_CONNECT:
> > 
> > Average: 11848.7
> > Min: 9748
> > Max: 17152
> > 
> > Speedup from powered change: 24.86x (average)
> 
> And this really only gives you a gain of 3ms.
> 
> That'd be nice, but like I said before, it's not the only thing
> we/you
> should be thinking about.
> 
> One fundamental issue I have with this is that you're now combining
> together temporary with persistent state changes. After a
> disconnection
> (or connection failure), the interface usually goes back to its
> previous
> state. With this change, you're keeping the MAC address modified
> though.
> 
> Sure, you don't care (because you're probably going use a new random
> address later anyway), but these are still things we should consider
> in
> an API.

Yeah, in IWD's case if this feature is supported we would be doing the
MAC change on every connection (unless already changed previously) for
privacy reasons.

Out of curiosity how this behavior is different than the power down +
RTNL MAC change (the current way of doing things)? If you power down
the device, change the MAC, then power up does that MAC get reset after
a disconnection/failure?

> 
> I'll happily take the subset of the patches that implements the
> IFF_LIVE_ADDR_CHANGE in mac80211, but I don't think the 3ms win there
> wins over having a well-defined API.

Sure, that would be great. That is definitely still a improvement to
the existing way of doing things.

Thanks,
James

> 
> johannes
> 

