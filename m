Return-Path: <linux-wireless+bounces-1941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C56182DD82
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D93AB21D52
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D875A18034;
	Mon, 15 Jan 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5bvSBwz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAE1802E
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 16:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D906C433F1;
	Mon, 15 Jan 2024 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705335578;
	bh=QiSgZSolxUPSfOYbyLUUHLTy4CLjDRtp62kNYexLlyA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=X5bvSBwzhpwwuM9OTTEWa3LR43D6ATbj7nHrPlmN1FTD7QAsb0S7HG9+8VuCTqQYJ
	 /iLdfdR1FJ92c2odOR6xTcg38Ang2XZVV694FtvUE0eBgd0PQ0g7zHhF9oDyzywFAY
	 nO3amy6rKUtR97rK7qwb2snkKJPDgtHhZRRGQ+4kobY1DW2Jb4M5cFlWY8GthHK+vB
	 1kGfHvWyDs3f8v80k9BVb6UYkWYB8KRqyUVCaF3r48/Pc0Uh3uwAECDHV1N7FTMgI5
	 xFusOOFXmSuIQ2QjuNL5BlKFoqnyXcJ1bh+jKIXRm4E9FEtIRzcgycmq9ZTzRdYhEX
	 bXrRiM+figKAA==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] wifi: ath12k: Introduce hw abstraction
References: <20240112024214.3481840-1-quic_periyasa@quicinc.com>
Date: Mon, 15 Jan 2024 18:19:35 +0200
In-Reply-To: <20240112024214.3481840-1-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Fri, 12 Jan 2024 08:12:12 +0530")
Message-ID: <877cka7enc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> To support multi link operation (MLO), need to move from the multi wiphy
> model to a single wiphy model. However, the single wiphy model allows
> multiple link/radio to be exposed by the same mac80211 hw. So introduce
> a new container (ath12k_hw) structure. This approach improves scalability
> for future multi link operation support.
>
> v2:
>  - Rebased on pending branch as per jeff comments
>
> Note: Raised on top of pending branch
>
> Karthikeyan Periyasamy (2):
>   wifi: ath12k: Refactor the mac80211 hw access from link/radio
>   wifi: ath12k: Introduce the container for mac80211 hw

In the pending branch I made changes to this patchset due to my changes
in the dependency patchsets:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=9a0e461254022db80d13f9a4e4046280bfd2bd9c

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=f7f6382c4e81f1de141d687e32a0159ee1a3f11c

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

