Return-Path: <linux-wireless+bounces-16463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9939F48D5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 11:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B20F188DC19
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA41E1C11;
	Tue, 17 Dec 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvSBwO1a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B21DBB35;
	Tue, 17 Dec 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431246; cv=none; b=qlYBR2cT5lyzCT9i2f2/F2HPp1urdvvq3Q2xYgnniqmxNBFKSzHZDMRtFI6Hwg2HvNQnXPyaxjiQ+yXk8hHjScDZnAIUrBUcqvQLDQY1Re2s2du/9kIpZxPgBkCxoEHZ/WOluvaBcYFPhn/7OuXJO0eFhdrYQN5cHktSY7lib8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431246; c=relaxed/simple;
	bh=e8NR2Mm3nxNykFMqs/2JJJHBv4LxQ7vBHBypvF16BLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ6VxerL/8SSgUP4jEp+swaDxFUd+Cp0QVel8Bxp6/fqbwxlct0t9DqdHcz8m9KCj0hqUnTkBCSrYlm+ZKPSqor8hDuun10x5w+IR+9dKgf+4AEK8Rk1llpCJMvOmZcInbAfRh3/XBzwL3HAu5Q0VxUPeVNKfnFFl6sDqxNKcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvSBwO1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C899C4CED3;
	Tue, 17 Dec 2024 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734431245;
	bh=e8NR2Mm3nxNykFMqs/2JJJHBv4LxQ7vBHBypvF16BLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvSBwO1a+tce/b0G/K8JPaSonNn6+CS1OkG2kzamKF5Y2Ij5m4sdm84ByGfKJaI33
	 Crd1jYrj59DrcvVKMHVBe9kZ0QkFIUnxKe/gkuKT0Lrzrb7sWAIRhIfMpyYA9NF376
	 IiNq6IUoE4F+fYbrqgnSqJ2zt8yjq3cNoGbZxQ3tnU0x5d4rj30Q9rO9Xq9e5vqxyo
	 v7X0S0pJ26NeHY2YTf7TGYFIGgb35+u8aAYpEWolmc1c4RfYtcl35USded6Oyyv6Zb
	 8hyGzBHXuG8rqegwW8SrFyiqvMLXBDWp9iL1vNJA5tT6tZrdgwa+xFCEtJ1l9pUKYW
	 qBmzUxuOMa+Fg==
Date: Tue, 17 Dec 2024 10:27:19 +0000
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
Subject: Re: [PATCH net-next 1/5] net: bridge: constify 'struct bin_attribute'
Message-ID: <20241217102719.GL780307@kernel.org>
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
 <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>

On Mon, Dec 16, 2024 at 12:30:08PM +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Simon Horman <horms@kernel.org>


