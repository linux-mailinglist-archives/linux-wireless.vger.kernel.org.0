Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B84364114
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbhDSLya (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 07:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhDSLy3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 07:54:29 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA3C06174A;
        Mon, 19 Apr 2021 04:53:59 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a18so2026975qtj.10;
        Mon, 19 Apr 2021 04:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Og9hc16KBzSKSswGbkMPhuX1y41NHyqdSV5Z1AeF8CY=;
        b=OtccHCfL2OmpKSlJZsoLHOOFs2nEXrhaZoP9RKTTpt6h9u3D5k6y1nSUNhlI7Oruy/
         V1D5DTSVxOvCJzpqE5uoNFBOt38yHCoQaRvtpfuVIwliE2oSGuc2/tkf6+pTzUVXAMjc
         EyT4SVHPbypj/zFHsVaskBeD+EVH9a0KzAhuUeekI5qEeuCgXcYTtjkiHKZd2SGiFDTb
         l06Cqwqh3DfBVC69rO0+REnamPUJhSiNDkT9V5m0dCjttTiKq7o9g/AL9yrz2R6QytmZ
         V72KC8SclNY0R3+t9ejKQYtjA086cSv6qP73I+75MZ0GkQnrPnmw0opvUhnAApy8ZKHk
         DTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Og9hc16KBzSKSswGbkMPhuX1y41NHyqdSV5Z1AeF8CY=;
        b=T5dfHzWXnLLRI1TQqqxeUzL1QR/dtqYsGVY4itoZ3lEaCLSG8n+oqAI1dIq/Fd3+Ku
         g/GlR4oRkc37/TzTLWgoCfXkPtJxv8vjHduhBMCif48b1KT6A0WsdKJO1fE29uDvgnF7
         THt4YgrcligaHaGOKPfUnx7MZKHJDEZgaBDB+/OsZU/4K5IAk36YJ2h6ZHLSz4NZ31+v
         ys0uVLFjkFGGZS4tcpPQhTD1TLVr4JDPJFUGy7dRtvWUTF/+fkRFtlYJS4UJaNNhHgw3
         80b29qMA6omYUvhGb1bBAGoX6tJIkxm+sfR/lg0wa49zyPVeQOHMw46ipvOY+9S7/D2Y
         u3iA==
X-Gm-Message-State: AOAM531bSSp8RDylYeZNr5/4hdbAQOWZ/8Q1rdKGpaVAhlvR6Pi5levj
        eywXJMpbb3s/XGBuaEYU59CYoykPA8s=
X-Google-Smtp-Source: ABdhPJxOfnndsz+YKpAytAFfNtNYoLzkzBuMjhkJkyO3HJ7eXpc9IbGee7MGAoOsKSPi5NlGL1e/xQ==
X-Received: by 2002:ac8:41ce:: with SMTP id o14mr11314082qtm.96.1618833238903;
        Mon, 19 Apr 2021 04:53:58 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:1102::1844? ([2620:10d:c091:480::1:1b53])
        by smtp.gmail.com with ESMTPSA id 205sm9725165qke.8.2021.04.19.04.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 04:53:58 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] rtl8xxxu: Fix device info for RTL8192EU devices
To:     Pascal Terjan <pterjan@google.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210323193617.3748164-1-pterjan@google.com>
Message-ID: <a69a3d60-71a0-3153-b248-dacc8b95bea8@gmail.com>
Date:   Mon, 19 Apr 2021 07:53:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323193617.3748164-1-pterjan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/23/21 3:36 PM, Pascal Terjan wrote:
> Based on 2001:3319 and 2357:0109 which I used to test the fix and
> 0bda:818b and 2357:0108 for which I found efuse dumps online.
> 
> == 2357:0109 ==
> === Before ===
> Vendor: Realtek
> Product: \x03802.11n NI
> Serial:
> === After ===
> Vendor: Realtek
> Product: 802.11n NIC
> Serial not available.
> 
> == 2001:3319 ==
> === Before ===
> Vendor: Realtek
> Product: Wireless N
> Serial: no USB Adap
> === After ===
> Vendor: Realtek
> Product: Wireless N Nano USB Adapter
> Serial not available.
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 11 ++--
>  .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 53 ++++++++++++++++---
>  2 files changed, 50 insertions(+), 14 deletions(-)

This makes sense, you may want to account for the total length of the
record though, see below.

Some cosmetic nits too.

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> index d6d1be4169e5..acb6b0cd3667 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
> @@ -853,15 +853,10 @@ struct rtl8192eu_efuse {
>  	u8 usb_optional_function;
>  	u8 res9[2];
>  	u8 mac_addr[ETH_ALEN];		/* 0xd7 */
> -	u8 res10[2];
> -	u8 vendor_name[7];
> -	u8 res11[2];
> -	u8 device_name[0x0b];		/* 0xe8 */
> -	u8 res12[2];
> -	u8 serial[0x0b];		/* 0xf5 */
> -	u8 res13[0x30];
> +	u8 device_info[80];
> +	u8 res11[3];
>  	u8 unknown[0x0d];		/* 0x130 */
> -	u8 res14[0xc3];
> +	u8 res12[0xc3];
>  };
>  
>  struct rtl8xxxu_reg8val {
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> index cfe2dfdae928..9c5fad49ed2a 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
> @@ -554,9 +554,39 @@ rtl8192e_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
>  	}
>  }
>  
> +static void rtl8192eu_log_device_info(struct rtl8xxxu_priv *priv,
> +				      char *record_name,
> +				      char **record)
> +{
> +	/* A record is [ total length | 0x03 | value ] */
> +	unsigned char l = (*record)[0];

These parenthesis make no sense.

> +
> +	/* The whole section seems to be 80 characters so a record should not
> +	 * be able to be that large.
> +	 */

Please respect the comment formatting of the driver, ie
/*
 * Foo
 */


> +	if (l > 80) {
> +		dev_warn(&priv->udev->dev,
> +			 "invalid record length %d while parsing \"%s\".\n",
> +			 l, record_name);
> +		return;
> +	}

The 80 check is only valid for the first entry, consecutive entries are
already advanced. Maybe switch it over to use an index to address into
the record keep an index and just pass in efuse->device_info instead.

> +
> +	if (l >= 2) {
> +		char value[80];
> +
> +		memcpy(value, &(*record)[2], l - 2);
> +		value[l - 2] = '\0';
> +		dev_info(&priv->udev->dev, "%s: %s\n", record_name, value);
> +		*record = *record + l;
> +	} else {
> +		dev_info(&priv->udev->dev, "%s not available.\n", record_name);
> +	}
> +}
> +
>  static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
>  {
>  	struct rtl8192eu_efuse *efuse = &priv->efuse_wifi.efuse8192eu;
> +	char *record = efuse->device_info;
>  	int i;
>  
>  	if (efuse->rtl_id != cpu_to_le16(0x8129))
> @@ -604,12 +634,23 @@ static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
>  	priv->has_xtalk = 1;
>  	priv->xtalk = priv->efuse_wifi.efuse8192eu.xtal_k & 0x3f;
>  
> -	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
> -	dev_info(&priv->udev->dev, "Product: %.11s\n", efuse->device_name);
> -	if (memchr_inv(efuse->serial, 0xff, 11))
> -		dev_info(&priv->udev->dev, "Serial: %.11s\n", efuse->serial);
> -	else
> -		dev_info(&priv->udev->dev, "Serial not available.\n");
> +	/* device_info section seems to be laid out as records
> +	 * [ total length | 0x03 | value ] so:
> +	 * - vendor length + 2
> +	 * - 0x03
> +	 * - vendor string (not null terminated)
> +	 * - product length + 2
> +	 * - 0x03
> +	 * - product string (not null terminated)
> +	 * Then there is one or 2 0x00 on all the 4 devices I own or found
> +	 * dumped online.
> +	 * As previous version of the code handled an optional serial
> +	 * string, I now assume there may be a third record if the
> +	 * length is not 0.
> +	 */
> +	rtl8192eu_log_device_info(priv, "Vendor", &record);
> +	rtl8192eu_log_device_info(priv, "Product", &record);
> +	rtl8192eu_log_device_info(priv, "Serial", &record);
>  
>  	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
>  		unsigned char *raw = priv->efuse_wifi.raw;
> 

