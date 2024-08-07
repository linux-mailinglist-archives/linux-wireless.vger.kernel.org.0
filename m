Return-Path: <linux-wireless+bounces-11068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B45694A266
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A4D1F23DF3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95819A28F;
	Wed,  7 Aug 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX1CswZC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82832868D
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018191; cv=none; b=pSHnbusVSTV1+9QIoINIm+obL4xO1IhpI2bPbKQMaV3wAwpO4SM1HrPWYAFbtHxwBDyc0+1yjz4LaIfPMYHfrvBJyEK202JBugX5mlWRn4T8G6KKGT6iJKZIKluQlmEanQScrUB2WIR/HZIkm+JugqqKVutsFuJhNRVm4wL6BMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018191; c=relaxed/simple;
	bh=udMylYuK8HYXdKoGhrjwWETQV3x2IYojbCwCuoIuW8E=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UeUie7Sm/UdXkRI/v+dnQYxjcSi4CCIklQFqRMm5qISZa+QqCd5bTg9V3lbEvb7xEbnAQJDn9NWOJNzfjBGe15Ti3HHFOgkosHTcbOGqWysazQRjshfOlhJBe4ub2msRv58Bp37oLGJ8UlWN+00PPWy/NEyyIhQCGod7GTBgyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX1CswZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA98C32782;
	Wed,  7 Aug 2024 08:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723018190;
	bh=udMylYuK8HYXdKoGhrjwWETQV3x2IYojbCwCuoIuW8E=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=VX1CswZC+CBZs/Im/HFRDf85cQOPfdL9DycPI0/mWqS46tsdam6eeXDEgRV3v63d0
	 HFVQvYXTW9AMsJQTdyPj93j3Kz+jJ7yGNJu3IJA8B4Xv1IJXZNCcXcB8qzx08PYixn
	 9r6Zs941ZdBlUE+pu/esW1kgxQ0sAcgH3SIOTcpAkHnMatSVJMG1Z9JScUc3p8WzrQ
	 mx2lBSt6yYLBnYxaznoX3OhHBJsDcpgqhyCUIRIHkTciK1uM2lm9j+N+gYszcjWfW2
	 OxvEpkxfFePyxzXhC60rND9hQG0nvf49bUuZRo4R2sviUjT9mPH77joOkNwuoQSsvc
	 3w4Toe2JbR7lg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: restore ASPM for supported hardwares only
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240709055817.3371406-1-quic_adisi@quicinc.com>
References: <20240709055817.3371406-1-quic_adisi@quicinc.com>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Aditya Kumar Singh
	<quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172301818779.3837211.5023880648651887884.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 08:09:49 +0000 (UTC)

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> During PCI based hardware device start up, ASPM is disabled for all. And
> once firmware is ready, it is restored back. However, not all hardwares
> (for example QCN9274) supports ASPM. Hence there is a need to conditionally
> restore ASPM back. Or else, for such hardwares, issue can be seen during
> sending and receiving packets.
> 
> Introduce a new hardware param supports_aspm which identifies whether a
> given hardware supports ASPM or not and then accordingly restore it.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8be12629b428 wifi: ath12k: restore ASPM for supported hardwares only

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240709055817.3371406-1-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


