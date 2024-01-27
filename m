Return-Path: <linux-wireless+bounces-2601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EEC83ED31
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 14:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B391C2185A
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 13:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8825765;
	Sat, 27 Jan 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U79BX+bO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974225601
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361321; cv=none; b=on2gD32v9f7BvOKQHszopOXnnHCZi64IF9ot10DR671Rf6lKL+SNovr2WNtX42gfywUzAVlu6Es+vqf46BQMF7Ecm8cxbSuRiTTdufyLVl8GfAfCpTyarBxRCcMNW2ogsUjEDhHdI2C2A9mCvnXes/cCLmpe9MoEDYbafGQW5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361321; c=relaxed/simple;
	bh=Dqdc0+GiMMU9oBgocmuzdAz+2RL5EmpPsPfk0dVDRO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEew11U3jjoVezKJ7+8s9Vjw4CB6kiErkUiEHuD2xHGUQEGwXcQH9nTG1p/VkQAg1wsPpcbMT2M6SP9us/eSEUGfKmypfom9reW5tl4I9Snu0vqY/pqaTm9WQR2C5HHC7xxX7KVS9mfmGBVMjNU72eTkrF0YzxF6CddeK8JueHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U79BX+bO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706361315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrazDqdbD6oanZQGLU+I+Chea6nbXarN1I/pTzbmfG4=;
	b=U79BX+bOtnw4mpLk47nGVj9Qnk56vKB2pU6qwHQd1nR45/XflIH/PWkg8I/hv5fEp5rtbl
	GOCZHSgTIDRSJALGEUthsNUllBXiwubQLaQHXzeQhN2zFv9dUaHMG7Zq4MrzG5Fwmdq60+
	rx2fvhmPyfvlHMoyD+OdhKtSDQCud5g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ztma-JvWNmec_HSiJ8Uz_A-1; Sat, 27 Jan 2024 08:15:13 -0500
X-MC-Unique: ztma-JvWNmec_HSiJ8Uz_A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2cf4671ed93so8925371fa.0
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 05:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706361312; x=1706966112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrazDqdbD6oanZQGLU+I+Chea6nbXarN1I/pTzbmfG4=;
        b=gnO1WkNQqQ4Inx3YAHtazXY63rdrvvGbRFo3kQkdK/T7vZZ8AXyyXsyQRzIPMr1+AD
         NzcEwQMVBAtlh67+AyqRj8i+2AAF7/R/hO6du0gZWlE+FDEFYJJ60oPeUic7EFOalg4m
         Su7LUcWKSHvFpejrlDn9E14BE+Jyo7hNUN4OiT1lB9KGmLIA0OrDfEYWhK0/nyWsw/yE
         lYvQVFsm7loWmVf5t/iI/w1Dj3VLseD7XNJ6AicnWTmukkyrLPstrHEAOrKchGECL038
         Mq2i6jp2Lf83rqL7DcDL/mHk9mfEXPzYnejkcRs2gqlsOLYiRgpe1V4rz/mdzGb0UDB+
         erkQ==
X-Gm-Message-State: AOJu0YwBb8QqaOURpAHuCLFt9qC9gedK8nf9ahT2PvrDQ4WGro4lzvgm
	/GGcjH48v326OnGETv27mJRjvyWh3YA/1jErSkJ29vcJcQKCHLQD8LBoOGTqZcVAHW3vAd/kanm
	MhATBjzguABscnzx5LDTnOigKQQcAbmbS8YDduguLj4CkQ+1xdNeYCdQmuk4esETq
X-Received: by 2002:ac2:4651:0:b0:50e:6a19:7a38 with SMTP id s17-20020ac24651000000b0050e6a197a38mr840738lfo.20.1706361312459;
        Sat, 27 Jan 2024 05:15:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/8eFrsRRCO0DBjR/ei2z8ocfhn93MBtESzm9v5YMp5FsQgPdgqxDov+zEfayAXv6aGPZLtw==
X-Received: by 2002:ac2:4651:0:b0:50e:6a19:7a38 with SMTP id s17-20020ac24651000000b0050e6a197a38mr840727lfo.20.1706361312120;
        Sat, 27 Jan 2024 05:15:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hd11-20020a170907968b00b00a31906f280asm1738295ejc.193.2024.01.27.05.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 05:15:11 -0800 (PST)
Message-ID: <8f225be1-647b-4421-b6b5-a2098f807d05@redhat.com>
Date: Sat, 27 Jan 2024 14:15:10 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
Content-Language: en-US, nl
To: Kees Cook <keescook@chromium.org>, Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, Kalle Valo <kvalo@kernel.org>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>, Ian Lin <ian.lin@infineon.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Wright Feng <wright.feng@cypress.com>, Hector Martin <marcan@marcan.st>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jisoo Jang <jisoo.jang@yonsei.ac.kr>, Aloka Dixit <quic_alokad@quicinc.com>,
 John Keeping <john@keeping.me.uk>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240126223150.work.548-kees@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240126223150.work.548-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/26/24 23:31, Kees Cook wrote:
> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
> cfg80211_scan_request with __counted_by"), the compiler may enforce
> dynamic array indexing of req->channels to stay below n_channels. As a
> result, n_channels needs to be increased _before_ accessing the newly
> added array index. Increment it first, then use "i" for the prior index.
> Solves this warning in the coming GCC that has __counted_by support:
> 
> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_internal_escan_add_info':
> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
> n_channels' may be undefined [-Wsequence-point]
>  3783 |                 req->channels[req->n_channels++] = chan;
>       |                               ~~~~~~~~~~~~~~~^~
> 
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: Ian Lin <ian.lin@infineon.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Wright Feng <wright.feng@cypress.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 133c5ea6429c..28d6a30cc010 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -3779,8 +3779,10 @@ static int brcmf_internal_escan_add_info(struct cfg80211_scan_request *req,
>  		if (req->channels[i] == chan)
>  			break;
>  	}
> -	if (i == req->n_channels)
> -		req->channels[req->n_channels++] = chan;
> +	if (i == req->n_channels) {
> +		req->n_channels++;
> +		req->channels[i] = chan;
> +	}
>  
>  	for (i = 0; i < req->n_ssids; i++) {
>  		if (req->ssids[i].ssid_len == ssid_len &&


