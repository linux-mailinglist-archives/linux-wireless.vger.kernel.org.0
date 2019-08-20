Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F119697E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfHTTcK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 15:32:10 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42202 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTTcJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 15:32:09 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i09rT-0006fI-Ru; Tue, 20 Aug 2019 21:32:08 +0200
Message-ID: <dd58815c934ab52acbd8a21d04dd0d44e9d32913.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 20 Aug 2019 21:32:06 +0200
In-Reply-To: <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com> (sfid-20190820_174845_396851_9BE0F3E7)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com>
         <72ac048c01619e0639fc182cd32818a5712cda1c.camel@sipsolutions.net>
         <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com>
         (sfid-20190820_174845_396851_9BE0F3E7)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Denis,

Rather than replying to all the separate items here, just two things:

1) I'll reiterate - please keep things civil. You're taking things out
   of context a *lot* here, in what seems like an attempt to draw a
   parallel between my and your utterances.

2) I'll take your point that I've been somewhat dismissive in tone, and
   will try to change that.


I do want to reply to two things specifically though:

> Fine.  I get that.  But how about asking what the use case is? Or say 
> you don't quite understand why something is needed?  

Really, I should *not* have to ask that. You should consider it your
obligation to provide enough information for me to review patches
without having to go back and ask what it is you actually want to
achieve.

Compared to some other subsystems and maintainers I've dealt with, I
think I've actually been rather patient in trying to extract the purpose
of your changes, rather than *really* just dismissing them (which I've
felt like many times.)

> a maintainer who's job (by definition) 
> is to encourage new contributors and improve the subsystem he 
> maintains...?

This is what maybe you see as the maintainer's role, but I disagree, at
least to some extent. I see the role more of a supervisor, somebody
who's ensuring that all the changes coming in will work together. Yes, I
have my own incentive to improve things, but if you have a particular
incentive to improve a particular use case, the onus really is on you to
convince me of that, not on me to try to ferret the reasoning out of you
and make those improvements my own.


So please - come with some actual reasoning. This particular thread only
offered "would elminate a few potential race conditions", in the cover
letter, not even the patch itself, so it wasn't very useful. I was
perhaps less than courteous trying to extract the reasoning, but I
shouldn't have to in the first place.

Thanks,
johannes

