Return-Path: <linux-wireless+bounces-9247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F019F90EF97
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 16:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214D11C20B4B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB451E520;
	Wed, 19 Jun 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXLv4D5o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5551DFCF
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805664; cv=none; b=ofWmAgQNUdaSFI71er94pjTrAm5Jl3yKLdaUJkuvOCPwdgGWcHfidoD2WrsvR/4ipsZOBO/8tQPSsFdfnU43S4dlVFqQMT8cDOKU7xgv7FFZEE0ljP4km1FCzKnuwjq6ZbzqGS0FPEDdceMvFgkgnZuvhvOMbibm6WAp11aMR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805664; c=relaxed/simple;
	bh=+tvp7aMwbkJu7Nc2OzppMWm0NdIEXv05XzZ3EDCQcts=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cOH2ecWT4/raQNOQxVCSUuFe35ZdRsjve4+mVAC52eL4L8OCvTJy7weB128nAfNF5qj8/10WkHFloXt7w7Yl2e41Fe05EfH3TPzISX9Dj1DOFudNpDcqiVD8qzY2eWyrhR/YvgGr1KtVcgSbJjKgzI8lldtoPhoaTDwHLd5WDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXLv4D5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39EAC2BBFC;
	Wed, 19 Jun 2024 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805662;
	bh=+tvp7aMwbkJu7Nc2OzppMWm0NdIEXv05XzZ3EDCQcts=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BXLv4D5o8w8bC8Qs6aKJror4di5Njyz0mYzzz7zDHVR8Xqjy+2LjJs7h59RS93dZq
	 PC758feYzGcmz244s8sxo6v1igpcx385NMGETgcBLDQPrgxrYMka2wPq14JpCGsfNm
	 spu+jG5HXl7DRzTte1s/ZvGL9Syk9SY8ComYVNA8BGOTzifc3FuP7EzeOq1NEI2icW
	 KVm43Mqi2dtJ5uFE0JADH/owjc93jp4PABQppRrkrOetuxCMpJgnxoEAmN9cpyqwJ1
	 477dIaV+mACOcUUQqnUj9xbsnPiXxJOUz0b1Yqwk+AUP0BpMQwPSsbEakwTX+Fik9V
	 hSX2b9wAg3jrQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: fix NULL pointer access in
 ath12k_mac_op_get_survey()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240611031017.297927-2-quic_aarasahu@quicinc.com>
References: <20240611031017.297927-2-quic_aarasahu@quicinc.com>
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171880566024.581414.8009521836659162267.kvalo@kernel.org>
Date: Wed, 19 Jun 2024 14:01:01 +0000 (UTC)

Aaradhana Sahu <quic_aarasahu@quicinc.com> wrote:

> Smatch throws below error
> 
> drivers/net/wireless/ath/ath12k/mac.c:8318 ath12k_mac_op_get_survey() error: we previously assumed 'sband' could be null
> 
> Currently, we access sband inside the null check of the sband
> in ath12k_mac_op_get_survey().
> 
> Fix this issue by removing the entire if block, because decrement
> idx is unnecessary since there are no more band to test.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 70e3be54bbdd ("wifi: ath12k: fix survey dump collection in 6 GHz")
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

59ca26c9a6e8 wifi: ath12k: fix NULL pointer access in ath12k_mac_op_get_survey()
19b77e7c656a wifi: ath12k: fix uninitialize symbol error on ath12k_peer_assoc_h_he()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240611031017.297927-2-quic_aarasahu@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


