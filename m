Return-Path: <linux-wireless+bounces-11545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141FF9546A4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5472890CD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E517BEB5;
	Fri, 16 Aug 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VthUs09B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234518FDC2
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803575; cv=none; b=C8RzUlVQM2gBdkCmAofTO1pnYVquAa6gYSDct5ra38crglGAFP942i18sJUJX469eCYSmYJ47MOd7A54r75V34wEx9p7eRHZDSyP+MsTsawOcf65Psxh55VkUvrCSs2C7Otowmevd1wjpzcCfhgAMbrdwl5qmyvB8YXoTao/uJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803575; c=relaxed/simple;
	bh=ZIv186wF3ofHqLNddfUNSNaW1NBxcO2OXUunj5qbqhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FJ3hda7NPTJK2b3+P2fQfqxzYF4Rn+CVcQ7ZaW8Pni7OSEiCa51XBWki2uBNkESgZoiho6p/A6C2daUGpZN04vJKA+KAOaJ3PHy5Vp18FZx3DSZN4+sxEMcIpiVpAIYjU8p3VrWUhLDzU7n90vDz0SGW1bcMrvdM2Fpws+p8Zps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VthUs09B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GA7ju9025407;
	Fri, 16 Aug 2024 10:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2bXmBZoME2JecUQT1ZwYTHkL8uy0wUMEYQBHtc8Ayp8=; b=VthUs09Bt70AhD7j
	ChrrXFuoKVOchM5+oWmaKf3ANwm5YjjZU1Q8Fw+2NoaL/ZBdvK8u4j8eCItgVKH+
	ZlTGTF3cYAxrABRE7IZFZTlW9nuSZdvr/xJ1BWNrZssUNDTrpZm9S+TXP3v+OQKX
	7sW2plbyVCfZuoISCJU7jUpxWpCcR1QMTyy51Hjhc3TujlIUZzPrf9+U0wS2DWr/
	fY/MsWjAt4RsuIMVLuzk7kZaNeAAI5FhVo9JA0FZqW2tIQi4vFYT6L41LOIdXjv4
	zSfat6LB8u0VyJrNHEY2FzUgateHkGfpGHwmgsS3OVjvC3KQw8NxsZBpnsFovTlt
	yUT+nQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411s5phh3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 10:19:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GAJTCi006218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 10:19:29 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 Aug
 2024 03:19:28 -0700
Message-ID: <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
Date: Fri, 16 Aug 2024 18:19:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ra5GBaB39CWGM-uwwpqi-qOzvBkqN_8F
X-Proofpoint-ORIG-GUID: Ra5GBaB39CWGM-uwwpqi-qOzvBkqN_8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_02,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160075



On 7/12/2024 9:11 PM, James Prestwood wrote:
> Hi,
> 
> I've seen this error mentioned on random forum posts, but its always associated with a kernel crash/warning or some very obvious negative behavior. I've noticed this occasionally and at one location very frequently during FT roaming, specifically just after CMD_ASSOCIATE is issued. For our company run networks I'm not seeing any negative behavior apart from a 3 second delay in sending the re-association frame since the kernel waits for this timeout. But we have some networks our clients run on that we do not own (different vendor), and we are seeing association timeouts after this error occurs and in some cases the AP is sending a deauthentication with reason code 8 instead of replying with a reassociation reply and an error status, which is quite odd.
> 
> We are chasing down this with the vendor of these APs as well, but the behavior always happens after we see this key removal failure/timeout on the client side. So it would appear there is potentially a problem on both the client and AP. My guess is _something_ about the re-association frame changes when this error is encountered, but I cannot see how that would be the case. We are working to get PCAPs now, but its through a 3rd party, so that timing is out of my control.
> 
> From the kernel code this error would appear innocuous, the old key is failing to be removed but it gets immediately replaced by the new key. And we don't see that addition failing. Am I understanding that logic correctly? I.e. this logic:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503
> 
> Below are a few kernel logs of the issue happening, some with the deauth being sent by the AP, some with just timeouts:
> 
> --- No deauth frame sent, just association timeouts after the error ---
> 
> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
> Jul 11 00:05:36 kernel: wlan0: authenticated
> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=16)
> Jul 11 00:05:36 kernel: wlan0: associated
> 
> --- Deauth frame sent amidst the association timeouts ---
> 
> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
> Jul 11 00:43:24 kernel: wlan0: authenticated
> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=101)
> Jul 11 00:43:24 kernel: wlan0: associated
> 
Hi James, this is QCA6174, right? could you also share firmware version?

> 

