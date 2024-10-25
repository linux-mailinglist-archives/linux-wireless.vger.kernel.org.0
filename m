Return-Path: <linux-wireless+bounces-14498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9029AFA33
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 08:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423FF282EAB
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1197118C935;
	Fri, 25 Oct 2024 06:42:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F218C018
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838541; cv=none; b=f1kMrsFsL2skgLTWAY6Fgsw/syv24CwPl9V0rVtp1IHqDKvbiwBBlcbwGcjkpXYI0rkheGnw1MD34dz0DVH3QlLjC9k+rq4r3jgbBN6Jr/6JmRwPshRczMU2S1MzUYnqVkGd48xgvui9YkTzsOg77R/eGu0kndkCXSN/yMU+0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838541; c=relaxed/simple;
	bh=kYFBttutQx2tMJpYacffeZDEGJ1YNRj1rjKMpH3pXzs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HpwN4uHBzqz/11SOvH0by47Nt7urD8B/xWRG/oilIlzx+cXFolBRMB/3oAbBT9nOSZUSDsBThKZVGd7+pFAdYW14PsBJDyyIz+NddtKCY6HX6JinEzeNSCBXHUpFt1040fRwSPNf1RtPsTm/Y5vQgNhjxMOX3dxedR53PKiaTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XZY8c0S1MzQsG3;
	Fri, 25 Oct 2024 14:41:20 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 08CCF140337;
	Fri, 25 Oct 2024 14:42:14 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 14:42:13 +0800
Subject: Re: [PATCH] ath11k: remove error checking for debugfs_create_file()
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	<linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
CC: Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20241025063614.368-1-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2aa6fb4a-157c-b5cd-f246-22bcb2636b66@huawei.com>
Date: Fri, 25 Oct 2024 14:42:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241025063614.368-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)


Sorry, Forgot to add v2 to the subject. I will repost.

On 2024/10/25 14:36, Zhen Lei wrote:
> Driver ath11k can work fine even if the debugfs files fail to be created.
> Therefore, the return value check of debugfs_create_file() should be
> ignored, as it says.
> 
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/net/wireless/ath/ath11k/spectral.c | 24 ----------------------
>  1 file changed, 24 deletions(-)
> 
> v1 --> v2:
> Remove error checking for debugfs_create_file() instead of fixing it.
> 


-- 
Regards,
  Zhen Lei

