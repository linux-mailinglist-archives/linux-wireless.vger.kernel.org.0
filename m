Return-Path: <linux-wireless+bounces-2783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0965841C42
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 08:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594181F21534
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C703F9E3;
	Tue, 30 Jan 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hc/wwrmf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE03CF66
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598015; cv=none; b=sa5Ag3oFyGj5MriqQeIGrWWo/IUwXTqTMGCReiXWs9DsbvUT/pancuzai+k7xW9YDEd0a0Pdb8d0IFeTdHrNn55ePoBk7h4OpkNVQuKG123yzRWi4lZrVF8KNQVkNIfEae29MoWM1yaYBnmfWdzXYWWk0SgJBf2rXNk2naNQYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598015; c=relaxed/simple;
	bh=51qyQRKJjvk/DNq4pjs5sGMGthX2+JiDTwMkgFl+ioU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fhZfdeVG8A5mpDpQ5s8axszD04UmcMayUFmPKF6O3YO2tA7STWOqVAcl4FCiuCoc74UT2u0E6ZUsC68e74hI5n0uJKNtbCZ0w3x0gtBykF9uYeoo86C/K14Wu7686LiGIvyAsQmPnLZ0MWhdIMjChufnFy6l6buVN5wtHr3x/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hc/wwrmf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U6Sa1X022746;
	Tue, 30 Jan 2024 07:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mIqgUfcXfNItkGKdsceAlheC0PfPnmZTRSdcvfF55+U=; b=Hc
	/wwrmfdaaw8E+wcubJ1n/zNSfW8xhAO0s08IVmOtLp8BOPN9Hf9dCNPm5huhwV2u
	wDz+lqaddZj97YRxYgqPbwnRX6VIixJ0kbxHls3/9qtynD5tvhKJhR0d5elv/7Km
	XV1DQefcNTDW7SMCuiJeN9YZQQqu5q8LOGcMi+LIF/LqNQNKtw8iLsNDb5zO0PvN
	Uw1I1g+DKiym+zrja3u+NblzQU5SvsnwN9LI079585gBSOk4Q6r/yDO6CblpOrlE
	CGHblNGL1CB4L70vvkgHXzPWkRrI8slmq3mpHzBDf3LOrJaSMBNHKVCizldbGFBV
	rwEKV/bwYMBoemKhQyrg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxdwf9rv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 07:00:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U7062d032608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 07:00:06 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 23:00:05 -0800
Message-ID: <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
Date: Tue, 30 Jan 2024 15:00:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
Content-Language: en-US
To: James Prestwood <jprestwood@locusrobotics.com>,
        "open list:MEDIATEK MT76
 WIRELESS LAN DRIVER" <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
 <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uCGgT4tfipFSIAFlorCMTxFm2VQaVI65
X-Proofpoint-ORIG-GUID: uCGgT4tfipFSIAFlorCMTxFm2VQaVI65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300049



On 1/27/2024 3:18 AM, James Prestwood wrote:
> On 1/24/24 5:06 AM, James Prestwood wrote:
> 
>> Hi,
>>
>> I recently added support to ath10k, for the QCA6174, to receive 
>> multicast action frames in order to support DPP. I'm trying to do this 
>> for the ath11k QCNFA765/WCN6855. I took the same approach as ath10k 
>> which was actually quite simple but I'm unable to see any multicast 
>> frames coming over even when I enable RX/DATA debugging.
>>
>> What I've done so far is:
>>
>>  - Add FIF_MCAST_ACTION to the supported filters list
>>
>>  - Created/started a monitor vdev from within 
>> ath11k_mac_op_configure_filter()
>>
>>     ath11k_mac_monitor_vdev_create(ar);
>>
>>     ath11k_mac_monitor_start(ar);
>>
>> - Also tried adding
>>
>>     ath11k_mac_config_mon_status_default(ar, true);
>>
>> I can successfully create/start the monitor vdev. I see now as I'm 
>> writing this email that my specific hardware does not support monitor 
>> mode outright... Is this a dead end or is there hope with purely 
>> driver changes? or is it some filtering at the firmware level 
>> preventing this?
> 
> I was able to finally see my broadcast frame after some additional 
> testing. It seems the driver/firmware/something gets a bit hung up when 
> I attempt to put it in monitor mode. It will start printing these 
> messages for about a minute:
> 
> [   51.093034] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id a1a2 
> != status ppdu_id a1a1 dest_mon_not_reaped = 650 dest_mon_stuck = 12
> [   51.094461] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id a1a3 
> != status ppdu_id a1a2 dest_mon_not_reaped = 651 dest_mon_stuck = 12
> [   51.096281] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id a1a5 
> != status ppdu_id a1a3 dest_mon_not_reaped = 652 dest_mon_stuck = 12
> 
> In most cases these ppdu ID's are a one-off from the expected ID which 
> seemed weird to me. But if I let it sit long enough I all of a sudden 
> get a ton of "data rx" messages, which is what I would expect if I 
> enabled a monitor vdev. Once this flurry starts I see the action frame 
> from my other client, sometimes at least. The firmware generally crashes 
> after a while so I've still got a ways to go but it seems within the 
> realm of possibility that this device could receive broadcast action 
> frames?
> 
> Hoping for some breadcrumbs to follow here...
> 
Hi James, as you already mentioned, ath11k/WCN6855 doesn't support 
monitor mode yet. I don't know why you are testing multicast action 
frame with monitor mode. So if monitor mode is not a must, could you 
test this with STATION mode? We would look into this if any issue found.

> Thanks,
> 
> James
> 
>>
>> Thanks,
>>
>> James
>>
>>

