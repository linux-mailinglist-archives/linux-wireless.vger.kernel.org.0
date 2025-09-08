Return-Path: <linux-wireless+bounces-27077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73250B48828
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123CF3AA770
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F422ED16B;
	Mon,  8 Sep 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6mBWZ2Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F442EBBBC
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323220; cv=none; b=nfPp6ShcsBCgpY6CsDQI4NUfE/kKKtUwjj45zTkG09rGN95nSWfA1c3ZgF524H2PfSewtbQq4mNVUuaO06BIel6O29jIWeG7cVAWroggLB/6MAiWQtWSC90KxoQ4ZHoEqO4//jJcEHQYldvYY66Owr1+3wm1VxoAesdShn4QmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323220; c=relaxed/simple;
	bh=RvB/XOeZola/zhwtbf12JpjACUKVBX4RRTFpxH1zHso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aUGHeLh8frRR7U8KSifoNAroJUvGg7aNBpc6d9EiyIyPYN32j9bNzY5YrdPpoF2E07z7lbMGp7ZKgGYS/L4B4OpxA0xzj/9MfsEU9wOM4L8BSrhKjBEyfp0LO5/JAMFq5DJoqd3lCVPt/CkKK4j0V4qssv0IiYUM4QP9/v+y+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6mBWZ2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAE9C4CEF8;
	Mon,  8 Sep 2025 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757323220;
	bh=RvB/XOeZola/zhwtbf12JpjACUKVBX4RRTFpxH1zHso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n6mBWZ2Qi4bWMd2yE9xqWTuLdO8tBxsUdEW5DI3ZvnhrysMst2z14h4v8QpMEYXAm
	 SktiVArEQpCCyjs2KhqEHCbgLgj1qCbxtm6I44YCltpyewcDSSUFmPyCVLNCtmzezB
	 k733a2PP0xPm/szbCDv8Cn7P/CWD+pWSp+Ww/ZmAyt8IY9v2oEmzBgVduhO0B4vnHE
	 lK8z/GgijlUEutT8qNcPo8tSTGvH8xfskLeDPSG/LbotvNNZGp5c0xm6LVN/Nmj6iZ
	 SJnaJzHOY8wWRIpRvSvfWXwkWIesWivp3F8sN1A2YDTr8h03P1IarNjwGE895RiRuW
	 2j1k3VjX34Tyw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id D16C45F846;
	Mon, 08 Sep 2025 17:20:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 avalon.vargas.centeno@est.una.ac.cr
In-Reply-To: <20250826004342.5363-1-pkshih@gmail.com>
References: <20250826004342.5363-1-pkshih@gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info including
 bandwidth for Costa Rica (CR) for 2023
Message-Id: <175732321782.1589339.2167695644057038388.b4-ty@kernel.org>
Date: Mon, 08 Sep 2025 17:20:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 26 Aug 2025 08:43:42 +0800, Ping-Ke Shih wrote:
> THE PRESIDENT OF THE REPUBLIC AND THE MINISTER OF SCIENCE, INNOVATION,
> TECHNOLOGY AND TELECOMMUNICATIONS released National Frequency Allocation
> Plan (PNAF) No. 44010-MICITT [1], and effective date from 05/31/2023.
> The table 22 shows maximum power permitted for the frequency bands:
> 
> - 2400 to 2500 MHz
>   36 dBm
> - 5150 to 5350 MHz
>   30 dBm
>   DFS on 5250-5350 MHz
> - 5470 to 5725 MHz
>   30 dBm
>   DFS on 5470-5730 MHz (take 5MHz from next entry)
> - 5725 to 5850 MHz
>   36 dBm
> - 5850 to 5895 MHz
>   36 dBm
> - 5895 to 5925 MHz
>   30 dBm
> - 5925 to 7125 MHz
>   30 dBm, LPI, indoor only
>   14 dBm, VLP, indoor and outdoor
> - 57,000 to 71,000 MHz
>   43 dBm
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info including bandwidth for Costa Rica (CR) for 2023
      https://git.kernel.org/wens/wireless-regdb/c/b484a31c2037

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


