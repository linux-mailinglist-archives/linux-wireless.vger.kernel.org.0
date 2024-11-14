Return-Path: <linux-wireless+bounces-15287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD09C829C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 06:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0172816DE
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EFD1F8188;
	Thu, 14 Nov 2024 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EolKFUWm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355141F80C5
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731562514; cv=none; b=ngjFI3IIwnpUrccLRibySVjLoaSgb4Ofei9SC6X5ygoN42lIzAxhPwAdWTCnLuJD9j4KoB4zzUYm6SAP9t1Uc327HAOTmBSkH54wnMbMfv+uJ2Ysp2vendW0qn08sDxjAfmNvLSFSGeF/AHQ82wppRfoIG+A+GXdpBnybktytcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731562514; c=relaxed/simple;
	bh=HnoRL8zS1LMi+39+RyEOUYxKmTKdZ0iha4N+tEpS/4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IFTyuUgjpTOfGwCdRDIC3jyJ30F+5HIXlWfkYoUiODKnvY8UMNMhNLBq18wfyCnTSgcf/5YGPZ/kSSnNUx0Tb6wkkYqB+8q01aDdw6gU3TD6Sz9wWwlup1UWor9s4Lz5V4z/XpN6YbO6jOzUDVnyO8BVhUqvcNlKktPcRHioSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EolKFUWm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1Wtc026737;
	Thu, 14 Nov 2024 05:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qvs3mVL4PFfMrttbu7121qyHJCTzMk8eNsinxkbH1oQ=; b=EolKFUWmvuNmLI+I
	fnX2MvrugMRzxsbygGuyMh2QQCUhQJhxJI7nSi1ACq7n5/j5azAoLfLr+Y5x05xF
	pku+BE49+wToklSlFwZ2sySVpp5u7GOlwNJPUEhsHavSBrHA4kPkVQgWGG1IjaPj
	esqkRwwLhDi6qhTsfBGPzQxOqmMsUU/A/b+2MYU6sN77v1NjuvC5XVCDZj493/Fk
	1SZkLlrAejqoDYr5pXI8gw7fSNhRRtoJ9yHWzQe4Wr/HnRzN4Sn4eWeTgI8c4V5+
	XoD7jtZmAkd1XmIu6BNlV3qGneTrw254s4vSNBE/FN2Ruv+KP+L1OLdvcNjGIEyf
	ybocOg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vt732py2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 05:35:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AE5Z2kp018345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 05:35:02 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 21:35:01 -0800
Message-ID: <9a602e80-a66a-4618-818c-2875fc488c82@quicinc.com>
Date: Thu, 14 Nov 2024 13:34:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: ath11k: avoid burning CPU in
 ath11k_debugfs_fw_stats_request()
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
 <20241113015631.3105-2-quic_bqiang@quicinc.com> <877c972xqu.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <877c972xqu.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _C8figD_8pXkzFIprA09Kk7LcixsKTnN
X-Proofpoint-GUID: _C8figD_8pXkzFIprA09Kk7LcixsKTnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140041



On 11/13/2024 7:12 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> We get report [1] that CPU is running a hot loop in
>> ath11k_debugfs_fw_stats_request():
>>
>> 94.60%     0.00%  i3status         [kernel.kallsyms]                 [k] do_syscall_64
>>         |
>>          --94.60%--do_syscall_64
>>                    |
>>                     --94.55%--__sys_sendmsg
>>                               ___sys_sendmsg
>>                               ____sys_sendmsg
>>                               netlink_sendmsg
>>                               netlink_unicast
>>                               genl_rcv
>>                               netlink_rcv_skb
>>                               genl_rcv_msg
>>                               |
>>                                --94.55%--genl_family_rcv_msg_dumpit
>>                                          __netlink_dump_start
>>                                          netlink_dump
>>                                          genl_dumpit
>>                                          nl80211_dump_station
>>                                          |
>>                                           --94.55%--ieee80211_dump_station
>>                                                     sta_set_sinfo
>>                                                     |
>>                                                      --94.55%--ath11k_mac_op_sta_statistics
>>                                                                ath11k_debugfs_get_fw_stats
>>                                                                |
>>                                                                 --94.55%--ath11k_debugfs_fw_stats_request
>>                                                                           |
>>                                                                           |--41.73%--_raw_spin_lock_bh
>>                                                                           |
>>                                                                           |--22.74%--__local_bh_enable_ip
>>                                                                           |
>>                                                                           |--9.22%--_raw_spin_unlock_bh
>>                                                                           |
>>                                                                            --6.66%--srso_alias_safe_ret
>>
>> This is because, if for whatever reason ar->fw_stats_done is not set by
>> ath11k_update_stats_event(), ath11k_debugfs_fw_stats_request() won't yield
>> CPU before an up to 3s timeout.
>>
>> Add 100ms sleep to avoid CPU burning.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>
>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>> Reported-by: Yury Vostrikov <mon@unformed.ru>
>> Closes: https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com/ # [1]
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/debugfs.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
>> index 57281a135dd7..a5e0f2092da5 100644
>> --- a/drivers/net/wireless/ath/ath11k/debugfs.c
>> +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
>> @@ -207,6 +207,9 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
>>  			break;
>>  		}
>>  		spin_unlock_bh(&ar->data_lock);
>> +
>> +		/* 100ms is empirical, change if required */
>> +		msleep(100);
>>  	}
>>  	return 0;
>>  }
> 
> Please don't reinvent the wheel. Why not just use completion instead of
> this ugly spinning hack?
previously I was thinking that a wait_for_completion() is not allowed since we are in atomic context due to spin_lock. But thinking it more I find that after changing to use completion, the spin_lock is not necessary. so thanks, will do in next version.

> 


