Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B833FD44F
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 09:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhIAHRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 03:17:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52006 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242424AbhIAHRC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 03:17:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mLKTb-0003Fq-Oi; Wed, 01 Sep 2021 10:16:04 +0300
Message-ID: <dcc42802afee4c0a29e7eea8e4488196b86a6570.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 01 Sep 2021 10:16:02 +0300
In-Reply-To: <87k0k03jnx.fsf@codeaurora.org>
References: <c0d6e33d5f9e113e59ee34ca65a4fb45cd89f33b.camel@coelho.fi>
         <87wno44i8k.fsf@codeaurora.org>
         <e048218dbe3338124ba09908cb1e49ec89214a96.camel@coelho.fi>
         <87k0k03jnx.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: pull-request: iwlwifi-next 2021-08-26
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-09-01 at 09:16 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > > As the merge window most likely starts today, and I didn't want to
> > > unnecessarily delay rest of iwlwifi patches, I decided to pull from a
> > > commit before that DHC stuff:
> > > 
> > > git pull
> > > git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
> > > e257d969f36503b8eb1240f32653a1afb3109f86
> > > 
> > > So pulled, thanks.
> > 
> > Thanks for pulling! But we also need at least the top patch in my pull-
> > req, the one that bumps the FW API...
> 
> Can you submit that patch again and assign it to me? And don't forget
> document in the commit log why it's needed.

Thanks, Kalle!

I'll resend it.

We have a new FW API freeze every 6 weeks, so we need to bump the
newest version number that the driver supports accordingly.  In this
specific case, support for new HW will only be possible with the new FW
version, so we need it in v5.15.

I'll try to reflect that in the commit log.

--
Cheers,
Luca.

