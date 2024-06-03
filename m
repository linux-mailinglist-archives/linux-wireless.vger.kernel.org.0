Return-Path: <linux-wireless+bounces-8425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3A8D83B4
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0321F21D67
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85F12CDB2;
	Mon,  3 Jun 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbX6VyJm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5858384D10
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420561; cv=none; b=T7c3YJwnSWClMropNVFUzJj+Z7TwAthZg0OcujARMBJP2McW93QYb64YgkfqbtzuBAs5V2eIlLqTjTbLhSvThg+Xu6gph4L2SYgajeMIPzOSMacYjkRcgirohUrq6y+J/eepLygDQAzAfr0igPYduFmoRoWPqlzoVW6H4HBJKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420561; c=relaxed/simple;
	bh=Oi5Pws480BNKKSEe7sI9huy38X0E8GqOQvpvBv6winQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=X5p7fEhlmT1N0tB6yZkEqr+RrJSltBebn6no083wHeffhu3Y4vlJ7shyPsmLIVWZvMuEy4CJ4xVUyMyRJPV1guke2qfU/fHVgTPCaIfwYkTaL/CpmTeM6mqbAR25kqBGmheRegn/FE1QpncEQIsDhCX10ni7LmxB8uRFzv1Da+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbX6VyJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD760C4AF08;
	Mon,  3 Jun 2024 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717420560;
	bh=Oi5Pws480BNKKSEe7sI9huy38X0E8GqOQvpvBv6winQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=QbX6VyJm5H2KJZLLGrxdWRhJmYuoTSTCScF+gywdKRqclmXfSv33sXV5ebQ4071iK
	 UCJq4pJLQNpqhFfgFai4a6D5wl2fSBpPFJ8JR40wLlYz5gbxc7IeYczM9f0rxxh9F0
	 /6D2EHFUmJWA/vkK6LpSOIkES6XQqrKwAn7NTeh8ZoSUe6jHHIk8sznVebJ7H2z9YO
	 NmLalE8wOmnR/+xVfRJJI/t+odHvyzQ+kDeZP6XmQ/gkGLf7m4vtOE9A9wsdLV3Jr3
	 ZRL35LMl2gTSeiCu1+eaV6E9bhpNHYjUG3wGAL+oNTdfR7/zlSJPYjxyKeLr8/jOcJ
	 d7CS8bjpfA/Nw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add hw_link_id in ath12k_pdev
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240529054955.4105240-1-quic_hprem@quicinc.com>
References: <20240529054955.4105240-1-quic_hprem@quicinc.com>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 Harshitha Prem <quic_hprem@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171742055763.1515473.11657840597879323437.kvalo@kernel.org>
Date: Mon,  3 Jun 2024 13:15:59 +0000 (UTC)

Harshitha Prem <quic_hprem@quicinc.com> wrote:

> Currently, hw_link_id is sent in WMI service ready event but it
> is not parsed anywhere.
> 
> But, in future, for multi-link operation, this parameter would be
> needed by many WMI commands such as WMI beacon template
> (WMI_BCN_TMPL_CMDID), WMI vdev start for Multi-link virtual AP
> interfaces (WMI_VDEV_START_REQUEST_CMDID), WMI peer assoc command
> (WMI_PEER_ASSOC_CMDID) for Multi-link peer and so on.
> 
> Hence, add changes to parse and store the hw_link_id received in
> WMI service ready event in ath12k_pdev structure.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

22767241e644 wifi: ath12k: add hw_link_id in ath12k_pdev

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240529054955.4105240-1-quic_hprem@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


