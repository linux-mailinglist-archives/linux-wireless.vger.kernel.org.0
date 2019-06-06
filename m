Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA56036FDD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfFFJbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 05:31:53 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58050 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfFFJbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 05:31:53 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-64-161-nat.elisa-mobile.fi [85.76.64.161])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 9530B2002D;
        Thu,  6 Jun 2019 12:31:49 +0300 (EEST)
Date:   Thu, 6 Jun 2019 12:31:49 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linuxppc-dev@lists.ozlabs.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190606093149.GA11598@darkstar.musicnaut.iki.fi>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <dfe6451c93574b61d4bdde4a05c5f8ccf86b31a0.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe6451c93574b61d4bdde4a05c5f8ccf86b31a0.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Jun 06, 2019 at 10:54:51AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2019-06-06 at 01:50 +0300, Aaro Koskinen wrote:
> > Hi,
> > 
> > When upgrading from v5.0 -> v5.1 on G4 PowerBook, I noticed WLAN does
> > not work anymore:
> > 
> > [   42.004303] b43legacy-phy0: Loading firmware version 0x127, patch level 14 (2005-04-18 02:36:27)
> > [   42.184837] b43legacy-phy0 debug: Chip initialized
> > [   42.184873] b43legacy-phy0 ERROR: The machine/kernel does not support the required 30-bit DMA mask
> > 
> > The same happens with the current mainline.
> 
> How much RAM do you have ?

The system has 1129 MB RAM. Booting with mem=1G makes it work.

A.
