Return-Path: <linux-wireless+bounces-26129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B8B1A46D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 16:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9128417F38B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B6C27146E;
	Mon,  4 Aug 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RMp4iUAd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDD1DD9AC
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317088; cv=none; b=goUbgDlie8eMY5jzQ56+MIZ2s4eqx83u85utsxsOvQNMueF0j32nS/hsHWSr41/DKFgaxL9s1nZYspu4HoayIv3mc7hxZ23g6cFD15aw3qlGdjyVWSpqNEcZEn5fCfM/TteYk2crMQAZjAEoR8dKy7iflbQiRHpGK4yFdPYkYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317088; c=relaxed/simple;
	bh=VKZmdjotUC3YbS16o6pwylau9DHkDdk5aDr5RC+8Sb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0Z6HJnmqpsdcqoHgTRmghju0KTPV4x+nJdENwLk/dZhGlbbH3b5Ovgu4yZTRYOdA5nu9aMLrEfCz9YIIj2hN4xzwPSB1UNhXOqSK2uDi7sL7iCLK6osNolmwpV6Dob+QO9u5ls1UiBvtMpxewsxDcUoPbARcEAgsaCGNVuJXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RMp4iUAd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574A40bA031698
	for <linux-wireless@vger.kernel.org>; Mon, 4 Aug 2025 14:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yV10ozYgUe4tzTx22lApIwGp
	t095dJ2LaBUIJh0zJQw=; b=RMp4iUAdZ9MiaxFspe846207a/m9KYLu8rIGQKjJ
	qB4vNnU8PaDP1Ad933PHN0PyrgvOI0fhe2SGeJ77pV9WJgEDfyRM1Ae4aDn7aWNf
	IArKKl93H++Hq7ONRD+H4cj1YfYK67jEveI1tDzu0H3ULUuMenzm0QKUmIhAfn78
	eP/TJ68EYRxJALyFI17JPBWUmbN/MiaxK8jEF1ZMT/gakSrO37rUX60yFUKn3OWA
	BXG9d0aoFqfMM+IqudbsaqHxRQycBnRzuVyfkbun6/f9EN7LiFNusGcsS9E5lwp8
	vgrmuF45J5XPyfxVbmtZycCTKPTarVb1uTQOK3ybKwJnTg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ak5a22ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 14:18:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bfab12672so3055726b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Aug 2025 07:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754317084; x=1754921884;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV10ozYgUe4tzTx22lApIwGpt095dJ2LaBUIJh0zJQw=;
        b=FX/fvr0+uFVrF4oDxjdkWxczj/Jjrf8bGSbTULyvK+euNFRR4rzeg3cW7IRiZN5poM
         waehVjouKsypopP8sxPjNEicPu/ZbrWYR9SyphjcD6w6/HK2rj2PuQ3ae6nLoLsPLy4t
         nPsEEgBRnvNI4LozGP+YVll+hOiUUAPFNbncXAIQpr0poyWRGXlS3Pu8d8BSpvW+Q903
         FebMegkvECSBGbfUr5IoiexoAjW26rF30f9Laq4ysOgoJT/hYRFnxCzYgN30lt0KECOe
         LWC7WiJ+P45H6s+mXxtAVb7MXMSQmjPBvL/ndDCHPHwtWGjk4HQCiu86jvCQTuvrPF+4
         W/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVMRTAVt59eM0aujNdcnjeSDL4AFmPSsVOsOW5SOCWKPVYe98wgIRgcDw40yo6MMxhhk5cCF03lpuQger+BoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfPnRPctUrQ93RKVVU7lIMH3vA3A1Oy9Ilb87+LgwfJ263a8J
	bKUFPNTvpHAbkcNAPfeYx5cyzihGaWkoUqYOc9kbITL0BiM0KfVMlKTWNWPP3rZDd8MHGhR/1eE
	aBnAlwAHz3CrUvMYiDs59w4Xxg2Tqh7iIKN5nM1XiTneIBF/uLYHwI+rZl7qecbWaIxtB3A==
X-Gm-Gg: ASbGnctV64ETGhtaijSN/VYM9r6tTF97H7WQjJm6lHERGQqXfb8P6rFrgzw4hciYZ2/
	kbsuYo82okcLetc2kvtd/y7Ii3qgQz4w5U/92c75shQJ/sEUKRPJ8ozMck1v9kvBad0Pbln17uK
	ZH3GIFXEC9C8GRCRDyaEq9jdhPmpAewzMQlqIUUvR9FjP5PiDFJVMqAJuXfymJArj+QGottIBqT
	L1gvtj7jjaUmrRr5OwW69LXl6aY2YNSj64Nm+LiwjbWdmX8PNSS8PwE17ZMpK/oPwcHya2bOvb4
	aUN0YYK4pn8loHGqHruQInO7sd2dfe0Ntwi0ut4IwQszE/rUOn4xoUNdeqKF1jxON8Y=
X-Received: by 2002:a05:6a00:744f:b0:76b:f06f:3bdf with SMTP id d2e1a72fcca58-76bf06f4064mr9615983b3a.17.1754317083680;
        Mon, 04 Aug 2025 07:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGDsTzlLGqDnAvh3MpUA8PVpt35YKMpiCWpzipsOhlEqGhm5w5CMVTLOTYyI4L20glEIYSNg==
X-Received: by 2002:a05:6a00:744f:b0:76b:f06f:3bdf with SMTP id d2e1a72fcca58-76bf06f4064mr9615955b3a.17.1754317083308;
        Mon, 04 Aug 2025 07:18:03 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bea205365sm6411378b3a.83.2025.08.04.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:18:02 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:47:55 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Message-ID: <20250804141755.qzwfgqjdx3s6yc7q@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <095ab6dd-9b0d-4f58-872a-852c5f19818c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095ab6dd-9b0d-4f58-872a-852c5f19818c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3OSBTYWx0ZWRfX9JoC4e4pjeFW
 X/mGUD2fdFb4DotGQlcNuKcSBfOptlpMux39GUVNijhOfl78MZUIM40VxhPvhSS3nzty3QvGTMv
 gP6unGkJ2V257EOqHrNGgzed53d+l/J5F71nwXQxQDxBwnfKtMajkL5qUWBOX3oU3dfVHPIU+cx
 P+XOmb7/RQBkhXIDpkkssZ02Rw9AOTaZ5t7q0NPK05IPVcJlJ/VO/DG35mBZ06uZ5/7SRMggO1F
 58sSRlgUFWVIcGkQ2NZ2tfjHOUo7vrUra8r17ijChwwtOht0Af+D6s772fZ1UvVxGXs47emI+TZ
 sYtnEMydnHL+lBAb/WSsj10+yW7CrflgvJuVenBS99FI3svlUqo+oTdrTYH/T3LoGBzKgOvocns
 XTccqwE4LvwDqpWZDR/XseTks/7gwJbKU2Le84MMIeb0ZU9BAmL035WYpkKkPwM9KyciNYRj
X-Proofpoint-GUID: HL25jiOLlqPACr8G3B521_4Irxx3gPeJ
X-Authority-Analysis: v=2.4 cv=LP1mQIW9 c=1 sm=1 tr=0 ts=6890c11c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=6krb5mtG3PrLwc7-ycAA:9
 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: HL25jiOLlqPACr8G3B521_4Irxx3gPeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=992 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040079

On Mon, Aug 04, 2025 at 03:16:35PM +0200, Konrad Dybcio wrote:
> On 8/4/25 2:41 PM, Mukesh Ojha wrote:
> > pas id is not used in qcom_mdt_load_no_init() and it should not
> > be used as it is non-PAS specific function and has no relation
> > to PAS specific mechanism.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > -static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
> > +static bool qcom_mdt_bins_are_split(const struct firmware *fw)
> 
> This seems unrelated (or at least unmentioned)

Ah, Missed it.
I will keep this as separate change.

-Mukesh
> 
> Konrad

