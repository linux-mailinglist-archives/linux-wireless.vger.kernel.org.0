Return-Path: <linux-wireless+bounces-3858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA19185D7FD
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 13:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F62825F5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC4D69312;
	Wed, 21 Feb 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8oIQ3JV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5669945
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519095; cv=none; b=n8CI3Bs9F1amSxcSpUcqBiwesOttNSZpMcRDngMNxCrp57qQf6B7uHjRgnuycq9QNwWWQnh968lyiHJTuNwy+xkYc+rAOjxMVwz6YmIXyjBWiiaaFi8Cb709oumSmCJ2RqBzXbdNCDJ7dV2b1iFMOs+0pn/Uzokf1X3FuUVo/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519095; c=relaxed/simple;
	bh=2DIU9m4srJpLOzj5EtilGvjZP4FJn5xKGraJQlch/2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hEbNQRCe4ikurJWRhxbMz/hG4QJ6CyruvpkAlrLuxNjwiwhnXtCvGrOK5Hg5Z6i0zNgbTvSexfaF4dPOgrmQQkwU4LOQDkE8c5IHeoZqEmvsbjGOtgVl5JuLDTGzsFO5K7iYn7RvH6dO1cn/jTd2M6gtgLUvd13oBdMnmRF5Gsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8oIQ3JV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b276979aso5048728a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 04:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708519094; x=1709123894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eI0ppqpQX94Yu79Tq3Cq2zj5iCtQ44NJHr7Cb/yza1A=;
        b=X8oIQ3JVM/+5ZBc9kgZ4qb8tLKFQG/lFkc785K+ZZl/kABWAa3At9jkO96IpoqM7Xs
         +qSBXInF+CFiU8KEzihEW1z5W0oDHcmf8PwUlvc958bRflkOPmxqL0cWjfLlCEEOAFAi
         n4+gws4nESlD7GbV09aKz0JhIFrsdSmFOef8CEIn/kmmGR+lgZ0PkZRbdYretqsTfYIy
         TpcYeBfY24yZirqPS6aG22YkxmvxIq5XWRHgp0KItLymaq2OYATxrZdxYDMguO6EH6qi
         AgQLxvA75BdQLHZ+TZRPVWpKvKG+PVOzz70gps/0dBrpRHWCz49EXe+uxllfPkRa16DQ
         MVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708519094; x=1709123894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eI0ppqpQX94Yu79Tq3Cq2zj5iCtQ44NJHr7Cb/yza1A=;
        b=dV2jwXYqOU/osrkZMgJxos9zh6LXC2ocWVZjH9h1nJFyfidGaO2GjpgJZy7j3a+n7R
         02eZ/nK8s/TWI7FBZgG9NSjMFslW4r33KsXs5b3xGdvF6NPji9ZBISX1gDvXEpSyTyLH
         27gbrjGhVRfBUSgr4PGCZx5UZdExHjNlNb3GQNSB3m40x06rygAyKnLIB/7EjXWsgIjm
         urwgpqStzh23IsyUymalJubw6Kb1FtipZG+8dksGfVuZJTD2vbFqNVh957LGN+A4u3+s
         Qk6TULI7sZGfGazY9EMeEnObvXzKL3J0AwA83SCU8gvIb8N+JnR0EfnCY6O/9bhGLbps
         8Czg==
X-Gm-Message-State: AOJu0YxRpbe8d/U4lR0UV1M4YjnLivy+b8CQDN9MpAmnYOJaXrbKjg28
	6qI8hohI2KzsMueEcqGoiMZdavaPVsQR+ZwlbLuPe57biVFRc2ydGFMNPgSA
X-Google-Smtp-Source: AGHT+IGqtkxSLniu96E4rr3pDu1aapqH0m/3J++FYnoNms4oj3x2lG8eyPx+27WSjhh2/xOfNjUJLw==
X-Received: by 2002:a17:90b:11c4:b0:299:2c4b:5d21 with SMTP id gv4-20020a17090b11c400b002992c4b5d21mr12247399pjb.15.1708519093637;
        Wed, 21 Feb 2024 04:38:13 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ee3-20020a17090afc4300b0029a04ec7084sm1621082pjb.54.2024.02.21.04.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 04:38:13 -0800 (PST)
Message-ID: <d67fb4f4-aea2-4668-aac4-6e7eca8db4fa@gmail.com>
Date: Wed, 21 Feb 2024 04:38:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: poll service ready message before failing
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240221031729.2707-1-quic_bqiang@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240221031729.2707-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 2/20/24 7:17 PM, Baochen Qiang wrote:
> Currently host relies on CE interrupts to get notified that
> the service ready message is ready. This results in timeout
> issue if the interrupt is not fired, due to some unknown
> reasons. See below logs:
>
> [76321.937866] ath10k_pci 0000:02:00.0: wmi service ready event not received
> ...
> [76322.016738] ath10k_pci 0000:02:00.0: Could not init core: -110
>
> And finally it causes WLAN interface bring up failure.
>
> Change to give it one more chance here by polling CE rings,
> before failing directly.
>
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
>
> Fixes: 5e3dd157d7e7 ("ath10k: mac80211 driver for Qualcomm Atheros 802.11ac CQA98xx devices")
> Reported-by: James Prestwood <prestwoj@gmail.com>
> Link: https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath10k/wmi.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index ddf15717d504..bf6cb2c73128 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -1763,12 +1763,28 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
>   
>   int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
>   {
> -	unsigned long time_left;
> +	unsigned long time_left, i;
>   
>   	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
>   						WMI_SERVICE_READY_TIMEOUT_HZ);
> -	if (!time_left)
> -		return -ETIMEDOUT;
> +	if (!time_left) {
> +		/* Sometimes the PCI HIF doesn't receive interrupt
> +		 * for the service ready message even if the buffer
> +		 * was completed. PCIe sniffer shows that it's
> +		 * because the corresponding CE ring doesn't fires
> +		 * it. Workaround here by polling CE rings once.
> +		 */
> +		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
> +
> +		for (i = 0; i < CE_COUNT; i++)
> +			ath10k_hif_send_complete_check(ar, i, 1);
> +
> +		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
> +							WMI_SERVICE_READY_TIMEOUT_HZ);
> +		if (!time_left)
> +			return -ETIMEDOUT;
> +	}
> +
>   	return 0;
>   }
>   
>
> base-commit: 707e306f3573fa321ae197d77366578e4566cff5

Thank you for looking at this I will test this and see if it resolves 
the problem we're seeing but since its somewhat rare it may take me a 
bit to validate.

Is this any different than just trying to bring up the interface again 
from userspace? I could be wrong, but my concern with this is that when 
I retried in userspace things got into a very odd state:

  - IWD starts

  - ifdown interface

  - ifup interface, timeout -110

  - Retry ifup, success

  - Authenticate/associate succeed

  - 4-way handshake fails because the device never received the 1/4 frame.

IWD would then retry indefinitely with auth/assoc succeeding but never 
receiving any 4-way handshake frames. The only way to get things working 
again was reloading the ath10k driver/reboot. Maybe this patch is 
different because its waiting for the initial request and no issuing a 
second one? Just wanted to point that out in case it sheds any light.

Thanks,

James


