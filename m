Return-Path: <linux-wireless+bounces-18486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C175A2816E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2411882708
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6356AAD;
	Wed,  5 Feb 2025 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZfVZAwn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB434545
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719857; cv=none; b=t8Hv7VXdk6V7M8L8YTkj8xElXngnoJ/rlFzg+PuejBCTqotCavJf3jqO+WneZn6mbV0jlKl9iSaQmL6itQvi7iOcckYVaQCIrNzEm6rkEvvOs87Cjtl43FoezOmMVfYD7Tf5Zq0kaPQ7dUIEELPfMBpEu7kJCtuQ85SN1IDtl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719857; c=relaxed/simple;
	bh=1RSWzxdsWZPGY15pOPcUn/5ZceBTkPE3LmOX+R6fgLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+dGJmctgXTQsVoZ1jfYRFRl8wax24CL1CYMMBe/5crkmxIOvvOHxI8mfAEPx+uWSTyi4lCk/t917dwqVCPq9vKzjSlhMv57YC6fRcwImmYlgSme8oPyryZRfVV/ur3nooeiFV6yvRmjTWwGmlGC43wUCunTzKZG06kXABuxtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZfVZAwn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514IVOsa000767
	for <linux-wireless@vger.kernel.org>; Wed, 5 Feb 2025 01:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F/fZynMqFI2qaQKuADObBuR1aM7GnfYzK40ZwnTu1B4=; b=FZfVZAwnGrY3Yowy
	yv5Z4vlXkamTGLtWmwhSzwtyDuQrKgkR551iJE/8G3gNLbRjICUrGCuMryPb50zR
	a53q3NwhSDIKHNoWxNQB3gWK1h8d5btqdomVMa8woXZG3Ut09zGNrCn+QKKeLsfK
	R9UqdpE7vE17ddGg5U6n/g0t6GqlMxx8+IRGV2AolGdMLlSJI1Fx/Hg6WzWZqWVB
	E1e/yfPt6M5XEvPey3wPepAQDdS3nuZCerJVYYfqWVBC2Pd8s5/U1zKKdRSVMcjR
	YHTNdmHIXP2R03/mGII5EjcOFQoPFeiAVQTrQO7RtMLb78V+BrTGS2AfeBp7/Vld
	o+1SoQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kr8e0sa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 01:44:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216266cc0acso8612405ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738719853; x=1739324653;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/fZynMqFI2qaQKuADObBuR1aM7GnfYzK40ZwnTu1B4=;
        b=HjP8j0lsI0T2gApb9t70eY1ONEahgKiGHIYV0PSzj7rv5EFKYdQPky/Oln3fZDLgNb
         bTVCCGHrclB59zU6IRINStBcH08unFlIfYj98R08J+HrywFYsE+fiHQNXhE5IYXBO7xK
         QgjAhYhEY/n4oA6JgrhYSheApA69LoNyN2Y0JrqpQaBtfkPmrlbyuRYhb0D9vsjGY8Gk
         mg2l9L0OuaZbWr23pFK8dJ4NOsHEs67JEooYcWkBGOlz5O1Q5oAMow38Btvm9KZssRUC
         9wxDY2P0ZrDZhQ1JLHpo3PPq3Do4f4qc6doCiBiCYMvlkKxRTaOtXeRiqM/hrUjNgthW
         mr1A==
X-Gm-Message-State: AOJu0YxzmBWpHeIxSxq/n5qbQztav/wOwrbOQLfK0ArValFiNtILXs0R
	/Y5DWx0FDlVlNpvud5Nac+tLRm+Pw1bgj8nBqBy/N5eoxt8hPk+TW5yURRcOlTdw1NJx43e/hgC
	3nS8ooGHVfDp3M8ovB6EoWrjtpjQRug0UVztSFY9Hvr/+LDgSHCzQ67zeFIhasVrCtw==
X-Gm-Gg: ASbGnct8Yl+XMqop07Q3qVXCP9e23XsoSiokpqQxD+slWQeFXMEXdZPmnXAwAOW41IA
	EyT2yFKNpHHaqmnRwJwTQt9piAl87Zweh8xmnrk4PmrC4hXQ4Kz0T7xxxBIgS+0K4zqSTVrXhUX
	/bUL/e3Ht7bGMiAwxXwLZpKaPVzacgtZzAeIcSCFtiN+yfCmhZ5tf44vB+3SZYkeqWFiq3Y6mZ+
	qPw6BMTK/oXViZPd9ax7SaHlVmgdTzlIt5nz4N7M2VZcC/r28QdvPlIqC0nj3YNdx5QqWKfXXuz
	KdDYlYgKjfCJl8Dvcmg8ree/g+dwXHCFuRb77ExjyAmSrKjbDFAn3enEyGTCgxBld4jZpXjNLA=
	=
X-Received: by 2002:a05:6a20:12d5:b0:1e0:cc01:43da with SMTP id adf61e73a8af0-1ede80ecbebmr1716015637.0.1738719853516;
        Tue, 04 Feb 2025 17:44:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcvrqSxuEOrYaUAGZfQeUUGM7t1FAafbakDitTpYHT4O8gxb/KoJm5TXE61Kmf104Xes5tcw==
X-Received: by 2002:a05:6a20:12d5:b0:1e0:cc01:43da with SMTP id adf61e73a8af0-1ede80ecbebmr1715991637.0.1738719853133;
        Tue, 04 Feb 2025 17:44:13 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f109786cfsm10499915ad.12.2025.02.04.17.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 17:44:12 -0800 (PST)
Message-ID: <f82f033d-e399-44d4-8291-5e17fb42366d@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 17:44:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] wifi: ath11k: fix data out of sync for channel
 list for reg update
To: Kang Yang <quic_kangyang@quicinc.com>, ath11k@lists.infradead.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250117061737.1921-1-quic_kangyang@quicinc.com>
 <12fad7bd-86cd-4c93-8fa2-35ec7b10f5e7@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <12fad7bd-86cd-4c93-8fa2-35ec7b10f5e7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o6EHX4Vo0aPehx2YGHhO5mqBiFoG05r0
X-Proofpoint-ORIG-GUID: o6EHX4Vo0aPehx2YGHhO5mqBiFoG05r0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_10,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 suspectscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502050008

On 1/21/2025 12:00 AM, Kang Yang wrote:
> On 1/17/2025 2:17 PM, Kang Yang wrote:
>> Currently there are two threads to updating/fetch data of channel
>> list, and there are no synchronization for the data, it leads data out
>> of sync for channel list when doing reg update.
>>
>> So change the call flow to make sure the fetch data running after the
>> update data finished, then data of channel list become synchronization.
>>
>> Note: This patch-set is an old patch-set in public review written by
>> Wen Gong. Just continue sending it for him.
>> Link: https://lore.kernel.org/linux-wireless/20230329091235.19500-1-quic_wgong@quicinc.com/
>>
>> v5:
>>      1. rewrite commit message in patch#1.
>>      2. update copyright in patch#1, #2.
>> v4:
>>      1. rewrite commit message in patch#1, #2.
>>      2. use list_splice_tail_init() to move list entry.
>>      3. use data_lock instead of adding a new lock.
>> v3:
>>      1. rebase on tag ath-202411251703.
>>      2. add KASAN BUG report in patch #1.
>> v2:
>>      1. rewrite commit message for patch #1 and #2.
>>      2. use a local list without the spinlock held for patch #2.
>>
> 
> Hi, jeff, aditya, vasanth, any comments on this patch-set?

Now pushed to 'pending'


