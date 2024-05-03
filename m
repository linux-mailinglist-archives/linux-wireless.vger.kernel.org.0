Return-Path: <linux-wireless+bounces-7147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDF8BADA5
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 15:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0BC1F22568
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CCE154C10;
	Fri,  3 May 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnfHihyB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6D154BEE
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742381; cv=none; b=D485xYzqdlYyxwUvq+JCRKBETMpQhtv1hu+lXKyV5Urp9nGIBi/Zb75TNETa0wWQJ9VLCXaauK62YH4ZHqS4Q+Y8JtuUc3N3YEqO7ZraNgkRssWqfAR9hzcRJ9N3/HDFmOvE/XTPQUVCWI6zZXV3zwpztUNtI+u47aA1rfubgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742381; c=relaxed/simple;
	bh=YhI2nPikgIM3EPthNilfCEFgXjvZSSdYMEiCxwsQKvk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=OTRCPmkpESv//0jfKIDYOr0zKQR7qJ53Dg33UsMxDO/SoQcAVvkPdh8JgElnrJPsCw3ZNjR0Z+i9ONwc1JhafIZETvYprS9pM5PnptC1egsH+4GIvHhe2pd08CN/eJwqw/mU3fNR6/BcgdN1FEAFDT/HE2S+fsYMzD8O/rz4MJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnfHihyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E692C4AF19;
	Fri,  3 May 2024 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714742381;
	bh=YhI2nPikgIM3EPthNilfCEFgXjvZSSdYMEiCxwsQKvk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qnfHihyBy4lxD7Q1eNffh8MLFTHuNk60SQTrspEnwwtabiEQOBQDEobE6cGnQGbL6
	 m99Otqji446zH0emByRVGcoUsDVvFV5mv+y0W62enfKLaxkwc9jzlWVVVriTDUDgy/
	 b0Mo1SN6bj8BmYzwyxMD3g1V9vPN95E1XQr/cT02ojWhAX8fik8HSOlBg9T5OujNHv
	 25NTF0eGEqiT1+nTd+JV71UI8tY7IBkvT9HcuCUGnLi/rKhzk/mqPpQcYITd+5+dWA
	 KlUOdEiwPs9pjHNczqpAqKgta/VoBbiKXSOtTaYQvyWQvl6vg2auwdST9Vmz0rsdu0
	 C4VV9DA799Jnw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wifi: ath12k: Replace "chip" with "device" in hal
 Rx
 return buffer manager
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240430165811.1377182-2-quic_periyasa@quicinc.com>
References: <20240430165811.1377182-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171474237820.1512332.17734100406949237606.kvalo@kernel.org>
Date: Fri,  3 May 2024 13:19:40 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Prefer the term "device" over "chip". Therefore, modify the relevant terms
> in hal Rx return buffer manager to use "device" instead.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

5f6c3a418b40 wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer manager
acc6afb31c3f wifi: ath12k: Refactor idle ring descriptor setup
b2d54ca73a5a wifi: ath12k: Introduce device index
53bf4a14f8c5 wifi: ath12k: add multi device support for WBM idle ring buffer setup

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240430165811.1377182-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


