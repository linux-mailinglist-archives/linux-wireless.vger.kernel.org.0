Return-Path: <linux-wireless+bounces-23378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431A0AC3398
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1531893D18
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B3155C88;
	Sun, 25 May 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="INdQg5CX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3122DCBFF
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748166441; cv=none; b=r2agmUcvD3hGTYmIVXpOg9ilyRdFlfXFd82den779cYhUrLjBIXng9FZ6YKmXJbI3Lcmsy1NvlMlTWcnjttAyaCpZpyxTB1OafJhEskb/Qx3ABnRbi0xRAaK7DfaHGIciK90sx83eRmeVd1NNMdWyAEfKXJwXJ9bryDP3Gn5yAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748166441; c=relaxed/simple;
	bh=NvwkMpDTSSCCjACAVuBLVrKrReHzj6vOsXj3K+wA/VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmLUPIuZhhK62r27bC/wjR8xOlOdRJLPoKWNFV9nDQ116wwoualzbwq39E+BN6diObZQtunot2PjRXKud49eQavdxO0d3rSWwPIjc8U+Lp0M5LE27eN09aivR/1Asd/iy4eB6H9GFxSMj+U501/psUwsHyRYW1RTc1suvZqv/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=INdQg5CX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742af848148so779826b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748166439; x=1748771239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gRRRpp2ysa9AW28bJqBQ4AWPZKN7HVsqHtVlIIKXx2g=;
        b=INdQg5CXonGdbDu6J+sCEQkVI+e368RwMOpt/sLpWTmRC7p0Dxwn3c9rrUyaZUSydF
         TF1VtQLW0FMAWGZBtlyBXJGj5/z3Tg2Lkq2wule/ey4QBhQcfVMCMe8OzoaWcpgihhyp
         aaN351JBx0HqG1HVFlDWGY65tpGs9XhRoNMeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748166439; x=1748771239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRRRpp2ysa9AW28bJqBQ4AWPZKN7HVsqHtVlIIKXx2g=;
        b=aqs6LmjSA8sWtslYJYAO3KKtDcmAj6/wrjpI70M2qeexZCTrA0i5aiOKQaqnyDHplO
         4S1OKhY9Z4Yrn+FSx8oJ5GAC+kb+hNEzdKHzZi78DgajYo10h/uBcoZlvcWcA4w/eoQv
         Ns6A3O8tyhwNo31ESGSsuhixZjYMdmnlMB/SLNelJqVRjz4zZDS8OJ/ribYgQAoXc0kf
         nfcU3fJHswaN2sSXrO5GBYIH5L5vouwRTndnSWxVzbQWDT80RK61owC6KO+HBFOtbSmA
         EgyXod4nscQcZXVnT02fPDiZ/aMe8YS0ovP+JohV92UI5rQDg7t8fLo7srFVZLlPF2E4
         KpFA==
X-Forwarded-Encrypted: i=1; AJvYcCXxiSvqgFOqHg/+FRgqBsq7DX+hQavCY/EejWfZFmPy63woCzaZcH+X88LCHfdbaAUSD0i47FM0y6OHHH4JcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KTIV347DzEqEvDguTy1EfuKAp8y//RQAMNJy8ViOl2+NxTuF
	YEmorZtp/rkISG5rXZ0GOCh8PIX7EvvqbByHVDGhMG+k5ZgTm3DobyitH4S72TGJuzgYUQPXNeL
	k74553g==
X-Gm-Gg: ASbGncvxC5Rr2S6qHV9l2WMf8BOCuRlK0rdHdf+9anDnCH5fu3B6s2cDW/20kbe4qqY
	lb6olVSPEL99lLcYyS8lhD+qyo6m3QVDZxyPp7pXvB3JAbRAPKi8/qkBkyheX4lASSsekvGzM3K
	+apexWF4Uid6GBxvyF1pdGIee+b8e3aMK7WMe38U2+NjpUX0BUaw2KxkVYKfQz4rAkwYsTJIQrS
	RugnmhJeUKY0biYTY3lfymPcn5XHsSZT7s1YhmXTUqh1Un/co0+tkueMl20eEmX6cqadnLprU4g
	LDRsJgbgxZygCl4ALDJ21KLw2jJl127GViucAOA3hGMb6Z0eUHL437F0/G8tSbYfjTwMyLZSF8F
	D/S3vLKvQ+gzqLNe99ARsbeIwyU0=
X-Google-Smtp-Source: AGHT+IE1sghhsAHkwYzud4pm/yEYXzjyb9pXG7gNvdJUqu4gaZ2i2rXbJOjlOYcVOvOJTYWwi71ptQ==
X-Received: by 2002:a05:6a00:2287:b0:73f:f623:55f8 with SMTP id d2e1a72fcca58-745fde779e7mr7506224b3a.5.1748166438922;
        Sun, 25 May 2025 02:47:18 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98770c2sm15324250b3a.150.2025.05.25.02.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 02:47:18 -0700 (PDT)
Message-ID: <c3ed7fd4-f4ac-4d23-bed1-78d5bd615ec5@broadcom.com>
Date: Sun, 25 May 2025 11:47:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth
 support for Infineon devices
To: Tim Harvey <tharvey@gateworks.com>
Cc: brcm80211@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>, hostap@lists.infradead.org
References: <CAJ+vNU2pLJd696Fc_98arrzs8QK70HfstPrZv6zVJm3G13REHQ@mail.gmail.com>
 <196d7901068.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAJ+vNU009QSwYopCFzZtwDNXDBppx7L4v_ZKtmNZ=5ep7trOSA@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAJ+vNU009QSwYopCFzZtwDNXDBppx7L4v_ZKtmNZ=5ep7trOSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/2025 1:38 AM, Tim Harvey wrote:
> Incidentally, while looking at this I noticed if you enable
> CONFIG_FORTIFY_SOURCE you'll get a splat from the memcpy in function
> you added in your patch:
> [  161.608607] ------------[ cut here ]------------
> [  161.608646] memcpy: detected field-spanning write (size 104) of
> single field "&mgmt_frame->u" at drivers/net/wir
> eless/broadcom/brcm80211/brcmfmac/cyw/core.c:307 (size 26)
> [  161.608712] WARNING: CPU: 1 PID: 64 at
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:307
> brcmf_not
> ify_auth_frame_rx+0x1f4/0x210
> [  161.647854] CPU: 1 UID: 0 PID: 64 Comm: kworker/1:2 Not tainted
> 6.15.0-rc5-01256-g68b44b05f4c8 #153 PREEMPT
> [  161.657699] Hardware name: Gateworks Venice GW73xx-0x i.MX8MM
> Development Kit (DT)
> [  161.665279] Workqueue: events brcmf_fweh_event_worker
> [  161.670348] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  161.677322] pc : brcmf_notify_auth_frame_rx+0x1f4/0x210
> [  161.682557] lr : brcmf_notify_auth_frame_rx+0x1f4/0x210
> [  161.687789] sp : ffff80008065bc30
> [  161.691107] x29: ffff80008065bc30 x28: ffffabb0a8e7d270 x27: ffff1f01c0b0c8c0
> [  161.698269] x26: dead000000000100 x25: dead000000000122 x24: ffff80008065bd58
> [  161.705426] x23: ffff1f01c03bc008 x22: ffff1f01c114b750 x21: 0000000000000080
> [  161.712587] x20: 0000000000000068 x19: ffff1f01c02c7f80 x18: 0000000000000030
> [  161.719744] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000ffffffff
> [  161.726903] x14: 000000000000000d x13: 7720676e696e6e61 x12: 00000000ffffffea
> [  161.734062] x11: ffff80008065b9f8 x10: ffffabb0a93242c0 x9 : 0000000000000001
> [  161.741220] x8 : 0000000000000001 x7 : c0000000ffffefff x6 : 0000000000017fe8
> [  161.748376] x5 : ffff1f01ff775808 x4 : 0000000000000000 x3 : 0000000000000027
> [  161.755536] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1f01c028a080
> [  161.762696] Call trace:
> [  161.765151]  brcmf_notify_auth_frame_rx+0x1f4/0x210 (P)
> [  161.770391]  brcmf_fweh_call_event_handler+0x40/0xc0
> [  161.775368]  brcmf_fweh_event_worker+0x158/0x3b8
> [  161.779999]  process_one_work+0x16c/0x2bc
> [  161.784024]  worker_thread+0x2dc/0x3dc
> [  161.787784]  kthread+0x130/0x200
> [  161.791028]  ret_from_fork+0x10/0x20
> [  161.794618] ---[ end trace 0000000000000000 ]---
> 
> Maybe you can submit a patch for that.

Okay. I do not run with that Kconfig option. Will have to look into how 
to fix this. Probably need some kind of annotation. If you know what is 
needed feel free to post a patch for it.

Thanks,
Arend

