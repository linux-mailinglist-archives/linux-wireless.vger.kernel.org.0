Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB2F9D60
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 23:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKLWp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 17:45:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35153 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfKLWp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 17:45:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so159989plp.2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 14:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A7Pc+eVl0wSAktH3DzadPRkSghY4HyxeOv9R7PEncHM=;
        b=oYQSJq4zERXQMy1ntYzA0pDqTL8s4hn6lme3Wi6UHkHDVsx8ZEdsY/LpVTxBcDOVZ7
         U5EfBcO1ge994/IMAD/1eMRQUtnFchjP9nFJadJhEAPXyFsBp4ymHxqfZGUMvkTsr6S8
         EbzUN9lK1X5tYP2DOI/ITy155aGrD26aivcghdgAE4pLPI+8Or6+2vnoGTfvu7IkaVGI
         0gnbJml71hyaXCNotZLaMqttoAujJ/bHfP9Q3ENv9zmlZkUGGNa0dKn4JYcmS66xsSrX
         xl6WqQ2ZXnejRzuqCOZTlVltDgK3NJgLA83kExxxAOdiE0n1fXpvKKIi+N13pQxueCDz
         AUcw==
X-Gm-Message-State: APjAAAUZGMTh88pniWOP1jT88kuwhK4f5x5BXvAR8Kv+BqOWQo1H4dGH
        tIyWottGYV51FfUgu98J4O8=
X-Google-Smtp-Source: APXvYqwvIIW+8jZ+uB9kCsP4i0eol6xQ9//Ptts0DODMaxFHlhNPszXN/sNcMZ+9S4Z2tshF3NTn7g==
X-Received: by 2002:a17:902:d20b:: with SMTP id t11mr223656ply.91.1573598728015;
        Tue, 12 Nov 2019 14:45:28 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u24sm39023pgf.6.2019.11.12.14.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:45:26 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 12720403DC; Tue, 12 Nov 2019 22:45:26 +0000 (UTC)
Date:   Tue, 12 Nov 2019 22:45:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        wireless-regdb@lists.infradead.org
Subject: Re: [RESEND PATCH] crda: Makefile: fix .so compilation line with
 some compilers
Message-ID: <20191112224526.GP11244@42.do-not-panic.com>
References: <20191105225751.1233-1-briannorris@chromium.org>
 <CA+ASDXM_5Q3LNyv_mbrG8d8Qo1iZZz2A2CFfvQqj9_Ta-q-wMA@mail.gmail.com>
 <786f623306ad462e3776236c94e83b5f2e0648ab.camel@sipsolutions.net>
 <CA+ASDXMVJg0QSPzSiWFjoDH67yJ-NfYX4MQZUT3gaivx1SJ2aA@mail.gmail.com>
 <20191106231749.GM11244@42.do-not-panic.com>
 <20191107173723.GA157096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107173723.GA157096@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 07, 2019 at 09:37:24AM -0800, Brian Norris wrote:
> Write the CC rule such that it only tries to produce a single output
> file (the .so). When including the .h files in the compiler invocation,
> this suggests we should be producing pre-compiled headers too, which
> doesn't make sense in this context, and Clang happens not to like.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> On Wed, Nov 06, 2019 at 11:17:49PM +0000, Luis Chamberlain wrote:
> > Sure, send me patches.

Thanks, applied and pushed!

  Luis
