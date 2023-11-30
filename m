Return-Path: <linux-wireless+bounces-238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6337FF79B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 17:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2361C21132
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BFE55C1E;
	Thu, 30 Nov 2023 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mny9vh9p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94655C1D
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 16:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1E7C433CB;
	Thu, 30 Nov 2023 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701363579;
	bh=22tNHaTzJIBbBfRc7EQUN92ROgJ2k/Qfhg6/ee+vttI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Mny9vh9pXG31dN8btGwzKcZHB9kfNjwbNFFxFznSTbm+otM5Lxe8vMkmtRUxWDdKv
	 0GxCuWJu3/asQOtxGA3rx3tkt4FKhQbj+OrHG/78Nf8AL+DIocUIXt5MvmNfdh4a+u
	 WGoO7tScn7f7MgLz2dbgOsbKPK2rOHB2asgeAfXISZJVfc/m0DGO0/lx5H6IAHcPda
	 AlBvdc8FGtWSOr+u16KjahKc/39bLN7OnGSeTHPzDedgTfwP+7y87e+I1qt6Bcpdeo
	 T83tgWbkIpkgLFxMNlyoIzCD7IugSqZxofSrxNOdOPz61TGA3OsVX1gPk6myG6guBQ
	 WxJDqWZ7JNm8Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath12k: Update Qualcomm Innovation Center, Inc.
 copyrights
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231128-ath12kcopyrights-v1-1-be0b7408cbac@quicinc.com>
References: <20231128-ath12kcopyrights-v1-1-be0b7408cbac@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
 <ath11k@lists.infradead.org>, <ath10k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170136357571.1435047.9848958403770331944.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 16:59:37 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Update the copyright for all ath12k files modified on behalf of
> Qualcomm Innovation Center, Inc. in 2023.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

05205b957661 wifi: ath12k: Update Qualcomm Innovation Center, Inc. copyrights
ea77e9398b32 wifi: ath11k: Update Qualcomm Innovation Center, Inc. copyrights
b1dc0ba41431 wifi: ath10k: Update Qualcomm Innovation Center, Inc. copyrights

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231128-ath12kcopyrights-v1-1-be0b7408cbac@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


