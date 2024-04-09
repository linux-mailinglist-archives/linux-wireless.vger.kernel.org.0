Return-Path: <linux-wireless+bounces-6007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058A689D925
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 14:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9481F22955
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 12:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E06012C552;
	Tue,  9 Apr 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TsZDflNx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17912C7E8
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665291; cv=none; b=OuPnavQ3mXU5QVbmV0p6oUtg2wy1ldKuramxLgeduCuEMKOEe63sX++BS1FLxuZx/Nak7n24Rx+DwdRYfteukUDMp+975ndccZXBJURE7MNVR2Ypkuspp4XCDbWzONKAJqcw1KyiDlcQIX/ymu7kL8qG5pop0LtBF6QA2pSmwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665291; c=relaxed/simple;
	bh=xb4U2Ctsr3x6eX5sgR+hktBTNC9i8Y0jdvaSgtmixcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kLHPHDJ8Xxk3E6JCfKRON0n/TrwsoNu7lLCdeaSdyZu3hohgC/FWPoytEbsL0N/PRx29fXBU9kjK38wEEBZwJZ9cLXM3RpbFtJMN4LbjhsYJ517pzpzMzR3qpsh91pThlCM2FVuU38nhDDjcgOIuV6k3wOeBiPDzuTieEm5+Xs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TsZDflNx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439BnMnP026280;
	Tue, 9 Apr 2024 12:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s4fqpEXDdKyMGZdE5RRDhqIm8vMvf8Nw2PrnW7+njjc=; b=Ts
	ZDflNxp0vvvfG9VN6DXrZdR16g9d/8VhHqm3/4kr0iY1UmQ5jSjLL+b9xohERQhP
	nC1mXzedR49z1w0AKhw67O5F3tpAffQsl3olBh4Jw/OmwrsNeE705BiinxAAHpgO
	owx8qsevMGK2OmekpU2OdniAnxa7wqk+YH9IOgxs9h2XRAPDWMu0fwnxAKiXd8zl
	Vh2kNvXpzEHdgARelt/EgvtjtyWVfFCQTGtppoMFYltgGE3Uki4aoUUMSmdcRsjC
	Ksvwl7AHyQmnANzoTPCbdMVwAJ3PJXkzITb80KFSFW/LIYipTrgAJac3W3+DOQzA
	vTotPfoqKaIH5qxO3e7Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd3nbr7c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 12:21:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439CLKe6030644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 12:21:20 GMT
Received: from [10.110.24.102] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Apr 2024
 05:21:19 -0700
Message-ID: <4038e991-9207-4033-930a-a14eae4a526f@quicinc.com>
Date: Tue, 9 Apr 2024 20:21:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240219095802.1147-1-quic_lingbok@quicinc.com>
 <87y1b7jkxu.fsf@kernel.org>
 <6f39eb1c-97f7-4029-a5f2-5ab36ff0f0a6@quicinc.com>
 <877ciq9h3e.fsf@kernel.org>
 <4e67118d-80e4-422e-aa39-73b891ee6042@quicinc.com>
 <87a5nkkfs1.fsf@kernel.org>
 <fd8384dc-b35f-477e-aac3-b7a5f49ce712@quicinc.com>
 <87ttl9drii.fsf@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87ttl9drii.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a-KKjqNZk0CNyitMZmIZtfi3wPuKA00_
X-Proofpoint-GUID: a-KKjqNZk0CNyitMZmIZtfi3wPuKA00_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=980
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404090079



On 2024/3/14 18:41, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> writes:
> 
>>>>>>
>>>>>> Ok, i will apply it in next version. Thanks for pointing out.
>>>>> After rereading my comments maybe keep the title simple like:
>>>>>      wifi: ath12k: report station mode transmit rate
>>>>> But it would be good to clarify in the commit message what modes
>>>>> this is
>>>>> supported. And what hardware families support this.
>>>>
>>>> Hi kalle, Could you please offer your opinion on this commit message?
>>>>
>>>> wifi: ath12k: report station mode transmit rate
>>>>
>>>> Currently, the transmit rate of "iw dev xxx station dump" command
>>>> always show an invalid value.
>>>>
>>>> To address this issue, ath12k parse the info of transmit complete
>>>> report from firmware and indicate the transmit rate to mac80211.
>>>>
>>>> This patch only applies to the WCN7850's station mode.
>>>>
>>>> After that, "iw dev xxx station dump" show the correct transmit rate.
>>>> Such as:
>>>> tx bitrate: 104.0 MBit/s MCS 13
>>>> tx bitrate: 144.4 MBit/s MCS 15 short GI tx bitrate: 626.9 MBit/s
>>>> 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0 tx bitrate: 1921.5 MBit/s
>>>> 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
>>> Looks good, except for readability I would add an empty line after
>>> "Such
>>> as:".
>>> I noticed that the signal patch depends on this patchset:
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20240219111417.1185-1-quic_lingbok@quicinc.com/
>>> In that you should submit both patchses in same patchset. But please
>>> wait until I have reviewed the signal strength patch.

Hi Kalle,
Please ignore the patches submitted separately below.

[PATCH v4] wifi: ath12k: report tx bitrate for iw dev xxx station dump
[PATCH] wifi: ath12k: report signal for iw dev xxx station dump
[PATCH] wifi: ath12k: add display tx and rx bitrate for 11be

I will resubmit these patches in same patchset:)

Best regards,
Lingbo Kong


