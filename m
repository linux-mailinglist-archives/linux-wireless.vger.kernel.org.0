Return-Path: <linux-wireless+bounces-12802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EB975D51
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CED28581E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C31AB6D4;
	Wed, 11 Sep 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1TEq2+w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED92185B5D;
	Wed, 11 Sep 2024 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094195; cv=none; b=qbTWNccMsYMKxCBjgQuKY+pH3ZjanUfCh5qGd9Fuur0v1Az7MPx6LCnq1qmeI5e33t8DEqtBduYpZSfjJy4+lrprcixbz9fyh2dC2Uz0kFlfczxTLMVooEqSwoS6E/LaJBh+yelox4BYdDGToaCiDkrjbOmFufBTXpJWgB4h/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094195; c=relaxed/simple;
	bh=ZiOOKFGR0cmZTtUmaA2YlGhkUNoYIP/6Bn7sc0q5Owg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnb4NEGBsLeSUEwPUfoojTmJc7/AqRga6ISAcJUSyJpbrUsw0FqPEfkzABkNc1wQ5f4KP1xDHBMkU8CuujCRA0EWQ+mGAukihcLyL/ZVyqAtjPXF8K9lYpiIB0Gh7RRQXjFEWOt7hnnzzfiqf3jE6QF0iPAksJvYl7oFZnZpc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1TEq2+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EC4C4CEC0;
	Wed, 11 Sep 2024 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726094194;
	bh=ZiOOKFGR0cmZTtUmaA2YlGhkUNoYIP/6Bn7sc0q5Owg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1TEq2+wP65QKKRljbQ+RdajyoUA3+XsHPceV7yfj4pzE4OCr2Jg7GsUsLBneBm8S
	 b5MSWsdYn9TpuVzEgAimTorRTcxXJhobDmH7qhlYEfMEHkXSWBio8onTR/ByngWhDs
	 MSbROgpjN5gyGmb3s9IH07/NFHMepwBGD9tpMK2dzE2wETAjecvzdKN6IBlr0tmoMK
	 gnS6et4DHztSQTptynMhbT/4SOUbZ2nMk0XMnN/tE5N88rBWpmM+Zum4TpsN7l6/UO
	 HSOvCiki6wzIdmdN20Pb/pPAdxUCvxQ6/Ha7ocM/fEV9pcey5X1a+AVIgYxaAHBrYv
	 68JbIVv/YkVPw==
Date: Wed, 11 Sep 2024 15:36:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-09-11
Message-ID: <20240911153633.7a01a6c7@kernel.org>
In-Reply-To: <87ikv1bz8e.fsf@kernel.org>
References: <20240911084147.A205DC4AF0F@smtp.kernel.org>
	<20240911134521.7f510329@kernel.org>
	<87ikv1bz8e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 01:29:53 +0300 Kalle Valo wrote:
> > ../drivers/net/wireless/realtek/rtw89/coex.c:6323:23: warning:
> > variable 'cnt_2g' set but not used [-Wunused-but-set-variable]
> >  6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_MAX, phy_dbcc;
> >       |                              ^
> > ../drivers/net/wireless/realtek/rtw89/coex.c:6323:35: warning:
> > variable 'cnt_5g' set but not used [-Wunused-but-set-variable]
> >  6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_MAX, phy_dbcc;
> >       |                                          ^
> > 2 warnings generated.
> > ../drivers/staging/rtl8712/rtl8712_recv.c:139:6: warning: variable
> > 'drvinfo_sz' set but not used [-Wunused-but-set-variable]
> >   139 |         u16 drvinfo_sz;
> >       |             ^
> > 1 warning generated.
> > ../drivers/staging/rtl8723bs/core/rtw_efuse.c:285:6: warning: variable
> > 'efuseValue' set but not used [-Wunused-but-set-variable]
> >   285 |         u32 efuseValue;
> >       |             ^
> > 1 warning generated.
> > ../drivers/staging/rtl8723bs/core/rtw_recv.c:2030:7: warning: variable
> > 'cnt' set but not used [-Wunused-but-set-variable]
> >  2030 |                 int cnt = 0;
> >       |                     ^
> > 1 warning generated.
> > ../drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:288:6: warning:
> > variable 'poll_cnt' set but not used [-Wunused-but-set-variable]
> >   288 |                 u8 poll_cnt = 0;
> >       |                    ^  
> 
> What's the deadline for these? Do you need the fixes tomorrow or can it
> wait a week or two?

It can wait, half of them are old anyway

