Return-Path: <linux-wireless+bounces-22940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA6EAB6D34
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647038C3640
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084771A2545;
	Wed, 14 May 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mc4TGqMh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A8201267
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230466; cv=none; b=UwC5fNc01n4cdAjiaBvk0o5NrfJPnThNOkk5hYM8dKDn8eSGImDw+5cR+hCvsGjpydRpgvU0Y58iB64FFsXD8cKdCboLZnMNqwMX48KlQro2bc1hJoI5NApmKPz8kmVEZVc+D7x90VYTztMRsqT6hP01bcABX1Q2oqA+bhX3Muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230466; c=relaxed/simple;
	bh=a93w5vgp02kGmQ+jVj3HlOlMzCfy2fyIyyNK5gHGXaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCnU8sSqiR2ArwUKFElEagLBOpuP3WteTeAe2Dh8+0wXA1ZcWHN3aA77ph6sIkaFZlmH/NEdWgoeYWiZLL7IBbUcaLLHUmLy0W9N7d7X1+UB+wGV4HgkFY1/U1oHbED/K9f2q4tuIMMOm5T+890Bns+HD4CXrWnA304fS0oCxLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mc4TGqMh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAuhVh002748
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 13:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6uM1re45O2wIlVIo/3+whtmMgKvQ4h1XZxYqjCsQfmE=; b=Mc4TGqMht/PxOfg6
	hA0BbEeadgia23CK8qnHA4hWxlKGTCqwQTgvPoDCIj+lVQ3cx/4A9Zk+UbCU4nDc
	KnRY+qJUPw1piR25whN/k19lK4Xsp8yGncvnboctU2OXa1mcRVCKccahtRpYjDgF
	uSA3tj8rRLeMB+sqsDExor1IczvedCknyEtdy1rKYGAveqZEMklTSN5Eg7ipxd+J
	+GTgFO51G+PeYEYU5+urmBg6AgxMutw4+tTmKpF38RUdnk5RfWtRggFQ2bbrYufq
	nG1T0t2gK2w17agcqtUaM1Tx+Xe3oRd6eeY0qlAuXC7ofLzmwksGqV1ZEVI550f+
	zNentQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpaume-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 13:47:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b1442e039eeso4208792a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 06:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747230462; x=1747835262;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uM1re45O2wIlVIo/3+whtmMgKvQ4h1XZxYqjCsQfmE=;
        b=Rs+ExAzHM3gVr15+AN1e/2RbGqEKFdoRCNTw8Wnfi7H0aj3qkas+LCmZwACp/HMZU1
         alLkYYvbHmlXDotk5b0vhc7xYAxjaqwxtIo3eFo9wYN1uyrhYXKbwgUPdJxKeiRlq0lI
         HNlwbLveTXQi1egjglVwkrnY4tMXmMLRcdqVkwmhXaAq2Ru5iE7XpKtjGj5umfmQqlNS
         Lhg0I5eELjgW1BFSg1JdQWKQlJW091iBjt5o7XH6h3qdPAGPCiCstBrcEBZZmn7dLqx2
         UzAjYpIoNia8rUl28XrbrfkMRBC63tZ9OixGipBHrT0xZ3bt3B1DvgdEdx6IVogcwONm
         vXgg==
X-Gm-Message-State: AOJu0Yy9dAy6hahdLSnkaWF9ZfSqazQ5+n8nmYF2tTy28SEtAofXq5aR
	BnjGC/YBgCn+rxjde4YJEKPxYfhYsI9Gruqfky1VOnB31jPdFq4P1BN/trSNz+w2lcdblAPG6vo
	VTuyL1caOjvcoGGt9q51RRKFqK4KfLbIO69SZKiIUT6Ghvax3/Xx67sAFm4Z2BBmKQQ==
X-Gm-Gg: ASbGncsXh24g8YnaA6MEIaOxAkLfyCO6ZV/csMR/Fq5Zs8aVEw3SJWymNEIT5/r5/xp
	yYOFz2yCR/2m1j2/X1/sxeIFSLAh9FEQqjf6WHD1TG4BN++q7BsNwPqKn3HKkW0Rl9B/gPUJysO
	rGBvDJf8l0erJYht6agAXmyqklTGSnWV7CfL0bRw3H0UGjLI8UjdnLMWS44UO08lPWwxVMFrHO2
	FPC7PHN3MWMHcHaF3BQ+9GtCLKsobOAUplAluBFeKNhXLt5JBWdAY3YEpYMJJjdc9CAQEHkoWlU
	P8mIg5ceWHRFOJq7g6waT7kt5KmNosB1YjQqR9+nThFLRSeRYcYrPWCrpCeCxkK3EjM=
X-Received: by 2002:a17:902:e54d:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-231980c96c6mr44309775ad.2.1747230462457;
        Wed, 14 May 2025 06:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Q3uPk/QbEWBOrhtr8PGNViB3LeyTkN11JRz2Zas4K7fDvgwbiBIbe9b160thz6soF12WTA==
X-Received: by 2002:a17:902:e54d:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-231980c96c6mr44309435ad.2.1747230462023;
        Wed, 14 May 2025 06:47:42 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc753fe13sm98929455ad.14.2025.05.14.06.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 06:47:41 -0700 (PDT)
Message-ID: <ff4e8d8e-5835-4200-a479-baa0e44478f0@oss.qualcomm.com>
Date: Wed, 14 May 2025 06:47:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix scan initiation failure
 handling
To: Vignesh C <quic_vignc@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250512065849.2833232-1-quic_vignc@quicinc.com>
 <52ff43fc-160c-4efe-ba9e-42a0c838fb3d@oss.qualcomm.com>
 <f0c8009a-829a-43f3-be03-c6b2a0b67883@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f0c8009a-829a-43f3-be03-c6b2a0b67883@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rTncO3Ka5AnmqCgeW7pJfC_X5d6Qkiut
X-Proofpoint-ORIG-GUID: rTncO3Ka5AnmqCgeW7pJfC_X5d6Qkiut
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=68249eff cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=nJ64htB4QhkbdbSvBzUA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyMiBTYWx0ZWRfX6rzlLIa98YmS
 r7Lz0MS6q38Lr45TIPJ6cwiDH7tpe+z/nDvOhsQE41E5bqzokKpFLz3dr5xo+B3LTUWrge/UMv/
 lXsXMHOHaD3B+NjofDc2H15btT6ax7+nuSyxr3HtzaACbtgx30yL3OQnFWViTxpPUVC/SOt/qkf
 f+/nDQ0pFPwA3doEDDCfZudc4BRfR2y+l9e4YuOBATlriMDxUocVTAiWh5aU0GXyJQ5kAwRwwCc
 DU+teb+ZhAuXqXyAk0ZWTy0wZMiO+SoCUl65h44HgskCKYWujAikQ5Ic2+n/H4JRCzv6BHaLVvR
 95bEZpnLzIk9qL2jp3KWkr6su2lmAmlq/38IwlsO2varoYm0RsuQ481NmHxbKJLniMbkpcGVQs5
 42HUn0fEBjCFe+tLrkpRrUS7wQAKIHVwGbpt/d/geW3KFhsoRI8HaOahp6U4XVog9EqqrWlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140122

On 5/14/2025 4:48 AM, Vignesh C wrote:
> 
> 
> On 5/13/2025 3:25 AM, Jeff Johnson wrote:
>> On 5/11/2025 11:58 PM, Vignesh C wrote:
>>> During a code review, it is observed that in the scenario
>>> where scan initiation fails, the current code schedules the
>>> ar->scan.timeout workqueue which is not necessary.
>>
>> Are there any user-visible effects?
>>
> 
> When MAC debug is enabled, the message 'mac scan started' is displayed, which is misleading in scan start failure scenario. Additionally, a scan timeout work-queue is scheduled to attempt aborting the scan, which is unnecessary in such cases.

Since there are no stability issues this is not a candidate for backporting

> 
>>>
>>> In the scan initiation failure scenario, exit the code instead
>>> of scheduling the ar->scan.timeout workqueue.
>>>
>>> Compile tested only.
>>>
>>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>>
>> If there are no user-visible effects then I'll drop the Fixes tag since there
>> is no reason to backport this to stable kernel versions.
>>
> 
> Kindly refer the above comment and please let me know the next steps.

There are no actions required on your part.

I've made the change in the pending branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=4545ccf7efbd97566eb6d98738013bb6d72ced05

