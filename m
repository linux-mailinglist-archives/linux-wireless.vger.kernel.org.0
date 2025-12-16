Return-Path: <linux-wireless+bounces-29814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D43CC4227
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D360830E722A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA84357703;
	Tue, 16 Dec 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SmQ5eNN0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AKo+HXA1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722B3570DF
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898023; cv=none; b=sIqp9JDD2bYGgjcxxlB/uEg7WbNrSpA2c3PieVAWmhSJTjTAyUgAfSbbhF8YvoG1K5Rr07ExAZMwV88Cl+XgEKOp8wASplDzeUH53opYJ9ucLTeN+B6J4STwkXW+5x/xxofIaj8kZplTpJB7bC9Ag3wYx8h7IkvCG4SiqjiK++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898023; c=relaxed/simple;
	bh=139Tc1NLAvH4U3agfnwzRhpCxcfycIfj1AKj/hkdbH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxIie9/Mr1qA2TB4Otr0lgJOWv0Vnn1Ese0TddNlMr6hAI3uvaYG0tjfL6ONcQ29TlfKDfyVKYYWpFXQC6PopWnpz87uf1urYut4QGvXh7GLUh2e8wJIvY7TK89WHagUnRzSdTScxx45qFhayIHUrzQz+nhVmBE55Mxad8tUag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SmQ5eNN0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AKo+HXA1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGAXX8A3598207
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MokaX9jIO2Z6Z4bwt+aQQydeIW4v30jB+xkrqmCbfgs=; b=SmQ5eNN0CU7QkRHF
	eHgHGZITNEQu9bowDQOb6jDNwbkbCEOqX+gEJdBCFmMm7G3VTt1SCFqoJ0HO/Ann
	6Qac36gQaT7dn4Kvxch8QMDO8Iorf49xZdXpj4Qjait1GKQybTyLSKYdazFZKXlP
	T8kNZ1Yz4xX0moJlxDhinfOjJgk+8uAA9rqR2Yo4f1Oc/a/wsAsQItf2Exa0kbPG
	c84J0bOWBJOTqSfkAj5PqwqAfhij8yEXzKpsi5+pZ6khJOdBFmGpDkhptqXM3SZy
	tyrDfwLnmXtmZDT6eEzKru03SWxEsF/YFFj6dmyPs2rl/rsy+UUQj11A/RoDZiVH
	ocLyAw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b35se0yu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:13:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d6193daso5969315a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765898020; x=1766502820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MokaX9jIO2Z6Z4bwt+aQQydeIW4v30jB+xkrqmCbfgs=;
        b=AKo+HXA19U3Cp/KSQ39vNVGMFwQNPpnu4vLxV9coL62d2BlVZLSnQw2ASZHvaIUL1q
         YV819QNj/vMga9fVX/FviZllkGmFG80/CMGNBnUg3k+MTYCw6+0PkZl8KoSg/cD2fsJ9
         dcIltfzQFnpeehwIo44H4w98NDy59h0iughmu6NqUg25Rg9vUuTUYYsujM5sZHx0D1xw
         dpIvhAt1vldwnVYAdNgmtzpj2i1z/huD7eIqDI+JC4SKWtn5xIpQMQmZ50tMWHuEpkLc
         XVhjxys6wZOS5MpgNhttzXL1Mwlznst7+Py5UHOdViDGZRHa5g7zxN6eIuaLJPOUWVub
         ADYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898020; x=1766502820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MokaX9jIO2Z6Z4bwt+aQQydeIW4v30jB+xkrqmCbfgs=;
        b=hxOekHRwXqJpUyP7wWZCI9BNis5w2Qdi6CkyUmwwJcA9dZwEPDS/8QFVf1O5w+RPMO
         /6COHfVV6NNkkdvNPv+/9zWeuHOhnBrTnvYqaHjJDE8LQoDGF+OFAmqsCNEHPbO8Ah6C
         kS1RfqdZKpnxfq41cLgmFTnBjSzsV2mHrP43tDRLk0w3rKwnZ3DA7mspLo59IPInVdFl
         ROIwugj9Cx3Ovyeo0Jd4NOgyadVqXGfMr7aIiYCwM20ofeMJLKgP6RWkj1oQpzQMBSex
         E+DzW8qKwj+tRsX8Iffe+2xVQaBkK6fERSUePnf5qoIkEHpz7O+ED5d+0Z6GN15H3DmI
         eoqw==
X-Gm-Message-State: AOJu0YzF5sIlqLoCohmYPzA7Ek/1SbSmpHz2mKWnGFdo6AIqJ0/3TfHY
	Jq2ROPPdMXUWjSXjBcPYTrforf0oJXk09lOidZhRD95/it+dsACVoC6pkT04k8weLHAUV7CmEun
	SYNeiJ3vGFr4ZFvsF/xmfP/NucJez9DP8ngyCBdY0a/j7rgoIigt2UHtmEfcH9pTXzdA9Jg==
X-Gm-Gg: AY/fxX5eMPRIioHOGuaVl4O/+4H/lysZZrz1i4crgMMJrwRD2D/Otq0lVcJ0CAdgkaY
	GjjGL+Uc7YBlkga495lc6cM7tiFL9BTN6Gll4rmh45FLbja1WLUI1Tj7PIEaigHs65PEz2DEeIx
	yf4xtJ8qSPhxtKPeryf5jXub9wCe2hVKrU+5oAaGleXeaLYALnxiLDGA1XJudt2TjY2vDwzr09Q
	KKbv0SjG7awAjNM9VGHPmkJrMqHFDFrLM1tOURsjAIp66faWyAeaWKXbKSypesEWlRPU2a971H3
	HQIlPdj7qcCec7lC2wd3tLJL44oGylEE2J6lrk37TPlIa6A1KS33lhmmNh4P7XN0NK7r2nWmpRl
	DKdVLZ33Dpl0SAMvCoqCWFFiZBeVreJJBAL4F+RgLdBg=
X-Received: by 2002:a05:6a20:1611:b0:361:79fe:19ad with SMTP id adf61e73a8af0-369adfb3680mr11442734637.20.1765898019715;
        Tue, 16 Dec 2025 07:13:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB5Ytsp5x16HIv6Dv1eTjssru6w+8QViisSpsuH0c+pWlqwiHZO4YRD4zlgdlrHAWRaEE8cQ==
X-Received: by 2002:a05:6a20:1611:b0:361:79fe:19ad with SMTP id adf61e73a8af0-369adfb3680mr11442699637.20.1765898019121;
        Tue, 16 Dec 2025 07:13:39 -0800 (PST)
Received: from [192.168.1.10] ([122.177.242.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2c582e86sm15539728a12.33.2025.12.16.07.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 07:13:38 -0800 (PST)
Message-ID: <2ab842f3-bcc2-409d-837c-5635e5e3feab@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 20:43:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 09/14] wifi: mac80211: add MIC generation
 support for EPPKE authentication in non-AP STA mode
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
 <20251211124051.3094878-10-kavita.kavita@oss.qualcomm.com>
 <438a3bf3725c66615fb2a9922845a2bad0245993.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <438a3bf3725c66615fb2a9922845a2bad0245993.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CSFHupZa3ONRS-Qf8GyMsrJgBk38wXMV
X-Authority-Analysis: v=2.4 cv=ar2/yCZV c=1 sm=1 tr=0 ts=69417724 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=vaJ6/3d+63OnhzhRW74whA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=xM-acJg1v8Oeq0Nl3nQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: CSFHupZa3ONRS-Qf8GyMsrJgBk38wXMV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEzMCBTYWx0ZWRfX+vNZO/A6Gy+o
 RVNFVIn+vFD6IBrDRw2hWrG2s3Blt4qddP/pp/2TFR4G170lcDZzf26J7Xufhwux17FL6dQU115
 XTZPcCHmdwAgtUZ6B2MQ/yiPupPyVX8UOgXRQrLurXHk8WoFnsA7WnjkP5lNiQCFgRdOHgXavIr
 NCdGvYTbUbFtD/XOWBVzat6N9QdvA7DdHMMPMy4H25jn+imL1ST999vydlJ71g1yqDBS8Vc4u8T
 MWYKPoy10owVTGdOC+GQc+713YLSZ/Murl+PTtJ1cW3/qUaCILDfmUE94fRp7mL2vkvJ/2V+nLs
 itjjQ5GDW91GF20cl3IHR+kdcZKVJpLsXQQ9wQGP0RjWI02IUiMi7dimWxl63t8r9+s7LfD09Om
 AvnStBTRwmZS4kmWD7H2hSTPHpfadw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160130


On 12/12/2025 6:04 PM, Johannes Berg wrote:
> On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
>> According to the IEEE Std 802.11-2024 specification (Table 9-70),
>> the Message Integrity Code (MIC) element must be the last element
>> in the authentication frame body and is present only in certain
>> authentication frames, as defined in Table 9-71.
>> For Enhanced Privacy Protection Key Exchange (EPPKE) authentication,
>> as specified in "IEEE P802.11bi/D3.0, 12.16.9", the MIC is mandatory
>> per Table 9-71.
>>
>> In the SME-supplicant case, userspace constructs the authentication
>> frame body, computes the MIC over that body, appends the MIC element,
>> and passes it to cfg80211 via NL80211_ATTR_AUTH_DATA with
>> NL80211_CMD_AUTHENTICATE.
>>
>> In MLO connections, userspace constructs most of the authentication
>> frame body, excluding the MLE, which mac80211 appends later in
>> ieee80211_send_assoc().
> Clearly you meant ieee80211_send_auth().


Thanks for pointing it out.


>
>> If userspace computes the MIC before this,
>> it produces an incorrect value over an incomplete frame body.
>> Moreover, the MIC element must be the last element in the frame to
>> comply with the specification. Since mac80211 appends the MLE after
>> the userspace-calculated MIC, the ordering is violated.
> This is all a correct and good thing to realise and ask how to solve it,
> but I'm not at all convinced that the answer is to put 300-400 lines of
> crypto code and key handling into the kernel for it.
>
> Might be easier to just have wpa_s generate the MLE, and we simply have
> a flag that indicates the MLE is present? Or even just check if the
> element list contains MLE for when MLO connection is requested? And if
> userspace gets it wrong and creates a MIC element w/o MLE element, and
> we do MLO connection, that's too bad and we'll send a wrong frame? But I
> don't think that's a big deal.


We initially followed this approach because the MLME resides in mac80211 
and,
in client mode, the final authentication frame is prepared by mac80211. 
Since
mac80211 was already appending the MLE to the authentication frame, we 
assumed
it would be cleaner for mac80211 to also append the MIC element, rather than
having userspace append the MLE.

However, we’re fine with the approach you suggested. We can move the MLE/MIC
handling to userspace instead. On the mac80211 side, we can simply check for
the presence of the MLE in the authentication frame, rather than
appending it directly in mac80211.


>
> johannes

