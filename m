Return-Path: <linux-wireless+bounces-14149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A80C9A24EE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAE128814C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1F1DE3CB;
	Thu, 17 Oct 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoS3N4X4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29EA1DE3AC
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175067; cv=none; b=LPBphKc3To6wRFYAVEE6IIXiuLzsIFABgmlM/3NclPWPExBmJevNZIPoPlRZpuwnCLmOpIaK2wZgXEfYDYsf/3FqsWs5fvlbaBbowx49m/SDgx/CYPLoHOA3va6vZLBYUTW/3IPnrb0Z07v82d16viznWuyLmqblNLoaCuS9/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175067; c=relaxed/simple;
	bh=QRlO4Cx2toqSMzJQQQ3aOPHetZ0vJLlhP6ua1/KAI10=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=nS9zwwhUodag9UCEYRadTGl//1Dos+ZsiPEXLn8zEsyMkuKGQP6u+ALlWKXQNefBeOKFr0JPBQV3Ny3OrTdczHFSy2Zi6Ndot3Nqq0cB8x1VCBFHWRF0Nln6Mz8znca7VFsscXBuuz/Q3pY6KUBpO8D/UfbUnNTSH4LjgIIX/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoS3N4X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFD7C4CEC3;
	Thu, 17 Oct 2024 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175067;
	bh=QRlO4Cx2toqSMzJQQQ3aOPHetZ0vJLlhP6ua1/KAI10=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DoS3N4X40IikPrpBSbpSFctUP1+4wQXA7IBIHw/3d2KGusGFZS7eZc8P4Bhb/TJsO
	 0z7UFQ4L2DTisf//Trw2vOev48BAjJkZ9SbIArkWMGAy37Cyt4XKyeGoe2qF0nRMOs
	 GhcPg3gOqqIfme1zkztYAxoOrY/zSNuTVKvZUDL0+V48skUXpPrk/RsVJ6suZ0IVlF
	 HN3KKiXiivHUXy6V8ZGbnGDGoKlYKB8tZtkHzbIqDRey58Ij1GN7A1Ln7ex9WSSGwy
	 OxYc4BDaAkAd0Tj+ZjNF2LImJiFtzFE6dVwAP5P5iJjePERsgQx8qEEtWqwSotj9ou
	 Ru4b4shzP91eQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
References: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172917506486.799221.14850633714806927517.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 14:24:26 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> RTL8822CU, RTL8822BU, and RTL8821CU don't need BIT_EN_PRE_CALC.
> In fact, RTL8822BU in USB 3 mode doesn't pass all the frames to the
> driver, resulting in much lower download speed than normal:
> 
> $ iperf3 -c 192.168.0.1 -R
> Connecting to host 192.168.0.1, port 5201
> Reverse mode, remote host 192.168.0.1 is sending
> [  5] local 192.168.0.50 port 43062 connected to 192.168.0.1 port 5201
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  26.9 MBytes   225 Mbits/sec                  
> [  5]   1.00-2.00   sec  7.50 MBytes  62.9 Mbits/sec                  
> [  5]   2.00-3.00   sec  8.50 MBytes  71.3 Mbits/sec                  
> [  5]   3.00-4.00   sec  8.38 MBytes  70.3 Mbits/sec                  
> [  5]   4.00-5.00   sec  7.75 MBytes  65.0 Mbits/sec                  
> [  5]   5.00-6.00   sec  8.00 MBytes  67.1 Mbits/sec                  
> [  5]   6.00-7.00   sec  8.00 MBytes  67.1 Mbits/sec                  
> [  5]   7.00-8.00   sec  7.75 MBytes  65.0 Mbits/sec                  
> [  5]   8.00-9.00   sec  7.88 MBytes  66.1 Mbits/sec                  
> [  5]   9.00-10.00  sec  7.88 MBytes  66.1 Mbits/sec                  
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.02  sec   102 MBytes  85.1 Mbits/sec  224             sender
> [  5]   0.00-10.00  sec  98.6 MBytes  82.7 Mbits/sec                  receiver
> 
> Don't set BIT_EN_PRE_CALC. Then the speed is much better:
> 
> % iperf3 -c 192.168.0.1 -R    
> Connecting to host 192.168.0.1, port 5201
> Reverse mode, remote host 192.168.0.1 is sending
> [  5] local 192.168.0.50 port 39000 connected to 192.168.0.1 port 5201
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  52.8 MBytes   442 Mbits/sec                  
> [  5]   1.00-2.00   sec  71.9 MBytes   603 Mbits/sec                  
> [  5]   2.00-3.00   sec  74.8 MBytes   627 Mbits/sec                  
> [  5]   3.00-4.00   sec  75.9 MBytes   636 Mbits/sec                  
> [  5]   4.00-5.00   sec  76.0 MBytes   638 Mbits/sec                  
> [  5]   5.00-6.00   sec  74.1 MBytes   622 Mbits/sec                  
> [  5]   6.00-7.00   sec  74.0 MBytes   621 Mbits/sec                  
> [  5]   7.00-8.00   sec  76.0 MBytes   638 Mbits/sec                  
> [  5]   8.00-9.00   sec  74.4 MBytes   624 Mbits/sec                  
> [  5]   9.00-10.00  sec  63.9 MBytes   536 Mbits/sec                  
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   717 MBytes   601 Mbits/sec   24             sender
> [  5]   0.00-10.00  sec   714 MBytes   599 Mbits/sec                  receiver
> 
> Fixes: 002a5db9a52a ("wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

4aefde403da7 wifi: rtw88: Fix the RX aggregation in USB 3 mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


