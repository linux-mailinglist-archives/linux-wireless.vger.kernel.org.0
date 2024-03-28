Return-Path: <linux-wireless+bounces-4571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED59878617
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4153B21C1F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE14AEDA;
	Mon, 11 Mar 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dl1NqHij"
X-Original-To: linux-wireless@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB34AEC3;
	Mon, 11 Mar 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177088; cv=none; b=HWXnvlapoBcqz/uVWDuRCPYIEEzBMWXqaN9iopTZP01R7z48Ztz1dLQOV0F6I4CAqMbopmM1klNaEwxUhi3z7EDlK/mRfxHH8vUy+UMpk+v0HvIZYRDane6a1VtIPc+d4QEZq0wQ6p7AnBPFpRuvu5jyt3EIzoUlSfKjLmFv/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177088; c=relaxed/simple;
	bh=5AOlmp0WhMZQanJVzfmUCGnKbq90HEOIbEhrlt/ju1k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CM/BGMxRkiQHrBkbfXrQKdVDo99lfRC9cyncUqyTMcH0PSxbL6KSZ+Zf61BILYXTa6c2cLArdclGZXIVgIZJMsqxcVb5BfwCsywNUHVXP7sANnrWo4c5dDt4tfcpAnU68Ozuz1sZQIJU27kGRizELv6XY+b38VPYj7KRf5w3/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dl1NqHij; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710177085;
	bh=5AOlmp0WhMZQanJVzfmUCGnKbq90HEOIbEhrlt/ju1k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=dl1NqHij7NxipguTGBERLEIq1bqfVRVP4iq3wioNLnoRj8g82MYWcih38MC1YerDb
	 YhPWoqoawOeG7J4ySudJmbQ64zMgmzEPziktv0To8I/s5RD4sK3x+XDx0nkmsIB2eC
	 htiJP4vxClYA8IPklK1mq1etU6mBcnrMIBPNFpzDeio9bKEFjNTc5++dxjOEy9Yawi
	 V97kUv+MyIoZND+Z8lyElxyXZeUndm0a/JY8Q3XVaIfzAcc3p95pz6amt0zErJssIV
	 wswXPg+bMzbbuhGFVTrPNABshzD/Y01VLthmaXySK9zYeolaTh1DypNY3jBQ7OS/ku
	 gIUIVVy+Qh8kA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 45F1B378200D;
	Mon, 11 Mar 2024 17:11:19 +0000 (UTC)
Message-ID: <ab6b08c5-86a2-47e3-8683-28cdbe5be7cf@collabora.com>
Date: Mon, 11 Mar 2024 22:11:51 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: connac: check for null before dereferencing
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240301144406.2808307-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240301144406.2808307-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 3/1/24 7:44 PM, Muhammad Usama Anjum wrote:
> The wcid can be NULL. It should be checked for validity before
> dereferencing it to avoid crash.
> 
> Fixes: 098428c400ff ("wifi: mt76: connac: set correct muar_idx for mt799x chipsets")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index af0c2b2aacb00..7af60eebe517a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -283,7 +283,7 @@ __mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
>  	};
>  	struct sk_buff *skb;
>  
> -	if (is_mt799x(dev) && !wcid->sta)
> +	if (is_mt799x(dev) && wcid && !wcid->sta)
>  		hdr.muar_idx = 0xe;
>  
>  	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,

-- 
BR,
Muhammad Usama Anjum

