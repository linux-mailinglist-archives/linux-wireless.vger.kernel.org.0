Return-Path: <linux-wireless+bounces-28413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E9AC215C0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 18:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 400184EE7AF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9031DF269;
	Thu, 30 Oct 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ONpZk3iF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WHX/8wvB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6B2E091B
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843576; cv=none; b=JtfZHNBG1Sa1QkfkN7OwFlabx9/YEpWtq4n6PYgAaTfvBv0nTqE3GviFi25PLz7aRAy3srGPdQPlrZHseLoJ+nJZ4r9TU9EqGMcE63J1OEnNPdXqp23TSns4eplotQarcqv3UklHd+7ksCgZtDx5rgMu9vWAZN/i4R5NYS+4d7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843576; c=relaxed/simple;
	bh=ZIsLeGkuYOoJsW2egdtsH6H42ZoKkgpTqvukLlWDPW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVEGvqK95w+eUekCs9mtRsI5VHckhNY3BB4mJazmwyp5SRF1qADVzr0OhLa/tf+xaCsfL6cJh2RW+qwZBAF43cufaGDJFANpo768s8U4691HfpsS4APByHkh0mStQX+CP+g5hlklyhaLsdxc3uPukbWDpSSlU46fdhgVK6OwNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ONpZk3iF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WHX/8wvB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9MsCx3116501
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wtZc1pGD2SAm3gsjvDf2qc52rmp60R+hZ96QX8U8Oz4=; b=ONpZk3iFuXFg0mK3
	GOHt6WkLWJekO1O/Qy8XJHX+bSA7REgsDN7ZMS3X3m4OI6WD1DVDGx0ONjtflw3e
	28A13NJv83cvr6O1JIQx6RSNEjSy5B3OdUdMVAuXAUe4u6iuMV09Cc29zDUkoO70
	zVi9UAzrugxHOwTdfxO5HPFlvDZeIQ2CBJLyfqjieurAAtM/kDcJHz81pVICy4M2
	aWFDBhiLi60qPTrY5t7oc1wJMAHcrlG7Qw4rWQ10RzlGWTLLyhqkW3jbEmI14GPq
	8AjSQXFS0x6SELDp4piW32sDQRVz46ZHvprCr9GIt8qXN4t4t6YxgKc07OqLen7y
	ZoZpew==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b41age-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 16:59:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6cd4d3a441so1117558a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761843573; x=1762448373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtZc1pGD2SAm3gsjvDf2qc52rmp60R+hZ96QX8U8Oz4=;
        b=WHX/8wvB/eW9ZAhfpeQNQ+f3tfRwpimLCeDWwRjeoAGlTxXX6yRmF6eJuPjB8WjHnt
         TnL+JO10dfEqcoq+mndLz4zb5sLo5iAjNGFWPyE1ueHSoSU/0BKKxQFgeE6nJwYDOE8b
         gEgn559RVnrmKZLzFEHE5hQCncU7eHXvjfJOrhj4feXH9lgh28s3oUp19TIKz7ZKQLwD
         Cxiizr9qo2CG/9W/DTwecAv7TlgXWyQuXJgGLlN/fgA02kP3LCNKgE1WGhQqqf45Zut4
         tej/V+2b6R7l0yzA9nVRDFteRlznD4xTk2AjVhu6VziT0k8RtAWTVxa8Dt7b0tUZcaXs
         52sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843573; x=1762448373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtZc1pGD2SAm3gsjvDf2qc52rmp60R+hZ96QX8U8Oz4=;
        b=RI05t0vK0sC3vrnFYIG5CWegHuXSVOGIx+0jLH0EiyZ4NAI4MnfaW8t1GtIosic60Z
         IGBQaz65HwLjXciUNRfB+zdr6/ro1dO9ZotbY2KyrTGY5Z6Soeq9vLKk8uprs0VsxQiy
         PvRdFbX8v6eV/BMzxKBJTKB/RNouTNRmtR9YFKLJ7ltsmx6hpn/zgRz8yOHGoADyFzGL
         Cs8w/8lrpf8dzoTlg1yEZ3+KrZgHRW8T/GkU89dIBMG3zvX2r+G3rbIRt3aOBqpedjZf
         Yq9xdqcM7l3vPowlE3B/jrYYo20lYYf5gbUrH10tS8h9Ge//yZ9YrOSoac3qGVyZaCdw
         8ZKA==
X-Gm-Message-State: AOJu0YwUF2p2lN+Bci1Cyw9yBgypxF5WqH+36QJyaE5PfdPL/mPCbUZ3
	xTgxyKK60Fp9nADDm3F0A0l+ZKb2zgxIdddUdWj5iyjsGKzXGYH2CObCzgAc9Cg3Nzp5R0VnOQw
	9rty8CDRBUujucRQ2wwF3N3clQZdgrOtZ4pCtfZ8SNkkbcmG8cCrOBX2OmAfOZt42gicipgu177
	T+XA==
X-Gm-Gg: ASbGncv6dUgtfER+f6PajeohyyP4kGXdjPn30yRrESSoMbfKnSokn/8+zFPBI5HKx8L
	7eSQ8T2i/SRgDzhih/+8GEA1KPZwPUZLLxp9cJOtDPSXFIsmpJ9b6LOMCrrOz1+qW4Yxe7cN3V+
	pgSEmMMFqnd/HUZGSxsHk3HY0NkOJG5EC+pg9gJryno78Q5B7x6K7zr2OzoRjmnri+KhZcAdMGc
	H3i60Tx1glMtikbWNU/monCDv/bnRnpV+kPHq31GPrDvKvynWYnCT2MmbW9jsvBFSW7WbjweDcy
	fS9zOdOpkRaB0ncoYkvf8uYKLbweXwM+4IxA/VIyTOi8hR3YzUPsPWvwCOHgI7OsU+U7WNYZHK7
	xKx5+AsdNYe9NrbSAu0G+L3J9qDs/LVz/LeJNUbs8kPj2UdOb9F0=
X-Received: by 2002:a05:6a21:e082:b0:263:57a:bb46 with SMTP id adf61e73a8af0-348bac647c7mr776417637.13.1761843572606;
        Thu, 30 Oct 2025 09:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExxueTBs52z1H94z4qxfGgGfpkQLd9sFoz3+QBkDeOOi1CzX8t/saF2wSQsaEfqoUTLon0Rw==
X-Received: by 2002:a05:6a21:e082:b0:263:57a:bb46 with SMTP id adf61e73a8af0-348bac647c7mr776388637.13.1761843572110;
        Thu, 30 Oct 2025 09:59:32 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.207.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087587sm19170760b3a.58.2025.10.30.09.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:59:31 -0700 (PDT)
Message-ID: <fb6265b9-a858-a266-6565-59712fd79306@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 22:29:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next] wifi: ath12k: fix error handling in creating
 hardware group
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        a-development <a-development@posteo.de>
References: <20251030-fix-hw-group-create-err-handling-v1-1-0659e4d15fb9@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251030-fix-hw-group-create-err-handling-v1-1-0659e4d15fb9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0MCBTYWx0ZWRfX5YDYlIdneCx5
 9w7olb7JldDKorORmMtq3LssNdHNWqepcr6iK83YadoCSHkC9BnSuMkQnh/n1G3N7JkYy/NLlnQ
 +5jKicuOh73C6PPI78SDStaojW/lMs+Oc+tFUQsgPGWItEbKbEpTElT0RoBH+6c3zy0gZbPpxms
 NO2fEzi6raQLG1z2C/4+sEnt773nznjIO6d/raRn1z6tPVMx2Jie5dAkJR2NPcz1UrU9PLlJS7v
 dXiI6nt0Lb+RxOXNn2EtIF7ClUWNgF6wQCCvuTJIrvbp/oRB3Ur2VJJkXHKGQVSlLhsFzjeWB0c
 R9cYlOaPiOHolpj4fOttttfRy9s6PWULBwr4uh/JBPi5fr7qys1hzEgMcl38z5xQ66QFg1Hn8ZA
 wuvVOWfuygV9pachKC0eYTtKo1kVeQ==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=69039975 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=CMr6UP9dfYAYc02HN5pMZg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=uChsZFC9AAAA:8 a=EUspDBNiAAAA:8
 a=a-WxQxKLB2PsUy-Z31IA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=ULtXvzFHYWHLyBAuiDia:22
X-Proofpoint-ORIG-GUID: wlbnr70V4SqTbik_hxatnRU3mO70GEPo
X-Proofpoint-GUID: wlbnr70V4SqTbik_hxatnRU3mO70GEPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300140



On 10/30/2025 7:38 AM, Baochen Qiang wrote:
> In ath12k_core_init() when ath12k_core_hw_group_create() fails,
> ath12k_core_hw_group_destroy() is called where for each device below
> path would get executed
> 
> 	ath12k_core_soc_destroy()
> 		ath12k_qmi_deinit_service()
> 			qmi_handle_release()
> 
> This results in kernel crash in case one of the device fails at
> qmi_handle_init() when creating hardware group:
> 
> ath12k_pci 0000:10:00.0: failed to initialize qmi handle
> ath12k_pci 0000:10:00.0: failed to initialize qmi :-517
> ath12k_pci 0000:10:00.0: failed to create soc core: -517
> ath12k_pci 0000:10:00.0: unable to create hw group
> BUG: unable to handle page fault for address: ffffffffffffffb7
> RIP: 0010:qmi_handle_release
> Call Trace:
>   <TASK>
>   ath12k_qmi_deinit_service
>   ath12k_core_hw_group_destroy
>   ath12k_core_init
>   ath12k_pci_probe
> 
> The detailed reason is, when qmi_handle_init() fails for a device
> ab->qmi.handle is not correctly initialized. Then
> ath12k_core_hw_group_create() returns failure, since error handing
> is done for all device, eventually qmi_handle_release() is called for the
> issue device and finally kernel crashes due to the uninitialized
> ab->qmi.handle.
> 
> Fix this by moving error handling to ath12k_core_hw_group_create(), this
> way the issue device can be skipped.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
> Link: https://lore.kernel.org/ath12k/fabc97122016d1a66a53ddedd965d134@posteo.net
> Reported-by: a-development <a-development@posteo.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220518
> Tested-by: a-development <a-development@posteo.de>
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

