Return-Path: <linux-wireless+bounces-4400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F1872716
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 19:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F0F284194
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47428DDB;
	Tue,  5 Mar 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8t/t8nn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88B1B809
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665026; cv=none; b=bmIQHfDMyLUFCptJvCLx/wWstgFnObthgP1JDKqL8ZzsclGYrmKDT5+y+9YI6rECN/w2B4c3Q/touZgi1J9OB+rlZNYpKT40Sox4HpMy4P5/fQbVq7V4SguLDRmtFl95lTdWeEZ+d1jI5AnW8yYOHxV9fet7zU9mRAU5Cy5yilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665026; c=relaxed/simple;
	bh=T2zu1pO5c4GCBLYxwdUk3vAsKGmikwmLd9aN1lfdw00=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kwxAJgjydXSmYWM25o/gl1Z72d+T6H6iXuxIGBXK0JzdrL20BHKyWRAkNegkl76tudqzdQAcITUBMYtEMo9xR1ShBiGWVGogbyxEWWpla95qZetb4dwgURpOWi6KN1iWitBtdS54QJTvhY01fSitLsgIn6925nleJFqQ1eDdPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8t/t8nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55065C43390;
	Tue,  5 Mar 2024 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709665026;
	bh=T2zu1pO5c4GCBLYxwdUk3vAsKGmikwmLd9aN1lfdw00=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=t8t/t8nnjcqfW9fUDB7FABdooeUR2D3yB6l/ZdofOkK6A5+B9ctp8nrD1iuYf5ct1
	 mKrMd1te2gZ35lQHKNAG9BANuXZLJU9WWJY/521yR2nqXoJwsom8+y0d9poYb/9LcC
	 LOd1kjMWB+tATXW8u3ZwUFZmrfhTQ7rvwK0PsIcpxia3izqVgGH44PqzRcSertxu4o
	 U5TdAu0UQQk0jLDYxb85KpoX50U1BAVEntjbjz0K73dgaD2lUAULIqLGifOZqZ8N5l
	 D5cnmszNugKhTRDflafuwk68fvMiadsQj6GsOEMTF6m/pVdTEULbk/WCfOCeaEcawD
	 651XnsKh1ncxA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: wow: update WoWLAN reason register for
 different chips
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240302005828.13666-2-pkshih@realtek.com>
References: <20240302005828.13666-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966502249.424347.1909823618619375040.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 18:57:04 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> The WoWLAN reason register is used for driver to get the wakeup reason
> for reporting to cfg80211, and it is different from chips. So put it
> into chip information.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

6ec8faa36564 wifi: rtw89: wow: update WoWLAN reason register for different chips
a0f0046533cf wifi: rtw89: wow: update WoWLAN status register for different generation
1bf6fa8ac6d5 wifi: rtw89: update DMA function with different generation
fff821286f7b wifi: rtw89: wow: update config mac function with different generation
60b3f2898a80 wifi: rtw89: update suspend/resume for different generation
d12d3df87497 wifi: rtw89: wow: set security engine options for 802.11ax chips only
4dc38e39758d wifi: rtw89: wow: move release offload packet earlier for WoWLAN mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240302005828.13666-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


