Return-Path: <linux-wireless+bounces-21216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE7A7EF48
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 22:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 104877A306D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E204219A8F;
	Mon,  7 Apr 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijtN8vE1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041719AD5C;
	Mon,  7 Apr 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057800; cv=none; b=I1XYezx+4MZQQqd1Kyxa3HXJGFMaVmDpwsonaT3eywMZn3WZKJxeEvRye2wD3bhWW/3JV4sOk5dj1QAphRt31V6FH7p5Sn60MdTCdPDwL0OGScoX8/pK5Ca9WRT863bMWQRzPW9NPhXyx7Ww91y4Ls+ZMBUCRje4Hl6FR/gHSHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057800; c=relaxed/simple;
	bh=0uUkcmMmCH8WwPbyW/FUIokF4YZ8d9l+tAMA/lRdEMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTzBWXfb4yi17z5VyyLG4qzj3mg1jxEBC+NVH0+6RZaMRDh1U/4W0jsi2fxteTPrm642y4Zm4hedrFPzy3C0t5+YnkgqMwGpVfeVWNgDKngfINHsQTRIhV8Jyg0u7sZkHcg1l3WM7gWZ5QIS3Rg1pKobq9IY73kh8sIGlkFfa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijtN8vE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8A7C4CEDD;
	Mon,  7 Apr 2025 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744057799;
	bh=0uUkcmMmCH8WwPbyW/FUIokF4YZ8d9l+tAMA/lRdEMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijtN8vE1wTmMMbsno3dXsqAt6uPU8o34qh60buT3USx3lpBJM48f/zHZH81G63+a4
	 kos8PrKFUW4U/GPzv+46aag51ZOiGcJjPOjuLnpMUM2JnFjjAijMLCDNDBBVgzYSvo
	 bztWtGzsRmjKjhZyg2u9m+aXv9DGpYBUXuM0gkRwH9iKBOIzfSQgma/EamUblQNUMO
	 /eCODv3MdScNttANiTxGAHp32lcoHU5X83u5J5H2IoYBlGhWZIKtO1jcKRS/fKpm/C
	 oP3gxjRzrO0K8Fkmmn26dfeTWgM8j/oZQoOofAB6GuV/p52c2whLB+1rYMI66HU/9F
	 nPPJuXAGBw+tQ==
Date: Mon, 7 Apr 2025 13:29:56 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: ath12k: core.h: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504071329.B7BE91F6A0@keescook>
References: <Z8-Snz86Xfwdlyd7@kspp>
 <202504071138.98D5B6E@keescook>
 <620d7c53-e8eb-4816-a9c2-d4bcd44b5d96@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <620d7c53-e8eb-4816-a9c2-d4bcd44b5d96@oss.qualcomm.com>

On Mon, Apr 07, 2025 at 11:45:15AM -0700, Jeff Johnson wrote:
> On 4/7/2025 11:39 AM, Kees Cook wrote:
> > On Tue, Mar 11, 2025 at 12:02:15PM +1030, Gustavo A. R. Silva wrote:
> >> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> >> getting ready to enable it, globally.
> >>
> >> Move the conflicting declaration to the end of the structure. Notice
> >> that `struct ieee80211_chanctx_conf` is a flexible structure --a
> >> structure that contains a flexible-array member.
> >>
> >> Fix 30 of the following warnings:
> >>
> >> drivers/net/wireless/ath/ath12k/core.h:298:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > 
> > Hi, just checking in on this patch. Is some adjustment needed for this
> > to land?
> > 
> > Thanks!
> 
> There is an alternate solution which should land in the next iteration of
> linux-next (I just enabled the post-merge-window flow from ath-next)
> 
> https://lore.kernel.org/all/20250321-ath12k-dont-put-chanctx-in-arvif-v1-1-c8e93061952b@quicinc.com/

Ah-ha! Thank you! :)

-Kees

-- 
Kees Cook

