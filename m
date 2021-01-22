Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13930023B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 12:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbhAVL6k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 06:58:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43797 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727410AbhAVL5j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 06:57:39 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 923885C00FF;
        Fri, 22 Jan 2021 06:56:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Jan 2021 06:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=s5zUnZIga8YCsxtkCuU8+h7RKOP
        gKeLXxz7i8hp47Tw=; b=u3sYz1KDMTYFbEyeRuRyc9DDE0BL1+tHrf0hTyHkwbJ
        OMT0G1tdavoYXzY8XYCMysbO3dU53BTBOHYNjhTKaWZCoKpqBuasX+U/YGGKFS9g
        10Ezlgzn2mJQUEDkhI7+FUoTGDOa3iFFVzJ9xN9CmiumRfD98qGhI1yMPTb6Tn1D
        CllR7QQaEslx3m1FXuEiiWagraEFlWgtR7oi/3Fw3ylqemQTjvD5qC2QPg4/a6JM
        rd7PeXQREkp+u1AOZ7IP9s8/7wVLSPBt0RwW9uVwtA7D6ju9e11/Ux6gd59Nq081
        AHnAi5FkhG9LwJ06tY3tdzrtXQkdpgAedwmC1xE50Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=s5zUnZ
        Iga8YCsxtkCuU8+h7RKOPgKeLXxz7i8hp47Tw=; b=SGWWzpFwuWLwDF2fV5Q584
        91wl4EOuI0qwRFdbCyor75KKCQNJASXnsbwJ4lY8mYfDRCCaqIZNz3bLVkIluYLj
        DMnQTTOlEFPyMtsmVNzOoZuiDV+eLqOYCR5h61yPcpGRx/wRdeFnxl2r4F1HMeMk
        PDscgV1K+C5hFWuGJBpKNeqxVEHE81ByXGqGC/txw+u54qYmjM2VFxMD2bZZT/Fb
        GhGS3DaUtLNYdOzxPKJ4Q0RYj0SiU6/f9ZhvmtXWYyKZ9vjF/NYxKD0MR+mlbu79
        vxGMxay8BBde7kFEye/l5MEPrq8vSC824mcmIdHG0z7lV+zyTRGvFE/uDnZ0eTGw
        ==
X-ME-Sender: <xms:cL0KYLr1d9153tsWM9GGNJRTXM0ivbMIufObuwg9H8qsNitgQwH25Q>
    <xme:cL0KYFrYRi4voIwQlyLXp_tRF91QXGniKikLbmAmsiw-0zwBXC0uiVQLKOJJIohhR
    LYbiBlhMFuh6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepueelledthe
    ekleethfeludduvdfhffeuvdffudevgeehkeegieffveehgeeftefgnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrjeegrdeigeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdr
    tghomh
X-ME-Proxy: <xmx:cL0KYINS49AoHePejXWusJWyOeJyPtMIMLV_2xiXAsWA4mbWnYtwgg>
    <xmx:cL0KYO4_kxzevlvLKo7tZcjigruNp5HXpG5DerRjlwHjForzBy4Fvw>
    <xmx:cL0KYK7QzQVwPPkRmDOtHsgZqHHakrNEZ398NZuvCOgGs6-3J9lc3Q>
    <xmx:cL0KYKEFFYwonaOkGc-JnZRExXIqJ3y8n9dG-s4JOQW1SsIPQVXOXw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id C3CEB24005A;
        Fri, 22 Jan 2021 06:56:31 -0500 (EST)
Date:   Fri, 22 Jan 2021 12:56:30 +0100
From:   Greg KH <greg@kroah.com>
To:     stf_xl@wp.pl
Cc:     linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bernhard <bernhard.gebetsberger@gmx.at>
Subject: Re: [PATCH] usb, xhci, rt2800usb: do not perform Soft Retry
Message-ID: <YAq9bt6q9dfk4F+F@kroah.com>
References: <20210122104342.12451-1-stf_xl@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122104342.12451-1-stf_xl@wp.pl>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 22, 2021 at 11:43:42AM +0100, stf_xl@wp.pl wrote:
> From: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> Since f8f80be501aa ("xhci: Use soft retry to recover faster from transaction
> errors") on some systems rt2800usb devices are unable to operate. Looks
> that due to firmware or hardware limitations of those devices, they
> require full recovery from USB Transaction Errors.
> 
> To avoid the problem add URB transfer flag, that restore pre f8f80be501aa
> xhci behaviour when the flag is set. For now only add it only to rt2800usb
> driver.

This feels like a really heavy hammer, to add a xhci flag for a single
broken device.

Are you sure this is really needed?  What does this device do on other
operating systems, do they have such a quirk for their host controller
driver?

Or is this due to the specific host controller device hardware?  Should
this be a xhci quirk for a specific pci device instead?



> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202541
> Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
> Reported-and-tested-by: Bernhard <bernhard.gebetsberger@gmx.at>
> Bisected-by: Bernhard <bernhard.gebetsberger@gmx.at>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2x00usb.c | 3 +++
>  drivers/usb/core/urb.c                         | 2 +-
>  drivers/usb/host/xhci-ring.c                   | 3 ++-
>  include/linux/usb.h                            | 1 +
>  4 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> index e4473a551241..f1d82b3e6bba 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
> @@ -214,6 +214,7 @@ void rt2x00usb_register_read_async(struct rt2x00_dev *rt2x00dev,
>  	usb_fill_control_urb(urb, usb_dev, usb_rcvctrlpipe(usb_dev, 0),
>  			     (unsigned char *)(&rd->cr), &rd->reg, sizeof(rd->reg),
>  			     rt2x00usb_register_read_async_cb, rd);
> +	urb->transfer_flags |= URB_SOFT_RETRY_NOT_OK;
>  	usb_anchor_urb(urb, rt2x00dev->anchor);
>  	if (usb_submit_urb(urb, GFP_ATOMIC) < 0) {
>  		usb_unanchor_urb(urb);
> @@ -323,6 +324,7 @@ static bool rt2x00usb_kick_tx_entry(struct queue_entry *entry, void *data)
>  			  usb_sndbulkpipe(usb_dev, entry->queue->usb_endpoint),
>  			  entry->skb->data, length,
>  			  rt2x00usb_interrupt_txdone, entry);
> +	entry_priv->urb->transfer_flags |= URB_SOFT_RETRY_NOT_OK;
>  
>  	status = usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
>  	if (status) {
> @@ -409,6 +411,7 @@ static bool rt2x00usb_kick_rx_entry(struct queue_entry *entry, void *data)
>  			  usb_rcvbulkpipe(usb_dev, entry->queue->usb_endpoint),
>  			  entry->skb->data, entry->skb->len,
>  			  rt2x00usb_interrupt_rxdone, entry);
> +	entry_priv->urb->transfer_flags |= URB_SOFT_RETRY_NOT_OK;
>  
>  	status = usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
>  	if (status) {
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index 357b149b20d3..140bac59dc32 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -495,7 +495,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
>  
>  	/* Check against a simple/standard policy */
>  	allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |
> -			URB_FREE_BUFFER);
> +		   URB_SOFT_RETRY_NOT_OK | URB_FREE_BUFFER);
>  	switch (xfertype) {
>  	case USB_ENDPOINT_XFER_BULK:
>  	case USB_ENDPOINT_XFER_INT:
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 5677b81c0915..6712e1a7735c 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2302,7 +2302,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
>  		remaining	= 0;
>  		break;
>  	case COMP_USB_TRANSACTION_ERROR:
> -		if ((ep_ring->err_count++ > MAX_SOFT_RETRY) ||
> +		if (td->urb->transfer_flags & URB_SOFT_RETRY_NOT_OK ||
> +		    (ep_ring->err_count++ > MAX_SOFT_RETRY) ||
>  		    le32_to_cpu(slot_ctx->tt_info) & TT_SLOT)
>  			break;
>  		*status = 0;
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 7d72c4e0713c..dcdac2f03263 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1329,6 +1329,7 @@ extern int usb_disabled(void);
>  #define URB_ISO_ASAP		0x0002	/* iso-only; use the first unexpired
>  					 * slot in the schedule */
>  #define URB_NO_TRANSFER_DMA_MAP	0x0004	/* urb->transfer_dma valid on submit */
> +#define URB_SOFT_RETRY_NOT_OK	0x0008	/* Avoid XHCI Soft Retry */

To match other flags here, how about "URB_NO_SOFT_RETRY"?

thanks,

greg k-h
