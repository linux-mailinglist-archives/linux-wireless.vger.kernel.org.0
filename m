Return-Path: <linux-wireless+bounces-27988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF02BE10BE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DB919C2961
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C702319617;
	Wed, 15 Oct 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJ8myXQ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083C31813F
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571632; cv=none; b=TiGCQmccqtuddKNWjqI8whP0eITYtC/R1kpTpEXj5I22JtXCVPaLc9hBjjaBfrgfDygBRz1affaz7O7/kM0Wpgm6l3rbTe4mZrYuSu3JZk8ycHL7hGtT3T8O3tbGuW1M0Dsj1ydBfZbwOx2Q/bU6lGaFgQ7Zc13dB4FLRFDJ2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571632; c=relaxed/simple;
	bh=1NxVKzBr4rBI+5jPFXOsrBJlspL7AagB9FtJTqatUTc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gjp9UuyhJDotNvKxuUu7erdWjF+oNR6yiOVTWA78pBcFcbJ/51fgJGSXRzqo3cNe90+7x7EpaEC1CAYZSegL1eYQ7+JQ4zvkYhq6kypGN6aeMpTDC3nw/oEJn8c6eMHdO2/AVXhr/klwScM1j3UqfqYmruH+8ctdbzQq888qvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJ8myXQ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJkjK4016853
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bt/ThjvpEY1Ds7Ra1mVzUh5C7dXWUsidS+33VW6u8/Q=; b=oJ8myXQ/EXDF/HEO
	qcJosEWRIB7THof4wEpKpXpvcv71jWTQB41NyQ6n5nerbTheA5P2ILvuXYlRrc9x
	f+Gbe1jaAJU1JhI8PhrwCdIv7i3HBFGVllnWtLuBp2MYUtSnd/v4Piof1dsXQ7nR
	P6NmVDGqqsjydqRaPoFM1TUfZvICb3T7sZfdgt03jkw3neXomMP5O8Sdednstg+B
	p1phtivHa1N1ymjsulYeD4fc4sFyyFpo5KyEX3IVbqsAP6xvyhzIndSGYX6B46Ca
	VhM4TIvXjt/5vn6zAmr+t1KA+inIQ6kaXMrPUeyK31apMN9bqyX7N/hgi8bTwMAD
	T6aGpQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrtb7gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 23:40:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27c62320f16so1449345ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Oct 2025 16:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571628; x=1761176428;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt/ThjvpEY1Ds7Ra1mVzUh5C7dXWUsidS+33VW6u8/Q=;
        b=Qg4kgNv10G9AWHHzB6sGsGKUpTsJcz2WfbYh+HqD3gt2g9azCjfdgHx9qG6TdsXZi9
         GJXU3MonnN20uXnjZ0S3HZ1rKOvvG5G3ZMIefpK9sDuWKLZ+o+cC4nMXoiB3yVPr+0Rg
         DAR3a+7oLzYUAEN9k1UAQ9nKSIAk63C+qlT6xFJTlJ6YQRU3AiWHrTvJwbMFN/rAsJ9S
         O1ELl9fn1n/NgoT8vzsaduPBOu/hJ955w60np3v/aDe8OJeJ9pkcSciwkQ3eeMnEWy8g
         mCaXzLfgRQ7Zxn41keb8xNJVScZt5H37FNRMWR5a9dKGxrVJ02sBGjKipsv7qNckSp7m
         IeeQ==
X-Gm-Message-State: AOJu0Yzed2P7nI+7wmtW8RJEAznAHk8WNnsfj0MXdcnSQYg94p6D00st
	MJOu2w7X1h3J9r4m8eUWkIeoVslT2paS9NzCQ0P9mQ3i3yLgtA0hMCuclV6r5/BPHHgAEMku2F0
	96EF8hS7xG1g4vnDvlF4OQUTE7TUVK7zRfGel3nBo+8pLD4DOEzz1H9LRszy0/TdUMwZXyw==
X-Gm-Gg: ASbGnctQFsntCeW1rH0gH/xmLVNp8GHauEZQn02y6g1v0KX6YsaXdX60/R/WdVAVll/
	gBkCFswMl7XKcbituYas7FIPZk1C8W2d7tZgbgR3kwNXRdE++x0PpMkCIn/9LecHw99Hb+PXruq
	kjZdHCs9cm5K9Zb5p+u/NqdeBVK2y77q+NIF4iymxMM7w01Ce2NYWYBHhM63NOcLoo0rbSDZG8h
	TwpnzRXxJwT0MwNd0SzQLsc/5B1oJS3C2uLWj167FPkV9DW4y6Y8SAXxwJp3Xw1FB6v4JA2wdKu
	2aUbNp5ZzGsxcScg9Z4Kfr5bAM6rL72kvdKDdbWzguIGqcQICAbOQIrUInRaPMn8cmdGFq4GRgz
	irENmS1zcYYEsV1m8j4SRGgoWfAhDiiusf4U=
X-Received: by 2002:a17:903:3885:b0:246:cfc4:9a30 with SMTP id d9443c01a7336-290272c037dmr370560555ad.35.1760571628390;
        Wed, 15 Oct 2025 16:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7HhVlq2H00+aNIpTwkJCZaZoBD0dGl1VCEZ2khUGd+30f4enLpyoFJJJSvMggkoiC967TAg==
X-Received: by 2002:a17:903:3885:b0:246:cfc4:9a30 with SMTP id d9443c01a7336-290272c037dmr370560315ad.35.1760571627901;
        Wed, 15 Oct 2025 16:40:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c255sm8055635ad.70.2025.10.15.16.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:40:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
In-Reply-To: <20251014-ath11k-reset-window-cache-v1-1-b85271b111dd@oss.qualcomm.com>
References: <20251014-ath11k-reset-window-cache-v1-1-b85271b111dd@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: restore register window after
 global reset
Message-Id: <176057162726.260563.6168810416311335291.b4-ty@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:40:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: BGGyskxLeWradbXjmxfamq10m-4ueiNJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX1Vvm9zVOSh8p
 K9bsDxiEQSHoAISxsLYFAQOMquB/Gyg0boQKatW0G2iv379AzMT/TVMIwwSxqVVoiupZWgse7Jx
 w+dRu1xdHgfGphi4LF29GOASLDn66JL4axer6aYemcsQFb1LR4kOjKdpt3eqZbFtJep1/tYPYrd
 Z42f9t2rySBa3DgEkkP2Yy0gHpSRIFKcda3O+KDvli2p3ilfqatW+aH5TQhADknG0+CcA/aOjlL
 XmW89d2GBmWFtcWils3/dXvnKIhgRzO5d32Go+GJGgHgYyCKVOtf6J3j32tvcExr5lcWFkdsp2E
 hGJwiTgkX55l4cOJsX3BKqJWSW9Pmsz2iaEiOWwpnUDexOip4wulvqmJiReQLLVx/ji2yXNCTqJ
 E3DAeU/4MmD5FOc9oU/llB1KyMXJyg==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f030ed cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Ui3C-Q-iVV_s1S7Q5lMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: BGGyskxLeWradbXjmxfamq10m-4ueiNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022


On Tue, 14 Oct 2025 10:30:20 +0800, Baochen Qiang wrote:
> Hardware target implements an address space larger than that PCI BAR can
> map. In order to be able to access the whole target address space, the BAR
> space is split into 4 segments, of which the last 3, called windows, can
> be dynamically mapped to the desired area. This is achieved by updating
> window register with appropriate window value. Currently each time when
> accessing a register that beyond ATH11K_PCI_WINDOW_START, host calculates
> the window value and caches it after window update, this way next time
> when accessing a register falling in the same window, host knows that the
> window is already good hence no additional update needed.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: restore register window after global reset
      commit: 596b911644cc19ecba0dbc9c92849fb59390e29a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


