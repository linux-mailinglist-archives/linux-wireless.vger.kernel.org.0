Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66093F2271
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 00:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfKFXRx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 18:17:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39136 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfKFXRx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 18:17:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so369150pfo.6
        for <linux-wireless@vger.kernel.org>; Wed, 06 Nov 2019 15:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jluuUPJMyJ9UrJ/y1hzGUViE0ppwGEMpYzoRViVVG5o=;
        b=GnngB3SJkbYXTZyPpNlh/kndYWgMeKcWX5xywPz0ghvqmcaaBI9nylo5rWlb0M99ej
         zYU1TV4PgX609RJCxwcT0gAoo6PkFs/DT4moVDTf1McDHlDX3Xi8mwNt2S7sIehVibNB
         d27vVqYQNj/9S5yuRdx6jX6D9xm4I2XQME7xMnGYV1Ypv/vvF8eKCr5uwat+kAUW34z+
         BJ9TaenCUS7cQM3pI5TAjhS+GBlEpFspqHeoCUsh3YUDlEVDN50263xyXPLq9tTP/E3N
         8yvTrjGRofn3bxADd7GDgrYFT6QNjGJZrXMO0SkYYJTcVuzMOHIA30E7G/b5Q/3Loch2
         vQFQ==
X-Gm-Message-State: APjAAAWkAZxDNIB3YEqEXFzy6NkcjQoLCzCOONxZ0ZkCn6BZ8/yY+q6D
        37rdaeWSevEWrR2AtXmgF70=
X-Google-Smtp-Source: APXvYqwG58PoA7lQYc4Csgh7zpQZznvbLnjXz9YBrn4PjkB5kX1WUnmIPLGXnrtlSiTPqWx2smz/lA==
X-Received: by 2002:aa7:8421:: with SMTP id q1mr6763149pfn.174.1573082272373;
        Wed, 06 Nov 2019 15:17:52 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b17sm72157pfr.17.2019.11.06.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:17:50 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9963440297; Wed,  6 Nov 2019 23:17:49 +0000 (UTC)
Date:   Wed, 6 Nov 2019 23:17:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        wireless-regdb@lists.infradead.org
Subject: Re: [PATCH] crda: Makefile: fix .so compilation line with some
 compilers
Message-ID: <20191106231749.GM11244@42.do-not-panic.com>
References: <20191105225751.1233-1-briannorris@chromium.org>
 <CA+ASDXM_5Q3LNyv_mbrG8d8Qo1iZZz2A2CFfvQqj9_Ta-q-wMA@mail.gmail.com>
 <786f623306ad462e3776236c94e83b5f2e0648ab.camel@sipsolutions.net>
 <CA+ASDXMVJg0QSPzSiWFjoDH67yJ-NfYX4MQZUT3gaivx1SJ2aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXMVJg0QSPzSiWFjoDH67yJ-NfYX4MQZUT3gaivx1SJ2aA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 06, 2019 at 08:38:33AM -0800, Brian Norris wrote:
> On Wed, Nov 6, 2019 at 12:12 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Tue, 2019-11-05 at 15:02 -0800, Brian Norris wrote:
> > > Apparently wireless-regdb@ is subscribers only. I have since joined,
> > > but I guess my patch bounced from that list... if I don't hear back in
> > > a while, I may resend.
> >
> > The bigger question is who actually maintains crda now, if anyone ... :)
> 
> My mailbox tells me that as of about a year ago, Luis was still
> merging patches. And his latest commit even claims it's "still
> maintained":
> 
>     As if kernel v4.15 CRDA is no longer needed. Annotate this. The
>     code will still be maintained to help older kernels.

Sure, send me patches. Its just not needed on older systems.

  Luis
