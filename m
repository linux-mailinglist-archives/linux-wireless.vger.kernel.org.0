Return-Path: <linux-wireless+bounces-9611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2831B918617
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8510AB20342
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDC718A935;
	Wed, 26 Jun 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5p64JE5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15AA92F
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416518; cv=none; b=oP5MVRZSBppgEPalg27Huq1WoRHn830Eho7ATJyM4EA8iItanjKKPJLsx1bSbfblnVv6xI5gZUflxDK8turXe3ruQIjD4Enw6PJydS9Q8zSkCb9Z3bkMen6D0Dg3qUbx8/cubQmgX1llPHhJzEnTSiFEJS+6NXD0YzJCnz+gQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416518; c=relaxed/simple;
	bh=U3zPUmPwStP/4jvwruoRXcg0ehbADGhwirCpV0MeysM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cZ6e4eOeRUs3lkN0SimpyhSUmLzAaSjBlLimtNwQPVn7UtNTn5Z+qAhXLbbXS43x92G38AC5F4zXx9QMgu5ZAR2ZzVzvHWOBxoLIdrw3IF7KibyCMBi/YuC8gN5upBITVhTO+wBM5eMVhuP8MeRuNT9LzLZiKfcplJRaOZjxXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5p64JE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A79FC116B1;
	Wed, 26 Jun 2024 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719416518;
	bh=U3zPUmPwStP/4jvwruoRXcg0ehbADGhwirCpV0MeysM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=U5p64JE5pAQZYEaQyXYA8BUGWQu3rg+BzYaMOAjQ0EbZRNBOdblQ0gqBHPOX+uN8A
	 7tBJWdNL9Q8Ll/CUpopchwbmyQXKpOb+BoE6cCwjEVdnyNwwSgwfRnyryrj9QLHlq3
	 SenAnMAGd8wxEQYPufNQJzs97l+/DaX+ZuZsVWmrTryxXIu5VP2n1hH2XADg5sxKyj
	 E/ZQRW1ya8MhoaH1Xd88Wkz/Xm514g0Q7aRmPk6UjfxSquLZoqSKoSY9Oyvk8uFmda
	 KBEC0tKoEUjLQFNyMCMYpxRJCIBxQqAICAhAFblJh4iFxfLLliXlPCk1Q/3ae7bli+
	 EEm/ouDdVec+A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: Fix pdev id sent to firmware for single
 phy
 devices
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240621102809.3984004-1-quic_rgnanase@quicinc.com>
References: <20240621102809.3984004-1-quic_rgnanase@quicinc.com>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Lingbo Kong <quic_lingbok@quicinc.com>,
 Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171941651550.1568703.13692158978977489041.kvalo@kernel.org>
Date: Wed, 26 Jun 2024 15:41:57 +0000 (UTC)

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> Pdev id from mac phy capabilities will be sent as a part of
> HTT/WMI command to firmware. This causes issue with single pdev
> devices where firmware does not respond to the WMI/HTT request
> sent from host.
> 
> For single pdev devices firmware expects pdev id as 1 for 5 GHz/6 GHz
> phy and 2 for 2 GHz band. Add wrapper ath12k_mac_get_target_pdev_id()
> to help fetch right pdev for single pdev devices.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2c7857677d69 wifi: ath12k: Fix pdev id sent to firmware for single phy devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240621102809.3984004-1-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


