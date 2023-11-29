Return-Path: <linux-wireless+bounces-213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC7B7FD5A0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0062A1F20FC6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7F41CA8D;
	Wed, 29 Nov 2023 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnBUPItK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340971CA89
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 11:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5C2C433C8;
	Wed, 29 Nov 2023 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701257263;
	bh=CxhC3KPL6edIsxMs1xLty9ggRm5+698r8F21EfLaHqI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=gnBUPItKb/2k/CgXYbsieuHvMzORRgH59C+x1bm62PZH9YPK2me8Yot24fyJSjObe
	 LccgTClXfmJvhZ28GXRycfGMKRgmf4iNuz4z4KZnTk2WwARPgzfL269OtyK85Ul9+K
	 SGKZLUf3NT4sP1X93nRHa1yM1BqGao26p76AcWg9uJ/WvQZPSI4DHKyh4b3IbijP0B
	 hwQMwZE7HV+rZAx3r060qm6vaxgnkXD52kbFGiBIvniNV7LQ5jIQ89XylsqfikSu3D
	 WQPubVSL6FnHvyRG4Qm0gQGUzHx5EQds77QxVk0107A6Eu1JuJRw7ajubMoRzloKPa
	 S8A958q3y9Sgw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wifi: ath12k: avoid explicit mac id argument in
 Rxdma
 replenish
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231111043934.20485-2-quic_periyasa@quicinc.com>
References: <20231111043934.20485-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170125726059.1070846.12579198842403519575.kvalo@kernel.org>
Date: Wed, 29 Nov 2023 11:27:42 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently all Rxdma replenish callers pass zero for the mac id
> argument, so make it as zero implicitly. To optimize the rx
> data path per packet, avoid the explicit unnecessary argument
> in Rxdma replenish function.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

d281a574f133 wifi: ath12k: avoid explicit mac id argument in Rxdma replenish
d457f9fe863d wifi: ath12k: avoid explicit RBM id argument in Rxdma replenish
4d922ce983cb wifi: ath12k: avoid explicit HW conversion argument in Rxdma replenish
9f1eebf0454d wifi: ath12k: refactor DP Rxdma ring structure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231111043934.20485-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


