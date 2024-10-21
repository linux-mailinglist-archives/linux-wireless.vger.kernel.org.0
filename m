Return-Path: <linux-wireless+bounces-14251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C889A5FAA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 11:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED481F221B4
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA11E25E6;
	Mon, 21 Oct 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2LO2f7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF721E0B91;
	Mon, 21 Oct 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501602; cv=none; b=Lbwpvd11P0SxFGd/vLahCujENH/xlvEAKSFxSFUyIZg7gQl1ynNwowEbJftFqeLlagDRdkEbYZfcIGeGMb7qr26yA7jaWphOr/EcdMNWrJYa3wXbyxY5IoiNf02BPOnREFoHcI0OyGY9pS5JA4fB5O85sDNnwuehYBBZJunN8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501602; c=relaxed/simple;
	bh=+ZMNc1CMzmELhjMB7j/skx2+yKwY4xJ6OUJftzt0FZA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Wc5yCCmeYeboMz+/CqO3dr9HsSjslRkHFgmNnFenWRiHX3QSXtzUr79isyVDJzWaejozcnSnJy63Yxx4U6zrb4OlS/Bat5p02OoPQN2137/br7ECUVGxL0MF92iLTKOSE3QsfmEcChcVV+6xoEJbzwitsivKn128ox/u9Cum3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2LO2f7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94912C4CEC3;
	Mon, 21 Oct 2024 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729501602;
	bh=+ZMNc1CMzmELhjMB7j/skx2+yKwY4xJ6OUJftzt0FZA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=l2LO2f7CuDmW1chxODWB1XEmOgaTtTbOnvzYwSwMTRYvFNlPbhSYMidmE8Kbzfest
	 2qrf9PcLNYyKn0qTAmYqKw9f7qCE06P562Wt2SoV2hekNOd9+AZsbkBuMFhZDFXgR8
	 zaeWA+WWA2+IhkT8HzpJYInm26OtrxDQRpI8Inn8mA/668VSfU4CLjpnURsaYQAT4R
	 /yjKJ8ZFn6I1QMqZ3z8cOyxU8vQUFSwmIJB/tgsgm7H1tf8WiC+rXau24VgoPXHmun
	 iEu8W0lg5dN3DSLjW4ch47xsApsQqk+kInjGXec3J+AzeUqU5mgRLMCqvmNFibyy0l
	 P/TlCqlt9h6Ug==
From: Kalle Valo <kvalo@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  "Rob
 Herring" <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  "Conor Dooley" <conor+dt@kernel.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  "Bjorn Andersson" <andersson@kernel.org>,  Konrad
 Dybcio <konradybcio@kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 16/22] wifi: ath12k: convert tasklet to BH workqueue
 for CE interrupts
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
	<20241015182637.955753-17-quic_rajkbhag@quicinc.com>
Date: Mon, 21 Oct 2024 12:06:37 +0300
In-Reply-To: <20241015182637.955753-17-quic_rajkbhag@quicinc.com> (Raj Kumar
	Bhagat's message of "Tue, 15 Oct 2024 23:56:31 +0530")
Message-ID: <877ca1q0yq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> Currently in Ath12k, tasklet is used to handle the BH context of CE
> interrupts. However the tasklet is marked deprecated and has some
> design flaws. To replace tasklets, BH workqueue support has been
> added. BH workqueue behaves similarly to regular workqueues except
> that the queued work items are executed in the BH context.
>
> Hence, convert the tasklet to BH workqueue for handling CE interrupts
> in the BH context.
>
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

22 patches is a lot and I'm not going to look at this in detail, please
reduce your patchset size. 10-12 patches is recommended. For example,
this could be easily submitted separately.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

