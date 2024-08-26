Return-Path: <linux-wireless+bounces-11933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4514B95E7CF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0261E28146B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 05:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D991155893;
	Mon, 26 Aug 2024 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LUtC55Vb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4212F2D;
	Mon, 26 Aug 2024 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724648644; cv=none; b=s+wFOZy2DAYMFKMJXW5PsYyE3n+Katj3IvrOszBRnHymKWquRPDF4dTafTd/xQXzZZbl5I7PuQv4Hg53zhihxsf5KTf2yHJ5bcL4ISH0MzP0/NGFJRPVMZkK9+lZjh1HMPJnaXTzQEO4GgPCMPXXVUVcRrSsWPYiIbZLvkkAbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724648644; c=relaxed/simple;
	bh=ueOYisPLZIrJNwDLMPCbIZvCi9eEz2pWhLtXasqFLH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su0ic77cdqnaDGNc6Pd4fgkCXDUNdz5pCvUXZxE4Mj75f2H9ll4+C7cHR4gGrVYNpH0N6qx5Yg7hxAqkENUKPW8DKF9jTBtgJ0yMGw8FS19F0D4B5jcer00ABPh/+XwEntGk8R309nbg2g4YNqjyUAg8EZuxKDwzdmlrP2rJnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LUtC55Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537ABC4AF0C;
	Mon, 26 Aug 2024 05:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724648644;
	bh=ueOYisPLZIrJNwDLMPCbIZvCi9eEz2pWhLtXasqFLH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUtC55VbKehADXr12ir+aMdz36JIjePGIM95lT4BzN9CJueTxDJpKF6+NDYyWY4wE
	 gxjT12eb6w/t9hRXVjoESM+KbCtPYjWupUX8O9zJmXIyIPMJNq32Zvdkb2ciOxqVHT
	 hkOkbEiMQEAVnvP/7NeYqZdxDUmWGX/o8Iut9sQU=
Date: Mon, 26 Aug 2024 07:04:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with
 usb_control_msg_recv
Message-ID: <2024082649-shape-karate-40b0@gregkh>
References: <tencent_1D9967CEC6D952EC86530991EED86ED70C06@qq.com>
 <tencent_F0CB92D8867509922ED02ED5CCA4E7D2C606@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F0CB92D8867509922ED02ED5CCA4E7D2C606@qq.com>

On Sun, Aug 25, 2024 at 10:21:49PM +0800, Edward Adam Davis wrote:
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
> V2: Directly using USB functions
> 
>  drivers/net/wireless/ath/ath6kl/usb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 5220809841a6..dc1f89ebb740 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -1027,9 +1027,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
>  	int ret;
>  
>  	/* get response */
> -	ret = ath6kl_usb_submit_ctrl_in(ar_usb,
> -					ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
> -					0, 0, buf, len);

By removing this call, there is now only one call left to
ath6kl_usb_submit_ctrl_in(), so that probably can also be unwrapped in a
second patch in this series, right?

> +	ret = usb_control_msg_recv(ar_usb->udev, 0, ATH6KL_USB_CONTROL_REQ_RECV_BMI_RESP,
> +				 USB_DIR_IN | USB_TYPE_VENDOR |
> +				 USB_RECIP_DEVICE, 0, 0, buf, len, 2000, GFP_KERNEL);

As was pointed out, this is a very odd indentation style.

thanks,

greg k-h

