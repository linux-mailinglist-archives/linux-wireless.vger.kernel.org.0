Return-Path: <linux-wireless+bounces-1888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818682D105
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A669B20FD2
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A606323C6;
	Sun, 14 Jan 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p23S/zSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCD23C2
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jan 2024 14:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7AAC433F1;
	Sun, 14 Jan 2024 14:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705244385;
	bh=Dy5kPxsHjGqVTGPSsW4+1cdug+F9HxfM/LEsiCVjKcc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=p23S/zSFZdCksXJB7VsnADBcYzejKET70aVO9whCGItmzqxPTtUwg58ksMIaRPKQO
	 nxJDqB3dzH1+R2U/CquVTGSaSEH43OonOPl7Msos+bFmWn9E7z4iAs7VKtxiILTu91
	 R87SnOd4KhArQ2hG6KxOf3adfWfQ2YlPHDYCYRZBaFQ4hBFn3aXsmG+bdDUx/cdJw4
	 KoAVGVoCZ6+HNWk7OomD6m1dl9JhD1TUX2SqOuj72+120LQwCIeRv8W8riSnMD5sxb
	 6Y8w9fcnksCJ+zuJRn/VZEp0vpguR1YXuNTL6IKcmSj/I9b9RwVQahuzeVmzDZpAAU
	 iCEepUnOYJAmQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 01/12] wifi: ath11k: add support to select 6 GHz
 regulatory type
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231218085844.2658-2-quic_bqiang@quicinc.com>
References: <20231218085844.2658-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170524438206.1421352.5740886782222495154.kvalo@kernel.org>
Date: Sun, 14 Jan 2024 14:59:44 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> There are 3 types of regulatory rules for AP mode and 6 type for
> station mode. Add wmi_vdev_type and ieee80211_ap_reg_power to
> select the exact reg rules.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

12 patches applied to ath-next branch of ath.git, thanks.

e3d373ec4f02 wifi: ath11k: add support to select 6 GHz regulatory type
7004bdceef60 wifi: ath11k: store cur_regulatory_info for each radio
cf2df0080bd5 wifi: ath11k: fix a possible dead lock caused by ab->base_lock
17144d32e907 wifi: ath11k: update regulatory rules when interface added
1329beb56297 wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band for station
28f64d368b21 wifi: ath11k: save power spectral density(PSD) of regulatory rule
6f4e235be655 wifi: ath11k: add parse of transmit power envelope element
46f20de2c4f8 wifi: ath11k: save max transmit power in vdev start response event from firmware
92425f788fee wifi: ath11k: fill parameters for vdev set tpc power WMI command
f8a573bd5f3b wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
ed0a61dcb2d3 wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
74ef2d05ede6 wifi: ath11k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231218085844.2658-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


