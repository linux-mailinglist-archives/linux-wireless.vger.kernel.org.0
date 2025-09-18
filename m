Return-Path: <linux-wireless+bounces-27470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D2B83503
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 09:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549F63AE08A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79392E7F08;
	Thu, 18 Sep 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HuC3m2ah"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A22D73A8
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180458; cv=none; b=qXeNIfofHP5lC3QNcklkEOPARoIIp1c02JfLzG+7iylAK0rJ0IHo60Xp5ZjFBaJQBWY9xIKxasm3Gptsepui0sxahSN7PNLEL9IyV15QEcif1X10IBHszHsw9XpTSPxvmfa2QzvjVCmnqjUzwLFMxbczJfa9SKEvHpuWA50C0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180458; c=relaxed/simple;
	bh=+0pnqooJvvQ3guaL0gULSvIN3AU4QEO/1s7ZgLDrVyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxOY3FThhgmeSLi8afEEfzUpz43/CJSY70G8EEACk1ERdezAi93LTeHXQgPCL0lySh/ABIAv8OhfeV2wgaM09/KPcRO3A9zSns48C3dw+rOQTNYKIZQ9HTaCSVQAMr8/YsL7k9wnrVh81tGTFlep9LCGbKylD4+IFSK6LONVxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HuC3m2ah; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3tGwK026799
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QtCe2RN/Y8pRtGMrLYTfDuCnv7IysubE6DCnGz7W7B8=; b=HuC3m2ahB4bvgx80
	qUemhJL76zjVnfWRorL9tTZoVdBfmD1OC6jLJzEjVNkgJBfpShrGwZsk+T8YdbwS
	sCigaZjWyDCAflV9onILshlLErjzC4wpIRHWGllI6L+q8m9HPzMLqjWDvrmIU9+8
	64ziix6Iliyjm4lJCj3SDi98XGn587KDUlHCaVBDqKnx3vqXFVrbFQcn5e1zSWgl
	ySoijlIpz5VxP/ywgJEuho0vW69SISwqAYcX2wEkM0Pj1K50IVDOisxCYBcEBB+j
	oxNGZwvGgatpO4N93z0otD7NyHASWnUBhdVUiI9+/lGmKnwH9CYpCRG2VJeJWwOI
	izukew==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt5d2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:27:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2699ebc0319so1227545ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 00:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758180455; x=1758785255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtCe2RN/Y8pRtGMrLYTfDuCnv7IysubE6DCnGz7W7B8=;
        b=D+VGAa+lbGTiF5EMANJf5vfiEL7CIU5TQGApA7U2bTvUeSutIpRxSnFgSwwUFt1wtB
         zYW6yvMMwwiUKOAnAk7//XtWddeNLnQwZ5HSevGub59C3Rkw2vQ7pFM0OCKtX4Ix7JMu
         qLSZYSjgXX/oclSyhYOy4wKepSz3KRGOZr7b5yeSHOBCvmgHt4MLa200zkGNcyzpUpBG
         yLkcZrOfy/wMJItF+q9CD+pFN8xkD08JnME3rX/Bh26h8slxr1UGntTE8gYaOsRHFHdU
         R+bWow1g/OCJLy38j/w3ZwjKRxOtHTlp+T1iFFFfYM3ZON03ObhW2xR7EuC3P72FItYT
         v5cg==
X-Forwarded-Encrypted: i=1; AJvYcCUIU9wmzs6I+kbGkOxKHJHhsIa8MNYu9ufTXATTrtHquvyQH1WovPlbQKRLKy+wN7uP4XtMBKcgKsBkQVQIPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwl3N0BwyPuooCTiK7ruPbWU/MAjG5sEaHXycehevMDu5fYm7K
	V3NsNoNgHLvn07UNXtgH8SDi3TF3LmNN/V5EfgHmeQF/eBFWMNrlImjqVlgBs5VZSdEd1zrYmHB
	EQeHXWKTpdBhfJbhR/EBNOunlxyWMZ/xqsFsRMvcEbds9vXUGtn7sk+t/XFLDdDiWsLiSaQ==
X-Gm-Gg: ASbGncs7rHlXP8xFw6EOT2HW3eBYoyPVPNwO9VG774I6nvxTI7ljxtlj7TfPpIq62ny
	P2EzhdTTSWOqDm++6mIsrByJiGN8WbZ0NR0s5ixU+GHpD3bnxDScJhiiflLdpVzeHKzymDe4peN
	4+7+SP9H+X1mNWSHQP2PehbQ1KWnq+GMxhbbt1ZGjI/pGSE31NucRTSQ3oiDce142P6pQ7nBEN0
	IgnOC1wExa625Y94z1rKaCPw+O2j5kVj/bO+DbuHdVldEBFPEeb286Dd+bslIa8UbKoID1198I6
	Yrj4UQbwBea5cDEevWLE3Ize3QJ/8S0Pwwstjm66v8e5BPnO4a0NlG362fOlfJufDh8yW6HWj22
	Ff/+NcQ==
X-Received: by 2002:a17:903:186:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-26812184917mr59001715ad.22.1758180455510;
        Thu, 18 Sep 2025 00:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErLnyx0n30seI7eSnLwhrrBGTy+VTJlJ2pd6118rrdXNeRKTAy8YPNg5NJ/hm0KMGdyJ+OsA==
X-Received: by 2002:a17:903:186:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-26812184917mr59001265ad.22.1758180455032;
        Thu, 18 Sep 2025 00:27:35 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcbesm16608495ad.88.2025.09.18.00.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:27:34 -0700 (PDT)
Message-ID: <d6ca6b1e-466b-f90c-a75a-b9f88ca63aa0@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:57:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath10k: avoid unnecessary wait for service
 ready message
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1R4Pe_dWcee9BYF30uURwCHJJuWNdr7B
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cbb468 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mpCJlUNt7pqHQ4OmjRMA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzPmcdJ8kOUxp
 MdWs+b0gcynq9rkzHzeZnquyUhAe/PsUdUkJ8rmlCqkfj2CikpApnPLBtKbnqTwd+6q7zK2KIN4
 Tq11MANu5ayf71xQCrBqaGhEb++uLOCXdH4MNvNEAtcfZiRtKF+tvZ6h7gt+DER4Uru8xrb0FlP
 e1KxzcFIZUTKkmHrS/pVtY1ppgR5dbZhRz6p5iDvG46uNrWVVmMCzXuQaCD4M3aE1MwxmzipOUF
 UMvd8RKm7UWq8WLgKqd73vON/TNsvTgMDFRtgckZkvs998Op2TyzOMWZifp4instRUtmcPT/NEc
 +fXghb/IUMqCk8AndUjOyQeBPWIVq/wkNPKNe58axvM80nWMo9gH7c+kCJ096HtwFqwdP8m8fBB
 TOWIHBAo
X-Proofpoint-ORIG-GUID: 1R4Pe_dWcee9BYF30uURwCHJJuWNdr7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/11/2025 2:56 PM, Baochen Qiang wrote:
> Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
> failing") works around the failure in waiting for the service ready
> message by active polling. Note the polling is triggered after initial
> wait timeout, which means that the wait-till-timeout can not be avoided
> even the message is ready.
> 
> A possible fix is to do polling once before wait as well, however this
> can not handle the race that the message arrives right after polling.
> So the solution is to do periodic polling until timeout.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
> 
> Fixes: e57b7d62a1b2 ("wifi: ath10k: poll service ready message before failing")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/all/97a15967-5518-4731-a8ff-d43ff7f437b0@molgen.mpg.de
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

