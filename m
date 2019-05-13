Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4891B30A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 11:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfEMJlQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 05:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfEMJlQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 05:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A017882F0;
        Mon, 13 May 2019 09:41:16 +0000 (UTC)
Received: from localhost (unknown [10.40.205.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F6DC63BB9;
        Mon, 13 May 2019 09:41:13 +0000 (UTC)
Date:   Mon, 13 May 2019 11:41:12 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/4] mt76: mt76x2: move mutex_lock inside
 mt76x2_set_channel
Message-ID: <20190513094111.GA15694@redhat.com>
References: <cover.1557567465.git.lorenzo@kernel.org>
 <1527e88fc4a307aa218f515811f2f2c15786caec.1557567465.git.lorenzo@kernel.org>
 <20190513083755.GA13726@redhat.com>
 <20190513091905.GB3127@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513091905.GB3127@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 13 May 2019 09:41:16 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 11:19:06AM +0200, Lorenzo Bianconi wrote:
> > On Sat, May 11, 2019 at 12:17:53PM +0200, Lorenzo Bianconi wrote:
> > > This is a preliminary patch to run mt76x02_edcca_init atomically
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 16 ++++++++------
> > >  .../wireless/mediatek/mt76/mt76x2/usb_main.c  | 22 ++++++++++---------
> > >  2 files changed, 21 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> > > index e416eee6a306..3a1467326f4d 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> > > @@ -54,14 +54,14 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
> > >  	int ret;
> > >  
> > >  	cancel_delayed_work_sync(&dev->cal_work);
> > 
> > Since now you use mutex in mt76x2_phy_calibrate() you can remove  
> > cancel_delayed_work_sync() and drop other changes from this patch
> > as releasing mutex just to acquire it in almost next step make
> > no sense.
> 
> I agree with you, the only difference is in that way we will perform phy
> calibration even during scanning. If the there are no
> objections I will post a v3 removing cancel_delayed_work_sync and
> reworking patch 3/4

Oh, calibration work should not be done during scanning, so cancel
cal_work should be added to .sw_scan_start() callback or this patch
should stay unchanged.

Stanislaw

