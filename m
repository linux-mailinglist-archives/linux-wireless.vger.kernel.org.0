Return-Path: <linux-wireless+bounces-5100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E140885D37
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 17:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03E21F2409F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35912BF38;
	Thu, 21 Mar 2024 16:17:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC075B1E6
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037828; cv=none; b=rfL4FRbYVaBRn6VSK6M1wcSVoxr07HkpwZPSGkIIN6RfVFGrgLo5grVqkz9AQxuYyMRIRn5v2/FOuwo5Ruy4bDnRfjSKkU4xlVCvUyH+Xj1rS7H8BAuxEz3sL+neCoIV1SwPQNtBcM2rq7u38CRY+MKDwMbG1eBmofN0uLWsnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037828; c=relaxed/simple;
	bh=30jy68VlGbmtsWE7K/SJnyAQQZ0T6LbTPbz7mONsDm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k20YdlAFIXCC4dL8QJgsJ4h5fAuSmRKaoXNFPWXetN0if2gDDe3+wBWLFU+xS6DobMXCFm5mfnJTjX4zGZmYp9WXNch5ZuZLm9+X9WSo0wyuqXnSJ3Nq9G4k7qm/rvpja1F+HyfvEQ9thzHevS7b4PX9T68Qki8B+vjjbToN6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([85.168.41.102]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Ml3ym-1r2DEF2KtQ-00lSaQ; Thu, 21 Mar 2024 16:51:07 +0100
Message-ID: <06508917-f7a0-4ea7-b9da-eb392da9171f@green-communications.fr>
Date: Thu, 21 Mar 2024 16:51:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7915: workaround dubious x | !y warning
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org
References: <20240321153437.403259-1-kvalo@kernel.org>
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
In-Reply-To: <20240321153437.403259-1-kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZRFRDxkFbUdg1hxbn+QhNqzyPt3tYltabuhWinLvggqXtNaxZN7
 7rUnL0XHjJnKYuZlsoUY7v3NPepATjyUZIAZZUHNkkCIeNJ03u+wy/DNZdS2PBd86OKtdJz
 /tvqJmCOr3kpVAIjFnZ/+DkCLGkCd2e4CKxP4gjyTSZEyZ0Y+Aukedlgd7TqyAf0z3Ei59K
 RKQPEUQaXkmDPEYCgXDtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UhyT2iIthC0=;pEMw45oHqDO3EA1YwRCD4n5L0/D
 xaVx0XGv8GFD7zoRY6Bej2/YZ82TmGrIQRAb4YEFpG8O4+xC05Hr3vS94MbyAWOKpviz812gW
 pKvO+hi2QFWaQCCfr2BKvtHAUSRdpNwRlrlLzlTTjke+Nkf6Mv/fHyToy7mhy80Q4vMqKm5uH
 KjfRv7TgBK8va4Ix9nViEc8FLslNITKqco5AY4EsnP7ihn9NKBiV0jPZ13LnOiu9FrYJFEWdK
 6Oh273RKkg4jPDRrslw2Ejjh9tnSgjSDdgDGFpK2nlFfnrsG2Jqm2VbFq9lqzpM/PW7GhqKJ5
 +L/3Akoa37Mc27b2bhdc8n7sg3k19Y9bLE7CvgHlLGfC7RIby4K+tmMghiXVyG40ldS/Dek0r
 wY7UCLMRouoEzcBbwdFr+ri0xaFRPVJYN/rvVzWWcPqZF94h1XLzv8U+8LpTlb1p4oq441B3Y
 7Rrq/SiAgt4rsd2SIr/xz97Z76xBHRHUjqfWWEF3Rkd/50RytC6VOIxgErIwnZtPB+bzMg8NN
 XsusxjrmdW8/1xioyyERGQmKii06sc8SOpz+d2TEO38/7//RBmmz5/OfXene3eE+dUinyzVwr
 lpKbdq4m3Vo266/JyNW1IHRemzW790hw9tH0Kan0wgbQuSz57q4BS+QqvryI5rc4dvIyr4/Xm
 lFrBE4OAnFY/udmxzlKyMellSWLFEQXCDTQNhcwRb2swBUWm3UfWpxlaSNlSvd+J6E+mEJivA
 0IGUYlebbTA33NlBLJ62JVyxtcRdrdSV953oi7PDr2EtXV+z7slJ9M=

On 21/03/2024 16:34, Kalle Valo wrote:
> Sparse warns:
> 
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:526:9: warning: dubious: x | !y
> 
> Workaround it by using the '?' operator. Compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 450f4d221184..3f47aafb1a6c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -523,7 +523,7 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
>   
>   	/* WM CPU info record control */
>   	mt76_clear(dev, MT_CPU_UTIL_CTRL, BIT(0));
> -	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | !dev->fw.debug_wm);
> +	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | dev->fw.debug_wm ? 0 : BIT(0));

clang says "bitwise or with non-zero value always evaluates to true 
[-Wtautological-bitwise-compare]"

It needs some parenthesis.


