Return-Path: <linux-wireless+bounces-39079-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wh+kHglWVmpz3gAAu9opvQ
	(envelope-from <linux-wireless+bounces-39079-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:30:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDAA756735
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:30:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R53fNbg8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39079-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39079-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A59BA304C900
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A226635E952;
	Tue, 14 Jul 2026 15:23:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EC47DF9C
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 15:23:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042588; cv=none; b=u549r0j+nmamQT6iaHxwCmLRZjxzUd+8IeZwo+a3hy1d4Akpndm8KhcZ6U01keFiF7FMsq9ASghhEv9USBFnF3qZ0sHzmS+5cUfYFND646Iu+VvVfaVu3+c9/dDaF2UPWFXdTlCbkbrn8Sb25lyEefPOCdhS8J0XzzCSjglnfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042588; c=relaxed/simple;
	bh=pP3RuGJEOJYMGueBByoBF8Qd1tVMJ/RQr3Wk9VJA1nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfj83rW0LdsVEpVsOnz4JshyWcN+szPU4QCtm9S3GYAYChkukeSYWLNW0AOidEdEJhBNmmwpg9Qojt4J3Xmekx4AWQe0lmm0o4lpB17umr3djvxwfrtt1EmIY1gHHfhX9ThFrhkl3Rsg4jy/2+mWcZF/dDnu2bczb2o9Bi6ayeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R53fNbg8; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so37819885e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784042585; x=1784647385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hjqr0KeiKvdS+CWD8xOUQjQsATKLi76iMcacJPH1zto=;
        b=R53fNbg8QH1SDxOJ16i8qkizUuvrAmOG4UcjDziUrYnP5LGzigvBP7Mlc/vBzv/aIl
         knWKLEc63TEIl7NJZsDFL0VxvCmXs/z5Mh9U7muGRJ+NTh6eByM8o+H84ZSGQ7SzLidz
         xRf9kIqH3l95CFlslQ9vmqN79FC3JY+loNrrIIKFxSfbTkXJUPHxrRcxSiKm0FtH5zF9
         Yjt1a8+1SuoLvZU8RbTAHe8sdhDWf0F6CRVWUVlmsUSldXJBuoIyD0HBhc0fgT7Ugb0A
         iip5ZdJ8F3vbmTtl0HEriCOfytf5FolytN++LZlGRGtnhRCiAF7geyMK8dR4VanAwpoh
         EeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042585; x=1784647385;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hjqr0KeiKvdS+CWD8xOUQjQsATKLi76iMcacJPH1zto=;
        b=a1Xtfuuey38C33qjFpFtMCZQdI5nYryl6ddxPxaOP8W72stloh2TOyg3WY0iMn0Z5X
         PYN4qG1arsinSxc07N8o7FkrSYXSfMHLOTPB4zEE/FdOkJ48BO1ve+6K28hK3KnCPzgC
         4VHE4FYqTfJzA23vLo1UgILtoRPWKVFBD2/5zrqDx1a19Xl1tkZ9/SxNEUJkQTURv/uG
         WrlPfkL4nYCWPp6kTy2dsS/tlch57obVxhsVJVkL/OwG9gMeVFTK4k2e36XUNxUKKD1z
         LW7xsP97O7XT88W0hsXUrHWMpYgHNJs8Q6tFasae9wyu6A/YtPdZO1IvNOd5Bd3FfQsb
         ec6g==
X-Gm-Message-State: AOJu0YxdjRRAk8pBCEUmtuuAQp2tfhcqC6ya6b2L91HlngLaaoU+qd2Q
	Ygae4rFBOdCqBQyvTwKa7V81dyjUKzUpcx4MIWAJEP231a37Fnj9jM0hb58meg==
X-Gm-Gg: AfdE7cn9v3+CJGi9+XTmd0in1JT78QWZIFiKOaL22HFlPq2JBmc5CCw1z39jTwX2rWE
	nlyssFzX8/Q22CayEZxke+weX3b8Pgqn0O/uiuE8KgQauUj0PQlrrUI/TEImwzSaRUEyBF7J60N
	lzYVVQtV2hvkOuOISk+QYoMXfrfCzxgOS8JwGRs5ZaT3/e32mxP8UgZCIM/W7f0iqTQb+U5n4tP
	Y/B6FtQB2nNMUZvi3/Bs8UIiAMVz1nnpDqIAa0JeIS0hiC/n110Bfv4RpO0ysXfTfAI9IVfGoiq
	//PHDbAWX1xE5o5dsgQ1XYZWl40/gE4E3APBfMxJbsIilScNtfdyI1YdFGb9ZfpejUqYrIg7dhv
	EoKqJikQFP9AsYcLNRTFjCW87CjBzQhnE8LFErXzha/wSfyIIFZ+qbc2+sAtLkc73qn/jRxFQpC
	8Hsl/EO/9Rsjlok5mYY9H9
X-Received: by 2002:a05:600c:c4ab:b0:493:a960:a0bf with SMTP id 5b1f17b1804b1-495389bcc4dmr34160385e9.21.1784042584970;
        Tue, 14 Jul 2026 08:23:04 -0700 (PDT)
Received: from [192.168.1.50] ([79.118.68.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f86556acsm248747635e9.1.2026.07.14.08.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 08:23:04 -0700 (PDT)
Message-ID: <af31a567-ad40-4bbd-85db-4b6242680423@gmail.com>
Date: Tue, 14 Jul 2026 18:23:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: nurofen55@meta.ua, pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org
References: <44184.185.179.215.97.1784041719.metamail@mail.meta.ua>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <44184.185.179.215.97.1784041719.metamail@mail.meta.ua>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39079-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nurofen55@meta.ua,m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[meta.ua,realtek.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.ua:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDDAA756735

On 14/07/2026 18:08, nurofen55@meta.ua wrote:
> Hi Ping-Ke,
> Thank you for the quick and insightful analysis!
> Here are the results from your suggestions:
> 1. Firmware Check:
> 
> You were absolutely right. I ran `dmesg | grep -i rtw89` on the 7.1.x kernel, and it confirmed that it is indeed loading the new v2 firmware:
> 
> rtw89_8852be 0000:02:00.0: loaded firmware rtw89/rtw8852b_fw-2.bin
> 
> Firmware version 0.29.29.18 (9e3d777f)
> 2. Power Save Test:
> 
> I identified my interface as wlp2s0 and completely disabled power saving:
> 
> sudo iw dev wlp2s0 set power_save off
> 
> Unfortunately, this did not improve the 2.4GHz stability; the intermittent packet loss and high latency spikes still persist under the same conditions.
> 3. Testing Nearby the AP:
> 
> Moving the laptop closer to the router (stronger signal) slightly mitigates the frequency of the drops, but the latency spikes still occur randomly on 2.4GHz, whereas 5GHz remains flawlessly stable.
> Since I am on openSUSE Tumbleweed (a rolling release distribution) and use it for my daily hospital workflow, compiling a custom kernel to manually apply patch 63ccdfac8677 is quite problematic for me at the moment.
> Given that commit 63ccdfac8677 fixes the exact AMPDU drop logic bug introduced in 7.0, it sounds like the perfect candidate to resolve this. Could you please queue this fix for inclusion into the upstream 7.1.x stable kernel tree? Once it is merged there, the openSUSE maintainers will pull it automatically, and I will gladly test the updated repository kernel to confirm the fix!
> Best regards,
> 
> Svyatoslav
> 
> 

Hi,

That patch is already queued for 7.1:

https://lore.kernel.org/stable/20260712105304.agent5-0001@kernel.org/

