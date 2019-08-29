Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A70A2227
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 19:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfH2RY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 13:24:29 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44590 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2RY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 13:24:29 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3O9r-0005kH-II; Thu, 29 Aug 2019 19:24:27 +0200
Message-ID: <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ramon Fontes <ramonreisfontes@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 29 Aug 2019 19:24:25 +0200
In-Reply-To: <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com> (sfid-20190829_190437_979108_D411F41E)
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
         <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
         <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
         (sfid-20190829_190437_979108_D411F41E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-29 at 14:04 -0300, Ramon Fontes wrote:
> Yes, that's what I (we?) expect.
> 
> Yes, wmediumd has some log files, but they don't help me to identify
> the reason of the problem. I also unsuccessfully tried to modified the
> wmediumd code. Both wmediumd and mac80211_hwsim work fine up to kernel
> version 4.17. The problem comes only from kernel 4.18. Since there are
> some wmediumd related-codes in mac80211_hwsim, I was wondering whether
> something wasn't missing in mac80211_hwsim (or even some needed
> changes in wmediumd) that is causing such problem.

Hmm, but are there? There's basically no change in hwsim between 4.17
and 4.18, only a few error path cleanups/fixes and the SUPPORTS_PS
change which also shouldn't matter for this?

> Another weird thing
> is the channel, since the channel is the same as defined in hostapd
> and doesn't match 5Ghz channels.

You mean the DS element? That's just from the frame itself.

johannes

