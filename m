Return-Path: <linux-wireless+bounces-3138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00561849F93
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919731F23E46
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EEC3C097;
	Mon,  5 Feb 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FmmuM+LX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DB3CF4B
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150917; cv=none; b=bI4x4egQ+44cypX7YiYGHbvzu7/OMCG3G7vJPCxrBuvcCKIwG6/SlV/6Pz7n+CQp+CnGbb/YjZTJNOQZnk4WJcWu72bcjmsQnErw7CLs6c8t5QDNCgBvBqlFzb0U+281Dr4ciSIgz+cwkaPzZ3Cs02q827ewnEieoFbniu01YZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150917; c=relaxed/simple;
	bh=Y3V6qmHl5CT9j8T65pC48CXsIiBBtyyjEG3AuQ1tnRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AQq920sAqpGZAT3mX/4CYTAehQP04ZYTms10QhHq+t3VszsxfvjZrC5PmqVdvfa1c0DJrJUVNWTAS4QwRS3QsPE8ANBqdob7nsIYALzT8UZUe4KUZFk2KApSyIWej1ZlltzhaagfdbWZ1/UDPdW+R55EKBTFjAWP1RsuHYE3kxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FmmuM+LX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415FU6gS021811;
	Mon, 5 Feb 2024 16:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VVBUDGI/7j74ztZpyPUEHLAkWrecmj/YVlNVycV5kaQ=; b=Fm
	muM+LXOXsKm/5arGTCbvC6908jaCRhwiLjSx4OVyQsr8lowdiCzQttZV/TSZdeSJ
	04hF5dWOf72J0JTauCDDOY5LG3oqaHtl9LA57faH9sdhBqRlsJU9/nWqg1BDaC9Z
	4Op9rpuMD2apgdSyPXhWHhmfdesUBMi9Ho4QPUa+bDFMONmDmOTScuboRYQajtkR
	Y//QGpAv1xplWab99wKNbWOo3K3FkFlwPJ73r84lSLK/6VifxTiAlf3Yd1pQcxF2
	ek5pYgW2mLGsV4LiUqp3DQzErWC9+LiIB7yhtBhKkORZ1Box3S/NMTY6obqN8oW3
	yUuFY5fU34nAt/TQbHHA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rvj9d67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 16:35:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415GZ8DE030721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 16:35:08 GMT
Received: from [10.110.62.200] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 08:35:08 -0800
Message-ID: <efda8b8e-0257-4779-b0c9-0903164b58c1@quicinc.com>
Date: Mon, 5 Feb 2024 08:35:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] wifi: ath12k: add P2P IE in beacon template
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Kang Yang <quic_kangyang@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-5-quic_kangyang@quicinc.com>
 <87bk8usx6d.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87bk8usx6d.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c1tPlce_qyVSogcM4QXR_gC8bgEHYYpK
X-Proofpoint-GUID: c1tPlce_qyVSogcM4QXR_gC8bgEHYYpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=884 bulkscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050126

On 2/5/2024 8:17 AM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
>> +	if (WARN_ON(skb->len < ie_offset))
>> +		return -EINVAL;
>> +
>> +	ie = (u8 *)cfg80211_find_vendor_ie(oui, oui_type,
>> +					   skb->data + ie_offset,
>> +					   skb->len - ie_offset);
> 
> So cfg80211_find_vendor_ie() returns:
> 
> static inline const u8 *
> cfg80211_find_vendor_ie(unsigned int oui, int oui_type,
> 			const u8 *ies, unsigned int len)
> 
> You are casting away the const here. I see that other drivers do the
> same as the assumption is that the pointer points to the same buffer,
> but I still don't really like casting away const. Thoughts?

I'm not a fan of typecasting either.

However, the problem here is that from the perspective of
cfg80211_find_vendor_ie() the buffer is const (not modified in any way
by the function), but from the perspective of every caller the buffer is
part of a message that is in RAM.

So you have to decide if you want to change the prototype to remove the
const from cfg80211_find_vendor_ie() or if you want to keep the current
semantic to cast away the const.

This is one of the rare cases where I think the typecast is ok.

/jeff

