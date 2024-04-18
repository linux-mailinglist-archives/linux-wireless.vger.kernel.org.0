Return-Path: <linux-wireless+bounces-6530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E638A9E3D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E15282548
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0496316D316;
	Thu, 18 Apr 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6njuncz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364916D314
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453721; cv=none; b=jgTgxf5jaBd0F7sBr1+PTs1P+WC8iNO4g80+RMRYu+vKrxh04p20oaPDC3DCouYTWVqFcwPICeRG0Z+ZPCT+K5AbaND9hP/jTZqgsCYP6V4WZVRXIOMMfks2gsvOpazw2bz/nJ7XIGcdWNM0uy1A0/VVydO5DPFIoN8Z2StncyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453721; c=relaxed/simple;
	bh=Fg1mdjdgbV6WAOs9fX5Vh5bSfuJLR4gB2Io1vUVq0Ow=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=HMHvmYKwmVEw8pLZMtSJwoSNHaR7ItwwWp94xpTP+xioYS/SehcAwBCRNYIuNm2obTD7aVylYV3c8G/hrrTw7Zfn1uMxZK0wu9G+TRSHwWwKOoqhVK9JSzJ1Zc4S5FgwSX3tA4vgdnSJnzBn3Ysifte+U7UoUFglVN2JF5bfqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6njuncz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B5C113CC;
	Thu, 18 Apr 2024 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453721;
	bh=Fg1mdjdgbV6WAOs9fX5Vh5bSfuJLR4gB2Io1vUVq0Ow=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=b6njuncz/GTRtyZCSdS1B1/Ad8EjDgdt4DJQSyvXc0sD3jLanGamISxk+cbbq9KPm
	 pa59pyusK607rNfSLv+hf3D8jXmQcy6ZqwPYLvW9ZJZyNNjvfjypR+a+oLAMFUk/PC
	 dgLxqv0K+Xg0nd9lmQY0e03GAGZz3tUDQ4qge4CXbOJ/5LZVPhGKuRtB6pNmvF3yNr
	 nFlhdE8NeYDksom0i9Q8ABV08wZ7BaI0zF4jHwfmvyLc2nMy1bk0mxuc4rkeL9Jc/f
	 AZh0aPIvoioLqLmbvRjNcLQ5t1TWegpe0/q8xhXI5xDvllENbaTQ7v4Cw8XL3C5QW6
	 nIEHWwyd4CL2w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: enable service flag for survey dump
 stats
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240410085329.3649572-1-quic_kathirve@quicinc.com>
References: <20240410085329.3649572-1-quic_kathirve@quicinc.com>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Thiraviyam Mariyappan
	<quic_tmariyap@quicinc.com>, Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171345371816.934743.12955577371994067370.kvalo@kernel.org>
Date: Thu, 18 Apr 2024 15:22:00 +0000 (UTC)

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> The survey dump statistics does not display channel RX and TX time
> properly because the survey flag is not enabled in the firmware service
> flag.
> 
> If firmware supports enable the service flag "bss_chan_info" in
> wmi_resource_config to fetch and print the stats for specific pdev.
> 
> Enabling WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 does not have any impact
> on WCN7850 since this bit is not utilized by the WCN7850 firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0d55f86d0260 wifi: ath12k: enable service flag for survey dump stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240410085329.3649572-1-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


