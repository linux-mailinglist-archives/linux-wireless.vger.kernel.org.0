Return-Path: <linux-wireless+bounces-6649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F8E8ACC77
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4048B2848F8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7430E1465AB;
	Mon, 22 Apr 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+o+JEF+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50815524A0
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787682; cv=none; b=aR+x4Aiiexsz7xr2KIiMptQIqSlh+fhqJI67/6NasWQIfEjk+HXChjUBVuitHtDvECEzUvQgPrB4hJMM2RznxdpaItR9PwEOfqlmmxrstNhhOPrejt7kIcGRxFSii6s7/Q6rLXPzPNksVshpLoWNOaTfytlKKxDSPsVNTTjRBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787682; c=relaxed/simple;
	bh=4teQusw/frW2YkbHTwRL4Zs5nlti7cBw2MbjQWXL43Q=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rfukIoFNXPPZv89ZYbhBcNcgENIKFiReALhzv8On+EjAjVQwiFtwhBsBC6nFzoucM+JvTXgwqUiE8DNA8tc6hpubFa5dQGkBkzcQNLUK33NiXDoUIiLxFext972bRjZLOeGMVqCESp4nlZVW/9EJs130ZEq9VZEvUHkvAMlCTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+o+JEF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0378AC113CC;
	Mon, 22 Apr 2024 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713787682;
	bh=4teQusw/frW2YkbHTwRL4Zs5nlti7cBw2MbjQWXL43Q=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=c+o+JEF+3fzKamn3fQhCChUNlKOCshpHiTrfcZS+kwGlIV3KtPZ57Q/+5FpGQKZBE
	 035KBuEiB9838PXbYhiWzKc1ZIm0WU5o7OZ4K+uzm+oGWXzu4MYqGqc3zor+wfWHhS
	 UJfcOFl9hY1oSeygccxbzT8edDPuiEBeAdo7qqqpBq41Ze0P3lkH6t2zDj90AUaMX3
	 D0eKyIJGCYoe6C2TMy9opfYsTYt1vzqUexOU1SsQIpRaDtPGgPaI9SqC8AsDH4/HGf
	 gwJ586J1+HhZmCV36NHg6vAvioMYa3D1s9ipolRRZPuGQVPmiQOoZv/1lzffCm8Zcj
	 e44vUc0sVFZTQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: fix out-of-bound access of
 qmi_invoke_handler()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240416080234.2882725-1-quic_kathirve@quicinc.com>
References: <20240416080234.2882725-1-quic_kathirve@quicinc.com>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171378767925.1358009.1322280791259157852.kvalo@kernel.org>
Date: Mon, 22 Apr 2024 12:08:00 +0000 (UTC)

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> Currently, there is no terminator entry for ath12k_qmi_msg_handlers hence
> facing below KASAN warning,
> 
>  ==================================================================
>  BUG: KASAN: global-out-of-bounds in qmi_invoke_handler+0xa4/0x148
>  Read of size 8 at addr ffffffd00a6428d8 by task kworker/u8:2/1273
> 
>  CPU: 0 PID: 1273 Comm: kworker/u8:2 Not tainted 5.4.213 #0
>  Workqueue: qmi_msg_handler qmi_data_ready_work
>  Call trace:
>   dump_backtrace+0x0/0x20c
>   show_stack+0x14/0x1c
>   dump_stack+0xe0/0x138
>   print_address_description.isra.5+0x30/0x330
>   __kasan_report+0x16c/0x1bc
>   kasan_report+0xc/0x14
>   __asan_load8+0xa8/0xb0
>   qmi_invoke_handler+0xa4/0x148
>   qmi_handle_message+0x18c/0x1bc
>   qmi_data_ready_work+0x4ec/0x528
>   process_one_work+0x2c0/0x440
>   worker_thread+0x324/0x4b8
>   kthread+0x210/0x228
>   ret_from_fork+0x10/0x18
> 
>  The address belongs to the variable:
>   ath12k_mac_mon_status_filter_default+0x4bd8/0xfffffffffffe2300 [ath12k]
>  [...]
>  ==================================================================
> 
> Add a dummy terminator entry at the end to assist the qmi_invoke_handler()
> in traversing up to the terminator entry without accessing an
> out-of-boundary index.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e1bdff48a1bb wifi: ath12k: fix out-of-bound access of qmi_invoke_handler()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240416080234.2882725-1-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


