Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A61923BC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCYJKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 05:10:17 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42936 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJKR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 05:10:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jH235-007mFm-CQ; Wed, 25 Mar 2020 10:10:07 +0100
Message-ID: <be3de0341e989b28f753bf4adef2b025d07bc383.camel@sipsolutions.net>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tony Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
Cc:     Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 25 Mar 2020 10:10:06 +0100
In-Reply-To: <30819fb6d90d48a9852dd0b7f59aa4f1@realtek.com>
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
         <30819fb6d90d48a9852dd0b7f59aa4f1@realtek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-03-25 at 05:54 +0000, Tony Chuang wrote:

> > That's entirely your fault, not the fault of the API. If your firmware
> > doesn't listen to your driver, then that's either your firmware or
> > your driver's fault. If you set a mask that has exactly 1 bitrate in
> > it... well, that's exactly what you should tell your firmware to do.
> > Not, "use this 1 bitrate, but try something else if you feel like it."
> 
> I cannot agree with it.

I tend to agree with Brian. If userspace, for some reason, told you that
only one rate is acceptable, then you should listen to that - if you
support the API at all.

> Let's be clear here:
> 
> If there's a rate mask comes from upper space, does it mean
> That driver or firmware/hardware can only use those rates
> masked when *802.11 retry*?

Yes.

> And use a lower rate when
> retry is called rate-fallback as I've mentioned before.  So I
> think the problem here is, do we need another option in the
> existing nl80211 command, if 802.11 *retry* is still allowed to
> choose a rate not in the rate mask?

Perhaps you'd like to have such an extension to the API, but that's not
what's there today. Today, the expectation is that you use these rates,
not some other rates you figured out from something.

Now, mac80211 is/was actually slightly buggy here at some point, and not
all drivers support this, but that's what the API was intended for.

Not some kind of "oh, let's try to start with these rates and then do
whatever we like later".

> In my opinion, if 802.11
> retry should be disabled, then all of the algorithm of the existing
> rate adaptive mechanism for rtw88 should be totally re-designed
> and we will have to rebuild another one.

Disabling retries has nothing to do with it. Only limiting the rates
that can be used (even for retries).

johannes

