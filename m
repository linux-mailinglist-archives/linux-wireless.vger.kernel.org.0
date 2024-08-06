Return-Path: <linux-wireless+bounces-10995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9677E948A32
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 09:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F94FB24A73
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010B15C133;
	Tue,  6 Aug 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge9uhy4R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC10155743
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929771; cv=none; b=nLNDb1fnlah6ZUz3pbIvKXbOE72IG+oCroVruf3275A/z4IqF92wL9NPdkU7+8JO/61BvzpCbKEHuQZFjc25UPyjeOwh4CpdtqqL1L+363sKDt8m1zgeO9H70fqb0NAxzfi4BUzU5FqOF/swT/W9SoM9JVovdhzqVEF/mNcAkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929771; c=relaxed/simple;
	bh=usHbK2xOPfCQ+695UH71YEygSIeNYeS4X/a7jt9Wdrk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Bjm2/O51iPEkueb6M/hyjHEnhK+3+Ub56RDmZJ4W7VgE78UPIGzgNY4k1SbpHglenmF1kZ9PS0s7SvVHLUGsTcRIZMJS3QkUYxVarHBW0GdM47dSK8UVv1ahJs2C9VmkGk0qvIDGRrujIezecZLAkZTWJUD7VoS7UnVKmz6mZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge9uhy4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23B0C4AF09;
	Tue,  6 Aug 2024 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722929770;
	bh=usHbK2xOPfCQ+695UH71YEygSIeNYeS4X/a7jt9Wdrk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ge9uhy4RFnnE+Ea2MfaZh/W90sczlGhPvHZWAsbNMn1+4/MOhseVZnVu4XQyDy1wg
	 H2FbwXGig59Wk2EHyPf9zihkOMXGEIlbFbNA3WJpfM1edi99B6LKIqdkI52vxLcn1d
	 6vXrJoXTMuCzF9MNwQT92VRpJcezDOBhrXBf++mEVde21IspGA/ud9p8Z7yjsqPGuN
	 JHRuSm46j6hbx0XkjsCQsbOMDWadpc/x7PEAwfvuA9lDTwH/DYCjXQIBYs1q3FlTFV
	 eVsSosepgrUrBr4RqGE58Ofjs+MTevRf1uxTei1TLdTyIvgRC87EIegDGi9DXSU0P1
	 7jkAVmR7pUICA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: read country code from SMBIOS for WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230913105156.17618-1-quic_wgong@quicinc.com>
References: <20230913105156.17618-1-quic_wgong@quicinc.com>
To: Wen Gong <quic_wgong@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172292976780.3540390.9964746290162496306.kvalo@kernel.org>
Date: Tue,  6 Aug 2024 07:36:09 +0000 (UTC)

Wen Gong <quic_wgong@quicinc.com> wrote:

> This read the country code from SMBIOS and send the country code
> to firmware, firmware will indicate the regulatory domain info of the
> country code and then ath12k will use the info.
> 
> dmesg:
> [ 1242.637253] ath12k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
> [ 1242.637259] ath12k_pci 0000:02:00.0: bdf variant name not found.
> [ 1242.637261] ath12k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
> [ 1242.927543] ath12k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Dropping this now, please rebase if still needed.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230913105156.17618-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


