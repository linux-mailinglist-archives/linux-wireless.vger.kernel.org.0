Return-Path: <linux-wireless+bounces-13583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C8992A1E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 13:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059FAB220F2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1D1BA86C;
	Mon,  7 Oct 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTb0kfP2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD1199948;
	Mon,  7 Oct 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300009; cv=none; b=N9PuVLesEpHErOYtVdx6cCc0tTdGqXgLfFjo+pmzRweleov7ZRNn62NU3RZeonSX71nW7gBswRJAhVy4X01yn/5XO3rA7s3pfpakFZcGB39ew8XiNQna/R/PsiUUGoW8Uwy56esi6f46DIMTVug432EUG5pE9roaGRVs9eyUOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300009; c=relaxed/simple;
	bh=kjZDC/Kf1R8Y03yq633O0mQsv2RP9MmyoADslJ4TRDM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NP4wiA7guo/bhuIEuqs/GHE6zl5pBzFokme7pPtzTTFXsDwcWhM9CBXdJBDiZ+6HVY8yi3rYu3c968m1E3LVoknG+Y82VQuyMXd65eNrAHJXpHhBmyYWBxd/HlQMQHZWoMKkHNBXv+knhS63jz69KBheyHObq4bXUvpJXOauFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTb0kfP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0AAC4CEC6;
	Mon,  7 Oct 2024 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728300008;
	bh=kjZDC/Kf1R8Y03yq633O0mQsv2RP9MmyoADslJ4TRDM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UTb0kfP2cZ50KyEzL6MbnlEGQMSxWdgRZXx3YVT4AYuDXqJTYgK1UGRiXZtCdI3wV
	 tQHaXq378mHySKMPInmAuJTO/Nd/ROZXvmFR3ZGXYIfKoE0TGdQVq44aYmBnXiVQ6l
	 8lozIGsz4IqXSIydL+MxwqxLCF4w9CU2hQYcT2fG2bo9z+ECPmJG4yQE4OfIF2Y6xY
	 mLAL/Q5GxEfm/4J1YreFnwIBXGIsxyPmRLUDwDZBhJsgdfvu5L/IvjnoYJgdXRLYmT
	 lniHH0hMfSKORjPFwkZSiRPUw/Q+I7Fi0bJrp8hKKycKz6XKRptABWWu4hBKHvXbQM
	 nKu2iFGkkMxLA==
From: Kalle Valo <kvalo@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,
  Kees Cook <kees@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Baochen
 Qiang <quic_bqiang@quicinc.com>,  Arnd Bergmann <arnd@arndb.de>,
  Rameshkumar Sundaram <quic_ramess@quicinc.com>,
  linux-wireless@vger.kernel.org,  ath12k@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix one more memcpy size error
References: <20241004095420.637091-1-arnd@kernel.org>
Date: Mon, 07 Oct 2024 14:20:04 +0300
In-Reply-To: <20241004095420.637091-1-arnd@kernel.org> (Arnd Bergmann's
	message of "Fri, 4 Oct 2024 09:54:13 +0000")
Message-ID: <875xq45fdn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> A previous patch addressed a fortified-memcpy warning on older compilers,
> but there is still a warning on gcc-14 in some configurations:
>
> In file included from include/linux/string.h:390,
>                  from drivers/net/wireless/ath/ath12k/wow.c:7:
> drivers/net/wireless/ath/ath12k/wow.c: In function 'ath12k_wow_convert_8023_to_80211.isra':
> include/linux/fortify-string.h:114:33: error: '__builtin_memcpy' accessing 18446744073709551610 or more bytes at offsets 0 and 0 overlaps 9223372036854775797 bytes at offset -9223372036854775803 [-Werror=restrict]
> include/linux/fortify-string.h:679:26: note: in expansion of macro '__fortify_memcpy_chk'
>   679 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wow.c:199:25: note: in expansion of macro 'memcpy'
>   199 |                         memcpy(pat + a3_ofs - pkt_ofs,
>       |                         ^~~~~~
>
> Address this the same way as the other two, using size_add().
>
> Fixes: b49991d83bba ("wifi: ath12k: fix build vs old compiler")
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

