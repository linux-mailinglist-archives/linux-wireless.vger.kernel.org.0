Return-Path: <linux-wireless+bounces-29852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03051CC9B52
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 23:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71B8530412DE
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 22:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825C8311971;
	Wed, 17 Dec 2025 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Srl8Mzil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3C26CE3F;
	Wed, 17 Dec 2025 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010500; cv=none; b=eo9oRdZoeb+XxbWiB3MEc/R37DZ0IzoqBd1c2/X3bIg8jgWW/VVLBQnUHyR6H+n7PXnXJBAj3xBKYwmUazS4DbSMKXNtw1Y92MdWL9tQ6kceDrlxlYIl4MrMARNA7msMwL7dmbMs7QbGCl7mJkH2/tdRYcH/BwXAXyN64b8GS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010500; c=relaxed/simple;
	bh=v6sv7nRepHfXKcblN7f9MBJN/qyP5DLpffko3IOHGO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mbs7xbgEA6YNp320oheoY2fgYijSy8eSRURvH8VfGRieywclMPcZxaDDMlUxF8V4gSyEPK3jO1fuP4U5Cj8Rce+KyTUxknsenvsfE22/i9XJKNkVdfcdO47IXQvMatBMmrPLe80EW84i5JHq0R95jsSK+CCzMN3FBGN822fD2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Srl8Mzil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7DDC4CEF5;
	Wed, 17 Dec 2025 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766010499;
	bh=v6sv7nRepHfXKcblN7f9MBJN/qyP5DLpffko3IOHGO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Srl8Mzil9rCikw0E6OD6cFRVdCYMgT8x75pDUTfnn6T18FEiYDwPLs/w8XNyFLkeS
	 W8I9stU/Iao05Db18m7R2/s8orhqvxPfVNVN1MCGU3ltyGJKGfX1g6hCBRKH0ZFFDf
	 biwEk5AZGDLFMrGUFgobpa5U5Hsdb61W1ZRYjM0HZvpSzUrwrWttib8skbGD6aGd3/
	 nBnAuZ6HCT3dxgBRnmVMxVXrS6XUso9gUzUilaPZacDx288Bv9G7E1Cir5H8qePj2Z
	 5E2eYQTqOK0YRjkAQWcur13JkSsLUfHRN3Yygcgm6hO2QOjQPkBmLvyiTziG5VDHu/
	 RvcsfhU7t62xQ==
Message-ID: <8de4b48d-1e25-4334-8afb-1b5d279fb483@kernel.org>
Date: Wed, 17 Dec 2025 16:28:18 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: connac: fix out of bounds read in
 mt76_connac2_load_patch()
To: Bert Karwatzki <spasswolf@web.de>
Cc: Felix Fietkau <nbd@nbd.name>, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-next@vger.kernel.org
References: <20251217222622.8161-1-spasswolf@web.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251217222622.8161-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 4:26 PM, Bert Karwatzki wrote:
> As sizeof(hdr->build_date) is 16 we reading 17 bytes (sizeof(build_date))
> result in the following error:
> 
> [    T378] ------------[ cut here ]------------
> [    T378] strnlen: detected buffer overflow: 17 byte read of buffer size 16
> [    T378] WARNING: lib/string_helpers.c:1036 at __fortify_report+0x3e/0x50, CPU#15: kworker/15:1/378
> [...]
> [    T378]  mt76_connac2_load_patch.cold+0x2a/0x313 [mt76_connac_lib]
> [    T378]  mt792x_load_firmware+0x31/0x140 [mt792x_lib]
> 
> Fixes: f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index ea99167765b0..aca3d7870dce 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -3125,7 +3125,7 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
>   	}
>   
>   	hdr = (const void *)fw->data;
> -	strscpy(build_date, hdr->build_date, sizeof(build_date));
> +	strscpy(build_date, hdr->build_date, sizeof(hdr->build_date));
>   	build_date[16] = '\0';
>   	strim(build_date);
>   	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",

FYI - there's already a fix here waiting for a maintainer to pick it.

https://lore.kernel.org/all/CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com/

