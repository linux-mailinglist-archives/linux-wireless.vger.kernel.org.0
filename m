Return-Path: <linux-wireless+bounces-11543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779F954681
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAC11C210FF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347D175548;
	Fri, 16 Aug 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFwpjc6D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D916F27C;
	Fri, 16 Aug 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802841; cv=none; b=I60UT3I+2hScuYl39tWoedEi5BO/nQ1ufdSvc2n6j5foaSzahwxzSYVRCY7czAJ7bkiAM0NuBNGZj1C/Q59czCfEDcIs0lhuxQsRVRoBwJOinPMZE+XSCyiEc2VnD9HwrN0YzyWFwc02PHgjIhMD1ljjjSuPlxq1k/GktlF6PX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802841; c=relaxed/simple;
	bh=Mbc+sLuhxuPXBjCsvB2V5cqv1xkV7XhLkdGzIspi/LI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=NZyKOD2m/t3n9f2aYjZG96SblwTtXcmBAJBYR3LUCgsBRXCFgjPeBMaygMbVD4napn8CcC/JoUUVjh5h15o0L4D1ThaToOhO+K4fgP2TXXXGzmUxqj79UZpfTJXI094GGGofngzNfH9FIgnRjNBQb8NoL3tJGIuWWWYwr86wMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFwpjc6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7083AC4AF0C;
	Fri, 16 Aug 2024 10:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723802841;
	bh=Mbc+sLuhxuPXBjCsvB2V5cqv1xkV7XhLkdGzIspi/LI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NFwpjc6DxIt0P3Xu9hhXPrfIz1Kb5xMwxH/etzQdi9anH3vhREc2IVmsJO5buK8IP
	 ArVXsJ3N3cprgO+IUQLwk4MmZY3Bz2J8bMd5dnNRyhBqscgkzi9iJYOsV4tZss43UN
	 FlHwVCpISLZr9VEaABnsFP4WwrlOT8yVLcclZeotrMyJfRBJJhWiSoDM9wGTCGIhep
	 CADxlNDl46o6YJCtwySnnNHmHLLY1d9Pb+6W0ypInRFCq++Ib+vLROs7ci//I9lEhy
	 MLAuQMBB0EUO8x73AC9sI5rfBoKYFJELCTYZ88FG3y3p13WIZxoHKcpo7nBIEaLzTg
	 5VieUhHUgRi+A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: keep mwifiex_cfg80211_ops constant
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>
References: 
 <20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, David Lin <yu-hao.lin@nxp.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172380283788.1488109.5178167432284634889.kvalo@kernel.org>
Date: Fri, 16 Aug 2024 10:07:19 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> With host_mlme support being added mwifiex_cfg80211_ops is no longer
> constant, but supplemented with the host_mlme related ops when host_mlme
> support is enabled. This doesn't work with multiple adapters when only
> few of then have host_mlme support. Duplicate mwifiex_cfg80211_ops
> before using it and keep the original constant.
> 
> While at it mark mwifiex_cfg80211_ops const to prevent people from
> changing it again during runtime.
> 
> Fixes: 36995892c271c ("wifi: mwifiex: add host mlme for client mode")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

daaf0dd0398d wifi: mwifiex: keep mwifiex_cfg80211_ops constant

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240809-mwifiex-duplicate-mwifiex_cfg80211_ops-v1-1-23e0e6290ace@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


