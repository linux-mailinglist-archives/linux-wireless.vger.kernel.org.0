Return-Path: <linux-wireless+bounces-4734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE887B9EC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 10:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE611C22FFF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03FB3EA6C;
	Thu, 14 Mar 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5fQ/Se1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962F6BB5D;
	Thu, 14 Mar 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406812; cv=none; b=N+vUqV2HCNaag4/hKr1JmJIVOVMRuWRX5Q+letguJLXi5g1YFCbH3GgQ1rj8BD0WWVChsH6ynAQmuJFP6sSOLxRYRcGu1nnHoo2B3pnrrdueV8mWkPhJNtq7xA0IqgN+XUANviTxgUAGUwYVFwqVHUevdP/ktXSsnaCCaAh3624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406812; c=relaxed/simple;
	bh=pMazMFPw4G3eABV6ZpzvptYS/hOkHNwP/iy8fDEfkz0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=mv2QIBCuzKNhBcwXw9ccrISbjg7idEYCB1FnhhcriW2bHt3SylmJVZ60a6bX/4PukYmZBeQOgbEFaZ9JdIO79adxarIcATF3nXzxzJfexZo15yFrN4Q8CPi2V13/VRM7rH6a5iE/9Ido7Etvo0fM26KKK3jtGYYDrvIoxbQOsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5fQ/Se1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2B8C433C7;
	Thu, 14 Mar 2024 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710406812;
	bh=pMazMFPw4G3eABV6ZpzvptYS/hOkHNwP/iy8fDEfkz0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=i5fQ/Se1xkHyOOGK1JbiOnz4TIdLW/7t2iuoEuKFpRXlRiPu06fLdKPTdmzjTlP9M
	 DDO/GMb5aGsXCNL/CFtqv123V0cTWWkkzrXjX/AR4Mmq1QnIchqhW26mzcBhxjJ7DH
	 4YlW2qidirD8KMjvj+onXfRi42CfCA3n6B01q58Pbkjs1i42vr6I3E8hhY9rybNnA4
	 YJnKvrdgwppYn3p+nn7zdbOt2YqX0IjsOLyGmcjg8R/+z4eZypJrrSgbaHTQreqwpa
	 T7SfEOGfW8MgFS0aK3w6rZvcal9mNUb6IOMfWAL9WR9BaLhrcJeFS6M/fgXBxu0QYp
	 9o02qYOEJEX2w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/9] wifi: rtw88: Shared module for rtw8723x devices
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240311103735.615541-2-fiona.klute@gmx.de>
References: <20240311103735.615541-2-fiona.klute@gmx.de>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
 Fiona Klute <fiona.klute@gmx.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171040680857.2399140.10870855139014893050.kvalo@kernel.org>
Date: Thu, 14 Mar 2024 09:00:10 +0000 (UTC)

Fiona Klute <fiona.klute@gmx.de> wrote:

> The already supported 8723d chip is very similar to 8703b/8723cs,
> split code that can be shared into a new module. The spec definition
> tables are combined into a struct so we only need one EXPORT_SYMBOL
> for them all.
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

9 patches applied to wireless-next.git, thanks.

ff88b7488266 wifi: rtw88: Shared module for rtw8723x devices
da2abdcdbbb8 wifi: rtw88: Debug output for rtw8723x EFUSE
9bb762b3a957 wifi: rtw88: Add definitions for 8703b chip
23c21068c296 wifi: rtw88: Add rtw8703b.h
61a486bcd782 wifi: rtw88: Add rtw8703b.c
b0ec946c543b wifi: rtw88: Add rtw8703b_tables.h
c75065b1ebfc wifi: rtw88: Add rtw8703b_tables.c
1f30e95b1646 wifi: rtw88: Reset 8703b firmware before download
64be03575f9e wifi: rtw88: SDIO device driver for RTL8723CS

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240311103735.615541-2-fiona.klute@gmx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


