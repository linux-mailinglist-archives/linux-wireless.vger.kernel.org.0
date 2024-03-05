Return-Path: <linux-wireless+bounces-4389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCBC8725D8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D5D1F21946
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0A17555;
	Tue,  5 Mar 2024 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2n5GxJE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E7171A7;
	Tue,  5 Mar 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660621; cv=none; b=frNv1mzMvJ4+sf9dA8Vhwi31oe0upzcCy+67sVd8bd4ql5cYmiIVtFXNG83CxyuqNN8/UcQ9gxO5clsQEniB8epkmjdbqmfOUz+MMla2ZA2a93OUUl2+Os5UABY1RYgpASa8jfmPV4cETYCQqhZ/sIHBYJ6ATpfLPARzsX/lvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660621; c=relaxed/simple;
	bh=k3duPj50TUmWI9VEiNWJ+Oj7+nk799b9xKxX4qq0/PQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=FdSX37YjQdR63DHBO+KbuQPp3VUvgAvJKhH25d6VNMl/yKpqiv9Y/pB1uZLNxdBaf7e6nbGLjNhTgWAZpY0FQMvGiGc8QJmBz1cvvhLM0M8qfhj5+70+GAdNd/wOqd9HUkHBX2a8NcW/0+hFdz2mgm/KML5UpLEI/QN1RtwdTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2n5GxJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB75C433C7;
	Tue,  5 Mar 2024 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709660620;
	bh=k3duPj50TUmWI9VEiNWJ+Oj7+nk799b9xKxX4qq0/PQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=m2n5GxJExidLb5JA5HR4QDHzw3elLQ7AOQZuj6Qf9uKVS1EEx4UACBhqTnEaF5LlS
	 utnlmMgmY0pThjqAMelG3j8B1e7DgClRmM8jZEMaT0zr/6itfnjI28iGXWZSipTg/x
	 yBbcOCLwfm7apJ4FYwlrr66TPVSTBOt1MAE9E2s8/EAGIAZx269DWhZNqhFQY3WJDM
	 ssg/uJ+g9rYdWa6SDmkg/l8pewo09RC8CHmTyrUAjj7ipO/ZZB9pLZsqUMQtr2s+5K
	 UO4kWhCyVGe711Kk/yJAcnl4GXxMV8znbJ4wEA1aB70gHdDfE/afWvoRK7KInVKYT7
	 CtLo10CZVe4MQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH,V2] wifi: rtw88: Add missing VID/PIDs for 8811CU and
 8821CU
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com>
References: <4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com>
To: Larry Finger <Larry.Finger@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 Nick Morrow <morrownr@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>,
 Ping-Ke Shih <pkshih@realtek.com>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966061752.365498.12192322464108604606.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 17:43:39 +0000 (UTC)

Larry Finger <Larry.Finger@gmail.com> wrote:

> From: Nick Morrow <morrownr@gmail.com>
> 
> Add VID/PIDs that are known to be missing for this driver.
> 
> Removed /* 8811CU */ and /* 8821CU */ as they are redundant
> since the file is specific to those chips.
> 
> Removed /* TOTOLINK A650UA v3 */ as the manufacturer. It has a REALTEK
> VID so it may not be specific to this adapter.
> 
> Verified and tested.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Nick Morrow <morrownr@gmail.com>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

b8a62478f3b1 wifi: rtw88: Add missing VID/PIDs for 8811CU and 8821CU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


