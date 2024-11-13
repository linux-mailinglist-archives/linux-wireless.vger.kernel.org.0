Return-Path: <linux-wireless+bounces-15244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1109C6D7B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442071F23862
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E51FEFA4;
	Wed, 13 Nov 2024 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+Y/T4Dk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2B1FE0EB
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496364; cv=none; b=QRL9R6FSS/xXSlVbCSdpSD4DSfABYyPE3sZIRKD7T/rChYZo6hDtcMJR11GMM5LEFf0fg/gNr22uzp3I8rIF1lH0em8ICGP8A+FEEmvU9RCNLk8Wh8H528MknVGt43No0rXGuK5J4v85LqlxWlB1EvL0I0w9Mm0gDvl1fkHwNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496364; c=relaxed/simple;
	bh=mIGdVzGsC4Nk+b93weI7HLWPEXwroJOOnErhV0tcHrY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IpNLv0HuRRdi+0xDsKAnhpEsmNMBExVfGcFXXL4mQTSXEbJesRZ6DomfK49M+dHtCd1CScPRmWhUYZ81XXKROAcf/9y2HF45X19ZF4GeRpCIV2yppLoYItb7PEZSlEnHLZtHd0CmOcB/WcW65OMbqYyhX7ohTUR/jAEJNZnSMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+Y/T4Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49629C4CECD;
	Wed, 13 Nov 2024 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731496364;
	bh=mIGdVzGsC4Nk+b93weI7HLWPEXwroJOOnErhV0tcHrY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=A+Y/T4Dkar86c5J2gKa6jC48JAiRut7QMWQ7m0RBpXvd8maYY6xEX8xiIBFUFMC9+
	 +Ks29tuWTOdx/HUSI3rt1mALI2uMU0tvPpdGirD0R2ONKVSz38aQI3+jJs5dPMoypQ
	 NZ7nL0eiIEG6szQhh8hQA2nGSIBmRjGtC9Lre/4GMIp/tp6yhrk6j4RQDcsXREZBrl
	 /mMDjMYHnjMar3bSI5zAGb65JZqv126sGtqO3YKMtZyKxuAu/vG5cvDyf3sO1jzTHt
	 lszd6fjsNONG0xg9egQ84NV4KXalXyfBV6X1Fyhq+zzmPfmQxPSzHmAz3EvS+R9V9G
	 IFEPtEMkM3kAA==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/6] wifi: ath11k: avoid burning CPU in
 ath11k_debugfs_fw_stats_request()
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
	<20241113015631.3105-2-quic_bqiang@quicinc.com>
Date: Wed, 13 Nov 2024 13:12:41 +0200
In-Reply-To: <20241113015631.3105-2-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Wed, 13 Nov 2024 09:56:26 +0800")
Message-ID: <877c972xqu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> We get report [1] that CPU is running a hot loop in
> ath11k_debugfs_fw_stats_request():
>
> 94.60%     0.00%  i3status         [kernel.kallsyms]                 [k] do_syscall_64
>         |
>          --94.60%--do_syscall_64
>                    |
>                     --94.55%--__sys_sendmsg
>                               ___sys_sendmsg
>                               ____sys_sendmsg
>                               netlink_sendmsg
>                               netlink_unicast
>                               genl_rcv
>                               netlink_rcv_skb
>                               genl_rcv_msg
>                               |
>                                --94.55%--genl_family_rcv_msg_dumpit
>                                          __netlink_dump_start
>                                          netlink_dump
>                                          genl_dumpit
>                                          nl80211_dump_station
>                                          |
>                                           --94.55%--ieee80211_dump_station
>                                                     sta_set_sinfo
>                                                     |
>                                                      --94.55%--ath11k_mac_op_sta_statistics
>                                                                ath11k_debugfs_get_fw_stats
>                                                                |
>                                                                 --94.55%--ath11k_debugfs_fw_stats_request
>                                                                           |
>                                                                           |--41.73%--_raw_spin_lock_bh
>                                                                           |
>                                                                           |--22.74%--__local_bh_enable_ip
>                                                                           |
>                                                                           |--9.22%--_raw_spin_unlock_bh
>                                                                           |
>                                                                            --6.66%--srso_alias_safe_ret
>
> This is because, if for whatever reason ar->fw_stats_done is not set by
> ath11k_update_stats_event(), ath11k_debugfs_fw_stats_request() won't yield
> CPU before an up to 3s timeout.
>
> Add 100ms sleep to avoid CPU burning.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Reported-by: Yury Vostrikov <mon@unformed.ru>
> Closes: https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com/ # [1]
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
> index 57281a135dd7..a5e0f2092da5 100644
> --- a/drivers/net/wireless/ath/ath11k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
> @@ -207,6 +207,9 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
>  			break;
>  		}
>  		spin_unlock_bh(&ar->data_lock);
> +
> +		/* 100ms is empirical, change if required */
> +		msleep(100);
>  	}
>  	return 0;
>  }

Please don't reinvent the wheel. Why not just use completion instead of
this ugly spinning hack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

