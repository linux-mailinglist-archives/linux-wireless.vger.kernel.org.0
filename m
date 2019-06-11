Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37C14185D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406584AbfFKWq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 18:46:28 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:38684 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388277AbfFKWq1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 18:46:27 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-70-161-nat.elisa-mobile.fi [85.76.70.161])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 692A23007D;
        Wed, 12 Jun 2019 01:46:24 +0300 (EEST)
Date:   Wed, 12 Jun 2019 01:46:23 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190611224623.GC26504@darkstar.musicnaut.iki.fi>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
 <20190607172902.GA8183@lst.de>
 <30000803-3772-3edf-f4a9-55122d504f3f@lwfinger.net>
 <20190610081825.GA16534@lst.de>
 <153c13f5-a829-1eab-a3c5-fecfb84127ff@lwfinger.net>
 <20190611060521.GA19512@lst.de>
 <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aaa600b-5b59-1f68-454f-20403c318f1a@lwfinger.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Jun 11, 2019 at 05:20:12PM -0500, Larry Finger wrote:
> It is obvious that the case of a mask smaller than min_mask should be
> handled by the IOMMU. In my system, CONFIG_IOMMU_SUPPORT is selected. All
> other CONFIG variables containing IOMMU are not selected. When
> dma_direct_supported() fails, should the system not try for an IOMMU
> solution? Is the driver asking for the wrong type of memory? It is doing a
> dma_and_set_mask_coherent() call.

I don't think we have IOMMU on G4. On G5 it should work (I remember fixing
b43 issue on G5, see 4c374af5fdee, unfortunately all my G5 Macs with b43
are dead and waiting for re-capping).

A.
