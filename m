Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF52419DE59
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 21:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgDCTI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 15:08:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45588 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728276AbgDCTI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 15:08:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jKRfu-0009Dw-Tc; Fri, 03 Apr 2020 22:08:20 +0300
Message-ID: <b8690095cf1b37b4ffca02f3959ad315b6f629ee.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Mark Asselstine <asselsm@gmail.com>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 03 Apr 2020 22:08:17 +0300
In-Reply-To: <08f1736dc95604f2a2fa47c2836251735e89ae99.camel@sipsolutions.net>
References: <20200403082955.1126339-1-luca@coelho.fi>
         <iwlwifi.20200403112332.75faaf2137f4.I9e27ccc3ee3c8855fc13682592b571581925dfbd@changeid>
         <CAPuovEJ7b36wEh7=8GQUx8dp_fx2AuQS4ivKb3tuHeP31HwyUQ@mail.gmail.com>
         (sfid-20200403_164636_006277_60796736) <08f1736dc95604f2a2fa47c2836251735e89ae99.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v5.7 7/8] iwlwifi: mvm: fix inactive TID removal return
 value usage
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-03 at 20:58 +0200, Johannes Berg wrote:
> On Fri, 2020-04-03 at 10:46 -0400, Mark Asselstine wrote:
> > On Fri, Apr 3, 2020 at 4:31 AM Luca Coelho <luca@coelho.fi> wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > I sent Johannes part of this fix weeks ago and heard nothing back. I
> > am far from a glory hound but something is wrong with this list if
> > fixes are sat on for weeks and then the fix shows up with any
> > acknowledgment lost. At minimum a note saying that a fix existed and
> > would be merged shortly would have been nice.
> 
> Uh, sorry. I really didn't have your fix on my radar when developing
> this, and cannot even remember it now.
> 
> I guess I could've saved myself some work there ...

This is my fault, sorry.  I've been sitting on patches sent to the list
for some time now.  I have a big backlog of patches in our internal
tree to send out and have been prioritizing those before processing
patches coming from the community.

I'm finally catching up now with fixes for v5.7 (and stable) and I
promise to do better from now on.

My sincere apologies.

--
Cheers,
Luca.

