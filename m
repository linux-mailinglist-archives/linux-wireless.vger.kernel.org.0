Return-Path: <linux-wireless+bounces-16013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973169E8A65
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AE628158D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC861865EF;
	Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwbtnceu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC416F288
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718962; cv=none; b=PYTWgRQqbwDXxltmriyK3YlNqCT/3ppTCx2Up6vqRsqnl/wy5aL/ooQg7LWstGdUhslN7fPhvkj+Wyihk3h9TJB/orxodKtyoCAH0clThs+SiYfuOXQTDshUeAeiyFSS3SbYjF76vswiAMPSRbrHZsnWcK7pu4PxwCs0ivOT3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718962; c=relaxed/simple;
	bh=SrFuC2cACAF9b4v9Yx/EtOo47eh8ATqR+yQQGwdO6wc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d+HseKH1wXH5lSGOBZYj9uQ1EbLMXy9ONrk9ndZgLJTXWI/ZfgzlWLmfxi+91HAEc4Vr1rNrJ4pYDn0iZsuxl6AoMbqd47suvrNSpsfZRiYH2RoVQpRLyKXa2BElb+CXv08oChphuSfmKHa7h1ECHOnCNjh5ED9Rm9v/LRQjEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwbtnceu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8AEC4CEE0;
	Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733718962;
	bh=SrFuC2cACAF9b4v9Yx/EtOo47eh8ATqR+yQQGwdO6wc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pwbtnceuqm4YMJxKKWizBUvwIB07cHMFoi5T6VGWTnGnj8DeWZStVmFl4dkYTP0tx
	 qYAjjIbPMezu15Y3zI/qthcce1zE8g1jh1PrxCZts3ZPeLQkNWMYogmbJVTilJlgPK
	 vamGbcgYEsLe+iPm2AtGmWh77KGkVVl0Vs8u41iEYY0mLj0SfCe0cnr/Uatt0cjnE2
	 q3vFZ5xzMUcAZ3VXvvqKYS9PJ48IWybg3mKvFlRkuOqWjX7nIhKFdpThc1heevrWMy
	 VS9iFwE4JUMqp4Uy3NcaBN+a43bSi6YHSTikvyEUNXSpxKPW2wDDNyG8FeVQQ0CUV5
	 2wc4Tafi3p2BQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 933FA5FD3D;
	Mon,  9 Dec 2024 12:35:59 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20241116082516.8819-1-pkshih@gmail.com>
References: <20241116082516.8819-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Syria (SY)
 for 2020
Message-Id: <173371895959.3369899.2451835461936606249.b4-ty@kernel.org>
Date: Mon, 09 Dec 2024 12:35:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sat, 16 Nov 2024 16:25:16 +0800, Ping-Ke Shih wrote:
> Syrian Arab Republic, Telecommunications and Post Regulatory Authority
> released regulations for Short range devices approved by Board of
> Commissioners Resolution No. 18 dated 3/14/2020 [2] via page [1].
> 
> In page 8, section WIDEBAND DATA TRANSMISSION SYSTEMS defines
> 
> * 2400-2483.5 MHz
>   - 100 mW EIRP
>   - Indoor only
>   - EN 300 328
> * 5150-5250 MHz
>   - 200 mW EIRP
>   - Indoor only
>   - EN 301 893
> * 5250-5350 MHz
>   - 200 mW EIRP
>   - Indoor only
>   - EN 301 893
>     * DFS
> * 5470-5725 MHz
>   - 200 mW EIRP
>   - Indoor
>   - EN 301 893
>     * DFS
> * 5725-5875 MHz
>   - 200 mW EIRP
>   - Indoor only
>   - EN 302 502 (In [2], EN 301 893 should be a typo)
>     * DFS: 5725 - 5850
> * 57-66 GHz
>   - 40 dBm EIRP
>   - Indoor only
>   - EN 302 567
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Syria (SY) for 2020
      https://git.kernel.org/wens/wireless-regdb/c/68588bffdc5c

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


