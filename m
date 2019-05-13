Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DED1B1FA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfEMIiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 04:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfEMIiA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 04:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26AEF30917A8;
        Mon, 13 May 2019 08:38:00 +0000 (UTC)
Received: from localhost (unknown [10.40.205.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4134E60BEC;
        Mon, 13 May 2019 08:37:57 +0000 (UTC)
Date:   Mon, 13 May 2019 10:37:56 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/4] mt76: mt76x2: move mutex_lock inside
 mt76x2_set_channel
Message-ID: <20190513083755.GA13726@redhat.com>
References: <cover.1557567465.git.lorenzo@kernel.org>
 <1527e88fc4a307aa218f515811f2f2c15786caec.1557567465.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527e88fc4a307aa218f515811f2f2c15786caec.1557567465.git.lorenzo@kernel.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 13 May 2019 08:38:00 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 11, 2019 at 12:17:53PM +0200, Lorenzo Bianconi wrote:
> This is a preliminary patch to run mt76x02_edcca_init atomically
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 16 ++++++++------
>  .../wireless/mediatek/mt76/mt76x2/usb_main.c  | 22 ++++++++++---------
>  2 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> index e416eee6a306..3a1467326f4d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
> @@ -54,14 +54,14 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
>  	int ret;
>  
>  	cancel_delayed_work_sync(&dev->cal_work);

Since now you use mutex in mt76x2_phy_calibrate() you can remove  
cancel_delayed_work_sync() and drop other changes from this patch
as releasing mutex just to acquire it in almost next step make
no sense.

Stanislaw
