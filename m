Return-Path: <linux-wireless+bounces-24628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07D4AEBE29
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 19:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1444A6A58B9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692FF2EA727;
	Fri, 27 Jun 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQrKSTpk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99542D3EFC
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043938; cv=none; b=Fp47ZZyKt8eEh5gb1/VYCyNZj3m7Od+JkYZluURggz8TIi4gzC0Fz622aUmqZlBUnIzNw4obX7fl7NAdINHUsz5Z1o7MKf+Y02hgzhyToF5VUh4PBSBtN9YVOX3edraefnBZqqgu6YGPSx/J7uYhtXlUgbneWW1/aSfdK37VGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043938; c=relaxed/simple;
	bh=URri9rtaeFQEwjHRWvdApiO5uoPZoUHI9uwK9qQupGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkZvj2tuOMmhwuozafBkpkzDOkqrNpPfRwfM7oe+gQMiH7Y8auu5LpXwup4L9FntSSoHlpiuXe24jQV+u5khU/I9TNyVJD0ywoHy62Lfiibxoh52iHyYINb6/pAywm3AG/vsE/0BBI88J/BuVUnHsni4zpIn1z0doLJFE5KcGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQrKSTpk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBu32i009871
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 17:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e4hhTOqWZMo9V6fIdyRvsV5cpbd4ClOqy3EZwA5PfkI=; b=PQrKSTpkR7xP6Vlm
	FCq7dTVdQAkxRJOB6dySi85NLfwt67iLTLjItHwjwt2leXZq2limx3G9tIXbyfOC
	zv/B6QBl1A1Flz8wmCBadNwW6IM1zalbaoitjvVattK6Yxvx0h/ErOiR/THlatCI
	7Pi7LbVJc6SUKeSatof0/cVLNyy4V8p//t83bsmEbi54wC8AA9m5n5qAXf5F3/m1
	m6BNs/F9nePB0sPcHT0pCTabPGIFyVxP2XqxdshVvJcgnT3+Z6R/F8fP3u1Kajf6
	SMZUNbLqJSlWa9UMqiizTc8SQ4oyEuTDfEsJK2JY9XiSTBFjmLp8vxX47of04Y3e
	Araw3Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88fh85g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 17:05:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31e1ef8890so54577a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 10:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043933; x=1751648733;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4hhTOqWZMo9V6fIdyRvsV5cpbd4ClOqy3EZwA5PfkI=;
        b=PXpeQL70BIM2hyZ1PpfYSkLMIrS77tMQEB8vyBzRIv/oFGmkUF9V4G1RaDNEE/qFr+
         RTVk1QuhQDIDIIfGMZjUKhTkzQBEpP1EDx4bjQhP4KtFr8VWfpjplHpvEgPbwsON8374
         oHHvim4SU+zJqP/GGlCHhk/eF2Hb5KSKQShINvWCujeG9FwKRBUM0duYIfK4xLZBro2M
         wIOiZdlS/bOdDdCTtlAnaON8Tb9+P10ZhszbiyWPMv8v15y/ttSVNyqUBi87V35mSn4r
         rmU4XK6RoCc3hCOdBxvcW0xNOhYCcBzhBHE+fRerPzapB1Ymf1hwyj2k5t+0TkYnGPVr
         gdoA==
X-Gm-Message-State: AOJu0Yxvh0NOldmeFCJKANEdIMVSY4/gszT6PCyYwPwk9IufZRhj6jdJ
	Zk9o+U7zVGRjC7LzsgCZOPlesU6p0/5U75vqwJ5JUi95PhQcoEHZj+Qu6gVvM1+2xjCFi7ycTN4
	lQKSacB8vT2mZQIjABmjLLwOcnkHInNttz4fUgkgdhLbQYyyroMbBoIkY1HdOPQ44LpuA20NwWU
	VD3g==
X-Gm-Gg: ASbGncuvvYPrUkMuZG95aEda0LRWEGegNq/8AVSCgn79zm9Zv7VO221I9Ji+AHsBBBk
	UmnaNwn6C3qPGHcHQdddMQzGZUgCkJ6+O8rRqkV4FEUIzeCB+t7qQISrQ4iJayFi+mmyBTMfNk5
	0NmUEchUpe3dc/tdwLxnzLyxdHvT+7J3L45A1L8/NhYwWw3kJsbTPwvBZwNT1Ng9ZYo7B2HHhX+
	00U6QvRIJ/SnQqFfOJvCTxCn0Hd3i/StG4UBSx8D2GLk2vNhMljjkAOVrPjVfYPfXpP3hEUEHuV
	yqjHwKFoXnsrm6CPYDXvBR7Lt2L3b4s26KDkbfDL8kTun+YMIloouWtyE3qVfVyOy1RWmE0KmXm
	V+3QMUbhOQg8JHzk=
X-Received: by 2002:a17:90b:4c89:b0:312:29e:9ec9 with SMTP id 98e67ed59e1d1-318c92ee68dmr6494982a91.24.1751043932726;
        Fri, 27 Jun 2025 10:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEh27OnPNhZGxxlt8ifDAaNJo9KryjgRVl1DMLDe3mGcXsunT1yKUcnQR+Cw4Ulqx7TgvFUA==
X-Received: by 2002:a17:90b:4c89:b0:312:29e:9ec9 with SMTP id 98e67ed59e1d1-318c92ee68dmr6494932a91.24.1751043932125;
        Fri, 27 Jun 2025 10:05:32 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54270a5sm7444241a91.25.2025.06.27.10.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 10:05:31 -0700 (PDT)
Message-ID: <94cc1f71-7de0-459c-90bc-84e25bd76353@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 10:05:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] wifi: cfg80211: allocate memory for link_station
 info structure
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <81f30515-a83d-4b05-a9d1-e349969df9e9@sabinyo.mountain>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <81f30515-a83d-4b05-a9d1-e349969df9e9@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzOCBTYWx0ZWRfXxonWM455rGLq
 YKAROeouqbQxFBiL00Rc6Jbrq4lmf9NsLXlOyEd9nvEpuWizmcLkd6PWSO0y7TDm90HHsr5hcRJ
 7VX0LivWPREjeLuhKeRbeJCsK4kAYnjngu+r9qu6AqSEzCEHv0LAYdw/+28iPPZ1qamM3/tGwys
 dT7LjMUd1XZVOKBq06IU0szSgDDDMAg1gGROvioSKk21UPIDY+GU0LvbICwThva/aEZEsgFiQsb
 w8jsbxAsM3ea348qOhTBvptg9ZiP0LmKfXo/DGNkvJI0odnOSv4MhAI5moT0WqLBIx0Ts7aq6uZ
 ysje0mW0OiyQcm2uYLYRdfC/Pv+NkvECpTyp4nU56VAxqbzMMVJq/t6Bmta8/o9Es1KQ/TGoiJA
 GbMALnSTV+9s7scVDzOIfKlcpbdK7YpU4UrFEJQDWFydw5/ApRF4bkvL0HnGMumhAlqOKsco
X-Proofpoint-ORIG-GUID: 68pIHulE46F7mNfD3InxaM23jaykJTAi
X-Proofpoint-GUID: 68pIHulE46F7mNfD3InxaM23jaykJTAi
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685ecf5e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Fu7zB1KMxb34FjUOL24A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270138

On 6/27/2025 8:37 AM, Dan Carpenter wrote:
> Hello Sarika Sharma,
> 
> Commit 49e47223ecc4 ("wifi: cfg80211: allocate memory for
> link_station info structure") from May 28, 2025 (linux-next), leads
> to the following Smatch static checker warning:
> 
> 	net/wireless/nl80211.c:7505 nl80211_dump_station()
> 	warn: 'sinfo.pertid' double freed

Thanks for the report, Dan.
Sarika is working on this.

/jeff

