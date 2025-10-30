Return-Path: <linux-wireless+bounces-28417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2BC227B4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 22:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7803A33EA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 21:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FA335568;
	Thu, 30 Oct 2025 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="igCpRbFi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WsXX72MA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC62EC0A0
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861463; cv=none; b=uduJSW+UBveOVezUqav0dA2zSscpVPQVLBys7DUEUwGsvq3h/UZqKRZS9aVVO5Sqk3NJr+xpnaFDtqoETYMzECbujMJ3hCsOMaIEcsARxz74l3JyFzq/J4+BzThecgy2wWxfRy0WRB40tJzAd01uwMjFVb4tPmBOCqxyjnyD/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861463; c=relaxed/simple;
	bh=VLfCFD+uvrBkmpJd/1V5M/PEUjAGoI3I7b5T8SfcbFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HZxzrFRdOpr0la+cjVyR+DHiNIfGYTMDUdQhpZ6U+Nv3KEPbZvnLzrW8i6j0+vacovztE4hGzyO1Wbk6uak8e6sW5qsXdCxiBMOr+jzgTXQOGRTrRWhz6tQBekGF42XdK+Rjp0kY5X0YnBPvoK6Q3eJT3b7UXqU9YX3qBOCc0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=igCpRbFi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WsXX72MA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UFHDYh102630
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hbxlqnkWJKv72MnwB+3LG1JlDumthqKLFTiHBb/B/wc=; b=igCpRbFiLpUf0N/w
	Icz0TjWojhTRRO09YZ4ZKZy5sY1Y7fS/WxzVKImdxQW0DL6oUvgTx3btchE+sfTR
	vSp46K9xoDy5AEhsvgwgWmNn0nfTHplgbWXLmqPtSiBpL0f+yUIq5vNJ5x8OgeLW
	nhkBBizuOxkeftSp4aZYS8nBdLC2+kNRxU57r+KCvP9nwCWDRHf55FwIc1yhHq3q
	2wCbggK5oABqN6/p49jKODc943k9lSliNAh4ALQTRhRZpET3ziDK/IDEw24Z46MM
	SQmNRmv2y4oWgHhO2mEshkL0n5sjI12OO/PKW5J+mRTCgtPZPHXOBVOlHflMh/xn
	/NgPLw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdh3n5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26985173d8eso35092735ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761861461; x=1762466261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbxlqnkWJKv72MnwB+3LG1JlDumthqKLFTiHBb/B/wc=;
        b=WsXX72MAFhSeGgz25vlVOEGeGD4WmBxRqF02wJE/GS3c7UT3D++ufcJ8Z0IJml7iMm
         bD7mKDDEWfnQCyQ27Lylna3aDVhRgKvIP7GzZOuOYDd6/Ai+xOZ6zr/3gZ0ji3hiYEga
         u8292iBLveQaMDBq6MeS16KmkFa97irm7i2i24/4tJKv2LWbTfgprF487tsrzY7K8wk9
         TDYNm0v125KAbMj8T/A+fdI/OldV3iOQRjGQA2D+MDQiwx6taAPat/oUokkd9U+pS1gT
         QnbAru7u7umBDRg9z+DEv6eYVhN6DvBl7Y+0VkSYM+dw2JsWbgGDvTdivgbJRsn7Ihuj
         79Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861461; x=1762466261;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbxlqnkWJKv72MnwB+3LG1JlDumthqKLFTiHBb/B/wc=;
        b=gaTFt+d0vPQCWMjZPHMwPh0nXgVHG6efGjh3cWisEGH/AKxW2zrz/tqpZZDTrAU0OJ
         KMtgpk1dWHl+giZrWfhmSbegk7pk6Yv371UjBAZYSfNYE7Uju9WFFqaOyiSVXLxoPpo2
         m461w9AvTN16r/lDpiGV3v4B0g8HTdDGeDAQXbhb2aXuxtG+35mdSrc3qBDpkiUoBuei
         nHKpWPmnaVEEKKeIK5GtRRcxjWcd2NkeX5r6dcXXrAq+//OortTbInnakpEUHsdqxOwV
         XRPD82Vo15qviF+ijMN3fkHGzUgkTQBj/rFpkAIMRQf6N0hBkPX9Z8YwbPoLICKi6EMQ
         eqcg==
X-Gm-Message-State: AOJu0Yx5po0a0d1l07gnucxQhspLx5PR3t/UP5TY4qHDNunJlZWB8ddH
	uQxhqWyOmI8JQzeLwUFBCXzCqufX6pbY66YJzTTfjwi1RIJTG+buOxEaUDZilv3fOVojSy7TlLO
	pNeEJUdWVFrvLExA3jv3LK1n95uNgl8Mkf8aHrmH4r9s8vwTQpuJ3Y/NiJXeAca+MdNrcqw==
X-Gm-Gg: ASbGncurleVTd9/US1oZK5T7GhEHLdwntLrQE0CXi/6uDwKNgblNhH9ys5JNtaRyAl1
	iSkUyPwGiowAMj4VIpNGjXHLnCL1D4L9DmzfBMELbeQwKr9Fia0uU7yGh1Jcf5J5Oibu7MM7v+B
	bBqJ2Yke2Nx4RbxgrZrs3wSW3C4Oskkwf07WfJZrMZ9hy1zZleg+45fvdi3ZXOogFrN2xJ2s5Qi
	SshciBS8dZxj9yAxqSgTijSufHwaxUf87bq7z1NXh89txwMhia7vRUQW/Tvq6qbySGmZ5zlvU6b
	I9dPJFZiCYFKDI/vQ19HvCco2E5OtmqjHnI/8Gi4Y7kZOJqGFmQqNjPZW6lWYIneSuwWTla0g3N
	ebEzKEGmzinLKhEliLWv9AkJZoF+X6ehUBVQ=
X-Received: by 2002:a17:903:38c5:b0:269:d978:7ec0 with SMTP id d9443c01a7336-2951a45a15emr18108275ad.28.1761861460571;
        Thu, 30 Oct 2025 14:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZJ3rUOeLoZ5JdbU31KxAXQDa+g3r+fwNG5gM0aI6wgEv2sSZ9CXBSV2RLCpCXzMfrc1egw==
X-Received: by 2002:a17:903:38c5:b0:269:d978:7ec0 with SMTP id d9443c01a7336-2951a45a15emr18107955ad.28.1761861460134;
        Thu, 30 Oct 2025 14:57:40 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm201868405ad.6.2025.10.30.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:57:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251028170457.134608-1-nihaal@cse.iitm.ac.in>
References: <20251028170457.134608-1-nihaal@cse.iitm.ac.in>
Subject: Re: [PATCH] wifi: ath12k: fix potential memory leak in
 ath12k_wow_arp_ns_offload()
Message-Id: <176186145939.3489476.17111380584676068402.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 14:57:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4NiBTYWx0ZWRfX6YCG6vG0bYqD
 YyWVlmc8Gs9bfvtG3uTicL55iUolnrXHi9+N+xP+CewlY48o/pdRfuhceA5lj2oq9GYFtrNVEHE
 bZgMcs/eMoVtmJMrwihh5Jd1V9u10yFbluHIqD4ZtMWJY5dSBzaDcp29lJklFWeFj7Q0p8WWDvm
 sIgbH4o1gnK2ReRvtkM+qV+XU5KUQsPV/yOqzgT3ZmXahPttkvK6xtmmOhtxQWfpUoYjY+YJFfA
 O32zWIMjpPWIWup2OQt+GbY5mEMMvtYLySdemf7rzSD/vDZE1AVnKXnRHigNmy5PyUL/PhyMr3i
 pEVRWlNTJCL9LgYqlpbrWPJFWumUd/q7160HPH+q2kvVFG2nsJZVzG+a28WsZTc8+XyQDgcxLDG
 xs9I1QgrUQbRWM3NjcO1uuTvlZe/Jg==
X-Proofpoint-GUID: B3N3stOJpmqjHM3keqoVUFpGmmkN41MX
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6903df55 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: B3N3stOJpmqjHM3keqoVUFpGmmkN41MX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300186


On Tue, 28 Oct 2025 22:34:55 +0530, Abdun Nihaal wrote:
> When the call to ath12k_wmi_arp_ns_offload() fails, the temporary memory
> allocation for offload is not freed before returning. Fix that by
> freeing offload in the error path.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()
      commit: be5febd51c478bc8e24ad3480435f2754a403b14

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


