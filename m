Return-Path: <linux-wireless+bounces-7877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD38CA99E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 10:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0353B1C214A3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540E6548EC;
	Tue, 21 May 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjxIbjOh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51D54777
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278749; cv=none; b=GW/tYoFa3rxKrSoBV1ZgcrP3sqVRJ+Sm1xoyUbw2EZL7S+UNr9S2a+VXxLwjaXw88645O67U5oAS1lmoDUTRwhKGzdrbpl9ZyE/Tys1Q3Hk8+bL9ai94Ng/JGoC7L9k5nDdoRjHRCtmXvcF2yFuxIy+Rz2kjiig3FmYu7hSaKmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278749; c=relaxed/simple;
	bh=R5x1eX0Ez4WjR44vMnMHTWgfZRTKYLOH3IUFemOI+PE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jyEFB3laG/fJfbPQo7VYJQ3DgLb+90Z6bj6YFQDcxYVsEP0bBUn3fgoMHHqYvTsIJ74B+vpnnaF/gzFlNekkhu/ubaTa/Gmy4socuc9aT+EJt/s746pRD8Kk+LuiGdBwXUuSfntyDY5Cpsqvu+fJXS3kgWs8Xuh8bhzm/eMwOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjxIbjOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BAAC2BD11;
	Tue, 21 May 2024 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716278748;
	bh=R5x1eX0Ez4WjR44vMnMHTWgfZRTKYLOH3IUFemOI+PE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=GjxIbjOhQcI0p6Sr5nzrlHc6uBEsuTnfkeMOfrqrWi31r2I7AfvCEiJcrf1ilAlwE
	 P+ziaQS6BdbiHrDD/mw9aeELEX6zIL3pEvawhiND+sZno6ZXqyBTzqrK+SW3tj5nET
	 s7YOcJT5QiBdLLnxvTK/FV6hVej/WFZQT5qANb/LNhP+1wyFAybH8lNCmSvNe3/368
	 wbxUTxt4HhggwTx6OOKCbbY14c8YGU7i+JJ76+jsu0BC09Sko1SU564EHjzYp7Xm+c
	 oupLhrb11ALmWgK302+T0iUp05U+3giblhtj0ZoxHRnkR10huNCXES131dwAX2/Wjt
	 rMZAadGRk4CEA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix Smatch warnings on
 ath12k_core_suspend()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240511095045.9623-1-quic_bqiang@quicinc.com>
References: <20240511095045.9623-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171627874515.3970531.14849401766701912789.kvalo@kernel.org>
Date: Tue, 21 May 2024 08:05:46 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Smatch is throwing below warning:
> 
> Commit 692921ead832 ("wifi: ath12k: flush all packets before
> suspend") leads to the following Smatch static checker warning:
> 
>         drivers/net/wireless/ath/ath12k/core.c:58 ath12k_core_suspend()
>         warn: sleeping in atomic context
> 
> and also gives the reason:
> 
> drivers/net/wireless/ath/ath12k/core.c
>     48         int ret, i;
>     49
>     50         if (!ab->hw_params->supports_suspend)
>     51                 return -EOPNOTSUPP;
>     52
>     53         rcu_read_lock();
>                ^^^^^^^^^^^^^^^
> Disables preemption.
> 
>     54         for (i = 0; i < ab->num_radios; i++) {
>     55                 ar = ath12k_mac_get_ar_by_pdev_id(ab, i);
>     56                 if (!ar)
>     57                         continue;
> --> 58                 ret = ath12k_mac_wait_tx_complete(ar);
>                                         ^^^^^^^
> Sleeping in atomic context.
> 
>     59                 if (ret) {
>     60                         ath12k_warn(ab, "failed to wait tx complete: %d\n", ret);
>     61                         rcu_read_unlock();
>     62                         return ret;
>     63                 }
>     64         }
>     65         rcu_read_unlock();
> 
> But it is weird that no warning on this in run time even with
> CONFIG_DEBUG_ATOMIC_SLEEP=y. With some debug it is found that this is
> because: when system goes to suspend, ath12k_mac_op_stop() gets called
> where then in ath12k_mac_stop() ab->pdevs_active[ar->pdev_idx] is cleared.
> This results in ath12k_mac_get_ar_by_pdev_id() always returning a NULL ar,
> and thereby ath12k_mac_wait_tx_complete() never gets a chance to run.
> 
> Fix it by retrieving ar directly from ab->pdevs[].ar instead of using
> ath12k_mac_get_ar_by_pdev_id(). Since ab->pdevs[].ar is set at boot time
> and won't get cleared when suspend, ath12k_mac_wait_tx_complete() won't
> be skipped. In addition, with ath12k_mac_get_ar_by_pdev_id() removed,
> rcu_read_lock()/unlock() are not needed any more, so remove them. This
> also fixes the warning above.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Fixes: 692921ead832 ("wifi: ath12k: flush all packets before suspend")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/ath12k/7a96ca11-80b5-4751-8cfc-fa637f3aa63a@moroto.mountain/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

33370412eced wifi: ath12k: fix Smatch warnings on ath12k_core_suspend()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240511095045.9623-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


