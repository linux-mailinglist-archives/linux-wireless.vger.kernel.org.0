Return-Path: <linux-wireless+bounces-8086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B328CFE48
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 12:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043B5284135
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0565313AA4C;
	Mon, 27 May 2024 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DW19be9B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199813AA3F
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806560; cv=none; b=Pu0pgHvKeSVUfCrHP5tU31y7QbDL6g/u6/8HuVVOBAHRfxTgOHIWMnRK+9ZzDeE+UyLDla9xXJEJXdq05I9Q0/Tt6Tg91SPe4r3lJ9KzK2nGn606s/R3cvhYz5NZkWZxzd4GvnaMcJe21yGrWMmJJUlDUxi77du+lVHtR1fDYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806560; c=relaxed/simple;
	bh=JA7oM9jNWZMzk4mfAc2X7KGM3P0Dl9I5HgE+58oBPHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cAJd7KQxr52iKFrbHcllsbeE5sFy6IiRxXTIFxpsBjIL6txLyi4FlTgLpJKNOTehFqrkUwO/vq43uGlNMNbYstSRo7H6kwyK2aGqANCJAvHG7YxuZS2zeKCTMknwWdp1zEa7g5BBR6uBgc2zEsqbREBbO/hnawDLQyQJ1QWP4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DW19be9B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R0QCMu020371;
	Mon, 27 May 2024 10:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k4cnGNkaK+HeyWfczK1r7lu3cwg2RZlYkGqsqhnn1c4=; b=DW19be9BjFayDPqx
	wXS4CxeAu9LZVembPgzgmEBsN05c2ciAT8VSvhxJ64s4cKoM7XtzDwiUmBKkYlAO
	B7HWSBKPj61nFxbIe+zn35m54MNnqaeRKfGMPw5TWZwYnTPfUvfAdeLPX96qmuu5
	plucyFKW7NErQdMjn8ykHmvwFCouL7jwkPqdb3JGwK8nQqfUEj1+Dz+dU7V2grVW
	DcU1QoEGd8kVtKxZoGGw2h1MPmTsaieQEi6YjclfS1w4vVK7TD2NYsRdzqhY3pP3
	JD/xVzmm5E7Er9p55qtrCzIGd380H4e2A6isSl+BvLfJPyhHaN42bayuq89dxzT2
	3DMv9Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h3ajg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 10:42:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RAgUBm014665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 10:42:30 GMT
Received: from [10.152.203.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 03:42:28 -0700
Message-ID: <9117445e-10b8-4872-903d-fa23f7733f8f@quicinc.com>
Date: Mon, 27 May 2024 16:12:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] wifi: ath12k: Add support to enable
 debugfs_htt_stats
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
 <20240510050806.514126-2-quic_rgnanase@quicinc.com>
 <87y183d2pb.fsf@kernel.org>
Content-Language: en-US
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
In-Reply-To: <87y183d2pb.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5i9and1Z1nqKg8neKbKRtRjQx7bT_xBl
X-Proofpoint-ORIG-GUID: 5i9and1Z1nqKg8neKbKRtRjQx7bT_xBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270087



On 5/21/2024 1:19 PM, Kalle Valo wrote:
> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
> 
>> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>>
>> Create debugfs_htt_stats file when ath12k debugfs support is enabled.
>> Add basic ath12k_debugfs_htt_stats_init and handle htt_stats_type
>> file operations.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
>> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> 
> [...]
> 
>> +struct ath12k_dbg_htt_stats {
>> +	enum ath12k_dbg_htt_ext_stats_type type;
>> +	u32 cfg_param[4];
>> +	/* protects shared stats req buffer */
>> +	spinlock_t lock;
>> +};
> 
> Is there a specific reason why a new lock is needed? Why not just use
> struct ath12k::data_lock?

We can use ath12k::data_lock as well since that is also per radio. I
will check and address in next version.

> 
>> +
>>  struct ath12k_debug {
>>  	struct dentry *debugfs_pdev;
>> +	struct ath12k_dbg_htt_stats htt_stats;
>>  };
>>  
>>  struct ath12k_per_peer_tx_stats {
>> diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
>> index 8d8ba951093b..30a80f04d824 100644
>> --- a/drivers/net/wireless/ath/ath12k/debugfs.c
>> +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
>> @@ -6,6 +6,7 @@
>>  
>>  #include "core.h"
>>  #include "debugfs.h"
>> +#include "debugfs_htt_stats.h"
>>  
>>  static ssize_t ath12k_write_simulate_radar(struct file *file,
>>  					   const char __user *user_buf,
>> @@ -87,4 +88,6 @@ void ath12k_debugfs_register(struct ath12k *ar)
>>  				    ar->debug.debugfs_pdev, ar,
>>  				    &fops_simulate_radar);
>>  	}
>> +
>> +	ath12k_debugfs_htt_stats_init(ar);
> 
> Let's try to have consistent naming: ath12k_debugfs_htt_stats_register()

Sure Kalle. I will take care in next version.
> 
>> +static ssize_t ath12k_read_htt_stats_type(struct file *file,
>> +					  char __user *user_buf,
>> +					  size_t count, loff_t *ppos)
>> +{
>> +	struct ath12k *ar = file->private_data;
>> +	char buf[32];
>> +	size_t len;
>> +
>> +	len = scnprintf(buf, sizeof(buf), "%u\n", ar->debug.htt_stats.type);
>> +
>> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
>> +}
> 
> Access to ar->debug.htt_stats.type isn't protected in any way.

I will check and address this.
> 
>> +
>> +static ssize_t ath12k_write_htt_stats_type(struct file *file,
>> +					   const char __user *user_buf,
>> +					   size_t count, loff_t *ppos)
>> +{
>> +	struct ath12k *ar = file->private_data;
>> +	enum ath12k_dbg_htt_ext_stats_type type;
>> +	unsigned int cfg_param[4] = {0};
>> +	int num_args;
>> +
>> +	char *buf __free(kfree) = kzalloc(count, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(buf, user_buf, count))
>> +		return -EFAULT;
>> +
>> +	num_args = sscanf(buf, "%u %u %u %u %u\n", &type, &cfg_param[0],
>> +			  &cfg_param[1], &cfg_param[2], &cfg_param[3]);
>> +	if (!num_args || num_args > 5)
>> +		return -EINVAL;
>> +
>> +	if (type >= ATH12K_DBG_HTT_NUM_EXT_STATS)
>> +		return -E2BIG;
>> +
>> +	if (type == ATH12K_DBG_HTT_EXT_STATS_RESET)
>> +		return -EPERM;
>> +
>> +	ar->debug.htt_stats.type = type;
>> +	ar->debug.htt_stats.cfg_param[0] = cfg_param[0];
>> +	ar->debug.htt_stats.cfg_param[1] = cfg_param[1];
>> +	ar->debug.htt_stats.cfg_param[2] = cfg_param[2];
>> +	ar->debug.htt_stats.cfg_param[3] = cfg_param[3];
>> +
>> +	return count;
>> +}
> 
> Same here with both type and cfg_param. Maybe it's ok to skip
> protection, I didn't do analysis yet, but this makes me suspicious.>
Sure Kalle. I will check and address the same.


