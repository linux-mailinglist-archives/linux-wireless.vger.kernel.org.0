Return-Path: <linux-wireless+bounces-23449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5965AC6087
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 05:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEE69E0D9C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 03:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3C1EF363;
	Wed, 28 May 2025 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oiJWnpzV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0B13AD38
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404608; cv=none; b=Zgi7+eaXSF/2P5kVMIvVRewvkLV69Ui0to4oho9UiPj+99jYD4ANIHBq1FFnNtkRaQKwSNww73ImzHFnQ44/34SjQiNIBkh7B9ImOcnGvIMV5n6qjM+TaePsuY/EBPTHIdhaTthJTEg/SkVLxDlssMkc31PpVXF9qpfmvszb0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404608; c=relaxed/simple;
	bh=O65+JDSVsTnlG5OMuzk34+iE83QDO7EeBWuwyqnMB/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uQ6J998OCP6r5PXhdm7e1E/YGr2zU0IDZE3G7Pg+kEZThrmH/MzMoUceA+4WWBpEWEbPkrY3yh7F0rDt0gNYvFGRm76d5zYoY5jyLLFgJ5pdogXR9c6ApuxcF9bEzse7Se220XJzwYdSycTEBiawmPQPQCG1lBYN3kUuWonD3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oiJWnpzV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RHU8V6030924
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 03:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NXMw4K3pG7s8qHHWqVSO894JEEtKzSZne5LydC/3Og=; b=oiJWnpzVllOWbndc
	pYXvOuMWyXzjV+sCgeUTLHvIJChXrF4soyLz7ZvfKRQD+pNSDzAOWN3kAWaABdy8
	2jyycBLzYO2mp7nCnsVw1qIxW4uAnSUtldZFxpgf1+V+1jZk+BrPtaIqnzKu7Rvf
	0zbOgmjWeshQu+ra8cpriYIdF7p27logg4EjC8KJcB5dFG/2zTlDWRNnxQF3eozo
	dlv9jNEPUITDYa1jJSzYIikrnbO/ByMH/AFoq6AzF9YZ0UsdguHWk0Mt/HW21AKP
	LTAcF6B5jAYBHPd8Ho7ofDnfTeRdK7ZQJsJnsawtGryL8clnjM85elucpM/xJF7D
	72P3uw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whuf1a8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 03:56:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2344f94f9e5so20939975ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 20:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404604; x=1749009404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NXMw4K3pG7s8qHHWqVSO894JEEtKzSZne5LydC/3Og=;
        b=tbBN6CEWeluFNsROjBmtnMkwv4ndD9DgNkweOfHWjs2/Mpd1ORQeKKMUcc2tlNS/ve
         UfHeBqqh+5Dfl2lZxDm6qRU7CGHFYFXzGVae2lB87VEEqEbCLH/opo/9pntC35lWAGCe
         M+n3NwAZVmUIOtnF08SmQjvlQsmimcDEEvexbRLaHzfOJ8LXhWfqNUtlWjFJAn3JPDax
         kNoeJosNDRrZzQizWYgHvyhZZDCQgxp+/GMqnx/nRQoN7uvC+ywf8I7lbpnl9JRRrk2X
         x+DWhOZ6jGH4MzquI2uu8GQCaxGiaMhJFPte114iatJNQcKUjvHlLuKNtiAuTJdYcRki
         BeKw==
X-Forwarded-Encrypted: i=1; AJvYcCXIS6ky5K2Alnr8wIlNPyf4r0MZeNxOQ35Pa02lVm1/rjH8wwOz2HVb+QXsn6MqGqDwug/A2OP4GW9VjCGJ/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHdmEh4M3ExACVWRukf5gjMKD+PKTk/KSgYnJ0iVWfyYYmL1s
	4Hrpf+iZdX5WnRTaGdumk+qRuzmdSwiXipsfIjIzhtRuhDQiA6CO7BiTNL4NeSyMAsLB3aEhMOX
	Ky9KOE8pjciUe+RG6/B1UBVFqq8eUnZiUQ+j+b7tzen7ldNVTP6V2GIQdesJnhuyQEGb3qQ==
X-Gm-Gg: ASbGnctbPRwfGYgkLPFyvYUeGgezwgHVdbyRWWx/K576jtFnKUDt48qnAEBtOKtNna5
	0wg9HFmzWkFzAX5r5edAqSC9Ta2c74PXrfXA8IoAo5zvDTa2EFWHf7aLLdNvYdbC8yh+MwXoOOX
	6wj6KOsRLmxs1paP98TWMP1PqVAjA8P58Sks6HPiEL9u3cz5aKdlPHRqF0PUkNDEZX+l8DSoNsa
	e/QDmqVF4cCBWoNTgY6m3/+nXkRs6LBo+pr9XjpsZ34LQBv88AzdO4yy62mbs+14MLpBNhMTPAW
	EjCfAkZ7BcrxKrWFIlYUpjgQwlosZKR9L3wfPMHoZj4NgsrfdsI=
X-Received: by 2002:a17:903:486:b0:234:8c52:1f9b with SMTP id d9443c01a7336-2348c521ff1mr90946495ad.43.1748404604415;
        Tue, 27 May 2025 20:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAlpt4yWXgPfN+qKEkvRNgfwgcKlBaVKh4LQVITeEc7nsjvsN3LkpnfFaNGyXrz4Ta6JkgSg==
X-Received: by 2002:a17:903:486:b0:234:8c52:1f9b with SMTP id d9443c01a7336-2348c521ff1mr90946255ad.43.1748404603926;
        Tue, 27 May 2025 20:56:43 -0700 (PDT)
Received: from [10.152.194.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fe1792sm2323865ad.56.2025.05.27.20.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 20:56:43 -0700 (PDT)
Message-ID: <8c0dfc10-f60f-47bd-a139-d60f2663c22b@oss.qualcomm.com>
Date: Wed, 28 May 2025 09:26:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CI results
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <01da63d05c861af5a71eb18d117341b5f7c7628f.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <01da63d05c861af5a71eb18d117341b5f7c7628f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=6836897d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=FG0n07EsnFDhZw2wZOYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: a7HChkakczPB1hAZE9DnM_i-Tg7L4V3U
X-Proofpoint-GUID: a7HChkakczPB1hAZE9DnM_i-Tg7L4V3U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDAzMyBTYWx0ZWRfXwASVfxdK2ByI
 frLaj8dDDj47gq5wDkNfr0eKCBJ1kW7yE2r+gkHcBa6VNeyvkfxEmTrgcoXyStObSgHqQ5zivO4
 lss+mUeYP7AxitkP04LufRjjeOGTMUWYaeCZcAT3DSLO3IP73376LGxeJE3aDthRtfRdH73p0kv
 lcJWcBUPioly68v24h52OV7oDgi8BAasDmE877NlUlOWK9mGIxACVZwa7cppMWdUrEgzpPolcNM
 Vm8L8lusAs+ot+QAHhkjRS3P0ojMLcNlXBJ9vKaL5bY5LBVKsygbD8PNCR8f6wLxvxRl4Zzab2g
 xJCim/NVn82AWT+ovb5k0fRr2HFkcvInMIxE9K97HG7UOntj2j3nIAB09/NjXyGdpYzoYb2iK2m
 9kh7rjsmynqkGQCST5Fj0oz43onnOKWhLaLYfY8oRcg82YfQ0GmAUYBa/NtHEV0DEb+jw4rs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_02,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280033

On 5/27/2025 2:25 PM, Johannes Berg wrote:
> Hi,
> 
> So I'm probably preaching to the choir, because those who don't pay
> attention won't read the list either, but still ...
> 
> Please everyone look at the patchwork dashboard:
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> You can filter by yourself, e.g. for me:
> 
> https://patchwork.kernel.org/project/linux-wireless/list/?submitter=90
> (but that list is empty now for me)
> 
> 
> If you have _red_ items there reported by the CI bot, I'm most likely
> simply not going to apply your patches. I _might_ if I care enough to
> fix the issues. This also depends on the timing, if it's with a lot of
> time left (like right), then there's plenty of time to resend.
> 
> If you have _yellow_ items there reported by the CI bot, I'm going to
> read that and I might decide to fix small issues such as spelling
> myself, but I really prefer not to, it makes things go smoother. Not all
> the yellow items always make sense, especially checkpatch.
> 
> 
> And I guess it needs to be said, but since these results are public, I
> feel silly manually requesting that people change the (obvious) things
> that were pointed out by the CI bot. I think I'll just start marking as
> "changes requested" semi-automatically.
> 
> Ideally everyone would build an internal workflow that checks this
> before, even the NIPA bot itself can be run pretty easily with the
> docker container (we still do that internally before sending to the
> list, even though we run the list instance now as well.) But I'll grant
> that not everyone can set it up and have enough hardware to throw at it,
> that's why the public version exists.
> 
> Please? :)

Concur with your thoughts here. However, I just want to bring one point 
related to _Dependencies_.

In case of Dependency (Depends-on tag) between series (even from the 
same tree), the bots - kernel as well as the NIPA, currently does not 
handle it gracefully and in such cases there could be legitimate build 
failures reported since obviously the declarations are in parent series 
which is not taken by the bots. So in such cases, _red_ items will be there.

Do you have any suggestions on how we should go about handling 
dependencies?


-- 
Aditya

