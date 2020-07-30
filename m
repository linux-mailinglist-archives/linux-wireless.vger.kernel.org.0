Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BF42332D8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgG3NSF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgG3NSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:18:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778FC061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:18:05 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18Rb-00DXgi-3n; Thu, 30 Jul 2020 15:17:59 +0200
Message-ID: <b17c0e5ad80050df4da85653d413a71cfcc37629.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power
 limits
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Jouni Malinen <j@w1.fi>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Date:   Thu, 30 Jul 2020 15:17:57 +0200
In-Reply-To: <CA+ASDXMf7iXuE9hQ-XitPPfvXP0EK5FchJLCu2+5Ag=ZC=0H0w@mail.gmail.com> (sfid-20200602_033247_740183_F75D1728)
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
         <1576684108-30177-2-git-send-email-kvalo@codeaurora.org>
         <1576748692.7758.17.camel@realtek.com> <20191219154828.GA12287@w1.fi>
         <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
         <20191219185522.GA16010@w1.fi>
         <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
         <871rpqly6a.fsf@kamboji.qca.qualcomm.com>
         <e8908eafd8e6050eef8782c6a7019e318d14f65f.camel@sipsolutions.net>
         <CA+ASDXMf7iXuE9hQ-XitPPfvXP0EK5FchJLCu2+5Ag=ZC=0H0w@mail.gmail.com>
         (sfid-20200602_033247_740183_F75D1728)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-06-01 at 18:32 -0700, Brian Norris wrote:
> I haven't quite reached the 3 month lag on the prior replies here :)

But I did, almost ;-)

> I do want to see this question resolved somehow, or else we'll be
> dragging along out-of-tree patches for...(counts on fingers)...4
> different nl80211 APIs for the same feature, and a driver-detecting
> user space for it.

Right.

> I think I was half-hoping that we'd get to chat at
> netdev about this, but that's not happening any time soon. (Topic for
> another day: does a "wireless workshop" still happen at a virtual-only
> conference?)

Yes, but only a short 1.5hr video call I guess. I'm not even sure what
to do there yet.

[snip]

Thanks for the overview!

> Also, Kalle had some concerns about stable ABI questions: shouldn't we
> bake in some kind of "check for support" feature to these kinds of
> APIs [3]? That would help ease transition, if we do start with a
> vendor API and move to a common one in the future. Given the nature of
> this feature, I wouldn't expect there will be a large variety of users
> making use of the APIs -- and I, for one, would be happy to migrate my
> user space over some period of time, as needed.

We do that? We list out the available vendor APIs, and in most cases
(perhaps not the one you've noticed there) we also list out the
availability of real nl80211 APIs in some way.

johannes

