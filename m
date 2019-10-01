Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA443C364E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 15:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbfJANti (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 09:49:38 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34406 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388742AbfJANti (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 09:49:38 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFIX1-0001dW-FZ; Tue, 01 Oct 2019 15:49:35 +0200
Message-ID: <616a319e4b8623508f6cd00fcfca8303f494a2de.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ramon Fontes <ramonreisfontes@gmail.com>,
        Bob Copeland <me@bobcopeland.com>
Cc:     Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 01 Oct 2019 15:49:33 +0200
In-Reply-To: <CAK8U23YMeFcQPLfWTMijyJaiX1V+NO9FWmq70nhS+bLVNxFYkg@mail.gmail.com> (sfid-20191001_152002_684460_EE3686CE)
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
         <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
         <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
         <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
         <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
         <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
         <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
         <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com>
         <CABPxzY+8Jjvjv0x79yzo+rL3nONTZSkROK1T+gMqq5nhXb=7-g@mail.gmail.com>
         <CAK8U23bb9C+16zuGi+uAYxUg-goddiSZfDAJUYeC1Xpu=jud+Q@mail.gmail.com>
         <df3b53f157e113e309360ed40b1f36b9f08f4d8c.camel@sipsolutions.net>
         <CAK8U23YMeFcQPLfWTMijyJaiX1V+NO9FWmq70nhS+bLVNxFYkg@mail.gmail.com>
         (sfid-20191001_152002_684460_EE3686CE)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-01 at 10:19 -0300, Ramon Fontes wrote:
> > Do they also have the same version of wmediumd?
> 
> Yes, they have the same version. As you can also see through the
> video, I only change the kernel and all the packages have the same
> version. I also tried to check the latest commits of mac80211_hwsim,
> but haven't found a reason for the problem yet.

I had been looking, but didn't consider that where you say "4.18" you
probably meant "4.18.xyz" for some stable version of 4.18 ...

Now that I look at that, I think most likely the reason is commit
119f94a6fefc ("cfg80211: Address some corner cases in scan result
channel updating") which was backported to the 4.18 series.

Before this commit, we'd have used the DS element all the time, after
this commit we'd trust the RX channel on 5 GHz...

Here's a test to reproduce this:

https://p.sipsolutions.net/63b37d07fd52179c.txt

However, I think the only reasonable way to fix this is in wmediumd:

https://p.sipsolutions.net/6c52392b5e31d9d1.txt

Bob, what do you think?

johannes

