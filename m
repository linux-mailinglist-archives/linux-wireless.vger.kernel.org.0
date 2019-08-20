Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE695A85
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfHTI7G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 04:59:06 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:60828 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfHTI7G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 04:59:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hzzyp-000242-Tt; Tue, 20 Aug 2019 10:59:04 +0200
Message-ID: <72ac048c01619e0639fc182cd32818a5712cda1c.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 20 Aug 2019 10:59:01 +0200
In-Reply-To: <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com> (sfid-20190819_225820_644148_FB77722C)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com>
         (sfid-20190819_225820_644148_FB77722C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-19 at 15:58 -0500, Denis Kenzior wrote:
> Hi Johannes,

[...]

> Hmm... I sense a pattern of you not seeing a point in doing many 
> things... Do you actually use the stuff you maintain?

[...]

> Well, one possible use case might be, oh something like this:
> 
> https://source.android.com/devices/tech/connect/wifi-mac-randomization

[...]

> And also maybe a bunch of other optimizations like not flushing scan 
> results?

Stop.

Your tone, and in particular the constant snide comments and attacks on
me are, quite frankly, getting extremely tiring.

It almost seems like you're just trying to bully me into taking your
patches by constantly trying to make me feel that I cannot know better
anyway. This is not how you should be treating anyone.

Look, I did say I don't see a point in this, but you're taking that out
of context. I also stated that I didn't understand the whole thing about
"race conditions" and all, because nobody actually explained the
reasoning behind the changes here.

James, unlike you, managed to reply on point and explain why it was
needed. If all you can do is accuse me of not using the software and
therefore not knowing how it should be used, even implying that I'm not
smart enough to understand the use cases, then I don't know why you
bother replying at all.

I can understand your frustration to some extent, and I want to give you
the benefit of doubt and want to believe this behaviour was borne out of
it, since I've been reviewing your changes relatively critically.

However, I also want to believe that I've been (trying to) keep the
discussion on a technical level, telling you why I believe some things
shouldn't be done the way you did them, rather than telling you that
you're not smart enough to be working on this. If you feel otherwise,
please do let me know and I'll go back to understand, in order to
improve my behaviour in the future.

Please help keep the discussion technical, without demeaning undertones.

Thanks,
johannes

