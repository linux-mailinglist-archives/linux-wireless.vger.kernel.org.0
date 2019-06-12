Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E84426CF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437285AbfFLM7L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 08:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437214AbfFLM7L (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 08:59:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9BBF356D3;
        Wed, 12 Jun 2019 12:59:10 +0000 (UTC)
Received: from localhost (unknown [10.43.2.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FD2068431;
        Wed, 12 Jun 2019 12:59:08 +0000 (UTC)
Date:   Wed, 12 Jun 2019 14:59:06 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190612125905.GB2600@redhat.com>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
 <20190612091036.GB2965@redhat.com>
 <20190612095302.GD8107@localhost.localdomain>
 <20190612102502.GB4431@redhat.com>
 <20190612104921.GF8107@localhost.localdomain>
 <20190612115120.GA3496@redhat.com>
 <20190612122845.GH8107@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612122845.GH8107@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 12 Jun 2019 12:59:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 12, 2019 at 02:28:48PM +0200, Lorenzo Bianconi wrote:
> [...]
> > 
> > My sense of humor declined quite drastically lastly ;-/
> > 
> > > > > but we can be more cautious since probably copying
> > > > > the first 128B will not make any difference
> > > > 
> > > > Not sure if I understand what you mean.
> > > 
> > > Please correct me if I am wrong but I think max amsdu rx size is 3839B for
> > > mt76. For the sg_en case this frame will span over multiple sg buffers since
> > > sg buffer size is 2048B (2 sg buffers). Moreover if we do not take into account
> > > skb_shared_info when configuring the sg buffer size we will need to always copy
> > > the first 128B of the first buffer since received len will be set to 2048 and
> > > the following if condition will always fail:
> > > 
> > > if (SKB_WITH_OVERHEAD(buf_size) >= MT_DMA_HDR_LEN + len) {
> > > }
> > 
> > Ok, that I understand.
> > 
> > > > > > And skb_shered_info is needed only in first buffer IIUC.
> > > > > > 
> > > > > > Also this patch seems to make first patch unnecessary except for
> > > > > > non sg_en case (in which I think rx AMSDU is broken anyway),
> > > > > > so I would prefer just to apply first patch.
> > > > > 
> > > > > I do not think rx AMSDU is broken for non sg_en case since the max rx value
> > > > > allowed should be 3839 IIRC and we alloc one page in this case
> > > > 
> > > > If that's the case we should be fine, but then I do not understand
> > > > why we allocate 8*2k buffers for sg_en case, isn't that AP can
> > > > sent AMSDU frame 16k big?
> > > 
> > > Sorry I did not get what you mean here, could you please explain?
> > 
> > If max RX AMSDU size is 3839B I do not see reason why we allocate
> > MT_SG_MAX_SIZE=8 of MT_RX_BUF_SIZE=2k buffers for sg_en case.
> > I thought the reason is that max AMSDU size is 16kB so it fit into
> > 8 sg buffers of 2k.
> > 
> > In other words, for me, looks like either
> > - we can not handle AMSDU for non sg case because we do not
> > allocate big enough buffer
> 
> I think AMSDU is mandatory and we currently support it even for non-sg case
> (since max rx AMSDU is 3839B)
> 
> > or
> > - we can just use one PAGE_SIZE buffer for rx and remove sg
> > buffers for rx completely 
> 
> using sg buffers we can support bigger rx AMSDU size in the future without using
> huge buffers (e.g. we can try to use IEEE80211_MAX_MPDU_LEN_HT_7935 with
> mt76x2u)

I think it would be simpler just to allocate 2 pages for 7935B .

Stanislaw 
