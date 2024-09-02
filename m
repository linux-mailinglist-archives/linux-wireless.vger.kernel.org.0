Return-Path: <linux-wireless+bounces-12341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4089B968C10
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04322832E0
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240581AC8;
	Mon,  2 Sep 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9pS7vGJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27655887
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294843; cv=none; b=aRIZAfQ6W47g3GqaLlbyb/kb41fBZ1AxtrxNvI0YBn9g9/xpW9bivRt8QTNM4zX26XwB6EB/Us9DVglK8NDbsCqSBZ0MvhoYFUoRIK5n1nWCfEu583AhUYkNYlFxJ2eq9K9TYHey7rLb5TuLpE2sIZe4YxB638eWZRD0PAeC39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294843; c=relaxed/simple;
	bh=R99Yspo7qOwlFSyFpIa+UsYtg9P68MkPvx+vhVddyws=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=i1vdpgjNGrgmtosC9UH0snxyEoaxNS/WjkQHanqTpnWBLVOvaMVhMHOuByqmulxtlyJodizx/pSKk4CZbGl5FnajYOKGVBs08H+fKUXuGXS3z6kS+uzN672LW4kSJEmn07sf/7hE65YRqRJWU4BpMmenNlWW7hCKbLk71S7srtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9pS7vGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C47C4CEC2;
	Mon,  2 Sep 2024 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725294843;
	bh=R99Yspo7qOwlFSyFpIa+UsYtg9P68MkPvx+vhVddyws=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=f9pS7vGJ/o/s1cQulEoXL3o+oUI2L7M6W3+CweuibcTxV2k7ON+o7FwXFmy7TMwFk
	 Cn08IGWPbsGtf5VVx0ufHpny0cB668whEkyVHF3T5YBAocajKN7kf4i25ScnzU5b/G
	 ibrO5z3dCFYSHy71wOXACL2tVpfGR2ZXCxMETdxhBTpKooncRBuRk8qDJ38ORpP55V
	 KU/SzGvz76ThAO9fYUOnKykSbsZ875dMLR5FX2zuEc5MV9KsG2lai2Tp18c51+CPbh
	 bk/F8j+VrMFxDDU86JKvxO/UDx+6zCtnBpoojf81zKVtUWsjmvBfAEgNgsSs2P7Kl5
	 Zm2gY1PYVVLiw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH ath-current 2/2] Revert "wifi: ath11k: support
 hibernation"
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240830073420.5790-3-quic_bqiang@quicinc.com>
References: <20240830073420.5790-3-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172529484025.723394.135704024474690225.kvalo@kernel.org>
Date: Mon,  2 Sep 2024 16:34:02 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> This reverts commit 166a490f59ac10340ee5330e51c15188ce2a7f8f.
> 
> There are several reports that this commit breaks system suspend on some specific
> Lenovo platforms. Since there is no fix available, for now revert this commit
> to make suspend work again on those platforms.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219196
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2301921
> Cc: <stable@vger.kernel.org> # 6.10.x: d3e154d7776b: Revert "wifi: ath11k: restore country code during resume"
> Cc: <stable@vger.kernel.org> # 6.10.x
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

2f833e8948d6 Revert "wifi: ath11k: support hibernation"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240830073420.5790-3-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


