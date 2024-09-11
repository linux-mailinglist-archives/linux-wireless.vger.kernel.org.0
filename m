Return-Path: <linux-wireless+bounces-12799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0C975C08
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 22:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9441C21842
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725613D893;
	Wed, 11 Sep 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6SqiIc9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C53D3B8;
	Wed, 11 Sep 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087523; cv=none; b=bxbIS2MFeQY0olYMVeREvcpGsqjU8A44kzk4uHjHGjw39B7+dtMktS3JwDzX1lZ/MjOaeq4labgksqE3AjvEExkbNoCzbMe3c7xLM+V6OmTrMjyTeB25uNnl0pP/o7+L8rX41pCaasyNM8xlpWJ057XoJy4/VaBxi3JXkKNCB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087523; c=relaxed/simple;
	bh=O7Y69PIgkHEXOoMMCpXya+p8Azq0hznxZoTw6hqs7N4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POHJXn/eFufNmW9B0hCv39ktY+2EFCqFi96WMx80gXDXzotLVwNcq8L5TyEjV/TGOGINamxpmdYdX7hXSWT0fyBba6Bu15l+aXbv5jSqKU/vDTIpfCpFx+RhEJ2cWJ3RvPSr6+zFN9sP3gIZ1n/EawL33moOgqnogpEfmBP3oPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6SqiIc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA92DC4CEC0;
	Wed, 11 Sep 2024 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726087523;
	bh=O7Y69PIgkHEXOoMMCpXya+p8Azq0hznxZoTw6hqs7N4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q6SqiIc9yNxuyQqx/UFI40FeMtxCbDPL8b4N7i4RpA1A7L/r322HZbgErsctwRnwQ
	 eK1t3OpSzC4GB7/iIYcphpzZibit6Eg5fuc9v1nh+jYen1zj1mMli/CkiKzTBvFBGc
	 FXmD3xx7Luta2m5GPRWBMYgS9nLLq1u0HAiFELjAXi89lSYjxvrw+o6NYFFZ7huYe/
	 AWUH4ZepXWvebjmqYO8//pFjEMG11RLKvS1FjHX4eS4mrmNU9mHkip2njd3Id21k2I
	 +pHa8ZlzDTDAkVEEcpufL/0IRfL0kHX3NNkPAU2gZxiD/9hGwMd30YR2oDdsxD+1ou
	 m6qWCNGMelE7g==
Date: Wed, 11 Sep 2024 13:45:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-09-11
Message-ID: <20240911134521.7f510329@kernel.org>
In-Reply-To: <20240911084147.A205DC4AF0F@smtp.kernel.org>
References: <20240911084147.A205DC4AF0F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 08:41:47 +0000 (UTC) Kalle Valo wrote:
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.

For a follow up, clang W=1 says:

../drivers/net/wireless/realtek/rtw89/coex.c:6323:23: warning: variable 'cnt_2g' set but not used [-Wunused-but-set-variable]
 6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_MAX, phy_dbcc;
      |                              ^
../drivers/net/wireless/realtek/rtw89/coex.c:6323:35: warning: variable 'cnt_5g' set but not used [-Wunused-but-set-variable]
 6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_MAX, phy_dbcc;
      |                                          ^
2 warnings generated.
../drivers/staging/rtl8712/rtl8712_recv.c:139:6: warning: variable 'drvinfo_sz' set but not used [-Wunused-but-set-variable]
  139 |         u16 drvinfo_sz;
      |             ^
1 warning generated.
../drivers/staging/rtl8723bs/core/rtw_efuse.c:285:6: warning: variable 'efuseValue' set but not used [-Wunused-but-set-variable]
  285 |         u32 efuseValue;
      |             ^
1 warning generated.
../drivers/staging/rtl8723bs/core/rtw_recv.c:2030:7: warning: variable 'cnt' set but not used [-Wunused-but-set-variable]
 2030 |                 int cnt = 0;
      |                     ^
1 warning generated.
../drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:288:6: warning: variable 'poll_cnt' set but not used [-Wunused-but-set-variable]
  288 |                 u8 poll_cnt = 0;
      |                    ^

