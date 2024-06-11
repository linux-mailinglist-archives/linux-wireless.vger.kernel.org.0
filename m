Return-Path: <linux-wireless+bounces-8806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C459043C5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387FA28C02D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0740171D8;
	Tue, 11 Jun 2024 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMN71+0e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68714A96
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130916; cv=none; b=JDjaqLaSAUBCK6xeSVCoxUgRQambPdkJF1+V4BwZmX75pV/1m5O+pEKncXSxt2p0cd7nHAgBVFSG6YWmBi9EynVxoYpdPlZ3Tcl98EqD1zRNvffe+Acqzs23RuQq7KZgKaF9dkuSd71a13wmhNbpHaCUoPRV0Hds1tRO8TcHSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130916; c=relaxed/simple;
	bh=Zpmd3ygmkPqb6iypRmQIwESFV41GHfX32oSI6YK1PGw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ZZIS1QWWSbRZif/6dgg1+MxmTxCn1QWRVonfmcuNJFfcv+e59ok9Bxk1sOfyR084fAmxaX1BN9lpETfs2ShAJzZXS++kTpu0bg7gu3SiJZWyIVi23gG+iO4zaGXZ0MYijOBkAnZ9rbCleiV0YQO1mRWHmLB3BOXvEq9ZG6aHsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMN71+0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A802C2BD10;
	Tue, 11 Jun 2024 18:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130916;
	bh=Zpmd3ygmkPqb6iypRmQIwESFV41GHfX32oSI6YK1PGw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NMN71+0ep7LW/AWi35zkUMmFEEzx7c23IIfKvJfUa1Qwb20YBPuc/VDIRIZX68JQ5
	 AOcbUppH/HPvsSxrMBrViks4wOy00n4QgU1TmvSfz+iCCzbyhLi7Ca+CsLdbmHN8Fo
	 6K+vq+hVpz6wVyiisiv9Tl5fN0Aep5WrIjI/xPpu5DuYbckPAfjlfLviaxD1f5f2Ur
	 PF2NB/8WjQgBRvoIjX8L35hpGQNEuqT/GCnLdi2pLJwA/6LDwv6kaenxDAkJnnDann
	 2cJQMWmMro9fUXDkg8PnHoBn+1wa6+ZRBGILejJPyXQObbWc+3xudsIKg+9OcVqY0c
	 XnKKOlfhqrNOg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: modify remain on channel for single wiphy
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240528082739.1226758-1-quic_ramess@quicinc.com>
References: <20240528082739.1226758-1-quic_ramess@quicinc.com>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171813091314.3564613.4590047167429779934.kvalo@kernel.org>
Date: Tue, 11 Jun 2024 18:35:14 +0000 (UTC)

Rameshkumar Sundaram <quic_ramess@quicinc.com> wrote:

> When multiple radios are advertised as a single wiphy which supports various
> bands, vdev creation for the vif is deferred until channel is assigned to it.
> If a remain on channel (RoC) request is received from mac80211, select the
> corresponding radio (ar) based on channel and create a vdev on that radio to
> initiate an RoC scan.
> 
> Note that on RoC completion this vdev is not deleted. If a new RoC/hw scan
> request is seen on that same vif for a different band the vdev will be deleted
> and created on the new radio supporting the request.
> 
> Also if the RoC scan is requested when the vdev is in started state, no
> switching to new radio is allowed and RoC request can be accepted only on
> channels within same radio.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4938ba733ee2 wifi: ath12k: modify remain on channel for single wiphy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240528082739.1226758-1-quic_ramess@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


