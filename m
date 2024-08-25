Return-Path: <linux-wireless+bounces-11895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47BC95E268
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 09:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52861C21378
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52C487A5;
	Sun, 25 Aug 2024 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PYjzwrJd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055D6F2E3;
	Sun, 25 Aug 2024 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724570741; cv=none; b=CzhufRmryHFkFDa2vjAI73+Uk6PJrrsd8B8qRT2S8TieAo91KfGqvRpvTc3n7Mbhv7j+9MUGb0+KB2iGwx1CeEo4XBp17bfU8TzVWzsDZQzWmdGeyXT6NwH2oAj4A5LOakvDbw06XWqZ52zw2fwqsheDtkL6SeU/cgLGtWIOGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724570741; c=relaxed/simple;
	bh=ba5A9+0iQOIUq6bNq1yxXNykX9r/BwnBZ9NIzFC0AqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2cPEId1DCaa9OA9aGG6Y9gbxbLDzozsJxHsQ4Q3EwGGeFBacSkWlHVwYWOdQ2kNq3Jy0zK+jhBpnoBQPRGlLZ+zuRbqKpbME17werAibDDFFamjvAEocEoIrHZZoyRbail/0eKg2h688wxwlAcbIAz8bgIqB0fm50xqhj5guQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PYjzwrJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C8FC32782;
	Sun, 25 Aug 2024 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724570741;
	bh=ba5A9+0iQOIUq6bNq1yxXNykX9r/BwnBZ9NIzFC0AqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYjzwrJduX2l13wfo7CZJUOUy131YMLbNjDahwJiVHcA9jiXlEX/zjRnnpXKth5Hy
	 tqaJmjiSqo91rUuC2fNe/EWzJUneLGUVx9ikNiGD6TwOE/1k/dTPV03M6hB4//XlcM
	 MuLutbFVGmTcGSNIHAArZ7wZfGykiEguUdroqYBE=
Date: Sun, 25 Aug 2024 09:25:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: ath6kl: Check that the read operation returns a
 data length of 0
Message-ID: <2024082507-clay-riveting-16f3@gregkh>
References: <00000000000096ee8f061e991433@google.com>
 <tencent_8D19734F828DA6A5938DF1122F5DDC5DBC07@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8D19734F828DA6A5938DF1122F5DDC5DBC07@qq.com>

On Sun, Aug 25, 2024 at 03:10:03PM +0800, Edward Adam Davis wrote:
> If the data length returned by the device is 0, the read operation
> should be considered a failure.
> 
> Reported-and-tested-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 5220809841a6..2a89bab81b24 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -1034,6 +1034,9 @@ static int ath6kl_usb_bmi_read(struct ath6kl *ar, u8 *buf, u32 len)
>  		ath6kl_err("Unable to read the bmi data from the device: %d\n",
>  			   ret);
>  		return ret;
> +	} else {
> +		ath6kl_err("Actual read the bmi data length is 0 from the device\n");
> +		return -EIO;

Close, but not quite there.  ath6kl_usb_submit_ctrl_in() needs to verify
that the actual amount of data was read that was asked for.  If a short
read happens (or a long one), then an error needs to propagate out, not
just 0.  See the "note:" line in that function for what needs to be
properly checked.

hope this helps,

greg k-h

