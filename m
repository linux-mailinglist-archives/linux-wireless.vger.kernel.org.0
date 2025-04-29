Return-Path: <linux-wireless+bounces-22180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908A6AA01A2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 07:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D1E84099A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 05:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81FE269D13;
	Tue, 29 Apr 2025 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFHmk+e2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666514D2A0;
	Tue, 29 Apr 2025 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745903072; cv=none; b=AhvmVM9Eyo7AspWv4xysWzSxz/3YK3ElqZZxkSopAQlDfe7aIVj6rJ2oo5Mz69siccPswDYUMseiFzDNYjA2ZF1hyj4ATnFgH6msT+6pHNyxnmILFj37FT7UhvqW7TzjS8AUACbiotYzARDcrdFJkeI+dcsKCa4U2P8wePrNH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745903072; c=relaxed/simple;
	bh=LNGtH5y4gw40TxiUmv6gMVCoBmYsea6D+tPHQZ/VOYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWkzhHEZONDLYSs57CsxB5VonZCY5SM/L0njl2VmX+FjNuzd4ZrwYf0cVNFFtnPrFX6M5CT+DKWJRWpNM3lL0E9jJi09u/wjcHmSQ/tdmAPk3nudykhHkpeDHHp1QbvijRn21WxCg8Wvo9V7GjYR97I3AA1XSchtxD+pORc8APw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFHmk+e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92EBC4CEE9;
	Tue, 29 Apr 2025 05:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745903072;
	bh=LNGtH5y4gw40TxiUmv6gMVCoBmYsea6D+tPHQZ/VOYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFHmk+e2MzCEXKYbax07J7v6Xy3PruLLpAgyRwRwRmETgolYZtm6yfAzuPcC+UnNP
	 n2+bjCqC0710KoQR7waiGj/6kbBTL6c9lk+pGDyeGhubWJv488CHsaS40ueeNB72Dl
	 3fU8+PhuLsYgjMpIOZmrGxoNiQ4rPARRjqCsia6TCaSR9vkT8c727mG6xwMz3LzKMo
	 b+9+n5gGdcgvYFVIW1fSCMvJary/KAenpGTV9LHyD4uBK8+o2odidmRW0y5gK+93cd
	 ruA5kkjwo07CSisgLV4HWwxgcYktijU4Rmy3mmAto1aoo3GLtAijZco4ya4XWgRtGi
	 2V2v48BCBAlVg==
Date: Mon, 28 Apr 2025 22:04:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Artur Rojek <artur@conclusive.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Subject: Re: [RFC PATCH 1/2] net: wireless: Add Nordic nRF70 series Wi-Fi
 driver
Message-ID: <20250429050430.GA7003@sol.localdomain>
References: <20250324211045.3508952-1-artur@conclusive.pl>
 <20250324211045.3508952-2-artur@conclusive.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324211045.3508952-2-artur@conclusive.pl>

On Mon, Mar 24, 2025 at 10:10:44PM +0100, Artur Rojek wrote:
> +static int nrf70_verify_firmware(struct device *dev,
> +				 const struct nrf70_fw_header *fw)
> +{
> +	struct crypto_shash *alg;
> +	u8 hash[NRF70_FW_HASH_LEN];
> +	int ret;
> +
> +	alg = crypto_alloc_shash("sha256", 0, 0);
> +	if (IS_ERR(alg)) {
> +		ret = PTR_ERR(alg);
> +		dev_err(dev, "Unable to allocate shash memory: %d\n", ret);
> +		goto out;
> +	};
> +
> +	if (crypto_shash_digestsize(alg) != NRF70_FW_HASH_LEN) {
> +		dev_err(dev, "Incorrect digest size\n");
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	ret = crypto_shash_tfm_digest(alg, fw->data, fw->length, hash);
> +	if (ret) {
> +		dev_err(dev, "Unable to compute hash\n");
> +		goto out;
> +	}
> +
> +	if (memcmp(fw->hash, hash, sizeof(hash))) {
> +		dev_err(dev, "Invalid firmware checksum\n");
> +		ret = -EFAULT;
> +	}
> +
> +out:
> +	crypto_free_shash(alg);
> +
> +	return ret;
> +}

You can just use sha256() here (and select CRYPTO_LIB_SHA256 from your kconfig
option).  It's much simpler than crypto_shash.

- Eric

