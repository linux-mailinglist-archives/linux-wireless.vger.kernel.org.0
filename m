Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF41E09A6
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbgEYJHM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbgEYJHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:07:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF384C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 02:07:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd94X-002b7U-Sl; Mon, 25 May 2020 11:07:02 +0200
Message-ID: <6488cbbfbaa0f6591fa7b495e9c8d500603ca5e8.camel@sipsolutions.net>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>,
        Ben Greear <greearb@candelatech.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 25 May 2020 11:07:00 +0200
In-Reply-To: <CA+ASDXNQxea+83+h87OQwDV-n_Sb8ENyEGx=BsJbMa3G9kkEVQ@mail.gmail.com> (sfid-20200325_191503_900952_26F93B7F)
References: <20200313065114.23433-1-yhchuang@realtek.com>
         <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
         <2e492e530d744713871f885e324106ef@realtek.com>
         <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
         <ce990869ebf0478d98cd7e8416b36289@realtek.com>
         <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
         <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com>
         <fbab3328d183406c923b30381389841f@realtek.com>
         <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
         <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
         <3894907ca6bf4566b8716731492a869b@realtek.com>
         <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
         <efa8c2f3-8254-8d36-20ec-9afb8ffb2339@candelatech.com>
         <CA+ASDXNQxea+83+h87OQwDV-n_Sb8ENyEGx=BsJbMa3G9kkEVQ@mail.gmail.com>
         (sfid-20200325_191503_900952_26F93B7F)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-03-25 at 11:14 -0700, Brian Norris wrote:
> On Wed, Mar 25, 2020 at 8:52 AM Ben Greear <greearb@candelatech.com> wrote:
> > On 03/24/2020 10:16 PM, Brian Norris wrote:
> > > Sure, but if you mask out all but 1 bitrate...voila! A fixed rate!
> > 
> > So, see this thread from a while back.  Has anyone even *tried* to use
> > this API you are proposing?
> 
> Yes, in fact, I have! Which is why I noted:
> 
> > > Now, there are other problems, like the others that Ben mentioned: the
> > > rest of the mac80211 framework doesn't like it too much if you really
> > > disable all but 1 rate (arguably a mac80211 bug -- but not a nl80211
> > > bug)
> > http://lists.infradead.org/pipermail/ath10k/2017-October/010291.html
> 
> I hadn't seen that thread. So it sounds like maybe Johannes isn't
> quite on the same page as Johannes ;)

Hah. Happens all the time, not sure what that other Johannes is thinking
;-)

More seriously though, I'm a bit lost now (and a big part of that is
probably because I'm replying to a 2 months old thread, sorry).

> If we're going to be particular about matching the AP's basic rates,
> then this API is indeed probably not useful for the "single fixed rate
> [for debugging/testing]" use case.
> 
> >      mac80211: Revert some of e8e4f5, fixes setting single rate in ath10k.
> 
> Commit e8e4f5 was an unfortunate consequence of the stuff I mentioned
> earlier about how Chrome OS used to use SET_TX_BITRATE_MAX -- we
> weren't nuanced about it at all, so we might configure a set of
> bitrates that doesn't intersect at all with the AP's BasicRates. That
> does make it hard for the driver/framework to decide what to do: do we
> listen to the user, or to the AP? Incidentally, that's also one reason
> why Chrome OS no longer uses the API; it was too big of a hammer for
> what we want (initial-connection reliability), and required us to be
> more delicate about {Supported,Basic}Rates than we really wanted to.

Right.

But I'm not sure why Ben needs to just do a pr_err()? Shouldn't that
just not happen?

Hmm.

johannes

