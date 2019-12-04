Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E684611242A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 09:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfLDIIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 03:08:07 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44550 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 03:08:06 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icPhY-00HZvi-VX; Wed, 04 Dec 2019 09:08:01 +0100
Message-ID: <fa98f3b62454370ef6c1951571ba1789ac2679c3.camel@sipsolutions.net>
Subject: Re: [Make-wifi-fast] [PATCH v8 0/2] Implement Airtime-based Queue
 Limit (AQL)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, Kan Yan <kyan@google.com>
Cc:     Dave Taht <dave@taht.net>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Wed, 04 Dec 2019 09:07:59 +0100
In-Reply-To: <0101016ecf3bc899-6e391bba-96ed-4495-a7be-1aa8dd8f1bf2-000000@us-west-2.amazonses.com>
References: <20191115014846.126007-1-kyan@google.com>
         <CA+iem5vaeLR6v_nZ1YUZhfj32wF0DrvC2nyp8nb8qYAZLQjLdw@mail.gmail.com>
         <CAA93jw5wTbFV51oFJ6tFHLUMo=bau8fbU65k57bQjOHGJoCkkQ@mail.gmail.com>
         <CA+iem5s4ZY239Q4=Gwy3WrmVhcdhesirXph6XQoOP5w-nuWcYw@mail.gmail.com>
         <CAA93jw5t0TwBVv7_DVkJ_-NsVn0ODNHwU0orp2-+LPB45iFVoQ@mail.gmail.com>
         <CA+iem5uVJFcCYpJfhker-48XPrOf3a+NWr-nKnBtGmLX2yB_Lg@mail.gmail.com>
         <8736eiam8f.fsf@toke.dk>
         <CA+iem5tpfEmaWJ5Mw7xF9fb=XLceZpC1LM4Avo89Mn1fL7YZVw@mail.gmail.com>
         <87a78p8rz7.fsf@toke.dk>
         <CA+iem5tNz2jjEOVmbh3aPTXLLZfkRjZ60-+bon1vDEJ8D4hQJw@mail.gmail.com>
         <87muco5gv5.fsf@toke.dk>
         <CA+iem5sBPq0mfz+Qx+uJqCZ6t-Cjru+GCBcYExdu6JueUbBXyw@mail.gmail.com>
         <87eexvyoy8.fsf@toke.dk> <878so2m5gp.fsf@nemesis.taht.net>
         <CA+iem5vVGSJXeB8k2n32f=TvqncEj+bOjVbunWS0G8sm_MEosw@mail.gmail.com>
         <0101016ecf3bc899-6e391bba-96ed-4495-a7be-1aa8dd8f1bf2-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-12-04 at 04:47 +0000, Kalle Valo wrote:
> 
> > Overall, I think AQL and fq_codel works well, at least with ath10k.
> > The current target value of 20 ms is a reasonable default.  It is
> > relatively conservative that helps stations with weak signal to
> > maintain stable throughput. Although, a debugfs entry that allows
> > runtime adjustment of target value could be useful.
> 
> Why not make it configurable via nl80211? We should use debugfs only for
> testing and debugging, not in production builds, and to me the use case
> for this value sounds like more than just testing.

On the other hand, what application/tool or even user would be able to
set this correctly?

johannes

