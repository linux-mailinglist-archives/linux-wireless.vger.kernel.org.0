Return-Path: <linux-wireless+bounces-216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBA67FD621
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C20283142
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787E51CF9B;
	Wed, 29 Nov 2023 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGCi24Nr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD71C68D
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 11:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ACEC433C8;
	Wed, 29 Nov 2023 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701259165;
	bh=IxdMQslkk612AP/cILCpgmoCw8Ky4Aib4RK2H0lKozw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=SGCi24NrdUE5JPvy8mmaa7cZijemPHbwQDy9DK5TVHxCSgTn9gKdxFKjYkreOBgDn
	 k8oCeeUaHwalbt6kjStcyFFuKPf763L1spGN2hhGtD231ug3sRBowDrBMkDStJLLhJ
	 G3J23MiQP2YNEMJcPUN3R+mDdC7TMcmJ6pMPsmJuk68ofpVQurXe86wV/N70xRpox6
	 9UW2yH6J3vTvkRc1dCgxFlwDxjkHj5EiP2MwA2tWSRtLugt9kQhO1Q78yOcoxB4qvf
	 /QQe1CKLPTiIxIm2im9i1GVelNt8uQMUitOyUeWDd4v9oW2FoTYaLa1YMgzfslGun6
	 u7r7ayQAv3bQA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: add support to allow broadcast action
 frame
 RX
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231116173246.40458-1-prestwoj@gmail.com>
References: <20231116173246.40458-1-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org, James Prestwood <prestwoj@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170125916304.1282598.27815217329600631.kvalo@kernel.org>
Date: Wed, 29 Nov 2023 11:59:25 +0000 (UTC)

James Prestwood <prestwoj@gmail.com> wrote:

> Broadcast action frames are needed for the Device Provisioning
> Protocol (DPP) for Presence and PKEX Exchange requests. Currently
> just ath9k has this capability so this is being enabled for
> ath10k (for at least one hardware variant).
> 
> Add a new capability flag in ath10k_hw_params to indicate support
> for receiving multicast action frames. This bit is then checked
> when configuring the RX filter and (if set) multicast action frame
> registration is enabled.
> 
> Until more hardware can be tested only the "qca6174 hw3.2" variant
> is enabling this feature.
> 
> Note: I went ahead and removed the 'changed_flags' mask operation
> since it had no effect, that parameter was not being used anywhere.
> 
> Tested-on: QCA6174 hw3.2 WLAN.RM.4.4.1-00288-
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This had a simple conflict in ath10k_configure_filter() and I fixed it in the
pending branch, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cc9f5dfd74f93ae6f596bccc3a5b92fe3f18c439

In the future please use ath.git master branch as the baseline for ath driver patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231116173246.40458-1-prestwoj@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


