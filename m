Return-Path: <linux-wireless+bounces-8607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AAA8FE41B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 12:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB3D284A7A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2DD194C66;
	Thu,  6 Jun 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="aoJWMYDL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6D194A74
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669135; cv=none; b=owOH9SlAfcgojAuBu5j2lhenBvVwRnORfiZy1To+YNWXAu01RMCCYMD40d4oi6TJU2ajvjoZURj8l9qzxpYqFiaLDlijIzkE6gyBczMCOp9nt8/a6qpPq6Nqv3xZN4yS8H2HYMgThtuJSdONvpR6jbuETfjN2xLHx8L5/lU5RfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669135; c=relaxed/simple;
	bh=RP/rKXepIkztaRKyqpjkD0YJJS198J7sA9g2S4hiaPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSFAsjI4RKxzCSwuuNvWLLX7wfWTuaA4oFx8GHmgf7GrGhteGKTHCdKeKJYQs30axS2dakA0zWWtMQGpajDgGoakWynybuhT+GDNeYXw7ju/LfsLjVk+LfzS3FfQy0oFTEfCWtZvfOnzkRjFy1mS7KDnYT4oOFSygKchuTKdcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=aoJWMYDL; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 106051FA3E;
	Thu,  6 Jun 2024 12:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717669124;
	bh=dN5/fh4QlibifiNZ67tzrgy1jJMvB8O2q5AwC6b+y2U=; h=From:To:Subject;
	b=aoJWMYDLP2NcXP/7VWEY3DSaPqCal2yvSRGxqG6mOgkcvJa3dKRe0rQwgZF7EuFIr
	 4fmIOa3+TmqnyqU9yEobMvCJE1AifCNjhE6ZkqigyPDbYwit4XSxExDYm8pC3g9L7A
	 r6ux2GublRBImbXTCxXBr4fE00N1qNyOhprUEgrB4Ozich5Pb7cG1QvxXfM4Oq4JqP
	 /tMpe2dCB0dL5rOQN7W528wQ9Qwfw1mA0LQn6J32l3FNOtmVVWkoeMyks9oVMUwcwq
	 Y11tj5V0SVu5VSQ8zgoXetGC6ACMDs9HBACsBqmBi7CoKBbAlSvF8jorZ5/hlDX0O8
	 kJnQIcjyjReHA==
Date: Thu, 6 Jun 2024 12:18:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Andreas Kemnade <andreas@kemnade.info>, yu-hao.lin@nxp.com,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>,
	linux-firmware@kernel.org, briannorris@chromium.org,
	francesco@dolcini.it, linux-wireless@vger.kernel.org,
	lukas@wunner.de
Subject: Re: mwifiex firmware mrvl/sd8987_uapsta.bin missing in the firmware
 git
Message-ID: <20240606101839.GA76158@francesco-nb>
References: <20240605160013.6bea8d4d@aktux>
 <_pNnwoI9WHlb2EY635KdIv6t_goU-ZYp9Vav31jkFOCf9fCE9EeKdyCea2m-L8pgfsKIQvODlnQLhQqmWSYip9e6FFZwaJHL5-u5rdOS_kY=@protonmail.ch>
 <20240605174709.5043af8f@akair>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605174709.5043af8f@akair>

+Neeraj

Hello David, hello Neeraj

On Wed, Jun 05, 2024 at 05:47:09PM +0200, Andreas Kemnade wrote:
> But that is all legalese and I am not a lawyer... Best is of course
> something officially added from NXP. No idea if it can be done
> otherwise. How to make NXP add something?

Would it be possible for you to get these firmware files added to the
official linux-firmware git repo? 

I am not using sd8987 myself, from what I read in the thread probably
some file name would need to be corrected (I would say in the mwifiex
driver).

Thanks,
Francesco


