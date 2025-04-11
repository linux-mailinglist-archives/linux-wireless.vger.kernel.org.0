Return-Path: <linux-wireless+bounces-21449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C363CA861BD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E488D16C517
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4120DD63;
	Fri, 11 Apr 2025 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDO88O0k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB41F5433;
	Fri, 11 Apr 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385070; cv=none; b=Jg8gpCNBlpt5VL7yTLvyhJd1cMFr0Vhmy33qrjnLaqlopFiYHcKH69NB5b1v+B8YAqBDhp45WvJVRdh5/dEIQhKZOF+uLwcGHZ17WnrDAqGxszpjDkxSMyBKFqbmfobw8vV6I6uFKcTTkzl2QsjHemIE+m6KTUfdt3QHjMcqIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385070; c=relaxed/simple;
	bh=cTCtE7M2VM4FPzXtByWa4pTLyYxPE1Z31+L/QQw6RZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYXuLOcKJNEL+l37JZjXWYUB6M39Pae+RxSloDPWlicmQmoNBFv2TsCvTbpz+Lz0+27mogfyUewe4baSCGMXms2/xLuAvQExjHbxmGaTBVsljc7Bj/CXXyuSLwONVOxIj9VgORJVcSiZXc2VcguaCIL43FRXpUxwdf09RIG8Jsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDO88O0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284B4C4CEE2;
	Fri, 11 Apr 2025 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744385069;
	bh=cTCtE7M2VM4FPzXtByWa4pTLyYxPE1Z31+L/QQw6RZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDO88O0kc0oPCPnbT1RIM6DPBqiYzsiXPXA4JBnnNPgV2b3KND7Cl3QRTxC1fZQc+
	 fuN5am5HeMkTUl5gLe3U5yVCRxLZHCCWLm25cy6IWtS9sjhGejVoHgsjyWP8A05IFC
	 Xo+Xfckq2xXOvxalh7jnnkc5sZIZsjYOy71HG76O5SopX3oQS0Y5vqYIduUFQ92h3l
	 ARV1WWLIzQHd0KIhDar9+CD8ftR12r++YKaojl93gD0aeGvykhWCmHLeKpi1g56OhO
	 opdB4Q29VkPmYT9pJVduWyKXJ9VtrIp1Kt1ZQlpW1PavKatDCTpTS5Rl4YA5jbh8ag
	 qwLbW4DMD6otQ==
Date: Fri, 11 Apr 2025 10:24:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jes Sorensen <Jes.Sorensen@gmail.com>, devicetree@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: net: wireless: Add Realtek
 RTL8188ETV USB WiFi
Message-ID: <174438506750.3274609.16595551844546804224.robh@kernel.org>
References: <20250408-rtl-onboard-v2-0-0b6730b90e31@posteo.net>
 <20250408-rtl-onboard-v2-1-0b6730b90e31@posteo.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408-rtl-onboard-v2-1-0b6730b90e31@posteo.net>


On Tue, 08 Apr 2025 21:13:12 +0200, J. Neuschäfer wrote:
> This is an on-board USB device that requires a 3.3V supply.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - Use my current email address
> - Remove TODO comment
> - Rename schema file to realtek,rtl8188e.yaml. This is the same
>   granularity at which the rtl8xxxu driver is split into files, making
>   it unnecessary to rename the schema file if another similar chip is added
>   in the future.
> - Change license identifier from (GPL-2.0 OR BSD-2-Clause) to (GPL-2.0-only
>   OR BSD-2-Clause) because GPL-2.0 is ambiguous
> ---
>  .../bindings/net/wireless/realtek,rtl8188e.yaml    | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


