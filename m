Return-Path: <linux-wireless+bounces-20560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A1A68C25
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 12:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB7A7A3495
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F60520ADE9;
	Wed, 19 Mar 2025 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cvOsdDR6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977CF2512DA
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385125; cv=none; b=V1TJyMV0RRgiQWP2HM/1ik3oXiPjibcpUS5YokpHXvbiuWKPjz8c5jfnlwepaj554yc1g2EHszQ8Aletd9qFo8NZAkRl2o22NrfM/w3uzSh+6e6Z4AUMAc0ocbPhkB6BGGlplS+UcNgxtaEjPVK8libW3kWRDT1n6mq9bxhxd+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385125; c=relaxed/simple;
	bh=lI3/UosqQPWkr2VCqCQTQ//FE3cLbgpWLPWReHxNYF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y13S+yZrXwEXNrhdHyOhtksZRhkgUKbJEyT8lFiuGP+whlZxFgsNfzDQ/CJPixQ9hqwTnbbxyuBbJPFuv9CQB7ihttlfV7kjfZby4p0i7bAw6lMHyJc6n1qlV8vW7EX38frxkPW6WFSNibR1x7V1pcGWeSLb/+jnjO8JsTvc2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cvOsdDR6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lufl017235
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 11:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UdswPg3edtdDr+B0eoS9mcUO
	r9VA6UyNDyGqxsynjgc=; b=cvOsdDR6JSP658gpX4Z9l+6ehz4rwF3gCO9c1GLe
	EmUAmN7rk+hSeKd7RTUmne0azQujC0LJtieA6PDc6a1qIWE5aRb/6/UgzBiMbIho
	VLvbPrityiO5+zZzMBXVrt+GUTmXCiOr1yncvH03UlKGblGTVYiDQEc9vsmiLCJy
	PeUzNSbsU2NTEmDOfvUwRKKcoV1z6146zYlRiwGh9E8+ozQ9pyQRaIfrIdtDio7p
	gHgCX5ZkRHSqhZaRbV8MNIWCITN4atOiRHBp9WjUO2N0jrRqlnDRn0AIN1mzz0u7
	og5oILJr6nbR/PyP0pdP0Gxjsw/eSTDTaG6vp8LYbDm5gw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sy3g2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 11:52:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c546efca59so1070234985a.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 04:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385121; x=1742989921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdswPg3edtdDr+B0eoS9mcUOr9VA6UyNDyGqxsynjgc=;
        b=BwJAHRc0prW/Sw5Ly2odI4TQMFyFbcZ7WjJ8vWOEdFc/PVIsbwUqI8klFZHNAxG6xX
         +f2eOnr/yMx+YEwDgz10dpBznLzrjxTrrMCNnmDG0/Ixpya63/fCOzD3rzqC5qMzzyKv
         TlErp8igtKTvgKYSR/dXXOJTLTLvBdg1c0QkzJQXCfRlGkVLfwTACjMP+RATpj6dEcDE
         /g3o8ctlZhpdje8PUn8Q8pCX50i/b1F0RXqvPmcnnshiaApcBZE40+bD3FgYVLktf5C9
         IVu7Tx2TkoUFjV2vdyH915qlGrzPmvIoyVfu5paTlJt0uI1py2qBwH4ChFC5+rjQ7++L
         tl3A==
X-Forwarded-Encrypted: i=1; AJvYcCV41i+rk0/Ps8MmCQnJO+64FSxfgjmS+e7VyVgOkreukKZt9J3mribuw28HJAnJN+M7KwPzfvsHMgwpkD51rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQiOya8SSKeIQaTcbJBCAW8FSZ+MFRBAJ/mTu4ODBSDtoi6cW
	/k4JO/k75DGx9uVbHs+kXiZMqHuyF21ehPPS8VGGAzeP0c35tY0KtLXVQRyZqXqlmI3/2nFdseA
	NvEKDbK9VB2OwyR5eg+gV4H3/JnKF9eLwZrzlMWTAWax5gMDLpz7QSGRljLg3AYi7vQ==
X-Gm-Gg: ASbGncv+bR0HynSVOCvtB/uaTzDlLZF7Gv5TGs7htK1NX92PjgXU0oy2/Ap+YKWuIxK
	Xxt/KvcYiBLI6KzZLd8tx2YAtWOXEo+s/OrUau6Mdpblo9GbQGpvWIowid+Sk+uH0Ih+uhV0bV7
	DhLr/13i7y0RyNYZdWPfxK1BoPuOEnXLV86yQvzgzZQSvvp7nd8uwWqr+e69NkxtbIYAMrcaw99
	XdIYbzpujY3x0HnDmn81giI/yGzIuu2WiSSDkNquSSboCOEl6HwrCHprZqv6nitkDBR5RfWbVWI
	4cqfLv5iT9l7Q12Rnk4wxvMpZOIovuiOlpk6hKXDYsqoRodGV+xzYJTzei2FkC06Tqj/Xmbi1LF
	nBSU=
X-Received: by 2002:a05:620a:bca:b0:7c5:6c02:4c25 with SMTP id af79cd13be357-7c5a83d2cdcmr315465185a.25.1742385121399;
        Wed, 19 Mar 2025 04:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMqIt+ZjjSIzaKVbJahn4BsYCf/9HulpLq8YdRR2+eEPEwKb48mWPQAXNqbJE+LaPyZkeY2g==
X-Received: by 2002:a05:620a:bca:b0:7c5:6c02:4c25 with SMTP id af79cd13be357-7c5a83d2cdcmr315461585a.25.1742385121051;
        Wed, 19 Mar 2025 04:52:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7bef3bsm1985881e87.63.2025.03.19.04.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:52:00 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:51:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, neil.armstrong@linaro.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
Message-ID: <2a5hvicenftfiktviiofvknanyz756cbryu35gkfczdvbcdd5j@fktlzfieotgl>
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
 <db232678-fa85-d75f-de72-d2b5e1ec611f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db232678-fa85-d75f-de72-d2b5e1ec611f@quicinc.com>
X-Proofpoint-GUID: -B0-l3QXEgJOwsusda1Taf8FXIUdrq21
X-Proofpoint-ORIG-GUID: -B0-l3QXEgJOwsusda1Taf8FXIUdrq21
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67daafe2 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=wx4mV0efHSwu5DqQRKkA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190082

On Wed, Mar 19, 2025 at 05:02:39PM +0530, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 3/19/2025 3:57 PM, Krzysztof Kozlowski wrote:
> > On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
> > > > > > ---
> > > > > > base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> > > > > > change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
> > > > > > 
> > > > > > Best regards,
> > > > > 
> > > > > NAK since this will break QCN
> > > > > There is a series under internal review to address MLO issues for WCN chipsets
> > > > 
> > > > ???
> > > > 
> > > > The original commit is wrong, this fixes the conversion, nothing else.
> > > 
> > > Nope. Driver changes to enable MLO with WCN chipset are not there yet.
> > > Setting the mlo capability flag without having required driver changes
> > > for WCN chipset will likely result in firmware crash. So the recommendation
> > > is to enable MLO (in WCN) only when all the necessary driver changes
> > > (in development, public posting in near future) are in place.
> > Really, these are your answers? There is regression and first reply is
> > upstream should wait for whatever you do internally. Second answer is
> > the same - public posting in near future?
> > 
> 
> May be I was not clear in my response. I was not telling MLO bug fixes were
> in the development. Actually the MLO feature itself is not enabled
> yet with WCN chip sets. Any code changes enabling it without full feature
> support would result in firmware crashes with the existing firmware binaries
> available in upstream.

Is there an undocumented change of the behaviour in the commit
46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
single_chip_mlo_supp")?

-- 
With best wishes
Dmitry

