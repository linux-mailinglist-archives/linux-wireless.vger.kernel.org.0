Return-Path: <linux-wireless+bounces-12664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D897195C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338BA282338
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D442048;
	Mon,  9 Sep 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6DqPO7Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E71DFF0;
	Mon,  9 Sep 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885115; cv=none; b=F4OAexru4RwBKCwny0fOFNtl/p86c9kRZSihIlVox0JmToCgyjsGHfFQmzheM8Q0BSbQjczvhrb+lJifcIUV6rjmVaOOpGeqegmLELlhf0vX4POXwxSyX0ZeR+iH5TsIJ0vXviR8cOf1uQUFvgEGJE29Ywilbv+G2EV/ysrsW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885115; c=relaxed/simple;
	bh=ok3YdEmI3KPOJX+am0aMqF5dQxuSRVW0iubchMi0Mn8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=sjU1/5cuWqAfLrvmIAvHTolN4m0hQ9T1w6JEHQSRKhW9J2aao6thORdInnzjNW+PRdRZtZiD79mfk7LfCYd5W1RqPT7nZr3dvuo6BzxL5GTRvhPbQSZAclB7zNc9xWBHGst04cAHcobk01JcJ6Kv8TsiiTycH+F5EdpfcB00lJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6DqPO7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F2C4CEC5;
	Mon,  9 Sep 2024 12:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725885115;
	bh=ok3YdEmI3KPOJX+am0aMqF5dQxuSRVW0iubchMi0Mn8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=p6DqPO7ZCcQdj6T1BL6EpyxJYpA+4TyZSqK6S2Y/856BUQF/eiRiH/L96uLfCSpm9
	 qBqa7kCgn6EPhdGPWjuC+iSES9xf12m83xmp4LYfDgm61Xzov449JKVwiREG/hRypU
	 h+xPA9FVwqXK8AQfH9nKKB6jX0K+lY8Hq6N16gyz9Gw/3HimGL0+bGsPMsfEVaTjrq
	 gf978ZGwY7RKaaMNn5T/9KhoXws7ZZ8FzPR/xCACsBGoP8KMiWGyyy36nJ5eyIJCgn
	 14a6YzBPcLP1fDOpEWTIuJ6v+uON+ozFXSb8j+LvG5Hb1jXPP8kajMESi1dA3Lb0Q8
	 S6WNGQVOXa4fw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Convert comma to semicolon
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240904074637.1352864-1-nichen@iscas.ac.cn>
References: <20240904074637.1352864-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: arend.vanspriel@broadcom.com, johannes.berg@intel.com, kees@kernel.org,
 a@bayrepo.ru, wsa+renesas@sang-engineering.com, quic_alokad@quicinc.com,
 marcan@marcan.st, j@jannau.net, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172588511056.2095526.3678260244479751728.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 12:31:51 +0000 (UTC)

Chen Ni <nichen@iscas.ac.cn> wrote:

> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

4f0568492fc4 wifi: brcmfmac: cfg80211: Convert comma to semicolon

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240904074637.1352864-1-nichen@iscas.ac.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


