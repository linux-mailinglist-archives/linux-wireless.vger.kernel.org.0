Return-Path: <linux-wireless+bounces-25663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4322FB0A5A2
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD61678F0
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A22417F0;
	Fri, 18 Jul 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/AMT58u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED615E5C2
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846929; cv=none; b=EkMibL+9RWrL86CT90vh+nfT8hstzDhCSiqK2/slCTIHyEMKHiEpq1QgHVvB9BHVh/CCC4TyIqKlyuj6aPyiLqCxnVSJYOeoFZ7E/zZ3gu4V258FJ+MKB9U/32PF+Xm19bA+nILjzoQhGJPtBgU16au1uHdhgeU3IsDa82zEQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846929; c=relaxed/simple;
	bh=Qlqj+XMIwehuGlzE6i5iV6mBurCAQHUN2SbwfBNCBLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhURVIZ26KlDBFGk/ldpvog4rQNtWfKTHJrd3K8rH3lVhJs8vBmke5Dhl+Ozp+lYRy+CfNL05JdWB5V4Q2QIShWm/Fbksi6fEWiaFKco75yzInmGpNsBbXxiJCG77VCnra5xnzjtppsz8s+EDwQrscXoFSd5Ka0xXq0QKEEql2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I/AMT58u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7dFnr022405
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 13:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P5dVwGg7k/V3B5EcnOn+3OotY9camqoCaUdc8gx4guI=; b=I/AMT58uIXI0oiOw
	STO29vzgMdf6dymZtKynzl4+BHPSgLHKqdWA7TVLqRkodv2T80v9H8wwrMa1dpeN
	QwMHre2koZI/rWovRm3eeYkzY437Sd+ZUHsuamLa4AL0f+dR2wcK9HGBk7GZUIJp
	8lPw4nP7h5cMjNU1KvErKsqXap4N2iphrnOVPZYZlYnElcoqPFR+iUAmttFUBGhs
	GmpLcYzRDhMKXhp7l+8pp/5apCyxCfU+LZDgcDQppY5IKlXLn5BFj6uWijIhNzSR
	yq4QQbf35MYWBbpEQemMNnD0Sc6LiZBG5mHqmkAVY1JF9+xYXBaetyOd85ql1hmu
	W3J3Vg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsybrx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 13:55:27 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2fff642182fso699764fac.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752846926; x=1753451726;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5dVwGg7k/V3B5EcnOn+3OotY9camqoCaUdc8gx4guI=;
        b=v0M4EDsNm49GFIQrvXIcDwd8fRZqPYXp7pVuSLZ/KSpwGvhMAb/xJ7kmwTLz+90uer
         K3pZKhzfKY9DpTCqb48B2+WkJCrKlN9bGLj36JIwzRKRmytGF7l8Nug+Rl7zF6eA93ID
         3vxTYwmZd67N5aTvqx3o8sGxD1e8Bb+pnzqSYEMCe8BoeCmxbafH21uYBlBii6Rr1lqx
         AW5zf6A4qie/9IcOs2drfipmdaShxLZZp98nW8QCbiW17jrRAnWfpZJqt2XJrlLcb2ry
         GU4avE/SEyTfKelK/P15aB935GRGCxATpasKARXnoEC0blX2Fje/dsAN+4GQWjNM+ZR+
         Zj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmdvgVQDtYlWX5BHkURb8zNcjdBLGMBQCuDz+GpkMBE1XYdP93QxcDIZ0w3S7cc0guNbUrYanFNntEM4ruvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwS8gB3pVb1MF6vZDD/r/JJdTJYHRb9egB7KCQx0rDY4DUJij
	Pz+w66vSV81U4l9xx/uQBQlrHQit+61uQoQfS74m988oF+dxFy21j2C2WUaqOpKlZBFqFpA2v6M
	X9tdviEuFAz4ANjSrLj6Df1OGZaOfZgIbMTPpj/hB4UIAllMGToafxYRK43R0v7OUpia9zF89mF
	AWqQ==
X-Gm-Gg: ASbGncuneUMndBa6G0CshPADBpAHSQqEUqlGp0KA/noMXy9/qvI4W56iInHKC9yFUeT
	CrYILlq72vXHxXk1O0nOMRTrjH28hWI6pdhlXnnxurpJpCMlC4KJQf6x2L2Se6SzGlYLYTEnTgB
	ER0s3Zq633GFn2JMVwN0siI+OJUoPjOI2UQSW5ePVvklpvOA7F0u1yhjf3iD1hOzp7g+TEXv+No
	9bzvY8lopcDgBeBFBuV5jjw9Jzw5a1PJmOqnBr08xqejYX+qMTggDIC5xHGABtufEnnK0RvLRFX
	LE3gIN+joxMiYbVHljvMzEQr1MOVGX2N27pEqccJdPMKOciV6+6oYh+Zbi5eP6D9G8Q6/OioNYK
	uyj/i7EFTlIIedGSh/uObmE9ZUmKCYzQe
X-Received: by 2002:a05:6870:b906:b0:2ea:6f56:5c1d with SMTP id 586e51a60fabf-2ffb1eb547amr8793145fac.0.1752846926004;
        Fri, 18 Jul 2025 06:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjAMr+J1DWlVlDBeNSf1/DmoGEqOIuzNZhHtUY3MLDIOyJxJXvuIaP+NvfaD3RFPdEhLsjOQ==
X-Received: by 2002:a05:6870:b906:b0:2ea:6f56:5c1d with SMTP id 586e51a60fabf-2ffb1eb547amr8793112fac.0.1752846925176;
        Fri, 18 Jul 2025 06:55:25 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3010179137asm679621fac.8.2025.07.18.06.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 06:55:24 -0700 (PDT)
Message-ID: <429a1fbc-dd2f-4c9b-b8da-73cee76e6732@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 06:55:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to
 mac80211 when offload is enabled
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com>
 <1ae4000edd954cf492e95bdb059c89b2@realtek.com>
 <CAD1Z1JK1wnCTeObYAHALkxDVFm0kx=7r4urtA4S0XorLNOPKfg@mail.gmail.com>
 <7859082aeea642e2a3fa3a2829404b55@realtek.com>
 <CAD1Z1J+M2342-fsyc--MB+K4cd16v-csMKd38Vjm4FSdvatEnQ@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAD1Z1J+M2342-fsyc--MB+K4cd16v-csMKd38Vjm4FSdvatEnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEwNyBTYWx0ZWRfX013iEiu2r/uT
 sYithRKtWC4yXU3nOIcz3yyiori1Qa3NcFpPogF2eowS9EU5/5Z6K1jrbSXUqSgHJR+VKcMyqTY
 Q/jzdf7QYqHQxLHjRbVRzJfEteKAcUESfWtU7iLfa09WqBim02jXCkr73hqqbaneJ0LjH5JNtYn
 B3rbsSnMBh+9f8TAcI9krfxCdnFanR/js4B/r1k5tuyKJgypkTg4i8xrCSI704U/0/LdJh0TzN3
 6xqmQeaerzXimUNxw8gqiBIv/RL/MBwLpy+W2FKDVlDMEXqwosD+rhFHHPN1DD0s68WGesFYjzc
 vTsERoM8iXc97izSZYnqx34g4LGrxB8YuAYXDnuEtZeMmCvO7DvjEpYaNGIIgji5UDOAvFNDoIh
 yOsTVJp73IdWIOZ3wt9F/IloSW72dZ0u/8q/pc+xmnpcgusVHm8qCc/YJsmffbqYP2HJ16dI
X-Proofpoint-GUID: tPA9OJ6xQX61E7P3fIwVAdcc6m_BubFw
X-Proofpoint-ORIG-GUID: tPA9OJ6xQX61E7P3fIwVAdcc6m_BubFw
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687a524f cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=n9Sqmae0AAAA:8 a=EUspDBNiAAAA:8
 a=oF63wo3pCtCFGqcOxokA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=UmAUUZEt6-oIqEbegvw9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=794 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180107

On 7/18/2025 6:47 AM, Nithyanantham Paramasivam wrote:
> On Fri, Jul 18, 2025 at 7:01 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>>
>>
>> Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com> wrote:
>>> On Fri, Jul 18, 2025 at 2:45 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>>>>
>>>>> @@ -578,6 +579,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
>>>>>         struct ath12k *ar;
>>>>>         struct sk_buff *msdu = desc_params->skb;
>>>>>         s32 noise_floor;
>>>>> +       struct ieee80211_tx_status status = { 0 };
>>>>
>>>> With '= {}', no matter how the struct changes, you don't need to change the
>>>> code accordingly.
>>>>
>>>
>>> Both ={} and = {0} achieve the same result, right?
>>
>> Yes.
>>
>> However, in some cases, it might cause compiler error. But I forgot the cases,
>> even I can't reproduce the error now. Sorry for the noise.
>>
> No worries at all. If you happen to recall the scenario later, I’d be
> curious to know. For now, since we have been following the same style,
> we'll continue with it.
> 

{} is preferable to { 0 } since the 2nd one causes a compilation failure if
the first member of the struct is not a scalar

