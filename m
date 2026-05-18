Return-Path: <linux-wireless+bounces-36590-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCEnHpTFCmqa7wQAu9opvQ
	(envelope-from <linux-wireless+bounces-36590-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:53:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DC5682A7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD11C3001CF1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038C13D16EB;
	Mon, 18 May 2026 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="EEWov21j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AA3DDDC3
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090066; cv=none; b=l9hRrkZTA0cXS2sM5ltngCYA/r79vFgUtklNUT/GyDWyrfQusE7F7oCVBtOyznLq4BJtQPjVG3Tkc7GvLpaMfDm1Czavz2QdfK9TY8dyVFGfcfiqFPC0B+G7m806LJhdvolYQKSO/DucZLs+zKyxTGh2RHIP9KT6UxOwTQpAGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090066; c=relaxed/simple;
	bh=+t7eCfHcu99uc/1gojh87pyUWrkEoYqEbDEsnP8cOTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNsRo8Yr5FpAYhMvWuYP5S6J6sJ3m/EwdkaB+1AyRc0Ky/opZU24UUz8v9jgJpWVS7ODKBzd3V6Ju/eKv6Y5LhZ+mPYXftBIlK3BQPlDeNtGDvO5OId7K4DToa5oda4MbnTLnv/3ciBGE9oaU8J2ZCMpM5ssCznoz6a4B5RGA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=EEWov21j; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30207 invoked from network); 18 May 2026 09:40:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1779090055; bh=HYgurHUU4+knRgMSE8vU6X7ApzfW3qHKdUoHfCKhVRs=;
          h=From:To:Cc:Subject;
          b=EEWov21jQZeVL0UYxkkUkyEaIK9CJBW5PhGMRGLejvAMFMx9tJO2+r1M7jsxokQDm
           hJuJcTmhxsMmizt4YeliIr0kylCUoEbWWKK/+U0MvmFnwsTNDh55kwnhTvq8Y4hdaR
           8n7YXlECR0PR4KnE30Hzaw52W/4mQKe/rm+0TlRRAl0XS+7B9ETEQ2Ik3oH0wPWFw/
           oBbimc7HJf7VtGjONGLpFZQSJv3SNF6CeJ7G5EBSEZ5GsJWzaPOlc68itLJc8mUDqd
           MHFCeIna2uwJIIuMhN8jl/dtJdcBYAhcE3ykfeFTApWY3BC+YR/1WIhmiCMXEIx7Gv
           w+/m3G0oL79BA==
Received: from 77-236-5-199.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.199])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 18 May 2026 09:40:55 +0200
Date: Mon, 18 May 2026 09:40:54 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless-next] wifi: rt2x00: Allocate LED names
 dynamically
Message-ID: <20260518074054.GA20466@wp.pl>
References: <20260517231759.56638-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517231759.56638-1-rosenp@gmail.com>
X-WP-MailID: ac132383b09a213990f7798b1bab3ac7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MaMx]                               
X-Rspamd-Queue-Id: 823DC5682A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36590-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[wp.pl];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wp.pl:mid,wp.pl:dkim]
X-Rspamd-Action: no action

Hi,

On Sun, May 17, 2026 at 04:17:59PM -0700, Rosen Penev wrote:
> The rt2x00 LED registration path builds LED class names from the
> driver and wiphy names. A fixed stack buffer can truncate those names
> before they are passed to the LED core.

To properly justify the change you'll need to provide real world
example when the size is not sufficient.

> Allocate each LED name with kasprintf(), check allocation failures, and
> release the stored name when the LED is unregistered.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../net/wireless/ralink/rt2x00/rt2x00leds.c   | 30 ++++++++++++++-----
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c b/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c
> index f5361d582d4e..8818e0b2447b 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00leds.c
> @@ -100,6 +100,8 @@ static int rt2x00leds_register_led(struct rt2x00_dev *rt2x00dev,
>  
>  	retval = led_classdev_register(device, &led->led_dev);
>  	if (retval) {
> +		kfree(name);
> +		led->led_dev.name = NULL;
>  		rt2x00_err(rt2x00dev, "Failed to register led handler\n");
>  		return retval;
>  	}
> @@ -111,15 +113,19 @@ static int rt2x00leds_register_led(struct rt2x00_dev *rt2x00dev,
>  
>  void rt2x00leds_register(struct rt2x00_dev *rt2x00dev)
>  {
> -	char name[36];
> +	char *name;
>  	int retval;
>  	unsigned long on_period;
>  	unsigned long off_period;
>  	const char *phy_name = wiphy_name(rt2x00dev->hw->wiphy);
>  
>  	if (rt2x00dev->led_radio.flags & LED_INITIALIZED) {
> -		snprintf(name, sizeof(name), "%s-%s::radio",
> -			 rt2x00dev->ops->name, phy_name);
> +		name = kasprintf(GFP_KERNEL, "%s-%s::radio",
> +				 rt2x00dev->ops->name, phy_name);
> +		if (!name) {
> +			retval = -ENOMEM;
> +			goto exit_fail;
> +		}

This is overengineering. If needed, the name size can be increased.

Regards
Stanislaw

>  
>  		retval = rt2x00leds_register_led(rt2x00dev,
>  						 &rt2x00dev->led_radio,
> @@ -129,8 +135,12 @@ void rt2x00leds_register(struct rt2x00_dev *rt2x00dev)
>  	}
>  
>  	if (rt2x00dev->led_assoc.flags & LED_INITIALIZED) {
> -		snprintf(name, sizeof(name), "%s-%s::assoc",
> -			 rt2x00dev->ops->name, phy_name);
> +		name = kasprintf(GFP_KERNEL, "%s-%s::assoc",
> +				 rt2x00dev->ops->name, phy_name);
> +		if (!name) {
> +			retval = -ENOMEM;
> +			goto exit_fail;
> +		}
>  
>  		retval = rt2x00leds_register_led(rt2x00dev,
>  						 &rt2x00dev->led_assoc,
> @@ -140,8 +150,12 @@ void rt2x00leds_register(struct rt2x00_dev *rt2x00dev)
>  	}
>  
>  	if (rt2x00dev->led_qual.flags & LED_INITIALIZED) {
> -		snprintf(name, sizeof(name), "%s-%s::quality",
> -			 rt2x00dev->ops->name, phy_name);
> +		name = kasprintf(GFP_KERNEL, "%s-%s::quality",
> +				 rt2x00dev->ops->name, phy_name);
> +		if (!name) {
> +			retval = -ENOMEM;
> +			goto exit_fail;
> +		}
>  
>  		retval = rt2x00leds_register_led(rt2x00dev,
>  						 &rt2x00dev->led_qual,
> @@ -182,6 +196,8 @@ static void rt2x00leds_unregister_led(struct rt2x00_led *led)
>  		led->led_dev.brightness_set(&led->led_dev, LED_OFF);
>  
>  	led->flags &= ~LED_REGISTERED;
> +	kfree(led->led_dev.name);
> +	led->led_dev.name = NULL;
>  }
>  
>  void rt2x00leds_unregister(struct rt2x00_dev *rt2x00dev)
> -- 
> 2.54.0
> 

