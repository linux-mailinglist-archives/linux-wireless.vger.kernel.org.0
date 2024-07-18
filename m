Return-Path: <linux-wireless+bounces-10335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4223B93475D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 07:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F3A1C2157C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 05:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676EC38382;
	Thu, 18 Jul 2024 05:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P72l7BtY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41402800
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279051; cv=none; b=ESSR0SKATTOSpg9X8kuYdvrjvfLWs4JYzKQkrRhTw1IafAfccnetmfU40Qi1rABc2keqfrDdHRHYITOz70dBctMHjWQC2Qex+3sRvXzcOMC+ar39HjYBuMJbUP9vrkyGXBGmoJXFw9pGunfAd7btScjMb4djn+721SJgxd7BLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279051; c=relaxed/simple;
	bh=IDWvvuo4DrwacAyOMBIA+EunjMMTtvFBo6WRBGN/+cA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uN/0gdZloVXJxbZboU8+/5XdSd8XKN1Y25NCiyl35OCb3MVlDSPb54uTr/fWK0pXXRkShddVdi+7EUrBxGKazGQrbhdL+J6Axuu3SQrau5vOUfukH6dsItAS7bYsKZA8Q1tsYZtcmGesRbYzXNQFbIRCDqvVUmw6J+hXGUQTY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P72l7BtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A79FC116B1;
	Thu, 18 Jul 2024 05:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721279050;
	bh=IDWvvuo4DrwacAyOMBIA+EunjMMTtvFBo6WRBGN/+cA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P72l7BtYjbtbB47wxa8lu9jX6Ns/WVIetBGGyypmquupqKisJixVzADX8JIKqPsk3
	 4PtwPZjkmzCbkTFG9GIT5SrMymsydgfDv0wsuIExeq23rtwhZ//IS5uvdvp38hreqn
	 tIT0u8/F0TH+zJ3RZVEuPAnqv0B0ScIQMQCamVsHTWAnAPBrRvn5KBLwf+qYgMG0x5
	 anS3C8QcfmVYkFuv6Sn/nq81evniwl8tcvYoDXMwDJZeCz4A8olVVm0v4nH9cTdccU
	 uV8v+Q4VqPJ2Hm12FzhqCQC0ybvyr8PGIZlljeNCkKW4qFt07bfxJ54p9ZpibPfOmD
	 hgydqW4h2auOw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id CC2825FA01;
	Thu, 18 Jul 2024 13:04:07 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240705060613.28909-3-pkshih@gmail.com>
References: <20240705060613.28909-1-pkshih@gmail.com>
 <20240705060613.28909-3-pkshih@gmail.com>
Subject: Re: [PATCH 3/5] wireless-regdb: Update regulatory info for Qatar
 (QA) on 6GHz
Message-Id: <172127904781.1446368.11576831399749742872.b4-ty@kernel.org>
Date: Thu, 18 Jul 2024 13:04:07 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 05 Jul 2024 14:06:11 +0800, Ping-Ke Shih wrote:
> Communications Regulatory Authority, State of Qatar, released
> Class License for the use of RLAN devices over 5925-6425 MHz Band on
> 26 April 2022 [2] via page [1].
> 
> Technical Requirements for the use of RLAN Devices over 5925-6425MHz
>  - Low Power
>    * e.i.r.p 23 dBm
>    * Indoor Use only
>  - Very Low Power
>    * e.i.r.p 14 dBm
>    * Indoor and Outdoor Use
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[3/5] wireless-regdb: Update regulatory info for Qatar (QA) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/c7d1083bc5c1

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


