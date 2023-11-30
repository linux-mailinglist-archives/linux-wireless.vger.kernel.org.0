Return-Path: <linux-wireless+bounces-252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B926C7FFB0D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD231C20CAC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA95FEFC;
	Thu, 30 Nov 2023 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGdfVwwR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35274A2D
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 19:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC40C433B6;
	Thu, 30 Nov 2023 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701371951;
	bh=ryf0ac22TL6DaGrTFgOPiOATU06MewbNS0dcr3C123M=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=PGdfVwwRrgWewpOo2s9FxLYSSS3AZYXHf92wPyUAn9ThkAl/79PE490k/9gR5PCUy
	 Z8iKG+Yf5lgyXmFJCDn7fRirIQ533MFUnFNbN06nOetLxAlLvPh8ilZZXnLwjehEXM
	 5hIfMsBvcQGlZCSe0gaBmvAgpeNqI85t1WBhOioNujgge7wS4iClZR89b+jDUeXsiW
	 m5MnZSEzbJkGSGVAHkeZw/1obqn67x+rQsJFuQBlxe+2jKLyJWW0sfkJvEx+MgB8+w
	 XykW7B5/Bd3z/j3fftyN62BB4vByy/OuNK8iUQrY5i8rbvrj6oJoyFcgfT4rMyX08u
	 MDbhSd0viR44g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] wifi: rt2x00: Simplify bool conversion
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231115010017.112081-1-yang.lee@linux.alibaba.com>
References: <20231115010017.112081-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: stf_xl@wp.pl, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137194830.1963309.4994000152784974396.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 19:19:10 +0000 (UTC)

Yang Li <yang.lee@linux.alibaba.com> wrote:

> ./drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1331:47-52: WARNING: conversion to bool not needed here
> ./drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1332:47-52: WARNING: conversion to bool not needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7531
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Patch applied to wireless-next.git, thanks.

cda398fcb488 wifi: rt2x00: Simplify bool conversion

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231115010017.112081-1-yang.lee@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


