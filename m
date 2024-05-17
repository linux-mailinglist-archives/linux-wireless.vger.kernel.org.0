Return-Path: <linux-wireless+bounces-7768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566528C811E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850851C209B8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 06:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FF814A99;
	Fri, 17 May 2024 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsPen7Af"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11B14A8D
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929042; cv=none; b=sSruBD/jAZBy9Kx/rq+m1gsK88+9N8CpSxXEU5FemMBC8HvKM9PUdN+iaqKVcw1FovlDdarhr4/xkfuEZN0khYTVLdkH4/Ybby6xy8XeXUtyIdPFOuAfQSQHS0ierbGNeQmsqoPvvpyqFIJeTaXz8t/LXRe3oojxDcldISIDLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929042; c=relaxed/simple;
	bh=WDA8FD2lgGijxh27XqYTzwf8c0PDnanf6CKK2mQJuds=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Q6eDT33yHJa1A2en7h+o1QeNSpvO7gA0vjLp93QeYOfKDMZR5Tpo+jr3Ja+FqZH0pc8kB28vL6/atS7cFDr72ch8+jY6Bq+nSOby+++YWqmPYN939oh+Yd9IC81jOFcT+dLANq+5qbhYFbD5skwytxbvuFx1f9SXmni47GMHkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsPen7Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7FEC2BD10;
	Fri, 17 May 2024 06:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715929041;
	bh=WDA8FD2lgGijxh27XqYTzwf8c0PDnanf6CKK2mQJuds=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=dsPen7AfMkuRv7H/6osZ+V1ItRq1GHa0yMGAualYKjEV6K+1hXkUTDQa3pqN7vZUE
	 lARigiQ232AoFUiJpvNrNeD+RGOFvdXRGDRkS4iSyfYLbX6ZzAPuzOGBDQV0P1lAuZ
	 xowQCuPw/AktFkJks/B9s83XcWVuaKde/XaXrmp5KxgvAFVqIqqBY6ny8Reg5Rmn+u
	 MmrTTnGVwbCkDKUvp6XWMamTeiwM7y9R3pEe8DHAKi2B/JZ2AbEjB/2UVckBs6v06b
	 F5+M9kWfUaAeOFwEZEYMKdBR7Hji9kJxfhTEPmsrrMyi3mlEYP1B0WDaaTsRRYpE1c
	 3HSbWG/umt32w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix the issue that calculation of ack
 signal
 strength
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240511030917.65811-1-quic_lingbok@quicinc.com>
References: <20240511030917.65811-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171592903908.3197586.10319031507353572437.kvalo@kernel.org>
Date: Fri, 17 May 2024 06:57:20 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> Currently, the calculation of ack signal strength is incorrect.
> 
> This is because before calculating the ack signal strength, ath12k need
> to determine whether the hardware and firmware support db2dbm. If the
> hardware and firmware support db2dbm, do not need to add noise floor,
> otherwise, need to add noise floor.
> 
> Besides, the value of ack_rssi passed by firmware to ath12k should be a
> signed number, so change its type to s8.
> 
> This patch affects QCN9274 and WCN7850 because they have the same issue.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ed61863debb2 wifi: ath12k: fix ack signal strength calculation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240511030917.65811-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


