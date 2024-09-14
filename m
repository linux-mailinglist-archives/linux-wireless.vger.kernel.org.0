Return-Path: <linux-wireless+bounces-12862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B39790A0
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7061B22A35
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Sep 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A01CEAC3;
	Sat, 14 Sep 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHcWtlco"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605624C96;
	Sat, 14 Sep 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314397; cv=none; b=OwDlgOvNMGYraSMgDiVDKj+Rm1ZOU88+XvMQus3wp+qdudhNfDz2DguA84OYX1hyQBKgXwZtDC9sN06ePO360FMjb5NiJFLu1eNbszqnHOEf3ite9h+f1EBolNneMGpScQjk6NahfVM+w46QxAuGCZPort31kMTpaNrkZLiD7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314397; c=relaxed/simple;
	bh=dddmxcbbKN61UbSqv5ZO/Fi6xeWeSevCQdpUku5tGjE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=eK8b9rgDGTrtwMwGbG3oAIcOofR/JfVnA/nNaB0R4O5AGOuIzGv/trCvhUMjTapeOcERnYCwHBCBJUaoWKvRf26IV8HatIr3lbNY+PtxXuFh5wMNoasuAL8bnJe2OCkb+kFloTTxBOXrbiL/pyrFIeP/QobjqfQp4yB2MljCsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHcWtlco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BDC4CEC0;
	Sat, 14 Sep 2024 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726314396;
	bh=dddmxcbbKN61UbSqv5ZO/Fi6xeWeSevCQdpUku5tGjE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LHcWtlco2zfmYYNeaJxg0eqQPLElbGRH1d8k2u+sBRU6QjWbLtR8KNKxMh0Yeobkd
	 Dz1xQNAfYbFM9Q/PpC9Em/+OYm077HUp4AqgUu1qsEr4oU3koGIP9wQbyvAc9+QuWP
	 /F1LKuGINbCVZIowfuooRKybM3LbzuVeUZ0EGoh/4RYD4A9JXjRVwBiJnChG0uGXrf
	 lE+wrOS7zM+jYME1dSN2Uqb9pndWceMcbzso3kTmHeG+D/O3NtHHXUWb5Q/NuAmN5j
	 cylJIZhHTcn4hiUBMq5+MdVSFKeEeVXpJDOqz1M3ohWxCv40jdvijPLcvGbi0Jks0n
	 mC5H2BSqtb1tA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: ath9k: add range check for conn_rsp_epid in
 htc_connect_service()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240909103855.68006-1-aha310510@gmail.com>
References: <20240909103855.68006-1-aha310510@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: toke@toke.dk, Sujith.Manoharan@atheros.com, senthilkumar@atheros.com,
 vasanth@atheros.com, linville@tuxdriver.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeongjun Park <aha310510@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172631439319.3042536.1475962432679276880.kvalo@kernel.org>
Date: Sat, 14 Sep 2024 11:46:34 +0000 (UTC)

Jeongjun Park <aha310510@gmail.com> wrote:

> I found the following bug in my fuzzer:
> 
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_hst.c:26:51
>   index 255 is out of range for type 'htc_endpoint [22]'
>   CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>   Workqueue: events request_firmware_work_func
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x180/0x1b0
>    __ubsan_handle_out_of_bounds+0xd4/0x130
>    htc_issue_send.constprop.0+0x20c/0x230
>    ? _raw_spin_unlock_irqrestore+0x3c/0x70
>    ath9k_wmi_cmd+0x41d/0x610
>    ? mark_held_locks+0x9f/0xe0
>    ...
> 
> Since this bug has been confirmed to be caused by insufficient verification
> of conn_rsp_epid, I think it would be appropriate to add a range check for
> conn_rsp_epid to htc_connect_service() to prevent the bug from occurring.
> 
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8619593634cb wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240909103855.68006-1-aha310510@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


