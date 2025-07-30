Return-Path: <linux-wireless+bounces-26057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9CB15DDC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 12:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C68189FFFF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06388273D95;
	Wed, 30 Jul 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="NT8ot2CY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96AB1F09B6
	for <linux-wireless@vger.kernel.org>; Wed, 30 Jul 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870256; cv=none; b=c+yWEg8+fogh1EkfwNgZWEQoI1jheXbDxObnyknHYjsw4a7s3QF/5itJxcUoPXN56/uMcal5VA/ODGYTIrKRHz0RHR8/9SSZzGKOfRQxjtJ/leBmnsLkuRSZ7FCd8v58IOqTtWieTodv5ZEiSrnXBO4mPTWNMHJhruD8CDxWSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870256; c=relaxed/simple;
	bh=AdCsx8Nngs+lrhMZa9aMiJC0qTRB3siwTyn9Iw/xzBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSFHjW8OuobhaOwPtHUGFwRiPqFFdUQ7q87RAa69HlC07j4OHizihWWvFL4RRIhrTlveyZNncZhCB7NOBNwuE+P57pNlWqafMHjhDdgh7KOYPdCC8VMdg10aqRdjDrc7+px9KVZ7pR2VgIpExUI3Blw/YaNbC5/rnTgGL39cqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=NT8ot2CY; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 6044 invoked from network); 30 Jul 2025 12:04:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1753869849; bh=5T32YM0L13QAl9GVrd5giNXERZAqYqtFnELJWH4hMok=;
          h=From:To:Cc:Subject;
          b=NT8ot2CYTEmbnhZII2QW9snUuGvunjOz4G8ijR8Bf45bdzDh1MKva3KUSFZKQGILf
           DF6Qje7LwCRDaKvNHZLy6t9oNG9hPfcBSIpoHIOrQ7W0pxgE2oEl1qcdCPVgosTqx8
           9fjmslP9h/Y5opnuqUwXf9gk2OhSRMwdN7vh3V+QiwHro7IL5et3sqApyL1AJX2gbf
           +qyPSqOr//XjlxJhxS5ZPXokmyZkY4qyeAjIZ20gvmVpiUoT5xy4mqJX0h9OJyt6CH
           ZfP3IighBib1nJeSoHmHHXFbMHNDZRN0WjogaLx2kpUDcyFsoTDsVcygr7ZTKNTxGO
           zXsDO/94BdIFw==
Received: from 89-64-9-64.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.64])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@kernel.org>; 30 Jul 2025 12:04:09 +0200
Date: Wed, 30 Jul 2025 12:04:08 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>, Rosen Penev <rosenp@gmail.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: rt2800: select CONFIG_RT2X00_LIB as needed
Message-ID: <20250730100408.GA117709@wp.pl>
References: <20250729152924.2462423-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729152924.2462423-1-arnd@kernel.org>
X-WP-MailID: 63b43a80a2d624911acb2c9655d84779
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [oaNx]                               

On Tue, Jul 29, 2025 at 05:29:21PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The rt2800 specific code requires the more general library code:
> 
> ERROR: modpost: "rt2x00queue_get_entry" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] undefined!
> ERROR: modpost: "rt2x00lib_dmastart" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] undefined!
> ERROR: modpost: "rt2x00lib_dmadone" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] undefined!
> ERROR: modpost: "rt2x00lib_rxdone" [drivers/net/wireless/ralink/rt2x00/rt2x00mmio.ko] undefined!
> ERROR: modpost: "rt2x00lib_txdone_nomatch" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
> ERROR: modpost: "rt2x00lib_txdone" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
> ERROR: modpost: "rt2x00queue_get_entry" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
> ERROR: modpost: "rt2x00lib_get_bssidx" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
> ERROR: modpost: "rt2x00mac_conf_tx" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
> ERROR: modpost: "rt2x00lib_txdone_noinfo" [drivers/net/wireless/ralink/rt2x00/rt2800lib.ko] undefined!
> 
> Select the symbol to avoid this build failure.
> 
> Fixes: 7f6109086c9e ("wifi: rt2800: move 2x00soc to 2800soc")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
> index 4d98b7723c56..d66fc839c3ce 100644
> --- a/drivers/net/wireless/ralink/rt2x00/Kconfig
> +++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
> @@ -225,6 +225,7 @@ config RT2800_LIB_MMIO
>  
>  config RT2X00_LIB_MMIO
>  	tristate
> +	select RT2X00_LIB
>  
>  config RT2X00_LIB_PCI
>  	tristate
> -- 
> 2.39.5
> 

