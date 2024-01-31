Return-Path: <linux-wireless+bounces-2895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64358444C1
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 17:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AE21F213F8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143BA15AF;
	Wed, 31 Jan 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs6MHL7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31087BAEC
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719635; cv=none; b=TyHZEJ3ZVZhk/cpXfNiVDInjxaiv6PG5KqGURCX1jCmADzTcFZaTbBn+soSBouO9F4kwJyzAiZykf40NemNlH+itZx3B6OG3tv1sV2PKL855hz4KOKPqnebMoo7X1LbfHiN01REvlnXtctWT1bbVC3quUz0OGvwFDDZpHTRCrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719635; c=relaxed/simple;
	bh=n4J5e0trCTDGle1PSUsR+5t6O+Jx8VRlH+ldwH3yaDo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=QKm1SeegbSr3jZlNhXDCdH5sMmSRNUPw34N+qHE2MJNhlpJl/z3i5yJjUWfrEVPVRLFKMJrwN5ozAThL1sJHsaVg1pQTnTd/IyLWM1LVpi3jyjwPjE9nY/RJJrivTyS9QTlAJCphVeMhdGnctd15V3OXUl5mHYEjtoyMAbZUZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs6MHL7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204E2C433C7;
	Wed, 31 Jan 2024 16:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706719634;
	bh=n4J5e0trCTDGle1PSUsR+5t6O+Jx8VRlH+ldwH3yaDo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cs6MHL7ED2+/8SyaqbLJzKm8xhfoeCSuCVDoaKMKF/15AEkQUODTr9o0+NTn0GHTB
	 NB3o64hPMTy2Dz63AHHf49B4txBPbgp71IDyzEx0YjJOkrZGHX/1bq0l1SQPjO/hSh
	 57InP/lh6CiTKdeDdf5i/R1Ol8G5wJOwW0CbtgCVYc6R9psyfvWiNwosIflcpihVsh
	 Ip7T43Vn6chbPalDmgQS5LPr/K/V/EAAGBniHXvcYZIys126dBKcqrqPj/oUVGFOap
	 HxsC/tCe7UQD4h5W7I6NbNOlZON2ETSSLDwbWydTfQNdjotsXGzbU9hlKDdqcwEtYY
	 9+LFpLJ4e6hVg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: ath-next-20240130
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <87bk93vtxf.fsf@kernel.org>
References: <87bk93vtxf.fsf@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 quic_jjohnson@quicinc.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170671963103.2518225.1246004749714311904.kvalo@kernel.org>
Date: Wed, 31 Jan 2024 16:47:12 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Hi,
> 
> Our ath-next pull request for wireless-next.
> 
> Kalle
> 
> The following changes since commit c5a3f56fcdb0a48a20772e4c9b8adc6c7256a461:
> 
>   Merge tag 'ath-next-20231215' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2023-12-17 13:20:18 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next-20240130
> 
> for you to fetch changes up to 9d5f28c1366f48efae7b1df0f622285519e74dce:
> 
>   wifi: ath11k: fix connection failure due to unexpected peer delete (2024-01-25 18:44:02 +0200)

Pulled manually as there was a simple conflict in ath11k/core.h.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/87bk93vtxf.fsf@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


