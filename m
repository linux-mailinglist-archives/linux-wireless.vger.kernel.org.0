Return-Path: <linux-wireless+bounces-688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C463C80E56F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 09:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DD01C212A7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2B18B1B;
	Tue, 12 Dec 2023 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMUszGCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1118B19
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 08:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF2CC433C8;
	Tue, 12 Dec 2023 08:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702368342;
	bh=gpNj8I/75OB5szd1g/dOW3OTP6BzEjuRG5ADKuihkok=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nMUszGCH9FX8/9eCqx9A1bdo4CS3slOBK6DdDZykUgYpjfoZ2REWvRyC6nlTKEOb/
	 fJDYezW6gy/v7bgrLUkKBIiufO4Lug8v62hEzREmON33GkXmd/ZJ7V3PBUjJtPAq2F
	 GIAuKFRpx1UarXZIo70yY0xhjPnmCiUMzggVUrsUK2zlrg9x8iKqKZLL+sqrpfjH3p
	 hYwt2DvCqLjqWd4zePq4nqJHCVCUGfviuQwFGuuYqxFPiLZZ+9xiZnOCSx/D+OPkqj
	 2JtDP/o1UFJAF8Uc96bXP19O5WCU0auyccrc/g689Mei1iCnQmPWre5pfgkre9EIAN
	 hwZbwMbKYKYrQ==
From: Kalle Valo <kvalo@kernel.org>
To: shitao <shitao@kylinos.cn>
Cc: gregory.greenman@intel.com,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] net: Fix spelling typo in comment
References: <20231212071935.3098275-1-shitao@kylinos.cn>
Date: Tue, 12 Dec 2023 10:05:39 +0200
In-Reply-To: <20231212071935.3098275-1-shitao@kylinos.cn> (shitao@kylinos.cn's
	message of "Tue, 12 Dec 2023 15:19:35 +0800")
Message-ID: <87wmtjonfw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shitao <shitao@kylinos.cn> writes:

> Fix spelling typo in iwl-context-info.h comment.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: shitao <shitao@kylinos.cn>
> ---
>  drivers/net/wireless/intel/iwlwifi/iwl-context-info.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The title should start with "wifi: iwlwifi:". Please read our wiki, link
below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

