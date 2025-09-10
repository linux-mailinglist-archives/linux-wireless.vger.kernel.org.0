Return-Path: <linux-wireless+bounces-27213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217EB517A7
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 15:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352974660C6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 13:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D831C57E;
	Wed, 10 Sep 2025 13:10:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C61136347
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509854; cv=none; b=TXSZopEOZDfuKdAwOFYKr1fV2EvV5K4bZWS9Gil4Xn4pvQZeHCk2Xziu9mhJ/vv1O/g/KXmYpZRHhuoaSdSXitYwcS9mjYx1TX25Xys/cDWcucoVWgATKlLQ45UO+17UZFvTBE+m+WweEHHqav+aJmqEKLx+GMh32dSnPw9cnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509854; c=relaxed/simple;
	bh=gO2Ks0VHsePKcc510DSGBUvhSSCMEAo5Wf85gCZL4zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zg2nJrFwruFm1yIbIwFb9zjHEXUHB8nNlvI0+v+thQOrQG510WqVOCGyLSQRYQCH64gnCD2/7ROLo0mReAqgWu9CPMA7u6f2kQk/eiq/GH+Qny9dKvCoPypoVuwfqtXYXkzPPBV4+N4F4ai6vmj8wK385ZivyswzlnGR39qweSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uwKb0-0006er-EU; Wed, 10 Sep 2025 15:10:46 +0200
Message-ID: <c3f3370f-1f2c-4e35-81a4-4303aed2d438@pengutronix.de>
Date: Wed, 10 Sep 2025 15:10:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] wifi: mwifiex: fix double free in
 mwifiex_send_rgpower_table()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Johannes Berg <johannes.berg@intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Jeff Chen <jeff.chen_1@nxp.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aLqZBh5_dSHUb4AE@stanley.mountain>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <aLqZBh5_dSHUb4AE@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi Dan,

thanks for spotting and fixing the double free error. I converted the 
code to use the cleanup helper late in the dev process and forgot to 
remove the call. I sent a patch for the endianness bug as well.

On 05.09.25 10:02, Dan Carpenter wrote:
> The "hostcmd" is freed using cleanup.h, so calling kfree() will lead to
> a double free.  Delete the kfree().
> 
> Fixes: 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> index 6d9e2af29a69..91d5098081e8 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
> @@ -1521,10 +1521,8 @@ int mwifiex_send_rgpower_table(struct mwifiex_private *priv, const u8 *data,
>   		return -ENOMEM;
>   
>   	_data = kmemdup(data, size, GFP_KERNEL);
> -	if (!_data) {
> -		kfree(hostcmd);
> +	if (!_data)
>   		return -ENOMEM;
> -	}
>   
>   	pos = _data;
>   	ptr = hostcmd->cmd;

Thank you,
Stefan

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |


