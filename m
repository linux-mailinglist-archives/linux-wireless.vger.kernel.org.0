Return-Path: <linux-wireless+bounces-29811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF7CC4131
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DBAE30361EE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9D34D4FA;
	Tue, 16 Dec 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YQ4TxSQv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NR843e/e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31A34D4FC
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897503; cv=none; b=rVVXp/SCW+SoM5euikQW62AlfHO5Wg9j51BtmvS1zLyqY3gxHJZA6EsTFpSGq9/s8vP3E+U/em6XtYzMpBkt1VcYqc2ViCSFU2JY2Im87zYGpROULTpv4gmJw0ZAq6UejHeWlvgB8UMUdFkxeqLuMKnlGoxVT60CCc/DWqoCf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897503; c=relaxed/simple;
	bh=NUIOTiFRd9lrp9ngo3S6+fHm7fK3aVkYrlNJuixw5hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fay5R5D2IgLpjKGBA/LuBPbGYBuTmrO6LnBnIcaLt6v+jFX2Dfr+BFR8yZw8pngpqyci8jbxVyL7Tw3av2cww53vFUAmvkHtE9r7Y9GQkoR9YqLT7IXhKMI6K7QbzsRJ8TCJunPuy1r5n/rt7iAkhAm6LAfQJtHC7HJ4YfCZDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YQ4TxSQv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NR843e/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGCo36e2869694
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NUIOTiFRd9lrp9ngo3S6+fHm7fK3aVkYrlNJuixw5hs=; b=YQ4TxSQv8pdQpBlW
	XBIwY51BeJqbpzR23g2058ek/QVEMw7SV8dnA8LV1MJZ2Fd5OARQ/58Qg3pPjze/
	FxLrDbQCaYBaZ1dOHmr5ofvN1xiA0osrFSfP08veY6/2rdk8ph0LDn0iW2fyPMzg
	F1SKfVwtYuEFDtVBG47ZPyuULMd8a3WTZDliQPobWhZkNQMkwMKsVbBTQGGbSmJE
	cI0R1DqIImdJ5+lUmkAm8P3+vSa34ipssm9aXHrirCASt1eIQIrXzpYxate37lRN
	WQFGqZU9kXXzEgGRnXlLKuYXg65bmcJvJujr84R3ksuG5OuQumFnjl2o6k6K8x3C
	z0zprA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33kw9n65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:04:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0bae9acd4so26681635ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765897498; x=1766502298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUIOTiFRd9lrp9ngo3S6+fHm7fK3aVkYrlNJuixw5hs=;
        b=NR843e/eucTFfvVswUe9fKp2RYQP1QDTv72UlW22S/m5b/9NL0KAb7UYAjN+SdZYxh
         3BmswjFLZPQmNK1USZ1XzADXxJhh0Z1rLMnGx9e0C0VFbkvQqiMHv6WXnPsMNuHyEeAU
         mgazVdtPfeZxjeuLEM9o+GL38PvJdu2TK5bIB72TcCDz/pnV18YHOXpBulYZi8ZMEHfz
         8vpgot9eKD3gqmXrhuqMxtduObB3gClYqjNUgYOECU/L5zdVf+QpRLb0+wkXVTlGQY2H
         8zOqD4jRMkpY1ESbsvfRGwPEhXHGrs2CNaU07J4d8vBTzVVna6zHNpe8jMgaWmeBgd0r
         ORyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897498; x=1766502298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUIOTiFRd9lrp9ngo3S6+fHm7fK3aVkYrlNJuixw5hs=;
        b=aGOzJGgw2JEfob0WS7fz5QmzHTxKqzJV9Z2ov8nKdL6xMbNibNDC6nDAj7WIIWnW8v
         4YlLi140BwaYYaXhsIEGgE23fnLInvTnMX2BDxoxbcBJnX3PD6h7ft0vWRMkAopVmYVr
         OEKelupfLLgEBZ3uElw2yySokPdVbfxE/wyeud7N94I2fhXTHL6uzHltrLFE8qrFTBzT
         v5/gSmPjIcEslVKPENU/nLGL7EGY07ZwAeOVT3nx5OfpG/Ad/rv2Ofxk++rhp+rqEEOw
         HVxZuDkEBb8hLi5o9Em7pWNxi5L0153QlS90QEY+dWL+W2Bq76pIN7vsFJqnFJF4r6E4
         UqPg==
X-Gm-Message-State: AOJu0YxTIGdQLbT4kfF+RHM2w293AS/qGeQ5KOUEIsY7kYrbV+BRG/eN
	oEf5BXSNXCovhs4OcIMMPUi1c5Y1YVp79XJdNLSDAUVYPidk+0J9dWKqDPBJlXWs8Zryfutr0Pw
	nQWbX3EM4diCtYlTeJLEeI+UvN6tXDtqJNngppCjCWZr1DEa5Lilf9ToxvJi1ChQEyUtYsVPKh5
	nddw==
X-Gm-Gg: AY/fxX4HkBRUdkgH3R2Wvw3XbYjdxpbVHb2cO1L3MUqs+POcMdW4Tl1pHtnb5IS2qR0
	BPTSQdpJRc8fv7u991MSd+E81/CJxMdhy/ymeaPNXXZ7g23jAleFGUDRcUvZTpErGGUOnZVOKaY
	XEBx9BioQutuS9kNKp0MSkg9Y+Q1eEc1+S8f2FxQcRAN8SBhA1uN3DazpBCCGpzmlW2P7bJY4n+
	9kcaJZ3zogw1V05VrDzVcbdQsyKMZmKTo5PH8rWCWfP1A0J7M+0Idr2/PAXa3C7/e2X5uRPeY5d
	I5O5+bkZEWA3pZSp2tmqfz4cBsYMglypCu9vNwaQ/zBEka3MFtS3uD1+a49lckoVpjM0c03YaeU
	a9n6NiHNJxz0Hem1JUIcsESQ23HsXzPxLC4mW0gYs+yU=
X-Received: by 2002:a17:902:dac2:b0:2a0:a33f:3049 with SMTP id d9443c01a7336-2a0a33f33c8mr93742045ad.4.1765897497396;
        Tue, 16 Dec 2025 07:04:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWTKRb5XeSg85fW+5gSGVSdn9zzgLhRPbyo3kICGcQZ9EACDlGcMgBfE7VOLMErmU9X9HzxA==
X-Received: by 2002:a17:902:dac2:b0:2a0:a33f:3049 with SMTP id d9443c01a7336-2a0a33f33c8mr93741475ad.4.1765897496430;
        Tue, 16 Dec 2025 07:04:56 -0800 (PST)
Received: from [192.168.1.10] ([122.177.242.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0867ebe9dsm113107095ad.40.2025.12.16.07.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 07:04:55 -0800 (PST)
Message-ID: <7a4cf095-5c51-4f42-a67e-42f4411b8528@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 20:34:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 02/14] wifi: cfg80211: add support for EPPKE
 Authentication Protocol
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        sai.magam@oss.qualcomm.com, quic_drohan@quicinc.com
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
 <20251211124051.3094878-3-kavita.kavita@oss.qualcomm.com>
 <25c5f36465a587e053d8041a65683b3179cfb55e.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <25c5f36465a587e053d8041a65683b3179cfb55e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TLpIilla c=1 sm=1 tr=0 ts=6941751a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=vaJ6/3d+63OnhzhRW74whA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iYhIsXvHP3eqqX3C4C8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: eTPyQvxtnaknYEWAqOg_WjTzbmmQtcoC
X-Proofpoint-ORIG-GUID: eTPyQvxtnaknYEWAqOg_WjTzbmmQtcoC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEyOSBTYWx0ZWRfX4vLsAg9RvvB9
 cYJOrfjVwWQS+Aj2UlVG34a0SKBi30M7Hrak/DgGoryy96NdG5HO64xCcEP68/pwgKcyFVZvrD4
 BkkrjCzaSbQV6JvE1mZ1zUPs/ftvBfADuOZBP21TBJwOkZ9IPwvmt6KiNyeBNxeitFjxStq+9Ck
 IvKJ2q4stZeBAZumHYEums/JSRuk2GbkmoO7b9qrpHplP6O+IM372CZI6dlUjpIVwvSHBmyhzb5
 /P0sdrfkg+RS89Wy3liXLM/Zvvb30O2K6pG5RYJyhZXlSJ8WJEwZdkA7NOlpVIFVeeKps54xBUs
 TFXcHXQYhi+LpY7l+3/aN/6ussw2tYC/KTUq9h7laLyoo7SqPLv6F9MHTdRVnaFdyytziBGJUw7
 +HbpF2WlQT2dGHFpz8YTICGCJ6FRGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160129


On 12/12/2025 5:55 PM, Johannes Berg wrote:
> On Thu, 2025-12-11 at 18:10 +0530, Kavita Kavita wrote:
>> Add support to validate the EPPKE base AKM suite in RSNE and reject
>> EPPKE Authentication frames if the base AKM suite is not present.
> I'm not convinced we need all this complexity, plenty ways for userspace
> to shoot itself in the foot anyway.


Thanks for the feedback. You are right, the AKM validation is not necessary
here in kernel. So I will drop this logic in the next version.


>
>
>> +/**
>> + * struct rsne - RSN element (RSNE)
>> [...]
>> + * Represents the RSN element defined in "IEEE Std 802.11-2020, 9.4.2.24"
>> + * so that cfg80211/mac80211 can parse and access its fields.
> This is totally misleading and I initially thought you were getting this
> completely messed up, but I guess with the comment above we don't need
> it.
>
> But the struct right no isn't "so that ... can parse" but rather
> "populated by the parser function" or something.


I introduced the RSNE structure only to support the validation logic. Since
that validation is no longer required, I will remove the structure as well
and update the commit accordingly in the next version. Thanks.


>
> johannes

