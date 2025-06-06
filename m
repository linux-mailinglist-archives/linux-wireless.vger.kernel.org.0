Return-Path: <linux-wireless+bounces-23814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F87AD0A03
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 00:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6DA7AAA6D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 22:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180DB233156;
	Fri,  6 Jun 2025 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GqhPWdbz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3DA1EF09D
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749249685; cv=none; b=mv49X3XeNDv3heXwh4VFHowLiGpyqjIhz0qombV5EJIOvbhPpQdajMOP4/4zBkcJUaRclw8pOToaH/qKKND86IwWH+i+HKxXr2DtYWyzdJoCpnUcd8EP3e9WTmK6lUHfZC317bQLnNL0LUCngk/dDBhWtJ3lsz5DSpb5SLoDwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749249685; c=relaxed/simple;
	bh=xQ+7JEe1/4ge7bB213WEMSNhJdfXrl7HFgHWjm6cWwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4EIuY5GAo4vQ5yP9TtlA7vCXbzgYHV/wdjMnUDtIMH92L0vSWsxnFTytYqsZ+fiKwT1HXQICuhOMeuqMkJ0RSwzWW8mXRryxdaKJXwX0EbLlp/7cH43XgX2t/z/SWKnptJadii9c+brb5GUusHWlS4oAv5yxdwCfs9rRIifBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GqhPWdbz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556F9DJg026173
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 22:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zAAJcQGkPl8K//dCoxaXa4s8/m31C5tv3RoukdeV8GE=; b=GqhPWdbzyExwmmTN
	PEMUqlItgydG8g8uEP2T2nQlGcCLSPzG9qVyzbJ5POwkK1eti7ADvK87JLwxtTww
	6RSvnC3ms8biZ7PEvsdQcP8ibnad1ze1ZaYANwpEH4P87TPSkmhHTnmkdjFjtadZ
	QnfLJlvavjrcJNXtcRZnBUW2bzxrjUmCefFVbnHjWtEoXkC+kBcKn9ITXx5krE+n
	Gl4ngxzSdiNAceM8rv4GOwtBjc1Wy37rjbaw7Hg04fnuhUXnrXHy80GYNuPPiYU1
	a80sszwJOla+RR3Rbk6HLl6oisC4NxUxC53vd7F6Eo8ooY28lKHc6NN/gAXI9fO1
	JU1Auw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 472mn084mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 22:41:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-747ddba7c90so2066868b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 15:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749249680; x=1749854480;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAAJcQGkPl8K//dCoxaXa4s8/m31C5tv3RoukdeV8GE=;
        b=L+9hxH5XcSTissD2oKLB9WHen1cnVUw7BmsL5C3mnjfysws4OY8J+95pBWriR1vHZJ
         cUMACplx+XDXU56oMgm+3sBQUFM3UJgyJgQ/qv3R/2HNd2eB8lY1Q0eJt1FbuMbNpQuJ
         iDMcwaG1gkHbsIT4kk6vgSq9u+cM+j9MWv1JDDesvO98J2XuijGo2lj4ZhF1ejcLVbE/
         wO6r9yhNS0Mv/1cBDNVCNulFT/I4hwdcRU/iT+PgcE2w0btRSGI0dSxUMtJTuxeCC+UN
         /hSsZQUawvJN7GDihe2/S5EoB41Z4SXMwRWI/D9jURfLFJQWFgqog//2dmnqUcz/HYjH
         y9kg==
X-Gm-Message-State: AOJu0YzyXofyI19geulc6IUmfYin5A4kuNV36+gEE8AprFtfUJDqAFjk
	Hotl5UEPkjWXAz4RO+wu8nGVLbtFkoo5L0yghfu9cDW3pG6nRRLiVeXrUs5Zb9s0uLbYq9T/vQm
	ciAR5oFWRv6tKY3bNNOVWxY9OPLu6fGNKpLNoV4Fm3xxM+pJ5svwtGtpACf5FXkZUJWvCx/SzgR
	oJEg==
X-Gm-Gg: ASbGnctDZ7Tov1ySMswjGnwuisp+U8f4Zx9Zm8DhyLgikc+viV5KR15v9noKM0tAoOV
	z+poibFw46kiLPkw7S7OpCIqdE/EEiLTC6YjIGCXqNRBXg4Q1Iy3EgHFPSK5SMQyEvRKXEGnd4K
	mDCuzLeOXR/KxJSav/zmiQAE0HaWA1bS5swVjprak5zN1anM4zxkhe2DRzRLFXMfrhOsZiaCf6B
	PoTJftlxTm+cHN4KAf4UbHurGCvT0DyigkWa4kEYrZLCxUU7adbzZCloNpLfA6FC7aFT3Po22MK
	7OStl9yt20luJNQPcnr+dVXwEbtIeol2rqmTn4wgJEpke+/Jq8wyWMJEqVGtKlhgjaM9yZgQW/n
	tI/6I
X-Received: by 2002:a05:6a00:21d6:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-74827fd6127mr6917828b3a.4.1749249680338;
        Fri, 06 Jun 2025 15:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEd91O9hxK4Rf2haaI+9r4R5fMx/23QcCPyfvYCRIOwxVKijRGSggnmb5aRmp+H97ufV9MuA==
X-Received: by 2002:a05:6a00:21d6:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-74827fd6127mr6917812b3a.4.1749249679982;
        Fri, 06 Jun 2025 15:41:19 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af3823esm1851236b3a.17.2025.06.06.15.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 15:41:19 -0700 (PDT)
Message-ID: <8b84055e-aa75-4660-a7fd-c10b721b47e1@oss.qualcomm.com>
Date: Fri, 6 Jun 2025 15:41:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: report station mode per-chain signal
 strength
To: Lingbo Kong <quic_lingbok@quicinc.com>, ath12k@lists.infradead.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250210054050.656075-1-quic_lingbok@quicinc.com>
 <4c1681f7-c4fe-4101-8023-a50b4b59a17d@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4c1681f7-c4fe-4101-8023-a50b4b59a17d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1ZsUZlFA0WYGQ9XGON4DKDdDoYUwD4Nu
X-Proofpoint-GUID: 1ZsUZlFA0WYGQ9XGON4DKDdDoYUwD4Nu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5MCBTYWx0ZWRfX5usuKN6ncWbW
 aPqkl6eO1fOCarzaMpQDnnz0LVzXIZHu/QHIIGG/xYWroTsvY88XlQa7aHbg9t6aSzTECDV/Xgy
 os0uqHrKnpW8yRt/0qufpTdaKOUAFf8/qw3hJmTLs5tZSgdCZ2ptSHw25lbjBlwhMsknPXwnalm
 sqzVyz86nEu3qFxNTnp3mZmWRZkSrY8yeKjI/qHBjOnFBuSMR/Fnq2jDao6e6D6isu4iDeLZvUd
 DmjwiqnRC63T4Om9LHtEY5Z54oFZirQ47QmA7/PI3czBMiOjEbJ86P4JHeHJ6ZAynJfzsiXXNe8
 57lm1gfqM5wOBjArj15hRs0k/1xD1JaTzmkXa8g2h2dro0b2PyLydUqzZLpwjnCxJ82xxcR8MyQ
 90OY+vd/v5zO4TJSSoU+Reynph+OptitkI3DnV2BnbybfkqzZfPjOEoCT447gtzSlHK1M05B
X-Authority-Analysis: v=2.4 cv=Y8/4sgeN c=1 sm=1 tr=0 ts=68436e91 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0-2u5t-MAw8Ac9FEvgEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060190

On 2/26/2025 3:34 AM, Lingbo Kong wrote:
> On 2025/2/10 13:40, Lingbo Kong wrote:
>> Currently, command “iw wlan0 station dump” does not show per-chain signal
>> strength.
>>
>> This is because ath12k does not handle the num_per_chain_rssi and
>> rssi_avg_beacon reported by firmware to ath12k.
>>
>> To address this, update ath12k to send WMI_REQUEST_STATS_CMDID with the
>> flag WMI_REQUEST_RSSI_PER_CHAIN_STAT to the firmware. Then, add logic to
>> handle num_per_chain_rssi and rssi_avg_beacon in the
>> ath12k_wmi_tlv_fw_stats_parse(), and assign the resulting per-chain signal
>> strength to the chain_signal of struct station_info.
...
> 
> hi jeff,
> do you have any updates on this patch?🙂

This fell off my radar. Can you rebase since it no longer applies?



