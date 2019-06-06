Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27044368DF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 02:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFFAzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jun 2019 20:55:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:37120 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfFFAzS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jun 2019 20:55:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x560spOn002708;
        Wed, 5 Jun 2019 19:54:53 -0500
Message-ID: <dfe6451c93574b61d4bdde4a05c5f8ccf86b31a0.camel@kernel.crashing.org>
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Jun 2019 10:54:51 +1000
In-Reply-To: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-06 at 01:50 +0300, Aaro Koskinen wrote:
> Hi,
> 
> When upgrading from v5.0 -> v5.1 on G4 PowerBook, I noticed WLAN does
> not work anymore:
> 
> [   42.004303] b43legacy-phy0: Loading firmware version 0x127, patch level 14 (2005-04-18 02:36:27)
> [   42.184837] b43legacy-phy0 debug: Chip initialized
> [   42.184873] b43legacy-phy0 ERROR: The machine/kernel does not support the required 30-bit DMA mask
> 
> The same happens with the current mainline.

How much RAM do you have ?

Ben.

> 
> Bisected to:
> 
> 	commit 65a21b71f948406201e4f62e41f06513350ca390
> 	Author: Christoph Hellwig <hch@lst.de>
> 	Date:   Wed Feb 13 08:01:26 2019 +0100
> 
> 	    powerpc/dma: remove dma_nommu_dma_supported
> 
> 	    This function is largely identical to the generic version used
> 	    everywhere else.  Replace it with the generic version.
> 
> 	    Signed-off-by: Christoph Hellwig <hch@lst.de>
> 	    Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> 	    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> A.

