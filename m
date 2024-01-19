Return-Path: <linux-wireless+bounces-2269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E8832E48
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2E4B223BA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22AC55E6F;
	Fri, 19 Jan 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYAPb+Ho"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C055E66
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686000; cv=none; b=A7WzZ5FwqbbRVCHQPCgIr38OPpZXrC6Fg4vmmlFSteLX+f7L9le+nh6LB/OLqcG+zp9Vd3JLdM8M9mcCGGmpH7AqqoAz/dgci9eCdvTSr2VhmQGPeJLY5SHkToBY949ySlN1OqwR+cpHZhruiH9jApClwM09lah5/gNoqLgW7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686000; c=relaxed/simple;
	bh=2xX0/kF2sbCgX90V3nzom+K/VUjh+kDxdRC4ZgR2DFw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cqLmvDCFzfuBTSy1BgnJvmYiuMX9GYb9A32pGFcZAp5nWEt4RSCVb7U3ootjPcVz2+3tWDRvI38dPz6GDNLM5gaEkMnYts0mh4CeLjcQmJzmKMcKgjkkxmxrVaUrey2ZKGmh5ZFln0m9eQ8clw/iqY6linvUneDFyqBX7hLEZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYAPb+Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B30C433F1;
	Fri, 19 Jan 2024 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705686000;
	bh=2xX0/kF2sbCgX90V3nzom+K/VUjh+kDxdRC4ZgR2DFw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mYAPb+HoJrOTSEEcTaQEgNi0KfzH8nPrl411BoU38NqUU5o0Dne8c14HYRuMk35WW
	 iR3/GbpfOuXFvvB/YxPBR0d5hBpkBhL/pFZok5ZjOke3v9vzkQbXJMOQN7k7vyF2O8
	 JurR0iatKzptCR/jTMkSZIf64LDg46KcHlvgIrhUmkJ47t7u0HM8nLngjVgx6Tycin
	 f36eoNWeZrv7nALx/G+WHlQzIxr5GaB3yWveeTgQuWbUUFtdCnTdGsMpxaTzwSN2Ph
	 rAK55Dy0+jTkCH4CBhrkaqMtilCox3eKV+sYcSMC9LtmzgAhWbIshArlbi9k+xkHVw
	 s775jrifz2ACA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] wifi: ath12k: Refactor the mac80211 hw access from
 link/radio
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240118010320.3918136-2-quic_periyasa@quicinc.com>
References: <20240118010320.3918136-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170568599770.3232677.5051262409967677613.kvalo@kernel.org>
Date: Fri, 19 Jan 2024 17:39:59 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, mac80211 hardware accesses link/radio structure directly in
> multiple locations. Introduce helper function to avoid this direct
> access, as this change will facilitate refactoring for Multi-link
> operation support.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

b856f023b40f wifi: ath12k: Refactor the mac80211 hw access from link/radio
6db6e70a17f6 wifi: ath12k: Introduce the container for mac80211 hw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240118010320.3918136-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


