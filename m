Return-Path: <linux-wireless+bounces-23248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A202DABFF0A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 23:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C541BC1DE9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB51E835B;
	Wed, 21 May 2025 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nA8XFlW2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FC1624CE
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863548; cv=none; b=Pd0w2DOISZCdeWuCnnZ2+7F8n0jcf+yB6khBd5OgAF8uaUNYTzt36UuP2x0mLrs8PK8bSEs3QmZQJbhfTfdj9ft35hkM0rajgUZGtyvB1v1vxAnJ8+DkyMOgW6AECyy0MiIakIMWmY4BUMmO9Msll3CcXWtP2LveWkkNQQ4NOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863548; c=relaxed/simple;
	bh=Bxj6K+eFzNKkxW6qxH5TZs2pv77pYSm2XIbpRo7auoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RvCKRJcLreJ/SY9YT4D+VtvkHkygH26KvZMsC2MjfeBqVKQ4lmlCiBzoGIfnBH16Tt+nuMTkKO+3QKwcxvcyIAnKbHXJVq3tqGTfopgWSwynFvDBJWPijlsuF8V2WX3Tqhz2iSJIv7kl2yBIUjXjWfyByN0k9Xxia+27onhwfj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nA8XFlW2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LI2Or6031724;
	Wed, 21 May 2025 21:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fhUlLBeUPNrxixNqYDdgu9rpqgKRCrk+ZY7Iw2xZMLs=; b=nA8XFlW2BO5zh0Q+
	iHZ6a29lvp3g578TaGM40Xl7HK8EEZVbTXKvPCYC8PF/AF7vkjFxin11D3oKQF3m
	MjSzlaW9FVjbBon0sYB+IsCY7uSH7g5y3XFvF0cEtlfzN9NaTYjvEJ7YQReEq3nE
	lU43fRX4KEbtxfUFWlve5/tEw0bdkjGGJua6QMRoieguF89pSwFzn1ZYnPc5AyFN
	7iX0/lrBkCtvsSEOd3Z61F/y3jDxY3oYJJthAmLO7TJYgQ7JG1oDc6xORp2hEpIm
	kxijKRuvNrBja8IRy2qEi4h2ciS+c+Lyi96n71o8ofsH1SAr0ms8fochW5Iu/w0i
	pmDIQA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c22txf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 21:39:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LLd3Xo021657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 21:39:03 GMT
Received: from [10.227.105.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 14:39:02 -0700
Message-ID: <71b78c07-03cd-4179-b162-0866b1a48b3f@quicinc.com>
Date: Wed, 21 May 2025 14:39:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
 <20250418174818.3336510-7-quic_pradeepc@quicinc.com>
 <5d61a6b8-e259-4683-94a8-911dcf2b9e81@oss.qualcomm.com>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <5d61a6b8-e259-4683-94a8-911dcf2b9e81@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIxNSBTYWx0ZWRfX+IY3rtqrDo8Z
 I2IKvnvgGLBPexSxvZs+DfMy2ZG6Fsq9T2o/nAuHGapW1yIsexzzxD2fYgso5Qtgd4raBcNRaC/
 urR8RSlB5LRs7dCokoz01f18YQCvqqHfnzVKlxuFN5Q1Itnh0L7K2xxRlshJG6N60mz9bgAE1fH
 +PyjQh4T/djOLB9eBR9ek27HbG5TdZ8ggWsHsfPliVpj2yIt7f5emP9xtxc4n7JY5ZRIDkgAPI/
 WTI2js/e0Kcv1iSpzfEyMa/eV3sZ2sSXoIgxc6iH7O06jMAtz9TybTLjVa/P2z27yxF5nwHsIBw
 bzIV4kZZj6X4FQnEKL5NE6LI7eJjw8/3au+r3yctKbOq8NoobyZGmOJ8Xp9IdOr7jRTL/P41iz5
 FdYgVTH7FO55yFJJCBM3a3Y4cl3rWBpLM1QQYnY9Z6NLxJr/8sorWSiUL+w2FIca09T+efjQ
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682e47f7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=4d3U5Okv3gj4gmqRzPQA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Js4T3ZGdVECrhyfXgAdnLpUd5oe9SZJZ
X-Proofpoint-GUID: Js4T3ZGdVECrhyfXgAdnLpUd5oe9SZJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=887 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210215



On 5/14/2025 7:54 AM, Jeff Johnson wrote:
> On 4/18/2025 10:48 AM, Pradeep Kumar Chitrapu wrote:
>> Add support to set fixed HE rate/GI/LTF values using nl80211.
>> Reuse parts of the existing code path already used for HT/VHT
>> to implement the new helpers symmetrically, similar to how
>> HT/VHT is handled.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> 
> Internal testing revealed interop issues with this patch, so this series is
> being dropped for now.
Thanks Jeff. Will address it in next revision

