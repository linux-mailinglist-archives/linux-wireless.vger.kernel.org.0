Return-Path: <linux-wireless+bounces-27889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A8BC5FF2
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF33407B55
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A929E0FD;
	Wed,  8 Oct 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JAM/mBDV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95402BD02A
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939797; cv=none; b=mMrXuus4BKGu272YaIPU0SybFaTmE0b89yqt5srd4KrBttV/FyEewJYe+QAtobPeZugMx5LsyImMhuA+pUaHS3sjEVYh0U4DHkFS8xzYEeLPMg/eH6mV8DA/xjhjNMb5RAJ2RcdHmz+y0yD9DJ2nrPqu/ZFOX3LccCPVmrze+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939797; c=relaxed/simple;
	bh=etUBXioaGzMn6nF3pI9LljSlKYcmqQdp1FNwNA3XrH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iz8OCIcXhTW4VFTuGmXwgkkyfvKEZ91sB4v3/IRBhyI6O6fSTlfIA4HldOzAdwH4UxmeA4VShtAPUuiPp2dVhwx4AbPg9vhUFVOLNnOzOJKoEUXMVfpSUN3I9CCKUUQ9XMQp7bRwZl6MMI2nNuccLohLIovdWmyb/6lH1gUy7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JAM/mBDV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Xns002171
	for <linux-wireless@vger.kernel.org>; Wed, 8 Oct 2025 16:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ss99cPPCtTuFplUwVBzHekqSJ/wYgBUqZ5l02AsSTxw=; b=JAM/mBDVdhdnW2Kc
	9W3IOKxKUm35UunJ2xlJgAWAHrTGlnF3wq8ioHiqAZOHre4GoCVUNPRdfNpEUh4Z
	ttZrUrWPABSS9oLbpGOyN8afBvm9u5d53Hj+h2v6vV3AQwZidS298Q8z7CxYSQ80
	yAaBZZDfXbQ0IcoPlxCwrJiRFSF4ZMIGfVeiSGvufZ+hAYCLlicwJHBAkWGYEGbO
	rSBQ4+xtdM9MH9O1KJCLr8fMIT181Pq1qZw5Y++ACnfgxbTcA26Z9u3S9/7nOtCA
	qpdOS9ZJB09O2bWRpx+B/irGFFiO1dzoM05NfseqZmbs6Ic1I3htOtsbCzrldqLk
	e3406Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy735yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 16:09:54 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810289cd5eso12795708b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 09:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759939793; x=1760544593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss99cPPCtTuFplUwVBzHekqSJ/wYgBUqZ5l02AsSTxw=;
        b=E5nm1SLSdZrXozmeNI/RDj5Fk6i8R9B5gL8aY/KXVvYTU78IStT+8TCCYhMlphLoeZ
         8qLIrSrDXoMg8Hgu6pZfD8+v+/T5WeFNIDo7+G8Zlb4epv1eGs4ruGq9DKOGPpdP9YTq
         3hpBcgFYheK++BXmp/daP/nlY4yxyvtQy8KAN4x73Hi0LqMheio65mgqJx7iQ7iQgyQr
         5SdkTEbLG90a0ER2OJESIYra8rUwBfnmpWgtENIcRcCUo/u9HENI9cRyxxtLTENlAB9i
         JvJMDeoLjhJAYYCGN1XGIqwBsqZmy0hc9EbiA5D7DK0O1D1D1RYl+KWtYCP/YJgy47RW
         ommA==
X-Gm-Message-State: AOJu0Yy1+mH+AOzV2TvFp34ohG+7EfZoAefHGuyhCoRjRdk/cXjnvA3z
	kNPjcLoLawQoVRG2edWZvk8wG3kiBkYiNk/4EwKzB2Jj2lJPjzqZ7s4UqB6X208QagN3Hj4K1ud
	KugVEYD31Gyi1HY/ayJeSnQ/wQ2jeKF8Jkc/nVBhyeNT9BYaQL/1LQNmQrPSdHFtNXp7gqw==
X-Gm-Gg: ASbGnct3a136Cdt0shviPNyFvnU8isHtKlkaPfYePxIT4AEbIUopzpWSqlXD/zjNPCu
	JKk2OWlorz00PfReGAqoo1ewMI+yc++PT81QJrmDz3188PHt5ukBLxLtfbKYqVj6LgIjSY7xwSk
	zAq7gmVfmSkOlHL/cHjzD3mLY9SSjPLQx3BoLUtfEYY8/oc9rFM7PwZecPAsXYdy8kVbXbSRKJx
	fTDmxsL0DRsIyJbRWE1m6eGbgsTNTJ1e5X0hsJB9ThyKYGRClUu2d8toyqNLkSAqCcuRFgKS8wu
	ZSEGqsDUXLnMsTpSveasIgUcC4jFZ/ugzmwhyAP/AL8Wvf1LK2nrj+PRAuk7o2mdg7CU5u1Apbg
	cT5Sr/4txi4ypUVQeAIR8hg==
X-Received: by 2002:a05:6a00:2407:b0:782:9b8d:24ac with SMTP id d2e1a72fcca58-7938743b234mr5062530b3a.28.1759939792862;
        Wed, 08 Oct 2025 09:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnZGiEiiUpL481qbqo4lG2Vfx4+WXoKcGF/ltJ7NCEBikGMrwZZ9xIlIltKP70C9AAwzEdqQ==
X-Received: by 2002:a05:6a00:2407:b0:782:9b8d:24ac with SMTP id d2e1a72fcca58-7938743b234mr5062479b3a.28.1759939792314;
        Wed, 08 Oct 2025 09:09:52 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.106.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e34e52bbsm120329b3a.81.2025.10.08.09.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:09:51 -0700 (PDT)
Message-ID: <40787b6a-f410-e780-05d2-058181d2e060@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 21:39:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next V16 0/2] wifi: ath12k: fix TX and RX MCS
 configurations in VHT and HE modes
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Baochen Qiang <quic_bqiang@quicinc.com>
References: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e68cd2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=z6xreaRxtU16OQ9bEhv1vw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=yaquvNMiY_n8JpVZVNkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: o6LfDLVdjzKGtukpLkqnOVn7r_RLG54D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX7uXul8+TfhV+
 vVmHo62aVCZCz9vcL1UOX5CpPgu3H0inae21rgg3UkwW31af+4o6nKEnQMHjHRNN5cbCmORim2f
 m5OTaNl5/32ODVziaEaxk2n4CfaF2b4YkJeQcVvoMYiTlfx4dsYZ5k+88fXbu6WIzycJnhADA/a
 NphLCYPlbF0BemlE3C98lTBjd+wsOgomOFO5HHz4VvZGUV60CFrx0ML3lSbuZL9msd6Aa292xI1
 o2EsUm41XmSVNWbpamVtLJjUhMtjpnue1PnWA66EBj4wE2D5iqJmQFvGqZz7PO0OXXo6N4oCk/p
 6E95eY9pA6Xr4TViO6hgY85aZAD/WMvhGcKLkoadxMpSstTX1TYTMFNQHBfeDMTNT+8XUY88c89
 9RTcPA5lOztycGQpfoVtcsX5MibJ+A==
X-Proofpoint-ORIG-GUID: o6LfDLVdjzKGtukpLkqnOVn7r_RLG54D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029



On 10/2/2025 5:37 AM, Pradeep Kumar Chitrapu wrote:
> This is revision version for patch:
> https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
> 
> changes in v16:
>   - remove patches in series which hare accepted already
>     https://patchwork.kernel.org/project/linux-wireless/list/?series=977538&state=*
>   - Fix review comment on last revision https://patchwork.kernel.org/project/linux-wireless/patch/20250701010408.1257201-6-quic_pradeepc@quicinc.com/
>   - Add similar VHT related changes into separate patch.
> 
> Baochen Qiang (1):
>    wifi: ath12k: fix VHT MCS assignment
> 
> Pradeep Kumar Chitrapu (1):
>    wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
> 
>   drivers/net/wireless/ath/ath12k/mac.c | 12 +++++-------
>   drivers/net/wireless/ath/ath12k/wmi.c | 11 +++++++----
>   drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
>   3 files changed, 14 insertions(+), 11 deletions(-)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

