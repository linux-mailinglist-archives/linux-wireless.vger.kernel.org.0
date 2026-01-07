Return-Path: <linux-wireless+bounces-30422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5581CFC71D
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 08:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B81E3089CF2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA8F29D260;
	Wed,  7 Jan 2026 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="uAZx0+Z2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400D27FB3E
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771891; cv=none; b=OPSegspThT4XVrLm/j8YhbhD0nblW6JUD6KzdGpFEHHkf32GYW4774HJ983svsRc5OQ8XPsGvE2rZ5Xu97s56l4lSzMSWV4YtJJnrB+hnO5bYPMllj4g0CdmRb5jhA7bpAZgbpgcXkZRF3KpolAL+OsieRLh0ALQffF+b4WVHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771891; c=relaxed/simple;
	bh=1m57/q8TMFVJ9BfUyApaGgLWZ9oytPDqw4rNi/4UEhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKNW9OzzBEzxohvWJO9xuIGFYswbdZ8IEjnWbltq8Q1RJm+deukgG/Tyc1BF84pxoG+qCOjSyL7H2ueiHfTyGyDGrEOCsbe+W0JuDBQ4o6ik1YtFop82sZxWvKLVFjIKvcTK73zHqRDwHgVjg2YoaLJG/V//JMaWn5ng/l0fcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=uAZx0+Z2; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 40003 invoked from network); 7 Jan 2026 08:44:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1767771879; bh=Fe6W8fAQBOgadr93rAipk3Ar3uYh12YMNc1LT9BrA8Q=;
          h=From:To:Cc:Subject;
          b=uAZx0+Z2h4WrwUQ094C6Vwx+fyK2D0A327lGxfiXpgYGKBXBo0hFWuk0kT+UMSCck
           MZcBSPbw0a4cEUHxsMXdulMv/ZkcxizfTe/2uuRsGQ8wwJqy+gNsGk3ToY147Nkx0e
           4GpE77x9eWHyToNebUIKCfgjztSmuIzEkKZ/tR7tJtPb3c5y6ZBWvOMfs6skdgkEtt
           yQeZ8SL+cPxzMxLTdJLk6MTkSYbX1DvsY02LZeEuVKy/L985fHdr9/GHNEsrorraJ1
           V+xUE4mFZ90kfOqk3xfQvgsLe4yaEzKw6kOn3v11lEvUVQqOF5IoXbQuSQfQa16Q6g
           9b9eu1UdffzyA==
Received: from 89-64-9-177.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.177])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <islituo@gmail.com>; 7 Jan 2026 08:44:39 +0100
Date: Wed, 7 Jan 2026 08:44:38 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Tuo Li <islituo@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlegacy: 3945-rs: fix possible null-pointer
 dereferences in il3945_rs_get_rate()
Message-ID: <20260107074438.GA34085@wp.pl>
References: <20260107071001.172132-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107071001.172132-1-islituo@gmail.com>
X-WP-MailID: 2582bbe82f106bf9029adb0d6afe8e00
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [YYD1]                               

On Wed, Jan 07, 2026 at 03:10:01PM +0800, Tuo Li wrote:
> In this function, il_sta is assigned to rs_sta, and rs_sta is dereferenced
> at several points. If il_sta is NULL, this can lead to null-pointer
> dereferences. To fix this issue, add an early check for il_sta and return
> if it is NULL, consistent with the handling in il3945_rs_tx_status().
> 
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>  drivers/net/wireless/intel/iwlegacy/3945-rs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> index 1826c37c090c..c13268093a6e 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> @@ -626,8 +626,13 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
>  
>  	D_RATE("enter\n");
>  
> +	if (!il_sta) {
> +		D_RATE("leave: No STA il data available!\n");
> +		return;
> +	}
> +
>  	/* Treat uninitialized rate scaling data same as non-existing. */
> -	if (rs_sta && !rs_sta->il) {
> +	if (!rs_sta->il) {
>  		D_RATE("Rate scaling information not initialized yet.\n");
>  		il_sta = NULL;
Please also change to return here instead of setting il_sta to NULL.
And make D_RATE messages similar to il3945_rs_tx_status() i.e. :

          if (!il_sta) {
                  D_RATE("leave: No STA il data to update!\n");
                  return;
          }

          /* Treat uninitialized rate scaling data same as non-existing. */
          if (!rs_sta->il) {
                  D_RATE("leave: STA il data uninitialized!\n");
                  return;
          }

Thanks
Stanislaw


