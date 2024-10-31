Return-Path: <linux-wireless+bounces-14779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE879B7C73
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 15:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7771F21B7F
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5619F41D;
	Thu, 31 Oct 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruM8qATr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22019538D;
	Thu, 31 Oct 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383812; cv=none; b=Qv3BX2GZ1Rt8BHBtrv7d6NnClZ2tvluTbJRRboLnistrX8wZDZ0kF9Ir4EUPNyqGLkeXTCks5Wjwph/0OAHRYPba460564tnMy4SDM8c55fP5AQUMcRUNFJfnqE/INDgYXCZRO8Y84NSmPyaTQx99M+krfvVXSCIMF5CpHdorE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383812; c=relaxed/simple;
	bh=8WGos1x+oBTF5bVQR3G5t0JfZpgS3k3J6doGA/QaG4w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TB67kimaFPlmcJi/wlcGZ04yVS/3/Skl0gRaLMsrcTt9MXVvUaVPNxKf4H+yQhnd3t1OdiudhbTvYf5paXd5l+oWZY6r/hhMYSxJNT2VpQ8swRefThAX5iJWy66qdBlenbDYe146VJqELT0Qd9xvP6E7AgL4t8JuAzk9ysYB9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruM8qATr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE065C567C7;
	Thu, 31 Oct 2024 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730383812;
	bh=8WGos1x+oBTF5bVQR3G5t0JfZpgS3k3J6doGA/QaG4w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ruM8qATrIIYZIbc5vVWHZ1DibbllBNorwrIv5GFdGvKKFz7GshhbtZTfnbn8Z27q2
	 tU9uM7qAyzwCrkgGDAVJ9carz8/hnE5gQ4wdHF+Yc8Vvz6NjaL1wkhPI9iDAIE+0Ue
	 FBUMupBwPT8FEhcpHMcoa8PHlzO9JdcMSVwP68PMZoQCucHKDr2bNB90kKNxpYZNuU
	 06LG4DDp7ys5Zo4JyvQiGYDFNfnbpXz+w3I2O2Bu2lYtZqAHJWkIVcwNJT8ZLx7/to
	 qMJ5RyDNnfY6eKF386fSp/S1q0wjwg3+JjtNppjithk2hFnOZjvB8A8Ih79GkYNnEc
	 O1uucZB2FSFYg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] ipw2x00: fix bad alignments
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241017020113.122029-1-jiapeng.chong@linux.alibaba.com>
References: <20241017020113.122029-1-jiapeng.chong@linux.alibaba.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: stas.yakovlev@gmail.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173038380901.539202.10384642881814927293.kvalo@kernel.org>
Date: Thu, 31 Oct 2024 14:10:10 +0000 (UTC)

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> No functional modification involved.
> 
> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code aligned with following code on line 882.
> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code aligned with following code on line 900.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11381
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

It's cleaner to use '&&' operator than two if statements. Please also
add 'wifi: ' to subject.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241017020113.122029-1-jiapeng.chong@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


