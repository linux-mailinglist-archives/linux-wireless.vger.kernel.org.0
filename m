Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C139DCC24A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfJDSGN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 14:06:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46700 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729291AbfJDSGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 14:06:13 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGRxy-0000us-Q3; Fri, 04 Oct 2019 21:06:12 +0300
Message-ID: <d8a3195b919e86e2c39e17e8c93cc0fcef19ae12.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 04 Oct 2019 21:06:09 +0300
In-Reply-To: <87imp4sk5j.fsf@codeaurora.org>
References: <20191004131414.27372-1-luca@coelho.fi>
         <20191004131414.27372-5-luca@coelho.fi> <87imp4sk5j.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 4/8] iwlwifi: mvm: fix race in sync rx queue notification
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-10-04 at 16:41 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Naftali Goldstein <naftali.goldstein@intel.com>
> > 
> > Consider the following flow:
> >  1. Driver starts to sync the rx queues due to a delba.
> >     mvm->queue_sync_cookie=1.
> >     This rx-queues-sync is synchronous, so it doesn't increment the
> >     cookie until all rx queues handle the notification from FW.
> >  2. During this time, driver starts to sync rx queues due to nssn sync
> >     required.
> >     The cookie's value is still 1, but it doesn't matter since this
> >     rx-queue-sync is non-synchronous so in the notification handler the
> >     cookie is ignored.
> >     What _does_ matter is that this flow increments the cookie to 2
> >     immediately.
> >     Remember though that the FW won't start servicing this command until
> >     it's done with the previous one.
> >  3. FW is still handling the first command, so it sends a notification
> >     with internal_notif->sync=1, and internal_notif->cookie=0, which
> >     triggers a WARN_ONCE.
> > 
> > The solution for this race is to only use the mvm->queue_sync_cookie in
> > case of a synchronous sync-rx-queues. This way in step 2 the cookie's
> > value won't change so we avoid the WARN.
> > 
> > The commit in the "fixes" field is the first commit to introduce
> > non-synchronous sending of this command to FW.
> 
> But I don't see a Fixes field anywhere :)

Hmmm, good catch.  My script should have added it.  One more thing to
check... *sigh*

This is the aforementioned commit:

Fixes: 3c514bf831ac ("iwlwifi: mvm: add a loose synchronization of the NSSN across Rx queues")

I'll add it and include it when I send the pull-req.

Thanks!

--
Cheers,
Luca.

