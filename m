Return-Path: <linux-wireless+bounces-14585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7069B28A8
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 08:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007D71F21344
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8818FDC6;
	Mon, 28 Oct 2024 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkBbww7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A34154444;
	Mon, 28 Oct 2024 07:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100017; cv=none; b=ZMGxFCiWG+mc2PcmcGZ6NcD8s/x7Wcy2N1W209PFLOOI34B7PMPsIDgqKTSigUVVDv4VOwMJq6KCVtxe7yClBUkxMObbEErLok+mFW2oVIyP1gCAUc7KYBQFW+Qshkv8ZexKKJbuAbFY2UrWcYQpV2SZrXhFrGpm86mYoOnLeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100017; c=relaxed/simple;
	bh=u9od9++BTm7X2l7Xuv45F/zZ7T0f9UZi7S4GYvQlRic=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=We7B9iFQko472QKGjLMvJklHnyYTUPqhWvizJA4GWnfVvBQwYSqa33zD/OT8nf+XdXWLlucZhOeKNvjCj9vt/1bsMQqo8HlBGtU8yBHVl3dpNC+9XWYeyk5MHPvdbTyZxYGmy6aAfMUAo3nHxQ4Iry2h6esOYHLbuPKu0oyFxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkBbww7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A018AC4CEC3;
	Mon, 28 Oct 2024 07:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730100016;
	bh=u9od9++BTm7X2l7Xuv45F/zZ7T0f9UZi7S4GYvQlRic=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CkBbww7C0rTIQifzrPyHGqytgbRYSPhHqEu5eySEdC0Nscn4xgtGqeKdde9iI+kf+
	 0EWXMV4dDnvL4vYujHJA18LOP4bRG4QlVlRyZYRIdiFdTPovuoomLOZrpp/2RFGjaf
	 TLcDJktFRMQOTstfYp3G/bHr/ZX0euhLztbhSpbP4jcgtDQaQo/VKsBliumDZg4SKb
	 DS379R9yOQTYJTZh4LyJO4cHpNXzol2o4h+UHq4EuNTiGjohPhShLfbMBfM+AHlYvy
	 tzedszlzOkWZADltwg3nR451Qrx31YOHmvnBbcee3awh2kNV4iUtmbvG2yXTuy/nch
	 eNtbtd6tDx3kA==
From: Kalle Valo <kvalo@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] wifi: trace: Replace BOOL_TO_STR() with
 str_true_false()
References: <20241025163210.1395-2-thorsten.blum@linux.dev>
Date: Mon, 28 Oct 2024 09:20:14 +0200
In-Reply-To: <20241025163210.1395-2-thorsten.blum@linux.dev> (Thorsten Blum's
	message of "Fri, 25 Oct 2024 18:32:11 +0200")
Message-ID: <878qu83d8x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@linux.dev> writes:

> Replace the custom BOOL_TO_STR() macro with the str_true_false() helper
> function and remove the macro.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/wireless/trace.h | 44 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)

BTW wireless patches go to wireless-next, not net-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

