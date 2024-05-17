Return-Path: <linux-wireless+bounces-7773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7258C8247
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186141C21F15
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747618651;
	Fri, 17 May 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J93yxSwB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8725632;
	Fri, 17 May 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933067; cv=none; b=FTZP6i/R4UDcEGW5ze7LnxfEMXFrC0YAwaTofzdn1oGT/pX6XCGMLJexDyVF3dvONNJLXqWxsHBg0uOZHzJhE/z1sl5DNhuF93EXvUxGuOW2LJyfcJjC45eJr5SOdCaQuOC4nBo9S2YPdgt942cGtoWhbhMouOGChGKQbWtqotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933067; c=relaxed/simple;
	bh=lcsdTwwDB11JUOFdYAsiNPSGzqe1+RPigLkU1Tmc66U=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kiSLKbUMy9fH6vogG3OObWzCxeF9qLCqmZUS2DbYbR/xezBSksSpD1AJ8J8wRH8K3QTr9R+ka7zkNV/2HSwb1m90d0TBIyP8iG62+4HCdWQ2ItEvG3xRrybkoHqGbWl3inUKVb0XjLTWsxdk4kPnH6gmK6XCi3x4JlwD9Hf79ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J93yxSwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECACC2BD10;
	Fri, 17 May 2024 08:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715933067;
	bh=lcsdTwwDB11JUOFdYAsiNPSGzqe1+RPigLkU1Tmc66U=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=J93yxSwB4s0J4kRIh5DyQorBe0m6Ul4Wsln75JeAv5l4yM6nGFxkvIYSAjLZCDnNt
	 W3V74BG3xWpftFmK/bNqlfkbgFokzaARn/ffc5jmp9s+R7njeFqpLsHPQd2wXP5CkB
	 3pOnIx/HT6XAnv29F4O/AoU4c4f3+RZBMyvXkn9hMOAvgs08+HuyFZat1sWi04GUOQ
	 dUa92NJUda15TSG0bcmQBemi72nIUCYlJ1sR5JlFm58QDYTFgsmquFdohvTZ51O0E3
	 BdRsuXKr/g1RtS1UalDAgce6NR7Tz+oJ2s5GGPLDuW5erBk6F5tTiTZ6UI/X76hSUO
	 p5TSlkcujvebw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v1] wifi: mwifiex: Fix interface type change
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240510110458.15475-1-francesco@dolcini.it>
References: <20240510110458.15475-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 Rafael Beims <rafael.beims@toradex.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, tsung-hsien.hsieh@nxp.com,
 David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171593306296.3274748.4179889716794962474.kvalo@kernel.org>
Date: Fri, 17 May 2024 08:04:24 +0000 (UTC)

Francesco Dolcini <francesco@dolcini.it> wrote:

> From: Rafael Beims <rafael.beims@toradex.com>
> 
> When changing the interface type we also need to update the bss_num, the
> driver private data is searched based on a unique (bss_type, bss_num)
> tuple, therefore every time bss_type changes, bss_num must also change.
> 
> This fixes for example an issue in which, after the mode changed, a
> wireless scan on the changed interface would not finish, leading to
> repeated -EBUSY messages to userspace when other scan requests were
> sent.
> 
> Fixes: c606008b7062 ("mwifiex: Properly initialize private structure on interface type changes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

BTW I removed the Reviewed-by from the commit message, I don't see the need to
have both Reviewed-by and s-o-b.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240510110458.15475-1-francesco@dolcini.it/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


