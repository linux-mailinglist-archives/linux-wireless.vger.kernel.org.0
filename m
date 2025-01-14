Return-Path: <linux-wireless+bounces-17509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC4A11038
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85301164F35
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D21F9EBB;
	Tue, 14 Jan 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIG7ISXq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740031C1AAA;
	Tue, 14 Jan 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879680; cv=none; b=GT+ZZfCjbJRZULNrxCtbtP1dvq6iawX0/Qp02oSQnAawLBICZlzVMyEuoYc3D8lh8iBwJcKr03aTlbykpAmKt9C2Nlh+hv/TvKiIexsybIyQBxZBmRwosdL4YCI5IvZESkeFPvPl8Q7LNRCnHDPAgQna+9gFlCOwXBjbDntpxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879680; c=relaxed/simple;
	bh=UZlAWxazLyKXPF6jT2tCXWEb0opztpqdgjV+D26ctXU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qJhnuQ63hybYcES3cEGiltsS/T9AAYaZCv1/uyqwhwjzr0MZQX8jTag1G0qrWVkXJcyAAxP1k7cgFwolAdtIh3mht0eIlm7L9d4U4i5P+ET0mLxjOWigp+Lpp6fgeNhcAngXG+KQFDqXUaZKY9NfetosFvg+zm2fpO7J8DXPSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIG7ISXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5FAC4CEDD;
	Tue, 14 Jan 2025 18:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879680;
	bh=UZlAWxazLyKXPF6jT2tCXWEb0opztpqdgjV+D26ctXU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dIG7ISXqlo95SRmOtAyzskF56poaoYZfp/MKy/nBWFwO1nG6N3zddqjUmZvaR2H5m
	 TCChiBuh7gCVWn31LLp6H0rKjLePET6Ni/HRSWbzyaqs2g3hgrqBPVoy5IMngtWRpe
	 iSDSRUtB8RmRY+0niSIXgtrJ+Ss981z5s7SwZukcpLoYmSliQBKU3RnBtGygut7885
	 5+u+CoFmKxYwz1brDvKv6pQis+zs9V9ZHRPDwU2fzB60fA3ZM+eF4Cme+l5eZOiVv4
	 QmZNkEcdGSohSYYjMr8yUL3eXJB4ShBmmSP52ZVtEBCC5vrnLggNGfVCJQOtnjSpW+
	 M95icH/TgDXOQ==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  Rameshkumar Sundaram
 <quic_ramess@quicinc.com>,  Kalle Valo <quic_kvalo@quicinc.com>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>,  <linux-wireless@vger.kernel.org>,
  <ath12k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: fix key cache handling
References: <20250112-fix_key_cache_handling-v2-1-70e142c6153e@quicinc.com>
Date: Tue, 14 Jan 2025 20:34:36 +0200
In-Reply-To: <20250112-fix_key_cache_handling-v2-1-70e142c6153e@quicinc.com>
	(Aditya Kumar Singh's message of "Sun, 12 Jan 2025 11:23:00 +0530")
Message-ID: <874j21p7lv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> Currently, an interface is created in the driver during channel assignment.
> If mac80211 attempts to set a key for an interface before this assignment,
> the driver caches the key. Once the interface is created, the driver
> installs the cached key to the hardware. This sequence is exemplified in
> mesh mode operation where the group key is set before channel assignment.
>
> However, in ath12k_mac_update_key_cache(), after caching the key, due to
> incorrect logic, it is deleted from the cache during the subsequent loop
> iteration. As a result, after the interface is created, the driver does not
> find any cached key, and the key is not installed to the hardware which is
> wrong. This leads to issue in mesh, where broadcast traffic is not
> encrypted over the air.
>
> Fix this issue by adjusting the logic of ath12k_mac_update_key_cache()
> properly.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Fixes: 25e18b9d6b4b ("wifi: ath12k: modify ath12k_mac_op_set_key() for MLO")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

