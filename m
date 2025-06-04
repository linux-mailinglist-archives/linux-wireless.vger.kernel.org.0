Return-Path: <linux-wireless+bounces-23719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAE1ACE225
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 18:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F07A4C16
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5A1DE4E3;
	Wed,  4 Jun 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJfXl3ER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87B150997
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054279; cv=none; b=r1kHqlUNTz/IWUR3Oo9IoHPsV+KPtyKVkYVjoYtUju5PgTJPG0O3crEWLDVIJ8F3bd/tQm/iKFC5euYmMYKD2/ZaiTjh0tdWzC1rEuyPbhYvOlp6wE5cXpWk1g5Ln87+OMZZglfB3VtpPJq2JdEKaMK1jW/BwxVeNODXFzpaEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054279; c=relaxed/simple;
	bh=PO3jUPStlFmT1m2wkC43j6GeI16ajnRuXqsKw7nCnHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2sY0rkpibUwa2vkoJKPyFngT1xDzejeViAS5rxcaJOWMkz1d3XTteUYfY3PcRqyRMRjVaMvB2bryPNbZTrYWereobAuUgKzNZ4dACCqL9LJHyCQSGuGM6lXTwjg/ShakOBsvVD9Xzyo1vKqDNh1iq+UMJaVgfCGkNR+YY1dUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJfXl3ER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548NuDr000741
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 16:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UmqjCOK/2PV+3jpeh7XZghC3MKfY9pGurM7qJBU/Zyc=; b=KJfXl3ERFqlZhjj3
	21STEtvBdDAbkpQsizC8Gvb74Fv8Nse5ic109dL5yKJ8iNC3iOoIFq+CP3iOrC1o
	wEQEq1qUJdXVV/jDWF3WlfpysKmCxf04km6UJRU6/RxRKsoj11Aigttyp7jwcR/R
	Cdbm6AnzT0EVPlC6uHfswTs2rAWCRks3cxKpmFy7AWedXgbHqLU+6lABjF7lp1Xj
	pxmDEG8Nq/Ze0tSnAeWoggdg2D+0v9BR5A4iowj6cRLjsMLCkaQuXRb+BPn6Xg3a
	1orNNQx+eRrZ7iREFvp/41TkodY9XfWP+IJkSGDYjWAUyRudElRWQ/FBEDVWGvms
	GKO+Kg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8q6qqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 16:24:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30ea0e890ccso15124a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 09:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749054275; x=1749659075;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmqjCOK/2PV+3jpeh7XZghC3MKfY9pGurM7qJBU/Zyc=;
        b=tY6ralrlf0YxbP3hlQD7WsmLlOjlCZu3na47jY1m8K2g4o3UfMMMJYzL9fb1t6Lh7F
         zQGC12MWMiuHDLJt1GJogMuHeIWyPXRwoTYJk5NWlV3kfig3HLemXekDTOL1nXeYzDqj
         rR0WRGr0EvvqZ8BwjafZd+eSF3G3/XOsY4c/gscLp9KBX00WNse6PEh3+ZYE5odn19Em
         KJcMLSbfrl8JFd2NfNaRWrqxl8ksd0Mp7WIH1+RPv6FjDbWUax48rqY5YfNxvDWYy9md
         tz8qh8ucgit6ck4C/8qhdfZeCppE1GwOIZV0QE9R4kQhlFgIEdU6lxc4jfWjEdg+CDlo
         jM9A==
X-Forwarded-Encrypted: i=1; AJvYcCWSQyedxEMgKZylUkRtm6OVKzDojADTDi8z0A8ELPp7I3pU8898sZiT5GwvogWo2JnAH8MZZtRb4n0Wzyq/uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0tcQiwn6fg936m/nDC5FqDjJE47xGwTwMSk1Cso3R12CxvzJ
	OvZopXX1hh7eh8N2ra9qPnYF0xFqsQC7X9sd8Hig4Xfz9RLCIADLsIJtslhfzu76DzdVEzkIAqi
	rqXURHG5DuVp4fJBGiRz1Lw9JMRDPIsWZKgAcpHec9IDmjq8hvHYbGX8SCFQgEXrfzP3AVw==
X-Gm-Gg: ASbGnculNPt1x3AACLhwN35q/Gm+78YvHkogBYhliArp7oObTdMvvy5TkBfrlxn5K9d
	9qy1KshoZ2CKSnKzuI8A/cdxfNEiqP1qOpjrWtRo1jN5HCEHsr1w01XscT9UvpafxRsVAIylxeC
	fbEcKGRIaLjKOe/G1auCfW6dRBmtHk4u8W5RHD815AvVs9yaZaXn3MC0z+tLi95KizuPX93qlYD
	rvOnZDQCLCCwTIcISKMMzHAw9FjMde4776zikK44g0THjw9xuQh8P1FDOrUHP6KjbDImJyPXIit
	Y+ds7sv8a5W6yNaGvmlNaEanidQzAgpUm6DUJ+A91U7vGI7o9yYiOjDZxjhfEfXw9vw=
X-Received: by 2002:a17:90b:48cc:b0:311:2f5:6b1 with SMTP id 98e67ed59e1d1-3130cd3c193mr4541061a91.22.1749054275285;
        Wed, 04 Jun 2025 09:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyeX7AH3Z2qmV4RyPhkzwExHjRAMbx65+A1uhcePobw4T+CSD/5pREJy2bkxvhQy4rzQER5Q==
X-Received: by 2002:a17:90b:48cc:b0:311:2f5:6b1 with SMTP id 98e67ed59e1d1-3130cd3c193mr4541044a91.22.1749054274900;
        Wed, 04 Jun 2025 09:24:34 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2d1689sm9089572a91.12.2025.06.04.09.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 09:24:34 -0700 (PDT)
Message-ID: <50555c1a-c200-4ac0-8dfb-424ff121b41d@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 09:24:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, Johan Hovold
 <johan@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
 <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BJ7F5JcaI-dXyyFWRu2btDjccHEYBubu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEyNSBTYWx0ZWRfXyR39F5PayACP
 W35NyGhphHWo1EvjSdWXAd3M22N10XY5kwIHdlVSg1a6+ck294hUJtF630cNu5mZETVJgkyv3Pd
 5rpuv2UwWFIuHD+Do3/QNYTt0jfSUqRIAtAI/6Fmne8KXB1d/iNIojTqTvPrngy0F7ZI4+2qVdX
 nioZFJpYEGXicQrKMsV5CfxdLEH7TpP6vKkt75bmoMlBWt2jjmC2nZVg1Iz5qsqijNoUAfGAH9i
 NNn558WSnzBj8RcafgkvFPje25GiQlWHKsNrgyHYipcR1XJG55cnR8JXq4eLuQXtV3vp8o46dMp
 gcM40Z2pQqgFJjmAqKfmlyWoS90GLHjaCqoUKS6bubP+gHHUFtpD6f9NbrlQ6Vl9pXsprm4/+l8
 idFukPI8NTF55cux1eks0yLVjpByW27rAD2suPhrpmEhXBBxEqnCyu5qc2KNBEHYLwdw8J4D
X-Proofpoint-ORIG-GUID: BJ7F5JcaI-dXyyFWRu2btDjccHEYBubu
X-Authority-Analysis: v=2.4 cv=PrmTbxM3 c=1 sm=1 tr=0 ts=68407344 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=OOj_HejH6eEqbjqsXVoA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxlogscore=963 mlxscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040125

On 6/3/2025 7:34 PM, Miaoqing Pan wrote:
> We previously had extensive discussions on this topic in the 
> https://lore.kernel.org/linux-wireless/ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com/ 
> thread. On my platform, dma_rmb() did not work as expected. The issue 
> only disappeared after disabling PCIe endpoint relaxed ordering in 
> firmware side. So it seems that HP was updated (Memory write) before 
> descriptor (Memory write), which led to the problem.

Have all ath11k and ath12k firmware been updated to prevent this problem from
the firmware side?

Or do we need both the barriers and the logic to retry reading the descriptor?


