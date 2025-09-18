Return-Path: <linux-wireless+bounces-27500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927DB87688
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CED1CC09FC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5512FC89C;
	Thu, 18 Sep 2025 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdoEWxOe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758972F7ABD
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239250; cv=none; b=F3rARhk93zjkeo0JAQUFHM1wcBKbF0W82NP/gpeXscaufBOjNKex4gqgTzSOFobAikalkqBd9MiRBIz7T+iv+JsGXZzceq6H7859rhKWYb2SlshCUX1fZ/YZqO+fKl93AfsKzotdbN5BQW3fKjuwLJPIvmDn5lH8uLz9UPMlzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239250; c=relaxed/simple;
	bh=Zl5SdpafoIGUs8BYSH4+VgG2ye/0GMp4SRZoJCZVwDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uQsmls0Ve/dYh62mSAhoDcW2TJiScUhQuglFbZWLtGyR4pbk2T5kZ6xTRSP+Cx9YFNBkIVINAn4JYmPTK3wPLFIGMv7/4Hspl3Ai/guBJP3w77HRK4Y1aozNBEuxqhC81KBFhcpNH43nHxvv2Z66KpbebA7YQIqEogYgodqpZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdoEWxOe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IItcGX018235
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nAdnGft0CDmvsgciSrd1Q2OfW5SxaJi36vRRvFm88Ec=; b=cdoEWxOevFYldDZ1
	7shFqLJcVR7S2J+1BMaQp7OlvYeakOfIyJPZOvLm9wGWhgyPpKhpho1Msr033Ysu
	r+3R5rxVcRC2kJmIBIftrpLerlAWuUq8bKl0MsD5cZ2FpepLI7M8+3dsdodM6W67
	GUXb3GiyLb6nx/mTqSbErtC4fUA08H8/dXU7eaMx+lsvvTetoz8Cv21JntI62ogL
	RPlOKJGNpHNhFmT7+8KUavB7b1UhP2N+9xpeJRrMqyA7D2BosuaPv478uZWJx/En
	8J/AucA4AUhZ4xXJficUVjBKTmF2lBoU9RlUP0p1y2i9ZF0tH1lad4OShjcBM9HM
	5x//Tg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwgcch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ced7cfa07so14219195ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239248; x=1758844048;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAdnGft0CDmvsgciSrd1Q2OfW5SxaJi36vRRvFm88Ec=;
        b=r1rqOSz7PlLqsAwQQ9X9ccpJ0PmBDzqGC1cxBNONoiQQMGjJ5JmNyn/5AFQ4DbUZSX
         OWsvqMVRASIv6IY2HsUaUJQYr7/u9Q6ydBYVILh9ZnikD0MxFExHvmjtlevep+vhAP84
         eCrGy2JYvXrW6yCpz2Ayd5EHWVv/DZLsu/vMB5/AbaslzmJbDZdb3ZgbIQO2GbazfzuL
         50leCKcd71KfPCdPmyBTsTEBfkpxwteSrQewExc04VnDEKcmuK5dd/z1TQX1+TY7Z0bM
         fE2ASB2Yv9mv0EfWvd6oTsfQWaEp53sPxT2pMPpLgVuV/a1CnmMUnbNnjMYocvyTqeD8
         I0vA==
X-Gm-Message-State: AOJu0YyweFALvSZKHn3EYWOG9DpWyNYpENLFgjgIegu4zqRGXpPF06r6
	ahmcM386KXTk4560+TjEQOZfG6nWwOa/COhxMX3PvLPl7ts1jTSCpE18LHtoxDgeXNf+7aO8t6E
	pje7LPn9dpqJcQVfliw8eWZz+qY5UEOmOf1U0jUsQ5fhAcnea7W5F/Wc2FHxmJppB7zh6UQ==
X-Gm-Gg: ASbGncuBr7qxvWp0IgtNbOA+b9O6y+bKmESWKGPIuLQ3B9r8lI/LwG/o6ppTuLuiVvk
	lgOu6e6/t8+TxpZ/6x3mNKNKU46F7zoC6mMRE07H7SiUPIrTS+uFzuJ0tdm5RCGLpxzs4Za45zY
	a88l2ivhg/AMj7bpQdASUSk873as/azQmdsIa8bLjSO+2yxmZK/EumGeYR73r+lLD8Lw0mARDnM
	UCRnn53SxAYKhvY79DBdbK19O7+8EL0sgMHFp5rS/ZO+BJVIjojGq+1aAyQihkzsJxy5I4g1Iy5
	sNpwYptERoaRQfWB3lGK1EnwXx+R68tLL/abqr7GBBab4nBSXbyNd3iOBCxqPAeCBIkP0Vz3BPZ
	1
X-Received: by 2002:a17:903:19e7:b0:264:f714:8dce with SMTP id d9443c01a7336-269ba5081d8mr19591805ad.36.1758239247957;
        Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6pdrrG/kT5DYHOezNz5h9+nn4BGxvAI5GesrnV6WPlcXl4zeyxLYLeOFQ2LPNRUv0K8Q2vg==
X-Received: by 2002:a17:903:19e7:b0:264:f714:8dce with SMTP id d9443c01a7336-269ba5081d8mr19591485ad.36.1758239247501;
        Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
In-Reply-To: <20250813214933.897486-1-robh@kernel.org>
References: <20250813214933.897486-1-robh@kernel.org>
Subject: Re: [PATCH v3] wifi: ath: Use of_reserved_mem_region_to_resource()
 for "memory-region"
Message-Id: <175823924668.3217488.3526211732380687793.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cc9a10 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VjuCZWrZiTeoWwOd-AYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2lDe58q8zdZz
 VVbi4x+vZCQ3PxGX05SCYDhrr7wFRLAfR0AmrBhIjIuE8UlNTwThss0RCZh90zOvflIIEC445gG
 Isf89ZgVEm7zhAPcJ4vANe47HwZr+BIf/A2SaAj+rahBDEaiPQzX4cciC3BqZ3W9FAF2mrrKJN5
 eCVj5TnOH+nvk9xUzKjCXyHMwildIYxv1LjLVsrgzzQWDJayu5Tq2vnN+spDxdhv2n0XdCh5UeC
 fH00hZ+L1PCLI0j/qLGeqyEXm7BWg4HCKP5WqHSOwVpgeeIjYWkgeYpXamor29zkB0aIHn5ocax
 hnHTwwuB863/ZdpQtsRcOIhS0bYTQUfMOVHehpasPv3Pi8DcLxNrwMby1pwDXjb4eLUYKKYSILa
 +7SFNPst
X-Proofpoint-GUID: kal_GxvLCssa10vNsl7OQdEqTr9W-tio
X-Proofpoint-ORIG-GUID: kal_GxvLCssa10vNsl7OQdEqTr9W-tio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On Wed, 13 Aug 2025 16:49:32 -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> The error handling is a bit different for ath10k. "memory-region" is
> optional, so failed lookup is not an error. But then an error in
> of_address_to_resource() is treated as an error. However, that
> distinction is not really important. Either the region is available
> and usable or it is not. So now, it is just
> of_reserved_mem_region_to_resource() which is checked for an error.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"
      commit: 900730dc4705dc78f9bf69c4c513ec018bffee37

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


