Return-Path: <linux-wireless+bounces-24753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F30AF0A0C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 06:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61E4E7B0471
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D41DED52;
	Wed,  2 Jul 2025 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3kcTlKg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFC1B9831
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431989; cv=none; b=JO+m/MHNrkIolQF4/zo6T5CMr21tBHxdBXlWGdz+azBm5oeEw0ubMJ4fESQ0xvn17ROghrAXjgrYBAgGegIPc7n/ypu0rnDwiM/sL7QqPPWFoZsgSjk32JEygqS+znxdsBvptnpudA28H0tnY0xYT2NfpRG7VpfXdgeQ8/qHhQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431989; c=relaxed/simple;
	bh=U0MmV9GD7Pjqnyd9ukW4/UdBnpirT6pIr0xOABSdnME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SiBUFxfqXb5rIgAMmhhq9/u2QqvS8pZADavgfiw4aIDxAczHuMM2+OuCDzUPfCT+e5qxcPhAjIME8WnVPmxav/GQ4d9c3B5jJrXFGyW0a1AQqMoST4X5n8Dl+rjWs/kjF0cax5viK7H0FLosufUlhiiMQx1ekM0dy/kHhEXtrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3kcTlKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F11DC4CEEE;
	Wed,  2 Jul 2025 04:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751431988;
	bh=U0MmV9GD7Pjqnyd9ukW4/UdBnpirT6pIr0xOABSdnME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u3kcTlKgD3tl0iHObjuff8/hQx5mG/7/gDzY+mXBkBgwyg6SA5mmasrllcB5LruBy
	 bfRSFKOmDQvfI6Ta89vKv/TSBC1f3kOettz7KuMyhCN42nOOmZIbKJBODq6+GIF/cP
	 2ZBciUVEw3aTBkOp11nkeXjbZGGiSrGZK33VYLLP7OW4Axl2ilbKaVVWVG9iTF9XFM
	 TcKRPbJF1jIrNyUhBpulC9dtmRz05woL1J7oZzkoFjKqZuEpW2y5tmmNvoiZKmsRDt
	 tXt00jCaJibm/F0sLDtLQEDcxOXh7TSjxqHwV/XxXN0VxZXaXBk+l2BpEJ37qaBvwT
	 PgvP9aWh6v57A==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id C2E7D5FC08;
	Wed,  2 Jul 2025 12:53:05 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Duy Hoang <duy@etylix.me>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <12521651747386138@mail-sendbernar-production-main-36.klg.yp-c.yandex.net>
References: <12521651747386138@mail-sendbernar-production-main-36.klg.yp-c.yandex.net>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Vietnam
 (VN) for 2025
Message-Id: <175143198579.473566.3806316258566400343.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 12:53:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 16 May 2025 16:02:18 +0700, Duy Hoang wrote:
> According to [1] and [2]:
> - Update frequency range to match with Circular
> - Update units from dBm to mW to match values listed in Circular
> - Add AUTO-BW flags to allow the use of 160 MHz based on other rules
> - Update to allow use of 6 GHz band
> 
> Detail:
> * 2400 - 2483.5 MHz
>   - 200 mW (23 dBm)
> * 5150 - 5250 MHz
>   - 200 mW (23 dBm)
>   - Indoor only
> * 5250 - 5350 MHz
>   - 100 mW (20 dBm)
>   - DFS/TPC
> * 5470 - 5725 MHz
>   - 500 mW (27 dBm)
>   - DFS/TPC
> * 5725 - 5850 MHz
>   - 1000 mW (30 dBm)
> * 5925 - 6425 MHz
>   - LPI
>     * 200 mW (23 dBm)
>     * Indoor only
>   - VLP
>     * 25 mW (14 dBm)
>     * Indoor and outdoor
> * 57000 - 66000 MHz
>   - 10000 mW
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Vietnam (VN) for 2025
      https://git.kernel.org/wens/wireless-regdb/c/4411b3985baa

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


