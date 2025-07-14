Return-Path: <linux-wireless+bounces-25396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC2B04549
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A431889278
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F02D25E816;
	Mon, 14 Jul 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vz598LLg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3E256C9C
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509562; cv=none; b=AuL7yekryTwWNxeHwNyD2LfBYJs0HjPU3I5Yh9QjJpcuIfYsl6Q1DirJxqTPBkQv25DBKY0voxStTVVX7DxE8Kln1W+VSd2uJhfR7lXpxe0GDs45blviydD+u+RCL1c3H6P9TNoj+Z5t4HFJOYuiGVXnqkoH6GZ5D2M+uXrn47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509562; c=relaxed/simple;
	bh=m2RN1PbmM2qJn2u2RVn3EdYDYkhISSePktCsQio9N+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpbbDUYNJZvHzSmJF3MAwC6bRgLSV0B/50htYBOeHggjWn3fc6p6VmEkHj3KEn2WMuYq9OzhKqKW2W8VyCyb8Gx7DdgE8CTvMKFstKMiFuPWtaQGqEkIXFZiInp8wYiHyqEoepM+Bbd6VE5MoiRFHKE4k9iW1bwS/xh3L49CqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vz598LLg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9MbQC013581
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 16:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rw40OLZb8DmaHdUuMAQhKLnxkhsuaJHUAZeS8EQfAkk=; b=Vz598LLg5T4K89dh
	en+r6xuPOq8LGBQ657HaIjEUigyePNIRFbrskpaxj+LbLlTwC3WeRsIoA9SatYZE
	FPGEWAgR57mTCABQJBK2uNZo2TVxr1rmy+m04o+XkDx6jwxk2X8AvxA2OD0UmHzH
	TKtV/K+lfLIVH2hmZg31cp9miR/1gvJR1i5MoCjj4A2pwujDKIGzXFw3AXXty5El
	uxtzoyZXOiaMdZe27W0mcHanPb73bhdefxKlLQJlWmA6slKy7uPIzu/nqj3aZ9JW
	D+SUVYsW4vJG6Nyi/N8Qfb/3W0QURisiRP6tRoRVEFJyu+cVtE8ta4X4VSVhraaw
	OWrxxw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmw9gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 16:12:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-236725af87fso74438455ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 09:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509508; x=1753114308;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw40OLZb8DmaHdUuMAQhKLnxkhsuaJHUAZeS8EQfAkk=;
        b=b9u4MiMc9mVaeL9R1KlJzDyN7JZ3W4s8ZXsHId56TXW1tKCa0rYcR8Tg329jjvuVdT
         qh3CgbYPPXUlOdaiHTu55V9Li9nEUzf02VogMWwPPvw6TJvr4HJcnjtO0PbXpbROEXfn
         4iSZDQBwDs04risCIygBvpgBT/9HfIxdQVhIFkPxc8bbAACp0aGtuD+ebSUPkg1Sb6C3
         bORbZ+oyIpKe8ZYjnfXr9Fe4e7z9pdX/nYKFk3jRIpGNNVQKmjdSzGQS8Nm00EFmsv2p
         F43yRCQHNqfrhYS1t2sFJupAPWONRWBZeaYyslMjLQOr/Y2SY5djFn8V88rnyjLXls6/
         R6UQ==
X-Gm-Message-State: AOJu0YzDYnQO810Mu4VYPxMm3xS90dAyXErHziCkt9pHTmfbd1kDmLzz
	fTVywi6IclP0HuqR8mqxfi1ICOxC4CCbSA1xU09TjkjtnguLUTUvqfpiM6cYsuegLlcuxU35lty
	TEMCM+WCGeuzMbNHnFvxkadEP6hVzn73CBSLsbdfwECjs9B+COFRYmVq4V+x/R1SnGRIMYw==
X-Gm-Gg: ASbGnctb1YDkwRP1pSxuZ6nHPbgbieL2REf9X979VFE/sg3jN8yJoBATKfSYYUVhM+i
	c9PudlCW52Hl/L4lyA4btgNTHjRlTsatVxfzXmoy+72+qpEmhJVVk8HaTSA5fsNweSVNxiW8dl9
	MWMPi/QbXSWYRIukdTrC72YYyetKNPDJDeeJdit+96VcuQqNlCocJxJtphzos3OkeqwTXoKJk14
	QBJSLPbJBpF10DGOtMLpaVfoZZ/ix7++gFaklnt3eSGb7vnyel6eBmmYseK/52ma4UDy4hIXjbA
	VQMYRg1AP/2UIiFH/O6eUGjjAZRnOjyg8+PpapZTiq4cAalZkog16ETN01fg+gvWafADcKpS/7k
	2gam/hEb0fCYF2k4kZMo=
X-Received: by 2002:a17:902:8b8b:b0:238:f2a:8893 with SMTP id d9443c01a7336-23dede984b9mr126994485ad.42.1752509508221;
        Mon, 14 Jul 2025 09:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhQER9vRAE25eTuAqmHDTfAWwBwxOI0u3/MNS+rhHXQILJw2sqscUlvRSowDfnOj2v7faYeQ==
X-Received: by 2002:a17:902:8b8b:b0:238:f2a:8893 with SMTP id d9443c01a7336-23dede984b9mr126994205ad.42.1752509507750;
        Mon, 14 Jul 2025 09:11:47 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43227b7sm93757965ad.106.2025.07.14.09.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:11:47 -0700 (PDT)
Message-ID: <c2870627-536d-4680-9fbd-1c4f5fea6d2c@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 09:11:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Use HTT_TCL_METADATA_VER_V1 in FTM
 mode
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250711035420.1509029-1-aaradhana.sahu@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250711035420.1509029-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4ltypqHNDZNUvqew8WE-jQSJBDrzHPeP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5OCBTYWx0ZWRfX3CZ4w/9FL+2P
 PmvKOeJUaCdx68iJvesxjU/CYB1roHRucOzcPT2GQXi1mfKzY7OgiSlebijRIUn5z8oulvukiQt
 xOIA2UZ/ZtoyTFdhH+7IeDu2H8X1H1d4XddVoYgUas4LppqYgjapVS4mWbrbBiieWWEdVF7aEVR
 pFtd3AxSD/QixaTZ7NYGnPElWePGHc4um6Fhka6otW96r8kh+CF8/2A+R7NTuQPcUp6Yle9IpKm
 ENwXSN7GUgcTwWh9OVSzM41aKViJYVyKbw7SIfVXz4P9CxyyF08oGUVlhNNeObIZ/y1+5UY+2ay
 dGUdXgRlDIOEFNs+1Nc/5boxTJynsWp8o+r1vDTPQI5eXzFbrEZ7Z8Mkk5GMKg=
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=68752c60 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=D0RHpJgxHeOTfRx_DPgA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 4ltypqHNDZNUvqew8WE-jQSJBDrzHPeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=894 classifier=spam
 authscore=0 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140098

On 7/10/2025 8:54 PM, Aaradhana Sahu wrote:
>  };
>  
>  #define HTT_VER_REQ_INFO_MSG_ID		GENMASK(7, 0)
> +#define HTT_OPTION_TCL_METADATA_VER_V1 1

use tab for value alignment to match other macros

i'll fix this in the 'pending' branch

>  #define HTT_OPTION_TCL_METADATA_VER_V2	2
>  #define HTT_OPTION_TAG			GENMASK(7, 0)
>  #define HTT_OPTION_LEN			GENMASK(15, 8)

