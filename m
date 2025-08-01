Return-Path: <linux-wireless+bounces-26077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEEB18057
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 12:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 828357B1BD6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1B2367A8;
	Fri,  1 Aug 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="1VmYqi3x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB923536A
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044998; cv=none; b=erbwi7xlG/3kOqNYwzTpVlLDkyzcW+BFsStDT88LuhORusUeFHFcsUQ8HXUv9isF/On91K0X7BY3zLCHY2WiV8Wpy7bCUAKahSsxswrrFVnClKd5HUGs36yI39h7/xh15FNj1DHSqYdKHH45Lj20em/UpfEPQEz8TYx7TWfbDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044998; c=relaxed/simple;
	bh=vdGghAuRqFh9v9OKtYjOGn/D80mvNRjAfBd2IBvyKbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ4qSpanzsHKxnK1lQnquaPRuQlVg08YECEBI09EymWMak95LwxJrqeJrzPJ6r/EhJItCZEnU6D8+Jo4KWqgh0FudWuoXsMH3ZNRcOuBgEh95AcqnxP5yssZ/qYE6kt9FmYovi+LqpDxo+BXlR3zgzwgPt/fkM3Bs278kbdyXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=1VmYqi3x; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 44112 invoked from network); 1 Aug 2025 12:43:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1754044985; bh=S8Xh4dwltKo48ODYTlU5bLdmTB5/mPSV+B2vDyT/wTg=;
          h=From:To:Cc:Subject;
          b=1VmYqi3xIM+gs+DDDQ3Vcx6jGfXAwH/D9iz4hnq5A3xEnbPOjQhJouvOzTJQLBCow
           /Noa5yMFh7ySZEkxlRM3dbtGsJ/i1obMfDxwnJWvdbWDuwaqzV7jFmpyD+jEp62nsC
           hhfyjr1IbLtSa8A+vjWKjqLKWk0sbxlPhiLShPjUA2sVzrx7vHeI6nKUpFg/+d4iYO
           76Qr0qHA0VtbPzqAmwcO9vufmPujoFK8rONfogZFwhkfo4ToMwu3HpemYt/DDzninp
           sEuTq7Q507woM2uFtykEFEiBsA5/XeyP4hflwYs40gBAiYQoPbndzPkeHEnUMd47Ak
           UiER5HasZZ8QQ==
Received: from 89-64-3-229.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.229])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@kernel.org>; 1 Aug 2025 12:43:05 +0200
Date: Fri, 1 Aug 2025 12:43:04 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, Johannes Berg <johannes.berg@intel.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wireless: rt2x00: fix CRC_CCITT dependency
Message-ID: <20250801104304.GA120216@wp.pl>
References: <20250731075837.1969136-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731075837.1969136-1-arnd@kernel.org>
X-WP-MailID: 59c87c2862a208fdaded71fd867ec669
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [UZMB]                               

On Thu, Jul 31, 2025 at 09:58:33AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compile-testing this driver on Arm platforms shows a link failure
> when the CRC functions are not part of the kernel:
> 
> x86_64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_check_firmware':
> rt2800lib.c:(.text+0x20e5): undefined reference to `crc_ccitt'
> 
> Move the select statement to the correct Kconfig symbol to match
> the call site.
> 
> Fixes: 311b05e235cf ("wifi: rt2x00: add COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
> index d66fc839c3ce..17f063fc0b57 100644
> --- a/drivers/net/wireless/ralink/rt2x00/Kconfig
> +++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
> @@ -66,7 +66,6 @@ config RT2800PCI
>  	select RT2X00_LIB_PCI
>  	select RT2X00_LIB_FIRMWARE
>  	select RT2X00_LIB_CRYPTO
> -	select CRC_CCITT
>  	select EEPROM_93CX6
>  	help
>  	  This adds support for rt27xx/rt28xx/rt30xx wireless chipset family.
> @@ -142,7 +141,6 @@ config RT2800USB
>  	select RT2X00_LIB_USB
>  	select RT2X00_LIB_FIRMWARE
>  	select RT2X00_LIB_CRYPTO
> -	select CRC_CCITT
>  	help
>  	  This adds support for rt27xx/rt28xx/rt30xx wireless chipset family.
>  	  Supported chips: RT2770, RT2870 & RT3070, RT3071 & RT3072
> @@ -217,6 +215,7 @@ config RT2800SOC
>  
>  config RT2800_LIB
>  	tristate
> +	select CRC_CCITT
>  
>  config RT2800_LIB_MMIO
>  	tristate
> -- 
> 2.39.5
> 

