Return-Path: <linux-wireless+bounces-11991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D238495F286
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1108A1C21A88
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5617C985;
	Mon, 26 Aug 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHj7DV2J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D61E871;
	Mon, 26 Aug 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678002; cv=none; b=in0R0soyokI3OLKSrKmsnUR+5Z0QnI+ee2iseAQfYzp8IXlbs6F+3jugFFplPzehVMjDAF+/Enwm7vKI1pRQd87XZRctAjaEUCkej7Fr600NKifxnUXx4qEPmDJYh4xZptnuXopkCQLfUCzCVmJcR78/ynO0ZakNM8T1kHfVlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678002; c=relaxed/simple;
	bh=nyaKbAslvxt6JQc4HbXa3VVIcEoG5UzzsowvbUhNFVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoLKenGR2/PBNiQr2/Mmk9bNv9vJtJlgpwUCxenRxl9aYPPRsYPA0r1jUb5r/fN2kin8emHdi5qgaC9XYP+p/P6BkUNICj2PCkmGkHq3b45XWSDPTbMnSfgLMtMff2pco+ACqwmuQ1wZXlTD4mlrpRRRQISyHNwSBImUli4CDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHj7DV2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A568C8CDC6;
	Mon, 26 Aug 2024 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724678001;
	bh=nyaKbAslvxt6JQc4HbXa3VVIcEoG5UzzsowvbUhNFVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xHj7DV2Jx3VWVPimQUlf7y/T4TTU86OOCwOcPpuOJYNdhKYN67KXs61m/ltCzUfEO
	 EP+hlQaaDulfvUiDD5m30cKgQiZ4XuGN4kzGdz/dQbpNcHvRTr3qZo1HPjAghHHlhs
	 DzBge/xvOJNIUmLNVl1el0s3AKQUZx45MknsIr0g=
Date: Mon, 26 Aug 2024 15:13:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, sergei.shtylyov@gmail.com,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V4 2/2] wifi: ath6kl: remove ath6kl_usb_submit_ctrl_in
Message-ID: <2024082607-foothold-boss-c693@gregkh>
References: <2024082631-upward-zips-f7b8@gregkh>
 <20240826122955.2674569-3-eadavis@qq.com>
 <tencent_6E58783A6D402D596E509598E92AED2ACE0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6E58783A6D402D596E509598E92AED2ACE0A@qq.com>

On Mon, Aug 26, 2024 at 08:29:57PM +0800, Edward Adam Davis wrote:
> ath6kl_usb_submit_ctrl_in() did not take into account the situation where
> the length of the data read from the device is not equal to the len, and
> such missing judgments will result in subsequent code using incorrect data.
> 
> usb_control_msg_recv() handles the abnormal length of the returned data,
> so using it directly.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c | 39 +++------------------------
>  1 file changed, 3 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 0458b5a078e1..b1fc66d823b8 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -901,40 +901,6 @@ static int ath6kl_usb_submit_ctrl_out(struct ath6kl_usb *ar_usb,
>  	return 0;
>  }
>  
> -static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
> -				  u8 req, u16 value, u16 index, void *data,
> -				  u32 size)
> -{
> -	u8 *buf = NULL;
> -	int ret;
> -
> -	if (size > 0) {
> -		buf = kmalloc(size, GFP_KERNEL);
> -		if (buf == NULL)
> -			return -ENOMEM;
> -	}
> -
> -	/* note: if successful returns number of bytes transfered */
> -	ret = usb_control_msg(ar_usb->udev,
> -				 usb_rcvctrlpipe(ar_usb->udev, 0),
> -				 req,
> -				 USB_DIR_IN | USB_TYPE_VENDOR |
> -				 USB_RECIP_DEVICE, value, index, buf,
> -				 size, 2000);
> -
> -	if (ret < 0) {
> -		ath6kl_warn("Failed to read usb control message: %d\n", ret);
> -		kfree(buf);
> -		return ret;
> -	}
> -
> -	memcpy((u8 *) data, buf, size);
> -
> -	kfree(buf);
> -
> -	return 0;
> -}
> -
>  static int ath6kl_usb_ctrl_msg_exchange(struct ath6kl_usb *ar_usb,
>  				     u8 req_val, u8 *req_buf, u32 req_len,
>  				     u8 resp_val, u8 *resp_buf, u32 *resp_len)
> @@ -954,8 +920,9 @@ static int ath6kl_usb_ctrl_msg_exchange(struct ath6kl_usb *ar_usb,
>  	}
>  
>  	/* get response */
> -	ret = ath6kl_usb_submit_ctrl_in(ar_usb, resp_val, 0, 0,
> -					resp_buf, *resp_len);
> +	ret = usb_control_msg_recv(ar_usb->udev, 0, resp_val,
> +				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +				0, 0, resp_buf, *resp_len, 2000, GFP_KERNEL);

You didn't run checkpatch on this :(


