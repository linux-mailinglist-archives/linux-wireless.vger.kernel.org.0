Return-Path: <linux-wireless+bounces-11980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825EC95EFAB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17CF1C213D8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0FC153828;
	Mon, 26 Aug 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2G0fFHvP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D770143C7D;
	Mon, 26 Aug 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671591; cv=none; b=ndWiJbmV6jwdLNewxaRNl4K+XO3Dz+Fs6W3ihZRNXHAKKPLwu1xVwLPZc1GWsEAZ+18cxa5g3ouPhhgp1DhlJVHeVsa5Mutbl71bmI4j7WcwIEm9bT8TY+5HQXuV1IH5bN6sjoWjk24YQ7jfw9DOi9aMWc2e7otHmD4DhmDlfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671591; c=relaxed/simple;
	bh=xgIrjbnPUK7X9li5k4Abk/lSMwv/fLyCRRwSRyE1oJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Obia63lCCo2IqwW/ECmeFl54WDzLYKnr5dYFNqUlkN1icXu0fX9Z/Ix2gmHhW40AIO4ZkURj6i/TSXIsM/P8effOMrdX76N8MQaDwQCkg7LPvMNVnpvHp8zVoD8VL0Ze0k6vnie+uapSMa73U+t/JI4SWpgNQoLiqPW41K40W9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2G0fFHvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85294C4FF16;
	Mon, 26 Aug 2024 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724671590;
	bh=xgIrjbnPUK7X9li5k4Abk/lSMwv/fLyCRRwSRyE1oJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2G0fFHvPmBEga4ilx8TY4lRFxtHPS9EWme/8oo2iegDPfxy1pGnA02Uu0UXT9vmMP
	 4pmeAaeaWbYS2xstzqWSsmTxZa4RS+VXjnqeimlqtJMfYCXeOrBsSFSTBbqxTlD/Gb
	 dHFIjsZsZrk+6zeWcskiSgNoUPg48AkbgZE9iuDQ=
Date: Mon, 26 Aug 2024 13:26:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, sergei.shtylyov@gmail.com,
	syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with
 usb_control_msg_recv
Message-ID: <2024082631-upward-zips-f7b8@gregkh>
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

Again, please make this a patch series, with the second one removing
ath6kl_usb_submit_ctrl_in() and moving to use usb_control_msg_recv() for
that too.

thanks,

greg k-h

