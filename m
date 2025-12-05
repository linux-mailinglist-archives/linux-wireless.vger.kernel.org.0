Return-Path: <linux-wireless+bounces-29549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E7CA8BC7
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 19:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 933EC30056EB
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6652F25F0;
	Fri,  5 Dec 2025 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2F3PJ5o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E32F25E7;
	Fri,  5 Dec 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764958455; cv=none; b=uLGNQvagzGICb8X79CDuiZ3dS19Q1GtNkMP06+TWryj0+YGQnffE7knrcnj52aeKSbk7LYKpWQQIQyHMEG1YGiwplpfNm1Tgczx258BdAsDBLNGcXDy/xMyQBq1phfwWQ8XcyJjgF99BmNpUwzyWTyn9YpEKdeBxEIJgP6XeQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764958455; c=relaxed/simple;
	bh=IC1OejnZkEXWNzAlMQT0aeyZvGu2/TpM7WMNFr1ZJok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbHkg91JkMM3oOfRiEcfmo0WJHOTB0zeeqteaaPPO3vGr/RbK9LHvh6R0G0sZUzpikG74ETE9rBjW15PqyffskpJVK7XUK8fmIJoWIhMbePL7Rf2jAS6UVbupvcNl6sZ01wYsB1YUWR7/w1Jz+BJ9Dt7ikZrE1+Fdf+UjnJMuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2F3PJ5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30EBC4CEF1;
	Fri,  5 Dec 2025 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764958454;
	bh=IC1OejnZkEXWNzAlMQT0aeyZvGu2/TpM7WMNFr1ZJok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e2F3PJ5oMseZBHaaWI6083F2LvTe2UUiJKSk6FKo0bT8Hf9FK2evfCTzdXra6Y4kQ
	 q8l4HxSd+EbJoOI5wAuGgd3xP82dM5fmv7JNHeh6Csrvc9NfImQOaI86OCbrvNpjUr
	 EFwsD1cwOIvNcR6j5YKnOy2be/iD2qwm0V4QOj2qIKncdyKXyh1sUjFVFhoJKlSmnt
	 8H8L0OlMvGExJFjDg7zyEvWt94MR+Ol9OID8GP1vC0k7UUtaP6dvdFQuto3kuqr9Yz
	 lwJwM+7DdckMVUDHgie6GEeYzYxYxIuE9uTYJ2nD5QFmiuaMWpgTHP4EsviKo8FxqN
	 //a7/38xyCfQA==
Message-ID: <9547b5e9-e6e8-4b24-82ac-e38327a54c45@kernel.org>
Date: Fri, 5 Dec 2025 12:14:13 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mt76: Fix strscpy buffer overflow in
 mt76_connac2_load_patch
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com>
 <20251205161202.48409-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251205161202.48409-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/25 10:12 AM, Mikhail Gavrilov wrote:
> Commit f804a5895eba ("wifi: mt76: Strip whitespace from build ddate") introduced
> a kernel panic/WARN on systems using MediaTek MT7921e (and potentially others
> using mt76_connac_lib) due to an incorrect buffer size calculation.
> 
> The error logged is:
> "strnlen: detected buffer overflow: 17 byte read of buffer size 16"
> 
> This occurs because the field 'hdr->build_date' is a fixed-size array of 16 bytes.
> The patch allocated a 17-byte local buffer 'build_date' but used 'sizeof(build_date)'
> (17) as the read limit for strscpy, causing Fortify Source to correctly detect
> an attempt to read 17 bytes from the 16-byte source field.
> 
> To fix this, replace strscpy with memcpy, which is appropriate for raw data
> copying, and explicitly use the size of the source field (sizeof(hdr->build_date) = 16)
> to limit the read, followed by manual null termination.
> 
> Fixes: f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index ea99167765b0..d2c4c65ec464 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -3125,8 +3125,11 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
>   	}
>   
>   	hdr = (const void *)fw->data;
> -	strscpy(build_date, hdr->build_date, sizeof(build_date));
> -	build_date[16] = '\0';
> +	/* hdr->build_date is 16 bytes. Copy exactly 16 bytes to the 17-byte buffer,
> +	 * and then add the null terminator at index 16.
> +	 */
> +	memcpy(build_date, hdr->build_date, sizeof(hdr->build_date));
> +	build_date[sizeof(hdr->build_date)] = '\0';
>   	strim(build_date);
>   	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
>   		 be32_to_cpu(hdr->hw_sw_ver), build_date);


