Return-Path: <linux-wireless+bounces-16464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3419F48DA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 11:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41517A53E2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218E1E1C11;
	Tue, 17 Dec 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1qIV3Zc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02D1DBB35;
	Tue, 17 Dec 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431292; cv=none; b=lKVWGX8VLVEtCt2CrlQLACVRWkklSC334Y0abCqCTQ/Prtbwo3aBbPSRC77f1n7PoxR53pwPCPoJz5mlclm6Dkx4vqsPR5JfBrXyuoaT8qAbLCKgNxFSkADHEW2g51WUESIOxl2zbTON64/hEyezYnysLdDy4z9Xbc6nBTiXwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431292; c=relaxed/simple;
	bh=qBDJHVXHEYwSy/oqc6AJLsNa/PxM5mt2M4C3rq4fdTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8f4QbWycSHi40mxvGPFcMWs0/FFY3Mr3A8q6kdQXuVuh3nXL3IoBxhaA1x9Wc/c//XjBMICcluUAPCksvcvwb3zHjAjA2DCjBH4bXcns/3Xw7PotQ2mH2SZfTRR4RC8oRQ1FQXv4lo8vPaBF6PGKLaSon8ysyLEzs5JSSfm3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1qIV3Zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D66C4CED3;
	Tue, 17 Dec 2024 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734431291;
	bh=qBDJHVXHEYwSy/oqc6AJLsNa/PxM5mt2M4C3rq4fdTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1qIV3ZcvlAcqKU4cQJkbTXewhjjPT06A10golSKZU7TJMn73NkCwZW9MK5iCU6IO
	 RkYLEh6DVd7u9CjSUahFcBXw/0kLvdzETRerClMWvSYVuSiQ2GJZxu15nc/k+2gfgt
	 st4W1aepVLHMf//a8jFOrNzLeYmCTI7rlhieICC1RFewfCX3MlBzhR2171TLBuCGYf
	 mEcTkHPL5BBFCdRBp/PGiDlwuxTRNpbFmJ678mRF3wj5GSzMBTfQ0dQgziIQrS1u0K
	 LejB6OsAq2Z/srALhKTJUnrNej7EQpxs6d5gBbl300HIUVuj6eFsPvqL7pGtlVbWIY
	 K7vj+iuusf0xA==
Date: Tue, 17 Dec 2024 10:28:05 +0000
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shahed Shaikh <shshaikh@marvell.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] netxen_nic: constify 'struct bin_attribute'
Message-ID: <20241217102805.GM780307@kernel.org>
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
 <20241216-sysfs-const-bin_attr-net-v1-4-ec460b91f274@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-4-ec460b91f274@weissschuh.net>

On Mon, Dec 16, 2024 at 12:30:11PM +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Simon Horman <horms@kernel.org>


