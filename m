Return-Path: <linux-wireless+bounces-11979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7465895EFA8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266D11F2268C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B5153812;
	Mon, 26 Aug 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GH8Xap1m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C01422C7;
	Mon, 26 Aug 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671532; cv=none; b=H2yLus3nxi/3z5w5jpsl4KJnu9PV5cG6jqB2Ipen5o1SfEhMRbnYGC6p8FJv5yb6OKx1viR2JejYKXLRWFQpD7tNw7etoB8j2Deh51Xc7Ya83Q98Tr3mIVttRtTiDj9C7TPVFseSqeLkrzRSK5Av6pJCGAjC/MAP/jrN6xarpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671532; c=relaxed/simple;
	bh=fdmNamvb7WRQZZurBMRVslYpPIn9FgkX3MlvAPG4GxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFgl39/G4m971Een2Cm7xaPD5c/xIAHR+0bTbwXduxdPQk1v4ZkDfLFbHU747TWpfJRduCG5QlRE9GajYu45ZVI5q0Y4uFSP8geTubq0q3z+1Hh8GtqLRDdB6FBQAOvgDuPl9HpOuwlhhlJawuBpGCzd4+8HbBbjKibvnjUjoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GH8Xap1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70935C4FF15;
	Mon, 26 Aug 2024 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724671532;
	bh=fdmNamvb7WRQZZurBMRVslYpPIn9FgkX3MlvAPG4GxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GH8Xap1mEm7hWQK5XayIFE1GX73L4wwqPF52Pcof26sHaM73hmF6pgcIyW+3mapDz
	 q93hxYV3qYFJEk+gpGCfJCPjlHdci5GnE/YVytHOiw3m+YUtgWHNPTPvEb1CNSHt57
	 0Fp5f8+CIvEqlx0zSohmB3cHJjLTtQDi9P12zV1o=
Date: Mon, 26 Aug 2024 13:25:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, sergei.shtylyov@gmail.com,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with
 usb_control_msg_recv
Message-ID: <2024082642-heave-fanning-2600@gregkh>
References: <tencent_2C2C336C9E441B294BB21B6A2558BA34BB08@qq.com>
 <tencent_AAA2EDEACE4478EA6C9C2CA96E8095DCE80A@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AAA2EDEACE4478EA6C9C2CA96E8095DCE80A@qq.com>

On Mon, Aug 26, 2024 at 07:19:09PM +0800, Edward Adam Davis wrote:
> ath6kl_usb_submit_ctrl_in() did not take into account the situation where
> the length of the data read from the device is not equal to the len, and
> such missing judgments will result in subsequent code using incorrect data.
> 
> usb_control_msg_recv() handles the abnormal length of the returned data,
> so using it directly can fix this warning.
> 
> Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> V2 -> V3: Adjust indentation style
> 
>  drivers/net/wireless/ath/ath6kl/usb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 5220809841a6..5b1ce4f9ed54 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -1027,9 +1027,11 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
>  	int ret;
>  
>  	/* get response */
> -	ret = ath6kl_usb_submit_ctrl_in(ar_usb,
> -					ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
> -					0, 0, buf, len);
> +	ret = usb_control_msg_recv(ar_usb->udev, 0,
> +				ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
> +				USB_DIR_IN | USB_TYPE_VENDOR |
> +				USB_RECIP_DEVICE, 0, 0, buf, len, 2000,
> +				GFP_KERNEL);

This should be:

	ret = usb_control_msg_recv(ar_usb->udev, 0,
				ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
				0, 0, buf, len, 2000, GFP_KERNEL);

right?  Keep the | values on the same line.

thanks,

greg k-h

