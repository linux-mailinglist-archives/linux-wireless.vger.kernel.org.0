Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1E339EF7
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Mar 2021 16:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhCMPno (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 10:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhCMPnO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 10:43:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 553A364E07;
        Sat, 13 Mar 2021 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615650194;
        bh=giY0FNup90bsA9e7Qg8ciSUPfUygNZHjbQUyRstuaPw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=A5aYnw9sIjY/tOhchJui1crLf0TwokhL9XpQD/RcEeYrUAjIN4qiPvt1GRaou5ukF
         vGFAz2vRkTPxpCkMQs+ZW9uvbkmxPO3NZ7xqIhm3nh4Yk6f0A+YcQ2i/C6trUjUKjg
         F5e8r3y8Fzb1fMBvq4ouU/BQU7dEHkSbxwb0FLVCnI7I+NG/J4/EPKvtpmrmayASMX
         ElFr1+bx+/UT7l4NWLQeukTBx3q3nkM9h3i46XGfv4Im+t9wF+T4iaa2145LjA1xA6
         XF2XtC7nJyZcwwKf5EacdoesEjGTRGVkOdccvI9KvNv2ktgAR0OaZjM6YjHDMMX8EF
         6V1ouSogJzoQg==
Date:   Sat, 13 Mar 2021 16:43:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
cc:     Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_enqueue_hcmd()
In-Reply-To: <87h7lfbowr.fsf@tynnyri.adurom.net>
Message-ID: <nycvar.YFH.7.76.2103131642290.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm> <87h7lfbowr.fsf@tynnyri.adurom.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 13 Mar 2021, Kalle Valo wrote:

> >> > From: Jiri Kosina <jkosina@suse.cz>
> >> > 
> >> > It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs 
> >> > disabled (e.g. from LED core). We can't enable BHs in such a situation.
> >> > 
> >> > Turn the unconditional BH-enable/BH-disable code into 
> >> > hardirq-disable/conditional-enable.
> >> > 
> >> > This fixes the warning below.
> >> 
> >> Hi,
> >> 
> >> friendly ping on this one ... 
> >
> > Luca,
> >
> > Johannes is telling me that he merged this patch internally, but I have no 
> > idea what is happening to it ... ?
> >
> > The reported splat is a clear bug, so it should be fixed one way or the 
> > other.
> 
> Should I take this to wireless-drivers?

I can't speak for the maintainers, but as far as I am concerned, it 
definitely is a 5.12 material, as it fixes real scheduling bug.

Thanks,

-- 
Jiri Kosina
SUSE Labs

