Return-Path: <linux-wireless+bounces-21692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FDA92D72
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925671B64D1D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3C221F18;
	Thu, 17 Apr 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fpad8Zkx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEFB221DA2
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930666; cv=none; b=C6QBbZDXWJxWT/9vHL7EyImrTF3856jUpyp62615/75C9Q04NS7Tr8ji7VEs3F7orjiEPuFyv5t8f+Xaw4kDAZHIUISjn4qVKW7fGB8ijuHT532ue3ilA1J0afffB9//sLvOmIOWy35HomntqrVU0Iw59L2/2jovNi8fZ6gxlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930666; c=relaxed/simple;
	bh=Va89dEro4Kkmtw7GfOlPLj+32qukwzSrdSj5vzEHd0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hynu92mXQ4biHe6M2IshfElsURQhB5dx9qhuhcLQT8Un/AH1SE5Q4fcpXtamLEjX8avzPKeS21tdpvjneP8nh0Wz63gcfucgBArkdvI5wlk3Oy8teU2pO9c8FAWAMiaqsfTpYFo3EWbr/kgLSZhXfe0tW5O/g/1AHoXqZH+WWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fpad8Zkx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClh1t014600
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KQ0AapFO2yhPVMDOZaxgS8v5NOii/sUa9QwZcbvEKKk=; b=fpad8Zkxw42D9J01
	Lp5PLjxxqf5lULuggiPbI0MfNVrmp0jEGN+0uxTh+/NkWruxd7+jHFzLnskQMcn7
	m+sQbV+yPVT8XkmYYQlHWjMnm4RUShnOqeJIPxOKNgHMDl5TuvSnMk+VJ4QZCNZT
	YGAtWhexjyt7PxjtxduWikStvu1jZzeDvhOXCtSDI+i8EMd+Pn9BJkY1bFzvtQ8S
	6kKfkF1OKr6Ziegne6qJP0dc/9MI+sNIngUyZXn7b4I2uEixBwBHONWmJ6ZhAP6i
	tPxrLsTnoSwzOUFHTZREzCRarse8F5mco/dQEW3kZgsCPQ8JrEB8vP+D6K4vP2lZ
	fypbzg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1g9mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7394792f83cso993261b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930663; x=1745535463;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ0AapFO2yhPVMDOZaxgS8v5NOii/sUa9QwZcbvEKKk=;
        b=Y/7Xm1T/opnmMDqOwttGRKCSNOd6bOAa7my2mLLRFInsuZPWjv/LAw1O0Edx8e7ox4
         W+gS4z96WhmffzZLk/zzWkUb/hk3y6aKLi6B+naJ6hUpcxn6B3D2hrrcl4qzEcomzmPU
         bEE0YZsHJmyLYlwB94HcrBV03rCCy7oWtjMJpoaAvYO9Ot8NsZRr/uGIlh3ayXO5R14s
         2iALiUC7xIHWmQQps3kKYrCBZCcAWLqjc+G+IPgRO5sSkhTQhF2Hxnr8LRkONYD+i8ZL
         2tMsbZFnzPUMuwt44jfDLhunCWqvK1C4f7pRLCPIbtDP4dbmCwBYdQMtdvtimcHXGl7T
         7I0w==
X-Forwarded-Encrypted: i=1; AJvYcCXkShnTbPTa35irkBaYvxCHwDIESSAxYbIOUuITjEWVIXHUf7gd4o2raOsaK4W9tJsyiVw6BK3FkrSZi2/wLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxviGsW7Ump3zuGhzMHdtGykcJjf1tgPJovxPB48U/A91TmeeuF
	TKCBDrMT11AHdTu08oFJMa9AFjnH1+Xuxa4Gm4M8ygQS0sTL8Vi2/iG7eSJOuYc4A+054nIHWV0
	pj+PLPmI0POsWbEMP5yOknX3Mun4UX0PNf+pRnbE/V+LrYpgDTfRZf5X6jx7dbXHtsA==
X-Gm-Gg: ASbGncsxCFOnrBD0aSgsU3TUd82rH8JVAfsbOJZwoqFe+5Tz5Yo216GxZwBpGih7Grf
	tCtLxWwBVSRCvCkna9Vaegb1AQN5Tbxv2YlzVR+v/9EIqzLO040x3iygOAs8NIMNRYc/WKDZu8p
	bpQ+WQxEBVUpBXoqYPCDpfK8+BAwXC2juYhJ4jbr4b1OFgKsjj9vb047Yh33YL7AzCzSxbfOqX5
	IKGe073/wO1NvN84KHu3Yw4FwwfAlalMmjaHBZBoD8+LzNz79PZws3sQYFvkDO6HIHt7JmJG7N4
	u9FKLd4Y7RB/1DVgdvzyl/pCZhQgpD806feFVWVmhl2NEk2d
X-Received: by 2002:a05:6a00:1495:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-73dc15d3539mr806993b3a.20.1744930662691;
        Thu, 17 Apr 2025 15:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnBlUcOaye28+dYXVT5e8hcezLBg2+PLcejjCu36v0S/nGdgKehCY5UEe/2PNm1Uh5qKd8eA==
X-Received: by 2002:a05:6a00:1495:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-73dc15d3539mr806963b3a.20.1744930662149;
        Thu, 17 Apr 2025 15:57:42 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:41 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, wcn36xx@lists.infradead.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>
In-Reply-To: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
References: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
Subject: Re: [PATCH ath-next 0/4] wifi: ath: Don't use %pK through printk
Message-Id: <174493066126.1347382.345644321134226340.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=68018768 cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=0rtzQTkjgJck7GMvs3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 5LO7uHKD59USe1dJimsu0hJVK0Q3FvAS
X-Proofpoint-ORIG-GUID: 5LO7uHKD59USe1dJimsu0hJVK0Q3FvAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=593 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Thu, 17 Apr 2025 15:19:06 +0200, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> [...]

Applied, thanks!

[1/4] wifi: ath10k: Don't use %pK through printk
      commit: 8add2b8d72722b60c749b559db2a2aef6c9def68
[2/4] wifi: ath11k: Don't use %pK through printk
      commit: 27c57c84922ef1dc72a2ea3a5427cdbaadc9be44
[3/4] wifi: ath12k: Don't use %pK through printk
      commit: 7e7f948c7d14ab5a6cfb26146a0d4734781903e3
[4/4] wifi: wcn36xx: Don't use %pK through printk
      commit: 75f90ba47b2cda7de7a7bc1d099172516f6f96fa

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


