Return-Path: <linux-wireless+bounces-29253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A762FC7D27C
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 15:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53BCB34A811
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8D220687;
	Sat, 22 Nov 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I43rExh/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E8217F36;
	Sat, 22 Nov 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763821103; cv=none; b=Nnw7BHEOG5piNeB0gxWNGfaD8yPgqUE/ZQEHAsxgr2S7W8o2X++hs35/fq+h55ZU5aixCi6PHNWHPJxsAZbhWjzSn0mnwV4DZGIkf8KI9KwobCskr8A6l7wu+LepI0iMgKwIwgNBtpXG+F60gVdAJ0QoNmnD3Ii2vP+LQ4bSLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763821103; c=relaxed/simple;
	bh=KV9tYIxQM14TEhl6KK98HgFvA2JdX9m+AUWHHcj7A9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF2aJy6hXH9jdvvH8jz/sXhgL4pNIo4C0nvvFtVbW+zKdbMm16/+tIM8oe8853RdHNmXWZUy7CEMam1Gm/5aOt5rtUVH4YaLra1Af4QgHskHgu+/OogHknbqZ3Q6jGdhCBe635XinWo0J5+1DwHveaf8NOdzaqZE+X7w0yHgKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I43rExh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047D2C4CEF5;
	Sat, 22 Nov 2025 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763821103;
	bh=KV9tYIxQM14TEhl6KK98HgFvA2JdX9m+AUWHHcj7A9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I43rExh/ImDqf7jsmxiI6Hq8Q9azPgm7OB2HyEM2A4teCnuMtVUWeCDN8bitcwPie
	 5Cs87WMFlf9wDE4b/sdh+csAqD6d2zlJtEpKpozfgpK9sj/tG+31drxuCZKGm+cUUZ
	 VH3TGP2HUAO1Ajg/8VjNEbK+ztsiPGuGISKovFuAAyab6hj0qOaJ/86CliZKOl840F
	 /0l73/vid3J0wLSrIlKIbwciO+fElZj5j8jtwxVXGnviH2OgrMy6IPi1e3li73UiUz
	 pIELoG+T46Du2/OfV7vs7DKkJV2YXcR4YOAwuVdKPyawIO0XkFJ8W29Jk9zM8KTzJ5
	 AuwDZvK0l+9yQ==
Message-ID: <a9e12ace-dc0e-4bac-9775-72cd7d477169@kernel.org>
Date: Sat, 22 Nov 2025 15:18:20 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND iwlwifi-next] wifi: iwlwifi: mld: remove unused
 variable in d3.c
To: Ally Heev <allyheev@gmail.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251121-aheev-remove-unused-var-old-keys-v1-1-6c2565c77ef7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2025 15:27, Ally Heev wrote:
> remove unused variable `old_keys`
> 
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mld/d3.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> index 1d4282a21f09e0f90a52dc02c8287ecc0e0fafe1..fefb4f532a1f9fbb1a4a5cbd2ade817d5c1adb58 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
> @@ -996,8 +996,6 @@ static void iwl_mld_mlo_rekey(struct iwl_mld *mld,
>  			      struct iwl_mld_wowlan_status *wowlan_status,
>  			      struct ieee80211_vif *vif)
>  {
> -	struct iwl_mld_old_mlo_keys *old_keys __free(kfree) = NULL;
> -
>  	IWL_DEBUG_WOWLAN(mld, "Num of MLO Keys: %d\n", wowlan_status->num_mlo_keys);
>  
>  	if (!wowlan_status->num_mlo_keys)
> 
> ---
> base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
> change-id: 20251111-aheev-remove-unused-var-old-keys-104ffca9bf62
> 
> Best regards,
> -----BEGIN PGP SIGNATURE-----
> 
> iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaRLyowAKCRCWPaLUP9d7
> HLG9AQDZmggT93tMLv32pq5myG3e83t12KWON9efOBg//lH4vgD+Ppw3KoTpdYtJ
> 20VDaWuqUVj9KLqjx9hblfEiB7s9gQw=
> =A6F+
> -----END PGP SIGNATURE-----

You should switch to patatt instead, not signing emails. We don't use
that, I think at all, unlike patatt which is being actively checked by
toolkit (b4).

Anyway, not a problem, just noise, so:


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

