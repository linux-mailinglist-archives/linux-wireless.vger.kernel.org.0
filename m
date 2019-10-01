Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67260C31E5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfJALAc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfJALAc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:00:32 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CED02133F;
        Tue,  1 Oct 2019 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569927631;
        bh=/rD1NXp0yBqq0N4gwG67dO1KzQlRYlyRZCVj4yCgDH4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=M83NJw1SKsydoUIyRFVbj/3mFHTsyIiGmZAkhwZm8ELaFaxmYD8nnaWyuSWF/Uwgo
         KeW0v0en9aY6sQao7/EFl9z4WlZgplfoNCnR7qOsxfSWkJUkhIK23AiNpW6Qfikrsi
         F1SzWjdN82aBg01HXB4jd0HPqOrDoBtYak0SAgnk=
Date:   Tue, 1 Oct 2019 12:56:59 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>
cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Aaron Hill <aa1ronham@gmail.com>,
        Lukas Redlinger <rel+kernel@agilox.net>,
        Oleksii Shevchuk <alxchk@gmail.com>
Subject: Re: [PATCH] mac80211: keep BHs disabled while calling
 drv_tx_wake_queue()
In-Reply-To: <87blv0visz.fsf@toke.dk>
Message-ID: <nycvar.YFH.7.76.1910011256001.13160@cbobk.fhfr.pm>
References: <1569924485-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid> <87blv0visz.fsf@toke.dk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 1 Oct 2019, Toke Høiland-Jørgensen wrote:

> > -			spin_unlock_bh(&fq->lock);
> > +			spin_unlock(&fq->lock);
> >  			drv_wake_tx_queue(local, txqi);
> > -			spin_lock_bh(&fq->lock);
> > +			spin_lock(&fq->lock);
> 
> Okay, so this will mean that the drv_wake_tx_queue() entry point will be
> called with bhs disabled. But there are lots of uses of
> spin_{,un}lock_bh() in tx.c:

I am fine with whatever fix for this you guys settle on :) Just for the 
record, I proposed this back then:

	http://lore.kernel.org/r/nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm

maybe it could be resurected, as I believe it'd fix this one as well?

But again, I have absolutely no preference either way, only that it'd be 
nice to have this fixed :)

Thanks!

-- 
Jiri Kosina
SUSE Labs

