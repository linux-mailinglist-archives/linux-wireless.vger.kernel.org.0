Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A614E339F8D
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Mar 2021 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhCMRgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 12:36:19 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:48782 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234010AbhCMRfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 12:35:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lL8Az-004U3u-MX; Sat, 13 Mar 2021 19:35:47 +0200
Message-ID: <c1681fa49280189c48ecf9f86fe54b81d662dc07.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 13 Mar 2021 19:35:44 +0200
In-Reply-To: <87zgz7t246.fsf@codeaurora.org>
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
         <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm>
         <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm>
         <87h7lfbowr.fsf@tynnyri.adurom.net>
         <nycvar.YFH.7.76.2103131642290.12405@cbobk.fhfr.pm>
         <f103b4a29b7c1942f091bd7b90d7a927d72c20a2.camel@coelho.fi>
         <87zgz7t246.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_enqueue_hcmd()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2021-03-13 at 19:06 +0200, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > On Sat, 2021-03-13 at 16:43 +0100, Jiri Kosina wrote:
> > > On Sat, 13 Mar 2021, Kalle Valo wrote:
> > > 
> > > > > > > From: Jiri Kosina <jkosina@suse.cz>
> > > > > > > 
> > > > > > > It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs 
> > > > > > > disabled (e.g. from LED core). We can't enable BHs in such a situation.
> > > > > > > 
> > > > > > > Turn the unconditional BH-enable/BH-disable code into 
> > > > > > > hardirq-disable/conditional-enable.
> > > > > > > 
> > > > > > > This fixes the warning below.
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > friendly ping on this one ... 
> > > > > 
> > > > > Luca,
> > > > > 
> > > > > Johannes is telling me that he merged this patch internally, but I have no 
> > > > > idea what is happening to it ... ?
> > > > > 
> > > > > The reported splat is a clear bug, so it should be fixed one way or the 
> > > > > other.
> > > > 
> > > > Should I take this to wireless-drivers?
> > > 
> > > I can't speak for the maintainers, but as far as I am concerned, it 
> > > definitely is a 5.12 material, as it fixes real scheduling bug.
> > 
> > Yes, please take this to w-d.  We have a similar patch internally, but
> > there's a backlog and it will take me some time to get to it.  I'll
> > resolve eventual conflicts when time comes.
> 
> Ok, can I have your ack for patchwork?

Sorry, forgot that.

Acked-by: Luca Coelho <luciano.coelho@intel.com>

--
Cheers,
Luca.

