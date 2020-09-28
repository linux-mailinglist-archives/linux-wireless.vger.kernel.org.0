Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC1B27AE02
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1Mj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 08:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1MjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 08:39:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A8EC061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 05:39:25 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMsR9-00CU38-WA; Mon, 28 Sep 2020 14:39:24 +0200
Message-ID: <1cd666a56750eaf1c1f114bf3809ac00539938b7.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: support HE rate configuration in 6 GHz band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 14:39:23 +0200
In-Reply-To: <0fe60ead4260aea18a6e2ce8c6e6387f@codeaurora.org>
References: <1600276451-3259-1-git-send-email-rmanohar@codeaurora.org>
         <cff3474685590bbc9663f970bb0a4a10143d3913.camel@sipsolutions.net>
         <fe2b37ecbe10eb1ceb2b25eaabb76efa@codeaurora.org>
         <8a3380b3d3f12610e8cf4c6d51f5a33fed7b85c6.camel@sipsolutions.net>
         <0fe60ead4260aea18a6e2ce8c6e6387f@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-09-18 at 13:01 -0700, Rajkumar Manoharan wrote:
> On 2020-09-18 12:19, Johannes Berg wrote:
> > On Fri, 2020-09-18 at 11:49 -0700, Rajkumar Manoharan wrote:
> > > On 2020-09-18 04:25, Johannes Berg wrote:
> > > > On Wed, 2020-09-16 at 10:14 -0700, Rajkumar Manoharan wrote:
> > > > > Allow HE-MCS, HE-GI, HE-LTF in 6 GHz band as well and allow only
> > > > > MCS rates in 6 GHz.
> > > > 
> > > > This doesn't apply at all, please respin.
> > > > 
> > > My bad. Forgot to mention that this change depends on "iw: add HE
> > > rate/gi/ltf support".
> > > 
> > > https://patchwork.kernel.org/patch/11364395/
> > 
> > Oh. But can I apply that? I think the kernel bits weren't there? But I
> > get confused with John's patch series'...
> > 
> The kernel bits are available in mac80211-next. Thought you sync 
> nl80211.h from -next tree.

I do, usually.

> If so, you can apply John's patch as well as mine.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git/commit/include/uapi/linux/nl80211.h?id=eb89a6a6b7a1af2d9c8d83ee44fa67700d6337e7
> 
> Sorry if I confused you further. :)

Yeah, hmm. Can you just resend any patches please?

johannes

