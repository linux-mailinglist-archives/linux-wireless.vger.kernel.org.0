Return-Path: <linux-wireless+bounces-18924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA9A34B40
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FD1188433F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068E28A2B1;
	Thu, 13 Feb 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J6jN8exp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7A28A2B0
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465934; cv=none; b=LdIvYbQe1dqMSI5J2c8AqE8QKzf4RgCs2RcBVDTam7HV0cDfbmIyDytiYAfdi6D47yJo4ilhfZTxvpDqJryJLcaXt4JOgZFX4qWorLjLwcnzUVp5hv0pp3n4Rv0Y4MXa/PW+vYhFkwcmRgd3n8Zl2FRYUC9QHbHopYG1dFK4xtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465934; c=relaxed/simple;
	bh=UxKTnizDZFEGJakTPq7CWy0HKAwhW7vhF2jkDqtyXN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hIExoVF02bO231MLhwtOtFQ1BbLHnMC8U6iSDv6qc7I5fACzYLN83Yl8iAmIEOy5quM+3x8h+vavzMqevOnoUkN3Br36xkd4JvrBfuiRnCzoz0O8xQwoZ3Z5xKhaqNs/uMtAuYFd92bLLud5vLYaopLQwleV8JCpRWBeyjr+OEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J6jN8exp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGaink008261;
	Thu, 13 Feb 2025 16:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TEDMpeBMSOQPuA5NUlj+OZr7o4+5HXVDCMV4Cy9c4Ig=; b=J6jN8exp9ztdPqkF
	TUfcMbSM5V0j5jpGgrSas8fBBqbiUMrGUmPzmaLjGmQk7eP6bzHliLYN/huGvb0Q
	+EXhLtTz7/1mxJoLSg5KylrxvKgdROWDvaKtAvCWlX0Zi8mjWvMBI8wy0ixMQnDy
	Schgxf2owY/Z8UOw/rf1xulO6j8g1Wy9+o3i6HqQx4fD9h9dM/BqVK7nGvJWI8O2
	J1nfRUnurKaiSVsOFvRQDi1oDUEHs00itOMiJwsAE2F1Kjmfs+r3qshbXaC2S6ny
	5gaQelXicnURUQnHHKRCasOwXs8Rs3HyD36LJNo7VEom2lYcDtdyVUUPQmEvcnFF
	KMDHLQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewhbjem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 16:58:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DGwos4010130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 16:58:50 GMT
Received: from [10.110.107.131] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Feb
 2025 08:58:49 -0800
Message-ID: <5e83efc7-a3f9-4dbf-8b28-b097c3a203f1@quicinc.com>
Date: Thu, 13 Feb 2025 08:58:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20250213012439.278373-1-quic_pradeepc@quicinc.com>
 <20250213012439.278373-7-quic_pradeepc@quicinc.com>
 <78d9cf28-6fb0-44e7-8305-a2dc6b64a121@oss.qualcomm.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <78d9cf28-6fb0-44e7-8305-a2dc6b64a121@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5sz4q54ShhIDp3OkbmwVMnbvOVDyG8Qv
X-Proofpoint-GUID: 5sz4q54ShhIDp3OkbmwVMnbvOVDyG8Qv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=915 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130122



On 2/12/2025 8:03 PM, Aditya Kumar Singh wrote:
> On 2/13/25 06:54, Pradeep Kumar Chitrapu wrote:
>> @@ -3690,6 +3859,7 @@ static void ath12k_mac_init_arvif(struct 
>> ath12k_vif *ahvif,
>>       for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
>>           arvif->bitrate_mask.control[i].legacy = 0xffffffff;
>> +        arvif->bitrate_mask.control[i].gi = NL80211_TXRATE_DEFAULT_GI;
>>           memset(arvif->bitrate_mask.control[i].ht_mcs, 0xff,
>>                  sizeof(arvif->bitrate_mask.control[i].ht_mcs));
>>           memset(arvif->bitrate_mask.control[i].vht_mcs, 0xff,
> 
> No need of setting arvif->bitrate_mask.control[i].he_mcs with 0xff ? It 
> was there in v9 and this change is not present in version change log 
> either.
> 
> 
Thanks for catching that..will fix this in next revision

