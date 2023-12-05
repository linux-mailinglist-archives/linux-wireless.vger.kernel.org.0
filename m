Return-Path: <linux-wireless+bounces-427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320B8805847
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA031F2123A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87A67E8F;
	Tue,  5 Dec 2023 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBgvafm4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85C2A1C0
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 15:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BB1C433C8;
	Tue,  5 Dec 2023 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701789056;
	bh=UD1uFP5QSngCrjzcxllTOb3luCX1xPpvYA27sT27aEg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=JBgvafm4xgGBbIS3PqP7Vw/PO+b3oLeNq+l2yYXnSXkbvrp969GW8TPXFlqadqahC
	 ZC4zXN/KMRLyMlIcBD0M70822AgzcEV3VG42qVMXSzAS5mmPtOPBHu/qUtUObmMqmU
	 0bqc2vUbKx9eyLLbLhsHoB9jUVkXwrm+Ec6XeFyFpwVgY5v2poMv4Y/PrW35TR5AAX
	 jekwj5Ct7IG93OzXj4tKSMzpaiLzRK1a6lnXj0kgz+tStkTWZ+attq/pcf42uGuDBy
	 ws4Hg/sXm6njg+PMYDTbD2R5k1jMVwHiCCKizPetRW0jkBu9k3bcb4UaJnwycMnoFh
	 zyJL8PvWdPcDw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: avoid repeated wiphy access from hw
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231201013735.2292313-1-quic_periyasa@quicinc.com>
References: <20231201013735.2292313-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170178905353.2418939.13490196335421003398.kvalo@kernel.org>
Date: Tue,  5 Dec 2023 15:10:55 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently repeated access of wiphy data from mac80211 hw structure is
> happen inside the mac80211 registration helper functions. So optimize
> these helper functions by storing wiphy data locally and accessing it
> directly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c8a5f34ad811 wifi: ath12k: avoid repeated wiphy access from hw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231201013735.2292313-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


