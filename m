Return-Path: <linux-wireless+bounces-29828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C87E2CC6F64
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 11:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18BB53019F81
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88579346E62;
	Wed, 17 Dec 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YdE3QKBE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K6OtC42K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3834AB1B
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965942; cv=none; b=VCEuf+0VXWe/m+UpdfLyeqiV2yd36x02oBZwyj44hXgv8YXOQw10tU7fCZV3kDqKvYHeYpfLtZdGWshofuN1ge5WL5RNObfK/WEGb9B5RST/uW2fU7AQ4advbiF9z0WKhvI5IbO33XuBA6pFTVNta1F0UrXYT2OJjRuwpqh2iBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965942; c=relaxed/simple;
	bh=f1qCjRx8D0CmvVA41ZgcMgNV5AgdcAse3ZuAJWDTYRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYQK7aV6HomtaGrCsGjxA6/zxcYB1De1VIgjBuSmBCR/heUUXQ3g32z9Z3jtMt0BvUItBHVC1vf6iU6FFkkvFJ05XwRoVIcsIAaq6PDg2SNrC+xgWnTrAsnAkymX4YHR1MR4MJ9uy7TnTdUig2QKFxI8ZXTBEQ0PHjZSkjf9C9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YdE3QKBE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K6OtC42K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH3F13B869291
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 10:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ql3B6eIngyYQ3p88fa9kSZYb4RV9fdSUXwNMcosHnBE=; b=YdE3QKBEGqgb5fR0
	8bjFFfgWUy/2JmYxCoYTRQHPIgKHm5gHYwagYgxlgtmYehSTJXCSkPZzUztcwLRp
	BwycFczHaw+DMc743clJlyUlm2aV5mVyogZnXxMTGFjwjt9Sako4887CXGTaNjYr
	4nJPw32rSwSFmWFWKHDUHMPFeHIzrYTM8EwkCUJB9e7y/usc8Ok8pnt3ihbfNDfj
	DqXsbrMBR+JXc6Yd8GkCFX2WNqxB4GbYDbf+gouOpglh5+x7la3OFWVXW9XHke1R
	xJ6oE8rCmhtnuJg1b51+khK1BTCjryvycNWLdT6hwIPF97HkqDiK2KOp85E4RmBG
	xJphtA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fj1t09y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 10:05:37 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b90740249dso9369327b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765965937; x=1766570737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql3B6eIngyYQ3p88fa9kSZYb4RV9fdSUXwNMcosHnBE=;
        b=K6OtC42KiMAs5gRmUbhZOOpHKoERgpJz7Kkhg8eRH1nGzShKiBAb0NN4kBuuWeuSDs
         oRasS1A/Tepp1zDkXeB9FIsipQGXpZeEGilO4TkqCn5uSuplr0KEiXXf1cyTDB649QTt
         i0KsdRwnMAs9Tuc99VA7rRCtp7sLl/wPbGLBeBZ4uS8W5M/nNcQcalt+FOKH3PWny1yf
         Z2rM2nLOCl8rE0OkaAlRS75YdIh4xHZLcnbcIstNaK3sRcJQn1nBa51FBujwDE+5pyPz
         9MUXLhqs4PwLwavX3qDtZhv9XbIXmr8qYUOWBxx5E0GLEr2qhVU/YeDh/+le12M1Jv7N
         eX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965937; x=1766570737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ql3B6eIngyYQ3p88fa9kSZYb4RV9fdSUXwNMcosHnBE=;
        b=mcAQLb7SbYx7pYxRHDlAKYeNeUz7uwd5ZBk3YFjuOoE/LGQ3omHCc3qp8hGc5Q+QJ3
         q7YU5V9ze81Bs1wTLAn8E81EeUy/siHqzaNw3sBNh/94YHSqSbb23m38gwYPyc70ohWM
         X/+4KPbFzMOaJLyxQ3KIUyjOgkTYVkolVjkc6vpZgg5z/t/Xud7+XGRwEzFQgdkUVmtP
         yjtAj8DFsfRfHh/lAXwUm4b3JH/W0ySMLXldBWDO2pwb+mzU0BNBIHEu2WJDusWPnvvi
         sqqln+OtTzqDznS/TS59TnhUXSt08nQbKKcflPBoR3En497ZVpgwSmUVtyaZb3RHjASE
         2i3A==
X-Gm-Message-State: AOJu0YxN7o5t4daJQVPfSNmW7Nc0uyP01udzspB7g1dYtmhrZ+8JH/d+
	l/KYs04MRv0o3nPEwL8U4iUe8l58Zt1jWDKYJ12qBJGyF7kfWOJvRI5HloRi3uHZMPcHRva+wK3
	QX75fYz/7K1XTRBiVULf4FgiIZWzq0RwPdwvkzfu6DrooVNPSQGitee5kSypCYNrsN9Q2FA==
X-Gm-Gg: AY/fxX7+zEgAqZjnatcbqCB6j40BvJxILqTPDZBOPotS/Ql2zwwTAjqMDhMDMPYvUmW
	b20czlwIznOsiag5M/JOSpVesSedLH+hb5LyWI6YI4mKcn0oKYXA+SHsWbepOvshzEc44KNQeer
	0dvlWUViSlkhrJfyC3Fm2Nmj8rG4IsMBVf19gBjVaxNHtf4XoaUsS2rPhCOf2Ew9S/qhfCLIT6o
	7b2sbsJW/6w7KXqM/T+a2A0syWlxB7dSKTB+4/4y7WVUxSDdFg9FNcPpTSeOvqbJuzkRvY3PIau
	nuWqdcs7z2a+D3tQj7Onhone8oHIpeb9Xnphy58SuFSsUY5CbX/CZU8W2quirlqKqYXd3KaZaew
	yc/xxPOhIdJV6WM73Th+8I9I6RxJufSeokl3Mb41ohSVDaw9gafs=
X-Received: by 2002:a05:6a00:f88:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7f66fddf683mr14536596b3a.16.1765965937310;
        Wed, 17 Dec 2025 02:05:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzMkblHygabQCF5vnXe7LAfu7bXE2uhwJhO9D32fXuz6Nc8QbB49k6guEuUsQHtzMc+EcszQ==
X-Received: by 2002:a05:6a00:f88:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7f66fddf683mr14536571b3a.16.1765965936757;
        Wed, 17 Dec 2025 02:05:36 -0800 (PST)
Received: from [10.151.41.188] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb8742a33sm2242989b3a.1.2025.12.17.02.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 02:05:36 -0800 (PST)
Message-ID: <910a50de-b00c-4bf6-9682-1c73826635d9@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 15:35:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC wireless-next 00/13] wifi: ieee80211/cfg80211: Add UHR
 (802.11bn) Capability and Operation support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <07cab823d7695b20aa7ddb1b3698e5eb88ff2c9c.camel@sipsolutions.net>
 <feb431cdbe7581e4e961f2033606bb6fe4d90199.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <feb431cdbe7581e4e961f2033606bb6fe4d90199.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA4MCBTYWx0ZWRfX2keBoov5ImkK
 W2bVmXhhB09GRJmKMuuwvVII1By7WRbYfSYO/b23zVd3MygICaE93ReMD1/bL+fZ6Ve1NTpBQcN
 jOyd8XkNbqmL2yZJplufrZttvM2tW/RFBPyP1zPC0S2irWSJnJzXC+hpLYNLF2m5J58yzfIzIGD
 0CXxqm9heBdkUOps6LSGPC21UXaUyvgb2YJ+mXAo/a1kzv7Y/IfexfxS3gkyP0KGCoYDlHmlK/z
 eXBZkwg/zaG7inYN60pQSsXUU9ao6YpUiIfzhJ/lkVLlioIWUNrFQL2UVGUoa6XIpy57hJb2CxS
 6Z2au9nNmrIVs3vUkEHAZZO2SEr74QvBYPCWdmi/iPR/6rH/HTTXne9g/KmNRRteS1maQ89QGvs
 p5YRaxjGyIwLCZh9XZ+7u4y4J+vdHA==
X-Proofpoint-ORIG-GUID: 63CFe9UDdV1ajY8O_d4NjNLuGO0EngLt
X-Proofpoint-GUID: 63CFe9UDdV1ajY8O_d4NjNLuGO0EngLt
X-Authority-Analysis: v=2.4 cv=edgwvrEH c=1 sm=1 tr=0 ts=69428072 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=5NhkCEYWh_9PesseEUkA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170080



On 12/16/2025 2:42 PM, Johannes Berg wrote:
> On Tue, 2025-12-16 at 10:04 +0100, Johannes Berg wrote:
>> On Tue, 2025-12-16 at 11:56 +0530, Karthikeyan Kathirvel wrote:
>>> This series covers support for UHR capability and operation (11bn)
>>> advertisement in AP and STA mode. The objective here is to give an
>>> idea of basic changes needed for UHR in cfg80211/nl80211/mac80211.
>>
>> Huh. I never posted my version, sorry about that! I'll see if I can do
>> that soon so we can compare notes, but I'll also go over yours quickly.
> 
> For what you have, mine was pretty similar, not all the naming
> (obviously), and you also have a few more definitions for DBE etc. that
> I didn't add since some were still broken.
> 
> I also had the rate calculation and more ELR stuff, IIRC.
> 
> Anyway, I'll post it soon and we can see that we arrive at a good
> combination.
> 
> johannes

I received your version, I will review the gaps between both of our 
patches and get back.

