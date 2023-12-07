Return-Path: <linux-wireless+bounces-532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7C808545
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 11:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C52E283E59
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8575935880;
	Thu,  7 Dec 2023 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRYE2zR/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD01947A
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 10:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD73C433C7;
	Thu,  7 Dec 2023 10:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701944102;
	bh=CoocNPMxb5l2JDMtf5l5zf7IC/mqD3P/6n0Xazwr1is=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lRYE2zR/liTILBhdYwRBc4/wQnLuAEZUUHf1FqeptdvGqXECeHJZJmrryITcX4i3z
	 Llk8YnKHsYfnLrDE2KbSJ6b0BlHYte1B48CIQQlod9TSXLjp3FUvUryRZsjLB/3kDQ
	 /0EvtotXPHJxWacYoX+B+8sC9W6Skx0+76m/z3tstkJyHuQGItrDINcWGIYZrag1YW
	 yhciBDW/++DhkQp3OLc+qA3EJRlIup6l0VueQDt/DHLDwKHZrT13uH8zo9wh/zeAFw
	 38ZHJnJhnbyAKnFr2zNngMv9kDTxFIBQno4bTWkfgeXmhLqSImTKUJ0/TfdM8NCezx
	 lR/JEQA0YISXg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: add support to allow broadcast action
 frame
 RX
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231116173246.40458-1-prestwoj@gmail.com>
References: <20231116173246.40458-1-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org, James Prestwood <prestwoj@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170194410003.2678961.4711724197337230129.kvalo@kernel.org>
Date: Thu,  7 Dec 2023 10:15:01 +0000 (UTC)

James Prestwood <prestwoj@gmail.com> wrote:

> Broadcast action frames are needed for the Device Provisioning
> Protocol (DPP) for Presence and PKEX Exchange requests. Currently
> just ath9k has this capability so this is being enabled for
> ath10k (for at least one hardware variant).
> 
> Add a new capability flag in ath10k_hw_params to indicate support
> for receiving multicast action frames. This bit is then checked
> when configuring the RX filter and (if set) multicast action frame
> registration is enabled.
> 
> Until more hardware can be tested only the "qca6174 hw3.2" variant
> is enabling this feature.
> 
> Note: I went ahead and removed the 'changed_flags' mask operation
> since it had no effect, that parameter was not being used anywhere.
> 
> Tested-on: QCA6174 hw3.2 WLAN.RM.4.4.1-00288-
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

63b896629353 wifi: ath10k: add support to allow broadcast action frame RX

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231116173246.40458-1-prestwoj@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


