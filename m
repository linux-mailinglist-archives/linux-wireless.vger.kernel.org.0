Return-Path: <linux-wireless+bounces-7277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F58BDF6B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30041C20835
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957412F2F;
	Tue,  7 May 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbHWZ9cm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BE14E2E7
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076550; cv=none; b=bm7sfPTpA1YwWSWUnBa/9uoDJasMlnHnoFdUgEShB7yoVv8LTgwSXU7qgI/y8csdMz/jLh06oGQt1EHH34tqYAKRMyNx/sZUF4v+5rZEB5fqnTKtJD6XOKzhetLGUL0tEauQUVukBUsJBlqNEkjI1mtQwP4MPmI8aBIxmuSbMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076550; c=relaxed/simple;
	bh=aC/zygQxaj+/h1z25yU/geEqMlaXbhAYUmrWO2nrIiA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=XUW76gNG/pONLx7l7uDK/2v7AyOWEb3AEaWbPdDmSv3OfhROjMqaTiEJLUAdhH9++w5SAyvgywD0utSQ1k0gypOL8afvmdwj5Er+vFATkWz/wKOBrI7TuLUEadGWkNVDS+hT2dMaadgU+7DHd1dzRxZy008vIzXxFtTavzYd8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbHWZ9cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EEAC2BBFC;
	Tue,  7 May 2024 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715076550;
	bh=aC/zygQxaj+/h1z25yU/geEqMlaXbhAYUmrWO2nrIiA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nbHWZ9cm9+ihq0txoM6ak5wOQexjTxsNnyZ44SRH7cWB3IOyADyVaFEWydXIF8ID4
	 EPt1IOZY4EIoMWuzGn9WI9nocLKbHsS48OZMG8LIfi4YuZnifAFzsTSW0uVddxiy5E
	 viMneV3yaZ2RKmpFcwo4kQp0Cqc2vBHB8cId9ip2ruPBCbtfRod7J4Ayxp8YH06b7O
	 uqID0x52ryBRMEicbLCARLUBS5j7LOWckVRSn+XqBNMFzmp4HrHBofeWgDodcVFasL
	 KOm1XYaiE93ujPoNcFbmD8mvER0sEVoN2PPKdHzPsAVRIev0PT+XcDh4CBXe6/ybJR
	 nKqr7FUwOmccQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv4 1/3] wifi: ath12k: fix calling correct function for rx
 monitor mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240430091414.2486196-2-quic_tamizhr@quicinc.com>
References: <20240430091414.2486196-2-quic_tamizhr@quicinc.com>
To: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171507654698.3827098.4687810601192996986.kvalo@kernel.org>
Date: Tue,  7 May 2024 10:09:08 +0000 (UTC)

Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> wrote:

> Currently in ath12k_dp_tx_htt_monitor_mode_ring_config()
> ath12k_dp_tx_htt_tx_monitor_mode_ring_config() function wrongly called twice.
> Fix that by calling ath12k_dp_tx_htt_rx_monitor_mode_ring_config().
> 
> Currently monitor mode is disabled in driver so the change is compile
> tested and boot sequence verified.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

9f74e7b306dc wifi: ath12k: fix calling correct function for rx monitor mode
ed07ff674509 wifi: ath12k: Remove unsupported tx monitor handling
582e94ebe230 wifi: ath12k: Remove unused tcl_*_ring configuration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240430091414.2486196-2-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


