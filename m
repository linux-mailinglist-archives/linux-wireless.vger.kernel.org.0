Return-Path: <linux-wireless+bounces-15215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8D9C605E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 19:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8B41F2436C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FB5216DF2;
	Tue, 12 Nov 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDNPnex1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD7216A1E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435962; cv=none; b=WmmFU4ZBsuI6c6TkVQHG6/Ig3eHa3DcKK48XETISRPB7YDpSzRkzpzZ9435phbFtlrYoOIenOkcQKJQxnpkWOXYfHwJznQzygG0Slvk0Wq6ELUeobxu+FU6gLCkEmkskB7JWIHz7F09RbNN/7B3eEfCfRox/R1ATes/3eMbpfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435962; c=relaxed/simple;
	bh=eqzLlzpk929Vmi2gaV3rBVHwh+wG99gcZDLn175bams=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kxZRv/HtDNLJ+5v1iulmjO9ZWFvQ82FsxzTPo+gJR9nloMBwBic1npewHiRcj+3jcenmUBTHpHhNbdky9RNScGHr5E8V2v6VOtLVZ5DYGZmFghgE4YawV4pLCydkXntkigAG/zMKlMfoyzu11yb3ZSELE3QOdnxwxD2FfKNg/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDNPnex1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCEEC4CECD;
	Tue, 12 Nov 2024 18:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731435962;
	bh=eqzLlzpk929Vmi2gaV3rBVHwh+wG99gcZDLn175bams=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CDNPnex1FABGeHIuIcv2mVQas/wYoKT+uUGTkKqZJU7ggZhfBg/2Ojsb3HvXbNpvw
	 f/gf0gxGi2QawM2LrjghMaLwGl4o2feFlhY8f5HfX4GbWRsYkFm+wiHH5HCSml9mFw
	 kWgKLK3BRy0tP62Xc2gs/waf7WoYZzXDDKYNrVC+bKcd8f88HIn3KD0mrwfc49GguS
	 T5kpiZCGFfl850kzO5MJ0eerqFR6I72sh8IDYFvDxJAwbi1jH0NJa69PmpEQPPr04f
	 KDv0CsYDkfz5hUw8DXsqbFH1aBs/hGQpbIrVYedax+KZr8eIbWdvxYSSz0b+FndLH6
	 Om1uSkdUj/E2A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "wifi: iwlegacy: do not skip frames with bad FCS"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241112142419.1023743-1-kvalo@kernel.org>
References: <20241112142419.1023743-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Alf Marius <post@alfmarius.net>,
 Andrii Batyiev <batyiev@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173143595994.1075500.7440430979997597729.kvalo@kernel.org>
Date: Tue, 12 Nov 2024 18:26:01 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> This reverts commit 02b682d54598f61cbb7dbb14d98ec1801112b878.
> 
> Alf reports that this commit causes the connection to eventually die on
> iwl4965. The reason is that rx_status.flag is zeroed after
> RX_FLAG_FAILED_FCS_CRC is set and mac80211 doesn't know the received frame is
> corrupted.
> 
> Fixes: 02b682d54598 ("wifi: iwlegacy: do not skip frames with bad FCS")
> Reported-by: Alf Marius <post@alfmarius.net>
> Closes: https://lore.kernel.org/r/60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com/
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Patch applied to wireless-next.git, thanks.

11597043d748 Revert "wifi: iwlegacy: do not skip frames with bad FCS"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241112142419.1023743-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


