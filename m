Return-Path: <linux-wireless+bounces-12466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA85196B529
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EAB28781C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3EC1D2208;
	Wed,  4 Sep 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXf0lvLe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE41CC88B;
	Wed,  4 Sep 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439014; cv=none; b=aLMjMPAjf+n/voX1c6XB8armZjFCoSfknsI/c/+5Ixcafxl1yw5/1aQQN04jJPE34tugb0PMyOvS0JmO/hz3r/r5ZvJn9/64pvcg3ZXRT23Vn+AvmIKnIgwDypu8IFpYO3IQZrUUnI3+qh9tpMFmKObXn1zN+r7urjlPooqmBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439014; c=relaxed/simple;
	bh=4NcKFFV961OMtO6GUk7a2VxLeq7aSTbuA2dtbQcrizk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4AicAPvaUB4LXB7nxxhyrTiR/LKdEcILPlRXo0G5PyvSkq2U74XFiQZ/SahfACfGKGkw0bph5i7EDi8R2XYus7wazr+RmqLiOJftE3RrXYEDDXnk+5EIQnpiytZOM5fxdOMSZFR5SMK/YaOcDnaJWjPiGghF8TUXxtu3PtV+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXf0lvLe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42ba9b47f4eso2611585e9.1;
        Wed, 04 Sep 2024 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725439010; x=1726043810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=coqROFg8ieCUdM0Q+87b+N5eZVFIazUMtX0eKOozZo4=;
        b=eXf0lvLeRHkjrG0apsl8EzZelf0GuqUk82WNLKh8d55i85kRfJWTrH18YyNeufhw/p
         t7OvDKynNM91jxItCcvoDjpU4ciCoTRFJDYoAGdH9nAYuZXdL2DBiSwQuHE62LmKbdQh
         prHwOfpdy2LOqP9phGGMEnWFiL4IBH2rSJtPS33n/dE7GnodiUvX9Ocdx5vtSouFaQKZ
         zYanRD/PLT2l1hpwG9FrUvp7bHtRxgF25EZKOvLSPQcA9hyyCHMSk6yppTyrRdTx6NUO
         oCXpyftq78pY1nuCfXg74+iJ+vmSqfOQCfpRLtTqxf7XB2D9w4kbr50axujQlLL9MBo8
         zWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439010; x=1726043810;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coqROFg8ieCUdM0Q+87b+N5eZVFIazUMtX0eKOozZo4=;
        b=rAu516vWv4wxHSIqcxaBfJ65jR2mJuwYtAYaXheu2SAbiVfgtXxFpsAb1rtmzuABFF
         rIPTRz0aG7CQytd46lQ3iAcyxhNU47tVltTLpax4aViZZwBWXy8oa1T+OWJza2fo4KDj
         DX0InC4tKe6IpLwAL36q4jRwQcHxv5q7xHC2nuew82l7CbcZFfQZEMwTd4mkZ6txjc9B
         cAAoLZalkhn6jcZpH724RKGfqkjf/5DztfaKuIXCrN9ZICAn2Gip8/rqibjVcdXBCsuA
         Y7xTbIWNHeOaE9MGPyIZ01y8Af6V7r4Nbtrs4i75T1tU86hkyPQNPZu8o0vtIa7lMH8/
         7eaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhppFj29N3MSKVhj7ErT4ptLaNR52i8XuvaOOS/ITU/AuWJiGAtlgYgn3JhC3krwuQVhlJcEo8Mw7iL34=@vger.kernel.org
X-Gm-Message-State: AOJu0YznKum2d6WFPXdpOAOBuaeEga4JyO3LnF/922/R9pm3/Vu1f5Zg
	/wxNIawPkgQBAHijTtVdf69jInKfSv94OOuL727kl/RqNk4HdLaT
X-Google-Smtp-Source: AGHT+IFZfXBla80xFEu9ewJ3fbefvH2EuZAZIRSZp/svaazCGUxVeydes80wRxUEgoJGLqgLEyeXdQ==
X-Received: by 2002:a05:600c:511a:b0:426:5c36:f57a with SMTP id 5b1f17b1804b1-42c95b9a087mr7582415e9.14.1725439009520;
        Wed, 04 Sep 2024 01:36:49 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbc87773fsm157261795e9.0.2024.09.04.01.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 01:36:48 -0700 (PDT)
Message-ID: <f2380ad1-f1d1-41c1-b00e-782f2c1937fc@gmail.com>
Date: Wed, 4 Sep 2024 10:36:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7925: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 kvalo@kernel.org, angelogioacchino.delregno@collabora.com,
 deren.wu@mediatek.com, mingyen.hsieh@mediatek.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240904075213.1352976-1-nichen@iscas.ac.cn>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240904075213.1352976-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2024 09:52, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> index 9dc22fbe25d3..82c5a8def344 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -2171,12 +2171,12 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
>   
>   	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_RLM, sizeof(*req));
>   	req = (struct bss_rlm_tlv *)tlv;
> -	req->control_channel = chandef->chan->hw_value,
> -	req->center_chan = ieee80211_frequency_to_channel(freq1),
> -	req->center_chan2 = ieee80211_frequency_to_channel(freq2),
> -	req->tx_streams = hweight8(phy->antenna_mask),
> -	req->ht_op_info = 4, /* set HT 40M allowed */
> -	req->rx_streams = hweight8(phy->antenna_mask),
> +	req->control_channel = chandef->chan->hw_value;
> +	req->center_chan = ieee80211_frequency_to_channel(freq1);
> +	req->center_chan2 = ieee80211_frequency_to_channel(freq2);
> +	req->tx_streams = hweight8(phy->antenna_mask);
> +	req->ht_op_info = 4; /* set HT 40M allowed */
> +	req->rx_streams = hweight8(phy->antenna_mask);
>   	req->band = band;
>   
>   	switch (chandef->width) {

