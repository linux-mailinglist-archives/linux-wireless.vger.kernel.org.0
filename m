Return-Path: <linux-wireless+bounces-18460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11114A279B8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F9D3A4A00
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A321767A;
	Tue,  4 Feb 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S3XggxeB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010F78F4A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693706; cv=none; b=cCB0InBIzrxdXWrErxkyKbxwhKlwQ8teKcLC+oTKherLev/nAZ5TYgsRTofxCDeaepMPaFL12QU7xBB5Fc9kNja9QT3w0z8liAm+efgYAHUL+toEfk2bvO6/6xZ99Pcw8ZbiGZI8j3W0tfBvKbmwnxPi2hgV4QHRGAFMulZLkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693706; c=relaxed/simple;
	bh=qcDl83pBBBrF2pPRs2i7Np2gid+G3KcI27QlsGRLepE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PXIvH0vtcLYeRDF0oQ2/j5leVRtyZjHZ3D4QJhrjNASCSIjT16Q6ShVfSheSFsXLYyp9sg3CsA2XElTZX3T8/KUlLeNbsr6l40Up2+TqnIQB3LZWplZ2yRHJNbTj1HP392cCw1q3YA6fxkWKx2s1DKozlG4Q3+uH86A/s8iPYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S3XggxeB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5147Io2R015359
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 18:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mnDqgeo9uUJiQelPKUM1yyUwM5/dmJVYIC9id6hP2eM=; b=S3XggxeBZDqErNNa
	rZc9RxZlbHnMbFPqVgodr/SbYzgwRcBvRWSBycUPDbVTs/VjerLTSsK8+hfSqvvO
	NkZLzXtxZSxEf/I39R3t13DPxaCyofQty2+sIMYzEPZy1GQ4tEzJ+uIlFxlPY12u
	81zT8OsgJ77eH1j0G3aMaDGNxjn8R1hAELo24aV1MgVviOQ0M/4NLSzucxwLqnte
	glAHKC0nr71UVFyWC/jQil2i3u1+97in1fvAxbELpGoPPCiA+31L4h8f6vB3n8g5
	Gq7q7EWYHKC6WO5Z76OhCZbN5oZ+duH5yyXg0Q3Y9QNLDnDX6LU7TwP6ot8uYicR
	LTShZg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kec41jrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 18:28:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2162f80040aso124607805ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693703; x=1739298503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnDqgeo9uUJiQelPKUM1yyUwM5/dmJVYIC9id6hP2eM=;
        b=UIFRxjL9EDv89ysvNjmtTSyCz2LuK+XUjwgwfQYaymmbxK1p2gjrhmtBPFYSOcY7Oc
         d9tB6sdoFxcr7BQW13yOipWoDI8bD7DjhGwmwgZMrFZU+aT5PLmz2kVCmREXePdRIiwn
         6JGt4DgkhvB7B+KrAPOtQJmK/MPQRWIAw13QueSuI+ORKOwnEqawLMxZGn/VxcUlYkGd
         35Ndp/lYqyqJSj4czZ2/IywJuy5XzcQd7lnQ4f4/62WNZOEmYfAT8pXK6A03GK4dlii+
         z760BnD75CMDxm30coMxq+rjB2YtsjFKMX541NNucQk0JObTn/3MdEn8EO2aKgTKJT/t
         l5tw==
X-Forwarded-Encrypted: i=1; AJvYcCWOth+DTofZUcFxn9lspB+pSk1S67HajowBh+6TTYPNWNe6Z9On158espKHlrtBGtXluZcPXxKQ22GnanPWzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyok5GxnBJuPt0Z96U3GC3kQa8nJiT3sIHdkf7I1F8VEI/j8vDL
	AnBUm4VPdavTHc0TePHUDlEMxhzxtGRaMrvjBM3eLO3gRnsGKrAdVmgs0UEoYnQRHFfdE+gDSd8
	1caiHxWN5h3LX0M2ePWaSJt4r0whILW4K+xUzcw9JL6CZLQlkUiMPJxXBHkWscRwcAJoMwQMdNA
	==
X-Gm-Gg: ASbGncvO1QlaaeacCY2IBd924+SizgEOytPhskemhlPWxVGcGpjTCe6M/CMqeq8t9f0
	YHez56mTN/5Uj26PPAZzoNI1zsLp5EEk5C0ZnelcxCIVnkh5l6ziT5zbUsdRqW90dJQbWl0lTmv
	VRzi0JBG3+KVc2us19NY/QQ2TgyXVkG5Xjwz3FsYJBA6AJIapnhzSNuvUnNPLOqxtpWiwDA3IN1
	gV7J8QGwNCr0PQ4GVEjMNJ7obMFuHCzDWbFWoxcZfx15+3upENeU1F9YooRd/ZgJRzDHsyodN7d
	7I6UoBwv9GRAWFrEuMy1X9+NZqueEBev+6gmABwn4+M0L3NGlHopdiCKFUwXrQ==
X-Received: by 2002:a17:902:c409:b0:215:5935:7eef with SMTP id d9443c01a7336-21dd7d78cafmr447489365ad.22.1738693703137;
        Tue, 04 Feb 2025 10:28:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWfHpkj5rPvOMiaCxTkUUngfXcOxXuZuG9TuF99jRCZHmEMKHu4h4bQdbh48P+jn6RklMqtQ==
X-Received: by 2002:a17:902:c409:b0:215:5935:7eef with SMTP id d9443c01a7336-21dd7d78cafmr447489045ad.22.1738693702763;
        Tue, 04 Feb 2025 10:28:22 -0800 (PST)
Received: from [10.227.89.219] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bfdb81bsm13773004a91.49.2025.02.04.10.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:28:22 -0800 (PST)
Message-ID: <a4809256-5806-4e1c-a12c-d5d2a6c0be44@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 10:28:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA
 beacon generation
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20250203214448.1978156-1-aloka.dixit@oss.qualcomm.com>
 <20250203214448.1978156-3-aloka.dixit@oss.qualcomm.com>
 <db16febb-a58e-4a60-ab1a-212c30fb5313@oss.qualcomm.com>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <db16febb-a58e-4a60-ab1a-212c30fb5313@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RMGQelT3qpclcZRCuZghavSVimOJKuIs
X-Proofpoint-GUID: RMGQelT3qpclcZRCuZghavSVimOJKuIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=695 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040140

On 2/3/2025 8:41 PM, Aditya Kumar Singh wrote:
> On 2/4/25 03:14, Aloka Dixit wrote:
>> Function ath11k_mac_setup_bcn_tmpl() retrieves tx_arvif only for
>> a sanity check and then calls ath11k_mac_setup_bcn_tmpl_mbssid()
>> or ath11k_mac_setup_bcn_tmpl_ema() both of which again retrieve
>> the same pointer. Instead store the pointer and pass it to the
>> latter two functions.
>>
> 
> Same, Is this tested? Perhaps you forgot to add "Tested-on:" tag?
> 
>> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>> ---
> 
> 

No, only ath12k patches are tested hence no tag here for ath11k.
This patch doesn't change handling functionally and I confirmed that all 
places using 'tx_arvif' first do NULL check because the refactored 
function can return NULL. Functions ath11k_mac_setup_bcn_tmpl_mbssid() 
and ath11k_mac_setup_bcn_tmpl_ema() always receive a non-NULL value now 
because the caller ath11k_mac_setup_bcn_tmpl() sets 'tx_arvif = arvif' 
whenever applicable.

