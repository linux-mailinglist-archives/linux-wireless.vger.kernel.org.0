Return-Path: <linux-wireless+bounces-14169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FE79A2AC4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D08282D55
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541471DF984;
	Thu, 17 Oct 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8Q1XW7y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DB1D95BE
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185693; cv=none; b=IyHzVicrHkQZ77OWqHwaH4HCwLP/uWxcLpoDw3wLsvIgZtndAoBxMrFpXh5XD4FeQ80EdM7KzpqcBVymSPmKO2/7HrO7f2cNWkQhVY3MTSkgabqmDQFeboaqx9vef4hg8desxhn6LfV1f5q78i5/GHxbqTU2YSdDsXXCNo3CbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185693; c=relaxed/simple;
	bh=4kYtN562RMlelbTsHDFEtpQTPWPZMleMgIb/m2w8Ijw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Lodjcxy3vaEgfx76FWUWevkT1Tt4rgq2eRiMfmof9Q8iu40hR4KyT5AShd+++lnLxQkczp1LhsFKywLWVYYrbtXYGKxJHzTkip0m73chU9lsb3D4EAwiZtoy1hPyyoIxbFRZDe2XLfAEUKKXpLzZRYmQiXvXjZGNTxysRRd75zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8Q1XW7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44107C4CEC3;
	Thu, 17 Oct 2024 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729185692;
	bh=4kYtN562RMlelbTsHDFEtpQTPWPZMleMgIb/m2w8Ijw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=J8Q1XW7yju+j34vQhs+0l/LulIA8QDfjJfFIOzyoZeEOvmKIEzfAGA0jD0TAiaHtQ
	 MP2HJj6CBhQ30+tN3xrRsa+ekxfAdZj3cPaT9Y/Dhzpbjyw+LmmgDodVyH2iBl32nT
	 +rFlpjNBeWT3uU0P5l9jciZ4/1UrWL3Hl3J1cGNxQMqlshy+7uef0nIVhyXQmQ5uPz
	 /BB8reRZes/YnfFUmHU4JaqtBoeLs2FHJTjQ4mHO9SBLE6G8CJR6/A7kgIEGtHwH7U
	 NIixNRGu9u2Ri6RTAaSO+WydF/9xZT3lAgGXlma0NB4BrqertIt+aQ88/f3GbQpKFG
	 xWyou7ZJeXqKA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-10-10
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <4a90097d-a2ce-4a30-953e-fb0ddae8d012@RTEXMBS04.realtek.com.tw>
References: <4a90097d-a2ce-4a30-953e-fb0ddae8d012@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918569072.1064610.13386931189755981541.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 17:21:32 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

1f3de77752a7 Merge tag 'rtw-next-2024-10-10' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4a90097d-a2ce-4a30-953e-fb0ddae8d012@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


