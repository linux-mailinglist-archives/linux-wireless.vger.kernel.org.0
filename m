Return-Path: <linux-wireless+bounces-7451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFC8C240C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598AB281EB2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F216E890;
	Fri, 10 May 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlp55sxB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69E3AC16;
	Fri, 10 May 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342199; cv=none; b=qqX3oXe9Vja/5x+c8xQQgXuaV/LhWeSzfaOlK39ntLJDEKtjr9z4JH/k3g/oyXm1l+Kffq9PMxEd7PQijznhvY1RNV7RfLNdjdNElG15qy94ZG8xggbPYKDH/EvfLhhvKrU1t0YlMfZwItDxDW+GqCJSICf4QrWXshDkuljuq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342199; c=relaxed/simple;
	bh=Sg1yNj7sz3TgmJXgjsW9mK/1ks9fy6gk2t2h724Zu/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC8kZZ7AaAACfmYO/LCyGpOuZtO3XRPIbXCw40F4pbGculmOuE4AHd8Q/UKXXCnbKN5xGAzS1bOZlK6tbMNufPcYC7qElEtWPqxBXvYCcwbW3nchvFidn7bY5POOz4coRmaYs8M76DgmpwMdsNlc13LQlXUNr1MNlA1Q0Un7X8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlp55sxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BE1C113CC;
	Fri, 10 May 2024 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715342199;
	bh=Sg1yNj7sz3TgmJXgjsW9mK/1ks9fy6gk2t2h724Zu/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlp55sxB0TjgbLIK7NtwytShjU39kvivxmsofCkbGqorK7SU+HQlQoIueRiZ22J0W
	 Lf+8QPYqjysh/K37yBrG2GvvzkfZkCdSz+gqsolYELyNW5y5BTAEAi8YakZI7KD0bG
	 0gcC2eL/CbrNzZy9KFQDjARsCrkrUML33SAQkha4CLsMBznCP4nVZBX/q46hCwQGhB
	 a7hbdHT5SlulYji9U4WgPGnqMhgTeJgzPQh3ek8/rz52pQOdvlVBDV5UYIaW+/bFOq
	 35UM359xepPSAO7FHUT+eb5qzRpBbvWlUZn9vpu/nrrrjaKv7sJyBvWCMawz6sd5QI
	 0Yjoa3jz1X/rA==
Date: Fri, 10 May 2024 12:56:33 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" <ath11k@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless-next] ath11k: Fix error path in
 ath11k_pcic_ext_irq_config
Message-ID: <20240510115633.GS2347895@kernel.org>
References: <20240508185902.70975-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508185902.70975-1-leitao@debian.org>

On Wed, May 08, 2024 at 11:59:01AM -0700, Breno Leitao wrote:
> If one of the dummy allocation fails in ath11k_pcic_ext_irq_config(),
> the previous allocated devices might leak due to returning without
> deallocating the devices.
> 
> Instead of returning on the error path, deallocate all the previously
> allocated net_devices and then return.
> 
> Fixes: bca592ead825 ("wifi: ath11k: allocate dummy net_device dynamically")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


