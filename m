Return-Path: <linux-wireless+bounces-26122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BC0B1A230
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 14:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C57AE3FB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB261C3027;
	Mon,  4 Aug 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="McHctA66"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433BF257AF4
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311583; cv=none; b=ZJSAGeUqss6UpXfgef8zAi6vbO7OpovJiHY5Y4YKluCGyUnm56nqGxOZCgZmE1SIp3MXFAWXgCm8FzsUv1Z1Gjz/XYexeZLNpPut9V0uljZj67J2FVt3L11L3U+8nqoqFsiSq/KChG5BxwAk2KUVAKFfSeJT1conQsY29LCC9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311583; c=relaxed/simple;
	bh=rM6WUBKB4nM1bTFF5efRuiq2r6zvWYsDnKyHNwOgRp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr3aRpuLNFPwDot73SyDWPMTICcVclIK4RGTWkvmhG4rxZOpxx7Y0Rd/LwxHzF1s5SIQL0xtPOet6BdsHhkjQHs7P84apBCNnmqAJu7/KlfKURr/ewjUMzPPy0xyos6m8+0bsmYwNDfoSANzGpheWILCPqaBtMU9ZbecwVtqgDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=McHctA66; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5748i9j8017261
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 12:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=srJNkV8mi/T3+DZb93ch2hkK
	PbbG674MuA3RGQ20bB0=; b=McHctA66Bgs8D1rMerh7ta8TOsGMjNF74+GhUZNB
	iRmxL6EhwTlWsCSPQtSTe1PZ09+aV6cXYwFuO6s042TBIpTDdiIcwzK1n7oRxaPq
	p+TibN0ZEzGUfDJLtFM6D0D2ZTbaA6ycMyK8cr65uYDsgrDfSeEZzQNnJFpHk4zR
	Ms/mccru8rJ0kBSOeL7qxXQvn2JL9YB+ZWsx9bTGoMwfCN3pR8tSrK25VTsdF/oT
	ArUBgWyBDxa7GkqfNNh1fKTINPKXnVYNGFztFVEVHAnduCmPMgYP5hIVSvSrr08u
	RBckhVA020jcfoMSlC3wcGHGK80QlmraG5Ok9efCUqiqXA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rn88a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 12:46:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76c0039e0f6so1267734b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 05:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311578; x=1754916378;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srJNkV8mi/T3+DZb93ch2hkKPbbG674MuA3RGQ20bB0=;
        b=gq2iff4W2P1xVK4O8vZW6pkMnrRcMl7bznY4Oc3OKR4I7XtYwyTt8j4RHyHRECCavU
         gx9sRVdbDqJhkotax6pWIfJI5XlEFarXmd0n7a+xogEXxPWX0TF2E/GJYvc40YApHQ6F
         N/818TbfRz8NUVNv/VSIS/A2QqomD/1BCEBpYKiulByjs47SKPTzTfHNqaE5uumgCevH
         JnK/OSjMwzn/ooziyadwVG5ZS5HTAB0rcwfUqRePRlFHcVR4fc8WlAwNioVce/EoL8yX
         dWiKk3EgxVb1uOGGqUSsvK2bYcuE/X3JRgzMkE/ZKqMXxUJtf0cvivhIGrU/ulEN2RpS
         739Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYAmaSFN+9mZvXUf9lizqmGUbmrAlayIpSYq0+Cs10WfnCHriLFKGR89MMekCdcTDhD4mp8gNiFK1Z9w0kQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiY7sHxPdwVGv7fgJXgw3HZzgdgvBZ5W+fG91+6kTVAyhXQvm4
	E4oRkDgENxJjfNetVs+uAA+ufVQKKoo4xawfUnmZVrGK+zgZN7FNCl7QZ40YoGtB0n/Wt6V3lR7
	nznS9URG6HoKY5CKnN8llsYrmzl65WlNuVhmyxd4JEfxUC+AhPJgx7gb99OkZoxVvHit3/g==
X-Gm-Gg: ASbGncvIPYha5RHO4x7SA3rdOXTB2iTnVsQ+D473Dcuiel5+BkEiFgLIW3FkzXUbL6O
	VODpHw8ZR21TIvLH8N82QAXpsinNU9YWobGThEUSNmezLAX2DyaFkTJYZ8ueypit7u+eERyMBD4
	oNSfoShz/3wmL/yd8Yxx4X/v7VZhxFLCW3eKxYLT1eEZAWd5MvpsYANzdJcV6koxkOAqtJ0DIP3
	SfiadptnEHPD5VjgTIEEaYJDunhkEJUP+uSbma9jC5xd+AjcQ8EyJMrM8orrQe7QSlGG7tFA0Py
	VzymJE4eEgqy7VDul6AkZa5/kbjpq31Ov3Pwh8wbGtjcE04n2+8LCroJmzll+hd5FAU=
X-Received: by 2002:a05:6a00:1484:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-76bec4e1e63mr11958351b3a.18.1754311577885;
        Mon, 04 Aug 2025 05:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpdaJQ7fVIlE18tUxW2ATQbF3hPhP2gMHXpqf5ai2xxiI+sZ1i3HhvTdj4U6zAvu2H9FbzRw==
X-Received: by 2002:a05:6a00:1484:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-76bec4e1e63mr11958312b3a.18.1754311577464;
        Mon, 04 Aug 2025 05:46:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8b5basm10399198b3a.41.2025.08.04.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:46:17 -0700 (PDT)
Date: Mon, 4 Aug 2025 18:16:10 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] EDITME: cover title for mdtloader-changes
Message-ID: <20250804124610.xqioktl6lbyvv5qb@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <andersson@kernel.org>,
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
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 11B0wAhCOZ3x5fC8s8tQ9Z7gJ4svqRM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OSBTYWx0ZWRfX/OgjcO0co4ea
 ejTaUYVeA2vI+I/Tvd8bWePCmFaCxKwaxXyUGaI2+l+9d/B+RynlqHV2Y8YpeKwmDm7qcqaxUfr
 gUsX4YPML7TcNfinugK4+1UhteJ6adaKyrg2EAH/A1HTIibANam4vGs5zBjNmMFLfFKVNKhFURW
 p5vvEEZe6uWBmP4Cyxs6/fYMLZxINvZ9s0AoLRoFuEwefwCsjkWCXTBW1rsel4bPtsglWm4cxUo
 6iHUvk/l/h2iJrLahgBsldfa0u8AKX3wqpVZCwUKJCHin9DsZ7Vr1+khGBSs8wWwYd1+cmaT0tS
 /hVoDZ1DeoN6yaxFpU+d2/tiCQeWVt8m2szL7IKy+dblkV7UMWSQj9brVVCR9DtVHUK6xR41Y2h
 +vm/yNUIa9x4Akr0/ggDwm8vLHTAn/fDGfMVmxAUSeMw5za5+T6wlUJOka6cev3ZZ7x87YLC
X-Proofpoint-GUID: 11B0wAhCOZ3x5fC8s8tQ9Z7gJ4svqRM9
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6890ab9b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ICuFGErgaGyLqr7TlXEA:9
 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=911 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040069

On Mon, Aug 04, 2025 at 06:11:48PM +0530, Mukesh Ojha wrote:
 
Please ignore this mistake of sending empty cover-letter to your inbox.

-Mukesh

> ---
> Mukesh Ojha (3):
>       soc: qcom: mdt_loader: Remove unused parameter
>       soc: qcom: mdt_loader: Remove pas id parameter
>       soc: qcom: mdt_loader: Fix check mdt_header_valid()
> 
>  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
>  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
>  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
>  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
>  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
>  drivers/soc/qcom/mdt_loader.c                | 22 ++++++++++------------
>  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
>  7 files changed, 21 insertions(+), 25 deletions(-)
> ---
> base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
> change-id: 20250804-mdtloader-changes-9aca55e8cf37
> 
> Best regards,
> -- 
> Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 

