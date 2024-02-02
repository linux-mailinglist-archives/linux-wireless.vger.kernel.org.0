Return-Path: <linux-wireless+bounces-3033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400CB847075
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711091C21643
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC99215B3;
	Fri,  2 Feb 2024 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpHx6Im4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE415A8
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877540; cv=none; b=MYc4LOQb/kDc4/G5VQQ2j/ZrTMhEvdv8Hp7cStTIbb6U6h1s9dojDYy5nIMnUxegnr1ur1+Xk10BnzWngFZv2W3R3gR7X2yXpm7buGMRKIi4SDJnIZdtCZPbOuTSW65r26Kpgo62swm07nQ9jfo/dfaXDKD9q0M+a18w3AOkrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877540; c=relaxed/simple;
	bh=jlw+WaBxmiMvgg7wAZHfkuNgaQW+mz46kwn198X8l54=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=gpPoWpMUq3ooJcWyRvh9BLH9uBfu8p2bip4wekA83RKpdrx1KtwFbFFAL/U5QONo7OJyxRUK3noPcLwGAQIgiwTqIDeX5vKmxENYrO/Ltn9g06tYo40HOG1NJBgl6BwaWlDo0LsRSZ4jc3y/azAWc0DfTFie1Tsf2yn++JA/Irc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpHx6Im4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025CC433C7;
	Fri,  2 Feb 2024 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877540;
	bh=jlw+WaBxmiMvgg7wAZHfkuNgaQW+mz46kwn198X8l54=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kpHx6Im4m5FUw3oSPT8UtMvBZ9+w79xBqOJIDEsQHqwrezV0/SrwQtYezI/n5bLDe
	 5ZSk8dTpDkeWS9JIu+UFuz7XWQZOecu5eW1IlZscwgucd0dQIp6FdgYFkYg6ad1tB+
	 C8hvdm6DijciUyaQNMu9Buo+4u7x3Bs7VypRVYwIq9zTvO90W6XVfYENj1pCnoGWhp
	 Ky6JpPEjPL/y30qQS6ZOoR3MgZVF7aTrxd2Mmu9yPIEsq/kcLeJYI40NCaxi2ScZc1
	 2HRHrZv6v1s2ZWMqhi73Cw3iff/bTFG1X0ihi8xZOCLKxzlYyJBFxs8/Fjsuw8NXq2
	 urHzoPi/e3WYQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: refactor the rfkill worker
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240125154555.3169706-1-quic_periyasa@quicinc.com>
References: <20240125154555.3169706-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170687753736.3221346.15559067668006296036.kvalo@kernel.org>
Date: Fri,  2 Feb 2024 12:38:59 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, the rfkill worker handler access mac80211 HW from the radio/link
> structure. This is will be incorrect for single wiphy model, as they will
> hold multiple link/radio structures. To fix this, access mac80211 HW based
> on the number of hardware in the SoC/chip. This approach makes the rfkill
> worker handler compatible with both multi wiphy and single wiphy models.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e7c7fbb582bc wifi: ath12k: refactor the rfkill worker

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240125154555.3169706-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


