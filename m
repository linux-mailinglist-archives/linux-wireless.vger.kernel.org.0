Return-Path: <linux-wireless+bounces-11295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB894E837
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 10:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D51F242E5
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC81547E2;
	Mon, 12 Aug 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3fw9LUH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6B14E2E9
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449958; cv=none; b=C73NEP6O6M53pKLY537O3eErC24/sPcegOpwOJbhSzOWrWC37w1mXZECwj46dfiuXgE45mnXmxtspfms6GTzL23/AV1s8RggoaM+RLcq6raz3NKHfGmlDyVXtNEvXCpnB4E3VgjLctTCesoGQz571kmW/9wE00QDNJKzxg9DkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449958; c=relaxed/simple;
	bh=hbwKtwDfsxameFtffYw7FC2KXsCOVMuOlmp/ZBpO3WI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pu8sd8LGVSgcsNfbxfVulmRBqfE6ym90Ju7o0Nb2RP+HZzqOgxEU0bh+L/C7w9aQOmJ4JFaBXH06zzijUie85d+noKnlRlkRD5Iwi0rT88dG/JCu1XOENqcyD01+WLNpxZD0h39UDyOx/qycS3SVSZlA2dRMOZRD7Dj94FilmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3fw9LUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBB7C4AF0C;
	Mon, 12 Aug 2024 08:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723449957;
	bh=hbwKtwDfsxameFtffYw7FC2KXsCOVMuOlmp/ZBpO3WI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g3fw9LUHKfLo8yF9s/ZnJxdOp/NEWX/dQhM9XWoZkoQkSxMTVwOMQsUgq095C80dE
	 x5h3CXioM3xWOovsynjCGtb1Funw2DunSkKjrERFQFOxrXjxR2d3OgrPwdSjK7bnEx
	 hSfZZEYGqGjNFjHiJkJCMOIb3zCQAMpKw2DHo+35+6fEUx7vLLmGAdFD1no8HCW8UR
	 d4Adi9iZ9UXNNonYSAPemr569BnNLgBhCnVWRyatggeiT7lxxw6GmA3nPuiO+LHzyC
	 Zx+UssU+M3cNkql2s9Sl8K+/0RLWKH5nYKJ5FN4L4nhjrzO5h1Tduh1IYmZPcWFCCB
	 pqefuWPm0l+dA==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 72A775FC82;
	Mon, 12 Aug 2024 16:05:55 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240809002810.4140-1-pkshih@gmail.com>
References: <20240809002810.4140-1-pkshih@gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for
 Guatemala (GT) for 2020
Message-Id: <172344995546.1735423.1638904193721245923.b4-ty@kernel.org>
Date: Mon, 12 Aug 2024 16:05:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 09 Aug 2024 08:28:10 +0800, Ping-Ke Shih wrote:
> Superintendence of Telecommunications of Guatemala released NATIONAL TABLE
> OF ATTRIBUTION OF FREQUENCIES RADIO ELECTRICS on 2020 [1] on page [2].
> 
> * GTM-30
>   - 2,400.0 - 2,483.5 MHz, 500 mW (26.99 dBm)
> 
> * GTM-45
>   indoor operation
>   - 5,150 - 5,350 MHz, 200 mW (23.01 dBm)
>   - 5,470 - 5,725 MHz, 250 mW (23.98 dBm)
>   - 5,725 - 5,850 MHz, 500 mW (26.99 dBm)
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Guatemala (GT) for 2020
      https://git.kernel.org/wens/wireless-regdb/c/21fcb86afa06

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


