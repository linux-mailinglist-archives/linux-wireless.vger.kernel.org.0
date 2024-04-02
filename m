Return-Path: <linux-wireless+bounces-5745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C83B895158
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 13:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E90285FB4
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4F960264;
	Tue,  2 Apr 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6iuDcKa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D15FDDB
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055803; cv=none; b=XSGbDFPnc5JUXrbzlElKt4rzbvC/CTZGL2XJ8zdTgKWvnXnJ2cdUQ+hiATsuOZlzdGRl3BwmxapbhiuP9tSlNcHDInuooFhEQA4UcHxNJGH2T9uCMl1gwwS46GaW5bw8iCQM4fyRBWPudbcha5mT2KXKXKpQJ/uNA84u2GU+CuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055803; c=relaxed/simple;
	bh=MK9jLxC4ux2EicVUX/VQh7Ssl8aX8z1ATo+jHpj6tAI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=M+xM4M2NNwt8ya54Vim0yA2wAAnIp0zLLQMIhD0/CMipq4JPPlsr4cYjhsagDbHK+OsiQNQHOmW3OQCs3d3w51znzIilLcgPcuwPSdaVxX8uJ4F/tIMQbaA80yqHryDtOJ5hLleosqdlThSPzBqxcufPc4zy88IkThqfrWI8XN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6iuDcKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23EFC433C7;
	Tue,  2 Apr 2024 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712055802;
	bh=MK9jLxC4ux2EicVUX/VQh7Ssl8aX8z1ATo+jHpj6tAI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=F6iuDcKaS6GnhXCGnhYwMHRrxa2u4NHJKCz5F2syIMUtN9OlL6pigsuRfE56+QKbA
	 kLItW1zunVSRJMQjpL3YskQsJ2hQdGysrLr/5hoWkylzIxZrxLkGCvBy0FdoYjaY6M
	 w3etep8pTdn8W+jd/BhZHx+ZhJ6SSgrQJ4CaRKa8j8EBRn2HRKc2gDoBWBBpAhyfFH
	 089xlI7zkQj3NiMZuZoQsfjYv3j7wTwyP+s1d+5GMQLYRg5Wvkddljk0apP+wNV+oG
	 oFkK1g0XCMaFagcmnOgC7NIMOsK+IT25EbN8bHduln/xJQNAI/oPuPSottR9QmDKHX
	 b/w+plunH+pFQ==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: report signal for iw dev xxx station dump
References: <20240219111417.1185-1-quic_lingbok@quicinc.com>
	<87o7b8amcn.fsf@kernel.org>
	<3f5b9e74-d898-416b-9b08-d008883c7e58@quicinc.com>
Date: Tue, 02 Apr 2024 14:03:19 +0300
In-Reply-To: <3f5b9e74-d898-416b-9b08-d008883c7e58@quicinc.com> (Lingbo Kong's
	message of "Wed, 27 Mar 2024 20:54:42 +0800")
Message-ID: <87a5mc6n7s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> On 2024/3/21 0:39, Kalle Valo wrote:
>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>> 
>>> The signal of "iw dev xxx station dump" always show 0 dBm. This is because
>>> currently signal is only set in ath12k_mgmt_rx_event function, and not set
>>> for rx data packet. So, change to get signal from firmware and report to
>>> mac80211.
>> 
>>>   	/* TODO: Use real NF instead of default one. */
>>> -	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
>>> -	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
>>> +	signal = arsta->rssi_comb;
>>> +
>>> +	if (!signal &&
>>> +	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
>>> +	    ar->ab->hw_params->supports_rssi_stats &&
>>> +	    !(ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
>>> +				      WMI_REQUEST_VDEV_STAT)))
>>> +		signal = arsta->rssi_beacon;
>>> +
>>> +	if (signal) {
>>> +		sinfo->signal = signal;
>>> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
>>> +	}
>>>   }
>> If I'm reading the patch correctly this is the sequence:
>> 1. ath12k_mac_op_sta_statistics() is called
>> 2. WMI_REQUEST_STATS_CMDID is sent to the firmware
>> 3. ath12k_mac_op_sta_statistics() returns
>> 4. firmware sends WMI_UPDATE_STATS_EVENTID to host
>> 5. ath12k_wmi_tlv_fw_stats_data_parse() stores signal to
>> arsta->rssi_beacon
>> So doesn't this mean that ath12k_mac_op_sta_statistics() actually
>> uses
>> the previous value? And if ath12k_mac_op_sta_statistics() is called very
>> seldom, like once an hour, the signal value can be one hour wrong?
>>
>
> Hi, kalle, you're right.
> Thanks you for pointing this out.
>
> I should add a struct completion to make up the synchronization mechanism.
>
> So, i add a struct completion in struct ath12k, then modify the
> ath12k_mac_get_fw_stats() function:
>
> +static int ath12k_mac_get_fw_stats(struct ath12k *ar, u32 pdev_id,
> +                                  u32 vdev_id, u32 stats_id)
> +{
> +       struct ath12k_base *ab = ar->ab;
> +       int ret, left;
> +
> +       mutex_lock(&ar->conf_mutex);
> +
> +       if (ar->state != ATH12K_STATE_ON) {
> +               ret = -ENETDOWN;
> +               goto err_unlock;
> +       }
> +
> +       reinit_completion(&ar->fw_stats_complete);
> +
> +       ret = ath12k_wmi_send_stats_request_cmd(ar, stats_id, vdev_id,
> pdev_id);
> +
> +       if (ret) {
> +               ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
> +               goto err_unlock;
> +       }
> +
> +       ath12k_dbg(ab, ATH12K_DBG_WMI,
> +                  "get fw stat pdev id %d vdev id %d stats id 0x%x\n",
> +                  pdev_id, vdev_id, stats_id);
> +
> +       left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
> +
> +       if (!left)
> +               ath12k_warn(ab, "time out while waiting for get fw
> stats\n");
> +err_unlock:
> +
> +       mutex_unlock(&ar->conf_mutex);
> +       return ret;
> +}
>
> then add "complete(&ar->fw_stats_complete);" at the end of
> ath12k_wmi_tlv_fw_stats_data_parse() function.
>
> what do you think of this?

I can comment better after seeing the patch but something like is needed.

>> Also I don't see any protection when accessing arsta->rssi_beacon.
>> 
>
> i think add protection is unnecessary when accessing
> arsta->rssi_beacon in ath12k_mac_op_sta_statistics() function, because
> we just take its value and don't change it.

But there's also a race that we can return the old value to the user
space, no?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

