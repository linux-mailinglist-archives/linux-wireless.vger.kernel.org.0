Return-Path: <linux-wireless+bounces-12401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C309196A680
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA3B1C241CC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFA1917CE;
	Tue,  3 Sep 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjnJYSol"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F618EFF0;
	Tue,  3 Sep 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388199; cv=none; b=Er5N5u42j36QyUbHBAZ2VEQvDIv5UysbejU4/F+cefkkVvr8TuQcCIsflh3oR6C2rwmGjY/EzfNjZAhdtzN0ahWdSd4B0BX2pMCJjrGlcTjyaJ+ZPxAKgyytodfw/RuHaFY5fVu7PuivY3YD7CuI+OfQKivvf6DgzvgMGunlxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388199; c=relaxed/simple;
	bh=uNXi3AVtFux7SXNuTj4/Mhy2r5c4MWPhDexce5mMEc4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=f4vBaPSSfDaUxxghUSKmfKiX7JoNP+u4wWNvVddx2V7H2QiCCWPbL9goXsiyFhTGSiNvEXt6mSU3n+11nkwk1DuNzI9lybszltVvr7u3dlAAN5eUlijibx9j+mhXuaMF8aTRywZ3DJ3hACgkdQIOGU3byVenm8hyUXZoWXH08zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjnJYSol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6A2C4CEC4;
	Tue,  3 Sep 2024 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388198;
	bh=uNXi3AVtFux7SXNuTj4/Mhy2r5c4MWPhDexce5mMEc4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bjnJYSolEvwyPx+KYfoWJCVZiuBPq/lX0WzwRq6AIKSnM35zzZsZflAVoqFd4rTLa
	 etfsiXeeuSrzp085N7jUNb54r7j5vyfWofDTrZzdFIljHhZsS9Y3jZJ4/+VWZ1gJ0F
	 jtfp+aqH+2aXwqQUIXEooZ0r6inu0oUE5A4b/0fkUCU02aUeiDP99RYjI6eH29oW1o
	 QnOrp/KKsSbgOWsXxOHzlVz36N5SsmW8fJFLJFe2VnatR9OVHUXmAnE/BKKol7isKK
	 mr91QmR9MOx/+5ddGA04iC0KvqUUrSgyzRVCpr6K1jmox5zErrM0GK1i4yiHMxPMnp
	 xGznzDCJZRvDQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next v2] wifi: brcmsmac: Use kvmemdup to simplify the
 code
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240821070257.2298559-1-ruanjinjie@huawei.com>
References: <20240821070257.2298559-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <arend.vanspriel@broadcom.com>, <johannes.berg@intel.com>,
 <miriam.rachel.korenblit@intel.com>, <erick.archer@outlook.com>,
 <ruanjinjie@huawei.com>, <emmanuel.grumbach@intel.com>,
 <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
 <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172538819507.1029035.1932092246762477157.kvalo@kernel.org>
Date: Tue,  3 Sep 2024 18:29:56 +0000 (UTC)

Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.
> 
> No functional change.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

d38792292be7 wifi: brcmsmac: Use kvmemdup to simplify the code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240821070257.2298559-1-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


