Return-Path: <linux-wireless+bounces-7843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8B8C9CBB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C42817D2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5D51C46;
	Mon, 20 May 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onq/54R+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530E502AC
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206139; cv=none; b=YkwKHqELPpbY6oAnKmbxDQ6ke5c5I8GujhW6CtIhDFkbNmrypXh+M7sEEcTHf5Qm6chcpe/5aUZQWw60zyEL/+1A33uLgb0Lhl65KQvU53eUoN5XM7XALtU0rEqaiipOk84gNVrmiksFtQR5PKZjsX29u8GORKFNmBP+zf6xExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206139; c=relaxed/simple;
	bh=f1j3Tqo79beaP7NnAvfjwKD3XcqiDwySY4RJO7UpV0c=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cJ40jobffrVoehGGpxC3nOgxH/qaXYJ8HTPMS1yITaWTxJu6Qd7B9R1g5jjnGc1/QL1HuWZtCeJhTaISgavaN9KI3P8dX7lsuFNKJ5z4kFsO09uPn4QBvdpwjPSc/Bbe+blxnTXkaZDuJ7EbT7lYcmkKc99tW39ZY7x0s41JFVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onq/54R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0609C2BD10;
	Mon, 20 May 2024 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716206138;
	bh=f1j3Tqo79beaP7NnAvfjwKD3XcqiDwySY4RJO7UpV0c=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=onq/54R+yQZ1NwzqgzJWeaKChFODPwUMqzEXhibs6mld5/qFl2dCxnnNk1empSL5p
	 kIwxEy59DRE0tH5nL85/2XXpR01mPQwMYguvDHlDFRLo+NUXPrFRIyQL9XM65DEu4j
	 3pkhHJ+E6WCj8oFfSYee6Le2TqrAZL4/v/Qwpff+9OtNwupeMocY9/MAV5W2RlHqrJ
	 8DN1umku2j7jsABjccd1Ns6d2Hwyjw4wkZ2vYHdrneH6ZrEdZ4gKMy/U/nw4AkhBln
	 dNZ8ZirmnWvV4O7YaseZ1ExnKAGjry49OabJJOZjZuJZIkY3pWiLjN/bLW01YDMACI
	 sdwXayR4DjYGg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: Add Dynamic VLAN support
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240515192830.995013-1-quic_msinada@quicinc.com>
References: <20240515192830.995013-1-quic_msinada@quicinc.com>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Muna Sinada <quic_msinada@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171620613612.3753090.12657165170702284157.kvalo@kernel.org>
Date: Mon, 20 May 2024 11:55:37 +0000 (UTC)

Muna Sinada <quic_msinada@quicinc.com> wrote:

> Add support for dynamic VLAN. VLAN group traffic is encapsulated and
> encrypted in mac80211 and driver needs to set flags for the VLAN group
> traffic to skip hardware encapsulation and encryption.
> 
> VLAN group traffic utilizes ext MSDU and HTT Metadata to set
> encapsulation type to RAW and encryption type to OPEN in order to
> inform firmware to skip hardware encapsulation and encryption.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

26dd8ccdba4d wifi: ath12k: dynamic VLAN support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240515192830.995013-1-quic_msinada@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


