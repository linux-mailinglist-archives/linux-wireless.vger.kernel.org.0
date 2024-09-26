Return-Path: <linux-wireless+bounces-13214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE9986B37
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 05:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D636B283117
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 03:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D439C1E86F;
	Thu, 26 Sep 2024 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ThocKRfC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFF145FEB
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727320597; cv=none; b=KXZRdPgAD2lhhSErxSyvL2Ci+pwfyxe3gJ57hOW/MpS0gguHmV9utYAwvdXUyio6UIdAF71QakL9Yl84pAK6066zojhABRzOkTELcvsZRODS0uGggHINzkG1pzXi7PoSoUv5wlZtSMTEtChI25eiKGEqPYXh1leY257cCO1YDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727320597; c=relaxed/simple;
	bh=mfUl06lPN4wdmU+ogmC0mR/pCCYwmHupGQl3jltboAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JRjBTqX+eI1eExjsgq1Jsx8xmVJUSpaAH8kNpGmsBPEgKPOaMvznBFN2tq936z2gGhRsVquogHYPGVV36hlgaIbgmbpRtubehOaQwy7f8WSfrPyKS5xbwARFRh6Q7gQ8+/X01ExpVNxhtAHxQLcKLlOPIuTorUTdDfbgY2kZu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ThocKRfC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PH5DJG008242;
	Thu, 26 Sep 2024 03:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hKAqh7ax0lL+dAm0XRSOK/k01MOqx17APzaO5aqfypQ=; b=ThocKRfCY5Gz16o8
	ZrgrQde4p9W//yUnftra8hFmpvzHbVIvoBZYK+7E2xVmJ2TerRUbBkWLXaATfTFD
	bOUcLPx4dLsSep9YLUyPyMRrlDgbAG2wCuuG0IiCdA/qN6LVJiORVarOAMYkoitx
	Ak0hITc+PW3upKRIuCLQHpVKt7KJwFv/UeIKRXq3TmvVjtWtwoxQiZOezR4fXCNh
	Fjw7srd4sNPHoA4QEC5cSl6ZGFX4gBEmZUiRl0KnRtvhH9PgRJiL/pDSkHHnEw+k
	BJD/g1A4G7S5fuNoj7A+Ro+MOOkI+rX0OFeyanUhbc/xJ/ZgFarLq2FhN+PVPgH1
	yc9yiw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuex469-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 03:16:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48Q3GTQx019832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 03:16:29 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Sep
 2024 20:16:28 -0700
Message-ID: <70567137-dfb9-4896-9e6c-6c02a97228cb@quicinc.com>
Date: Thu, 26 Sep 2024 11:16:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>
CC: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
 <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>
 <0d1dab88-66a0-48c1-bdbe-777d07c3132e@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <0d1dab88-66a0-48c1-bdbe-777d07c3132e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uT2kmp040eVZOaWB7O-gGzh5O8MC_Nsw
X-Proofpoint-ORIG-GUID: uT2kmp040eVZOaWB7O-gGzh5O8MC_Nsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260020



On 9/25/2024 7:33 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 9/25/24 3:07 AM, Baochen Qiang wrote:
>>
>> On 9/19/2024 8:21 PM, James Prestwood wrote:
>>> Hi,
>>>
>>> I noticed an issue when we started putting ath11k clients on a WPA3 network which seems to be related to the fact that management frame protection is enabled (works fine on WPA2 no MFP). Immediately after an initial association a neighbor report request goes out and we get no response from the AP. After getting a PCAP in one case we noticed the neighbor report request went out unencrypted, though still had the CCMP IV parameter. The content of the request was the unencrypted request, and something like 15 bytes of 0x00 padding. I will say, this initial PCAP was made through the AP vendor so perhaps it automatically added the right keys to decrypt the frame, this could be a red herring. I tried on my home network and it was hit or miss, sometimes I would get a response but sometimes I wouldn't, but I did see the frame was always encrypted in my home network case though when adding the PMK directly in wireshark I couldn't decrypt it, where on other hardware like iwlwifi I
>>> could.
>> is your home network also WPA3?
any comment on this query?

>>
>> and how did you get the PMK? is it generated by IWD and printed as debug message?
> 
> I actually had to modify IWD to print out the PMK after it derived it. WPA3 makes this a huge pain since the PMK differs between SAE exchanges.
> 
> I've attached an IWD diff that prints out the PMK, which can be added to wireshark if that helps.
Thanks, I found another way to do the decryption.

> 
>>
>>> Some time after the connection neighbor reports work fine. I'm not sure of a time frame or delay required that gets them working, but it makes me suspect that ath11k doesn't have the keys fully added in the firmware before userspace gets signaled as "connected". Running the same scenario on ath10k or iwlwifi has no issues. This neighbor report request immediately after connecting is IWD's default behavior, so its relatively easy to test by just restarting IWD.
>> I captured a WPA3 SAE PCAP too, but only can find some unencrypted ADDBA req/resp frames. for those encrypted action frames I am still struggling to decrypt them
I checked all the action frames after decrypt the PCAP, but still not able to find a 'neighbor report' frame. next will study IWD code to understand how such a frame is triggered.

and again, if not possible to share the complete PCAP, can you share the individual 'neighbor report request' frame ? you can simply copy it in wireshark.

>>
>>> Since the neighbor reports work fine after some time its not really a critical issue but I wanted to bring it up just in case.
>>>
>>> Thanks,
>>>
>>> James
>>>


