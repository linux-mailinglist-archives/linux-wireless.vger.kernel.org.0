Return-Path: <linux-wireless+bounces-35759-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBIUGnX+9GkiHAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35759-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 21:26:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A73F4AF23C
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 21:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DA7A3001F91
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1283209F43;
	Fri,  1 May 2026 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPAaRvsg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308841C311
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777663598; cv=none; b=qvAf2mBdzEOSqV4Oy5C7tqYDRgIo6GcyCLBNrn3r8e3IUpsrqtwJ9APjp2Wz5xBqfwjlWMvdOhMdkK4+rMa9qCDT3eWZ6Sbs4E41J8h6fLyemJKZpPI10b8dUHVEmhcAgPbsU1w4mtCKPdL3rnCVEtYW3JcPl1a90ootg0gNq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777663598; c=relaxed/simple;
	bh=HVuL/IZWSvdhZZkkQXpKjZZJIBtOavjaVaByvGXjaNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTsBOLiGlBK+vdUip3Qbl9K6T59eHMdWvjBEWoQKD8BPRDOE12BCVoPtfnRFxnPeCAQR6saGyWW7QL31gMsCkpRSqoa+VpWnC8npzmfArWhbN4mpvYleyNtnFwLLkCdR6zoldSFPl9UHL5Jx1L3otfUEMjEker7nTUSJpy2xvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPAaRvsg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so17846975e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 01 May 2026 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777663595; x=1778268395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KV4kSIiY3A3IMB/1Fwk7IrL1FCT6zTF9wEUbB3puRYM=;
        b=JPAaRvsgOtvGbrYyebgx78TvF8ih67ZpLcmLCmJWdopIkeqsKViuOKqY0nbQSks19V
         slY93ogWrYgxQuYMgfAKxbWgC2WtfOfVxxxkQyeqKTqwTF7h9qGXrN8o+y/Q6crpfq7c
         Ubd90S49aCVaDv9OhhMUfMaoypeNSv2KmUAJUfSpK4sj90pR7+vGz6DSzCQd1px9pAdw
         RdNlN1G0M1MUX8UayEslQH7ec6h3A+OgKWV8zuQ+FZWFMuZUnXFl1VnKDmxAMyPp2stf
         1MkVoENA19u54FylkFVTqadnws64kewGdLEcWXFnyU5aeLrAK16zE4CDiEBjaoyETfL4
         WZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777663595; x=1778268395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV4kSIiY3A3IMB/1Fwk7IrL1FCT6zTF9wEUbB3puRYM=;
        b=L8Ia3zFAMrqXls7Im3Xa5oxd/96JnwEtP5KMCklFzY0x6HeqR1ln4tMUGfnkknigat
         BvrZ4vpB/3xecpEexFXLNQh4ZjVToak7LfBrdoXhOOAJKgobVuZiyfqCDosffXsQuHu6
         rLz313JLExGiaaBil5mns7xw01jLRSCAjDfwSxyJOACpYCtH5wuJBQzTuTdO6eWlKnvl
         h6xj7tjRaJkMN4QSVNJupw1Ugvkf0uYkCdMV4naDksBG1EeNhcqOoGZw+gCBPz7wfXi3
         LpsvkwuOHiHSNhCQ9PfArT1m5yxoRvNgo5az6n4ywQDnKPb2toWWOegx6RkTEKbqXKxy
         XhDg==
X-Forwarded-Encrypted: i=1; AFNElJ8u0nK8SuTLvEiE9Cp4w6mlnj6Azc8fHP6LafpWAKAt9V8202Ay6v2xAIvelxOzlODa2IfaOkvHUnpc3gO/fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80ZTX8N03qgbUJKFIZi/WJiH8QAjBEpef3l9cAQSGhYwxSHoL
	lAqGLBqfG1BlrDQWQrRdTffhgkqIES/oOJgB+7pVJ1m7yV0ol68J3pAe
X-Gm-Gg: AeBDietuIgZeKyknGFOmIqmNnDLPznBhOaWua1qMm+l2K366VsWw6Y/58aHab2mBwOy
	kWAFDq9RpuJ1LF6RlvI5V0i0yFTXQ+/dJ0diforARk9qcocw8OlgV1SYqZunxEzpSTzTGtn2hVw
	sSdqAH1JacMwuhKKkPECOn3ykP67ytSTwptl75wCKXfdX9eXxcroZkwSvXJftALwLZ+m7E7NT0E
	sN5vTd+/csk4RtjqtBDm4BicWeGzB0kx5A4SnVup9DcLuFW6v5ZA04ulJvsRL3N2w242Pl8VW4f
	HoPbcIVQB39wgTknprBGW1cloku8bipdyWGosLLxaurYmcYJcDeQkOXnABNgTvoAbIUi9ppZsg/
	VwysadZ5fLsPbmDoFS10MOhoVSSUupOeCygKMKWKPuZeOOdX1tQ6t9IGuVZ/ZmoX5NJpCd+jOcR
	x5leTuWdw+9hhRrsP4QEHLRTzyc5V2yi3OoVCbw5NmFcrULsyfikg=
X-Received: by 2002:a05:600c:698d:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48a9866e8a5mr6571995e9.24.1777663594868;
        Fri, 01 May 2026 12:26:34 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm171686915e9.14.2026.05.01.12.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 12:26:34 -0700 (PDT)
Message-ID: <72f6fffd-bd77-437f-a9d9-6a542a8b365b@gmail.com>
Date: Fri, 1 May 2026 22:26:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: increase TX report timeout to fix race
 condition
To: luka.gejak@linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>,
 Brian Norris <briannorris@chromium.org>,
 Stanislaw Gruszka <sgruszka@redhat.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260501150402.227788-1-luka.gejak@linux.dev>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260501150402.227788-1-luka.gejak@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8A73F4AF23C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35759-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 01/05/2026 18:04, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> The driver expects the firmware to report TX status within 500ms.
> However, a race condition exists when the hardware is under heavy TX
> load and is simultaneously interrupted by background scans or
> power-saving state transitions. During these events, the firmware may
> go off-channel for longer than 500ms, delaying the TX reports.
> 

But power saving state transitions should not happen during heavy TX load.

> When this happens, the purge timer fires prematurely, dropping the
> tracking skbs from the queue and spamming the kernel log with:
> "failed to get tx report from firmware". Dropping these tracking skbs
> prevents the driver from reporting TX status back to mac80211, which
> breaks rate control accounting and degrades performance.
> 

But mac80211 doesn't handle rate control for these chips. How much does
performance degrade?

> Increase RTW_TX_PROBE_TIMEOUT to 2500ms. This timeout is large enough
> to comfortably accommodate the duration of full WiFi background scans
> and sleep transitions without incorrectly tripping the purge timer,
> while still eventually catching true firmware lockups.
> 

rtw88 supports many chips. Which one are you using?

Perhaps provide a full description of the problem you encountered.

> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Cc: stable@vger.kernel.org
> Tested-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  drivers/net/wireless/realtek/rtw88/tx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
> index d34cdeca16f1..95d15e4f5d34 100644
> --- a/drivers/net/wireless/realtek/rtw88/tx.h
> +++ b/drivers/net/wireless/realtek/rtw88/tx.h
> @@ -7,7 +7,7 @@
>  
>  #define RTK_TX_MAX_AGG_NUM_MASK		0x1f
>  
> -#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(500)
> +#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(2500)
>  
>  struct rtw_tx_desc {
>  	__le32 w0;


