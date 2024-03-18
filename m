Return-Path: <linux-wireless+bounces-4842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9387ED27
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A631F220F2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F724F5F8;
	Mon, 18 Mar 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx4DHphv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070552F93
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778385; cv=none; b=Uk4lu5cfk/x/uDfM1jNB00KJSNsHY1ggyMXBXwOC73hHavtLt4b50GyXtz4lQ11UNqE2hnDCaDJVrLoe1DAzexro6xh/JSzQcD8a6hwJwy8JDFuYNNd12ZwiZunJ59qBH1m/hOOMnoo2MOlhh3awP2+xLL1tgevbhYGqftd6eNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778385; c=relaxed/simple;
	bh=75E12AswLEG0xez8s7YO+qXaEGTmywwnfrG5XXd0iu4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=F7QB+pLBF4ymteyCDsjDr4U9HJc79ixQQTj9RQqrEJAxOW1YuGz3lLLxkuKBnolOegCFYRStiMaXVAy3iDurz1f4Mh51bJ5SbnZdTmPbw+x59xWgPmH/t+H47SjO9c2UCVyRcQRY7vHulaPcjrWo8b7peUbQJJr95naiMLA9Iqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx4DHphv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10DC433F1;
	Mon, 18 Mar 2024 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710778384;
	bh=75E12AswLEG0xez8s7YO+qXaEGTmywwnfrG5XXd0iu4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Bx4DHphvvgCEwE19K2ccjWH5P/A1Kt1CJLtzBIuN4DFjvRGyJZDjOVnp3I7oK0u/T
	 EycmbdnQdOCCEKZnt+7lT0+UywMxgPKLmzk89aMf5GX9ZsMbHFpbfcbI7Kz5sRPsJm
	 eLuO7Y8naNTYWBjw0gLYdvgt2UnyI925CNTWAr95y71HNiOFdyB3fAAh92pGarqaYN
	 88SfguUhKsF6nFHQQPlFZFRSeIJpWfSRqCszFTMxhprWEqxrk8mDMOyeMgWOUcUXTD
	 Po/yobS3oUGlkxsKXH3UhSUcAwJiG1fKHMG154nqpB52LTM7y1xjiC4eNy+k7+eSQJ
	 6/exkF0j6gR2g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wifi: mwifiex: Add missing MODULE_FIRMWARE() for SD8801
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240313183156.2234301-1-victor.gonzalo@anddroptable.net>
References: <20240313183156.2234301-1-victor.gonzalo@anddroptable.net>
To: =?utf-8?q?V=C3=ADctor_Gonzalo?= <victor.gonzalo@anddroptable.net>
Cc: linux-wireless@vger.kernel.org, briannorris@chromium.org,
 =?utf-8?q?V=C3=ADctor_Gonzalo?= <victor.gonzalo@anddroptable.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171077838185.2674434.2366193154567060093.kvalo@kernel.org>
Date: Mon, 18 Mar 2024 16:13:03 +0000 (UTC)

Víctor Gonzalo <victor.gonzalo@anddroptable.net> wrote:

> The module metadata for the firmware file mrvl/sd8801_uapsta.bin
> is missing.
> 
> Signed-off-by: Víctor Gonzalo <victor.gonzalo@anddroptable.net>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

c76936a7e1da wifi: mwifiex: Add missing MODULE_FIRMWARE() for SD8801

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240313183156.2234301-1-victor.gonzalo@anddroptable.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


