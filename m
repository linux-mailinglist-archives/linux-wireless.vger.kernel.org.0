Return-Path: <linux-wireless+bounces-13048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0809597D3EB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 11:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A864C1F228A9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C125776;
	Fri, 20 Sep 2024 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="siai8Gt3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B54317C
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726826100; cv=none; b=UsaFBBKVSb6pz26nUn1Jyqk/h5mQgsFTcjY0bLU0vvm/tyDsmRgsMfIbu10wg4CAMaJeR6Ra1Zypl2yLIrU/AOAFAjv3hUuSShDwlhcMOmVtMub2pivAgfHuRQNk3I5MvsMfLiAWuSkaE/iacSuOnaj8MxAvgmIAnkYFRbbguNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726826100; c=relaxed/simple;
	bh=mxYgAn+a0wVE1Kp5E/hPaQWf086VSZFYYbg3z9ovlNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U80U7bJrtKqQ+cgmGoMoPFvcgzGyPOUXd8nZCvAfoywOmIT07fqM9d5irRV6xNSo4ugHI0gEF6IBXCJI8fv/ys3TeaMaWpFbY9MsLwDbL+dmD+wmazo52gkM9ww8xeIjwWS3wACnUPo4VXKwgWDyDRFLtx8Kvd8PCfOTwm5XKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=siai8Gt3; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 22415 invoked from network); 20 Sep 2024 11:54:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1726826089; bh=VJn/uDEMspLYV2fn6/GPDktvV6tSMLAKuEhNpNytZXc=;
          h=From:To:Cc:Subject;
          b=siai8Gt3V66jxoeOBJj1V/b08gZH2Sjti9Z/eqK9+93X4hV4WKos3Y8uWyi4JIxSx
           xvvusnGY0gFrJXbD9RkhuYZdovf53Y0NaYffq534QVk5JU9cM2O6htcYYpXi3z9hpC
           enP8V8BCBA4y6yoZoLvs37mZCFpt1w+qkuNkMIrg=
Received: from 89-64-14-248.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.14.248])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yanzhen@vivo.com>; 20 Sep 2024 11:54:49 +0200
Date: Fri, 20 Sep 2024 11:54:48 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Yan Zhen <yanzhen@vivo.com>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] wifi: rt2x00: convert comma to semicolon
Message-ID: <20240920095448.GA20424@wp.pl>
References: <20240920025917.1959932-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920025917.1959932-1-yanzhen@vivo.com>
X-WP-MailID: 04474890552c4e224df9f75495f0b2be
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kXNE]                               

On Fri, Sep 20, 2024 at 10:59:17AM +0800, Yan Zhen wrote:
> To ensure code clarity and prevent potential errors, it's advisable
> to employ the ';' as a statement separator, except when ',' are
> intentionally used for specific purposes.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index 3bb81bcff0ac..60c2a12e9d5e 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -3607,7 +3607,7 @@ static void rt2800_config_channel_rf55xx(struct rt2x00_dev *rt2x00dev,
>  			rt2800_rfcsr_write(rt2x00dev, 52, 0x0C);
>  			rt2800_rfcsr_write(rt2x00dev, 54, 0xF8);
>  			if (rf->channel <= 50) {
> -				rt2800_rfcsr_write(rt2x00dev, 55, 0x06),
> +				rt2800_rfcsr_write(rt2x00dev, 55, 0x06);
>  				rt2800_rfcsr_write(rt2x00dev, 56, 0xD3);
>  			} else if (rf->channel >= 52) {
>  				rt2800_rfcsr_write(rt2x00dev, 55, 0x04);
> -- 
> 2.34.1
> 

