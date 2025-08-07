Return-Path: <linux-wireless+bounces-26194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125FB1D214
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 07:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2647F1765AB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 05:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3F1EB9E3;
	Thu,  7 Aug 2025 05:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ED7htlSd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7351F4198
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 05:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544983; cv=none; b=i/+vYusd+p8e0qjQgb/9CSmkvMs10I+Tg1SBustepzexWtNZHfZa/uzh7/8f0zaj4sLBbtPyBnV3aPQIbbIQKrbQvGfl/AyxNcdrKw1JxvvGx8Bf06GdEJ/OBiYCovJC5ICLhXWJ7sbrIUm4+6Dm6fclldEuK/Skx11bzNXp4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544983; c=relaxed/simple;
	bh=hBdkyxc+SMi+zWG2hEQIQ7ioQV7w1x6uk/Zx2DS+uKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KulrXMoyS4s7WwAcG0yzV03Q2/5EtCXixWTf+wVvWXNHEHabwlvTgLbtkHAz+sRpXqBVwdomojaZJUCQHN2d05EmdRmMl8nWGuNITI5wrHVDwnqffTBYnNxcNnuc55AaF5JouKWPN4dHKben3if8vn/KPhz4+jvT+byFMAJcyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ED7htlSd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577225gh027278
	for <linux-wireless@vger.kernel.org>; Thu, 7 Aug 2025 05:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UxZeQQVAmBavdpLJSCBxurMh
	Vns7iRlr3w0iJRJhDDw=; b=ED7htlSddzgYdLewfK9+dghQeRB9D2fcgN5QpsGR
	7itCFpfsule34dfad4JJ4K6XQOHfQkq2xltTUXrvZPnwFbSF4DF0drY4xKt1UoK2
	H/dkcBBV0uBQqOn2hxkHb8cloOFvHIVZXODYG5BnlK2lwfawPpAk65IZ8+gW4HBx
	IV1wenqR57x1BMujGnfZATPk+SLkF0T2+7CGEUM9Y4MH4l3osJ23YZBd4Eihmmjc
	fPo4AW+xNOW2JwplaUPzHgRvAVwPRbxMxe8n42baslouNkaD0ODlbfwlTSCW9r4B
	6WwVnVqM5NHa7fFKiVeQq2eHqeQk1S/Y4Oj33Y+1byatSA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyad2tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 Aug 2025 05:36:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2403e4c82ddso5308125ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 22:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754544979; x=1755149779;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxZeQQVAmBavdpLJSCBxurMhVns7iRlr3w0iJRJhDDw=;
        b=e63q06bStISi8SYToDYmpyoO/bJbOgPbe+zAMoKeAEbwMAJr45GMYF+hETfp5tQwCF
         ptG4he7m1B/UWR+hcuUqKNR8fqDOmPW8RFz6Szx2vKTqfoBe5/gc4ACr+LyumGFOZOwn
         j4vMjGXTYPehZxQ9qxzhJ77FzsMtVMAyFlKnPvz/GmpFH+aJAIw5Z8VAzxkXOcKDWEgQ
         hwcmSvonU1rP47ByZmtGE44RXP1+Kr8QKhWNv9SqEr2P5ys+X8TAa1+wfRZlzKMa35sq
         w8vkyDRjLB2EjIv4BOS85FIYTNKLBI7V/EpsdJDTmpa/x53t60LyRQ3Fp/4YD9I2CWZ5
         TnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCUYGm7j/xq93JcYpT2G+MBMtDdzbDuyO4YfhGtZTAxVY9XU+wlJi/twXY1UOQW5u1rfKW5IahfwWb1T6Pvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfuidh77iUn8J2kK040JR0duGzBk4I9DwXzTAOpcQ/Yo7YfayM
	9eZzsZV9seYdXY5NvXCGnQ5lzflgGLNykKwGa2gE62LOiIqLl5Vk+/SLe4MkKOz+gnkL2BVENG4
	k2f1dJMVwPBYaWmhyvjgzs/HSEO5jA1wAElc5kDmDr1AO9ZuCvTjNqN9zjCDhaL3lz6AwOQ==
X-Gm-Gg: ASbGncvezBeLG+v/7SqeuP7CcIz45l6PdCSEo0ewL6GBUSRR1UdNfgfJn+cH2yRfrG5
	rUCJuBZXf+CQuRHkvtndWRIxpVDqlkKku/j9bHgFtYTSD5zcrGqjfrOaq6ruHbpci9u01e5zTUt
	lbULu2fMfwaR6D6D3/VD2Pn9rQuQLEwWSsAEOjoiV7eZ6b7eqFQSFp2dDZck7NPnYk6Yb7mDaPa
	OR3dpwQKHXBXl+l4Vu0BtFka2AGcf9oLXZmPg9qCh1heIDxzHYCu8lXscqboXFiOpicErTsddIN
	9kKZ1vmQv2m8/B5mf0D5aw/UXHIhogQZ2pvfTZGMRsJBgK8UBuBftZ8dNf8VMtH+mRU=
X-Received: by 2002:a17:902:cecf:b0:240:3dbb:761c with SMTP id d9443c01a7336-2429f6256acmr95522345ad.32.1754544978891;
        Wed, 06 Aug 2025 22:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNnNfGxhuNTArtU5/L07BRaCZPrejbjIclynuCefSVipf8dv9sFPtvjvfNzygxX8GedWQ6Nw==
X-Received: by 2002:a17:902:cecf:b0:240:3dbb:761c with SMTP id d9443c01a7336-2429f6256acmr95521815ad.32.1754544978443;
        Wed, 06 Aug 2025 22:36:18 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89768fcsm175372765ad.82.2025.08.06.22.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 22:36:18 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:06:10 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] soc: qcom: mdt_loader: Remove pas id parameter
Message-ID: <20250807053610.siel2gsvl2igc3ga@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
 <20250806172531.1865088-3-mukesh.ojha@oss.qualcomm.com>
 <c9d761a2-7121-4ce6-84c7-232a6c4ce976@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d761a2-7121-4ce6-84c7-232a6c4ce976@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: JVSI924UDnpcdZBFlZo3pRfn6VojQh7j
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=68943b53 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=6krb5mtG3PrLwc7-ycAA:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXwBr+mGRrUenL
 kwSarffbx1th546hOUgb0Zil6E0PRRbizeZSdb/JPfXzqGpmPJxMyN6My28p4HXOInQdXfHbAju
 sIK19edTGsdXTmI3EPe8AXIxQDInD8U6dL6+PE0bsksFI13BAuOSySvaYlWigTBQwShXZSkBMs3
 kU7x4hzf7416SNIsQg68DoehF/IM51AqjgX7DsKxUXp6YOP2+Q+GNzhptWY8c+5ByAymBeX00IT
 KMPFcHE3BWNQ22H+15WMDyRLU3RERV/xKAFkXOGRbk7mX8dY7z/k694hxeQ2Olw24Nc/RYIFyun
 kgnO1j+jARpAd7/YWYlr6MaO7vK1OFXP2d8wHnTX6x2gLJNAaBr4MtX+aqaOXydtWGxL0SkBeTJ
 LMKicBOv
X-Proofpoint-GUID: JVSI924UDnpcdZBFlZo3pRfn6VojQh7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 12:07:05PM -0700, Jeff Johnson wrote:
> On 8/6/2025 10:25 AM, Mukesh Ojha wrote:
> > pas id is not used in qcom_mdt_load_no_init() and it should not
> > be used as it is non-PAS specific function and has no relation
> > to PAS specific mechanism.
> ...> @@ -353,7 +353,7 @@ static int __qcom_mdt_load(struct device *dev, const
> struct firmware *fw,
> >  	if (!mdt_header_valid(fw))
> >  		return -EINVAL;
> >  
> > -	is_split = qcom_mdt_bins_are_split(fw, fw_name);
> > +	is_split = qcom_mdt_bins_are_split(fw);
> 
> this should be in the 4/4 patch
> 

Rush to send patches!!

-- 
-Mukesh

