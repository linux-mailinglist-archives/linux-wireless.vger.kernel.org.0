Return-Path: <linux-wireless+bounces-14478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1A9AEDC1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 19:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8A11C23B90
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB81F76B4;
	Thu, 24 Oct 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrnLInid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97701F5844
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790486; cv=none; b=Q1K+CLVMDRKcJ6IjK1gkeX5f2KBfWDzeecenu12hqRNeFqNaBFA1ePFfZGCaEKpwACHk2jrX8IyMXR//ummPd5LDwLbKs/PF9r9srCAPKIWY2daWZ6EbAZ8hXiqLd+wLcfC+TaKd09xEvi2XCLCZbXFv9E+KgHOozKZsgq+qeto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790486; c=relaxed/simple;
	bh=IxpR5XjcaYcZ65huyZuO1PDv2ovoaXh745f+hkM7SPM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aaIWnOYtmPSSzq3wWdhS6l0snCXouNMeMNBAoSmDc1hYAb2RhApr9SQU82tw6heNMzJIIDLZT8iOSdwMbBhQ23bYFLhCdRrdl+98eaHGqdrbv9SH2d+32dnANqxo3duSFiW3qjpWM0dje8CRkhbxJyTDr1zkVn36K3DPC1pZZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrnLInid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBEFC4CEC7;
	Thu, 24 Oct 2024 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729790485;
	bh=IxpR5XjcaYcZ65huyZuO1PDv2ovoaXh745f+hkM7SPM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nrnLInid2ueSNqYCcvwTcLcbpU3aplkalnukL3AoJr6WcKV0tGi31ygFjsbhQt7jI
	 m1RnCVltUs1BXgJV8JejxfFqMEceW5zy+7JT6jsmykxBf19JWgeiydkd+BOukdodaY
	 0zXLhG2zyVYPbACr+pyY3pcUCT1vDsZEOXKY2VmRvEYaFtMWWks4JBCshYsw7regsr
	 95K0hhqX43OxAQQZvhUuntyI/e8LSzrDIxXyQf8WmeLh/plMvnTGADoIVmfsyjae+W
	 ONMdMITnGBnXDJHsFeRtc2Nq64qpZkcrWBl0A5XKP9gT/2HC7XUZmGoJLbtmU/e44M
	 lCn5uzV/SpA0w==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/8] wifi: ath12k: ath12k_mac_vdev_create(): use goto
 for error handling
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-2-kvalo@kernel.org>
	<ab8f3e88-f55b-4945-b4bb-a784d1466a27@quicinc.com>
Date: Thu, 24 Oct 2024 20:21:22 +0300
In-Reply-To: <ab8f3e88-f55b-4945-b4bb-a784d1466a27@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 08:01:05 -0700")
Message-ID: <877c9xmn71.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/23/2024 6:29 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> In commit 477cabfdb776 ("wifi: ath12k: modify link arvif creation and removal
>> for MLO") I had accidentally left one personal TODO comment about using goto
>> instead of ret. Switch to use goto to be consistent with the error handling in
>> the function.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/mac.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index f5f96a8b1d61..f45f32f3b5f6 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -7047,8 +7047,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>>  		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
>>  						       arvif->bssid);
>>  		if (ret)
>> -			/* KVALO: why not goto err? */
>> -			return ret;
>> +			goto err;
>
> why does this goto err instead of err_vdev_del?

Good point. I did this to follow the same as the next command does:

		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
						       arvif->bssid);
		if (ret)
			goto err;

But yeah, err_vdev_del looks like more approriate.

>
>>  
>>  		ar->num_peers--;
>>  	}
>
> looking at the context for this patch I have a question about a different part
> of this function:
>
> 	param_id = WMI_VDEV_PARAM_RTS_THRESHOLD;
> 	param_value = hw->wiphy->rts_threshold;
> 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> 					    param_id, param_value);
> 	if (ret) {
> 		ath12k_warn(ar->ab, "failed to set rts threshold for vdev %d: %d\n",
> 			    arvif->vdev_id, ret);
>
> NOTE: no return or goto
>
> 	}
>
> 	ath12k_dp_vdev_tx_attach(ar, arvif);
> 	if (vif->type != NL80211_IFTYPE_MONITOR && ar->monitor_conf_enabled)
> 		ath12k_mac_monitor_vdev_create(ar);
>
> 	return ret;
>
> NOTE: this can return an error if the RTS threshold set fails, but fails
> without cleaning up (dp vdev still attached and monitor vdev created)
>
> Seems either we need error handling if the set param fails, or we should ret 0
> at this point

Yeah, I do not like this kind of vague error handling at all. I think we
should have either a proper error handling or a comment explaining why
we continue to the execution. An example about the comment:

ret = foo();
if (ret)
        ath12k_warn("foo failed: %d", ret);
        /* continue function because foo is optional */

I think this should all this should be cleaned up in a separate patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

