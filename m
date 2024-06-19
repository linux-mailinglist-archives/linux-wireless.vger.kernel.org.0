Return-Path: <linux-wireless+bounces-9246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5AC90EF91
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD97C1C20AB5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910B71DDCE;
	Wed, 19 Jun 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWGXuOxB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD26D26A
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805622; cv=none; b=s6u4hKjjyXxT99uT1O4YB6+xZ5JFlLzPJc8cTY2m+kUx5KEh0waWHwLkbHqsDiPBhRx/FZ2t8Wt+aVept6jA3M/kle1j9+rc6AHmGquNqzkr6v9ks3LQ4YpBQuUMMzum3gf1FJLlMIxLjtLfB4+cg44c59QNj2GMwNzXoYd2YBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805622; c=relaxed/simple;
	bh=n+YNzpWU7EqoHXf4jXkEv4zoHXbpTG8VTVOb1pLg/gU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=JNf47rEZjAdy5STKKEnaAWLD0XQ8yiLfVbbQJ7XeyJtSxci1M+lufbb9vog9PaJLlAPXCornh9Bnr1ESI5JLG8MDevfymPNWXpdEkKU5YbP7jOprsxlB4GDvfjOY+9B7hMPzj/ZLXsWqyfXWOHBuGw9VIDpBPgnT2y9YYB4lwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWGXuOxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B9AC2BBFC;
	Wed, 19 Jun 2024 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805622;
	bh=n+YNzpWU7EqoHXf4jXkEv4zoHXbpTG8VTVOb1pLg/gU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cWGXuOxBERxyQugmXDPdDQGEKwJqahtLfbmDW05qbE6rb2EweuWF3DGrCZlN22oWi
	 fv/DiYujYFJ1raLjXVSMNpFe0BXwn7q9TzhJhFA6Xd3fMR4FVhHiXIuqc1Dc7WW8S6
	 0flPcLzXN8lAzn4fVOinMGZVmkSpc4WozZznEQ+ogmhNFdwA5RBuL8KkFHMJDcQqzc
	 cxkgYsXqu/HYxP+ykDSUjhnkMlTfDqJK4fr13VZHLNMTu9XzVcWkGnyRIiYIYU4IVo
	 3S+0RuHVtPhqJ0vqFYLFT6vCeCv4bx8tqbeCLZz/HKv5KKSK3llsQxDRTx23I+Nf3e
	 XrA5W+lLtwBjg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: modify the calculation of the average
 signal
 strength in station mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240309121129.5379-1-quic_lingbok@quicinc.com>
References: <20240309121129.5379-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171880561937.581414.6854820032353365399.kvalo@kernel.org>
Date: Wed, 19 Jun 2024 14:00:21 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> Currently, the calculation of the average signal strength in station mode
> is incorrect.
> 
> This is because before calculating the average signal strength, ath11k need
> to determine whether the hardware and firmware support db2dbm, if the
> hardware and firmware support db2dbm, do not need to add noise floor,
> otherwise, need to add noise floor.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

aadeee47e9d7 wifi: ath11k: modify the calculation of the average signal strength in station mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240309121129.5379-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


