Return-Path: <linux-wireless+bounces-13574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952CA9922F4
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 05:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E0C282A0E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 03:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7C17BA4;
	Mon,  7 Oct 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiWtr4fT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A91799D
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728271672; cv=none; b=iHY98ya6ni2fP0Jvms7uc0klyWTd3FcJHzqHXDaPGh48jKCjnecW1IBDsQD9SLQKOzOfkmQu1gdsWt7WJ3lcAei1zq3Pv6U+HtlFt9wfqUuismjAQHdZlaMtzWGPsYA2ZjqHxeori/bjmE13eNxpAnXR8ZrltbW6qoolskvMTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728271672; c=relaxed/simple;
	bh=qgA/3jdhECS8vtzuX2ovSKREmuAY6NvzTJCan9Pwcyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rIPATTQ7XQbzmol6WGlk8uf1vOkTaSfDc2OXf1qh9U15ORyVigcZlW4Yt0wP85ywHIWW8UDfRZhO0xtGC8oHGmfQK748RdnJYZ8/m6GSblQCjrVxhbMQI0g+FrNGaVSjxLCmjT67OXnfR/XVtiqqRlCR8U0/KwtBWzUNooXNbpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiWtr4fT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220CAC4CECF;
	Mon,  7 Oct 2024 03:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728271672;
	bh=qgA/3jdhECS8vtzuX2ovSKREmuAY6NvzTJCan9Pwcyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RiWtr4fTZu0KUh32gTEckgB9tXIxZWrvQkFD1fdJm5eVzyuQJNiFSHckG7XoGoVHY
	 UA/k86WvOB5AhP86E2lgxOvtBexKG56IaUH0zoTZ+UzZzBLt7osfhv0F9iKHiFrU2s
	 0WJMY06Q5erxrbXbrWQ0dZ6LBHgJzclZ4zPPnD1ASu72YfQlC9vO28tmwkFVfv/84h
	 GE9Ka6z3KBuXnWwvBX4OlpXRp/XALZ51k9WXb1SiC3oe6c3UcvT23OqKPeGTLvClRJ
	 gTq19WRPhQMUbdOUYlf5VR+5/rVXdkZvo6dv5wbf0gsvq1patEuB7G3AjwOheTZIKH
	 HXsA/r8C96wJw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 61C5B5FD7F;
	Mon,  7 Oct 2024 11:27:49 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20241001063430.8347-1-pkshih@gmail.com>
References: <20241001063430.8347-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Pakistan
 (PK) for 2024
Message-Id: <172827166939.1242641.9655444804404520136.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 11:27:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 01 Oct 2024 14:34:30 +0800, Ping-Ke Shih wrote:
> The Pakistan Telecommunication Authority released FRAMEWORK FOR WIRELESS
> LOCAL AREA NETWORK - 2024 [1]
> 
> * 2.40-2.50 GHz
>   - 30 dBm EIRP
> * 5.725-5.875 GHz
>   - 30 dBm EIRP
> * 5.925- 6.425 GHz
>   - Indoor use Only
>     * 23 dBm Maximum mean EIRP
>     * Power Spectral Density of WLAN operating under this provision shall
>       not exceed 10 dBm/MHz.
>   - Outdoor use
>     * 14 dBm Maximum mean EIRP
>     * Power Spectral Density of WLAN operating under this provision shall:
>       - not exceed 1 dBm/MHz.
>       - not exceed 10 dBm/MHz for narrowband operations on BWs below 20 MHz
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Pakistan (PK) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/29633a689bbb

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


