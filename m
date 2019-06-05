Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8890367AA
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 00:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFEW56 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jun 2019 18:57:58 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:38866 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEW56 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jun 2019 18:57:58 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 18:57:57 EDT
Received: from darkstar.musicnaut.iki.fi (85-76-64-161-nat.elisa-mobile.fi [85.76.64.161])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id DAC592002F;
        Thu,  6 Jun 2019 01:50:59 +0300 (EEST)
Date:   Thu, 6 Jun 2019 01:50:59 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

When upgrading from v5.0 -> v5.1 on G4 PowerBook, I noticed WLAN does
not work anymore:

[   42.004303] b43legacy-phy0: Loading firmware version 0x127, patch level 14 (2005-04-18 02:36:27)
[   42.184837] b43legacy-phy0 debug: Chip initialized
[   42.184873] b43legacy-phy0 ERROR: The machine/kernel does not support the required 30-bit DMA mask

The same happens with the current mainline.

Bisected to:

	commit 65a21b71f948406201e4f62e41f06513350ca390
	Author: Christoph Hellwig <hch@lst.de>
	Date:   Wed Feb 13 08:01:26 2019 +0100

	    powerpc/dma: remove dma_nommu_dma_supported

	    This function is largely identical to the generic version used
	    everywhere else.  Replace it with the generic version.

	    Signed-off-by: Christoph Hellwig <hch@lst.de>
	    Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
	    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

A.
