Return-Path: <linux-wireless+bounces-17324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91209A09184
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 14:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBEB188E29A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A2209F22;
	Fri, 10 Jan 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgdbLQBg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04831E32C5;
	Fri, 10 Jan 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514771; cv=none; b=rieYtrAkxRcMc8WFC6HTCxJz5roKYM9ifENHjcC5ZPjplt4S9ZTAXG6FF6BAsKxw4oGCBV2vHg2S9L7e9oqrl9u/Jiz1XkP6m2cvVOW84K7quhs/JkHK+nLI6+ro5SATppGcPELkr4QQaXYsJ78Fe3DiuB/xZdxxczW0aczHpos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514771; c=relaxed/simple;
	bh=nj7fsiiDxvJq0xaxvcHI/mKFqbzzUp16p1h3nysGU1g=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=IjxU+8kqrU4MZkBXRun02ELaOjJkZgk5pc89+zjEHzs+RvUBO1LEETG3+b8IqW7VHDV/au3dLKagZt+D5VCqh1T1wH3w5K7e11Eb1g2i2yz9tEuZUpIb08SpvA1M3BNQpHztWiw/aBy+BrecYqAUX/OB1hvkqaOYP87rYrydwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgdbLQBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454DFC4CED6;
	Fri, 10 Jan 2025 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736514771;
	bh=nj7fsiiDxvJq0xaxvcHI/mKFqbzzUp16p1h3nysGU1g=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rgdbLQBgesy2zp0ISmUwrHhecNpF3+BDRZp+Ry7C0V6h9dTm/3zxwwd8Caei/AwVu
	 Aapw69zwxGENr7SJBBJW9uUlMx1vmrr/4upOE75uozp9V/LzJGhToB56miOKesld/H
	 C/+6a+1ILYb+7Tkji1hzEmCXKbjawc74Uap8xHCb4L7kxI5/bF+uWhdgK8gzWUjzyP
	 VE7EsTDii1Kh+nlAWTNJd/TmVlY+3hJXFj/Rp/HymA5rn8XW8cFluAa/1Q1dUfU4El
	 uJJi+3L0EjZNVIPKqpY4kZCWaV38e4TuBM1V4v58e4HJrbJr1tPTNfI7V9jXvG5A3b
	 Q5Yw47uCDaeqQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/2] wifi: iwlegacy: Remove unused il3945_calc_db_from_ratio()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241226011355.135417-2-linux@treblig.org>
References: <20241226011355.135417-2-linux@treblig.org>
To: linux@treblig.org
Cc: stf_xl@wp.pl, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173651476877.72755.17293189953022835840.kvalo@kernel.org>
Date: Fri, 10 Jan 2025 13:12:50 +0000 (UTC)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of il3945_calc_db_from_ratio() was removed in 2010 by
> commit ed1b6e99b5e6 ("iwlwifi: remove noise reporting")
> when it was still called iwl3945_calc_db_from_ratio().
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

2 patches applied to wireless-next.git, thanks.

413859e909a4 wifi: iwlegacy: Remove unused il3945_calc_db_from_ratio()
83ed80dd25f6 wifi: iwlegacy: Remove unused il_get_single_channel_number()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241226011355.135417-2-linux@treblig.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


