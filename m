Return-Path: <linux-wireless+bounces-19253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7234FA3EBE5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 05:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713D7701569
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 04:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613641E1A32;
	Fri, 21 Feb 2025 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DcI2Q+0s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DD1D7E4C
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112681; cv=none; b=q2Y0c83X4+LSrM10gT29NzdsL9YZ7TqopzyT5bdZNTvvcuB2J+2ti0PTTgekGHJbJ/zICEQ3rdhE/cF3+zmsZ0PV3m1izYUPf4ToJsPT5tQii0ybsTsUymDTAHAIxDfmcMpCMP80qIDr5qnXMvj4kTvPyrAkHi3BHgeyBh3PaDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112681; c=relaxed/simple;
	bh=3q8JfxhsR++g6nIvsROk88xessze8nvcY9oiF9Vk3aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axzMnM6+XtCzbMoNNaqRM2yjywhrZBlA6/E0oFadaB+S7GhbOWQsEcNIYvZozL5YqH/ITizWy1ZcMO3IsXx/9cSI6lz/tI/XSHa41Oo6XyKBvQENv4JGNSMN5iBJRsda8iG0ekm4jOm0jJNopiqnjuhH2w9JqXaS9CDvZ2n4Arg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DcI2Q+0s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFm0XU012178
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 04:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y5lAOYW0ExNZlPYUkLDU1c+fxrdo7zGHF95FfHHanss=; b=DcI2Q+0sIs13Uzlz
	TKkWVPkAQjTeE+5HWrpEALsR/9bE1Ck79+nVDx9PwLDsWOhmFdA4yuHbRfjJ4kgP
	jUr7D8RCkyNqi47nto3yMoUL1VLCWRd5U9p1Y3EqZkr2CME6XAnLUsBPd0eyhiiH
	p12TVbwr9pqpF99UIEd9bplrZy9s98DmBlSZn0sIit14fnUWKzBF9zX2mIT1QH/U
	FGQNYZt5PK4zvoK+LxW6IT0xJThj1hfVSPtFB5TAWtux+jn6bCy+x5lMwr5Djbfe
	u9EGGRVKcQC0PXcLg612cSzHTzD8xlmTeqUGNwrhWPoC+bMT2Xatj0hVvAcKliI7
	nKjD7A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1rfgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 04:37:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc1a70935fso3659137a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 20:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740112678; x=1740717478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5lAOYW0ExNZlPYUkLDU1c+fxrdo7zGHF95FfHHanss=;
        b=Vu5Yqm/YhQ/iE7cSE0Zq9vCoHrqMsNLe+earNfP3SArj6FQ4hpZNvc8tUvFOtt2ELC
         3C6OqnpVn+POuyEz/VzBd8/zjnQr27kDdpl83jLPZH+eXJn9HdxTq8W/nj5OYcm6DgCz
         7cNEss7klXaL0aqDwU3qpk5yu3YcjcYViaZBHBmAx198ld5rMFYhJt1BxG2PF7ZqqNE6
         2QDPGJwfWsl1gjNzw7mmgtAg7VHhTUBv0A7fExl2p/8ZOGF6wawpj2gWSYB0qnAF/OH7
         WBaWqVYzk8C8RWxTE9AKZgA3UfGKvJhrsXw4i6M4WHcjHY4geLv7N5KBQi9lHqTVXLFo
         UIZA==
X-Gm-Message-State: AOJu0YyP+zSxWRKWhZhpHpdcGi1FxQS/N+JSx5qIhw80vws1uCiSh/3y
	gJQ2a9xbhkqgVQ3SaFF2GC8pUnuoTFIQ+WdeHPczqNv48P1OWWi4FKlxI1MAjy83TUMcj7E9sbg
	iFOY9ecQzF0UavSlHY4qHAIdv96XyhgfKwqCEvIzWa23V1G65vN1/mRmyzbC/80WwKQ==
X-Gm-Gg: ASbGncsuSxmqlW9+DI9zac+SpyKXnZGzjvjCbjI+d1S0H/tm91NIK9wctET8brB9Hjx
	U6l2zBQNMpWmXheLOT1Vbnb6mvQb1d1HY2+74F3agxZQTy5nRVSMStZHj2xxKTrQlAMeqzkklcX
	n7X/zphdTN30fFdO2F8bszkTIkAPhY2wUxAUY4OvRk3HBN6R0k9iI+UDTM566BZ4srCOir4meiA
	QbZ9Uwa2u6fRoOGFV+76bsTmHe9vDMxYkkd3/+k3E0xG4+XxI7qFKmmnl3iTO2oef9AVZGKkyDb
	v1ydDYL6QzXtFa/BTT1YJZofBlPBhp6LuNEmyqHeIP8/zZYKc58hzB3LLg==
X-Received: by 2002:a17:90a:ec8d:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2fce78b05b0mr3159442a91.13.1740112677729;
        Thu, 20 Feb 2025 20:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF8aLJ1q0WrbLAex4k31um4F1PvZfcDct1XDrhbQq3n5l8XuaQjKmFWB+Pa14qcGUAM5dm1w==
X-Received: by 2002:a17:90a:ec8d:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2fce78b05b0mr3159409a91.13.1740112677274;
        Thu, 20 Feb 2025 20:37:57 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d47ba84fsm129408875ad.0.2025.02.20.20.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 20:37:56 -0800 (PST)
Message-ID: <709e1fc9-a898-c7dd-5481-2a374865c924@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 10:07:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: Improve BSS discovery with hidden SSID in 6
 GHz band
Content-Language: en-US
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
References: <20250207060005.153835-1-quic_rdevanat@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250207060005.153835-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: d28cMy5Q9FBrKbNxycJopRc9NnqaeL6b
X-Proofpoint-ORIG-GUID: d28cMy5Q9FBrKbNxycJopRc9NnqaeL6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=544 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210032



On 2/7/2025 11:30 AM, Roopni Devanathan wrote:
> From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> 
> Currently, sometimes, the station is unable to identify the configured
> AP SSID in its scan results when the AP is not broadcasting its name
> publicly and has a hidden SSID.
> 
> Currently, channel dwell time for an ath12k station is 30 ms. Sometimes,
> station can send broadcast probe request to AP close to the end of dwell
> time. In some of these cases, before AP sends a response to the received
> probe request, the dwell time on the station side would come to an end.
> So, the station will move to scan next channel and will not be able to
> acknowledge the unicast probe response.
> 
> Resolve this issue by increasing station's channel dwell time to 70 ms,
> so that the it remains on the same channel for a longer period. This
> would increase the station's chance of receiving probe response from the
> AP. The station will then send a response acknowledgment back to the AP,
> thus leading to successful scan and BSS discovery.
> 
> With an increased dwell time, scan would take longer than it takes now.
> But, this fix is an improvement for hidden SSID scan issue.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

