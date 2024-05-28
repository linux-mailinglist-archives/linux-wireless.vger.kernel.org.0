Return-Path: <linux-wireless+bounces-8200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7695E8D1C22
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31763286A21
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF516F0D6;
	Tue, 28 May 2024 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPMVsX2b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E016DECA;
	Tue, 28 May 2024 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901480; cv=none; b=eRtIE/SeQ604t2dc1yjsbqPhrl1o6Q8wxCFSsTtGwAwHN8hKFb8z/R+ocDD4daRJu36CyA6h9LEnUahsZPCoPqgQ4QuB/R2IH+ZS4cGMSXM2AyONxjNU4OFh3/dK3T25VLDGxKJMHyTX1PYpvQuTO3RdGwQDQPMzyxCyKb6DFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901480; c=relaxed/simple;
	bh=Ijz4ZOiC+c0cFiKrbiFrp879iEN7anQ6A2QjvwsHUtA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aCPxdRVBvI92kr3+iGJnips4KSxtxltKeX8jMZOXFF2STBe7etrbvB2R2XOpQgQywyZl2dvT5xQrb8WEteNhnrOBvGHMsIrxpBDKd006hyUMLJ/TYKrfArh+nQY+oP8yAaH9ZRs0Z+JcYdufdQUthBUeiljjgRKYFU7XOp73Qjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPMVsX2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0D4C3277B;
	Tue, 28 May 2024 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716901480;
	bh=Ijz4ZOiC+c0cFiKrbiFrp879iEN7anQ6A2QjvwsHUtA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pPMVsX2b6gB7oiD2MjKYi4Sd8Qzer0obTAYJ69CuL+sC+O2OxQySc32Oqiy8eUZgi
	 FeBvgLcF7exFGykDnrgPYa4MJR2iaLF2gAO+s7b5kdqzAG8QU9wEES3aoAyyDWyMD9
	 KplHEEWGqITn4yY3lTE2CrUuAU3wZSjYDgSO+P3deyXGuc7bcqwTdB3J07H6kdIdU1
	 st5lAPisOOitbqda/XUNsNDWfAkZAGhjILbUsaXjMQo65V8Fk4U5ABfN7Im3kryOiN
	 8OxZ/YEeaLzyOF1U8FO+Y1uxwoag0RVVjpkMAyLRgSCh8yvCztweWVwM50dJuPKPiP
	 ep2zWTfawKXcA==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Johannes Berg
 <johannes.berg@intel.com>,  stable@vger.kernel.org,  Rene Petersen
 <renepetersen@posteo.de>
Subject: Re: [PATCH wireless] wifi: mt76: mt7615: add missing chanctx ops
References: <20240528142308.3f7db1821e68.I531135d7ad76331a50244d6d5288e14aa9668390@changeid>
Date: Tue, 28 May 2024 16:04:36 +0300
In-Reply-To: <20240528142308.3f7db1821e68.I531135d7ad76331a50244d6d5288e14aa9668390@changeid>
	(Johannes Berg's message of "Tue, 28 May 2024 14:23:08 +0200")
Message-ID: <87sey2m6jf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> Here's another one I missed during the initial conversion,
> fix that.
>
> Cc: stable@vger.kernel.org
> Reported-by: Rene Petersen <renepetersen@posteo.de>
> Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218895
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I assigned to me on patchwork but acks from Felix and Lorenzo would be
good.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

