Return-Path: <linux-wireless+bounces-21508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94CA87E8F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 13:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC693B529A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDA269882;
	Mon, 14 Apr 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NyeuqcGj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3FDF42
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629056; cv=none; b=ZJjZAFF0tzHgXvxUFwHDoenr0FwB6cdL/iT4melHaA8XIqPhU/j5K4m/7P75myH9QaIXxlHmOJUzGT00hLKa91ZmgTgzdHrsFBDEaGXfygz5a0fjAr4GsbudjJLI7rPx7aTjbubh21zNvMfrYhERIldmN/M4bMQHQqUswfzArL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629056; c=relaxed/simple;
	bh=L7XaRirmwJupOOHMhnoCtFMIcEnaVIlyuVsQ5lNFJMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y7MTQpn3uQrlveRGkgzm08hkNK0t4YOIBAFYort2XGSylYF585D2NCXTc1gDx0jGcuzjG1NEvPIJAOG/8DHJPCjPbksax4s5NNw2d7YV1hK1uPwPxVQRer0ZTCynUFPOoY0zfh9KaCZ7slHQvhZUsmUp3TNCsqcaxK0qS76Sr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NyeuqcGj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99k1U013565;
	Mon, 14 Apr 2025 11:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	emUra44Q/4y0KAe1slv1v4WkBdrHE35nrGijc4+Zh/0=; b=NyeuqcGji1gBri5U
	86fFNvbTvaxYOWCykQHgNOVjAXPLOJKYId9GBoEA64v1DiXwpOm6nDvss9Ttbbag
	zvUYuFfqmuLcLaHRoCkFvygg07VmBAcF2QAj0rkBi2RR0yUr2VhLnXxtkrm33egk
	IHRFq69DFqnuPj0htXQyMgxPLzS7kUyyxRaCm+cWL/hh+KmVBPaBvcdd3J2+vc5q
	9ebW3WLvnQynAXUyXiClQW4Wy5vNfOvhb+ox46KdpyDeshm/TViZQib6p5O3zQkO
	vT0GDQOqUAqJewGtS8b8kpAVwrUifvxXBR0tV8gnK6XmkI/ABl3n2SFfaIUjZy8r
	dEOHYg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcv729-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 11:10:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53EBAijQ011081
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 11:10:44 GMT
Received: from [10.110.63.41] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Apr
 2025 04:10:42 -0700
Message-ID: <6438380f-ec71-4ef9-a737-99f4a45184d6@quicinc.com>
Date: Mon, 14 Apr 2025 19:10:39 +0800
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
        Oleksandr
 Natalenko <oleksandr@natalenko.name>
References: <20250226113118.7626-1-quic_lingbok@quicinc.com>
 <46030c46-a2ca-4d02-ab51-3581f7f3ddfe@lucifer.local>
 <21ef1321-b079-4749-a675-dcc814f9373d@quicinc.com>
 <4930255f-87d7-49c5-b53f-6fa565cd3a56@lucifer.local>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <4930255f-87d7-49c5-b53f-6fa565cd3a56@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fced34 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=qYKNfHejAAAA:8
 a=6QU0jq9d6xpoQD9IgfcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=xXeQd-R7dKE4HXh-qqqZ:22
X-Proofpoint-GUID: tUWcPilIKA4XpavpZTlBwKjZvkIjbosQ
X-Proofpoint-ORIG-GUID: tUWcPilIKA4XpavpZTlBwKjZvkIjbosQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140081



On 2025/4/14 17:29, Lorenzo Stoakes wrote:
> On Mon, Apr 14, 2025 at 11:27:47AM +0800, Lingbo Kong wrote:
>>
>>
>> On 2025/4/11 18:05, Lorenzo Stoakes wrote:
>>> +cc Oleskandr who kindly pointed me at the v1 of this patch (see [0]).
>>>
>>> [0]:https://lore.kernel.org/all/20250124093352.481-1-quic_lingbok@quicinc.com/
>>>
>>> On Wed, Feb 26, 2025 at 07:31:18PM +0800, Lingbo Kong wrote:
>>>> Currently, when ath12k performs the remove link interface operation, if
>>>> there is an ongoing scan operation on the arvif, ath12k may execute the
>>>> remove link interface operation multiple times on the same arvif. This
>>>> occurs because, during the remove link operation, if a scan operation is
>>>> present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
>>>> from the firmware. Upon receiving this event, ath12k will continue to
>>>> execute the ath12k_scan_vdev_clean_work() function, performing the remove
>>>> link interface operation on the same arvif again.
>>>>
>>>> To address this issue, before executing the remove link interface
>>>> operation, ath12k needs to check if there is an ongoing scan operation on
>>>> the current arvif. If such an operation exists, it should be aborted.
>>>>
>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>>
>>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>>>
>>> Hey, thanks for this!
>>>
>>> Not sure on status of this, has the patch been taken for 6.15? As I don't
>>> see it in Linus's tree (not looking _that_ hard though). I don't think it's
>>> even in -next?
>>>
>>> I keep hitting issues with my X870E CARBON wifi onboard motherboard wifi -
>>> most recently I saw a null pointer deref in ath12k_mac_remove_link_interface().
>>>
>>> This occurred when I tried changing the network interface, in fact I had
>>> first clicked on 'available networks' in network manager so quite likely a
>>> concurrent scan.
>>>
>>> I rather stupidly didn't copy/paste the text of it, but you can see the
>>> report in screenshot form at [1]. Apologies for shade being case on ath12k
>>> driver but you know, frustrations :))
>>>
>>> It's difficult for me to test your patch as I am having pretty awful
>>> firmware issue with this motherboard - if I powercycle in any way that gets
>>> interrupted, or especially if a kernel issue arises, then the ath12k module
>>> will not load on next boot, or at all going forward.
>>>
>>> Updating the kernel to, I think, a recent 6.13 (and now 6.14-1 where I
>>> observed this issue), got the wifi working again, seemingly randomly.
>>>
>>> Usually I have to try to reset the CMOS state, but doing so causes other
>>> issues so I generally try to avoid (I have a network workaround involving
>>> an ethernet wifi adapater, it's pretty... yeah).
>>>
>>> So I assume some non-volatile state gets corrupted somehow, I'm not sure if
>>> you had any insights into how I might more sanely reset that?
>>>
>>> Anyway regardless thanks for your efforts, if the wifi adapter appears
>>> again then I will test this and can give T-b tags if so.
>>>
>>> Cheers, Lorenzo
>>>
>>> [1]:https://fosstodon.org/@ljs/114318530969496869
>>>
>>
>> hi, lorenzo,
>> sry for delay response.😊
>> as for as i know, this patch hasn't been accepted so far.
>> for your description, you find the ath12k_mac_remove_link_interface() have a
>> null pointer deref, i think maybe there is a concurrent scan operation.
>>
>> i have a suggestion, you can apply this patch and observe if there is still
>> a crash.
> 
> Unfortunately as I said it's really hard for me to test this since the
> motherboard wifi is permanently unavailable due to some cmos state which is
> really painful/difficult for me to restore.
> 
> This is another bug/issue specific I guess to my motherboard.
> 
> I can give it a try if/when that ever comes back, but I really can't afford
> unfortunately on this machine the time/risk to try to reset mobo state as things
> become unstable when I try.
> 
>>
>> can you offer a detailed crash dump?
> 
> Again, unfortunately, all I can offer is that screenshot I took, I stupidly
> didn't copy/paste it.
> 
> And it seems kernel I was using had symbols stripped so hard to figure out
> exactly where in function it occurred.
> 

oh, sry, i just noticed the link you posted. after looking at your 
screenshot, it seems the issue is indeed related to concurrent scan. my 
patch should be solved this problem, but i need to do further investigate.:)

i'll resent this patch rebasing the upstream code.:)

thx a lot! lorenzo.

/lingbo



>>
>> /lingbo
>>
>>
>>>> ---
>>>> 1.rebase to ath-next
>>>>
>>>>    drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>>>> index 3e3afdc56fc9..551133483f44 100644
>>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>>> @@ -9578,6 +9578,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>>>>    	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
>>>>    	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
>>>>    		ath12k_mac_monitor_stop(ar);
>>>> +
>>>> +	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
>>>> +		ath12k_scan_abort(ar);
>>>> +		ar->scan.arvif = NULL;
>>>> +	}
>>>>    }
>>>>
>>>>    static int
>>>>
>>>> base-commit: e180a01bf2c4a67db13d70d2d91410a8c6f74be3
>>>> --
>>>> 2.34.1
>>>>
>>>>

