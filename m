Return-Path: <linux-wireless+bounces-10856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B16C9457ED
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 08:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8931C23512
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 06:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45F249EB;
	Fri,  2 Aug 2024 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0lLugXS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4171757D
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578784; cv=none; b=Ekn7pmcf0gN3AgcIFfwVPwJSfatlNUYJiE1I7p7OHnMaOawfClRNPQAAUsVOKjoccUvqxzAvHThhH9hIkZqg46q5l76lSK9f6ZKaOCsgeoE+HkzzAqL/yyRQYBr2nBqMDxB56MSYFhVssDepwVpfSOIdZiUdS7yaHAPsGwkvBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578784; c=relaxed/simple;
	bh=SQkJvtEXVrebzVhBgSg0yGtQ1w+NGYlLfUfg4pyXeR4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=abHbhpXHmixTmOcRPeqsLeMeiiS+C7h1F3mX0MID0mZ0PhBMthoI568lld4QfvOyKuos1UrWWva+qFbDaQyo1822i3xvoRoaRcAZ/ZNUsI1v0e0gWbE0ViV458jvvJhtSHGan1dscOl5vj/Pq8SIH3V8jKWiFn7IQommsKhXC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0lLugXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583C7C32782;
	Fri,  2 Aug 2024 06:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722578784;
	bh=SQkJvtEXVrebzVhBgSg0yGtQ1w+NGYlLfUfg4pyXeR4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m0lLugXSS/Idu/4f1UerWKkfu8yfvWMai7zV5FB78Kee92K3tNGVxaYrS5eX9hpqM
	 Q+N8DyqajXwzIiRlTHYmYyBhOF4mz+0LMWPAqKHOooM7Ht8vRO9ud0Bjj2nkGMne8d
	 sOrwA4JuLPv+z5XMpjdYyFnCm6jlCHKC5EXBybQFYGBp8FOZseZ02fn4I73YBTfuZG
	 6vyikxn6EEFyHvrh12SVREDMJUVbfJXe24FvalV/nPR4jSdplfXceh0qOwTYMjoy1G
	 DXOuZYfPkMlsJCBgSCFJn4+s+6BXmAxo2T1XMCqUkUx5C2VaGb1P/0eCzm+59nKcZV
	 pSPhFJ6F9WCmg==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 455AF5F752;
	Fri,  2 Aug 2024 14:06:22 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240719032326.7353-1-pkshih@gmail.com>
References: <20240719032326.7353-1-pkshih@gmail.com>
Subject: Re: [PATCH v2 1/5] wireless-regdb: Update regulatory info for New
 Zealand (NZ) for 2022
Message-Id: <172257878225.1673308.7191951038227374583.b4-ty@kernel.org>
Date: Fri, 02 Aug 2024 14:06:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 19 Jul 2024 11:23:22 +0800, Ping-Ke Shih wrote:
> Radiocommunications Regulations (General User Radio Licence for Short Range
> Devices) Notice 2022 listed spectrum:
> 
> 2400.0000 - 2483.5000
>   * e.i.r.p. 6 dBW (36 dBm)
> 
> 5150.0000 - 5350.0000
>  * the maximum power is 0 dBW (1 W) e.i.r.p. and
>    the maximum permitted power spectral density is -13 dBW/MHz
>    (17 dBm/Hz, 50 mW/MHz) e.i.r.p.
>  * 5250 - 5350 MHz, If Transmitter Power Control is not used, then the
>    maximum power (e.i.r.p.) value shall be reduced by 3 dB.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/5] wireless-regdb: Update regulatory info for New Zealand (NZ) for 2022
      https://git.kernel.org/wens/wireless-regdb/c/bad398523d73
[2/5] wireless-regdb: Update regulatory info for Peru (PE) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/58575b4cc911
[3/5] wireless-regdb: Update regulatory info for El Salvador (SV) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/983f55149d7f
[4/5] wireless-regdb: Update regulatory info for Togo (TG) for 2022
      https://git.kernel.org/wens/wireless-regdb/c/aad0c26a1612
[5/5] wireless-regdb: Add regulatory info for Namibia (NA) for 2023
      https://git.kernel.org/wens/wireless-regdb/c/218d1460e046

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


