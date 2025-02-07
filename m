Return-Path: <linux-wireless+bounces-18648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1600EA2CC11
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 19:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6EA3A4BFD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4E1D9337;
	Fri,  7 Feb 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tnk+V2mD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B81D6DBF
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954409; cv=none; b=ildy2sliWxv5CAwARuO3+rDdlI0EGJgdiF66DTRuoJnnW8Y6YLttBNIxrBsjHdfy8WjR1PLq9JMqRg300GKmoXQX7gSdYyYsQml2OCooC+iPUhfuGxBCrgzszDCaf+rZXh8+XBfH+Ur4InuzUpWOF7rzEIP2KwCGh9m8P6KUVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954409; c=relaxed/simple;
	bh=Po73/tZ8bi0JSffQc7D/8DfH0NLszTadi2esSu4eGnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRvkWM0tuCxLHqTE/QFnv1DVqqWiA238zQIbDEMiDBZsPYbURvE6fzfqhA8wFaxoXZJVCkum75T8ScCS2L3lClHAHyawBIkTNwGTUhPvz3tLAhwYtsdewS7HieQKVcIUNafbQ1BX8GJM3xFF46YuIdg+SU0oiS/RA5DdFSykFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tnk+V2mD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517HfR4K013427
	for <linux-wireless@vger.kernel.org>; Fri, 7 Feb 2025 18:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	62U43CWQ85bcTSG0zmifYLZOS2pGijYoAOm9rAX5t2E=; b=Tnk+V2mD3QMFuS7N
	VJe36pwhoBa35mH8lzukiY99WuTgNpEgWgm/PjKmozlhXU4rMxtOmep4bOuMjlB9
	9qYguoo0n0xNXbCUY2t5nAuOMC0XtPArH9WrUQ7xbaY2t4ARl4h1A4lUZUkk36MU
	6DSHUCPR27L/tYs4lvRgQJ7CfT6EptAfz+ezYiS2cY9nVbX82a4qf9fWGunIVsdn
	DMg4eEFsVXL8wWAn2gZcAVssBTzKdiecKVK9MbGv7FYs0O3o3mu4Bhdeb/5JveLs
	+zF57ULCBIRKng7j2/bgRVaF2Zv6h52eTNZEBzO2Da1GhzorvSGHoI6f6uw6QhhA
	Kk5scQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44npt1859q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 18:53:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f1e5c641aso83981345ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2025 10:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738954403; x=1739559203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62U43CWQ85bcTSG0zmifYLZOS2pGijYoAOm9rAX5t2E=;
        b=v8OACa7oHzZW3kAsUpS34XtJWJpxyVRFfv+X0sLF2qeU+F0Zn7My1Ti155IG/7IZZ3
         5Vb+E8RkjJQyG9bhzN3yMNye9Uz7Y81zirXn/SKDTGxA+BesKG5UR8kkZ0ZDkHopcOdZ
         QlJE2fAqRtlSHQwdz19F766tBstRWc6CN0RvwCiAz6m719l7B3I79JwwofQXmW/vpenN
         pihXhrJiOtKFJxDZeLJ/heebd4Pui6/qPnqj7OZxrgG27TXNJ78h8MYzos1Yn+nlK6iE
         VJUCGi42UTDFKblpV75eR6yyKWIIwiQ9k6MNyOd1ZmFV9df4YVRc+4NguvR5t5iA2PNp
         rYvA==
X-Gm-Message-State: AOJu0Yx2UeL7kOHqiCUDVjki+Qo/uF0zKeIronT9FS6vz1UVLczab6xY
	9l4mML4j1Fbz/EIZjA5l/RMT5B+Csn2W3/9SK0AKLseGJYB54FgWjke1sfgQxL+brNp1sjiTfXq
	ZGQ/f30h2fhMRf0g1wkF8r5C3ZxJOIQS8gJ+9FwkvhB4R8TAiU9embg2gxdUkRgFBiXbl7pWBfA
	==
X-Gm-Gg: ASbGncsERN5djcIJJEt2VKCnbeALuz1xNZHlAXrDhutVxo1P2hV+Mg/bp+I79B/qqf1
	dIrLhfsX1dZ2RYtnWn4iZygL/+IVmpamxQj/Y2DY6ljPPIjFRXRGfObJ1RJJ49D0JpWPoHOkTkt
	UcBMTn2J784N5VmL/iEaD5zKzu9YYPYUm9av+grKJIdGvewTf7+WK5n+cGfnHKoxpSNAQRAFizT
	Oa/Ou8Qb040gowRNnWOo/2a3nklys83lwf0uwhwvQqo37BV0QRkBWJuViALLAA4f8PSNZSrQXhw
	36awzrfofoyb7BLWjR3e7M2YVdQ0wJ6Ih7jOUEKvbuErQDxHU/81XkdyXfSLTBcLqePMwli9gQ=
	=
X-Received: by 2002:a17:902:f551:b0:215:a179:14ca with SMTP id d9443c01a7336-21f4e1c8d18mr74899665ad.2.1738954403085;
        Fri, 07 Feb 2025 10:53:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOsePrihm3NpzSVHZOlBY12jj1paNWwIKlb89H94n0dQQE1LqorQY8+Kv/encc8DMPG6IvkA==
X-Received: by 2002:a17:902:f551:b0:215:a179:14ca with SMTP id d9443c01a7336-21f4e1c8d18mr74899225ad.2.1738954402703;
        Fri, 07 Feb 2025 10:53:22 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ec92sm33843475ad.17.2025.02.07.10.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 10:53:22 -0800 (PST)
Message-ID: <7ee0f7fd-7a3d-4942-8323-08ff9c4c8915@oss.qualcomm.com>
Date: Fri, 7 Feb 2025 10:53:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Abort scan before removing link interface
 to prevent duplicate deletion
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20250124093352.481-1-quic_lingbok@quicinc.com>
 <44dc86f0-7775-4d47-9058-17cb048cd976@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <44dc86f0-7775-4d47-9058-17cb048cd976@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qq5jC-Mi1KqcetDzTTK3ml3VGgh1LASp
X-Proofpoint-ORIG-GUID: qq5jC-Mi1KqcetDzTTK3ml3VGgh1LASp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070140

On 2/7/2025 1:04 AM, Lingbo Kong wrote:
> 
> 
> On 2025/1/24 17:33, Lingbo Kong wrote:
>> Currently, when ath12k performs the remove link interface operation, if
>> there is an ongoing scan operation on the arvif, ath12k may execute the
>> remove link interface operation multiple times on the same arvif. This
>> occurs because, during the remove link operation, if a scan operation is
>> present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
>> from the firmware. Upon receiving this event, ath12k will continue to
>> execute the ath12k_scan_vdev_clean_work() function, performing the remove
>> link interface operation on the same arvif again.
>>
>> To address this issue, before executing the remove link interface
>> operation, ath12k needs to check if there is an ongoing scan operation on
>> the current arvif. If such an operation exists, it should be aborted.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 329c05003721..cdce88787182 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -9333,6 +9333,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>>   	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
>>   		ath12k_mac_monitor_stop(ar);
>>   
>> +	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
>> +		ath12k_scan_abort(ar);
>> +		ar->scan.arvif = NULL;
>> +	}
>> +
>>   	ath12k_mac_remove_link_interface(hw, arvif);
>>   	ath12k_mac_unassign_link_vif(arvif);
>>   }
>>
>> base-commit: 376673aa393c1c232299be3e910d7f2e6d974b2f
> 
> hi jeff,
> do you have any updates on this patch?🙂

while this patch applies cleanly to ath/main, it does not apply cleanly to the
current ath/pending, conflicting with:

https://msgid.link/20250204-unlink_link_arvif_from_chanctx-v2-8-764fb5973c1a@oss.qualcomm.com

that patch relocates the adjacent lines:
   	ath12k_mac_remove_link_interface(hw, arvif);
   	ath12k_mac_unassign_link_vif(arvif);

so should this logic stay in ath12k_mac_op_unassign_vif_chanctx() or should it
also be relocated to ath12k_mac_op_change_vif_links()?

/jeff

