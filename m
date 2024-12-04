Return-Path: <linux-wireless+bounces-15878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06389E320A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 04:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711B2B219BD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 03:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78D136658;
	Wed,  4 Dec 2024 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="psvfS0t2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C5137923;
	Wed,  4 Dec 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282500; cv=none; b=EaMiEKKL9DDpdzwDg9u24dkSG+8Z+sr3ca4ahoYmD8ZTrJT118Fr5/JAjp9EXwrDnlQ5YQyVoNmqhp0yl/pBX4tX2wlNIaqk5oELqTaWuxXbdmuV4kPYhAsLp92jp1taRwp97FFerDTTsDxi0BaoYLgkMquieqgBgQZtFnIzYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282500; c=relaxed/simple;
	bh=R1rYM2+btzLoRyaLqa8NnWh6A5XuxBP6Bo1o8rlyhDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lXbzT2pHk3HI1AIzTKfoEXcE2c8BkNRYb3WYkWkCiJZLffU1t9AVVYJaOAUvTbMeeKrC/drCx6nabNoTtj7Z10u70ee4qnxIb9/65HzAEQ8z3r2cRwq5IaK3/qZ7HXTH4VG+o3UkbNX0j6r14OQGB3bhJevyRpOCs7OIlazoTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=psvfS0t2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B42B3Pi027317;
	Wed, 4 Dec 2024 03:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MO1jtcavQq6rrUrV5M1EUuLowd7a36/BNJFDEa0zfUw=; b=psvfS0t2/0uwmLNx
	WHKVnEKJ7JkcGc2WcTBtQ/VCDfSwudDzXRH9r/wRdfWaov0XcG7zmv3njXiaSlxP
	84NKK04SmarAQ/jXPJi5g/3iqOF9NUCfv5y9/6f1hbEQaMH9lomOVhJUyi74yOH+
	yfCaemUgfhAu/EshvkttYbf3oLp2St3HJNfyD8Og2lloEE8NO1Xz+bAqbqjKPNh7
	g9vV6Ss/A+Md2LgcwYUGty+/iKi1GehB82U3DLtXp0aYA0S3RUISZ/P1ccnCg5X6
	RypVBdKk30cZIO5/Mn5rZU/sOk52UH6BrQOaelNqA9CG3h4J77+aPwUdEvtR79lX
	Q0bCIQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a1g5j50h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 03:21:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B43LUIu027530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 03:21:30 GMT
Received: from [10.231.194.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 19:21:28 -0800
Message-ID: <1b09c2c9-53bd-4960-b09c-7468f506b0a3@quicinc.com>
Date: Wed, 4 Dec 2024 11:21:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <ath11k@lists.infradead.org>, <jjohnson@kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_cjhuang@quicinc.com>, <vbenes@redhat.com>
References: <99359cc4-2279-4a8a-80a1-d5475fd5208d@quicinc.com>
 <20241203163359.129185-1-jtornosm@redhat.com>
Content-Language: en-US
From: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
In-Reply-To: <20241203163359.129185-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G_pActyAXx1r8Dyf8-IPWNo5HT00sR8f
X-Proofpoint-ORIG-GUID: G_pActyAXx1r8Dyf8-IPWNo5HT00sR8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040026



On 12/4/2024 12:33 AM, Jose Ignacio Tornos Martinez wrote:
>> And you want setup sta + sap + sap, right?
> Your proposed interface combination fails as well for me if I am just
> setting 2APs.
>> When up the second sap will meet error? Could you pls share the error
>> logs?
> This is the log that is appearing:
> [   61.909165] 8021q: 802.1Q VLAN Support v1.8
> [   62.227530] ath11k_pci 0000:01:00.0: failed to create vdev 3, reached max vdev limit 3
> It is appearing after configuring both APs when only one AP is up and when
> both are down (see my previous 'iw dev' outputs).
> 
>> I'm not very sure if you add all interface with managed type, and do
>> "ifconfig xxx up" before running hostapd.
> Yes, I am setting the link up before running hostapd.
>> You can try add second and third interface with
>> "iw dev xx interface add xx type __ap".
> And yes, I am doing like that for both APs.
Pls try add interface with type __ap or directly use hostapd up the ap 
interfaces that will re-type managed to ap.

> Please, take into account that everything is working with the old interface
> configuration and when it is set with the parameter (no error log), but it
> is not working for me with your interface combination.
f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces") update about 
interface combination limits.

If chip support DBS, station interfaces max is 2 that why you can't up 
the 3rd managed type interface. You better add interface with ap type.

> Have you tried with 2.4GHz band?
> 
2.4GHz works fine also.
sh-5.1# iw dev
phy#0
         Interface wlan2
                 ifindex 6
                 wdev 0x3
                 addr 12:03:7f:21:84:11
                 ssid QSoftAP2
                 type AP
                 channel 6 (2437 MHz), width: 20 MHz, center1: 2437 MHz
                 txpower 5.00 dBm
                 multicast TXQ:
                         qsz-byt qsz-pkt flows   drops   marks   overlmt 
hashcol tx-bytes        tx-packets
                         0       0       0       0       0       0 
0       0               0
         Interface wlan1
                 ifindex 5
                 wdev 0x2
                 addr 02:03:7f:21:84:11
                 ssid QSoftAP1
                 type AP
                 channel 6 (2437 MHz), width: 20 MHz, center1: 2437 MHz
                 txpower 18.00 dBm
                 multicast TXQ:
                         qsz-byt qsz-pkt flows   drops   marks   overlmt 
hashcol tx-bytes        tx-packets
                         0       0       0       0       0       0 
0       0               0
         Interface wlan0
                 ifindex 4
                 wdev 0x1
                 addr 00:03:7f:21:84:11
                 type managed
                 txpower 5.00 dBm
                 multicast TXQ:
                         qsz-byt qsz-pkt flows   drops   marks   overlmt 
hashcol tx-bytes        tx-packets
                         0       0       0       0       0       0 
0       0               0

> Thanks
> 
> Best regards
> Jose Ignacio
> 


