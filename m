Return-Path: <linux-wireless+bounces-18516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40230A288E5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F3188869F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FF01519A0;
	Wed,  5 Feb 2025 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bYLsH0Pe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB47151995;
	Wed,  5 Feb 2025 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753826; cv=none; b=OQrSW0LgSZeONOyeTzSgdZ8nVo0Ri/4W/z92pH9Nt12ZAdMV54Rork9kD0MwlAKSAZJpqUMtuAljYFtsTw+Lpz/I8sF6otLlWBRLRQEno5QThFLn8wScAvjBvLahw1/5SHxHVrIKZ0IGeZZL2tb1Uxq2u614u9q7ku6wfxx8NLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753826; c=relaxed/simple;
	bh=WHS1z4S2pW9TUixaKFqSRj95qxK9MEieGBVP9HebYHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tkn+lBnQT2a7zPZEIL8tG20pMEm120pL0yn0LnqrEDJ73AxGeUlBRzIfqZdLoRrcXKJjVSJ9xjPsCc4dzp1Lj/90gB8haAXc5aogL7l+ZKJlTyb7oCEmKMAuGNGuhOPWc2dI8qLPTBkXvRH3xqexdK2/1rQ5fh1VYsRDJ/iIJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bYLsH0Pe; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lSa38rUrscbTFzyMkucxLavPbKPbT/c+ByJbj4TeKKo=; b=bYLsH0PeEzYqIve54qUrIJKU9A
	v5ns7mkJkI/kUpfqU6oc3A5REOG8Rnrg80JMzEmKa6uXjE6uRUoaOUhHhI9vAfdJThd2RB9Z3y5Ag
	3TE7dxfnY7BqGnKK6/2752HlvwgmMu6gg00ao0d/+fq3U437AgQZ7QX2vmKn5gaFtrJ8g1I1joCQC
	WM/EIJDx9VcPSzudbv9Rjn0mDG2F9yV2H2UqXeCP4U8Tg5iTO7wcJYF+K9qHQ3QoCT84m8HO6uDjO
	WA0SunR1W5LHL06dp82ciLqEjMN5zgqaHNEuxpmsgaoAvv+9ghGWDxf5uiNq1L3IXZbcJ7gHVjIDY
	sVlLrGRg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1tfdIJ-001rDS-PV; Wed, 05 Feb 2025 11:10:12 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 21C64BE2EE7; Wed, 05 Feb 2025 12:10:11 +0100 (CET)
Date: Wed, 5 Feb 2025 12:10:11 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: wireless: broadcom: b43: Replace outdated
 firmware URL
Message-ID: <Z6NHE0cL2SaIiJbi@eldamar.lan>
References: <20250205110614.216958-1-carnil@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205110614.216958-1-carnil@debian.org>
X-Debian-User: carnil

On Wed, Feb 05, 2025 at 12:06:14PM +0100, Salvatore Bonaccorso wrote:
> https://wireless.wiki.kernel.org site now redirects to
> https://wireless.docs.kernel.org/en/latest/ making the reference
> information for the b43 firmware inaccessible. Update the URL to the
> current location.
> 
> Link: https://bugs.debian.org/1095062
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  drivers/net/wireless/broadcom/b43/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
> index 25b4ef9d3c9a..7529afd24aed 100644
> --- a/drivers/net/wireless/broadcom/b43/main.c
> +++ b/drivers/net/wireless/broadcom/b43/main.c
> @@ -2166,7 +2166,7 @@ static void b43_print_fw_helptext(struct b43_wl *wl, bool error)
>  {
>  	const char text[] =
>  		"You must go to " \
> -		"https://wireless.wiki.kernel.org/en/users/Drivers/b43#devicefirmware " \
> +		"https://wireless.docs.kernel.org/en/latest/en/users/drivers/b43/developers.html#list-of-firmware " \
>  		"and download the correct firmware for this driver version. " \
>  		"Please carefully read all instructions on this website.\n";
>  
> -- 
> 2.47.2

FWIW, I think there are more such outdated references and should be
updated to the current docs location.  So feel free to reject this one
in favour of a better ovehaul.

Or maybe the old locations could be redirected to the new place?

Regards,
Salvatore

