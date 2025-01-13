Return-Path: <linux-wireless+bounces-17445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B1A0C168
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79BB165A88
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14931B21BC;
	Mon, 13 Jan 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bcWgumng"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB11C9B62
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796517; cv=none; b=fown13cU8x2ICLDgqHaB11KOmDfTR1fCcKt+YZOIbu1eO63RyU05QCj+F35zPfEUsjds3slkcrJRmCdS3ZBNyAuPM6S36+P1DbscKVXSwjaLNlZQuCbBr4snys5XX/UlAQByoyGGpQmJoU0l5NpWxZEu2YXCjWgzx3cLJp4Km5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796517; c=relaxed/simple;
	bh=VXVOBd1bepD4YOnI9GBDknUn44th81dU9S7X7P8WeSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3OzXwZ8tBkQD9kuU15/FELjbG0P9DcGmOBkT/9NHSYdbYYN+fhWohlJtc6TPNRJNWd3BsgpCjWfWchnb18HLKXZ9cDKpDqSckTJXuSUhceMpcTqM85XZpLAmqCjmoI9ZKwXSyGGVnbeA4LbalY8kAAyT4lg/OkXfoKPDiZlM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bcWgumng; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab2e308a99bso32162566b.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736796514; x=1737401314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QALMLN5RGy8U/8LqFR8Kx7H+3ZaayKQvJ9z0v27Bhio=;
        b=bcWgumng1P4mRVp8SDN5+c4g41/0aAyDj24dg4jQYXMu37k7l9+qcVzQgIq5S3KDWu
         v4BSkOIjmpDLSh05mlt+wekxfqTaLehZQEXsUhUJq7Pu6XS1LCvOxNLDBUyayC4+IlrV
         RmPibXKj6f8Sg+Qfnk9LnZw8KAn7QCr9ZDcZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796514; x=1737401314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QALMLN5RGy8U/8LqFR8Kx7H+3ZaayKQvJ9z0v27Bhio=;
        b=gkbRvPkKWdKabT1dt2ZF5PrlVRQH8b8zA7ZowUNUjv4QU37Gm5LC7sjNPLLv4sPEgK
         dWgc7Tl5p9+DZUntYDLaIr5Jn5Rf0hNSErudJvh9Wp4Og8r6DI9KBk538DfyjH6aaIt4
         wmA5dVAar6KEcu64wEnPMzUQu6dhLlLbfmKztzNoEuijfXx+aVjfdfgKlhEDv/LOH3za
         S3nszaiKVLw/T7yiGxfJ3Me01WsGsM6WLdqnZY4sblZCZ4psSmMgAMudQz5ypsMF9scJ
         bfVlzFzuwpAzwYz9JWn9Sra8kOmt1axlkz4eqNQukNt554IoMFPcwycy9G8z7ReBd7ys
         hwNw==
X-Forwarded-Encrypted: i=1; AJvYcCXHLq5WUFtfZ2vl+iN5NG2+DaSdffwW+oM7y6qOsMEkVhPilN1g3r0IfTwJVaQ2s9GmWzataDOYYFqbz46y0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcb+pq1KZV4e/q59tvO9cCVrTn9RjBx+dupROp8Vbg6v2yn7jp
	IOh6Sf+cMvnQNWVG63fjWjwCSiagk2QVj+DquJkqHriBXWXDGcdJaj8M9KUlLyAZ3qrZGv+JCbb
	wGQ==
X-Gm-Gg: ASbGncu51hGD/xi3zrEHwZgZLcXUSqqO8DurAb7QBLj7K5cTlgKaUXhfeThzYUrTkIw
	r3wLsIVWTTd90ey8s1IMTWzuNyuPFyng5V3+q3PwO2uMsXWuBva17UZOS+1tryDpz7mMmTPOOKR
	YdS5gQ0ZtQz3yMbY3OE3jqBy7lLwmnVnQ+kwEzXFeU9+dqe+5xckMEim6jwJ695NiJArIbRTonO
	Xrg3L6NIitoQNvemdTXEI7L6Vn7FqnwgJtxjXsfcRnaDayxtuS7BNl6PME7inGyjUt7p7nhjs7t
	eiUlZxt/tifrvakwYWF4TB/I4iZs6JUV
X-Google-Smtp-Source: AGHT+IHPanyWz773JheYHtrrW9jgXITDNhYeZU/g6YY9i3wfmzx90fIiUce0LiYnVe0xzvvknRVYng==
X-Received: by 2002:a17:906:dc92:b0:aa6:7c8e:808c with SMTP id a640c23a62f3a-ab2c3cb6e09mr1820421066b.17.1736796514151;
        Mon, 13 Jan 2025 11:28:34 -0800 (PST)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060badsm537733966b.29.2025.01.13.11.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:28:33 -0800 (PST)
Message-ID: <4020e574-be5d-43e4-9c04-1e5a708e70c6@broadcom.com>
Date: Mon, 13 Jan 2025 20:28:33 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brcmfmac: NULL pointer dereference on tx statistic
 update
To: Marcel Hamer <marcel.hamer@windriver.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 stable@vger.kernel.org
References: <20250110134502.824722-1-marcel.hamer@windriver.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <20250110134502.824722-1-marcel.hamer@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/2025 2:45 PM, Marcel Hamer wrote:
> On removal of the device or unloading of the kernel module a potential
> NULL pointer dereference occurs.
> 
> The following sequence deletes the interface:
> 
>    brcmf_detach()
>      brcmf_remove_interface()
>        brcmf_del_if()
> 
> Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
> BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
> 
> After brcmf_remove_interface() call the brcmf_proto_detach() function is
> called providing the following sequence:
> 
>    brcmf_detach()
>      brcmf_proto_detach()
>        brcmf_proto_msgbuf_detach()
>          brcmf_flowring_detach()
>            brcmf_msgbuf_delete_flowring()
>              brcmf_msgbuf_remove_flowring()
>                brcmf_flowring_delete()
>                  brcmf_get_ifp()
>                  brcmf_txfinalize()
> 
> Since brcmf_get_ip() can and actually will return NULL in this case the
> call to brcmf_txfinalize() will result in a NULL pointer dereference
> inside brcmf_txfinalize() when trying to update
> ifp->ndev->stats.tx_errors.
> 
> This will only happen if a flowring still has an skb.
> 
> Although the NULL pointer dereference has only been seen when trying to update
> the tx statistic, all other uses of the ifp pointer have been guarded as well.

Here my suggestion to make it a bit more simple...

> Cc: stable@vger.kernel.org
> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
> ---
> v1 -> v2: guard all uses of the ifp pointer inside brcmf_txfinalize()
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index c3a57e30c855..791757a3ec13 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -543,13 +543,13 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)

Instead of checking ifp below you can simply do following here and be 
done with it:

	if (!ifp) {
		brcmu_pkt_buf_free_skb(txp);
		return;
	}

>   	eh = (struct ethhdr *)(txp->data);
>   	type = ntohs(eh->h_proto);
>   
> -	if (type == ETH_P_PAE) {
> +	if (type == ETH_P_PAE && ifp) {
>   		atomic_dec(&ifp->pend_8021x_cnt);
>   		if (waitqueue_active(&ifp->pend_8021x_wait))
>   			wake_up(&ifp->pend_8021x_wait);
>   	}
>   
> -	if (!success)
> +	if (!success && ifp)
>   		ifp->ndev->stats.tx_errors++;
>   
>   	brcmu_pkt_buf_free_skb(txp);


