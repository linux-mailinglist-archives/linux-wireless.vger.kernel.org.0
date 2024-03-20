Return-Path: <linux-wireless+bounces-4982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 644388812B9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950C81C23611
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB03D54C;
	Wed, 20 Mar 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYXV8ApL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24A29CFD
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942897; cv=none; b=KZpR+B3dx2CcOMYILb4jO3qsFd4kI9KGnoNrN2kOhgk8kWPwHg8aCIrvLMxqObjQfje4WYApQJWXzNEKHE83frUL0WAutyoNzgJOYG4mZhyIOxz1S+vyPYVxj65ZPJxkNg4wnpQhuDa5ut/N86MBJtiOdhELN+avLbfCZRUiOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942897; c=relaxed/simple;
	bh=dkNkQOh/hGTDH36C/RRIAKYFE7cHmZYvbi6VnYqum04=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=V+EOI3X5Jo7MA1zbJOB0TKJn4GBSy1ofjsR1Olqtn5y29dzPsOgWBS5r/Vj7zWNjwyg59m8zLB0NjiLXa+FSW5DJx3zch+ONpQqdhdMMTWv3jFUI01/XUMg3KUpI3ExHA3hHnn2/45m4NHrFQaj+fHShkv9dqzL1RBaSDDcBLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYXV8ApL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D5EC433C7;
	Wed, 20 Mar 2024 13:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710942897;
	bh=dkNkQOh/hGTDH36C/RRIAKYFE7cHmZYvbi6VnYqum04=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mYXV8ApLa1bDQARvPiawF/0gxAzPKsYISzuIIglBOjgubQHXOT2yNg9gNl6rO7rGg
	 WhbugaE/TYD0jlEZaEFY+3kmwACbxZImPsABSOgP0BifpPZGkqV6V7lA1C9K87cVkI
	 ESm4FUlQBVi9rMIThCo9SFZr3rzUq9Uzubi0qS6BG5M+dvevMr/FEtvqmN10yNSxhM
	 j8O4xilxrGaITgiKLyiZXUErp+6AqnPEuTlCd2CIcTX4SM7E8o5IKUruz0RNz9gJQ5
	 RLj3lpGpsHhtZ/ZYFY3YDKnbSxFNOsGKnQmExkesuGpg5dx6MXVS1UTwyUxef1nHnT
	 XsknlfVy9oFIQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: remove duplicate definitions in wmi.h
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240314021654.304451-1-quic_kangyang@quicinc.com>
References: <20240314021654.304451-1-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171094289438.3225057.14544830230083761491.kvalo@kernel.org>
Date: Wed, 20 Mar 2024 13:54:56 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> There are some duplicate definitions in wmi.h, remove them.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

There was a conflict but git-am handled that automatically:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=5955a10e0a46d46216420b8d2b6c0a1c895892af

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240314021654.304451-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


