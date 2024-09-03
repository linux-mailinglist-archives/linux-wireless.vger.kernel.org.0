Return-Path: <linux-wireless+bounces-12389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDD96A0D7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B76B2160E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718613D531;
	Tue,  3 Sep 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyPBWZPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F11CA69B;
	Tue,  3 Sep 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374385; cv=none; b=d4LMLiJbTyjatOOEzg0uKnZAvzyD264JIid7HJxkb07eQwMrXIhz2jW1I8leZqEIH15jyg7qGl4kxVxa741tH8jimjUcw7Xq43qyxPv+d/vrHTugkbh20H2rTrOU9nyjqNTE2/qwcQXHNhi1y9oFVVoQYGlF58gVwxxac1O4T7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374385; c=relaxed/simple;
	bh=D9Cdv5s5uqz98UZ38zDPKTwaHhmtDL/60jvVsg3/qPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbQfXU147fGB54f3JR6s7JifjHgSE5xf55lY6i/frqAFrNezlYbSWc6AXcP7DOxpQb8RH9kqnNknUmW0+fG6s3j9fGKWm7VfDUd2rYORdsuxX/1J55wklYAPaYcx6BuMuCAk8B4uXTBf41+MOc5FvbWdvflDkCiyRYPEKten4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyPBWZPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F48C4CEC4;
	Tue,  3 Sep 2024 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725374385;
	bh=D9Cdv5s5uqz98UZ38zDPKTwaHhmtDL/60jvVsg3/qPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyPBWZPDeICY9ZBtXSc7LSZtnnn18oNHYc3kNzVVj4ZF8b+0opmKhC80/kVyTTJox
	 8soqTepKaf2TPia5hcdQit0VzzeRrtEP86sZO+qIQRRzdrVuur11qUNX2imBKT7hJQ
	 xCS/ctKh/L01UWhhXNbPx7bMHOrxP5LLGapGGIJE1ShcSi9Hz54TTn7LdvTSWAKvsO
	 QNArc8AfDXTS7/11r+m+RiFpvrl3ezBNZEaXpQdb5qr/0zYRCbCScmP6mh/7ymrJKc
	 SFnnk2jRuCRHydK24y37jZhLxHATNhv6Jf7G86I8BcMpJEhTtoQvQ2A6C8r4KC0O6b
	 Osp/1o0/B0mdQ==
Date: Tue, 3 Sep 2024 09:39:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: nico@fluxnic.net, pabeni@redhat.com, daniel@ffwll.ch,
	davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
	saravanak@google.com, andriy.shevchenko@linux.intel.com,
	linux-kernel@vger.kernel.org, mripard@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com, f.fainelli@gmail.com,
	linux-wireless@vger.kernel.org, airlied@gmail.com,
	linus.walleij@linaro.org, brcm80211@lists.linux.dev, andrew@lunn.ch,
	devicetree@vger.kernel.org, linux@armlinux.org.uk,
	alsi@bang-olufsen.dk, tzimmermann@suse.de, kvalo@kernel.org,
	arend.vanspriel@broadcom.com, maarten.lankhorst@linux.intel.com
Subject: Re: [PATCH v1 7/7] of/irq: Make use of irq_get_trigger_type()
Message-ID: <172537438003.978249.2559307502514402788.robh@kernel.org>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-8-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902225534.130383-8-vassilisamir@gmail.com>


On Tue, 03 Sep 2024 00:55:34 +0200, Vasileios Amoiridis wrote:
> Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> simple irq_get_trigger_type(irq).
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/of/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


