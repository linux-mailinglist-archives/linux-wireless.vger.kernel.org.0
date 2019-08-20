Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB2969EA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfHTUB0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:01:26 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42750 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfHTUB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:01:26 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0AJo-0007If-D2; Tue, 20 Aug 2019 22:01:24 +0200
Message-ID: <3dc266154b11381c8f019712e2203b5cbfd3a6da.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 20 Aug 2019 22:01:23 +0200
In-Reply-To: <fcfc70bc-78ba-cd06-55ab-d53d80ac2cc8@gmail.com> (sfid-20190820_215433_125295_49BCBF06)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com>
         <72ac048c01619e0639fc182cd32818a5712cda1c.camel@sipsolutions.net>
         <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com>
         <dd58815c934ab52acbd8a21d04dd0d44e9d32913.camel@sipsolutions.net>
         <fcfc70bc-78ba-cd06-55ab-d53d80ac2cc8@gmail.com>
         (sfid-20190820_215433_125295_49BCBF06)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> So let me ask you this.  What do you _want_ to see when a contributor 
> submits something as an RFC, which that contributor states is not ready 
> for 'true' review and is really there to generate feedback?
> 
> Do you want to have that contributor use a different prefix? Every 
> maintainer is differrent.  I get that.  So if we want to start an actual 
> brainstorming session with you, how do we accomplish that?

I'd be happy if you were to just state what you want to achieve, for
starters! Whether it's [RFC] with a cover letter saying "hey, we feel
this could be faster, and have come up with the following as an idea",
or just another email without any code changes saying "hey, we feel this
could be faster, how do you think we could do this" ... doesn't really
matter.

What you have *actually* been doing though (at least from my
perspective) is something along the lines of

"hey, here's a new way to do <X>"

without even really stating why the existing <X> doesn't work for you.
And where I questioned the need to have a new way to do <X>, well, we
got the other part of this thread.

> So this goes back to my earlier point.  How do you want us to start a 
> discussion with you such that you don't become a 'supervisor' and 
> instead try to understand the pain points first?

Just explaining the pain points would help?

johannes

