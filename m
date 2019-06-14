Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D718645FD4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfFNOBE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:01:04 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42548 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfFNOBE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:01:04 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbmlL-0001i4-0t; Fri, 14 Jun 2019 16:01:03 +0200
Message-ID: <6a9c7642a2fcca60658036c605438ff2ac982bd0.camel@sipsolutions.net>
Subject: Re: [PATCH v2] Revert "cfg80211: fix processing world regdomain
 when non modular"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 14 Jun 2019 16:01:00 +0200
In-Reply-To: <32951d52-3f9d-aaee-fa07-75585c03edba@digi.com>
References: <20190614131600.GA13897@a1-hr>
         <ebab80c3f632f792373bfcace252c7a1bf65ce89.camel@sipsolutions.net>
         <32951d52-3f9d-aaee-fa07-75585c03edba@digi.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 13:58 +0000, Hodaszi, Robert wrote:
> 
> I didn't just resend that. I just realized, accidentally I forgot to fix 
> the debug message printing function, that define doesn't exist anymore. 
> Sorry for the confusion!

Oops. I looked too superficially then and didn't even see the
difference, sorry.

I guess that's why Kalle always says you should have a patch changelog
:-)

> Under "original issue", you mean the issue, which commit 
> 96cce12ff6e0bc9d9fcb2235e08b7fc150f96fd2 (cfg80211: fix processing world 
> regdomain when non modular) supposed to fix? 

Yes.

> That still won't work, but 
> that didn't work neither before I reverted the patch, because crda call 
> timeout will just drop the last packet. Also, as it re-processed the 
> last request, not just resent it, it caused undesired states. Like when 
> I used 2 WiFi modules with US regulatory domains, after enumeration, my 
> global regulator domain was set to "Country 98".
> 
> To fix my issue, why I reverted the patch, and also fix the issue the 
> reverted commit supposed to fix, I could imagine something like this. 
> But I'm not sure, it doesn't have any side effect:

[snip]

Ok, thanks. I guess I'll have to look at this in more detail.

You don't happen to have a way to reproduce either issue with a hwsim
test case?

johannes

