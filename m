Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE21B3B4847
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jun 2021 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFYRk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Jun 2021 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRkZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Jun 2021 13:40:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04304C061574
        for <linux-wireless@vger.kernel.org>; Fri, 25 Jun 2021 10:38:04 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lwpmD-00BVYl-Tm; Fri, 25 Jun 2021 19:38:02 +0200
Message-ID: <a83bfa3f88909706fe9055be28e3664b7d482627.camel@sipsolutions.net>
Subject: Re: iw: some stats are missing from nla_policy
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Naumov <sknaumov@gmail.com>, linux-wireless@vger.kernel.org
Date:   Fri, 25 Jun 2021 19:38:01 +0200
In-Reply-To: <CAH3pVZOevaoOJ1SOOdiuzajM72WiuZYwURNQ8ky4FyUXNFmqHw@mail.gmail.com> (sfid-20210625_121104_830287_B318C078)
References: <CAH3pVZOevaoOJ1SOOdiuzajM72WiuZYwURNQ8ky4FyUXNFmqHw@mail.gmail.com>
         (sfid-20210625_121104_830287_B318C078)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sergey,
> 
> I noticed that not all parameters are added to nla_policy. For
> example, NL80211_STA_INFO_CONNECTED_TIME
> (https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/commit/?id=087d778f6f82346debfd275ddbb8f646f9a1a167)
> is parsed, but absent from stats_policy.
> 
> The question is whether it is done accidentally or deliberately? Is
> there some hidden logic not to add attributes to policy? And then why
> to use policy at all if some attributes are not checked anyway?

No, there's no particular reason or policy (pun intended) to this ...

It's kind of just being a bit lazy, and we have to trust the kernel to
not kill the process anyway, in a sense. But I think the right way still
would be to have a policy so we can detect errors.

johannes

