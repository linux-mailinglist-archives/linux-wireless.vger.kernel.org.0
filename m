Return-Path: <linux-wireless+bounces-26160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF63B1B603
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E0174ADF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6327F198;
	Tue,  5 Aug 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jAIMma6C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534527FB27
	for <linux-wireless@vger.kernel.org>; Tue,  5 Aug 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402721; cv=none; b=WIGT3SeyjjcFtb3RGegE9V8OW7eC46PrbX+HlTED3FxFGgY0HnwQB66JtL+KbgnqbNPNKtMq9S+B2kQf3ORJpB3UJ81gJquCY+pvdfDGK1sfOG2mws7jciae8TdlWskg843phnX24aS2yap3Z7wSfNuDLL0hCrGwkF5klVNrbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402721; c=relaxed/simple;
	bh=8J5cuWTNGNmnCmEFZreVGaQl+BFghG3/wBWhuX49l00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkirU9oBIjFa+sXXGYLtEVasGEfvMEJkni+VhUY/liy8VNbGRkOXDm8AEbOaiY+s7Ki3XZnUrc7SnkuIqwrSxLmVWMtz7wnZLq6dYxJMr8vaS4igr8ym989lK8CfNsyzqaThnBbtvc6NzzoHZW1jenl4DimqvA3b6YmDIdpeJss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jAIMma6C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575AcOWT016480
	for <linux-wireless@vger.kernel.org>; Tue, 5 Aug 2025 14:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y8GWTLsDapJ06m9sj6GKQ34d
	0P33lgkh1NvaX1OZEs4=; b=jAIMma6CYw3JK3nfFf0Da2hkIb7nPW1Jh4bDgmtD
	5iw1pkAPLrNmwsi+f6MHzF+yZXpcqvNA+nivsWmTgTGBYZsyFEGHnZ6Z0C5WgLKo
	+UrsaTVsR3Hc2lBXoCXlKiULAlsfBm+nhYZSLvLhM1MECxBSCQIzQYtwqEhwEkkm
	SUHpQ9vVYlxAcPlFzel/7M8ThaizvIwdTPXXqqsufHLPnMeTT1EilxP+W6ZJKsHc
	C5z7N2AdRpr1WurFIipApsqpmD7uelP8DxdCKqXMZ8N9XgDUpIs4ptV4JDZ+vh3u
	eD4BQr9Qvh4D+WvpvJMBklk1m668AibdG7HQg3pQ7LjOIA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48aqyv4ya4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 Aug 2025 14:05:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31f322718faso4505884a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 Aug 2025 07:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754402716; x=1755007516;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8GWTLsDapJ06m9sj6GKQ34d0P33lgkh1NvaX1OZEs4=;
        b=PwxiA8u3zTVP1C2oJWIQe6oySHfSeK0saBc6f+X9QawDmdz/o6s2LBjsp418VmlYN5
         ttXC4pXadGGrHbqYNEtbp7Fj7XsWuwhqHJQNTfoBpapqENe2rAy6yKsJA2JHwfFKsTtI
         MUayQuDzNgc6KVJ1EhyDECPun9Go0DC4pcHyK4nTQve9+ysN1PuEmwENkF6o0bhORuKj
         wLAhCvOiBt3QxtXOCWUaJpR+97yt2w1/5bSb9b2DT6kP0zbjx7lVXZg7ZJOPcvie4Wyd
         7JKww14fRDtJbGUSo8hzD4Aamh5uKl58h+6Uh/dA9TL2ydyPS2A/DiGPYxOIyyPC/NCD
         2PDg==
X-Forwarded-Encrypted: i=1; AJvYcCUEzgGiYKbpy6u9FZqhuLklpllKzvTxD1ug4tgNjYIe3rRT6hml2UAWrx0mHlHBScgXG+qIFB46XmIGnbnseQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uXeHaO0lodiyKt6lMLISyuu4lWAEb9f6ksP6pA+HpmkYCMjx
	FzMJ/wCAdC4ZAiECHmAcpf50dizaUyWwUvbMWTUq0NYYslNJO86BOvZNu2cyiD8LzeCEpWVPfHF
	nvYacgCgSzpEz8eXXQ4j1/R2BKJb7ocR2QUOol24N4IQwKpFCt1s5eHCbRk5/wFKTphL13g==
X-Gm-Gg: ASbGnctck3OFNdi/EU1Kofa5xAMW+C7+mpnbdJFBE+uh7JoFPsCrPomSfCMOk+qpw1k
	/1oDOGaWN8ltgIgRY/tuTCKHzLoAbB9mjZ6WxEEnKNhp77dQXlrZpo2QNr7aCBIOIe8wYXZO9ts
	17dAbvFsYx/c+e6vCLyeL20Lu9q5kpvxWKWBsHewEVJN3xXvYK/7NG1FoLmryrA8qRP+/tfeQqb
	pLX/igNN2vHDj+COuqsqSYKCMlC6ISD9jMTjIhA8QEbROAGffgxnjZXqqYo/vlfVoNVGO/slb+3
	S0o/lGwxK6IqefIKf6RZY3ZJ6mMEjiIE+zkD2PBoikxoCJzHrD9QWxiuJu/ChSpWaR4=
X-Received: by 2002:a17:90b:3e8a:b0:321:3715:993 with SMTP id 98e67ed59e1d1-32137150ad5mr11688572a91.14.1754402715855;
        Tue, 05 Aug 2025 07:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjmfwajEFNC0n/4JWnoR261FA5nFMX6Yqgmg9OjOOyA6BAlGJkbJzfB308KbNyUV9w099bVQ==
X-Received: by 2002:a17:90b:3e8a:b0:321:3715:993 with SMTP id 98e67ed59e1d1-32137150ad5mr11688449a91.14.1754402714757;
        Tue, 05 Aug 2025 07:05:14 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611d846esm369077a91.8.2025.08.05.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:05:13 -0700 (PDT)
Date: Tue, 5 Aug 2025 19:35:06 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
Message-ID: <20250805140506.b6d2x5berkss3it3@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
 <658d7d55-fd5e-42cb-bc5d-abcc0b47a168@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658d7d55-fd5e-42cb-bc5d-abcc0b47a168@oss.qualcomm.com>
X-Proofpoint-GUID: 8v5MUUcOjIAJ_o--9oTsnplerSzJV1T7
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=68920f9d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=9ZXyijcKk7BvzWFVFWYA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 8v5MUUcOjIAJ_o--9oTsnplerSzJV1T7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwMiBTYWx0ZWRfX2QP1K6+lNvst
 TKUhbrCVVSu5Gd1OIIy1qxVRB5CquxRwD0SnH23kTPpqep2dYeKsWQ6pzBsSoH/tyk6A1pU7TmA
 boCHJDzbGEvZGsbSPiOZUcMQ9KdmOeA2K+t0qYtkk9/kqVGkAiGxo4niLpDdmzcrOHlCdqdFTEd
 ec2OLT6sqSXCHKL0ut5yw7ul+VUN+roA1YQe7sf0x9VIQFvjiLhCGvyl3nicfQfuF4hopkK/oo3
 lUqXuT/NDEZ2IMrLjW+3k9HJyteZ93e/yXG6I06Xz7n5HZ0mb/XZ3zxZO/OqsFjPMN6WgeZT6r8
 rLk48b1oP8cLqlUS2FAkJwZWfWvpl9CsZ74SCuhOJK6VcT/EDxAMkl3pSRWdkaFpJ8Hn0R/PfSH
 HlJtTfrTVGxBmd1XSex7rQ5LAgLjlGG+ojPFVwlHud5CJvbum49dDcveco69+uxqZFp0qwdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=873 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050102

On Mon, Aug 04, 2025 at 07:17:02AM -0700, Jeff Johnson wrote:
> On 8/4/2025 5:41 AM, Mukesh Ojha wrote:
> > pas id is not used in qcom_mdt_load_no_init() and it should not
> > be used as it is non-PAS specific function and has no relation
> > to PAS specific mechanism.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
> >  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
> >  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
> >  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
> >  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
> >  drivers/soc/qcom/mdt_loader.c                | 14 ++++++--------
> >  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
> >  7 files changed, 17 insertions(+), 21 deletions(-)
> 
> Since this patch touches files which go through different maintainers, do you
> have a plan on how this will be merged?

I am hoping,  Bjorn should be ok to take this into his tree ?

> 
> I can ack the drivers/net/wireless/ath change once I know how it will be handled.

Going to send v2, please ack it, once we have confirmation on the above
question.

-Mukesh

> 
> /jeff

