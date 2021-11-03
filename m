Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138BC44470C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 18:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKCRa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKCRaz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 13:30:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48481C061205
        for <linux-wireless@vger.kernel.org>; Wed,  3 Nov 2021 10:28:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o14so2967167plg.5
        for <linux-wireless@vger.kernel.org>; Wed, 03 Nov 2021 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NcwuPLOjcRJ80x/LipZOI4qiTbp+r+P7DcX9hPJki30=;
        b=e5bsZRVQwKkerzbUsA1160FqOLH1af6quHAVCXRanpCgacv8lRuVojvyI/KOkcBpfq
         ZtZ4Mi1zKS4OjadNH0nE6+KzMFvjOdkPM1r8PkL2iWzRIgB55X6C30ddHF0YE2aJuNga
         5RfqAuOlsJYkUvCkQxSVGQBvVbNNgOoZwMdAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NcwuPLOjcRJ80x/LipZOI4qiTbp+r+P7DcX9hPJki30=;
        b=DQ2GpTrILAM4nTd/JdTYHkFqIyd5JrZ3TkuXEwG51Ix2Zb2HCrKDtiEXsjiJMbEaZ8
         5j/QQI3nAMj784yJLb5WkxoVXQSc/oU+06rRGbsuGF9xxBFLpJ9kocgEPU9XBRzP8zS5
         h6dvP88dm+2RPl5IrExIn5McjsVw2lxuFGGZ3Nw4muW00/yAn5yh2lcXcD6AokKRFzaG
         q3D/ItOq/9BCKs4ZXhZmFiBrOSp7RgrOrw8Xe935t8gnYHzXFgX7V2N0nR8mRHPdbjyA
         EuiwIGFmANDNyc/OQjJrNlW8tamDH5IHqkY/FDdatEaS3eL7S+wmGotizMykTwUlMx+8
         pN0g==
X-Gm-Message-State: AOAM531zlvGhzgTUMXHslf0NQlOuPhE0KOE3VrzpHCWK5glED1QdPP7p
        qFEdJf9HTl/ztCt/zOtiUlgaOQ==
X-Google-Smtp-Source: ABdhPJxFDP5WBMs30DYUN69TYJEAhPfTWLRE/Xx438QXQO63mQTcP6N0EqJt3trDdUQbRkowJ3/sYw==
X-Received: by 2002:a17:902:728b:b0:13f:c086:bdfe with SMTP id d11-20020a170902728b00b0013fc086bdfemr39360399pll.6.1635960498721;
        Wed, 03 Nov 2021 10:28:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c80d:e9d8:d115:daf])
        by smtp.gmail.com with ESMTPSA id b15sm3108732pfm.203.2021.11.03.10.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:28:18 -0700 (PDT)
Date:   Wed, 3 Nov 2021 10:28:16 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v3 1/2] mwifiex: Use a define for firmware version string
 length
Message-ID: <YYLGsPhKZe4A0XFr@google.com>
References: <20211103171055.16911-1-verdre@v0yd.nl>
 <20211103171055.16911-2-verdre@v0yd.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103171055.16911-2-verdre@v0yd.nl>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 03, 2021 at 06:10:54PM +0100, Jonas Dreﬂler wrote:
> Since the version string we get from the firmware is always 128
> characters long, use a define for this size instead of having the number
> 128 copied all over the place.
> 
> Signed-off-by: Jonas Dreﬂler <verdre@v0yd.nl>

Thanks for this patch. For the series:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
>  drivers/net/wireless/marvell/mwifiex/fw.h          | 4 +++-
>  drivers/net/wireless/marvell/mwifiex/main.h        | 2 +-
>  drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 5 +++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 2ff23ab259ab..63c25c69ed2b 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -2071,9 +2071,11 @@ struct mwifiex_ie_types_robust_coex {
>  	__le32 mode;
>  } __packed;
>  
> +#define MWIFIEX_VERSION_STR_LENGTH  128
> +
>  struct host_cmd_ds_version_ext {
>  	u8 version_str_sel;
> -	char version_str[128];
> +	char version_str[MWIFIEX_VERSION_STR_LENGTH];
>  } __packed;
>  
>  struct host_cmd_ds_mgmt_frame_reg {
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
> index 90012cbcfd15..65609ea2327e 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.h
> +++ b/drivers/net/wireless/marvell/mwifiex/main.h
> @@ -646,7 +646,7 @@ struct mwifiex_private {
>  	struct wireless_dev wdev;
>  	struct mwifiex_chan_freq_power cfp;
>  	u32 versionstrsel;
> -	char version_str[128];
> +	char version_str[MWIFIEX_VERSION_STR_LENGTH];
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dfs_dev_dir;
>  #endif
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> index 6b5d35d9e69f..20b69a37f9e1 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> @@ -711,8 +711,9 @@ static int mwifiex_ret_ver_ext(struct mwifiex_private *priv,
>  	if (version_ext) {
>  		version_ext->version_str_sel = ver_ext->version_str_sel;
>  		memcpy(version_ext->version_str, ver_ext->version_str,
> -		       sizeof(char) * 128);
> -		memcpy(priv->version_str, ver_ext->version_str, 128);
> +		       MWIFIEX_VERSION_STR_LENGTH);
> +		memcpy(priv->version_str, ver_ext->version_str,
> +		       MWIFIEX_VERSION_STR_LENGTH);

Not related to your patch, but this highlights that nobody is ensuring
this string is 0-terminated, and various other places (notably, *not*
your patch 2!) assume that it is.

We should either fix those to use an snprintf()/length-restricted
variant, or else just force:

		priv->version_str[MWIFIEX_VERSION_STR_LENGTH - 1] = '\0';

here.

But that's a separate issue/patch. I can cook one on top of your series
when it gets merged if you don't want to.

Brian

>  	}
>  	return 0;
>  }
> -- 
> 2.33.1
> 
