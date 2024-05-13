Return-Path: <linux-wireless+bounces-7598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96B98C431D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5968281DB3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49A15383F;
	Mon, 13 May 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp+CnAu9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2915383D;
	Mon, 13 May 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609966; cv=none; b=niBnn0IDMa61lS2D2lAg4eNNdioE3bLNUzja66XZsuUEqTVPX9sp1yjAeJaguPVCliIlZkido21V3RnebhS/yov1JPoiK4/RSRVmbY03WRgs8P/iUO/r9GEKfhx4QJlpWvs1EkoXGcItYjj+P4NKtRibZ0TBjI5c2FykyaeWgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609966; c=relaxed/simple;
	bh=Pf4Q+gCnCQVUE/TMvKBTjzV2HO0RZrZsRGNbNFuqenk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ozkBjyqzkKslzCSXzrYZaajGmXHxdP/KNykZN2uo/8YPeC4whGMHN/0hOywy8ga6ztAhsgZcG+YtUzks6poN/soPD5lYrREdLONnaCB9/a0jzK0M3fmA0HaDv6yF7wsdOvLeCCO91A2ZBelAzAOR28mOsiPQ9sI3sQ3OcXPNR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp+CnAu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27401C4AF0C;
	Mon, 13 May 2024 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609965;
	bh=Pf4Q+gCnCQVUE/TMvKBTjzV2HO0RZrZsRGNbNFuqenk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Qp+CnAu9cV1NVsPOJZrdK2r5V2/KW5LKZZ4h3j1wNWkbL1zeOGfNtY99cAXgB9Qdm
	 gkkWDYxRtB+zzxwUIcB44CKCX0YCNg7+6xnva9IBstu2ONYpO1H1BbNrV83K1U4R5m
	 XzShutYjN6avTokYFSuCunZwAjr6qRqnO1Hjox71mfDTnxU80aGXV/LY6MkloISZ73
	 ArH3fXcGeeI1LJA1XXaa4Ef5dXXF4fEJ31lA6kV4qYpllbTM8hf2DkvhrtZzcC62mn
	 L00e2sqf/0r2olLmt15a4FXC/HcB0OKs9qmJr4NudhuTVAV3UOmffxaXAIzezJk0mz
	 aL56uKufFmopQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next v2] wifi: ath12k: allocate dummy net_device
 dynamically
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240508095410.1923198-1-leitao@debian.org>
References: <20240508095410.1923198-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, Jeff Johnson <jjohnson@kernel.org>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
 ath12k@lists.infradead.org (open list:QUALCOMM ATH12K WIRELESS DRIVER),
 linux-kernel@vger.kernel.org (open list)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171560996218.1732161.18068750430706487082.kvalo@kernel.org>
Date: Mon, 13 May 2024 14:19:23 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct ath12k_ext_irq_grp by converting it
> into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
> the net_device object at ath12k_pci_ext_irq_config().
> 
> The free of the device occurs at ath12k_pci_free_ext_irq().
> 
> Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4f9206e8c2c1 wifi: ath12k: allocate dummy net_device dynamically

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240508095410.1923198-1-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


