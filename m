Return-Path: <linux-wireless+bounces-2158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321BC8315F7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA789288D88
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E666200BD;
	Thu, 18 Jan 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7f+yUu/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC10200B6
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570633; cv=none; b=Inhf3lQW4yflHhCOUkPdTlq0jV3ENpxZXOMtxAYyeR4H/OTRvlBtcYvKNvHuL2kkQiqsbK65aeyMJeOPbAAsJLfzEp0X0Pb0vFr/5DKzNiqoI+wncbPBBWU7Kv4GyoWj2e6RsdTwuasT/K5AuukByQX9SdRDaJcXia7qjdLFuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570633; c=relaxed/simple;
	bh=nYuNYEjG6LyOzjsAgvrulPFtkAtCEaeVnvrm0+TZHS4=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=N42qCR4vpPqshpVroblE14f2PimUMyj/Ao9P8kBoQqLIjZM2s2bDwyrFXZ/olbfE4nPgEVfOdah/iqVgwoOeaXRSnMKCNyNcK8mLBjEw/TA9fTFDEmBM2ITDnnc/y54ghOpkQkT+mmC3C8OmaHtZJ9qiBzZNb1N/ZCAIdHHLIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7f+yUu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E1FC43394;
	Thu, 18 Jan 2024 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705570632;
	bh=nYuNYEjG6LyOzjsAgvrulPFtkAtCEaeVnvrm0+TZHS4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=l7f+yUu/36u44TGscRzoMh26lKlsfSej6tazInE3eZaqT+QnKLA7ThRVdwb+0SijQ
	 JEiNJ7xhe6LSHjnEGQuM2QOcqzkBCUxqF2ztFvUFSwzpZJVQfuxmPybXnICQIrV21v
	 8XUGkyh0mLSi3BnIR6gU48/raQw3AxXnsS+31KZ+ZjSY/5jmbDU8u4LjvdMRtoas7c
	 P+RNjev9UfI0ikNeM56XAG+izdgaMyqrTS1eQ7P8+65/fx2x5F4kHZ3Q1We4FYMtTb
	 vL7zl2Ed8AL8U5law+QiJCbtfAZeHhtrwoa+nrUzNX5uB4Ntf+nZ72gAsdr5jmNr1P
	 F69K7/UxN+bXw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: convert EN_DESC_ID of TX descriptor
 to
 le32 type
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240116080945.20172-1-pkshih@realtek.com>
References: <20240116080945.20172-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <Jes.Sorensen@gmail.com>, <martin.kaistra@linutronix.de>, <lkp@intel.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557062915.2797779.4326486069336936357.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:37:11 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Fields of TX descriptor are little-endian order, so correct EN_DESC_ID
> field to le32 type.
> 
> Fixes: b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP mode")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401161318.YtXoCkjU-lkp@intel.com/
> Cc: Martin Kaistra <martin.kaistra@linutronix.de>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

426e7b477392 wifi: rtl8xxxu: convert EN_DESC_ID of TX descriptor to le32 type
92c7428f942d wifi: rtl8xxxu: make instances of iface limit and combination to be static const

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240116080945.20172-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


