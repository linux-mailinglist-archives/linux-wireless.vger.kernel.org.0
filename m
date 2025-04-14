Return-Path: <linux-wireless+bounces-21484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C8A8763B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 05:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D72A188FBB8
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954957C93;
	Mon, 14 Apr 2025 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lt+hCrCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D82DF5C
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744601286; cv=none; b=BOCU8ZtK1bsqkBikqBoN21forYfNCSbE63blOV9m992fr2VwPlaNQvPjTFdtkx+v80TnLg1PERkT4p4IWCH102XT10aEvAOs7VfLidT3MLVAtZuY/snBSgEgphqoIlbFOWzrcwErqJO6zWWc3uPI7cghh6FPU4EcTtx+mVMWJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744601286; c=relaxed/simple;
	bh=x+ryyYgp7FzAMaLRXdkT6Vq2HUQzbQ9VgbH0nFZ3EQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cvS/dwu37W8YGBFj05WquzowJIBZ3c4hU3L3y7iKrPrWAgmw9BXN6g2HW+sZ/4PaMcIGv1zaMBkJ25jvEpK+CSKhf6lj9TQpLO9Rj75d9o//BuEdqnG423PbvCd6/l6AnwHi2dtSSY5Rsvsanjd2YK2MJnKosCQD5HOZibTuNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lt+hCrCa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DMj1ti001012;
	Mon, 14 Apr 2025 03:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4ONQCFMae/pApUf3GZW+r3qJt0YKMEaQZxHza69xaxQ=; b=lt+hCrCatHJdl/Sf
	tepCpkQwKAUnU0agjvnpk874Blng57dCidpEunsqLE+2u+Y/Y7fz+vt5a/GoYkT+
	Ec7rPtngGCRVfgpyluU6OE8cQg24p+gI8Us10hqXwgrSvPpcSh8FKuo3UwtULKe1
	PuQj3Q0yxQOooU6UsNH6H+ufem0zpiiylNx8h3ULkpO4pa2CcYPpM6yV1TD9E3ER
	zkpf5g1gUVLi9XA+oQLLlFzgcAbbxeI23l6v1VU+AQO4vx7drnwjMSvyqTZuI/Rc
	LDTN+BA+dHFzJx2NSP5F2PiWlokpxZKLGIew001ThcHHmXpxWbqSXiGv8cRoCsgF
	1h6gQQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjb6m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 03:27:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53E3RqsT009181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 03:27:52 GMT
Received: from [10.253.34.219] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 13 Apr
 2025 20:27:50 -0700
Message-ID: <21ef1321-b079-4749-a675-dcc814f9373d@quicinc.com>
Date: Mon, 14 Apr 2025 11:27:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Abort scan before removing link
 interface to prevent duplicate deletion
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Oleksandr
 Natalenko" <oleksandr@natalenko.name>,
        Lingbo Kong <quic_lingbok@quicinc.com>
References: <20250226113118.7626-1-quic_lingbok@quicinc.com>
 <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X1WARF3bSuo10ZZRdNX6240nqpyDpOmd
X-Proofpoint-ORIG-GUID: X1WARF3bSuo10ZZRdNX6240nqpyDpOmd
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67fc80b9 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=qYKNfHejAAAA:8
 a=4WRb8wXiXRrubVGSIagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=xXeQd-R7dKE4HXh-qqqZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140024



On 2025/4/11 18:05, Lorenzo Stoakes wrote:
> +cc Oleskandr who kindly pointed me at the v1 of this patch (see [0]).
> 
> [0]:https://lore.kernel.org/all/20250124093352.481-1-quic_lingbok@quicinc.com/
> 
> On Wed, Feb 26, 2025 at 07:31:18PM +0800, Lingbo Kong wrote:
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
> 
> Hey, thanks for this!
> 
> Not sure on status of this, has the patch been taken for 6.15? As I don't
> see it in Linus's tree (not looking _that_ hard though). I don't think it's
> even in -next?
> 
> I keep hitting issues with my X870E CARBON wifi onboard motherboard wifi -
> most recently I saw a null pointer deref in ath12k_mac_remove_link_interface().
> 
> This occurred when I tried changing the network interface, in fact I had
> first clicked on 'available networks' in network manager so quite likely a
> concurrent scan.
> 
> I rather stupidly didn't copy/paste the text of it, but you can see the
> report in screenshot form at [1]. Apologies for shade being case on ath12k
> driver but you know, frustrations :))
> 
> It's difficult for me to test your patch as I am having pretty awful
> firmware issue with this motherboard - if I powercycle in any way that gets
> interrupted, or especially if a kernel issue arises, then the ath12k module
> will not load on next boot, or at all going forward.
> 
> Updating the kernel to, I think, a recent 6.13 (and now 6.14-1 where I
> observed this issue), got the wifi working again, seemingly randomly.
> 
> Usually I have to try to reset the CMOS state, but doing so causes other
> issues so I generally try to avoid (I have a network workaround involving
> an ethernet wifi adapater, it's pretty... yeah).
> 
> So I assume some non-volatile state gets corrupted somehow, I'm not sure if
> you had any insights into how I might more sanely reset that?
> 
> Anyway regardless thanks for your efforts, if the wifi adapter appears
> again then I will test this and can give T-b tags if so.
> 
> Cheers, Lorenzo
> 
> [1]:https://fosstodon.org/@ljs/114318530969496869
> 

hi, lorenzo,
sry for delay response.😊
as for as i know, this patch hasn't been accepted so far.
for your description, you find the ath12k_mac_remove_link_interface() 
have a null pointer deref, i think maybe there is a concurrent scan 
operation.

i have a suggestion, you can apply this patch and observe if there is 
still a crash.

can you offer a detailed crash dump?

/lingbo


>> ---
>> 1.rebase to ath-next
>>
>>   drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 3e3afdc56fc9..551133483f44 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -9578,6 +9578,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>>   	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
>>   	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
>>   		ath12k_mac_monitor_stop(ar);
>> +
>> +	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
>> +		ath12k_scan_abort(ar);
>> +		ar->scan.arvif = NULL;
>> +	}
>>   }
>>
>>   static int
>>
>> base-commit: e180a01bf2c4a67db13d70d2d91410a8c6f74be3
>> --
>> 2.34.1
>>
>>

