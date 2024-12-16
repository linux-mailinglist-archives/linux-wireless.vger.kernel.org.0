Return-Path: <linux-wireless+bounces-16418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F56A9F34BF
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF762167B6E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAAC1494B2;
	Mon, 16 Dec 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fP87Upys"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F61487E5;
	Mon, 16 Dec 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363656; cv=none; b=MSJcZJpsugnn2EmeGyiQXaeiuhCiuEeAfMDUoZk0j+Fje8X5JwxkRyb3TNlRvASrHHp9Ga6RnKfIEVJl5gIvXaRxsxJ1lBzgQseB9+U65SU5DfCfSzzMHdHqALOsIb4rOmRxVHkMbXkjmds2rMo56B7H30tT0kR67xatt38bpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363656; c=relaxed/simple;
	bh=nBlfpGHZLN/tSmadhAaGKOZKCuSup5dAG2EvrJLNhm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGcg0iG8kykgSTAKWyZEnMtGxIhIpUpJVG02dENRlSORiew7G/ZXzuoFFHxHbxdirrZdwvHuzWqZXmiD6UwFCKMsPFNV6oU9QoZ3IszK8EOF9RS7bCg9KsufWaNhIhIjMVl+FNIduvzT9eXnzpzUoL0Udl7uhKfKbGMukDSYSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fP87Upys; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lgibr6KIaF4osjRJKvvTMTfF1EZjS2bKGRpJ4Y47g5E=; b=fP
	87UpysOTTMwnIYBto8w3o7YSyba+R0lAQodCnE9xM3nL7ER8J2lPIg0yPQgHTmGnm3fxOWtaCrHXd
	cC/jdRnYpClxaknx45QCZpgGni/UZTINa9D0tdO069/pycivefBA5cRGOHkB4mfGzsRZqZOVksPKu
	eieCfUot1B6JxdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNDD1-000f9s-Dg; Mon, 16 Dec 2024 16:40:35 +0100
Date: Mon, 16 Dec 2024 16:40:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shahed Shaikh <shshaikh@marvell.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: phy: ks8995: constify 'struct
 bin_attribute'
Message-ID: <1f30c688-64fa-456d-a4c5-94fb7d6eac71@lunn.ch>
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
 <20241216-sysfs-const-bin_attr-net-v1-2-ec460b91f274@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-2-ec460b91f274@weissschuh.net>

On Mon, Dec 16, 2024 at 12:30:09PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

