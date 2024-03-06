Return-Path: <linux-wireless+bounces-4430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD358735A5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 12:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8461B22DE0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8A57867C;
	Wed,  6 Mar 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHPIPDY8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770F604D5;
	Wed,  6 Mar 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724978; cv=none; b=riDzPQuvC9ZDOsNM/Cgy/dOsPl7BII+GAlcyMpwQ/qb6QmeyjHkWBg3M/dcBd5KrdwE5JDjtmVFrosWDWrkh52twwHhnSyWz2xkNFfd9FNlVjGQQjp8YwNZleU/u3XJE7KBcY6tqxO59jhD/dicDEWGim4HfhHRTeBanpbYLx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724978; c=relaxed/simple;
	bh=EYPvwpSzXJAtAhLtRrNbtR5A5VaRRo7dt9OYmdJzSlU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IXZrTpSGc/4hDzRpdDMt7rjqxY5V+c4BF2S7q/q2eBvzbY4RsRWGKHSJAn0uMI7J9x0Bfkhh6sSOujjZzwICyZRXh6EDgKBtJFBV7DHCpzwX+ECFihmAfZfmHkG8EX0eXcat3qafS8QtJV/Qra/GcQLiDQQWx84GIluyeq5vaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHPIPDY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C097C433F1;
	Wed,  6 Mar 2024 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709724977;
	bh=EYPvwpSzXJAtAhLtRrNbtR5A5VaRRo7dt9OYmdJzSlU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HHPIPDY8RxnjljDpAkz41MV4E33qMpoPfhQfQaC6SiuTVuFfLb94Muf00XtKk3pun
	 tbzNE6yxcNdfBmwmbddSp3FIVbPPKUwmQIKF9QoWb/fFeRmjr4Qvl8S1+3o89eRidR
	 bdizK524pgRTwzHuC25EPvYW/Gm1xSZ0zCmKDV5ve/esr1eWLnY3y/9NuICgTXN0UP
	 7PCzcoiM2MXmUmgXgeorMwldjd7sX3OSouqC91D+Z8upLbnKn9yugRRBYxNIvB7m3B
	 lLK+n+6lcqUIJVJU0o/Mw07Ni7tVYYZj55anRmpSZAG2Z80NXyj0v+WuRvE5fTjfL5
	 9NjgbFjlotgKg==
From: Kalle Valo <kvalo@kernel.org>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: deeb.rand@confident.ru,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  lvc-project@linuxtesting.org,
  m@bues.ch,  voskresenski.stanislav@confident.ru
Subject: Re: [PATCH v2] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
References: <170966495037.424347.1344425289163744212.kvalo@kernel.org>
	<20240306112558.163415-1-rand.sec96@gmail.com>
Date: Wed, 06 Mar 2024 13:36:14 +0200
In-Reply-To: <20240306112558.163415-1-rand.sec96@gmail.com> (Rand Deeb's
	message of "Wed, 6 Mar 2024 14:25:58 +0300")
Message-ID: <878r2vh9sh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rand Deeb <rand.sec96@gmail.com> writes:

> Hi Kalle,
>
> It seems there's been a mix-up in applying the patch. The previous patch
> was intended for the linux-5.10.y branch, not the master branch. I
> appreciate your attention to detail.
>
> The following patch has been tailored for the master branch and should
> resolve the issue properly. Thank you for your understanding.

This text should be below '---' line so that it's not included to the
git history and you should restore the original commit message. Please
submit v3 with the correct commit message and please also read the wiki
link below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

