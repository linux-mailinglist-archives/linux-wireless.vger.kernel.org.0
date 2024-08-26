Return-Path: <linux-wireless+bounces-12002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483095F960
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F95F2811C4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D1181AB4;
	Mon, 26 Aug 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJVP1VWu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F62B9A1
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699149; cv=none; b=V+9aGtafN02m22qxXgtFJpwsgtPgua978JDeEHxBzdZBmT1ZV/m0W3njsU/sRNbR0f6UaI08aUXDe4QV9R+iiA7klUh1myTvB63DHm87feVvTklIiBUGRuss/Yyrq2oiRNM0VJHPpdRqbAzGxZtVCcdVJK5Oi+W0XHHPvqsD2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699149; c=relaxed/simple;
	bh=/ticz3e/0Gfp6vEU2b12WQiAYP7eD9ZXMelOecoRrNQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MA5x0kegfZ6jr/6/nEua061BX4OHZYYqru6sFseAw9Cf5KhnGeQA3GHvAk5SxD53Tg60HY9odIRsf9VhzofXcFXBWh3gs0BKy1cdNhBNWBTNPbKkWfcvtHymP3SkInNUlkcvRqfdv0SkfD6bmjjA3l6+gYO4JWUudKI/A9T6FPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJVP1VWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B64C8B7A4;
	Mon, 26 Aug 2024 19:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724699149;
	bh=/ticz3e/0Gfp6vEU2b12WQiAYP7eD9ZXMelOecoRrNQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eJVP1VWu6gvcvGQ+3FWc3xhnnscZQ0H5bRB5mcQxKL1bnfJWmiBDvsrHbhxsagEPZ
	 HENaEe30/LmziQfmNN6UrjwWWUnHEiNw+cBEs+UINLBetPnMBRsUuzArGOPjVy3Hax
	 SZD1d6zdWBK5PuxHeErL7R8FJN/qeOXIUkv1ThwYBTaEN0zQIFs/V1J176N2XENggL
	 uKWMZQ6PkAvFh7Sqe9Ah0ePgG5x4F0jjOhj8lOs/fDGMkSWQyp4EJuaGvMS6rhHFsq
	 C2jFf7XzVy7A+WTbqyme/wa2gFxB3V0DMS3rf2yKPS9WwUPJHRjxsO8O8uP5wX/7mr
	 im0xBHF1/4SKQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kavita Kavita <quic_kkavita@quicinc.com>
Cc: <johannes@sipsolutions.net>,  <linux-wireless@vger.kernel.org>,
  <quic_mpaluri@quicinc.com>
Subject: Re: [PATCH] wifi: cfg80211: skip regulatory checks when the channel
 is punctured
References: <20240826123341.5405-1-quic_kkavita@quicinc.com>
Date: Mon, 26 Aug 2024 22:05:46 +0300
In-Reply-To: <20240826123341.5405-1-quic_kkavita@quicinc.com> (Kavita Kavita's
	message of "Mon, 26 Aug 2024 18:03:41 +0530")
Message-ID: <87cylvf6k5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kavita Kavita <quic_kkavita@quicinc.com> writes:

> The kernel performs several regulatory checks for AP mode in
> nl80211/cfg80211. These checks include radar detection,
> verification of whether the sub-channel is disabled, and
> an examination to determine if the channel is a DFS channel
> (both DFS usable and DFS available). These checks are
> performed across a frequency range, examining each sub-channel.
>
> However, these checks are also performed on frequencies that
> have been punctured, which should not be examined as they are
> not in use.
>
> This leads to the issue where the AP stops because one of
> the 20 MHz sub-channels is disabled or radar detected on
> the channel, even when the sub-channel is punctured.
>
> To address this issue, add a condition check wherever
> regulatory checks exist for AP mode in nl80211/cfg80211.
> This check identifies punctured channels and, upon finding
> them, skips the regulatory checks for those channels.
>
> Co-developed-by: Manaswini Paluri <quic_mpaluri@quicinc.com>
> Signed-off-by: Manaswini Paluri <quic_mpaluri@quicinc.com>
> Signed-off-by: Kavita Kavita <quic_kkavita@quicinc.com>

Kavita, is your first and last name really the same? Just trying to
verify that s-o-b is correct.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

