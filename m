Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9ECD1EB82
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEOJ4I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 05:56:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfEOJ4I (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 05:56:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C36F3086212;
        Wed, 15 May 2019 09:56:08 +0000 (UTC)
Received: from localhost (unknown [10.43.2.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91EA919C71;
        Wed, 15 May 2019 09:56:05 +0000 (UTC)
Date:   Wed, 15 May 2019 11:54:41 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7603: add debugfs knob to enable/disable edcca
Message-ID: <20190515095440.GB3407@redhat.com>
References: <cover.1557591530.git.lorenzo@kernel.org>
 <0691acb931e963cb6028d4687cdd61032d0aaf52.1557591530.git.lorenzo@kernel.org>
 <87r293ugia.fsf@purkki.adurom.net>
 <20190513084127.GA3127@localhost.localdomain>
 <20190513094837.GB15694@redhat.com>
 <20190515093333.GA2333@redhat.com>
 <20190515094354.GA30757@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515094354.GA30757@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 15 May 2019 09:56:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 15, 2019 at 11:43:55AM +0200, Lorenzo Bianconi wrote:
> > On Mon, May 13, 2019 at 11:48:37AM +0200, Stanislaw Gruszka wrote:
> > > On Mon, May 13, 2019 at 10:41:28AM +0200, Lorenzo Bianconi wrote:
> > > > > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> > > > > 
> > > > > > Introduce a knob in mt7603 debugfs in order to enable/disable
> > > > > > edcca processing
> > > > > >
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > 
> > > > > It's good to explain what edcca does and how the file is used supposed
> > > > > to be used. In other words, have a small introduction for the user.
> > > > 
> > > > Hi Kalle,
> > > > 
> > > > edcca is used for adjusting energy detect based on CCA thresholds.
> > > > The code was already there so I just reported the acronym.
> > > 
> > > What for it is needed ?
> > 
> > Care to comment why EDCCA is needed at all ?
> > 
> > Taking that debugfs file that enable it is read-only, it looks like
> > feature that nobody needs nor tests.
> 
> already fixed in v2
> https://patchwork.kernel.org/patch/10940645/

I'm aware of this patch and other one for mt76x02. But so far in the
sources EDCCA is disabled for mt76x02 without possibility to enable it
(and this permission file issue was pointed by Kalle during review, not
by someone who want to test EDCCA). So again, what for EDCCA is needed ?

Stanislaw
