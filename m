Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5096AC732
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2019 17:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391160AbfIGPLO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Sep 2019 11:11:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41536 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388430AbfIGPLO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Sep 2019 11:11:14 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i6cMl-0007dL-T2; Sat, 07 Sep 2019 18:11:11 +0300
Message-ID: <287fc1be9e095b7f8875635bbd72c69fd263b7e6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Sat, 07 Sep 2019 18:11:06 +0300
In-Reply-To: <87h85owov3.fsf@codeaurora.org>
References: <ed169588021b846217aa86cbf2576a1375653065.camel@coelho.fi>
         <87h85owov3.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: pull-request: iwlwifi-next 2019-09-06
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-09-07 at 10:24 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > Here's a batch of patches intended for v5.4.  This includes the last
> > patchset 4 patchsets I sent.  Usual development work.  More details
> > about the contents in the tag
> > description.
> > 
> > I pushed this to my pending branch and I got results from kbuildbot to
> > some of the series, but I didn't get any results yet from the two last
> > v2 series I sent.  I'll let you know if I get any results in the next
> > couple of days.
> 
> Yesterday evening I pulled this to my pending branch and I did get a
> success report from kbuildbot.

Great! Yesterday evening I got a "build incomplete" message and again
the same today.


> > Please let me know if there are any issues.
> > 
> > Cheers,
> > Luca.
> > 
> > 
> > The following changes since commit a18da8f6194978c2b32a8367fb0df81cc6417848:
> > 
> >   Merge tag 'mt76-for-kvalo-2019-09-05' of https://github.com/nbd168/wireless (2019-09-06 11:59:32 +0300)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2019-09-06
> 
> Pulled, thanks Luca.

Thanks!

--
Luca.

