Return-Path: <linux-wireless+bounces-16465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 444159F48DD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 11:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F816CB65
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34241E260D;
	Tue, 17 Dec 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a82Cz/y7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7A1E1C11;
	Tue, 17 Dec 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431311; cv=none; b=MN29dKH77r/UW1QKSb0A7Wa5M9Zt1XGUDbADPN2ohYhKi5sEd/Quo3jNS7JviHtD+7Y710hGfPuq3WrhT0QFelgSb/7zIhEjQ9eqh5InU0Vjmqt0d/q9DAM0OelfeyJVGpWf2+9FctEuYf0JnL73yiew0Nm8DLX3R4+4tSaKQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431311; c=relaxed/simple;
	bh=Kb6sRtTPSyByaBOCsB2WSRTHSbYPgdfsi05OLf0B6Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2+I7MEH7IG3j1YlhPw+GwUCKjfbTfzAwrwME5O8TTkGIWOwgLnBWXyvheugCarFpcNe0PWJmiLg6luW9jxrAgyp4/8lP6N9DqvwvMXolI/PVRB9eQAusT6FiUKkeuPhcJXFR1gn18XZanYk2z5+0LmDu08CRDF22UkksI+jl8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a82Cz/y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3057C4CED3;
	Tue, 17 Dec 2024 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734431311;
	bh=Kb6sRtTPSyByaBOCsB2WSRTHSbYPgdfsi05OLf0B6Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a82Cz/y7ll8QEaZPw9/d/IF9J9ITFrwBXKMgjyRXg7xpSgV2qrlcqhtMtjTWH0bho
	 ba63kNMSg0LkvkTwAPG3w0Hc8vNv1loNK9RiBG/sts2XHc/9xLebR2y0lIjhDBYv6Z
	 0W9fTIaHr75phPno1PQRgIvdP5tCFzJSbbeN8PrAC7RqMyliw1Tzt2prjoQZG8c5Mo
	 d2YAp8aSvkaiV4GKI4LoL7ZtTKinxIP1Gxx75wBhdhdKPwM7CHYtc3GbmZmqpzVKtB
	 ChtVa+tZ/Mmks+U86Wd8eZNTRkd+4U6OtgUgmKyXI8/X5rNSG8+xrKeETAqARdDyaV
	 CEz884KiNCivQ==
Date: Tue, 17 Dec 2024 10:28:25 +0000
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
Subject: Re: [PATCH net-next 5/5] qlcnic: constify 'struct bin_attribute'
Message-ID: <20241217102825.GN780307@kernel.org>
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
 <20241216-sysfs-const-bin_attr-net-v1-5-ec460b91f274@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-5-ec460b91f274@weissschuh.net>

On Mon, Dec 16, 2024 at 12:30:12PM +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Simon Horman <horms@kernel.org>


