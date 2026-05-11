Return-Path: <linux-wireless+bounces-36259-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKwVHz0fAmqloAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36259-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:26:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD71951460C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 20:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BFBC30D8813
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46647AF61;
	Mon, 11 May 2026 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLZzgBI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CF37A494
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523281; cv=none; b=C60USF3LwUjPX+J2uiagPAgpqtCpQ1/hf2CzJVBT4fs6CGVNT0rA7wp3pQFr3ApYnshnX59KOPVfPMCY3pS13YP97X1IyBISO4lSLvqJVx8HcgoXq1sj8KG8cgqiGDXVcUV8IuraciCRLpR9iUEoQlkoGexUQVq2xARJG3mC1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523281; c=relaxed/simple;
	bh=M7y8d+ewhVaZ762+P18JmMhtV/4Or+AW8PguEo8GasI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPVjZyPIcL9E+mknYdEbpAU8agQRjYTNH4Crpmiq5BJN3iQMxGvMIby5hdod2sxnPasnaNVwW7x6AXZReNqJ3VLvz5e9kcWOOju2IdhUvqDdM612ICxMFdwCF3gtcyFnatEWbGKdWjo89zjuPkT69hS3n9FBbvJB/HKiqfKAGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLZzgBI+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44a14580111so3409218f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523278; x=1779128078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0uzosvprbfI3xU6tZxgwhc5c0UNuG1K2cj973x8GOI=;
        b=SLZzgBI+5hz8W2uQXjBkMqTFE9Ggs3yhStBZWhT6bcmXtjBTTUs5m4OYk0l7qnoK7B
         1NVOOflHuJJx9LUQfVyNlXGG0qQtLUquvrKt7NJUmnfXVut/sVyaWZsnJ0Aeh2hlGNGP
         JPl/ON4vFjsdgrMCwDdx+mm3v0AjvxuYIYBb68YgfHHg7crlUfbuN/m1BLWdVBnVdsjQ
         8aD4OywNh4oPy1VYQJXzrvTYLKDPxNDU9GBbQK5YDOJrloHAEtAYV/5hkIV1rayDaxe+
         YSM8jG1ULPKWNtabK4Uk1rXqDnHLbdQhijj4Yv4yyu6fBBD077YInLre5dF/2fFEJWhd
         9RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523278; x=1779128078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0uzosvprbfI3xU6tZxgwhc5c0UNuG1K2cj973x8GOI=;
        b=DZuW90qCqrCEDjY+vmKxCz7+yqd1LnNR2YeZV7bvNOpV24v/mHuFo5gh9SXrm+3JDA
         qdahmTATizANpzI/pqeTJH06DDy2DcxjDNmKePjvDae9Jlu4haE3BZUtvhr6mpRwngze
         9+VCQO23GTYEpI6FiI0RIqDEITShz28TnYAm4lAsrfSu4t/0Fpawz2zJI3GkBTJsqhQ5
         WGogJwNg7XQjHrSaQONGyZkS/RTP5ZeQInwKY/bxSoIIhvKwclDZqO0ji/aaSXjrcxos
         tDFu8L0zryEzYO6XRcw5a4B9r1zdsaqG7LsGi5ZVCsTJjX5RLCRGjF9D59jeN6C5mbLl
         5orA==
X-Forwarded-Encrypted: i=1; AFNElJ9CvVcj3oHIld3giPHjKKO9mbEIEBCpm2azD0UagVLZulmw/yysVMx3664pg+y02TzidplkMT1Z/uzm1m01oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySAgffcCtj15Nlhu/RQPCXaWFUx1MC5DQkdg65Tgwi40R60HeU
	+BVIKT92u9MzF/1LbTmvnLCaZ1/GQzCXIC4bhvDW0vhmoMuvfcJnWrW8
X-Gm-Gg: Acq92OF+grYs4UQlsFuLrfDgBkoR3ZMbz6sra2eUo4y1E2S3ANcPAjF60+gvgujCh4b
	//s6N/nYZS/4EBACBBcx+tpmxUNabe8wHRLNYVjlzmGeHGisrC+k4tO1YsT0pbbVo+cEWhKZ/VQ
	fgxbBhj13+K78UHEA5/8GKze2cROoibZ59acQJVaP482dLRbAEzcDVbvmWbxSpLYSiBkIATUZnQ
	33GikfjbfXxxn6kczcg8+gs5TyvYHvvtpFf5Izx+C2MOIxLTQk95ZlFTbGxNFvNTRrwfOpBcx4O
	GCQTq4TkpfKgjyKt0pSHZzycC3HMF99LJU87M64WenWgLEZo1eQUcrkZ9wrzpj3Ajogb/pQLDqd
	vJcM+ffytiKPWm8UWpDTIeWJes+94gVZfzFszt5osJqEodbUGy0OK78dr1SRDxgSTP/x+TrA7hB
	FVxGOrI7MNAPth8G+Kqk4FozVeupLFSg==
X-Received: by 2002:a05:6000:4027:b0:454:4472:6234 with SMTP id ffacd0b85a97d-45444726351mr24306076f8f.1.1778523277521;
        Mon, 11 May 2026 11:14:37 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-458b3664e3esm11484900f8f.3.2026.05.11.11.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 11:14:37 -0700 (PDT)
Message-ID: <639b2f23-bff3-400f-b5ef-e7d0c39196bc@gmail.com>
Date: Mon, 11 May 2026 21:14:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to
 USB 3 mode
To: Devin Wittmayer <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com, linux-kernel@vger.kernel.org
References: <20260508054421.128938-1-lucid_duck@justthetip.ca>
 <20260511160811.17647-1-lucid_duck@justthetip.ca>
 <20260511160811.17647-2-lucid_duck@justthetip.ca>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260511160811.17647-2-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD71951460C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36259-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email]
X-Rspamd-Action: no action

On 11/05/2026 19:08, Devin Wittmayer wrote:
> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> The Realtek wifi 6/7 devices which support USB 3 are weird: when first
> plugged in, they pretend to be USB 2. The driver needs to send some
> commands to the device, which make it disappear and come back as a
> USB 3 device.
> 
> Implement the required commands in rtw89.
> 
> When a USB 3 device is plugged into a USB 2 port, rtw89 will try to
> switch it to USB 3 mode only once. The device will disappear and come
> back still in USB 2 mode, of course.
> 
> Some people experience heavy interference in the 2.4 GHz band in
> USB 3 mode, so add a module parameter switch_usb_mode with the
> default value 1 to let people disable the switching.
> 
> Tested with RTL8832BU and RTL8832CU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>

Are you quite sure you tested this?

> ---
>  drivers/net/wireless/realtek/rtw89/reg.h |  4 +++
>  drivers/net/wireless/realtek/rtw89/usb.c | 41 ++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
> index 42ffe83931a3..7d4c085d9fb2 100644
> --- a/drivers/net/wireless/realtek/rtw89/reg.h
> +++ b/drivers/net/wireless/realtek/rtw89/reg.h
> @@ -164,6 +164,10 @@
>  #define R_AX_DBG_PORT_SEL 0x00C0
>  #define B_AX_DEBUG_ST_MASK GENMASK(31, 0)
>  
> +#define R_AX_PAD_CTRL2 0x00C4
> +#define U2SWITCHU3 0xB
> +#define USB_SWITCH_DELAY 0xF
> +
>  #define R_AX_PMC_DBG_CTRL2 0x00CC
>  #define B_AX_SYSON_DIS_PMCR_AX_WRMSK BIT(2)
>  
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
> index 767a95f759b1..4fb25791d118 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -9,6 +9,11 @@
>  #include "txrx.h"
>  #include "usb.h"
>  
> +static bool rtw89_switch_usb_mode = true;
> +module_param_named(switch_usb_mode, rtw89_switch_usb_mode, bool, 0644);
> +MODULE_PARM_DESC(switch_usb_mode,
> +		 "Set to N to disable switching to USB 3 mode to avoid potential interference in the 2.4 GHz band (default: Y)");
> +
>  static void rtw89_usb_read_port_complete(struct urb *urb);
>  
>  static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
> @@ -1027,6 +1032,35 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
>  	usb_set_intfdata(intf, NULL);
>  }
>  
> +static int rtw89_usb_switch_mode(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
> +
> +	if (!rtw89_switch_usb_mode)
> +		return 0;
> +
> +	/* No known USB 3 devices with this chip. */
> +	if (rtwdev->chip->chip_id == RTL8851B)
> +		return 0;
> +
> +	if (rtwusb->udev->speed == USB_SPEED_SUPER)
> +		return 0;
> +
> +	rtw89_debug(rtwdev, RTW89_DBG_HCI, "%s: pad_ctrl2: %#x %#x\n",
> +		    __func__,
> +		    rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 1),
> +		    rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 2));
> +
> +	/* Already tried to switch but it's a USB 2 port. */
> +	if (rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 1) == USB_SWITCH_DELAY)
> +		return 0;
> +
> +	rtw89_write8(rtwdev, R_AX_PAD_CTRL2 + 1, USB_SWITCH_DELAY);
> +	rtw89_write8(rtwdev, R_AX_PAD_CTRL2 + 2, U2SWITCHU3);
> +
> +	return 1;
> +}
> +
>  int rtw89_usb_probe(struct usb_interface *intf,
>  		    const struct usb_device_id *id)
>  {
> @@ -1059,6 +1093,13 @@ int rtw89_usb_probe(struct usb_interface *intf,
>  		goto err_free_hw;
>  	}
>  
> +	ret = rtw89_usb_switch_mode(rtwdev);
> +	if (ret) {
> +		/* Not a fail, but we do need to skip rtw89_core_register. */
> +		ret = 0;
> +		goto err_intf_deinit;
> +	}
> +
>  	if (rtwusb->udev->speed == USB_SPEED_SUPER)
>  		rtwdev->hci.dle_type = RTW89_HCI_DLE_TYPE_USB3;
>  	else


