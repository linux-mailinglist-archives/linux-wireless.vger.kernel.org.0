Return-Path: <linux-wireless+bounces-20176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD6A5C689
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94E63BA768
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6232525E82A;
	Tue, 11 Mar 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbHtfjoQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE025DD08
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706439; cv=none; b=oqdBSPk4WCZLmD8ABeC+cASnmOitacGwchQulewWilM83sTnIj5Aw+Gw3Ly+mQlB8ANrwfMDVn7Y/nvGa1OJad8d5o9pJp+barfdE4yJewx2B9BAp8uaC7gUc+ZPrCqywZqf549/4ZTs4Rgkkp8KmbOXRraIwyKUkJHlOFAR4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706439; c=relaxed/simple;
	bh=xbIYcltamSKWajOA9SFxU6mIAIXWX9r9mUII+sBAL+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hm2/9AW9nQRqt2TNIOyd80SDimj60saBNnyg2+3IvRTW+dxz3kgThXMZlhRw3cXR/1/L57EJtjth2kl1+ZjrUGTTOBuiEc7xBUygQiF+xN8pCQl9QMtO7niKwYN45Qbl4KQI3Zp8GlqHEDv5bjUnDodvKIIXe7oZOpygetuDmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GbHtfjoQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7hbOr022620
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 15:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6S5ygg+RCYgkDd953aVyRkTurt13EX9y7F3QCMrgVgc=; b=GbHtfjoQB8/5XvFF
	odcnZMfVHt9SVzgJg/4yZpWld8MBehRt5ngEDpzvqPbdvBVv0FasRnsUNlt7DAEj
	Bq9QWng0NYKs1Zq6UfnJfZN8L6lKXpibvCmDJQg3Ak9t7vDwMh9/p+z+g1oGZxFU
	3+U5hXKvq3eGcIn9BKRPJkBUsL34ZZWhSqchlXo+e5bf6KO0dLU0F1Jy16FHZqab
	HwYtuK/AxSfHTrnLMbOLPx5UuYky3AtcTQNA8aN0EW+qsIaXFjw3MKtTk/dCgZDX
	uqRcyOOguS42t6cdUaL/78FJ6SH/feS2H0/fTGJFgALxT1zA1H37K89XbKhcaziI
	5xBHXw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewk935n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 15:20:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225107fbdc7so56758525ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 08:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706435; x=1742311235;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S5ygg+RCYgkDd953aVyRkTurt13EX9y7F3QCMrgVgc=;
        b=d1vY+qoa6K72uQmQj9VsNVRAlZGTKp6BOn9bx+BtH5xM9OCscLfJTDOTeqTWxYKnvu
         RH6/RqAOTxFey8HiKAFVgk/TfKJ815S9gv/11KEmzkLdO/mPhnQ0tStavzYm9wsa90E1
         Ss//f8hXvFh4hkdDEklsFoZd8oVCC7RQ1hfCHjni4tGU1dsNk6xUsfPGqgUDYwTgLjwr
         llw7Z9ONqZE1734rFgJLM8d8iRGV0byfeCAmHSHK+Rx6NgGvjXQEGl8vhBUHGMgst439
         Se1ElzX2ED+H85HzI1IdPgPDd75StcoGCaXnQBKfxJ7+pH1YqqBoo5LYPw2rajJJlJUS
         SJdw==
X-Forwarded-Encrypted: i=1; AJvYcCWBLIb9QZwwHeHFXxqRWnnuShClHeOB1stzkpfxc/iNFFMucfhu25OCjr01Wdx3A8B5gehziPGVPZVvqDjaIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEUB9C2jo/WsB93zXN6ATfV06KCUNdz+Z3nz3wWqS+BQT75dp
	4hVzmR9zSRwkh4OzW3Tdpl2soiY701WI7CL6xMgxMUOIXrJ4Lg7OrV9tDy8wBQTzo8aHtqxMBj0
	i2Q0sCevZWoKk0lZ6rqNwsjDOWT0WwDzs+c4DnM4qscgU8WwcaCTgYwHBs2AiEzPzCg==
X-Gm-Gg: ASbGncsWyH7X9BWPIJkj4kxqM6CMgdRUKZZy/lOurIzX23Gbcoy69gnnggl7BldxBVw
	fw6HKthaTBeHRwHUImoRwjvI3hOVFt7TKHuZpBct9tqsMKS4Ztfy1LVIoK1pooQZ58GIuRZmBib
	rRE7WByWDFO8MsEPKB+xPOtOnkf/T0Ugn/0frNGLVgEGr3oxerUYhCPAU87bAa+w3cdTIyXVy91
	WIA7IyAav8KfJjpbgcWKAsF3lZP3YF3g63hGAZq+PKB/Cxf35pBGsnUJBm3o4lxOeJSVpez43Yu
	TUZZlpqwwuITs3YL0TsmMRvb3nUUWjMSdRiiFgaWjl+jWGePBeZ3trVLDaInajbM+atVZlg=
X-Received: by 2002:a17:902:ccc5:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22428a9d152mr264950345ad.29.1741706434949;
        Tue, 11 Mar 2025 08:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO6l35iZWPJ3KWFhVCy19eV0b9mYiGmLSNfasvFshbTZzRkI+5187/fK/CQbEGiBAF6eAu5w==
X-Received: by 2002:a17:902:ccc5:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22428a9d152mr264950025ad.29.1741706434546;
        Tue, 11 Mar 2025 08:20:34 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e816csm99020365ad.54.2025.03.11.08.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:20:34 -0700 (PDT)
Message-ID: <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 08:20:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, Johan Hovold <johan@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Tr8chCXh c=1 sm=1 tr=0 ts=67d054c4 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=uOWRnoLIEoXm2GSVXJgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ZUfCtbRblE6JSobtYLBJV2epZ2L-mkyq
X-Proofpoint-ORIG-GUID: ZUfCtbRblE6JSobtYLBJV2epZ2L-mkyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=784 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110096

On 3/11/2025 1:29 AM, Miaoqing Pan wrote:
> On 3/10/2025 6:09 PM, Johan Hovold wrote:
>> I'm still waiting for feedback from one user that can reproduce the
>> ring-buffer corruption very easily, but another user mentioned seeing
>> multiple zero-length descriptor warnings over the weekend when running
>> with this patch:
>>
>> 	ath11k_pci 0006:01:00.0: rxed invalid length (nbytes 0, max 2048)
>>
>> Are there ever any valid reasons for seeing a zero-length descriptor
>> (i.e. unrelated to the race at hand)? IIUC the warning would only be
>> printed when processing such descriptors a second time (i.e. when
>> is_desc_len0 is set).
>>
> 
> That's exactly the logic, only can see the warning in a second time. For 
> the first time, ath12k_ce_completed_recv_next() returns '-EIO'.

That didn't answer Johan's first question:
Are there ever any valid reasons for seeing a zero-length descriptor?

We have an issue that there is a race condition where hardware updates the
pointer before it has filled all the data. The current solution is just to
read the data a second time. But if that second read also occurs before
hardware has updated the data, then the issue isn't fixed.

So should there be some forced delay before we read a second time?
Or should we attempt to read more times?



