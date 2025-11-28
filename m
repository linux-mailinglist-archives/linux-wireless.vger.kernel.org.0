Return-Path: <linux-wireless+bounces-29420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9752AC92BF7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 18:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEF1D4E3099
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B882BE647;
	Fri, 28 Nov 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TOfp9aoW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482B26FD86;
	Fri, 28 Nov 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764349551; cv=none; b=N1p7PcC4e5hAZAMW1i7Vsz1YhyEaJalvhY6TQbfjIBYxcA+UTY9ntbDVtkJswbyTCS2P8zFHd0x6GoYPthgpAYJYC3KT6TD9d9whReClvz6K+ZT/ODvZyzqGQ2xqZ3ZNVCHFWqhOWDBgHGJiOUXBaPIMtRFc7m8HGBgnARgLHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764349551; c=relaxed/simple;
	bh=PvNIlld0IaNRs9dqfcFlKkKutDvX8ypz/zN3pY5PILI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXzCQbzDjuSSFxEJAzYatDZkIRdxVQIFbvtRzBgypsnYh1QA4MiMySBzc8AWMMmz1jYuV9Y21JpscxQLkSJW1mUaskPHxb4GAK8ucZcAKu8X8uMlOFQrKMhQm7MmYbgz7NwBRk+l9uw8gpV7n/VP7Gdm4Ps16/sFv5JszWEu7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TOfp9aoW; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E156C1FD35;
	Fri, 28 Nov 2025 18:05:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1764349538;
	bh=PvNIlld0IaNRs9dqfcFlKkKutDvX8ypz/zN3pY5PILI=;
	h=Received:From:To:Subject;
	b=TOfp9aoWdasbKSRX3VWQIfP2S+HY1WpEpSH3mVqwdhQ5yDfS27be1AKTHvSFsjhCi
	 rDQE1UgFPadMAHVK7KU7oLuVx4bwJwQQ/io4VYL3yv97S+YmzQAaNOmmgBH8dgWHQ9
	 az1pFiQ5F9tQ0puODrO/55qMjJSRCmac0iCIVOz+OaFNV4MTCurJGoKoc9TnERTdQN
	 Ng8d98Roa1Xeh7LHSG8TuK9V/9CpukRmUpYLcJrnb5Gic3xi9SNj58PKdhTSF79hfb
	 mT5mVz0er90By9o68ZHnpnUy/593diKLafCYPRuq3QHixt07+NSv9L7pZbN9mSTE7r
	 b/3KkV24y9CYw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 94AD87F9F8; Fri, 28 Nov 2025 18:05:37 +0100 (CET)
Date: Fri, 28 Nov 2025 18:05:37 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Karel Balej <balejk@matfyz.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, david@ixit.cz
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
Message-ID: <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>

Hello Karel,

On Thu, Nov 27, 2025 at 04:29:12PM +0100, Karel Balej wrote:
> To reiterate, the firmware is generally available but is not part of
> linux-firmware and the entire process of upstreaming the chipset support is
> stuck on that.

I'll try to see if any of my contact in NXP Wi-Fi group is able to help. Give
me a few days.

Francesco



