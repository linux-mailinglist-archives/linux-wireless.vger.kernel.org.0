Return-Path: <linux-wireless+bounces-25670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 190FEB0A871
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 18:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807431C43F27
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDFD2DECB2;
	Fri, 18 Jul 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mNZyl8Zl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C851EB5B
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856234; cv=none; b=dGLkCRGcTu+jYkra8fLuBXF9WWMrw4df3JjB2F+TRPbh6/drvKKtaVn/ec7762L+BT3YQMeE109S9ZnHMCG2GHNBrtTKpUmkc3ZJ5I5cDLVZrObjdB0L2BxKKSP8VoY7BZ8btbts8huk09bLGh8ECjNR8MIdmCyio9kgXBeIUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856234; c=relaxed/simple;
	bh=6msmlysVAXBw6pkNlAcJvOZ/37Z2sU18MC08ZMCWZwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKglhfqfIQdMQU68IWTdqDFyyjW4E0DWL3dKAzAAVwOoY79yj3jMtPaEDzGnaHwRIu6n7yHsCMLn/f3WJ86HeXREDZezWsmRngYo2cTZEfirV1E09CKzBviKyh9Z3kcy6QnDywsdG7U3Fz+aE8JGTlmxdUa7XpOHQ9fYnGFCxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mNZyl8Zl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8pKQh020753
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 16:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mf8I+kRP1GTFcctuOp3Hq6TFwDrPAlRHX+k0G5vJD98=; b=mNZyl8ZlbIhLetIh
	F2pNCuIOAyqV9o8hAqB6wd4jABA4f3OzO5/V7HYwSjNw3IXbzTZWsvsiNtIMuOVP
	Qv++vcZXvIYm7rxK/sCZf/MoEES2k12VzM+p0TF6nVqduEP895M6fkdgHUwyeRvM
	0X9e4RGZMti9xzULxvQ61MNAfmDHjTWEMrSxjOO1VV1xuRADQi6qpYgMP8tLZRu0
	KvauIX1HnLzmcCtFNvFPLdIutavDiYDI7mYBEQ+ni9TiKXpZktAWklaSbS7r7+3r
	fkS6lCtwqyOjRoavrxeDAKq1eZKX+O/lxUN4bbquT5JsIL0D0IbktNXy3s0yY8gW
	hIz1gw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpqbb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 16:30:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235f6b829cfso18970185ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 09:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752856231; x=1753461031;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mf8I+kRP1GTFcctuOp3Hq6TFwDrPAlRHX+k0G5vJD98=;
        b=E+y/0ofhAwMfdFdez/GmpI+dQZ9yaySNsgFcI4+oTC2cazYdihS2LljQcPf0BUjFqI
         zqK1BQAjTrfYf0klQd959rfMl1tHYgsUI8qLtNzEr4jPbCfcu5dm/lro8XyV5U03FhFf
         B2QSNbeUDDMdWFFmPHM+pISUE89da1e1J65zvVgAORBuY83x9DSRtH+VQQcC6QoCd+sW
         xOVJxehni6ZQiZsawtWQub2x3ZCipeRyadLsxmyuSpqXFO84Vw6t6alFiEAjLoQG/ZCi
         O8w8avdI5k+fo6C1cn9GJoVTP2krl+v95agNXoCawHyIpddq0lapU7IuavI0mcfRLhjP
         3jTg==
X-Forwarded-Encrypted: i=1; AJvYcCXKgRSkafmdLpf8pEl8yXe71diXYRFpOa7AapgHbk68vtakFpYwYyyNC0b93eBx++FHq7hIgn5YP2Kov80lTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz117deYki35+H3jq7EkgNx6ON1099ztOqcUaOGGSPK4WplxGAw
	SsMZ08v8ZdjC6OdMDW0zOhHvyiZe/TodjVDhs+usYexZSO3xantVTnk5nudpwfcsItQWO+4zhRa
	xKbAzQ5l4J+8c7k3g3sDrxW31NxQi/ziu0Welg44ERD0jRR5fV9v0LoouuG0Y0oB132is1A==
X-Gm-Gg: ASbGncv3iGmg8iE9KRcma5LaC1o8C/7UcWAk+ZKLNj+6oc/8WFnVVSYUOzqokJ8mZE/
	XZtF0u2qHJLrunngu1myYyXT+jmKV31C+sJ6h3ZRyaU6RftMm9OqZxMbTaOWz/7/ZdyAH5FRQst
	vDSVaeWlLTkFmSNzZz+qB/e1mfhEGT1Cfp7pAHE3YRiNUZEbKGMYjEMDl/rnm1797REgQFECgPC
	G7QHhFjfGQTgR86hIwaiGVE52c/8QRBUqovyG7UBE1BG61FYRQs26JTTRjDeiZZrKnhYTmzQH7+
	s97VrFdwYcBjPwh7LMKhmZTwM3sUIQks9lKqM+qZp1/q9QkOsLFcPz+DGaR2cCYwNat+rJXRAgo
	RR226g6y8sDlygujUHHFaO2ytsEldPzbl
X-Received: by 2002:a17:903:2a83:b0:237:cadf:9aac with SMTP id d9443c01a7336-23e2572ff8amr176250005ad.29.1752856230804;
        Fri, 18 Jul 2025 09:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWB11Y/PmMi/Ueq6vlx/4MaJoiFWJYhHXpsYm/xS7ysxjQ+WomysTx1SZIYBT9SlSEsnVZlw==
X-Received: by 2002:a17:903:2a83:b0:237:cadf:9aac with SMTP id d9443c01a7336-23e2572ff8amr176249115ad.29.1752856230115;
        Fri, 18 Jul 2025 09:30:30 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b708763sm15473805ad.230.2025.07.18.09.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:30:29 -0700 (PDT)
Message-ID: <9e6f5b97-f76f-4573-b70c-1f81c9fb730a@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 09:30:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to
 mac80211 when offload is enabled
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com>
 <1ae4000edd954cf492e95bdb059c89b2@realtek.com>
 <CAD1Z1JK1wnCTeObYAHALkxDVFm0kx=7r4urtA4S0XorLNOPKfg@mail.gmail.com>
 <7859082aeea642e2a3fa3a2829404b55@realtek.com>
 <CAD1Z1J+M2342-fsyc--MB+K4cd16v-csMKd38Vjm4FSdvatEnQ@mail.gmail.com>
 <429a1fbc-dd2f-4c9b-b8da-73cee76e6732@oss.qualcomm.com>
 <CAD1Z1JKSMqRRMKXEL2RUA2AKdP_FyExZ6U8XAz60aXB=B7iVhA@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAD1Z1JKSMqRRMKXEL2RUA2AKdP_FyExZ6U8XAz60aXB=B7iVhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyOSBTYWx0ZWRfXwzNzOy4MHkvB
 iaIUmwaB7i6iMrG/7howZWeA1OXMUpdVc6D3T2x1PVzN8Z/oejUivXSdyVg77zYu6vg2yQ9V5KH
 ZxcJgSmLVY3bhGN9Ma5jW7BJ2qFjmFvQy3k0D5Bpoo3GIqJ1qp5vdCSRwmisZgMoOAJL3MWdTAO
 RNYzhZH/jtNcjbCPVBr9KDtw70R4foTh/Iz6yB4nXpsHSun8kRn2vCDOjOO8L53PonZV2mqj/ia
 7XESf5kRRrmhCqBW4H9k9meUrrzG2Ib2MiKnBOIQGESpYS/UxrEl0pu6igPMijJL2f3+o874sA4
 CxUKuc/CQnBxyGThHEnLuZ+IlnxwhwrGzhOPVtGU/xnzLMeJ8nvWVoSICP/KCJPxvhx4POrQplc
 /K95bxkHnzrb7NkC3wDYjC9YBUv/lMzJPdnjSuePjb9yBCpX4SCiMYaJyQyes4+AElBDeZm7
X-Proofpoint-GUID: jYwd8a6fS2MXUe_erfRuQtzpS3HtUJUm
X-Proofpoint-ORIG-GUID: jYwd8a6fS2MXUe_erfRuQtzpS3HtUJUm
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a76a7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=n9Sqmae0AAAA:8
 a=IiLNXlrfRh48qxmsI9QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=UmAUUZEt6-oIqEbegvw9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=933 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180129

On 7/18/2025 7:05 AM, Nithyanantham Paramasivam wrote:
> On Fri, Jul 18, 2025 at 7:25 PM Jeff Johnson
> <jeff.johnson@oss.qualcomm.com> wrote:
>>
>> On 7/18/2025 6:47 AM, Nithyanantham Paramasivam wrote:
>>> On Fri, Jul 18, 2025 at 7:01 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>>>>
>>>>
>>>> Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com> wrote:
>>>>> On Fri, Jul 18, 2025 at 2:45 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>>>>>>
>>>>>>> @@ -578,6 +579,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
>>>>>>>         struct ath12k *ar;
>>>>>>>         struct sk_buff *msdu = desc_params->skb;
>>>>>>>         s32 noise_floor;
>>>>>>> +       struct ieee80211_tx_status status = { 0 };
>>>>>>
>>>>>> With '= {}', no matter how the struct changes, you don't need to change the
>>>>>> code accordingly.
>>>>>>
>>>>>
>>>>> Both ={} and = {0} achieve the same result, right?
>>>>
>>>> Yes.
>>>>
>>>> However, in some cases, it might cause compiler error. But I forgot the cases,
>>>> even I can't reproduce the error now. Sorry for the noise.
>>>>
>>> No worries at all. If you happen to recall the scenario later, I’d be
>>> curious to know. For now, since we have been following the same style,
>>> we'll continue with it.
>>>
>>
>> {} is preferable to { 0 } since the 2nd one causes a compilation failure if
>> the first member of the struct is not a scalar
> 
> Thanks for the clarification! I’ll follow the same approach going
> forward. I’ll make the change and update the code accordingly.

Since there are a lot of these already in the driver I'm going to take this
patch as-is. I'll separately fix all of these across the ath1[0-2]k drivers.

