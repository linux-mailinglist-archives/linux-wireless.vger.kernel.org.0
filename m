Return-Path: <linux-wireless+bounces-16306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD609EE4F7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 12:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126B1282117
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0322116EE;
	Thu, 12 Dec 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3E0Ju/F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7F211475;
	Thu, 12 Dec 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002812; cv=none; b=MlkQbHwLIKfpH/hIext4wFnL8FhKauPf4yydXsERxG4wX/DHjXWWKw2rziqCIjeZbVJ9miqhGVkN+Dx9hp4Ljapa8cwWpXAkJ4wmCaFnLrd1NO5/Xjvjmd9WsG/CTDHDtt2j95nJ/75R5aimecWy9TEPYOMXN1jlg7nkTsI8zcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002812; c=relaxed/simple;
	bh=pccqLc7i82mC3GgYKCrj2ARpPSBFqcYNm0iJ15hvcbI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=e1Omks5d2T3RefP8cvVJndg0rfH+uIX/g92apN4EZf0ewIFaN0MyWL5dTOUb5TJjCvA3FKZl2awekVgbgRiMDiVq16lnMDtsA1QK51V2c7WmSUe2u4BkMhwTdgDgf8cgzgWO06lbYE2KTE4fu9ZRQTMfBNl4S0GH9v3B3jFaUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3E0Ju/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2314DC4CED1;
	Thu, 12 Dec 2024 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734002812;
	bh=pccqLc7i82mC3GgYKCrj2ARpPSBFqcYNm0iJ15hvcbI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=q3E0Ju/FLqCDCHdnrqHsakSbX2yXQkkroxiPNSrAX09m54+Y4bVYJUGoeA9VQ3pru
	 FMSBXhBydUMzZAXhRmSCCH1HX2t95NsmPTCdJ2uwz+pHsDABdypJcqNmdqqFj/lGjA
	 7m0wMbKAcDloLvlfaIezjIx3G1gFZ6WyGhQkIH48l1VwbgaJ0vBd90l3JLriLNXBmd
	 PaNSXMvR4v3MGrGVLlGlzQtim+kwiDkAyApJXYclg2ZFFQQ+wsCfcVbmqrOXV5QUnO
	 5c88ZtrAExlX78JsSQZzlKd/xNZMdr4+k8VZqS6US55+a1bT0EeGueznqjWl31S1uH
	 ol87nF3PwRC3w==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  Rameshkumar Sundaram
 <quic_ramess@quicinc.com>,  Sriram R <quic_srirrama@quicinc.com>,  Kalle
 Valo <quic_kvalo@quicinc.com>,  Jeff Johnson <quic_jjohnson@quicinc.com>,
  <linux-wireless@vger.kernel.org>,  <ath12k@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fix read pointer after free in
 ath12k_mac_assign_vif_to_vdev()
References: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com>
Date: Thu, 12 Dec 2024 13:26:48 +0200
In-Reply-To: <20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com> (Aditya
	Kumar Singh's message of "Tue, 10 Dec 2024 10:56:33 +0530")
Message-ID: <87bjxhp2fb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> In ath12k_mac_assign_vif_to_vdev(), if arvif is created on a different
> radio, it gets deleted from that radio through a call to
> ath12k_mac_unassign_link_vif(). This action frees the arvif pointer.
> Subsequently, there is a check involving arvif, which will result in a
> read-after-free scenario.
>
> Fix this by moving this check after arvif is again assigned via call to
> ath12k_mac_assign_link_vif().
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1636423
> Fixes: b5068bc9180d ("wifi: ath12k: Cache vdev configs before vdev create")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

