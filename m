Return-Path: <linux-wireless+bounces-30050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31BCD5E67
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A906230194D6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67245309EF4;
	Mon, 22 Dec 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJlxgW0e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F/CnqIS7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705730F946
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404759; cv=none; b=HEpYan3CBTwRAjzENDiFEdEbpTocojtvzcQx1kGeQpq/37BWMMVvf9neUDWrtXYl/+Ea87k/JLJP7CgoBjkSc8a8q2o8BdJ8ytnNGccA20xnM51kfTvkQszPwJAPaLtcxDPF4HtqrvVC0dM3jmCQmEWsQaWkHkdq9m5No1KqcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404759; c=relaxed/simple;
	bh=ofm4pSKdI2hzccNt4etl+VEm9J7ZOsdp3C9/NGyesJM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ds6rFny8PWuZUUFfonetQ4gs1OpzKaFiDxXiGMLRYJspkgX+RNf8yxkh5w+YLaFCZyGUw9A6F26JgUfuVYitoQsPvw9oRmnmQse8AH7KmwQjTlkYIjRpFSb4ryJNzbjSpI8lwm5G0XEgguEptdg1fbDnwq6kTLsW4GgAoO2yAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJlxgW0e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F/CnqIS7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM8Hpd43841451
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 11:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FleiIrf3RRgyJnBCMq4247PwknDMKl3psal18cz4hHE=; b=gJlxgW0eZCXN3Zm5
	saPVJOMLxUEApt4QEP+QBmUqANzVZNdNJ7tVYthJbCduD1icieZteWrH/EQTi81a
	WzGi1w2SECSZWfgQNuFs2yMHA7g8v3iaBwDIRus+xWy8TgXhRxhtYN2I4YIigNpG
	s+KjPZvrNqzVB8c/X5VwF5Hjc4EGWgJ+hvqnfPYVpiYSGF7ckU9vkpFUpWwNeKPy
	/97BiyikOAwkDVgv/I0Qbyn3pXDUZ9cKiVoq1R+Zni6tWEFSk5NslfRdx9dr40JD
	YmDJc8+oEx/p/0nHvD59rPxp2+HZYkJVAR6m6CqXNZ3LZ0y/pTvgwPqElBYE7F9j
	h9zRaQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mry4u5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 11:59:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f26fc6476so65754715ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766404755; x=1767009555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FleiIrf3RRgyJnBCMq4247PwknDMKl3psal18cz4hHE=;
        b=F/CnqIS7TQ8R9KIfUY01iTt85Qn1lwO0+pApmcTwIMx40k4PiYwEBYfxLWt37/ylOF
         1sQmn2oed7b7QJV5OLJSPSje5sofFy9MfXg6o8qfW6/Izlwqt0Gy6S2lLydQZTgKY9UX
         XX73eZMfFIqR9atbj8c4WUSgrJpi1Qd+iFQpZlgCiNs78S3gPgUYAV3zAXUsuIOh4Won
         KjtO4OspWGKq/9Uq2OQLxSizHzfenDq5x+jlL0E8JEaVkYWD2YM0lnpXw2nMONT8ILqV
         i+rpTHCqTASVkugWpvI6WqaB3oSNi6uR/19tUfnQ3UkTZehWFQVj/D1Y/qyIe1jpZ/nr
         zWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766404755; x=1767009555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FleiIrf3RRgyJnBCMq4247PwknDMKl3psal18cz4hHE=;
        b=KhlSFP+AyybH4XYAaDjwYdS6q7ZeV/ZbGdsqfcNF5e809bOZnBmVornAMGbQaHpCBx
         SGywoYL2xWeLPpzhsG7U+nNb65DbaAVR3RkPD+5P54cb1xiHOmpGzoVWS6sMdLbClDK3
         TPKBWJotzZyNj67xfulTaJgEALMyhrxDXH/o1+sZJCR00MfuIl49AT4fxm7MsWMssnnI
         dKTJ2o76xvboExSAweXgqFcngUjetenaD04S1l9Gl8h/f+qo7n57f/9Ff7ToG3Adil28
         e9hMtz08S6k3QEfj8TG7zrCU3XWnpxDWK3ECSJvt2WaOegG2s4UH0I6xX6yaTEKsWi/F
         mN6g==
X-Gm-Message-State: AOJu0Yz8YOsiaKhchCVQfgD8eXV/2YjeUtOdxFMiZioUa6kaRNunGhz4
	lHCcK5PnrYrVFGTnJcWPv3OY5iWAKv9JJdP3EdnTvf1a3vrJk1Ze06URKyovyYAUPnlBw/6um/E
	tzhWWuWUwgtNPxW3+FvaRuzUVjEt8eAq3s85kW6PlN0IdnXX+XBjqWcvItJP85YGmMIoMMw==
X-Gm-Gg: AY/fxX7LAvJUADsgJu2awa+rW1VhXSXE2HqPZwEc7wKrchl7+FxhIemW955cpP/jx/p
	RZiSmLLn8a0xWVIjiOhnmGZ6ztSXFWCswff/NZbQ14fGDbxlfTtqlDoz0+hKCTAPqQ5C8ukhFuI
	2hCaxprAhFQhLRqW5rJI550iy/EVKZULyoZ1xx5MrhTx8UbQ6gFSDTBP5UhGU9Vlrz1pivtub/2
	5bZ2u2dOSbejf7FaqFmav5t25zep/47/dHHPXs5/ZBebV5i5L1/U/H/lhzwnij3NEEbNVYsJQyr
	sKsw+w52q097NaxKeFrqdu5Pcb4kOeQ5jQuQW6kyEAMft8I2wIsCjDPOvxRw3e7XxHsC/K2VTPi
	mE+N3DFGV1ilfLAu7dVhtSRNnL0LWB8driczl7S94gklqToeU2dA=
X-Received: by 2002:a17:903:fb0:b0:2a0:de4f:cad with SMTP id d9443c01a7336-2a2f2c4e714mr88366505ad.60.1766404754773;
        Mon, 22 Dec 2025 03:59:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvGdYiOQsw9COQ2ME5/ptrOPMcZPK49DTXWh3CxepKgkGLx47+qoTfzsslNBGQaLcm+6PxHg==
X-Received: by 2002:a17:903:fb0:b0:2a0:de4f:cad with SMTP id d9443c01a7336-2a2f2c4e714mr88366295ad.60.1766404754231;
        Mon, 22 Dec 2025 03:59:14 -0800 (PST)
Received: from [10.151.41.188] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d6ec60sm95149405ad.86.2025.12.22.03.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:59:13 -0800 (PST)
Message-ID: <10918efa-88eb-488b-ae21-35db29e6017d@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 17:29:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC wireless-next 00/13] wifi: ieee80211/cfg80211: Add UHR
 (802.11bn) Capability and Operation support
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <07cab823d7695b20aa7ddb1b3698e5eb88ff2c9c.camel@sipsolutions.net>
 <feb431cdbe7581e4e961f2033606bb6fe4d90199.camel@sipsolutions.net>
 <910a50de-b00c-4bf6-9682-1c73826635d9@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <910a50de-b00c-4bf6-9682-1c73826635d9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cbbfb3DM c=1 sm=1 tr=0 ts=69493293 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Pga4Yl9NeCk96JCWn4kA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNyBTYWx0ZWRfX5WeC1YCUdKNH
 Lp7D4ys3Oz/nc5LFAOQV3xHe4Z7Pa5lanGSDZ4oyz14MxgtjjutE3f4o8bjzvRahMSBwJzs0pN6
 tjmx0sKjxVEO2kloVBMvDt1mRk2qxPbMpF8VB/G06ExuDg3j69J+wWYP7Zdk9vhS8x4oapccEgm
 V3oKE0unoxtEE+SwB3OSRU3TtYBT3u4DpeGfUmd1Qv6FJYleUDrHBDxOEshqrR67PTC5H0/tQJs
 irmeTQw4NtVn0q5CIlgO/wEVsTNv1DCpyKJp6hjtVlg80e9ZI35otg9kRt8rd5swzJdTV3u9Rzq
 +DxEuJahzl22m7OrGv2V/R5YISS5r2H561xrdoVgYrgow7nYR4bML2PUJvxcECz2a6rXZ5PNZXi
 FlECrg1qvxXbrhIv5iv9EewysfIvoxfK5/qCUcde69c14iAxgbYtCZbsyi5ZQHTUgfDVkMT0aH3
 wwVWt6GPwgQ22wjuZqg==
X-Proofpoint-GUID: tva3J7zAp-gwnGXuSF4RHY3CkL6Fkw5k
X-Proofpoint-ORIG-GUID: tva3J7zAp-gwnGXuSF4RHY3CkL6Fkw5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220107



On 12/17/2025 3:35 PM, Karthikeyan Kathirvel wrote:
> 
> 
> On 12/16/2025 2:42 PM, Johannes Berg wrote:
>> On Tue, 2025-12-16 at 10:04 +0100, Johannes Berg wrote:
>>> On Tue, 2025-12-16 at 11:56 +0530, Karthikeyan Kathirvel wrote:
>>>> This series covers support for UHR capability and operation (11bn)
>>>> advertisement in AP and STA mode. The objective here is to give an
>>>> idea of basic changes needed for UHR in cfg80211/nl80211/mac80211.
>>>
>>> Huh. I never posted my version, sorry about that! I'll see if I can do
>>> that soon so we can compare notes, but I'll also go over yours quickly.
>>
>> For what you have, mine was pretty similar, not all the naming
>> (obviously), and you also have a few more definitions for DBE etc. that
>> I didn't add since some were still broken.
>>
>> I also had the rate calculation and more ELR stuff, IIRC.
>>
>> Anyway, I'll post it soon and we can see that we arrive at a good
>> combination.
>>
>> johannes
> 
> I received your version, I will review the gaps between both of our 
> patches and get back.

Hi Johannes

I have reviewed your patches and listed down the changes which are 
missing between our patches

-Johannes-
Defined EBPCC and SMD Info
Handled UHR MCS, ELR and IM
Handled NPCA in ieee80211_determine_ap_chan()
Handled STA_STATS_RATE_TYPE_UHR


-KK-
Handled DPS, DBE and P-EDCA in ieee80211_uhr_oper_size_ok()
Handled DBE calculation in ieee80211_uhr_capa_size_ok()
Handled parsing of ieee80211 elems differently for beacons
mac80211 hwsim

I can add your missing changes on my list of patch series and send a 
next version, please comment your opinion ?

Thanks
KK

