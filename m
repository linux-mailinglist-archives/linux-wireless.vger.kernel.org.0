Return-Path: <linux-wireless+bounces-12535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C296DF64
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6684628228D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115A19F49E;
	Thu,  5 Sep 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4+fjJZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F9101DE;
	Thu,  5 Sep 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553202; cv=none; b=Fh+HOG8GKG/X1fWQUL0wD6myCXFAQZiA+0QZdFxzdLJWgDKL3tSePfGP8jSi4PxRlRw8ZFUnEcTLm2B5pXBAspCRq6sy80QvbH2lzx6Xa1qevRARc8048HfW7U2++b8Ern0hT0U7q7UsrH8euwAJOqn8vEH34ZLZz9BT0MyrSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553202; c=relaxed/simple;
	bh=nwAsYYrguqDxU9no8Long5e3xKJoCmijbR2bx/gDFhw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jjUWisqebuvjikxD6rB6Rqxz4AAItWrZ9cr3/fghdhNiFugN5NGXI5CwmWoKstqlpkjRJRx5l/j5OAygWMi3T9m22Tm8RjTG5Uvi9L5njggiWI19PHp0rF6gheKzgs9mfO2Zl+eIOC2lNAvsScn4AX5nv5ONy1/QJF1P9YXnvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4+fjJZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F62C4CEC3;
	Thu,  5 Sep 2024 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553201;
	bh=nwAsYYrguqDxU9no8Long5e3xKJoCmijbR2bx/gDFhw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=A4+fjJZFwxZXIo+Fp5KBmDUo2y8g0G56NQINFwik/ZW1ZyjTGwrdRn9STiEXVyVY2
	 VjTUTVFupBsrGajsyjKRxBgUf8IumTRm6MHPUol60y26FYd87vP1C8RhO+OBRqiXBj
	 jZ+XzQsLEqY4Y3jtZtW5WjGvWwM9F6WkNlcEBxikDq/RBZD7Njx8itpS9b+z8cUNf5
	 XlEP4WNQxRONaj55fjBf7dAu5F125t6WdSaWAfUJmf+uYQXjYnUBhSbixMqLCiUWwR
	 rZRa3YA2DyD4EUlSdGSHDRUCHHDahfrINjGED/WAEvXs5nfnWwGb8/yNlapHEFdmFt
	 qQt0bvT+3424w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: ath11k: Avoid -Wflex-array-member-not-at-end
 warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZrZB3Rjswe0ZXtug@cute>
References: <ZrZB3Rjswe0ZXtug@cute>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172555319846.1740680.15884701557144481853.kvalo@kernel.org>
Date: Thu,  5 Sep 2024 16:20:00 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct ieee80211_chanctx_conf` is a flexible structure --a
> structure that contains a flexible-array member.
> 
> Also, remove a couple of unused structures.
> 
> Fix the following warnings:
> drivers/net/wireless/ath/ath11k/core.h:409:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/ath/ath11k/dp.h:1309:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/ath/ath11k/dp.h:1368:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

820aa897837f wifi: ath11k: Avoid -Wflex-array-member-not-at-end warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZrZB3Rjswe0ZXtug@cute/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


