Return-Path: <linux-wireless+bounces-21129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D37A7A4EB
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 16:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBEE188BF78
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3927F7FC;
	Thu,  3 Apr 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="QIEMyArq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89802E3386
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689595; cv=none; b=F9cmtL7b/NGmR7ocFoH4zHcCFNzyDUlnRB3Sk+L6DzLnwf0y0QyOBB2fzX28DozUrvEfYIEqqz0EsI+xtILfXj99IpNl58ihX9osjOxb4D+fYYN4T0uAMeNMpBoQTvdlDqe/gUiV6JsieHLwac9Iljjf4HaLd8i1in71Hjd7JNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689595; c=relaxed/simple;
	bh=b6Xe4damUlX0SdnPSvLEJGnYenLSS3mEfJwPjwjZLJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGDGmr5Y0kvOwA8AJDXc2/283zzTrSFTuhAi89HLQefm5w0lsnDeiGs16XGXICCGL/VPMrqw+SSkDIXsDIfvNjlhQYGsFVocmdp9t4XLcy9NG9l+Miwu0DvqCT68j1869IiONcP1HBse0SFSSrInrglL4o369L2uhWdtTl9G9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=QIEMyArq; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2742E240029
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 16:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1743689585; bh=b6Xe4damUlX0SdnPSvLEJGnYenLSS3mEfJwPjwjZLJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=QIEMyArq7JrD9UoR4zf5FJNOhHJyVbioxdT2xp0StJqxHIjfJ4bX86nHr0Htoz0sw
	 /4kHIHxhLrdBst/TAy9txa7jcb7AZsQ9yWczRFwMbIZsIzLCYZHbjN4bBAUyJsrL/H
	 6lnCBcM78TRsgh2xqcsIKVuf8Fw717LE0/4iaDRZ1L+phCdQ61bMHpFc8VsVcBAJ/Z
	 oGqely1103Y/se2fB3YRnkHx3MocfWT1V1iJAMzGZQKQMi1crnZp/un/FQL+NH4XA3
	 YFiOsw0vQms09JjZjpBidqwQp3p8oCt6z9T37qyY0gO+zL8/zLJXaujfJoYhOROXg4
	 Ibp1MZ/sEexHg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZT3bz2Wp7z6tyW;
	Thu,  3 Apr 2025 16:13:03 +0200 (CEST)
Date: Thu,  3 Apr 2025 14:13:02 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: j.ne@posteo.net
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Matthias Kaehlcke <mka@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jes Sorensen <Jes.Sorensen@gmail.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: Add Realtek RTL8188 USB
 WiFi
Message-ID: <Z-6XbotPbah2flxK@probook>
References: <20250403-rtl-onboard-v1-0-10ca9a6a4ee0@posteo.net>
 <20250403-rtl-onboard-v1-1-10ca9a6a4ee0@posteo.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403-rtl-onboard-v1-1-10ca9a6a4ee0@posteo.net>

On Thu, Apr 03, 2025 at 04:07:48PM +0200, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> This is an on-board USB device that requires a 3.3V supply.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
[...]
> +maintainers:
> +  - J. Neuschäfer <j.neuschaefer@gmx.net>

Sorry, typoed that. I wanted to use my current email address instead of
this old one. Will fix in v2.

