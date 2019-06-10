Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4663B095
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 10:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfFJISy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 04:18:54 -0400
Received: from verein.lst.de ([213.95.11.211]:42185 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387825AbfFJISy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 04:18:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C36F768B05; Mon, 10 Jun 2019 10:18:25 +0200 (CEST)
Date:   Mon, 10 Jun 2019 10:18:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190610081825.GA16534@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi> <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net> <20190607172902.GA8183@lst.de> <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Jun 08, 2019 at 04:52:24PM -0500, Larry Finger wrote:
> On 6/7/19 12:29 PM, Christoph Hellwig wrote:
>> I don't think we should work around this in the driver, we need to fix
>> it in the core.  I'm curious why my previous patch didn't work.  Can
>> you throw in a few printks what failed?  I.e. did dma_direct_supported
>> return false?  Did the actual allocation fail?
>
> Routine dma_direct_supported() returns true.
>
> The failure is in routine dma_set_mask() in the following if test:
>
>         if (!dev->dma_mask || !dma_supported(dev, mask))
>                 return -EIO;
>
> For b43legacy, dev->dma_mask is 0xc265684800000000.
>     dma_supported(dev, mask) is 0xc08b000000000000, mask is 0x3fffffff, and 
> the routine returns -EIO.
>
> For b43,       dev->dma_mask is 0xc265684800000001,
>     dma_supported(dev, mask) is 0xc08b000000000000, mask is 0x77777777, and 
> the routine returns 0.

I don't fully understand what values the above map to.  Can you send
me your actual debugging patch as well?
