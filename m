Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8414440F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfFMQef (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 12:34:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730767AbfFMHvS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 03:51:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9D5230C0DEA;
        Thu, 13 Jun 2019 07:51:12 +0000 (UTC)
Received: from localhost (ovpn-204-191.brq.redhat.com [10.40.204.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4B86544FE;
        Thu, 13 Jun 2019 07:51:09 +0000 (UTC)
Date:   Thu, 13 Jun 2019 09:51:08 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190613075108.GA24650@redhat.com>
References: <2ed0b595a12944a8cfea14e066bcc4fa24f0ba44.1559293385.git.lorenzo@kernel.org>
 <20190612091036.GB2965@redhat.com>
 <20190612095302.GD8107@localhost.localdomain>
 <20190612102502.GB4431@redhat.com>
 <20190612104921.GF8107@localhost.localdomain>
 <20190612115120.GA3496@redhat.com>
 <20190612122845.GH8107@localhost.localdomain>
 <20190612125905.GB2600@redhat.com>
 <20190612142128.GA20760@redhat.com>
 <20190612144400.GB7016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612144400.GB7016@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Jun 2019 07:51:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 12, 2019 at 04:44:01PM +0200, Lorenzo Bianconi wrote:
> On Jun 12, Stanislaw Gruszka wrote:
> > On Wed, Jun 12, 2019 at 02:59:05PM +0200, Stanislaw Gruszka wrote:
> > > > > If max RX AMSDU size is 3839B I do not see reason why we allocate
> > > > > MT_SG_MAX_SIZE=8 of MT_RX_BUF_SIZE=2k buffers for sg_en case.
> > > > > I thought the reason is that max AMSDU size is 16kB so it fit into
> > > > > 8 sg buffers of 2k.
> > > > > 
> > > > > In other words, for me, looks like either
> > > > > - we can not handle AMSDU for non sg case because we do not
> > > > > allocate big enough buffer
> > > > 
> > > > I think AMSDU is mandatory and we currently support it even for non-sg case
> > > > (since max rx AMSDU is 3839B)
> > > > 
> > > > > or
> > > > > - we can just use one PAGE_SIZE buffer for rx and remove sg
> > > > > buffers for rx completely 
> > > > 
> > > > using sg buffers we can support bigger rx AMSDU size in the future without using
> > > > huge buffers (e.g. we can try to use IEEE80211_MAX_MPDU_LEN_HT_7935 with
> > > > mt76x2u)
> > > 
> > > I think it would be simpler just to allocate 2 pages for 7935B .
> > 
> > And if we could determine that there is no true need to use sg for rx,
> > I think best approach here would be revert f8f527b16db5 in v5.2 to fix
> > regression and remove rx sg in -next. That would make code simpler,
> > allocate 4k instead 16k per packet, allow to use build_skb (4096 - 3839
> > give enough space for shared info) and not use usb hcd bounce buffer.
> 
> I do not think we should drop sg support since:
> - it allow us to rx huge amsdu frames (e.g. IEEE80211_MAX_MPDU_LEN_VHT_11454)
>   using multiple one page buffer. I think there will be new usb devices where we can
>   increase amsdu size (we can increase it even on mt76x2u usb 3.0 devices)

I looked at intel wifi drivers and this is handled by amsdu_size module
parameter, supported values are 4k, 8k and 12k. RX allocation size and
proper values in vht_cap & ht_cap are set accordingly. Assuming (some)
mt76 HW and FW can handle bigger AMSDUs I think we should do similar
thing.

Otherwise looks for me, we just waste memory and have not needed code
for no true reason. 

>   space needed for skb_shared_info is 320B on a x86_64 device

Uhh, I haven't expected that sk_shared_info() is that big, so indeed build_skb
could not used and 128B copy fallback will be necessary.


Stanislaw
