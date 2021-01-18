Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704FA2FA536
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404434AbhARPw7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 10:52:59 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40894 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405967AbhARPwi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 10:52:38 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l1Woo-003tjP-Je; Mon, 18 Jan 2021 17:51:51 +0200
Message-ID: <61e64922f182c751992b3f108f9224a0d8f994dc.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 18 Jan 2021 17:51:48 +0200
In-Reply-To: <871reigtok.fsf@codeaurora.org>
References: <20210115110558.1248847-1-luca@coelho.fi>
         <iwlwifi.20210115130253.621c948b1fad.I3ee9f4bc4e74a0c9125d42fb7c35cd80df4698a1@changeid>
         <875z3ugtsd.fsf@codeaurora.org> <871reigtok.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH for v5.11 11/12] iwlwifi: pcie: use jiffies for memory
 read spin time limit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-01-18 at 17:18 +0200, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
> > Luca Coelho <luca@coelho.fi> writes:
> > 
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > There's no reason to use ktime_get() since we don't need any better
> > > precision than jiffies, and since we no longer disable interrupts
> > > around this code (when grabbing NIC access), jiffies will work fine.
> > > Use jiffies instead of ktime_get().
> > > 
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > 
> > What bug does this fix? After reading the commit log to me this looks
> > like more like cleanup and is better for -next.
> 
> Ah, this is a dependency for patch 12. I'll mention this in the commit
> log, but please correct me if I have misunderstood.

Yes, you're right! It's a dependency and I thought it would be simpler
and cause less conflicts if I just took it too instead of sending them
via different trees.

--
Cheers,
Luca.

