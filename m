Return-Path: <linux-wireless+bounces-14456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA009AE161
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD94284F86
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107141AC8B9;
	Thu, 24 Oct 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRRDLTIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56F1714A8
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763310; cv=none; b=CYvrz/CwDpNS5/9s9ygVopf4Kb1fp6qQHpDPCgQG8NkFuFY+bgxnEyxC7099WIzIvStzYwcaqNqSebQ+02ZshR/Li6vi1yXA3GZ3g26dFr56WJc03QZxf6Xv7y3MDN8WkJruxLmBcmX9f4idY05ymCRhL34zoKjGUkD6VfuuBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763310; c=relaxed/simple;
	bh=kGeIHMWd4A1zAwUB34qoIGbCj+6EFwJ/Rf1fl0x7NB4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QGtTJc3pkt26hWCamDQFlO1wOsA9tLneX3DLOwATbwelZxOdhS1GqFUdEL4x9lNFWhyCcNqA8fxEmvCNikgBXiV3rnRGX5Bq6MhYPfTf+cwCWQ3wurx1gbqc+YFo62xktJKytC9cBH0sEqcH8KOqkaduC0b590GYP1WkSyujxs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRRDLTIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7AEC4CEC7;
	Thu, 24 Oct 2024 09:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729763309;
	bh=kGeIHMWd4A1zAwUB34qoIGbCj+6EFwJ/Rf1fl0x7NB4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QRRDLTIp2RZ4t3cPh2SbLbVa+6a1eovn7HIII4ssBKMljvaE+xxl1q+Cbj9hXv+L0
	 AV1Lc3qnMzakLnKC1V0HLckyoGnwoOaeJO0bTPtAeIvXSGq3MJJj0DxhRh7GP7Syfm
	 As6SDHca1gqkYg9SZKTEIwuPOZce6dZNDqx3DyG2UFqPm46clD6WjXwoj7iNdtgoQl
	 wxRmW1HtjYroXNjVI3yxQnldSgCvkqkjw0im6wmpMOUffYiDQbtTuKBH9tTonPPVQX
	 UwnZo3ebLXi/HhpoGL8/bvpN5rmccgnD7jnpCyrmwIvhgylHESj9lp9vFiXGfNoJDC
	 uwS1myPpD4E3Q==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] wifi: ath12k: convert tasklet to BH workqueue for CE
 interrupts
References: <20241022072406.3231450-1-quic_rajkbhag@quicinc.com>
	<d5fffc97-2603-4614-95cd-333c86435534@quicinc.com>
Date: Thu, 24 Oct 2024 12:48:25 +0300
In-Reply-To: <d5fffc97-2603-4614-95cd-333c86435534@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 10:14:34 -0700")
Message-ID: <87froln85y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/22/2024 12:24 AM, Raj Kumar Bhagat wrote:
>> Currently in Ath12k, tasklet is used to handle the BH context of CE
>> interrupts. However the tasklet is marked deprecated and has some
>> design flaws. To replace tasklets, BH workqueue support has been
>> added. BH workqueue behaves similarly to regular workqueues except
>> that the queued work items are executed in the BH context.
>> 
>> Hence, convert the tasklet to BH workqueue for handling CE interrupts
>> in the BH context.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> (Not sure how to stress-test this, but it does survive multiple rmmod/insmod
> with a Youtube video stream running)

Raj, did you notice any changes in throughput?

Passes my tests as well:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

