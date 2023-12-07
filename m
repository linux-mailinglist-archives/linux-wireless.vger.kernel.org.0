Return-Path: <linux-wireless+bounces-551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD5808D03
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4092817B1
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A111446DF;
	Thu,  7 Dec 2023 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRO/73Yh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2BA3309C
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC9AC433CA;
	Thu,  7 Dec 2023 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701966090;
	bh=8vGpLp3+bjYjIpmxZeb1wm8wdVrlZJ6LWlZ0kMqu1U8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LRO/73Yhf+RL7+j+KH0CFfGPtFC53ihdzPXUu2wHSPtxKgnsbJoAROr5qDNr7jIt2
	 ROdWFOS0x1E/QfWJ/WG9XtJ8EgGXoO3imhJI6RExzhup1qXIbudcS2CkuFWr1mZQMW
	 GGFPpm+NEYZ09w/6sCGMTIFtZL9USO4aCOsuvSWgk5y+XOHyO1oWaRdIIAsb7dco/n
	 /1IlAm2VRMcquosK7sAkCx4lcQlGeSfIUSwRUyyMtwB9O2PMUOi48V9nOz0BCDfFm4
	 jzuwj5c8uRcydARDn25JxVXF0sxkS+MZFSbmD1lYjrqaEGO2x5tjL+uAA1Z0pFwp9C
	 CbQSxOoNosS/A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/5] wifi: rtw89: 8922a: dump MAC registers when SER
 occurs
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231204080751.15354-5-pkshih@realtek.com>
References: <20231204080751.15354-5-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <leo.li@realtek.com>, <kevin_yang@realtek.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170196608744.2897000.6455822302893464057.kvalo@kernel.org>
Date: Thu,  7 Dec 2023 16:21:29 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chia-Yuan Li <leo.li@realtek.com>
> 
> To diagnose the reason why firmware or hardware get abnormal, add to dump
> MAC registers related to counters and interrupt masks. With these values,
> people can classify problems and check if registers values are unexpected,
> and then correct them. However, it could possible false alarm because
> firmware triggers this SER event by wrong conditions that we should
> correct it at firmware or register settings.
> 
> In field, SER might happen under special conditions, and very hard to
> happen again, so dump lots of registers to provide rich information to
> catch the problem.
> 
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I can understand printing few essential firmware/hardware information to dmesg
but from quickly looking at the patch it looks like rtw89 is dumping A LOT of
values during a firmware crash. I think that's too extensive and other means
should be considered, for example providing the data using coredump framework.

This is not a blocker but more like a comment for future design decisions.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231204080751.15354-5-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


