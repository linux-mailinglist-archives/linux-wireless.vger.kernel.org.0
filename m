Return-Path: <linux-wireless+bounces-11809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7AF95BC79
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 18:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB964B2480E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC17D1CDFAC;
	Thu, 22 Aug 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQy3dlB3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A01CDFA2;
	Thu, 22 Aug 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345463; cv=none; b=E5T/x61ktZ3NsXKSwhqDoY4KPnRihGAsBFEVD4mYHGru4YnDOMT34mIc3BWcODsPraX1tHjp764oqzEh9nakOtjT4OPsc+6gNuEfHLrKJD4gNzyZUX47Xa5+nrfVLsIi54zChSSCUuce9Y8WJXxfvwT1pSFrs6HNavz7jmBzvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345463; c=relaxed/simple;
	bh=oozyVpdqLg6UHIZBhIKffWsUV8pmA0nK9tulXciIyK8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=O9pr0bXDXzEuIk/tEY21bYEjUePWutvSZV7vnwRzBogdxjfytrfRJjafJfZP89Mw9ycbYmM+4azB4s9nFrTssYsOx38bowBX60cHe6h/NFuFAT70PzmwIj80LM8R6KzTlcOanB5ya5xqNxnqn1hPGvFLFaMR20v1Cj03b0zR5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQy3dlB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A308C32782;
	Thu, 22 Aug 2024 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345463;
	bh=oozyVpdqLg6UHIZBhIKffWsUV8pmA0nK9tulXciIyK8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DQy3dlB31CAuPdwkMLz/PLgQhB931WCGc6mXcX3DCanpioX+jGPbMA2G9XR84yeg6
	 +OvzWQ94nUaIBtwwHQSBJkkrtxfpv/V7uZaTUiTGRGVbfvkxkmqNdwOxfUWYgYKuEh
	 QMhOZSArqVvqZpsBTR9KM7B25O+VVTrhNPS+iTL7HNC4p13BIvYOTYN3MK9sVBC+U0
	 p7jcozUZTZ3twDD8XgCjRWLGs8ArL0y0ETAczuPqaq+2aHCF3TcG8fjlxKaiR/4y8X
	 uVPOw4FniZylRw/jI94ZeUThHEfMHspfx3Y+2Fi5D6U4owgXz7TJ0ngPxlomra2MoW
	 5bclU1bDdrVsg==
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
Message-ID: <172434545943.2469785.15733185765753701476.kvalo@kernel.org>
Date: Thu, 22 Aug 2024 16:51:01 +0000 (UTC)

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

Should I add a similar comment as with the ath11k patch:

https://patchwork.kernel.org/project/linux-wireless/patch/ZrZB3Rjswe0ZXtug@cute/

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZrZEuxJihMzAaTVh@cute/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


