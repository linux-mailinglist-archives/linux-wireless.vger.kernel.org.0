Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5298E1A797A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439155AbgDNLaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 07:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728699AbgDNL3L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 07:29:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE7C061A0C
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2020 04:29:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jOJkX-00Gvc2-SS; Tue, 14 Apr 2020 13:29:05 +0200
Message-ID: <895ba040fcefbc8899cf297c09dfbf804ec4bc87.camel@sipsolutions.net>
Subject: Re: [PATCH v5.7 4/8] iwlwifi: mvm: limit maximum queue appropriately
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mark Asselstine <asselsm@gmail.com>, Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 14 Apr 2020 13:29:04 +0200
In-Reply-To: <CAPuovE+Pmh71BNWdKEBJYYVhuowL3XABMyDtk6kbFTzfSR3M+g@mail.gmail.com> (sfid-20200403_191045_693592_55FBA86D)
References: <20200403082955.1126339-1-luca@coelho.fi>
         <iwlwifi.20200403112332.0ed2f71aee7f.I3a4af6b03b87a6bc18db9b1ff9a812f397bee1fc@changeid>
         <CAPuovEJK8AUBPeBBi=BMx-o+9krdA-_NqCJLByWHV2_q2b42Ow@mail.gmail.com>
         <CAPuovE+Pmh71BNWdKEBJYYVhuowL3XABMyDtk6kbFTzfSR3M+g@mail.gmail.com>
         (sfid-20200403_191045_693592_55FBA86D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-03 at 13:10 -0400, Mark Asselstine wrote:
> On Fri, Apr 3, 2020 at 10:38 AM Mark Asselstine <asselsm@gmail.com> wrote:
> > On Fri, Apr 3, 2020 at 4:32 AM Luca Coelho <luca@coelho.fi> wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > Due to some hardware issues, queue 32 isn't usable on devices that have
> > > 32 queues (7000, 8000, 9000 families),
> 
> Is this statement really correct?

No, it should've said "queue 31" since they're numbered 0-based ...

> All these devices have 31 queues
> according to (.num_of_queues = 31).

Well, they were supposed to have 32, but there's some issue with the
last one. I don't really even remember what's up with it, but we just
never use it.

> Without a HW specification I can't
> be 100% sure but you should have this information within Intel. From
> the details of my patch and my investigation, this should be nack'd
> along with an explanation as to why my fix is not valid.

I don't see any real difference to your fix? Your fix marks them as used
before, whereas mine just avoids looking at them.

johannes

