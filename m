Return-Path: <linux-wireless+bounces-8809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C288C9043D4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A41B1F25872
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6A5731B;
	Tue, 11 Jun 2024 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOrgfbbG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB114A96;
	Tue, 11 Jun 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131277; cv=none; b=SFjC7x4XRbmITaYKtKNBKfv08uFlgtONf92b0guojGKwfYAmT8ysBIvwM/fyrw7sXBIlScSQAwmXtTozDV7eSXayXER/+LpBUPwrimxV+0MhbofLnIAtUDx+ecHLE+WK5c07DJRHnzO/Kgfs89OSe+t16kevTb6jFAhbTk/Iuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131277; c=relaxed/simple;
	bh=P0+kbGBViPVlXWHNujnSAalb1rK+KEqJYTwnL+IIEfQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=DniS/24ZoeYWyz5CMWNnubirzEEVKd2wRBPlA4pSPKYUPi5PP+1uOZiQ5SfwGaxMipJ1Xebh8ZmY2c3Xa2IZVwieiq20sE2bNRIXdM1Yu85gWm9V+cMNY/BFmJDPmYEP2Ph2E+/rkE24wa00VzJuTtIWXf9zsNmfyaC5ew25kSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOrgfbbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE79C2BD10;
	Tue, 11 Jun 2024 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718131276;
	bh=P0+kbGBViPVlXWHNujnSAalb1rK+KEqJYTwnL+IIEfQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FOrgfbbGeCvpAnkAhL/PCPu/D+j2PnA/UhagF/dWDyEsiNt6Hs295i2fBilB8jTlT
	 rt+TFahXScTYiZKR9BBiQal7BvBkIXpTsWAKUv+yXRIgTDz5Zxk9POqcL+/iugn+9g
	 r/QBlzWgNcf/HG+Z8UyI2kWX9yCDd6my8FWB7/DntU+hWi7spuFWvk8413cC5J+IIK
	 YH/PySHue4hED+9UF4f7nSjJFOHfQUaRUYAFFNCs2J5ElpMlzsHXmTltfjUAroNPgB
	 7Cuvt9siTM3am8CMU0eCE5nsuqNuXPEkftfGkyXHeaZFiWT48MusSGf+lypHRNZXFb
	 /WcMP62Jflfcw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: ath11k: use 'time_left' variable with
 wait_event_timeout()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240603091541.8367-2-wsa+renesas@sang-engineering.com>
References: <20240603091541.8367-2-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171813127345.3564613.1259429079165785453.kvalo@kernel.org>
Date: Tue, 11 Jun 2024 18:41:15 +0000 (UTC)

Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_event_timeout() causing patterns like:
> 
>         timeout = wait_event_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Fix to the proper variable type 'long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

65a8368bf34e wifi: ath11k: use 'time_left' variable with wait_event_timeout()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240603091541.8367-2-wsa+renesas@sang-engineering.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


