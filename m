Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2088633E9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 12:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfGIKGX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 06:06:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGIKGX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 06:06:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33DED307D915;
        Tue,  9 Jul 2019 10:06:23 +0000 (UTC)
Received: from localhost (unknown [10.43.2.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5C45DD6D;
        Tue,  9 Jul 2019 10:06:20 +0000 (UTC)
Date:   Tue, 9 Jul 2019 12:06:18 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH 1/3] mt76: usb: fix endian in mt76u_copy
Message-ID: <20190709100617.GA3099@redhat.com>
References: <1562079961-15527-1-git-send-email-sgruszka@redhat.com>
 <1562079961-15527-2-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562079961-15527-2-git-send-email-sgruszka@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 09 Jul 2019 10:06:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 02, 2019 at 05:05:59PM +0200, Stanislaw Gruszka wrote:
> In contrast to mt76_wr() which we use to program registers,
> on mt76_wr_copy() we should not change endian of the data.
> 
> Fixes: b40b15e1521f ("mt76: add usb support to mt76 layer")
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/net/wireless/mediatek/mt76/usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
> index 87ecbe290f99..db90ec6b8775 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -165,11 +165,11 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offset,
>  
>  	mutex_lock(&usb->usb_ctrl_mtx);
>  	for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
> -		put_unaligned_le32(val[i], usb->data);
> +		put_unaligned(val[i], usb->data);

This is bug as put_unaligned() use size based second argument
pointer type, correct version should looks like this:

		put_unaligned(val[i], (u32 *) usb->data);

Stanislaw
