Return-Path: <linux-wireless+bounces-26557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72800B310BD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 09:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D34AE3645
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17AD2E8B88;
	Fri, 22 Aug 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="ijoLieHq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9C2E229D
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848696; cv=none; b=C5jWUZIsKTwGGVtEnByS1ULsqEL6v2B57IF1enER4Q6amMa9SgcJXt4XfKoQZ2ZiZuTywavnylEIEvdm2zBow8Lhkh3EgCnpGEsi0VnU9tHv9mzKwAp0Ft78BXt1lGxntgtn9RJEcnE93+4If+aF08cIqlmkoR1Glre9E/Q7Tpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848696; c=relaxed/simple;
	bh=aO+BEQYJGFxiIbIwxLA23dTGTDkoeiaPCQsOtr9mmdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNLC+Hgk0o/isE1+NmoX5+L9aUPcTaA3wJ2mYwnkO1lEH53shQsLuamNJl09MZAqmh6JKFk/o+pRwKohuJBW4r/SQ48FH8UuJdLSBkXaJM0mEkVcnUqbzjdWTHTypH0AT6KEpB73oJGlhGZP814LZyNu0FKH4/RxvZNs+6wVk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=ijoLieHq; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 40998 invoked from network); 22 Aug 2025 09:44:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755848690; bh=7OdtT1Jfm2sPdVO2zP3rvPoNlCqI3vZd/g7+k+Deqa8=;
          h=From:To:Cc:Subject;
          b=ijoLieHqN1HXGX0ClsjbRPSbMbB6jxoUfylSSk6l9VPe3KQGrUlf1ed2jP26USZpD
           bFLmZRJHL2dQH8T0NmNERhMlDWZX3YbE6vzWdmjjdf6W/spA0zA4J80M+wUfDLKoIx
           YHRzS42Q64e2dW6SYUI/Wd2c9xgZ9IZCqYg/exsCjbDHE40/PhNPJmdFmCO1tCs/3v
           Z7lDuyFFNx3Jgwys3T+4JWC4vNSHlSTGXCLrneP5rqotWvK5Bk1mhYsNAgOB/b2HFZ
           ZG6r+Vq8AZSg8SrTNa2FNQGkj8tMIrf5ZtH8DjbUbayKOFpvs7iZbnNZ6s7z7h7lQU
           ZUsS4cZvZM/eg==
Received: from 89-64-9-131.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.131])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <zhao.xichao@vivo.com>; 22 Aug 2025 09:44:50 +0200
Date: Fri, 22 Aug 2025 09:44:50 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: rt2x00: Remove the use of dev_err_probe()
Message-ID: <20250822074450.GB46129@wp.pl>
References: <20250820085843.397945-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820085843.397945-1-zhao.xichao@vivo.com>
X-WP-MailID: e9e16a532b3768f79eedd2e7c2c1c36e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YbMB]                               

Hi

On Wed, Aug 20, 2025 at 04:58:43PM +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.

There is this comment regarding dev_err_probe:

 * Using this helper in your probe function is totally fine even if @err
 * is known to never be -EPROBE_DEFER.
 * The benefit compared to a normal dev_err() is the standardized format
 * of the error code, which is emitted symbolically (i.e. you get "EAGAIN"
 * instead of "-35"), and having the error code returned allows more
 * compact error paths.

If you want this change you have please justify it better, i.e.
we don't need to print error message because ...

Regards
Stanislaw


> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> index 8f510a84e7f1..e5c99fc6509b 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> @@ -289,7 +289,7 @@ static int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops
>  
>  	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
>  	if (!hw)
> -		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allocate hardware");
> +		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, hw);
>  
> -- 
> 2.34.1
> 

