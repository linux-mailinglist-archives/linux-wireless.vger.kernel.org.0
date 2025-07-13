Return-Path: <linux-wireless+bounces-25333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDB5B02F15
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 09:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE0B1895E9B
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 07:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0080A1D6DB5;
	Sun, 13 Jul 2025 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="S05NwZfz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204CC1AC44D
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391000; cv=none; b=ERmIDZ/aV2fDixYLU9SZb1EJPm6lX3yE2ol/2bphpYkGlQj9h2kh0HZFJFip/GcxL30r4u2G1qDe/5hAIEyfkQ892gz9+I6Bce/1lWP/DHstPxNyARWXItsrEj64RcBpxV3vLZd30wtM28PyhnZ7JBIjExbbLcuUaMdTgiNquCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391000; c=relaxed/simple;
	bh=HfZHTLzzuEQmXMzhwy+ZqqtMIF/uB8XjosxDmlFCl4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6JG7X5IPrEsSTHDtBsd0VWKapB7/3qK0DQ1jE1dQbL5w5rtnFYYOnOIFrz9Zzk7xWdGSG1LYwO1zNa+eGXAReKWfiV1ur8ZY7M/zgf8isoEiGgdO+UuA2WeMCb3NcIBmOPf+1IRJkSYe5dxUfwPcnvSlLtJB3YQ8BAV0UPH8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=S05NwZfz; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 33692 invoked from network); 13 Jul 2025 09:16:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752390996; bh=XHpjxRCC9oBEtCC7LwQSVhUBCtPG0Hfe6EOtEGtBLcc=;
          h=From:To:Cc:Subject;
          b=S05NwZfzm8j7SBsM1S7JM9VsSaBsYDaWFzDYYA0TVR7ogGAa+BzDGSB6kmHKfCTwu
           LCAeuNW0JWJpncdtTK+lGB2+d8+d0GgHe+9bFOkSffWV3UqDJkuWMdBAkiGqfrWpeZ
           qOnPX06lc0VTbW7gPPDLsLmH2aiHpn7HuZOn+rxBcJ929xuCj4oNm5HyK5c7d5OC9g
           Zf2FqDyrfZ9rFPDhsSahWQCp6uYyaDk6wSBb0RebkA8DcrQXuxBgPiOQcWkVhWvWfB
           Br2xfuKsAZXl4owxAaoiCghP7y62+IJUfLnd1Qr/rVlA87fMzgwy/A1JnGNk0mgOAW
           Lj1kGAgApiilA==
Received: from 89-64-3-180.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.180])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 13 Jul 2025 09:16:36 +0200
Date: Sun, 13 Jul 2025 09:16:35 +0200
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
Subject: Re: [PATCHv4 wireless-next 3/7] wifi: rt2800soc: allow loading from
 OF
Message-ID: <20250713071635.GB18469@wp.pl>
References: <20250712210448.429318-1-rosenp@gmail.com>
 <20250712210448.429318-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712210448.429318-4-rosenp@gmail.com>
X-WP-MailID: aea20ff63548b994e5d08e30c56a4aac
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0dNx]                               

On Sat, Jul 12, 2025 at 02:04:44PM -0700, Rosen Penev wrote:
> Add a single binding to help the already present dts files load the
> driver. More are possible but there doesn't seem to be a significant
> difference between them to justify this.
> 
> Use wifi name per dtschema requirements.
> 
> The data field will be used to remove the custom non static probe
> function and use of_device_get_match_data.
> 
> Added OF dependency to SOC CONFIG as adding of_match_table without OF
> being present makes no sense.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig     | 2 +-
>  drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
> index 3a32ceead54f..a0dc9a751234 100644
> --- a/drivers/net/wireless/ralink/rt2x00/Kconfig
> +++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
> @@ -202,7 +202,7 @@ endif
>  
>  config RT2800SOC
>  	tristate "Ralink WiSoC support"
> -	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
> +	depends on OF && (SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST)
>  	select RT2X00_LIB_SOC
>  	select RT2X00_LIB_MMIO
>  	select RT2X00_LIB_CRYPTO
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> index e73394cf6ea6..db8d01f0cdc3 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> @@ -243,9 +243,16 @@ static int rt2800soc_probe(struct platform_device *pdev)
>  	return rt2x00soc_probe(pdev, &rt2800soc_ops);
>  }
>  
> +static const struct of_device_id rt2880_wmac_match[] = {
> +	{ .compatible = "ralink,rt2880-wifi", .data = &rt2800soc_ops },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt2880_wmac_match);
> +
>  static struct platform_driver rt2800soc_driver = {
>  	.driver		= {
>  		.name		= "rt2800_wmac",
> +		.of_match_table = rt2880_wmac_match,
>  	},
>  	.probe		= rt2800soc_probe,
>  	.remove		= rt2x00soc_remove,
> -- 
> 2.50.0
> 

