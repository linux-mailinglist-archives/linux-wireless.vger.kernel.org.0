Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C69145116
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 03:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFNBQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 21:16:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33717 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNBQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 21:16:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so348612pfq.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2019 18:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZViEBYZeL/z5EPk8qxP1sfyjHKjqDUy0obWXo7P9+g=;
        b=W73u1rm7pEPUZ0dWGqzBGbZRpb62vvQkquRyfx5YrGwT1851/HQV3tRqiHxzHCiILU
         Sunl4+rtfrmOtmkRHvqvxgnoydNDK+4Kfn6PMhG1eWe42Lt5mJ30K2HGH8ecJZPtFVUU
         M7kAUOnqYgcRSOZxDFRx9OG9bwNXJ0gWELOeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZViEBYZeL/z5EPk8qxP1sfyjHKjqDUy0obWXo7P9+g=;
        b=jSLPA/mtn1jAOfvGpei9t8MMgDjhC82DmJzkuf1G/ht5uaZG57gx9LMMMM1W6zYbkA
         XxQq3mQlE6VZglnuC+g0gPSlU4yiZVHMS3xoEd3iXdYGyOX+SMvhBoxfBtpodkRuLZUS
         pYBsDkqlweobRSccxjs9AjRNuKo3q1V9iv1wWlMMBxkBNEB/FnJT6zRKJCOxSg+ip/OM
         /DZd7+q2o0fjXbMVEWwhlyJSscurKyQLSDqU6bi3AO2FQrVjOUL58ZAyVO2DAmJc4PJX
         9d2+BbfE9olE2XibvC7/dCDU1Wj2EXvS20TCc6OGrtRFnKeF0UnTpXRm8Ye0IDD0kFoQ
         1E8w==
X-Gm-Message-State: APjAAAVlGBg/DAqydt8ZpzYWeMj8mLlO8Jeu1Lok7MCihNS9n8X3GVDW
        QaW2zTuEd9M04Y1v9ODE2+3ByQ==
X-Google-Smtp-Source: APXvYqwo6zzOwKPlHBhSHl9jU+cMBgxq3J653CP2HQ+0PRuQaQpWtTBYmKdhMCdz1A1KCUjjTKhiSA==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr32683960pgv.156.1560475014292;
        Thu, 13 Jun 2019 18:16:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id r4sm919657pjd.28.2019.06.13.18.16.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 18:16:52 -0700 (PDT)
Date:   Thu, 13 Jun 2019 18:16:50 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     linux-wireless@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] mwifiex: avoid deleting uninitialized timer during USB
 cleanup
Message-ID: <20190614011648.GA121099@google.com>
References: <1560354873-17182-1-git-send-email-gbhat@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560354873-17182-1-git-send-email-gbhat@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ganapathi,

This looks kinda wrong, but I'm not totally sure, as I'm not very familiar with
your USB driver.

On Wed, Jun 12, 2019 at 09:24:33PM +0530, Ganapathi Bhat wrote:
> Driver calls del_timer_sync(hold_timer), in unregister_dev(), but
> there exists is a case when the timer is yet to be initialized. A
> restructure of init and cleanup is needed to synchronize timer
> creation and delee. Make use of init_if() / cleanup_if() handlers

s/delee/delete/

> to get this done.
> 
> Reported-by: syzbot+373e6719b49912399d21@syzkaller.appspotmail.com
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/usb.c | 32 +++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
> index c2365ee..939f1e9 100644
> --- a/drivers/net/wireless/marvell/mwifiex/usb.c
> +++ b/drivers/net/wireless/marvell/mwifiex/usb.c
> @@ -1348,6 +1348,8 @@ static void mwifiex_usb_cleanup_tx_aggr(struct mwifiex_adapter *adapter)
>  
>  	for (idx = 0; idx < MWIFIEX_TX_DATA_PORT; idx++) {
>  		port = &card->port[idx];
> +		if (!port->tx_data_ep)
> +			continue;

It's not clear to me what this is about. Are you sure you're not just cleaning
stuff up in the wrong order?

>  		if (adapter->bus_aggr.enable)
>  			while ((skb_tmp =
>  				skb_dequeue(&port->tx_aggr.aggr_list)))

...

> @@ -1584,7 +1580,29 @@ static void mwifiex_usb_submit_rem_rx_urbs(struct mwifiex_adapter *adapter)
>  	return 0;
>  }
>  
> +static int mwifiex_init_usb(struct mwifiex_adapter *adapter)
> +{
> +	struct usb_card_rec *card = (struct usb_card_rec *)adapter->card;
> +	int ret = 0;
> +
> +	if (card->usb_boot_state == USB8XXX_FW_DNLD)
> +		return 0;

This looks wrong. You don't want to skip your basic initialization just because
firmware isn't loaded yet. In fact, init_if() always gets called before FW
init, so haven't you basically stubbed out this function most of the time?

I guess the question is: is this step supposed to go before, or after firmware
initilization? Based on that answer, we can make an appropriate patch.

(The original code does this after FW initialization, and now you're only sort
of moving it before.)

> +
> +	ret = mwifiex_usb_rx_init(adapter);
> +	if (!ret)
> +		ret = mwifiex_usb_tx_init(adapter);
> +
> +	return ret;
> +}

Brian
