Return-Path: <linux-wireless+bounces-4964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5A880F4D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11D9B22024
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FE63D566;
	Wed, 20 Mar 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuot2mC3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7A3D551
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929227; cv=none; b=ZV54LApaEMqAFl8IZNtZacy6h/IN6rCs/nLyQJl/nGW581SfxRljxrp3uxBkw+CJfMWYfllrNKlVQaL5w72FCYTPooN5OFr9QCXfqiTZHSaDk+DuXRvFCrT15WcRiamILOZL3Lhc//qEHj8nkaLD2XKEx/DN2733mzoHi45KDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929227; c=relaxed/simple;
	bh=VE+Bn/r+0jrIyjgwGAHCLncsj+C7cRWTvnPM0hKnwfk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Cn6t0S3Sb2FojwZh5g73Yi5yPLuZLtsW5mYUG1R8GaDZZfYw8VRbOMzWziPnf0dCHG0WiucDHeuySGAWBEu49OOylJtWfIVmFIokyRr0MgbTWJUdTg3hC4NFyw6bqbasYLTHCV8U0eBnP6m3bmPzs9l1LmMvnSUuh1wOLWTknpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuot2mC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2F4C433F1;
	Wed, 20 Mar 2024 10:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710929226;
	bh=VE+Bn/r+0jrIyjgwGAHCLncsj+C7cRWTvnPM0hKnwfk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fuot2mC3mvly6w87G88zx7YZVWyjr5xzPcvSiVdPDVmxmzOHM+H2ccpXRzxmoNHCb
	 OeTtRLyKtrI4H+NCQkpb+vWjT9yD7KQ96D+mFfM2tSwn3VWAVyaMOq/WSTDyyBvCCa
	 gsVRa3rx+/7z1KO6IBU9Bp8NsuFclEONahIB9/QKqZfR3XSqqbMxfQkQkvpdIsGz/i
	 3tRTInZ1pL1gPOB/v+C4QvNolKX1JYPqvIiBtfIDy4uAYYXEpefBcztP2VGUpp0eEA
	 NpZgyHC7JqBOr5m4MoIHaBX5srixbuyQRWiYyTtaUjIhbOxygYjfM0+IjFEJkNKfiY
	 bEMR7aWOn7kgw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: fix desc address calculation in wbm tx
 completion
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240311180708.9334-1-quic_tmariyap@quicinc.com>
References: <20240311180708.9334-1-quic_tmariyap@quicinc.com>
To: quic_tmariyap@quicinc.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171092922417.3054175.16453288096112928412.kvalo@kernel.org>
Date: Wed, 20 Mar 2024 10:07:05 +0000 (UTC)

quic_tmariyap@quicinc.com wrote:

> In tx completion, status desc is obtained from offsetting the address
> from wbm ring. Having HTT_TX_WBM_COMP_STATUS_OFFSET(8) and reserved 8
> bytes in status desc offsets the address twice and read the values
> from the incorrect address. Hence, remove the
> HTT_TX_WBM_COMP_STATUS_OFFSET from wbm completion address calculation.
> 
> Also this patch is applicable for WCN7850.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a49732b1f1f8 wifi: ath12k: fix desc address calculation in wbm tx completion

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240311180708.9334-1-quic_tmariyap@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


