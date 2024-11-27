Return-Path: <linux-wireless+bounces-15748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A59DA48E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660A3B25EAF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44F81917E7;
	Wed, 27 Nov 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XVuSRdSG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E813B13D278
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698836; cv=none; b=JPRJvWnOGv9/NyhqRJ/8+6/PlhmgkzDMV8Wi5oKgA/yxP0m/N3ebFZTZtuuqQM/SoMR1dC9u6jsOde4UDQYqJR2R8wtgg8ppvm5CImDPW6U6i/ccU7uxnyg3g1eAn0Nueq54zjmXLpCx6RTMzmfoZE8kTh1wbuRMb3DCeG4bqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698836; c=relaxed/simple;
	bh=xJtkvUaB/JWlGuYJXIGfctvTyaUneWxxGY80+/2LVcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI1L0IRgH3AvhIpZbP1Kgv5EvGTvYl5gzzbFjiXRWGeDmO6nrfkvFT9NSzon3purftzORHH4fziRcRFY8Zw/UvNy86vLp2Z/BGB+irgysvFBCVqv/3WDFc8AS06yvkx2KV42V9Qb0HJvYXn1r9x1+DrtfCvfajqYLlKcjNCBgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XVuSRdSG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wyETpKO51eTl1fCkJFT713v0ML1NP/KOl9aF2zsls+c=; b=XVuSRdSGKcZVkvs7T1cyQde2tQ
	GWQCO6BqPmta3hCr+VAXKe//z6C7a9hL+WcHtJMyi6cvcbowtSEfsu+OtRfNvWO/zzT/uekOvhvBu
	NOtBW/U5jnfeQUGocEol2eOe4OrrBeYzrwAg1ZD8b4zoQW9JAA1q4hWyKArdS4RLzdWPyJb8iWR31
	rAFQiFER/T3/mz/iAqanJ5rC79idHawAktsu9FK1NLuphxFQW4Bzc2B7vRJcAa/vG2R6/6E72fpvc
	WjuZoFVjaeV0Zjmoskpb/6aQjS9MycoTRtlxcfh9nuNRlvnZ9WQZbYt9D/a4pRcAS0BR7Hv26OfiD
	y8sACTGw==;
Received: from 179-125-64-246-dinamico.pombonet.net.br ([179.125.64.246] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tGE7I-00DXSC-E3; Wed, 27 Nov 2024 10:13:49 +0100
Date: Wed, 27 Nov 2024 06:13:41 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH 0/4] wifi: rtlwifi probe error path fixes
Message-ID: <Z0bixXh/zDeCjcBm@quatroqueijos.cascardo.eti.br>
References: <20241122172718.465539-1-cascardo@igalia.com>
 <b2b4bf1246054c9a97d56893c3dd4371@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b4bf1246054c9a97d56893c3dd4371@realtek.com>

On Wed, Nov 27, 2024 at 06:44:44AM +0000, Ping-Ke Shih wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > These fix different bugs when the probe fails. One of them is the addition
> > to a global list, which is not removed during the error path. That list has
> > been removed.
> > 
> > Then, some memory leaks are fixed, which require a change in where the
> > workqueue is destroyed.
> > 
> > Finally, the firmware completion is waited to prevent its callback from
> > accessing freed data.
> > 
> > These were tested against an "emulated" rtl8192se. It was a changed rtl8139
> > device under qemu with the rtl8192se PCI ID.
> 
> Interesting. Does it mean qemu can support PCI pass-through to work with
> real hardware? 
> 

Well, it does, but since I don't have real hardware available, I did a
quick change in qemu such that linux would probe the rtl8192se driver. It
wouldn't work as a complete device, but it would be sufficient to complete
the probe process and let me test the many error paths.

> > Memory allocation failures
> > were injected over 4 different places: init_sw_vars, rtl_pci_init,
> > rtl_init_core and ieee80211_register_hw.
> > 
> 
> For the Fixes tag of cleanup patches, I'm not sure if it should be or not.
> We can keep them and leave maintainers to decide taking to stable tree or not.
> If that happens, please carefully check the dependency of these patches. 
> 
> 

I decided to add the Fixes: tags on the cleanup patches as they are either
dependencies and necessary for the followup patches or really fix a problem
of their own. I will comment on those two patches.

Thanks.
Cascardo.

