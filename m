Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF1B2560
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389839AbfIMStt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 14:49:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59706 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389736AbfIMStt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 14:49:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i8qdf-0006el-Fh; Fri, 13 Sep 2019 20:49:47 +0200
Message-ID: <f40b9c1dcee781a160ae1d6b57467eb3ade77262.camel@sipsolutions.net>
Subject: Re: [RFC 0/4] Allow live MAC address change
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 13 Sep 2019 20:49:45 +0200
In-Reply-To: <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com> (sfid-20190911_212249_094118_78051519)
References: <20190904191155.28056-1-prestwoj@gmail.com>
         (sfid-20190904_221357_305070_478BF6CA) <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
         <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
         (sfid-20190911_175613_316165_C021A0FB) <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
         <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
         (sfid-20190911_212249_094118_78051519)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-11 at 12:20 -0700, James Prestwood wrote:

> I see what your saying, but theses kind of state changes are all over
> the place in other APIs, and undocumented: One example is
> SCAN_FLAG_FLUSH clearing out the scanning state for all other
> processes.

Scanning always changes scan list state?

> I'm sure I could find more. If we documented this attribute
> and behavior I don't see an issue.

But I'm sure you could actually find an example :-)

That doesn't really mean it's the *right* thing to do though, IMHO.

Also, who says that this is the only thing? Next up, somebody wants to
randomize the MTU? Ok, probably not, but you could pick a random other
rtnetlink attribute and have nl80211 set it. Where do we stop?

Thinking this to the extreme - why not add an rtnetlink message
interpreter into this code? ;-)

Sure, none of that is really seriously likely to happen, but I'm really
not convinced we (more or less arbitrarily) need many ways of doing the
same thing in the kernel.

Either way, regardless of that discussion, I think it'd be good if you
could repost the patches for just the "quick win" that we can all agree
on, and then we can get those reviewed and into the tree before we need
to continue this discussion; after all, while we're discussing saving
about 3 milliseconds, you're still wasting around 280 :-)

(and the easy one can be done without affecting the other, just need to
reorder the patches and split them a bit differently)

johannes

