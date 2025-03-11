Return-Path: <linux-wireless+bounces-20199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B33A5D35A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 00:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734297AA7C3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0827231C8D;
	Tue, 11 Mar 2025 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShoKnTPq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC822F3B0
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737020; cv=none; b=Hd76PI62gsJKWja6QY9wpi1zogc4g8YiZcMfGLfISB1UuAIwbN28U7sgnrEH6SDVQQ0RXSyUJB/eco1uR2mARbfpO8hxuIFribZzC8b5BoNqLCUqpcZYsUKMAsCHMOJ3yas+uD2pdAzunn+HdA8xJ1puK1zQtnAnsR0UC0DRfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737020; c=relaxed/simple;
	bh=947P92LWN1PQsL1NjngmkpV950HAXBusCIiwk7trb1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWTUt3HHKQ6PpQ3aR40oKhEnLZubNI7dtOJZMp6ZJyGF5lfnuxohts+uCiqfULoPtOAJZqTvCo6uT9YlSgGwsG50/f8k1CqnGI5BTHFXx+J8wGFN07wOQ4OFfpR1hPO8Pb2lpqS8IvxoXlTvY+qikjmZ5AlbanM28e4l6mDhWQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShoKnTPq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHE2U008924
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 23:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KSwxLEzFOquxNWm7S5SF5Il7NMTbysSakigO04XuV+c=; b=ShoKnTPqBX0WE2eq
	pIwq6SofCbIsCzwTNu10H0jiK1M7+Co2KV7g1irKC9hiWhPTyI9eRVDDNq2hUl0O
	B5/YBRaF6qT/mld+7HOmrU7vdJCQNH2GMNMQJxydFuPTyK21zwm8qbpV8RbGqg7Y
	6dn0d7FphXaJlSAggMg8EyjhcaiIYBO4QF1e7/pb82qjl9No2z1waRXtwaMCVyF4
	QcGapqVx3eLAEN6P4N0GuHcYcAc9mFTR1qO4qRh4ce3oQm+42Zr7bCwEdcUnByez
	AbN+8KGeYcMoe+PBymMvFtQCbNsiTpa8O8TB4t/n4Xyk+cnv+9JaVyauIna8cHpy
	aQygoA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2r8hen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 23:50:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so9248510a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 16:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741737014; x=1742341814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSwxLEzFOquxNWm7S5SF5Il7NMTbysSakigO04XuV+c=;
        b=RGwIjf0PoHm0gbJvfxbJ+L3J7MlaWs3cKEXwk7wafgWjil07HZM0XH1/Hzk51Ha8QH
         3wymM4Mz7+N5aWGsoV+OEFYOMsyrhwewwJY8yTD/0fjm+Eey+Oo63QJNQqYDkS4rzaFP
         JBpyr50mX+8SVr0o/QIe5C1swMM4zPH6Ba5moN2SXtryAAc/x0/r/Vh506Zj37wiXAws
         SxNpbk5MRpsSBPzZZKf8GnnAyJiSPCPc5Ul1bNPhPRBPZkRommPxwDhHF3KdEhqLcTGd
         9lox947K/4A1aeBj8XIbu+Qhf89u1aXvr+r2x/5z7/2h7WyiAwWypwgd4xMJbiuqlNoU
         5TFQ==
X-Gm-Message-State: AOJu0YyEL1XBwQ7hrFvYcGto/6UHZyuxhIeszQ8MdiE1xuRA/baioXeX
	sBPf8CXs+pRyWTr8mtvg190ADG4+ljSSzeW4Q4u2BTDYxDD2AA7ILu9HXiB2E/7OlYT4+Vvuzk2
	SBj3BcuisKvn5MB+tf5P5tqcFbkWZZmoGP0rtlvXqk2vSQscpu2YcMl8Ykc68GQMOGtSQ6TwPog
	==
X-Gm-Gg: ASbGnctwbOMP4Bt6TVWSeXTg2bEP7qUEMkv0f/UVUbP1wScuLU3N5Qefpar27o31IJJ
	VvoYQl8q0jA1VxyLPr8a7vynOrw70K8S9GkuAGKb/6BMmEY7fk+Qc4hCGM9WB8b/NDAv0wCUIQ+
	M7xGtb1Zg/ZpRLd7PdMI9K4eoBD2fDTLBFCrk2GUh4sTLbDMEX+reIG++LXUrIQlbVZCo6Rzye8
	Ls35KzNNqnJEynOv1FvVIOTOfVjHqvT3LQ4fq0+ddU14NjdcKQVh3wfkISjlfe8wa4jky82LGGS
	1KFzPsRfFfAX01CixjL9c8Ai6QARhfFh3OEik5nJxboMpingQUUuiZVfwpmVlkVl/jW7
X-Received: by 2002:a17:90b:180a:b0:2ff:7ad4:77af with SMTP id 98e67ed59e1d1-300ff10d6aemr7012979a91.20.1741737014184;
        Tue, 11 Mar 2025 16:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsoFL5Vka1zauC1v1RiK0uyDMevsg9XXmXo5zTBbQFnxlN64zDXfXqyuwBdulMTGJSRyvBYg==
X-Received: by 2002:a17:90b:180a:b0:2ff:7ad4:77af with SMTP id 98e67ed59e1d1-300ff10d6aemr7012962a91.20.1741737013697;
        Tue, 11 Mar 2025 16:50:13 -0700 (PDT)
Received: from [10.227.106.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30118218707sm215485a91.3.2025.03.11.16.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 16:50:13 -0700 (PDT)
Message-ID: <d3cc0cae-4e37-48e8-9c93-aa489099c3fd@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 16:50:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [wireless-next v3 1/2] wifi: mac80211: Create separate links for
 VLAN interfaces
Content-Language: en-GB
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250310223528.3528897-1-muna.sinada@oss.qualcomm.com>
 <20250310223528.3528897-2-muna.sinada@oss.qualcomm.com>
 <6bd5a19c9c87b671af6a0c05a47f5167d032f30e.camel@sipsolutions.net>
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
In-Reply-To: <6bd5a19c9c87b671af6a0c05a47f5167d032f30e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D6NHKuRj c=1 sm=1 tr=0 ts=67d0cc37 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=8Ohk0volueyHbZO54zQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: brzr1oquUaScvErc2rgBjU7m1Esjlfs5
X-Proofpoint-ORIG-GUID: brzr1oquUaScvErc2rgBjU7m1Esjlfs5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_07,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=961 clxscore=1015 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503110158



On 3/11/2025 3:29 AM, Johannes Berg wrote:
> 
> Can this not use for_each_valid_link()? I think
> for_each_valid_link(&sdata->vif, link_id) should work? If not some new
> macro? I don't like open-coding this "if (valid_links)" etc. everywhere.
> 
> johannes
for_each_valid_link() is a cfg80211 macro that utilizes wdev to
access valid_links and links array. Using this macro with &sdata->vif
will not work since, links array located in sdata and is named "link"
and valid_links is located inside vif. 

Should I will go ahead and define a new macro that is similar but
utilizes sdata or should I stick to using for_each_valid_link() and
pass in &sdata->wdev.

