Return-Path: <linux-wireless+bounces-33651-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACwsL8QCv2n9pAMAu9opvQ
	(envelope-from <linux-wireless+bounces-33651-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:42:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E652E7368
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 21:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB86301ABB8
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4336BCC4;
	Sat, 21 Mar 2026 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkIV+w5E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B135F604
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774125743; cv=none; b=uruHKr0QhggOIqKjydBUym9nnsFBit4bq1lKN6A6Ysp7gEqeTGSYE/1VFbjXI1/lA/r2yAICtFpzuJoS14BTG3QIIRiASdJnF7kJAbsW67drvaf5Ds0hVxYZW6Co6UFyph9QsY4jz36DZcdXZDirWh/9CpIWQCZ3pwDco4j0gps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774125743; c=relaxed/simple;
	bh=9Hvw3yUz+vYKVKOwbUPYHPFTvHz7/u6JH9+3GT1rRcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwAKGINY6PTvescXZm2uFvuFqPeR4172xOTOVep2heCr5iKjLANF3U9O+sWAMewSVP3CPrtInkiENHdkStCSnq/9Ky4fT8kcLQgc7Tj1lM1RG2JPzu95AqOIer5YWdEiSgvDNLeIFAOs0My//gKTUDZQjoCpgZWXPoYsSnjx9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkIV+w5E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso26978205e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774125740; x=1774730540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYPEnL2xoKtC1XUQmlMniWyz1D5/gbGHWd4efeidywQ=;
        b=hkIV+w5EEdItE96c3jrLb2QM+kCaIWwzQ83wA72LwzmzCN3q8PzvD7ZCq/zchJHY/L
         aucXBwa4Z5chdkNaWYyqPHqVIeQrVX+dvXTUxUAO6v736oR23tnaWcQ1UR8Dqm4EIJaP
         f6VvZz91MmczwPrZrh+3CS66Mg+Gt0LGpk3TSqGKfOzABHflBjvHdv9QZ83+CTvdj0nn
         +anM9JRFTL3YtxA6xUA1Qp2HVijmDYQHuR/13WyfiflRDQ2U62Bo/7/aRJhAZlgfHk6J
         RLG5V2/jHgZ7iyb1VxoHXXsZ6+OY0pPFRsfFark+b0557NfkRvjgQqxXt9b+IfrYTmNj
         PjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774125740; x=1774730540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYPEnL2xoKtC1XUQmlMniWyz1D5/gbGHWd4efeidywQ=;
        b=iUI9cOIBFQvJXBB7bsuDTPV6oasZtRhi375yNSxWN/JX+gNfeiEgvTuIjuRnLU/vW/
         VW2hvDPVWM0yWk0RriZxeQqP7RHh0GSd31izJjKkowN7WkIF6X9CqDVfLFZy7bPf+Jsj
         2IW7cfE7uqmIMyDEMX9P3cHoqJeQvE9o0JLE9YoGrrVxairj15x4Nc0cmQYm+/BAXNqF
         Om+1xUtmP0/S+eYAo4L6zQztgPtImokdKTvOsiYG6cveRhGaV63+h7cz7MFtGIjG3quU
         5oOz7i1lVyg7I01Xr4B81+Ahzwl1SDajUtPhu8Er9KJY6eCFMUGsRZZfNI/BvmqVR3ch
         mtSQ==
X-Gm-Message-State: AOJu0Yyu0KbKvM7WaVW2eb3Y0Omg5USjs0wg/ixN2zSZwp3aSfYB/yh7
	nN/eToAWMj/pQzx7qLsoxREqzM1NxCGiaqOZwPuO62CRJ2my9HoNsne5
X-Gm-Gg: ATEYQzw99bk8MKBptPTmL1C2OSJ5dLH6TlEjLODIiLIrqmhQxibe99Jr4v6868ufK8+
	UOnu2uBUEjnXE3Imet7+15h7xBGkxF88PkxoD7dtsj2xSvwKW2AeTB652e+Z42DZwIvj7ZaAhTB
	MW4TT+RjXkyyXU2vG2EI+ZkHWkUN1ub8j/mOXRO27dXwfsrAIqXqL6ljA68G5EhntD/9pzXeL17
	RmsIIdPSMtbecZPvjPD/DHlwbI1F5M1ick8cVB35eSWJ97xNEagg9X13BHGxYYnuhph5ollh9iB
	Mxk+Q2kCOaot0TV7fOFYxdxbjabfefUoP60MXEgITOYyJTC6yqEjAlWCFTac/Oxh7TgnXhUocWd
	M2qFXttofq+Wa8Kz1ZhyUezXwPHiI80M9qPaF9cew9U3mn7BBaFdwTSzS0hl7COWq9qibfNtdw7
	tvW+L8axbBdyhmw4+h1WH2hetVeRZKYySkhGFjU6vEX/BACeYFKNubvrx/20ceG7USQXJQl7485
	4KhZbZnzSAt0kUcP2ssMnLFiy5+TPGk
X-Received: by 2002:a05:600c:310d:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-486ff03db6fmr100597465e9.31.1774125739568;
        Sat, 21 Mar 2026 13:42:19 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e3a94sm169194155e9.7.2026.03.21.13.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:42:19 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w436Z-00000001Ol7-2xXq;
	Sat, 21 Mar 2026 21:42:13 +0100
Message-ID: <a92b853c-fc20-4c6e-b587-ffa8f0f66ba4@gmail.com>
Date: Sat, 21 Mar 2026 21:42:13 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] carl9170: main: add exponential restart backoff
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6C3933233D4272D36007C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6C3933233D4272D36007C9444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33651-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 27E652E7368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:38 AM, Masi Osmani wrote:
> When the AR9170 enters a bad state (firmware errors, command
> timeouts, TX queue stalls), the driver can trigger rapid-fire
> restarts that prevent the device from ever stabilizing.
> 
> Add exponential backoff to carl9170_restart(): if a restart
> request arrives before the current backoff window has elapsed,
> the request is throttled.  The backoff starts at 500 ms and
> doubles on each restart, capping at 30 seconds.  A successful
> restart resets the backoff to zero.


If this helps? It would be great if the device could get to "cool down"
instead of the restart request being throttled, after all something must
have happend for the restart request to be issued.

> 
> Additionally, use named constants for the firmware error
> threshold (CARL9170_FW_ERROR_THRESHOLD) instead of a magic
> number, and add a window-based counting approach to avoid
> accumulating sporadic errors over long uptimes.

I guess you are refering with "window-based counting" to the
CARL9170_FW_ERROR_WINDOW_MS ? But is it used anywhere?
Maybe part of the patch is missing, or is there another patch?

Otherwise, I would be inclined to test this out (in other words: ack it).

Cheers,
Christian

> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/carl9170.h |  2 ++
>   drivers/net/wireless/ath/carl9170/main.c     | 27 ++++++++++++++++++++
>   drivers/net/wireless/ath/carl9170/rx.c       | 10 +++++++-
>   3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/carl9170.h b/drivers/net/wireless/ath/carl9170/carl9170.h
> index a2ffa62..2eedb2f 100644
> --- a/drivers/net/wireless/ath/carl9170/carl9170.h
> +++ b/drivers/net/wireless/ath/carl9170/carl9170.h
> @@ -301,6 +301,8 @@ struct ar9170 {
>   	bool needs_full_reset;
>   	bool force_usb_reset;
>   	atomic_t pending_restarts;
> +	unsigned long last_restart_jiffies;
> +	unsigned int restart_backoff_ms;
>   
>   	/* interface mode settings */
>   	struct list_head vif_list;
> diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
> index dcedcb1..ebf9fa9 100644
> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -492,6 +492,7 @@ static void carl9170_restart_work(struct work_struct *work)
>   	if (!err && !ar->force_usb_reset) {
>   		ar->restart_counter++;
>   		atomic_set(&ar->pending_restarts, 0);
> +		ar->restart_backoff_ms = 0;
>   
>   		ieee80211_restart_hw(ar->hw);
>   	} else {
> @@ -505,6 +506,9 @@ static void carl9170_restart_work(struct work_struct *work)
>   	}
>   }
>   
> +#define CARL9170_RESTART_BACKOFF_INIT_MS	500
> +#define CARL9170_RESTART_BACKOFF_MAX_MS		30000
> +
>   void carl9170_restart(struct ar9170 *ar, const enum carl9170_restart_reasons r)
>   {
>   	carl9170_set_state_when(ar, CARL9170_STARTED, CARL9170_IDLE);
> @@ -519,6 +523,29 @@ void carl9170_restart(struct ar9170 *ar, const enum carl9170_restart_reasons r)
>   		return;
>   	}
>   
> +	/*
> +	 * Exponential backoff: if restarts are happening too frequently,
> +	 * increase the delay before accepting the next one.  This prevents
> +	 * restart storms when the device is in a bad state.
> +	 */
> +	if (ar->last_restart_jiffies &&
> +	    time_before(jiffies, ar->last_restart_jiffies +
> +			msecs_to_jiffies(ar->restart_backoff_ms))) {
> +		dev_warn(&ar->udev->dev,
> +			 "restart (%d) throttled (backoff %u ms)\n",
> +			 r, ar->restart_backoff_ms);
> +		atomic_dec(&ar->pending_restarts);
> +		return;
> +	}
> +
> +	ar->last_restart_jiffies = jiffies;
> +	if (ar->restart_backoff_ms == 0)
> +		ar->restart_backoff_ms = CARL9170_RESTART_BACKOFF_INIT_MS;
> +	else
> +		ar->restart_backoff_ms = min(ar->restart_backoff_ms * 2,
> +					     (unsigned int)
> +					     CARL9170_RESTART_BACKOFF_MAX_MS);
> +
>   	ieee80211_stop_queues(ar->hw);
>   
>   	dev_err(&ar->udev->dev, "restart device (%d)\n", r);
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 414d499..bb909b5 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -46,6 +46,14 @@
>   #include "hw.h"
>   #include "cmd.h"
>   
> +/*
> + * Time window for firmware error counting.  Sporadic errors are
> + * normal over long uptimes; only a burst of errors within a short
> + * window warrants a restart.
> + */
> +#define CARL9170_FW_ERROR_WINDOW_MS	10000

This CARL9170_FW_ERROR_WINDOW_MS isn't used anywhere?

> +#define CARL9170_FW_ERROR_THRESHOLD	3
> +
>   static void carl9170_dbg_message(struct ar9170 *ar, const char *buf, u32 len)
>   {
>   	bool restart = false;
> @@ -54,7 +62,7 @@ static void carl9170_dbg_message(struct ar9170 *ar, const char *buf, u32 len)
>   	if (len > 3) {
>   		if (memcmp(buf, CARL9170_ERR_MAGIC, 3) == 0) {
>   			ar->fw.err_counter++;
> -			if (ar->fw.err_counter > 3) {
> +			if (ar->fw.err_counter >= CARL9170_FW_ERROR_THRESHOLD) {

 > then vs >= now. You could update CARL9170_FW_ERROR_THRESHOLD to 4 to match the "previous" behavior.
But no, this is neither here nor there.

>   				restart = true;
>   				reason = CARL9170_RR_TOO_MANY_FIRMWARE_ERRORS;
>   			}


