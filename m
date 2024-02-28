Return-Path: <linux-wireless+bounces-4196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1703F86B145
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 15:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A84F1C21F48
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40871148FFC;
	Wed, 28 Feb 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYVIlY33"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11A14F995
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129249; cv=none; b=HQ42Hi6jsSrF0QwcUkEC6Ko0OMbWrKS39fMVwrPL+0y43W83cMJ0DmeZTtZwbu6qUFn0OJlUrsElaaiSjnf++mIQ0KbGv19BILugs/Wge9W/PIWXO3jrWyMb/CVWOlaQii58GZj7kTDJ8gK1LAeVIFt7fM2ASYIHe5eMUlSGqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129249; c=relaxed/simple;
	bh=aiyNEy+DqcKUBkC8EcCyMAFQ1147rb2bWoj6wm7bHmg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=V4lVumTB300DBbj8xSatjx/A0k2zbQSH6lMXDnrg0wJ+tPQ+MZbLYaR56xNNTWJ3dFkEbAiwy4ahEsBYH0FO/N3gTu4sKhGtqSksaSP7wS7OPOP+OhpFu6RbaOqTr0DOX1hGPppKgFO84j1iQO3oD7z43Errk/ht7zjiFPCoqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYVIlY33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C18C433C7;
	Wed, 28 Feb 2024 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709129248;
	bh=aiyNEy+DqcKUBkC8EcCyMAFQ1147rb2bWoj6wm7bHmg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=MYVIlY33eSac1Bs1JhQ7UqCT2J7oN7t8c+b1wxmClgXh/Khw+/hA6/mfjINhfRhQu
	 v8n2h4dMgRfp9LJ6d0qHe2tSYYWvIcgc2fFPUMeCJ88EP1HVzB/LZ/3VENiorLWD5p
	 IJ7NsqH6ygvnqBudaO+vmjVlkkwqxCRwZXHzFqFoodbrIKYCbOMriA4cM1uexengTY
	 q9LwnV5FFaIOMgzMKewpfZf99wcHw3GRoNSF7MO3usAn8BHxyXix14brKSnusl5R1X
	 kWu5xM40AMvV+ttYoMOACRhJJ2bdM/tKhz11TZk0PkO7epVm5GC1i3rmzSSYIiiMli
	 k7hFMjKDwntYA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: add rcu lock for ath12k_wmi_p2p_noa_event()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240223054505.438839-1-quic_kangyang@quicinc.com>
References: <20240223054505.438839-1-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170912924605.3989537.2614593152654573809.kvalo@kernel.org>
Date: Wed, 28 Feb 2024 14:07:27 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> Warning will appear when running P2P GO:
> 
> WARNING: suspicious RCU usage
> drivers/net/wireless/ath/ath12k/mac.c:583 suspicious rcu_dereference_check() usage!
> other info that might help us debug this:
> rcu_scheduler_active = 2, debug_locks = 1
> no locks held by swapper/0/0.
> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc4-wt-ath+ #4
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x82/0xa0
>  dump_stack+0x14/0x20
>  lockdep_rcu_suspicious+0x214/0x3b0
>  ath12k_mac_get_ar_by_vdev_id+0x192/0x220 [ath12k]
>  ath12k_wmi_op_rx+0x2d7/0x1b40 [ath12k]
> 
> ath12k_mac_get_ar_by_vdev_id() requires its callers to have called
> rcu_read_lock(), but in ath12k_wmi_p2p_noa_event() it is called without
> doing so, and hence the warning was triggered.
> 
> Add rcu_read_lock() and rcu_read_unlock() to avoid warning.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 9411eecb60cb ("wifi: ath12k: implement handling of P2P NoA event")
> Reported-by: Kalle Valo <quic_kvalo@quicinc.com>
> Closes: https://lore.kernel.org/linux-wireless/87o7cusyvw.fsf@kernel.org/
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ee3b63586b30 wifi: ath12k: add rcu lock for ath12k_wmi_p2p_noa_event()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240223054505.438839-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


