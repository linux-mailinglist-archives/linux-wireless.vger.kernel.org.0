Return-Path: <linux-wireless+bounces-7643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32928C5761
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45C22822F8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7A144D29;
	Tue, 14 May 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSpTyays"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6C144D26;
	Tue, 14 May 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694715; cv=none; b=poUJ4VG8UtJof+WhUyXLRZGZWJAQ2B5Aeze45k5X1OKviZp50PHHrzfWSkugachJ/vVnnxIOiz99y3hWP38qzXutIz14VgGXp2vfahYo0cEZVCCVu4rOM2tFNJ3NJ2P1jGXpNOkOFzmoQMJ1JVmuGQE7V4phm2XEAMKREfCQBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694715; c=relaxed/simple;
	bh=R/1VExEKXdpSSpeOfIuEd1O0aNDvKIRCpBfTqbd15Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iADA34kIDWZ/aNYyLu40pFQY9afU1oVtlkcPa/GjGCGEUkv/MEbHTABUukdznj9NvG5Npk3mIfmCkY9dzZJTlIKv8WAaQ6/J6rRH1gHkn4RSIAMVraxLUs7f4RXaElRED1EMzEYvqeczA7PNBknwws6KREGKFJi1a/PRADWfBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSpTyays; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CABC4AF12;
	Tue, 14 May 2024 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715694714;
	bh=R/1VExEKXdpSSpeOfIuEd1O0aNDvKIRCpBfTqbd15Mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gSpTyays0LYY4ooZsyyyRrDaM7pkLb7GYKzJoNE+EAYveWtjpZjRAciUaikEOnK+8
	 9WgIfyuiEDU3m8WY9ucvzuV0gd5Lsvgf71mEW7XMHdzKIntERMEoMbWshDz4QMA8kb
	 /HITb97RmQnuPfok1H17zE9BhWNn8Dc1tUhZEbKFlzRZqrcum8I0EF7lHkLf0uQiMn
	 sSF781Q5C0szFqPSq/CS2Tn8hGx/w1/pna8nNn1ePQ400JO42CyqysewadMNAr4B+u
	 PBHePE0+rSsZ9o6jzCkpVRpEXxiTzMxWhTl+2lPitb3id1fD1Z25skmBF5NuuQdyrL
	 wzo7UKSIeD0ug==
Date: Tue, 14 May 2024 06:51:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, horms@kernel.org, Jeff Johnson
 <jjohnson@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org (open
 list:NETWORKING DRIVERS (WIRELESS)), ath11k@lists.infradead.org (open
 list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER), linux-kernel@vger.kernel.org
 (open list)
Subject: Re: [PATCH wireless-next] ath11k: Fix error path in
 ath11k_pcic_ext_irq_config
Message-ID: <20240514065153.1320f47f@kernel.org>
In-Reply-To: <171569306687.2017278.16792087877494747045.kvalo@kernel.org>
References: <20240508185902.70975-1-leitao@debian.org>
	<171569306687.2017278.16792087877494747045.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 13:24:28 +0000 (UTC) Kalle Valo wrote:
> > If one of the dummy allocation fails in ath11k_pcic_ext_irq_config(),
> > the previous allocated devices might leak due to returning without
> > deallocating the devices.
> > 
> > Instead of returning on the error path, deallocate all the previously
> > allocated net_devices and then return.
> > 
> > Fixes: bca592ead825 ("wifi: ath11k: allocate dummy net_device dynamically")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: Simon Horman <horms@kernel.org>  
> 
> As commit bca592ead825 is in net-next I think this patch needs to go to v6.10, right?

There's no rush, FWIW, we can pick up the conversion after the merge
window.

