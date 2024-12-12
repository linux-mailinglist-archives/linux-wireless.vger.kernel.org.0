Return-Path: <linux-wireless+bounces-16313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA229EE908
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 15:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CB428126D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253F84D02;
	Thu, 12 Dec 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD3BtImo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38B42AA6
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014233; cv=none; b=Xs+H/Gc+ypVb0OjPNPkGVFxDI+7g8v8BjA8pMQSgvuRXDcqwtuxwlz7CmLU+50QWNBmbmkIrruGd8H0rXs5w1GRzC0Pe4Lb6AikYrQJAmClnJaSmjVvXqw6yckK+KZJEWWjsi952Cm1q/wH+rUrER3M16LUZuk7m6qEhkAKSKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014233; c=relaxed/simple;
	bh=TrXredXJ9ccEX/jcm5h1PIrzSODLA8qVGghS8P/vP8w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rFyuYoJiO34mem9aytsCRaq8oY0Ibz6qwwOaGmTYY0HOgejnIFmwswUp9vvKePTK7/IlAtsq7sMvTbM0fjwrJ0RJ6EZmBcIeFgzDdGMkczO3A6a9LGYghHDQ4yJp1YwMpPOTbhBdZqq4TYr4zNyXtQihKgn8m54K9UsKPThTQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD3BtImo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDFBC4CECE;
	Thu, 12 Dec 2024 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734014233;
	bh=TrXredXJ9ccEX/jcm5h1PIrzSODLA8qVGghS8P/vP8w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=KD3BtImocCVUg9WQNu8x07m+fc0yEDMdGScK9wtvZxw+boHG/3awcBPhXzqN6el5c
	 6lYyGFQZg6/vVsUYbOChbkCEJLiaZFNtZdgCHX7PCZwMOS3K93vz3X2SXNvyKtbGfr
	 MnC+Qh0CbpX1Hk8ZtbUsW10kO7Y1XQhAivG8vQMyVUQyxwgzS5K/fx+r1X/7CXBQ2+
	 CWYco0brGPQkPbfCJqmTxvri+pKWuERkv/bx26KyW4NPHcJ8E4aOc187KUhvzylxs1
	 o/yuVeqYXPbO/0mYelrdsmnBM/ay5HtQlYkltSM5ecLoDcBwsxkSD/TnmM7+1jaKMU
	 nXQ07O3VwvZMg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix tx power,
 max reg power update to firmware
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240909073049.3423035-1-quic_santrame@quicinc.com>
References: <20240909073049.3423035-1-quic_santrame@quicinc.com>
To: Santhosh Ramesh <quic_santrame@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
 Santhosh Ramesh <quic_santrame@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173401423043.833118.7299649308958540993.kvalo@kernel.org>
Date: Thu, 12 Dec 2024 14:37:12 +0000 (UTC)

Santhosh Ramesh <quic_santrame@quicinc.com> wrote:

> From: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> 
> Currently, when the vdev start WMI cmd is sent from host, vdev related
> parameters such as max_reg_power, max_power, and max_antenna_gain are
> multiplied by 2 before being sent to the firmware. This is incorrect
> because the firmware uses 1 dBm steps for power calculations.
> 
> This leads to incorrect power values being used in the firmware and
> radio, potentially causing incorrect behavior.
> 
> Fix the update of max_reg_power, max_power, and max_antenna_gain values
> in the ath12k_mac_vdev_start_restart function, ensuring accurate
> power settings in the firmware by sending these values as-is,
> without multiplication.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> Signed-off-by: Santhosh Ramesh <quic_santrame@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240909073049.3423035-1-quic_santrame@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


