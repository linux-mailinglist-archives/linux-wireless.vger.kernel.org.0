Return-Path: <linux-wireless+bounces-9987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23517927361
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 11:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB411F23AD9
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019101A3BD1;
	Thu,  4 Jul 2024 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1haj+qv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7518A93F;
	Thu,  4 Jul 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086797; cv=none; b=a50T3973eSTaVh+dNLXn9mixux2rlubJVbxfFN30vdBk98QvVLmsR1iXvCF4iEtMVk34HHCbZVKwUPTS+Ma0BehuTZzGJhkG/PZ3GL1VSz4z5IEzyA9sV5WWcf/V5wO81GiV1ZFr83Td0/TQk3Z1Xhh1Oh8OG22bEuF/od3RQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086797; c=relaxed/simple;
	bh=B8dMfcWXHdgKDl/LUosbH/t3NH/n75FSpahN1BHbALE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HRapoSBOxaR4chm6gKxkpL4RTBzgBohvhiuqmeis2Aonh/LLexDP5XqOZoOpZtW7iSDzZP6NH4IUax+j1ARkhdC9FZcYqBGrz9BBZ/ztjU1MUtwsf8dA+84a1HYCU5nd7bW4vlcbiSGtUnVS+J9fGAFqn/mBAgT55r/aUz/jY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1haj+qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBDAC3277B;
	Thu,  4 Jul 2024 09:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720086797;
	bh=B8dMfcWXHdgKDl/LUosbH/t3NH/n75FSpahN1BHbALE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=T1haj+qvw5bFe2oh4yNapY4OAhzoWJM9BhfQp5rx1/82Gf5X6q21HxzSG0NoKtA67
	 VW35vH4xbLEWKnLlSVbCYH3jM5nHG3dkUcNeb0I48G915W+0efedxusZPsKvh3VpvT
	 pJAaOn3OZeGV4fYkr9LDQC8fIPCymuB+tgOBDlbycV0Rhkcmnt5UebW4hBDHV5NKst
	 zCn3K+Ld4JHdC/J1Ioaq1KaNZlCq0Xz6OqR2KgGuNT6znoFx4oOI3DaI31MWXNVx+R
	 7cbXc2nqAmZsIFCOYnmzaJD5Z/rHXSTWI/oQzYkUuOyIFSgzBrZ67hi51fNoRvuk77
	 MdYrucuUGDWYw==
From: Kalle Valo <kvalo@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  <linux-wireless@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] wifi: rtw89: Fix array index mistake in
 rtw89_sta_info_get_iter()
References: <20240703210510.11089-1-amishin@t-argos.ru>
Date: Thu, 04 Jul 2024 12:53:14 +0300
In-Reply-To: <20240703210510.11089-1-amishin@t-argos.ru> (Aleksandr Mishin's
	message of "Thu, 4 Jul 2024 00:05:10 +0300")
Message-ID: <87wmm1cwl1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksandr Mishin <amishin@t-argos.ru> writes:

> In rtw89_sta_info_get_iter() 'status->he_gi' is compared to array size.
> But then 'rate->he_gi' is used as array index instead of 'status->he_gi'.
> This can lead to go beyond array boundaries in case of 'rate->he_gi' is
> not equal to 'status->he_gi' and is bigger than array size. Looks like
> "copy-paste" mistake.
>
> Fix this mistake by replacing 'rate->he_gi' with 'status->he_gi'.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

A reminder for maintainers: rtw89 patches go to Ping's rtw tree, not net
tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

