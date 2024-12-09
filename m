Return-Path: <linux-wireless+bounces-16018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E99E8B32
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 06:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453422814DA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781820FABC;
	Mon,  9 Dec 2024 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXZhlK9H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3120FA99
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723524; cv=none; b=iSvC5OLrsqyiIlXR1V9KB4ClaD+29sK6rEHj/nSFp/1k9txT2ATq9dyF1bNm8ZA9q5b+FKMVyg8aKKDdtIxFd4QbFFhLLqYBapAs53mYeB+ePjaIbjvLKKl13QiZeZWCFApylotQm/BoCbwHTIuruLZjvX1RLqeineARHx0Eebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723524; c=relaxed/simple;
	bh=mwiIiqNIdB6mZrBb7/PSo4K5yBcLR0YgHtklPxn8qaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JmJnSqVGh54EXHj+q/VhIA+JrLDMEcr4yPs1w5nKxc8QyJpmYp8sbzLr4SKarZllwruax040WzjA5wblU5ezm02/Jh53VZka4f0dIsO0qjVAsFB1sTHl64sWS1QoLczJ0FePykI+ycxJuhVvm5l8rSS3efPk3UwFuVNfA5V6M3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXZhlK9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BAEC4CED1;
	Mon,  9 Dec 2024 05:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733723523;
	bh=mwiIiqNIdB6mZrBb7/PSo4K5yBcLR0YgHtklPxn8qaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AXZhlK9H9t0xiznfxZNu0Fi610flMLslYT5xoPD5edmlqHNhBay/X9FMdp9o8oI1Y
	 7LtDDVySNDZWcYXEHaZ/xzj2dp1lvPUle6F1w4k8pTegkQQfFB4m89aMFgyYEDKw4B
	 pWNocdEinK2e0nrXPamsrQ1GqUFwwJlY943WdVGDqy9KnkHjneqnhq9jv9nN0EeeFz
	 n+B1Kn/aRl8osvUNqUNfjAd431rMC14jrqauUQw+6PkUn4iggBUAZqUjZgk3oyf17q
	 z62ImsHcqGsfwcL3f3lZU/CjB2GuRO0BX5LF5AH7Sz/eQ6WH0at3iSUcdVx0X5aVcX
	 6kFkiCz+HwYWw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 9F0785FD3D;
	Mon,  9 Dec 2024 13:52:00 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20241021071506.24320-1-pkshih@gmail.com>
References: <20241021071506.24320-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Oman (OM)
Message-Id: <173372352062.3392947.8322619197587000209.b4-ty@kernel.org>
Date: Mon, 09 Dec 2024 13:52:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 21 Oct 2024 15:15:06 +0800, Ping-Ke Shih wrote:
> Sultanate of Oman, Telecommunications Regulatory Authority released
> Technical Specifications for Wideband and Broadband Data Transmission
> Systems [1].
> 
> * 2400-2483.5 MHz
>   - 100 mW max. mean EIRP
>   - indoor use only
> * 5150-5250 MHz
>   - 200 mW max. mean EIRP
> * 5250-5350 MHz
>   - 200 mW max. mean EIRP
>   - TPC: if TPC is not used, then the maximum permitted mean EIRP and the
>          corresponding mean EIRP density limits shall be reduced by 3 dB.
>          (20 dBm is adopted)
>   - DFS
> * 5470-5725 MHz
>   - 1 W max. mean EIRP
>   - TPC: if TPC is not used, then the maximum permitted mean EIRP and the
>          corresponding mean EIRP density limits shall be reduced by 3 dB.
>          (27 dBm is adopted)
>   - DFS
> * 5725-5850 MHz
>   - 2 W max. mean EIRP
>   - TPC: FWA systems operating in frequency band 5725-5850 MHz shall
>          employ TPC with a range of at least 5 dB.
>          (28 dBm Is adopted)
>   - Outdoor use only
>     (Since NO-INDOOR flag is not supported by current format, don't add
>      this entry.)
>   - DFS
> * 5925-6425 MHz
>   - 200 mW max. mean EIRP
>   - Indoor use only
> * 57-66 GHz
>   - 40 dBm max. mean EIRP
>   - Indoor use only
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Oman (OM)
      https://git.kernel.org/wens/wireless-regdb/c/f67f40d00919

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


