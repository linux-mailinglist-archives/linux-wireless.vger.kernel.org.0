Return-Path: <linux-wireless+bounces-12536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3307696DF66
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A993AB232EA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992AE19FA8E;
	Thu,  5 Sep 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9Gox4+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73919E96D;
	Thu,  5 Sep 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553230; cv=none; b=P77pERrJCmsJPrXNCIjjhRoIa3J5VduyvEEU9DtSA8Vvu8CFX3B6dQgUmod9gk3dhULWTN/vR8Wef0fzjNlHSLpj8KGLkSadGy/Ocf1nd+Sal7P7dKTUMYNUR7DMs9u9rTTKt0vgP2ClsJY81ZiXV4qGrzuyrnE37XrupvPX/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553230; c=relaxed/simple;
	bh=qusHqJLOWjw7pUwleJIWBOfj0NWh22390XqDHGqnV8s=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=depwtyQ1o4eGF7S+HDszHDaBFwVajx8A1x7BjLSnYMaUUHXW0/hSeeCDxV+Kx41XLWLylF+mwCwJ7a7na0K5u3sSrqnKKln2rmxKuoERvKHIsmbFIs4FfKiYCYS95JRMX2BKk7l3zrZLXVF9qXmHy/pfIe8gAmImiaAPVvlj2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9Gox4+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6B2C4CEC3;
	Thu,  5 Sep 2024 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553230;
	bh=qusHqJLOWjw7pUwleJIWBOfj0NWh22390XqDHGqnV8s=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=u9Gox4+ENg+5bDZQr5wkDzAyb79a0pTAFY3xI+V/xvYcrcIB42f1zZUtNaI9+TTEr
	 55Wmog8B7A/JP6ZOH2m1aJWueoJ4v+9V09QZ/e27YnKhNl3xUAEqTN8xagYBVuhEVo
	 mIGuuAfUNoxQ5H53IRq4dOVeBFTK84FXQxAkeob4qrQpvEm5+HoCRIzfeWfCx37qqj
	 hyTGsm/jvC53kbwtPHb8YJMDK+KP7K9NRC4x2i4zWRbF0XYW18+XchrL9VD97SoD6A
	 1d2E3+NwgVIItCShSfnE+ahVof65qwvqwU9hTaFAUPuMZLFudpSypHPYDgRliTyuZv
	 C8bzMNVnENptg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: ath12k: Avoid -Wflex-array-member-not-at-end
 warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZrZEuxJihMzAaTVh@cute>
References: <ZrZEuxJihMzAaTVh@cute>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172555322675.1740680.5516276191783582303.kvalo@kernel.org>
Date: Thu,  5 Sep 2024 16:20:28 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct ieee80211_chanctx_conf` is a flexible structure --a
> structure that contains a flexible-array member.
> 
> Also, remove an unused structure.
> 
> Fix the following warnings:
> drivers/net/wireless/ath/ath12k/core.h:290:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/ath/ath12k/dp.h:1499:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

02f454f9aa62 wifi: ath12k: Avoid -Wflex-array-member-not-at-end warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZrZEuxJihMzAaTVh@cute/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


