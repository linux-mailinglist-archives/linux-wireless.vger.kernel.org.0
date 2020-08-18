Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94480247DFA
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 07:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHRFoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 01:44:17 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:57753 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgHRFoR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 01:44:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597729456; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=1unocQMvu9sjJglSqHMIcwAbzJi6rQZsFmun0kqnCOg=; b=lM6Nr2B/TzNqwfmPRhC0+4Z9hkdV2yLXg6UKgt7Gv+vAsxE/DLrk3KB278kw4FGEOsC1NyNk
 PC47ZhZ/fGQD2ya7PHg4DkDRoE8MbnSLyxMmyw7F8spz8OjYtp1VcuyVVE2ch7G+XKCoC/JX
 VGAis22Ai9PBq8+KbQ6Qv9QdDho=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f3b68c81e4d3989d4d11235 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 05:36:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC177C43387; Tue, 18 Aug 2020 05:36:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A4ADC433C6;
        Tue, 18 Aug 2020 05:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A4ADC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/8] rndis_wlan: Make use of cpu_to_le16_array()
References: <20200817184659.58419-1-andriy.shevchenko@linux.intel.com>
        <20200817184659.58419-3-andriy.shevchenko@linux.intel.com>
Date:   Tue, 18 Aug 2020 08:36:04 +0300
In-Reply-To: <20200817184659.58419-3-andriy.shevchenko@linux.intel.com> (Andy
        Shevchenko's message of "Mon, 17 Aug 2020 21:46:54 +0300")
Message-ID: <87tux0jz23.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> Since we have a new helper, let's replace open coded variant by it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jussi Kivilinna <jussi.kivilinna@iki.fi>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> ---
> v2: new patch
>  drivers/net/wireless/rndis_wlan.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
> index 8852a1832951..06850ee6d6dc 100644
> --- a/drivers/net/wireless/rndis_wlan.c
> +++ b/drivers/net/wireless/rndis_wlan.c
> @@ -859,9 +859,12 @@ static int rndis_set_config_parameter(struct usbnet *dev, char *param,
>  						int value_type, void *value)
>  {
>  	struct ndis_config_param *infobuf;
> -	int value_len, info_len, param_len, ret, i;
> +	int value_len, info_len, param_len, ret;
>  	__le16 *unibuf;
>  	__le32 *dst_value;
> +#ifdef DEBUG
> +	int i;
> +#endif
>  
>  	if (value_type == 0)
>  		value_len = sizeof(__le32);
> @@ -901,13 +904,11 @@ static int rndis_set_config_parameter(struct usbnet *dev, char *param,
>  
>  	/* simple string to unicode string conversion */
>  	unibuf = (void *)infobuf + sizeof(*infobuf);
> -	for (i = 0; i < param_len / sizeof(__le16); i++)
> -		unibuf[i] = cpu_to_le16(param[i]);
> +	cpu_to_le16_array(unibuf, param, param_len / sizeof(__le16));
>  
>  	if (value_type == 2) {
>  		unibuf = (void *)infobuf + sizeof(*infobuf) + param_len;
> -		for (i = 0; i < value_len / sizeof(__le16); i++)
> -			unibuf[i] = cpu_to_le16(((u8 *)value)[i]);
> +		cpu_to_le16_array(unibuf, value, value_len / sizeof(__le16));
>  	} else {
>  		dst_value = (void *)infobuf + sizeof(*infobuf) + param_len;
>  		*dst_value = cpu_to_le32(*(u32 *)value);

I assume this goes via usb tree:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
