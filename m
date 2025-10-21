Return-Path: <linux-wireless+bounces-28132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C7BF5C0F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 12:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8029C3A5439
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9180320391;
	Tue, 21 Oct 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="hU6Z46wj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF22EA17D
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042133; cv=none; b=enZb0g5Vf8lAVMuBlrO377epvb/CmW/Ld1sZsEEApzo3anS6I4m0IIGGHsHdYhtjP2m4nNbo2DryZ8Oa0UQ3Ug6MevoJVKbgyAjzmyp8suIZ/gqHT1086aU6w9qs7pgfQdliCYPrZ/+sR/YbO75piDlFznyrfRzePzXs8g2bUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042133; c=relaxed/simple;
	bh=jOWFbBkmo9QcpQZXDKONhCCGG1D62pkQPjUSP9O+sIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBRE4x249rP9licv48GtZ49mAyfIY2azIIqI8GSfp2r6WLof+Kp1d4Eg/EfPn8u0XB5jAB0l0gbq7BqH8Vcw/psBwNEv/LS0XYxHVMsYkKwpWPHG0RabGDOah2oyPOEvJlf18lrfdpLgNvvW3uj79HM/cLruDLRgZEqcqfosMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=hU6Z46wj; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30124 invoked from network); 21 Oct 2025 12:22:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1761042120; bh=SF6LoAXfZ7sHzYrQeTZS5IqAbBi9Ehzr8C6mmjUXlSU=;
          h=From:To:Cc:Subject;
          b=hU6Z46wjQqZI4Pmno7++IBcA9vPzzs6Rvw041D29d0QOmSyrdp2F+JXE/ujepE9Vm
           +RLHfcNHH0grj4p9dF7BPeJHT+kQ3LuXDWjFX2dvrJC+zo//1JJ7L9ZLUB87afup9W
           lwpVmIqZWazLbSgEDRzEGKch1aspA9DePhCgRvIaLBVsFmP+APcFkzWZyrzQjPuP1+
           1Ovy5FRieZHDV/aDVTDYnxxhXTOUtOd7fdHKcc8VhfM8LWKa2QV2JcoUglyJFa9s9J
           W5/zz2Zx94fjFeVVQhSB0O+siQlcoxLFxh2KiZslcRMZdloaNbWKv/dex+U3px01Gp
           DWclhKi7JMDZA==
Received: from 89-64-9-53.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.53])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 21 Oct 2025 12:22:00 +0200
Date: Tue, 21 Oct 2025 12:21:59 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rt2x00: check retval for of_get_mac_address
Message-ID: <20251021102159.GA14793@wp.pl>
References: <20251014050833.46377-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014050833.46377-1-rosenp@gmail.com>
X-WP-MailID: 70b5e08b3428e12d1b1a4af11f1c2643
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [geOx]                               

Hi

On Mon, Oct 13, 2025 at 10:08:33PM -0700, Rosen Penev wrote:
> of_get_mac_address can return -EPROBE_DEFER when nvmem is not probed yet
> for whatever reason. In this case, nvmem mac assignments will not work.
> 
> Based on the function path, this change only has effect for rt2800soc.c
> and rt2800pci.c. The former tends to use nvmem for assignments.

What you mean? The USB probing also goes through
rt2800_validate_eeprom().

> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Anyway patch looks ok for me.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c |  4 +++-
>  drivers/net/wireless/ralink/rt2x00/rt2x00.h    |  2 +-
>  drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 10 ++++++++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index b312b40f4aa3..af19153697ed 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -11010,7 +11010,9 @@ static int rt2800_validate_eeprom(struct rt2x00_dev *rt2x00dev)
>  	 * Start validation of the data that has been read.
>  	 */
>  	mac = rt2800_eeprom_addr(rt2x00dev, EEPROM_MAC_ADDR_0);
> -	rt2x00lib_set_mac_address(rt2x00dev, mac);
> +	retval = rt2x00lib_set_mac_address(rt2x00dev, mac);
> +	if (retval)
> +		return retval;
>  
>  	word = rt2800_eeprom_read(rt2x00dev, EEPROM_NIC_CONF0);
>  	if (word == 0xffff) {
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> index 0b67b09695b6..4d6437deaa9a 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
> @@ -1416,7 +1416,7 @@ static inline void rt2x00debug_dump_frame(struct rt2x00_dev *rt2x00dev,
>   */
>  u32 rt2x00lib_get_bssidx(struct rt2x00_dev *rt2x00dev,
>  			 struct ieee80211_vif *vif);
> -void rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr);
> +int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr);
>  
>  /*
>   * Interrupt context handlers.
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> index ee667e1a7937..4af132acadb6 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
> @@ -984,14 +984,20 @@ static void rt2x00lib_rate(struct ieee80211_rate *entry,
>  		entry->flags |= IEEE80211_RATE_SHORT_PREAMBLE;
>  }
>  
> -void rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
> +int rt2x00lib_set_mac_address(struct rt2x00_dev *rt2x00dev, u8 *eeprom_mac_addr)
>  {
> -	of_get_mac_address(rt2x00dev->dev->of_node, eeprom_mac_addr);
> +	int ret;
> +
> +	ret = of_get_mac_address(rt2x00dev->dev->of_node, eeprom_mac_addr);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;
>  
>  	if (!is_valid_ether_addr(eeprom_mac_addr)) {
>  		eth_random_addr(eeprom_mac_addr);
>  		rt2x00_eeprom_dbg(rt2x00dev, "MAC: %pM\n", eeprom_mac_addr);
>  	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(rt2x00lib_set_mac_address);
>  
> -- 
> 2.51.0
> 

