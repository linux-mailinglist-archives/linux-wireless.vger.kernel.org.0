Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84D34623F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 16:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhCWPD7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 11:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232336AbhCWPD2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 11:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616511807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzM7fzIa27HA919EKJPeo4/3mZLnET0KAoGtKPohuRo=;
        b=WXj1m5NrNJAUfEmG4bIjGBki7FRTVQDwz2ALchgAEvFJ1iG2O/it4UzVUvLavYOtaCnTrz
        GnTgqbxr3ljRiABJV6PTQcxH60Y/Y6yidJ0+s19cpwrpjb6oV/3sZ2WkT/LTZURSruMa9m
        rOfxk1KqE49cBaimn0AEWdkpFvIwuj8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-MTba1tq0OImjTaPz75t7Lg-1; Tue, 23 Mar 2021 11:03:25 -0400
X-MC-Unique: MTba1tq0OImjTaPz75t7Lg-1
Received: by mail-qv1-f72.google.com with SMTP id u17so1758923qvq.23
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 08:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gzM7fzIa27HA919EKJPeo4/3mZLnET0KAoGtKPohuRo=;
        b=S0MJCE83f1q7BjQUUx+Q7HMeHcUJZDf57qGVYx+PNtWDdvrZ3OMeWfF6Rb8TP/EosK
         KlLOatfrlCuhIHUnbV6t2IXsVreFvLgJ603nQ9eaMvK8s8W8r67JUT+TscmQrxt9WbaT
         lVK6xFDnYZHkosOVIXHppQMrpU6lorkQOnPe91brVFCeU3awd7cUf8rlQ3s8a2brrfBn
         +zPQpy2WrfDIJPjfyc+6jhYE6HmsrmkyiBYmCHOFaPWTcZj9+1Igp/ouDpuZs1Ufz0Ot
         Cjuet+fQaH9oWnxyC1o0ISKlkkz9jkO8LlE3HG8/66trOEzjQMTFqXGWvNdVZPzfrJqK
         +Vkw==
X-Gm-Message-State: AOAM530ySlulghonHtNFkAvO/L8QZU1BoW33V4xBVa0TvydZskVbtZNA
        lGZyIKTZUDUA5HSdACTyyBjeaizcL/DJ6C4fdDJRWM3cObVcCJwTBJcQmLLlBNu6GwUAELvQ6Yf
        BtswQpt0fJa8E4s1hoetG5XRd6Z4=
X-Received: by 2002:a05:6214:a91:: with SMTP id ev17mr5446730qvb.59.1616511805188;
        Tue, 23 Mar 2021 08:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhC3u3a88NRfJWWKAbxH4TIEos1Vt/VsjTCAHWQZVhwl7wikb+mI+s0BWAf83yZcp6NK96qw==
X-Received: by 2002:a05:6214:a91:: with SMTP id ev17mr5446698qvb.59.1616511804907;
        Tue, 23 Mar 2021 08:03:24 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d18sm10647197qtd.85.2021.03.23.08.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:03:24 -0700 (PDT)
Subject: Re: [PATCH net-next] airo: work around stack usage warning
To:     Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210323131634.2669455-1-arnd@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c6fcc558-7fd4-445b-169e-2c9878a625f2@redhat.com>
Date:   Tue, 23 Mar 2021 08:03:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323131634.2669455-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 3/23/21 6:16 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-11 with KASAN on 32-bit arm produces a warning about a function
> that needs a lot of stack space:
>
> drivers/net/wireless/cisco/airo.c: In function 'setup_card.constprop':
> drivers/net/wireless/cisco/airo.c:3960:1: error: the frame size of 1512 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]
>
> Most of this is from a single large structure that could be dynamically
> allocated or moved into the per-device structure.  However, as the callers
> all seem to have a fairly well bounded call chain, the easiest change
> is to pull out the part of the function that needs the large variables
> into a separate function and mark that as noinline_for_stack. This does
> not reduce the total stack usage, but it gets rid of the warning and
> requires minimal changes otherwise.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/cisco/airo.c | 117 +++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
> index e35e1380ae43..540ba694899c 100644
> --- a/drivers/net/wireless/cisco/airo.c
> +++ b/drivers/net/wireless/cisco/airo.c
> @@ -3818,6 +3818,68 @@ static inline void set_auth_type(struct airo_info *local, int auth_type)
>  		local->last_auth = auth_type;
>  }
>  
> +static int noinline_for_stack airo_readconfig(struct airo_info *ai, u8 *mac, int lock)
> +{
> +	int i, status;
> +	/* large variables, so don't inline this function,
> +	 * maybe change to kmalloc
> +	 */
> +	tdsRssiRid rssi_rid;
> +	CapabilityRid cap_rid;
> +
> +	kfree(ai->SSID);
> +	ai->SSID = NULL;
> +	// general configuration (read/modify/write)
> +	status = readConfigRid(ai, lock);
> +	if (status != SUCCESS) return ERROR;
> +
> +	status = readCapabilityRid(ai, &cap_rid, lock);
> +	if (status != SUCCESS) return ERROR;
> +
> +	status = PC4500_readrid(ai, RID_RSSI, &rssi_rid, sizeof(rssi_rid), lock);
> +	if (status == SUCCESS) {
> +		if (ai->rssi || (ai->rssi = kmalloc(512, GFP_KERNEL)) != NULL)
> +			memcpy(ai->rssi, (u8*)&rssi_rid + 2, 512); /* Skip RID length member */
> +	}
> +	else {
> +		kfree(ai->rssi);
> +		ai->rssi = NULL;
> +		if (cap_rid.softCap & cpu_to_le16(8))
> +			ai->config.rmode |= RXMODE_NORMALIZED_RSSI;
> +		else
> +			airo_print_warn(ai->dev->name, "unknown received signal "
> +					"level scale");
> +	}
> +	ai->config.opmode = adhoc ? MODE_STA_IBSS : MODE_STA_ESS;
> +	set_auth_type(ai, AUTH_OPEN);
> +	ai->config.modulation = MOD_CCK;
> +
> +	if (le16_to_cpu(cap_rid.len) >= sizeof(cap_rid) &&
> +	    (cap_rid.extSoftCap & cpu_to_le16(1)) &&
> +	    micsetup(ai) == SUCCESS) {
> +		ai->config.opmode |= MODE_MIC;
> +		set_bit(FLAG_MIC_CAPABLE, &ai->flags);
> +	}
> +
> +	/* Save off the MAC */
> +	for (i = 0; i < ETH_ALEN; i++) {
> +		mac[i] = ai->config.macAddr[i];
> +	}
> +
> +	/* Check to see if there are any insmod configured
> +	   rates to add */
> +	if (rates[0]) {
> +		memset(ai->config.rates, 0, sizeof(ai->config.rates));
> +		for (i = 0; i < 8 && rates[i]; i++) {
> +			ai->config.rates[i] = rates[i];
> +		}
> +	}
> +	set_bit (FLAG_COMMIT, &ai->flags);
> +
> +	return SUCCESS;
> +}
> +
> +
>  static u16 setup_card(struct airo_info *ai, u8 *mac, int lock)
>  {
>  	Cmd cmd;
> @@ -3864,58 +3926,9 @@ static u16 setup_card(struct airo_info *ai, u8 *mac, int lock)
>  	if (lock)
>  		up(&ai->sem);
>  	if (ai->config.len == 0) {
> -		int i;
> -		tdsRssiRid rssi_rid;
This is mostly an array, and what I guess is the problem.
> -		CapabilityRid cap_rid;
> -
> -		kfree(ai->SSID);
> -		ai->SSID = NULL;
> -		// general configuration (read/modify/write)
> -		status = readConfigRid(ai, lock);
> -		if (status != SUCCESS) return ERROR;
> -
> -		status = readCapabilityRid(ai, &cap_rid, lock);
> -		if (status != SUCCESS) return ERROR;
> -
> -		status = PC4500_readrid(ai, RID_RSSI,&rssi_rid, sizeof(rssi_rid), lock);
This is reading into a stack temp
> -		if (status == SUCCESS) {
> -			if (ai->rssi || (ai->rssi = kmalloc(512, GFP_KERNEL)) != NULL)
> -				memcpy(ai->rssi, (u8*)&rssi_rid + 2, 512); /* Skip RID length member */

Here is the temp being copied to heap memory.

This is the only use of rssi_rid

Why not do the alloc in PC4500_read ?

The call would be something like

status = PC4500_readrid(ai, RID_RSSI, &ai->rssi, sizeof(), lock)

or since ai, is common reduce the signature of the function and make the call

PC4500_readid(ai, RID_RSSI, lock)

Tom

> -		}
> -		else {
> -			kfree(ai->rssi);
> -			ai->rssi = NULL;
> -			if (cap_rid.softCap & cpu_to_le16(8))
> -				ai->config.rmode |= RXMODE_NORMALIZED_RSSI;
> -			else
> -				airo_print_warn(ai->dev->name, "unknown received signal "
> -						"level scale");
> -		}
> -		ai->config.opmode = adhoc ? MODE_STA_IBSS : MODE_STA_ESS;
> -		set_auth_type(ai, AUTH_OPEN);
> -		ai->config.modulation = MOD_CCK;
> -
> -		if (le16_to_cpu(cap_rid.len) >= sizeof(cap_rid) &&
> -		    (cap_rid.extSoftCap & cpu_to_le16(1)) &&
> -		    micsetup(ai) == SUCCESS) {
> -			ai->config.opmode |= MODE_MIC;
> -			set_bit(FLAG_MIC_CAPABLE, &ai->flags);
> -		}
> -
> -		/* Save off the MAC */
> -		for (i = 0; i < ETH_ALEN; i++) {
> -			mac[i] = ai->config.macAddr[i];
> -		}
> -
> -		/* Check to see if there are any insmod configured
> -		   rates to add */
> -		if (rates[0]) {
> -			memset(ai->config.rates, 0, sizeof(ai->config.rates));
> -			for (i = 0; i < 8 && rates[i]; i++) {
> -				ai->config.rates[i] = rates[i];
> -			}
> -		}
> -		set_bit (FLAG_COMMIT, &ai->flags);
> +		status = airo_readconfig(ai, mac, lock);
> +		if (status != SUCCESS)
> +			return ERROR;
>  	}
>  
>  	/* Setup the SSIDs if present */

