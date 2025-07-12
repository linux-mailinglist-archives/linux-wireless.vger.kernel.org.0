Return-Path: <linux-wireless+bounces-25309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E87B02A2D
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 10:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E764E197A
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EDD273D62;
	Sat, 12 Jul 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="WKjhJ3Md"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6FE2F42
	for <linux-wireless@vger.kernel.org>; Sat, 12 Jul 2025 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752310780; cv=none; b=JLI0lnk0pDQ4tEGxp7C6jzJx/sfOhdM+J9PnqjKDd5Li5Kj3suK6N/xXl3SVTofg96MxxUPS1m+BHGVBirSZFL2jlBykszyWoNRw6fv7Zzp6AmX3/9/pYsxyyKPZI2Unbd3xfECtmokB7rzybXHJq9glbY3cqLuIMCLDbGFiD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752310780; c=relaxed/simple;
	bh=6RREnLfBr6vaToFnee4iQdKCEbQ4E+5QoB/pAJOaHzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNGaISZ8dj2NoknlXNWP0UPfx3AW6tLeIrU8OTwEZ25qhXGD3TZOcUqEHvpJ6fqx/Br3rW1Z00HbhohRvWV56dVtJblrYjrS6DnRWbB2gLqKEmN9vata0sB28TIlpRIo0udI8Ckq+HoEim6cRquVwdDNyPsSmkuKCyOr6BQY0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=WKjhJ3Md; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 13802 invoked from network); 12 Jul 2025 10:59:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752310767; bh=eSJuXP2Tn8QwaAeo4iI9YXDlY+NdjeXSDkoE+IE9RBA=;
          h=From:To:Cc:Subject;
          b=WKjhJ3Mdixt+XahfZtVpGIKxNl6vwCFnCrUmv1nrBUwefTsoSFzzP4njmWdxKBG/H
           4bffCe3DN9oy8hanhud3aXVyt8L2o9/zJgSVjtZ+Wy2K0vJkYBn1cvX25Q58jiafFR
           8k5pziuwtMYlyodb8k4SJA2EHysbLGfP6EjZtUA8B+hNcosbxLonJDC14OSgwNa8FT
           NEWO9CosPdk7R0ibPT6gBZdd9xRGwUgQUcst0ilt6SBq/+sKBlt79iHxBDNwvu6N0F
           WrVINziE9wyjtoNtxYpqnm5Wv+o9QAqEMkInOBskZnEe+VVYbumVWup7ki+AiFIZBs
           kCltJzhUOGttQ==
Received: from 89-64-3-180.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.180])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 12 Jul 2025 10:59:27 +0200
Date: Sat, 12 Jul 2025 10:59:27 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCHv3 wireless-next 1/7] wifi: rt2x00: add COMPILE_TEST
Message-ID: <20250712085927.GA9845@wp.pl>
References: <20250710200820.262295-1-rosenp@gmail.com>
 <20250710200820.262295-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710200820.262295-2-rosenp@gmail.com>
X-WP-MailID: fa94b3e93e05bf3e9316b9cc31b4a93a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [wTOh]                               

On Thu, Jul 10, 2025 at 01:08:14PM -0700, Rosen Penev wrote:
> While this driver is for a specific arch, there is nothing preventing it
> from being compiled on other platforms.
> 
> Allows the various bots to test compilation and complain if a patch is
> bad.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
> index d1fd66d44a7e..3a32ceead54f 100644
> --- a/drivers/net/wireless/ralink/rt2x00/Kconfig
> +++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
> @@ -202,7 +202,7 @@ endif
>  
>  config RT2800SOC
>  	tristate "Ralink WiSoC support"
> -	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620
> +	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
>  	select RT2X00_LIB_SOC
>  	select RT2X00_LIB_MMIO
>  	select RT2X00_LIB_CRYPTO
> -- 
> 2.50.0
> 

