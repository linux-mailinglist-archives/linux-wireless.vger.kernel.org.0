Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FF1342894
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 23:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCSWP1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 18:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCSWPV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 18:15:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD81BC06175F;
        Fri, 19 Mar 2021 15:15:20 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lNNOl-000kRz-12; Fri, 19 Mar 2021 23:15:15 +0100
Message-ID: <14f7bbfea8a17dcd12e7d40641198063428d19b3.camel@sipsolutions.net>
Subject: Re: systemd-rfkill regression on 5.11 and later kernels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Mar 2021 23:15:14 +0100
In-Reply-To: <9db9d9ae751a50c9fd1da1ee3bd4c564546ce1c5.camel@sipsolutions.net> (sfid-20210318_121746_242488_98446BA5)
References: <s5ha6r0kgt5.wl-tiwai@suse.de>
         <54859a03b8789a2800596067e06c8adb49a107f5.camel@sipsolutions.net>
         <s5ho8fgixl9.wl-tiwai@suse.de>
         <c196f9cb7ba2487fb5aceceedf860cc24c6843f2.camel@sipsolutions.net>
         <s5hczvwiumf.wl-tiwai@suse.de>
         <9db9d9ae751a50c9fd1da1ee3bd4c564546ce1c5.camel@sipsolutions.net>
         (sfid-20210318_121746_242488_98446BA5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-03-18 at 12:16 +0100, Johannes Berg wrote:
> > Yeah, that's a dilemma.  An oft-seen trick is to add more bytes for
> > the future use, e.g. extend to 16 bytes and fill 0 for the remaining.
> 
> Yeah, I guess I could stick a reserved[15] there, it's small enough.

Actually, that doesn't really help anything either.

If today I require that the reserved bytes are sent as 0 by userspace,
then any potential expansion that requires userspace to set it will
break when userspace does it and runs on an old kernel.

If I don't require the reserved bytes to be set to 0 then somebody will
invariably get it wrong and send garbage, and then we again cannot
extend it.

So ... that all seems pointless. I guess I'll send the patch as it is
now.

johannes

