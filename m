Return-Path: <linux-wireless+bounces-2369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5F838A5C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 10:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49801C23460
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3A59B54;
	Tue, 23 Jan 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY2uuySA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889159B4C
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002377; cv=none; b=JhX2JLn+yR4NKYDB2TmUOHWUYek+ywIQKZGAWyARUbYYcSwfys9tsWkD2qx4JZwsUnooETXj54axEhXcpPIlmnLIb7pQXDwD2nhyT3uxLSXTcUAbpZzDdLPRNDP5K2S+O9fCwUfdm4rWxSfG2vaopGm1QWthC52ZTSUUZ7PcI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002377; c=relaxed/simple;
	bh=HwDo0qMM5rmS7Ioy8zXu0yj4NxvXalYI+ptN1DCfQL8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TphHhQ4F/t9ool+tNog+fvJ27vFB/ZwPjSvAphHYN+1n1SuGGi1vRJD4kNMHafBcS7WzE32AeO4/ooNY9sca21efnAnC1bRhn13AUh649zjyAt02cTG5/7tipW/7yCJnIk3zwLNvcpiGh6/6DGYaQ/2qwET+AandQzz5dizVgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY2uuySA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63E0C43390;
	Tue, 23 Jan 2024 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706002376;
	bh=HwDo0qMM5rmS7Ioy8zXu0yj4NxvXalYI+ptN1DCfQL8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=gY2uuySA6EmCungLnDHpui2vUEf4nuZzbda3AW7Nc+45uYdkLRAWmLaCb3H09wlnw
	 Cbh7zMD6F9u1ZmM6DHep9Txu9j8rRdR5qxIVnCTEKUuhuh/ne5+vzoSuhc814ZFBLk
	 PeRrfmYHf4fVtknwls817JCBQmBsWQYUXfAt6VZiFrQQzxDHp47w9cTuaH9dXm5G6M
	 T/GDkqmB5Xa+5QGDVCePNUyNp6TYCG6drJFYa0Gx3RR7iF3fLoPwuAwsflWtVb+WN7
	 YAQvFZcpS/yHey+9Qcabb2xoVObz3/s87KgGzTBwnYsPzAFK9HBBlEBDsHZxoaCfwx
	 vQMxYX2HrGzSg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Fix issues in channel list update
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240117062628.8260-1-quic_srirrama@quicinc.com>
References: <20240117062628.8260-1-quic_srirrama@quicinc.com>
To: Sriram R <quic_srirrama@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Sriram R <quic_srirrama@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170600237376.3897582.9674673785656987739.kvalo@kernel.org>
Date: Tue, 23 Jan 2024 09:32:55 +0000 (UTC)

Sriram R <quic_srirrama@quicinc.com> wrote:

> Currently, the logic used to select the 6 GHz band is incorrect,
> which may cause 6 GHz supported channels to not be updated properly.
> This is because the 6 GHz max frequency supported by the driver is
> being compared to the max frequency supported on the board. If in
> some cases, the 6 GHz max frequency supported on the board is less
> than the defined 6 GHz max frequency, all 6 GHz channels are disabled.
> To address this, compare the max frequency supported by the board to
> the defined 6 GHz minimum frequency by the driver.
> 
> Similarly, when a dual mac card supports both 6 GHz and 5 GHz radios,
> if the 5 GHz radio gets enumerated first before 6 GHz, the checks in
> ath12k_mac_setup_channels_rates() can cause the 5 GHz channels which
> were enabled earlier to get disabled when the 6 GHz channel list is
> updated. This is because the min 6 GHz frequency defined in the driver
> is 5945 MHz, which should be 5925 MHz since channel 2 is not considered
> currently, but the firmware can pass 5925 MHz as the minimum.
> Hence, update the min frequency supported by the driver to 5925 MHz.
> 
> In addition, ensure that the channel list update to firmware updates
> only the channels that the current radio (ar) supports rather than
> considering the wiphy support. This would be required when multiple pdevs
> are supported in a wiphy and they support different ranges of frequencies
> or bands as in single wiphy support.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

I did because it looks odd for me that these are capitalised (could be wrong though):

s/Min/min/
s/Max/max/

Jeff, what do you think about that the patch and my changes?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240117062628.8260-1-quic_srirrama@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


