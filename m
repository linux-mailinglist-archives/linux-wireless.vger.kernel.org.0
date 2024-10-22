Return-Path: <linux-wireless+bounces-14289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2639A9A3F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 08:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B4B2837E3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F3D146A71;
	Tue, 22 Oct 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="ODl32DNE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B661474B2
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579740; cv=pass; b=cA6aHPb/2+MemndMnUh7OvRwdU8kXMF+CvsaqDZaDXzNhj85xDyPYjs8k0dHWuH79QtbOiV5hvCvv1zr/2qYmWvOHRF7Y9ljJ04ZAqRHVlTX65l1TZrvVw1iVvWlr+A3b1rJhBUyIbGs9p+KRWRzOCGhI7wTyQxjCRggps14JvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579740; c=relaxed/simple;
	bh=PjCwF1x/n5pLs/kjoZ78JaDeN+SCeTOznEQZz8GDoo8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PYxBGWZ7jdH1ignjeh3dK8ajQNlZWNiiSEx9yDZ2yrjIBn12VqfGkvtBIdZyXz1lJHkhwYZAKuoYNz4mtav2j0w8AbOeSObc+tg/SoH1da01yywSVd9FtYnCgzLjN1+LKH2M9DOL+PROyyg7MtpjeJkHbk17QhPUo7GJVEGuJj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=ODl32DNE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729579731; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EC4jh4XA+DKtrV4ZIBVyWHhqDAqvwu7i+bYL4xBoFwsQ6E8gWN5r8Rvg593mqAnScXcZHldS65mDBuvU/YOHPZ7fzd4spduGYJqYbgNl1zhkCRrfeNJA6XOD5vTycY2S4DTGu7t/lPWdAyopFvJtGtkF3tiKIK2ZdwUog/ljJjc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729579731; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=39UhXVSNom/D968QZX3NP2279tlO3PvdWexNNLUG2b0=; 
	b=nlQLf/oW4nCj7TH8iEAftIWo3LMqElof7GkptuPF23Qpl365qfdc+TWwfl4b0G+hV5bzH3Nae+WkozTkbYieuq8zmZ4Pa7b48tP6t9fRlMu/cYd7ADzAgueigC888BHPzukZ+vjA4xh8oibhzzPHCFDrYTF5tswH1ITrVGAbOsI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729579731;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=39UhXVSNom/D968QZX3NP2279tlO3PvdWexNNLUG2b0=;
	b=ODl32DNEmfzmS9XFDPA6AduEFVFDfdJVxSufBS4OSL3ZbgCen3MaHDC3V9moArgm
	TFPUh8aiTBP2GqFqreJtlXVhcuRL0P1QkYxV2hpF97IEaZB8KAvhEnG5PVH0YRRHkxp
	09PkyOkERogOA3qhqIuzTg5I5F6rilRVUtbbzWRQ=
Received: by mx.zohomail.com with SMTPS id 1729579729629892.7028481450611;
	Mon, 21 Oct 2024 23:48:49 -0700 (PDT)
Message-ID: <1d673f56-0bd8-4a55-8805-4e30c38cc36f@collabora.com>
Date: Tue, 22 Oct 2024 11:48:43 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: do not increase mcu skb refcount if retry is
 not supported
To: Kalle Valo <kvalo@kernel.org>
References: <20240917110942.22077-1-nbd@nbd.name>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240917110942.22077-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 9/17/24 4:09 PM, Felix Fietkau wrote:
> If mcu_skb_prepare_msg is not implemented, incrementing skb refcount does not
> work for mcu message retry. In some cases (e.g. on SDIO), shared skbs can trigger
> a BUG_ON, crashing the system.
> Fix this by only incrementing refcount if retry is actually supported.
> 
> Fixes: 3688c18b65ae ("wifi: mt76: mt7915: retry mcu messages")
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/mcu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
> index 98da82b74094..3353012e8542 100644
> --- a/drivers/net/wireless/mediatek/mt76/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mcu.c
> @@ -84,13 +84,16 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
>  	mutex_lock(&dev->mcu.mutex);
>  
>  	if (dev->mcu_ops->mcu_skb_prepare_msg) {
> +		orig_skb = skb;
>  		ret = dev->mcu_ops->mcu_skb_prepare_msg(dev, skb, cmd, &seq);
>  		if (ret < 0)
>  			goto out;
>  	}
>  
>  retry:
> -	orig_skb = skb_get(skb);
> +	/* orig skb might be needed for retry, mcu_skb_send_msg consumes it */
> +	if (orig_skb)
> +		skb_get(orig_skb);
>  	ret = dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, &seq);
>  	if (ret < 0)
>  		goto out;
> @@ -105,7 +108,7 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
>  	do {
>  		skb = mt76_mcu_get_response(dev, expires);
>  		if (!skb && !test_bit(MT76_MCU_RESET, &dev->phy.state) &&
> -		    retry++ < dev->mcu_ops->max_retry) {
> +		    orig_skb && retry++ < dev->mcu_ops->max_retry) {
>  			dev_err(dev->dev, "Retry message %08x (seq %d)\n",
>  				cmd, seq);
>  			skb = orig_skb;
This patch is in next from 5 weeks. As 3688c18b65ae ("wifi: mt76: mt7915: retry mcu messages") is
already in the mainline, why this fix hasn't been included in mainline? I thought fixes are included
as soon as possible in mainline RCs. Am I missing something? 

Are we planning to include this fix in next release instead of current one?


-- 
BR,
Muhammad Usama Anjum


