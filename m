Return-Path: <linux-wireless+bounces-30430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EC3CFCB36
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 10:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C216C30022EA
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F224E4B4;
	Wed,  7 Jan 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="ajWcDGAn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C02EB5CD
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776401; cv=none; b=WmzOAUZUEsxs/cOilC7lwNICdB2K7UzT6TzQL73f6cimWExpdKHa8JHKHT9KM5g4d3RIORH9Ug91Cddl++cKuDO6ML9O2TqDwQ5SwtbdD91DvsuhJyV5+3dqqOkjngRMNfLTJ8NOTDCxf6FyrBNkuO6iVXv1burSjsat69NkLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776401; c=relaxed/simple;
	bh=G01bw8VodzuEhXVLxUpWrkZQy2RRY/bfUMnHSxC/oX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcOSPdD3ECv691gy+1AXou42eMOMCLY6u7MiIfdzcIJf+qmp/QgEOUfiEVR2fXZ1WR3r1NscecAipSxK2jaAZpPGTxwq3CUMtAdAJyem+zsg/+d8Fj7/096m9b8H/1JYxx7eFOUbFY+XQdsEbljUVyQp8kVO19zSauTrrVHtUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=ajWcDGAn; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 31647 invoked from network); 7 Jan 2026 09:59:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1767776390; bh=biprdf4NEHgzmjxcS6k4/ivu+RhzDzUbVcbuXvqvFnM=;
          h=From:To:Cc:Subject;
          b=ajWcDGAnMGqIt66vbOAH0mOyZNIwe/Pxvm/TWT4rTdMmqhhUYSKVQGnFVwazDdrKJ
           NLDW4/wjPecPgixnmjgqh0U5m6f1oANq/6S9ORde+x+Q7dT3XM2EN3syUYDLAmQk5Q
           Owlp8lV8nmzNYnf3ltq88BoR2rWdLTqFWJCfDVK7ieu65MlsKs4MFPKtlghAk9nWNh
           GFe0g6kL8C1ZO7eyssMRXkGrHOJ+vfnnNNoKyWIMOa5QIbd1qSjWQJZlhfytsWaayg
           /O9W788e4wAUv+OItaWXtYD9l0vaS1xvMrjeA/lw2oV0XrIniDJzKEyPH3iHY6CFuK
           CAXwfjz/0T84A==
Received: from 89-64-9-177.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.177])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <islituo@gmail.com>; 7 Jan 2026 09:59:50 +0100
Date: Wed, 7 Jan 2026 09:59:49 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Tuo Li <islituo@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlegacy: 3945-rs: fix possible null-pointer
 dereferences in il3945_rs_get_rate()
Message-ID: <20260107085949.GA35258@wp.pl>
References: <20260107084149.173289-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107084149.173289-1-islituo@gmail.com>
X-WP-MailID: e9fd3caef925315737ca5eefda8df96d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [IbDF]                               

On Wed, Jan 07, 2026 at 04:41:49PM +0800, Tuo Li wrote:
> In this function, il_sta is assigned to rs_sta, and rs_sta is dereferenced
> at several points. If il_sta is NULL, this can lead to null-pointer
> dereferences. To fix this issue, add an early check for il_sta and return
> if it is NULL, consistent with the handling in il3945_rs_tx_status().
> 
> Besides, if the STA il data is uninitialized, return early instead of
> setting il_sta to NULL, consistent with the handling in
> il3945_rs_tx_status().
> 
> Signed-off-by: Tuo Li <islituo@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks
Stanislaw
> ---
> v2:
> * Return early for uninitialized STA il data and align D_RATE messages with
>   il3945_rs_tx_status(). Add a wifi: prefix to the patch title.
>   Thanks to Stanislaw Gruszka for the helpful advice.
> ---
>  drivers/net/wireless/intel/iwlegacy/3945-rs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> index 1826c37c090c..c509c89bba00 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> @@ -626,10 +626,15 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
>  
>  	D_RATE("enter\n");
>  
> +	if (!il_sta) {
> +		D_RATE("leave: No STA il data to update!\n");
> +		return;
> +	}
> +
>  	/* Treat uninitialized rate scaling data same as non-existing. */
> -	if (rs_sta && !rs_sta->il) {
> -		D_RATE("Rate scaling information not initialized yet.\n");
> -		il_sta = NULL;
> +	if (!rs_sta->il) {
> +		D_RATE("leave: STA il data uninitialized!\n");
> +		return;
>  	}
>  
>  	rate_mask = sta->deflink.supp_rates[sband->band];
> -- 
> 2.43.0
> 

