Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49794DAF5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 22:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfFTUJr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 16:09:47 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44888 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfFTUJr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 16:09:47 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1he3NR-0004kv-U5; Thu, 20 Jun 2019 22:09:46 +0200
Message-ID: <144f36779085498bdc1b2f7ac0d0c267d431f51d.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 20 Jun 2019 22:09:44 +0200
In-Reply-To: <427f488f-98f5-f888-f079-e2bbbb6eedf3@gmail.com> (sfid-20190620_220528_438291_AA97E7A5)
References: <20190619223606.4575-1-denkenz@gmail.com>
         <20190619223606.4575-3-denkenz@gmail.com>
         <ec1ca95a5789f9001e89e603633b20316d687721.camel@sipsolutions.net>
         <7da9b924-78c7-ba72-fecc-a11700a34ff4@gmail.com>
         <44923833f1068e360b1f9534a9bbd37be41e4833.camel@sipsolutions.net>
         <427f488f-98f5-f888-f079-e2bbbb6eedf3@gmail.com>
         (sfid-20190620_220528_438291_AA97E7A5)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-20 at 15:05 -0500, Denis Kenzior wrote:
> 
> Ugh.  So, if I understand this correctly, NEW_WIPHY events that are 
> generated when a new wiphy is plugged would only send the old 'legacy' 
> info and any info we add in cases 9+ would be 'lost' and the application 
> is forced into re-dumping the phy.

Yes.

> This is pretty much counter to what we want.

Well, you want the info, shouldn't matter how you get it?

> If you want to keep your sanity in userspace, you need proper 'object 
> appeared' / 'object disappeared' events from the kernel.

Sure, but you don't really need to know *everything* about the events
right there ... you can already filter which ones you care about
(perhaps you know you never want to bind hwsim ones for example) and
then request data on those that you do need.

> And those 
> events should have all or nearly all info to not bother the kernel going 
> forward.

That's what you wish for, but ...

>   It sounds like nl80211 API has run into the extend-ability 
> wall, no?

I don't really see it that way.

> Any suggestions on how to resolve this?  Should NEW_WIPHY events also do 
> the whole split_dump semantic and generate 15+ or whatever messages?

No, that'd be awful, and anyway you'd have to send a new command because
otherwise old applications might be completely confused (not that I know
of any other than "iw event" that would event listen to this, but who
knows)

johannes

