Return-Path: <linux-wireless+bounces-26193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659DB1D1D8
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 07:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53484564E2E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 05:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDFB1DB127;
	Thu,  7 Aug 2025 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqrs9qkh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49151E0DCB
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543401; cv=none; b=qPvihvSheVdLIQDwXbK1zHmPMKIdpR3utVUYwjfN7Gsdv5mw0dVtrHDRdb5RZUYcL1V2Kz2JtgeI/nuOD9UCGc12L15UI/jkux5UntjAOOjk914qhmgcOV/JvB7hitGCpDY0rxkKicI8IkWcOC7hYRXsDo//5vDfcJlESwNm6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543401; c=relaxed/simple;
	bh=Tlr/AsUjBkz+xny+/rpFl7o+Ey8YWX6po2IM+lvkxEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBcTVs34CK4Y0JV9GRRVx9bcq8LwBsUR7TNwcIs6cUfvnNCgXXpEN95cZA8Hi2dOTb3uiadEQGbEydlpuNEQ4NBqMWBB86stz4W5twNMdKllec4KbMKj7ZVQ5TtzNWDfyiw9Watxkbz8iUzOlfZjEFcGsu7Yf6bQEgnBTDeOv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aqrs9qkh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57723Aro010872
	for <linux-wireless@vger.kernel.org>; Thu, 7 Aug 2025 05:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bmXjPpDHd0Cgpzu9CL46gO7J
	+euneT5LSuqRLfgfzJA=; b=aqrs9qkhORFhgqiUNUP0pYhKt1VB6oMXbtys+wIJ
	lllsaCtVARHRehkk2xlv/zI5+koVePpz1iNe+b2INzZibBh7Yi7rE/W7pjymGhR7
	olOL9jaES0sYiNoNsYhRTjye27XU/mHsU5fhF7dRyn0dkcHHIhRCoJrUaPVv7qb/
	tBhJGP+3QysAA9t6Kf1KVZdqSLrMWD+pb/tsoIbJdXvKYlEBGlIP7iGNNxnLE1UA
	pIqUSY5LiyjCS8JsZSwEqXI9TEezGgVPisDefxobZ0i3s846grVh7fBJ5dJhaGCW
	P7MKmhrcytNa2AbShQ8+93IFOZJRLiCohcH8Pl5/C9esvg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy7w3hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 05:09:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3211b736a11so1404547a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 22:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754543399; x=1755148199;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmXjPpDHd0Cgpzu9CL46gO7J+euneT5LSuqRLfgfzJA=;
        b=J/TigLJu41enTnYGI4n6hafX2MiEC/WdSss0YPku8z0UV5iXTmTrH3g0uySZQZO6m6
         KLCMu/g/k1UZ/2kb9QkKro+AOxz1Pktfd8dQnB8WVF4y25lDVB1vCqIwbSz1lkfYW/37
         qlTd4OVOTmZYS4nCpQlB+1BCndw/oLTzqKAzMl1YHYZZ9+0UFuK1awauoC8PU0tP5KI+
         hpWCG3fFUwo0m+ev62/YN21Kpo7iod5TgBtLBcIhOq2gAs6vek7roXuXeud2GLbjg4x2
         GH/IdA7tlrDLLZtajQLpfWfyZFD377f1Kq9CkmDG8zIRF2gT7NNqKnz5m77aWWIAuFN2
         I60Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt9cYHL2FjLBAgkakGDXWu8QwIEO//TBzkiUWrxRaq5P5PZQGdT9FfjK/pXhGV3RDz89rhUvS+C95/vH7pWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8UqgHhpSMheVa/jqCuBGRCSljRgsNVYNlkt560ur1mWlJ6P2l
	WzIIQqi1u7sSFMoriyvv4kIIKeKPAXNAwY/naF2CfNrU4EhFh56LFtP0gbUSeW17cJMHT7bVPUp
	mAxh3uV4hRLZXpvCGZBfJYnwV4azKtTbSGEfgTYoCLGdtpIqBMJ7750i3FY0qVwkWje7Ftw==
X-Gm-Gg: ASbGncvxYwY/MVvHL7hkQQbCkKFiYRWQ9hHuZkkhFF4AvW3jtn0ZfwnXv/8BhaEl3/X
	LBSFMbHOiPRYr92D0unp3rDv09DY7TsEEOdeqR3YUZOsTGT4JjWPKlJOESWKVxcXnY7DQWBHIg6
	3igm4rAs+uZefkEYuctMECf4ZYlgmY988rH2NrAwPY+C88gBkYlAQ8j2edDxeoHWdUR4mV311R+
	eyfXTXgKx+XbzGUYUuYy2vMuW7OQdzfp3P2Cx8L45O/2CGWghLh0kbs8P2TGjGSyny6Mt0tYgCN
	067ZnGK8/dPI+DHdAtZXQTwTn0jgKeTxQoDRLEcZP2pPnt0zOghna1WV3R0yHq1FJEI=
X-Received: by 2002:a17:90b:5101:b0:31f:3c3:947c with SMTP id 98e67ed59e1d1-32166c2af67mr7690685a91.10.1754543398721;
        Wed, 06 Aug 2025 22:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG47kar2q36LtbPQN4NmJWmgREGO2dRSmwYDlKD0mRi6OR7+kX7FHIYLR3UKacYjpT+SbKlfg==
X-Received: by 2002:a17:90b:5101:b0:31f:3c3:947c with SMTP id 98e67ed59e1d1-32166c2af67mr7690645a91.10.1754543398204;
        Wed, 06 Aug 2025 22:09:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77f33asm14674650a12.5.2025.08.06.22.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 22:09:57 -0700 (PDT)
Date: Thu, 7 Aug 2025 10:39:50 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soc: qcom: mdt_loader: Fix check
 mdt_header_valid()
Message-ID: <20250807050950.n76f4vtndgjnujbo@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <andersson@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
 <wgpgwf2yq4awig5cztgkgm32h6zjtqzv4irpxd277gwjydofzu@f3zb6t4iyahc>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wgpgwf2yq4awig5cztgkgm32h6zjtqzv4irpxd277gwjydofzu@f3zb6t4iyahc>
X-Authority-Analysis: v=2.4 cv=Mftsu4/f c=1 sm=1 tr=0 ts=68943527 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=OaSFCp3QGDZU0s8We4QA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 89CSplQsYrtmFweuwjLmLRX94lp6vx90
X-Proofpoint-GUID: 89CSplQsYrtmFweuwjLmLRX94lp6vx90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXwrqnWv9XzjnH
 aFO2Zsrm29gHyop9O4qZrfUMLdHShkSkoFxhCMuPGxm7jmUYt7WU83TYc/tA4+jqOndS/Vlv0vd
 gjhtW6Xkxed2nErL3MGuzp+flMnamdmP2AMclOKwsiTVaDKIctellQ6BRqqEwUrmawzhmTn6Ako
 5iJF256oRCCR75oODRoefaLRyRLjTEIv7vYX/rAmrem79j6kkHHuAFKCcpabp+HvUd8f++qNsON
 w0izAEaKYt/YqnczG6Gic2l5S4qdbr+wAW4+c4XVKPP6xt20Rhc2SGK9VjL05+tRiMkaJGD6RIW
 eNdHnAwLxxhnV12svdW0kmtDAFh6NKCAM3UG1TWoWxGIHY09KCR5ZyIl2XV7z26eNF9lVGZbEd+
 8GxeX3xL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 03:01:45PM -0700, Bjorn Andersson wrote:
> On Wed, Aug 06, 2025 at 10:55:28PM +0530, Mukesh Ojha wrote:
> > Firmware binaries may lack section headers, in which case
> > the e_shentsize field in the ELF header can be zero.
> > 
> > Update mdt_header_valid() to correctly handle this scenario
> > by adjusting the validation logic accordingly.
> > 
> 
> As I replied earlier today on v1 (probably after you sent this), I've
> applied the patch I sent out earlier for this problem.

Sure, thank you.

-Mukesh

