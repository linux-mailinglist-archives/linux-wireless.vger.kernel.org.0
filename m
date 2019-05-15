Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F061EC21
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 12:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfEOKdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 06:33:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfEOKdQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 06:33:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08C8A3018760;
        Wed, 15 May 2019 10:33:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E95AF608A6;
        Wed, 15 May 2019 10:33:12 +0000 (UTC)
Date:   Wed, 15 May 2019 12:33:10 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190515103309.GA15134@redhat.com>
References: <cover.1557591530.git.lorenzo@kernel.org>
 <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
 <87r293ugia.fsf@purkki.adurom.net>
 <20190513084127.GA3127@localhost.localdomain>
 <20190513094837.GB15694@redhat.com>
 <20190515093333.GA2333@redhat.com>
 <20190515094354.GA30757@localhost.localdomain>
 <20190515095440.GB3407@redhat.com>
 <20190515100343.GB30757@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515100343.GB30757@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 15 May 2019 10:33:16 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 12:03:44PM +0200, Lorenzo Bianconi wrote:
> > On Wed, May 15, 2019 at 11:43:55AM +0200, Lorenzo Bianconi wrote:
> > > > On Mon, May 13, 2019 at 11:48:37AM +0200, Stanislaw Gruszka wrote:
> > > > > On Mon, May 13, 2019 at 10:41:28AM +0200, Lorenzo Bianconi wrote:
> > > > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > > > 
> > > > > > > > Introduce a knob in mt7603 debugfs in order to enable/disable
> > > > > > > > edcca processing
> > > > > > > >
> > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > 
> > > > > > > It's good to explain what edcca does and how the file is used supposed
> > > > > > > to be used. In other words, have a small introduction for the user.
> > > > > > 
> > > > > > Hi Kalle,
> > > > > > 
> > > > > > edcca is used for adjusting energy detect based on CCA thresholds.
> > > > > > The code was already there so I just reported the acronym.
> > > > > 
> > > > > What for it is needed ?
> > > > 
> > > > Care to comment why EDCCA is needed at all ?
> > > > 
> > > > Taking that debugfs file that enable it is read-only, it looks like
> > > > feature that nobody needs nor tests.
> > > 
> > > already fixed in v2
> > > https://patchwork.kernel.org/patch/10940645/
> > 
> > I'm aware of this patch and other one for mt76x02. But so far in the
> > sources EDCCA is disabled for mt76x02 without possibility to enable it
> > (and this permission file issue was pointed by Kalle during review, not
> > by someone who want to test EDCCA). So again, what for EDCCA is needed ?
> 
> As I have already written in a previous email, ED/CCA is used to control tx power
> according to the CCA MIB counters (e.g do not transmit if the channel busy time
> is higher than 90% for given amount of time in a row). I guess it is required
> by ETSI regulatory.
But what is user case for that, i.e. who need this (it wasn't implemented in
mt76x2 since you added it on Dec 2018). What will happen if it will be removed?

> Regarding file permission for mt76x02 debugfs edcca node is a typo.
Typo or not, effectively disable the feature and show nobody is
testing it.

The reason I'm asking is that seems EDCCA is the main reason to
implement watchod for mt76x2, it wasn't necessary to have a watchdog
as seems devices did not hung before EDCCA was added.

Stanislaw
