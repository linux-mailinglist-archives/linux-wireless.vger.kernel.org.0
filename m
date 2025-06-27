Return-Path: <linux-wireless+bounces-24617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DEDAEBA21
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AA24A757D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647802E765F;
	Fri, 27 Jun 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jEtnbiV5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B12E7653
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035427; cv=none; b=AzWj8Q1kYDCB1wtaPbE4KcqV81ftKNPLs8yGSvNmPcQxtj4z8N+Ue0D1XvUx/GhJijf8kzbNbU7hgj69MZ6QL7eWQa/HfAo5U81bCVrQPS4iTNzWroE1n7yOcurkFe00eOZnTb3z14Kj8yL+Gy1ySSWJLABUZp8ATBK2ndgjFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035427; c=relaxed/simple;
	bh=/ul3doB1+dwnoIoS5D9P2nsTkt/84FYhTR/P0YnMwqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AU5rf1kHC3hdTX6eUtckadf7i+PyAQjN8NvqgPvEwReUtuGu0kepYqyLxPbi7nriCiMZamxsYPNw41iK9nraF5N7KcgnjL2AHU1fHvkz6k4rcbOAtfjTrGimyHNwYv5e3d7pXjW6PF8ahpwfvQpgnfsZjIN+VeDZ4mlxIW/iLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jEtnbiV5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCDej8009564
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mnEz7OZ9bC64orY85fIGEKGnIosfekYwIKnmm/3NWO0=; b=jEtnbiV5A3meDkam
	hKYJte3pUhZG4A0IfGtqwYhk39+9W8wFsYU3o4fi8/WIKQbEE+Gd6+KG64qG68Wh
	1ui17ANu0+yYqRrm0UssyjkBVdM06abMpgjwtUcNoWCnR73CVahZR1XfYNOowmEy
	EelGvNJh3KVArgI5LhkWjpfGLn0930uaJaSkG8X0VAfjLfT6ZyUjn8o48HNUSUu4
	xCeVs567p3WxlpPFVM/s4YECDTwbrKVWQGPaH/8x6bpz6hlIYIi8/f8kPYtoxt5V
	VMoaMN2Wjn/nPkYl6pbDdpY1XGLSjOpDAZuGXUwlD/8U+sd8fbu0czb5x9H9nvaq
	r/ZvhQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b473cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 14:43:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7494999de28so3133157b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 07:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035424; x=1751640224;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnEz7OZ9bC64orY85fIGEKGnIosfekYwIKnmm/3NWO0=;
        b=vAAbiE+eiw4Lr7yPqpRh+JnqyREMdGHKeNhgazQPW6Yf6rjfsmxe3+QNLP8WtLdkwW
         Nv1G+HCKCu9DmQGMcb+ktF6MCuoTC0tOf7qrYUXyQ3yQzPvAAutNi9NJuvNAATXUfOdy
         eC2EK+p9a+BgNk4DAinNkP1O56vDXN1vOfJhQCpEBtkqfdoMU68bhn8jWqYVFrqAr3gg
         JLU8Etp5yj6z/fd9QGIPxIOPNxa4OKxfNKlQzo/FbTUt7SVVfoRZj7UCAzmEKfuOv9hp
         hm6noHs87C5ddGei/d/EsAdEHVHW5xivSM2b8jBF5BWICDvwcIt1G9eTEqBRk6N5VYHy
         CMLw==
X-Gm-Message-State: AOJu0YzqFYMDvoQD4japkqnFuv8CVpA0NO9Lg/R6j8HQiOWRcPf+a5kH
	3gmsws9gGL1sZYG9nfhI80GLwuogyN6qAV5f562Cwz7yS4AuYvZQDzF9amPEYzsa+c7shbZXp9Y
	sUZra2d/2IwI54DFtg3TLJiV3toq0oOUhzx4rOnp7i46/0kzxoT9R/RCvZuDWiBW4K636SQ==
X-Gm-Gg: ASbGncuOorA9iccb+dZ+sDAQPyp+2Up3ULA+58QHauTJfAxLd/KmGEFqTyXcotj6g+p
	eQyV/5mQ6byVcxUqIPi2cf90Q/L7F3DegErllPp/I2YEjcxjI0qOAYm5+KObISuVspwF9jqIpEt
	KOAvRLe2yVlTkWUUPdvlZlzCY64rbxN/Ua3gWcmWLBhm09ElXZefpcSEtXGMv35aQZ9BjJB+8Zd
	yapIiXzkD3pWU4NRt45n/Cg1oDIDorFTaSrGeXBlEn2wwNPTZB2pG5oDTdmafMywikRD2I10m8H
	9ApA+6+dvYOFyJTKgfDG2BYPv8kpyYX+MRfHJKOWg01WZzPAyIQ4Qj1o6Ik=
X-Received: by 2002:a05:6a00:4b16:b0:748:f1ba:9aff with SMTP id d2e1a72fcca58-74af6e6350cmr4661281b3a.5.1751035424215;
        Fri, 27 Jun 2025 07:43:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXUXASWkVGqAD6hPre0AnkWX72+JTqkej8+ilFSGk66OQwdS0ApjjhTz7IQTLD/IwpMwL9oA==
X-Received: by 2002:a05:6a00:4b16:b0:748:f1ba:9aff with SMTP id d2e1a72fcca58-74af6e6350cmr4661251b3a.5.1751035423831;
        Fri, 27 Jun 2025 07:43:43 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef4ccsm2458956b3a.156.2025.06.27.07.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:43:43 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250521055411.288724-1-sumanth.gavini@yahoo.com>
References: <20250521055411.288724-1-sumanth.gavini.ref@yahoo.com>
 <20250521055411.288724-1-sumanth.gavini@yahoo.com>
Subject: Re: [PATCH] wifi: ath10k: Fix Spelling
Message-Id: <175103542317.3295854.2266295711938072392.b4-ty@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 07:43:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyMCBTYWx0ZWRfX/nUkepAY97lw
 vkAHceRhdORK8IZE/aNtcWqi5wB/qgp7CovPpH/V8xPNEXBGboGW9O4bkm7TZ7C9v5R1G1da71Z
 LHplsTO4yIjzAZntzhORbGrgbVUh44AfrABmgpylOpLYpMQKjzwICP1kzPYKuR8zstksHGTteSI
 qdaAtQm3Wt7/YXYYI5yeaJg8ljgjYHHdYGnYerVbT6Vv5G7wsgwLC/UHg8K9W/k5XwyZq6AZuiw
 txK+s+ImHRhT5AQ46t1aWiB/SsLi8S/KfjKJ6yA5DXBZUUBd5GGIf6C5NClMzMGvmPsoqmk8eJT
 iUrl5yR9bS637XlucMhJpcoE25wQZEWATG9EodZcclcela2b4oWJWe+iLaG54M/s0cEYw93S1nZ
 kUaSHh1NlMlGCgfDSuG5+DNDIJoqkJWzNFG7Wy3HXjb0cUchCWAnfTn7STrQH9X8cnWr/DFD
X-Proofpoint-ORIG-GUID: zcRPDC6Q6LDne1JLf1yJp6FDk1lHDdUL
X-Proofpoint-GUID: zcRPDC6Q6LDne1JLf1yJp6FDk1lHDdUL
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685eae21 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=750 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270120


On Tue, 20 May 2025 22:54:09 -0700, Sumanth Gavini wrote:
> Fix "trasmitting" to "transmitting"
> 
> 

Applied, thanks!

[1/1] wifi: ath10k: Fix Spelling
      commit: 20870fb0a3001fa99f2684dafb200c2ae6b8aae7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


