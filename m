Return-Path: <linux-wireless+bounces-17843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92679A199A2
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 21:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32EB67A05A4
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37894214239;
	Wed, 22 Jan 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nx1VMuRt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D91BE238
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577199; cv=none; b=D/fleHowInyAXvAZ7U+xVVadi/b6MDH+AsZ+HqVk3Jlm4MswLwZuU/TSmsUwK3ETPmfgCpZ9L7ns4Ms4rPYzuFTJZSZZ1ehBldPKkFKiBpmE4X9XtFXgVGtV1CrbIpR4jprHxeR/aPXwT6foSWunJ/amdgejAAR1iLR8RmPsN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577199; c=relaxed/simple;
	bh=qOqpEGxgJOzluK1mQNmwbp12T2CHdd1A4X2evIAZHNI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TSVGQDd7V6Dgvd0lCSe7uPAC2d1BctawDS9PQ2WnN2btkaShF/2v8YCvHvVHSQEF1FqA0oLCqOEfpjG9mew53/fKGfyZ7dPEcQyC7NQgPzgFgP4kZQZQzc5A04/zUHNRU1ugJuaEv9P4o2/R+VUxS1YtYX7nYpISqs6IQjIdWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nx1VMuRt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MGpa6d004030
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 20:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JHHjSQd18Y1cYuysXzTsGuH3C1uMTh/IaU+/fk0uTyY=; b=Nx1VMuRteHY+2gcd
	VWcxWVHGD8NNWxNR99Vza1HKEHbwTEXjB2+15v1W891q7WrOCwjoIBXVZoQc2BOj
	NacxXoW43aMp60h4yA6GnnE7Y0CZSGgQ7q9E5uI6vUxSmr6g5eiLPhzYqdcnJRyH
	NDGGIpcbUCdtAK6uuUa9nXZhgguu5UDRFVRqeUEWKMM5fO0ZrphvQqS7+j5pvZtd
	jLhzVlY2nHc/KCxVgGpYujLBhctfLHEyr7py7ezWsPdPs8XScbR1gObfuUWZ4KIp
	TMdq2HpiDNbauxi+EvKeJhnYZhLW+2OyY9kzNCw1+9JdYRrydBj2NueDSBijQCkL
	wE7mFg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44b4jm0ff9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 20:19:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so656463a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 12:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737577194; x=1738181994;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHHjSQd18Y1cYuysXzTsGuH3C1uMTh/IaU+/fk0uTyY=;
        b=q2U10CYPaArvUlm1Cq+xuPxC5ssBYxefJLnuOfdZCHcrn8Lwel3YAcZj9OJt0cBPAe
         hmOMIucZvyDRyEwmaoNGDkkPtE2ng2C/SJ0NCXzFZOaPEmsIerRx9zmqS0S/GZESgZSS
         daWxLfkvkq3SgekWLIWvzOQr38f/ozmV6A2QZQPObUtxkVf4E42Tt5pW2e/d2H+xsXRq
         kj99O2wHwPpLHKi/CjspjBrxDSzpVk6paJNOJY31NJERYrkoe+rVfrKgKBREGMflO5Pa
         HpUQAMtSYP+xAt49cPrT5VmThiNY3ZsYbJtDR2A4KUMjV6Mjp0G8uKUQR981Xa+oAMDk
         qSHQ==
X-Gm-Message-State: AOJu0YwYvaZKmKLxJxWFcYh1XbfkRYKIGw/d5JZphohSUTsogVAdHmOX
	DB9TSJrW6CIsrsl8pjlkQtjXpASXei5QkLHhQ1HI1J4ED2RCkkBlYYCxHKWOO8iu3GCCHbI92Rk
	dhNkQd+98dXhs4WfG6Fo13lRfNlXcnQidsXtWdg1/ktQVpU5/vDrIy2v9VUVXtjA6Xw==
X-Gm-Gg: ASbGncuzRnPoIm9cLVd9xT9hmdk95e0tN509J6IpoW7nFLmwkWyesUYsWEmzZyMBPil
	wZPCd09qsAoJf6zVQz56Zaym8eEn6YJsmSpV95U//p3sUrgAi337t5VVqCQcobQESb8v5nGbBCx
	yAoZkDiFPtUkN391U8KSGmtCcbpbbBq0RcaI6Bc8jOifY3nlkQNcr+PqKoe2u4i4qmPd2Nu0R8/
	vrqfR5w4GcsjFLrvOn5aArwvJEuVie3lAPlN95C8csl0GCuRCyHG8NxZYTzlvXf99wlE+segJ/7
	RDZMw4BG04t0JdurBpYUmBGTb5DQ68prgr03wrWSanqiB4BKjV2heQj7dEhf404=
X-Received: by 2002:a17:90b:568b:b0:2ea:5054:6c49 with SMTP id 98e67ed59e1d1-2f782b11bd4mr41359113a91.0.1737577194627;
        Wed, 22 Jan 2025 12:19:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK4d4okbPhPVphCozEzK0xFCb2TLOlnYr87swXBLsfPtnwchfIvrGxX0cqhLZ5nt/XzXIvyQ==
X-Received: by 2002:a17:90b:568b:b0:2ea:5054:6c49 with SMTP id 98e67ed59e1d1-2f782b11bd4mr41359075a91.0.1737577194236;
        Wed, 22 Jan 2025 12:19:54 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a5e2b2sm2157813a91.3.2025.01.22.12.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 12:19:53 -0800 (PST)
Message-ID: <c6b65bee-3680-4e54-9d7a-2b582461cc73@oss.qualcomm.com>
Date: Wed, 22 Jan 2025 12:19:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx error
 path
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250122160112.3234558-1-nico.escande@gmail.com>
 <101c0824-1c0d-4e5f-bb4c-7d6ef65f1698@oss.qualcomm.com>
 <d0dfce80-3e57-4efe-8552-b18bae9e9437@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d0dfce80-3e57-4efe-8552-b18bae9e9437@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: W5cXUWEXU9NOm_k8B9weAN7hZe1x9SE_
X-Proofpoint-GUID: W5cXUWEXU9NOm_k8B9weAN7hZe1x9SE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_09,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxlogscore=945 priorityscore=1501 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501220146

On 1/22/2025 10:20 AM, Jeff Johnson wrote:
> On 1/22/2025 8:46 AM, Aditya Kumar Singh wrote:
>> On 1/22/25 21:31, Nicolas Escande wrote:
>>> When vlan support was added, we missed that when
>>> ath12k_dp_prepare_htt_metadata returns an error we also need to free the
>>
>> nit: Always refer function name with () for clarity.
>>
>>> skb holding the metadata before going on with the cleanup process.
>>> Compile tested only.
>>>
>>> Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
>>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>>> ---
>>
>> If there's going to be a new version please take care of above nit 
>> comment. Otherwise -
>>
>> Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
>>
>>
> 
> I'll fixup () in both subject and description

fixup in pending:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=29d6569f323a88ccb3239abea562f6e691cfd9e4

