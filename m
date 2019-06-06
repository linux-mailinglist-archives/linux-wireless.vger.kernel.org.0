Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A9E37238
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 12:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFFK6K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 06:58:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:37571 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFFK6K (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 06:58:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x56Avni0032240;
        Thu, 6 Jun 2019 05:57:50 -0500
Message-ID: <f8df19ffe5b75537045119037459ae9ad4a1de39.camel@kernel.crashing.org>
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Jun 2019 20:57:49 +1000
In-Reply-To: <d87ac9a7faac0d5522cb496d74afc586410fed9c.camel@kernel.crashing.org>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
         <dfe6451c93574b61d4bdde4a05c5f8ccf86b31a0.camel@kernel.crashing.org>
         <20190606093149.GA11598@darkstar.musicnaut.iki.fi>
         <d87ac9a7faac0d5522cb496d74afc586410fed9c.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-06 at 20:56 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2019-06-06 at 12:31 +0300, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Thu, Jun 06, 2019 at 10:54:51AM +1000, Benjamin Herrenschmidt
> > wrote:
> > > On Thu, 2019-06-06 at 01:50 +0300, Aaro Koskinen wrote:
> > > > Hi,
> > > > 
> > > > When upgrading from v5.0 -> v5.1 on G4 PowerBook, I noticed WLAN
> > > > does
> > > > not work anymore:
> > > > 
> > > > [   42.004303] b43legacy-phy0: Loading firmware version 0x127,
> > > > patch level 14 (2005-04-18 02:36:27)
> > > > [   42.184837] b43legacy-phy0 debug: Chip initialized
> > > > [   42.184873] b43legacy-phy0 ERROR: The machine/kernel does not
> > > > support the required 30-bit DMA mask
> > > > 
> > > > The same happens with the current mainline.
> > > 
> > > How much RAM do you have ?
> > 
> > The system has 1129 MB RAM. Booting with mem=1G makes it work.
> 
> Wow... that's an odd amount. One thing we could possibly do is add code
> to limit the amount of RAM when we detect that device....

Sent too quickly... I mean that *or* force swiotlb at 30-bits on those systems based
on detecting the presence of that device in the device-tree.

Cheers,
Ben.


