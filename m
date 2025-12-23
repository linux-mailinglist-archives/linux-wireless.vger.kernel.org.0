Return-Path: <linux-wireless+bounces-30094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73780CDAB80
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE4243034A2C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F01313265;
	Tue, 23 Dec 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjFbg3Tx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743982ECD37;
	Tue, 23 Dec 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526877; cv=none; b=D5tOUh9ZNI8cbZk4JZoit6giXPHQu57BEBTkAOxY6WEBEB7T7tUYXOz2cJSdMNRSyP1HAKrF/ki3iEZbo7kN90SIek5w4jGfQIA+NvyFlZna2TPvNq1mb0N5vZFpGh3FnmeAyIXebYpYgmMbGlon8cVdNIGmK2Fx/VqGSl1Mp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526877; c=relaxed/simple;
	bh=WjBoMucTJzMCotHr+d+oZ2zQOT8QQxP/yyGSLmhTzPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KryHBizSgzHvppIfQMWFKbHFMhBdB+QlIqeEcpkO/SKahV9v+wQz7ZOWZab4/BUMA8LdNIfXx60Y50D9rW0FxQLPoz/hCwldP8EWCrGFVz0CCEYJLf9MG0hgn6cHzqBSKLq4xDXL+KUsHFLkM8JjGSNJU2MKUoPewQKus19IJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjFbg3Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEEAC113D0;
	Tue, 23 Dec 2025 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766526877;
	bh=WjBoMucTJzMCotHr+d+oZ2zQOT8QQxP/yyGSLmhTzPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjFbg3TxpD+h++93PzGsiIr29b5ENlY1dwH9QdhOD5X0AOUMdnpmIvAGQMG63xAG5
	 OlSbr6fg8ToRWZZf1EU3ABM1g04Aplc/gVoqJrCSkLFvyr2/VygHU8pZdweBg8jgsw
	 yP4KXezT1hhLdmYRYHkRcKsz2B6PG1Y0BTxn3Dv+qry5wQPHl3MtdEXBzUVrZXQWHp
	 I2/lBdpLFkp3f5OY1VY/iL7kco4P0rEMMw9IEgpniZgFYQJNInLmHjQTHXxZmb2d+M
	 1DQwu2kpg2Hu9afMUREFKSBEbaMGggjCRmcaiP/QEc/DzfJRdcjXq3ByKA4uy+Jk4j
	 vc5dVk6DhJ4zw==
Date: Tue, 23 Dec 2025 14:54:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: Fix strscpy buffer overflow in
 mt76_connac2_load_patch
Message-ID: <20251223215431.GA3327658@ax162>
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

+ netdev and wireless/networking maintainers

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

I got bit by this regression when installing v6.19-rc2 on my new test
machine, which has an MT7925 (RZ717) chip in it. I don't see this in
either Felix's or the main wireless tree yet but I do understand it is
the end of the year with breaks and such (along with Johannes not
actually being on CC since he is not in the output of get_maintainers.pl
for drivers/net/wireless/mediatek/mt76). If there is not going to be a
wireless pull soon, can this be applied to net directly so that it gets
to Linus soon? It was rather annoying to do a bisect for a regression
that already has a pending fix.

Tested-by: Nathan Chancellor <nathan@kernel.org>

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
> -- 
> 2.52.0
> 

