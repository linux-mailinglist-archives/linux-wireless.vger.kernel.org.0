Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF043ED4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfFMPxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 11:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731619AbfFMJDm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 05:03:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 510373172D64;
        Thu, 13 Jun 2019 09:03:37 +0000 (UTC)
Received: from localhost (unknown [10.43.2.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F9885F9B0;
        Thu, 13 Jun 2019 09:03:33 +0000 (UTC)
Date:   Thu, 13 Jun 2019 11:02:02 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mt76: usb: do not always copy the first part of
 received frames
Message-ID: <20190613090201.GA2753@redhat.com>
References: <20190612095302.GD8107@localhost.localdomain>
 <20190612102502.GB4431@redhat.com>
 <20190612104921.GF8107@localhost.localdomain>
 <20190612115120.GA3496@redhat.com>
 <20190612122845.GH8107@localhost.localdomain>
 <20190612125905.GB2600@redhat.com>
 <20190612142128.GA20760@redhat.com>
 <20190612144400.GB7016@localhost.localdomain>
 <20190613075108.GA24650@redhat.com>
 <20190613082637.GA18296@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613082637.GA18296@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Jun 2019 09:03:42 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

On Thu, Jun 13, 2019 at 10:26:38AM +0200, Lorenzo Bianconi wrote:
> [...]
> 
> > I looked at intel wifi drivers and this is handled by amsdu_size module
> > parameter, supported values are 4k, 8k and 12k. RX allocation size and
> > proper values in vht_cap & ht_cap are set accordingly. Assuming (some)
> > mt76 HW and FW can handle bigger AMSDUs I think we should do similar
> > thing.
> > 
> > Otherwise looks for me, we just waste memory and have not needed code
> > for no true reason. 
> > 
> > >   space needed for skb_shared_info is 320B on a x86_64 device
> > 
> > Uhh, I haven't expected that sk_shared_info() is that big, so indeed build_skb
> > could not used and 128B copy fallback will be necessary.
> 
> Hi Stanislaw,
> 
> reviewing the original patch I think we can't trigger any IOMMU bug since the
> usb buffer length is actually 2048 and not 2048 + skb_shared_info_size:

I'm concerned about alignment and crossing pages boundaries. If you
allocate via page_frag_alloc() buffers, except first one, will have
'not natural' alignment and every second will be spanned across
two pages.

Stanislaw

