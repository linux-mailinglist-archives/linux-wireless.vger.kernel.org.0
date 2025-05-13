Return-Path: <linux-wireless+bounces-22907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBCBAB534C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 12:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BB84612C3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C923C504;
	Tue, 13 May 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIM/Tavf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB428689E
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133809; cv=none; b=KaNjFlF9Lan5VHcKRuvzZVVFu/eEqOG5g2agJhE1UT+JJtaE4Cg/LmE5QU32EHX7GPViCL7FJTicYcxwlhEvFA4JRL8EDbRPj9XHYCGvDUFAhsqCbEofBkhp7AvlUPZPGgKdXXQvH7HwrVyBRpwTxQwCSZzhxiKNsDL1BgK3uUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133809; c=relaxed/simple;
	bh=L0oZNBNb5KDSBD1YnNTVQFxqf67QjDSZupvPJk8sUXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZ99QpRuGJiFVmzc60B9M0RgzeZCHYyIVWNM0u15mz7e7vKiU04vJqtNw4rRnVAzJU/90i+Zq+976sGDX0BtQVMGM8LDsJdrSyJ+dvsV/2xQxP+74GMMyeeTn4F0oaXf/y0zD34WD22Ex0EJr3TlaqdTMITC4aOXQVBsbrmYZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIM/Tavf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D91RWc028428
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FJBRR62o3uX80SBDIqqnKU3aMyKpPYvJPwwRrE8Tb+U=; b=SIM/TavfqUtrS4Os
	xK0Wqdv+B/IFHjJnB8P+MJ11WLhBO1ScJcAZ0QXSwtNwzaRKC9Brh+3EeaP5asdf
	FvKo7Tcwwd//7eP9ONY8jGtieuRMnnHZQrhdYVT6Bta1/GIFXHZ2cOrXbQ36UeiT
	RLIkKETEHzTRkM7J+b9TRGDFayAOr5T2JLwSjRJchJGGvzeoiTmg2zM50meU95u/
	uDQ3liyCR2FlwWeoykTv396vN47fiTxtnIWTiZjyL4AuVg51UHRkTqZ/zlUTxOdd
	eiPNcfl/B4/2e/TWBAnbDie/q3/CQ1WijjZA56TC72keJDtgYa1geDWtpkp5lS2E
	eQ2ikg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hxvxfeeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 10:56:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30c1a269a12so8021169a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747133804; x=1747738604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJBRR62o3uX80SBDIqqnKU3aMyKpPYvJPwwRrE8Tb+U=;
        b=iJDwN4K/BW3HFba/+H7Nh3C+sh2L7+tUi2nKgKq2P4zUCn1YT4a0YHOKzqnnbafxgy
         +uzwrjUMdEtaYsv1hPxY4Xs4UzKU3/VFADZRrjzLRHCpZwgI4CGNjr0hdV+KlHos2whu
         8u6ly4kN1MzWx0fjdCfxWZM/2BHY1mi1gjztmRO+63NCkuYUCoMrSu1NymSCdLXVZUWM
         pko1VKctgdojzqclAOvDo8RUY2aJIuzlVlAPPE5Co0P86TsCn4TqgNUVviNgubOYGaE9
         0NcvJYbh8eDz7/43NtqsZ0VooaLyZkZVWoLHSGGPQ/QnicWfgUkZnTk+XuL3Oqx9uqIc
         UJyQ==
X-Gm-Message-State: AOJu0YzVLjHDCCUUSmbr1vJ87WHT0y5o5uaUyQC94LnZqIQ2R5bwZ/9x
	kOLCd4GaqcuHGTauxZVZnYlBnF8yBYK6vBh1QEZrwLvjaWhM0r/eTlLrn8J5csYvWeGsPBp09J2
	wS50Vp6aTCGTNEr0V+cfr2wj8ahqev4zmuELviP8nLF2fIVzzZSxND2Tvpw4M/JRFodcYwI8CxQ
	==
X-Gm-Gg: ASbGnctno7BzQUvdrdNjgmKcBHyZQJ6Bi0PJD13DjXUDev9HUNdKeCb/DSfS75C2NG3
	AdUYkJiPkTi9y24FoTZDciHBjY4XU7QXVsLt93mqLepfycv+ViwqTZGCAUSvjImoo0ug2xDMnCt
	4QnmH+nRrdEcje4i9CAwoMwAJu+ek+ljJ5lE8jhbqHayIvNMz5tKGu+HOZ6C0ypspxO9BL+uX+m
	X8AmxZ5Z0HC/zr5e2bYjs7nls0jK4y5R/LqGrJ1z8h5VRn7CpggDeHJQhvIxQ2cgyMjddDfm7FO
	/vCB9bDmvrvrHaWHlMsBSYU3jeNVsCq8TLryj6oLoAK+AUchpf8=
X-Received: by 2002:a17:902:f70a:b0:227:e709:f71 with SMTP id d9443c01a7336-22fc8c8ccf0mr254953145ad.29.1747133804455;
        Tue, 13 May 2025 03:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsf5tREbUMFBBtD0Hz+Z0kckWcjsKPrOZzQurZEc/5IkxxH/Fa6v15+tlLj3WYvlCqbZehBg==
X-Received: by 2002:a17:902:f70a:b0:227:e709:f71 with SMTP id d9443c01a7336-22fc8c8ccf0mr254952835ad.29.1747133804060;
        Tue, 13 May 2025 03:56:44 -0700 (PDT)
Received: from [10.152.194.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7540056sm79235615ad.23.2025.05.13.03.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:56:43 -0700 (PDT)
Message-ID: <772514cb-298a-40b0-9a33-a7dfcf037bd1@oss.qualcomm.com>
Date: Tue, 13 May 2025 16:26:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: validate SCAN_FLAG_AP
 in scan request during MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
 <20250513-bug_fix_mlo_scan-v1-1-94235bb42fbe@oss.qualcomm.com>
 <16499ad8e4b060ee04c8a8b3615fe8952aa7b07b.camel@sipsolutions.net>
 <26a9e68d-bce6-4bba-871d-13e2aeee3fed@oss.qualcomm.com>
 <296b9aa887022258f8ec8e4f352822c24b41ab82.camel@sipsolutions.net>
 <77fe950d-c5af-4c28-8b0b-bd1aa08d885a@oss.qualcomm.com>
 <d211e634532031322a77053ff912394714b5ff35.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <d211e634532031322a77053ff912394714b5ff35.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNCBTYWx0ZWRfX8Jjz2RFCEOED
 lxH5DoB1jgXT/ocAXZOFX3ahp7f6Wrn2srkO0y0uFLuCWpoPoRMTjgOyKot182j5W2Bs3mj9G8Q
 z3HQ3/SLs5Pb1q8xS4hSOo/0vJ0f2OHKnrMbr9/Vvw9eQ5gyokQjSYVQVy5AqRJPKcE51WXSAa7
 owC18ETjQcxvOr0OjAX4kqDMHnflHVFqqoi/+9ER01sz5BIKeM8qBiJeXyAFG4FJJG/Axlxw82M
 /qeXiVKNK5nPduk4zj8WrGBxjTN+tjSuUzNUQccvyJpThyzNcc7wBSURMDuKOEuA/gzqrT6ecKP
 cpSbRl77VPCtDsNXV9m0Xz7Dp1nLqbRtlUdanbR2kppOkBIsX2R4ALAPqv9xNCbjRdL0xcMN1P3
 CWjCnaheszti1SCC34i7N9l9c2Quwj45gi5hwfo80N1f91b4ZKSeTNYNrphU6AfHNZ4aMcqu
X-Proofpoint-GUID: dyhc6XBqDcHIUtwOUip7icAcCm6izW54
X-Authority-Analysis: v=2.4 cv=WMV/XmsR c=1 sm=1 tr=0 ts=6823256d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yWWtvJtKPxVNrAc7q94A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: dyhc6XBqDcHIUtwOUip7icAcCm6izW54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=720 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130104

On 5/13/2025 4:18 PM, Johannes Berg wrote:
> On Tue, 2025-05-13 at 16:02 +0530, Aditya Kumar Singh wrote:
>>
>> Okay sure let me first send a clean up. So,
>> ieee80211_num_beaconing_links() should return 1 for non-MLO as well?
>>
> 
> That would seem logical to me? For this and many other things non-MLO is
> mostly equivalent to just having a single link (apart from the address
> translation.)

Yeah in a way true only.

> 
>> And callers should test for == 1 instead of <= 1.
> 
> Not even sure that matters enough to need to change?
yeah can be left as it is. Sure then I will change the function alone to 
return 1 for non-MLO case as well.

Thanks for the inputs :)

-- 
Aditya

