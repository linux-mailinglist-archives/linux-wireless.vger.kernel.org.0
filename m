Return-Path: <linux-wireless+bounces-27417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C39B7CD24
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D8582D30
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 03:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D62D321A;
	Wed, 17 Sep 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQ5IYe8z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F9266B52
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081226; cv=none; b=EmAiE7mIbKo8nluEy4r1+FAiEAbeCl0xOJpOR1c8HkZgarlZmTP/t4XhEwQYKwOR2Dkt526pTvL9TRuAxGnypWhanFF43rvSO6ki3ISpfVF75X27/nSrRHnUEmq3PhTkejkdXgZcKg8pnm6yp66zKpntYUZFlQzzRAMiu4p+2g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081226; c=relaxed/simple;
	bh=KlTGsGVXqwBej59KeF874/Bo/ROethgpLYZEmN7KZsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXXNDxydr5JdLJO7/ayugnfe3PLCJMX3hyB12y4zOuO81JZw9Syhy0vNJ+uq5G4pmD2OPbQRwgAVzc0Bb9YDm58EfY9bBpKvOeeitkjcJ/9iI8Fo2MVsUdNcLmxTg/GbjM3YDPkVebat+8VtpJmTuJZhkPnwXouKG9xyM6g7zxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQ5IYe8z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLa27A019133
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 03:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cep67SnTfnADXcOmFM0wZ+47pVbXaqSC/dRePINIa3M=; b=DQ5IYe8zCWBQgkrP
	1OkP6M8IejcEYdrmuxaD90k7mzkhy2nbk7OW4h5jYcV35u8THXsUcrHMDNddolsl
	de8DbAQcEQX/q6SENMcb0zZuXxgV/4DOxNJxJbcC3DqD5+Qbyfk2Prw0RwVCv+K1
	kJ03hsNB3VKm20eR8LIRMTOUy4RYkslF8lUrZxdEiVypg3bCB2EreZFI+kaalfmw
	Fzkl5nZd8pVLPflxYWhgzySvVRuBK1Cpx1UnBwpWJ5eEUG1x30n/VCpHJrUCS+5N
	6dCYy1KYeI8UVXMpqCIc4WRuE88GxINAgRtoyS5g5Xc3iUD2AsoyRXrp5OrtnDKD
	gJDP6g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwgtse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 03:53:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so1531013a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 20:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758081221; x=1758686021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cep67SnTfnADXcOmFM0wZ+47pVbXaqSC/dRePINIa3M=;
        b=Z2EFc7SdUnnNdKo7McJ4/6TG0Afj9aPuFwCpmCxzQNkmlomXEoCTWSbJD3zUd+Ub2l
         oshZLEbG6TdyDdJC5karnFtJxHOCuiLkHolFKewRaulGphr6wJEAJJrTY797b4Ghx9Mi
         t3zMdO/C7dbshsQUenrgkLmdY/2NK0v5fvdw6kYvbHOqbsWZps3Y/eXHiXrse4KYKy0S
         pxyJ6SAVu2b53Om7Bk17WloBSnW4s4PZa1IuIwnCuRIgOe2t7O61n/iUxnQEVRj13w1t
         BDmZjqiY0HbpwnE6BtV1Uwx4rM3vGDbzPQoEDeo4dc5Wofhtef2gK5JkDCyG4smmrarb
         GA1Q==
X-Gm-Message-State: AOJu0Yw1bWJ4KsAwWaTKeZ/TvCP/fO9GhlMeVc0yH19VMfW/lyX5lKYF
	nXW5D9wyoNmwLUZIUR3RrTP0en4mKvhT1KeL2UP6kHRjOL8qz/b94+QBBuEnDDsPMg2b0FD0iL9
	vAubrtwIOtrV/jHKqFo1n2XMYOXZh72ePNVdWHh9ev2kpjH4n3+wN5eWKLsqiG0yH69q8fg==
X-Gm-Gg: ASbGncvjkC8iLD6nS/WF4CVKe0qiwoaFyPj6V1kIydFwVZQxvs+gL8wFJUvaItG9//f
	ESkKxn1CDlEj3xm8Yb6QYcQhVtnWaetVDIe1YNymrbXXex9IQc21Tz4o+Uv4vrYOrBVOWUAx/Bo
	bwHx3A4DnAIgGDc9KOWSyznfggD9wDgb257joCraKDbhx8LJjG/BflGs8IB9af9jkoyiRtCh4kp
	3KYLoJMPo7vw6Ic4ZYMpQ3wJMkxcLSkYe3zDCsDBMe1rG7ZmysI5tZuFNogwEBPFf5+/YVZTia5
	BSojnZiaP2XWUaMHHp6N+lMAwZQtdOK4XJCVTPFSppPQOrDDpLnrtsbmcZ2Idq1J1CEpvdMSA2t
	nh4gLoxaSBFM=
X-Received: by 2002:a17:90b:5348:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-32ee3eefe77mr975452a91.15.1758081221364;
        Tue, 16 Sep 2025 20:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhkw0YdOtL29ExmK2v3LOWKcGCk1jKtiEcNh06EUhootqyd/kiRmyV7nVn1zQ6nwDbzwHsFg==
X-Received: by 2002:a17:90b:5348:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-32ee3eefe77mr975422a91.15.1758081220864;
        Tue, 16 Sep 2025 20:53:40 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.98.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed27724c9sm985762a91.27.2025.09.16.20.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 20:53:40 -0700 (PDT)
Message-ID: <a5778370-d889-fb9d-0ce5-498342bbfb2d@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 09:23:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 0/3] wifi: ath: downgrade logging level for CE
 buffer enqueue failure
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org
References: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX21OFsivD5BPu
 z3Jak2ukvSJaqXFQ3JZCMf2NwxuoNYFeNhirSGAEB8vlF+3Omk06pgmrg99y85WSHytLMvXqEXZ
 vJ3jyHu52QOJzkP5F/DjvwYbdKMQ3KxH4fIiyeK71ZgPhOFcNXB9yVjLmI5i5ZZQgkYQ3FykmtT
 /YluLEKO5g3qYz77RrKZBjFDoKVW5Ab1ORmA4Q7vVbDoga51y/dcO1KKk+MeY0AsCVqfDaEisJJ
 G/F4eqZMAb9nfIydnh8VSZUsrW07Z9V5+Z9b3jOWztWWBUsxLYA9YQ36a6JcFY+ev2IZ5O4/rQ2
 dyNXEEw3g228dn89UCywgM+nSBA/rLIwCuX5AgWwYjWf3UXLyYjE50zgJeGByBeXvTjVqGKyB+X
 MLEFUwiy
X-Proofpoint-GUID: j4R8OUlZ6gnk1rAxaa6SWaQRNqAiGD1U
X-Authority-Analysis: v=2.4 cv=ROezH5i+ c=1 sm=1 tr=0 ts=68ca30c6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=r0KOKur2OvuaYElxfjaavw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TpeBPK0GJKfZ0rfD3RcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: j4R8OUlZ6gnk1rAxaa6SWaQRNqAiGD1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 8/15/2025 7:14 AM, Baochen Qiang wrote:
> The CE buffer enqueue failure won't cause any functional issue, downgrade
> logging level to avoid misleading.
> 
> Also fix an incorrect debug ID usage for CE.
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (3):
>        wifi: ath11k: downgrade log level for CE buffer enqueue failure
>        wifi: ath12k: fix wrong logging ID used for CE
>        wifi: ath12k: downgrade log level for CE buffer enqueue failure
> 
>   drivers/net/wireless/ath/ath11k/ce.c    | 3 ++-
>   drivers/net/wireless/ath/ath12k/ce.c    | 5 +++--
>   drivers/net/wireless/ath/ath12k/debug.h | 1 +
>   3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

