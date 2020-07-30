Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4482332E6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgG3NYO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgG3NYO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:24:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0B8C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:24:14 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18Xc-00DXqz-2U; Thu, 30 Jul 2020 15:24:12 +0200
Message-ID: <c3ef60c2263a6840d21f6a797ad3ffb685a728b8.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power
 limits
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     Jouni Malinen <j@w1.fi>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Date:   Thu, 30 Jul 2020 15:24:11 +0200
In-Reply-To: <87y2n9clhj.fsf@codeaurora.org>
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
         <1576684108-30177-2-git-send-email-kvalo@codeaurora.org>
         <1576748692.7758.17.camel@realtek.com> <20191219154828.GA12287@w1.fi>
         <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
         <20191219185522.GA16010@w1.fi>
         <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
         <871rpqly6a.fsf@kamboji.qca.qualcomm.com>
         <e8908eafd8e6050eef8782c6a7019e318d14f65f.camel@sipsolutions.net>
         <CA+ASDXMf7iXuE9hQ-XitPPfvXP0EK5FchJLCu2+5Ag=ZC=0H0w@mail.gmail.com>
         <87lfjjx0o7.fsf@codeaurora.org>
         <CA+ASDXOAzPuOn_rMsRj4t56kC-TgoG0p5WhSTPJjB8xTTq5kfg@mail.gmail.com>
         <87y2n9clhj.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-07-24 at 12:26 +0300, Kalle Valo wrote:

> > > So to me it feels like the best solution forward is to go with the
> > > vendor API, do you agree? We can, of course, later switch to the common
> > > API if we manage to create one which is usable for everyone.

But why wouldn't we try that now, while we have it all in our heads (in
a way ... even if this discussion drags out forever)?

I mean, the range-based approach ought to work, and if we define it as a
nested attribute list or so, we can even later add more attributes to it
(chain limits, whatnot) without any backward compatibility concerns.

So what is it that we _cannot_ do in a more common way today?

> > I think we've had some healthy (though very protracted) discussion,
> > and I don't think I've seen anyone bring up anything I wasn't already
> > aware of that would prevent eventual consolidation. As long as we
> > acknowledge those things (item 2 at
> > https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api),
> > I'm happy.
> 
> Good, I was just checking that we all are on the same page.

But are we? ;-)

I don't really see anything in the new proposal [1] that really explains
why the common API that we've sort of vaguely outlined in this thread
couldn't work? It just speaks of technical difficulties ("need a
reporting API too"), but should we let that stop us?

[1] https://patchwork.kernel.org/patch/11686317/


johannes

