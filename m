Return-Path: <linux-wireless+bounces-12363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79D9694BD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8961C22DEE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74761D6C76;
	Tue,  3 Sep 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKtHUvx/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1011D6C68;
	Tue,  3 Sep 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347347; cv=none; b=oWS+8triqBoyZwt/YLmgp3p1gUhktNZcns2hrEfluhwzQZT4hBR6JkbQ7rQkkDdHczd8r3wpFOML//az9o8SrFHPbRfDxNha8uPGIBQ63NOceDsonwoFIDpPEkzx7zUTo3Kheo8wjpJ3B6D8w7czZT+VTHvw36Swf5dIgtbplEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347347; c=relaxed/simple;
	bh=RV1DL4EWhw1Iqgi6fDlqAVV21a+LAaW/eDxabMVQgtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CodMz5S6svtT3a3EbcaBdUkv9DrKEMUSOtpxDAP7AUMCL0MMMxOmY2ivMAL2jOltPjEmrrDGbWJOoKdNpI2UnFUwtc16gK32mDNSQfJaRsXDYiMU8+ZYtdAOke7YtryOk/0vEaOFG0tMHe8Rnf7BcqznwKXNVaOwQKAv5bjgvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKtHUvx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFE7C4CEC6;
	Tue,  3 Sep 2024 07:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725347347;
	bh=RV1DL4EWhw1Iqgi6fDlqAVV21a+LAaW/eDxabMVQgtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKtHUvx/hP/0KkhraxYmABpceQJQz/L6YAkP06Dt77kaWqGyMn8hkeWLtVSu5V9h/
	 UXhudOUmMcdz1nwZciLUWZDBVPAFJRYdxtlWuKVK+yzX3j1A4+BDY4gIwoM62CyiLm
	 kgQcHJlrqpRpU0L95EFH/HwyG0B4GFxIz7ZEU6V37oQQhpamLQrcuHATAipXpNDGb3
	 hykxUP1b5B4bSVESTwMRypChDlabJFnnx/iR3msXhbnd7MnPXXcMe0aPXzrAXBpzke
	 7Ww/9ikmb/3gkCcMLmcPK/dlLzxLgraODNmf9M1z46G0VQTcKsWkO3iAxEplMpzHg9
	 3inKYa0e300Lg==
Date: Tue, 3 Sep 2024 09:09:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: linux@armlinux.org.uk, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, nico@fluxnic.net, arend.vanspriel@broadcom.com, kvalo@kernel.org, 
	robh@kernel.org, saravanak@google.com, andriy.shevchenko@linux.intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 7/7] of/irq: Make use of irq_get_trigger_type()
Message-ID: <m3zzseb7rhc3l3ol5ecaikbvvp6nvu2oc56wr7bv7oxgmkchma@al6ywvqogvxc>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-8-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902225534.130383-8-vassilisamir@gmail.com>

On Tue, Sep 03, 2024 at 12:55:34AM +0200, Vasileios Amoiridis wrote:
> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/of/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


