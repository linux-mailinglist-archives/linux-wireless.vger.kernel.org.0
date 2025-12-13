Return-Path: <linux-wireless+bounces-29722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3BCBA360
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 03:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3F53028FEA
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Dec 2025 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0440A2E0405;
	Sat, 13 Dec 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuoChyv5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF22DEA98;
	Sat, 13 Dec 2025 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765593346; cv=none; b=CoXxvvg6MWKgMfheo0sf6LjofnSyU7pHgrOIRBkSR8G5UcHkfI29IXplUh2o3nm0rhZZtfIVQN4m3KYBUdJ1IdK0Kr3aD0rrKHVbrdYut9/LbS9U2KEm32AEemqPOhgESB4kB8llRghdV1W/LQ+bN9Uq9Ly6mYXqf2Yfrr5EQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765593346; c=relaxed/simple;
	bh=hR43q9+HkHjR+LZRB0QtBbOiMrh52IpHxBRNvie6MiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0MmhZmMLhaI73JGXcAvZkb3MkX5c/A0gl37lB5v8jDt4SPH36o/B9tZw+B9XX34ktId/Ab5YSEcgqqoe9lErDaOW7Y+FTmdVKrJRT4NzDi9Dmpi++gSMvf0FhZJd7k6HacOxHIkx/e393+cl1EAFRXHF0OZxBEGgGXkyhaH1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuoChyv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99793C4CEF1;
	Sat, 13 Dec 2025 02:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765593345;
	bh=hR43q9+HkHjR+LZRB0QtBbOiMrh52IpHxBRNvie6MiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuoChyv5ovIuvuFd9n6ukkQbS7RE0sPBst+U2nDFzXoydZhTieSP2kiPs153KYdmp
	 NCh/YJTSz9ikyn7AkXisXZ4Q9pAwETFum/3agIiHl2c8frW2987jeYnwrR/suroCwe
	 hOueackFgCc26Alz8KsMv8WrBb2SHex5QAvlE/IwH0uSNGv6RzeDxGdPnCe+DLcXRW
	 agrwtptNt9BQf+gwcICNmUJ5PIjRy5Kmrbzfo+o13A5Pf0CtpT0tX8RLGlu15ZZRWw
	 9E0lqQrtEP2kOMA/pDUdX63KFebZbAwqZL+Q6eGH/FF9rmiWVrVLmRWha/Qzh/OKxU
	 hvsGiaEChn0ww==
Date: Fri, 12 Dec 2025 18:35:39 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: Fix strscpy buffer overflow in
 mt76_connac2_load_patch
Message-ID: <20251213023539.GC71695@sol>
References: <CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com>
 <20251205161202.48409-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205161202.48409-1-mikhail.v.gavrilov@gmail.com>

On Fri, Dec 05, 2025 at 09:12:02PM +0500, Mikhail Gavrilov wrote:
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
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index ea99167765b0..d2c4c65ec464 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -3125,8 +3125,11 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
>  	}
>  
>  	hdr = (const void *)fw->data;
> -	strscpy(build_date, hdr->build_date, sizeof(build_date));
> -	build_date[16] = '\0';
> +	/* hdr->build_date is 16 bytes. Copy exactly 16 bytes to the 17-byte buffer,
> +	 * and then add the null terminator at index 16.
> +	 */
> +	memcpy(build_date, hdr->build_date, sizeof(hdr->build_date));
> +	build_date[sizeof(hdr->build_date)] = '\0';
>  	strim(build_date);
>  	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
>  		 be32_to_cpu(hdr->hw_sw_ver), build_date);

Tested-by: Eric Biggers <ebiggers@kernel.org>

Can this be sent upstream soon?

- Eric

