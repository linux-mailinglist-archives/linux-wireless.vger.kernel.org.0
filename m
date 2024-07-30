Return-Path: <linux-wireless+bounces-10685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0469412CB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 15:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4288C1F23A97
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0511EEE6;
	Tue, 30 Jul 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W31SlpL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862A1E49B
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344915; cv=none; b=QSqG3ekvxR4Mq78QLSDn6etbpDWzlZXeNQKETO4QlWCdfdv8mmryc1X1Mbyv+OCZYnF3cwj4LRhrQZ2FU/hEGarQK0y+JD2r9Uoe8GaLm1q9kgbFbvsaLihovvlWkC8GzvkrztTlwEaGpVFX8uV5VAGn7CLom2qvq5ElEf3KWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344915; c=relaxed/simple;
	bh=AryoqJp+rM4Wdz7GTINj/m+b1f9vK+moT6QydzfH2S0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=vGmtwVehvci6F1vEYifcPInuxB7XYA5NHuNsOrqyrE0Qy19pHdgUXtsfgD4MJB0uTIKm/b5bcOhT/RCWHzxf8myZMj5tE1co1QDiOJXHzWBnti9nGEqrq2HzweR76Kep4+fU+2kIuYgTsfrkL49mA4h+xdh5l7LEKwEFO5iGIdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W31SlpL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5592FC32782;
	Tue, 30 Jul 2024 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722344915;
	bh=AryoqJp+rM4Wdz7GTINj/m+b1f9vK+moT6QydzfH2S0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=W31SlpL1Ftnm8/n9afpraAX3rtUpxw040tUpbCaphdnCckCSjRac85xKZvK01ANLp
	 IhZJ3hVD0thiGN2Homc/45rvc6Hi+en6goJCnh0auYVrHp83ENFLONuMkbffixowUP
	 MuYTYMD38Kk+2uo6SurVm+qxCKl4Doqxd138StUm+eqjHo9jvZ+xmJbeYW/NF/CsrI
	 EZHD1VdHhixLlG1uAAeCzooMEIoyyUAdby7ckig2lGMRksskKpY5SGRMjkZ0Tf/sgg
	 bUq/to/A+39KmvjFN6FliYWODorbriovJJrSZRFwDKFQgvDvCR6mvqO10mGo2Zefly
	 kG/Q5ZodmmuZQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>,  <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: select WANT_DEV_COREDUMP
References: <20240718070616.42217-1-pkshih@realtek.com>
Date: Tue, 30 Jul 2024 16:08:32 +0300
In-Reply-To: <20240718070616.42217-1-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Thu, 18 Jul 2024 15:06:15 +0800")
Message-ID: <87sevrkoxb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> We have invoked device coredump when fw crash.
> Should select WANT_DEV_COREDUMP by ourselves.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Should these two go to wireless tree? If yes, please assign the patches
to me on patchwork. But rtw tree is fine for me as well, your call.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

