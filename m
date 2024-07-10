Return-Path: <linux-wireless+bounces-10151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A992D63F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C6EB28355
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A1194A5E;
	Wed, 10 Jul 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+g+T2M+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F3191F8E
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628721; cv=none; b=mCdTHIBsHahozzHsGsI4TJgpBW0Q1+nbSe57oikVKKb/SHX45fcn23u+km7Lr8aqWcJD02Kyxa2D5jX/CE1OdpFtGo+7dFC/VUecR1COK3VDDX/EAEN7naP8Yweyk3IY0Tuo+yflBdMBFN+m6ebQMW57Sp0tO8HlgdKsYrDeZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628721; c=relaxed/simple;
	bh=I89m5qBk5w3SDf6qsuZSZrcga7EqvfjuLokGSkIuM7E=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=DXX1yu4yQbQR04xNbhyhTrwu2giq38a28rL72zP0zPJwsfvbXKbA0cyNhsxa9RhK9sHOsrUu7GPZLtaCDke4MKoItQMwdXt2KxYDR7eD7U6lrQIIkviZ6nbjffD8SIGGmk+aN0bx5YUH7VjibVRPY9B9t0/NMmdtUWyt/KM+Y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+g+T2M+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA77C32781;
	Wed, 10 Jul 2024 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628721;
	bh=I89m5qBk5w3SDf6qsuZSZrcga7EqvfjuLokGSkIuM7E=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=L+g+T2M+WYqA26K1VE/ll5FF9JdGR9goUO4OLDh3kImzxIqs4IW+qtmxIVxJjX5aI
	 DkBLhgvJl0j4yZVhdSj6m9w5XukdjUNObSpHuTyQtAQ7EP8XWUcteRXZONlFViOhc2
	 q46W+cndtzRbHrhA3HUTgJkhXz+irQS5uIcySnPLGcava0gc5QC1tiD6bOFK8xNqgc
	 kcZm5lp/P6jsE3CbZ/Mv5h9BFDhvwVIXeY0XaHD4Ucvw1VKClUaNwQ6vHDCowAN7Uc
	 cNaWDj0GWW9eZageoy0zrquDhodNcgITxt+CGrV64Q6bFgcrAnrNSv/0abwZbjYdgL
	 yDLY7OahgWuRA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath11k: use work queue to process beacon tx event
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240626053543.1946-1-quic_kangyang@quicinc.com>
References: <20240626053543.1946-1-quic_kangyang@quicinc.com>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172062871821.1204645.1268185092465319877.kvalo@kernel.org>
Date: Wed, 10 Jul 2024 16:25:19 +0000 (UTC)

Kang Yang <quic_kangyang@quicinc.com> wrote:

> Commit 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
> from Feb 28, 2024 (linux-next), leads to the following Smatch static
> checker warning:
> 
> drivers/net/wireless/ath/ath11k/wmi.c:1742 ath11k_wmi_p2p_go_bcn_ie()
> warn: sleeping in atomic context
> 
> The reason is that ath11k_bcn_tx_status_event() will directly call might
> sleep function ath11k_wmi_cmd_send() during RCU read-side critical
> sections. The call trace is like:
> 
> ath11k_bcn_tx_status_event()
> -> rcu_read_lock()
> -> ath11k_mac_bcn_tx_event()
>         -> ath11k_mac_setup_bcn_tmpl()
>         ……
>                 -> ath11k_wmi_bcn_tmpl()
>                         -> ath11k_wmi_cmd_send()
> -> rcu_read_unlock()
> 
> Commit 886433a98425 ("ath11k: add support for BSS color change") added the
> ath11k_mac_bcn_tx_event(), commit 01e782c89108 ("ath11k: fix warning
> of RCU usage for ath11k_mac_get_arvif_by_vdev_id()") added the RCU lock
> to avoid warning but also introduced this BUG.
> 
> Use work queue to avoid directly calling ath11k_mac_bcn_tx_event()
> during RCU critical sections. No need to worry about the deletion of vif
> because cancel_work_sync() will drop the work if it doesn't start or
> block vif deletion until the running work is done.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/2d277abd-5e7b-4da0-80e0-52bd96337f6e@moroto.mountain/
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

177b49dbf9c1 wifi: ath11k: use work queue to process beacon tx event

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240626053543.1946-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


