Return-Path: <linux-wireless+bounces-18168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD76A22493
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 20:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF1E3A224A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 19:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E455158A09;
	Wed, 29 Jan 2025 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QvrfNZf3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BFD197552
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179058; cv=none; b=K5V/Mrow2YCRkl0FuPLvBXkWuAXqpEtcWtYBzyzdNFEb/J9OW5fJ7eb42eBW150fLlKQ7JcrqOMbu0S3xrdPcXpEV3K1rHs7+QZUhAr9GukRRKSe0tmLTXHffESqotg54AzmTY9ZfhRx7RvlO8SEcXn3BHUy4c3KUwQgIhKvgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179058; c=relaxed/simple;
	bh=hB9dNw1dj+ROGYSlJH7F8r3X6rGmU8kqM4JJg6CxxGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MnOjDFcBdnZf5WCAK9PBr7ocGBhYrHNgq6cY1qJVU4LBzeERVXjjbpCBNUE7HmOzRRgJZVYBRwUpmZaeT+2SZEyCP4LGYuJ0WiMNNNbf7i9/uFb09uhRSZ9CnOrgrOAmxxXObNn6JHFwo9iwY2T4nAD+aXIPLZ0arnJxQP+htjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QvrfNZf3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TIXMlL021413;
	Wed, 29 Jan 2025 19:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t5zAxQbACyM6wJZKsUBJnL/IIfNHWJKjt9GVA+vzAyg=; b=QvrfNZf3nGy+eCnN
	DS7CTA53hjEvBElynFWStcHokhLknjCKymaIwr/SkAxK+03qowW41dreFzsEBG0a
	gy4GQ4Z70oIZKEMLY2i+wIQe0dBFlJfz7eDJORkP4XDJozoN6Bf85QN85XgQErIR
	77S3GI+OGhr9egvX9OkfmkO3Vefe72zFWXY85SYFo20vzZmmzEo9FO/FjUDnjR7V
	7S9d/ykC0g9+30bRpQS//291nlQ09A0o6GnO1KuTLuAxKh5fjJavCsSt3Bv3OcrB
	o7UIMrtJSlL517Mj7D/1l2QjpG5vXTNYd6bt1EBr40e1THvPWY66uAwb+4FIaJvl
	+1tRrQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fsq285ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 19:30:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50TJUnLA018036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 19:30:49 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 Jan
 2025 11:30:48 -0800
Message-ID: <dedfdb8e-c5b4-42fa-bd76-ca866ab1cf41@quicinc.com>
Date: Wed, 29 Jan 2025 11:30:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/9] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Muna Sinada <quic_msinada@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
 <20250114003813.2783550-7-quic_pradeepc@quicinc.com>
 <f5c6d874e9d7682d52c5ed107a0ede952b5cf53f.camel@freebox.fr>
 <5861c953-436e-4f36-ae8b-5ef52fceb3b6@quicinc.com>
 <2aba18dc3448b5a60a1a06b33fa591e562927693.camel@freebox.fr>
 <961df6e7-0b5c-4972-9324-5c4d430cb172@quicinc.com>
 <54d456f00aa8a806768099df55dc9f2ef734209b.camel@freebox.fr>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <54d456f00aa8a806768099df55dc9f2ef734209b.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fhCo870AM7CgWl2gZkp4MvPBHhtAzAOG
X-Proofpoint-GUID: fhCo870AM7CgWl2gZkp4MvPBHhtAzAOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290151



On 1/28/2025 11:13 AM, Maxime Bizon wrote:
> 
> On Tue, 2025-01-28 at 10:44 -0800, Pradeep Kumar Chitrapu wrote:
> 
> 
> Hello,
> 
> 
>> Currently default is configured as FORCE_SGI
> 
> "Currently" with or without your patch applied ?
> 
>  From my perspective:
>   - without your patch: DEFAULT_SGI
>   - with your patch applied, no fixed rate: FORCE_SGI
>   - with your patch applied, fixed rates: user decides
> 
Hi Maxime

Yes, your understanding is correct..

This is detailed explanation.

In 11n, 11ac, the supported Guard intervals are
0.4usGI (Short GI)  - enum value used for this in firmware  - 1
0.8usGI (Long GI)   - enum value used for this in firmware  - 0

If peer support SGI, param_value 1 is sent to firmware where firmware 
switches between SGI/LGI based on packet error rate. This param value 1
corresponds to NL80211_TXRATE_FORCE_SGI in nl80211.

If user overrides this by setting default GI specifically, then we will 
override this config to send enum 0 to use LGI always irrespective of 
PER in firmware. Using SGI would slightly give a better throughput.

FW uses 0.8us GI by default for 11ax and 11be.

Hope this helps!

Thanks
Pradeep

