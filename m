Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1AC338E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfJAL62 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJAL61 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:58:27 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB1EF20640;
        Tue,  1 Oct 2019 11:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569931107;
        bh=OgiOZU38SqL+RT076Kc7vgcWrZhVApcF4i/OOXDXLLs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=egy2YD35xaXZYM//mgnYkOr1VGNb87DOmezbNO64raOOdHz0bxO4Jb/gFBquCLPiV
         HABRDpoQ/n7RTyVQZ8uOGmDL8f/KNeqB8/PJdlJXsJ5PveHIMV4sdEpMSEm5sMfJfy
         Eq++tKhDTYQTA5yHjLpFffem6fDCXmO60Y9Td3iE=
Date:   Tue, 1 Oct 2019 13:58:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>
cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Aaron Hill <aa1ronham@gmail.com>,
        Lukas Redlinger <rel+kernel@agilox.net>,
        Oleksii Shevchuk <alxchk@gmail.com>
Subject: Re: [PATCH v2] mac80211: keep BHs disabled while calling
 drv_tx_wake_queue()
In-Reply-To: <87tv8su1up.fsf@toke.dk>
Message-ID: <nycvar.YFH.7.76.1910011357470.13160@cbobk.fhfr.pm>
References: <1569928763-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid> <87tv8su1up.fsf@toke.dk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 1 Oct 2019, Toke Høiland-Jørgensen wrote:

> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > Drivers typically expect this, as it's the case for almost all cases
> > where this is called (i.e. from the TX path). Also, the code in mac80211
> > itself (if the driver calls ieee80211_tx_dequeue()) expects this as it
> > uses this_cpu_ptr() without additional protection.
> >
> > This should fix various reports of the problem:
> > https://bugzilla.kernel.org/show_bug.cgi?id=204127
> > https://lore.kernel.org/linux-wireless/CAN5HydrWb3o_FE6A1XDnP1E+xS66d5kiEuhHfiGKkLNQokx13Q@mail.gmail.com/
> > https://lore.kernel.org/lkml/nycvar.YFH.7.76.1909111238470.473@cbobk.fhfr.pm/
> >
> > Reported-by: Jiri Kosina <jikos@kernel.org>

Reported-and-tested-by: Jiri Kosina <jkosina@suse.cz>

> > Reported-by: Aaron Hill <aa1ronham@gmail.com>
> > Reported-by: Lukas Redlinger <rel+kernel@agilox.net>
> > Reported-by: Oleksii Shevchuk <alxchk@gmail.com>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>

Thanks,

-- 
Jiri Kosina
SUSE Labs

