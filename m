Return-Path: <linux-wireless+bounces-19297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45554A3FED1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D1E3A0868
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032251FBCA9;
	Fri, 21 Feb 2025 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZeFuqcCf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340631FBCB1
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162467; cv=none; b=pMgT3kPLXwFnFj2ASsZ3M7zoboWK7DIgrBGEuG+Sr2H6WWMWcqWrCHbls4QM3oGNIo8/Mpfjm/++vobgtPoUsaMZ/zKyQE6Ph+DJIii/tXRyHdaTy78g9SylExYpArOFY1EpH/VI1kNFg2QxMcmZJxNViUO6iFqPZjagzIu15S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162467; c=relaxed/simple;
	bh=Nr9FIh/dtO+kWPQ4HZjMg+DtgcV9/dEKq7dWwOmN2lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=UMraFEHgknHWD5RwzQCUsCJepfu9NzEupdEouZsWz2d0qysYoL+Z0dAWIFOj6zr+Ry7tYhCxxdzB3Ce6uDHoJMyLGmx3gOT/rPUEcYdbCHjIfZPPLfPqk16b4q34br1FVfwsPd4fp7ZY7/4wHzYhZ/NwUbljegoQ46FdR/2raBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZeFuqcCf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LGbVaB026612
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iMFEkd+cYZgRaPOdXQcI2vNcH06Vl6UBqI6ZYLo77XY=; b=ZeFuqcCfbbPp0Eqs
	NkIqI+sGw2oE+7C63K/dv75c7WCowb5QaYEQQqWJe5h6G8NBw5z95Pv/kS6k6bzU
	caRHWD3M0Frhj+9YZAw3TfDB5RxWx0gcRA81RZpnm610Z4oh3M2fOp1DtS0sWuEm
	OraFullDrB9clQpkkb4dWv0a3kpnePUy6VZuHBFnyqkAgBFcoICzB27b5hZ76O3s
	ByQagzvCfR3mpOFveNqxqX8R7BFKz2vqZQA2+iTsfFOaP8S6UK7k6sRrXMX2eCDW
	qPbRDULE7ql4yWtx7Q3/yCVE0sxspjMksJAp6e1tEIxsIAU1I9V5ATarsbhTyLHH
	lghusg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x2r3w3qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 18:27:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220e62c4fc2so51872585ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 10:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162463; x=1740767263;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMFEkd+cYZgRaPOdXQcI2vNcH06Vl6UBqI6ZYLo77XY=;
        b=obyQn23Ea5/v6f/6nEju5NPEm6h4GToIKP7M+w8uDp13wTa4/BK6YwytQxHZC4KA64
         y04h4zrbhQS1W36iqSDyzmfNNrq8QzTpuYLRW66tzL/rF17+IuSF1pg+Ap9LR9FJQJdL
         8molh7K1wkdl6Q1FTILY/lKZWQ9GO212KOH2dtaCqkWrnQHXjMXKcbt2wVshVOkACsiu
         su8Ca/1NLxMfrILt7biqGFR5QyWULMzWEgYbjUP+RHbc2S6rOWXewlmeB/ihB65sEPrR
         HcxVTIyYYHwQ7HjPaAcIa6a5j6vznuj/hvQpr/W1V0xK2N2/hbS4QOODhZllhxczv3CQ
         ZerA==
X-Forwarded-Encrypted: i=1; AJvYcCWAnlQashpp0LtJFALmT9hGj8bXssDF+2cthe1hf65LddQESYq8ZS6t9bGVg10jXRaeKWvCQZE8j37xt6AQhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5L9gJm2QwSQngGHbeKc0fvhCVwehTb6ppp0sn21Q4plimbj/
	1Yq4uUAv42CzwT/vCsbNfHB38CVglY2yl5ydceAWgQc1BoyqC3U93FVel9r2VwiQmMsWB3WL8UQ
	+pcQSByvsWgq630J3bcI1GDOgD+OfiM1g1KQ3FUhnJLHR7cBVBofZO/AsLqn/A2nLog==
X-Gm-Gg: ASbGncuveG+pn3AW17I9AkcE3JFt3QR+0/haOR5V1g5T8dTHiEQ/zm8BHIYHMSW1qCU
	dhy3jxg1bhYLWPV8O0df4EfOMREXtuJHA6ojTT5RsNViS4dtF90CeY0wHPXbZcRS0zAoSyCuQ/u
	4Xteo/WgmnOaadaXburchNv9aG/rsQf41oIpnxEVANaBgYAVyjVdIATXMUDJIIhgIqeJciUbK2G
	TN3+F4bprAazprNtNCgHGWSUzN1CxVvXZLF40N8MLwS08N5DaRGpxyTrg0T5WshfJEChvuROKm3
	TSdZlUL0hovLH9TiqDmdGj9nE2TWU7Nqnu0SRJiaecW0kWKngab0v5SsmkiKeT0YSOwLab38x2A
	Yi3D/TLR9
X-Received: by 2002:a17:902:d50b:b0:220:fe24:7910 with SMTP id d9443c01a7336-2219ff4e74emr71196485ad.15.1740162463062;
        Fri, 21 Feb 2025 10:27:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqT0lhdlf9xUs5u4H9+hR1MDcGNjhy1drF8rRGCFmhOjcsTVDF/mRwDk9hIOl4FkKbEbM5zg==
X-Received: by 2002:a17:902:d50b:b0:220:fe24:7910 with SMTP id d9443c01a7336-2219ff4e74emr71196075ad.15.1740162462656;
        Fri, 21 Feb 2025 10:27:42 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537ca99sm139294875ad.106.2025.02.21.10.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:27:42 -0800 (PST)
Message-ID: <7c7498fd-ede6-407b-b583-e9b8caf56bda@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 10:27:41 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: please use tree tags in patches
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <ec3a3d891acfe5ed8763271a1df4151d75daf25f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uKMqcHGCOeuHyG6iEXgpuvlDI3O0S2pl
X-Proofpoint-GUID: uKMqcHGCOeuHyG6iEXgpuvlDI3O0S2pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502210128

On 2/21/2025 4:17 AM, Johannes Berg wrote:
> Hi,
> 
> I couldn't (yet?) figure out how to make the nipa bot stuff run
> properly, so please start using
> 
>   [PATCH wireless] wifi: xyz
> 
> or
> 
>   [PATCH wireless-next] wifi: xyz
> 
> for the subject line. This way the automation can pick it up, see e.g.
> 
> https://patchwork.kernel.org/project/linux-wireless/list/?series=936374
> 
> I'll need to fix some username stuff etc.
> 
> I likely also need to add more trees to it - please reply with your
> subject tags, trees and branches to use, e.g.
> 
> wireless: main
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/
> 
> wireless-next: main
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/
> 
> but perhaps we want to have
> 
> rtw-next: rtw-next
> https://github.com/pkshih/rtw
> 
> or so? Not sure if you maintain a fixes branch there too?
> 
> 
> Anyway, good luck to me, and please don't try to attack it ;-) I spent
> all day setting it up, and haven't pulled out everything yet.

First of all, thank you for adding any automation which improves the lives of
the maintainers. Aditya has been working on that for the ath.git tree as well.

ath.git contains both ath-current and ath-next branches in the same tree:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath-current
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath-next

So we can use:
	[PATCH ath] for current (this branch gets little use)
	[PATCH ath-next] for next
if that helps your automation.

And for Qualcomm contributions we've been asking the developers to always
supply a base: hash to also denote the basis of a patchset.

/jeff

