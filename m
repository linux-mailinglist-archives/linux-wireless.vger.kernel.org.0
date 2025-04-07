Return-Path: <linux-wireless+bounces-21199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3F9A7DEEA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D392818955DC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111A253B76;
	Mon,  7 Apr 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB1zvzcw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085B24166C;
	Mon,  7 Apr 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032073; cv=none; b=G5Yv7IQajAjh5BbyZWFZhe4OwQMAwCtOsbV7LpBpBFkoeaeZPSQ8BHQ3Ybz+NjVfR4aKCLQLwkj3YqAXJtrZ9KE2Ou+KIfF0hIKdYAkO7U5dNHSteSJ4Bf2B4FH9XwaBUnCT/zwlYgWapka5BHQ32lc5YN00gyR7IcDeI5sEkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032073; c=relaxed/simple;
	bh=qzBapD4NoxcE/kMAUPWaWmt4V1Q1ODyGaFYeTtAzGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMVQ6AF8OXv2qlntsipjwRg8H2RpOEFrfzu8BaVpVvBxDIU86+9D7jBFZSePuBDas9ZWQReR76jvBNxfRTju4n0cpC3oGcluTALkZm2FMIJJ+nyo396qMc0aX9rgeZWRvQx2xCwXCtY7zkEd5h1LbRGXoPyGX/XY8PRqR2c5h/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB1zvzcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34B3C4CEDD;
	Mon,  7 Apr 2025 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744032072;
	bh=qzBapD4NoxcE/kMAUPWaWmt4V1Q1ODyGaFYeTtAzGZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lB1zvzcwoUhpf3je9CjUIs+sUr3Qloh+PP1fl8IcSxUSv3XSKhxtr+V+Lf3dPiqpy
	 SFQelrh8AjAn8ffg3cMLfGmvuzrf95cEF4RJRcXtkqU362XiiGG+EcfqrrT/RwXrLK
	 ZiBHmH6NKXd6MrJUAfTEmh5drdxoSG4tki+ieuXBy4cnre8y8ZLL59Qb8rKX7LhDJb
	 uRXZ3Q+0S20mfasJeztUoUafRfMyleHTBhnv5BFRjX4Y/IR1aReJ9Kjls9Lvzthv+j
	 gC588nw/85mrsqjgKQ/JDawjjKzspk6qoEGkL8QpkqnO20aH8qrpVrL7ZNraC1t74V
	 Oppy427f7rCTQ==
Date: Mon, 7 Apr 2025 08:21:11 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Matthias Kaehlcke <mka@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: Add Realtek RTL8188 USB
 WiFi
Message-ID: <20250407132111.GA1945629-robh@kernel.org>
References: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net>
 <20250403-rtl-onboard-v1-1-10ca9a6a4ee0@posteo.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403-rtl-onboard-v1-1-10ca9a6a4ee0@posteo.net>

On Thu, Apr 03, 2025 at 04:07:48PM +0200, J. Neuschäfer wrote:
> This is an on-board USB device that requires a 3.3V supply.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../bindings/net/wireless/realtek,rtl8188.yaml     | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Looks fine to me other than the issues pointed out.

