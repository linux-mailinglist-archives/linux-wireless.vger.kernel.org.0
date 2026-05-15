Return-Path: <linux-wireless+bounces-36460-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI7ZJtH+BmpiqgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36460-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:09:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E696554E1BC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC19308DB9D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D52946AF20;
	Fri, 15 May 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HY2l0Gaa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dy6qCKYu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFABE46AF00
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842377; cv=none; b=O5RqfcVxmFTNM38C36Jgsl+KWYiGSXwhs8cZtwMWOcYmxvzxOIdrDx8vEYZ47a8zIvFF6MFipvtZ6TnB1YQCvEkJtPa6YPFMOjqv5SjyIuTwa3abt5DumTPTU1LxrQezXVyS3I7xs1qHjzP8NATd2xYTVCAjZ8aScyYifAp4mrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842377; c=relaxed/simple;
	bh=GYRqtEFORIGvBXtjHRIEjsIKBIBEvrSiUzkUEEbUTL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFCs3KOG9jMm98/SKAqUpp4SESeuteZqoN4hH6LEy4D6fVl+O89w1RQJaVQU19udRcyboIQCNAHjytTbx/8oAGn61+YQsro1fcSjXzc/Wlm5XxQGP7d1mdvscx8KxDaHQArI8G6is4qqWkzQH7Yg1KuVUmL3CuN47hUkXSoEcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HY2l0Gaa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dy6qCKYu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F59pPt1847949
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 10:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q74vIe1vHtsQlNs4raX5h9oaRxwa1dTxwCCq8Ygatgk=; b=HY2l0GaaIOTOInh/
	lFpvlr8nwTsjS56jmB7h0lPRnvOanPA/m/eV3BcO6oG5eMK2vPQdUEp4gJNnF38m
	XPzngmatmyIHiMrJLkxDkdoF9xrC+Zt57rUipSc9dzWg2ZtPCDLvK5z2inJTgk2s
	BFF7u53xBs69A24v+0fL4xvXgxXQcmj56gtNh+ADEYvzie4wRTuJhfo9WLqiSLgO
	x8ipv9BeW8TNAncwLGXl93rgMkV7kSccbsmAqP4Ue8JoLqb4C2iEXvBF+MW2wHRG
	vKb/vFWvPtSn0sXc9zf/MKjZnIkGMQB8PScv4STA2Qj+xP1qY6j9oorZJBfepGDW
	/gDJBQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t2vpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 10:52:54 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95cd22ec862so500055241.3
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778842374; x=1779447174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q74vIe1vHtsQlNs4raX5h9oaRxwa1dTxwCCq8Ygatgk=;
        b=Dy6qCKYu1gTJSyr4LtWIPQP1jaVOpQNHWWlJPvt4VGpvc3hM1AeulShAAdHtl5VWXj
         BXoDt1A4oSXHl0zuBQsr798O/t+63Zv+bDM83D8d86kZ06kB5g/ACDnkoCWozsKZWNWM
         MvVqrSTUlNXoFFfrQMZMGYJZraJo6FO4BTH7FfIxSfFWc6J/l2FHsYXreK92OhUDbg2S
         KKzmkDBPL8x8xzF1u2cB7EDDiWXfZ954sa+Vik7yeygDKJ2/VQv9zsG0E0e7y3LjPT78
         6iZnJ4CxPSN1AeaY6Fn/k4JVPS8Xi9Bteh9SrhKc3dFHQhdIbi3g6cSqE1XixuYLPOWU
         tQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842374; x=1779447174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q74vIe1vHtsQlNs4raX5h9oaRxwa1dTxwCCq8Ygatgk=;
        b=YzrTuvLtUFYOJuMwiPUlK6NxBnRmqJDaLVIlRs4ubMUUquYMhnYuCgt6ATH3Hj8HtJ
         e4ciYaTKSfCYrElYRFXsHbNXgcr3IebI2lL6sj7akpqyJ/QR5ZBOJ/Sdns8kWVtxqc+f
         IPjHL/oIMOYkqb6jO/4pVe2iSi9PN5Nb37NXUff/TDk9c76FvEUV18I4sPTKj6jJWnRf
         ag85D979paB68GmqVHvjpIwktFqZunKwOXDjwX80GBShQby3z6rYKVdh4z6BX5WXpcXT
         IxWh1L1/H6PxZYL9vBC3qAutYV2Vb2xM4CBzXLc4CsE4yk5EW//foYK9RXBfgV9E1SXm
         DILA==
X-Forwarded-Encrypted: i=1; AFNElJ8jY/44q33/pJvt+X5GID5JBa6PDmt4rdvgW/PlkzgT3w/VFFlf4CKT+3w3NxwMqSOSx3BReaiWFgFexeGh5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFeGYihZmXSxj5Wol1tpu9jneRJ/Qwx0KoYs096cCEM2gnn4Y
	BlfAZoVNuSLMwWeSaFvmoNL6Us6Dhlfwibu9IucICZQ8OuHEqdMS3cRTuOdK3cFJHPwENX1MMmN
	kDjxaaNWqgZo9bQylYe+P7smLPFybCK9UlNf3JY9QOB5y+V5vzk+GlbqenfZIblj0wP0adQ==
X-Gm-Gg: Acq92OGf24kJ1qi5fSQKuZATCoLiZBvu9WOiZzc7HfvNrpmLHz0lWWXJUipE5IgsXis
	B5Jj79ozQwdejq7I9QphWQr3REy8s3rKxDoXF0oJ+F3KkslZy13p5KsUFC3J/DReHu0jJbSSQM5
	+s5oAPLR26Xnhq5jmWXC/f9/STsOPPnUBG4vjpshsz0EZsRS2rBfTrx61kABgL8K/G81YWcuPNC
	8O6Tg8qqTyM9xkryrBIleJ94/q/gW5V52dxDsjQeNI69GYUuw/gPQHCRyo4PqFe1Khq+4tLlqyq
	9oHfiRsGvNKqbvm1IucNdBYtY6biEhrmF2AVrK+/hPAcyyvtn6xH1xoLoNsMP+WOEi6/CZZOxz8
	P45SFhdtln2Lynzidx8UPlzu1w1g+N+ycj8Vd5DvpQAx+nzCJjecgdFMw0555gcdqpElxpuU/eF
	7sYxg=
X-Received: by 2002:a05:6122:6117:b0:575:dcec:efc1 with SMTP id 71dfb90a1353d-5760bc49d2emr517885e0c.0.1778842373938;
        Fri, 15 May 2026 03:52:53 -0700 (PDT)
X-Received: by 2002:a05:6122:6117:b0:575:dcec:efc1 with SMTP id 71dfb90a1353d-5760bc49d2emr517858e0c.0.1778842373403;
        Fri, 15 May 2026 03:52:53 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd1bc9sm212603566b.9.2026.05.15.03.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:52:52 -0700 (PDT)
Message-ID: <bad20423-de93-416e-896f-002e7c05e4ec@oss.qualcomm.com>
Date: Fri, 15 May 2026 12:52:48 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: milos-fairphone-fp6: Enable WiFi
To: Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Alexander Koskovich <AKoskovich@pm.me>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-7-393322b27c5f@fairphone.com>
 <4fbs4arx6sez6fffy75ctmzecfvitr6aocau3cczlr2ps2ptld@v7wpa2irsihl>
 <2514523f-a43f-4470-a69b-3d5175d10385@oss.qualcomm.com>
 <DI789NOBWJHK.1V3SFQLCFLS4P@fairphone.com>
 <870d16bb-b426-4285-a299-deb09ae90243@oss.qualcomm.com>
 <DI9X9D3TTIRE.1CGHQI2LEZ1UL@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DI9X9D3TTIRE.1CGHQI2LEZ1UL@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a06fb06 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=jmRdrQK5CiodBuYeE2YA:9
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExMCBTYWx0ZWRfXzgSqYrcqojGc
 X/G5Nk+byKLabvu0eVkdMa01S1dx4HssR55cfuZGqO1Gkjej/P901zXNpvGDsRhIk+e/+owuIxZ
 3CgfPCVEEnUEpm+b2GU1cT0t+Nvi6rb7CsL05qoTEDGNt9I4kbiHYXrxco0q+ZqxujuryikeXZ9
 G/19rngJrlsXCRSLnPIapaO3MyOTsJ7VwvdWzmUHxgEyMvuqWiX9GdZW02CeCb+b9upLylkQPg/
 exuy18O34EQLQ+Ru0gwGxpUl3dRJcvyrH83uQWC2djkFjBn8FRjmo39uierLGJvPbKKW9RBOP++
 Hj1kB3oP0ZG7WMI5LIaFdrGGNTK3i/m0RbpJ4oasx+d5s4Jd6Qqiz8UnIT1EI3GMPqGkFuG7ctj
 TcbKhhUSZCqyE0ue2kOVrk5GJMDjxIcF+aySlKa0KyTA0OeghgYKyFsiT309l2p0346C5asV3bs
 pzvbirLR69XAvwx65Fw==
X-Proofpoint-ORIG-GUID: k13ghlQtEGgOuPfoyNj79_Rmif4rb-5F
X-Proofpoint-GUID: k13ghlQtEGgOuPfoyNj79_Rmif4rb-5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150110
X-Rspamd-Queue-Id: E696554E1BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net,lists.sr.ht,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-36460-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,fairphone.com:email,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/4/26 3:21 PM, Luca Weiss wrote:
> On Mon May 4, 2026 at 3:10 PM CEST, Konrad Dybcio wrote:
>> On 5/1/26 11:20 AM, Luca Weiss wrote:
>>> Hi Konrad,
>>>
>>> On Tue Apr 7, 2026 at 3:16 PM CEST, Konrad Dybcio wrote:
>>>> On 4/3/26 9:35 PM, Dmitry Baryshkov wrote:
>>>>> On Fri, Apr 03, 2026 at 03:52:53PM +0200, Luca Weiss wrote:
>>>>>> Configure and enable the WiFi node, and add the required pinctrl to
>>>>>> provide the sleep clock from the PMK8550 (PMK7635) to WCN6755.
>>>>>>
>>>>>> Thanks to Alexander Koskovich for helping with the bringup, adding
>>>>>> the missing pinctrl to make the WPSS stop crashing.
>>>>>>
>>>>>> Link: https://lore.kernel.org/linux-arm-msm/DBF7OWAWQ94M.FSCP4DPF8ZJY@fairphone.com/
>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>> ---
>>>>>>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 19 ++++++++++++++++++-
>>>>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>>>> index db72418b7195..d8ac495ca7c8 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>>>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>>>> @@ -242,7 +242,7 @@ wcn6750-pmu {
>>>>>>  
>>>>>>  		clocks = <&rpmhcc RPMH_RF_CLK1>;
>>>>>>  
>>>>>> -		pinctrl-0 = <&bluetooth_enable_default>;
>>>>>> +		pinctrl-0 = <&bluetooth_enable_default>, <&pmk8550_sleep_clk_default>;
>>>>>>  		pinctrl-names = "default";
>>>>>>  
>>>>>>  		regulators {
>>>>>> @@ -766,6 +766,17 @@ &pmiv0104_eusb2_repeater {
>>>>>>  	qcom,tune-usb2-preem = /bits/ 8 <0x6>;
>>>>>>  };
>>>>>>  
>>>>>> +&pmk8550_gpios {
>>>>>> +	pmk8550_sleep_clk_default: sleep-clk-default-state {
>>>>>> +		pins = "gpio5";
>>>>>> +		function = "func1";
>>>>>> +		input-disable;
>>>>>> +		output-enable;
>>>>>
>>>>> Hmm, if it's a sleep_clk, should it not be handled via the power
>>>>> sequencer?
>>>>
>>>> If you mean that it may be needed to toggle it with specific timings,
>>>> possibly..  seems that WCN6855 has a "xo-clk" GPIO defined. I requested
>>>> access to some docs that I think should have the answer, hopefully should
>>>> get it soon.
>>>
>>> Did you manage to get anything there yet?
>>
>> Yeah, sorry, it got lost in the sea of emails..
>>
>> The PDF talks about the electrical requirements of the clock signal and
>> the section titled "Power-up sequence timing" doesn't mention it at all,
>> so my assumption would be "OK so long as it's ticking before you power
>> up the WCN"
> 
> Thanks for checking!
> 
> Is this an R-b then?

Yes

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

