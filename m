Return-Path: <linux-wireless+bounces-12892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630597A2B6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891631C20976
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C297155725;
	Mon, 16 Sep 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qajCUoRS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD241553B7
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491949; cv=none; b=EOEC1eY4qv8GpZcJY9SiLIFGvD4bnl79ysqR47pTS9k7gOihSZcvrrd7ODH1dhjRhWwZIBGHGYwhkD4s7iGesMs9cYmNhNx8M2VT+j3hIz2Fm7oHd9OMFDSAI8A95nvVzY8fgQn3Rp7yvGSl7fqTVCj4gi2ovIUFcOntviBbA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491949; c=relaxed/simple;
	bh=RMwMLkJh3YIgZ/58xtZg63tgS5MnB+406c9amhG2MnA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=paU5fg64SGzEmZLx91oXasIvQIeejh2RlKLXnd44EmzB65n3QmofctY5UlmaiDhIDb6AvzDDj7Nf9Z7giNTAZTwRBh8MYWXTNVw9qe1ygfTTHFACf4EUe985VhA/QdcxqGXK9HZ6g79anIvNcqa9ZnPDnzPb1fNpD2OPNPOnc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qajCUoRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D628C4CEC4;
	Mon, 16 Sep 2024 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726491949;
	bh=RMwMLkJh3YIgZ/58xtZg63tgS5MnB+406c9amhG2MnA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qajCUoRS4Mby7Nj3VPRNFWZ3UCjssfuHLsNKGUpvxwFjuV8LstG7mFzXGMbdq45jD
	 ystXs78PB7W7Y2JpKB2eY0emgp93NWXal5kcvnKL17Bgqw2RNaUHvZvQuXV8HXDTmv
	 lO3ZXMEA6YhSUJwDKgzdHm8Gac842ZdxNp4yJSHfXHWfrqGimSUS4/KT9aw/HvWHCD
	 IXu1VYTkuASAlPlhdnbho/1/gZZKUHtytTNUub2sGIUm0nrRFVVaYv6duOJRjllsxr
	 u/0unoBisSFkGBqxkSGMzc5S7cAewMynB+4U2h8XusWHgIrju1fGD+gB0WCJVZ+LXP
	 XMCdfkEYMCgAg==
From: Kalle Valo <kvalo@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: ath12k firmware regression with update 82318c966fd1
References: <87bk0nc1yb.wl-tiwai@suse.de>
Date: Mon, 16 Sep 2024 16:05:46 +0300
In-Reply-To: <87bk0nc1yb.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon, 16
	Sep 2024 12:44:44 +0200")
Message-ID: <875xqveok5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Takashi Iwai <tiwai@suse.de> writes:

> it seems that the recent update of ath12k WCN7850 board-2.bin update
> broke WiFi on Lenovo Thinkpad 14 Gen 5 AMD.  Reverting to the older
> firmware seems fixing the issue.

Just to clarify, reverting to an older board-2.bin seems to fix the
issue. (Board files are basically calibration data)

> The report for openSUSE Tumbleweed is found at
>   https://bugzilla.suse.com/show_bug.cgi?id=1230596
> and for Arch
>   https://bbs.archlinux.org/viewtopic.php?id=299286

For easier tracking can someone file a bug to bugzilla.kernel.org? Also
please include more information:

https://wireless.wiki.kernel.org/en/users/drivers/ath12k/bugreport

> Let me know if it's already handled in Qualcomm and the fix is
> expected shortly.  Otherwise I'll try to revert the change locally for
> TW as a temporary solution.

This is the first time I'm hearing about this and to my knowledge there
is not fix pending.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

