Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD9B048A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 21:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfIKTWr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 15:22:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42896 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfIKTWr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 15:22:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id x20so4990209plm.9
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=c+ZH/L47dn7uaiLov7k11NOiM8pyXY4aaG49Im6BtFE=;
        b=EYUVw+jEiZMzdDkz2qsZGuuJpZxdSyhcRnEEdGFwKyT8sVraQi6j/e6YHX23bQQ7DN
         5/VQr/GRl/GE+rF3fXGQgFu9AFAN8nwGH7oWGqblf7Ks4XDgLCSPygdjbyNYnqtccUu0
         QmxuLBGWFKUo/ImRDZQU06hijdv/LglUWaGpDJIB2MdklYPl70jj67zmckCOU/fjBA8+
         b8pAjpyr0gZplVMDqc07yoaUCQ673hkWyvlZLdhPRNPVoFueHyyfKheTtQliCtMb4246
         iRG6sWGHCemL5diYrJ9t/f8QRNRDFmyKA2ZEhId7ETtfjuuOTKNDwbDGUzvCXDmBydzO
         UNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+ZH/L47dn7uaiLov7k11NOiM8pyXY4aaG49Im6BtFE=;
        b=ALa6TdeliLWjAW+ENtLYxb8C0hQXIGE/M1vbEXZzwT97Pems795dtdHWP6k7RBax0/
         IibshUNsCYHp4q9ZnB5b+bTce3oyPAl0tdhfN7zCDkHgHMIRmjv+elTzAGy8pIEA46qf
         VYX7TFF87Kyb0l5CV5ZwVY1CnZD9GuQSdWIKONLQd3fadID4ipvoBUXS+x1RBTB4N/VI
         nWBCt/d1mEmdko4+9uf+/RIC6i0nU20rYN1nYTJU7VDr/c7az62PR+E8mN/i1MKR9D70
         jbWeiBMaqph5MRXCsEECdedgw29fdSkdKa0e7zNL/a/0LdDpAILkJdfFf/g4F6FKKLrH
         JRAw==
X-Gm-Message-State: APjAAAWr4G13VeFoiJ3YmntL0eoanef7nqC+lsUt6PjV0pB8IqFvYetL
        cXnGlJZEL9D95pCW1A4m9aMRaCq2NoE=
X-Google-Smtp-Source: APXvYqx3eBkqgN2GIfaEtkNcWtPM32TOflLqqiIfyfe5I7wxWYfNUZ1uxHdjKgWnl0JmPkJ9gMh19Q==
X-Received: by 2002:a17:902:aa84:: with SMTP id d4mr4755456plr.45.1568229766629;
        Wed, 11 Sep 2019 12:22:46 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id dw14sm6445187pjb.2.2019.09.11.12.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 12:22:46 -0700 (PDT)
Message-ID: <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
Subject: Re: [RFC 0/4] Allow live MAC address change
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 12:20:55 -0700
In-Reply-To: <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
References: <20190904191155.28056-1-prestwoj@gmail.com>
         (sfid-20190904_221357_305070_478BF6CA) <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
         <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
         (sfid-20190911_175613_316165_C021A0FB) <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

> > Out of curiosity how this behavior is different than the power down
> > +
> > RTNL MAC change (the current way of doing things)? If you power
> > down
> > the device, change the MAC, then power up does that MAC get reset
> > after
> > a disconnection/failure?
> 
> No, of course not? But then you're explicitly issuing a command
> ("change
> the MAC address") that is supposed to affect state indefinitely, vs.
> issuing a command ("please connect") that isn't really meant to.

I see what your saying, but theses kind of state changes are all over
the place in other APIs, and undocumented: One example is
SCAN_FLAG_FLUSH clearing out the scanning state for all other
processes. I'm sure I could find more. If we documented this attribute
and behavior I don't see an issue.

This is also no different than changing the MAC via SET_INTERFACE and
having CMD_CONNECT fail; the MAC still persists but instead we payed an
extra 3ms for the same result.

I know 3ms doesn't seems like a lot but everything counts and from my
testing this is even a further 20% improvement to doing so with RTNL.
Plus the added simplicity to the userspace code/API. We have taken a
lot of time to optimize IWD's connection times, and everything counts.
The connection times are fast already, but when there is room for
improvement we will push for it, especially in situations like this
when the change is quite minimal and does not introduce much
complexity.

> 
> If there was one thing that we learned from wext, IMHO it was that
> keeping all the state in the kernel is bad for you, and it's much
> better
> to handle things if the state gets reset when you disconnect etc. In
> most places that's what we do now and I think it has served us well,
> so
> I'm very reluctant to mix things that need state in the kernel with
> those that don't.

I don't really agree that this change puts any more or less state in
the kernel. Even the current way of doing things userspace still needs
to maintain what it changed the MAC to, here is no different. And
again, documenting this attribute should leave no question about what
is happening.

> 
> (You might not remember wext, but you'd have to issue a bunch of
> commands in the right order, and it would keep all the state
> inbetween;

I was not around for that, but yes that sounds bad. The difference
though is we are not issuing a bunch of state changing commands in a
row to achieve a single goal. We are issuing one single command,
CMD_CONNECT or CMD_AUTHENTICATE.

Thanks,
James

> if you forgot to clear the BSSID after setting it, it'd be remembered
> and you couldn't connect to a new AP unless you reset it, etc.)
> 
> Thanks,
> johannes
> 

