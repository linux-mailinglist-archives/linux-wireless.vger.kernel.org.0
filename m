Return-Path: <linux-wireless+bounces-30599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DF8D080FA
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 10:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AE913054405
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6217330679;
	Fri,  9 Jan 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="Wix/oSe/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023EA218ADD
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949368; cv=none; b=Fm5OUyvcHShTjPg+EdBdwiNa5p15EZdsCI1kEvnhIvUP2S0X7tn9dg8ev1wavKljbHbPnvk5tGED8GdvMG5Zvb9YHZYRPaLcmVEIu318HlzNhOJYxcP1+dyx88V6L0FXTQ2+aMxIBwk1a7ZtgA8IGt7lneWgtMDSdqiOo6twVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949368; c=relaxed/simple;
	bh=xQ8+grcG06QD1Q4C8WtuUmerpKw9YJvgMKCRXTCT/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmkeCxeI8t7mPTjokSf+QIldn9XYgN3j9YcFBWBThiMaaVFsao7plHNgY5BU9hVamzpL1Rfi5+Ll/oxElNN1g9Iq0Pz2n5FvxA6b/9HJ1DYjgTPVLGM7ac77pWy6wpHgkrCERl22YuB1z1oJcfQO3yz1jjaAjtctiv1v+KjgqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=Wix/oSe/; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 42208 invoked from network); 9 Jan 2026 10:02:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1767949348; bh=RRfBtMQPhUJY5yA2JbypY0+yMfkyIIXFoRkKIfLJoto=;
          h=From:To:Cc:Subject;
          b=Wix/oSe/XKst1KTpV6DSeKE7S1lNIPLif6BE+aKpCqia9AKFswHSsYez+ZW7SCzCN
           lpnAmEIANOXaqOAlxIMXPv/UtdSsUSVuLOFdOV3DxFjnsrNkdv1IYd0tS5WR6Jq8Kw
           Ywa5LsLmI1XT6I90cF7fWvTv4x4QMpg4g9rrbcKenTKUYrkGoQZsOKdh8ZDOxpXKm6
           Z6IOatB/xOoZpI1GWhC/sNiC1fVxVtKyWde4B15szgakSun4frd252w6WQoMM88H5P
           ZlNpoVY4rhwNGVuh/69u7qMJBfXM2ZqD3jHLYkc00YtxeaPBNlacWdqv9xNTn0iDP7
           u27UMvDJuYPhQ==
Received: from 89-64-9-177.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.177])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <islituo@gmail.com>; 9 Jan 2026 10:02:28 +0100
Date: Fri, 9 Jan 2026 10:02:27 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Tuo Li <islituo@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] wifi: iwlegacy: 3945-rs: add a defensive WARN_ON_ONCE
 for il_sta in il3945_rs_get_rate()
Message-ID: <20260109090227.GA48150@wp.pl>
References: <20260109034014.187124-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109034014.187124-1-islituo@gmail.com>
X-WP-MailID: 42e53ab5e7fc937c426f05b08d1c6e07
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [IbJV]                               

Hi Tuo,

On Fri, Jan 09, 2026 at 11:40:14AM +0800, Tuo Li wrote:
> In this function, il_sta is not expected to be NULL. Add a defensive
> WARN_ON_ONCE() to catch this unexpected condition and aid debugging.
> 
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v3:
> * Replace plain NULL check with WARN_ON_ONCE() and update subject to better
>   reflect defensive nature of the check.
>   Thanks to Johannes Berg and Stanislaw Gruszka for helpful advice.
> v2:
> * Return early for uninitialized STA il data and align D_RATE messages with
>   il3945_rs_tx_status(). Add a wifi: prefix to the patch title.
>   Thanks to Stanislaw Gruszka for the helpful advice.
> ---
>  drivers/net/wireless/intel/iwlegacy/3945-rs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> index 1826c37c090c..463565ce14af 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> @@ -626,6 +626,9 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
>  
>  	D_RATE("enter\n");
>  
> +	if (WARN_ON_ONCE(!il_sta))
> +		return;
> +

Sorry for giving you wrong advice before, but after examining related code
I agree with Johannes the il_sta can not be NULL.
Now, I think we should just remove il_sta/rs_sta pointer check.

Regards
Stanislaw

