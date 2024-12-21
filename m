Return-Path: <linux-wireless+bounces-16698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDB9FA13F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 16:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2CC167AC7
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B492EB00;
	Sat, 21 Dec 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DnW3p0Wq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCC1F427B;
	Sat, 21 Dec 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734793579; cv=none; b=j/Qq8ipI/s0jqSz+dqNTc3cR6pjLIq/Gp0jDHNsYLCQyWTTjShTXrkVAnJS0qp5NaC+TtZInG6OctySFWVRwmVs+6gPBcv8lPbmUq4mstOjNoJshFKkYMwcl8kC2kCHS52ewRc6cj4GWjr3ejdzOWJ08FjhzgWLfl/RcmCzJ+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734793579; c=relaxed/simple;
	bh=fg9AM9uCOoy34gPSOGcTPBKBCJnw5BhZsPbWtU5StSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqaCGLGBB1WDtl4qRny/DFLS2GjvuCmFqK13gXRaer9GTRMIMtEJAPBVml/wFJE5pgUT/8eiPlqjsdhecbfahNXflqESNBI1dS9n85X1P9LOZ0nwfi5428QXZstxrCy90zSKvX8u/XU0vL0M5SWSrw1zNAlyliyzQTnSXBuv8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DnW3p0Wq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nnUaS3ZdfldbVv26q/JCdoZX4cOue7uHQN0UsIPsLgw=; b=DnW3p0WqYpcwpI5GhqekySA0OP
	ThuDzjKUrdCaUb9/cjsTSqxexPQhx0ueNtDLJIEV33ZDlUdpVtiiEm1SmgkXv++B04iM4nUASSqEt
	2Vmvq6h/4FrGWtBMRvBiGtjtO6d+g561CUxBmAANScbAlgt98N6xVQ3W28c1SXIIgHtk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tP13T-002KH5-R5; Sat, 21 Dec 2024 16:06:11 +0100
Date: Sat, 21 Dec 2024 16:06:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 2/2] net/phy,neterion: Remove dead values
Message-ID: <9f15203a-349f-48f3-a812-ca3f7ec995ab@lunn.ch>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-3-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221124445.1094460-3-ariel.otilibili-anieli@eurecom.fr>

On Sat, Dec 21, 2024 at 01:39:33PM +0100, Ariel Otilibili wrote:
> Coverity-ID: 1269173, 1575053
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
> ---
>  drivers/net/ethernet/neterion/s2io.c     | 2 --
>  drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1 -

Please split this into a patch per driver.

>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
> index f8016dc25e0a..4f89f9fd8043 100644
> --- a/drivers/net/ethernet/neterion/s2io.c
> +++ b/drivers/net/ethernet/neterion/s2io.c
> @@ -1969,8 +1969,6 @@ static void en_dis_err_alarms(struct s2io_nic *nic, u16 mask, int flag)
>  				   MC_ERR_REG_ECC_ALL_DBL | PLL_LOCK_N, flag,
>  				   &bar0->mc_err_mask);
>  	}
> -	nic->general_int_mask = gen_int_mask;
> -
>  	/* Remove this line when alarm interrupts are enabled */
>  	nic->general_int_mask = 0;

So this change looks reasonable, but you need to update the comment,
because it is now wrong.

>  }
> diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
> index 550ef08970f4..e15ab9ba2f50 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
> @@ -818,7 +818,6 @@ static void nxp_c45_rx_sc_update(struct phy_device *phydev,
>  	u32 cfg = 0;
>  
>  	nxp_c45_macsec_read(phydev, MACSEC_RXSC_CFG, &cfg);
> -	cfg &= ~MACSEC_RXSC_CFG_VF_MASK;
>  	cfg = phy_secy->secy->validate_frames << MACSEC_RXSC_CFG_VF_OFF;

I can see why a static analysis tool would point this out, but you
need to include some justification why your change is correct, and it
is not a bug, maybe cfg should be written back after being masked? Or
the assignment to cfg should actually be an |= not = ?

	Andrew

