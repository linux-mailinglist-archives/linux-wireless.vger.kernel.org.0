Return-Path: <linux-wireless+bounces-10997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A95948A5E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 09:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53881F258F8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98B13C909;
	Tue,  6 Aug 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQfA+6N+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4A15D1
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930358; cv=none; b=SqRnx2IOXmBvTCnQ69J+AtokxH/3z+mtXs4rcuwWqZ7HecfTDi2wBYxCUl9kT9OvHvjCeyYG0zPS2oVb99mOStfD4FXJIwxZcAlnWFho80ClVjlQYxEo98Uz2U6mgvdRtOMaTUTqoYzkvjrqdtlXN27nxZ3k8jOKlJk9bMkOxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930358; c=relaxed/simple;
	bh=1evXblcSYvb5qmHw2FupWWsp4jq4UbWaaxs6X99ERLg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Fpwopoj+WNsqd5DqMAmxiMp0EaGiDMwON//cKbQKQI4P+UzU5Thoo+au4I0QaLU63QLiEFzP1hEfV0E/M+CesC+SeUyIBqdm5y/+8ZLHxgkAUYrOGIfRSrxQ1Jsu65FIpkvFpeoweSTKYEnvFHzTYQoMqz0+tr6YJZ9yg0SNmRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQfA+6N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2A8C32786;
	Tue,  6 Aug 2024 07:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722930357;
	bh=1evXblcSYvb5qmHw2FupWWsp4jq4UbWaaxs6X99ERLg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=JQfA+6N+K3aNud0gxxGN8p+XxG1gAUILNnkbhe2HtJGHwiPzuo27N4kRaM8t2Q5YC
	 EsoOtQOF6t9jypWEkZ0brn2BVRCb0jNDqWKg8NYNo1Kw723IlA0xZXsvgCddJ+cxQw
	 lM0qDgxfGJKKNQd9Z4qlLJ4X1wyEo1nUCS8BvwMA0BbLwzZFAhrQGpfa6vIgr+8Cv1
	 wmcuBI0k62Bb0+wOkVOOgURzk1fxlS4WW9PNKtDWXCEK1EUoVVSphx8dhCm8Z3CoBY
	 B1gIagT5QNp8RNIErhi04XSwugygKvKmAV43bVFmrRGlxo8gj6NMWM6Qm2mHwgchFF
	 PUqcNIPNSEkmA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: update proper pdev/vdev id for testmode
 command
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230424092420.12794-1-quic_rajkbhag@quicinc.com>
References: <20230424092420.12794-1-quic_rajkbhag@quicinc.com>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172293035522.3540390.11633694817898356836.kvalo@kernel.org>
Date: Tue,  6 Aug 2024 07:45:56 +0000 (UTC)

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> 
> User can extend test mode command support to set vdev and pdev params
> for debug purpose at run time by sending vdev/pdev param set command
> through the testmode command interface.
> 
> Fill the proper pdev/vdev id in driver since, pdev/vdev id details may
> not be available at user space. It will make sure that the proper
> vdev/pdev ids are sent to firmware.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Depends-On:
> 	[v3,3/4] wifi: ath11k: factory test mode support
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/testmode.c:250
error: drivers/net/wireless/ath/ath11k/testmode.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230424092420.12794-1-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


