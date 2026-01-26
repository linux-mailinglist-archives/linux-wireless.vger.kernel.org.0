Return-Path: <linux-wireless+bounces-31179-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFCRFtx1d2n7ggEAu9opvQ
	(envelope-from <linux-wireless+bounces-31179-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 15:10:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A600B89563
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A900301B720
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC333C191;
	Mon, 26 Jan 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4NsjtII"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C491850A4
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436605; cv=none; b=uEHsWFUmfkMfscJnk08myu9h+9yn81hpHMoSUbEN4CgBi37RM4VhejPiVbO8eohNF1BGXx49wmGJPlai/Cg/vVnYgVLya1igSVJfxXpfgRxayR9WXxphCx9ZoDo81h7ORuXXBW/QLd7V7Ps2ewTwCB2rNq1bh3OtGNJgL7OstIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436605; c=relaxed/simple;
	bh=avMQ3R/SqvADmbBgZIZeinmK8WYBHIqwH+snCaDD4xQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i+cpz/196b2WUQSo0I8stcNf0upUuHTHxj+jzknhflehTdNV0scgq+LD1sU2Zd4GMtLEM3v4bR3L0B9u/68GgO9jA5l+GzkbDoYzrbyqEdGEBrmtND2cucv4k0vNYMdQJuv+RtMUUQvGX5rrOCHfAI9pIdac55X22LS9IbwVLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4NsjtII; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb5810d39so2917762f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769436602; x=1770041402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1HnPYljvlRkBiLtNly4RebMWdtENssz7l4anKGP0ins=;
        b=Z4NsjtIIKjDwLJ4zHZkG4kbdsrFSTf1tpZCq3GuWiZn+XoCltafwQ+w3FcNn1/GBgo
         Z9Vqnc0euTJDHdlc1+Pvy1yL/Vy4UbjifMNyY4/2VYZPQsKE8IJ1lL2Ks0fFfd7Mwohq
         i/c9Z9bOEFQpCR+rwCYGjifLoLQ3rqcwaRUrR5EXdNiBVRhcTHtYFRiK9LnwWsqKhFqu
         SBUFYIsP9eQx1XoJ6bE/YIp0d3m+JGXE/upgrsx/QnzCRc2Z7Q1Pdovgl+Yqs9P8xSnO
         7/Fw8CcwVohXkEK3YCjPZbiyCi2qHW+CNnfwBnRBccZL20fxPIIopNdTjKnNz/O9stoe
         OKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769436602; x=1770041402;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HnPYljvlRkBiLtNly4RebMWdtENssz7l4anKGP0ins=;
        b=VTZrdPkPkKqC8XBZW/fMzc0s5hTCmRiR/IPcnphM/xDjIesOgeovXs4RExkC2hcxi3
         XkE3zO9jj2jdZqCEhc/p12hIP49HHhwWDGu/SpOlacNdOnDM2HnzgfM10xVrBffrlxSC
         y6uNoRp4UEag7jYn8cruta/jxegzZE2yxzuJcMTnNO9uQzSUc7n3ogBVGLoludP20Tpn
         2fPU9ae3dgHP+jvQZChjnUwkkFs8kcYtt8V90jRHmIfj5LY/fFxinz4Al2Q4p7BAL0QE
         zdaQNbZBlRRktNedt7e18nwZnfb+UHX0BiXF/92tXZLLqDWCuBzWSAmfJk0JozLr9aLi
         5Fhg==
X-Forwarded-Encrypted: i=1; AJvYcCULBsbopB4LWOPgKMZV+7pVZB1PxogD+Ta1XJrsxOosTBFLUi5jB3cXhL/TE8E/W2g2Bq1+uM9RkSNiaghcYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYF+z9/bYufU/NgtLemA7ySYFf5IfOlnrRPxN8vsDeOMn2mEFV
	IqcS7ilpcW5/F+oLsXQYt1WUds9j3eq4T9QWbETrQsWi21vV8AI2XeVH
X-Gm-Gg: AZuq6aLId3gvSn68smJJRvrSeRgq1J0ZZFCE7jAjZPh/yLqznCYBuiYMv+2xbXofFpN
	5ssOObyEcP6RUWzEWMJihc5FQyjTsTYuw9EewcKUDL0Azdu6OluhIMUifaW4kpdICdSCnPz1zbB
	yHcanG0r6WGKfPBLP+5Li8rnWFjRyd4CigqRdztaag1afdZWnyOdxewz+Wyn72EaGwtdfATCHzH
	QuhQ4JmxAPmL3Yr5mLM6cAVfRS8t6RGdWvjIe4vgv+Um1rezfZZ36p3XmfX5FPepx68Rw30N2Vx
	zcv/mUDAqnNZMGpL5UG6GDIv9iFbtNvZ7HEesnvM+HtPHV1Irp1epUnsGJZ+tAaVfpJsxEaRy1r
	emhvz9ZiwrkEJZVzw+8jS3xaqtN/dV9e2hsJrk9MfN1pMDxeqi5kAS2qFCrXQrs29/2TgXnJyBz
	SUPPo3G/CUOVr7RHOf5A==
X-Received: by 2002:a05:6000:178f:b0:432:8537:85ca with SMTP id ffacd0b85a97d-435ca198cd4mr7264809f8f.50.1769436601969;
        Mon, 26 Jan 2026 06:10:01 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02cd8sm29021538f8f.8.2026.01.26.06.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 06:10:01 -0800 (PST)
Message-ID: <471ce67a-8633-46f3-882e-6051ab022a7e@gmail.com>
Date: Mon, 26 Jan 2026 16:09:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtw89: usb: fix TX flow control by tracking
 in-flight URBs
To: Lucid Duck <lucid_duck@justthetip.ca>, linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <20260125221943.36001-1-lucid_duck@justthetip.ca>
Content-Language: en-US
In-Reply-To: <20260125221943.36001-1-lucid_duck@justthetip.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31179-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:email]
X-Rspamd-Queue-Id: A600B89563
X-Rspamd-Action: no action

On 26/01/2026 00:19, Lucid Duck wrote:
> rtw89_usb_ops_check_and_reclaim_tx_resource() currently returns a
> hardcoded placeholder value of 42, violating mac80211's TX flow control
> contract. This causes uncontrolled URB accumulation under sustained TX
> load since mac80211 believes resources are always available.
> 
> Fix this by implementing proper TX backpressure:
> 
> - Add per-channel atomic counters (tx_inflight[]) to track URBs between
>   submission and completion
> - Increment counter before usb_submit_urb() with rollback on failure
> - Decrement counter in completion callback
> - Return available slots (max - inflight) to mac80211, or 0 at capacity
> - Exclude firmware command channel (CH12) from flow control
> 
> Tested on D-Link DWA-X1850 (RTL8832AU) with:
> - Sustained high-throughput traffic
> - Module load/unload stress tests
> - Hot-unplug during active transmission
> - 30-minute soak test verifying counters balance at idle
> 
> Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
> ---
>  drivers/net/wireless/realtek/rtw89/usb.c | 27 ++++++++++++++++++++++--
>  drivers/net/wireless/realtek/rtw89/usb.h |  6 ++++++
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
> index e77561a4d..6fcf32603 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -161,16 +161,25 @@ static u32
>  rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
>  					    u8 txch)
>  {
> +	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
> +	int inflight;
> +
> +	/* Firmware command channel is not flow-controlled */
>  	if (txch == RTW89_TXCH_CH12)
>  		return 1;
>  
> -	return 42; /* TODO some kind of calculation? */
> +	inflight = atomic_read(&rtwusb->tx_inflight[txch]);
> +	if (inflight >= RTW89_USB_MAX_TX_URBS_PER_CH)
> +		return 0;
> +
> +	return RTW89_USB_MAX_TX_URBS_PER_CH - inflight;
>  }
>  
>  static void rtw89_usb_write_port_complete(struct urb *urb)
>  {
>  	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
>  	struct rtw89_dev *rtwdev = txcb->rtwdev;
> +	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
>  	struct ieee80211_tx_info *info;
>  	struct rtw89_txwd_body *txdesc;
>  	struct sk_buff *skb;
> @@ -229,6 +238,10 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
>  		break;
>  	}
>  
> +	/* Decrement in-flight counter (skip firmware command channel) */
> +	if (txcb->txch != RTW89_TXCH_CH12)

You don't need to add these checks because there is one in
rtw89_usb_ops_check_and_reclaim_tx_resource().

> +		atomic_dec(&rtwusb->tx_inflight[txcb->txch]);
> +
>  	kfree(txcb);
>  }
>  
> @@ -306,9 +319,17 @@ static void rtw89_usb_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
>  
>  		skb_queue_tail(&txcb->tx_ack_queue, skb);
>  
> +		/* Increment BEFORE submit to avoid race with completion */
> +		if (txch != RTW89_TXCH_CH12)
> +			atomic_inc(&rtwusb->tx_inflight[txch]);
> +
>  		ret = rtw89_usb_write_port(rtwdev, txch, skb->data, skb->len,
>  					   txcb);
>  		if (ret) {
> +			/* Rollback increment on failure */
> +			if (txch != RTW89_TXCH_CH12)
> +				atomic_dec(&rtwusb->tx_inflight[txch]);
> +
>  			if (ret != -ENODEV)
>  				rtw89_err(rtwdev, "write port txch %d failed: %d\n",
>  					  txch, ret);
> @@ -666,8 +687,10 @@ static void rtw89_usb_init_tx(struct rtw89_dev *rtwdev)
>  	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++)
> +	for (i = 0; i < ARRAY_SIZE(rtwusb->tx_queue); i++) {
>  		skb_queue_head_init(&rtwusb->tx_queue[i]);
> +		atomic_set(&rtwusb->tx_inflight[i], 0);
> +	}
>  }
>  
>  static void rtw89_usb_deinit_tx(struct rtw89_dev *rtwdev)
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
> index 203ec8e99..f72a8b1b2 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.h
> +++ b/drivers/net/wireless/realtek/rtw89/usb.h
> @@ -20,6 +20,9 @@
>  #define RTW89_MAX_ENDPOINT_NUM		9
>  #define RTW89_MAX_BULKOUT_NUM		7
>  
> +/* TX flow control: max in-flight URBs per channel */
> +#define RTW89_USB_MAX_TX_URBS_PER_CH	32
> +
>  struct rtw89_usb_info {
>  	u32 usb_host_request_2;
>  	u32 usb_wlan0_1;
> @@ -63,6 +66,9 @@ struct rtw89_usb {
>  	struct usb_anchor tx_submitted;
>  
>  	struct sk_buff_head tx_queue[RTW89_TXCH_NUM];
> +
> +	/* TX flow control: track in-flight URBs per channel */
> +	atomic_t tx_inflight[RTW89_TXCH_NUM];

Is there a reason to add a new counter instead of just using
the length of each tx_queue?

>  };
>  
>  static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)


