Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3691099
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfHQNkj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 09:40:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42751 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQNkj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 09:40:39 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id A772ECED30;
        Sat, 17 Aug 2019 15:49:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Flag for detecting 802.11r Fast BSS Transition support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+ASDXNC0hwFzSTvZmUq-B7r_H+pZ3N=p_kjfMqKb1gftsmDKw@mail.gmail.com>
Date:   Sat, 17 Aug 2019 15:40:36 +0200
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Matthew Wang <matthewmwang@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kirtika Ruchandani <kirtika@google.com>,
        Jouni Malinen <j@w1.fi>
Content-Transfer-Encoding: 8BIT
Message-Id: <7CCE8D56-9E1A-4E04-9C28-E384C1B2E2EA@holtmann.org>
References: <CAAooHFeLWrY_wmCp-HWqygh8gnKsfpoPCky7SykOBKZgXkb8OQ@mail.gmail.com>
 <20190403210200.GA93453@google.com>
 <211816ff03cf188d834a21b1fbc98b4f8c5b81f4.camel@sipsolutions.net>
 <CA+ASDXOyXb0dPGOrjQR7C-b6dyftiZhkta3cwG28B9sC5wxHxQ@mail.gmail.com>
 <7687225C-D965-479E-BAE8-769B0AEADD76@holtmann.org>
 <CA+ASDXNC0hwFzSTvZmUq-B7r_H+pZ3N=p_kjfMqKb1gftsmDKw@mail.gmail.com>
To:     Brian Norris <briannorris@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Brian,

>>> Well, I guess we could just run the command and look for EOPNOTSUPP...
>> 
>> this kind of API design and usage is bad. Try-and-error approach is just not sustainable.
> 
> Sure. That "suggestion" was quite literally an afterthought. Not
> really a proper suggestion.
> 
>> Even while it is late to add a proper flag that indicates support, we need to do this to make nl80211 better for the future.
> 
> I suppose. I'm not quite sure how I would make use of that properly
> though, given the corpus of kernels out there where the flag doesn't
> exist (but the feature does). Some other heurestic for determining
> kernel recency? Compile-time flags for the relevant user space, such
> that one builds it for "new kernel API (w/ flag)" vs. "old kernel API"
> (with the latter not even trying to look for the flag)?
> 
> Or I guess a more proactive approach: implement both a "supported" and
> an "unsupported" flag, so user space can figure out a tristate: flag
> not available (old kernel -- user space is left to guess) vs. command
> supported flag vs. command not supported flag.
> 
> That seems a bit awkward though.

I would not make it this complicated. Add the flag for future kernels and the move on with life. Trying to workaround older versions is something I would not bother with. It is always possible to backport the feature to older kernels. And if you have a distribution or an OEM that cares, then that is what is going to happen.

Regards

Marcel

