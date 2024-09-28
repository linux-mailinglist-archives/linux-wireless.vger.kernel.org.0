Return-Path: <linux-wireless+bounces-13267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F5988EB7
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC6A281A5D
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134219D8B8;
	Sat, 28 Sep 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlIvXf7I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2514D2B1
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514840; cv=none; b=gFXt1OlNcdVvUZtGZJiq/sbTbvFvJ/KZ4ZaxdNX+4C4crvyAbM9h3OLcCHO38dPlWfzteUAMp6nzGpnSIyOrEBcQ1TGa9waMB6tkCscM1UGykG2WrVdTGIbr9OrE1QjeU12cxXnlofpAb7Ug7Gvs0eVUBOh3UETz16OWSm1o3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514840; c=relaxed/simple;
	bh=MuoyHGLE+6W/2kYjgGiz6aPF6NyGFpk0q3YTEbhJ22Q=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=dDzY1cQ7Hb8sfeQnjoR02ejKD7thJc2MJ7KukwzIQUlcUPiNUELu05mUWjYpWWvjf6Dt10NcDnxULkNXJfKHwd+Pgv9UcNxMSZtvbMLDhFJ53+v/YUBa95eGlbfXFUaaqru8CAF74ycSwvb54ETc0aWwRSQ/9GPJlSdc87/3aMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlIvXf7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22CCC4CEC3;
	Sat, 28 Sep 2024 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727514840;
	bh=MuoyHGLE+6W/2kYjgGiz6aPF6NyGFpk0q3YTEbhJ22Q=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=TlIvXf7ImSnY4yM5siqqjl1q/xZydstwz7wwTCtuS3iomiFU7tR948oHz2bkvdtbd
	 M3x9r2vWhFEc0N64RkMhJ/TZY8zcURUOyl8lMhX4TCP7FXkf0n6zTknUUYexAH6r+6
	 y9pukfTvAl6GuxAfVXFR/g/FkHGnfJM5MA0ZW1FvODaI9nplOoHLlRDOZEN+RjGKQ0
	 7yuHaE7TjM0IdWKrod04AVACpsuVFx2emkkfcAcLr5j74HccsDy0c2qLZF5wL9/tVM
	 jfJNJ0IpgrOP5vcz1s/dkk5GARD15v86rOEOLbOAy3vlq1XyZ1U2hFjxIovrSGc/sD
	 6IWXZOtNsIZww==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath10k: fix the stack frame size warning in
 ath10k_hw_scan
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240830015649.1083758-1-quic_miaoqing@quicinc.com>
References: <20240830015649.1083758-1-quic_miaoqing@quicinc.com>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: <quic_jjohnson@quicinc.com>, <ath10k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751483707.2249584.11310873270275618668.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:13:58 +0000 (UTC)

Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:

> Fix the following W=1 kernel build warning:
> 
> drivers/net/wireless/ath/ath10k/mac.c: In function ‘ath10k_hw_scan’:
> drivers/net/wireless/ath/ath10k/mac.c:6468:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Compile tested only.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

acf8304b58e8 wifi: ath10k: fix the stack frame size warning in ath10k_hw_scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240830015649.1083758-1-quic_miaoqing@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


