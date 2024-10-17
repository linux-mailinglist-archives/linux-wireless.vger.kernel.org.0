Return-Path: <linux-wireless+bounces-14163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1649B9A2987
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0AB280AA7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B591DF73C;
	Thu, 17 Oct 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTNImOsQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9551DEFF7;
	Thu, 17 Oct 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183761; cv=none; b=EvJabIEnx4JUKMqVO8NFmwirWKFkJsIUkvsGS8ybVfhbrEV9YB3ZVHY4zlbaAsWraULohPg8AzD2/m1hBICZjLRPOt8xqFttbUe/AxVXlEeD/hP/o8APFn/Y9u4blSrdPkjZxkj57gF33Pdl35s1rNwXOchLXYU3mB3ooCMgtbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183761; c=relaxed/simple;
	bh=5oVVOjpDieq/9tl5DT0OB3tiHRSUmsarzFp+M6qTTvo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=r2HOB3IHTYbhuVMga3J5jpKa3D2M3YL7SY93J0zXTbsd6YHSlIHwSfsdSUL9kzLQCBG83ujD28UG8/FkJ7RrkB2Eo1SuMK35n9AmxghUbfyqyBF4xEw7rHfoPN8RpY+XoBJTY2g+UBK0q/FqJQ9yIyuiBGGNLk/pv580TF3mfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTNImOsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F82AC4CECD;
	Thu, 17 Oct 2024 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183761;
	bh=5oVVOjpDieq/9tl5DT0OB3tiHRSUmsarzFp+M6qTTvo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UTNImOsQyS5/xVMPLYsh4RLQjQjxGrF5/RcmQyz6wL5kQVMBePI/xhxjsAUG7dvo3
	 yy4K9oMv4pUlEcGt7ROxhMy7pttaYzDcYTrHHyIke+RIOITWOkfFRILFM6mQ2ie7AK
	 K1CKlAa18HJJOydiYEccg0mvD85NaQzgVHfbGUefDuFMPZ0zzSH44LQ2oyV4jGfz3c
	 ksC7nAvbojL6KqeYnB792cenPudPVr8WJfmGb3D2fPbmO/UUHisO0GW7LGHizoWTWw
	 3RJZ8Gb2nsjx7nsQgv3pzeHUw5R6KrUaTY64pUiH+dpnpGEG44WKTi1lV+qFQgX6qd
	 5f7oU7XqaPXiQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmfmac: Remove unused brcmf_cfg80211_get_iftype()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241004004252.470836-1-linux@treblig.org>
References: <20241004004252.470836-1-linux@treblig.org>
To: linux@treblig.org
Cc: arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918375791.970100.1035976290251694294.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:49:19 +0000 (UTC)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> brcmf_cfg80211_get_iftype() has been unused since 2013's commit
> 5cd51c2bad56 ("brcmfmac: Find correct MAC descriptor in case of TDLS.")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Patch applied to wireless-next.git, thanks.

e2e25113473b wifi: brcmfmac: Remove unused brcmf_cfg80211_get_iftype()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241004004252.470836-1-linux@treblig.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


