Return-Path: <linux-wireless+bounces-8858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2F790520C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2A51F288A8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739A374D3;
	Wed, 12 Jun 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiKHMZah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C47152DF1
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194001; cv=none; b=GlBOGkEi+o8c2w281TR8zN2GSIXoOJeL1/pUC9EkcfIcCtbLw+1yw9gGwAjzUz+JGqvyZW4qvpcLYyqugh+QCMMUtAT6P6YrlG6ErkXIJkcX9nG6Rz9FOfW5+9pG8gJ9QighnNod6UITxoYIn3diTWCZcb3f7nLmnE+rGTMHHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194001; c=relaxed/simple;
	bh=00vPD93kJUmCxjtL2ZOh+LvycvFt+ZvpgyuiE6ZabKY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=W8kWfBGoHpT5DFrWR2tbrvWmWKMpubH1pHuWH3QJ2l2UlgnNVruW8rprAMgWSUQ4+YZpy00CIbPS1AnIkIdbAIjxNTyAbyONGX9OYE5RBgHCJRv1BBh+zSn64tg+d58xBSkKQKntzRcEq2gbqfGPBUToeo6pMiNcLWTF89Wtx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiKHMZah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EC7C3277B;
	Wed, 12 Jun 2024 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718194001;
	bh=00vPD93kJUmCxjtL2ZOh+LvycvFt+ZvpgyuiE6ZabKY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WiKHMZahjCve3aSq319O0D33gyjCeRSaZzbLIOthnjgXxVm0HSOLJ/NUddAw1JeAl
	 AWa4c2/Z8QqThEAbE38lJBRbeQpuiIbmBpgjcJAdcNAV3fXk3tmweBO96klwUwoFis
	 qnat3AzWJuOoVwGIqkrEPRc58utr0iHEt8dFyh/LclTDulDf5MYBGK+vTndm3jFx5v
	 Xug4J9qLzTTmvq8hzUl3m7ijI/2+XLsPjWBOyuSCY9W2/bdAkLXTDaSeuChZ3WCGw4
	 eq0aAH7jf2UjA/pu63MrBalbNSiFCnH8bMbttXEHDJ5uHOX30IWL4RO5A4/KF9mAQo
	 jj5jzlKunt4Ww==
From: Kalle Valo <kvalo@kernel.org>
To: <andrea.marcer@external.marelli.com>
Cc: <quic_rajkbhag@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <quic_gsaminat@quicinc.com>,
  <Dennis.Damore@marelli.com>,  <danilo.sabato@external.marelli.com>,
  <giovanni.ciaramitaro@external.marelli.com>
Subject: Re: [PATCH v4 0/4] ath11k: factory test mode support
References: <TYZPR02MB7247209AEA8B450DB501972ACDC02@TYZPR02MB7247.apcprd02.prod.outlook.com>
Date: Wed, 12 Jun 2024 15:06:37 +0300
In-Reply-To: <TYZPR02MB7247209AEA8B450DB501972ACDC02@TYZPR02MB7247.apcprd02.prod.outlook.com>
	(andrea marcer's message of "Wed, 12 Jun 2024 11:46:55 +0000")
Message-ID: <87r0d2nz5e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<andrea.marcer@external.marelli.com> writes:

>> Device is booted in factory test mode to calibrate the board.
>> The commands are sent from a userspace application, which is
>> sent to firmware using wmi commands. Firmware will send the
>> response back to the application which stores the calibration
>> data in caldata.bin file. This file will be loaded when the
>> device boots up normally next time.
>
> I would like to calibrate and generate test signals on a QCN9074 
> chip using the factory test mode. Which userspace application 
> am I supposed to use to perform the calibration and tests?
>
> QCN9074 PCI WLAN.HK.2.5.0.1-03982-QCAHKSWPL_SILICONZ-3 
> Linux Kernel 6.1

To my knowledge there are no calibration tools publically available,
unfortunately.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

