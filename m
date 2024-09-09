Return-Path: <linux-wireless+bounces-12662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEAD971955
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C871F2312F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED65422095;
	Mon,  9 Sep 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8xP5ytq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DE1E522;
	Mon,  9 Sep 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885036; cv=none; b=KCCCFadxxKRbRaI4ADpB2RkYPEtKmnHU6WTQcxHLfrzP4jr3aF5ashqftY4ns3yaXI87dlI9MiFgl76BnlE/ItzCckRBhuMInD7qJeoHIUHyvVqTDaLx60G4IFOP74X4/FR2fkQ9/Pc310/H5ua5D3k7ABdf9fmg7ZzniTrpY1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885036; c=relaxed/simple;
	bh=OUn/degUiH165tZNLfvps1/lgjuYW32EmyaNsXg1vuA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=EvvOcjJnQ0Kcq5ABHaFeR6qLGsUGiqzF2Ja4hWlDXiRCQP0YMRl/LpDtgqbH/xCIu4FaARV6UlEVOSJN9L9xSzACfeJDrhVeU3wbwH5lzBjqOfkmcMCe4NuXihcgs5CrMRkrTovemqsT5G5wT7pLOpBZ3pxjjfYSNePoSI6sjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8xP5ytq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72323C4CEC5;
	Mon,  9 Sep 2024 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725885035;
	bh=OUn/degUiH165tZNLfvps1/lgjuYW32EmyaNsXg1vuA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=o8xP5ytqGtSGwMeIHwXV/gYK9s33IQNMG+ym2oxDo4sQi6G18aaD20mAKJL0PNKND
	 XSkCog4OVizqGbzx3Ydo18T1cEre7gULlG9UT4KXnzdoPJaq5QBUTOFleFdwbqW2HP
	 mxRHdGpxaqdwC0Ktx0IBN+HdwVhq5UhMa9hsSvj+WwjExnDGO36UJjBwW9+m9Jh4Mz
	 m2BpyZ8to0tZQVDI1KTC8vw8u1gEQ+OSEVzQ5ltjLZ/RS6ieVftSjPbMRNWalwZNnP
	 6UguEEAeg6xPRN/aPW0pXzNPLybV2IeO4/fRg6L/O8nJbGs96Ye3iCuRaUr7HI1yp1
	 5/qCL7MhIBt9w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: libertas: Cleanup unused declarations
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240903115811.958692-1-yuehaibing@huawei.com>
References: <20240903115811.958692-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <yuehaibing@huawei.com>, <libertas-dev@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172588503287.2095526.16517907817437814288.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 12:30:34 +0000 (UTC)

Yue Haibing <yuehaibing@huawei.com> wrote:

> There is no caller and implementation in tree.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Patch applied to wireless-next.git, thanks.

54c9b9735246 wifi: libertas: Cleanup unused declarations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240903115811.958692-1-yuehaibing@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


