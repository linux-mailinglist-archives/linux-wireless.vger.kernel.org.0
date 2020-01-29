Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C314714CC5E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 15:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgA2OYd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 09:24:33 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:17250 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgA2OYd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 09:24:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580307872; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=VX3kmbdYfef45mzPcZSRglrDaIuEGLiG+F/CL1OGSpc=; b=CM3Cd/IqguFUqu+ZrlGRjuU3hiQikom8G+9DUakIP8k/w8g7ajvf86qdHylbLu0YVIOW/Iu2
 61WKEP0LIq3nMVtdZKEQ0IQbCgnqMHZnualSgZ5FVcPMyFsA54Fi9J+n365j6YUOlfIuJH52
 qKvYcj5m3glMtY3CHbY3pMscT10=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e31959c.7f717f937d50-smtp-out-n03;
 Wed, 29 Jan 2020 14:24:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9771C4479F; Wed, 29 Jan 2020 14:24:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 095A5C433CB;
        Wed, 29 Jan 2020 14:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 095A5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandru-Mihai Maftei <amaftei@solarflare.com>
Subject: Re: linux-next: manual merge of the generic-ioremap tree with the net-next tree
References: <20200109161202.1b0909d9@canb.auug.org.au>
        <20200128095449.5688fddc@canb.auug.org.au>
        <20200129081628.750f5e05@canb.auug.org.au>
Date:   Wed, 29 Jan 2020 16:24:22 +0200
In-Reply-To: <20200129081628.750f5e05@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 29 Jan 2020 08:16:28 +1100")
Message-ID: <87blqm8hnt.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> On Tue, 28 Jan 2020 09:54:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Thu, 9 Jan 2020 16:12:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> > 
>> > Today's linux-next merge of the generic-ioremap tree got a conflict in:
>> > 
>> >   drivers/net/ethernet/sfc/efx.c
>> > 
>> > between commit:
>> > 
>> >   f1826756b499 ("sfc: move struct init and fini code")
>> > 
>> > from the net-next tree and commit:
>> > 
>> >   4bdc0d676a64 ("remove ioremap_nocache and devm_ioremap_nocache")
>> > 
>> > from the generic-ioremap tree.
>> > 
>> > I fixed it up (the latter moved the code, so I applied the following
>> > merge fix patch) and can carry the fix as necessary. This is now fixed
>> > as far as linux-next is concerned, but any non trivial conflicts should
>> > be mentioned to your upstream maintainer when your tree is submitted
>> > for merging.  You may also want to consider cooperating with the
>> > maintainer of the conflicting tree to minimise any particularly complex
>> > conflicts.
>> > 
>> > From: Stephen Rothwell <sfr@canb.auug.org.au>
>> > Date: Thu, 9 Jan 2020 16:08:52 +1100
>> > Subject: [PATCH] fix up for "sfc: move struct init and fini code"
>> > 
>> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> > ---
>> >  drivers/net/ethernet/sfc/efx_common.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
>> > index fe74c66c8ec6..bf0126633c25 100644
>> > --- a/drivers/net/ethernet/sfc/efx_common.c
>> > +++ b/drivers/net/ethernet/sfc/efx_common.c
>> > @@ -954,7 +954,7 @@ int efx_init_io(struct efx_nic *efx, int bar, dma_addr_t dma_mask,
>> >  		goto fail3;
>> >  	}
>> >  
>> > -	efx->membase = ioremap_nocache(efx->membase_phys, mem_map_size);
>> > +	efx->membase = ioremap(efx->membase_phys, mem_map_size);
>> >  	if (!efx->membase) {
>> >  		netif_err(efx, probe, efx->net_dev,
>> >  			  "could not map memory BAR at %llx+%x\n",
>> > -- 
>> > 2.24.0  
>> 
>> This is now a conflict between the net-next tree and Linus' tree.
>
> It actually turns out that this is a conflict between the
> wireless-drivers tree and Linus' tree since the wireless-drivers tree
> has merged most of the net-next tree.

Yeah, I fast forwarded wireless-drivers to top of net-next so that I can
easily apply fixes and send them to Dave later this week. But as I don't
touch drivers/net/ethernet I don't think there's nothing I can do to fix
this conflict.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
